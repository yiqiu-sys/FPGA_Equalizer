`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/13 12:36:58
// Design Name: 
// Module Name: modify_time
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


module modify_time(
 input[11:0]           button_ord,
 input                 I2C_clk,
 output[8:0]           min_mod,
 output[5:0]           sec_mod,
 output reg [3:0]      min1,
 output reg [3:0]      min2,
 output reg [3:0]      sec1,
 output reg [3:0]      sec2
    
 );
 
 reg[2:0] state=3'b000;
 
 assign min_mod={5'd0,min1}*9'd10+{5'd0,min2};
 assign sec_mod={2'd0,sec1}*6'd10+{2'd0,sec2};
 
always @(posedge I2C_clk)
 begin
 
 case(state)
 3'b000:
 begin
 min1<=4'd0;
 min2<=4'd0;
 sec1<=4'd0;
 sec2<=4'd0;
 state<=3'b001;
 end
 
 3'b001:
 begin
 if(button_ord[10]==1'b1)
  begin
  state<=3'b000;
  end
 else if(button_ord[0]==1'b1)
  begin
  min1<=4'd1;
  state<=3'b010;
  end
 else if(button_ord[1]==1'b1)
  begin
  min1<=4'd2;
  state<=3'b010;
  end
 else if(button_ord[2]==1'b1)
  begin
  min1<=4'd3;
  state<=3'b010;
  end
 else if(button_ord[3]==1'b1)
  begin
  min1<=4'd4;
  state<=3'b010;
  end
 else if(button_ord[4]==1'b1)
  begin
  min1<=4'd5;
  state<=3'b010;
  end
 else if(button_ord[5]==1'b1)
  begin
  min1<=4'd6;
  state<=3'b010;
  end  
 else if(button_ord[6]==1'b1)
  begin
  min1<=4'd7;
  state<=3'b010;
  end
 else if(button_ord[7]==1'b1)
  begin
  min1<=4'd8;
  state<=3'b010;
  end
 else if(button_ord[8]==1'b1)
  begin
  min1<=4'd9;
  state<=3'b010;
  end
 else if(button_ord[9]==1'b1)
  begin
  min1<=4'd0;
  state<=3'b010;
  end
 else
  begin
  min1<=min1;
  state<=state;
  end       
 end
 
  3'b010:
 begin
 if(button_ord[10]==1'b1)
  begin
  state<=3'b000;
  end
 else if(button_ord[0]==1'b1)
  begin
  min2<=4'd1;
  state<=3'b011;
  end
 else if(button_ord[1]==1'b1)
  begin
  min2<=4'd2;
  state<=3'b011;
  end
 else if(button_ord[2]==1'b1)
  begin
  min2<=4'd3;
  state<=3'b011;
  end
 else if(button_ord[3]==1'b1)
  begin
  min2<=4'd4;
  state<=3'b011;
  end
 else if(button_ord[4]==1'b1)
  begin
  min2<=4'd5;
  state<=3'b011;
  end
 else if(button_ord[5]==1'b1)
  begin
  min2<=4'd6;
  state<=3'b011;
  end  
 else if(button_ord[6]==1'b1)
  begin
  min2<=4'd7;
  state<=3'b011;
  end
 else if(button_ord[7]==1'b1)
  begin
  min2<=4'd8;
  state<=3'b011;
  end
 else if(button_ord[8]==1'b1)
  begin
  min2<=4'd9;
  state<=3'b011;
  end
 else if(button_ord[9]==1'b1)
  begin
  min2<=4'd0;
  state<=3'b011;
  end
 else
  begin
  min2<=min2;
  state<=state;
  end       
 end

  3'b011:
 begin
 if(button_ord[10]==1'b1)
  begin
  state<=3'b000;
  end
 else if(button_ord[0]==1'b1)
  begin
  sec1<=4'd1;
  state<=3'b100;
  end
 else if(button_ord[1]==1'b1)
  begin
  sec1<=4'd2;
  state<=3'b100;
  end
 else if(button_ord[2]==1'b1)
  begin
  sec1<=4'd3;
  state<=3'b100;
  end
 else if(button_ord[3]==1'b1)
  begin
  sec1<=4'd4;
  state<=3'b100;
  end
 else if(button_ord[4]==1'b1)
  begin
  sec1<=4'd5;
  state<=3'b100;
  end
 else if(button_ord[5]==1'b1)
  begin
  sec1<=4'd6;
  state<=3'b100;
  end  
 else if(button_ord[6]==1'b1)
  begin
  sec1<=4'd7;
  state<=3'b100;
  end
 else if(button_ord[7]==1'b1)
  begin
  sec1<=4'd8;
  state<=3'b100;
  end
 else if(button_ord[8]==1'b1)
  begin
  sec1<=4'd9;
  state<=3'b100;
  end
 else if(button_ord[9]==1'b1)
  begin
  sec1<=4'd0;
  state<=3'b100;
  end
 else
  begin
  sec1<=sec1;
  state<=state;
  end       
 end
 
  3'b100:
 begin
 if(button_ord[10]==1'b1)
  begin
  state<=3'b000;
  end
 else if(button_ord[0]==1'b1)
  begin
  sec2<=4'd1;
  state<=3'b001;
  end
 else if(button_ord[1]==1'b1)
  begin
  sec2<=4'd2;
  state<=3'b001;
  end
 else if(button_ord[2]==1'b1)
  begin
  sec2<=4'd3;
  state<=3'b001;
  end
 else if(button_ord[3]==1'b1)
  begin
  sec2<=4'd4;
  state<=3'b001;
  end
 else if(button_ord[4]==1'b1)
  begin
  sec2<=4'd5;
  state<=3'b001;
  end
 else if(button_ord[5]==1'b1)
  begin
  sec2<=4'd6;
  state<=3'b001;
  end  
 else if(button_ord[6]==1'b1)
  begin
  sec2<=4'd7;
  state<=3'b001;
  end
 else if(button_ord[7]==1'b1)
  begin
  sec2<=4'd8;
  state<=3'b001;
  end
 else if(button_ord[8]==1'b1)
  begin
  sec2<=4'd9;
  state<=3'b001;
  end
 else if(button_ord[9]==1'b1)
  begin
  sec2<=4'd0;
  state<=3'b001;
  end
 else
  begin
  sec2<=sec2;
  state<=state;
  end       
 end 
 
 endcase
 
 end
 
endmodule
