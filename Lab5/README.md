# Hardware Trojan Design and Detection

## Overview

This laboratory assignment focuses on the design and detection of hardware Trojans in digital systems. You will work on two distinct projects: designing a stealthy hardware Trojan in a cryptographic module and detecting a hidden Trojan in an 8-bit adder. Each project will be implemented using Verilog
.
## Lab Assignments

### 1. Detection of Hidden Hardware Trojan in an 8-bit Adder

**Objective:** Detect and analyze a hidden hardware Trojan in an 8-bit ripple-carry adder.

- Examine the provided obfuscated Verilog code to identify the Trojan's trigger condition and payload.
- Develop a testbench to demonstrate normal adder behavior and Trojan activation.
- Show how the Trojan permanently alters the adder's functionality after activation.

[View Hardware Trojan Detection Details](1_trojan_detection_gates/README.md)  

### 2. Hardware Trojan Design in TEA Encryptor

**Objective:** Integrate a stealthy hardware Trojan into a Tiny Encryption Algorithm (TEA) encryptor module.

- Analyze the provided TEA encryptor implementation.
- Insert a Trojan with a hidden trigger and a payload that leaks the internal secret key.
- Ensure the encryptor functions normally when the Trojan is inactive.
- Develop a testbench to verify both normal operation and Trojan activation.

[View Hardware Trojan Design Details](2_hw-trojan-design/README.md)