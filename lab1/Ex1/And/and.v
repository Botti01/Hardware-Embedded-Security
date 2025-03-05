module and_gate (A, B, Y);

// Define the input and output ports
input A, B;
output Y;

// Define IO wires and registers 
wire A, B;      // INPUTS - defined as wires in most cases
wire Y;         // OUTPUTS - defined as wire since we will assign it continuosly with an assign statement

// Internal wires and registers (if any)

// Define the AND gate
assign Y = A & B;

endmodule
