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
wire  [HWC_SEL_WIDTH-1:0]  SelectAddress;
reg                 StoreSuccess;
wire                WrongPassword;
// wire                wireTempWrongPassword;
wire                ValidPassword;
wire                wireEqualFlag;
wire                wireIsValid;

// Parameter definitions
`include "params/parameters.v"
parameter STORE_MODE   = 1'b1;
parameter COMPARE_MODE = 1'b0;
parameter SUCCESS      = 1'b1;
parameter FAILURE      = 1'b0;
parameter BUFFER_SIZE = 16;

// Internal memory and registers
reg [HWC_WIDTH-1:0] InternalMemory [0:HWC_MEMORY_SIZE-1];
reg [HWC_INDEX_PSW_LENGTH-1:0]  RegIndexPassword;
reg [HWC_SEL_WIDTH-1:0]         RegCurrentAddress;
reg [HWC_WIDTH-1:0]             MemReadData;
reg [BUFFER_SIZE-1:0]           InternalBuffer;
reg [HWC_SEL_WIDTH-1:0]         RegCounter; // Counter for compare mode
reg                             RegValidPassword;
reg                             RegWrongPassword;

// Next address calculation
wire [HWC_SEL_WIDTH-1:0] wireNextAddress;
assign wireNextAddress = RegCurrentAddress + 1;
// Compare data read vs input
assign wireEqualFlag   = (MemReadData == DataIn) ? SUCCESS : FAILURE;
// Drive outputs
assign ValidPassword   = RegValidPassword;
assign WrongPassword   = RegWrongPassword;

assign wireIsValid = &(InternalBuffer[BUFFER_SIZE-1:0]); 

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
        InternalBuffer <= 0;
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
        RegCounter        <= 0;
        InternalBuffer <= 0;
        RegWrongPassword  <= 0;
    end
    else begin
        // Active operation after start deasserted
        // In STORE_MODE, Nothing to Change
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
            // In COMPARE_MODE BUFFERING BEFORE COMPARING
            // COMPARE mode or STORE done
            // Read current memory location
            MemReadData <= InternalMemory[RegCurrentAddress];
            if (RegIndexPassword >= DataLength) begin
                // End of compare sequence: set valid if last byte matched
                // Since now Wrong and Valid are set based on the buffer they are just the inverse
                // signal of each other
                if (RegCounter > BUFFER_SIZE) begin
                    RegValidPassword <= wireIsValid;
                    RegWrongPassword <= ~wireIsValid;
                end else begin
                    RegCounter <= RegCounter + 1;
                    InternalBuffer <= {InternalBuffer[BUFFER_SIZE-2:0], 1'b1}; // Assume all the other bytes matched
                end
            end else begin
                // Continue comparing next byte
                // Use the buffer to store the comparison results, 1 for match, 0 for mismatch
                InternalBuffer <= {InternalBuffer[BUFFER_SIZE-2:0], wireEqualFlag};
                RegCurrentAddress <= wireNextAddress;
                RegIndexPassword  <= RegIndexPassword + 1;
                RegCounter <= RegCounter + 1;
            end
        end
    end
end

endmodule
