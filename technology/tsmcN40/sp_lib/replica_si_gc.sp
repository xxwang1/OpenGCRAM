.SUBCKT replica_si_gc rbl wbl rwl wwl vdd gnd
* Write transistor d g s b
MM0 gnd wwl wbl gnd nch W=120.00n L=50n
* Read transistor d g s b
MM1 rwl gnd rbl vdd pch W=240n L=50n
.ENDS replica_si_gc

