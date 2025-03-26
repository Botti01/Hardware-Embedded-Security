module tb_fullAdder;

    reg A;
    reg B;
    reg Cin;
    wire Sum;
    wire Cout;

    // Instanzia il modulo Full Adder
    fullAdder dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin

        $dumpfile("fullAdder.vcd");    // Specify the name of the VCD file
        $dumpvars(0, tb_fullAdder);    // Dump all variables in the testbench

        // Inizializza i segnali
        A = 0; B = 0; Cin = 0;

        // Testa tutte le combinazioni di input
        A = 0; B = 0; Cin = 0; #10;
        A = 0; B = 0; Cin = 1; #10;
        A = 0; B = 1; Cin = 0; #10;
        A = 0; B = 1; Cin = 1; #10;
        A = 1; B = 0; Cin = 0; #10;
        A = 1; B = 0; Cin = 1; #10;
        A = 1; B = 1; Cin = 0; #10;
        A = 1; B = 1; Cin = 1; #10;

        // Fine della simulazione
        $finish;
    end

endmodule