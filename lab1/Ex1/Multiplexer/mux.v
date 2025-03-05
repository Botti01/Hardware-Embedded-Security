// Multiplexer 4 to 1

module mux_4to1 #(parameter WIDTH = 8) (a, b, c, d, sel, y);

// Define the input and output ports
input  [WIDTH-1:0] a;    // Input a
input  [WIDTH-1:0] b;    // Input b
input  [WIDTH-1:0] c;    // Input c
input  [WIDTH-1:0] d;    // Input d
input  [1:0] sel;        // Select signal
output [WIDTH-1:0] y;    // Output y

// Define IO wires and registers 
wire [WIDTH-1:0] a;     // Input a
wire [WIDTH-1:0] b;     // Input b
wire [WIDTH-1:0] c;     // Input c
wire [WIDTH-1:0] d;     // Input d
wire [1:0] sel;         // Select signal
wire [WIDTH-1:0] y;     // Output y

// Implement the functionality using a conditional operator
assign y = (sel == 2'b00) ? a : 
           (sel == 2'b01) ? b : 
           (sel == 2'b10) ? c : 
           (sel == 2'b11) ? d : 0;


endmodule