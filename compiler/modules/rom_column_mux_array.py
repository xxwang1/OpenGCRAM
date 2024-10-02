# See LICENSE for licensing information.
#
# Copyright (c) 2016-2024 Regents of the University of California and The Board
# of Regents for the Oklahoma Agricultural and Mechanical College
# (acting for and on behalf of Oklahoma State University)
# All rights reserved.
#
from openram import debug
from openram.base import design
from openram.base import vector
from openram.sram_factory import factory
from openram.tech import layer, preferred_directions, drc
from openram.tech import layer_properties as layer_props
from openram import OPTS


class rom_column_mux_array(design):
    """
    Dynamically generated column mux array.
    Array of column mux to read the bitlines from ROM, based on the RAM column mux
    """

    def __init__(self, name, columns, word_size, tap_spacing=4, input_layer="m1", bitline_layer="m1", sel_layer="m2"):
        super().__init__(name)
        debug.info(1, "Creating {0}".format(self.name))
        self.add_comment("cols: {0} word_size: {1} ".format(columns, word_size))

        self.columns = columns
        self.word_size = word_size
        self.words_per_row = int(self.columns / self.word_size)
        self.input_layer = input_layer
        self.tap_spacing = tap_spacing
        self.sel_layer = sel_layer
        self.supply_layer = "m2"
        self.sel_pitch = getattr(self, self.sel_layer + "_pitch")
        self.bitline_layer = bitline_layer

        if preferred_directions[self.sel_layer] == "V":
            self.via_directions = ("H", "H")
        else:
            self.via_directions = "pref"

        self.create_netlist()
        if not OPTS.netlist_only:
            self.create_layout()

    def create_netlist(self):
        self.add_modules()
        self.add_pins()
        self.create_array()

    def create_layout(self):
        self.setup_layout_constants()
        self.place_array()
        self.add_routing()

        # Find the highest shapes to determine height before adding well
        highest = self.find_highest_coords()
        self.height = highest.y
        self.add_layout_pins()
        if "pwell" in layer:
            self.add_enclosure(self.mux_inst, "pwell")

        self.add_boundary()
        self.DRC_LVS()

    def add_pins(self):
        for i in range(self.columns):
            self.add_pin("bl_{}".format(i))
        for i in range(self.words_per_row):
            self.add_pin("sel_{}".format(i))
        for i in range(self.word_size):
            self.add_pin("bl_out_{}".format(i))
        self.add_pin("gnd")

    def add_modules(self):
        self.mux = factory.create(module_type="rom_column_mux", input_layer=self.input_layer, output_layer=self.bitline_layer)
        self.tap = factory.create(module_type="rom_poly_tap", add_active_tap=True)
        self.cell = factory.create(module_type="rom_base_cell")

    def setup_layout_constants(self):
        self.column_addr_size = int(self.words_per_row / 2)
        self.width = self.columns * self.mux.width
        # one set of metal1 routes for select signals and a pair to interconnect the mux outputs bl/br
        # one extra route pitch is to space from the sense amp
        self.route_height = (self.words_per_row + 3) * self.cell.width
        self.route_layer_width = drc["minwidth_{}".format(self.bitline_layer)]
        self.route_layer_pitch = drc["{0}_to_{0}".format(self.bitline_layer)]

    def create_array(self):
        self.mux_inst = []
        # For every column, add a pass gate
        for col_num in range(self.columns):
            name = "XMUX{0}".format(col_num)
            self.mux_inst.append(self.add_inst(name=name,
                                               mod=self.mux))

            self.connect_inst(["bl_{}".format(col_num),
                               "bl_out_{}".format(int(col_num / self.words_per_row)),
                               "sel_{}".format(col_num % self.words_per_row),
                               "gnd"])

    def place_array(self):
        # Default to single spaced columns
        self.offsets = [n * self.mux.width for n in range(self.columns)]

        # For every column, add a pass gate
        for col_num, xoffset in enumerate(self.offsets[0:self.columns]):
            offset = vector(xoffset, self.route_height)
            self.mux_inst[col_num].place(offset=offset)

    def add_layout_pins(self):
        """ Add the pins after we determine the height. """
        # For every column, add a pass gate
        for col_num in range(self.columns):
            mux_inst = self.mux_inst[col_num]
            bl_pin = mux_inst.get_pin("bl")
            offset = bl_pin.ll()
            self.add_layout_pin(text="bl_{}".format(col_num),
                                layer=bl_pin.layer,
                                offset=offset,
                                height=self.height - offset.y)


    def route_supplies(self):
        self.route_horizontal_pins("gnd", self.insts, layer=self.supply_layer)

    def add_routing(self):
        self.add_horizontal_input_rail()
        self.add_vertical_poly_rail()
        self.route_bitlines()
        self.route_supplies()

    def add_horizontal_input_rail(self):
        """ Create address input rails below the mux transistors  """
        tap_offset = 0
        for j in range(self.words_per_row):
            if j % self.tap_spacing == 0 and j != 0:
                tap_offset += self.tap.pitch_offset
            offset = vector(0, self.route_height + tap_offset + (j - self.words_per_row) * self.cell.width)

            self.add_layout_pin(text="sel_{}".format(j),
                                layer=self.sel_layer,
                                offset=offset,
                                width=self.mux_inst[-1].rx())

    def add_vertical_poly_rail(self):
        """  Connect the poly to the address rails """


        # Offset to the first transistor gate in the pass gate
        for col in range(self.columns):
            # which select bit should this column connect to depends on the position in the word
            sel_index = col % self.words_per_row
            # Add the column x offset to find the right select bit
            gate_offset = self.mux_inst[col].get_pin("sel").bc()
            # use the y offset from the sel pin and the x offset from the gate

            offset = vector(gate_offset.x,
                            self.get_pin("sel_{}".format(sel_index)).cy())

            bl_x_offset = self.mux_inst[col].get_pin("bl_out").cx() + 2 * self.route_layer_width + self.route_layer_pitch + 0.5 * self.poly_contact.width

            bl_offset = offset.scale(0, 1) + vector(bl_x_offset, 0)
            self.add_via_stack_center(from_layer="poly",
                                      to_layer=self.sel_layer,
                                      offset=bl_offset,
                                      directions=self.via_directions)
            self.add_path("poly", [offset, gate_offset, bl_offset])

    def route_bitlines(self):
        """  Connect the output bit-lines to form the appropriate width mux """
        for j in range(self.columns):

            bl_offset_begin = self.mux_inst[j].get_pin("bl_out").bc()

            bl_out_offset_begin = bl_offset_begin - vector(0, (self.words_per_row + 1) * self.cell.width)

            # Add the horizontal wires for the first bit
            if j % self.words_per_row == 0:
                bl_offset_end = self.mux_inst[j + self.words_per_row - 1].get_pin("bl_out").bc()
                bl_out_offset_end = bl_offset_end - vector(0, (self.words_per_row + 1) * self.cell.width)

                self.add_path(self.sel_layer, [bl_out_offset_begin, bl_out_offset_end])

                # Extend the bitline output rails and gnd downward on the first bit of each n-way mux
                self.add_layout_pin_segment_center(text="bl_out_{}".format(int(j / self.words_per_row)),
                                                   layer=self.bitline_layer,
                                                   start=bl_offset_begin,
                                                   end=bl_out_offset_begin)


            else:
                self.add_path(self.bitline_layer, [bl_out_offset_begin, bl_offset_begin])

            # This via is on the right of the wire
            self.add_via_stack_center(from_layer=self.bitline_layer,
                                      to_layer=self.sel_layer,
                                      offset=bl_out_offset_begin,
                                      directions=self.via_directions)

    def graph_exclude_columns(self, column_include_num):
        """
        Excludes all columns muxes unrelated to the target bit being simulated.
        Each mux in mux_inst corresponds to respective column in bitcell array.
        """
        for i in range(len(self.mux_inst)):
            if i != column_include_num:
                self.graph_inst_exclude.add(self.mux_inst[i])
