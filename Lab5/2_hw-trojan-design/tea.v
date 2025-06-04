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

    // ------------------------------------------------------------------------
    // FSM state encoding
    // ------------------------------------------------------------------------
    localparam IDLE   = 3'd0;
    localparam RUN    = 3'd1;
    localparam FINISH = 3'd2;

    // ------------------------------------------------------------------------
    // Internal registers
    // ------------------------------------------------------------------------
    reg [2:0]   state, next_state;
    reg [31:0]  v0, v1, sum;
    reg [5:0]   round_cnt;
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
        // Default: hold current values
        next_state      = state;
        v0_next         = v0;
        v1_next         = v1;
        sum_next        = sum;
        round_cnt_next  = round_cnt;
        ciphertext_next = ciphertext;
        done_next       = 1'b0;

        case (state)
            // IDLE: wait for start, load plaintext
            IDLE: begin
                if (start) begin
                    v0_next        = plaintext[63:32];
                    v1_next        = plaintext[31:0];
                    sum_next       = 32'd0;
                    round_cnt_next = 6'd0;
                    next_state     = RUN;
                end
            end

            // RUN: perform one TEA round per cycle
            RUN: begin
                sum_next       = sum + DELTA;
                v0_next        = v0 + (
                    ((v1 << 4) + SECRET_KEY[127:96]) ^
                    (v1 + sum)                   ^
                    ((v1 >> 5) + SECRET_KEY[ 95:64])
                );
                v1_next        = v1 + (
                    ((v0 << 4) + SECRET_KEY[ 63:32]) ^
                    (v0 + sum)                     ^
                    ((v0 >> 5) + SECRET_KEY[ 31: 0])
                );
                round_cnt_next = round_cnt + 1;
                if (round_cnt == ROUNDS-1)
                    next_state = FINISH;
            end

            // FINISH: output ciphertext and flag done
            FINISH: begin
                ciphertext_next = {v0, v1};
                done_next       = 1'b1;
                next_state      = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
