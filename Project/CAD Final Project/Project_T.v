`include "Project.v"
`timescale 1ms/1ms
module DClock_tb;
    reg CLK;
    reg rst;
    wire [15:0] LED;
    wire [7:0] SEG_DATA;
    wire [4:0] SEG_SEL;
    //wire BUZZER;
    DClock inst(
        .CLK(CLK),
        .rst(rst),
        .LED(LED),
        .SEG_DATA(SEG_DATA),
        .SEG_SEL(SEG_SEL)
        //.BUZZER(BUZZER)
    );
    initial
    begin
        $dumpfile("Project.vcd");
        $dumpvars(0,DClock_tb);
        CLK = 0;
        rst = 1;
        #1
        rst = 0;
        repeat(100000)
        begin
        #1 CLK = ~CLK;
        
        //$display("LED = %b", LED);
        //$display("SEG_DATA = %b", SEG_DATA);
        //$display("SEG_SEL = %b", SEG_SEL);
        end
       
        $finish;
    end
endmodule