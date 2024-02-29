module top(
    input [3:0] A,
    input [3:0] B,
    input clk,
    input [1:0] c,
    input EN,
    output reg Out_c,
    output reg [3:0] Out_bits
    
);
wire A_equal_B;
wire A_greater_than_B;
wire A_less_than_B;
wire out_c;
wire [3:0] out_bits;
FourBitComparator inst(
        .A(A),
        .B(B),
        .A_equal_B(A_equal_B),
        .A_greater_than_B(A_greater_than_B),
        .A_less_than_B(A_less_than_B)
);

controller ins(
    .A_equal_B(A_equal_B),
    .A_greater_than_B(A_greater_than_B),
    .A_less_than_B(A_less_than_B),
    .clk(clk),
    .c(c),
    .EN(EN),
    .out_c(out_c),
    .out_bits(out_bits)
);

always @(posedge clk)
begin
    if (EN == 1)
    begin
    Out_bits <= 4'b0000;
    Out_c <= out_c;
    if (out_c)
    Out_bits <= A;
    end
end

endmodule
module OneBitComparator (
    input wire A,
    input wire B,
    output wire A_equal_B,
    output wire A_greater_than_B,
    output wire A_less_than_B
);

assign A_equal_B = ~(A ^ B);
assign A_greater_than_B = (A & ~B);
assign A_less_than_B = (~A & B);

endmodule

module FourBitComparator (
    input [3:0] A,
    input [3:0] B,
    output A_equal_B,
    output A_greater_than_B,
    output A_less_than_B
);

wire [3:0] equal_bits, greater_than_bits, less_than_bits;

OneBitComparator comp_0 (.A(A[0]), .B(B[0]), .A_equal_B(equal_bits[0]), .A_greater_than_B(greater_than_bits[0]), .A_less_than_B(less_than_bits[0]));
OneBitComparator comp_1 (.A(A[1]), .B(B[1]), .A_equal_B(equal_bits[1]), .A_greater_than_B(greater_than_bits[1]), .A_less_than_B(less_than_bits[1]));
OneBitComparator comp_2 (.A(A[2]), .B(B[2]), .A_equal_B(equal_bits[2]), .A_greater_than_B(greater_than_bits[2]), .A_less_than_B(less_than_bits[2]));
OneBitComparator comp_3 (.A(A[3]), .B(B[3]), .A_equal_B(equal_bits[3]), .A_greater_than_B(greater_than_bits[3]), .A_less_than_B(less_than_bits[3]));
assign A_equal_B = &equal_bits;
assign A_greater_than_B = greater_than_bits[3] ? 1'b1:
                        ~less_than_bits[3] & greater_than_bits[2] ? 1'b1:
                         ~less_than_bits[2] & greater_than_bits[1] ? 1'b1:
                         ~less_than_bits[1] & greater_than_bits[0] ? 1'b1: 1'b0;  
assign A_less_than_B = less_than_bits[3] ? 1'b1:
                        ~greater_than_bits[3] & less_than_bits[2] ? 1'b1:
                       ~greater_than_bits[2] & less_than_bits[1] ? 1'b1:
                        ~greater_than_bits[1] & less_than_bits[0] ? 1'b1: 1'b0;

endmodule




module controller(
    input A_equal_B,
    input A_greater_than_B,
    input A_less_than_B,
    input clk,
    input [1:0] c,
    input EN,
    output reg out_c,
    output reg [3:0] out_bits
);

always @(posedge clk)
begin
    if (EN)
    begin
    case(c)
    2'b00:
    begin
    out_c <= A_greater_than_B;
    end
    2'b01:
    begin
    out_c <= A_equal_B;
    end
    2'b10:
    begin
    out_c <= A_less_than_B;
    end
    default:begin
    end
    endcase
    end

    else
    begin
    out_c <= 0;
    end
end
endmodule

