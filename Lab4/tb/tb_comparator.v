// Author: Tzamn Melendez Carmona
// file: tb_comparator.v
// description: Testbench for the comparator module.
// name of the module expected: comparator
// module IO expected: Enable, Reset, Clock, PortA, PortB, Output
// parameters: NBITS_COMPARATOR defined in parameters.v
// This testbench generates a clock signal and resets the comparator
// for 10 clock cycles. The output of the comparator is stored in a VCD file
// named comparator.vcd
`include "src/comparator.v"

module tb_comparator;
`include "params/parameters.v"

reg Enable;
reg Reset;
reg Clock;
reg [NBITS_COMPARATOR-1:0] PortA;
reg [NBITS_COMPARATOR-1:0] PortB;
wire Output;

comparator comparator(
    .Enable(Enable),
    .Reset(Reset),
    .Clock(Clock),
    .PortA(PortA),
    .PortB(PortB),
    .Output(Output)
);

initial begin
    $dumpfile("comparator.vcd");
    $dumpvars(0, tb_comparator);

    // Testbench for the comparator
    Reset = 0;
    Enable = 0;
    Clock = 0;
    PortA = 8'b00000001;
    PortB = 8'b00000000;

    // Reset the comparator and wait for 10 clock cycles
    // to ensure that the comparator is reset
    #10 Reset = 1;
    #10 Reset = 0;
    #10 Enable = 1;
    // Test for the case where PortA is greater than PortB
    #10 PortA = 8'b00000001;
    #10 PortB = 8'b00000000;
    // Test for the case where PortA is less than PortB
    #10 PortA = 8'b00000000;
    #10 PortB = 8'b00000001;
    // Test for the case where PortA is equal PortB
    #10 PortA = 8'b00000001;
    #10 PortB = 8'b00000001;
    // Test for the case where PortA is equal PortB
    #10 PortA = 8'b00000000;
    #10 PortB = 8'b00000000;
    // Test for the case where PortA is greater than PortB
    #10 PortA = 8'b00000010;
    #10 PortB = 8'b00000001;

    #300 $finish;
end

// Clock generation
always begin
    #5 Clock= ~Clock;
end
endmodule
