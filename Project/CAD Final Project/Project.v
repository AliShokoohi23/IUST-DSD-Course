module DClock(
  input CLK,
  input rst,
  output reg [15:0] LED,
  output reg [7:0] SEG_DATA,
  output reg [4:0] SEG_SEL
  //output reg BUZZER
);
reg CLK10MS = 1'b0;
reg CLK1S = 1'b0;
reg [7:0] SEG_DATA_reg1, SEG_DATA_reg2, SEG_DATA_reg3, SEG_DATA_reg4;
reg COUNTER2, COUNTER3, COUNTER4;
reg [3:0] BCD1, BCD2, BCD3, BCD4;
//reg ALARM;
reg [15:0] count_div1 = 8'b00000000;
reg [7:0] count_div2 = 8'b00000000;
reg [3:0] counter1 = 4'b0000;
reg [3:0] counter2 = 4'b0000;
reg [3:0] counter3 = 4'b0000;
reg [3:0] counter4 = 4'b0000;
reg [2:0] RefreshSEG;
//reg idle;

always @(negedge rst)
begin
  BCD1 <= 4'b0000;
  BCD2 <= 4'b0000;
  BCD3 <= 4'b0000;
  BCD4 <= 4'b0000;
end
// 10 millisecond delay signal
always @(posedge CLK)
begin
  if (count_div1 < 2) //400000
    count_div1 <= count_div1 + 1;
  else begin
    count_div1 <= 0;
    CLK10MS <= ~CLK10MS;
  end
end

// 1 second delay signal
always @(posedge CLK10MS)
begin
  if (count_div2 < 40) //41
    count_div2 <= count_div2 + 1;
  else begin
    count_div2 <= 0;
    CLK1S <= ~CLK1S;
  end
end

// BCD counters
always @(posedge CLK1S)
begin
    if (counter1 < 9) begin
      counter1 = counter1 + 1;
      COUNTER2 = 0;
    end
    else begin
      counter1 = 0;
      COUNTER2 = 1;
    end
    BCD1 = counter1;
end

always @(posedge COUNTER2)
begin
    if (counter2 < 5) begin
      counter2 = counter2 + 1;
      COUNTER3 = 0;
    end
    else begin
      counter2 = 0;
      COUNTER3 = 1;
    end
    BCD2 = counter2;
end

always @(posedge COUNTER3)
begin
    if (counter3 < 9) begin
      counter3 = counter3 + 1;
      COUNTER3 = 0;
    end
    else begin
      counter3 = 0;
      COUNTER4 = 1;
    end
    BCD3 = counter3;
end

always @(posedge COUNTER4)
begin
    if (counter4 < 5) begin
      counter4 = counter4 + 1;
      COUNTER3 = 0;
    end
    else begin
      counter3 = 0;
    end
    BCD4 = counter4;
end

// BCD to 7 segment converters
always @(*)
begin
  case (BCD1)
    4'b0000: SEG_DATA_reg1 = 7'b0111111;
    4'b0001: SEG_DATA_reg1 = 7'b0000110;
    4'b0010: SEG_DATA_reg1 = 7'b1011011;
    4'b0011: SEG_DATA_reg1 = 7'b1001111;
    4'b0100: SEG_DATA_reg1 = 7'b1100110;
    4'b0101: SEG_DATA_reg1 = 7'b1101101;
    4'b0110: SEG_DATA_reg1 = 7'b1111101;
    4'b0111: SEG_DATA_reg1 = 7'b0000111;
    4'b1000: SEG_DATA_reg1 = 7'b1111111;
    4'b1001: SEG_DATA_reg1 = 7'b1101111;
    default: SEG_DATA_reg1 = 7'b0000000;
  endcase
end

always @(*)
begin
  case (BCD2)
    4'b0000: SEG_DATA_reg2 = 7'b0111111;
    4'b0001: SEG_DATA_reg2 = 7'b0000110;
    4'b0010: SEG_DATA_reg2 = 7'b1011011;
    4'b0011: SEG_DATA_reg2 = 7'b1001111;
    4'b0100: SEG_DATA_reg2 = 7'b1100110;
    4'b0101: SEG_DATA_reg2 = 7'b1101101;
    4'b0110: SEG_DATA_reg2 = 7'b1111101;
    4'b0111: SEG_DATA_reg2 = 7'b0000111;
    4'b1000: SEG_DATA_reg2 = 7'b1111111;
    4'b1001: SEG_DATA_reg2 = 7'b1101111;
    default: SEG_DATA_reg2 = 7'b0000000;
  endcase
end

always @(*)
begin
  case (BCD3)
    4'b0000: SEG_DATA_reg3 = 7'b0111111;
    4'b0001: SEG_DATA_reg3 = 7'b0000110;
    4'b0010: SEG_DATA_reg3 = 7'b1011011;
    4'b0011: SEG_DATA_reg3 = 7'b1001111;
    4'b0100: SEG_DATA_reg3 = 7'b1100110;
    4'b0101: SEG_DATA_reg3 = 7'b1101101;
    4'b0110: SEG_DATA_reg3 = 7'b1111101;
    4'b0111: SEG_DATA_reg3 = 7'b0000111;
    4'b1000: SEG_DATA_reg3 = 7'b1111111;
    4'b1001: SEG_DATA_reg3 = 7'b1101111;
    default: SEG_DATA_reg3 = 7'b0000000;
  endcase
end

always @(*)
begin
  case (BCD4)
    4'b0000: SEG_DATA_reg4 = 7'b0111111;
    4'b0001: SEG_DATA_reg4 = 7'b0000110;
    4'b0010: SEG_DATA_reg4 = 7'b1011011;
    4'b0011: SEG_DATA_reg4 = 7'b1001111;
    4'b0100: SEG_DATA_reg4 = 7'b1100110;
    4'b0101: SEG_DATA_reg4 = 7'b1101101;
    4'b0110: SEG_DATA_reg4 = 7'b1111101;
    4'b0111: SEG_DATA_reg4 = 7'b0000111;
    4'b1000: SEG_DATA_reg4 = 7'b1111111;
    4'b1001: SEG_DATA_reg4 = 7'b1101111;
    default: SEG_DATA_reg4 = 7'b0000000;
  endcase
end



always @(*)
begin
  LED = {BCD4, BCD3, BCD2, BCD1};
end

// Display refresher
always @(posedge CLK10MS)
begin
  if (RefreshSEG < 4)
    RefreshSEG <= RefreshSEG + 1;
  else 
    RefreshSEG <= 0;
  case (RefreshSEG)
    3'b000: begin
      SEG_SEL[4] <= 1'b0;
      SEG_SEL[0] <= 1'b1;
      SEG_DATA <= SEG_DATA_reg1;
    end
    3'b001: begin
      SEG_SEL[0] <= 1'b0;
      SEG_SEL[1] <= 1'b1;
      SEG_DATA <= SEG_DATA_reg2;
    end
    3'b010: begin
      SEG_SEL[1] <= 1'b0;
      SEG_SEL[2] <= 1'b1;
      SEG_DATA <= SEG_DATA_reg3;
    end
    3'b011: begin
      SEG_SEL[2] <= 1'b0;
      SEG_SEL[3] <= 1'b1;
      SEG_DATA <= SEG_DATA_reg4;
    end

    3'b100: begin
      SEG_SEL[3] <= 1'b0;
      SEG_SEL[4] <= 1'b1;
      SEG_DATA[0] <= BCD1[0];
      SEG_DATA[1] <= BCD1[0];
      SEG_DATA[7:2] <= 6'b000000;
    end
    default: begin
    end
  endcase
end

// Buzzer controller
/*always @(posedge CLK)
begin
  BUZZER <= 1'b0;
  if (idle) begin
    if (ALARM) begin
      BUZZER <= 1'b1;
      idle <= 1'b0;
    end
  end
  else begin
    if (!ALARM) idle <= 1'b1;
  end
end*/

endmodule




