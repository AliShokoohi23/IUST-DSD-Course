`include "400521477_Q1.v"
module OneBitComparator_tb;
    reg A;
    reg B;
    wire A_equal_B;
    wire A_greater_than_B;
    wire A_less_than_B;
    OneBitComparator inst(
        .A(A),
        .B(B),
        .A_equal_B(A_equal_B),
        .A_greater_than_B(A_greater_than_B),
        .A_less_than_B(A_less_than_B)
    );
    initial
    begin
        $dumpfile("4005214477_Q1_1bitcomparator.vcd");
        $dumpvars(0,OneBitComparator_tb);
        A = 1;
        B = 1;
        #10
        
        //$display("A_greater_than_B = %b",A_greater_than_B);
        //$display("A_equal_B = %b",A_equal_B);
        //$display("A_less_than_B = %b",A_less_than_B);
        $finish;
    end
endmodule



