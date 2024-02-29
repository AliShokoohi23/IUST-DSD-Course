module STACK
#(
  parameter W = 16,
  parameter N = 3
)
(
    input [W-1:0] datain,
    input pop,
    input push,
    input clk,
    input reset,
    output reg [W-1:0] dataout,
    output wire full,
    output wire empty
    
);
reg [W-1:0]stack [N-1:0];
reg [W-1:0]index, next_index; 
reg [W-1:0]next_dataout;

//wire empty, full;
always @(negedge reset)
begin
  dataout  <= 8'd0;
  index <= 1'b0;
  for (integer i = 0; i < N; i=i+1)
    stack[i] <= 16'b0000000000000000;
end

always @(posedge clk)
begin
    dataout  <= next_dataout;
    index <= next_index;
end

assign full  = !(|(index ^ N));
assign empty = !(|index);

always @(*)
begin
    if(push && !full)
    begin
        stack[index] = datain;
        next_index   = index + 1'b1;
    end

    else if(pop && !empty)
    begin
        next_dataout  = stack[index - 1'b1];
        next_index = index - 1'b1;
    end

    else
    begin
        next_dataout  = dataout;
        next_index = index;
    end
end


endmodule






