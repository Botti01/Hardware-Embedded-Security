# tools
IVERILOG := iverilog
GTKWAVE  := gtkwave

# files
SRC      := adder_trojan.v
TB       := tb_adder_trojan.v
OUT      := out
VCD      := adder_trojan.vcd

.PHONY: all compile sim wave clean

all: compile sim

compile: $(SRC) $(TB)
	$(IVERILOG) -o $(OUT) $(SRC) $(TB)

sim: compile
	./$(OUT)

wave: sim
	$(GTKWAVE) $(VCD)

clean:
	rm -f $(OUT) $(VCD)

