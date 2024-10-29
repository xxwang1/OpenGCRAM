# See LICENSE for licensing information.
#
# Copyright (c) 2016-2023 Regents of the University of California and The Board
# of Regents for the Oklahoma Agricultural and Mechanical College
# (acting for and on behalf of Oklahoma State University)
# All rights reserved.
#
import os
from openram import drc as d
#from drc.design_rules import design_rules
#from drc.module_type import module_type
#from drc.custom_cell_properties import cell_properties
#from drc.custom_layer_properties import layer_properties

"""
File containing the process technology parameters for FreePDK 45nm.
"""

###################################################
# Custom modules
###################################################

# This uses the default classes to instantiate module from
# '$OPENRAM_HOME/compiler/modules'.
# Using tech_modules['cellname'] you can override each class by providing a custom
# implementation in '$OPENRAM_TECHDIR/modules/'
# For example: tech_modules['contact'] = 'contact_freepdk45'
tech_modules = d.module_type()


###################################################
# Custom cell properties
###################################################
cell_properties = d.cell_properties()
cell_properties.pgate.add_implants = False
###################################################
# Custom cell properties
###################################################
layer_properties = d.layer_properties()

###################################################
# GDS file info
###################################################

GDS = {}
# gds units
# From http://www.cnf.cornell.edu/cnf_spie9.html: "The first
#is the size of a database unit in user units. The second is the size
#of a database unit in meters.  For example, if your library was
#created with the default units (user unit = 1 m and 1000 database
#units per user unit), then the first number would be 0.001 and the
#second number would be 10-9. Typically, the first number is less than
#1, since you use more than 1 database unit per user unit. To
#calculate the size of a user unit in meters, divide the second number
#by the first."
GDS["unit"] = (0.001,1e-9)
# default label zoom
GDS["zoom"] = 0.05

###################################################
# Interconnect stacks
###################################################

poly_stack = ("poly", "contact", "m1")
active_stack = ("active", "contact", "m1")
m1_stack = ("m1", "via1", "m2")
m2_stack = ("m2", "via2", "m3")
m3_stack = ("m3", "via3", "m4")
m4_stack = ("m4", "via4", "m5")
m5_stack = ("m5", "via5", "m6")

layer_indices = {"poly": 0,
                 "active": 0,
                 "m1": 1,
                 "m2": 2,
                 "m3": 3,
                 "m4": 4,
                 "m5": 5,
                 "m6": 6}

# The FEOL stacks get us up to m1
feol_stacks = [poly_stack,
               active_stack]

# The BEOL stacks are m1 and up
beol_stacks = [m1_stack,
               m2_stack,
               m3_stack,
               m4_stack,
               m5_stack]

layer_stacks = feol_stacks + beol_stacks

preferred_directions = {"poly": "V",
                        "active": "V",
                        "m1": "H",
                        "m2": "V",
                        "m3": "H",
                        "m4": "V",
                        "m5": "H",
                        "m6": "V"}
###################################################
# Power grid
###################################################
# Use M3/M4
power_grid = m5_stack

###################################################
# GDS Layer Map
###################################################

# Create the GDS layer map using internal names
layer = {}
layer["active"]  = (6, 0)
layer["pwell"]   = (2, 0)
layer["nwell"]   = (3, 0)
layer["nimplant"]= (26, 0)
layer["pimplant"]= (25, 0)
layer["vtg"]     = (-1, 0)
layer["vth"]     = (-1, 0)
layer["poly"]    = (17, 0)
layer["contact"] = (30, 0)
layer["m1"]  = (31, 0)
layer["via1"]    = (51, 0)
layer["m2"]  = (32, 0)
layer["via2"]    = (52, 0)
layer["m3"]  = (33, 0)
layer["via3"]    = (53, 0)
layer["m4"]  = (34, 0)
layer["via4"]    = (54, 0)
layer["m5"]  = (35, 0)
layer["via5"]    = (55, 40)
layer["m6"]  = (36, 40)
layer["text"]    = (127, 0)
layer["boundary"]= (108, 0)
layer["m1p"] = (131, 0)
layer["m2p"] = (132, 0)
layer["m3p"] = (133, 0)
layer["m4p"] = (134, 0)
layer["m5p"] = (135, 0)
layer["m6p"] = (136, 0)

use_purpose = {}

# Layer names for external PDKs
layer_names = {}
layer_names["active"]  = "OD"
layer_names["pwell"]   = "PW"
layer_names["nwell"]   = "NW"
layer_names["nimplant"]= "NP"
layer_names["pimplant"]= "PP"
layer_names["vtg"]     = "vtg"
layer_names["vth"]     = "vth"
layer_names["poly"]    = "poly"
layer_names["contact"] = "CO"
layer_names["m1"]      = "M1"
layer_names["via1"]    = "VIA1"
layer_names["m2"]      = "M2"
layer_names["via2"]    = "VIA2"
layer_names["m3"]      = "M3"
layer_names["via3"]    = "VIA3"
layer_names["m4"]      = "M4"
layer_names["via4"]    = "VIA4"
layer_names["m5"]      = "M5"
layer_names["via5"]    = "VIA5"
layer_names["m6"]      = "M6"
layer_names["via6"]    = "VIA6"
layer_names["m7"]      = "M7"
layer_names["via7"]    = "VIA7"
layer_names["m8"]      = "M8"
layer_names["via8"]    = "VIA8"
layer_names["m9"]      = "M9"
layer_names["via9"]    = "VIA9"
layer_names["m10"]     = "M10"
layer_names["text"]    = "text"
layer_names["boundary"]= "prBoundary"
layer_names["m1p"]     = "M1"
layer_names["m2p"]     = "M2"
layer_names["m3p"]     = "M3"
layer_names["m4p"]     = "M4"
layer_names["m5p"]     = "M5"
layer_names["m6p"]     = "M6"

###################################################
# DRC/LVS Rules Setup
###################################################

#technology parameter
parameter={}
parameter["min_tx_size"] = 0.12
parameter["beta"] = 3

parameter["6T_inv_nmos_size"] = 0.205
parameter["6T_inv_pmos_size"] = 0.12
parameter["6T_access_size"] = 0.135
parameter["write_size"] = 0.12
parameter["read_size"] = 0.12
drclvs_home=os.environ.get("DRCLVS_HOME")

drc = d.design_rules("tsmcN40")

#grid size
drc["grid"] = 0.005

#DRC/LVS test set_up
# drc["drc_rules"]="/cad/tsmc/PDK_N40_2022/1p6m_4x1z/Calibre/drc/calibre.drc"
drc["drc_rules"]="/home/xxwang1/OpenRAM/technology/tsmcN40/tech/calibre.drc"
drc["lvs_rules"]="/home/xxwang1/OpenRAM/technology/tsmcN40/tech/calibre.lvs"
drc["xrc_rules"]="/home/xxwang1/OpenRAM/technology/tsmcN40/tech/calibre.rcx"
drc["layer_map"]=os.environ.get("OPENRAM_TECH") + "/tsmcN40/tf/virtuoso_45nm_1P6M_4X1Z_12c.map"

# minwidth_tx with contact (no dog bone transistors)
drc["minwidth_tx"] = 0.12
drc["minwidth_m1p"] = 0.07
drc["minwidth_m2p"] = 0.07
drc["minlength_channel"] = 0.05

# WELL.2 Minimum spacing of nwell/pwell at different potential
drc["pwell_to_nwell"] = 0.08
# drc["implant_to_implant"] = 0.01
drc["implant_to_active"] = 0.08
drc["implant_to_pwell"] = 0.02
drc["implant_to_nwell"] = 0.02
# WELL.3 Minimum spacing of nwell/pwell at the same potential
# WELL.4 Minimum width of nwell/pwell
drc.add_layer("nwell",
              width=0.34,
              spacing=0.34)
drc.add_layer("pwell",
              width=0.34,
              spacing=0.34)

# POLY.1 Minimum width of poly
# POLY.2 Minimum spacing of poly AND active
drc.add_layer("poly",
              width=0.05,
              spacing=0.12,
              area=0.022)

# POLY.3 Minimum poly extension beyond active
drc["poly_extend_active"]=0.07
# Not a rule
drc["poly_to_contact"]=0.04
# POLY.4 Minimum enclosure of active around gate
drc["active_enclose_gate"]=0.09
# POLY.5 Minimum spacing of field poly to active
drc["poly_to_active"]=0.05
# POLY.6 Minimum Minimum spacing of field poly
drc["poly_to_field_poly"]=0.075
# Not a rule
drc["minarea_poly"]=0.0

# ACTIVE.1 Minimum width of active
# ACTIVE.2 Minimum spacing of active
drc.add_layer("active",
              width=0.06,
              spacing=0.1,
              area=0.035)
# ACTIVE.3 Minimum enclosure/spacing of nwell/pwell to active
drc.add_enclosure("nwell",
                  layer="active",
                  enclosure=0.08)
drc.add_enclosure("pwell",
                  layer="active",
                  enclosure=0.08)
drc.add_enclosure("nwell",
                  layer="implant",
                  enclosure=0.08)
drc.add_enclosure("pwell",
                  layer="implant",
                  enclosure=0.08)

# IMPLANT.1 Minimum spacing of nimplant/ pimplant to channel
drc["implant_to_channel"]=0.23
drc["pimplant_to_channel"]=0.23

# Not a rule
drc.add_enclosure("implant",
                  layer="active",
                  enclosure=0.08,
                  extension=0.08)
drc.add_enclosure("implant",
                  layer="poly",
                  enclosure=0.11)
drc.add_enclosure("pimplant",
                  layer="active",
                  enclosure=0.08,
                  extension=0.08)
drc.add_enclosure("pimplant",
                  layer="poly",
                  enclosure=0.11)
# Not a rule
drc.add_enclosure("implant",
                  layer="contact",
                  enclosure=0)
drc.add_enclosure("pimplant",
                  layer="contact",
                  enclosure=0)
# IMPLANT.2 Minimum spacing of nimplant/ pimplant to contact
drc["implant_to_contact"]=0.04
drc["pimplant_to_contact"]=0.04
# IMPLANT.3 Minimum width/ spacing of nimplant/ pimplant
# IMPLANT.4 Minimum width/ spacing of nimplant/ pimplant
drc.add_layer("implant",
              width=0.18,
              spacing=0.18,
              area=0.11)
drc.add_enclosure("implant",
                  layer="active",
                  enclosure=0.08,
                  extension=0.08)
drc.add_enclosure("implant",
                  layer="nwell",
                  enclosure=0.02,
                  extension=0.02)
drc.add_enclosure("implant",
                  layer="pwell",
                  enclosure=0.02,
                  extension=0.02)
drc.add_layer("pimplant",
              width=0.18,
              spacing=0.18,
              area=0.11)
drc.add_enclosure("pimplant",
                  layer="active",
                  enclosure=0.08,
                  extension=0.08)
drc.add_enclosure("pimplant",
                  layer="nwell",
                  enclosure=0.02,
                  extension=0.02)
drc.add_enclosure("pimplant",
                  layer="pwell",
                  enclosure=0.02,
                  extension=0.02)
# CONTACT.1 Minimum width of contact
# CONTACT.2 Minimum spacing of contact
drc.add_layer("contact",
              width=0.06,
              spacing=0.08)
# CONTACT.4 Minimum enclosure of active around contact
drc.add_enclosure("active",
                  layer="contact",
                  enclosure=0.03) #double check

# CONTACT.6 Minimum spacing of contact and gate
drc["active_contact_to_gate"]=0.04
# CONTACT.7 Minimum spacing of contact and poly
drc["poly_contact_to_gate"]=0.04

# CONTACT.1 Minimum width of contact
# CONTACT.2 Minimum spacing of contact
drc.add_layer("contact",
              width=0.06,
              spacing=0.08)
# CONTACT.5 Minimum enclosure of poly around contact
drc.add_enclosure("poly",
                  layer="contact",
                  enclosure=0.03) #double check

drc.add_enclosure("poly",
                  layer="active",
                  enclosure=0,
                  extension=0.09)
# CONTACT.6 Minimum spacing of contact and gate
drc["contact_to_gate"]=0.04
# CONTACT.7 Minimum spacing of contact and poly
drc["contact_to_poly"]=0.04

drc["active_to_poly"]=0.04




# METAL1.1 Minimum width of metal1
# METAL1.2 Minimum spacing of metal1
drc.add_layer("m1",
              width=0.07,
              spacing=0.07,
              area=0.0215)

# METAL1.3 Minimum enclosure around contact on two opposite sides
drc.add_enclosure("m1",
                  layer="contact",
                  enclosure=0,
                  extension=0.03)
# METAL1.4 inimum enclosure around via1 on two opposite sides
drc.add_enclosure("m1",
                  layer="via1",
                  enclosure=0,
                  extension=0.03)

# VIA1.1 Minimum width of via1
# VIA1.2 Minimum spacing of via1
drc.add_layer("via1",
              width=0.07,
              spacing=0.07)







# METALINT.1 Minimum width of intermediate metal
# METALINT.2 Minimum spacing of intermediate metal
drc.add_layer("m2",
              width=0.07,
              spacing=0.07,
              area=0.027)

# METALINT.3 Minimum enclosure around via1 on two opposite sides
drc.add_enclosure("m2",
                  layer="via1",
                  enclosure=0,
                  extension=0.03)

# METALINT.4 Minimum enclosure around via[2-3] on two opposite sides
drc.add_enclosure("m2",
                  layer="via2",
                  enclosure=0,
                  extension=0.03)

# VIA2-3.1 Minimum width of Via[2-3]
# VIA2-3.2 Minimum spacing of Via[2-3]
drc.add_layer("via2",
              width=0.07,
              spacing=0.07)






# METALINT.1 Minimum width of intermediate metal
# METALINT.2 Minimum spacing of intermediate metal
# Minimum spacing of m3 wider than 0.09 & longer than 0.3=0.09
# Minimum spacing of m3 wider than 0.27 & longer than 0.9=0.27
# Minimum spacing of m3 wider than 0.5 & longer than 1.8=0.5
# Minimum spacing of m3 wider than 0.9 & longer than 2.7=0.9
# Minimum spacing of m3 wider than 1.5 & longer than 4.0=1.5
drc.add_layer("m3",
              width=0.07,
              spacing=0.07,
              area=0.027)
# METALINT.3 Minimum enclosure around via1 on two opposite sides
drc.add_enclosure("m3",
                  layer="via2",
                  enclosure=0,
                  extension=0.03)

# METALINT.4 Minimum enclosure around via[2-3] on two opposite sides
drc.add_enclosure("m3",
                  layer="via3",
                  enclosure=0,
                  extension=0.03)

# VIA2-3.1 Minimum width of Via[2-3]
# VIA2-3.2 Minimum spacing of Via[2-3]
drc.add_layer("via3",
              width=0.07,
              spacing=0.07)






# METALSMG.1 Minimum width of semi-global metal
# METALSMG.2 Minimum spacing of semi-global metal
# Minimum spacing of m4 wider than 0.27 & longer than 0.9=0.27
# Minimum spacing of m4 wider than 0.5 & longer than 1.8=0.5
# Minimum spacing of m4 wider than 0.9 & longer than 2.7=0.9
# Minimum spacing of m4 wider than 1.5 & longer than 4.0=1.5
drc.add_layer("m4",
              width=0.07,
              spacing=0.07,
              area=0.0289)
# METALSMG.3 Minimum enclosure around via[3-6] on two opposite sides
drc.add_enclosure("m4",
                  layer="via3",
                  enclosure=0,
                  extension=0.03)

# Metal 5-10 are ommitted
# METALINT.4 Minimum enclosure around via[2-3] on two opposite sides
drc.add_enclosure("m4",
                  layer="via4",
                  enclosure=0,
                  extension=0.03)

# VIA2-3.1 Minimum width of Via[2-3]
# VIA2-3.2 Minimum spacing of Via[2-3]
drc.add_layer("via4",
              width=0.07,
              spacing=0.07)






# METALSMG.1 Minimum width of semi-global metal
# METALSMG.2 Minimum spacing of semi-global metal
# Minimum spacing of m4 wider than 0.27 & longer than 0.9=0.27
# Minimum spacing of m4 wider than 0.5 & longer than 1.8=0.5
# Minimum spacing of m4 wider than 0.9 & longer than 2.7=0.9
# Minimum spacing of m4 wider than 1.5 & longer than 4.0=1.5
drc.add_layer("m5",
              width=0.07,
              spacing=0.28,
              area=0.0289)
# METALSMG.3 Minimum enclosure around via[3-6] on two opposite sides
drc.add_enclosure("m5",
                  layer="via4",
                  enclosure=0,
                  extension=0.03)
                  
# METALINT.4 Minimum enclosure around via[2-3] on two opposite sides
drc.add_enclosure("m5",
                  layer="via5",
                  enclosure=0.08,
                  extension=0.08)

# VIA2-3.1 Minimum width of Via[2-3]
# VIA2-3.2 Minimum spacing of Via[2-3]
drc.add_layer("via5",
              width=0.36,
              spacing=0.34)
              
              
              
              
              

# METALSMG.1 Minimum width of semi-global metal
# METALSMG.2 Minimum spacing of semi-global metal
# Minimum spacing of m4 wider than 0.27 & longer than 0.9=0.27
# Minimum spacing of m4 wider than 0.5 & longer than 1.8=0.5
# Minimum spacing of m4 wider than 0.9 & longer than 2.7=0.9
# Minimum spacing of m4 wider than 1.5 & longer than 4.0=1.5
drc.add_layer("m6",
              width=0.4,
              spacing=0.4,
              area=0.565)
# METALSMG.3 Minimum enclosure around via[3-6] on two opposite sides
drc.add_enclosure("m6",
                  layer="via5",
                  enclosure=0.08)
drc.add_layer("via6",
              width=0.4,
              spacing=0.4)



###################################################
# Spice Simulation Parameters
###################################################

#spice info
spice = {}
spice["nmos"] = "nch"
spice["pmos"] = "pch"
spice["osfet"] = "osfet"
# This is a map of corners to model files
SPICE_MODEL_DIR=os.environ.get("SPICE_MODEL_DIR")

spice["fet_libraries"] = { "TT": [[os.environ.get("SPICE_MODEL_DIR") + "/toplevel.l", "top_tt"]]}
spice["osfet_models"] = { "TT": ["/sim/xxwang1/OSFET/osfet/veriloga/veriloga.oa"]}
#spice stimulus related variables
spice["feasible_period"] = 5         # estimated feasible period in ns
spice["supply_voltages"] = [0.9, 1.0, 1.1] # Supply voltage corners in [Volts]
spice["nom_supply_voltage"] = 1.0    # Nominal supply voltage in [Volts]
spice["rise_time"] = 0.005           # rise time in [Nano-seconds]
spice["fall_time"] = 0.005           # fall time in [Nano-seconds]
spice["temperatures"] = [0, 25, 100] # Temperature corners (celcius)
spice["nom_temperature"] = 25        # Nominal temperature (celcius)

# analytical delay parameters
spice["nom_threshold"] = 0.4     # Typical Threshold voltage in Volts
spice["wire_unit_r"] = 0.25      # Unit wire resistance in ohms/square
spice["wire_unit_c"] = 2.3e-15   # Unit wire capacitance F/um^2, calculated from PTM
spice["min_tx_drain_c"] = 0.7    # Minimum transistor drain capacitance in ff
spice["min_tx_gate_c"] = 0.2     # Minimum transistor gate capacitance in ff
spice["dff_setup"] = 9        # DFF setup time in ps
spice["dff_hold"] = 1         # DFF hold time in ps
spice["dff_in_cap"] = 0.2091  # Input capacitance (D) [Femto-farad]
spice["dff_out_cap"] = 2       # Output capacitance (Q) [Femto-farad]

# analytical power parameters, many values are temporary
spice["bitcell_leakage"] = 1     # Leakage power of a single bitcell in nW
spice["gain_cell_leakage"] = 0     # Leakage power of a single bitcell in nW
spice["inv_leakage"] = 1         # Leakage power of inverter in nW
spice["nand2_leakage"] = 1       # Leakage power of 2-input nand in nW
spice["nand3_leakage"] = 1       # Leakage power of 3-input nand in nW
spice["nand4_leakage"] = 1       # Leakage power of 4-input nand in nW
spice["nor2_leakage"] = 1        # Leakage power of 2-input nor in nW
spice["dff_leakage"] = 1      # Leakage power of flop in nW

spice["default_event_frequency"] = 100     # Default event activity of every gate. MHz

# Parameters related to sense amp enable timing and delay chain/RBL sizing
parameter["le_tau"] = 2.25                  # In pico-seconds.
parameter["cap_relative_per_ff"] = 7.5      # Units of Relative Capacitance/ Femto-Farad
parameter["dff_clk_cin"] = 30.6             # relative capacitance
parameter["6tcell_wl_cin"] = 3              # relative capacitance
parameter["min_inv_para_delay"] = 2.4       # Tau delay units
parameter["sa_en_pmos_size"] = 0.72         # micro-meters
parameter["sa_en_nmos_size"] = 0.27         # micro-meters
parameter["sa_inv_pmos_size"] = 0.54        # micro-meters
parameter["sa_inv_nmos_size"] = 0.27        # micro-meters
parameter["bitcell_drain_cap"] = 0.1        # In Femto-Farad, approximation of drain capacitance

# Spice Values uses to calculate analytical delay based on CACTI equations
spice["i_on_n"] = 0.0004463 # A/um
spice["i_on_p"] = 0.0000771   # A/um
spice["tox"] = 0.00114        # microns
spice["eps_ox"] = 0.00245e-14  # F/um, calculated from CACTI 45nm data
spice["cox"] = spice["eps_ox"]/spice["tox"] # F/um^2
spice["c_g_ideal"] = spice["cox"]*drc["minlength_channel"] # F/um
spice["c_overlap"] = 0.2*spice["c_g_ideal"] # F/um
spice["c_fringe"] = 0 # F/um, not defined in this technology
spice["cpolywire"] = 0 # F/um, replicated from CACTI which is hardcoded to 0
spice["c_junc"] = 5e-16 #F/um^2
spice["c_junc_sw"] = 5e-16 #F/um
spice["wire_c_per_um"] = spice["wire_unit_c"]*drc["minwidth_m2"] # Unit c by m2 width,  F/um units
spice["wire_r_per_um"] = spice["wire_unit_r"]/drc["minwidth_m2"] # Unit r per m2 width, Ohms/um units
spice["mobility_n"] = 0.045e8   # um^2/(V*s)
spice["V_dsat"] = 0.0938        # From CACTI 45nm tech
spice["sa_transconductance"] = (spice["mobility_n"])*spice["cox"]*(parameter["sa_inv_nmos_size"]/parameter["min_tx_size"])*spice["V_dsat"]
###################################################
# Technology Tool Preferences
###################################################

drc_name = "calibre"
lvs_name = "calibre"
pex_name = "calibre"

blackbox_bitcell = False
