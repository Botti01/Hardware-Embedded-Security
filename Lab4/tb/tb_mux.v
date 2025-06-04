// Author: Tzamn Melendez Carmona
// file: tb_mux.v
// description: Testbench for the mux module.
// name of the module expected: mux
// module IO expected: Select, dataInput, dataOutput
// parameters: SELBITS_MUX, NINPUTS_MUX defined in parameters.v
// This testbench tests the mux module by changing the select signal 
// and the data input signal. The output of the mux is stored in a VCD file
`include "src/mux.v"

`timescale 1ns / 1ns

module tb_mux;

`include "params/parameters.v"

reg [SELBITS_MUX - 1:0] Select;
reg [NINPUTS_MUX - 1:0] dataInput;
wire dataOutput;

mux mux(
    .Select(Select),
    .dataInput(dataInput),
    .dataOutput(dataOutput)
);

initial begin
    $dumpfile("mux.vcd");
    $dumpvars(0, tb_mux);

    // Testbench for the mux
    // test select = 0
    Select = 3'b000;
    dataInput = 8'b00000000;
    #10 dataInput = 8'b00000001;
    #10 dataInput = 8'b00000000;

    // Change the select and wait for 10 ns
    // to ensure that the mux is working
    #10 Select = 3'b001;
    #10 dataInput = 8'b00000000;
    #10 dataInput = 8'b00000010;
    #10 dataInput = 8'b00000000;
    #10 Select = 3'b010;
    #10 dataInput = 8'b00000000;
    #10 dataInput = 8'b00000100;
    #10 dataInput = 8'b00000000;
    #10 Select = 3'b011;
    #10 dataInput = 8'b00000000;
    #10 dataInput = 8'b00001000;
    #10 dataInput = 8'b00000000;
    #10 Select = 3'b100;
    #10 dataInput = 8'b00000000;
    #10 dataInput = 8'b00010000;
    #10 dataInput = 8'b00000000;
    #10 Select = 3'b101;
    #10 dataInput = 8'b00000000;
    #10 dataInput = 8'b00100000;
    #10 dataInput = 8'b00000000;
    #10 Select = 3'b110;
    #10 dataInput = 8'b00000000;
    #10 dataInput = 8'b01000000;
    #10 dataInput = 8'b00000000;
    #10 Select = 3'b111;
    #10 dataInput = 8'b00000000;
    #10 dataInput = 8'b01000000;
    #10 dataInput = 8'b00000000;

    #300 $finish;
end

endmodule
