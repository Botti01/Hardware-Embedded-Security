# Exercise 2 – Generic Linear Feedback Shift Register (LFSR)

## Learning Objectives
- Implement a configurable LFSR using Verilog parameters
- Understand the principles behind hardware-based pseudo-random number generation
- Practice modular digital design by creating reusable components
- Apply knowledge of sequential and combinational logic in a practical application
- Develop techniques for scaling circuit designs to handle larger bit widths

## Introduction to LFSRs

Linear Feedback Shift Registers (LFSRs) are specialized shift registers that use feedback paths to generate pseudo-random sequences. They are essential components in many digital systems, including:

- Communication systems (scrambling/descrambling)
- Cryptographic applications
- Built-in self-test circuits
- Error detection and correction
- Noise generators for audio/video applications

## Hardware vs. Software Pseudo-Random Number Generators

| Aspect | Hardware LFSRs | Software RNGs |
|--------|---------------|---------------|
| **Speed** | Extremely fast - generates numbers in a single clock cycle | Typically requires multiple instructions/cycles |
| **Resource Usage** | Minimal - requires only flip-flops and XOR gates | Consumes CPU resources and memory |
| **Implementation** | Direct circuit implementation | Requires software execution environment |
| **Flexibility** | Fixed structure once implemented | Easily modified via code updates |
| **Applications** | Real-time systems, cryptography, communications | General-purpose computing, simulations |

Hardware LFSRs excel in applications where dedicated, high-speed random number generation is critical, while software generators offer greater flexibility at the cost of performance.

## Assignment Overview

This exercise consists of two parts:

1. **Generic n-bit LFSR Implementation**
2. **Scaling to a 32-bit LFSR using Modular Design**

## Part 1: Generic LFSR Implementation

In this part, you will create a parameterized LFSR that can be configured for different bit widths and tap positions.

### Requirements:
- Implement `lfsr.v` with parameters from `params/parameters.v`
- Use **sequential logic (flip-flops)** for the register component
- Implement **combinational logic** for the XOR feedback network
- Support parameterized bit width (`NBITS_LFSR`) and tap configuration (`LFSR_TAP_BITS`)

### Key Components:
1. **Shift Register** - Stores the current state of the LFSR
2. **Feedback Network** - Determines which bits are XORed together
3. **Control Logic** - Handles synchronous reset and enable signals

### Example N-bit LFSR Structure:
```
    Feedback Bit
        ^
        |       +-------------------------------+
        |------>| N |...|...|...|...|...|...| 1 |
                +-------------------------------+
                      |____|__|__ XOR taps
```

## Part 2: 32-bit LFSR Using Modular Design
In this part, you will create a 32-bit LFSR out of an 8-bit lfsr as a building block.

### Requirements:
- Implement `lfsr_32_bit.v` using **only one instance** of your 8-bit LFSR
- Create a shift register to collect outputs from the 8-bit LFSR
- Generate a complete 32-bit pseudo-random number every 4 clock cycles
- Use the parameter `LFSR_32_BIT` from the parameters file

### Implementation Strategy:
1. Instantiate your 8-bit LFSR module
2. On each clock cycle:
   - Capture the 8-bit output from the LFSR
   - Shift this output into your 32-bit register
   - After 4 cycles, you'll have a complete 32-bit pseudo-random value

### Visualization of 32-bit LFSR Operation:
```
     8-bit LFSR -> [7:0] + Current [31:8] = New [31:0]
    
          +------------+
    --->  | LFSR [7:0] |      <-- Generates 8-bit values
          +------------+
               ||
               VV
     +-----------------------------+
     | RandOut [31:0] (Shift Reg) |
     +-----------------------------+
```

## Project Structure

```
2_lfsr/
├── src/
│   ├── lfsr.v            # Generic parameterized LFSR module
│   └── lfsr_32_bit.v     # 32-bit LFSR implementation using 8-bit LFSR
├── tb/
│   ├── tb_lfsr.v         # Testbench for generic LFSR
│   └── tb_lfsr_32_bit.v  # Testbench for 32-bit LFSR
└── params/
    └── parameters.v      # Parameter definitions (bit widths and tap configurations)
```
## Testing Your Designs

1. **For the N-bit LFSR**:
   - Verify that it generates a sequence that repeats only after 2^n-1 values
   - Test different tap configurations for sequence quality
   - Ensure proper behavior with reset and enable signals

2. **For the 32-bit LFSR**:
   - Confirm the valid signal correctly indicates when a new 32-bit value is ready
   - Verify the integration between the 8-bit LFSR and the 32-bit shift register
   - Test the statistical properties of the generated 32-bit numbers

## Simulation Instructions

1. **Compile and simulate the N-bit LFSR**:
   ```bash
   iverilog -o tb_lfsr src/lfsr.v tb/tb_lfsr.v
   gtkwave tb_lfsr.vcd
   ```

2. **Compile and simulate the 32-bit LFSR**:
   ```bash
   iverilog -o tb_lfsr_32_bit src/lfsr.v src/lfsr_32_bit.v tb/tb_lfsr_32_bit.v
   gtkwave tb_lfsr_32_bit.vcd
   ```
## Menu
- [NEXT](../3_mux/README.md) - Exercise 3: MUX Design
- [PREVIOUS](../1_counter/README.md) - Exercise 1: Counter Design
- [HOME](../../README.md) - Home
