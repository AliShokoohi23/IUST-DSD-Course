module TrafficLight(
  input wire clk,
  input wire reset,
  output reg red,
  output reg yellow,
  output reg green
);

reg [4:0] state;
reg [4:0] count;

parameter R_TIME = 20; 
parameter RY_TIME = 5;    
parameter G_TIME = 25;   
parameter Y_TIME = 5;     

parameter IDLE = 4'b0000;
parameter RED = 4'b0001;
parameter RED_YELLOW = 4'b0010;
parameter GREEN = 4'b0100;
parameter YELLOW = 4'b1000;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= IDLE;
    count <= 0;
  end else begin
    case (state)
      IDLE: begin
        state <= RED;
        count <= R_TIME;
      end
      RED: begin
        if (count == 0) begin
          state <= RED_YELLOW;
          count <= RY_TIME;
        end else begin
          count <= count - 1;
        end
      end
      RED_YELLOW: begin
        if (count == 0) begin
          state <= GREEN;
          count <= G_TIME;
        end else begin
          count <= count - 1;
        end
      end
      GREEN: begin
        if (count == 0) begin
          state <= YELLOW;
          count <= Y_TIME;
        end else begin
          count <= count - 1;
        end
      end
      YELLOW: begin
        if (count == 0) begin
          state <= RED;
          count <= R_TIME;
        end else begin
          count <= count - 1;
        end
      end
    endcase
  end
end

always @(state) begin
  case (state)
    IDLE: begin
      red <= 0;
      yellow <= 0;
      green <= 0;
    end
    RED: begin
      red <= 1;
      yellow <= 0;
      green <= 0;
    end
    RED_YELLOW: begin
      red <= 1;
      yellow <= 1;
      green <= 0;
    end
    GREEN: begin
      red <= 0;
      yellow <= 0;
      green <= 1;
    end
    YELLOW: begin
      red <= 0;
      yellow <= 1;
      green <= 0;
    end
  endcase
end

endmodule