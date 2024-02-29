`include "400521477_Q2.v"
module STACK_tb;
    parameter N = 3;
    parameter W = 16;
    reg [W-1:0] datain;
    reg pop;
    reg push;
    reg clk;
    reg reset;
    wire [W-1:0] dataout;
    wire full;
    wire empty;

    STACK #(.W(W), .N(N)) inst(
        .datain(datain),
        .pop(pop),
        .push(push),
        .clk(clk),
        .reset(reset),
        .dataout(dataout),
        .full(full),
        .empty(empty)
    );

    initial
    begin
        reset = 1;
        #2
        reset = 0;
        clk = 0;
        datain = 16'b0000000010000011;
        push = 1;
        repeat(2)
        #5 clk = ~clk;
        datain = 16'b0000000000011111;
        repeat(2)
        #5 clk = ~clk;
        datain = 16'b1100000000011111;
        repeat(2)
        #5 clk = ~clk;
        datain = 16'b1111100000011111;
        repeat(2)
        #5 clk = ~clk;
        push = 0;
        pop = 1;
        repeat(10)
        begin
        #5 clk = ~clk;
        if (clk == 1)
        begin
            $display("dataout = %b", dataout);
            $display("full = %b", full);
            $display("empty = %b", empty);
        end
        end

    end
endmodule