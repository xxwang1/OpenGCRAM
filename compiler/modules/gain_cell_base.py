# See LICENSE for licensing information.
#
# Copyright (c) 2016-2024 Regents of the University of California and The Board
# of Regents for the Oklahoma Agricultural and Mechanical College
# (acting for and on behalf of Oklahoma State University)
# All rights reserved.
#
from openram import debug
from openram.base import design
from openram.base import logical_effort
from openram.tech import parameter, drc, layer, spice
from openram import OPTS


class gain_cell_base(design):
    """
    Base gain_cell parameters to be over-riden.
    """
    def __init__(self, name, cell_name=None, prop=None):
        design.__init__(self, name, cell_name, prop)

        # Set the gain_cell specific properties
        if prop:
            self.storage_nets = prop.storage_nets
            self.nets_match = self.do_nets_exist(prop.storage_nets)
            self.mirror = prop.mirror
            self.end_caps = prop.end_caps
    def get_stage_effort(self, load):
        parasitic_delay = 1
        # This accounts for bitline being drained
        # thought the access TX and internal node
        size = 0.5
        # Assumes always a minimum sizes inverter.
        # Could be specified in the tech.py file.
        cin = 3
        # min size NMOS gate load
        read_port_load = 0.5

        return logical_effort('bitline',
                              size,
                              cin,
                              load + read_port_load,
                              parasitic_delay,
                              False)

    def analytical_power(self, corner, load):
        """gain_cell power in nW. Only characterizes leakage."""
        from openram.tech import spice
        leakage = spice["gain_cell_leakage"]
        # FIXME
        dynamic = 0
        total_power = self.return_power(dynamic, leakage)
        return total_power

    def input_load(self):
        """ Return the relative capacitance of the access transistor gates """

        # FIXME: This applies to bitline capacitances as well.
        # FIXME: sizing is not accurate with the handmade cell.
        # Change once cell widths are fixed.
        access_tx_cin = parameter["write_size"] / drc["minwidth_tx"]
        return 2 * access_tx_cin

    def get_wwl_cin(self):
        """Return the relative capacitance of the access transistor gates"""
        # This is a handmade cell so the value must be entered
        # in the tech.py file or estimated.
        # Calculated in the tech file by summing the widths of all
        # the related gates and dividing by the minimum width.
        # FIXME: sizing is not accurate with the handmade cell.
        # Change once cell widths are fixed.
        access_tx_cin = parameter["write_size"] / drc["minwidth_tx"]
        return access_tx_cin
    
    def get_rwl_cin(self):
        """Return the relative capacitance of the access transistor gates"""
        # This is a handmade cell so the value must be entered
        # in the tech.py file or estimated.
        # Calculated in the tech file by summing the widths of all
        # the related gates and dividing by the minimum width.
        # FIXME: sizing is not accurate with the handmade cell.
        # Change once cell widths are fixed.
        access_tx_cin = parameter["write_size"] / drc["minwidth_tx"]
        return access_tx_cin

    def get_storage_net_names(self):
        """
        Returns names of storage nodes in gain_cell in
        [non-inverting, inverting] format.
        """
        # Checks that they do exist
        if self.nets_match:
            return self.storage_nets
        else:
            fmt_str = "Storage nodes={} not found in spice file."
            debug.warning(fmt_str.format(self.storage_nets))
            return None

    def get_storage_net_offset(self):
        """
        Gets the location of the storage net labels to add top level
        labels for pex simulation.
        """
        # If we generated the gain_cell, we already know where Q and Q_bar are
        if OPTS.gain_cell == "gain_cell":
            self.storage_net_offsets = []
            for i in range(len(self.get_storage_net_names())):
                for text in self.gds.getTexts(layer["m1"]):
                    if self.storage_nets[i] == text.textString.rstrip('\x00'):
                        self.storage_net_offsets.append(text.coordinates[0])

            for i in range(len(self.storage_net_offsets)):
                self.storage_net_offsets[i]  = tuple([self.gds.info["units"][0] * x for x in self.storage_net_offsets[i]])

        return(self.storage_net_offsets)

    def get_bitline_offset(self):

        rbl_names = self.get_all_rbl_names()
        wbl_names = self.get_all_wbl_names()

        found_rbl = []
        found_wbl = []

        self.rbl_offsets = []
        self.wbl_offsets = []

        for i in range(len(rbl_names)):
            for text in self.gds.getTexts(layer["m2"]):
                if not rbl_names[i] in found_rbl:
                    if rbl_names[i] == text.textString.rstrip('\x00'):
                        self.rbl_offsets.append(text.coordinates[0])
                        found_rbl.append(rbl_names[i])

                        continue

        for i in range(len(wbl_names)):
            for text in self.gds.getTexts(layer["m2"]):
                if not wbl_names[i] in found_wbl:
                    if wbl_names[i] == text.textString.rstrip('\x00'):
                        self.wbl_offsets.append(text.coordinates[0])
                        found_wbl.append(wbl_names[i])
                        continue

        for i in range(len(self.rbl_offsets)):
            self.rbl_offsets[i]  = tuple([self.gds.info["units"][0] * x for x in self.rbl_offsets[i]])

        for i in range(len(self.wbl_offsets)):
            self.wbl_offsets[i]  = tuple([self.gds.info["units"][0] * x for x in self.wbl_offsets[i]])

        return(self.rbl_offsets, self.wbl_offsets, found_rbl, found_wbl)

    def get_normalized_storage_nets_offset(self):
        """
        Convert storage net offset to be relative to the bottom left corner
        of the gain_cell. This is useful for making sense of offsets outside
        of the gain_cell.
        """
        if OPTS.gain_cell == "gain_cell":
            normalized_storage_net_offset = self.get_storage_net_offset()

        else:
            net_offset = self.get_storage_net_offset()
            SN_x = net_offset[0][0] - self.leftmost_xpos
            SN_y = net_offset[0][1] - self.botmost_ypos
            # Q_bar_x = net_offset[1][0] - self.leftmost_xpos
            # Q_bar_y = net_offset[1][1] - self.botmost_ypos

            normalized_storage_net_offset = [[SN_x, SN_y]]

        return normalized_storage_net_offset

    def get_normalized_bitline_offset(self):
        return self.get_bitline_offset()

    def build_graph(self, graph, inst_name, port_nets):
        """
        By default, gain_cells won't be part of the graph.

        """
        return

    def get_all_wl_names(self):
        """ Creates a list of all wordline pin names """
        row_pins = ["rwl", "wwl"]
        return row_pins

    def get_all_bitline_names(self):
        """ Creates a list of all bitline pin names (both bl and br) """
        return ["rbl", "wbl"]

    def get_all_rbl_names(self):
        """ Creates a list of all bl pins names """
        return ["rbl"]

    def get_all_wbl_names(self):
        """ Creates a list of all br pins names """
        return ["wbl"]

    def get_rbl_name(self, port=0):
        """Get bl name"""
        debug.check(port == 0, "One port for gain_cell only.")
        return "rbl"
    def get_all_rwl_names(self):
        """ Creates a list of all bl pins names """
        return ["rwl"]
    
    def get_all_wwl_names(self):
        """ Creates a list of all bl pins names """
        return ["wwl"]
        
    def get_wbl_name(self, port=0):
        """Get bl name"""
        debug.check(port == 0, "One port for gain_cell only.")
        return "wbl"

    def get_all_wwl_names(self):
        """ Creates a list of all br pins names """
        return ["wwl"]

    def get_wwl_name(self, port=0):
        """Get bl name"""
        debug.check(port == 0, "One port for gain_cell only.")
        return "wwl"

    def get_rwl_name(self, port=0):
        """Get wl name"""
        debug.check(port == 0, "One port for gain_cell only.")
        return "rwl"

    def get_on_resistance(self):
        """On resistance of pinv, defined by single nmos"""
        is_nchannel = True
        stack = 2 # for access and inv tx
        is_cell = False
        return self.tr_r_on(drc["minwidth_tx"], is_nchannel, stack, is_cell)

    def get_input_capacitance(self):
        """Input cap of input, passes width of gates to gate cap function"""
        # Input cap of both access TX connected to the wordline
        return self.gate_c(2*parameter["write_size"])

    def get_intrinsic_capacitance(self):
        """Get the drain capacitances of the TXs in the gate."""
        stack = 1
        mult = 1
        # FIXME: Need to define TX sizes of gain_cell storage node. Using
        # min_width as a temp value

        # Add the inverter drain Cap and the bitline TX drain Cap
        nmos_drain_c =  self.drain_c_(drc["minwidth_tx"]*mult,
                                      stack,
                                      mult)
        pmos_drain_c =  self.drain_c_(drc["minwidth_tx"]*mult,
                                      stack,
                                      mult)

        rbl_nmos_drain_c =  self.drain_c_(parameter["read_size"],
                                         stack,
                                         mult)

        return nmos_drain_c + pmos_drain_c + rbl_nmos_drain_c

    def module_wire_c(self):
        """Capacitance of bitline"""
        # FIXME: entire bitline cap is calculated here because of the current
        # graph implementation so array dims are all re-calculated here. May
        # be incorrect if dim calculations change
        cells_in_col = OPTS.num_words/OPTS.words_per_row
        return cells_in_col*self.height*spice["wire_c_per_um"]

    def module_wire_r(self):
        """Resistance of bitline"""
        # FIXME: entire bitline r is calculated here because of the current
        # graph implementation so array dims are all re-calculated. May
        # be incorrect if dim calculations change
        cells_in_col = OPTS.num_words/OPTS.words_per_row
        return cells_in_col*self.height*spice["wire_r_per_um"]

    def cacti_rc_delay(self, inputramptime, tf, vs1, vs2, rise, extra_param_dict):
        """ Special RC delay function used by CACTI for bitline delay
        """
        import math
        vdd = extra_param_dict['vdd']
        m = vdd / inputramptime #v_wl = vdd for OpenRAM
        # vdd == V_b_pre in OpenRAM. Bitline swing is assumed 10% of vdd
        tstep = tf * math.log(vdd/(vdd - 0.1*vdd))
        if tstep > 0.5*(vdd-spice["nom_threshold"])/m:
            delay = tstep + (vdd-spice["nom_threshold"])/(2*m)
        else:
            delay = math.sqrt(2*tstep*(vdd-spice["nom_threshold"])/m)

        return delay

    def build_graph(self, graph, inst_name, port_nets):
        """
        Adds edges based on inputs/outputs.
        Overrides base class function.
        """
        debug.error("Must override build_graph function in gain_cell base class.")

    def is_non_inverting(self):
        """Return input to output polarity for module"""

        return False
