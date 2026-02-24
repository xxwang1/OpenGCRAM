# Data word size
num_banks = 1
word_size = 32
# Number of words in the memory
num_words = 32

num_rw_ports = 0
num_r_ports = 1
num_w_ports = 1
# Technology to use in $OPENRAM_TECH
tech_name = "tsmcN40"
# Process corners to characterize
process_corners = [ "TT" ]
# Voltage corners to characterize
supply_voltages = [ 1.0 ]
vddio = 1.2
gc_type = "OS"
# Temperature corners to characterize
temperatures = [ 25 ]

nominal_corner_only = True
delay_chain_stages = 5
delay_chain_fanout_per_stage = 4
trim_netlist = True
route_supplies = True
level_shifter = True
netlist_only = False
check_lvsdrc = True
use_pex = False
inline_lvsdrc = True
# Output directory for the results
output_path = "cxr_tapeout"
# Output file base name
output_name = "tsmc_gain_cell_32x32_os_dcs_5"

# Disable analytical models for full characterization (WARNING: slow!)
analytical_delay = False

# To force this to use magic and netgen for DRC/LVS/PEX
# Could be calibre for FreePDK45
drc_name = "calibre"
lvs_name = "calibre"
pex_name = "calibre"
keep_temp = True
