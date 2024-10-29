
.SUBCKT gain_cell_write_driver din wbl en vdd gnd
*inverters for enawble and data input
minP wbl_bar din vdd vdd pch w=360.000000n l=50.000000n
minN wbl_bar din gnd gnd nch w=180.000000n l=50.000000n
moutP en_bar en vdd vdd pch w=360.000000n l=50.000000n
moutN en_bar en gnd gnd nch w=180.000000n l=50.000000n

*tristate for wbl
mout0P int1 wbl_bar vdd vdd pch w=360.000000n l=50.000000n
mout0P2 wbl en_bar int1 vdd pch w=360.000000n l=50.000000n
mout0N wbl en int2 gnd nch w=180.000000n l=50.000000n
mout0N2 int2 wbl_bar gnd gnd nch w=180.000000n l=50.000000n

.ENDS gain_cell_write_driver

