# Lab 3 – Generic 16-bit Multiplexer (MUX)

## Learning Objectives
- Implement a configurable multiplexer using parameters in Verilog
- Master pure combinational logic design techniques
- Apply parameterization principles to create reusable digital components
- Understand multiplexer operation and selection mechanisms
- Practice efficient hardware description using Verilog constructs

## Introduction to Multiplexers

Multiplexers (MUX) are fundamental building blocks in digital systems that select one of multiple
input signals and forward it to a single output based on a selection control signal. They function
as programmable switches and are essential components in:

- Data routing and bus systems
- Memory addressing
- ALU operations and instruction decoding
- Communication systems
- Signal selection in control paths

## Key Concepts

### Combinational Logic
- **Definition**: Circuits whose outputs depend solely on current input values, without any memory elements
- **Properties**: No state retention, no clock dependence, instantaneous response to input changes
- **Implementation**: Implemented using `assign` statements, conditional operators, or combinational `always` blocks

### Multiplexer Operation
The multiplexer selects which of its N inputs to forward to the output based on the binary value of the selection signal:

| Select Value | Output |
|--------------|--------|
| 0 | Input[0] |
| 1 | Input[1] |
| 2 | Input[2] |
| ... | ... |
| N-1 | Input[N-1] |

### Parameterization Benefits
- **Reusability**: The same module can be used in multiple contexts with different configurations
- **Maintainability**: Changes to the design only need to be made in one place
- **Scalability**: Easily adapt designs to different bit widths or sizes
- **Design verification**: Simplified testing across different parameter configurations

## Assignment Requirements

### Functional Requirements
Implement a parameterized 16-input, 1-output multiplexer with the following characteristics:

- Input selector determines which bit from the data input is forwarded to the output
- All functionality must be implemented using **pure combinational logic**
- Module must be parameterized using values from `params/parameters.v`
- Design must support any number of inputs defined by `NINPUTS_MUX` parameter

### Technical Constraints
- ** Must use only combinational logic**
- ** No sequential logic allowed (no flip-flops, registers, or memory elements)**
- ** No clock signals, reset signals, or edge-triggered constructs**
- ** No `always @(posedge clk)` blocks**

## Project Structure
```
3_mux/
├── src/
│   └── mux.v             // Your multiplexer implementation 
├── tb/
│   └── tb_mux.v          // Testbench to verify functionality
└── params/
    └── parameters.v      // Parameter definitions
```

## Verification Strategy

Your testbench should verify:
1. **Basic functionality**: Each input can be selected and correctly appears at the output
2. **Boundary conditions**: Test edge cases like selecting the first and last inputs
3. **Invalid selections**: Test behavior when Select value exceeds valid input range
4. **Parameter variations**: Test with different parameters (if possible)

## Implementation Tips

1. Remember that multiplexers are purely combinational circuits - your implementation should not include any sequential elements
2. Verify that the select signal can address all possible inputs
3. Consider how to handle the case when Select is out of range (beyond valid inputs)
4. Think about the most efficient Verilog constructs for implementing the selection logic
5. Ensure your implementation is properly parameterized using the values from parameters.v

## Menu
- [PREVIOUS](../2_lfsr/README.md) - Exercise 2: LFSR Design
- [HOME](../../README.md) - Home
