# Tools
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Directories
BUILD_DIR = build
SRC_DIR = src
TB_DIR = tb
PARAM_DIR = params

# Include paths
INCLUDES = -I./$(SRC_DIR)/ -I./$(PARAM_DIR)/

# Default testbench (can be overridden via make TB=name)
TB ?= tb_hardware_comparator
OUT = $(BUILD_DIR)/$(TB).vvp
WAVES = $(TB).vcd

# Default target
all: run

# Build target
$(OUT): $(TB_DIR)/$(TB).v
	@mkdir -p $(BUILD_DIR)
	$(IVERILOG) $(INCLUDES) -o $@ $<

# Run target
run: $(OUT)
	$(VVP) $<

# View waveform
view: $(WAVES)
	$(GTKWAVE) $(WAVES) &

# Clean generated files
clean:
	rm -f $(BUILD_DIR)/*.vvp *.vcd *.out
	rm -rf $(BUILD_DIR)

# List info
list:
	@echo "Testbench: $(TB_DIR)/$(TB).v"
	@echo "Output: $(OUT)"
	@echo "Waveform: $(WAVES)"
	@echo "Includes: $(INCLUDES)"

.PHONY: all run view clean list

