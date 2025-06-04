`timescale 1ns/1ps

module tb_tea;
    // Clock and reset
    reg         clk;
    reg         rst;
    // Input to DUT
    reg         start;
    reg  [63:0] plaintext;
    // Outputs from DUT
    wire [63:0] ciphertext;
    wire        done;

    // Instantiate the TEA core with Trojan
    tea dut (
        .clk        (clk),
        .rst        (rst),
        .start      (start),
        .plaintext  (plaintext),
        .ciphertext (ciphertext),
        .done       (done)
    );

    // Clock generation: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
	$dumpfile("tea.vcd");
	$dumpvars(0, tb_tea);
        // --------------------------------------------------------------------
        // 1) Reset
        // --------------------------------------------------------------------
        rst       = 1;
        start     = 0;
        plaintext = 64'd0;
        #20;
        rst = 0;
        #10;

        // --------------------------------------------------------------------
        // 2) Normal encryption test
        // --------------------------------------------------------------------
        // Use TRIG1 value for functional check as well (plaintext = 0x0123456789ABCDEF)
        plaintext = 64'h0453_3337_89AB_CD79;
        start = 1;
        #10  start = 0;
        // Wait for encryption to complete
        wait (done);
        $display("NORMAL:  PT = 0x%016h => CT = 0x%016h", plaintext, ciphertext);

        #20;

        // --------------------------------------------------------------------
        // 3) Trojan trigger sequence
        // --------------------------------------------------------------------
        // First trigger word
        plaintext = 64'h0123_4567_89AB_CDEF;  // TRIG1
        start = 1;
        #10 start = 0;
        // Second trigger word
        plaintext = 64'hFEDC_BA98_7654_3210;  // TRIG2
        // Immediately after this cycle, the Trojan will leak the key

        // --------------------------------------------------------------------
        // 4) Capture leaked key (two words)
        // --------------------------------------------------------------------
        // First leak (MSW of key)
        #15 $display("TROJAN LEAK 1: expected: 0xA56BABCD0000FFFF - KEY[127:64] = 0x%016h", ciphertext);
        #10 $display("TROJAN LEAK 2: expected: 0x123456789ABCDEF0 - KEY[ 63: 0] = 0x%016h", ciphertext);

        #20;
        $finish;
    end

endmodule

