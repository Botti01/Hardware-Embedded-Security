set_routing_layers -signal met1-met5
set_global_routing_layer_adjustment met1-met5 0.3

global_route -congestion_iterations 100 -verbose

check_antennas -report_violating_nets
detailed_route
