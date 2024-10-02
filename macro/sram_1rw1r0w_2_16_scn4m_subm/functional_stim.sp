* Functional test stimulus file for 10ns period

* TT process corner
.include "/home/xxwang1/OpenRAM/technology/scn4m_subm/models/nom/pmos.sp"
.include "/home/xxwang1/OpenRAM/technology/scn4m_subm/models/nom/nmos.sp"
.include "/tmp/openram_xxwang1_21993_temp/sram.sp"

* Global Power Supplies
Vvdd vdd 0 5.0

*Nodes gnd and 0 are the same global ground node in ngspice/hspice/xa. Otherwise, this source may be needed.
*Vgnd gnd 0 0.0

* Instantiation of the SRAM
Xsram_1rw1r0w_2_16_scn4m_subm din0_0 din0_1 a0_0 a0_1 a0_2 a0_3 a1_0 a1_1 a1_2 a1_3 CSB0 CSB1 WEB0 clk0 clk1 dout0_0 dout0_1 dout1_0 dout1_1 vdd gnd sram_1rw1r0w_2_16_scn4m_subm

* SRAM output loads
CD00 dout0_0  0 39.2968f
CD01 dout0_1  0 39.2968f
CD10 dout1_0  0 39.2968f
CD11 dout1_1  0 39.2968f


* Important signals for debug
* bl:	xsram:xbank0:bl_0_1
* br:	xsram:xbank0:br_0_1
* s_en:	xsram:s_en
* q:	xsram:xbank0:xbitcell_array:xbitcell_array:xbit_r0_c0.Q
* qbar:	xsram:xbank0:xbitcell_array:xbitcell_array:xbit_r0_c0.Q_bar


* Sequence of operations
*	Idle during cycle 0 (0ns - 10ns)
*	Writing 10  to  address 1110 (from port 0) during cycle 1 (10ns - 20ns)
*	Writing 11  to  address 1110 (from port 0) during cycle 2 (20ns - 30ns)
*	Writing 10  to  address 1110 (from port 0) during cycle 3 (30ns - 40ns)
*	Reading 10 from address 1110 (from port 0) during cycle 4 (40ns - 50ns)
*	Reading 10 from address 1110 (from port 1) during cycle 4 (40ns - 50ns)
*	Reading 10 from address 1110 (from port 0) during cycle 5 (50ns - 60ns)
*	Reading 10 from address 1110 (from port 0) during cycle 6 (60ns - 70ns)
*	Reading 10 from address 1110 (from port 0) during cycle 7 (70ns - 80ns)
*	Reading 10 from address 1110 (from port 0) during cycle 9 (90ns - 100ns)
*	Reading 10 from address 1110 (from port 1) during cycle 9 (90ns - 100ns)
*	Reading 10 from address 1110 (from port 0) during cycle 10 (100ns - 110ns)
*	Writing 10  to  address 0000 (from port 0) during cycle 11 (110ns - 120ns)
*	Reading 10 from address 1110 (from port 1) during cycle 11 (110ns - 120ns)
*	Writing 10  to  address 1110 (from port 0) during cycle 12 (120ns - 130ns)
*	Reading 10 from address 0000 (from port 1) during cycle 12 (120ns - 130ns)
*	Writing 11  to  address 1110 (from port 0) during cycle 14 (140ns - 150ns)
*	Reading 10 from address 0000 (from port 0) during cycle 15 (150ns - 160ns)
*	Reading 10 from address 0000 (from port 1) during cycle 15 (150ns - 160ns)
*	Reading 10 from address 0000 (from port 0) during cycle 16 (160ns - 170ns)
*	Reading 10 from address 0000 (from port 1) during cycle 17 (170ns - 180ns)
*	Writing 11  to  address 0000 (from port 0) during cycle 19 (190ns - 200ns)
*	Reading 11 from address 0000 (from port 0) during cycle 20 (200ns - 210ns)
*	Writing 01  to  address 1110 (from port 0) during cycle 21 (210ns - 220ns)
*	Reading 11 from address 0000 (from port 0) during cycle 22 (220ns - 230ns)
*	Reading 11 from address 0000 (from port 1) during cycle 22 (220ns - 230ns)
*	Reading 11 from address 0000 (from port 0) during cycle 23 (230ns - 240ns)
*	Reading 11 from address 0000 (from port 0) during cycle 24 (240ns - 250ns)
*	Reading 11 from address 0000 (from port 0) during cycle 25 (250ns - 260ns)
*	Reading 01 from address 1110 (from port 1) during cycle 25 (250ns - 260ns)
*	Reading 01 from address 1110 (from port 1) during cycle 26 (260ns - 270ns)
*	Reading 11 from address 0000 (from port 0) during cycle 28 (280ns - 290ns)
*	Reading 01 from address 1110 (from port 0) during cycle 29 (290ns - 300ns)
*	Reading 11 from address 0000 (from port 0) during cycle 30 (300ns - 310ns)
*	Reading 11 from address 0000 (from port 1) during cycle 30 (300ns - 310ns)
*	Writing 11  to  address 1110 (from port 0) during cycle 31 (310ns - 320ns)
*	Writing 11  to  address 0000 (from port 0) during cycle 32 (320ns - 330ns)
*	Reading 11 from address 1110 (from port 1) during cycle 32 (320ns - 330ns)
*	Reading 11 from address 1110 (from port 0) during cycle 33 (330ns - 340ns)
*	Reading 11 from address 0000 (from port 1) during cycle 33 (330ns - 340ns)
*	Reading 11 from address 1110 (from port 0) during cycle 34 (340ns - 350ns)
*	Reading 11 from address 0000 (from port 1) during cycle 35 (350ns - 360ns)
*	Reading 11 from address 0000 (from port 0) during cycle 36 (360ns - 370ns)
*	Reading 11 from address 1110 (from port 1) during cycle 36 (360ns - 370ns)
*	Writing 10  to  address 0000 (from port 0) during cycle 37 (370ns - 380ns)
*	Reading 10 from address 0000 (from port 0) during cycle 38 (380ns - 390ns)
*	Reading 11 from address 1110 (from port 1) during cycle 38 (380ns - 390ns)
*	Writing 10  to  address 1110 (from port 0) during cycle 39 (390ns - 400ns)
*	Reading 10 from address 0000 (from port 1) during cycle 39 (390ns - 400ns)
*	Reading 10 from address 1110 (from port 0) during cycle 40 (400ns - 410ns)
*	Reading 10 from address 0000 (from port 1) during cycle 40 (400ns - 410ns)
*	Writing 01  to  address 1110 (from port 0) during cycle 43 (430ns - 440ns)
*	Reading 10 from address 0000 (from port 0) during cycle 44 (440ns - 450ns)
*	Reading 01 from address 1110 (from port 0) during cycle 45 (450ns - 460ns)
*	Reading 01 from address 1110 (from port 1) during cycle 45 (450ns - 460ns)
*	Writing 10  to  address 0000 (from port 0) during cycle 47 (470ns - 480ns)
*	Reading 01 from address 1110 (from port 0) during cycle 48 (480ns - 490ns)
*	Reading 10 from address 0000 (from port 1) during cycle 48 (480ns - 490ns)
*	Reading 10 from address 0000 (from port 0) during cycle 49 (490ns - 500ns)
*	Reading 10 from address 0000 (from port 0) during cycle 50 (500ns - 510ns)
*	Reading 10 from address 0000 (from port 1) during cycle 50 (500ns - 510ns)
*	Writing 10  to  address 1110 (from port 0) during cycle 51 (510ns - 520ns)
*	Writing 10  to  address 0000 (from port 0) during cycle 52 (520ns - 530ns)
*	Reading 10 from address 0000 (from port 0) during cycle 53 (530ns - 540ns)
*	Reading 10 from address 0000 (from port 1) during cycle 53 (530ns - 540ns)
*	Reading 10 from address 1110 (from port 0) during cycle 54 (540ns - 550ns)
*	Reading 10 from address 1110 (from port 1) during cycle 54 (540ns - 550ns)
*	Reading 10 from address 1110 (from port 0) during cycle 55 (550ns - 560ns)
*	Writing 11  to  address 1110 (from port 0) during cycle 56 (560ns - 570ns)
*	Writing 11  to  address 1110 (from port 0) during cycle 57 (570ns - 580ns)
*	Reading 10 from address 0000 (from port 0) during cycle 59 (590ns - 600ns)
*	Reading 11 from address 1110 (from port 1) during cycle 59 (590ns - 600ns)
*	Reading 11 from address 1110 (from port 0) during cycle 60 (600ns - 610ns)
*	Writing 11  to  address 0000 (from port 0) during cycle 62 (620ns - 630ns)
*	Reading 11 from address 1110 (from port 0) during cycle 63 (630ns - 640ns)
*	Reading 11 from address 1110 (from port 1) during cycle 63 (630ns - 640ns)
*	Reading 11 from address 1110 (from port 0) during cycle 65 (650ns - 660ns)
*	Reading 11 from address 0000 (from port 0) during cycle 66 (660ns - 670ns)
*	Reading 11 from address 0000 (from port 0) during cycle 68 (680ns - 690ns)
*	Reading 11 from address 1110 (from port 1) during cycle 68 (680ns - 690ns)
*	Reading 11 from address 0000 (from port 0) during cycle 70 (700ns - 710ns)
*	Reading 11 from address 0000 (from port 1) during cycle 70 (700ns - 710ns)
*	Writing 01  to  address 1110 (from port 0) during cycle 71 (710ns - 720ns)
*	Reading 01 from address 1110 (from port 0) during cycle 72 (720ns - 730ns)
*	Reading 11 from address 0000 (from port 0) during cycle 73 (730ns - 740ns)
*	Reading 11 from address 0000 (from port 0) during cycle 74 (740ns - 750ns)
*	Reading 11 from address 0000 (from port 0) during cycle 75 (750ns - 760ns)
*	Reading 01 from address 1110 (from port 0) during cycle 76 (760ns - 770ns)
*	Reading 01 from address 1110 (from port 1) during cycle 76 (760ns - 770ns)
*	Reading 01 from address 1110 (from port 0) during cycle 78 (780ns - 790ns)
*	Reading 11 from address 0000 (from port 1) during cycle 78 (780ns - 790ns)
*	Reading 11 from address 0000 (from port 0) during cycle 79 (790ns - 800ns)
*	Reading 01 from address 1110 (from port 1) during cycle 79 (790ns - 800ns)
*	Reading 01 from address 1110 (from port 0) during cycle 80 (800ns - 810ns)
*	Reading 11 from address 0000 (from port 1) during cycle 80 (800ns - 810ns)
*	Writing 10  to  address 0000 (from port 0) during cycle 81 (810ns - 820ns)
*	Reading 01 from address 1110 (from port 1) during cycle 82 (820ns - 830ns)
*	Reading 10 from address 0000 (from port 0) during cycle 83 (830ns - 840ns)
*	Reading 10 from address 0000 (from port 1) during cycle 83 (830ns - 840ns)
*	Reading 01 from address 1110 (from port 0) during cycle 84 (840ns - 850ns)
*	Reading 10 from address 0000 (from port 0) during cycle 86 (860ns - 870ns)
*	Writing 10  to  address 0000 (from port 0) during cycle 87 (870ns - 880ns)
*	Reading 10 from address 0000 (from port 1) during cycle 88 (880ns - 890ns)
*	Writing 10  to  address 0000 (from port 0) during cycle 89 (890ns - 900ns)
*	Reading 01 from address 1110 (from port 0) during cycle 90 (900ns - 910ns)
*	Reading 10 from address 0000 (from port 1) during cycle 90 (900ns - 910ns)
*	Reading 10 from address 0000 (from port 1) during cycle 91 (910ns - 920ns)
*	Reading 01 from address 1110 (from port 1) during cycle 92 (920ns - 930ns)
*	Reading 10 from address 0000 (from port 0) during cycle 93 (930ns - 940ns)
*	Reading 01 from address 1110 (from port 1) during cycle 93 (930ns - 940ns)
*	Reading 01 from address 1110 (from port 1) during cycle 94 (940ns - 950ns)
*	Reading 10 from address 0000 (from port 0) during cycle 95 (950ns - 960ns)
*	Reading 01 from address 1110 (from port 1) during cycle 95 (950ns - 960ns)
*	Reading 10 from address 0000 (from port 0) during cycle 98 (980ns - 990ns)
*	Reading 10 from address 0000 (from port 1) during cycle 99 (990ns - 1000ns)
*	Writing 10  to  address 1110 (from port 0) during cycle 100 (1000ns - 1010ns)
*	Reading 10 from address 1110 (from port 0) during cycle 101 (1010ns - 1020ns)
*	Writing 01  to  address 1110 (from port 0) during cycle 102 (1020ns - 1030ns)
*	Reading 01 from address 1110 (from port 0) during cycle 103 (1030ns - 1040ns)
*	Reading 10 from address 0000 (from port 0) during cycle 104 (1040ns - 1050ns)
*	Reading 10 from address 0000 (from port 1) during cycle 104 (1040ns - 1050ns)
*	Reading 10 from address 0000 (from port 0) during cycle 105 (1050ns - 1060ns)
*	Reading 10 from address 0000 (from port 1) during cycle 105 (1050ns - 1060ns)
*	Reading 10 from address 0000 (from port 0) during cycle 106 (1060ns - 1070ns)
*	Writing 01  to  address 1110 (from port 0) during cycle 107 (1070ns - 1080ns)
*	Writing 11  to  address 1110 (from port 0) during cycle 108 (1080ns - 1090ns)
*	Reading 11 from address 1110 (from port 0) during cycle 109 (1090ns - 1100ns)
*	Writing 10  to  address 1110 (from port 0) during cycle 111 (1110ns - 1120ns)
*	Writing 11  to  address 0000 (from port 0) during cycle 112 (1120ns - 1130ns)
*	Writing 11  to  address 0000 (from port 0) during cycle 113 (1130ns - 1140ns)
*	Reading 10 from address 1110 (from port 1) during cycle 113 (1130ns - 1140ns)
*	Reading 11 from address 0000 (from port 0) during cycle 115 (1150ns - 1160ns)
*	Reading 11 from address 0000 (from port 1) during cycle 115 (1150ns - 1160ns)
*	Writing 01  to  address 1110 (from port 0) during cycle 116 (1160ns - 1170ns)
*	Reading 11 from address 0000 (from port 0) during cycle 117 (1170ns - 1180ns)
*	Reading 11 from address 0000 (from port 0) during cycle 118 (1180ns - 1190ns)
*	Reading 11 from address 0000 (from port 1) during cycle 118 (1180ns - 1190ns)
*	Reading 11 from address 0000 (from port 0) during cycle 119 (1190ns - 1200ns)
*	Reading 01 from address 1110 (from port 1) during cycle 119 (1190ns - 1200ns)
*	Reading 01 from address 1110 (from port 0) during cycle 120 (1200ns - 1210ns)
*	Reading 01 from address 1110 (from port 1) during cycle 120 (1200ns - 1210ns)
*	Reading 11 from address 0000 (from port 0) during cycle 121 (1210ns - 1220ns)
*	Reading 11 from address 0000 (from port 1) during cycle 121 (1210ns - 1220ns)
*	Reading 01 from address 1110 (from port 0) during cycle 124 (1240ns - 1250ns)
*	Reading 11 from address 0000 (from port 0) during cycle 125 (1250ns - 1260ns)
*	Reading 11 from address 0000 (from port 1) during cycle 125 (1250ns - 1260ns)
*	Reading 01 from address 1110 (from port 0) during cycle 127 (1270ns - 1280ns)
*	Reading 11 from address 0000 (from port 1) during cycle 127 (1270ns - 1280ns)
*	Reading 11 from address 0000 (from port 0) during cycle 128 (1280ns - 1290ns)
*	Reading 11 from address 0000 (from port 1) during cycle 128 (1280ns - 1290ns)
*	Writing 10  to  address 1110 (from port 0) during cycle 129 (1290ns - 1300ns)
*	Reading 11 from address 0000 (from port 1) during cycle 129 (1290ns - 1300ns)
*	Reading 11 from address 0000 (from port 0) during cycle 130 (1300ns - 1310ns)
*	Writing 11  to  address 0000 (from port 0) during cycle 131 (1310ns - 1320ns)
*	Reading 11 from address 0000 (from port 1) during cycle 132 (1320ns - 1330ns)
*	Reading 11 from address 0000 (from port 0) during cycle 133 (1330ns - 1340ns)
*	Reading 10 from address 1110 (from port 1) during cycle 133 (1330ns - 1340ns)
*	Reading 11 from address 0000 (from port 0) during cycle 134 (1340ns - 1350ns)
*	Reading 10 from address 1110 (from port 1) during cycle 134 (1340ns - 1350ns)
*	Reading 11 from address 0000 (from port 0) during cycle 136 (1360ns - 1370ns)
*	Reading 11 from address 0000 (from port 1) during cycle 137 (1370ns - 1380ns)
*	Reading 10 from address 1110 (from port 0) during cycle 138 (1380ns - 1390ns)
*	Reading 10 from address 1110 (from port 1) during cycle 138 (1380ns - 1390ns)
*	Reading 11 from address 0000 (from port 1) during cycle 139 (1390ns - 1400ns)
*	Reading 10 from address 1110 (from port 0) during cycle 140 (1400ns - 1410ns)
*	Reading 11 from address 0000 (from port 0) during cycle 142 (1420ns - 1430ns)
*	Reading 11 from address 0000 (from port 0) during cycle 144 (1440ns - 1450ns)
*	Writing 01  to  address 0000 (from port 0) during cycle 146 (1460ns - 1470ns)
*	Reading 10 from address 1110 (from port 1) during cycle 146 (1460ns - 1470ns)
*	Writing 10  to  address 0000 (from port 0) during cycle 147 (1470ns - 1480ns)
*	Reading 10 from address 1110 (from port 1) during cycle 147 (1470ns - 1480ns)
*	Reading 10 from address 0000 (from port 0) during cycle 148 (1480ns - 1490ns)
*	Reading 10 from address 0000 (from port 1) during cycle 148 (1480ns - 1490ns)
*	Reading 10 from address 1110 (from port 0) during cycle 149 (1490ns - 1500ns)
*	Reading 10 from address 0000 (from port 1) during cycle 149 (1490ns - 1500ns)
*	Reading 10 from address 0000 (from port 0) during cycle 151 (1510ns - 1520ns)
*	Reading 10 from address 0000 (from port 1) during cycle 151 (1510ns - 1520ns)
*	Writing 10  to  address 1110 (from port 0) during cycle 152 (1520ns - 1530ns)
*	Reading 10 from address 0000 (from port 1) during cycle 153 (1530ns - 1540ns)
*	Reading 10 from address 0000 (from port 0) during cycle 154 (1540ns - 1550ns)
*	Reading 10 from address 1110 (from port 1) during cycle 154 (1540ns - 1550ns)
*	Reading 10 from address 1110 (from port 0) during cycle 155 (1550ns - 1560ns)
*	Reading 10 from address 0000 (from port 1) during cycle 155 (1550ns - 1560ns)
*	Writing 11  to  address 1110 (from port 0) during cycle 156 (1560ns - 1570ns)
*	Reading 10 from address 0000 (from port 1) during cycle 156 (1560ns - 1570ns)
*	Reading 11 from address 1110 (from port 0) during cycle 157 (1570ns - 1580ns)
*	Writing 10  to  address 1110 (from port 0) during cycle 159 (1590ns - 1600ns)
*	Reading 10 from address 0000 (from port 0) during cycle 160 (1600ns - 1610ns)
*	Reading 10 from address 0000 (from port 1) during cycle 160 (1600ns - 1610ns)
*	Writing 01  to  address 1110 (from port 0) during cycle 161 (1610ns - 1620ns)
*	Reading 10 from address 0000 (from port 1) during cycle 162 (1620ns - 1630ns)
*	Reading 01 from address 1110 (from port 0) during cycle 163 (1630ns - 1640ns)
*	Reading 01 from address 1110 (from port 0) during cycle 164 (1640ns - 1650ns)
*	Reading 10 from address 0000 (from port 1) during cycle 166 (1660ns - 1670ns)
*	Reading 01 from address 1110 (from port 0) during cycle 167 (1670ns - 1680ns)
*	Reading 01 from address 1110 (from port 0) during cycle 168 (1680ns - 1690ns)
*	Reading 01 from address 1110 (from port 0) during cycle 169 (1690ns - 1700ns)
*	Reading 10 from address 0000 (from port 1) during cycle 169 (1690ns - 1700ns)
*	Reading 01 from address 1110 (from port 1) during cycle 170 (1700ns - 1710ns)
*	Reading 01 from address 1110 (from port 0) during cycle 171 (1710ns - 1720ns)
*	Writing 10  to  address 0000 (from port 0) during cycle 172 (1720ns - 1730ns)
*	Reading 01 from address 1110 (from port 0) during cycle 173 (1730ns - 1740ns)
*	Reading 10 from address 0000 (from port 1) during cycle 173 (1730ns - 1740ns)
*	Reading 01 from address 1110 (from port 0) during cycle 176 (1760ns - 1770ns)
*	Reading 01 from address 1110 (from port 1) during cycle 176 (1760ns - 1770ns)
*	Writing 01  to  address 1110 (from port 0) during cycle 177 (1770ns - 1780ns)
*	Reading 10 from address 0000 (from port 1) during cycle 177 (1770ns - 1780ns)
*	Writing 01  to  address 1110 (from port 0) during cycle 178 (1780ns - 1790ns)
*	Reading 10 from address 0000 (from port 0) during cycle 179 (1790ns - 1800ns)
*	Reading 01 from address 1110 (from port 1) during cycle 179 (1790ns - 1800ns)
*	Reading 01 from address 1110 (from port 0) during cycle 180 (1800ns - 1810ns)
*	Reading 10 from address 0000 (from port 0) during cycle 181 (1810ns - 1820ns)
*	Reading 01 from address 1110 (from port 0) during cycle 183 (1830ns - 1840ns)
*	Reading 01 from address 1110 (from port 1) during cycle 184 (1840ns - 1850ns)
*	Writing 11  to  address 1110 (from port 0) during cycle 186 (1860ns - 1870ns)
*	Reading 10 from address 0000 (from port 0) during cycle 187 (1870ns - 1880ns)
*	Writing 10  to  address 0000 (from port 0) during cycle 188 (1880ns - 1890ns)
*	Reading 11 from address 1110 (from port 1) during cycle 188 (1880ns - 1890ns)
*	Writing 11  to  address 1110 (from port 0) during cycle 189 (1890ns - 1900ns)
*	Reading 10 from address 0000 (from port 1) during cycle 190 (1900ns - 1910ns)
*	Writing 11  to  address 1110 (from port 0) during cycle 191 (1910ns - 1920ns)
*	Reading 10 from address 0000 (from port 1) during cycle 191 (1910ns - 1920ns)
*	Reading 10 from address 0000 (from port 1) during cycle 192 (1920ns - 1930ns)
*	Reading 11 from address 1110 (from port 0) during cycle 193 (1930ns - 1940ns)
*	Reading 10 from address 0000 (from port 1) during cycle 193 (1930ns - 1940ns)
*	Reading 10 from address 0000 (from port 0) during cycle 194 (1940ns - 1950ns)
*	Reading 11 from address 1110 (from port 1) during cycle 194 (1940ns - 1950ns)
*	Reading 11 from address 1110 (from port 0) during cycle 195 (1950ns - 1960ns)
*	Reading 10 from address 0000 (from port 0) during cycle 196 (1960ns - 1970ns)
*	Reading 10 from address 0000 (from port 1) during cycle 196 (1960ns - 1970ns)
*	Writing 01  to  address 0000 (from port 0) during cycle 197 (1970ns - 1980ns)
*	Reading 11 from address 1110 (from port 1) during cycle 197 (1970ns - 1980ns)
*	Reading 11 from address 1110 (from port 0) during cycle 198 (1980ns - 1990ns)
*	Reading 01 from address 0000 (from port 1) during cycle 198 (1980ns - 1990ns)
*	Reading 01 from address 0000 (from port 0) during cycle 199 (1990ns - 2000ns)
*	Reading 11 from address 1110 (from port 0) during cycle 200 (2000ns - 2010ns)
*	Writing 10  to  address 0000 (from port 0) during cycle 201 (2010ns - 2020ns)
*	Reading 11 from address 1110 (from port 1) during cycle 201 (2010ns - 2020ns)
*	Reading 10 from address 0000 (from port 0) during cycle 202 (2020ns - 2030ns)
*	Writing 11  to  address 1110 (from port 0) during cycle 203 (2030ns - 2040ns)
*	Reading 10 from address 0000 (from port 1) during cycle 203 (2030ns - 2040ns)
*	Writing 10  to  address 1110 (from port 0) during cycle 204 (2040ns - 2050ns)
*	Idle during cycle 205 (2050ns - 2060ns)

* Generation of data and address signals
* (time, data): [(0, 0), (10, 0), (20, 1), (30, 0), (40, 0), (50, 0), (60, 0), (70, 0), (80, 0), (90, 0), (100, 0), (110, 0), (120, 0), (130, 0), (140, 1), (150, 1), (160, 1), (170, 1), (180, 1), (190, 1), (200, 1), (210, 1), (220, 1), (230, 1), (240, 1), (250, 1), (260, 1), (270, 1), (280, 1), (290, 1), (300, 1), (310, 1), (320, 1), (330, 1), (340, 1), (350, 1), (360, 1), (370, 0), (380, 0), (390, 0), (400, 0), (410, 0), (420, 0), (430, 1), (440, 1), (450, 1), (460, 1), (470, 0), (480, 0), (490, 0), (500, 0), (510, 0), (520, 0), (530, 0), (540, 0), (550, 0), (560, 1), (570, 1), (580, 1), (590, 1), (600, 1), (610, 1), (620, 1), (630, 1), (640, 1), (650, 1), (660, 1), (670, 1), (680, 1), (690, 1), (700, 1), (710, 1), (720, 1), (730, 1), (740, 1), (750, 1), (760, 1), (770, 1), (780, 1), (790, 1), (800, 1), (810, 0), (820, 0), (830, 0), (840, 0), (850, 0), (860, 0), (870, 0), (880, 0), (890, 0), (900, 0), (910, 0), (920, 0), (930, 0), (940, 0), (950, 0), (960, 0), (970, 0), (980, 0), (990, 0), (1000, 0), (1010, 0), (1020, 1), (1030, 1), (1040, 1), (1050, 1), (1060, 1), (1070, 1), (1080, 1), (1090, 1), (1100, 1), (1110, 0), (1120, 1), (1130, 1), (1140, 1), (1150, 1), (1160, 1), (1170, 1), (1180, 1), (1190, 1), (1200, 1), (1210, 1), (1220, 1), (1230, 1), (1240, 1), (1250, 1), (1260, 1), (1270, 1), (1280, 1), (1290, 0), (1300, 0), (1310, 1), (1320, 1), (1330, 1), (1340, 1), (1350, 1), (1360, 1), (1370, 1), (1380, 1), (1390, 1), (1400, 1), (1410, 1), (1420, 1), (1430, 1), (1440, 1), (1450, 1), (1460, 1), (1470, 0), (1480, 0), (1490, 0), (1500, 0), (1510, 0), (1520, 0), (1530, 0), (1540, 0), (1550, 0), (1560, 1), (1570, 1), (1580, 1), (1590, 0), (1600, 0), (1610, 1), (1620, 1), (1630, 1), (1640, 1), (1650, 1), (1660, 1), (1670, 1), (1680, 1), (1690, 1), (1700, 1), (1710, 1), (1720, 0), (1730, 0), (1740, 0), (1750, 0), (1760, 0), (1770, 1), (1780, 1), (1790, 1), (1800, 1), (1810, 1), (1820, 1), (1830, 1), (1840, 1), (1850, 1), (1860, 1), (1870, 1), (1880, 0), (1890, 1), (1900, 1), (1910, 1), (1920, 1), (1930, 1), (1940, 1), (1950, 1), (1960, 1), (1970, 1), (1980, 1), (1990, 1), (2000, 1), (2010, 0), (2020, 0), (2030, 1), (2040, 0), (2050, 0)]
Vdin0_0  din0_0  0 PWL (0n 0.0v 9.45n 0.0v 9.55n 0.0v 19.45n 0.0v 19.55n 5.0v 29.45n 5.0v 29.55n 0.0v 39.45n 0.0v 39.55n 0.0v 49.45n 0.0v 49.55n 0.0v 59.45n 0.0v 59.55n 0.0v 69.45n 0.0v 69.55n 0.0v 79.45n 0.0v 79.55n 0.0v 89.45n 0.0v 89.55n 0.0v 99.45n 0.0v 99.55n 0.0v 109.45n 0.0v 109.55n 0.0v 119.45n 0.0v 119.55n 0.0v 129.45n 0.0v 129.55n 0.0v 139.45n 0.0v 139.55n 5.0v 149.45n 5.0v 149.55n 5.0v 159.45n 5.0v 159.55n 5.0v 169.45n 5.0v 169.55n 5.0v 179.45n 5.0v 179.55n 5.0v 189.45n 5.0v 189.55n 5.0v 199.45n 5.0v 199.55n 5.0v 209.45n 5.0v 209.55n 5.0v 219.45n 5.0v 219.55n 5.0v 229.45n 5.0v 229.55n 5.0v 239.45n 5.0v 239.55n 5.0v 249.45n 5.0v 249.55n 5.0v 259.45n 5.0v 259.55n 5.0v 269.45n 5.0v 269.55n 5.0v 279.45n 5.0v 279.55n 5.0v 289.45n 5.0v 289.55n 5.0v 299.45n 5.0v 299.55n 5.0v 309.45n 5.0v 309.55n 5.0v 319.45n 5.0v 319.55n 5.0v 329.45n 5.0v 329.55n 5.0v 339.45n 5.0v 339.55n 5.0v 349.45n 5.0v 349.55n 5.0v 359.45n 5.0v 359.55n 5.0v 369.45n 5.0v 369.55n 0.0v 379.45n 0.0v 379.55n 0.0v 389.45n 0.0v 389.55n 0.0v 399.45n 0.0v 399.55n 0.0v 409.45n 0.0v 409.55n 0.0v 419.45n 0.0v 419.55n 0.0v 429.45n 0.0v 429.55n 5.0v 439.45n 5.0v 439.55n 5.0v 449.45n 5.0v 449.55n 5.0v 459.45n 5.0v 459.55n 5.0v 469.45n 5.0v 469.55n 0.0v 479.45n 0.0v 479.55n 0.0v 489.45n 0.0v 489.55n 0.0v 499.45n 0.0v 499.55n 0.0v 509.45n 0.0v 509.55n 0.0v 519.45n 0.0v 519.55n 0.0v 529.45n 0.0v 529.55n 0.0v 539.45n 0.0v 539.55n 0.0v 549.45n 0.0v 549.55n 0.0v 559.45n 0.0v 559.55n 5.0v 569.45n 5.0v 569.55n 5.0v 579.45n 5.0v 579.55n 5.0v 589.45n 5.0v 589.55n 5.0v 599.45n 5.0v 599.55n 5.0v 609.45n 5.0v 609.55n 5.0v 619.45n 5.0v 619.55n 5.0v 629.45n 5.0v 629.55n 5.0v 639.45n 5.0v 639.55n 5.0v 649.45n 5.0v 649.55n 5.0v 659.45n 5.0v 659.55n 5.0v 669.45n 5.0v 669.55n 5.0v 679.45n 5.0v 679.55n 5.0v 689.45n 5.0v 689.55n 5.0v 699.45n 5.0v 699.55n 5.0v 709.45n 5.0v 709.55n 5.0v 719.45n 5.0v 719.55n 5.0v 729.45n 5.0v 729.55n 5.0v 739.45n 5.0v 739.55n 5.0v 749.45n 5.0v 749.55n 5.0v 759.45n 5.0v 759.55n 5.0v 769.45n 5.0v 769.55n 5.0v 779.45n 5.0v 779.55n 5.0v 789.45n 5.0v 789.55n 5.0v 799.45n 5.0v 799.55n 5.0v 809.45n 5.0v 809.55n 0.0v 819.45n 0.0v 819.55n 0.0v 829.45n 0.0v 829.55n 0.0v 839.45n 0.0v 839.55n 0.0v 849.45n 0.0v 849.55n 0.0v 859.45n 0.0v 859.55n 0.0v 869.45n 0.0v 869.55n 0.0v 879.45n 0.0v 879.55n 0.0v 889.45n 0.0v 889.55n 0.0v 899.45n 0.0v 899.55n 0.0v 909.45n 0.0v 909.55n 0.0v 919.45n 0.0v 919.55n 0.0v 929.45n 0.0v 929.55n 0.0v 939.45n 0.0v 939.55n 0.0v 949.45n 0.0v 949.55n 0.0v 959.45n 0.0v 959.55n 0.0v 969.45n 0.0v 969.55n 0.0v 979.45n 0.0v 979.55n 0.0v 989.45n 0.0v 989.55n 0.0v 999.45n 0.0v 999.55n 0.0v 1009.45n 0.0v 1009.55n 0.0v 1019.45n 0.0v 1019.55n 5.0v 1029.45n 5.0v 1029.55n 5.0v 1039.45n 5.0v 1039.55n 5.0v 1049.45n 5.0v 1049.55n 5.0v 1059.45n 5.0v 1059.55n 5.0v 1069.45n 5.0v 1069.55n 5.0v 1079.45n 5.0v 1079.55n 5.0v 1089.45n 5.0v 1089.55n 5.0v 1099.45n 5.0v 1099.55n 5.0v 1109.45n 5.0v 1109.55n 0.0v 1119.45n 0.0v 1119.55n 5.0v 1129.45n 5.0v 1129.55n 5.0v 1139.45n 5.0v 1139.55n 5.0v 1149.45n 5.0v 1149.55n 5.0v 1159.45n 5.0v 1159.55n 5.0v 1169.45n 5.0v 1169.55n 5.0v 1179.45n 5.0v 1179.55n 5.0v 1189.45n 5.0v 1189.55n 5.0v 1199.45n 5.0v 1199.55n 5.0v 1209.45n 5.0v 1209.55n 5.0v 1219.45n 5.0v 1219.55n 5.0v 1229.45n 5.0v 1229.55n 5.0v 1239.45n 5.0v 1239.55n 5.0v 1249.45n 5.0v 1249.55n 5.0v 1259.45n 5.0v 1259.55n 5.0v 1269.45n 5.0v 1269.55n 5.0v 1279.45n 5.0v 1279.55n 5.0v 1289.45n 5.0v 1289.55n 0.0v 1299.45n 0.0v 1299.55n 0.0v 1309.45n 0.0v 1309.55n 5.0v 1319.45n 5.0v 1319.55n 5.0v 1329.45n 5.0v 1329.55n 5.0v 1339.45n 5.0v 1339.55n 5.0v 1349.45n 5.0v 1349.55n 5.0v 1359.45n 5.0v 1359.55n 5.0v 1369.45n 5.0v 1369.55n 5.0v 1379.45n 5.0v 1379.55n 5.0v 1389.45n 5.0v 1389.55n 5.0v 1399.45n 5.0v 1399.55n 5.0v 1409.45n 5.0v 1409.55n 5.0v 1419.45n 5.0v 1419.55n 5.0v 1429.45n 5.0v 1429.55n 5.0v 1439.45n 5.0v 1439.55n 5.0v 1449.45n 5.0v 1449.55n 5.0v 1459.45n 5.0v 1459.55n 5.0v 1469.45n 5.0v 1469.55n 0.0v 1479.45n 0.0v 1479.55n 0.0v 1489.45n 0.0v 1489.55n 0.0v 1499.45n 0.0v 1499.55n 0.0v 1509.45n 0.0v 1509.55n 0.0v 1519.45n 0.0v 1519.55n 0.0v 1529.45n 0.0v 1529.55n 0.0v 1539.45n 0.0v 1539.55n 0.0v 1549.45n 0.0v 1549.55n 0.0v 1559.45n 0.0v 1559.55n 5.0v 1569.45n 5.0v 1569.55n 5.0v 1579.45n 5.0v 1579.55n 5.0v 1589.45n 5.0v 1589.55n 0.0v 1599.45n 0.0v 1599.55n 0.0v 1609.45n 0.0v 1609.55n 5.0v 1619.45n 5.0v 1619.55n 5.0v 1629.45n 5.0v 1629.55n 5.0v 1639.45n 5.0v 1639.55n 5.0v 1649.45n 5.0v 1649.55n 5.0v 1659.45n 5.0v 1659.55n 5.0v 1669.45n 5.0v 1669.55n 5.0v 1679.45n 5.0v 1679.55n 5.0v 1689.45n 5.0v 1689.55n 5.0v 1699.45n 5.0v 1699.55n 5.0v 1709.45n 5.0v 1709.55n 5.0v 1719.45n 5.0v 1719.55n 0.0v 1729.45n 0.0v 1729.55n 0.0v 1739.45n 0.0v 1739.55n 0.0v 1749.45n 0.0v 1749.55n 0.0v 1759.45n 0.0v 1759.55n 0.0v 1769.45n 0.0v 1769.55n 5.0v 1779.45n 5.0v 1779.55n 5.0v 1789.45n 5.0v 1789.55n 5.0v 1799.45n 5.0v 1799.55n 5.0v 1809.45n 5.0v 1809.55n 5.0v 1819.45n 5.0v 1819.55n 5.0v 1829.45n 5.0v 1829.55n 5.0v 1839.45n 5.0v 1839.55n 5.0v 1849.45n 5.0v 1849.55n 5.0v 1859.45n 5.0v 1859.55n 5.0v 1869.45n 5.0v 1869.55n 5.0v 1879.45n 5.0v 1879.55n 0.0v 1889.45n 0.0v 1889.55n 5.0v 1899.45n 5.0v 1899.55n 5.0v 1909.45n 5.0v 1909.55n 5.0v 1919.45n 5.0v 1919.55n 5.0v 1929.45n 5.0v 1929.55n 5.0v 1939.45n 5.0v 1939.55n 5.0v 1949.45n 5.0v 1949.55n 5.0v 1959.45n 5.0v 1959.55n 5.0v 1969.45n 5.0v 1969.55n 5.0v 1979.45n 5.0v 1979.55n 5.0v 1989.45n 5.0v 1989.55n 5.0v 1999.45n 5.0v 1999.55n 5.0v 2009.45n 5.0v 2009.55n 0.0v 2019.45n 0.0v 2019.55n 0.0v 2029.45n 0.0v 2029.55n 5.0v 2039.45n 5.0v 2039.55n 0.0v 2049.45n 0.0v 2049.55n 0.0v )
* (time, data): [(0, 0), (10, 1), (20, 1), (30, 1), (40, 1), (50, 1), (60, 1), (70, 1), (80, 1), (90, 1), (100, 1), (110, 1), (120, 1), (130, 1), (140, 1), (150, 1), (160, 1), (170, 1), (180, 1), (190, 1), (200, 1), (210, 0), (220, 0), (230, 0), (240, 0), (250, 0), (260, 0), (270, 0), (280, 0), (290, 0), (300, 0), (310, 1), (320, 1), (330, 1), (340, 1), (350, 1), (360, 1), (370, 1), (380, 1), (390, 1), (400, 1), (410, 1), (420, 1), (430, 0), (440, 0), (450, 0), (460, 0), (470, 1), (480, 1), (490, 1), (500, 1), (510, 1), (520, 1), (530, 1), (540, 1), (550, 1), (560, 1), (570, 1), (580, 1), (590, 1), (600, 1), (610, 1), (620, 1), (630, 1), (640, 1), (650, 1), (660, 1), (670, 1), (680, 1), (690, 1), (700, 1), (710, 0), (720, 0), (730, 0), (740, 0), (750, 0), (760, 0), (770, 0), (780, 0), (790, 0), (800, 0), (810, 1), (820, 1), (830, 1), (840, 1), (850, 1), (860, 1), (870, 1), (880, 1), (890, 1), (900, 1), (910, 1), (920, 1), (930, 1), (940, 1), (950, 1), (960, 1), (970, 1), (980, 1), (990, 1), (1000, 1), (1010, 1), (1020, 0), (1030, 0), (1040, 0), (1050, 0), (1060, 0), (1070, 0), (1080, 1), (1090, 1), (1100, 1), (1110, 1), (1120, 1), (1130, 1), (1140, 1), (1150, 1), (1160, 0), (1170, 0), (1180, 0), (1190, 0), (1200, 0), (1210, 0), (1220, 0), (1230, 0), (1240, 0), (1250, 0), (1260, 0), (1270, 0), (1280, 0), (1290, 1), (1300, 1), (1310, 1), (1320, 1), (1330, 1), (1340, 1), (1350, 1), (1360, 1), (1370, 1), (1380, 1), (1390, 1), (1400, 1), (1410, 1), (1420, 1), (1430, 1), (1440, 1), (1450, 1), (1460, 0), (1470, 1), (1480, 1), (1490, 1), (1500, 1), (1510, 1), (1520, 1), (1530, 1), (1540, 1), (1550, 1), (1560, 1), (1570, 1), (1580, 1), (1590, 1), (1600, 1), (1610, 0), (1620, 0), (1630, 0), (1640, 0), (1650, 0), (1660, 0), (1670, 0), (1680, 0), (1690, 0), (1700, 0), (1710, 0), (1720, 1), (1730, 1), (1740, 1), (1750, 1), (1760, 1), (1770, 0), (1780, 0), (1790, 0), (1800, 0), (1810, 0), (1820, 0), (1830, 0), (1840, 0), (1850, 0), (1860, 1), (1870, 1), (1880, 1), (1890, 1), (1900, 1), (1910, 1), (1920, 1), (1930, 1), (1940, 1), (1950, 1), (1960, 1), (1970, 0), (1980, 0), (1990, 0), (2000, 0), (2010, 1), (2020, 1), (2030, 1), (2040, 1), (2050, 1)]
Vdin0_1  din0_1  0 PWL (0n 0.0v 9.45n 0.0v 9.55n 5.0v 19.45n 5.0v 19.55n 5.0v 29.45n 5.0v 29.55n 5.0v 39.45n 5.0v 39.55n 5.0v 49.45n 5.0v 49.55n 5.0v 59.45n 5.0v 59.55n 5.0v 69.45n 5.0v 69.55n 5.0v 79.45n 5.0v 79.55n 5.0v 89.45n 5.0v 89.55n 5.0v 99.45n 5.0v 99.55n 5.0v 109.45n 5.0v 109.55n 5.0v 119.45n 5.0v 119.55n 5.0v 129.45n 5.0v 129.55n 5.0v 139.45n 5.0v 139.55n 5.0v 149.45n 5.0v 149.55n 5.0v 159.45n 5.0v 159.55n 5.0v 169.45n 5.0v 169.55n 5.0v 179.45n 5.0v 179.55n 5.0v 189.45n 5.0v 189.55n 5.0v 199.45n 5.0v 199.55n 5.0v 209.45n 5.0v 209.55n 0.0v 219.45n 0.0v 219.55n 0.0v 229.45n 0.0v 229.55n 0.0v 239.45n 0.0v 239.55n 0.0v 249.45n 0.0v 249.55n 0.0v 259.45n 0.0v 259.55n 0.0v 269.45n 0.0v 269.55n 0.0v 279.45n 0.0v 279.55n 0.0v 289.45n 0.0v 289.55n 0.0v 299.45n 0.0v 299.55n 0.0v 309.45n 0.0v 309.55n 5.0v 319.45n 5.0v 319.55n 5.0v 329.45n 5.0v 329.55n 5.0v 339.45n 5.0v 339.55n 5.0v 349.45n 5.0v 349.55n 5.0v 359.45n 5.0v 359.55n 5.0v 369.45n 5.0v 369.55n 5.0v 379.45n 5.0v 379.55n 5.0v 389.45n 5.0v 389.55n 5.0v 399.45n 5.0v 399.55n 5.0v 409.45n 5.0v 409.55n 5.0v 419.45n 5.0v 419.55n 5.0v 429.45n 5.0v 429.55n 0.0v 439.45n 0.0v 439.55n 0.0v 449.45n 0.0v 449.55n 0.0v 459.45n 0.0v 459.55n 0.0v 469.45n 0.0v 469.55n 5.0v 479.45n 5.0v 479.55n 5.0v 489.45n 5.0v 489.55n 5.0v 499.45n 5.0v 499.55n 5.0v 509.45n 5.0v 509.55n 5.0v 519.45n 5.0v 519.55n 5.0v 529.45n 5.0v 529.55n 5.0v 539.45n 5.0v 539.55n 5.0v 549.45n 5.0v 549.55n 5.0v 559.45n 5.0v 559.55n 5.0v 569.45n 5.0v 569.55n 5.0v 579.45n 5.0v 579.55n 5.0v 589.45n 5.0v 589.55n 5.0v 599.45n 5.0v 599.55n 5.0v 609.45n 5.0v 609.55n 5.0v 619.45n 5.0v 619.55n 5.0v 629.45n 5.0v 629.55n 5.0v 639.45n 5.0v 639.55n 5.0v 649.45n 5.0v 649.55n 5.0v 659.45n 5.0v 659.55n 5.0v 669.45n 5.0v 669.55n 5.0v 679.45n 5.0v 679.55n 5.0v 689.45n 5.0v 689.55n 5.0v 699.45n 5.0v 699.55n 5.0v 709.45n 5.0v 709.55n 0.0v 719.45n 0.0v 719.55n 0.0v 729.45n 0.0v 729.55n 0.0v 739.45n 0.0v 739.55n 0.0v 749.45n 0.0v 749.55n 0.0v 759.45n 0.0v 759.55n 0.0v 769.45n 0.0v 769.55n 0.0v 779.45n 0.0v 779.55n 0.0v 789.45n 0.0v 789.55n 0.0v 799.45n 0.0v 799.55n 0.0v 809.45n 0.0v 809.55n 5.0v 819.45n 5.0v 819.55n 5.0v 829.45n 5.0v 829.55n 5.0v 839.45n 5.0v 839.55n 5.0v 849.45n 5.0v 849.55n 5.0v 859.45n 5.0v 859.55n 5.0v 869.45n 5.0v 869.55n 5.0v 879.45n 5.0v 879.55n 5.0v 889.45n 5.0v 889.55n 5.0v 899.45n 5.0v 899.55n 5.0v 909.45n 5.0v 909.55n 5.0v 919.45n 5.0v 919.55n 5.0v 929.45n 5.0v 929.55n 5.0v 939.45n 5.0v 939.55n 5.0v 949.45n 5.0v 949.55n 5.0v 959.45n 5.0v 959.55n 5.0v 969.45n 5.0v 969.55n 5.0v 979.45n 5.0v 979.55n 5.0v 989.45n 5.0v 989.55n 5.0v 999.45n 5.0v 999.55n 5.0v 1009.45n 5.0v 1009.55n 5.0v 1019.45n 5.0v 1019.55n 0.0v 1029.45n 0.0v 1029.55n 0.0v 1039.45n 0.0v 1039.55n 0.0v 1049.45n 0.0v 1049.55n 0.0v 1059.45n 0.0v 1059.55n 0.0v 1069.45n 0.0v 1069.55n 0.0v 1079.45n 0.0v 1079.55n 5.0v 1089.45n 5.0v 1089.55n 5.0v 1099.45n 5.0v 1099.55n 5.0v 1109.45n 5.0v 1109.55n 5.0v 1119.45n 5.0v 1119.55n 5.0v 1129.45n 5.0v 1129.55n 5.0v 1139.45n 5.0v 1139.55n 5.0v 1149.45n 5.0v 1149.55n 5.0v 1159.45n 5.0v 1159.55n 0.0v 1169.45n 0.0v 1169.55n 0.0v 1179.45n 0.0v 1179.55n 0.0v 1189.45n 0.0v 1189.55n 0.0v 1199.45n 0.0v 1199.55n 0.0v 1209.45n 0.0v 1209.55n 0.0v 1219.45n 0.0v 1219.55n 0.0v 1229.45n 0.0v 1229.55n 0.0v 1239.45n 0.0v 1239.55n 0.0v 1249.45n 0.0v 1249.55n 0.0v 1259.45n 0.0v 1259.55n 0.0v 1269.45n 0.0v 1269.55n 0.0v 1279.45n 0.0v 1279.55n 0.0v 1289.45n 0.0v 1289.55n 5.0v 1299.45n 5.0v 1299.55n 5.0v 1309.45n 5.0v 1309.55n 5.0v 1319.45n 5.0v 1319.55n 5.0v 1329.45n 5.0v 1329.55n 5.0v 1339.45n 5.0v 1339.55n 5.0v 1349.45n 5.0v 1349.55n 5.0v 1359.45n 5.0v 1359.55n 5.0v 1369.45n 5.0v 1369.55n 5.0v 1379.45n 5.0v 1379.55n 5.0v 1389.45n 5.0v 1389.55n 5.0v 1399.45n 5.0v 1399.55n 5.0v 1409.45n 5.0v 1409.55n 5.0v 1419.45n 5.0v 1419.55n 5.0v 1429.45n 5.0v 1429.55n 5.0v 1439.45n 5.0v 1439.55n 5.0v 1449.45n 5.0v 1449.55n 5.0v 1459.45n 5.0v 1459.55n 0.0v 1469.45n 0.0v 1469.55n 5.0v 1479.45n 5.0v 1479.55n 5.0v 1489.45n 5.0v 1489.55n 5.0v 1499.45n 5.0v 1499.55n 5.0v 1509.45n 5.0v 1509.55n 5.0v 1519.45n 5.0v 1519.55n 5.0v 1529.45n 5.0v 1529.55n 5.0v 1539.45n 5.0v 1539.55n 5.0v 1549.45n 5.0v 1549.55n 5.0v 1559.45n 5.0v 1559.55n 5.0v 1569.45n 5.0v 1569.55n 5.0v 1579.45n 5.0v 1579.55n 5.0v 1589.45n 5.0v 1589.55n 5.0v 1599.45n 5.0v 1599.55n 5.0v 1609.45n 5.0v 1609.55n 0.0v 1619.45n 0.0v 1619.55n 0.0v 1629.45n 0.0v 1629.55n 0.0v 1639.45n 0.0v 1639.55n 0.0v 1649.45n 0.0v 1649.55n 0.0v 1659.45n 0.0v 1659.55n 0.0v 1669.45n 0.0v 1669.55n 0.0v 1679.45n 0.0v 1679.55n 0.0v 1689.45n 0.0v 1689.55n 0.0v 1699.45n 0.0v 1699.55n 0.0v 1709.45n 0.0v 1709.55n 0.0v 1719.45n 0.0v 1719.55n 5.0v 1729.45n 5.0v 1729.55n 5.0v 1739.45n 5.0v 1739.55n 5.0v 1749.45n 5.0v 1749.55n 5.0v 1759.45n 5.0v 1759.55n 5.0v 1769.45n 5.0v 1769.55n 0.0v 1779.45n 0.0v 1779.55n 0.0v 1789.45n 0.0v 1789.55n 0.0v 1799.45n 0.0v 1799.55n 0.0v 1809.45n 0.0v 1809.55n 0.0v 1819.45n 0.0v 1819.55n 0.0v 1829.45n 0.0v 1829.55n 0.0v 1839.45n 0.0v 1839.55n 0.0v 1849.45n 0.0v 1849.55n 0.0v 1859.45n 0.0v 1859.55n 5.0v 1869.45n 5.0v 1869.55n 5.0v 1879.45n 5.0v 1879.55n 5.0v 1889.45n 5.0v 1889.55n 5.0v 1899.45n 5.0v 1899.55n 5.0v 1909.45n 5.0v 1909.55n 5.0v 1919.45n 5.0v 1919.55n 5.0v 1929.45n 5.0v 1929.55n 5.0v 1939.45n 5.0v 1939.55n 5.0v 1949.45n 5.0v 1949.55n 5.0v 1959.45n 5.0v 1959.55n 5.0v 1969.45n 5.0v 1969.55n 0.0v 1979.45n 0.0v 1979.55n 0.0v 1989.45n 0.0v 1989.55n 0.0v 1999.45n 0.0v 1999.55n 0.0v 2009.45n 0.0v 2009.55n 5.0v 2019.45n 5.0v 2019.55n 5.0v 2029.45n 5.0v 2029.55n 5.0v 2039.45n 5.0v 2039.55n 5.0v 2049.45n 5.0v 2049.55n 5.0v )
* (time, data): [(0, 0), (10, 0), (20, 0), (30, 0), (40, 0), (50, 0), (60, 0), (70, 0), (80, 0), (90, 0), (100, 0), (110, 0), (120, 0), (130, 0), (140, 0), (150, 0), (160, 0), (170, 0), (180, 0), (190, 0), (200, 0), (210, 0), (220, 0), (230, 0), (240, 0), (250, 0), (260, 0), (270, 0), (280, 0), (290, 0), (300, 0), (310, 0), (320, 0), (330, 0), (340, 0), (350, 0), (360, 0), (370, 0), (380, 0), (390, 0), (400, 0), (410, 0), (420, 0), (430, 0), (440, 0), (450, 0), (460, 0), (470, 0), (480, 0), (490, 0), (500, 0), (510, 0), (520, 0), (530, 0), (540, 0), (550, 0), (560, 0), (570, 0), (580, 0), (590, 0), (600, 0), (610, 0), (620, 0), (630, 0), (640, 0), (650, 0), (660, 0), (670, 0), (680, 0), (690, 0), (700, 0), (710, 0), (720, 0), (730, 0), (740, 0), (750, 0), (760, 0), (770, 0), (780, 0), (790, 0), (800, 0), (810, 0), (820, 0), (830, 0), (840, 0), (850, 0), (860, 0), (870, 0), (880, 0), (890, 0), (900, 0), (910, 0), (920, 0), (930, 0), (940, 0), (950, 0), (960, 0), (970, 0), (980, 0), (990, 0), (1000, 0), (1010, 0), (1020, 0), (1030, 0), (1040, 0), (1050, 0), (1060, 0), (1070, 0), (1080, 0), (1090, 0), (1100, 0), (1110, 0), (1120, 0), (1130, 0), (1140, 0), (1150, 0), (1160, 0), (1170, 0), (1180, 0), (1190, 0), (1200, 0), (1210, 0), (1220, 0), (1230, 0), (1240, 0), (1250, 0), (1260, 0), (1270, 0), (1280, 0), (1290, 0), (1300, 0), (1310, 0), (1320, 0), (1330, 0), (1340, 0), (1350, 0), (1360, 0), (1370, 0), (1380, 0), (1390, 0), (1400, 0), (1410, 0), (1420, 0), (1430, 0), (1440, 0), (1450, 0), (1460, 0), (1470, 0), (1480, 0), (1490, 0), (1500, 0), (1510, 0), (1520, 0), (1530, 0), (1540, 0), (1550, 0), (1560, 0), (1570, 0), (1580, 0), (1590, 0), (1600, 0), (1610, 0), (1620, 0), (1630, 0), (1640, 0), (1650, 0), (1660, 0), (1670, 0), (1680, 0), (1690, 0), (1700, 0), (1710, 0), (1720, 0), (1730, 0), (1740, 0), (1750, 0), (1760, 0), (1770, 0), (1780, 0), (1790, 0), (1800, 0), (1810, 0), (1820, 0), (1830, 0), (1840, 0), (1850, 0), (1860, 0), (1870, 0), (1880, 0), (1890, 0), (1900, 0), (1910, 0), (1920, 0), (1930, 0), (1940, 0), (1950, 0), (1960, 0), (1970, 0), (1980, 0), (1990, 0), (2000, 0), (2010, 0), (2020, 0), (2030, 0), (2040, 0), (2050, 0)]
Va0_0  a0_0  0 PWL (0n 0.0v 9.45n 0.0v 9.55n 0.0v 19.45n 0.0v 19.55n 0.0v 29.45n 0.0v 29.55n 0.0v 39.45n 0.0v 39.55n 0.0v 49.45n 0.0v 49.55n 0.0v 59.45n 0.0v 59.55n 0.0v 69.45n 0.0v 69.55n 0.0v 79.45n 0.0v 79.55n 0.0v 89.45n 0.0v 89.55n 0.0v 99.45n 0.0v 99.55n 0.0v 109.45n 0.0v 109.55n 0.0v 119.45n 0.0v 119.55n 0.0v 129.45n 0.0v 129.55n 0.0v 139.45n 0.0v 139.55n 0.0v 149.45n 0.0v 149.55n 0.0v 159.45n 0.0v 159.55n 0.0v 169.45n 0.0v 169.55n 0.0v 179.45n 0.0v 179.55n 0.0v 189.45n 0.0v 189.55n 0.0v 199.45n 0.0v 199.55n 0.0v 209.45n 0.0v 209.55n 0.0v 219.45n 0.0v 219.55n 0.0v 229.45n 0.0v 229.55n 0.0v 239.45n 0.0v 239.55n 0.0v 249.45n 0.0v 249.55n 0.0v 259.45n 0.0v 259.55n 0.0v 269.45n 0.0v 269.55n 0.0v 279.45n 0.0v 279.55n 0.0v 289.45n 0.0v 289.55n 0.0v 299.45n 0.0v 299.55n 0.0v 309.45n 0.0v 309.55n 0.0v 319.45n 0.0v 319.55n 0.0v 329.45n 0.0v 329.55n 0.0v 339.45n 0.0v 339.55n 0.0v 349.45n 0.0v 349.55n 0.0v 359.45n 0.0v 359.55n 0.0v 369.45n 0.0v 369.55n 0.0v 379.45n 0.0v 379.55n 0.0v 389.45n 0.0v 389.55n 0.0v 399.45n 0.0v 399.55n 0.0v 409.45n 0.0v 409.55n 0.0v 419.45n 0.0v 419.55n 0.0v 429.45n 0.0v 429.55n 0.0v 439.45n 0.0v 439.55n 0.0v 449.45n 0.0v 449.55n 0.0v 459.45n 0.0v 459.55n 0.0v 469.45n 0.0v 469.55n 0.0v 479.45n 0.0v 479.55n 0.0v 489.45n 0.0v 489.55n 0.0v 499.45n 0.0v 499.55n 0.0v 509.45n 0.0v 509.55n 0.0v 519.45n 0.0v 519.55n 0.0v 529.45n 0.0v 529.55n 0.0v 539.45n 0.0v 539.55n 0.0v 549.45n 0.0v 549.55n 0.0v 559.45n 0.0v 559.55n 0.0v 569.45n 0.0v 569.55n 0.0v 579.45n 0.0v 579.55n 0.0v 589.45n 0.0v 589.55n 0.0v 599.45n 0.0v 599.55n 0.0v 609.45n 0.0v 609.55n 0.0v 619.45n 0.0v 619.55n 0.0v 629.45n 0.0v 629.55n 0.0v 639.45n 0.0v 639.55n 0.0v 649.45n 0.0v 649.55n 0.0v 659.45n 0.0v 659.55n 0.0v 669.45n 0.0v 669.55n 0.0v 679.45n 0.0v 679.55n 0.0v 689.45n 0.0v 689.55n 0.0v 699.45n 0.0v 699.55n 0.0v 709.45n 0.0v 709.55n 0.0v 719.45n 0.0v 719.55n 0.0v 729.45n 0.0v 729.55n 0.0v 739.45n 0.0v 739.55n 0.0v 749.45n 0.0v 749.55n 0.0v 759.45n 0.0v 759.55n 0.0v 769.45n 0.0v 769.55n 0.0v 779.45n 0.0v 779.55n 0.0v 789.45n 0.0v 789.55n 0.0v 799.45n 0.0v 799.55n 0.0v 809.45n 0.0v 809.55n 0.0v 819.45n 0.0v 819.55n 0.0v 829.45n 0.0v 829.55n 0.0v 839.45n 0.0v 839.55n 0.0v 849.45n 0.0v 849.55n 0.0v 859.45n 0.0v 859.55n 0.0v 869.45n 0.0v 869.55n 0.0v 879.45n 0.0v 879.55n 0.0v 889.45n 0.0v 889.55n 0.0v 899.45n 0.0v 899.55n 0.0v 909.45n 0.0v 909.55n 0.0v 919.45n 0.0v 919.55n 0.0v 929.45n 0.0v 929.55n 0.0v 939.45n 0.0v 939.55n 0.0v 949.45n 0.0v 949.55n 0.0v 959.45n 0.0v 959.55n 0.0v 969.45n 0.0v 969.55n 0.0v 979.45n 0.0v 979.55n 0.0v 989.45n 0.0v 989.55n 0.0v 999.45n 0.0v 999.55n 0.0v 1009.45n 0.0v 1009.55n 0.0v 1019.45n 0.0v 1019.55n 0.0v 1029.45n 0.0v 1029.55n 0.0v 1039.45n 0.0v 1039.55n 0.0v 1049.45n 0.0v 1049.55n 0.0v 1059.45n 0.0v 1059.55n 0.0v 1069.45n 0.0v 1069.55n 0.0v 1079.45n 0.0v 1079.55n 0.0v 1089.45n 0.0v 1089.55n 0.0v 1099.45n 0.0v 1099.55n 0.0v 1109.45n 0.0v 1109.55n 0.0v 1119.45n 0.0v 1119.55n 0.0v 1129.45n 0.0v 1129.55n 0.0v 1139.45n 0.0v 1139.55n 0.0v 1149.45n 0.0v 1149.55n 0.0v 1159.45n 0.0v 1159.55n 0.0v 1169.45n 0.0v 1169.55n 0.0v 1179.45n 0.0v 1179.55n 0.0v 1189.45n 0.0v 1189.55n 0.0v 1199.45n 0.0v 1199.55n 0.0v 1209.45n 0.0v 1209.55n 0.0v 1219.45n 0.0v 1219.55n 0.0v 1229.45n 0.0v 1229.55n 0.0v 1239.45n 0.0v 1239.55n 0.0v 1249.45n 0.0v 1249.55n 0.0v 1259.45n 0.0v 1259.55n 0.0v 1269.45n 0.0v 1269.55n 0.0v 1279.45n 0.0v 1279.55n 0.0v 1289.45n 0.0v 1289.55n 0.0v 1299.45n 0.0v 1299.55n 0.0v 1309.45n 0.0v 1309.55n 0.0v 1319.45n 0.0v 1319.55n 0.0v 1329.45n 0.0v 1329.55n 0.0v 1339.45n 0.0v 1339.55n 0.0v 1349.45n 0.0v 1349.55n 0.0v 1359.45n 0.0v 1359.55n 0.0v 1369.45n 0.0v 1369.55n 0.0v 1379.45n 0.0v 1379.55n 0.0v 1389.45n 0.0v 1389.55n 0.0v 1399.45n 0.0v 1399.55n 0.0v 1409.45n 0.0v 1409.55n 0.0v 1419.45n 0.0v 1419.55n 0.0v 1429.45n 0.0v 1429.55n 0.0v 1439.45n 0.0v 1439.55n 0.0v 1449.45n 0.0v 1449.55n 0.0v 1459.45n 0.0v 1459.55n 0.0v 1469.45n 0.0v 1469.55n 0.0v 1479.45n 0.0v 1479.55n 0.0v 1489.45n 0.0v 1489.55n 0.0v 1499.45n 0.0v 1499.55n 0.0v 1509.45n 0.0v 1509.55n 0.0v 1519.45n 0.0v 1519.55n 0.0v 1529.45n 0.0v 1529.55n 0.0v 1539.45n 0.0v 1539.55n 0.0v 1549.45n 0.0v 1549.55n 0.0v 1559.45n 0.0v 1559.55n 0.0v 1569.45n 0.0v 1569.55n 0.0v 1579.45n 0.0v 1579.55n 0.0v 1589.45n 0.0v 1589.55n 0.0v 1599.45n 0.0v 1599.55n 0.0v 1609.45n 0.0v 1609.55n 0.0v 1619.45n 0.0v 1619.55n 0.0v 1629.45n 0.0v 1629.55n 0.0v 1639.45n 0.0v 1639.55n 0.0v 1649.45n 0.0v 1649.55n 0.0v 1659.45n 0.0v 1659.55n 0.0v 1669.45n 0.0v 1669.55n 0.0v 1679.45n 0.0v 1679.55n 0.0v 1689.45n 0.0v 1689.55n 0.0v 1699.45n 0.0v 1699.55n 0.0v 1709.45n 0.0v 1709.55n 0.0v 1719.45n 0.0v 1719.55n 0.0v 1729.45n 0.0v 1729.55n 0.0v 1739.45n 0.0v 1739.55n 0.0v 1749.45n 0.0v 1749.55n 0.0v 1759.45n 0.0v 1759.55n 0.0v 1769.45n 0.0v 1769.55n 0.0v 1779.45n 0.0v 1779.55n 0.0v 1789.45n 0.0v 1789.55n 0.0v 1799.45n 0.0v 1799.55n 0.0v 1809.45n 0.0v 1809.55n 0.0v 1819.45n 0.0v 1819.55n 0.0v 1829.45n 0.0v 1829.55n 0.0v 1839.45n 0.0v 1839.55n 0.0v 1849.45n 0.0v 1849.55n 0.0v 1859.45n 0.0v 1859.55n 0.0v 1869.45n 0.0v 1869.55n 0.0v 1879.45n 0.0v 1879.55n 0.0v 1889.45n 0.0v 1889.55n 0.0v 1899.45n 0.0v 1899.55n 0.0v 1909.45n 0.0v 1909.55n 0.0v 1919.45n 0.0v 1919.55n 0.0v 1929.45n 0.0v 1929.55n 0.0v 1939.45n 0.0v 1939.55n 0.0v 1949.45n 0.0v 1949.55n 0.0v 1959.45n 0.0v 1959.55n 0.0v 1969.45n 0.0v 1969.55n 0.0v 1979.45n 0.0v 1979.55n 0.0v 1989.45n 0.0v 1989.55n 0.0v 1999.45n 0.0v 1999.55n 0.0v 2009.45n 0.0v 2009.55n 0.0v 2019.45n 0.0v 2019.55n 0.0v 2029.45n 0.0v 2029.55n 0.0v 2039.45n 0.0v 2039.55n 0.0v 2049.45n 0.0v 2049.55n 0.0v )
* (time, data): [(0, 0), (10, 1), (20, 1), (30, 1), (40, 1), (50, 1), (60, 1), (70, 1), (80, 1), (90, 1), (100, 1), (110, 0), (120, 1), (130, 1), (140, 1), (150, 0), (160, 0), (170, 0), (180, 0), (190, 0), (200, 0), (210, 1), (220, 0), (230, 0), (240, 0), (250, 0), (260, 0), (270, 0), (280, 0), (290, 1), (300, 0), (310, 1), (320, 0), (330, 1), (340, 1), (350, 1), (360, 0), (370, 0), (380, 0), (390, 1), (400, 1), (410, 1), (420, 1), (430, 1), (440, 0), (450, 1), (460, 1), (470, 0), (480, 1), (490, 0), (500, 0), (510, 1), (520, 0), (530, 0), (540, 1), (550, 1), (560, 1), (570, 1), (580, 1), (590, 0), (600, 1), (610, 1), (620, 0), (630, 1), (640, 1), (650, 1), (660, 0), (670, 0), (680, 0), (690, 0), (700, 0), (710, 1), (720, 1), (730, 0), (740, 0), (750, 0), (760, 1), (770, 1), (780, 1), (790, 0), (800, 1), (810, 0), (820, 0), (830, 0), (840, 1), (850, 1), (860, 0), (870, 0), (880, 0), (890, 0), (900, 1), (910, 1), (920, 1), (930, 0), (940, 0), (950, 0), (960, 0), (970, 0), (980, 0), (990, 0), (1000, 1), (1010, 1), (1020, 1), (1030, 1), (1040, 0), (1050, 0), (1060, 0), (1070, 1), (1080, 1), (1090, 1), (1100, 1), (1110, 1), (1120, 0), (1130, 0), (1140, 0), (1150, 0), (1160, 1), (1170, 0), (1180, 0), (1190, 0), (1200, 1), (1210, 0), (1220, 0), (1230, 0), (1240, 1), (1250, 0), (1260, 0), (1270, 1), (1280, 0), (1290, 1), (1300, 0), (1310, 0), (1320, 0), (1330, 0), (1340, 0), (1350, 0), (1360, 0), (1370, 0), (1380, 1), (1390, 1), (1400, 1), (1410, 1), (1420, 0), (1430, 0), (1440, 0), (1450, 0), (1460, 0), (1470, 0), (1480, 0), (1490, 1), (1500, 1), (1510, 0), (1520, 1), (1530, 1), (1540, 0), (1550, 1), (1560, 1), (1570, 1), (1580, 1), (1590, 1), (1600, 0), (1610, 1), (1620, 1), (1630, 1), (1640, 1), (1650, 1), (1660, 1), (1670, 1), (1680, 1), (1690, 1), (1700, 1), (1710, 1), (1720, 0), (1730, 1), (1740, 1), (1750, 1), (1760, 1), (1770, 1), (1780, 1), (1790, 0), (1800, 1), (1810, 0), (1820, 0), (1830, 1), (1840, 1), (1850, 1), (1860, 1), (1870, 0), (1880, 0), (1890, 1), (1900, 1), (1910, 1), (1920, 1), (1930, 1), (1940, 0), (1950, 1), (1960, 0), (1970, 0), (1980, 1), (1990, 0), (2000, 1), (2010, 0), (2020, 0), (2030, 1), (2040, 1), (2050, 1)]
Va0_1  a0_1  0 PWL (0n 0.0v 9.45n 0.0v 9.55n 5.0v 19.45n 5.0v 19.55n 5.0v 29.45n 5.0v 29.55n 5.0v 39.45n 5.0v 39.55n 5.0v 49.45n 5.0v 49.55n 5.0v 59.45n 5.0v 59.55n 5.0v 69.45n 5.0v 69.55n 5.0v 79.45n 5.0v 79.55n 5.0v 89.45n 5.0v 89.55n 5.0v 99.45n 5.0v 99.55n 5.0v 109.45n 5.0v 109.55n 0.0v 119.45n 0.0v 119.55n 5.0v 129.45n 5.0v 129.55n 5.0v 139.45n 5.0v 139.55n 5.0v 149.45n 5.0v 149.55n 0.0v 159.45n 0.0v 159.55n 0.0v 169.45n 0.0v 169.55n 0.0v 179.45n 0.0v 179.55n 0.0v 189.45n 0.0v 189.55n 0.0v 199.45n 0.0v 199.55n 0.0v 209.45n 0.0v 209.55n 5.0v 219.45n 5.0v 219.55n 0.0v 229.45n 0.0v 229.55n 0.0v 239.45n 0.0v 239.55n 0.0v 249.45n 0.0v 249.55n 0.0v 259.45n 0.0v 259.55n 0.0v 269.45n 0.0v 269.55n 0.0v 279.45n 0.0v 279.55n 0.0v 289.45n 0.0v 289.55n 5.0v 299.45n 5.0v 299.55n 0.0v 309.45n 0.0v 309.55n 5.0v 319.45n 5.0v 319.55n 0.0v 329.45n 0.0v 329.55n 5.0v 339.45n 5.0v 339.55n 5.0v 349.45n 5.0v 349.55n 5.0v 359.45n 5.0v 359.55n 0.0v 369.45n 0.0v 369.55n 0.0v 379.45n 0.0v 379.55n 0.0v 389.45n 0.0v 389.55n 5.0v 399.45n 5.0v 399.55n 5.0v 409.45n 5.0v 409.55n 5.0v 419.45n 5.0v 419.55n 5.0v 429.45n 5.0v 429.55n 5.0v 439.45n 5.0v 439.55n 0.0v 449.45n 0.0v 449.55n 5.0v 459.45n 5.0v 459.55n 5.0v 469.45n 5.0v 469.55n 0.0v 479.45n 0.0v 479.55n 5.0v 489.45n 5.0v 489.55n 0.0v 499.45n 0.0v 499.55n 0.0v 509.45n 0.0v 509.55n 5.0v 519.45n 5.0v 519.55n 0.0v 529.45n 0.0v 529.55n 0.0v 539.45n 0.0v 539.55n 5.0v 549.45n 5.0v 549.55n 5.0v 559.45n 5.0v 559.55n 5.0v 569.45n 5.0v 569.55n 5.0v 579.45n 5.0v 579.55n 5.0v 589.45n 5.0v 589.55n 0.0v 599.45n 0.0v 599.55n 5.0v 609.45n 5.0v 609.55n 5.0v 619.45n 5.0v 619.55n 0.0v 629.45n 0.0v 629.55n 5.0v 639.45n 5.0v 639.55n 5.0v 649.45n 5.0v 649.55n 5.0v 659.45n 5.0v 659.55n 0.0v 669.45n 0.0v 669.55n 0.0v 679.45n 0.0v 679.55n 0.0v 689.45n 0.0v 689.55n 0.0v 699.45n 0.0v 699.55n 0.0v 709.45n 0.0v 709.55n 5.0v 719.45n 5.0v 719.55n 5.0v 729.45n 5.0v 729.55n 0.0v 739.45n 0.0v 739.55n 0.0v 749.45n 0.0v 749.55n 0.0v 759.45n 0.0v 759.55n 5.0v 769.45n 5.0v 769.55n 5.0v 779.45n 5.0v 779.55n 5.0v 789.45n 5.0v 789.55n 0.0v 799.45n 0.0v 799.55n 5.0v 809.45n 5.0v 809.55n 0.0v 819.45n 0.0v 819.55n 0.0v 829.45n 0.0v 829.55n 0.0v 839.45n 0.0v 839.55n 5.0v 849.45n 5.0v 849.55n 5.0v 859.45n 5.0v 859.55n 0.0v 869.45n 0.0v 869.55n 0.0v 879.45n 0.0v 879.55n 0.0v 889.45n 0.0v 889.55n 0.0v 899.45n 0.0v 899.55n 5.0v 909.45n 5.0v 909.55n 5.0v 919.45n 5.0v 919.55n 5.0v 929.45n 5.0v 929.55n 0.0v 939.45n 0.0v 939.55n 0.0v 949.45n 0.0v 949.55n 0.0v 959.45n 0.0v 959.55n 0.0v 969.45n 0.0v 969.55n 0.0v 979.45n 0.0v 979.55n 0.0v 989.45n 0.0v 989.55n 0.0v 999.45n 0.0v 999.55n 5.0v 1009.45n 5.0v 1009.55n 5.0v 1019.45n 5.0v 1019.55n 5.0v 1029.45n 5.0v 1029.55n 5.0v 1039.45n 5.0v 1039.55n 0.0v 1049.45n 0.0v 1049.55n 0.0v 1059.45n 0.0v 1059.55n 0.0v 1069.45n 0.0v 1069.55n 5.0v 1079.45n 5.0v 1079.55n 5.0v 1089.45n 5.0v 1089.55n 5.0v 1099.45n 5.0v 1099.55n 5.0v 1109.45n 5.0v 1109.55n 5.0v 1119.45n 5.0v 1119.55n 0.0v 1129.45n 0.0v 1129.55n 0.0v 1139.45n 0.0v 1139.55n 0.0v 1149.45n 0.0v 1149.55n 0.0v 1159.45n 0.0v 1159.55n 5.0v 1169.45n 5.0v 1169.55n 0.0v 1179.45n 0.0v 1179.55n 0.0v 1189.45n 0.0v 1189.55n 0.0v 1199.45n 0.0v 1199.55n 5.0v 1209.45n 5.0v 1209.55n 0.0v 1219.45n 0.0v 1219.55n 0.0v 1229.45n 0.0v 1229.55n 0.0v 1239.45n 0.0v 1239.55n 5.0v 1249.45n 5.0v 1249.55n 0.0v 1259.45n 0.0v 1259.55n 0.0v 1269.45n 0.0v 1269.55n 5.0v 1279.45n 5.0v 1279.55n 0.0v 1289.45n 0.0v 1289.55n 5.0v 1299.45n 5.0v 1299.55n 0.0v 1309.45n 0.0v 1309.55n 0.0v 1319.45n 0.0v 1319.55n 0.0v 1329.45n 0.0v 1329.55n 0.0v 1339.45n 0.0v 1339.55n 0.0v 1349.45n 0.0v 1349.55n 0.0v 1359.45n 0.0v 1359.55n 0.0v 1369.45n 0.0v 1369.55n 0.0v 1379.45n 0.0v 1379.55n 5.0v 1389.45n 5.0v 1389.55n 5.0v 1399.45n 5.0v 1399.55n 5.0v 1409.45n 5.0v 1409.55n 5.0v 1419.45n 5.0v 1419.55n 0.0v 1429.45n 0.0v 1429.55n 0.0v 1439.45n 0.0v 1439.55n 0.0v 1449.45n 0.0v 1449.55n 0.0v 1459.45n 0.0v 1459.55n 0.0v 1469.45n 0.0v 1469.55n 0.0v 1479.45n 0.0v 1479.55n 0.0v 1489.45n 0.0v 1489.55n 5.0v 1499.45n 5.0v 1499.55n 5.0v 1509.45n 5.0v 1509.55n 0.0v 1519.45n 0.0v 1519.55n 5.0v 1529.45n 5.0v 1529.55n 5.0v 1539.45n 5.0v 1539.55n 0.0v 1549.45n 0.0v 1549.55n 5.0v 1559.45n 5.0v 1559.55n 5.0v 1569.45n 5.0v 1569.55n 5.0v 1579.45n 5.0v 1579.55n 5.0v 1589.45n 5.0v 1589.55n 5.0v 1599.45n 5.0v 1599.55n 0.0v 1609.45n 0.0v 1609.55n 5.0v 1619.45n 5.0v 1619.55n 5.0v 1629.45n 5.0v 1629.55n 5.0v 1639.45n 5.0v 1639.55n 5.0v 1649.45n 5.0v 1649.55n 5.0v 1659.45n 5.0v 1659.55n 5.0v 1669.45n 5.0v 1669.55n 5.0v 1679.45n 5.0v 1679.55n 5.0v 1689.45n 5.0v 1689.55n 5.0v 1699.45n 5.0v 1699.55n 5.0v 1709.45n 5.0v 1709.55n 5.0v 1719.45n 5.0v 1719.55n 0.0v 1729.45n 0.0v 1729.55n 5.0v 1739.45n 5.0v 1739.55n 5.0v 1749.45n 5.0v 1749.55n 5.0v 1759.45n 5.0v 1759.55n 5.0v 1769.45n 5.0v 1769.55n 5.0v 1779.45n 5.0v 1779.55n 5.0v 1789.45n 5.0v 1789.55n 0.0v 1799.45n 0.0v 1799.55n 5.0v 1809.45n 5.0v 1809.55n 0.0v 1819.45n 0.0v 1819.55n 0.0v 1829.45n 0.0v 1829.55n 5.0v 1839.45n 5.0v 1839.55n 5.0v 1849.45n 5.0v 1849.55n 5.0v 1859.45n 5.0v 1859.55n 5.0v 1869.45n 5.0v 1869.55n 0.0v 1879.45n 0.0v 1879.55n 0.0v 1889.45n 0.0v 1889.55n 5.0v 1899.45n 5.0v 1899.55n 5.0v 1909.45n 5.0v 1909.55n 5.0v 1919.45n 5.0v 1919.55n 5.0v 1929.45n 5.0v 1929.55n 5.0v 1939.45n 5.0v 1939.55n 0.0v 1949.45n 0.0v 1949.55n 5.0v 1959.45n 5.0v 1959.55n 0.0v 1969.45n 0.0v 1969.55n 0.0v 1979.45n 0.0v 1979.55n 5.0v 1989.45n 5.0v 1989.55n 0.0v 1999.45n 0.0v 1999.55n 5.0v 2009.45n 5.0v 2009.55n 0.0v 2019.45n 0.0v 2019.55n 0.0v 2029.45n 0.0v 2029.55n 5.0v 2039.45n 5.0v 2039.55n 5.0v 2049.45n 5.0v 2049.55n 5.0v )
* (time, data): [(0, 0), (10, 1), (20, 1), (30, 1), (40, 1), (50, 1), (60, 1), (70, 1), (80, 1), (90, 1), (100, 1), (110, 0), (120, 1), (130, 1), (140, 1), (150, 0), (160, 0), (170, 0), (180, 0), (190, 0), (200, 0), (210, 1), (220, 0), (230, 0), (240, 0), (250, 0), (260, 0), (270, 0), (280, 0), (290, 1), (300, 0), (310, 1), (320, 0), (330, 1), (340, 1), (350, 1), (360, 0), (370, 0), (380, 0), (390, 1), (400, 1), (410, 1), (420, 1), (430, 1), (440, 0), (450, 1), (460, 1), (470, 0), (480, 1), (490, 0), (500, 0), (510, 1), (520, 0), (530, 0), (540, 1), (550, 1), (560, 1), (570, 1), (580, 1), (590, 0), (600, 1), (610, 1), (620, 0), (630, 1), (640, 1), (650, 1), (660, 0), (670, 0), (680, 0), (690, 0), (700, 0), (710, 1), (720, 1), (730, 0), (740, 0), (750, 0), (760, 1), (770, 1), (780, 1), (790, 0), (800, 1), (810, 0), (820, 0), (830, 0), (840, 1), (850, 1), (860, 0), (870, 0), (880, 0), (890, 0), (900, 1), (910, 1), (920, 1), (930, 0), (940, 0), (950, 0), (960, 0), (970, 0), (980, 0), (990, 0), (1000, 1), (1010, 1), (1020, 1), (1030, 1), (1040, 0), (1050, 0), (1060, 0), (1070, 1), (1080, 1), (1090, 1), (1100, 1), (1110, 1), (1120, 0), (1130, 0), (1140, 0), (1150, 0), (1160, 1), (1170, 0), (1180, 0), (1190, 0), (1200, 1), (1210, 0), (1220, 0), (1230, 0), (1240, 1), (1250, 0), (1260, 0), (1270, 1), (1280, 0), (1290, 1), (1300, 0), (1310, 0), (1320, 0), (1330, 0), (1340, 0), (1350, 0), (1360, 0), (1370, 0), (1380, 1), (1390, 1), (1400, 1), (1410, 1), (1420, 0), (1430, 0), (1440, 0), (1450, 0), (1460, 0), (1470, 0), (1480, 0), (1490, 1), (1500, 1), (1510, 0), (1520, 1), (1530, 1), (1540, 0), (1550, 1), (1560, 1), (1570, 1), (1580, 1), (1590, 1), (1600, 0), (1610, 1), (1620, 1), (1630, 1), (1640, 1), (1650, 1), (1660, 1), (1670, 1), (1680, 1), (1690, 1), (1700, 1), (1710, 1), (1720, 0), (1730, 1), (1740, 1), (1750, 1), (1760, 1), (1770, 1), (1780, 1), (1790, 0), (1800, 1), (1810, 0), (1820, 0), (1830, 1), (1840, 1), (1850, 1), (1860, 1), (1870, 0), (1880, 0), (1890, 1), (1900, 1), (1910, 1), (1920, 1), (1930, 1), (1940, 0), (1950, 1), (1960, 0), (1970, 0), (1980, 1), (1990, 0), (2000, 1), (2010, 0), (2020, 0), (2030, 1), (2040, 1), (2050, 1)]
Va0_2  a0_2  0 PWL (0n 0.0v 9.45n 0.0v 9.55n 5.0v 19.45n 5.0v 19.55n 5.0v 29.45n 5.0v 29.55n 5.0v 39.45n 5.0v 39.55n 5.0v 49.45n 5.0v 49.55n 5.0v 59.45n 5.0v 59.55n 5.0v 69.45n 5.0v 69.55n 5.0v 79.45n 5.0v 79.55n 5.0v 89.45n 5.0v 89.55n 5.0v 99.45n 5.0v 99.55n 5.0v 109.45n 5.0v 109.55n 0.0v 119.45n 0.0v 119.55n 5.0v 129.45n 5.0v 129.55n 5.0v 139.45n 5.0v 139.55n 5.0v 149.45n 5.0v 149.55n 0.0v 159.45n 0.0v 159.55n 0.0v 169.45n 0.0v 169.55n 0.0v 179.45n 0.0v 179.55n 0.0v 189.45n 0.0v 189.55n 0.0v 199.45n 0.0v 199.55n 0.0v 209.45n 0.0v 209.55n 5.0v 219.45n 5.0v 219.55n 0.0v 229.45n 0.0v 229.55n 0.0v 239.45n 0.0v 239.55n 0.0v 249.45n 0.0v 249.55n 0.0v 259.45n 0.0v 259.55n 0.0v 269.45n 0.0v 269.55n 0.0v 279.45n 0.0v 279.55n 0.0v 289.45n 0.0v 289.55n 5.0v 299.45n 5.0v 299.55n 0.0v 309.45n 0.0v 309.55n 5.0v 319.45n 5.0v 319.55n 0.0v 329.45n 0.0v 329.55n 5.0v 339.45n 5.0v 339.55n 5.0v 349.45n 5.0v 349.55n 5.0v 359.45n 5.0v 359.55n 0.0v 369.45n 0.0v 369.55n 0.0v 379.45n 0.0v 379.55n 0.0v 389.45n 0.0v 389.55n 5.0v 399.45n 5.0v 399.55n 5.0v 409.45n 5.0v 409.55n 5.0v 419.45n 5.0v 419.55n 5.0v 429.45n 5.0v 429.55n 5.0v 439.45n 5.0v 439.55n 0.0v 449.45n 0.0v 449.55n 5.0v 459.45n 5.0v 459.55n 5.0v 469.45n 5.0v 469.55n 0.0v 479.45n 0.0v 479.55n 5.0v 489.45n 5.0v 489.55n 0.0v 499.45n 0.0v 499.55n 0.0v 509.45n 0.0v 509.55n 5.0v 519.45n 5.0v 519.55n 0.0v 529.45n 0.0v 529.55n 0.0v 539.45n 0.0v 539.55n 5.0v 549.45n 5.0v 549.55n 5.0v 559.45n 5.0v 559.55n 5.0v 569.45n 5.0v 569.55n 5.0v 579.45n 5.0v 579.55n 5.0v 589.45n 5.0v 589.55n 0.0v 599.45n 0.0v 599.55n 5.0v 609.45n 5.0v 609.55n 5.0v 619.45n 5.0v 619.55n 0.0v 629.45n 0.0v 629.55n 5.0v 639.45n 5.0v 639.55n 5.0v 649.45n 5.0v 649.55n 5.0v 659.45n 5.0v 659.55n 0.0v 669.45n 0.0v 669.55n 0.0v 679.45n 0.0v 679.55n 0.0v 689.45n 0.0v 689.55n 0.0v 699.45n 0.0v 699.55n 0.0v 709.45n 0.0v 709.55n 5.0v 719.45n 5.0v 719.55n 5.0v 729.45n 5.0v 729.55n 0.0v 739.45n 0.0v 739.55n 0.0v 749.45n 0.0v 749.55n 0.0v 759.45n 0.0v 759.55n 5.0v 769.45n 5.0v 769.55n 5.0v 779.45n 5.0v 779.55n 5.0v 789.45n 5.0v 789.55n 0.0v 799.45n 0.0v 799.55n 5.0v 809.45n 5.0v 809.55n 0.0v 819.45n 0.0v 819.55n 0.0v 829.45n 0.0v 829.55n 0.0v 839.45n 0.0v 839.55n 5.0v 849.45n 5.0v 849.55n 5.0v 859.45n 5.0v 859.55n 0.0v 869.45n 0.0v 869.55n 0.0v 879.45n 0.0v 879.55n 0.0v 889.45n 0.0v 889.55n 0.0v 899.45n 0.0v 899.55n 5.0v 909.45n 5.0v 909.55n 5.0v 919.45n 5.0v 919.55n 5.0v 929.45n 5.0v 929.55n 0.0v 939.45n 0.0v 939.55n 0.0v 949.45n 0.0v 949.55n 0.0v 959.45n 0.0v 959.55n 0.0v 969.45n 0.0v 969.55n 0.0v 979.45n 0.0v 979.55n 0.0v 989.45n 0.0v 989.55n 0.0v 999.45n 0.0v 999.55n 5.0v 1009.45n 5.0v 1009.55n 5.0v 1019.45n 5.0v 1019.55n 5.0v 1029.45n 5.0v 1029.55n 5.0v 1039.45n 5.0v 1039.55n 0.0v 1049.45n 0.0v 1049.55n 0.0v 1059.45n 0.0v 1059.55n 0.0v 1069.45n 0.0v 1069.55n 5.0v 1079.45n 5.0v 1079.55n 5.0v 1089.45n 5.0v 1089.55n 5.0v 1099.45n 5.0v 1099.55n 5.0v 1109.45n 5.0v 1109.55n 5.0v 1119.45n 5.0v 1119.55n 0.0v 1129.45n 0.0v 1129.55n 0.0v 1139.45n 0.0v 1139.55n 0.0v 1149.45n 0.0v 1149.55n 0.0v 1159.45n 0.0v 1159.55n 5.0v 1169.45n 5.0v 1169.55n 0.0v 1179.45n 0.0v 1179.55n 0.0v 1189.45n 0.0v 1189.55n 0.0v 1199.45n 0.0v 1199.55n 5.0v 1209.45n 5.0v 1209.55n 0.0v 1219.45n 0.0v 1219.55n 0.0v 1229.45n 0.0v 1229.55n 0.0v 1239.45n 0.0v 1239.55n 5.0v 1249.45n 5.0v 1249.55n 0.0v 1259.45n 0.0v 1259.55n 0.0v 1269.45n 0.0v 1269.55n 5.0v 1279.45n 5.0v 1279.55n 0.0v 1289.45n 0.0v 1289.55n 5.0v 1299.45n 5.0v 1299.55n 0.0v 1309.45n 0.0v 1309.55n 0.0v 1319.45n 0.0v 1319.55n 0.0v 1329.45n 0.0v 1329.55n 0.0v 1339.45n 0.0v 1339.55n 0.0v 1349.45n 0.0v 1349.55n 0.0v 1359.45n 0.0v 1359.55n 0.0v 1369.45n 0.0v 1369.55n 0.0v 1379.45n 0.0v 1379.55n 5.0v 1389.45n 5.0v 1389.55n 5.0v 1399.45n 5.0v 1399.55n 5.0v 1409.45n 5.0v 1409.55n 5.0v 1419.45n 5.0v 1419.55n 0.0v 1429.45n 0.0v 1429.55n 0.0v 1439.45n 0.0v 1439.55n 0.0v 1449.45n 0.0v 1449.55n 0.0v 1459.45n 0.0v 1459.55n 0.0v 1469.45n 0.0v 1469.55n 0.0v 1479.45n 0.0v 1479.55n 0.0v 1489.45n 0.0v 1489.55n 5.0v 1499.45n 5.0v 1499.55n 5.0v 1509.45n 5.0v 1509.55n 0.0v 1519.45n 0.0v 1519.55n 5.0v 1529.45n 5.0v 1529.55n 5.0v 1539.45n 5.0v 1539.55n 0.0v 1549.45n 0.0v 1549.55n 5.0v 1559.45n 5.0v 1559.55n 5.0v 1569.45n 5.0v 1569.55n 5.0v 1579.45n 5.0v 1579.55n 5.0v 1589.45n 5.0v 1589.55n 5.0v 1599.45n 5.0v 1599.55n 0.0v 1609.45n 0.0v 1609.55n 5.0v 1619.45n 5.0v 1619.55n 5.0v 1629.45n 5.0v 1629.55n 5.0v 1639.45n 5.0v 1639.55n 5.0v 1649.45n 5.0v 1649.55n 5.0v 1659.45n 5.0v 1659.55n 5.0v 1669.45n 5.0v 1669.55n 5.0v 1679.45n 5.0v 1679.55n 5.0v 1689.45n 5.0v 1689.55n 5.0v 1699.45n 5.0v 1699.55n 5.0v 1709.45n 5.0v 1709.55n 5.0v 1719.45n 5.0v 1719.55n 0.0v 1729.45n 0.0v 1729.55n 5.0v 1739.45n 5.0v 1739.55n 5.0v 1749.45n 5.0v 1749.55n 5.0v 1759.45n 5.0v 1759.55n 5.0v 1769.45n 5.0v 1769.55n 5.0v 1779.45n 5.0v 1779.55n 5.0v 1789.45n 5.0v 1789.55n 0.0v 1799.45n 0.0v 1799.55n 5.0v 1809.45n 5.0v 1809.55n 0.0v 1819.45n 0.0v 1819.55n 0.0v 1829.45n 0.0v 1829.55n 5.0v 1839.45n 5.0v 1839.55n 5.0v 1849.45n 5.0v 1849.55n 5.0v 1859.45n 5.0v 1859.55n 5.0v 1869.45n 5.0v 1869.55n 0.0v 1879.45n 0.0v 1879.55n 0.0v 1889.45n 0.0v 1889.55n 5.0v 1899.45n 5.0v 1899.55n 5.0v 1909.45n 5.0v 1909.55n 5.0v 1919.45n 5.0v 1919.55n 5.0v 1929.45n 5.0v 1929.55n 5.0v 1939.45n 5.0v 1939.55n 0.0v 1949.45n 0.0v 1949.55n 5.0v 1959.45n 5.0v 1959.55n 0.0v 1969.45n 0.0v 1969.55n 0.0v 1979.45n 0.0v 1979.55n 5.0v 1989.45n 5.0v 1989.55n 0.0v 1999.45n 0.0v 1999.55n 5.0v 2009.45n 5.0v 2009.55n 0.0v 2019.45n 0.0v 2019.55n 0.0v 2029.45n 0.0v 2029.55n 5.0v 2039.45n 5.0v 2039.55n 5.0v 2049.45n 5.0v 2049.55n 5.0v )
* (time, data): [(0, 0), (10, 1), (20, 1), (30, 1), (40, 1), (50, 1), (60, 1), (70, 1), (80, 1), (90, 1), (100, 1), (110, 0), (120, 1), (130, 1), (140, 1), (150, 0), (160, 0), (170, 0), (180, 0), (190, 0), (200, 0), (210, 1), (220, 0), (230, 0), (240, 0), (250, 0), (260, 0), (270, 0), (280, 0), (290, 1), (300, 0), (310, 1), (320, 0), (330, 1), (340, 1), (350, 1), (360, 0), (370, 0), (380, 0), (390, 1), (400, 1), (410, 1), (420, 1), (430, 1), (440, 0), (450, 1), (460, 1), (470, 0), (480, 1), (490, 0), (500, 0), (510, 1), (520, 0), (530, 0), (540, 1), (550, 1), (560, 1), (570, 1), (580, 1), (590, 0), (600, 1), (610, 1), (620, 0), (630, 1), (640, 1), (650, 1), (660, 0), (670, 0), (680, 0), (690, 0), (700, 0), (710, 1), (720, 1), (730, 0), (740, 0), (750, 0), (760, 1), (770, 1), (780, 1), (790, 0), (800, 1), (810, 0), (820, 0), (830, 0), (840, 1), (850, 1), (860, 0), (870, 0), (880, 0), (890, 0), (900, 1), (910, 1), (920, 1), (930, 0), (940, 0), (950, 0), (960, 0), (970, 0), (980, 0), (990, 0), (1000, 1), (1010, 1), (1020, 1), (1030, 1), (1040, 0), (1050, 0), (1060, 0), (1070, 1), (1080, 1), (1090, 1), (1100, 1), (1110, 1), (1120, 0), (1130, 0), (1140, 0), (1150, 0), (1160, 1), (1170, 0), (1180, 0), (1190, 0), (1200, 1), (1210, 0), (1220, 0), (1230, 0), (1240, 1), (1250, 0), (1260, 0), (1270, 1), (1280, 0), (1290, 1), (1300, 0), (1310, 0), (1320, 0), (1330, 0), (1340, 0), (1350, 0), (1360, 0), (1370, 0), (1380, 1), (1390, 1), (1400, 1), (1410, 1), (1420, 0), (1430, 0), (1440, 0), (1450, 0), (1460, 0), (1470, 0), (1480, 0), (1490, 1), (1500, 1), (1510, 0), (1520, 1), (1530, 1), (1540, 0), (1550, 1), (1560, 1), (1570, 1), (1580, 1), (1590, 1), (1600, 0), (1610, 1), (1620, 1), (1630, 1), (1640, 1), (1650, 1), (1660, 1), (1670, 1), (1680, 1), (1690, 1), (1700, 1), (1710, 1), (1720, 0), (1730, 1), (1740, 1), (1750, 1), (1760, 1), (1770, 1), (1780, 1), (1790, 0), (1800, 1), (1810, 0), (1820, 0), (1830, 1), (1840, 1), (1850, 1), (1860, 1), (1870, 0), (1880, 0), (1890, 1), (1900, 1), (1910, 1), (1920, 1), (1930, 1), (1940, 0), (1950, 1), (1960, 0), (1970, 0), (1980, 1), (1990, 0), (2000, 1), (2010, 0), (2020, 0), (2030, 1), (2040, 1), (2050, 1)]
Va0_3  a0_3  0 PWL (0n 0.0v 9.45n 0.0v 9.55n 5.0v 19.45n 5.0v 19.55n 5.0v 29.45n 5.0v 29.55n 5.0v 39.45n 5.0v 39.55n 5.0v 49.45n 5.0v 49.55n 5.0v 59.45n 5.0v 59.55n 5.0v 69.45n 5.0v 69.55n 5.0v 79.45n 5.0v 79.55n 5.0v 89.45n 5.0v 89.55n 5.0v 99.45n 5.0v 99.55n 5.0v 109.45n 5.0v 109.55n 0.0v 119.45n 0.0v 119.55n 5.0v 129.45n 5.0v 129.55n 5.0v 139.45n 5.0v 139.55n 5.0v 149.45n 5.0v 149.55n 0.0v 159.45n 0.0v 159.55n 0.0v 169.45n 0.0v 169.55n 0.0v 179.45n 0.0v 179.55n 0.0v 189.45n 0.0v 189.55n 0.0v 199.45n 0.0v 199.55n 0.0v 209.45n 0.0v 209.55n 5.0v 219.45n 5.0v 219.55n 0.0v 229.45n 0.0v 229.55n 0.0v 239.45n 0.0v 239.55n 0.0v 249.45n 0.0v 249.55n 0.0v 259.45n 0.0v 259.55n 0.0v 269.45n 0.0v 269.55n 0.0v 279.45n 0.0v 279.55n 0.0v 289.45n 0.0v 289.55n 5.0v 299.45n 5.0v 299.55n 0.0v 309.45n 0.0v 309.55n 5.0v 319.45n 5.0v 319.55n 0.0v 329.45n 0.0v 329.55n 5.0v 339.45n 5.0v 339.55n 5.0v 349.45n 5.0v 349.55n 5.0v 359.45n 5.0v 359.55n 0.0v 369.45n 0.0v 369.55n 0.0v 379.45n 0.0v 379.55n 0.0v 389.45n 0.0v 389.55n 5.0v 399.45n 5.0v 399.55n 5.0v 409.45n 5.0v 409.55n 5.0v 419.45n 5.0v 419.55n 5.0v 429.45n 5.0v 429.55n 5.0v 439.45n 5.0v 439.55n 0.0v 449.45n 0.0v 449.55n 5.0v 459.45n 5.0v 459.55n 5.0v 469.45n 5.0v 469.55n 0.0v 479.45n 0.0v 479.55n 5.0v 489.45n 5.0v 489.55n 0.0v 499.45n 0.0v 499.55n 0.0v 509.45n 0.0v 509.55n 5.0v 519.45n 5.0v 519.55n 0.0v 529.45n 0.0v 529.55n 0.0v 539.45n 0.0v 539.55n 5.0v 549.45n 5.0v 549.55n 5.0v 559.45n 5.0v 559.55n 5.0v 569.45n 5.0v 569.55n 5.0v 579.45n 5.0v 579.55n 5.0v 589.45n 5.0v 589.55n 0.0v 599.45n 0.0v 599.55n 5.0v 609.45n 5.0v 609.55n 5.0v 619.45n 5.0v 619.55n 0.0v 629.45n 0.0v 629.55n 5.0v 639.45n 5.0v 639.55n 5.0v 649.45n 5.0v 649.55n 5.0v 659.45n 5.0v 659.55n 0.0v 669.45n 0.0v 669.55n 0.0v 679.45n 0.0v 679.55n 0.0v 689.45n 0.0v 689.55n 0.0v 699.45n 0.0v 699.55n 0.0v 709.45n 0.0v 709.55n 5.0v 719.45n 5.0v 719.55n 5.0v 729.45n 5.0v 729.55n 0.0v 739.45n 0.0v 739.55n 0.0v 749.45n 0.0v 749.55n 0.0v 759.45n 0.0v 759.55n 5.0v 769.45n 5.0v 769.55n 5.0v 779.45n 5.0v 779.55n 5.0v 789.45n 5.0v 789.55n 0.0v 799.45n 0.0v 799.55n 5.0v 809.45n 5.0v 809.55n 0.0v 819.45n 0.0v 819.55n 0.0v 829.45n 0.0v 829.55n 0.0v 839.45n 0.0v 839.55n 5.0v 849.45n 5.0v 849.55n 5.0v 859.45n 5.0v 859.55n 0.0v 869.45n 0.0v 869.55n 0.0v 879.45n 0.0v 879.55n 0.0v 889.45n 0.0v 889.55n 0.0v 899.45n 0.0v 899.55n 5.0v 909.45n 5.0v 909.55n 5.0v 919.45n 5.0v 919.55n 5.0v 929.45n 5.0v 929.55n 0.0v 939.45n 0.0v 939.55n 0.0v 949.45n 0.0v 949.55n 0.0v 959.45n 0.0v 959.55n 0.0v 969.45n 0.0v 969.55n 0.0v 979.45n 0.0v 979.55n 0.0v 989.45n 0.0v 989.55n 0.0v 999.45n 0.0v 999.55n 5.0v 1009.45n 5.0v 1009.55n 5.0v 1019.45n 5.0v 1019.55n 5.0v 1029.45n 5.0v 1029.55n 5.0v 1039.45n 5.0v 1039.55n 0.0v 1049.45n 0.0v 1049.55n 0.0v 1059.45n 0.0v 1059.55n 0.0v 1069.45n 0.0v 1069.55n 5.0v 1079.45n 5.0v 1079.55n 5.0v 1089.45n 5.0v 1089.55n 5.0v 1099.45n 5.0v 1099.55n 5.0v 1109.45n 5.0v 1109.55n 5.0v 1119.45n 5.0v 1119.55n 0.0v 1129.45n 0.0v 1129.55n 0.0v 1139.45n 0.0v 1139.55n 0.0v 1149.45n 0.0v 1149.55n 0.0v 1159.45n 0.0v 1159.55n 5.0v 1169.45n 5.0v 1169.55n 0.0v 1179.45n 0.0v 1179.55n 0.0v 1189.45n 0.0v 1189.55n 0.0v 1199.45n 0.0v 1199.55n 5.0v 1209.45n 5.0v 1209.55n 0.0v 1219.45n 0.0v 1219.55n 0.0v 1229.45n 0.0v 1229.55n 0.0v 1239.45n 0.0v 1239.55n 5.0v 1249.45n 5.0v 1249.55n 0.0v 1259.45n 0.0v 1259.55n 0.0v 1269.45n 0.0v 1269.55n 5.0v 1279.45n 5.0v 1279.55n 0.0v 1289.45n 0.0v 1289.55n 5.0v 1299.45n 5.0v 1299.55n 0.0v 1309.45n 0.0v 1309.55n 0.0v 1319.45n 0.0v 1319.55n 0.0v 1329.45n 0.0v 1329.55n 0.0v 1339.45n 0.0v 1339.55n 0.0v 1349.45n 0.0v 1349.55n 0.0v 1359.45n 0.0v 1359.55n 0.0v 1369.45n 0.0v 1369.55n 0.0v 1379.45n 0.0v 1379.55n 5.0v 1389.45n 5.0v 1389.55n 5.0v 1399.45n 5.0v 1399.55n 5.0v 1409.45n 5.0v 1409.55n 5.0v 1419.45n 5.0v 1419.55n 0.0v 1429.45n 0.0v 1429.55n 0.0v 1439.45n 0.0v 1439.55n 0.0v 1449.45n 0.0v 1449.55n 0.0v 1459.45n 0.0v 1459.55n 0.0v 1469.45n 0.0v 1469.55n 0.0v 1479.45n 0.0v 1479.55n 0.0v 1489.45n 0.0v 1489.55n 5.0v 1499.45n 5.0v 1499.55n 5.0v 1509.45n 5.0v 1509.55n 0.0v 1519.45n 0.0v 1519.55n 5.0v 1529.45n 5.0v 1529.55n 5.0v 1539.45n 5.0v 1539.55n 0.0v 1549.45n 0.0v 1549.55n 5.0v 1559.45n 5.0v 1559.55n 5.0v 1569.45n 5.0v 1569.55n 5.0v 1579.45n 5.0v 1579.55n 5.0v 1589.45n 5.0v 1589.55n 5.0v 1599.45n 5.0v 1599.55n 0.0v 1609.45n 0.0v 1609.55n 5.0v 1619.45n 5.0v 1619.55n 5.0v 1629.45n 5.0v 1629.55n 5.0v 1639.45n 5.0v 1639.55n 5.0v 1649.45n 5.0v 1649.55n 5.0v 1659.45n 5.0v 1659.55n 5.0v 1669.45n 5.0v 1669.55n 5.0v 1679.45n 5.0v 1679.55n 5.0v 1689.45n 5.0v 1689.55n 5.0v 1699.45n 5.0v 1699.55n 5.0v 1709.45n 5.0v 1709.55n 5.0v 1719.45n 5.0v 1719.55n 0.0v 1729.45n 0.0v 1729.55n 5.0v 1739.45n 5.0v 1739.55n 5.0v 1749.45n 5.0v 1749.55n 5.0v 1759.45n 5.0v 1759.55n 5.0v 1769.45n 5.0v 1769.55n 5.0v 1779.45n 5.0v 1779.55n 5.0v 1789.45n 5.0v 1789.55n 0.0v 1799.45n 0.0v 1799.55n 5.0v 1809.45n 5.0v 1809.55n 0.0v 1819.45n 0.0v 1819.55n 0.0v 1829.45n 0.0v 1829.55n 5.0v 1839.45n 5.0v 1839.55n 5.0v 1849.45n 5.0v 1849.55n 5.0v 1859.45n 5.0v 1859.55n 5.0v 1869.45n 5.0v 1869.55n 0.0v 1879.45n 0.0v 1879.55n 0.0v 1889.45n 0.0v 1889.55n 5.0v 1899.45n 5.0v 1899.55n 5.0v 1909.45n 5.0v 1909.55n 5.0v 1919.45n 5.0v 1919.55n 5.0v 1929.45n 5.0v 1929.55n 5.0v 1939.45n 5.0v 1939.55n 0.0v 1949.45n 0.0v 1949.55n 5.0v 1959.45n 5.0v 1959.55n 0.0v 1969.45n 0.0v 1969.55n 0.0v 1979.45n 0.0v 1979.55n 5.0v 1989.45n 5.0v 1989.55n 0.0v 1999.45n 0.0v 1999.55n 5.0v 2009.45n 5.0v 2009.55n 0.0v 2019.45n 0.0v 2019.55n 0.0v 2029.45n 0.0v 2029.55n 5.0v 2039.45n 5.0v 2039.55n 5.0v 2049.45n 5.0v 2049.55n 5.0v )
* (time, data): [(0, 0), (10, 0), (20, 0), (30, 0), (40, 0), (50, 0), (60, 0), (70, 0), (80, 0), (90, 0), (100, 0), (110, 0), (120, 0), (130, 0), (140, 0), (150, 0), (160, 0), (170, 0), (180, 0), (190, 0), (200, 0), (210, 0), (220, 0), (230, 0), (240, 0), (250, 0), (260, 0), (270, 0), (280, 0), (290, 0), (300, 0), (310, 0), (320, 0), (330, 0), (340, 0), (350, 0), (360, 0), (370, 0), (380, 0), (390, 0), (400, 0), (410, 0), (420, 0), (430, 0), (440, 0), (450, 0), (460, 0), (470, 0), (480, 0), (490, 0), (500, 0), (510, 0), (520, 0), (530, 0), (540, 0), (550, 0), (560, 0), (570, 0), (580, 0), (590, 0), (600, 0), (610, 0), (620, 0), (630, 0), (640, 0), (650, 0), (660, 0), (670, 0), (680, 0), (690, 0), (700, 0), (710, 0), (720, 0), (730, 0), (740, 0), (750, 0), (760, 0), (770, 0), (780, 0), (790, 0), (800, 0), (810, 0), (820, 0), (830, 0), (840, 0), (850, 0), (860, 0), (870, 0), (880, 0), (890, 0), (900, 0), (910, 0), (920, 0), (930, 0), (940, 0), (950, 0), (960, 0), (970, 0), (980, 0), (990, 0), (1000, 0), (1010, 0), (1020, 0), (1030, 0), (1040, 0), (1050, 0), (1060, 0), (1070, 0), (1080, 0), (1090, 0), (1100, 0), (1110, 0), (1120, 0), (1130, 0), (1140, 0), (1150, 0), (1160, 0), (1170, 0), (1180, 0), (1190, 0), (1200, 0), (1210, 0), (1220, 0), (1230, 0), (1240, 0), (1250, 0), (1260, 0), (1270, 0), (1280, 0), (1290, 0), (1300, 0), (1310, 0), (1320, 0), (1330, 0), (1340, 0), (1350, 0), (1360, 0), (1370, 0), (1380, 0), (1390, 0), (1400, 0), (1410, 0), (1420, 0), (1430, 0), (1440, 0), (1450, 0), (1460, 0), (1470, 0), (1480, 0), (1490, 0), (1500, 0), (1510, 0), (1520, 0), (1530, 0), (1540, 0), (1550, 0), (1560, 0), (1570, 0), (1580, 0), (1590, 0), (1600, 0), (1610, 0), (1620, 0), (1630, 0), (1640, 0), (1650, 0), (1660, 0), (1670, 0), (1680, 0), (1690, 0), (1700, 0), (1710, 0), (1720, 0), (1730, 0), (1740, 0), (1750, 0), (1760, 0), (1770, 0), (1780, 0), (1790, 0), (1800, 0), (1810, 0), (1820, 0), (1830, 0), (1840, 0), (1850, 0), (1860, 0), (1870, 0), (1880, 0), (1890, 0), (1900, 0), (1910, 0), (1920, 0), (1930, 0), (1940, 0), (1950, 0), (1960, 0), (1970, 0), (1980, 0), (1990, 0), (2000, 0), (2010, 0), (2020, 0), (2030, 0), (2040, 0), (2050, 0)]
Va1_0  a1_0  0 PWL (0n 0.0v 9.45n 0.0v 9.55n 0.0v 19.45n 0.0v 19.55n 0.0v 29.45n 0.0v 29.55n 0.0v 39.45n 0.0v 39.55n 0.0v 49.45n 0.0v 49.55n 0.0v 59.45n 0.0v 59.55n 0.0v 69.45n 0.0v 69.55n 0.0v 79.45n 0.0v 79.55n 0.0v 89.45n 0.0v 89.55n 0.0v 99.45n 0.0v 99.55n 0.0v 109.45n 0.0v 109.55n 0.0v 119.45n 0.0v 119.55n 0.0v 129.45n 0.0v 129.55n 0.0v 139.45n 0.0v 139.55n 0.0v 149.45n 0.0v 149.55n 0.0v 159.45n 0.0v 159.55n 0.0v 169.45n 0.0v 169.55n 0.0v 179.45n 0.0v 179.55n 0.0v 189.45n 0.0v 189.55n 0.0v 199.45n 0.0v 199.55n 0.0v 209.45n 0.0v 209.55n 0.0v 219.45n 0.0v 219.55n 0.0v 229.45n 0.0v 229.55n 0.0v 239.45n 0.0v 239.55n 0.0v 249.45n 0.0v 249.55n 0.0v 259.45n 0.0v 259.55n 0.0v 269.45n 0.0v 269.55n 0.0v 279.45n 0.0v 279.55n 0.0v 289.45n 0.0v 289.55n 0.0v 299.45n 0.0v 299.55n 0.0v 309.45n 0.0v 309.55n 0.0v 319.45n 0.0v 319.55n 0.0v 329.45n 0.0v 329.55n 0.0v 339.45n 0.0v 339.55n 0.0v 349.45n 0.0v 349.55n 0.0v 359.45n 0.0v 359.55n 0.0v 369.45n 0.0v 369.55n 0.0v 379.45n 0.0v 379.55n 0.0v 389.45n 0.0v 389.55n 0.0v 399.45n 0.0v 399.55n 0.0v 409.45n 0.0v 409.55n 0.0v 419.45n 0.0v 419.55n 0.0v 429.45n 0.0v 429.55n 0.0v 439.45n 0.0v 439.55n 0.0v 449.45n 0.0v 449.55n 0.0v 459.45n 0.0v 459.55n 0.0v 469.45n 0.0v 469.55n 0.0v 479.45n 0.0v 479.55n 0.0v 489.45n 0.0v 489.55n 0.0v 499.45n 0.0v 499.55n 0.0v 509.45n 0.0v 509.55n 0.0v 519.45n 0.0v 519.55n 0.0v 529.45n 0.0v 529.55n 0.0v 539.45n 0.0v 539.55n 0.0v 549.45n 0.0v 549.55n 0.0v 559.45n 0.0v 559.55n 0.0v 569.45n 0.0v 569.55n 0.0v 579.45n 0.0v 579.55n 0.0v 589.45n 0.0v 589.55n 0.0v 599.45n 0.0v 599.55n 0.0v 609.45n 0.0v 609.55n 0.0v 619.45n 0.0v 619.55n 0.0v 629.45n 0.0v 629.55n 0.0v 639.45n 0.0v 639.55n 0.0v 649.45n 0.0v 649.55n 0.0v 659.45n 0.0v 659.55n 0.0v 669.45n 0.0v 669.55n 0.0v 679.45n 0.0v 679.55n 0.0v 689.45n 0.0v 689.55n 0.0v 699.45n 0.0v 699.55n 0.0v 709.45n 0.0v 709.55n 0.0v 719.45n 0.0v 719.55n 0.0v 729.45n 0.0v 729.55n 0.0v 739.45n 0.0v 739.55n 0.0v 749.45n 0.0v 749.55n 0.0v 759.45n 0.0v 759.55n 0.0v 769.45n 0.0v 769.55n 0.0v 779.45n 0.0v 779.55n 0.0v 789.45n 0.0v 789.55n 0.0v 799.45n 0.0v 799.55n 0.0v 809.45n 0.0v 809.55n 0.0v 819.45n 0.0v 819.55n 0.0v 829.45n 0.0v 829.55n 0.0v 839.45n 0.0v 839.55n 0.0v 849.45n 0.0v 849.55n 0.0v 859.45n 0.0v 859.55n 0.0v 869.45n 0.0v 869.55n 0.0v 879.45n 0.0v 879.55n 0.0v 889.45n 0.0v 889.55n 0.0v 899.45n 0.0v 899.55n 0.0v 909.45n 0.0v 909.55n 0.0v 919.45n 0.0v 919.55n 0.0v 929.45n 0.0v 929.55n 0.0v 939.45n 0.0v 939.55n 0.0v 949.45n 0.0v 949.55n 0.0v 959.45n 0.0v 959.55n 0.0v 969.45n 0.0v 969.55n 0.0v 979.45n 0.0v 979.55n 0.0v 989.45n 0.0v 989.55n 0.0v 999.45n 0.0v 999.55n 0.0v 1009.45n 0.0v 1009.55n 0.0v 1019.45n 0.0v 1019.55n 0.0v 1029.45n 0.0v 1029.55n 0.0v 1039.45n 0.0v 1039.55n 0.0v 1049.45n 0.0v 1049.55n 0.0v 1059.45n 0.0v 1059.55n 0.0v 1069.45n 0.0v 1069.55n 0.0v 1079.45n 0.0v 1079.55n 0.0v 1089.45n 0.0v 1089.55n 0.0v 1099.45n 0.0v 1099.55n 0.0v 1109.45n 0.0v 1109.55n 0.0v 1119.45n 0.0v 1119.55n 0.0v 1129.45n 0.0v 1129.55n 0.0v 1139.45n 0.0v 1139.55n 0.0v 1149.45n 0.0v 1149.55n 0.0v 1159.45n 0.0v 1159.55n 0.0v 1169.45n 0.0v 1169.55n 0.0v 1179.45n 0.0v 1179.55n 0.0v 1189.45n 0.0v 1189.55n 0.0v 1199.45n 0.0v 1199.55n 0.0v 1209.45n 0.0v 1209.55n 0.0v 1219.45n 0.0v 1219.55n 0.0v 1229.45n 0.0v 1229.55n 0.0v 1239.45n 0.0v 1239.55n 0.0v 1249.45n 0.0v 1249.55n 0.0v 1259.45n 0.0v 1259.55n 0.0v 1269.45n 0.0v 1269.55n 0.0v 1279.45n 0.0v 1279.55n 0.0v 1289.45n 0.0v 1289.55n 0.0v 1299.45n 0.0v 1299.55n 0.0v 1309.45n 0.0v 1309.55n 0.0v 1319.45n 0.0v 1319.55n 0.0v 1329.45n 0.0v 1329.55n 0.0v 1339.45n 0.0v 1339.55n 0.0v 1349.45n 0.0v 1349.55n 0.0v 1359.45n 0.0v 1359.55n 0.0v 1369.45n 0.0v 1369.55n 0.0v 1379.45n 0.0v 1379.55n 0.0v 1389.45n 0.0v 1389.55n 0.0v 1399.45n 0.0v 1399.55n 0.0v 1409.45n 0.0v 1409.55n 0.0v 1419.45n 0.0v 1419.55n 0.0v 1429.45n 0.0v 1429.55n 0.0v 1439.45n 0.0v 1439.55n 0.0v 1449.45n 0.0v 1449.55n 0.0v 1459.45n 0.0v 1459.55n 0.0v 1469.45n 0.0v 1469.55n 0.0v 1479.45n 0.0v 1479.55n 0.0v 1489.45n 0.0v 1489.55n 0.0v 1499.45n 0.0v 1499.55n 0.0v 1509.45n 0.0v 1509.55n 0.0v 1519.45n 0.0v 1519.55n 0.0v 1529.45n 0.0v 1529.55n 0.0v 1539.45n 0.0v 1539.55n 0.0v 1549.45n 0.0v 1549.55n 0.0v 1559.45n 0.0v 1559.55n 0.0v 1569.45n 0.0v 1569.55n 0.0v 1579.45n 0.0v 1579.55n 0.0v 1589.45n 0.0v 1589.55n 0.0v 1599.45n 0.0v 1599.55n 0.0v 1609.45n 0.0v 1609.55n 0.0v 1619.45n 0.0v 1619.55n 0.0v 1629.45n 0.0v 1629.55n 0.0v 1639.45n 0.0v 1639.55n 0.0v 1649.45n 0.0v 1649.55n 0.0v 1659.45n 0.0v 1659.55n 0.0v 1669.45n 0.0v 1669.55n 0.0v 1679.45n 0.0v 1679.55n 0.0v 1689.45n 0.0v 1689.55n 0.0v 1699.45n 0.0v 1699.55n 0.0v 1709.45n 0.0v 1709.55n 0.0v 1719.45n 0.0v 1719.55n 0.0v 1729.45n 0.0v 1729.55n 0.0v 1739.45n 0.0v 1739.55n 0.0v 1749.45n 0.0v 1749.55n 0.0v 1759.45n 0.0v 1759.55n 0.0v 1769.45n 0.0v 1769.55n 0.0v 1779.45n 0.0v 1779.55n 0.0v 1789.45n 0.0v 1789.55n 0.0v 1799.45n 0.0v 1799.55n 0.0v 1809.45n 0.0v 1809.55n 0.0v 1819.45n 0.0v 1819.55n 0.0v 1829.45n 0.0v 1829.55n 0.0v 1839.45n 0.0v 1839.55n 0.0v 1849.45n 0.0v 1849.55n 0.0v 1859.45n 0.0v 1859.55n 0.0v 1869.45n 0.0v 1869.55n 0.0v 1879.45n 0.0v 1879.55n 0.0v 1889.45n 0.0v 1889.55n 0.0v 1899.45n 0.0v 1899.55n 0.0v 1909.45n 0.0v 1909.55n 0.0v 1919.45n 0.0v 1919.55n 0.0v 1929.45n 0.0v 1929.55n 0.0v 1939.45n 0.0v 1939.55n 0.0v 1949.45n 0.0v 1949.55n 0.0v 1959.45n 0.0v 1959.55n 0.0v 1969.45n 0.0v 1969.55n 0.0v 1979.45n 0.0v 1979.55n 0.0v 1989.45n 0.0v 1989.55n 0.0v 1999.45n 0.0v 1999.55n 0.0v 2009.45n 0.0v 2009.55n 0.0v 2019.45n 0.0v 2019.55n 0.0v 2029.45n 0.0v 2029.55n 0.0v 2039.45n 0.0v 2039.55n 0.0v 2049.45n 0.0v 2049.55n 0.0v )
* (time, data): [(0, 0), (10, 0), (20, 0), (30, 0), (40, 1), (50, 1), (60, 1), (70, 1), (80, 1), (90, 1), (100, 1), (110, 1), (120, 0), (130, 0), (140, 0), (150, 0), (160, 0), (170, 0), (180, 0), (190, 0), (200, 0), (210, 0), (220, 0), (230, 0), (240, 0), (250, 1), (260, 1), (270, 1), (280, 1), (290, 1), (300, 0), (310, 0), (320, 1), (330, 0), (340, 0), (350, 0), (360, 1), (370, 1), (380, 1), (390, 0), (400, 0), (410, 0), (420, 0), (430, 0), (440, 0), (450, 1), (460, 1), (470, 1), (480, 0), (490, 0), (500, 0), (510, 0), (520, 0), (530, 0), (540, 1), (550, 1), (560, 1), (570, 1), (580, 1), (590, 1), (600, 1), (610, 1), (620, 1), (630, 1), (640, 1), (650, 1), (660, 1), (670, 1), (680, 1), (690, 1), (700, 0), (710, 0), (720, 0), (730, 0), (740, 0), (750, 0), (760, 1), (770, 1), (780, 0), (790, 1), (800, 0), (810, 0), (820, 1), (830, 0), (840, 0), (850, 0), (860, 0), (870, 0), (880, 0), (890, 0), (900, 0), (910, 0), (920, 1), (930, 1), (940, 1), (950, 1), (960, 1), (970, 1), (980, 1), (990, 0), (1000, 0), (1010, 0), (1020, 0), (1030, 0), (1040, 0), (1050, 0), (1060, 0), (1070, 0), (1080, 0), (1090, 0), (1100, 0), (1110, 0), (1120, 0), (1130, 1), (1140, 1), (1150, 0), (1160, 0), (1170, 0), (1180, 0), (1190, 1), (1200, 1), (1210, 0), (1220, 0), (1230, 0), (1240, 0), (1250, 0), (1260, 0), (1270, 0), (1280, 0), (1290, 0), (1300, 0), (1310, 0), (1320, 0), (1330, 1), (1340, 1), (1350, 1), (1360, 1), (1370, 0), (1380, 1), (1390, 0), (1400, 0), (1410, 0), (1420, 0), (1430, 0), (1440, 0), (1450, 0), (1460, 1), (1470, 1), (1480, 0), (1490, 0), (1500, 0), (1510, 0), (1520, 0), (1530, 0), (1540, 1), (1550, 0), (1560, 0), (1570, 0), (1580, 0), (1590, 0), (1600, 0), (1610, 0), (1620, 0), (1630, 0), (1640, 0), (1650, 0), (1660, 0), (1670, 0), (1680, 0), (1690, 0), (1700, 1), (1710, 1), (1720, 1), (1730, 0), (1740, 0), (1750, 0), (1760, 1), (1770, 0), (1780, 0), (1790, 1), (1800, 1), (1810, 1), (1820, 1), (1830, 1), (1840, 1), (1850, 1), (1860, 1), (1870, 1), (1880, 1), (1890, 1), (1900, 0), (1910, 0), (1920, 0), (1930, 0), (1940, 1), (1950, 1), (1960, 0), (1970, 1), (1980, 0), (1990, 0), (2000, 0), (2010, 1), (2020, 1), (2030, 0), (2040, 0), (2050, 0)]
Va1_1  a1_1  0 PWL (0n 0.0v 9.45n 0.0v 9.55n 0.0v 19.45n 0.0v 19.55n 0.0v 29.45n 0.0v 29.55n 0.0v 39.45n 0.0v 39.55n 5.0v 49.45n 5.0v 49.55n 5.0v 59.45n 5.0v 59.55n 5.0v 69.45n 5.0v 69.55n 5.0v 79.45n 5.0v 79.55n 5.0v 89.45n 5.0v 89.55n 5.0v 99.45n 5.0v 99.55n 5.0v 109.45n 5.0v 109.55n 5.0v 119.45n 5.0v 119.55n 0.0v 129.45n 0.0v 129.55n 0.0v 139.45n 0.0v 139.55n 0.0v 149.45n 0.0v 149.55n 0.0v 159.45n 0.0v 159.55n 0.0v 169.45n 0.0v 169.55n 0.0v 179.45n 0.0v 179.55n 0.0v 189.45n 0.0v 189.55n 0.0v 199.45n 0.0v 199.55n 0.0v 209.45n 0.0v 209.55n 0.0v 219.45n 0.0v 219.55n 0.0v 229.45n 0.0v 229.55n 0.0v 239.45n 0.0v 239.55n 0.0v 249.45n 0.0v 249.55n 5.0v 259.45n 5.0v 259.55n 5.0v 269.45n 5.0v 269.55n 5.0v 279.45n 5.0v 279.55n 5.0v 289.45n 5.0v 289.55n 5.0v 299.45n 5.0v 299.55n 0.0v 309.45n 0.0v 309.55n 0.0v 319.45n 0.0v 319.55n 5.0v 329.45n 5.0v 329.55n 0.0v 339.45n 0.0v 339.55n 0.0v 349.45n 0.0v 349.55n 0.0v 359.45n 0.0v 359.55n 5.0v 369.45n 5.0v 369.55n 5.0v 379.45n 5.0v 379.55n 5.0v 389.45n 5.0v 389.55n 0.0v 399.45n 0.0v 399.55n 0.0v 409.45n 0.0v 409.55n 0.0v 419.45n 0.0v 419.55n 0.0v 429.45n 0.0v 429.55n 0.0v 439.45n 0.0v 439.55n 0.0v 449.45n 0.0v 449.55n 5.0v 459.45n 5.0v 459.55n 5.0v 469.45n 5.0v 469.55n 5.0v 479.45n 5.0v 479.55n 0.0v 489.45n 0.0v 489.55n 0.0v 499.45n 0.0v 499.55n 0.0v 509.45n 0.0v 509.55n 0.0v 519.45n 0.0v 519.55n 0.0v 529.45n 0.0v 529.55n 0.0v 539.45n 0.0v 539.55n 5.0v 549.45n 5.0v 549.55n 5.0v 559.45n 5.0v 559.55n 5.0v 569.45n 5.0v 569.55n 5.0v 579.45n 5.0v 579.55n 5.0v 589.45n 5.0v 589.55n 5.0v 599.45n 5.0v 599.55n 5.0v 609.45n 5.0v 609.55n 5.0v 619.45n 5.0v 619.55n 5.0v 629.45n 5.0v 629.55n 5.0v 639.45n 5.0v 639.55n 5.0v 649.45n 5.0v 649.55n 5.0v 659.45n 5.0v 659.55n 5.0v 669.45n 5.0v 669.55n 5.0v 679.45n 5.0v 679.55n 5.0v 689.45n 5.0v 689.55n 5.0v 699.45n 5.0v 699.55n 0.0v 709.45n 0.0v 709.55n 0.0v 719.45n 0.0v 719.55n 0.0v 729.45n 0.0v 729.55n 0.0v 739.45n 0.0v 739.55n 0.0v 749.45n 0.0v 749.55n 0.0v 759.45n 0.0v 759.55n 5.0v 769.45n 5.0v 769.55n 5.0v 779.45n 5.0v 779.55n 0.0v 789.45n 0.0v 789.55n 5.0v 799.45n 5.0v 799.55n 0.0v 809.45n 0.0v 809.55n 0.0v 819.45n 0.0v 819.55n 5.0v 829.45n 5.0v 829.55n 0.0v 839.45n 0.0v 839.55n 0.0v 849.45n 0.0v 849.55n 0.0v 859.45n 0.0v 859.55n 0.0v 869.45n 0.0v 869.55n 0.0v 879.45n 0.0v 879.55n 0.0v 889.45n 0.0v 889.55n 0.0v 899.45n 0.0v 899.55n 0.0v 909.45n 0.0v 909.55n 0.0v 919.45n 0.0v 919.55n 5.0v 929.45n 5.0v 929.55n 5.0v 939.45n 5.0v 939.55n 5.0v 949.45n 5.0v 949.55n 5.0v 959.45n 5.0v 959.55n 5.0v 969.45n 5.0v 969.55n 5.0v 979.45n 5.0v 979.55n 5.0v 989.45n 5.0v 989.55n 0.0v 999.45n 0.0v 999.55n 0.0v 1009.45n 0.0v 1009.55n 0.0v 1019.45n 0.0v 1019.55n 0.0v 1029.45n 0.0v 1029.55n 0.0v 1039.45n 0.0v 1039.55n 0.0v 1049.45n 0.0v 1049.55n 0.0v 1059.45n 0.0v 1059.55n 0.0v 1069.45n 0.0v 1069.55n 0.0v 1079.45n 0.0v 1079.55n 0.0v 1089.45n 0.0v 1089.55n 0.0v 1099.45n 0.0v 1099.55n 0.0v 1109.45n 0.0v 1109.55n 0.0v 1119.45n 0.0v 1119.55n 0.0v 1129.45n 0.0v 1129.55n 5.0v 1139.45n 5.0v 1139.55n 5.0v 1149.45n 5.0v 1149.55n 0.0v 1159.45n 0.0v 1159.55n 0.0v 1169.45n 0.0v 1169.55n 0.0v 1179.45n 0.0v 1179.55n 0.0v 1189.45n 0.0v 1189.55n 5.0v 1199.45n 5.0v 1199.55n 5.0v 1209.45n 5.0v 1209.55n 0.0v 1219.45n 0.0v 1219.55n 0.0v 1229.45n 0.0v 1229.55n 0.0v 1239.45n 0.0v 1239.55n 0.0v 1249.45n 0.0v 1249.55n 0.0v 1259.45n 0.0v 1259.55n 0.0v 1269.45n 0.0v 1269.55n 0.0v 1279.45n 0.0v 1279.55n 0.0v 1289.45n 0.0v 1289.55n 0.0v 1299.45n 0.0v 1299.55n 0.0v 1309.45n 0.0v 1309.55n 0.0v 1319.45n 0.0v 1319.55n 0.0v 1329.45n 0.0v 1329.55n 5.0v 1339.45n 5.0v 1339.55n 5.0v 1349.45n 5.0v 1349.55n 5.0v 1359.45n 5.0v 1359.55n 5.0v 1369.45n 5.0v 1369.55n 0.0v 1379.45n 0.0v 1379.55n 5.0v 1389.45n 5.0v 1389.55n 0.0v 1399.45n 0.0v 1399.55n 0.0v 1409.45n 0.0v 1409.55n 0.0v 1419.45n 0.0v 1419.55n 0.0v 1429.45n 0.0v 1429.55n 0.0v 1439.45n 0.0v 1439.55n 0.0v 1449.45n 0.0v 1449.55n 0.0v 1459.45n 0.0v 1459.55n 5.0v 1469.45n 5.0v 1469.55n 5.0v 1479.45n 5.0v 1479.55n 0.0v 1489.45n 0.0v 1489.55n 0.0v 1499.45n 0.0v 1499.55n 0.0v 1509.45n 0.0v 1509.55n 0.0v 1519.45n 0.0v 1519.55n 0.0v 1529.45n 0.0v 1529.55n 0.0v 1539.45n 0.0v 1539.55n 5.0v 1549.45n 5.0v 1549.55n 0.0v 1559.45n 0.0v 1559.55n 0.0v 1569.45n 0.0v 1569.55n 0.0v 1579.45n 0.0v 1579.55n 0.0v 1589.45n 0.0v 1589.55n 0.0v 1599.45n 0.0v 1599.55n 0.0v 1609.45n 0.0v 1609.55n 0.0v 1619.45n 0.0v 1619.55n 0.0v 1629.45n 0.0v 1629.55n 0.0v 1639.45n 0.0v 1639.55n 0.0v 1649.45n 0.0v 1649.55n 0.0v 1659.45n 0.0v 1659.55n 0.0v 1669.45n 0.0v 1669.55n 0.0v 1679.45n 0.0v 1679.55n 0.0v 1689.45n 0.0v 1689.55n 0.0v 1699.45n 0.0v 1699.55n 5.0v 1709.45n 5.0v 1709.55n 5.0v 1719.45n 5.0v 1719.55n 5.0v 1729.45n 5.0v 1729.55n 0.0v 1739.45n 0.0v 1739.55n 0.0v 1749.45n 0.0v 1749.55n 0.0v 1759.45n 0.0v 1759.55n 5.0v 1769.45n 5.0v 1769.55n 0.0v 1779.45n 0.0v 1779.55n 0.0v 1789.45n 0.0v 1789.55n 5.0v 1799.45n 5.0v 1799.55n 5.0v 1809.45n 5.0v 1809.55n 5.0v 1819.45n 5.0v 1819.55n 5.0v 1829.45n 5.0v 1829.55n 5.0v 1839.45n 5.0v 1839.55n 5.0v 1849.45n 5.0v 1849.55n 5.0v 1859.45n 5.0v 1859.55n 5.0v 1869.45n 5.0v 1869.55n 5.0v 1879.45n 5.0v 1879.55n 5.0v 1889.45n 5.0v 1889.55n 5.0v 1899.45n 5.0v 1899.55n 0.0v 1909.45n 0.0v 1909.55n 0.0v 1919.45n 0.0v 1919.55n 0.0v 1929.45n 0.0v 1929.55n 0.0v 1939.45n 0.0v 1939.55n 5.0v 1949.45n 5.0v 1949.55n 5.0v 1959.45n 5.0v 1959.55n 0.0v 1969.45n 0.0v 1969.55n 5.0v 1979.45n 5.0v 1979.55n 0.0v 1989.45n 0.0v 1989.55n 0.0v 1999.45n 0.0v 1999.55n 0.0v 2009.45n 0.0v 2009.55n 5.0v 2019.45n 5.0v 2019.55n 5.0v 2029.45n 5.0v 2029.55n 0.0v 2039.45n 0.0v 2039.55n 0.0v 2049.45n 0.0v 2049.55n 0.0v )
* (time, data): [(0, 0), (10, 0), (20, 0), (30, 0), (40, 1), (50, 1), (60, 1), (70, 1), (80, 1), (90, 1), (100, 1), (110, 1), (120, 0), (130, 0), (140, 0), (150, 0), (160, 0), (170, 0), (180, 0), (190, 0), (200, 0), (210, 0), (220, 0), (230, 0), (240, 0), (250, 1), (260, 1), (270, 1), (280, 1), (290, 1), (300, 0), (310, 0), (320, 1), (330, 0), (340, 0), (350, 0), (360, 1), (370, 1), (380, 1), (390, 0), (400, 0), (410, 0), (420, 0), (430, 0), (440, 0), (450, 1), (460, 1), (470, 1), (480, 0), (490, 0), (500, 0), (510, 0), (520, 0), (530, 0), (540, 1), (550, 1), (560, 1), (570, 1), (580, 1), (590, 1), (600, 1), (610, 1), (620, 1), (630, 1), (640, 1), (650, 1), (660, 1), (670, 1), (680, 1), (690, 1), (700, 0), (710, 0), (720, 0), (730, 0), (740, 0), (750, 0), (760, 1), (770, 1), (780, 0), (790, 1), (800, 0), (810, 0), (820, 1), (830, 0), (840, 0), (850, 0), (860, 0), (870, 0), (880, 0), (890, 0), (900, 0), (910, 0), (920, 1), (930, 1), (940, 1), (950, 1), (960, 1), (970, 1), (980, 1), (990, 0), (1000, 0), (1010, 0), (1020, 0), (1030, 0), (1040, 0), (1050, 0), (1060, 0), (1070, 0), (1080, 0), (1090, 0), (1100, 0), (1110, 0), (1120, 0), (1130, 1), (1140, 1), (1150, 0), (1160, 0), (1170, 0), (1180, 0), (1190, 1), (1200, 1), (1210, 0), (1220, 0), (1230, 0), (1240, 0), (1250, 0), (1260, 0), (1270, 0), (1280, 0), (1290, 0), (1300, 0), (1310, 0), (1320, 0), (1330, 1), (1340, 1), (1350, 1), (1360, 1), (1370, 0), (1380, 1), (1390, 0), (1400, 0), (1410, 0), (1420, 0), (1430, 0), (1440, 0), (1450, 0), (1460, 1), (1470, 1), (1480, 0), (1490, 0), (1500, 0), (1510, 0), (1520, 0), (1530, 0), (1540, 1), (1550, 0), (1560, 0), (1570, 0), (1580, 0), (1590, 0), (1600, 0), (1610, 0), (1620, 0), (1630, 0), (1640, 0), (1650, 0), (1660, 0), (1670, 0), (1680, 0), (1690, 0), (1700, 1), (1710, 1), (1720, 1), (1730, 0), (1740, 0), (1750, 0), (1760, 1), (1770, 0), (1780, 0), (1790, 1), (1800, 1), (1810, 1), (1820, 1), (1830, 1), (1840, 1), (1850, 1), (1860, 1), (1870, 1), (1880, 1), (1890, 1), (1900, 0), (1910, 0), (1920, 0), (1930, 0), (1940, 1), (1950, 1), (1960, 0), (1970, 1), (1980, 0), (1990, 0), (2000, 0), (2010, 1), (2020, 1), (2030, 0), (2040, 0), (2050, 0)]
Va1_2  a1_2  0 PWL (0n 0.0v 9.45n 0.0v 9.55n 0.0v 19.45n 0.0v 19.55n 0.0v 29.45n 0.0v 29.55n 0.0v 39.45n 0.0v 39.55n 5.0v 49.45n 5.0v 49.55n 5.0v 59.45n 5.0v 59.55n 5.0v 69.45n 5.0v 69.55n 5.0v 79.45n 5.0v 79.55n 5.0v 89.45n 5.0v 89.55n 5.0v 99.45n 5.0v 99.55n 5.0v 109.45n 5.0v 109.55n 5.0v 119.45n 5.0v 119.55n 0.0v 129.45n 0.0v 129.55n 0.0v 139.45n 0.0v 139.55n 0.0v 149.45n 0.0v 149.55n 0.0v 159.45n 0.0v 159.55n 0.0v 169.45n 0.0v 169.55n 0.0v 179.45n 0.0v 179.55n 0.0v 189.45n 0.0v 189.55n 0.0v 199.45n 0.0v 199.55n 0.0v 209.45n 0.0v 209.55n 0.0v 219.45n 0.0v 219.55n 0.0v 229.45n 0.0v 229.55n 0.0v 239.45n 0.0v 239.55n 0.0v 249.45n 0.0v 249.55n 5.0v 259.45n 5.0v 259.55n 5.0v 269.45n 5.0v 269.55n 5.0v 279.45n 5.0v 279.55n 5.0v 289.45n 5.0v 289.55n 5.0v 299.45n 5.0v 299.55n 0.0v 309.45n 0.0v 309.55n 0.0v 319.45n 0.0v 319.55n 5.0v 329.45n 5.0v 329.55n 0.0v 339.45n 0.0v 339.55n 0.0v 349.45n 0.0v 349.55n 0.0v 359.45n 0.0v 359.55n 5.0v 369.45n 5.0v 369.55n 5.0v 379.45n 5.0v 379.55n 5.0v 389.45n 5.0v 389.55n 0.0v 399.45n 0.0v 399.55n 0.0v 409.45n 0.0v 409.55n 0.0v 419.45n 0.0v 419.55n 0.0v 429.45n 0.0v 429.55n 0.0v 439.45n 0.0v 439.55n 0.0v 449.45n 0.0v 449.55n 5.0v 459.45n 5.0v 459.55n 5.0v 469.45n 5.0v 469.55n 5.0v 479.45n 5.0v 479.55n 0.0v 489.45n 0.0v 489.55n 0.0v 499.45n 0.0v 499.55n 0.0v 509.45n 0.0v 509.55n 0.0v 519.45n 0.0v 519.55n 0.0v 529.45n 0.0v 529.55n 0.0v 539.45n 0.0v 539.55n 5.0v 549.45n 5.0v 549.55n 5.0v 559.45n 5.0v 559.55n 5.0v 569.45n 5.0v 569.55n 5.0v 579.45n 5.0v 579.55n 5.0v 589.45n 5.0v 589.55n 5.0v 599.45n 5.0v 599.55n 5.0v 609.45n 5.0v 609.55n 5.0v 619.45n 5.0v 619.55n 5.0v 629.45n 5.0v 629.55n 5.0v 639.45n 5.0v 639.55n 5.0v 649.45n 5.0v 649.55n 5.0v 659.45n 5.0v 659.55n 5.0v 669.45n 5.0v 669.55n 5.0v 679.45n 5.0v 679.55n 5.0v 689.45n 5.0v 689.55n 5.0v 699.45n 5.0v 699.55n 0.0v 709.45n 0.0v 709.55n 0.0v 719.45n 0.0v 719.55n 0.0v 729.45n 0.0v 729.55n 0.0v 739.45n 0.0v 739.55n 0.0v 749.45n 0.0v 749.55n 0.0v 759.45n 0.0v 759.55n 5.0v 769.45n 5.0v 769.55n 5.0v 779.45n 5.0v 779.55n 0.0v 789.45n 0.0v 789.55n 5.0v 799.45n 5.0v 799.55n 0.0v 809.45n 0.0v 809.55n 0.0v 819.45n 0.0v 819.55n 5.0v 829.45n 5.0v 829.55n 0.0v 839.45n 0.0v 839.55n 0.0v 849.45n 0.0v 849.55n 0.0v 859.45n 0.0v 859.55n 0.0v 869.45n 0.0v 869.55n 0.0v 879.45n 0.0v 879.55n 0.0v 889.45n 0.0v 889.55n 0.0v 899.45n 0.0v 899.55n 0.0v 909.45n 0.0v 909.55n 0.0v 919.45n 0.0v 919.55n 5.0v 929.45n 5.0v 929.55n 5.0v 939.45n 5.0v 939.55n 5.0v 949.45n 5.0v 949.55n 5.0v 959.45n 5.0v 959.55n 5.0v 969.45n 5.0v 969.55n 5.0v 979.45n 5.0v 979.55n 5.0v 989.45n 5.0v 989.55n 0.0v 999.45n 0.0v 999.55n 0.0v 1009.45n 0.0v 1009.55n 0.0v 1019.45n 0.0v 1019.55n 0.0v 1029.45n 0.0v 1029.55n 0.0v 1039.45n 0.0v 1039.55n 0.0v 1049.45n 0.0v 1049.55n 0.0v 1059.45n 0.0v 1059.55n 0.0v 1069.45n 0.0v 1069.55n 0.0v 1079.45n 0.0v 1079.55n 0.0v 1089.45n 0.0v 1089.55n 0.0v 1099.45n 0.0v 1099.55n 0.0v 1109.45n 0.0v 1109.55n 0.0v 1119.45n 0.0v 1119.55n 0.0v 1129.45n 0.0v 1129.55n 5.0v 1139.45n 5.0v 1139.55n 5.0v 1149.45n 5.0v 1149.55n 0.0v 1159.45n 0.0v 1159.55n 0.0v 1169.45n 0.0v 1169.55n 0.0v 1179.45n 0.0v 1179.55n 0.0v 1189.45n 0.0v 1189.55n 5.0v 1199.45n 5.0v 1199.55n 5.0v 1209.45n 5.0v 1209.55n 0.0v 1219.45n 0.0v 1219.55n 0.0v 1229.45n 0.0v 1229.55n 0.0v 1239.45n 0.0v 1239.55n 0.0v 1249.45n 0.0v 1249.55n 0.0v 1259.45n 0.0v 1259.55n 0.0v 1269.45n 0.0v 1269.55n 0.0v 1279.45n 0.0v 1279.55n 0.0v 1289.45n 0.0v 1289.55n 0.0v 1299.45n 0.0v 1299.55n 0.0v 1309.45n 0.0v 1309.55n 0.0v 1319.45n 0.0v 1319.55n 0.0v 1329.45n 0.0v 1329.55n 5.0v 1339.45n 5.0v 1339.55n 5.0v 1349.45n 5.0v 1349.55n 5.0v 1359.45n 5.0v 1359.55n 5.0v 1369.45n 5.0v 1369.55n 0.0v 1379.45n 0.0v 1379.55n 5.0v 1389.45n 5.0v 1389.55n 0.0v 1399.45n 0.0v 1399.55n 0.0v 1409.45n 0.0v 1409.55n 0.0v 1419.45n 0.0v 1419.55n 0.0v 1429.45n 0.0v 1429.55n 0.0v 1439.45n 0.0v 1439.55n 0.0v 1449.45n 0.0v 1449.55n 0.0v 1459.45n 0.0v 1459.55n 5.0v 1469.45n 5.0v 1469.55n 5.0v 1479.45n 5.0v 1479.55n 0.0v 1489.45n 0.0v 1489.55n 0.0v 1499.45n 0.0v 1499.55n 0.0v 1509.45n 0.0v 1509.55n 0.0v 1519.45n 0.0v 1519.55n 0.0v 1529.45n 0.0v 1529.55n 0.0v 1539.45n 0.0v 1539.55n 5.0v 1549.45n 5.0v 1549.55n 0.0v 1559.45n 0.0v 1559.55n 0.0v 1569.45n 0.0v 1569.55n 0.0v 1579.45n 0.0v 1579.55n 0.0v 1589.45n 0.0v 1589.55n 0.0v 1599.45n 0.0v 1599.55n 0.0v 1609.45n 0.0v 1609.55n 0.0v 1619.45n 0.0v 1619.55n 0.0v 1629.45n 0.0v 1629.55n 0.0v 1639.45n 0.0v 1639.55n 0.0v 1649.45n 0.0v 1649.55n 0.0v 1659.45n 0.0v 1659.55n 0.0v 1669.45n 0.0v 1669.55n 0.0v 1679.45n 0.0v 1679.55n 0.0v 1689.45n 0.0v 1689.55n 0.0v 1699.45n 0.0v 1699.55n 5.0v 1709.45n 5.0v 1709.55n 5.0v 1719.45n 5.0v 1719.55n 5.0v 1729.45n 5.0v 1729.55n 0.0v 1739.45n 0.0v 1739.55n 0.0v 1749.45n 0.0v 1749.55n 0.0v 1759.45n 0.0v 1759.55n 5.0v 1769.45n 5.0v 1769.55n 0.0v 1779.45n 0.0v 1779.55n 0.0v 1789.45n 0.0v 1789.55n 5.0v 1799.45n 5.0v 1799.55n 5.0v 1809.45n 5.0v 1809.55n 5.0v 1819.45n 5.0v 1819.55n 5.0v 1829.45n 5.0v 1829.55n 5.0v 1839.45n 5.0v 1839.55n 5.0v 1849.45n 5.0v 1849.55n 5.0v 1859.45n 5.0v 1859.55n 5.0v 1869.45n 5.0v 1869.55n 5.0v 1879.45n 5.0v 1879.55n 5.0v 1889.45n 5.0v 1889.55n 5.0v 1899.45n 5.0v 1899.55n 0.0v 1909.45n 0.0v 1909.55n 0.0v 1919.45n 0.0v 1919.55n 0.0v 1929.45n 0.0v 1929.55n 0.0v 1939.45n 0.0v 1939.55n 5.0v 1949.45n 5.0v 1949.55n 5.0v 1959.45n 5.0v 1959.55n 0.0v 1969.45n 0.0v 1969.55n 5.0v 1979.45n 5.0v 1979.55n 0.0v 1989.45n 0.0v 1989.55n 0.0v 1999.45n 0.0v 1999.55n 0.0v 2009.45n 0.0v 2009.55n 5.0v 2019.45n 5.0v 2019.55n 5.0v 2029.45n 5.0v 2029.55n 0.0v 2039.45n 0.0v 2039.55n 0.0v 2049.45n 0.0v 2049.55n 0.0v )
* (time, data): [(0, 0), (10, 0), (20, 0), (30, 0), (40, 1), (50, 1), (60, 1), (70, 1), (80, 1), (90, 1), (100, 1), (110, 1), (120, 0), (130, 0), (140, 0), (150, 0), (160, 0), (170, 0), (180, 0), (190, 0), (200, 0), (210, 0), (220, 0), (230, 0), (240, 0), (250, 1), (260, 1), (270, 1), (280, 1), (290, 1), (300, 0), (310, 0), (320, 1), (330, 0), (340, 0), (350, 0), (360, 1), (370, 1), (380, 1), (390, 0), (400, 0), (410, 0), (420, 0), (430, 0), (440, 0), (450, 1), (460, 1), (470, 1), (480, 0), (490, 0), (500, 0), (510, 0), (520, 0), (530, 0), (540, 1), (550, 1), (560, 1), (570, 1), (580, 1), (590, 1), (600, 1), (610, 1), (620, 1), (630, 1), (640, 1), (650, 1), (660, 1), (670, 1), (680, 1), (690, 1), (700, 0), (710, 0), (720, 0), (730, 0), (740, 0), (750, 0), (760, 1), (770, 1), (780, 0), (790, 1), (800, 0), (810, 0), (820, 1), (830, 0), (840, 0), (850, 0), (860, 0), (870, 0), (880, 0), (890, 0), (900, 0), (910, 0), (920, 1), (930, 1), (940, 1), (950, 1), (960, 1), (970, 1), (980, 1), (990, 0), (1000, 0), (1010, 0), (1020, 0), (1030, 0), (1040, 0), (1050, 0), (1060, 0), (1070, 0), (1080, 0), (1090, 0), (1100, 0), (1110, 0), (1120, 0), (1130, 1), (1140, 1), (1150, 0), (1160, 0), (1170, 0), (1180, 0), (1190, 1), (1200, 1), (1210, 0), (1220, 0), (1230, 0), (1240, 0), (1250, 0), (1260, 0), (1270, 0), (1280, 0), (1290, 0), (1300, 0), (1310, 0), (1320, 0), (1330, 1), (1340, 1), (1350, 1), (1360, 1), (1370, 0), (1380, 1), (1390, 0), (1400, 0), (1410, 0), (1420, 0), (1430, 0), (1440, 0), (1450, 0), (1460, 1), (1470, 1), (1480, 0), (1490, 0), (1500, 0), (1510, 0), (1520, 0), (1530, 0), (1540, 1), (1550, 0), (1560, 0), (1570, 0), (1580, 0), (1590, 0), (1600, 0), (1610, 0), (1620, 0), (1630, 0), (1640, 0), (1650, 0), (1660, 0), (1670, 0), (1680, 0), (1690, 0), (1700, 1), (1710, 1), (1720, 1), (1730, 0), (1740, 0), (1750, 0), (1760, 1), (1770, 0), (1780, 0), (1790, 1), (1800, 1), (1810, 1), (1820, 1), (1830, 1), (1840, 1), (1850, 1), (1860, 1), (1870, 1), (1880, 1), (1890, 1), (1900, 0), (1910, 0), (1920, 0), (1930, 0), (1940, 1), (1950, 1), (1960, 0), (1970, 1), (1980, 0), (1990, 0), (2000, 0), (2010, 1), (2020, 1), (2030, 0), (2040, 0), (2050, 0)]
Va1_3  a1_3  0 PWL (0n 0.0v 9.45n 0.0v 9.55n 0.0v 19.45n 0.0v 19.55n 0.0v 29.45n 0.0v 29.55n 0.0v 39.45n 0.0v 39.55n 5.0v 49.45n 5.0v 49.55n 5.0v 59.45n 5.0v 59.55n 5.0v 69.45n 5.0v 69.55n 5.0v 79.45n 5.0v 79.55n 5.0v 89.45n 5.0v 89.55n 5.0v 99.45n 5.0v 99.55n 5.0v 109.45n 5.0v 109.55n 5.0v 119.45n 5.0v 119.55n 0.0v 129.45n 0.0v 129.55n 0.0v 139.45n 0.0v 139.55n 0.0v 149.45n 0.0v 149.55n 0.0v 159.45n 0.0v 159.55n 0.0v 169.45n 0.0v 169.55n 0.0v 179.45n 0.0v 179.55n 0.0v 189.45n 0.0v 189.55n 0.0v 199.45n 0.0v 199.55n 0.0v 209.45n 0.0v 209.55n 0.0v 219.45n 0.0v 219.55n 0.0v 229.45n 0.0v 229.55n 0.0v 239.45n 0.0v 239.55n 0.0v 249.45n 0.0v 249.55n 5.0v 259.45n 5.0v 259.55n 5.0v 269.45n 5.0v 269.55n 5.0v 279.45n 5.0v 279.55n 5.0v 289.45n 5.0v 289.55n 5.0v 299.45n 5.0v 299.55n 0.0v 309.45n 0.0v 309.55n 0.0v 319.45n 0.0v 319.55n 5.0v 329.45n 5.0v 329.55n 0.0v 339.45n 0.0v 339.55n 0.0v 349.45n 0.0v 349.55n 0.0v 359.45n 0.0v 359.55n 5.0v 369.45n 5.0v 369.55n 5.0v 379.45n 5.0v 379.55n 5.0v 389.45n 5.0v 389.55n 0.0v 399.45n 0.0v 399.55n 0.0v 409.45n 0.0v 409.55n 0.0v 419.45n 0.0v 419.55n 0.0v 429.45n 0.0v 429.55n 0.0v 439.45n 0.0v 439.55n 0.0v 449.45n 0.0v 449.55n 5.0v 459.45n 5.0v 459.55n 5.0v 469.45n 5.0v 469.55n 5.0v 479.45n 5.0v 479.55n 0.0v 489.45n 0.0v 489.55n 0.0v 499.45n 0.0v 499.55n 0.0v 509.45n 0.0v 509.55n 0.0v 519.45n 0.0v 519.55n 0.0v 529.45n 0.0v 529.55n 0.0v 539.45n 0.0v 539.55n 5.0v 549.45n 5.0v 549.55n 5.0v 559.45n 5.0v 559.55n 5.0v 569.45n 5.0v 569.55n 5.0v 579.45n 5.0v 579.55n 5.0v 589.45n 5.0v 589.55n 5.0v 599.45n 5.0v 599.55n 5.0v 609.45n 5.0v 609.55n 5.0v 619.45n 5.0v 619.55n 5.0v 629.45n 5.0v 629.55n 5.0v 639.45n 5.0v 639.55n 5.0v 649.45n 5.0v 649.55n 5.0v 659.45n 5.0v 659.55n 5.0v 669.45n 5.0v 669.55n 5.0v 679.45n 5.0v 679.55n 5.0v 689.45n 5.0v 689.55n 5.0v 699.45n 5.0v 699.55n 0.0v 709.45n 0.0v 709.55n 0.0v 719.45n 0.0v 719.55n 0.0v 729.45n 0.0v 729.55n 0.0v 739.45n 0.0v 739.55n 0.0v 749.45n 0.0v 749.55n 0.0v 759.45n 0.0v 759.55n 5.0v 769.45n 5.0v 769.55n 5.0v 779.45n 5.0v 779.55n 0.0v 789.45n 0.0v 789.55n 5.0v 799.45n 5.0v 799.55n 0.0v 809.45n 0.0v 809.55n 0.0v 819.45n 0.0v 819.55n 5.0v 829.45n 5.0v 829.55n 0.0v 839.45n 0.0v 839.55n 0.0v 849.45n 0.0v 849.55n 0.0v 859.45n 0.0v 859.55n 0.0v 869.45n 0.0v 869.55n 0.0v 879.45n 0.0v 879.55n 0.0v 889.45n 0.0v 889.55n 0.0v 899.45n 0.0v 899.55n 0.0v 909.45n 0.0v 909.55n 0.0v 919.45n 0.0v 919.55n 5.0v 929.45n 5.0v 929.55n 5.0v 939.45n 5.0v 939.55n 5.0v 949.45n 5.0v 949.55n 5.0v 959.45n 5.0v 959.55n 5.0v 969.45n 5.0v 969.55n 5.0v 979.45n 5.0v 979.55n 5.0v 989.45n 5.0v 989.55n 0.0v 999.45n 0.0v 999.55n 0.0v 1009.45n 0.0v 1009.55n 0.0v 1019.45n 0.0v 1019.55n 0.0v 1029.45n 0.0v 1029.55n 0.0v 1039.45n 0.0v 1039.55n 0.0v 1049.45n 0.0v 1049.55n 0.0v 1059.45n 0.0v 1059.55n 0.0v 1069.45n 0.0v 1069.55n 0.0v 1079.45n 0.0v 1079.55n 0.0v 1089.45n 0.0v 1089.55n 0.0v 1099.45n 0.0v 1099.55n 0.0v 1109.45n 0.0v 1109.55n 0.0v 1119.45n 0.0v 1119.55n 0.0v 1129.45n 0.0v 1129.55n 5.0v 1139.45n 5.0v 1139.55n 5.0v 1149.45n 5.0v 1149.55n 0.0v 1159.45n 0.0v 1159.55n 0.0v 1169.45n 0.0v 1169.55n 0.0v 1179.45n 0.0v 1179.55n 0.0v 1189.45n 0.0v 1189.55n 5.0v 1199.45n 5.0v 1199.55n 5.0v 1209.45n 5.0v 1209.55n 0.0v 1219.45n 0.0v 1219.55n 0.0v 1229.45n 0.0v 1229.55n 0.0v 1239.45n 0.0v 1239.55n 0.0v 1249.45n 0.0v 1249.55n 0.0v 1259.45n 0.0v 1259.55n 0.0v 1269.45n 0.0v 1269.55n 0.0v 1279.45n 0.0v 1279.55n 0.0v 1289.45n 0.0v 1289.55n 0.0v 1299.45n 0.0v 1299.55n 0.0v 1309.45n 0.0v 1309.55n 0.0v 1319.45n 0.0v 1319.55n 0.0v 1329.45n 0.0v 1329.55n 5.0v 1339.45n 5.0v 1339.55n 5.0v 1349.45n 5.0v 1349.55n 5.0v 1359.45n 5.0v 1359.55n 5.0v 1369.45n 5.0v 1369.55n 0.0v 1379.45n 0.0v 1379.55n 5.0v 1389.45n 5.0v 1389.55n 0.0v 1399.45n 0.0v 1399.55n 0.0v 1409.45n 0.0v 1409.55n 0.0v 1419.45n 0.0v 1419.55n 0.0v 1429.45n 0.0v 1429.55n 0.0v 1439.45n 0.0v 1439.55n 0.0v 1449.45n 0.0v 1449.55n 0.0v 1459.45n 0.0v 1459.55n 5.0v 1469.45n 5.0v 1469.55n 5.0v 1479.45n 5.0v 1479.55n 0.0v 1489.45n 0.0v 1489.55n 0.0v 1499.45n 0.0v 1499.55n 0.0v 1509.45n 0.0v 1509.55n 0.0v 1519.45n 0.0v 1519.55n 0.0v 1529.45n 0.0v 1529.55n 0.0v 1539.45n 0.0v 1539.55n 5.0v 1549.45n 5.0v 1549.55n 0.0v 1559.45n 0.0v 1559.55n 0.0v 1569.45n 0.0v 1569.55n 0.0v 1579.45n 0.0v 1579.55n 0.0v 1589.45n 0.0v 1589.55n 0.0v 1599.45n 0.0v 1599.55n 0.0v 1609.45n 0.0v 1609.55n 0.0v 1619.45n 0.0v 1619.55n 0.0v 1629.45n 0.0v 1629.55n 0.0v 1639.45n 0.0v 1639.55n 0.0v 1649.45n 0.0v 1649.55n 0.0v 1659.45n 0.0v 1659.55n 0.0v 1669.45n 0.0v 1669.55n 0.0v 1679.45n 0.0v 1679.55n 0.0v 1689.45n 0.0v 1689.55n 0.0v 1699.45n 0.0v 1699.55n 5.0v 1709.45n 5.0v 1709.55n 5.0v 1719.45n 5.0v 1719.55n 5.0v 1729.45n 5.0v 1729.55n 0.0v 1739.45n 0.0v 1739.55n 0.0v 1749.45n 0.0v 1749.55n 0.0v 1759.45n 0.0v 1759.55n 5.0v 1769.45n 5.0v 1769.55n 0.0v 1779.45n 0.0v 1779.55n 0.0v 1789.45n 0.0v 1789.55n 5.0v 1799.45n 5.0v 1799.55n 5.0v 1809.45n 5.0v 1809.55n 5.0v 1819.45n 5.0v 1819.55n 5.0v 1829.45n 5.0v 1829.55n 5.0v 1839.45n 5.0v 1839.55n 5.0v 1849.45n 5.0v 1849.55n 5.0v 1859.45n 5.0v 1859.55n 5.0v 1869.45n 5.0v 1869.55n 5.0v 1879.45n 5.0v 1879.55n 5.0v 1889.45n 5.0v 1889.55n 5.0v 1899.45n 5.0v 1899.55n 0.0v 1909.45n 0.0v 1909.55n 0.0v 1919.45n 0.0v 1919.55n 0.0v 1929.45n 0.0v 1929.55n 0.0v 1939.45n 0.0v 1939.55n 5.0v 1949.45n 5.0v 1949.55n 5.0v 1959.45n 5.0v 1959.55n 0.0v 1969.45n 0.0v 1969.55n 5.0v 1979.45n 5.0v 1979.55n 0.0v 1989.45n 0.0v 1989.55n 0.0v 1999.45n 0.0v 1999.55n 0.0v 2009.45n 0.0v 2009.55n 5.0v 2019.45n 5.0v 2019.55n 5.0v 2029.45n 5.0v 2029.55n 0.0v 2039.45n 0.0v 2039.55n 0.0v 2049.45n 0.0v 2049.55n 0.0v )

 * Generation of control signals
* (time, data): [(0, 1), (10, 0), (20, 0), (30, 0), (40, 0), (50, 0), (60, 0), (70, 0), (80, 1), (90, 0), (100, 0), (110, 0), (120, 0), (130, 1), (140, 0), (150, 0), (160, 0), (170, 1), (180, 1), (190, 0), (200, 0), (210, 0), (220, 0), (230, 0), (240, 0), (250, 0), (260, 1), (270, 1), (280, 0), (290, 0), (300, 0), (310, 0), (320, 0), (330, 0), (340, 0), (350, 1), (360, 0), (370, 0), (380, 0), (390, 0), (400, 0), (410, 1), (420, 1), (430, 0), (440, 0), (450, 0), (460, 1), (470, 0), (480, 0), (490, 0), (500, 0), (510, 0), (520, 0), (530, 0), (540, 0), (550, 0), (560, 0), (570, 0), (580, 1), (590, 0), (600, 0), (610, 1), (620, 0), (630, 0), (640, 1), (650, 0), (660, 0), (670, 1), (680, 0), (690, 1), (700, 0), (710, 0), (720, 0), (730, 0), (740, 0), (750, 0), (760, 0), (770, 1), (780, 0), (790, 0), (800, 0), (810, 0), (820, 1), (830, 0), (840, 0), (850, 1), (860, 0), (870, 0), (880, 1), (890, 0), (900, 0), (910, 1), (920, 1), (930, 0), (940, 1), (950, 0), (960, 1), (970, 1), (980, 0), (990, 1), (1000, 0), (1010, 0), (1020, 0), (1030, 0), (1040, 0), (1050, 0), (1060, 0), (1070, 0), (1080, 0), (1090, 0), (1100, 1), (1110, 0), (1120, 0), (1130, 0), (1140, 1), (1150, 0), (1160, 0), (1170, 0), (1180, 0), (1190, 0), (1200, 0), (1210, 0), (1220, 1), (1230, 1), (1240, 0), (1250, 0), (1260, 1), (1270, 0), (1280, 0), (1290, 0), (1300, 0), (1310, 0), (1320, 1), (1330, 0), (1340, 0), (1350, 1), (1360, 0), (1370, 1), (1380, 0), (1390, 1), (1400, 0), (1410, 1), (1420, 0), (1430, 1), (1440, 0), (1450, 1), (1460, 0), (1470, 0), (1480, 0), (1490, 0), (1500, 1), (1510, 0), (1520, 0), (1530, 1), (1540, 0), (1550, 0), (1560, 0), (1570, 0), (1580, 1), (1590, 0), (1600, 0), (1610, 0), (1620, 1), (1630, 0), (1640, 0), (1650, 1), (1660, 1), (1670, 0), (1680, 0), (1690, 0), (1700, 1), (1710, 0), (1720, 0), (1730, 0), (1740, 1), (1750, 1), (1760, 0), (1770, 0), (1780, 0), (1790, 0), (1800, 0), (1810, 0), (1820, 1), (1830, 0), (1840, 1), (1850, 1), (1860, 0), (1870, 0), (1880, 0), (1890, 0), (1900, 1), (1910, 0), (1920, 1), (1930, 0), (1940, 0), (1950, 0), (1960, 0), (1970, 0), (1980, 0), (1990, 0), (2000, 0), (2010, 0), (2020, 0), (2030, 0), (2040, 0), (2050, 1)]
VCSB0 CSB0 0 PWL (0n 5.0v 9.45n 5.0v 9.55n 0.0v 19.45n 0.0v 19.55n 0.0v 29.45n 0.0v 29.55n 0.0v 39.45n 0.0v 39.55n 0.0v 49.45n 0.0v 49.55n 0.0v 59.45n 0.0v 59.55n 0.0v 69.45n 0.0v 69.55n 0.0v 79.45n 0.0v 79.55n 5.0v 89.45n 5.0v 89.55n 0.0v 99.45n 0.0v 99.55n 0.0v 109.45n 0.0v 109.55n 0.0v 119.45n 0.0v 119.55n 0.0v 129.45n 0.0v 129.55n 5.0v 139.45n 5.0v 139.55n 0.0v 149.45n 0.0v 149.55n 0.0v 159.45n 0.0v 159.55n 0.0v 169.45n 0.0v 169.55n 5.0v 179.45n 5.0v 179.55n 5.0v 189.45n 5.0v 189.55n 0.0v 199.45n 0.0v 199.55n 0.0v 209.45n 0.0v 209.55n 0.0v 219.45n 0.0v 219.55n 0.0v 229.45n 0.0v 229.55n 0.0v 239.45n 0.0v 239.55n 0.0v 249.45n 0.0v 249.55n 0.0v 259.45n 0.0v 259.55n 5.0v 269.45n 5.0v 269.55n 5.0v 279.45n 5.0v 279.55n 0.0v 289.45n 0.0v 289.55n 0.0v 299.45n 0.0v 299.55n 0.0v 309.45n 0.0v 309.55n 0.0v 319.45n 0.0v 319.55n 0.0v 329.45n 0.0v 329.55n 0.0v 339.45n 0.0v 339.55n 0.0v 349.45n 0.0v 349.55n 5.0v 359.45n 5.0v 359.55n 0.0v 369.45n 0.0v 369.55n 0.0v 379.45n 0.0v 379.55n 0.0v 389.45n 0.0v 389.55n 0.0v 399.45n 0.0v 399.55n 0.0v 409.45n 0.0v 409.55n 5.0v 419.45n 5.0v 419.55n 5.0v 429.45n 5.0v 429.55n 0.0v 439.45n 0.0v 439.55n 0.0v 449.45n 0.0v 449.55n 0.0v 459.45n 0.0v 459.55n 5.0v 469.45n 5.0v 469.55n 0.0v 479.45n 0.0v 479.55n 0.0v 489.45n 0.0v 489.55n 0.0v 499.45n 0.0v 499.55n 0.0v 509.45n 0.0v 509.55n 0.0v 519.45n 0.0v 519.55n 0.0v 529.45n 0.0v 529.55n 0.0v 539.45n 0.0v 539.55n 0.0v 549.45n 0.0v 549.55n 0.0v 559.45n 0.0v 559.55n 0.0v 569.45n 0.0v 569.55n 0.0v 579.45n 0.0v 579.55n 5.0v 589.45n 5.0v 589.55n 0.0v 599.45n 0.0v 599.55n 0.0v 609.45n 0.0v 609.55n 5.0v 619.45n 5.0v 619.55n 0.0v 629.45n 0.0v 629.55n 0.0v 639.45n 0.0v 639.55n 5.0v 649.45n 5.0v 649.55n 0.0v 659.45n 0.0v 659.55n 0.0v 669.45n 0.0v 669.55n 5.0v 679.45n 5.0v 679.55n 0.0v 689.45n 0.0v 689.55n 5.0v 699.45n 5.0v 699.55n 0.0v 709.45n 0.0v 709.55n 0.0v 719.45n 0.0v 719.55n 0.0v 729.45n 0.0v 729.55n 0.0v 739.45n 0.0v 739.55n 0.0v 749.45n 0.0v 749.55n 0.0v 759.45n 0.0v 759.55n 0.0v 769.45n 0.0v 769.55n 5.0v 779.45n 5.0v 779.55n 0.0v 789.45n 0.0v 789.55n 0.0v 799.45n 0.0v 799.55n 0.0v 809.45n 0.0v 809.55n 0.0v 819.45n 0.0v 819.55n 5.0v 829.45n 5.0v 829.55n 0.0v 839.45n 0.0v 839.55n 0.0v 849.45n 0.0v 849.55n 5.0v 859.45n 5.0v 859.55n 0.0v 869.45n 0.0v 869.55n 0.0v 879.45n 0.0v 879.55n 5.0v 889.45n 5.0v 889.55n 0.0v 899.45n 0.0v 899.55n 0.0v 909.45n 0.0v 909.55n 5.0v 919.45n 5.0v 919.55n 5.0v 929.45n 5.0v 929.55n 0.0v 939.45n 0.0v 939.55n 5.0v 949.45n 5.0v 949.55n 0.0v 959.45n 0.0v 959.55n 5.0v 969.45n 5.0v 969.55n 5.0v 979.45n 5.0v 979.55n 0.0v 989.45n 0.0v 989.55n 5.0v 999.45n 5.0v 999.55n 0.0v 1009.45n 0.0v 1009.55n 0.0v 1019.45n 0.0v 1019.55n 0.0v 1029.45n 0.0v 1029.55n 0.0v 1039.45n 0.0v 1039.55n 0.0v 1049.45n 0.0v 1049.55n 0.0v 1059.45n 0.0v 1059.55n 0.0v 1069.45n 0.0v 1069.55n 0.0v 1079.45n 0.0v 1079.55n 0.0v 1089.45n 0.0v 1089.55n 0.0v 1099.45n 0.0v 1099.55n 5.0v 1109.45n 5.0v 1109.55n 0.0v 1119.45n 0.0v 1119.55n 0.0v 1129.45n 0.0v 1129.55n 0.0v 1139.45n 0.0v 1139.55n 5.0v 1149.45n 5.0v 1149.55n 0.0v 1159.45n 0.0v 1159.55n 0.0v 1169.45n 0.0v 1169.55n 0.0v 1179.45n 0.0v 1179.55n 0.0v 1189.45n 0.0v 1189.55n 0.0v 1199.45n 0.0v 1199.55n 0.0v 1209.45n 0.0v 1209.55n 0.0v 1219.45n 0.0v 1219.55n 5.0v 1229.45n 5.0v 1229.55n 5.0v 1239.45n 5.0v 1239.55n 0.0v 1249.45n 0.0v 1249.55n 0.0v 1259.45n 0.0v 1259.55n 5.0v 1269.45n 5.0v 1269.55n 0.0v 1279.45n 0.0v 1279.55n 0.0v 1289.45n 0.0v 1289.55n 0.0v 1299.45n 0.0v 1299.55n 0.0v 1309.45n 0.0v 1309.55n 0.0v 1319.45n 0.0v 1319.55n 5.0v 1329.45n 5.0v 1329.55n 0.0v 1339.45n 0.0v 1339.55n 0.0v 1349.45n 0.0v 1349.55n 5.0v 1359.45n 5.0v 1359.55n 0.0v 1369.45n 0.0v 1369.55n 5.0v 1379.45n 5.0v 1379.55n 0.0v 1389.45n 0.0v 1389.55n 5.0v 1399.45n 5.0v 1399.55n 0.0v 1409.45n 0.0v 1409.55n 5.0v 1419.45n 5.0v 1419.55n 0.0v 1429.45n 0.0v 1429.55n 5.0v 1439.45n 5.0v 1439.55n 0.0v 1449.45n 0.0v 1449.55n 5.0v 1459.45n 5.0v 1459.55n 0.0v 1469.45n 0.0v 1469.55n 0.0v 1479.45n 0.0v 1479.55n 0.0v 1489.45n 0.0v 1489.55n 0.0v 1499.45n 0.0v 1499.55n 5.0v 1509.45n 5.0v 1509.55n 0.0v 1519.45n 0.0v 1519.55n 0.0v 1529.45n 0.0v 1529.55n 5.0v 1539.45n 5.0v 1539.55n 0.0v 1549.45n 0.0v 1549.55n 0.0v 1559.45n 0.0v 1559.55n 0.0v 1569.45n 0.0v 1569.55n 0.0v 1579.45n 0.0v 1579.55n 5.0v 1589.45n 5.0v 1589.55n 0.0v 1599.45n 0.0v 1599.55n 0.0v 1609.45n 0.0v 1609.55n 0.0v 1619.45n 0.0v 1619.55n 5.0v 1629.45n 5.0v 1629.55n 0.0v 1639.45n 0.0v 1639.55n 0.0v 1649.45n 0.0v 1649.55n 5.0v 1659.45n 5.0v 1659.55n 5.0v 1669.45n 5.0v 1669.55n 0.0v 1679.45n 0.0v 1679.55n 0.0v 1689.45n 0.0v 1689.55n 0.0v 1699.45n 0.0v 1699.55n 5.0v 1709.45n 5.0v 1709.55n 0.0v 1719.45n 0.0v 1719.55n 0.0v 1729.45n 0.0v 1729.55n 0.0v 1739.45n 0.0v 1739.55n 5.0v 1749.45n 5.0v 1749.55n 5.0v 1759.45n 5.0v 1759.55n 0.0v 1769.45n 0.0v 1769.55n 0.0v 1779.45n 0.0v 1779.55n 0.0v 1789.45n 0.0v 1789.55n 0.0v 1799.45n 0.0v 1799.55n 0.0v 1809.45n 0.0v 1809.55n 0.0v 1819.45n 0.0v 1819.55n 5.0v 1829.45n 5.0v 1829.55n 0.0v 1839.45n 0.0v 1839.55n 5.0v 1849.45n 5.0v 1849.55n 5.0v 1859.45n 5.0v 1859.55n 0.0v 1869.45n 0.0v 1869.55n 0.0v 1879.45n 0.0v 1879.55n 0.0v 1889.45n 0.0v 1889.55n 0.0v 1899.45n 0.0v 1899.55n 5.0v 1909.45n 5.0v 1909.55n 0.0v 1919.45n 0.0v 1919.55n 5.0v 1929.45n 5.0v 1929.55n 0.0v 1939.45n 0.0v 1939.55n 0.0v 1949.45n 0.0v 1949.55n 0.0v 1959.45n 0.0v 1959.55n 0.0v 1969.45n 0.0v 1969.55n 0.0v 1979.45n 0.0v 1979.55n 0.0v 1989.45n 0.0v 1989.55n 0.0v 1999.45n 0.0v 1999.55n 0.0v 2009.45n 0.0v 2009.55n 0.0v 2019.45n 0.0v 2019.55n 0.0v 2029.45n 0.0v 2029.55n 0.0v 2039.45n 0.0v 2039.55n 0.0v 2049.45n 0.0v 2049.55n 5.0v )
* (time, data): [(0, 1), (10, 1), (20, 1), (30, 1), (40, 0), (50, 1), (60, 1), (70, 1), (80, 1), (90, 0), (100, 1), (110, 0), (120, 0), (130, 1), (140, 1), (150, 0), (160, 1), (170, 0), (180, 1), (190, 1), (200, 1), (210, 1), (220, 0), (230, 1), (240, 1), (250, 0), (260, 0), (270, 1), (280, 1), (290, 1), (300, 0), (310, 1), (320, 0), (330, 0), (340, 1), (350, 0), (360, 0), (370, 1), (380, 0), (390, 0), (400, 0), (410, 1), (420, 1), (430, 1), (440, 1), (450, 0), (460, 1), (470, 1), (480, 0), (490, 1), (500, 0), (510, 1), (520, 1), (530, 0), (540, 0), (550, 1), (560, 1), (570, 1), (580, 1), (590, 0), (600, 1), (610, 1), (620, 1), (630, 0), (640, 1), (650, 1), (660, 1), (670, 1), (680, 0), (690, 1), (700, 0), (710, 1), (720, 1), (730, 1), (740, 1), (750, 1), (760, 0), (770, 1), (780, 0), (790, 0), (800, 0), (810, 1), (820, 0), (830, 0), (840, 1), (850, 1), (860, 1), (870, 1), (880, 0), (890, 1), (900, 0), (910, 0), (920, 0), (930, 0), (940, 0), (950, 0), (960, 1), (970, 1), (980, 1), (990, 0), (1000, 1), (1010, 1), (1020, 1), (1030, 1), (1040, 0), (1050, 0), (1060, 1), (1070, 1), (1080, 1), (1090, 1), (1100, 1), (1110, 1), (1120, 1), (1130, 0), (1140, 1), (1150, 0), (1160, 1), (1170, 1), (1180, 0), (1190, 0), (1200, 0), (1210, 0), (1220, 1), (1230, 1), (1240, 1), (1250, 0), (1260, 1), (1270, 0), (1280, 0), (1290, 0), (1300, 1), (1310, 1), (1320, 0), (1330, 0), (1340, 0), (1350, 1), (1360, 1), (1370, 0), (1380, 0), (1390, 0), (1400, 1), (1410, 1), (1420, 1), (1430, 1), (1440, 1), (1450, 1), (1460, 0), (1470, 0), (1480, 0), (1490, 0), (1500, 1), (1510, 0), (1520, 1), (1530, 0), (1540, 0), (1550, 0), (1560, 0), (1570, 1), (1580, 1), (1590, 1), (1600, 0), (1610, 1), (1620, 0), (1630, 1), (1640, 1), (1650, 1), (1660, 0), (1670, 1), (1680, 1), (1690, 0), (1700, 0), (1710, 1), (1720, 1), (1730, 0), (1740, 1), (1750, 1), (1760, 0), (1770, 0), (1780, 1), (1790, 0), (1800, 1), (1810, 1), (1820, 1), (1830, 1), (1840, 0), (1850, 1), (1860, 1), (1870, 1), (1880, 0), (1890, 1), (1900, 0), (1910, 0), (1920, 0), (1930, 0), (1940, 0), (1950, 1), (1960, 0), (1970, 0), (1980, 0), (1990, 1), (2000, 1), (2010, 0), (2020, 1), (2030, 0), (2040, 1), (2050, 1)]
VCSB1 CSB1 0 PWL (0n 5.0v 9.45n 5.0v 9.55n 5.0v 19.45n 5.0v 19.55n 5.0v 29.45n 5.0v 29.55n 5.0v 39.45n 5.0v 39.55n 0.0v 49.45n 0.0v 49.55n 5.0v 59.45n 5.0v 59.55n 5.0v 69.45n 5.0v 69.55n 5.0v 79.45n 5.0v 79.55n 5.0v 89.45n 5.0v 89.55n 0.0v 99.45n 0.0v 99.55n 5.0v 109.45n 5.0v 109.55n 0.0v 119.45n 0.0v 119.55n 0.0v 129.45n 0.0v 129.55n 5.0v 139.45n 5.0v 139.55n 5.0v 149.45n 5.0v 149.55n 0.0v 159.45n 0.0v 159.55n 5.0v 169.45n 5.0v 169.55n 0.0v 179.45n 0.0v 179.55n 5.0v 189.45n 5.0v 189.55n 5.0v 199.45n 5.0v 199.55n 5.0v 209.45n 5.0v 209.55n 5.0v 219.45n 5.0v 219.55n 0.0v 229.45n 0.0v 229.55n 5.0v 239.45n 5.0v 239.55n 5.0v 249.45n 5.0v 249.55n 0.0v 259.45n 0.0v 259.55n 0.0v 269.45n 0.0v 269.55n 5.0v 279.45n 5.0v 279.55n 5.0v 289.45n 5.0v 289.55n 5.0v 299.45n 5.0v 299.55n 0.0v 309.45n 0.0v 309.55n 5.0v 319.45n 5.0v 319.55n 0.0v 329.45n 0.0v 329.55n 0.0v 339.45n 0.0v 339.55n 5.0v 349.45n 5.0v 349.55n 0.0v 359.45n 0.0v 359.55n 0.0v 369.45n 0.0v 369.55n 5.0v 379.45n 5.0v 379.55n 0.0v 389.45n 0.0v 389.55n 0.0v 399.45n 0.0v 399.55n 0.0v 409.45n 0.0v 409.55n 5.0v 419.45n 5.0v 419.55n 5.0v 429.45n 5.0v 429.55n 5.0v 439.45n 5.0v 439.55n 5.0v 449.45n 5.0v 449.55n 0.0v 459.45n 0.0v 459.55n 5.0v 469.45n 5.0v 469.55n 5.0v 479.45n 5.0v 479.55n 0.0v 489.45n 0.0v 489.55n 5.0v 499.45n 5.0v 499.55n 0.0v 509.45n 0.0v 509.55n 5.0v 519.45n 5.0v 519.55n 5.0v 529.45n 5.0v 529.55n 0.0v 539.45n 0.0v 539.55n 0.0v 549.45n 0.0v 549.55n 5.0v 559.45n 5.0v 559.55n 5.0v 569.45n 5.0v 569.55n 5.0v 579.45n 5.0v 579.55n 5.0v 589.45n 5.0v 589.55n 0.0v 599.45n 0.0v 599.55n 5.0v 609.45n 5.0v 609.55n 5.0v 619.45n 5.0v 619.55n 5.0v 629.45n 5.0v 629.55n 0.0v 639.45n 0.0v 639.55n 5.0v 649.45n 5.0v 649.55n 5.0v 659.45n 5.0v 659.55n 5.0v 669.45n 5.0v 669.55n 5.0v 679.45n 5.0v 679.55n 0.0v 689.45n 0.0v 689.55n 5.0v 699.45n 5.0v 699.55n 0.0v 709.45n 0.0v 709.55n 5.0v 719.45n 5.0v 719.55n 5.0v 729.45n 5.0v 729.55n 5.0v 739.45n 5.0v 739.55n 5.0v 749.45n 5.0v 749.55n 5.0v 759.45n 5.0v 759.55n 0.0v 769.45n 0.0v 769.55n 5.0v 779.45n 5.0v 779.55n 0.0v 789.45n 0.0v 789.55n 0.0v 799.45n 0.0v 799.55n 0.0v 809.45n 0.0v 809.55n 5.0v 819.45n 5.0v 819.55n 0.0v 829.45n 0.0v 829.55n 0.0v 839.45n 0.0v 839.55n 5.0v 849.45n 5.0v 849.55n 5.0v 859.45n 5.0v 859.55n 5.0v 869.45n 5.0v 869.55n 5.0v 879.45n 5.0v 879.55n 0.0v 889.45n 0.0v 889.55n 5.0v 899.45n 5.0v 899.55n 0.0v 909.45n 0.0v 909.55n 0.0v 919.45n 0.0v 919.55n 0.0v 929.45n 0.0v 929.55n 0.0v 939.45n 0.0v 939.55n 0.0v 949.45n 0.0v 949.55n 0.0v 959.45n 0.0v 959.55n 5.0v 969.45n 5.0v 969.55n 5.0v 979.45n 5.0v 979.55n 5.0v 989.45n 5.0v 989.55n 0.0v 999.45n 0.0v 999.55n 5.0v 1009.45n 5.0v 1009.55n 5.0v 1019.45n 5.0v 1019.55n 5.0v 1029.45n 5.0v 1029.55n 5.0v 1039.45n 5.0v 1039.55n 0.0v 1049.45n 0.0v 1049.55n 0.0v 1059.45n 0.0v 1059.55n 5.0v 1069.45n 5.0v 1069.55n 5.0v 1079.45n 5.0v 1079.55n 5.0v 1089.45n 5.0v 1089.55n 5.0v 1099.45n 5.0v 1099.55n 5.0v 1109.45n 5.0v 1109.55n 5.0v 1119.45n 5.0v 1119.55n 5.0v 1129.45n 5.0v 1129.55n 0.0v 1139.45n 0.0v 1139.55n 5.0v 1149.45n 5.0v 1149.55n 0.0v 1159.45n 0.0v 1159.55n 5.0v 1169.45n 5.0v 1169.55n 5.0v 1179.45n 5.0v 1179.55n 0.0v 1189.45n 0.0v 1189.55n 0.0v 1199.45n 0.0v 1199.55n 0.0v 1209.45n 0.0v 1209.55n 0.0v 1219.45n 0.0v 1219.55n 5.0v 1229.45n 5.0v 1229.55n 5.0v 1239.45n 5.0v 1239.55n 5.0v 1249.45n 5.0v 1249.55n 0.0v 1259.45n 0.0v 1259.55n 5.0v 1269.45n 5.0v 1269.55n 0.0v 1279.45n 0.0v 1279.55n 0.0v 1289.45n 0.0v 1289.55n 0.0v 1299.45n 0.0v 1299.55n 5.0v 1309.45n 5.0v 1309.55n 5.0v 1319.45n 5.0v 1319.55n 0.0v 1329.45n 0.0v 1329.55n 0.0v 1339.45n 0.0v 1339.55n 0.0v 1349.45n 0.0v 1349.55n 5.0v 1359.45n 5.0v 1359.55n 5.0v 1369.45n 5.0v 1369.55n 0.0v 1379.45n 0.0v 1379.55n 0.0v 1389.45n 0.0v 1389.55n 0.0v 1399.45n 0.0v 1399.55n 5.0v 1409.45n 5.0v 1409.55n 5.0v 1419.45n 5.0v 1419.55n 5.0v 1429.45n 5.0v 1429.55n 5.0v 1439.45n 5.0v 1439.55n 5.0v 1449.45n 5.0v 1449.55n 5.0v 1459.45n 5.0v 1459.55n 0.0v 1469.45n 0.0v 1469.55n 0.0v 1479.45n 0.0v 1479.55n 0.0v 1489.45n 0.0v 1489.55n 0.0v 1499.45n 0.0v 1499.55n 5.0v 1509.45n 5.0v 1509.55n 0.0v 1519.45n 0.0v 1519.55n 5.0v 1529.45n 5.0v 1529.55n 0.0v 1539.45n 0.0v 1539.55n 0.0v 1549.45n 0.0v 1549.55n 0.0v 1559.45n 0.0v 1559.55n 0.0v 1569.45n 0.0v 1569.55n 5.0v 1579.45n 5.0v 1579.55n 5.0v 1589.45n 5.0v 1589.55n 5.0v 1599.45n 5.0v 1599.55n 0.0v 1609.45n 0.0v 1609.55n 5.0v 1619.45n 5.0v 1619.55n 0.0v 1629.45n 0.0v 1629.55n 5.0v 1639.45n 5.0v 1639.55n 5.0v 1649.45n 5.0v 1649.55n 5.0v 1659.45n 5.0v 1659.55n 0.0v 1669.45n 0.0v 1669.55n 5.0v 1679.45n 5.0v 1679.55n 5.0v 1689.45n 5.0v 1689.55n 0.0v 1699.45n 0.0v 1699.55n 0.0v 1709.45n 0.0v 1709.55n 5.0v 1719.45n 5.0v 1719.55n 5.0v 1729.45n 5.0v 1729.55n 0.0v 1739.45n 0.0v 1739.55n 5.0v 1749.45n 5.0v 1749.55n 5.0v 1759.45n 5.0v 1759.55n 0.0v 1769.45n 0.0v 1769.55n 0.0v 1779.45n 0.0v 1779.55n 5.0v 1789.45n 5.0v 1789.55n 0.0v 1799.45n 0.0v 1799.55n 5.0v 1809.45n 5.0v 1809.55n 5.0v 1819.45n 5.0v 1819.55n 5.0v 1829.45n 5.0v 1829.55n 5.0v 1839.45n 5.0v 1839.55n 0.0v 1849.45n 0.0v 1849.55n 5.0v 1859.45n 5.0v 1859.55n 5.0v 1869.45n 5.0v 1869.55n 5.0v 1879.45n 5.0v 1879.55n 0.0v 1889.45n 0.0v 1889.55n 5.0v 1899.45n 5.0v 1899.55n 0.0v 1909.45n 0.0v 1909.55n 0.0v 1919.45n 0.0v 1919.55n 0.0v 1929.45n 0.0v 1929.55n 0.0v 1939.45n 0.0v 1939.55n 0.0v 1949.45n 0.0v 1949.55n 5.0v 1959.45n 5.0v 1959.55n 0.0v 1969.45n 0.0v 1969.55n 0.0v 1979.45n 0.0v 1979.55n 0.0v 1989.45n 0.0v 1989.55n 5.0v 1999.45n 5.0v 1999.55n 5.0v 2009.45n 5.0v 2009.55n 0.0v 2019.45n 0.0v 2019.55n 5.0v 2029.45n 5.0v 2029.55n 0.0v 2039.45n 0.0v 2039.55n 5.0v 2049.45n 5.0v 2049.55n 5.0v )
* (time, data): [(0, 1), (10, 0), (20, 0), (30, 0), (40, 1), (50, 1), (60, 1), (70, 1), (80, 1), (90, 1), (100, 1), (110, 0), (120, 0), (130, 1), (140, 0), (150, 1), (160, 1), (170, 1), (180, 1), (190, 0), (200, 1), (210, 0), (220, 1), (230, 1), (240, 1), (250, 1), (260, 1), (270, 1), (280, 1), (290, 1), (300, 1), (310, 0), (320, 0), (330, 1), (340, 1), (350, 1), (360, 1), (370, 0), (380, 1), (390, 0), (400, 1), (410, 1), (420, 1), (430, 0), (440, 1), (450, 1), (460, 1), (470, 0), (480, 1), (490, 1), (500, 1), (510, 0), (520, 0), (530, 1), (540, 1), (550, 1), (560, 0), (570, 0), (580, 1), (590, 1), (600, 1), (610, 1), (620, 0), (630, 1), (640, 1), (650, 1), (660, 1), (670, 1), (680, 1), (690, 1), (700, 1), (710, 0), (720, 1), (730, 1), (740, 1), (750, 1), (760, 1), (770, 1), (780, 1), (790, 1), (800, 1), (810, 0), (820, 1), (830, 1), (840, 1), (850, 1), (860, 1), (870, 0), (880, 1), (890, 0), (900, 1), (910, 1), (920, 1), (930, 1), (940, 1), (950, 1), (960, 1), (970, 1), (980, 1), (990, 1), (1000, 0), (1010, 1), (1020, 0), (1030, 1), (1040, 1), (1050, 1), (1060, 1), (1070, 0), (1080, 0), (1090, 1), (1100, 1), (1110, 0), (1120, 0), (1130, 0), (1140, 1), (1150, 1), (1160, 0), (1170, 1), (1180, 1), (1190, 1), (1200, 1), (1210, 1), (1220, 1), (1230, 1), (1240, 1), (1250, 1), (1260, 1), (1270, 1), (1280, 1), (1290, 0), (1300, 1), (1310, 0), (1320, 1), (1330, 1), (1340, 1), (1350, 1), (1360, 1), (1370, 1), (1380, 1), (1390, 1), (1400, 1), (1410, 1), (1420, 1), (1430, 1), (1440, 1), (1450, 1), (1460, 0), (1470, 0), (1480, 1), (1490, 1), (1500, 1), (1510, 1), (1520, 0), (1530, 1), (1540, 1), (1550, 1), (1560, 0), (1570, 1), (1580, 1), (1590, 0), (1600, 1), (1610, 0), (1620, 1), (1630, 1), (1640, 1), (1650, 1), (1660, 1), (1670, 1), (1680, 1), (1690, 1), (1700, 1), (1710, 1), (1720, 0), (1730, 1), (1740, 1), (1750, 1), (1760, 1), (1770, 0), (1780, 0), (1790, 1), (1800, 1), (1810, 1), (1820, 1), (1830, 1), (1840, 1), (1850, 1), (1860, 0), (1870, 1), (1880, 0), (1890, 0), (1900, 1), (1910, 0), (1920, 1), (1930, 1), (1940, 1), (1950, 1), (1960, 1), (1970, 0), (1980, 1), (1990, 1), (2000, 1), (2010, 0), (2020, 1), (2030, 0), (2040, 0), (2050, 1)]
VWEB0 WEB0 0 PWL (0n 5.0v 9.45n 5.0v 9.55n 0.0v 19.45n 0.0v 19.55n 0.0v 29.45n 0.0v 29.55n 0.0v 39.45n 0.0v 39.55n 5.0v 49.45n 5.0v 49.55n 5.0v 59.45n 5.0v 59.55n 5.0v 69.45n 5.0v 69.55n 5.0v 79.45n 5.0v 79.55n 5.0v 89.45n 5.0v 89.55n 5.0v 99.45n 5.0v 99.55n 5.0v 109.45n 5.0v 109.55n 0.0v 119.45n 0.0v 119.55n 0.0v 129.45n 0.0v 129.55n 5.0v 139.45n 5.0v 139.55n 0.0v 149.45n 0.0v 149.55n 5.0v 159.45n 5.0v 159.55n 5.0v 169.45n 5.0v 169.55n 5.0v 179.45n 5.0v 179.55n 5.0v 189.45n 5.0v 189.55n 0.0v 199.45n 0.0v 199.55n 5.0v 209.45n 5.0v 209.55n 0.0v 219.45n 0.0v 219.55n 5.0v 229.45n 5.0v 229.55n 5.0v 239.45n 5.0v 239.55n 5.0v 249.45n 5.0v 249.55n 5.0v 259.45n 5.0v 259.55n 5.0v 269.45n 5.0v 269.55n 5.0v 279.45n 5.0v 279.55n 5.0v 289.45n 5.0v 289.55n 5.0v 299.45n 5.0v 299.55n 5.0v 309.45n 5.0v 309.55n 0.0v 319.45n 0.0v 319.55n 0.0v 329.45n 0.0v 329.55n 5.0v 339.45n 5.0v 339.55n 5.0v 349.45n 5.0v 349.55n 5.0v 359.45n 5.0v 359.55n 5.0v 369.45n 5.0v 369.55n 0.0v 379.45n 0.0v 379.55n 5.0v 389.45n 5.0v 389.55n 0.0v 399.45n 0.0v 399.55n 5.0v 409.45n 5.0v 409.55n 5.0v 419.45n 5.0v 419.55n 5.0v 429.45n 5.0v 429.55n 0.0v 439.45n 0.0v 439.55n 5.0v 449.45n 5.0v 449.55n 5.0v 459.45n 5.0v 459.55n 5.0v 469.45n 5.0v 469.55n 0.0v 479.45n 0.0v 479.55n 5.0v 489.45n 5.0v 489.55n 5.0v 499.45n 5.0v 499.55n 5.0v 509.45n 5.0v 509.55n 0.0v 519.45n 0.0v 519.55n 0.0v 529.45n 0.0v 529.55n 5.0v 539.45n 5.0v 539.55n 5.0v 549.45n 5.0v 549.55n 5.0v 559.45n 5.0v 559.55n 0.0v 569.45n 0.0v 569.55n 0.0v 579.45n 0.0v 579.55n 5.0v 589.45n 5.0v 589.55n 5.0v 599.45n 5.0v 599.55n 5.0v 609.45n 5.0v 609.55n 5.0v 619.45n 5.0v 619.55n 0.0v 629.45n 0.0v 629.55n 5.0v 639.45n 5.0v 639.55n 5.0v 649.45n 5.0v 649.55n 5.0v 659.45n 5.0v 659.55n 5.0v 669.45n 5.0v 669.55n 5.0v 679.45n 5.0v 679.55n 5.0v 689.45n 5.0v 689.55n 5.0v 699.45n 5.0v 699.55n 5.0v 709.45n 5.0v 709.55n 0.0v 719.45n 0.0v 719.55n 5.0v 729.45n 5.0v 729.55n 5.0v 739.45n 5.0v 739.55n 5.0v 749.45n 5.0v 749.55n 5.0v 759.45n 5.0v 759.55n 5.0v 769.45n 5.0v 769.55n 5.0v 779.45n 5.0v 779.55n 5.0v 789.45n 5.0v 789.55n 5.0v 799.45n 5.0v 799.55n 5.0v 809.45n 5.0v 809.55n 0.0v 819.45n 0.0v 819.55n 5.0v 829.45n 5.0v 829.55n 5.0v 839.45n 5.0v 839.55n 5.0v 849.45n 5.0v 849.55n 5.0v 859.45n 5.0v 859.55n 5.0v 869.45n 5.0v 869.55n 0.0v 879.45n 0.0v 879.55n 5.0v 889.45n 5.0v 889.55n 0.0v 899.45n 0.0v 899.55n 5.0v 909.45n 5.0v 909.55n 5.0v 919.45n 5.0v 919.55n 5.0v 929.45n 5.0v 929.55n 5.0v 939.45n 5.0v 939.55n 5.0v 949.45n 5.0v 949.55n 5.0v 959.45n 5.0v 959.55n 5.0v 969.45n 5.0v 969.55n 5.0v 979.45n 5.0v 979.55n 5.0v 989.45n 5.0v 989.55n 5.0v 999.45n 5.0v 999.55n 0.0v 1009.45n 0.0v 1009.55n 5.0v 1019.45n 5.0v 1019.55n 0.0v 1029.45n 0.0v 1029.55n 5.0v 1039.45n 5.0v 1039.55n 5.0v 1049.45n 5.0v 1049.55n 5.0v 1059.45n 5.0v 1059.55n 5.0v 1069.45n 5.0v 1069.55n 0.0v 1079.45n 0.0v 1079.55n 0.0v 1089.45n 0.0v 1089.55n 5.0v 1099.45n 5.0v 1099.55n 5.0v 1109.45n 5.0v 1109.55n 0.0v 1119.45n 0.0v 1119.55n 0.0v 1129.45n 0.0v 1129.55n 0.0v 1139.45n 0.0v 1139.55n 5.0v 1149.45n 5.0v 1149.55n 5.0v 1159.45n 5.0v 1159.55n 0.0v 1169.45n 0.0v 1169.55n 5.0v 1179.45n 5.0v 1179.55n 5.0v 1189.45n 5.0v 1189.55n 5.0v 1199.45n 5.0v 1199.55n 5.0v 1209.45n 5.0v 1209.55n 5.0v 1219.45n 5.0v 1219.55n 5.0v 1229.45n 5.0v 1229.55n 5.0v 1239.45n 5.0v 1239.55n 5.0v 1249.45n 5.0v 1249.55n 5.0v 1259.45n 5.0v 1259.55n 5.0v 1269.45n 5.0v 1269.55n 5.0v 1279.45n 5.0v 1279.55n 5.0v 1289.45n 5.0v 1289.55n 0.0v 1299.45n 0.0v 1299.55n 5.0v 1309.45n 5.0v 1309.55n 0.0v 1319.45n 0.0v 1319.55n 5.0v 1329.45n 5.0v 1329.55n 5.0v 1339.45n 5.0v 1339.55n 5.0v 1349.45n 5.0v 1349.55n 5.0v 1359.45n 5.0v 1359.55n 5.0v 1369.45n 5.0v 1369.55n 5.0v 1379.45n 5.0v 1379.55n 5.0v 1389.45n 5.0v 1389.55n 5.0v 1399.45n 5.0v 1399.55n 5.0v 1409.45n 5.0v 1409.55n 5.0v 1419.45n 5.0v 1419.55n 5.0v 1429.45n 5.0v 1429.55n 5.0v 1439.45n 5.0v 1439.55n 5.0v 1449.45n 5.0v 1449.55n 5.0v 1459.45n 5.0v 1459.55n 0.0v 1469.45n 0.0v 1469.55n 0.0v 1479.45n 0.0v 1479.55n 5.0v 1489.45n 5.0v 1489.55n 5.0v 1499.45n 5.0v 1499.55n 5.0v 1509.45n 5.0v 1509.55n 5.0v 1519.45n 5.0v 1519.55n 0.0v 1529.45n 0.0v 1529.55n 5.0v 1539.45n 5.0v 1539.55n 5.0v 1549.45n 5.0v 1549.55n 5.0v 1559.45n 5.0v 1559.55n 0.0v 1569.45n 0.0v 1569.55n 5.0v 1579.45n 5.0v 1579.55n 5.0v 1589.45n 5.0v 1589.55n 0.0v 1599.45n 0.0v 1599.55n 5.0v 1609.45n 5.0v 1609.55n 0.0v 1619.45n 0.0v 1619.55n 5.0v 1629.45n 5.0v 1629.55n 5.0v 1639.45n 5.0v 1639.55n 5.0v 1649.45n 5.0v 1649.55n 5.0v 1659.45n 5.0v 1659.55n 5.0v 1669.45n 5.0v 1669.55n 5.0v 1679.45n 5.0v 1679.55n 5.0v 1689.45n 5.0v 1689.55n 5.0v 1699.45n 5.0v 1699.55n 5.0v 1709.45n 5.0v 1709.55n 5.0v 1719.45n 5.0v 1719.55n 0.0v 1729.45n 0.0v 1729.55n 5.0v 1739.45n 5.0v 1739.55n 5.0v 1749.45n 5.0v 1749.55n 5.0v 1759.45n 5.0v 1759.55n 5.0v 1769.45n 5.0v 1769.55n 0.0v 1779.45n 0.0v 1779.55n 0.0v 1789.45n 0.0v 1789.55n 5.0v 1799.45n 5.0v 1799.55n 5.0v 1809.45n 5.0v 1809.55n 5.0v 1819.45n 5.0v 1819.55n 5.0v 1829.45n 5.0v 1829.55n 5.0v 1839.45n 5.0v 1839.55n 5.0v 1849.45n 5.0v 1849.55n 5.0v 1859.45n 5.0v 1859.55n 0.0v 1869.45n 0.0v 1869.55n 5.0v 1879.45n 5.0v 1879.55n 0.0v 1889.45n 0.0v 1889.55n 0.0v 1899.45n 0.0v 1899.55n 5.0v 1909.45n 5.0v 1909.55n 0.0v 1919.45n 0.0v 1919.55n 5.0v 1929.45n 5.0v 1929.55n 5.0v 1939.45n 5.0v 1939.55n 5.0v 1949.45n 5.0v 1949.55n 5.0v 1959.45n 5.0v 1959.55n 5.0v 1969.45n 5.0v 1969.55n 0.0v 1979.45n 0.0v 1979.55n 5.0v 1989.45n 5.0v 1989.55n 5.0v 1999.45n 5.0v 1999.55n 5.0v 2009.45n 5.0v 2009.55n 0.0v 2019.45n 0.0v 2019.55n 5.0v 2029.45n 5.0v 2029.55n 0.0v 2039.45n 0.0v 2039.55n 0.0v 2049.45n 0.0v 2049.55n 5.0v )
* PULSE: period=10
Vclk0 clk0 0 PULSE (0 5.0 9.95n 0.1n 0.1n 4.9n 10n)
* PULSE: period=10
Vclk1 clk1 0 PULSE (0 5.0 9.95n 0.1n 0.1n 4.9n 10n)

 * Generation of dout measurements
* CHECK dout0_0 vdout0_0ck4 = 0 time = 50
* CHECK dout0_1 vdout0_1ck4 = 5.0 time = 50
* CHECK dout1_0 vdout1_0ck4 = 0 time = 50
* CHECK dout1_1 vdout1_1ck4 = 5.0 time = 50
* CHECK dout0_0 vdout0_0ck5 = 0 time = 60
* CHECK dout0_1 vdout0_1ck5 = 5.0 time = 60
* CHECK dout0_0 vdout0_0ck6 = 0 time = 70
* CHECK dout0_1 vdout0_1ck6 = 5.0 time = 70
* CHECK dout0_0 vdout0_0ck7 = 0 time = 80
* CHECK dout0_1 vdout0_1ck7 = 5.0 time = 80
* CHECK dout0_0 vdout0_0ck9 = 0 time = 100
* CHECK dout0_1 vdout0_1ck9 = 5.0 time = 100
* CHECK dout1_0 vdout1_0ck9 = 0 time = 100
* CHECK dout1_1 vdout1_1ck9 = 5.0 time = 100
* CHECK dout0_0 vdout0_0ck10 = 0 time = 110
* CHECK dout0_1 vdout0_1ck10 = 5.0 time = 110
* CHECK dout1_0 vdout1_0ck11 = 0 time = 120
* CHECK dout1_1 vdout1_1ck11 = 5.0 time = 120
* CHECK dout1_0 vdout1_0ck12 = 0 time = 130
* CHECK dout1_1 vdout1_1ck12 = 5.0 time = 130
* CHECK dout0_0 vdout0_0ck15 = 0 time = 160
* CHECK dout0_1 vdout0_1ck15 = 5.0 time = 160
* CHECK dout1_0 vdout1_0ck15 = 0 time = 160
* CHECK dout1_1 vdout1_1ck15 = 5.0 time = 160
* CHECK dout0_0 vdout0_0ck16 = 0 time = 170
* CHECK dout0_1 vdout0_1ck16 = 5.0 time = 170
* CHECK dout1_0 vdout1_0ck17 = 0 time = 180
* CHECK dout1_1 vdout1_1ck17 = 5.0 time = 180
* CHECK dout0_0 vdout0_0ck20 = 5.0 time = 210
* CHECK dout0_1 vdout0_1ck20 = 5.0 time = 210
* CHECK dout0_0 vdout0_0ck22 = 5.0 time = 230
* CHECK dout0_1 vdout0_1ck22 = 5.0 time = 230
* CHECK dout1_0 vdout1_0ck22 = 5.0 time = 230
* CHECK dout1_1 vdout1_1ck22 = 5.0 time = 230
* CHECK dout0_0 vdout0_0ck23 = 5.0 time = 240
* CHECK dout0_1 vdout0_1ck23 = 5.0 time = 240
* CHECK dout0_0 vdout0_0ck24 = 5.0 time = 250
* CHECK dout0_1 vdout0_1ck24 = 5.0 time = 250
* CHECK dout0_0 vdout0_0ck25 = 5.0 time = 260
* CHECK dout0_1 vdout0_1ck25 = 5.0 time = 260
* CHECK dout1_0 vdout1_0ck25 = 5.0 time = 260
* CHECK dout1_1 vdout1_1ck25 = 0 time = 260
* CHECK dout1_0 vdout1_0ck26 = 5.0 time = 270
* CHECK dout1_1 vdout1_1ck26 = 0 time = 270
* CHECK dout0_0 vdout0_0ck28 = 5.0 time = 290
* CHECK dout0_1 vdout0_1ck28 = 5.0 time = 290
* CHECK dout0_0 vdout0_0ck29 = 5.0 time = 300
* CHECK dout0_1 vdout0_1ck29 = 0 time = 300
* CHECK dout0_0 vdout0_0ck30 = 5.0 time = 310
* CHECK dout0_1 vdout0_1ck30 = 5.0 time = 310
* CHECK dout1_0 vdout1_0ck30 = 5.0 time = 310
* CHECK dout1_1 vdout1_1ck30 = 5.0 time = 310
* CHECK dout1_0 vdout1_0ck32 = 5.0 time = 330
* CHECK dout1_1 vdout1_1ck32 = 5.0 time = 330
* CHECK dout0_0 vdout0_0ck33 = 5.0 time = 340
* CHECK dout0_1 vdout0_1ck33 = 5.0 time = 340
* CHECK dout1_0 vdout1_0ck33 = 5.0 time = 340
* CHECK dout1_1 vdout1_1ck33 = 5.0 time = 340
* CHECK dout0_0 vdout0_0ck34 = 5.0 time = 350
* CHECK dout0_1 vdout0_1ck34 = 5.0 time = 350
* CHECK dout1_0 vdout1_0ck35 = 5.0 time = 360
* CHECK dout1_1 vdout1_1ck35 = 5.0 time = 360
* CHECK dout0_0 vdout0_0ck36 = 5.0 time = 370
* CHECK dout0_1 vdout0_1ck36 = 5.0 time = 370
* CHECK dout1_0 vdout1_0ck36 = 5.0 time = 370
* CHECK dout1_1 vdout1_1ck36 = 5.0 time = 370
* CHECK dout0_0 vdout0_0ck38 = 0 time = 390
* CHECK dout0_1 vdout0_1ck38 = 5.0 time = 390
* CHECK dout1_0 vdout1_0ck38 = 5.0 time = 390
* CHECK dout1_1 vdout1_1ck38 = 5.0 time = 390
* CHECK dout1_0 vdout1_0ck39 = 0 time = 400
* CHECK dout1_1 vdout1_1ck39 = 5.0 time = 400
* CHECK dout0_0 vdout0_0ck40 = 0 time = 410
* CHECK dout0_1 vdout0_1ck40 = 5.0 time = 410
* CHECK dout1_0 vdout1_0ck40 = 0 time = 410
* CHECK dout1_1 vdout1_1ck40 = 5.0 time = 410
* CHECK dout0_0 vdout0_0ck44 = 0 time = 450
* CHECK dout0_1 vdout0_1ck44 = 5.0 time = 450
* CHECK dout0_0 vdout0_0ck45 = 5.0 time = 460
* CHECK dout0_1 vdout0_1ck45 = 0 time = 460
* CHECK dout1_0 vdout1_0ck45 = 5.0 time = 460
* CHECK dout1_1 vdout1_1ck45 = 0 time = 460
* CHECK dout0_0 vdout0_0ck48 = 5.0 time = 490
* CHECK dout0_1 vdout0_1ck48 = 0 time = 490
* CHECK dout1_0 vdout1_0ck48 = 0 time = 490
* CHECK dout1_1 vdout1_1ck48 = 5.0 time = 490
* CHECK dout0_0 vdout0_0ck49 = 0 time = 500
* CHECK dout0_1 vdout0_1ck49 = 5.0 time = 500
* CHECK dout0_0 vdout0_0ck50 = 0 time = 510
* CHECK dout0_1 vdout0_1ck50 = 5.0 time = 510
* CHECK dout1_0 vdout1_0ck50 = 0 time = 510
* CHECK dout1_1 vdout1_1ck50 = 5.0 time = 510
* CHECK dout0_0 vdout0_0ck53 = 0 time = 540
* CHECK dout0_1 vdout0_1ck53 = 5.0 time = 540
* CHECK dout1_0 vdout1_0ck53 = 0 time = 540
* CHECK dout1_1 vdout1_1ck53 = 5.0 time = 540
* CHECK dout0_0 vdout0_0ck54 = 0 time = 550
* CHECK dout0_1 vdout0_1ck54 = 5.0 time = 550
* CHECK dout1_0 vdout1_0ck54 = 0 time = 550
* CHECK dout1_1 vdout1_1ck54 = 5.0 time = 550
* CHECK dout0_0 vdout0_0ck55 = 0 time = 560
* CHECK dout0_1 vdout0_1ck55 = 5.0 time = 560
* CHECK dout0_0 vdout0_0ck59 = 0 time = 600
* CHECK dout0_1 vdout0_1ck59 = 5.0 time = 600
* CHECK dout1_0 vdout1_0ck59 = 5.0 time = 600
* CHECK dout1_1 vdout1_1ck59 = 5.0 time = 600
* CHECK dout0_0 vdout0_0ck60 = 5.0 time = 610
* CHECK dout0_1 vdout0_1ck60 = 5.0 time = 610
* CHECK dout0_0 vdout0_0ck63 = 5.0 time = 640
* CHECK dout0_1 vdout0_1ck63 = 5.0 time = 640
* CHECK dout1_0 vdout1_0ck63 = 5.0 time = 640
* CHECK dout1_1 vdout1_1ck63 = 5.0 time = 640
* CHECK dout0_0 vdout0_0ck65 = 5.0 time = 660
* CHECK dout0_1 vdout0_1ck65 = 5.0 time = 660
* CHECK dout0_0 vdout0_0ck66 = 5.0 time = 670
* CHECK dout0_1 vdout0_1ck66 = 5.0 time = 670
* CHECK dout0_0 vdout0_0ck68 = 5.0 time = 690
* CHECK dout0_1 vdout0_1ck68 = 5.0 time = 690
* CHECK dout1_0 vdout1_0ck68 = 5.0 time = 690
* CHECK dout1_1 vdout1_1ck68 = 5.0 time = 690
* CHECK dout0_0 vdout0_0ck70 = 5.0 time = 710
* CHECK dout0_1 vdout0_1ck70 = 5.0 time = 710
* CHECK dout1_0 vdout1_0ck70 = 5.0 time = 710
* CHECK dout1_1 vdout1_1ck70 = 5.0 time = 710
* CHECK dout0_0 vdout0_0ck72 = 5.0 time = 730
* CHECK dout0_1 vdout0_1ck72 = 0 time = 730
* CHECK dout0_0 vdout0_0ck73 = 5.0 time = 740
* CHECK dout0_1 vdout0_1ck73 = 5.0 time = 740
* CHECK dout0_0 vdout0_0ck74 = 5.0 time = 750
* CHECK dout0_1 vdout0_1ck74 = 5.0 time = 750
* CHECK dout0_0 vdout0_0ck75 = 5.0 time = 760
* CHECK dout0_1 vdout0_1ck75 = 5.0 time = 760
* CHECK dout0_0 vdout0_0ck76 = 5.0 time = 770
* CHECK dout0_1 vdout0_1ck76 = 0 time = 770
* CHECK dout1_0 vdout1_0ck76 = 5.0 time = 770
* CHECK dout1_1 vdout1_1ck76 = 0 time = 770
* CHECK dout0_0 vdout0_0ck78 = 5.0 time = 790
* CHECK dout0_1 vdout0_1ck78 = 0 time = 790
* CHECK dout1_0 vdout1_0ck78 = 5.0 time = 790
* CHECK dout1_1 vdout1_1ck78 = 5.0 time = 790
* CHECK dout0_0 vdout0_0ck79 = 5.0 time = 800
* CHECK dout0_1 vdout0_1ck79 = 5.0 time = 800
* CHECK dout1_0 vdout1_0ck79 = 5.0 time = 800
* CHECK dout1_1 vdout1_1ck79 = 0 time = 800
* CHECK dout0_0 vdout0_0ck80 = 5.0 time = 810
* CHECK dout0_1 vdout0_1ck80 = 0 time = 810
* CHECK dout1_0 vdout1_0ck80 = 5.0 time = 810
* CHECK dout1_1 vdout1_1ck80 = 5.0 time = 810
* CHECK dout1_0 vdout1_0ck82 = 5.0 time = 830
* CHECK dout1_1 vdout1_1ck82 = 0 time = 830
* CHECK dout0_0 vdout0_0ck83 = 0 time = 840
* CHECK dout0_1 vdout0_1ck83 = 5.0 time = 840
* CHECK dout1_0 vdout1_0ck83 = 0 time = 840
* CHECK dout1_1 vdout1_1ck83 = 5.0 time = 840
* CHECK dout0_0 vdout0_0ck84 = 5.0 time = 850
* CHECK dout0_1 vdout0_1ck84 = 0 time = 850
* CHECK dout0_0 vdout0_0ck86 = 0 time = 870
* CHECK dout0_1 vdout0_1ck86 = 5.0 time = 870
* CHECK dout1_0 vdout1_0ck88 = 0 time = 890
* CHECK dout1_1 vdout1_1ck88 = 5.0 time = 890
* CHECK dout0_0 vdout0_0ck90 = 5.0 time = 910
* CHECK dout0_1 vdout0_1ck90 = 0 time = 910
* CHECK dout1_0 vdout1_0ck90 = 0 time = 910
* CHECK dout1_1 vdout1_1ck90 = 5.0 time = 910
* CHECK dout1_0 vdout1_0ck91 = 0 time = 920
* CHECK dout1_1 vdout1_1ck91 = 5.0 time = 920
* CHECK dout1_0 vdout1_0ck92 = 5.0 time = 930
* CHECK dout1_1 vdout1_1ck92 = 0 time = 930
* CHECK dout0_0 vdout0_0ck93 = 0 time = 940
* CHECK dout0_1 vdout0_1ck93 = 5.0 time = 940
* CHECK dout1_0 vdout1_0ck93 = 5.0 time = 940
* CHECK dout1_1 vdout1_1ck93 = 0 time = 940
* CHECK dout1_0 vdout1_0ck94 = 5.0 time = 950
* CHECK dout1_1 vdout1_1ck94 = 0 time = 950
* CHECK dout0_0 vdout0_0ck95 = 0 time = 960
* CHECK dout0_1 vdout0_1ck95 = 5.0 time = 960
* CHECK dout1_0 vdout1_0ck95 = 5.0 time = 960
* CHECK dout1_1 vdout1_1ck95 = 0 time = 960
* CHECK dout0_0 vdout0_0ck98 = 0 time = 990
* CHECK dout0_1 vdout0_1ck98 = 5.0 time = 990
* CHECK dout1_0 vdout1_0ck99 = 0 time = 1000
* CHECK dout1_1 vdout1_1ck99 = 5.0 time = 1000
* CHECK dout0_0 vdout0_0ck101 = 0 time = 1020
* CHECK dout0_1 vdout0_1ck101 = 5.0 time = 1020
* CHECK dout0_0 vdout0_0ck103 = 5.0 time = 1040
* CHECK dout0_1 vdout0_1ck103 = 0 time = 1040
* CHECK dout0_0 vdout0_0ck104 = 0 time = 1050
* CHECK dout0_1 vdout0_1ck104 = 5.0 time = 1050
* CHECK dout1_0 vdout1_0ck104 = 0 time = 1050
* CHECK dout1_1 vdout1_1ck104 = 5.0 time = 1050
* CHECK dout0_0 vdout0_0ck105 = 0 time = 1060
* CHECK dout0_1 vdout0_1ck105 = 5.0 time = 1060
* CHECK dout1_0 vdout1_0ck105 = 0 time = 1060
* CHECK dout1_1 vdout1_1ck105 = 5.0 time = 1060
* CHECK dout0_0 vdout0_0ck106 = 0 time = 1070
* CHECK dout0_1 vdout0_1ck106 = 5.0 time = 1070
* CHECK dout0_0 vdout0_0ck109 = 5.0 time = 1100
* CHECK dout0_1 vdout0_1ck109 = 5.0 time = 1100
* CHECK dout1_0 vdout1_0ck113 = 0 time = 1140
* CHECK dout1_1 vdout1_1ck113 = 5.0 time = 1140
* CHECK dout0_0 vdout0_0ck115 = 5.0 time = 1160
* CHECK dout0_1 vdout0_1ck115 = 5.0 time = 1160
* CHECK dout1_0 vdout1_0ck115 = 5.0 time = 1160
* CHECK dout1_1 vdout1_1ck115 = 5.0 time = 1160
* CHECK dout0_0 vdout0_0ck117 = 5.0 time = 1180
* CHECK dout0_1 vdout0_1ck117 = 5.0 time = 1180
* CHECK dout0_0 vdout0_0ck118 = 5.0 time = 1190
* CHECK dout0_1 vdout0_1ck118 = 5.0 time = 1190
* CHECK dout1_0 vdout1_0ck118 = 5.0 time = 1190
* CHECK dout1_1 vdout1_1ck118 = 5.0 time = 1190
* CHECK dout0_0 vdout0_0ck119 = 5.0 time = 1200
* CHECK dout0_1 vdout0_1ck119 = 5.0 time = 1200
* CHECK dout1_0 vdout1_0ck119 = 5.0 time = 1200
* CHECK dout1_1 vdout1_1ck119 = 0 time = 1200
* CHECK dout0_0 vdout0_0ck120 = 5.0 time = 1210
* CHECK dout0_1 vdout0_1ck120 = 0 time = 1210
* CHECK dout1_0 vdout1_0ck120 = 5.0 time = 1210
* CHECK dout1_1 vdout1_1ck120 = 0 time = 1210
* CHECK dout0_0 vdout0_0ck121 = 5.0 time = 1220
* CHECK dout0_1 vdout0_1ck121 = 5.0 time = 1220
* CHECK dout1_0 vdout1_0ck121 = 5.0 time = 1220
* CHECK dout1_1 vdout1_1ck121 = 5.0 time = 1220
* CHECK dout0_0 vdout0_0ck124 = 5.0 time = 1250
* CHECK dout0_1 vdout0_1ck124 = 0 time = 1250
* CHECK dout0_0 vdout0_0ck125 = 5.0 time = 1260
* CHECK dout0_1 vdout0_1ck125 = 5.0 time = 1260
* CHECK dout1_0 vdout1_0ck125 = 5.0 time = 1260
* CHECK dout1_1 vdout1_1ck125 = 5.0 time = 1260
* CHECK dout0_0 vdout0_0ck127 = 5.0 time = 1280
* CHECK dout0_1 vdout0_1ck127 = 0 time = 1280
* CHECK dout1_0 vdout1_0ck127 = 5.0 time = 1280
* CHECK dout1_1 vdout1_1ck127 = 5.0 time = 1280
* CHECK dout0_0 vdout0_0ck128 = 5.0 time = 1290
* CHECK dout0_1 vdout0_1ck128 = 5.0 time = 1290
* CHECK dout1_0 vdout1_0ck128 = 5.0 time = 1290
* CHECK dout1_1 vdout1_1ck128 = 5.0 time = 1290
* CHECK dout1_0 vdout1_0ck129 = 5.0 time = 1300
* CHECK dout1_1 vdout1_1ck129 = 5.0 time = 1300
* CHECK dout0_0 vdout0_0ck130 = 5.0 time = 1310
* CHECK dout0_1 vdout0_1ck130 = 5.0 time = 1310
* CHECK dout1_0 vdout1_0ck132 = 5.0 time = 1330
* CHECK dout1_1 vdout1_1ck132 = 5.0 time = 1330
* CHECK dout0_0 vdout0_0ck133 = 5.0 time = 1340
* CHECK dout0_1 vdout0_1ck133 = 5.0 time = 1340
* CHECK dout1_0 vdout1_0ck133 = 0 time = 1340
* CHECK dout1_1 vdout1_1ck133 = 5.0 time = 1340
* CHECK dout0_0 vdout0_0ck134 = 5.0 time = 1350
* CHECK dout0_1 vdout0_1ck134 = 5.0 time = 1350
* CHECK dout1_0 vdout1_0ck134 = 0 time = 1350
* CHECK dout1_1 vdout1_1ck134 = 5.0 time = 1350
* CHECK dout0_0 vdout0_0ck136 = 5.0 time = 1370
* CHECK dout0_1 vdout0_1ck136 = 5.0 time = 1370
* CHECK dout1_0 vdout1_0ck137 = 5.0 time = 1380
* CHECK dout1_1 vdout1_1ck137 = 5.0 time = 1380
* CHECK dout0_0 vdout0_0ck138 = 0 time = 1390
* CHECK dout0_1 vdout0_1ck138 = 5.0 time = 1390
* CHECK dout1_0 vdout1_0ck138 = 0 time = 1390
* CHECK dout1_1 vdout1_1ck138 = 5.0 time = 1390
* CHECK dout1_0 vdout1_0ck139 = 5.0 time = 1400
* CHECK dout1_1 vdout1_1ck139 = 5.0 time = 1400
* CHECK dout0_0 vdout0_0ck140 = 0 time = 1410
* CHECK dout0_1 vdout0_1ck140 = 5.0 time = 1410
* CHECK dout0_0 vdout0_0ck142 = 5.0 time = 1430
* CHECK dout0_1 vdout0_1ck142 = 5.0 time = 1430
* CHECK dout0_0 vdout0_0ck144 = 5.0 time = 1450
* CHECK dout0_1 vdout0_1ck144 = 5.0 time = 1450
* CHECK dout1_0 vdout1_0ck146 = 0 time = 1470
* CHECK dout1_1 vdout1_1ck146 = 5.0 time = 1470
* CHECK dout1_0 vdout1_0ck147 = 0 time = 1480
* CHECK dout1_1 vdout1_1ck147 = 5.0 time = 1480
* CHECK dout0_0 vdout0_0ck148 = 0 time = 1490
* CHECK dout0_1 vdout0_1ck148 = 5.0 time = 1490
* CHECK dout1_0 vdout1_0ck148 = 0 time = 1490
* CHECK dout1_1 vdout1_1ck148 = 5.0 time = 1490
* CHECK dout0_0 vdout0_0ck149 = 0 time = 1500
* CHECK dout0_1 vdout0_1ck149 = 5.0 time = 1500
* CHECK dout1_0 vdout1_0ck149 = 0 time = 1500
* CHECK dout1_1 vdout1_1ck149 = 5.0 time = 1500
* CHECK dout0_0 vdout0_0ck151 = 0 time = 1520
* CHECK dout0_1 vdout0_1ck151 = 5.0 time = 1520
* CHECK dout1_0 vdout1_0ck151 = 0 time = 1520
* CHECK dout1_1 vdout1_1ck151 = 5.0 time = 1520
* CHECK dout1_0 vdout1_0ck153 = 0 time = 1540
* CHECK dout1_1 vdout1_1ck153 = 5.0 time = 1540
* CHECK dout0_0 vdout0_0ck154 = 0 time = 1550
* CHECK dout0_1 vdout0_1ck154 = 5.0 time = 1550
* CHECK dout1_0 vdout1_0ck154 = 0 time = 1550
* CHECK dout1_1 vdout1_1ck154 = 5.0 time = 1550
* CHECK dout0_0 vdout0_0ck155 = 0 time = 1560
* CHECK dout0_1 vdout0_1ck155 = 5.0 time = 1560
* CHECK dout1_0 vdout1_0ck155 = 0 time = 1560
* CHECK dout1_1 vdout1_1ck155 = 5.0 time = 1560
* CHECK dout1_0 vdout1_0ck156 = 0 time = 1570
* CHECK dout1_1 vdout1_1ck156 = 5.0 time = 1570
* CHECK dout0_0 vdout0_0ck157 = 5.0 time = 1580
* CHECK dout0_1 vdout0_1ck157 = 5.0 time = 1580
* CHECK dout0_0 vdout0_0ck160 = 0 time = 1610
* CHECK dout0_1 vdout0_1ck160 = 5.0 time = 1610
* CHECK dout1_0 vdout1_0ck160 = 0 time = 1610
* CHECK dout1_1 vdout1_1ck160 = 5.0 time = 1610
* CHECK dout1_0 vdout1_0ck162 = 0 time = 1630
* CHECK dout1_1 vdout1_1ck162 = 5.0 time = 1630
* CHECK dout0_0 vdout0_0ck163 = 5.0 time = 1640
* CHECK dout0_1 vdout0_1ck163 = 0 time = 1640
* CHECK dout0_0 vdout0_0ck164 = 5.0 time = 1650
* CHECK dout0_1 vdout0_1ck164 = 0 time = 1650
* CHECK dout1_0 vdout1_0ck166 = 0 time = 1670
* CHECK dout1_1 vdout1_1ck166 = 5.0 time = 1670
* CHECK dout0_0 vdout0_0ck167 = 5.0 time = 1680
* CHECK dout0_1 vdout0_1ck167 = 0 time = 1680
* CHECK dout0_0 vdout0_0ck168 = 5.0 time = 1690
* CHECK dout0_1 vdout0_1ck168 = 0 time = 1690
* CHECK dout0_0 vdout0_0ck169 = 5.0 time = 1700
* CHECK dout0_1 vdout0_1ck169 = 0 time = 1700
* CHECK dout1_0 vdout1_0ck169 = 0 time = 1700
* CHECK dout1_1 vdout1_1ck169 = 5.0 time = 1700
* CHECK dout1_0 vdout1_0ck170 = 5.0 time = 1710
* CHECK dout1_1 vdout1_1ck170 = 0 time = 1710
* CHECK dout0_0 vdout0_0ck171 = 5.0 time = 1720
* CHECK dout0_1 vdout0_1ck171 = 0 time = 1720
* CHECK dout0_0 vdout0_0ck173 = 5.0 time = 1740
* CHECK dout0_1 vdout0_1ck173 = 0 time = 1740
* CHECK dout1_0 vdout1_0ck173 = 0 time = 1740
* CHECK dout1_1 vdout1_1ck173 = 5.0 time = 1740
* CHECK dout0_0 vdout0_0ck176 = 5.0 time = 1770
* CHECK dout0_1 vdout0_1ck176 = 0 time = 1770
* CHECK dout1_0 vdout1_0ck176 = 5.0 time = 1770
* CHECK dout1_1 vdout1_1ck176 = 0 time = 1770
* CHECK dout1_0 vdout1_0ck177 = 0 time = 1780
* CHECK dout1_1 vdout1_1ck177 = 5.0 time = 1780
* CHECK dout0_0 vdout0_0ck179 = 0 time = 1800
* CHECK dout0_1 vdout0_1ck179 = 5.0 time = 1800
* CHECK dout1_0 vdout1_0ck179 = 5.0 time = 1800
* CHECK dout1_1 vdout1_1ck179 = 0 time = 1800
* CHECK dout0_0 vdout0_0ck180 = 5.0 time = 1810
* CHECK dout0_1 vdout0_1ck180 = 0 time = 1810
* CHECK dout0_0 vdout0_0ck181 = 0 time = 1820
* CHECK dout0_1 vdout0_1ck181 = 5.0 time = 1820
* CHECK dout0_0 vdout0_0ck183 = 5.0 time = 1840
* CHECK dout0_1 vdout0_1ck183 = 0 time = 1840
* CHECK dout1_0 vdout1_0ck184 = 5.0 time = 1850
* CHECK dout1_1 vdout1_1ck184 = 0 time = 1850
* CHECK dout0_0 vdout0_0ck187 = 0 time = 1880
* CHECK dout0_1 vdout0_1ck187 = 5.0 time = 1880
* CHECK dout1_0 vdout1_0ck188 = 5.0 time = 1890
* CHECK dout1_1 vdout1_1ck188 = 5.0 time = 1890
* CHECK dout1_0 vdout1_0ck190 = 0 time = 1910
* CHECK dout1_1 vdout1_1ck190 = 5.0 time = 1910
* CHECK dout1_0 vdout1_0ck191 = 0 time = 1920
* CHECK dout1_1 vdout1_1ck191 = 5.0 time = 1920
* CHECK dout1_0 vdout1_0ck192 = 0 time = 1930
* CHECK dout1_1 vdout1_1ck192 = 5.0 time = 1930
* CHECK dout0_0 vdout0_0ck193 = 5.0 time = 1940
* CHECK dout0_1 vdout0_1ck193 = 5.0 time = 1940
* CHECK dout1_0 vdout1_0ck193 = 0 time = 1940
* CHECK dout1_1 vdout1_1ck193 = 5.0 time = 1940
* CHECK dout0_0 vdout0_0ck194 = 0 time = 1950
* CHECK dout0_1 vdout0_1ck194 = 5.0 time = 1950
* CHECK dout1_0 vdout1_0ck194 = 5.0 time = 1950
* CHECK dout1_1 vdout1_1ck194 = 5.0 time = 1950
* CHECK dout0_0 vdout0_0ck195 = 5.0 time = 1960
* CHECK dout0_1 vdout0_1ck195 = 5.0 time = 1960
* CHECK dout0_0 vdout0_0ck196 = 0 time = 1970
* CHECK dout0_1 vdout0_1ck196 = 5.0 time = 1970
* CHECK dout1_0 vdout1_0ck196 = 0 time = 1970
* CHECK dout1_1 vdout1_1ck196 = 5.0 time = 1970
* CHECK dout1_0 vdout1_0ck197 = 5.0 time = 1980
* CHECK dout1_1 vdout1_1ck197 = 5.0 time = 1980
* CHECK dout0_0 vdout0_0ck198 = 5.0 time = 1990
* CHECK dout0_1 vdout0_1ck198 = 5.0 time = 1990
* CHECK dout1_0 vdout1_0ck198 = 5.0 time = 1990
* CHECK dout1_1 vdout1_1ck198 = 0 time = 1990
* CHECK dout0_0 vdout0_0ck199 = 5.0 time = 2000
* CHECK dout0_1 vdout0_1ck199 = 0 time = 2000
* CHECK dout0_0 vdout0_0ck200 = 5.0 time = 2010
* CHECK dout0_1 vdout0_1ck200 = 5.0 time = 2010
* CHECK dout1_0 vdout1_0ck201 = 5.0 time = 2020
* CHECK dout1_1 vdout1_1ck201 = 5.0 time = 2020
* CHECK dout0_0 vdout0_0ck202 = 0 time = 2030
* CHECK dout0_1 vdout0_1ck202 = 5.0 time = 2030
* CHECK dout1_0 vdout1_0ck203 = 0 time = 2040
* CHECK dout1_1 vdout1_1ck203 = 5.0 time = 2040
.include /home/xxwang1/OpenRAM/macro/sram_1rw1r0w_2_16_scn4m_subm/functional_meas.sp
* probe is used for hspice/xa, while plot is used in ngspice
*.probe V(*)
*.plot V(*)
.end

