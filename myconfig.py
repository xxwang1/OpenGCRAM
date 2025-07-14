# Data word size
num_banks = 1
word_size = 32
# Number of words in the memory
num_words = 32

num_rw_ports = 1
# Technology to use in $OPENRAM_TECH
tech_name = "tsmcN40"
# Process corners to characterize
process_corners = [ "TT" ]
# Voltage corners to characterize
supply_voltages = [ 1.0 ]
# Temperature corners to characterize
temperatures = [ 25 ]

nominal_corner_only = True

route_supplies = True
check_lvsdrc = True
inline_lvsdrc = False
# Output directory for the results
output_path = "temp_1p0"
# Output file base name
output_name = "tsmc_sram_32x32"

# Disable analytical models for full characterization (WARNING: slow!)
analytical_delay = False
delay_chain_stages = 9
# To force this to use magic and netgen for DRC/LVS/PEX
# Could be calibre for FreePDK45
drc_name = "calibre"
lvs_name = "calibre"
pex_name = "calibre"
keep_temp = True
