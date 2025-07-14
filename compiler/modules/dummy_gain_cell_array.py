# See LICENSE for licensing information.
#
# Copyright (c) 2016-2024 Regents of the University of California, Santa Cruz
# All rights reserved.
#
from openram.sram_factory import factory
from openram import OPTS
from .gain_cell_base_array import gain_cell_base_array


class dummy_gain_cell_array(gain_cell_base_array):
    """
    Generate a dummy row/column for the replica array.
    """
    def __init__(self, rows, cols, column_offset=0, mirror=0, location="", name=""):
        super().__init__(rows=rows, cols=cols, column_offset=column_offset, name=name)
        self.mirror = mirror

        self.create_netlist()
        if not OPTS.netlist_only:
            self.create_layout()

    def create_netlist(self):
        """ Create and connect the netlist """
        # This will create a default set of bitline/wordline names
        self.create_all_bitline_names()
        self.create_all_wordline_names()

        self.add_modules()
        self.add_pins()
        self.create_instances()

    def create_layout(self):

        self.place_array("dummy_r{0}_c{1}", self.mirror)

        self.add_layout_pins()

        self.route_supplies()

        self.add_boundary()

        self.DRC_LVS()

    def add_modules(self):
        """ Add the modules used in this design """

        self.dummy_cell = factory.create(module_type=OPTS.dummy_gain_cell)
        self.cell = factory.create(module_type=OPTS.gain_cell)

    def create_instances(self):
        """ Create the module instances used in this design """
        self.cell_inst = {}
        for col in range(self.column_size):
            for row in range(self.row_size):
                name = "bit_r{0}_c{1}".format(row, col)
                self.cell_inst[row, col]=self.add_inst(name=name,
                                                       mod=self.dummy_cell)
                self.connect_inst(self.get_gain_cell_pins(row, col))

    # def add_pins(self):
    #     # bitline pins are not added because they are floating
    #     for bl_name in self.get_bitline_names():
    #         self.add_pin(bl_name, "INOUT")
    #     # bitline pins are not added because they are floating
    #     for wl_name in self.get_wordline_names():
    #         self.add_pin(wl_name, "INPUT")
    #     self.add_pin("vdd", "POWER")
    #     self.add_pin("gnd", "GROUND")
    def add_pins(self):
        # bitline pins are not added because they are floating
        for bl_name in self.get_bitline_names():
            if "r" in bl_name:
                self.add_pin(bl_name, "INOUT")
            else:
                self.add_pin(bl_name, "INPUT")
        # bitline pins are not added because they are floating
        for wl_name in self.get_wordline_names():
            if "r" in bl_name:
                self.add_pin(wl_name, "INOUT")
            else:
                self.add_pin(wl_name, "INPUT")
        self.add_pin("vdd", "POWER")
        self.add_pin("gnd", "GROUND")

    def add_layout_pins(self):
        """ Add the layout pins """

        # Add the bitline metal, but not as pins since they are going to just be floating
        # For some reason, LVS has an issue if we don't add this metal
        bitline_names = self.cell.get_all_bitline_names()
        # for col in range(self.column_size):
        #     for port in self.all_ports:
        #         rbl_pin = self.cell_inst[0, col].get_pin(bitline_names[2 * port])
        #         self.add_layout_pin(text="rbl_{0}_{1}".format(port, col),
        #                             layer=rbl_pin.layer,
        #                             offset=rbl_pin.ll().scale(1, 0),
        #                             width=rbl_pin.width(),
        #                             height=self.height)
        #         wbl_pin = self.cell_inst[0, col].get_pin(bitline_names[2 * port + 1])
        #         self.add_layout_pin(text="wbl_{0}_{1}".format(port, col),
        #                             layer=wbl_pin.layer,
        #                             offset=wbl_pin.ll().scale(1, 0),
        #                             width=wbl_pin.width(),
        #                             height=self.height)
        for col in range(self.column_size):
            # for port in self.all_ports:
            for port in self.read_ports:
                rbl_pin = self.cell_inst[0, col].get_pin(bitline_names[port])
                self.add_layout_pin(text="rbl_{0}_{1}".format(port, col),
                                    layer=rbl_pin.layer,
                                    offset=rbl_pin.ll().scale(1, 0),
                                    width=rbl_pin.width(),
                                    height=self.height)
            for port in self.write_ports:
                wbl_pin = self.cell_inst[0, col].get_pin(bitline_names[port])
                self.add_layout_pin(text="wbl_{0}_{1}".format(port, col),
                                    layer=wbl_pin.layer,
                                    offset=wbl_pin.ll().scale(1, 0),
                                    width=wbl_pin.width(),
                                    height=self.height)
        # wl_names = self.cell.get_all_wl_names()
        # for row in range(self.row_size):
        #     for port in self.all_ports:
        #         rwl_pin = self.cell_inst[row, 0].get_pin(wl_names[2 * port])
        #         self.add_layout_pin(text="rwl_{0}_{1}".format(port, row),
        #                             layer=rwl_pin.layer,
        #                             offset=rwl_pin.ll().scale(0, 1),
        #                             width=self.width,
        #                             height=rwl_pin.height())
        #         wwl_pin = self.cell_inst[row, 0].get_pin(wl_names[2 * port + 1])
        #         self.add_layout_pin(text="wwl_{0}_{1}".format(port, row),
        #                             layer=wwl_pin.layer,
        #                             offset=wwl_pin.ll().scale(0, 1),
        #                             width=self.width,
        #                             height=wwl_pin.height())
        wl_names = self.cell.get_all_wl_names()
        for row in range(self.row_size):
            # for port in self.all_ports:
            for port in self.read_ports:
                rwl_pin = self.cell_inst[row, 0].get_pin(wl_names[port])
                self.add_layout_pin(text="rwl_{0}_{1}".format(port, row),
                                    layer=rwl_pin.layer,
                                    offset=rwl_pin.ll().scale(0, 1),
                                    width=self.width,
                                    height=rwl_pin.height())
            for port in self.write_ports:
                wwl_pin = self.cell_inst[row, 0].get_pin(wl_names[port])
                self.add_layout_pin(text="wwl_{0}_{1}".format(port, row),
                                    layer=wwl_pin.layer,
                                    offset=wwl_pin.ll().scale(0, 1),
                                    width=self.width,
                                    height=wwl_pin.height())

    def route_supplies(self):

        # Copy a vdd/gnd layout pin from every cell
        for row in range(self.row_size):
            for col in range(self.column_size):
                inst = self.cell_inst[row, col]
                for pin_name in ["vdd", "gnd"]:
                    self.copy_layout_pin(inst, pin_name)

    def input_load(self):
        # FIXME: This appears to be old code from previous characterization. Needs to be updated.
        wl_wire = self.gen_wl_wire()
        return wl_wire.return_input_cap()
