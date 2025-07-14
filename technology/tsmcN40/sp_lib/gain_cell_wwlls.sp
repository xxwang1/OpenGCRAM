.SUBCKT gain_cell_wwlls we_clk web we_shifted vdd vddio gnd

** Library name: OpenRAM
** Cell name: gain_cell_wwlls
** View name: schematic
MM3 we_shifted web gnd gnd nch_25 l=270e-9 w=12e-6 multi=1 nf=6 sd=220e-9 ad=1.32e-12 as=1.48e-12 pd=13.32e-6 ps=17.48e-6 nrd=0 nrs=0 sa=725.774e-9 sb=725.774e-9 sa1=292.058e-9 sa2=576.37e-9 sa3=774.686e-9 sb1=292.058e-9 sb2=576.37e-9 sb3=774.686e-9
MM2 net14 we_clk gnd gnd nch_25 l=270e-9 w=2e-6 multi=1 nf=1 sd=220e-9 ad=300e-15 as=300e-15 pd=4.3e-6 ps=4.3e-6 nrd=0 nrs=0 sa=150e-9 sb=150e-9 sa1=150e-9 sa2=150e-9 sa3=150e-9 sb1=150e-9 sb2=150e-9 sb3=150e-9
MM5 web we_clk gnd gnd nch l=40e-9 w=3.5e-6 multi=1 nf=10 sd=140e-9 ad=245e-15 as=273e-15 pd=4.9e-6 ps=5.76e-6 nrd=15.125e-3 nrs=15.125e-3 sa=496.714e-9 sb=496.714e-9 sa1=235.119e-9 sa2=430.824e-9 sa3=683.135e-9 sa4=473.338e-9 sb1=235.119e-9 sb2=430.824e-9 sb3=683.135e-9 spa=140e-9 spa1=140e-9 spa2=140e-9 spa3=140e-9 sap=211.4e-9 spba=163.849e-9 sapb=264.826e-9 spba1=165.659e-9
MM4 web we_clk vdd vdd pch l=40e-9 w=4.5e-6 multi=1 nf=10 sd=140e-9 ad=315e-15 as=351e-15 pd=5.9e-6 ps=6.96e-6 nrd=10.725e-3 nrs=10.725e-3 sa=496.714e-9 sb=496.714e-9 sa1=235.119e-9 sa2=430.824e-9 sa3=683.135e-9 sa4=473.338e-9 sb1=235.119e-9 sb2=430.824e-9 sb3=683.135e-9 spa=140e-9 spa1=140e-9 spa2=140e-9 spa3=140e-9 sap=211.4e-9 spba=163.849e-9 sapb=264.826e-9 spba1=165.659e-9
MM1 net14 we_shifted vddio vddio pch_25 l=270e-9 w=400e-9 multi=1 nf=1 sd=220e-9 ad=60e-15 as=60e-15 pd=1.1e-6 ps=1.1e-6 nrd=0 nrs=0 sa=150e-9 sb=150e-9 sa1=150e-9 sa2=150e-9 sa3=150e-9 sb1=150e-9 sb2=150e-9 sb3=150e-9
MM0 we_shifted net14 vddio vddio pch_25 l=270e-9 w=2.4e-6 multi=1 nf=6 sd=220e-9 ad=264e-15 as=296e-15 pd=3.72e-6 ps=4.68e-6 nrd=0 nrs=0 sa=725.774e-9 sb=725.774e-9 sa1=292.058e-9 sa2=576.37e-9 sa3=774.686e-9 sb1=292.058e-9 sb2=576.37e-9 sb3=774.686e-9
.ENDS gain_cell_wwlls
