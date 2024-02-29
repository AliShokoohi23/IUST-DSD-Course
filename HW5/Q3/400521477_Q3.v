module BUFFER
#(
  parameter W = 8,
  parameter N = 11
)
(
    input [W-1:0] datain,
    input read,
    input write,
    input clk,
    input reset,
    output reg [W-1:0] dataout,
    output wire full,
    output wire empty
    
);
reg [W-1:0] buffer [N-1:0];
reg [W-1:0] index, next_index; 
reg [W-1:0] next_dataout;

always @(negedge reset)
begin
  dataout  <= 8'd0;
  index <= 1'b0;
  for (integer i = 0; i < N; i=i+1)
    buffer[i] <= 8'b00000000;
end

always @(posedge clk)
begin
    dataout  <= next_dataout;
    index <= next_index;
end

assign full  = (index == N);
assign empty = (index == 0);

always @(*)
begin
    if(write && !full)
    begin
        buffer[index] = datain;
        next_index   = index + 1'b1;
    end

    else if(read && !empty)
    begin
        next_dataout  = buffer[0];
        for (integer i = 1; i <= next_index;i = i + 1)
        begin
            buffer[i-1] = buffer[i];
        end
        next_index = index - 1'b1;
    end

    else
    begin
        next_dataout  = dataout;
        next_index = index;
    end
end


endmodule






