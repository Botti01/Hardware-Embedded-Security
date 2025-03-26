# Makefile for building and running Verilog files with iverilog and gtkwave

# Variables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Source files
SRC_AND = and.v and_testbench.v

# Output files
OUT_AND = and.out

# Waveform files
WAVES_AND = and.vcd

# Default target
all: run_and view_and

# Compile the Verilog files
$(OUT_AND): $(SRC_AND)
	$(IVERILOG) -o $(OUT_AND) $(SRC_AND)

# Run the simulations
run_and: $(OUT_AND)
	$(VVP) $(OUT_AND)

# View the waves
view_and: $(WAVES_AND)
	$(GTKWAVE) $(WAVES_AND)

# Clean up generated files
clean:
	rm -f $(OUT_AND) $(WAVES_AND)

.PHONY: all run_and view_and clean