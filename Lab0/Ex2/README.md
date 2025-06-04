## Exercise 2: Building a Full Adder in Verilog

In this exercise, you will design and simulate a Full Adder using Verilog. The Full Adder is a key component in digital circuits, used for performing binary addition. To ensure the module works correctly, you will also create a testbench for verification.

### Part 1 - Design a Full Adder

A Full Adder adds three 1-bit binary numbers: a, b, and cin (carry-in) and it produces two outputs:
- **sum**: the result of the addition.
- **cout**: the carry-out bit, which is used if the sum exceeds the value that can be represented by a single bit (i.e., 2).

##### Truth Table

The Full Adder can be described by the following truth table:
| a	| b	| cin	| sum	| cout | 
|-----|-----|:-----:|:-----:|:-----:|
| 0	| 0	| 0	    | 0	    | 0    |
| 0	| 0	| 1	    | 1	    | 0    |
| 0	| 1	| 0	    | 1	    | 0    |
| 0	| 1	| 1	    | 0	    | 1    |
| 1	| 0	| 0	    | 1	    | 0    |
| 1	| 0	| 1	    | 0	    | 1    |
| 1	| 1	| 0	    | 0	    | 1    |
| 1	| 1	| 1	    | 1	    | 1    |

##### Full Adder Equations

From the truth table, we can derive the following logic equations:
```
sum = a ⊕ b ⊕ cin (the XOR of the three inputs)
cout = (a & b) | (b & cin) | (a & cin) (carry out is true if at least two of the three inputs are true)
```

Your task is to implement these equations in Verilog to create a Full Adder module.

```verilog
// SOLUTION
module full_adder (a, b, cin, sum, cout);

// Define the input and output ports
input a, b, cin;                        // Inputs
output sum, cout;                       // Outputs

// Define IO wires and registers
wire a, b, cin;                         // INPUTS - defined as wires
wire sum, cout;                          // OUTPUTS - defined as wire since they are assigned in an assign block

// Logic for sum and carry-out
assign sum = a ^ b ^ cin;               // XOR for sum
assign cout = (a & b) | (b & cin) | (a & cin);  // Carry-out logic

endmodule
```

### Part 2 - Build a testbench for the Full Adder and simulate it

To verify the correct operation of your Full Adder, you should design a testbench and test it, following the same steps outlined in the previous exercise.

```verilog
// SOLUTION
module tb_full_adder;
    
// Declare variables to drive the inputs
reg a;
reg b;
reg cin;
wire sum;
wire cout;

// Instantiate the full_adder module
full_adder dut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

// Create a VCD file for waveform dumping
initial begin
    $dumpfile("fa.vcd");            // Specify the name of the VCD file
    $dumpvars(0, tb_full_adder);    // Dump all variables in the testbench

    // Test case 1: a = 0, b = 0, cin = 0
    a = 0; b = 0; cin = 0;
    #10;  // Wait for 10 time units
    // Test case 2: a = 0, b = 0, cin = 1
    a = 0; b = 0; cin = 1;
    #10;
    // Test case 3: a = 0, b = 1, cin = 0
    a = 0; b = 1; cin = 0;
    #10;
    // Test case 4: a = 0, b = 1, cin = 1
    a = 0; b = 1; cin = 1;
    #10;
    // Test case 5: a = 1, b = 0, cin = 0
    a = 1; b = 0; cin = 0;
    #10;
    // Test case 6: a = 1, b = 0, cin = 1
    a = 1; b = 0; cin = 1;
    #10;
    // Test case 7: a = 1, b = 1, cin = 0
    a = 1; b = 1; cin = 0;
    #10;
    // Test case 8: a = 1, b = 1, cin = 1
    a = 1; b = 1; cin = 1;
    #10;
    // End the simulation
    $finish;
end

endmodule
```

- - -

#### Previous Exercise
- [Exercise 1: Introduction to Verilog and Digital Design](../Ex1_HDLIntro/README.md)

#### Next Exercise
- [Exercise 3: Building a Ripple Carry Adder using Full Adders](../Ex3_RippleCarryAdder/README.md)