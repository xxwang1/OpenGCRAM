# See LICENSE for licensing information.
#
# Copyright (c) 2016-2024 Regents of the University of California, Santa Cruz
# All rights reserved.
#
from openram import debug
from openram.base import vector
from openram.base import contact
from openram.sram_factory import factory
from openram.tech import drc, spice
from openram.tech import cell_properties as props
from openram import OPTS
from .gain_cell_base_array import gain_cell_base_array


class replica_gain_cell_array(gain_cell_base_array):
    """
    Creates a gain_cell array of cols x rows and then adds the replica
    columns and dummy rows. Replica columns are on the left and
    right, respectively and connected to the given gain_cell ports.
    Dummy rows are on the top and bottom passing through the Rrbl WLs.
    Requires a regular gain_cell array and (if using replica topology)
    replica gain_cell and dummy gain_cell (rbl/wbl disconnected).
    """
    def __init__(self, rows, cols, rrbl=None, left_rrbl=None, right_rrbl=None, name=""):
        super().__init__(name=name, rows=rows, cols=cols, column_offset=0)
        debug.info(1, "Creating {0} {1} x {2} rrbls: {3} left_rrbl: {4} right_rrbl: {5}".format(self.name,
                                                                                             rows,
                                                                                             cols,
                                                                                             rrbl,
                                                                                             left_rrbl,
                                                                                             right_rrbl))
        self.add_comment("rows: {0} cols: {1}".format(rows, cols))
        self.add_comment("rrbl: {0} left_rrbl: {1} right_rrbl: {2}".format(rrbl, left_rrbl, right_rrbl))

        self.column_size = cols
        self.row_size = rows
        # This is how many Rrbls are in all the arrays
        # Even if the Rrbl is not placed in this array, the module still needs
        # to place dummy rows with rrbl wordlines so that they will have the same
        # load as the regular wordlines (and so the arrays are the same size)
        if rrbl is not None:
            self.rrbl = rrbl
        else:
            self.rrbl = [0] * len(self.all_ports)
        # This specifies how many Rrbls to put on the left by port number.
        # For example, left_rrbl = [0, 1] means there will be two
        # Rrbls on the left, one for port 0 and another for port 1.
        if left_rrbl is not None:
            self.left_rrbl = left_rrbl
        else:
            self.left_rrbl = []
        # Similar to left_rrbl but on the right side of the array
        if right_rrbl is not None:
            self.right_rrbl = right_rrbl
        else:
            self.right_rrbl = []
        self.rrbls = self.left_rrbl + self.right_rrbl

        debug.check(sum(self.rrbl) >= len(self.left_rrbl) + len(self.right_rrbl),
                    "Cannot have more left + right Rrbls than total Rrbls")

        self.create_netlist()
        if not OPTS.netlist_only:
            self.create_layout()

    def create_netlist(self):
        """ Create and connect the netlist """
        self.add_modules()
        self.add_pins()
        self.create_instances()

    def add_modules(self):
        """  Array and dummy/replica columns """
        # gain_cell array
        self.gain_cell_array = factory.create(module_type="gain_cell_array",
                                            column_offset=1 + len(self.left_rrbl),
                                            cols=self.column_size,
                                            rows=self.row_size)

        # Replica bitlines
        self.replica_columns = {}

        for port in self.all_ports:
            # We will always have self.rrbl[0] dummy rows below the array
            # for the replica wordlines.
            if port in self.left_rrbl:
                # These go top down starting from the bottom of the gain_cell array.
                replica_bit = self.rrbl[0] - port - 1
                column_offset = len(self.left_rrbl)
            elif port in self.right_rrbl:
                # These go bottom up starting from the top of the gain_cell array.
                replica_bit = self.rrbl[0] + self.row_size + port - 1
                column_offset = len(self.left_rrbl) + self.column_size + 1
            else:
                continue

            self.replica_columns[port] = factory.create(module_type="replica_column",
                                                        rows=self.row_size,
                                                        rrbl=self.rrbl,
                                                        column_offset=column_offset,
                                                        replica_bit=replica_bit)

        # Dummy row (for replica wordlines)
        self.dummy_row = factory.create(module_type="dummy_array",
                                            cols=self.column_size,
                                            rows=1,
                                            # cap column + left replica column
                                            # FIXME: these col offsets should really start at 0 because
                                            # this is the left edge of the array... but changing them all is work
                                            column_offset=1 + len(self.left_rrbl),
                                            mirror=0)

    def add_pins(self):

        # Arrays are always:
        # bitlines (column first then port order)
        # word lines (row first then port order)
        # dummy wordlines
        # replica wordlines
        # regular wordlines (bottom to top)
        # # dummy bitlines
        # replica bitlines (port order)
        # regular bitlines (left to right port order)
        #
        # vdd
        # gnd

        self.add_bitline_pins()
        self.add_wordline_pins()
        self.add_pin("vdd", "POWER")
        self.add_pin("gnd", "GROUND")

    def add_bitline_pins(self):
        # The bit represents which port the Rrbl is for
        for bit in self.rrbls:
            for port in self.all_ports:
                self.rrbl_bitline_names[bit].append("rrbl_rbl_{0}_{1}".format(port, bit))
            for port in self.all_ports:
                self.rrbl_bitline_names[bit].append("rrbl_wbl_{0}_{1}".format(port, bit))
        # Make a flat list too
        self.all_rrbl_bitline_names = [x for sl in self.rrbl_bitline_names for x in sl]

        self.bitline_names = self.gain_cell_array.bitline_names
        # Make a flat list too
        self.all_bitline_names = [x for sl in zip(*self.bitline_names) for x in sl]

        self.bitline_pin_list = []
        for port in self.left_rrbl:
            self.bitline_pin_list.extend(self.rrbl_bitline_names[port])
        self.bitline_pin_list.extend(self.all_bitline_names)
        for port in self.right_rrbl:
            self.bitline_pin_list.extend(self.rrbl_bitline_names[port])

        self.add_pin_list(self.bitline_pin_list, "INOUT")

    def add_wordline_pins(self):
        # Unused wordlines are connected to ground at the next level of hierarchy
        self.unused_wordline_names = []

        for port in self.all_ports:
            if self.rrbl[port] == 0:
                continue  # TODO: there's probarbly a better way to do this check
            for bit in self.all_ports:
                self.rrbl_wordline_names[port].append("rrbl_wl_{0}_{1}".format(port, bit))
                if bit != port:
                    self.unused_wordline_names.append("rrbl_wl_{0}_{1}".format(port, bit))

        self.all_rrbl_wordline_names = [x for sl in self.rrbl_wordline_names for x in sl]

        self.wordline_names = self.gain_cell_array.wordline_names
        self.all_wordline_names = self.gain_cell_array.all_wordline_names

        # All wordlines including Rrbl
        self.wordline_pin_list = []
        for bit in range(self.rrbl[0]):
            self.wordline_pin_list.extend(self.rrbl_wordline_names[bit])
        self.wordline_pin_list.extend(self.all_wordline_names)
        for bit in range(self.rrbl[1]):
            self.wordline_pin_list.extend(self.rrbl_wordline_names[self.rrbl[0] + bit])

        self.used_wordline_names = []
        for port in range(self.rrbl[0]):
            self.used_wordline_names.append(self.rrbl_wordline_names[port][port])
        self.used_wordline_names.extend(self.all_wordline_names)
        for port in range(self.rrbl[0], self.rrbl[0] + self.rrbl[1]):
            self.used_wordline_names.append(self.rrbl_wordline_names[port][port])

        self.add_pin_list(self.wordline_pin_list, "INPUT")

    def create_instances(self):
        """ Create the module instances used in this design """
        self.supplies = ["vdd", "gnd"]

        # Main array
        self.gain_cell_array_inst=self.add_inst(name="gain_cell_array",
                                              mod=self.gain_cell_array)
        self.connect_inst(self.all_bitline_names + self.all_wordline_names + self.supplies)

        # Replica columns
        self.replica_col_insts = []
        for port in self.all_ports:
            if port in self.rrbls:
                self.replica_col_insts.append(self.add_inst(name="replica_col_{}".format(port),
                                                            mod=self.replica_columns[port]))
                self.connect_inst(self.rrbl_bitline_names[port] + self.wordline_pin_list + self.supplies)
            else:
                self.replica_col_insts.append(None)

        # Dummy rows above/below the gain_cell array (connected with the replica cell wl)
        self.dummy_row_replica_insts = []
        # Note, this is the number of left and right even if we aren't adding the columns to this gain_cell array!
        for port in self.all_ports: # TODO: tie to self.rrbl or whatever
            if self.rrbl[port] != 0:
                self.dummy_row_replica_insts.append(self.add_inst(name="dummy_row_{}".format(port),
                                                                    mod=self.dummy_row))
                self.connect_inst(self.all_bitline_names + self.rrbl_wordline_names[port] + self.supplies)
            else:
                self.dummy_row_replica_insts.append(None)

    def create_layout(self):

        # This creates space for the unused wordline connections as well as the
        # row-based or column based power and ground lines.
        self.vertical_pitch = 1.1 * getattr(self, "{}_pitch".format(self.supply_stack[0]))
        self.horizontal_pitch = 1.1 * getattr(self, "{}_pitch".format(self.supply_stack[2]))

        # This is a gain_cell x gain_cell offset to scale
        self.gain_cell_offset = vector(self.cell.width, self.cell.height)
        self.col_end_offset = vector(self.cell.width, self.cell.height)
        self.row_end_offset = vector(self.cell.width, self.cell.height)

        # Everything is computed with the main array
        self.gain_cell_array_inst.place(offset=0)

        self.add_replica_columns()

        # Array was at (0, 0) but move everything so it is at the lower left
        # We move DOWN the number of left Rrbl even if we didn't add the column to this gain_cell array
        # Note that this doesn't include the row/col cap
        array_offset = self.gain_cell_offset.scale(-len(self.left_rrbl), -self.rrbl[0])
        self.translate_all(array_offset)

        self.add_layout_pins()

        self.route_supplies()

        self.height = (sum(self.rrbl) + self.row_size) * self.cell.height
        self.width = (len(self.rrbls) + self.column_size) * self.cell.width

        self.add_boundary()

        self.DRC_LVS()

    def get_main_array_top(self):
        """ Return the top of the main gain_cell array. """
        return self.gain_cell_array_inst.uy()

    def get_main_array_bottom(self):
        """ Return the bottom of the main gain_cell array. """
        return self.gain_cell_array_inst.by()

    def get_main_array_left(self):
        """ Return the left of the main gain_cell array. """
        return self.gain_cell_array_inst.lx()

    def get_main_array_right(self):
        """ Return the right of the main gain_cell array. """
        return self.gain_cell_array_inst.rx()

    def get_column_offsets(self):
        """
        Return an array of the x offsets of all the regular bits
        """
        offsets = [x + self.gain_cell_array_inst.lx() for x in self.gain_cell_array.get_column_offsets()]
        return offsets

    def add_replica_columns(self):
        """ Add replica columns on left and right of array """

        # Grow from left to right, toward the array
        for bit, port in enumerate(self.left_rrbl):
            offset = self.gain_cell_offset.scale(-len(self.left_rrbl) + bit, -self.rrbl[0])
            self.replica_col_insts[bit].place(offset)
        # Grow to the right of the gain_cell array, array outward
        for bit, port in enumerate(self.right_rrbl):
            offset = self.gain_cell_array_inst.lr() + self.gain_cell_offset.scale(bit, -self.rrbl[0])
            self.replica_col_insts[self.rrbl[0] + bit].place(offset)

        # Replica dummy rows
        # Add the dummy rows even if we aren't adding the replica column to this gain_cell array
        # These grow up, toward the array
        for bit in range(self.rrbl[0]):
            dummy_offset = self.gain_cell_offset.scale(0, -self.rrbl[0] + bit + (-self.rrbl[0] + bit) % 2)
            self.dummy_row_replica_insts[bit].place(offset=dummy_offset,
                                                    mirror="MX" if (-self.rrbl[0] + bit) % 2 else "R0")
        # These grow up, away from the array
        for bit in range(self.rrbl[1]):
            dummy_offset = self.gain_cell_offset.scale(0, bit + bit % 2) + self.gain_cell_array_inst.ul()
            self.dummy_row_replica_insts[self.rrbl[0] + bit].place(offset=dummy_offset,
                                                                  mirror="MX" if (self.row_size + bit) % 2 else "R0")

    def add_layout_pins(self):
        """ Add the layout pins """

        # All wordlines
        # Main array wl
        for pin_name in self.all_wordline_names:
            pin_list = self.gain_cell_array_inst.get_pins(pin_name)
            for pin in pin_list:
                self.add_layout_pin(text=pin_name,
                                    layer=pin.layer,
                                    offset=pin.ll().scale(0, 1),
                                    width=self.width,
                                    height=pin.height())

        # Replica wordlines (go by the row instead of replica column because we may have to add a pin
        # even though the column is in another local gain_cell array)
        for (names, inst) in zip(self.rrbl_wordline_names, self.dummy_row_replica_insts):
            for (wl_name, pin_name) in zip(names, self.dummy_row.get_wordline_names()):
                pin = inst.get_pin(pin_name)
                self.add_layout_pin(text=wl_name,
                                    layer=pin.layer,
                                    offset=pin.ll().scale(0, 1),
                                    width=self.width,
                                    height=pin.height())

        # Main array rbl/wbl
        for pin_name in self.all_bitline_names:
            pin_list = self.gain_cell_array_inst.get_pins(pin_name)
            for pin in pin_list:
                self.add_layout_pin(text=pin_name,
                                    layer=pin.layer,
                                    offset=pin.ll().scale(1, 0),
                                    width=pin.width(),
                                    height=self.height)

        # Replica bitlines
        if len(self.rrbls) > 0:
            for (names, inst) in zip(self.rrbl_bitline_names, self.replica_col_insts):
                pin_names = self.replica_columns[self.rrbls[0]].all_bitline_names
                for (rbl_name, pin_name) in zip(names, pin_names):
                    pin = inst.get_pin(pin_name)
                    self.add_layout_pin(text=rbl_name,
                                        layer=pin.layer,
                                        offset=pin.ll().scale(1, 0),
                                        width=pin.width(),
                                        height=self.height)

    def route_supplies(self):
        """ just copy supply pins from all instances """
        for inst in self.insts:
            for pin_name in ["vdd", "gnd"]:
                self.copy_layout_pin(inst, pin_name)

    def analytical_power(self, corner, load):
        """Power of gain_cell array and bitline in nW."""
        # Dynamic Power from Bitline
        rbl_wire = self.gen_rbl_wire()
        cell_load = 2 * rbl_wire.return_input_cap()
        rbl_swing = OPTS.rrbl_delay_percentage
        freq = spice["default_event_frequency"]
        bitline_dynamic = self.calc_dynamic_power(corner, cell_load, freq, swing=rbl_swing)

        # Calculate the gain_cell power which currently only includes leakage
        cell_power = self.cell.analytical_power(corner, load)

        # Leakage power grows with entire array and bitlines.
        total_power = self.return_power(cell_power.dynamic + bitline_dynamic * self.column_size,
                                        cell_power.leakage * self.column_size * self.row_size)
        return total_power


    def gen_rbl_wire(self):
        if OPTS.netlist_only:
            height = 0
        else:
            height = self.height
        rbl_pos = 0
        rbl_wire = self.generate_rc_net(int(self.row_size - rbl_pos), height, drc("minwidth_m1"))
        rbl_wire.wire_c =spice["min_tx_drain_c"] + rbl_wire.wire_c # 1 access tx d/s per cell
        return rbl_wire

    def graph_exclude_bits(self, targ_row=None, targ_col=None):
        """
        Excludes bits in column from being added to graph except target
        """
        self.gain_cell_array.graph_exclude_bits(targ_row, targ_col)

    def graph_exclude_replica_col_bits(self):
        """
        Exclude all replica/dummy cells in the replica columns except the replica bit.
        """

        for port in self.left_rrbl + self.right_rrbl:
            self.replica_columns[port].exclude_all_but_replica()

    def get_cell_name(self, inst_name, row, col):
        """
        Gets the spice name of the target gain_cell.
        """
        return self.gain_cell_array.get_cell_name(inst_name + "{}x".format(OPTS.hier_seperator) + self.gain_cell_array_inst.name, row, col)

    def clear_exclude_bits(self):
        """
        Clears the bit exclusions
        """
        self.gain_cell_array.init_graph_params()
