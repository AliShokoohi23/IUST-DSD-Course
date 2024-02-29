module MatrixMultiplier
#(
    parameter N = 3,
    parameter W = 8
) (
  input [N*W-1:0] A,
  input [N*W-1:0] B,
  input clk,
  input rst,
  output reg [2*N*W - 1 : 0] out
);
  reg [W-1:0] matrixA [N-1:0];
  reg [W-1:0] matrixB [N-1:0];
  reg [W-1:0] products [N-1:0];
  reg [W-1:0] accumulator [N-1:0];
  integer index;
  integer k = 0;

  always @(posedge clk)
  begin
    if (k != N)
    begin
      matrixA[k] <= A[index +: W];
      matrixB[k] <= B[index +: W];
      k <= k + 1;
    end
  end

  always @(negedge rst)
  begin
    out = 0;
    k = 0;
  end

  always @(*) begin
    index = 8 * k;
    for (integer i = 0; i < N; i = i + 1) begin
      products[i] = matrixA[i] * matrixB[i];
    end

    accumulator[0] = products[0];
    for (integer i = 1; i < N; i = i + 1) begin
      accumulator[i] = accumulator[i-1] + products[i];
    end

    out = accumulator[N-1];
  end

endmodule