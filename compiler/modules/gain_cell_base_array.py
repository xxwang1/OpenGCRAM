# See LICENSE for licensing information.
#
# Copyright (c) 2016-2024 Regents of the University of California and The Board
# of Regents for the Oklahoma Agricultural and Mechanical College
# (acting for and on behalf of Oklahoma State University)
# All rights reserved.
#
from openram import debug
from openram.base import design
from openram.sram_factory import factory
from openram import OPTS


class gain_cell_base_array(design):
    """
    Abstract base class for gain_cell-arrays -- gain_cell, dummy, replica
    """
    def __init__(self, name, rows, cols, column_offset):
        super().__init__(name)
        debug.info(1, "Creating {0} {1} x {2}".format(self.name, rows, cols))

        self.column_size = cols
        self.row_size = rows
        self.column_offset = column_offset

        # gain_cell for port names only
        self.cell = factory.create(module_type=OPTS.gain_cell)

        self.wordline_names = [[] for port in self.all_ports]
        self.all_wordline_names = []
        self.bitline_names = [[] for port in self.all_ports]
        self.all_bitline_names = []
        self.rbl_bitline_names = [[] for port in self.all_ports]
        self.all_rbl_bitline_names = []
        self.rbl_wordline_names = [[] for port in self.all_ports]
        self.all_rbl_wordline_names = []

    def create_all_bitline_names(self):
        for col in range(self.column_size):
            for port in self.read_ports:
                self.bitline_names[port].extend(["rbl_{0}_{1}".format(port, col)])
            for port in self.write_ports:
                self.bitline_names[port].extend(["wbl_{0}_{1}".format(port, col)])
        # Make a flat list too
        self.all_bitline_names = [x for sl in zip(*self.bitline_names) for x in sl]

    def create_all_wordline_names(self, row_size=None, start_row=0):
        if row_size == None:
            row_size = self.row_size
        print("create_all_wordline_names row_size, start_row = ", row_size, start_row)
        for port in self.write_ports:
            for row in range(start_row, row_size):
                # for port in self.all_ports:
                self.wordline_names[0].append("wwl_{0}_{1}".format(port, row))
        for port in self.read_ports:
            for row in range(start_row, row_size):
                # for port in self.all_ports:
                self.wordline_names[1].append("rwl_{0}_{1}".format(port, row))
            
        print("create_all_wordline_names self.wordline_names = ", self.wordline_names)
        self.all_wordline_names = [x for sl in zip(*self.wordline_names) for x in sl]

    def add_pins(self):
        for bl_name in self.get_bitline_names():
            if "r" in bl_name:
                self.add_pin(bl_name, "INOUT")
            else:
                self.add_pin(bl_name, "INPUT")
        for wl_name in self.get_wordline_names():
            if "r" in bl_name:
                self.add_pin(wl_name, "INOUT")
            else:
                self.add_pin(wl_name, "INPUT")
        if OPTS.gc_type == "Si":
            self.add_pin("vdd", "POWER")
            self.add_pin("gnd", "GROUND")

    def get_gain_cell_pins(self, row, col):
        """
        Creates a list of connections in the gain_cell,
        indexed by column and row, for instance use in gain_cell_array
        """
        gain_cell_pins = []
        # for port in self.all_ports:
        #     gain_cell_pins.extend([x for x in self.get_bitline_names(port) if x.endswith("_{0}".format(col))])
        # gain_cell_pins.extend([x for x in self.all_wordline_names if x.endswith("_{0}".format(row))])

        for port in self.read_ports:
            gain_cell_pins.extend([x for x in self.get_bitline_names(port) if x.endswith("_{0}".format(col))])
        for port in self.write_ports:
            gain_cell_pins.extend([x for x in self.get_bitline_names(port) if x.endswith("_{0}".format(col))])
        for port in self.read_ports:
            gain_cell_pins.extend([x for x in self.get_wordline_names(port) if x.endswith("_{0}".format(row))])
        for port in self.write_ports:
            gain_cell_pins.extend([x for x in self.get_wordline_names(port) if x.endswith("_{0}".format(row))])
        if OPTS.gc_type == "Si":
            gain_cell_pins.append("vdd")
            gain_cell_pins.append("gnd")

        return gain_cell_pins

    def get_rbl_wordline_names(self, port=None):
        """
        Return the WL for the given RBL port.
        """
        if port == None:
            return self.all_rbl_wordline_names
        else:
            return self.rbl_wordline_names[port]

    def get_rbl_bitline_names(self, port=None):
        """ Return all the BL for the given RBL port """
        if port == None:
            return self.all_rbl_bitline_names
        else:
            return self.rbl_bitline_names[port]

    def get_bitline_names(self, port=None):
        """ Return the regular bitlines for the given port or all"""
        if port == None:
            return self.all_bitline_names
        else:
            return self.bitline_names[port]

    def get_all_bitline_names(self, port=None):
        """ Return ALL the bitline names (including rbl) """
        temp = []
        temp.extend(self.get_rbl_bitline_names(0))
        if port == None:
            temp.extend(self.all_bitline_names)
        else:
            temp.extend(self.bitline_names[port])
        if len(self.all_ports) > 1:
            temp.extend(self.get_rbl_bitline_names(1))
        return temp

    def get_wordline_names(self, port=None):
        """ Return the regular wordline names """
        print("port = ", port)
        if port == None:
            print("port = None")
            return self.all_wordline_names
        else:
            print("port != None")
            return self.wordline_names[port]

    def get_all_wordline_names(self, port=None):
        """ Return all the wordline names """
        temp = []
        temp.extend(self.get_rbl_wordline_names(0))
        if port == None:
            temp.extend(self.all_wordline_names)
        else:
            temp.extend(self.wordline_names[port])
        if len(self.all_ports) > 1:
            temp.extend(self.get_rbl_wordline_names(1))
        return temp

    def add_bitline_pins(self):
        bitline_names = self.cell.get_all_bitline_names()
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
    def add_wl_pins(self):
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
        if OPTS.gc_type == "Si":
            for inst in self.cell_inst.values():
                for pin_name in ["vdd", "gnd"]:
                    self.copy_layout_pin(inst, pin_name)

    def add_layout_pins(self):
        """ Add the layout pins """
        self.add_bitline_pins()
        self.add_wl_pins()

    def _adjust_x_offset(self, xoffset, col, col_offset):
        tempx = xoffset
        dir_y = False
        # If we mirror the current cell on the y axis adjust the x position
        if self.cell.mirror.y and (col + col_offset) % 2:
            tempx = xoffset + self.cell.width
            dir_y = True
        if OPTS.gc_type == "OS":
            dir_y = False
        return (tempx, dir_y)

    def _adjust_y_offset(self, yoffset, row, row_offset):
        tempy = yoffset
        dir_x = False
        # If we mirror the current cell on the x axis adjust the y position
        if self.cell.mirror.x and (row + row_offset) % 2:
            tempy = yoffset + self.cell.height
            dir_x = True
        if OPTS.gc_type == "OS":
            dir_x = True
        return (tempy, dir_x)

    def place_array(self, name_template, row_offset=0):
        # We increase it by a well enclosure so the precharges don't overlap our wells
        self.height = self.row_size * self.cell.height
        self.width = self.column_size * self.cell.width

        xoffset = 0.0
        for col in range(self.column_size):
            yoffset = 0.0
            tempx, dir_y = self._adjust_x_offset(xoffset, col, self.column_offset)

            for row in range(self.row_size):
                tempy, dir_x = self._adjust_y_offset(yoffset, row, row_offset)

                if dir_x and dir_y:
                    dir_key = "XY"
                elif dir_x:
                    dir_key = "MX"
                elif dir_y:
                    dir_key = "MY"
                else:
                    dir_key = ""

                self.cell_inst[row, col].place(offset=[tempx, tempy],
                                               mirror=dir_key)
                yoffset += self.cell.height
                print("Placing row, col = ", row, col)
                print("Placing inst = ", self.cell_inst[row, col])
                print("Placing cell height = ", self.cell.height)
                print("Placing offset x y = ", tempx, tempy)
                print("Placing mirror = ", dir_key)
            xoffset += self.cell.width

    def get_column_offsets(self):
        """
        Return an array of the x offsets of all the regular bits
        """
        offsets = [self.cell_inst[0, col].lx() for col in range(self.column_size)]
        return offsets
