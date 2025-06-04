# Makefile for TEA core with in-core Trojan
# Targets:
#   make compile  → compile Verilog sources
#   make sim      → run simulation
#   make wave     → open ‘.vcd’ in GTKWave
#   make all      → equivalent to ‘make sim wave’
#   make clean    → remove generated files

# tools
IVERILOG := iverilog
GTKWAVE  := gtkwave

# files
SRC      := tea.v
SRC_TR   := tea_trojan.v
TB       := tb_tea.v
OUT      := out
VCD      := tea.vcd

.PHONY: all all_trojan compile compile_trojan sim wave clean

all: clean compile sim
all_trojan: clean compile_trojan sim

compile: $(SRC) $(TB)
	$(IVERILOG) -o $(OUT) $(SRC) $(TB)

compile_trojan: $(SRC_TR) $(TB)
	$(IVERILOG) -o $(OUT) $(SRC_TR) $(TB)

sim:
	./$(OUT)

wave:
	$(GTKWAVE) $(VCD)

clean:
	rm -f $(OUT) $(VCD)

