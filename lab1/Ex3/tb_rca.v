// Author: Alessio Caviglia
// File: tb_rca.v
// Description: Testbench for a 4-bit ripple carry adder in Verilog
// Module: tb_ripple_carry_adder
// Inputs: none
// Outputs: none

module tb_ripple_carry_adder;

// Define the internal signals
reg [3:0] A;
reg [3:0] B;
reg Cin;
wire [3:0] Sum;
wire Cout;

// Instantiate the Ripple Carry Adder module
ripple_carry_adder dut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum),
    .Cout(Cout)
);

// Test procedure
initial begin
    $dumpfile("rca.vcd");                   // Specify the name of the VCD file
    $dumpvars(0, tb_ripple_carry_adder);    // Dump all variables in the testbench

    // Initialize carry-in to 0
    Cin = 0;
    // Test case 1: A = 4'b0000, B = 4'b0000 (0 + 0)
    A = 4'b0000;
    B = 4'b0000;
    #10;
    // Test case 2: A = 4'b0001, B = 4'b0010 (1 + 2)
    A = 4'b0001;
    B = 4'b0010;
    #10;
    // Test case 3: A = 4'b0101, B = 4'b0010 (5 + 2)
    A = 4'b0101;
    B = 4'b0010;
    #10;
    // Test case 4: A = 4'b1111, B = 4'b1111 (15 + 15)
    A = 4'b1111;
    B = 4'b1111;
    #10;
    // Test case 5: A = 4'b1010, B = 4'b0001 (10 + 1)
    A = 4'b1010;
    B = 4'b0001;
    #10;
    // End the simulation
    $finish;
end

endmodule