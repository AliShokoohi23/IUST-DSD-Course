module MealyMachine (
    input wire clk,
    input wire reset,
    input wire [3:0] Qin,
    input wire [3:0] M,
	  output reg out,
    output reg [7:0] AQ
);
reg[2:0] state;
wire[2:0] nextState;
reg[3:0] A;
reg Qn;
integer count;
reg[8:0] temp;
reg[3:0] Q;
reg b;
reg[3:0] M_comp;

assign nextState = (state == 3'b000) ? 3'b001 :
                  (state == 3'b001 && Q[0] == 0 && Qn == 0) ? 3'b100 :
                  (state == 3'b001 && Q[0] == 0 && Qn == 1) ? 3'b010 :
                  (state == 3'b001 && Q[0] == 1 && Qn == 0) ? 3'b011 :
                  (state == 3'b001 && Q[0] == 1 && Qn == 1) ? 3'b100 :
                  (state == 3'b010 || state == 3'b011) ? 3'b100 :
                  (state == 3'b100 && count == 0) ? 3'b101 : 3'b001;

always @(posedge reset) begin
    state = 3'b000;
    count = 4;
    A = 4'b0000;
    Qn = 0;
    out = 0;
    Q = Qin;
    temp = {A,Q,Qn};
    b = 0;
end
always @(posedge clk)
begin
  b = 0;
  state = nextState;
end;

always @(posedge clk) begin
  case (state)
    3'b000: begin
      
    end
    3'b001: begin
      out = 0;
    end
    3'b010: begin
      if (b ==0)
      begin
      A = A + M;
      end
    end
    3'b011: begin
      if (b == 0)
      begin
      M_comp = ~M + 4'b0001;
      A = A + M_comp;
      end
    end
    3'b100: begin
      if (b == 0)
      begin
      temp = {temp[8],temp[8:6],temp[5:1]};
      A = temp[8:5];
      Q = temp[4:1];
      Qn = temp[0];
      count = count - 1;
      out = (count == 0) ? 1 : 0;
      b = 1;
      end
    end
    3'b101: begin
      AQ[7:4] = A;
      AQ[3:0] = Q;
    end
    default: begin
    end
  endcase
end

endmodule;

//first testbench
module MealyMachine_tb1;
    reg clk, reset;
    reg [3:0] M;
    reg [3:0] Qin;
    wire out;
    wire [7:0] AQ;

    MealyMachine inst (
        .clk(clk),
        .reset(reset),
        .M(M),
        .Qin(Qin),
        .out(out),
        .AQ(AQ)
    );

    initial begin
    clk = 0;
    reset = 0;
    M = 4'b0011;
    Qin = 4'b0010;
    #5
    reset = 1;
    #5
    forever begin
    #10 clk = ~clk;
    #30
    $display("AQ = %b", AQ);
    $display("out = %b", out);
    end
    $finish;
    end
endmodule

//second testbench
/*module MealyMachine_tb2;
    reg clk, reset;
    reg [3:0] M;
    reg [3:0] Qin;
    wire out;
    wire [7:0] AQ;

    MealyMachine inst (
        .clk(clk),
        .reset(reset),
        .M(M),
        .Qin(Qin),
        .out(out),
        .AQ(AQ)
    );

    initial begin
    clk = 0;
    reset = 0;
    M = 4'b0100;
    Qin = 4'b0011;
    #5
    reset = 1;
    #5
    forever begin
    #10 clk = ~clk;
    #30
    $display("AQ = %b", AQ);
    $display("out = %b", out);
    end
    $finish;
    end
endmodule*/
 