NET_DIR=../netlist
DESIGN=counter_gen
TB_DIR=../tb
TB_NAME=tb_counter_gen

TECH_NAME=sky130
TECH_TYPE=fd_sc_hd
LIB_NAME=${TECH_NAME}_${TECH_TYPE}
LIB_DIR=/home/user/${LIB_NAME}/verilog

iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 -o ${TB_NAME}.vvp ${LIB_DIR}/primitives.v \
	 ${LIB_DIR}/${LIB_NAME}.v ${NET_DIR}/${DESIGN}.v ${TB_DIR}/${TB_NAME}.v \
	 -s ${TB_NAME}
vvp ${TB_NAME}.vvp
