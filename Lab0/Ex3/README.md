## Exercise 3: Building a Ripple Carry Adder using Full Adders

In this exercise, you'll use the Full Adder module from [Exercise 2](./Ex2_FullAdder/README.md) to construct a Ripple Carry Adder in Verilog. A Ripple Carry Adder is a multi-bit adder that links several full adders together to add binary numbers that are more than 1-bit wide.

#### What is a Ripple Carry Adder

A Ripple Carry Adder adds two multi-bit binary numbers by cascading multiple full adders. Each full adder handles one bit of the two numbers and passes any carry bit to the next full adder in the chain. This "rippling" of the carry bit through the adders is how the Ripple Carry Adder works.

For example, a 4-bit Ripple Carry Adder consists of 4 full adders. The carry-out of one full adder is passed as the carry-in to the next full adder.

![](https://vlsiverify.com/wp-content/uploads/2022/11/ripple_carry_adder.jpg)

#### Task Description

Your task is to:
- **Create a new Verilog module** called `ripple_carry_adder` that uses the `full_adder` module from Exercise 2 to implement a **4-bit Ripple Carry Adder**.
- **Test the module** with the provided testbench and Makefile (check that files/modules names match).

```verilog
// SOLUTION
module ripple_carry_adder (A, B, Cin, Sum, Cout);

// Define the input and output ports
input [3:0] A, B;       // 4-bit inputs A and B
input Cin;              // Carry-in input (initial carry)
output [3:0] Sum;       // 4-bit Sum output
output Cout;            // Carry-out output

// Define IO wires
wire [3:0] A, B;        // 4-bit inputs A and B
wire Cin;               // Carry-in input
wire [3:0] Sum;         // 4-bit Sum output
wire Cout;              // Carry-out output

// Internal wires for connecting carries between full adders
wire C1, C2, C3;

// Instantiate the Full Adders
full_adder fa0 (
    .a(A[0]), .b(B[0]), .cin(Cin), .sum(Sum[0]), .cout(C1)
);

full_adder fa1 (
    .a(A[1]), .b(B[1]), .cin(C1), .sum(Sum[1]), .cout(C2)
);

full_adder fa2 (
    .a(A[2]), .b(B[2]), .cin(C2), .sum(Sum[2]), .cout(C3)
);

full_adder fa3 (
    .a(A[3]), .b(B[3]), .cin(C3), .sum(Sum[3]), .cout(Cout)
);

endmodule
```

- - -

#### Previous Exercise
- [Exercise 2: Building a Full Adder in Verilog](../Ex2_FullAdder/README.md)

#### Next Exercise
- [Exercise 4: Building a Counter (Sequential Logic)](../Ex4_Counter/README.md)