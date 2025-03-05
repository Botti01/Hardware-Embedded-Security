// Implement a D flip-flop in Verilog

module dff (clk, rst, d, q);

// Define the input and output ports
input clk;
input rst;
input d;
output q;

// Define IO wires and registers
wire clk, rst, d;  // INPUTS - defined as wires
reg q;             // OUTPUT - defined as reg since it is assigned in an always block

// Define the flip-flop behavior
always @(posedge clk or posedge rst) begin
    if (rst) begin
        q <= 1'b0;
    end else begin
        q <= d;
    end
end

endmodule