# Makefile for building and running Verilog files with iverilog and gtkwave

# Variables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Source files
SRC_ADDER = fullAdder.v tb_fullAdder.v

# Output files
OUT_ADDER = fullAdder.out

# Waveform files
WAVES_ADDER = fullAdder.vcd

# Default target
all: run_fulladder view_fulladder

# Compile the Verilog files
$(OUT_ADDER): $(SRC_ADDER)
	$(IVERILOG) -o $(OUT_ADDER) $(SRC_ADDER)

# Run the simulations
run_fulladder: $(OUT_ADDER)
	$(VVP) $(OUT_ADDER)

# View the waves
view_fulladder: $(WAVES_ADDER)
	$(GTKWAVE) $(WAVES_ADDER)

# Clean up generated files
clean:
	rm -f $(OUT_ADDER) $(WAVES_ADDER)

.PHONY: all run_fulladder view_fulladder clean
