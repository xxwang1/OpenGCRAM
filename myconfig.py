# Data word size
num_banks = 4
word_size = 64
# Number of words in the memory
num_words = 64

num_rw_ports = 1
# Technology to use in $OPENRAM_TECH
tech_name = "tsmcN40"
# Process corners to characterize
process_corners = [ "TT" ]
# Voltage corners to characterize
supply_voltages = [ 3.3 ]
# Temperature corners to characterize
temperatures = [ 25 ]

nominal_corner_only = False

route_supplies = True
check_lvsdrc = True
inline_lvsdrc = False
# Output directory for the results
output_path = "temp"
# Output file base name
output_name = "tsmc_sram_256x256"

# Disable analytical models for full characterization (WARNING: slow!)
# analytical_delay = False

# To force this to use magic and netgen for DRC/LVS/PEX
# Could be calibre for FreePDK45
drc_name = "calibre"
lvs_name = "calibre"
pex_name = "calibre"
keep_temp = True
