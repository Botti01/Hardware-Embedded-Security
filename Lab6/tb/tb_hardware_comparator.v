// File: tb_hardware_comparator.v
// Testbench for hardware_comparator module
// Author: Tzamn Melendez Carmona
// Date: May 27, 2025
`timescale 1ns / 1ps
`include "src/hardware_comparator_secure.v"
// `include "src/hardware_comparator.v"

module tb_hardware_comparator;

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

    reg  [HWC_WIDTH-1:0]       PASSWORD_10_ARR [0:BIT10-1];
    reg  [HWC_WIDTH-1:0]       PASSWORD_12_ARR [0:BIT12-1];
    integer                    i;

    // =================================================
    // DUT INSTANTIATION
    // =================================================
        hardware_comparator dut(
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
    // INITIALIZE PASSWORD ARRAYS FROM FILES
    // =================================================
    initial begin
        $readmemh("tb/password_0.txt", PASSWORD_10_ARR);
        $readmemh("tb/password_1.txt", PASSWORD_12_ARR);
    end

    // =================================================
    // TEST SEQUENCE
    // =================================================
    initial begin
        // Dump only top-level ports of DUT (hide internals)
        $dumpfile("tb_hardware_comparator.vcd");
        $dumpvars(1, tb_hardware_comparator);

        // Reset pulse
        Reset = 1; Start = 0; FunctionMode = 0;
        SelectAddress = 0; DataIn = 0; DataLength = 0;
        #15;  // > one clock cycle
        Reset = 0;
        #10;

        // ----------- STORE PASSWORD_10 -----------
        FunctionMode = STORE_MODE;
        SelectAddress = 0;
        DataLength = BIT10;
        @(posedge Clock) Start = 1;
        @(posedge Clock) Start = 0;
        for (i = 0; i < BIT10; i = i + 1) begin
            DataIn = PASSWORD_10_ARR[i];
            @(posedge Clock);
        end
        DataIn = 0;
        #10;

        // ----------- COMPARE correct PASSWORD_10 -----------
        FunctionMode = COMPARE_MODE;
        SelectAddress = 0;
        DataLength = BIT10;
        @(posedge Clock) Start = 1;
        @(posedge Clock) Start = 0;
        for (i = 0; i < BIT10; i = i + 1) begin
            DataIn = PASSWORD_10_ARR[i];
            @(posedge Clock);
        end
        DataIn = 0;
        #100;
        // compare with a wrong password
        FunctionMode = COMPARE_MODE;
        SelectAddress = 0;
        DataLength = BIT10;
        @(posedge Clock) Start = 1;
        @(posedge Clock) Start = 0;
        for (i = 0; i < BIT12; i = i + 1) begin
            DataIn = PASSWORD_12_ARR[i];
            @(posedge Clock);
        end
        #100;
        // compare with a password with all mismatched bits
        FunctionMode = COMPARE_MODE;
        SelectAddress = 0;
        DataLength = BIT10;
        @(posedge Clock) Start = 1;
        @(posedge Clock) Start = 0;
        for (i = 1; i < BIT10; i = i + 1) begin
            DataIn = PASSWORD_12_ARR[i];
            @(posedge Clock);
        end
        #100;

        $display("Simulation completed");
        $finish;
    end

    // =================================================
    // MONITORS
    // =================================================
    always @(posedge StoreSuccess)  $display("[STORE SUCCESS]    @ %0t", $time);
    always @(posedge WrongPassword) $display("[WRONG PASSWORD]   @ %0t", $time);
    always @(posedge ValidPassword) $display("[VALID PASSWORD]   @ %0t", $time);

endmodule
