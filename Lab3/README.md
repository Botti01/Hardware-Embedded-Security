# Hardware Design of Pseudo-Random Number Generators

## Overview

This laboratory assignment focuses on implementing three fundamental hardware components commonly used in pseudo-random number generation circuits. Each design will be created using Verilog HDL and must follow a standardized project structure.

## Project Structure

For each project, create the following directory structure:

```
project_name/
├── src/       # Source code files (.v)
├── tb/        # Testbench files (.v)
└── params/    # Parameter definitions (.v or .vh)
```

## Lab Assignments

### 1. Counter Design

**Objective:** Implement a parameterized counter using both sequential and combinational logic.

- Create a configurable N-bit counter with various modes (up, down, etc.)
- Implement synchronous reset functionality
- Include enable/disable control input
- Design must be fully parameterized for bit width

[View Counter Implementation Details](1_Counter/README.md)

### 2. Linear Feedback Shift Register (LFSR)

**Objective:** Design a generic LFSR for pseudo-random sequence generation.

- Implement configurable register width
- Support multiple polynomial configurations
- Include seed loading capability
- Provide options for parallel or serial output

[View LFSR Implementation Details](2_lfsr/README.md)

### 3. Multiplexer (MUX)

**Objective:** Create a 16-bit multiplexer using purely combinational logic.

- Design a fully parameterized implementation
- Support variable input width configuration
- Implement efficient select logic
- Include input validation mechanisms

[View MUX Implementation Details](3_mux/README.md)
