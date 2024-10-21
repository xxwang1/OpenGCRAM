# See LICENSE for licensing information.
#
# Copyright (c) 2016-2024 Regents of the University of California, Santa Cruz
# All rights reserved.
#
from math import log, ceil
from openram import debug
from openram.base import design
from openram.base import vector
from openram.sram_factory import factory
from openram.tech import layer, drc
from openram.tech import layer_properties as layer_props
from openram import OPTS


class gain_cell_port_address(design):
    """
    Create the address port (row decoder and wordline driver)..
    """

    def __init__(self, cols, rows, port, has_rbl, name=""):

        self.num_cols = cols
        self.num_rows = rows
        self.port = port
        self.has_rbl = has_rbl
        self.addr_size = ceil(log(self.num_rows, 2))

        if name == "":
            name = "port_address_{0}_{1}".format(cols, rows)
        super().__init__(name)
        debug.info(2, "create data port of cols {0} rows {1}".format(cols, rows))

        self.create_netlist()
        if not OPTS.netlist_only:
            debug.check(len(self.all_ports) <= 2, "Bank layout cannot handle more than two ports.")
            self.create_layout()
            self.add_boundary()

    def create_netlist(self):
        self.add_pins()
        self.add_modules()
        self.create_row_decoder()
        self.create_wordline_driver()
        if self.has_rbl:
            self.create_rbl_driver()

    def create_layout(self):
        if "li" in layer:
            self.route_layer = "li"
        else:
            self.route_layer = "m1"
        self.place_instances()
        self.route_layout()
        self.DRC_LVS()

    def add_pins(self):
        """ Adding pins for port address module"""

        for bit in range(self.addr_size):
            self.add_pin("addr_{0}".format(bit), "INPUT")

        if self.port in self.read_ports: self.add_pin("rwl_en", "INPUT")
        elif self.port in self.write_ports: self.add_pin("wwl_en", "INPUT")

        for bit in range(self.num_rows):
            if self.port in self.read_ports: self.add_pin("rwl_{0}".format(bit), "OUTPUT")
            elif self.port in self.write_ports: self.add_pin("wwl_{0}".format(bit), "OUTPUT")

        if self.has_rbl:
            if self.port in self.read_ports: self.add_pin("rbl_rwl", "OUTPUT")
            elif self.port in self.write_ports: self.add_pin("rbl_wwl", "OUTPUT")

        self.add_pin("vdd", "POWER")
        self.add_pin("gnd", "GROUND")

    def route_layout(self):
        """ Create routing amoung the modules """
        self.route_pins()
        self.route_internal()
        self.route_supplies()

    def route_supplies(self):
        """ Propagate all vdd/gnd pins up to this level for all modules """
        if self.has_rbl:
            if layer_props.wordline_driver.vertical_supply:
                self.copy_layout_pin(self.rbl_driver_inst, "vdd")
            else:
                rbl_pos = self.rbl_driver_inst.get_pin("vdd").rc()
                self.add_power_pin("vdd", rbl_pos, minarea=True)
                self.add_path("m4", [rbl_pos, self.wordline_driver_array_inst.get_pins("vdd")[0].rc()])

        self.copy_layout_pin(self.wordline_driver_array_inst, "vdd")
        self.copy_layout_pin(self.wordline_driver_array_inst, "gnd")

        self.copy_layout_pin(self.row_decoder_inst, "vdd")
        self.copy_layout_pin(self.row_decoder_inst, "gnd")

        # Also connect the B input of the RBL and_dec to vdd
        if self.has_rbl:
            if OPTS.local_array_size == 0:
                rbl_b_pin = self.rbl_driver_inst.get_pin("B")
                rbl_loc = rbl_b_pin.center() - vector(3 * self.m1_pitch, 0)
                self.add_path(rbl_b_pin.layer, [rbl_b_pin.center(), rbl_loc])
                self.add_power_pin("vdd", rbl_loc, start_layer=rbl_b_pin.layer,minarea=True)

    def route_pins(self):
        for row in range(self.addr_size):
            decoder_name = "addr_{}".format(row)
            self.copy_layout_pin(self.row_decoder_inst, decoder_name)

        for row in range(self.num_rows):
            if self.port in self.read_ports: driver_name = "rwl_{}".format(row)
            elif self.port in self.write_ports: driver_name = "wwl_{}".format(row)
            self.copy_layout_pin(self.wordline_driver_array_inst, driver_name)

        if self.has_rbl:
            if self.port in self.read_ports: self.copy_layout_pin(self.rbl_driver_inst, "Z", "rbl_rwl")
            elif self.port in self.write_ports: self.copy_layout_pin(self.rbl_driver_inst, "Z", "rbl_wwl")

    def route_internal(self):
        for row in range(self.num_rows):
            # The pre/post is to access the pin from "outside" the cell to avoid DRCs
            decoder_out_pin = self.row_decoder_inst.get_pin("decode_{}".format(row))
            decoder_out_pos = decoder_out_pin.rc()
            driver_in_pin = self.wordline_driver_array_inst.get_pin("in_{}".format(row))
            driver_in_pos = driver_in_pin.lc()
            self.add_zjog(self.route_layer, decoder_out_pos, driver_in_pos, var_offset=0.3)

            self.add_via_stack_center(from_layer=decoder_out_pin.layer,
                                      to_layer=self.route_layer,
                                      offset=decoder_out_pos)

            self.add_via_stack_center(from_layer=driver_in_pin.layer,
                                      to_layer=self.route_layer,
                                      offset=driver_in_pos)

        # Route the RBL from the enable input
        en_pin = self.wordline_driver_array_inst.get_pin("en")
        if self.port == 0:
            en_pos = en_pin.bc()
        else:
            en_pos = en_pin.uc()

        if self.has_rbl:
            rbl_in_pin = self.rbl_driver_inst.get_pin("A")
            rbl_in_pos = rbl_in_pin.center()
            wl_en_offset = rbl_in_pos

            self.add_via_stack_center(from_layer=rbl_in_pin.layer,
                                      to_layer=en_pin.layer,
                                      offset=rbl_in_pos)
            self.add_zjog(layer=en_pin.layer,
                          start=rbl_in_pos,
                          end=en_pos,
                          first_direction="V")
        else:
            wl_en_offset = en_pos

        if self.port in self.read_ports: self.add_layout_pin_rect_center(text="rwl_en",
                                        layer=en_pin.layer,
                                        offset=wl_en_offset)
        elif self.port in self.write_ports: self.add_layout_pin_rect_center(text="wwl_en",
                                        layer=en_pin.layer,
                                        offset=wl_en_offset)

    def add_modules(self):

        self.row_decoder = factory.create(module_type="decoder",
                                          num_outputs=self.num_rows)

        self.wordline_driver_array = factory.create(module_type="gain_cell_wordline_driver_array",
                                                    rows=self.num_rows,
                                                    cols=self.num_cols,
                                                    port=self.port)

        local_array_size = OPTS.local_array_size
        if local_array_size > 0:
            driver_size = max(int(self.num_cols / local_array_size), 1)
        else:
            # Defautl to FO4
            driver_size = max(int(self.num_cols / 4), 1)

        # The polarity must be switched if we have a hierarchical wordline
        # to compensate for the local array inverters
        b = factory.create(module_type=OPTS.gain_cell)

        if self.has_rbl:
            if local_array_size > 0:
                # The local wordline driver will change the polarity
                self.rbl_driver = factory.create(module_type="inv_dec",
                                                 size=driver_size,
                                                 height=b.height)
            else:
                # There is no local wordline driver
                self.rbl_driver = factory.create(module_type="and2_dec",
                                                 size=driver_size,
                                                 height=b.height)

    def create_row_decoder(self):
        """  Create the hierarchical row decoder  """

        self.row_decoder_inst = self.add_inst(name="row_decoder",
                                              mod=self.row_decoder)

        temp = []
        for bit in range(self.addr_size):
            temp.append("addr_{0}".format(bit))
        for row in range(self.num_rows):
            temp.append("dec_out_{0}".format(row))
        temp.extend(["vdd", "gnd"])
        self.connect_inst(temp)

    def create_rbl_driver(self):
        """ Create the RBL Wordline Driver """
        if self.port in self.read_ports: 
            self.rbl_driver_inst = self.add_inst(name="rbl_driver",
                                                mod=self.rbl_driver)

            temp = []
            temp.append("rwl_en")
            if OPTS.local_array_size == 0:
                temp.append("vdd")
            temp.append("rbl_rwl")
            temp.append("vdd")
            temp.append("gnd")
            self.connect_inst(temp)
        elif self.port in self.write_ports:
            self.rbl_driver_inst = self.add_inst(name="rbl_driver",
                                                mod=self.rbl_driver)

            temp = []
            temp.append("wwl_en")
            if OPTS.local_array_size == 0:
                temp.append("vdd")
            temp.append("rbl_wwl")
            temp.append("vdd")
            temp.append("gnd")
            self.connect_inst(temp)

    def create_wordline_driver(self):
        """ Create the Wordline Driver """

        self.wordline_driver_array_inst = self.add_inst(name="gain_cell_wordline_driver",
                                                        mod=self.wordline_driver_array)

        temp = []
        for row in range(self.num_rows):
            temp.append("dec_out_{0}".format(row))
        if self.port in self.read_ports: 
            for row in range(self.num_rows):
                temp.append("rwl_{0}".format(row))
            temp.append("rwl_en")
        elif self.port in self.write_ports:
            for row in range(self.num_rows):
                temp.append("wwl_{0}".format(row))
            temp.append("wwl_en")
        temp.append("vdd")
        temp.append("gnd")
        self.connect_inst(temp)

    def place_instances(self):
        """
        Compute the offsets and place the instances.
        """

        row_decoder_offset = vector(0, 0)
        self.row_decoder_inst.place(row_decoder_offset)

        wordline_driver_array_offset = vector(self.row_decoder_inst.rx(), 0)
        self.wordline_driver_array_inst.place(wordline_driver_array_offset)

        if self.has_rbl:
            # This m6_pitch corresponds to the offset space for jog routing in the
            # wordline_driver_array
            rbl_driver_offset = wordline_driver_array_offset + vector(2 * self.m6_pitch, 0)

            if self.port == 0:
                self.rbl_driver_inst.place(rbl_driver_offset, "MX")
            else:
                rbl_driver_offset += vector(0,
                                            self.wordline_driver_array.height)
                self.rbl_driver_inst.place(rbl_driver_offset)

        # Pass this up
        self.predecoder_height = self.row_decoder.predecoder_height

        self.height = self.row_decoder.height
        self.width = self.wordline_driver_array_inst.rx()
