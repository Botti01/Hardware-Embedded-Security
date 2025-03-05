module dff_tb;     // Testbench for Flip-Flop

reg clk, rst, d;  // Registers to store test inputs
wire q;           // Wire to capture the output

// Instantiate the Flip-Flop
dff dut (
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
);

// Clock generation
always #5 clk = ~clk;  // Toggle clock every 5 time units

// Test procedure
initial begin
    $dumpfile("dff.vcd");         // Specify the name of the VCD file
    $dumpvars(0, dff_tb);         // Dump all variables in the testbench

    // Initialize inputs
    clk = 0; rst = 0; d = 0;

    // Apply test inputs
    rst = 1; #10;  // Reset the flip-flop
    rst = 0; d = 1; #10;  // Set d to 1
    d = 0; #10;  // Set d to 0
    d = 1; #10;  // Set d to 1

    // End simulation
    $finish;
end

endmodule
