`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/04 21:35:31
// Design Name: 
// Module Name: button_order
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


module button_order(
	 input                   pclk,
	 input                   touch_int,
	 input  [11:0]           TOUCH1_X2,
     input  [11:0]           TOUCH1_Y2,
	 output reg [11:0]       button_ord,
	 input                   update
    );

reg        button_active0,button_active1,button_active2,button_active3,button_active4,button_active5,button_active6,button_active7,button_active8,button_active9,button_active10,button_active11;
reg        touch_int1,touch_int2;
wire       touch_in;
reg [5:0]  WAIT_num1=6'd0;
reg [24:0] WAIT_num2=25'd0;
reg [5:0]  WAIT_num3=6'd0;
reg [24:0] WAIT_num4=25'd0;
reg [5:0]  WAIT_num5=6'd0;
reg [24:0] WAIT_num6=25'd0;
reg [5:0]  WAIT_num7=6'd0;
reg [24:0] WAIT_num8=25'd0;
reg [5:0]  WAIT_num9=6'd0;
reg [24:0] WAIT_num10=25'd0;
reg [5:0]  WAIT_num11=6'd0;
reg [24:0] WAIT_num12=25'd0;
reg [5:0]  WAIT_num13=6'd0;
reg [24:0] WAIT_num14=25'd0;
reg [5:0]  WAIT_num15=6'd0;
reg [24:0] WAIT_num16=25'd0;
reg [5:0]  WAIT_num17=6'd0;
reg [24:0] WAIT_num18=25'd0;
reg [5:0]  WAIT_num19=6'd0;
reg [24:0] WAIT_num20=25'd0;

reg [1:0]  state1,state2,state3,state4,state5,state6,state7,state8,state9,state10;

//Key feedback state machine parameters
parameter IDLE=2'd0;
parameter SHORT=2'd1;
parameter WAIT=2'd2;
parameter LONG=2'd3;

assign    touch_in=~touch_int1&touch_int2;

always@(posedge pclk)
begin
	if(TOUCH1_Y2 >= 12'd160 && TOUCH1_Y2 <= 12'd220 && TOUCH1_X2 >= 12'd480 && TOUCH1_X2  <= 12'd565)	
		button_active0 <= 1'b1;
	else
		button_active0 <= 1'b0;
                if(TOUCH1_Y2 >= 12'd160 && TOUCH1_Y2 <= 12'd220 && TOUCH1_X2 >= 12'd586 && TOUCH1_X2  <= 12'd671)	
		button_active1 <= 1'b1;
	else
		button_active1 <= 1'b0;
               if(TOUCH1_Y2 >= 12'd160 && TOUCH1_Y2 <= 12'd220 && TOUCH1_X2 >= 12'd693 && TOUCH1_X2  <= 12'd778)	
		button_active2 <= 1'b1;
	else
		button_active2 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd240 && TOUCH1_Y2 <= 12'd300 && TOUCH1_X2 >= 12'd480 && TOUCH1_X2  <= 12'd565)	
		button_active3 <= 1'b1;
	else
		button_active3 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd240 && TOUCH1_Y2 <= 12'd300 && TOUCH1_X2 >= 12'd586 && TOUCH1_X2  <= 12'd671)	
		button_active4 <= 1'b1;
	else
		button_active4 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd240 && TOUCH1_Y2 <= 12'd300 && TOUCH1_X2 >= 12'd693 && TOUCH1_X2  <= 12'd778)	
		button_active5 <= 1'b1;
	else
		button_active5 <= 1'b0;		
              if(TOUCH1_Y2 >= 12'd320 && TOUCH1_Y2 <= 12'd380 && TOUCH1_X2 >= 12'd480 && TOUCH1_X2  <= 12'd565)	
		button_active6 <= 1'b1;
	else
		button_active6 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd320 && TOUCH1_Y2 <= 12'd380 && TOUCH1_X2 >= 12'd586 && TOUCH1_X2  <= 12'd671)	
		button_active7 <= 1'b1;
	else
		button_active7 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd320 && TOUCH1_Y2 <= 12'd380 && TOUCH1_X2 >= 12'd693 && TOUCH1_X2  <= 12'd778)	
		button_active8 <= 1'b1;
	else
		button_active8 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd400 && TOUCH1_Y2 <= 12'd460 && TOUCH1_X2 >= 12'd480 && TOUCH1_X2  <= 12'd565)	
		button_active9 <= 1'b1;
	else
		button_active9 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd400 && TOUCH1_Y2 <= 12'd460 && TOUCH1_X2 >= 12'd586 && TOUCH1_X2  <= 12'd671)	
		button_active10 <= 1'b1;
	else
		button_active10 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd400 && TOUCH1_Y2 <= 12'd460 && TOUCH1_X2 >= 12'd693 && TOUCH1_X2  <= 12'd778)	
		button_active11 <= 1'b1;
	else
		button_active11 <= 1'b0;				
end
    
  always @(posedge pclk)
  begin
  touch_int1<=touch_int;
  touch_int2<=touch_int1;
  end    

 
 //Key feedback mode second
 always @(posedge pclk)
 begin
 case(state1)
 
 IDLE:
 begin
 if(touch_in==1'b1 && button_active0==1'b1)
begin
 if(WAIT_num1==6'd30)
 begin
 WAIT_num1<=6'd0;
 state1<=SHORT;
 button_ord[0]<=1'b1;
 end
 else
 begin
 WAIT_num1<=WAIT_num1+6'd1;
 button_ord[0]<=1'b0;
 end
 
 end

 
 end
 
 SHORT:
 begin
 button_ord[0]<=1'b0;
 state1<=WAIT;
 end
 
 WAIT:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num2==25'd11000000)
 begin
 WAIT_num2<=25'd0;
 state1<=IDLE;
 button_ord[0]<=1'b0;
 WAIT_num1<=6'd0;
 end
 else
 WAIT_num2<=WAIT_num2+25'd1;
 end
 
 if(touch_in==1'b1 && button_active0==1'b1)
 begin
 WAIT_num2<=25'd0;
 if(WAIT_num1==6'd30)
 begin
 WAIT_num1<=6'd0;
 state1<=LONG;
 end
 else
 WAIT_num1<=WAIT_num1+6'd1;
 end
 
 end
 
  LONG:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num2==25'd11000000)
 begin
 WAIT_num2<=25'd0;
 state1<=IDLE;
 button_ord[0]<=1'b0;
 end
 else
 WAIT_num2<=WAIT_num2+25'd1;
 end
 
 if(touch_in==1'b1 && button_active0==1'b1)
 begin
 WAIT_num2<=25'd0;
 button_ord[0]<=1'b0;
 end
 else
 button_ord[0]<=1'b0;
 
 end
 
 endcase
 end
 
 
 //Key feedback mode second
 always @(posedge pclk)
 begin
 case(state4)
 
 IDLE:
 begin
 if(touch_in==1'b1 && button_active3==1'b1)
begin
 if(WAIT_num7==6'd30)
 begin
 WAIT_num7<=6'd0;
 state4<=SHORT;
 button_ord[3]<=1'b1;
 end
 else
 begin
 WAIT_num7<=WAIT_num7+6'd1;
 button_ord[3]<=1'b0;
 end
 
 end

 
 end
 
 SHORT:
 begin
 button_ord[3]<=1'b0;
 state4<=WAIT;
 end
 
 WAIT:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num8==25'd11000000)
 begin
 WAIT_num8<=25'd0;
 state4<=IDLE;
 button_ord[3]<=1'b0;
 WAIT_num7<=6'd0;
 end
 else
 WAIT_num8<=WAIT_num8+25'd1;
 end
 
 if(touch_in==1'b1 && button_active3==1'b1)
 begin
 WAIT_num8<=25'd0;
 if(WAIT_num7==6'd30)
 begin
 WAIT_num7<=6'd0;
 state4<=LONG;
 end
 else
 WAIT_num7<=WAIT_num7+6'd1;
 end
 
 end
 
  LONG:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num8==25'd11000000)
 begin
 WAIT_num8<=25'd0;
 state4<=IDLE;
 button_ord[3]<=1'b0;
 end
 else
 WAIT_num8<=WAIT_num8+25'd1;
 end
 
 if(touch_in==1'b1 && button_active3==1'b1)
 begin
 WAIT_num8<=25'd0;
 button_ord[3]<=1'b0;
 end
 else
 button_ord[3]<=1'b0;
 
 end
 
 endcase
 end
 
  //Key feedback mode second
 always @(posedge pclk)
 begin
 case(state2)
 
 IDLE:
 begin
 if(touch_in==1'b1 && button_active1==1'b1)
begin
 if(WAIT_num3==6'd30)
 begin
 WAIT_num3<=6'd0;
 state2<=SHORT;
 button_ord[1]<=1'b1;
 end
 else
 begin
 WAIT_num3<=WAIT_num3+6'd1;
 button_ord[1]<=1'b0;
 end
 
 end

 
 end
 
 SHORT:
 begin
 button_ord[1]<=1'b0;
 state2<=WAIT;
 end
 
 WAIT:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num4==25'd11000000)
 begin
 WAIT_num4<=25'd0;
 state2<=IDLE;
 button_ord[1]<=1'b0;
 WAIT_num3<=6'd0;
 end
 else
 WAIT_num4<=WAIT_num4+25'd1;
 end
 
 if(touch_in==1'b1 && button_active1==1'b1)
 begin
 WAIT_num4<=25'd0;
 if(WAIT_num3==6'd30)
 begin
 WAIT_num3<=6'd0;
 state2<=LONG;
 end
 else
 WAIT_num3<=WAIT_num3+6'd1;
 end
 
 end
 
  LONG:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num4==25'd11000000)
 begin
 WAIT_num4<=25'd0;
 state2<=IDLE;
 button_ord[1]<=1'b0;
 end
 else
 WAIT_num4<=WAIT_num4+25'd1;
 end
 
 if(touch_in==1'b1 && button_active1==1'b1)
 begin
 WAIT_num4<=25'd0;
 button_ord[1]<=1'b0;
 end
 else
 button_ord[1]<=1'b0;
 
 end
 
 endcase
 end
 
  //Key feedback mode second
 always @(posedge pclk)
 begin
 case(state3)
 
 IDLE:
 begin
 if(touch_in==1'b1 && button_active2==1'b1)
begin
 if(WAIT_num5==6'd30)
 begin
 WAIT_num5<=6'd0;
 state3<=SHORT;
 button_ord[2]<=1'b1;
 end
 else
 begin
 WAIT_num5<=WAIT_num5+6'd1;
 button_ord[2]<=1'b0;
 end
 
 end

 
 end
 
 SHORT:
 begin
 button_ord[2]<=1'b0;
 state3<=WAIT;
 end
 
 WAIT:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num6==25'd11000000)
 begin
 WAIT_num6<=25'd0;
 state3<=IDLE;
 button_ord[2]<=1'b0;
 WAIT_num5<=6'd0;
 end
 else
 WAIT_num6<=WAIT_num6+25'd1;
 end
 
 if(touch_in==1'b1 && button_active2==1'b1)
 begin
 WAIT_num6<=25'd0;
 if(WAIT_num5==6'd30)
 begin
 WAIT_num5<=6'd0;
 state3<=LONG;
 end
 else
 WAIT_num5<=WAIT_num5+6'd1;
 end
 
 end
 
  LONG:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num6==25'd11000000)
 begin
 WAIT_num6<=25'd0;
 state3<=IDLE;
 button_ord[2]<=1'b0;
 end
 else
 WAIT_num6<=WAIT_num6+25'd1;
 end
 
 if(touch_in==1'b1 && button_active2==1'b1)
 begin
 WAIT_num6<=25'd0;
 button_ord[2]<=1'b0;
 end
 else
 button_ord[2]<=1'b0;
 
 end
 
 endcase
 end
 
  //Key feedback mode second
 always @(posedge pclk)
 begin
 case(state5)
 
 IDLE:
 begin
 if(touch_in==1'b1 && button_active4==1'b1)
begin
 if(WAIT_num9==6'd30)
 begin
 WAIT_num9<=6'd0;
 state5<=SHORT;
 button_ord[4]<=1'b1;
 end
 else
 begin
 WAIT_num9<=WAIT_num9+6'd1;
 button_ord[4]<=1'b0;
 end
 
 end

 
 end
 
 SHORT:
 begin
 button_ord[4]<=1'b0;
 state5<=WAIT;
 end
 
 WAIT:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num10==25'd11000000)
 begin
 WAIT_num10<=25'd0;
 state5<=IDLE;
 button_ord[4]<=1'b0;
 WAIT_num9<=6'd0;
 end
 else
 WAIT_num10<=WAIT_num10+25'd1;
 end
 
 if(touch_in==1'b1 && button_active4==1'b1)
 begin
 WAIT_num10<=25'd0;
 if(WAIT_num9==6'd30)
 begin
 WAIT_num9<=6'd0;
 state5<=LONG;
 end
 else
 WAIT_num9<=WAIT_num9+6'd1;
 end
 
 end
 
  LONG:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num10==25'd11000000)
 begin
 WAIT_num10<=25'd0;
 state5<=IDLE;
 button_ord[4]<=1'b0;
 end
 else
 WAIT_num10<=WAIT_num10+25'd1;
 end
 
 if(touch_in==1'b1 && button_active4==1'b1)
 begin
 WAIT_num10<=25'd0;
 button_ord[4]<=1'b0;
 end
 else
 button_ord[4]<=1'b0;
 
 end
 
 endcase
 end
 
  //Key feedback mode second
 always @(posedge pclk)
 begin
 case(state6)
 
 IDLE:
 begin
 if(touch_in==1'b1 && button_active5==1'b1)
begin
 if(WAIT_num11==6'd30)
 begin
 WAIT_num11<=6'd0;
 state6<=SHORT;
 button_ord[5]<=1'b1;
 end
 else
 begin
 WAIT_num11<=WAIT_num11+6'd1;
 button_ord[5]<=1'b0;
 end
 
 end

 
 end
 
 SHORT:
 begin
 button_ord[5]<=1'b0;
 state6<=WAIT;
 end
 
 WAIT:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num12==25'd11000000)
 begin
 WAIT_num12<=25'd0;
 state6<=IDLE;
 button_ord[5]<=1'b0;
 WAIT_num11<=6'd0;
 end
 else
 WAIT_num12<=WAIT_num12+25'd1;
 end
 
 if(touch_in==1'b1 && button_active5==1'b1)
 begin
 WAIT_num12<=25'd0;
 if(WAIT_num11==6'd30)
 begin
 WAIT_num11<=6'd0;
 state6<=LONG;
 end
 else
 WAIT_num11<=WAIT_num11+6'd1;
 end
 
 end
 
  LONG:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num12==25'd11000000)
 begin
 WAIT_num12<=25'd0;
 state6<=IDLE;
 button_ord[5]<=1'b0;
 end
 else
 WAIT_num12<=WAIT_num12+25'd1;
 end
 
 if(touch_in==1'b1 && button_active5==1'b1)
 begin
 WAIT_num12<=25'd0;
 button_ord[5]<=1'b0;
 end
 else
 button_ord[5]<=1'b0;
 
 end
 
 endcase
 end
 
  //Key feedback mode second
 always @(posedge pclk)
 begin
 case(state7)
 
 IDLE:
 begin
 if(touch_in==1'b1 && button_active6==1'b1)
begin
 if(WAIT_num13==6'd30)
 begin
 WAIT_num13<=6'd0;
 state7<=SHORT;
 button_ord[6]<=1'b1;
 end
 else
 begin
 WAIT_num13<=WAIT_num13+6'd1;
 button_ord[6]<=1'b0;
 end
 
 end

 
 end
 
 SHORT:
 begin
 button_ord[6]<=1'b0;
 state7<=WAIT;
 end
 
 WAIT:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num14==25'd11000000)
 begin
 WAIT_num14<=25'd0;
 state7<=IDLE;
 button_ord[6]<=1'b0;
 WAIT_num13<=6'd0;
 end
 else
 WAIT_num14<=WAIT_num14+25'd1;
 end
 
 if(touch_in==1'b1 && button_active6==1'b1)
 begin
 WAIT_num14<=25'd0;
 if(WAIT_num13==6'd30)
 begin
 WAIT_num13<=6'd0;
 state7<=LONG;
 end
 else
 WAIT_num13<=WAIT_num13+6'd1;
 end
 
 end
 
  LONG:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num14==25'd11000000)
 begin
 WAIT_num14<=25'd0;
 state7<=IDLE;
 button_ord[6]<=1'b0;
 end
 else
 WAIT_num14<=WAIT_num14+25'd1;
 end
 
 if(touch_in==1'b1 && button_active6==1'b1)
 begin
 WAIT_num14<=25'd0;
 button_ord[6]<=1'b0;
 end
 else
 button_ord[6]<=1'b0;
 
 end
 
 endcase
 end
 
  //Key feedback mode second
 always @(posedge pclk)
 begin
 case(state8)
 
 IDLE:
 begin
 if(touch_in==1'b1 && button_active7==1'b1)
begin
 if(WAIT_num15==6'd30)
 begin
 WAIT_num15<=6'd0;
 state8<=SHORT;
 button_ord[7]<=1'b1;
 end
 else
 begin
 WAIT_num15<=WAIT_num15+6'd1;
 button_ord[7]<=1'b0;
 end
 
 end

 
 end
 
 SHORT:
 begin
 button_ord[7]<=1'b0;
 state8<=WAIT;
 end
 
 WAIT:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num16==25'd11000000)
 begin
 WAIT_num16<=25'd0;
 state8<=IDLE;
 button_ord[7]<=1'b0;
 WAIT_num15<=6'd0;
 end
 else
 WAIT_num16<=WAIT_num16+25'd1;
 end
 
 if(touch_in==1'b1 && button_active7==1'b1)
 begin
 WAIT_num16<=25'd0;
 if(WAIT_num15==6'd30)
 begin
 WAIT_num15<=6'd0;
 state8<=LONG;
 end
 else
 WAIT_num15<=WAIT_num15+6'd1;
 end
 
 end
 
  LONG:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num16==25'd11000000)
 begin
 WAIT_num16<=25'd0;
 state8<=IDLE;
 button_ord[7]<=1'b0;
 end
 else
 WAIT_num16<=WAIT_num16+25'd1;
 end
 
 if(touch_in==1'b1 && button_active7==1'b1)
 begin
 WAIT_num16<=25'd0;
 button_ord[7]<=1'b0;
 end
 else
 button_ord[7]<=1'b0;
 
 end
 
 endcase
 end
 
  //Key feedback mode second
 always @(posedge pclk)
 begin
 case(state9)
 
 IDLE:
 begin
 if(touch_in==1'b1 && button_active8==1'b1)
begin
 if(WAIT_num17==6'd30)
 begin
 WAIT_num17<=6'd0;
 state9<=SHORT;
 button_ord[8]<=1'b1;
 end
 else
 begin
 WAIT_num17<=WAIT_num17+6'd1;
 button_ord[8]<=1'b0;
 end
 
 end

 
 end
 
 SHORT:
 begin
 button_ord[8]<=1'b0;
 state9<=WAIT;
 end
 
 WAIT:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num18==25'd11000000)
 begin
 WAIT_num18<=25'd0;
 state9<=IDLE;
 button_ord[8]<=1'b0;
 WAIT_num17<=6'd0;
 end
 else
 WAIT_num18<=WAIT_num18+25'd1;
 end
 
 if(touch_in==1'b1 && button_active8==1'b1)
 begin
 WAIT_num18<=25'd0;
 if(WAIT_num17==6'd30)
 begin
 WAIT_num17<=6'd0;
 state9<=LONG;
 end
 else
 WAIT_num17<=WAIT_num17+6'd1;
 end
 
 end
 
  LONG:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num18==25'd11000000)
 begin
 WAIT_num18<=25'd0;
 state9<=IDLE;
 button_ord[8]<=1'b0;
 end
 else
 WAIT_num18<=WAIT_num18+25'd1;
 end
 
 if(touch_in==1'b1 && button_active8==1'b1)
 begin
 WAIT_num18<=25'd0;
 button_ord[8]<=1'b0;
 end
 else
 button_ord[8]<=1'b0;
 
 end
 
 endcase
 end
 
  //Key feedback mode second
 always @(posedge pclk)
 begin
 case(state10)
 
 IDLE:
 begin
 if(touch_in==1'b1 && button_active10==1'b1)
begin
 if(WAIT_num19==6'd30)
 begin
 WAIT_num19<=6'd0;
 state10<=SHORT;
 button_ord[9]<=1'b1;
 end
 else
 begin
 WAIT_num19<=WAIT_num19+6'd1;
 button_ord[9]<=1'b0;
 end
 
 end

 
 end
 
 SHORT:
 begin
 button_ord[9]<=1'b0;
 state10<=WAIT;
 end
 
 WAIT:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num20==25'd11000000)
 begin
 WAIT_num20<=25'd0;
 state10<=IDLE;
 button_ord[9]<=1'b0;
 WAIT_num19<=6'd0;
 end
 else
 WAIT_num20<=WAIT_num20+25'd1;
 end
 
 if(touch_in==1'b1 && button_active10==1'b1)
 begin
 WAIT_num20<=25'd0;
 if(WAIT_num19==6'd30)
 begin
 WAIT_num19<=6'd0;
 state10<=LONG;
 end
 else
 WAIT_num19<=WAIT_num19+6'd1;
 end
 
 end
 
  LONG:
 begin
 if(touch_int==1'b1)
 begin
 if(WAIT_num20==25'd11000000)
 begin
 WAIT_num20<=25'd0;
 state10<=IDLE;
 button_ord[9]<=1'b0;
 end
 else
 WAIT_num20<=WAIT_num20+25'd1;
 end
 
 if(touch_in==1'b1 && button_active10==1'b1)
 begin
 WAIT_num20<=25'd0;
 button_ord[9]<=1'b0;
 end
 else
 button_ord[9]<=1'b0;
 
 end
 
 endcase
 end


 //Key feedback mode third
always @(posedge pclk)
begin
if(update==1'b1&&button_active9==1'b1)
button_ord[10]<=1'b1;
else
button_ord[10]<=1'b0;
end

 //Key feedback mode third
always @(posedge pclk)
begin
if(update==1'b1&&button_active11==1'b1)
button_ord[11]<=1'b1;
else
button_ord[11]<=1'b0;
end
 
    
endmodule
