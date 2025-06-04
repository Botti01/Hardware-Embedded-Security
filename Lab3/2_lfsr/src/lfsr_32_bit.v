// ============================================================================
// Module Name:    lfsr_32_bit
// Description:    32-bit Linear Feedback Shift Register (LFSR) generator
//                 using an 8-bit LFSR to build a full 32-bit pseudo-random
//                 value in chunks. Controlled by Clock, Reset, and Enable.
//
// Author:         Tzamn Melendez Carmona
//
// Inputs:
//   - Clock         : System clock for synchronization
//   - Reset         : Resets the internal state to InitialState
//   - Enable        : Enables random number generation
//   - InitialState  : 32-bit value used to initialize the LFSR
//
// Outputs:
//   - RandOut       : Current 32-bit pseudo-random output
//
// Dependencies:
//   - lfsr.v        : Contains a parameterized LFSR module
//   - parameters.v  : Defines parameter values such as LFSR bit widths and taps
//
// Parameters:
//   - LFSR_32_BIT        : Width of the 32-bit LFSR accumulator
//   - LFSR_8_BIT         : Width of the 8-bit sub-LFSR
//   - LFSR_8_BIT_TAPS    : Tap configuration for the 8-bit LFSR
//
// ----------------------------------------------------------------------------
// Functionality:
// This module builds a 32-bit pseudo-random number by shifting in 8 bits at
// a time from a smaller 8-bit LFSR. On each clock cycle (when enabled), it
// captures a new 8-bit value and shifts it into the higher bits of the
// 32-bit register, effectively creating a concatenated stream of pseudo-
// random data.
//
// Resetting the module loads the 32-bit register with the provided initial
// state. The 8-bit LFSR is also initialized with the lower 8 bits of this
// state.
//
// Schematic Concept:
//
//   8-bit LFSR -> [7:0] + Current [31:8] = New [31:0]
//
//        +------------+
//  --->  | LFSR [7:0] |      <-- Generates 8-bit values
//        +------------+
//             ||
//             VV
//   +-----------------------------+
//   | RandOut [31:0] (Shift Reg) |
//   +-----------------------------+
//
// ============================================================================

`include "src/lfsr.v"
module lfsr_32_bit(Enable, Reset, Clock, InitialState, RandOut);

`include "params/parameters.v"
    // Port definitions
    input Enable;                              // Enables LFSR operation
    input Reset;                               // Asynchronous reset
    input Clock;                               // Clock input
    input [LFSR_32_BIT - 1:0] InitialState;    // Initial 32-bit seed
    output [LFSR_32_BIT - 1:0] RandOut;         // 32-bit random output

    // Internal Wires and Registers
    wire [LFSR_8_BIT - 1:0] wireLfsrOut;       // Output from 8-bit LFSR
    wire [LFSR_8_BIT - 1:0] wireLfsrInitState; // Initial seed for 8-bit LFSR
    wire [LFSR_32_BIT - 1:0] wireNextState;    // Next state of 32-bit register
    reg  [LFSR_32_BIT - 1:0] regCurrentState;  // Internal state register

    // Use least significant 8 bits of InitialState as seed for 8-bit LFSR
    assign wireLfsrInitState = InitialState[LFSR_8_BIT - 1:0];

    // Instantiate 8-bit LFSR module
    lfsr #(
        .NBITS_LFSR(LFSR_8_BIT), 
        .LFSR_TAP_BITS(LFSR_8_BIT_TAPS)
    )
    lfsr8bit (
        .Clock(Clock),
        .Reset(Reset),
        .Enable(Enable),
        .InitialState(wireLfsrInitState),
        .RandOut(wireLfsrOut)
    );

    // Compute the next state: shift in 8-bit LFSR output into higher bits
    assign wireNextState = {wireLfsrOut, regCurrentState[LFSR_32_BIT - 1:LFSR_8_BIT]};

    // Output the current state if enabled, otherwise zero
    assign RandOut = (Enable == 1'b0) ? 0 : wireNextState;

    // Sequential logic to update state on clock or reset
    always @(posedge Clock or posedge Reset) 
    begin
        if (Reset == 1'b1)
            regCurrentState <= InitialState;
        else if (Enable == 1'b1)
            regCurrentState <= wireNextState;
    end

endmodule // lfsr_32_bit
