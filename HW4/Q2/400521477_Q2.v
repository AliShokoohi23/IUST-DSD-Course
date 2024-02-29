module convert_decimal_to_BCD(
    input wire [6:0] decimal,
    output wire [7:0] bcd,
    output wire [6:0] seg1,
    output wire [6:0] seg2
    
);
    assign bcd[7:4] = decimal / 10;
    assign bcd[3:0] = decimal % 10;
//I used https://www.javatpoint.com/ for converting BCD to 7-seg
    assign seg1 = (bcd[3:0] == 4'b0000) ? 7'b1111110 :
              (bcd[3:0] == 4'b0001) ? 7'b0110001 :
              (bcd[3:0] == 4'b0010) ? 7'b1101101 :
              (bcd[3:0] == 4'b0011) ? 7'b1111001 :
              (bcd[3:0] == 4'b0100) ? 7'b0110011 :
              (bcd[3:0] == 4'b0101) ? 7'b1011011 :
              (bcd[3:0] == 4'b0110) ? 7'b1011111 :
              (bcd[3:0] == 4'b0111) ? 7'b1110000 :
              (bcd[3:0] == 4'b1000) ? 7'b1111111 :
              (bcd[3:0] == 4'b1001) ? 7'b1111011 :
                                7'b0000000; 
    assign seg2 = (bcd[7:4] == 4'b0000) ? 7'b1111110 :
              (bcd[7:4] == 4'b0001) ? 7'b0110001 :
              (bcd[7:4] == 4'b0010) ? 7'b1101101 :
              (bcd[7:4] == 4'b0011) ? 7'b1111001 :
              (bcd[7:4] == 4'b0100) ? 7'b0110011 :
              (bcd[7:4] == 4'b0101) ? 7'b1011011 :
              (bcd[7:4] == 4'b0110) ? 7'b1011111 :
              (bcd[7:4] == 4'b0111) ? 7'b1110000 :
              (bcd[7:4] == 4'b1000) ? 7'b1111111 :
              (bcd[7:4] == 4'b1001) ? 7'b1111011 :
                                7'b0000000;

endmodule




