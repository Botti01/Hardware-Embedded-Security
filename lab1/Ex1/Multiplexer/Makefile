# Makefile for building and running Verilog files with iverilog and gtkwave

# Variables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Source files
SRC_MUX = mux.v mux_tb.v

# Output files
OUT_MUX = mux.out

# Waveform files
WAVES_MUX = mux.vcd

# Default target
all: run_mux view_mux

# Compile the Verilog files
$(OUT_MUX): $(SRC_MUX)
	$(IVERILOG) -o $(OUT_MUX) $(SRC_MUX)

# Run the simulations
run_mux: $(OUT_MUX)
	$(VVP) $(OUT_MUX)

# View the waves
view_mux: $(WAVES_MUX)
	$(GTKWAVE) $(WAVES_MUX)

# Clean up generated files
clean:
	rm -f $(OUT_MUX) $(WAVES_MUX)

.PHONY: all run_mux view_mux clean