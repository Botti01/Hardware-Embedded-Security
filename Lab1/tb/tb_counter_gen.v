`timescale 1ns/1ns
module tb_counter_gen();

   localparam TCLK_2 = 5;
   localparam TCLK = TCLK_2*2;

   localparam RST_CYCLES = 2;
   localparam RST_TIME = RST_CYCLES*TCLK;

   localparam SIM_CYCLES = 20;
   localparam SIM_TIME = SIM_CYCLES*TCLK;

   localparam NBIT = 8;
   
   reg 			   clk, rstn;
   wire [NBIT-1:0] 	   cnt;

   counter_gen #(.NBIT(NBIT) ) dut(clk, rstn, cnt);

   initial begin

      $dumpfile("tb_counter_gen.vcd");
      $dumpvars;

      clk=0;
      forever #(TCLK_2) clk=~clk;
   
   end
   
   initial begin
      
      rstn=0;
      #(RST_TIME);
      rstn=1;
      #(SIM_TIME)
      $finish ;
      
   end
   
endmodule
