.SUBCKT gain_cell_ref_gen ref vdd gnd 
*.PININFO ref:O gnd:B vdd:B
MM6 net6 net3 gnd gnd nch l=120.0n w=120.0n m=1
MM5 net4 net4 gnd gnd nch l=120.0n w=120.0n m=1
MM4 net5 net4 net1 gnd nch l=100n w=625.00n m=1
MM3 net3 net2 gnd gnd nch l=100n w=625.00n m=1
MM2 ref net8 gnd gnd nch l=800n w=120.0n m=1
MM1 net2 net8 gnd gnd nch l=2.4u w=120.0n m=1
MM0 net1 net8 gnd gnd nch l=1.2u w=120.0n m=1
MM18 net86 net87 gnd gnd nch l=120.0n w=120.0n m=1
MM17 net89 net89 gnd gnd nch l=120.0n w=120.0n m=1
MM16 net85 net89 net84 gnd nch l=100n w=625.00n m=1
MM15 net87 net88 gnd gnd nch l=100n w=625.00n m=1
MM14 net8 vdd gnd gnd nch l=800n w=120.0n m=1
MM12 net88 vdd gnd gnd nch l=2.4u w=120.0n m=1
MM13 net84 vdd gnd gnd nch l=1.2u w=120.0n m=1
MM27 net6 net6 net8 vdd pch l=120.0n w=120.0n m=1
MM26 net2 net6 net8 vdd pch l=120.0n w=120.0n m=1
MM11 ref net6 net8 vdd pch l=40n w=120n m=1
MM10 net3 net5 net8 vdd pch l=120.0n w=120.0n m=1
MM9 net4 net5 net8 vdd pch l=120.0n w=120.0n m=1
MM8 net5 net5 net8 vdd pch l=100n w=250.0n m=1
MM7 ref net5 net8 vdd pch l=40n w=1.2u m=1
MM25 net86 net86 vdd vdd pch l=120.0n w=120.0n m=1
MM24 net88 net86 vdd vdd pch l=120.0n w=120.0n m=1
MM23 net8 net86 vdd vdd pch l=40n w=120n m=1
MM22 net87 net85 vdd vdd pch l=120.0n w=120.0n m=1
MM21 net89 net85 vdd vdd pch l=120.0n w=120.0n m=1
MM20 net85 net85 vdd vdd pch l=100n w=250.0n m=1
MM19 net8 net85 vdd vdd pch l=40n w=1.2u m=1
.ENDS
