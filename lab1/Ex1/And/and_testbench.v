// Description: Testbench for the AND gate

module and_testbench;

// Defining the signals
reg A, B;  // Inputs for the AND gate
wire Y;    // Output from the AND gate


// Define the dut (design/device under test)
and_gate dut (       // Instantiate the AND gate
    .A(A),           // Connect A input to A of and_gate
    .B(B),           // Connect B input to B of and_gate
    .Y(Y)            // Connect Y output to Y of and_gate
);

// Defining the test procedure
initial begin
    $dumpfile("and.vcd");      // Specify the name of the VCD file
    $dumpvars(0, and_testbench); // Dump all variables from the testbench module
    // Apply test inputs
    A = 0; B = 0; #10;  // Wait 10 time units
    A = 0; B = 1; #10;
    A = 1; B = 0; #10;
    A = 1; B = 1; #10;

    // End simulation
    $finish;
end

endmodule