module counter_gen
  #(
    parameter NBIT = 4)
   (
    input                clk,
    input                rstn,
    output reg [NBIT-1:0] out);

   always @ (posedge clk, negedge rstn) begin
      if (! rstn)
        out <= 0;
      else
        out <= out + 1;
   end

endmodule
