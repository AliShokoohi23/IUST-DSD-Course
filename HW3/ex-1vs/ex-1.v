module mux2_1(a,b,s,y);
	input a;
	input b;
	input s;
	output wire y;
	assign y = ((a & ~s) | (b & s));
endmodule

module test;
reg a,b,s;
wire y;
mux2_1 inst(a,b,s,y);
initial 
begin
a = 1;
b = 0;
s = 0;
#10
$display("y = %b",y);
$finish;
end
endmodule
	
