set clk_name clk
set clk_port_name clk
set clk_period 3.74
set clk_period_factor 0.2

set clk_port [get_ports $clk_port_name]

create_clock -name $clk_name -period $clk_period $clk_port
set non_clock_inputs [lsearch -inline -all -not -exact [all_inputs] $clk_port]

set delay [expr $clk_period * $clk_period_factor]
set_input_delay $delay -clock $clk_name $non_clock_inputs
set_output_delay $delay -clock $clk_name [all_outputs] 