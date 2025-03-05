// Author: Alessio Caviglia
// File: tb_counter.v
// Description: Testbench for a 4-bit counter in Verilog
// Module: tb_counter_4bit
// Inputs: none
// Outputs: none

module tb_counter_4bit;

// Inputs to the Counter
reg clk;
reg reset;

// Outputs from the Counter
wire [3:0] count;

// Instantiate the 4-bit Counter module
counter_4bit dut (
    .clk(clk),
    .reset(reset),
    .count(count)
);

// Clock generation
always begin
    #5 clk = ~clk;  // Invert the clock every 5 time units
end

// Test procedure
initial begin
    $dumpfile("counter.vcd");         // Specify the name of the VCD file
    $dumpvars(0, tb_counter_4bit);    // Dump all variables in the testbench
    
    // Initialize inputs
    clk = 0;
    reset = 1;  // Start with reset active
    #10 reset = 0;  // Release reset after 10 time units

    // Let the counter run for a few clock cycles
    #100;

    // Apply reset in the middle of counting
    reset = 1;  // Assert reset
    #10 reset = 0;  // Release reset
    
    // Let the counter run for a few more cycles
    #50;

    // End simulation
    $finish;
end

endmodule