// ============================================================================
// Module Name:    lfsr
// Description:    Parameterized Linear Feedback Shift Register (LFSR)
// Author:         Tzamn Melendez Carmona
//
// Inputs:
//   - Clock         : Clock signal to synchronize state updates
//   - Reset         : Asynchronous reset; loads the InitialState
//   - Enable        : Enables the shift operation
//   - InitialState  : Initial seed value for the LFSR
//
// Output:
//   - RandOut       : Current pseudo-random value from the LFSR
//
// Parameters:
//   - NBITS_LFSR       : Width of the LFSR register
//   - LFSR_TAP_BITS    : Bitmask that defines feedback tap positions
//
// Dependencies:
//   - parameters.v must define NBITS_LFSR and LFSR_TAP_BITS
//
// ----------------------------------------------------------------------------
// Functionality:
// This module implements a generic, parameterized LFSR using a tap-mask
// configuration to define feedback positions. On each clock cycle (when
// enabled), the register shifts right, and the MSB is filled with a feedback
// bit derived by XORing the selected tap bits (as specified in LFSR_TAP_BITS).
//
// Reset loads the LFSR with a user-defined initial state.
//
// Schematic Concept:
//
//   Feedback Bit
//       ^
//       |       +-------------------------------+
//   --->|------>| N |...|...|...|...|...|...| 1 |
//               +-------------------------------+
//                     |________ XOR taps
//
// ============================================================================
module lfsr(Clock, Reset, Enable, InitialState, RandOut);

`include "params/parameters.v"
    // Port definitions
    input Clock;
    input Reset;
    input Enable;
    input [NBITS_LFSR-1:0] InitialState;
    output [NBITS_LFSR-1:0] RandOut;

    // Internal wire definitions
    wire feedbackBit;
    wire [NBITS_LFSR-1:0] wireNextState;

    // Register to store the current LFSR state
    reg [NBITS_LFSR-1:0] regCurrentState;

    // LFSR logic
    // The new state is the current state shifted right by 1 bit
    // with the feedback bit as the new MSB
    assign wireNextState[NBITS_LFSR-2:0] = regCurrentState[NBITS_LFSR-1:1];
    assign wireNextState[NBITS_LFSR-1] = feedbackBit;

    //  Keep the bits on the current state that are tapped
    assign tappedBits = regCurrentState & LFSR_TAP_BITS;  // Mask current state with taps

    // Compute the feedback bit by XORing all bits in tappedBits.
    // This is done using the reduction XOR operator (^), which folds
    // the entire vector down into a single bit by applying XOR across
    // all the bits in the vector from left to right.
    // For example, if tappedBits = 8'b00011010,
    // then feedbackBit = 0 ^ 0 ^ 0 ^ 1 ^ 1 ^ 0 ^ 1 ^ 0 = 1
    assign feedbackBit = ^tappedBits;  // Reduction XOR

    // Output logic for the LFSR
    // Output is zero if not enabled, otherwise the next state
    assign RandOut = (Enable == 1'b0) ? 0 : wireNextState;

    // State machine to control the LFSR
    always @(posedge Clock or posedge Reset)
    begin
        if (Reset == 1'b1)
            regCurrentState <= InitialState; // Load initial state on reset
        else if (Enable == 1'b1)
            regCurrentState <= wireNextState; // Update on clock if enabled
    end

endmodule  // lfsr

