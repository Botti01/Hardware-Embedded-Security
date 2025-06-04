// File: hardware_comparator.v
// Author: Tzamn Melendez Carmona
// Date: May 27, 2025
// Description:
//   A parameterized hardware password comparator module with two modes:
//     - STORE_MODE: Stores an input password sequence into internal memory.
//     - COMPARE_MODE: Compares an input password sequence against stored memory.
//   Outputs:
//     - StoreSuccess: pulses high when storage completes successfully.
//     - WrongPassword: asserted if any comparison fails in COMPARE_MODE.
//     - ValidPassword: asserted when the full comparison sequence matches.

module hardware_comparator(
    Clock,           // System clock
    Reset,           // Asynchronous reset
    Start,           // Start signal for new transaction
    FunctionMode,    // Mode selector: 1 = STORE, 0 = COMPARE
    DataIn,          // Input data (password byte)
    DataLength,      // Number of bytes in password
    SelectAddress,   // Starting address in memory
    StoreSuccess,    // Indicates successful storage
    WrongPassword,   // Indicates mismatch during compare
    ValidPassword    // Indicates full match
);

// I/O declarations
input                Clock;
input                Reset;
input                Start;
input                FunctionMode;
input  [HWC_WIDTH-1:0]           DataIn;
input  [HWC_PASSWORD_LENGTH-1:0] DataLength;
input  [HWC_SEL_WIDTH-1:0]       SelectAddress;
output               StoreSuccess;
output               WrongPassword;
output               ValidPassword;

// Internal signals
wire                 Clock;
wire                 Reset;
wire                 Start;
wire                 FunctionMode;
wire  [HWC_WIDTH-1:0]           DataIn;
wire  [HWC_PASSWORD_LENGTH-1:0] DataLength;
wire  [HWC_SEL_WIDTH-1:0]       SelectAddress;
reg                  StoreSuccess;
wire                 WrongPassword;
wire                 ValidPassword;

// Parameter definitions
`include "params/parameters.v"
parameter STORE_MODE   = 1'b1;
parameter COMPARE_MODE = 1'b0;
parameter SUCCESS      = 1'b1;
parameter FAILURE      = 1'b0;

// Internal memory and registers
reg   [HWC_WIDTH-1:0] InternalMemory [0:HWC_MEMORY_SIZE-1];
reg   [HWC_INDEX_PSW_LENGTH-1:0] RegIndexPassword;
reg   [HWC_SEL_WIDTH-1:0]       RegCurrentAddress;
reg   [HWC_WIDTH-1:0]           MemReadData;
reg                             RegValidPassword;
reg                             RegWrongPassword;
wire                            wireEqualFlag;
wire                            wireWrongPassword;

// Next address calculation
wire [HWC_SEL_WIDTH-1:0] wireNextAddress;
assign wireNextAddress = RegCurrentAddress + 1;
// Compare data read vs input
assign wireEqualFlag   = (MemReadData == DataIn) ? SUCCESS : FAILURE;
// Drive outputs
assign ValidPassword   = RegValidPassword;
// WrongPassword: true in compare mode if a mismatch occurs and not already validated
assign wireWrongPassword   = (FunctionMode == COMPARE_MODE)
                        && (~wireEqualFlag)
                        && (~Start)      // not during start pulse
                       ? SUCCESS
                       : FAILURE;
assign WrongPassword = RegWrongPassword;

integer i;  // loop variable for reset
// Main sequential block
always @(posedge Clock or posedge Reset or posedge Start) begin
    if (Reset) begin
        // Asynchronous reset: clear all state and memory
        RegIndexPassword  <= 0;
        RegCurrentAddress <= 0;
        StoreSuccess      <= 0;
        MemReadData       <= 0;
        RegValidPassword  <= 0;
        RegWrongPassword  <= 0;
        // for (i = 0; i < HWC_MEMORY_SIZE; i = i + 1) begin
        //     InternalMemory[i] <= 0;
        // end
        $readmemh("src/init.mem", InternalMemory);
    end
    else if (Start) begin
        // Start of new sequence: reinitialize indices and flags
        RegIndexPassword  <= 0;
        RegCurrentAddress <= SelectAddress;
        StoreSuccess      <= 0;
        RegValidPassword  <= 0;
        RegWrongPassword  <= 0;
    end
    else begin
        // Active operation after start deasserted
        if (FunctionMode == STORE_MODE && !StoreSuccess) begin
            // STORE: write DataIn to memory
            InternalMemory[RegCurrentAddress] <= DataIn;
            if (RegIndexPassword >= DataLength) begin
                // All bytes stored
                StoreSuccess <= 1;
            end else begin
                // Move to next byte
                RegCurrentAddress <= wireNextAddress;
                RegIndexPassword  <= RegIndexPassword + 1;
            end
        end else begin
            // COMPARE mode or STORE done
            // Read current memory location
            MemReadData <= InternalMemory[RegCurrentAddress];
            if (RegWrongPassword == 1'b0) begin
                RegWrongPassword <= wireWrongPassword;
            end else begin
                RegWrongPassword <= 1'b1;  // Keep it high if already wrong
            end
            if (RegIndexPassword >= DataLength) begin
                // End of compare sequence: set valid if last byte matched
                RegValidPassword <= ~RegWrongPassword & wireEqualFlag;
            end else begin
                RegCurrentAddress <= wireNextAddress;
                RegIndexPassword  <= RegIndexPassword + 1;
            end
        end
    end
end

endmodule
