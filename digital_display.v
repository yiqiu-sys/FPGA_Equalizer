`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/11 15:40:14
// Design Name: 
// Module Name: digital_display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module digital_display(
input                     rst,
input[6:0]                amount,          //wav file amount
input[6:0]                now,             //wav file current
output reg [5:0]         sel=6'b111110,   //position selective signal
output [6:0]              dig,            //segment selection signal 
input                     clk 
    );
    
 reg [6:0] amount_decade,amount_unit;
 reg [6:0] now_decade,now_unit;    
 wire [6:0] a;
 wire [6:0] yshang,yyushu;
 
 reg  [4:0] num;
 wire  numhi;
 
 reg [21:0] sel_num=22'd0;
 reg shift;
 
 reg [6:0] digit;
 
 reg [6:0] a_to_g;
 
 assign dig=~a_to_g;
 
 assign numhi=num[4];
 assign a=(numhi==1'b1)?amount:now; 
 
 always @(posedge clk)
  begin
  num<=num+5'd1;
  end
  
 always @(posedge clk)
  begin
  if(rst==1'b1)
  begin
  amount_decade<=7'd0;
  amount_unit<=7'd0;
  now_decade<=7'd0;
  now_unit<=7'd0;
  end
  else if(numhi==1'b1)
  begin
  amount_decade<=yshang;
  amount_unit<=yyushu;
  end
  else
  begin
  now_decade<=yshang;
  now_unit<=yyushu;
  end
  end
  
  always @(posedge clk)
   begin
   if(rst==1'b1)
   begin
   sel_num<=22'd0;
   shift<=1'b0;
   end
   else if(sel_num==22'd50000)
   begin
   sel_num<=22'd0;
   shift<=1'b1;
   end
   else
   begin
   sel_num<=sel_num+22'd1;
   shift<=1'b0;
   end
   end
   
   always @(posedge clk)
    begin
    if(shift==1'b1)
    sel<={sel[0],sel[5:1]};
    end
  
  always @(*)
   begin
   if(rst==1'b1)
   digit=7'd0;
   else if(sel[0]==1'b0)
   digit=now_decade;
   else if(sel[1]==1'b0)
   digit=now_unit;
   else if(sel[4]==1'b0)
   digit=amount_decade;
   else if(sel[5]==1'b0)
   digit=amount_unit;
   else
   digit=7'd15;
   end
   
      always@(*) 
      begin
      case(digit) 
        0:a_to_g=7'b1111110; 
        1:a_to_g=7'b0110000; 
        2:a_to_g=7'b1101101; 
        3:a_to_g=7'b1111001; 
        4:a_to_g=7'b0110011; 
        5:a_to_g=7'b1011011; 
        6:a_to_g=7'b1011111; 
        7:a_to_g=7'b1110000; 
        8:a_to_g=7'b1111111; 
        9:a_to_g=7'b1111011; 
        'hA:a_to_g=7'b1110111; 
        'hB:a_to_g=7'b0011111; 
        'hC:a_to_g=7'b1001110; 
        'hD:a_to_g=7'b0111101; 
        'hE:a_to_g=7'b1001111; 
        'hF:a_to_g=7'b0000000; 
        default:a_to_g=7'b1111110; 
      endcase 
     end
  
ChuFa_tiny Chu3(
 .a                 (a                 ), 
 .b                 (7'd10             ), 
.yshang            (yshang            ),
 .yyushu            (yyushu            )
);
    
endmodule
