module DFF(input wire D, input wire clk, output reg Q);

always @(posedge clk)
begin
    Q <= D;
end
endmodule

module Decoder(
  input wire [3:0] address,
  output wire [15:0] select_line
);  
  assign select_line = (address == 4'b0000) ? 16'b0000000000000001 :
                       (address == 4'b0001) ? 16'b0000000000000010 :
                       (address == 4'b0010) ? 16'b0000000000000100 :
                       (address == 4'b0011) ? 16'b0000000000001000 :
                       (address == 4'b0100) ? 16'b0000000000010000 :
                       (address == 4'b0101) ? 16'b0000000000100000 :
                       (address == 4'b0110) ? 16'b0000000001000000 :
                       (address == 4'b0111) ? 16'b0000000010000000 :
                       (address == 4'b1000) ? 16'b0000000100000000 :
                       (address == 4'b1001) ? 16'b0000001000000000 :
                       (address == 4'b1010) ? 16'b0000010000000000 :
                       (address == 4'b1011) ? 16'b0000100000000000 :
                       (address == 4'b1100) ? 16'b0001000000000000 :
                       (address == 4'b1101) ? 16'b0010000000000000 :
                       (address == 4'b1110) ? 16'b0100000000000000 :
                       (address == 4'b1111) ? 16'b1000000000000000 : 16'b0000000000000000;
  

endmodule

module MemoryUnit(
  input wire [3:0] address,
  input wire [3:0] data_in,
  input wire write_enable,
  output reg [3:0] data_out
);

  wire [15:0] select_line;
  reg [3:0] data_reg [0:15];

  Decoder decoder_inst (
    .address(address),
    .select_line(select_line)
  );

  always @(posedge write_enable)
  begin
    if (write_enable)
      data_reg[select_line] <= data_in;
  end

  always @(*)
  begin
    if (select_line < 16'b10000)
      data_out = data_reg[select_line];
    else
      data_out = 4'b0000;
  end

endmodule


module MemoryUnit_tb;

  reg [3:0] address;
  reg [3:0] data_in;
  reg write_enable;
  wire [3:0] data_out;

  MemoryUnit mem_unit_inst (
    .address(address),
    .data_in(data_in),
    .write_enable(write_enable),
    .data_out(data_out)
  );

  reg clk = 0;
  initial begin
    $dumpfile("MemoryUnit_tb.vcd");
    $dumpvars(0, MemoryUnit_tb);

    forever begin
    #5 clk = ~clk;
    #5
    address = 4'b0010;
    data_in = 4'b1100;
    write_enable = 1;
    #20;
    $display("data out1 = %b", data_out);
    address = 4'b0010;
    data_in = 4'b0000;
    write_enable = 0;
    #20;
    $display("data out2 = %b", data_out);
    address = 4'b0101;
    data_in = 4'b1010;
    write_enable = 1;
    #20;
    $display("data out3 = %b", data_out);

    address = 4'b0101;
    data_in = 4'b0000;
    write_enable = 0;
    #20;
    $display("data out4 = %b", data_out);
    end
    $finish;
  end

endmodule




