# Lab 7 – Side-Channel Attacks

## Overview
In this lab, you'll explore timing side-channel attacks by targeting a hardware password comparator
implemented in Verilog. You'll simulate password verification scenarios, exploit timing
vulnerabilities to extract sensitive information, and implement security hardening measures.

## Learning Objectives
- Understand how timing side-channel attacks work in hardware systems
- Analyze timing vulnerabilities in the `hardware_comparator` module
- Implement and execute a practical timing attack
- Design and implement countermeasures to prevent timing attacks

## Getting Started
### 1. Clone the Repository
```bash
git clone https://baltig.polito.it/teaching-material/hwws2025/labs/lab7.git
cd lab7
```

### 2. Initial Setup and Compilation
Compile the module and run the initial simulation:
```bash
make
```

Open the waveform viewer to analyze timing behavior:
```bash
make view
```

## Part 1: Understanding the Hardware Comparator

### Key System Signals
When analyzing the waveform, focus on these critical signals:

| Signal | Description |
|--------|-------------|
| `Clk` | System clock signal |
| `Reset` | System reset signal |
| `Start` | Initiates STORE or COMPARE operations |
| `FunctionMode` | Operation mode: STORE (1) or COMPARE (0) |
| `SelectAddress` | Memory address being accessed |
| `DataIn` | Password byte being processed |
| `DataLength` | Number of bytes in the password |
| `StoreSuccess` | Indicates successful STORE operation completion |
| `WrongPassword` | Raised when password mismatch is detected |
| `ValidPassword` | Raised when all password bytes match |

### Default Testbench Behavior
This testbench simulates the password verification process by: Storing a password and then comparing
it against a user input. You must observe that the timing of the `ValidPassword` depends on the
length of the password.
The second important observation is that the `WrongPassword` signal is raised immediately when a
mismatch is detected.

## Part 2: Implementing the Timing Attack
### Understanding Side-Channel Attacks
A side-channel attack extracts secret information by analyzing the physical implementation
characteristics of a system, rather than exploiting software vulnerabilities. In this timing attack,
you'll measure response times to reveal password information.

By inspecting the timing of the `ValidPassword` and `WrongPassword` signals in the waveform, analyze
the timing differences. The goal is to understand how the comparator's response time varies based on
the password length and the specific bytes being compared.

### Creating the Attack Testbench

1. **make a copy of the testbench file**: `tb/tb_hardware_comparator.v` and name it `tb/timing_attack_tb.v`

2. **Compile and run your testbench**:
The provided makefile includes a target for the timing attack testbench. To compile and run it, use
the following command:
   ```bash
   make TB=tb_timing_attack
   ```

### Implementation Guidelines

- Instantiate the `hardware_comparator` module in your testbench
- Use `Clk` and `Start` signals for operation timing control
- Provide different password inputs via `DataIn`
- From the time response times for `ValidPassword` and `WrongPassword` signals previously observed, 
  implement logic to infer the password.
- Two passwords are pre-stored in the comparator and are stored in the the address `0x32` and `0x64`:
- And lenght is 10 and 12 bytes respectively.
- This information will help you to perform the attack. However, you can also try to implement the
  attack without the length information.
- The password only contains uppercase letters (A-Z).

#### Important Notes
- Red signals in the waveform viewer indicate uninitialized memory values (this is normal)
- Focus on relative timing differences rather than absolute values
- The attack exploits early termination in password comparison

## Part 3: Hardening the Design

### Security Vulnerability Analysis
The current implementation is vulnerable because it stops comparing as soon as a mismatch is found,
creating timing differences that leak information about password correctness.

### Implementing Constant-Time Comparison

#### Design Requirements
- **Constant Execution Time**: All comparisons must take the same time regardless of input
- **Complete Processing**: Always process all password bytes
- **Consistent Response Timing**: Uniform delay before raising result signals

### Verification Process
After implementing your hardened design:

1. **Re-run the timing attack testbench**
2. **Analyze new timing behavior**
3. **Verify consistent response times**
4. **Confirm attack mitigation**
