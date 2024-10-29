
.SUBCKT gain_cell_sense_amp rbl ref dout en vdd gnd
M0 dint net_1 vdd vdd pch w=540.0n l=50.0n
M1 net_1 dint vdd vdd pch w=540.0n l=50.0n
M2 dint net_1 net_2 gnd nch w=270.0n l=50.0n
M3 net_1 dint net_2 gnd nch w=270.0n l=50.0n
M4 rbl en dint vdd pch w=720.0n l=50.0n
M5 ref en net_1 vdd pch w=720.0n l=50.0n
M6 net_2 en gnd gnd nch w=270.0n l=50.0n

M7 dout_bar dint vdd vdd pch w=180.0n l=50.0n
M8 dout_bar dint gnd gnd nch w=120.0n l=50.0n
M9 dout dout_bar vdd vdd pch w=540.0n l=50.0n
M10 dout dout_bar gnd gnd nch w=270.0n l=50.0n
.ENDS gain_cell_sense_amp

