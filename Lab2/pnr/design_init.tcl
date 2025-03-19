read_liberty ../sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_lef ../sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef
read_lef ../sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef

read_verilog ../syn/counter_gen.v
link_design counter_gen
read_sdc counter_gen.sdc
