
.SUBCKT dummy_si_gc rbl wbl rwl wwl vdd gnd
* Write transistor d g s b
MM0 SN wwl wbl_noconn gnd nch W=120.00n L=50n
* Read transistor d g s b
MM1 rwl SN rbl_noconn vdd pch W=240n L=50n
.ENDS dummy_si_gc

