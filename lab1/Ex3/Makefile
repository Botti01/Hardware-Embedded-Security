# Makefile for building and running Verilog files with iverilog and gtkwave

# Variables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

SRC = rca.v tb_rca.v ../Ex2/fullAdder.v
OUT = tb_rca.out
WAVES = rca.vcd

# Default target
all: run view

# Compile the Verilog files
$(OUT): $(SRC)
	$(IVERILOG) -o $(OUT) $(SRC)

# Run the simulation
run: $(OUT)
	$(VVP) $(OUT)

# View the waves
view: $(WAVES)
	$(GTKWAVE) $(WAVES)

# Clean up generated files
clean:
	rm -f $(OUT) $(WAVES)

.PHONY: all run view clean