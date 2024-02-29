`include "400521477_Q1.v"
module FourBitComparator_tb;
    reg [3:0] A;
    reg [3:0] B;
    wire A_equal_B;
    wire A_greater_than_B;
    wire A_less_than_B;
    FourBitComparator inst(
        .A(A),
        .B(B),
        .A_equal_B(A_equal_B),
        .A_greater_than_B(A_greater_than_B),
        .A_less_than_B(A_less_than_B)
    );
    initial
    begin
        $dumpfile("4005214477_Q1_4bitcomparator.vcd");
        $dumpvars(0,FourBitComparator_tb);
        A = 4'b1111;
        B = 4'b0111;
        #10
        $finish;
        //$display("(4bit) A_greater_than_B = %b",A_greater_than_B);
        //$display("(4bit) A_equal_B = %b",A_equal_B);
        //$display("(4bit) A_less_than_B = %b",A_less_than_B);
    end
endmodule