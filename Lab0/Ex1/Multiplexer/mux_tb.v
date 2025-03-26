module mux_tb;

    // Parameters
    localparam WIDTH = 8;

    // Inputs
    reg  [WIDTH-1:0] a;
    reg  [WIDTH-1:0] b;
    reg  [WIDTH-1:0] c;
    reg  [WIDTH-1:0] d;
    reg  [1:0]       sel;

    // Outputs
    wire [WIDTH-1:0] y;

    // Instantiate the Device Under Test (DUT)
    mux_4to1 #(WIDTH) dut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel),
        .y(y)
    );

    // Testbench logic
    initial begin
        $dumpfile("mux.vcd");    // Specify the name of the VCD file
        $dumpvars(0, mux_tb);    // Dump all variables in the testbench

        // Initialize inputs
        a = 0;
        b = 0;
        c = 0;
        d = 0;
        sel = 2'b00;

        // Apply test cases
        #10 a = 8'hAA; b = 8'hBB; c = 8'hCC; d = 8'hDD; // Assign unique values to inputs
        // Test case 1: sel = 2'b00 (select a)
        sel = 2'b00;
        #10;
        // Test case 2: sel = 2'b01 (select b)
        sel = 2'b01;
        #10;
        // Test case 3: sel = 2'b10 (select c)
        sel = 2'b10;
        #10;
        // Test case 4: sel = 2'b11 (select d)
        sel = 2'b11;
        #10;

        // End simulation
        $finish;
    end

endmodule
