# Hardware Trojan Design

## Introduction

In this lab, you will integrate a hardware Trojan, a malicious modification that activates upon detecting a specific input pattern and leaks secret data. You will implement it in an already provided hardware encryptor module based on the **Tiny Encryption Algorithm (TEA)**.

---

## Background

### Finite State Machine (FSM)

A **Finite State Machine** (FSM) is a computational model used to design and describe the behavior of digital systems. It consists of:

* **States**: Specific conditions or modes the system can be in at any given time.
* **Inputs**: External signals that influence state transitions.
* **Transitions**: Rules that determine how states change in response to inputs.
* **Outputs**: Actions or signals generated based on the current state or transition.

FSMs are commonly visualized with state diagrams, where circles represent states and arrows represent transitions.

**Example:** A simple FSM for a vending machine:

* States: Waiting, Coin Inserted, Dispensing
* Inputs: Insert coin, Press button
* Transitions:

    * Waiting → Coin Inserted (upon inserting a coin)
    * Coin Inserted → Dispensing (upon pressing a button)
    * Dispensing → Waiting (after item dispensed)

Visual diagrams:

```
             insert coin            press button
Waiting -----------> Coin Inserted -----------> Dispensing
    ^                                                 |
    |                                                 |
    +-------------------------------------------------+
```

FSMs are powerful tools for designing control logic in digital systems clearly and systematically.

### FSM Example in Verilog

Here's a simple FSM example implemented in Verilog:

```verilog
module simple_fsm (
        input wire clk,
        input wire rst,
        input wire coin,
        input wire button,
        output reg dispense
);

        typedef enum logic [1:0] {
                WAITING = 2'b00,
                COIN_INSERTED = 2'b01,
                DISPENSING = 2'b10
        } state_t;

        state_t state, next_state;

        // State transition logic
        always_ff @(posedge clk or posedge rst) begin
                if (rst)
                        state <= WAITING;
                else
                        state <= next_state;
        end

        // Next state logic
        always_comb begin
                dispense = 0;
                next_state = state;
                case (state)
                        WAITING: begin
                                if (coin) next_state = COIN_INSERTED;
                        end
                        COIN_INSERTED: begin
                                if (button) next_state = DISPENSING;
                        end
                        DISPENSING: begin
                                dispense = 1;
                                next_state = WAITING;
                        end
                        default: begin
                                next_state = WAITING;
                        end
                endcase
        end
endmodule
```

---

## Tiny Encryption Algorithm (TEA)

**TEA** is a simple symmetric-key encryption algorithm.

* **Block size:** 64 bits
* **Key size:** 128 bits
* **Rounds:** 32 rounds per encryption

### Encryption Steps (per round):

Given:

* Input block divided into two 32-bit halves: $v0$, $v1$
* Key divided into four 32-bit words: $k0, k1, k2, k3$
* $sum$ initialized to 0
* Constant $\delta = 0x9E3779B9$

For 32 rounds:

```
sum += delta;
v0  += ((v1 << 4) + k0) XOR (v1 + sum) XOR ((v1 >> 5) + k1);
v1  += ((v0 << 4) + k2) XOR (v0 + sum) XOR ((v0 >> 5) + k3);
```

Final ciphertext is concatenation of $v0$ and $v1$.

---

## Hardware Trojan

A **hardware Trojan** is malicious circuitry inserted secretly into a hardware component. Typically, it has:

* A **trigger condition**: a specific input or sequence of inputs causing the Trojan to activate.
* A **payload**: harmful behavior executed upon activation, such as leaking secret keys or data.

---

## Your Lab Tasks

### Step 1: Inspect the TEA Encryptor

Read the provided code implementing the TEA Encryptor to understand its functioning. This is necessary in order to correctly insert the Trojan without affecting functionality outside of the trigger condition.

### Step 2: Insert a Hardware Trojan

Modify the TEA encryptor to include a hidden hardware Trojan. You **CANNOT** change the input and output signals of the module, not even their width, the interface should be exactly the same as the original module. Ensure that the encryptor operates normally when the trigger condition is not met. Try to obscure the Trojan's presence as much as possible.

* **Trigger:** The encryptor is expected to be thoroughly tested using ATPG (Automatic Test Pattern Generation). Therefore, you **CANNOT** base the trigger on specific functional input values, as all input combinations are likely to be tested and such triggers would be detected.
* **Payload:** Upon activation, the Trojan must leak the internal hardcoded 128-bit secret key.

### Step 3: Testing and Verification

* Write a Verilog testbench to:
    * Demonstrate correct TEA encryptor functionality under normal operation.
    * Demonstrate Trojan activation and payload execution clearly.

### OPTIONAL GAME SESSION

Find another group that has implemented a Trojan and create a testing program to detect it. **DO NOT** read their Verilog code; implement your testbench based on assumptions about how the Trojan could have been implemented.
