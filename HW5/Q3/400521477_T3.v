`include "400521477_Q3.v"
module BUFFER_tb;
    parameter N = 11;
    parameter W = 8;
    reg [W-1:0] datain;
    reg read;
    reg write;
    reg clk;
    reg reset;
    wire [W-1:0] dataout;
    wire full;
    wire empty;

    BUFFER #(.W(W), .N(N)) inst(
        .datain(datain),
        .read(read),
        .write(write),
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
        datain = 8'b00000001;
        write = 1;
        repeat(2)
        #5 clk = ~clk;
        datain = 8'b00000010;
        repeat(2)
        #5 clk = ~clk;
        datain = 8'b00000011;
        repeat(2)
        #5 clk = ~clk;
        datain = 8'b0000100;
        repeat(2)
        #5 clk = ~clk;
        //
        datain = 8'b10000101;
        write = 1;
        repeat(2)
        #5 clk = ~clk;
        datain = 8'b00000110;
        repeat(2)
        #5 clk = ~clk;
        datain = 8'b00000111;
        repeat(2)
        #5 clk = ~clk;
        datain = 8'b00001000;
        repeat(2)
        #5 clk = ~clk;
        datain = 8'b10001001;
        write = 1;
        repeat(2)
        #5 clk = ~clk;
        datain = 8'b00001010;
        repeat(2)
        #5 clk = ~clk;
        datain = 8'b00001011;
        repeat(2)
        #5 clk = ~clk;
        datain = 8'b00001100;
        repeat(2)
        #5 clk = ~clk;
        //
        write = 0;
        read = 1;
        repeat(24)
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