`include "src/lfsr.v"

`timescale 1ns / 1ns

module tb_lfsr;
`include "params/parameters.v"
reg Clock;
reg Reset;
reg Enable;
reg [LFSR_16_BIT - 1:0] InitialState;
wire [LFSR_16_BIT - 1:0] RandOut;

lfsr #(
    .NBITS_LFSR(LFSR_16_BIT),
    .LFSR_TAP_BITS(LFSR_16_BIT_TAPS)
)
lfsr16bits(
    .Clock(Clock),
    .Reset(Reset),
    .Enable(Enable),
    .InitialState(InitialState),
    .RandOut(RandOut)
);

    initial begin
        $dumpfile("lfsr.vcd");
        $dumpvars(0, tb_lfsr);

        // Testbench for the LFSR
        Clock = 0;
        Reset = 0;
        Enable = 0;
        InitialState = $urandom_range(0, 2 ** LFSR_16_BIT - 1);

        // Reset the LFSR and wait for 10 clock cycles
        // to ensure that the LFSR is reset
        #10 Reset = 1;
        #10 Reset = 0;
        #10 Enable = 1;
        #300 $finish;
    end

    // Clock generation
    always begin
        #5 Clock = ~Clock;
    end
// Monitor the output
initial begin
    $monitor("Time=%0d Clock=%b Reset=%b Enable=%b InitialState=%d RandOut=%d", 
             $time, Clock, Reset, Enable, InitialState, RandOut);
end

endmodule
