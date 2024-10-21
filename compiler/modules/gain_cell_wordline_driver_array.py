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
from openram.tech import drc, layer
from openram.tech import layer_properties as layer_props
from openram import OPTS


class gain_cell_wordline_driver_array(design):
    """
    Creates a Wordline Driver
    Generates the wordline-driver to drive the bitcell
    """

    def __init__(self, name, rows, cols, port):
        super().__init__(name)
        debug.info(1, "Creating {0}".format(self.name))
        self.add_comment("rows: {0} cols: {1}".format(rows, cols))

        self.rows = rows
        self.cols = cols
        self.port = port
        self.create_netlist()
        if not OPTS.netlist_only:
            self.create_layout()

    def create_netlist(self):
        self.add_modules()
        self.add_pins()
        self.create_drivers()

    def create_layout(self):
        if "li" in layer:
            self.route_layer = "li"
        else:
            self.route_layer = "m1"

        self.place_drivers()
        self.route_layout()
        self.offset_x_coordinates(vector(-2*self.m6_pitch, 0))

        # Leave a well gap to separate the bitcell array well from this well
        well_gap = 2 * drc("pwell_to_nwell") + drc("nwell_enclose_active")
        if self.port in self.read_ports:
            self.width = self.rwld_inst[-1].rx() + well_gap
            self.height = self.rwld_inst[-1].uy()
        elif self.port in self.write_ports:
            self.width = self.wwld_inst[-1].rx() + well_gap
            self.height = self.wwld_inst[-1].uy()

        self.add_boundary()
        self.route_supplies()
        self.DRC_LVS()

    def add_pins(self):
        # inputs to wordline_driver.
        for i in range(self.rows):
            self.add_pin("in_{0}".format(i), "INPUT")
        # Outputs from wordline_driver.
        if self.port in self.read_ports:
            for i in range(self.rows):
                self.add_pin("rwl_{0}".format(i), "OUTPUT")
        elif self.port in self.write_ports:
            for i in range(self.rows):
                self.add_pin("wwl_{0}".format(i), "OUTPUT")
        self.add_pin("en", "INPUT")
        self.add_pin("vdd", "POWER")
        self.add_pin("gnd", "GROUND")

    def add_modules(self):
        if self.port in self.read_ports:
            self.rwl_driver = factory.create(module_type="gain_cell_wordline_driver",
                                        cols=self.cols,
                                        port=self.port)
        elif self.port in self.write_ports:
            self.wwl_driver = factory.create(module_type="gain_cell_wordline_driver",
                                        cols=self.cols,
                                        port=self.port)

    def route_supplies(self):
        """
        Add vertical power rails.
        """

        if self.port in self.read_ports:
            if layer_props.wordline_driver.vertical_supply:
                self.route_vertical_pins("vdd", self.rwld_inst)
                self.route_vertical_pins("gnd", self.rwld_inst)
            else:
                self.route_vertical_pins("vdd", self.rwld_inst, xside="rx",)
                self.route_vertical_pins("gnd", self.rwld_inst, xside="lx",)
        elif self.port in self.write_ports:
            if layer_props.wordline_driver.vertical_supply:
                self.route_vertical_pins("vdd", self.wwld_inst)
                self.route_vertical_pins("gnd", self.wwld_inst)
            else:
                self.route_vertical_pins("vdd", self.wwld_inst, xside="rx",)
                self.route_vertical_pins("gnd", self.wwld_inst, xside="lx",)


    def create_drivers(self):
        self.rwld_inst = []
        self.wwld_inst = []
        if self.port in self.read_ports:
            for row in range(self.rows):
                name_and = "rwl_driver_and{}".format(row)

                # add and2
                self.rwld_inst.append(self.add_inst(name=name_and,
                                                    mod=self.rwl_driver))
                self.connect_inst(["in_{0}".format(row),
                                "en",
                                "rwl_{0}".format(row),
                                "vdd", "gnd"])
        elif self.port in self.write_ports:
            for row in range(self.rows):
                name_and = "wwl_driver_and{}".format(row)

                # add and2
                self.wwld_inst.append(self.add_inst(name=name_and,
                                                    mod=self.wwl_driver))
                self.connect_inst(["in_{0}".format(row),
                                "en",
                                "wwl_{0}".format(row),
                                "vdd", "gnd"])

    def place_drivers(self):
        if self.port in self.read_ports:
            for row in range(self.rows):
                if (row % 2):
                    y_offset = self.rwl_driver.height * (row + 1)
                    inst_mirror = "MX"
                else:
                    y_offset = self.rwl_driver.height * row
                    inst_mirror = "R0"

                and2_offset = [self.rwl_driver.width, y_offset]

                # add and2
                self.rwld_inst[row].place(offset=and2_offset,
                                        mirror=inst_mirror)
        elif self.port in self.write_ports:
            for row in range(self.rows):
                if (row % 2):
                    y_offset = self.wwl_driver.height * (row + 1) 
                    inst_mirror = "MX"
                else:
                    y_offset = self.wwl_driver.height * row 
                    inst_mirror = "R0"

                and2_offset = [self.wwl_driver.width, y_offset]

                # add and2
                self.wwld_inst[row].place(offset=and2_offset,
                                        mirror=inst_mirror)

    def route_layout(self):
        """ Route all of the signals """

        # Wordline enable connection
        if self.port in self.read_ports:
            r_en_pin = self.rwld_inst[0].get_pin("B")
            r_en_bottom_pos = vector(r_en_pin.cx(), 0)
            r_en_top_pos = vector(r_en_pin.cx(), self.rwld_inst[-1].uy())
            r_en_pin = self.add_layout_pin_segment_center(text="en",
                                                        layer="m2",
                                                        start=r_en_bottom_pos,
                                                        end=r_en_top_pos)
            for row in range(self.rows):
                r_and_inst = self.rwld_inst[row]

                # Drop a via
                r_b_pin = r_and_inst.get_pin("B")
                self.add_via_stack_center(from_layer=r_b_pin.layer,
                                        to_layer="m2",
                                        offset=r_b_pin.center())

                # connect the decoder input pin to and2 A
                self.copy_layout_pin(r_and_inst, "A", "in_{0}".format(row))

                rwl_offset = r_and_inst.get_pin("Z").rc()
                self.add_layout_pin_segment_center(text="rwl_{0}".format(row),
                                               layer=self.route_layer,
                                               start=rwl_offset,
                                               end=rwl_offset - vector(self.m1_width, 0))
        elif self.port in self.write_ports:
            
            w_en_pin = self.wwld_inst[0].get_pin("B")
            w_en_bottom_pos = vector(w_en_pin.cx(), 0)
            w_en_top_pos = vector(w_en_pin.cx(), self.wwld_inst[-1].uy())
            w_en_pin = self.add_layout_pin_segment_center(text="en",
                                                        layer="m2",
                                                        start=w_en_bottom_pos,
                                                        end=w_en_top_pos)
            for row in range(self.rows): 
                w_and_inst = self.wwld_inst[row]

                # Drop a via
                w_b_pin = w_and_inst.get_pin("B")
                self.add_via_stack_center(from_layer=w_b_pin.layer,
                                        to_layer="m2",
                                        offset=w_b_pin.center())

                # connect the decoder input pin to and2 A
                self.copy_layout_pin(w_and_inst, "A", "in_{0}".format(row))

                # output each WL on the right
                wwl_offset = w_and_inst.get_pin("Z").rc()
                self.add_layout_pin_segment_center(text="wwl_{0}".format(row),
                                            layer=self.route_layer,
                                            start=wwl_offset,
                                            end=wwl_offset - vector(self.m1_width, 0))
