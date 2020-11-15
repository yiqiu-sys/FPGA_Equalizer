`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/07 23:00:41
// Design Name: 
// Module Name: ChuFa
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


module ChuFa(
input[31:0] a, 
input[31:0] b,
 
output [31:0] yshang,
output [31:0] yyushu,
output Error
);
wire [31:0] Yushu,Shang;
 
wire[31:0] tempb;
reg[63:0] temp_a;
reg[63:0] temp_b;
 
integer i;

assign Error=(|b==1)?1'b0:1'b1;
assign tempb=b;

always @(*)
begin
    temp_a = {32'h00000000,a};
    temp_b = {b,32'h00000000}; 
    for(i = 0;i < 32;i = i + 1)
        begin
            temp_a = {temp_a[62:0],1'b0};
            if(temp_a[63:32] >= tempb)
                temp_a = temp_a - temp_b + 1'b1;
            else
				temp_a = temp_a;
        end
 
end
 
     assign Shang = temp_a[31:0];
     assign Yushu = temp_a[63:32];
     assign yshang=(a==32'b0)?1'b0:Shang;
     assign yyushu=(a==32'b0)?1'b0:Yushu;
 
endmodule
