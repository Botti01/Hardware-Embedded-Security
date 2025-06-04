# Exercise 1 – Parameterized Counter

## Learning Objectives
- Implement a flexible digital counter using parameters in Verilog
- Understand the interaction between sequential circuits and combinational logic
- Practice creating reusable hardware designs through parameterization
- Write effective testbenches to verify digital circuit functionality

## Introduction
Digital counters are fundamental building blocks in digital systems, found in applications ranging from timers and frequency dividers to memory address generators. In this lab, you will create a parameterizable counter that can be easily configured for different bit widths without modifying the core design.

## Verilog Parameter Techniques

Parameters allow you to create flexible, reusable hardware designs. Below are two approaches to implementing parameters in Verilog:

### Approach 1: Inline Parameters
Parameters can be defined directly within your module declaration:

```verilog
module adder #(parameter WIDTH = 8) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [WIDTH-1:0] sum
);
    assign sum = a + b;
endmodule
```

When instantiating this module, you can override the default parameter:
```verilog
// Create a 16-bit adder
adder #(.WIDTH(16)) my_adder (
    .a(input_a),
    .b(input_b),
    .sum(result)
);
```

### Approach 2: External Parameter Files
For larger projects, centralizing parameters in a dedicated file improves maintainability:

```verilog
// params/parameters.v
`ifndef PARAMETERS_V
`define PARAMETERS_V
// Global parameters
parameter NBITS_COUNTER = 8;
`endif
```

Include this file in your modules:
```verilog
`include "params/parameters.v"

module adder (
    input [NBITS_COUNTER-1:0] a,
    input [NBITS_COUNTER-1:0] b,
    output [NBITS_COUNTER-1:0] sum
);
    assign sum = a + b;
endmodule
```

## Counter Design Specifications

Your parameterized counter must include the following features:

| Feature | Description |
|---------|-------------|
| **Bit Width** | Determined by `NBITS_COUNTER` parameter in `parameters.v` |
| **Clock** | Synchronous operation on rising edge of clock |
| **Enable** | Counter increments only when Enable signal is HIGH |
| **Reset** | Synchronous reset to 0 when Reset signal is HIGH |

## Assignment Tasks

1. **Create the Parameterized Counter Module**
   - Modify the hard-wired counter from Lab 1 to use the `NBITS_COUNTER` parameter
   - Implement synchronous reset and enable functionality
   - Ensure proper synchronization with the clock

2. **Develop a Comprehensive Testbench**
   - Verify the counter increments correctly when enabled
   - Test reset functionality
   - Confirm the counter maintains its value when disabled
   - Validate proper behavior with different parameter values

3. **Document Your Design**
   - Include comments explaining your implementation choices
   - Document any assumptions or design decisions

## Project Structure

```
1_Counter/
├── src/
│   └── counter.v          // Your parameterized counter implementation
├── tb/
│   └── tb_counter.v       // Testbench for verification
└── params/
    └── parameters.v       // Parameter definitions file
```

## Simulation Instructions

1. **Navigate to your project directory**:
   ```bash
   cd 1_Counter
   ```

2. **Compile your design**:
   ```bash
   iverilog -o counter src/counter.v tb/tb_counter.v
   ```

3. **Run the simulation**:
   ```bash
   gtkwave counter.vcd
   ```
## Additional Resources
- [Verilog HDL Basics](https://www.chipverify.com/verilog/verilog-tutorial)
## MENU
- [NEXT EXERCISE](../2_lfsr/README.md)
- [MAIN PAGE](../README.md)
