## Exercise 4: Building a Counter (Sequential Logic)

In this lab, we will explore sequential logic and build a simple counter in Verilog. Sequential logic introduces the concept of memory, which is a crucial aspect of real-world digital systems.

#### What is a Counter?

A counter is a sequential circuit that counts in binary, incrementing its value at each clock pulse. Counters are widely used in digital systems, for example, in timers, frequency dividers, and state machines.

Since the counter relies on previous states (i.e., its current count value), it is considered a sequential circuit. It uses flip-flops to store the count and updates the count on each clock edge.

#### Task Description

Your task is to:
- **Design a 4-bit binary counter** that increments by 1 on each rising edge of the clock. Once the counter reaches the maximum value (1111 in binary or 15 in decimal), it wraps around to 0000 on the next clock pulse. Call your module `counter_4bit`.
- **Test it** with the provided testbench and Makefile (check that files/modules names match).

Key Components:
- **Clock**: The counter will count on each rising edge of the clock.
- **Reset**: You will include a reset input that sets the counter to 0000 when asserted (active).
- **4-bit Output**: The counter will have a 4-bit output representing the current count value.

```verilog
// SOLUTION
module counter_4bit (clk, reset, count);

// Define the input and output ports
input clk, reset;                       // Inputs
output [3:0] count;                     // Outputs

// Define IO wires and registers
wire clk, reset;                        // INPUTS - defined as wires
reg [3:0] count;                        // OUTPUT - defined as reg since it is assigned in an always block

// On the rising edge of the clock or when reset is asserted
always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 4'b0000;  // Reset counter to 0000
    end else begin
        count <= count + 1;  // Increment counter
    end
end

endmodule
```

- - -

#### Previous Exercise
- [Exercise 3: Building a Ripple Carry Adder using Full Adders](../Ex3_RippleCarryAdder/README.md)