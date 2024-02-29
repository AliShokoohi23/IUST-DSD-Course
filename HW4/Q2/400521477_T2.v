`timescale 1ms/1ms
`include "400521477_Q2.v"
module convert_decimal_to_BCD_tb;
    reg [6:0] decimal;
    wire [7:0] bcd;
    wire [6:0] seg1;
    wire [6:0] seg2;
    convert_decimal_to_BCD inst(
        .decimal(decimal),
        .bcd(bcd),
        .seg1(seg1),
        .seg2(seg2)
    );
    
    initial
    begin
        $dumpfile("4005214477_Q2.vcd");
        $dumpvars(0,convert_decimal_to_BCD_tb);
        decimal = 98;
        #10
        $display("bcd = %b", bcd);
        $display("seg1 = %b", seg1);
        $display("seg2 = %b", seg2);
        
        $finish;
    end
endmodule