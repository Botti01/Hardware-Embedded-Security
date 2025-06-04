module counter(Enable, Reset, Clock, Output);
`include "params/parameters.v"

// parameter declarations
// parameter NBITS_COUNTER is defined in the parameters.v file

// port declarations
input Enable;
input Reset;
input Clock;
output [NBITS_COUNTER-1 : 0] Output;

reg [NBITS_COUNTER-1 : 0] CurrentValue;

// counter logic
assign Output = CurrentValue;

always @(posedge Clock, posedge Reset)
begin
    if (Reset == 1'b0)
        begin
            if (Enable == 1'b0)
                CurrentValue <= CurrentValue;
            else
                CurrentValue <= CurrentValue + 1;
        end
    else
        CurrentValue <= 0;
end

endmodule // counter
