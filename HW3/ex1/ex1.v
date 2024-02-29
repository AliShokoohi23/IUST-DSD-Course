module mux2_1(a,b,s,y);
	input a;
	input b;
	input s;
	reg t1,t2;
	output reg y;
always @(a or b)
begin
	t1 = a & ~s;
	t2 = b & s;
	y = t1 | t2;
end
endmodule

module test;
	reg a,b,s;
	wire y;
initial 
begin
a = 1'b1;
b = 1'b0;
s = 1'b0;
#1
$finish;
end
endmodule
	
