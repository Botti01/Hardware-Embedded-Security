module mux(Select, DataInput, DataOutput);

`include "params/parameters.v"

// port declarations
input [SELBITS_MUX-1:0] Select;
input [NINPUTS_MUX-1:0] DataInput;
output DataOutput;

assign DataOutput = (Select == 4'b0000) ? DataInput[0] :
                    (Select == 4'b0001) ? DataInput[1] :
                    (Select == 4'b0010) ? DataInput[2] :
                    (Select == 4'b0011) ? DataInput[3] :
                    (Select == 4'b0100) ? DataInput[4] :
                    (Select == 4'b0101) ? DataInput[5] :
                    (Select == 4'b0110) ? DataInput[6] :
                    (Select == 4'b0111) ? DataInput[7] :
                    (Select == 4'b1000) ? DataInput[8] :
                    (Select == 4'b1001) ? DataInput[9] :
                    (Select == 4'b1010) ? DataInput[10] :
                    (Select == 4'b1011) ? DataInput[11] :
                    (Select == 4'b1100) ? DataInput[12] :
                    (Select == 4'b1101) ? DataInput[13] :
                    (Select == 4'b1110) ? DataInput[14] :
                    DataInput[15]; 

endmodule
