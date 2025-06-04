# Detection of Hidden Hardware Trojan in an 8-bit Adder

## Objective

In this lab, you will analyze a provided Verilog implementation of an 8-bit ripple-carry adder (`adder_trojan.v`). The provided design contains a stealthy hardware Trojan that permanently alters the adder's behavior once triggered by a specific input combination.

Your tasks are:

1. **Analyze** the provided Verilog code to identify:

   * The conditions required to trigger the hardware Trojan.
   * The exact behavior alteration (payload) caused by the Trojan.

2. **Develop** a Verilog testbench to:

   * Verify the normal behavior of the adder.
   * Clearly demonstrate how to activate the Trojan.
   * Show that, after activation, the Trojan permanently affects subsequent operations.

## Provided Files

* `adder_trojan.v`: Obfuscated gate-level Verilog implementation of an 8-bit adder containing a hidden hardware Trojan.
