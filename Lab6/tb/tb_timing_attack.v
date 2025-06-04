// File:tb_timing_attack.v
// Testbench for timing attack on tb_timing_attackmodule
// Author: Tzamn Melendez Carmona
// Date: May 27, 2025
`timescale 1ns / 1ps
`include "src/hardware_comparator.v"

module tb_timing_attack;
    `include "params/parameters.v"

    // =================================================
    // PARAMETERS
    // =================================================
    parameter BIT10        = 10;
    parameter BIT12        = 12;
    parameter STORE_MODE   = 1'b1;
    parameter COMPARE_MODE = 1'b0;

    // =================================================
    // SIGNALS
    // =================================================
    reg                        Clock;
    reg                        Reset;
    reg                        Start;
    reg                        FunctionMode;
    reg  [HWC_SEL_WIDTH-1:0]   SelectAddress;
    reg  [HWC_WIDTH-1:0]       DataIn;
    reg  [HWC_PASSWORD_LENGTH-1:0] DataLength;

    wire                       StoreSuccess;
    wire                       WrongPassword;
    wire                       ValidPassword;

    reg  [HWC_WIDTH-1:0]       PASSWORD[0:BIT10-1];
    integer                    i;
    integer                    pos;
    integer                    j;

    // =================================================
    // DUT INSTANTIATION
    // =================================================
        hardware_comparator hwc(
            .Clock(Clock),
            .Reset(Reset),
            .Start(Start),
            .FunctionMode(FunctionMode),
            .SelectAddress(SelectAddress),
            .DataIn(DataIn),
            .DataLength(DataLength),
            .StoreSuccess(StoreSuccess),
            .WrongPassword(WrongPassword),
            .ValidPassword(ValidPassword)
        );

    // =================================================
    // CLOCK GENERATION
    // =================================================
    initial begin
        Clock = 0;
        forever #5 Clock = ~Clock;  // 10 ns period
    end

    // =================================================
    // TEST SEQUENCE
    // =================================================
    initial begin
        // Dump only top-level ports of DUT (hide internals)
        $dumpfile("tb_timing_attack.vcd");
        $dumpvars(0,tb_timing_attack);

        Reset = 0;
        #10; 
        Reset = 1; 
        Start = 0; 
        FunctionMode = 0;
        SelectAddress = 0; 
        DataIn = 0; 
        DataLength = 0;
        @(posedge Clock);
        Reset = 0;
        @(posedge Clock);
        @(posedge Clock);

        DataIn = 0;
        FunctionMode = COMPARE_MODE;
        SelectAddress = 8'h32;
        DataLength = BIT10;

        for (pos = 0; pos < BIT10 ; pos = pos + 1) begin 
            for (i = 0; i <= 26; i = i + 1) begin
                Start = 1; // Prepare to start the comparison
                @(posedge Clock);
                Start = 0; // Trigger the comparison
                // Feed previously found characters first
                if (pos > 0) begin
                    for (j = 0; j < pos; j = j + 1) begin
                        DataIn = PASSWORD[j];
                        @(posedge Clock);
                    end
                end
                DataIn = (65 + i);  // ASCII starting from 'A' (65) + i
                @(posedge Clock);
                @(posedge Clock);
                if (WrongPassword == 0) begin
                    $display("Found valid character %c at position %0d after %0d attempts", 65 + i, pos, i);
                    PASSWORD[pos] = DataIn; // Store the found character
                    i = 26; // Break out of this inner loop
                end
            end
        end

        #40;

        DataIn = 0;
        FunctionMode = COMPARE_MODE;
        SelectAddress = 8'h64;
        DataLength = BIT12;

        for (pos = 0; pos < BIT12 ; pos = pos + 1) begin 
            for (i = 0; i <= 26; i = i + 1) begin
                Start = 1; // Prepare to start the comparison
                @(posedge Clock);
                Start = 0; // Trigger the comparison
                // Feed previously found characters first
                if (pos > 0) begin
                    for (j = 0; j < pos; j = j + 1) begin
                        DataIn = PASSWORD[j];
                        @(posedge Clock);
                    end
                end
                DataIn = (65 + i);  // ASCII starting from 'A' (65) + i
                @(posedge Clock);
                @(posedge Clock);
                if (WrongPassword == 0) begin
                    $display("Found valid character %c at position %0d after %0d attempts", 65 + i, pos, i);
                    PASSWORD[pos] = DataIn; // Store the found character
                    i = 26; // Break out of this inner loop
                end
            end
        end

        $display("Simulation completed");
        $finish;
    end
    // Monitoring signals
    always @(posedge Clock) begin
        if (ValidPassword) begin
            $display("Valid password detected at time %0t", $time);
        end
    end
endmodule
