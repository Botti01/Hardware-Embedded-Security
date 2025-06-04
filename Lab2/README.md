# Random Number Generators

This repository contains implementations and exercises related to various random number generation techniques used in cryptography and computing applications.

## Contents

This project is organized into separate modules, each focusing on a different random number generation technique:

- [Linear Congruential Generator (LCG)](./1_lcg/README.md) - Basic pseudo-random number generation using linear equations
- [Linear Feedback Shift Register (LFSR)](./2_lfsr/README.md) - Hardware-friendly pseudo-random sequence generators with good statistical properties
- [True Random Number Generator (TRNG)](./3_trng/README.md) - Generating random numbers from physical processes using Intel's RDSEED and RDRAND instructions
- [LFSR with TRNG Seed](./4_lfsr_trng/README.md) - Enhancing LFSRs with true random seeds for improved security

## Overview

Random number generation is a critical component in many fields including:
- Cryptography and information security
- Simulation and modeling
- Gaming
- Statistical sampling

This repository provides practical implementations and exercises to understand both pseudo-random and true random number generation techniques. Each module includes theory, implementation guidance, and exercises to reinforce understanding.

## Requirements

- C compiler (GCC recommended)
- Intel CPU with RDRAND/RDSEED support (for TRNG sections)
- Basic understanding of cryptography principles
- Knowledge of C programming

## Getting Started

1. Clone this repository
2. Navigate to any of the module folders
3. Follow the instructions in each module's README.md file
