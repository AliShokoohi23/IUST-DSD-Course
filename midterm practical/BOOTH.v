module MealyMachine (
    input wire clk,
    input wire reset,
    input wire [3:0] Qin,
    input wire [3:0] M,
	  output reg out,
    output reg [7:0] AQ
);
reg[2:0] state,nextState;
reg[3:0] A,Q;
reg Qn;
integer count;
reg[8:0] temp;
reg[3:0] M_comp;

always @(negedge reset) begin
    state <= 3'b000;
    count <= 4;
    A <= 4'b0000;
    Qn <= 0;
    out <= 0;
    Q <= Qin;
    temp <= {A,Q,Qn};
end
always @(posedge clk)
begin
  state <= nextState;
end

always @(state or Q or Qn or count) begin
  case (state)
    3'b000: begin
      nextState = 3'b001;
    end
    3'b001: begin
      if (Q[0] == 0 && Qn == 0)
        nextState = 3'b100;
      else if (Q[0] == 0 && Qn == 1)
        nextState = 3'b010;
      else if (Q[0] == 1 && Qn == 0)
        nextState = 3'b011;
      else if (Q[0] == 1 && Qn == 1)
        nextState = 3'b100;
      out = 0;
    end
    3'b010: begin
      nextState = 3'b100;
    end
    3'b011: begin
      nextState = 3'b100;
    end
    3'b100: begin
      if (count == 0)
        nextState = 3'b101;
      else
        nextState = 3'b001;
    end
    3'b101: begin
    end
    default: begin
    end
  endcase
end

  always @(state or Q or Qn or count,A) begin
case (state)
3'b000: begin
      
    end
    3'b001: begin
      
    end
    3'b010: begin
      A = A + M;
    end
    3'b011: begin
      M_comp = ~M + 1;
      A = A + M_comp;
    end
    3'b100: begin
      temp = {A,Q,Qn};
      temp = {temp[8],temp[8:6],temp[5:1]};
      A = temp[8:5];
      Q = temp[4:1];
      Qn = temp[0];
      count = count - 1;
      out = (count == 0) ? 1 : 0;
    end
    3'b101: begin
      AQ = temp[8:1];
    end
    default: begin
    end
  endcase
end


endmodule

//testbench
// AQ is final result
module MealyMachine_tb1;
    reg clk, reset;
    reg [3:0] M;
    reg [3:0] Qin;
    wire out;
    wire [7:0] AQ;
    integer i = 5000;

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
    reset = 1;
    reset = 0;
    // negative number in negative number (-6 * -2 = 12)
    M = 4'b1010;
    Qin = 4'b1110;
    #5
    while(i > 0)
    begin
    #10 clk = ~clk;
    i = i - 1;
    end
    $display("AQ1 = %b", AQ);
    $display("out1 = %b", out);

    #50
    clk = 0;
    reset = 1;
    reset = 0;
    //positive number in positive number (4 * 5 = 20)
    M = 4'b0100;
    Qin = 4'b0101;
    i = 5000;
    #5
    while(i > 0)
    begin
    #10 clk = ~clk;
    i = i - 1;
    end
    $display("AQ2 = %b", AQ);
    $display("out2 = %b", out);

    #50
    clk = 0;
    reset = 1;
    reset = 0;
    //negative number in positive number (-6 * 4 = -24)
    M = 4'b1010;
    Qin = 4'b0100;
    i = 5000;
    #5
    while(i > 0)
    begin
    #10 clk = ~clk;
    i = i - 1;
    end
    $display("AQ3 = %b", AQ);
    $display("out3 = %b", out);

    #50
    clk = 0;
    reset = 1;
    reset = 0;
    //positive number in negative number (2 * -8 = -16)
    M = 4'b0010;
    Qin = 4'b1000;
    i = 5000;
    #5
    while(i > 0)
    begin
    #10 clk = ~clk;
    i = i - 1;
    end
    $display("AQ4 = %b", AQ);
    $display("out4 = %b", out);
    $finish;
    end
endmodule
 