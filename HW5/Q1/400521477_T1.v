`include "400521477_Q1.v"
module MatrixMultiplier_tb;
    parameter N = 3;
    parameter W = 8;
    reg [N*W-1:0] A;
    reg [N*W-1:0] B;
    reg clk;
    reg rst;
    wire [2*N*W - 1 : 0] out;

    MatrixMultiplier #(.W(W), .N(N)) inst(
        .A(A),
        .B(B),
        .clk(clk),
        .rst(rst),
        .out(out)
    );

    initial
    begin
      //test 1
        A = {8'd1, 8'd2, 8'd3};
        B = {8'd1, 8'd2, 8'd3};
        rst = 1;
        #2 rst = 0;
        clk = 0;
        repeat(30)
        #3 clk = ~clk;
        //answer is 14
        #2 $display("out = %d", out);

        #30
        // test 2
        A = {8'd10, 8'd5, 8'd2};
        B = {8'd10, 8'd5, 8'd2};
        rst = 1;
        #2 rst = 0;
        clk = 0;
        repeat(30)
        #3 clk = ~clk;
        //answer is 129
        #2 $display("out = %d", out);
    end
endmodule