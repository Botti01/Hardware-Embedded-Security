// Author: Tzamn Melendez Carmona
// file: tb_ring_oscillator.v
// description: Testbench for the ring_oscillator module.
// name of the module expected: ring_oscillator
// module IO expected: Enable and Oscillation
// This testbench generates a clock signal and enables the ring_oscillator
// for 10 ns. The output of the ring_oscillator is stored in a VCD file
// named ring_oscillator.VCD
`include "src/ring_oscillator.v"

`timescale 1ns / 1ps

module tb_ring_oscillator;
    reg Clock;
    reg Enable;
    wire Out;

    ring_oscillator ring_oscillator(
        .Enable(Enable),
        .Oscillation(Out)
    );

    initial begin
        $dumpfile("ring_oscillator.vcd");
        $dumpvars(0, tb_ring_oscillator);

        Clock = 0;
        Enable = 0;

        // Enable the ring_oscillator and wait for 10 ns
        // to ensure that the ring_oscillator is enabled
        #10 Enable = 1;
        #300 $finish;
    end

    // Clock generation
    always begin
        #5 Clock = ~Clock;
    end

endmodule
