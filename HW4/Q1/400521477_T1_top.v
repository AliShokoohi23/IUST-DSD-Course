`include "400521477_Q1.v"

module top_tb;
    reg [3:0] A;
    reg [3:0] B;
    reg clk;
    reg [1:0] c;
    reg EN;
    wire Out_c;
    wire [3:0] Out_bits;
    top inst(
        .A(A),
        .B(B),
        .clk(clk),
        .c(c),
        .EN(EN),
        .Out_c(Out_c),
        .Out_bits(Out_bits)
    );
    initial
    begin
        $dumpfile("4005214477_Q1_top.vcd");
        $dumpvars(0,top_tb);
        A = 4'b0111;
        B = 4'b0111;
        c = 2'b01;
        EN = 1;
        clk = 0;
        #10
        repeat(60)
        begin
          #5 clk = ~clk;
        end

        #20
        A = 4'b1000;
        B = 4'b0010;
        c = 2'b00;
        EN = 1;
        clk = 0;
        #10
        repeat(60)
        begin
          #5 clk = ~clk;
        end

        $finish;
        //$display("Out_c = %b", Out_c);
        //$display("Out_bits = %b", Out_bits);
    end
endmodule