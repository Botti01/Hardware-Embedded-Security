// Author: Tzamn Melendez Carmona
// file: tb_ro_puf.v
// description: Testbench for the ro_puf module.
// name of the module expected: ro_puf
// module IO expected: Enable, Reset, Clock, Challenge, Response
// parameters: NBITS_ROPUF defined in parameters.v
// This testbench generates a clock signal every 50 ns and challenges the ro_puf
// every rising edge of the clock. The output of the ro_puf is stored in a VCD file
// named ro_puf.vcd

`include "src/ro_puf.v"
`timescale 1ns / 1ps
module tb_ro_puf;

`include "params/parameters.v"
reg Enable;
reg Reset;
reg Clock;
reg [NBITS_ROPUF - 1:0] Challenge;
wire Response;

ro_puf ro_puf_instance(
    .Enable(Enable),
    .Reset(Reset),
    .Clock(Clock),  
    .Challenge(Challenge),
    .Response(Response)
);

initial begin
    $dumpfile("ro_puf.vcd");
    $dumpvars(0, tb_ro_puf);

    // Testbench for the ro_puf
    Enable = 0;
    Reset = 0;
    Clock = 1;
    Challenge = 0;

    // Enable the ro_puf and wait for 10 ns
    // to ensure that the ro_puf is enabled
    #100 Reset = 1;
    #200 Reset = 0;
    #200 Enable = 1;
    #10000 $finish;
end

// Clock generation
// Create a clock signal with a period of 50 ns
always begin
    #50 Clock = ~Clock;
end

// Challenge generation evey rising edge of the clock
always begin
    #100 Challenge = $random;
end

endmodule

