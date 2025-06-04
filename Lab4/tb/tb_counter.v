// Author: Tzamn Melendez Carmona
// file: tb_counter.v
// description: Testbench for the counter module.
// name of the module expected: counter
// module IO expected: Enable, Reset, Clock, Output
// parameters: NBITS_COUNTER defined in parameters.v
// This testbench generates a clock signal and resets the counter
// for 10 clock cycles. The output of the counter is stored in a VCD file
// named counter.vcd
`include "src/counter.v"

`timescale 1ns / 1ns

module tb_counter;
`include "params/parameters.v"

reg Clock;
reg Reset;
reg Enable;
wire [NBITS_COUNTER-1:0] Output;

counter counter(
    .Enable(Enable),
    .Reset(Reset),
    .Clock(Clock),
    .Output(Output)
);

initial begin
    $dumpfile("counter.vcd");
    $dumpvars(0, tb_counter);

    // Testbench for the counter
    Clock = 0;
    Reset = 0;
    Enable = 0;

    // Reset the counter and wait for 10 clock cycles
    // to ensure that the counter is reset
    #10 Reset = 1;
    #10 Reset = 0;
    #10 Enable = 1;
    #1200 $finish;
end

initial begin
    // Clock generation
    forever begin
        #5 Clock = ~Clock;
    end
end

endmodule

