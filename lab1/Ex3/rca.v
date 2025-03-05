module ripple_carry_adder (A, B, Cin, Sum, Cout);
    input [3:0] A;
    input [3:0] B;
    input Cin;
    output [3:0] Sum;
    output Cout;

    wire [2:0] C;

    fullAdder fa0 (A[0], B[0], Cin, Sum[0], C[0]);
    fullAdder fa1 (A[1], B[1], C[0], Sum[1], C[1]);
    fullAdder fa2 (A[2], B[2], C[1], Sum[2], C[2]);
    fullAdder fa3 (A[3], B[3], C[2], Sum[3], Cout);

endmodule
