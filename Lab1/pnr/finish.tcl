density_fill -rules ../sky130_fd_sc_hd/fill.json

report_worst_slack
report_design_area

write_verilog design_pnr.v
