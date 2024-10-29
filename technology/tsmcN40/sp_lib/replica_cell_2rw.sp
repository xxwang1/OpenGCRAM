
.SUBCKT replica_cell_2rw bl0 br0 bl1 br1 wl0 wl1 vdd gnd
MM9 RA_to_R_right wl1 br1 gnd nch_mac W=180.0n L=50n m=1
MM8 RA_to_R_right Q gnd gnd nch_mac W=180.0n L=50n m=1
MM7 RA_to_R_left vdd gnd gnd nch_mac W=180.0n L=50n m=1
MM6 RA_to_R_left wl1 bl1 gnd nch_mac W=180.0n L=50n m=1
MM5 Q wl0 bl0 gnd nch_mac W=135.00n L=50n m=1
MM4 vdd wl0 br0 gnd nch_mac W=135.00n L=50n m=1
MM1 Q vdd gnd gnd nch_mac W=205.0n L=50n m=1
MM0 vdd Q gnd gnd nch_mac W=205.0n L=50n m=1
MM3 Q vdd vdd vdd pch_mac W=90n L=50n m=1
MM2 vdd Q vdd vdd pch_mac W=90n L=50n m=1
.ENDS

