// author: Tzamn Melendez Carmona
// version: 1.0
// description: A simple ring oscillator implemented in Verilog
// module: ring_oscillator
// inputs: Enable
// outputs: Oscillation
// parameters: N_INVERTERS_RO, GATE_DELAY_RO

// timescale directive, defines the time unit and time precision for the GAte-level simulation
// GATE_DELAY_RO is affected by this directive
`timescale 1ps / 1ps
module ring_oscillator(
    input Enable,
    output Oscillation
);

// parameter declarations, this parameters are defined in the parameters.v file
// it must be included withing the module
`include "params/parameters.v"
// The ring oscillator is implemented as a chain of wireInverters
// where each wireInverter is connected to the output of the previous
// the don't touch attribute is used to prevent synthesis tools from
// optimizing the ring oscillator
(* dont_touch = "yes" *) wire [N_INVERTERS_RO-1:0] wireInverters;

genvar i;
generate
    for (i = 0; i < N_INVERTERS_RO - 1; i = i + 1) 
    begin: inverters
        assign #(GATE_DELAY_RO + $urandom_range(0,10)) wireInverters[i+1] = ~wireInverters[i]; 
    end
endgenerate

assign #(GATE_DELAY_RO + $urandom_range(0,10)) wireInverters[0] = ~wireInverters[N_INVERTERS_RO-1] & Enable;
assign Oscillation = wireInverters[N_INVERTERS_RO-1];

endmodule  // ring_oscillator

