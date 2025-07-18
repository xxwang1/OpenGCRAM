# See LICENSE for licensing information.
#
# Copyright (c) 2016-2024 Regents of the University of California and The Board
# of Regents for the Oklahoma Agricultural and Mechanical College
# (acting for and on behalf of Oklahoma State University)
# All rights reserved.
#
from openram import debug
from openram.base import logical_effort
from openram.tech import cell_properties as props
from openram.tech import parameter, drc
from .gain_cell_base import gain_cell_base


class replica_gain_cell_2port(gain_cell_base):
    """
    A single bit cell (6T, 8T, etc.)
    This module implements the single memory cell used in the design. It
    is a hand-made cell, so the layout and netlist should be available in
    the technology library. """

    def __init__(self, name):
        super().__init__(name, prop=props.replica_gain_cell_2port)
        debug.info(2, "Create replica gain_cell object")

    def get_stage_effort(self, load):
        parasitic_delay = 1
        size = 0.5 # This accounts for bitline being drained thought the access TX and internal node
        cin = 3 # Assumes always a minimum sizes inverter. Could be specified in the tech.py file.
        read_port_load = 0.5 # min size NMOS gate load
        return logical_effort('bitline', size, cin, load + read_port_load, parasitic_delay, False)

    def input_load(self):
        """Return the relative capacitance of the access transistor gates"""

        # FIXME: This applies to bitline capacitances as well.
        access_tx_cin = parameter["write_size"] / drc["minwidth_tx"]
        return access_tx_cin

    def analytical_power(self, corner, load):
        """gain_cell power in nW. Only characterizes leakage."""
        from openram.tech import spice
        leakage = spice["gain_cell_leakage"]
        dynamic = 0 # FIXME
        total_power = self.return_power(dynamic, leakage)
        return total_power

    def build_graph(self, graph, inst_name, port_nets):
        """Adds edges based on inputs/outputs. Overrides base class function."""
        self.add_graph_edges(graph, port_nets)

    def is_non_inverting(self):
        """Return input to output polarity for module"""

        return False
