repair_clock_inverters
clock_tree_synthesis -root_buf sky130_fd_sc_hd__clkbuf_4 \
                     -buf_list sky130_fd_sc_hd__clkbuf_4 \
                     -sink_clustering_enable \
                     -sink_clustering_size 30 \
                     -sink_clustering_max_diameter 100 \
                     -balance_levels

set_dont_use $dont_use_cells
repair_clock_nets

set_placement_padding -global -left 0 -right 0
detailed_placement

check_placement -verbose
