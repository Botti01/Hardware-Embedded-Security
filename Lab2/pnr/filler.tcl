set fill_cells "sky130_fd_sc_hd__fill_1 sky130_fd_sc_hd__fill_2 
    	       sky130_fd_sc_hd__fill_4 sky130_fd_sc_hd__fill_8"

filler_placement $fill_cells
check_placement
