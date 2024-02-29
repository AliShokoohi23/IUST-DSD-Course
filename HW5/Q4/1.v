module concatination2;
reg clock, In1, In2, In3, amp;
parameter CP=10;
initial
begin
clock = 0;
#(CP+1) In1 = 1'b0;
#CP In2 = 1'b1;
#(CP*5) $finish;
end
always #(CP/2) clock = ~clock;
always #(CP*2) In3 = In1 & amp;
endmodule
