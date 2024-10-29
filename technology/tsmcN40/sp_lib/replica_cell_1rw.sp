
.SUBCKT replica_cell_1rw bl br wl vdd gnd
* Inverter 1
MM0 vdd Q gnd gnd nch W=205.00n L=50n
MM4 vdd Q vdd vdd pch W=120n L=50n

* Inverer 2
MM1 Q vdd gnd gnd nch W=205.00n L=50n 
MM5 Q vdd vdd vdd pch W=120n L=50n

* Access transistors
MM3 bl wl Q gnd nch W=135.00n L=50n
MM2 br wl vdd gnd nch W=135.00n L=50n 
.ENDS replica_cell_1rw

