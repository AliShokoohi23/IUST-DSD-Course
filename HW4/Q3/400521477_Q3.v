module sequence_counter (
  input wire clk,
  input wire rst,
  output reg [2:0] state
);
reg [2:0] nextState;
parameter [2:0] S5 = 3'b101;
parameter [2:0] S4 = 3'b100;
parameter [2:0] S7 = 3'b111;
parameter [2:0] S6 = 3'b110;
parameter [2:0] S1 = 3'b001;
parameter [2:0] S0 = 3'b000;
parameter [2:0] S3 = 3'b011;
parameter [2:0] S2 = 3'b010;

always @(negedge rst)
begin
    state <= S5;
end
always @(posedge clk)
begin
    state <= nextState;
end

always @(*)
begin
    case(state)
    3'b101:
    begin
    nextState = S4;
 
    end

    3'b100:
    begin
    nextState = S7;
 
    end
    
    3'b111:
    begin
    nextState = S6;
 
    end

    3'b110:
    begin
    nextState = S1;
 
    end

    3'b001:
    begin
    nextState = S0;
 
    end

    3'b000:
    begin
    nextState = S3;
 
    end

    3'b011:
    begin
    nextState = S2;
 
    end

    3'b010:
    begin
    nextState = S5;
 
    end
    default:begin
    end
    endcase
end

endmodule

