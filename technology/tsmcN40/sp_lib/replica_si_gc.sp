.SUBCKT replica_si_gc rbl wbl rwl wwl vdd gnd
* Write transistor d g s b
MM0 vdd wwl wbl gnd nch W=120.00n L=50n
* Read transistor d g s b
MM1 rwl vdd rbl vdd pch W=120n L=50n
.ENDS replica_si_gc

