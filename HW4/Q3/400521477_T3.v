`timescale 1ms/1ms
`include "400521477_Q3.v"
module sequence_counter_tb;
    reg clk;
    reg rst;
    wire [2:0] state;

    sequence_counter inst(
        .clk(clk),
        .rst(rst),
        .state(state)
    );
    initial
    begin
        $dumpfile("4005214477_Q3.vcd");
        $dumpvars(0,sequence_counter_tb);
    rst = 1;
    rst = 0;
    clk = 0;
    #5
    
    repeat (100)
    begin
        #5 clk = ~clk;
        $display("state = %b", state);
    end
    end
endmodule