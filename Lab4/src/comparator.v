
module comparator(Enable, Reset, Clock, PortA, PortB, Output);
`include "params/parameters.v"

input Enable;
input Reset;
input Clock;
input [NBITS_COMPARATOR-1:0] PortA;
input [NBITS_COMPARATOR-1:0] PortB;
output Output;

wire evaluationFlag;
reg currentOutput;

assign  evaluationFlag = (PortA > PortB) ? 1'b1 : 1'b0;

assign Output = currentOutput & Enable;

always @(posedge Clock, posedge Reset)
begin
    if (Reset == 1'b0)
                currentOutput <= evaluationFlag;
    else
        currentOutput <= 0;
end

endmodule
