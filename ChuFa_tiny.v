`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/07 23:00:41
// Design Name: 
// Module Name: ChuFa_tiny
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


module ChuFa_tiny(
input[6:0] a, 
input[6:0] b,
 
output [6:0] yshang,
output [6:0] yyushu,
output Error
);
wire [6:0] Yushu,Shang;
 
wire[6:0] tempb;
reg[13:0] temp_a;
reg[13:0] temp_b;
 
integer i;

assign Error=(|b==1)?1'b0:1'b1;
assign tempb=b;

always @(*)
begin
    temp_a = {7'b0000000,a};
    temp_b = {b,7'b0000000}; 
    for(i = 0;i < 7;i = i + 1)
        begin
            temp_a = {temp_a[12:0],1'b0};
            if(temp_a[13:7] >= tempb)
                temp_a = temp_a - temp_b + 1'b1;
            else
				temp_a = temp_a;
        end
 
end
 
     assign Shang = temp_a[6:0];
     assign Yushu = temp_a[13:7];
     assign yshang=(a==7'b0)?1'b0:Shang;
     assign yyushu=(a==7'b0)?1'b0:Yushu;
 
endmodule
