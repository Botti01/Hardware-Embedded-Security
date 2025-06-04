// Testbench for adder_trojan module
`timescale 1ns/1ps

module tb_adder_trojan();
    // Inputs
    reg [7:0] A;
    reg [7:0] B;
    
    // Outputs
    wire [7:0] SUM;
    
    // Expected output for verification
    reg [7:0] expected_sum;
    
    // Instantiate the adder_trojan module
    adder_trojan uut (
        .A(A),
        .B(B),
        .SUM(SUM)
    );
    
    // Test procedure
    initial begin
        $dumpfile("adder_trojan.vcd");
        $dumpvars(0, tb_adder_trojan);
        // Initialize inputs
        A = 8'h00;
        B = 8'h00;
        
        // Add some delay for simulation to settle
        #10;
        
        // Test Case 1: Simple addition (no trojan trigger)
        A = 8'h03;
        B = 8'h04;
        expected_sum = A + B; // Should be 7
        #10;
        
        $display("Test Case 1: Normal Operation");
        $display("A = %h, B = %h", A, B);
        $display("Expected SUM = %h, Actual SUM = %h", expected_sum, SUM);
        $display("Trojan Triggered: %s", (expected_sum === SUM) ? "No" : "Yes");
        $display("");
        
        // Test Case 2: Larger numbers (no trojan trigger)
        A = 8'h45;
        B = 8'h32;
        expected_sum = A + B;
        #10;
        
        $display("Test Case 2: Normal Operation");
        $display("A = %h, B = %h", A, B);
        $display("Expected SUM = %h, Actual SUM = %h", expected_sum, SUM);
        $display("Trojan Triggered: %s", (expected_sum === SUM) ? "No" : "Yes");
        $display("");
        
        // Test Case 3: Overflow scenario (no trojan trigger)
        A = 8'hFF;
        B = 8'h01;
        expected_sum = A + B; // Should be 00h with overflow
        #10;
        
        $display("Test Case 3: Overflow Scenario");
        $display("A = %h, B = %h", A, B);
        $display("Expected SUM = %h, Actual SUM = %h", expected_sum, SUM);
        $display("Trojan Triggered: %s", (expected_sum === SUM) ? "No" : "Yes");
        $display("");
        
        // Test Case 4: Medium values (no trojan trigger)
        A = 8'h2A;
        B = 8'h18;
        expected_sum = A + B;
        #10;
        
        $display("Test Case 4: Medium Values");
        $display("A = %h, B = %h", A, B);
        $display("Expected SUM = %h, Actual SUM = %h", expected_sum, SUM);
        $display("Trojan Triggered: %s", (expected_sum === SUM) ? "No" : "Yes");
        $display("");
        
        // Test Case 5: One operand zero (no trojan trigger)
        A = 8'h73;
        B = 8'h00;
        expected_sum = A + B;
        #10;
        
        $display("Test Case 5: One Operand Zero");
        $display("A = %h, B = %h", A, B);
        $display("Expected SUM = %h, Actual SUM = %h", expected_sum, SUM);
        $display("Trojan Triggered: %s", (expected_sum === SUM) ? "No" : "Yes");
        $display("");
        
        // Test Case 6: Trojan trigger
        A = 8'hDE;
        B = 8'hAD;
        expected_sum = A + B;
        #10;
        
        $display("Test Case 6: Trojan Trigger Condition");
        $display("A = %h, B = %h", A, B);
        $display("Expected SUM (without trojan) = %h, Actual SUM = %h", expected_sum, SUM);
        $display("Trojan Triggered: %s", (expected_sum === SUM) ? "No" : "Yes");
        $display("Expected with trojan: MSB flipped = %h", expected_sum ^ 8'h80);
        $display("");
        
        // Test Case 7: Verify that the trojan triggered
        A = 8'h25;
        B = 8'h5B;
        expected_sum = A + B;
        #10;
        
        $display("Test Case 7: Post-trigger Operation");
        $display("A = %h, B = %h", A, B);
        $display("Expected SUM = %h, Actual SUM = %h", expected_sum, SUM);
        $display("Trojan Triggered: %s", (expected_sum === SUM) ? "No" : "Yes");
        $display("");
        
        // Test Case 8: Identical operands (post-trigger)
        A = 8'h55;
        B = 8'h55;
        expected_sum = A + B;
        #10;
        
        $display("Test Case 8: Identical Operands (Post-trigger)");
        $display("A = %h, B = %h", A, B);
        $display("Expected SUM = %h, Actual SUM = %h", expected_sum, SUM);
        $display("Trojan Triggered: %s", (expected_sum === SUM) ? "No" : "Yes");
        $display("");
        
        // Test Case 9: Overflow (post-trigger)
        A = 8'hF0;
        B = 8'h20;
        expected_sum = A + B;
        #10;
        
        $display("Test Case 9: Overflow (Post-trigger)");
        $display("A = %h, B = %h", A, B);
        $display("Expected SUM = %h, Actual SUM = %h", expected_sum, SUM);
        $display("Trojan Triggered: %s", (expected_sum === SUM) ? "No" : "Yes");
        $display("");
        
        // End simulation
        $display("Simulation completed");
        $finish;
    end
endmodule