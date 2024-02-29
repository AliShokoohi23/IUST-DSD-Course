//Ali Shokoohi 400521477
//Armin Amirfatahi 400521108
module Quiz (
    input [1:0] A, 
    input [1:0] B, 
	input [3:0] x,
    output reg [7:0] result 
);

	reg [13:0] temp; 

    integer i;

    always @(*) begin
        temp = 13'b1; 

        for (i = 0; i < B; i = i + 1) begin

            temp = temp * x;
        end
		temp = temp * A;
		while(temp > 13'b11111111)
			begin
				temp = temp - 13'b11111111;
			end
			
		result = temp;
        
		
    end
endmodule

// testbenches
module Quiz_tb;
    reg [1:0] A; 
    reg [1:0] B;
	reg [3:0] x;
    wire [7:0] result; 
    Quiz inst(
        .A(A),
        .B(B),
		.x(x),
        .result(result)
    );
    initial begin
        A = 2'b11;
        B = 2'b11;
		x = 4'b0111;

        #10
        $display("result1 = %b", result);
		#20
		A = 2'b11;
        B = 2'b11;
		x = 4'b1111;

        #10
        $display("result2 = %b", result);

		A = 2'b01;
        B = 2'b10;
		x = 4'b0111;

        #10
        $display("result3 = %b", result);
        $finish; 
    end
endmodule
