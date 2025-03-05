# Makefile for building and running Verilog files with iverilog and gtkwave

# Variables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Source files
SRC_DFF = dff.v dff_tb.v

# Output files
OUT_DFF = dff.out

# Waveform files
WAVES_DFF = dff.vcd

# Default target
all: run_dff view_dff

# Compile the Verilog files
$(OUT_DFF): $(SRC_DFF)
	$(IVERILOG) -o $(OUT_DFF) $(SRC_DFF)

# Run the simulations
run_dff: $(OUT_DFF)
	$(VVP) $(OUT_DFF)

# View the waves
view_dff: $(WAVES_DFF)
	$(GTKWAVE) $(WAVES_DFF)

# Clean up generated files
clean:
	rm -f $(OUT_DFF) $(WAVES_DFF)

.PHONY: all run_dff view_dff clean