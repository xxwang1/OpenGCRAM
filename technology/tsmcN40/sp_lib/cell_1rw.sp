
.SUBCKT cell_1rw bl br wl vdd gnd
* Inverter 1
MM0 Q_bar Q gnd gnd nch W=205.00n L=50n
MM4 Q_bar Q vdd vdd pch W=120n L=50n

* Inverer 2
MM1 Q Q_bar gnd gnd nch W=205.00n L=50n 
MM5 Q Q_bar vdd vdd pch W=120n L=50n

* Access transistors
MM3 bl wl Q gnd nch W=135.00n L=50n
MM2 br wl Q_bar gnd nch W=135.00n L=50n 
.ENDS cell_1rw

