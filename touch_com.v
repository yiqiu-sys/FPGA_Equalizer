`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    touch_com 
// Function: initial touch and read the touch value
//////////////////////////////////////////////////////////////////////////////////
module touch_com
(
    input clk,
	 input reset,
	 
	 input touch_int,	 
	
	 output SCL,
	 inout SDA,

	 output [11:0] TOUCH1_X2,            //触摸�?1这一次的X坐标  15~14: 1st Event Flag, 11~0: X Position
     output [11:0] TOUCH1_Y2,             //触摸�?1这一次的Y坐标, 15~12: Touch ID, 11~0: Y Position
     
     output update
);
  
  
wire [7:0] RdData;
wire Done_Sig;

reg [7:0] WrAddr;
reg [7:0] WrData;
reg [1:0] isStart;

reg [7:0] Vendor_ID;

reg [7:0] GEST_ID;              //触摸动作
reg [3:0] TD_Status;            //触摸的点�?


reg [15:0] TF1_X2;            //触摸�?1这一次的X坐标  15~14: 2st Event Flag, 11~0: X Position
reg [15:0] TF1_Y2;            //触摸�?1这一次的Y坐标, 15~12: Touch ID, 11~0: Y Position

reg [4:0] touch_state;

reg upd;
reg upd0,upd1;

assign TOUCH1_X2=TF1_X2[11:0];
assign TOUCH1_Y2=TF1_Y2[11:0];

always @(posedge clk)
 begin
 upd0<=upd;
 upd1<=upd0;
 end

assign update=~upd0&upd1;

/***************************/
/*   touch register read   */
/***************************/	  
always @ ( posedge clk )	
begin
	 if( reset ) begin
			WrAddr <= 8'd0;
			WrData <= 8'd0;
			isStart <= 2'b00;
			touch_state<=5'd0;
			upd<=1'b0;
	 end
	 else begin
		case( touch_state )	 
	     5'd0: begin                  //read CTPM Vendor ID 168
		     if (Done_Sig) begin isStart <= 2'b00; touch_state<=touch_state+1'b1; Vendor_ID<=RdData; end
		       else begin isStart <= 2'b10; WrAddr <= 8'd168; end   
		  end
	     5'd1: begin                 //idle
	         upd<=1'b0;
		     if (touch_int==1'b0) begin isStart <= 2'b00; touch_state<=touch_state+1'b1; end
			  else begin touch_state<=touch_state; end
		  end
	     5'd2: begin                //read GEST_ID
		       if( Done_Sig ) begin isStart <= 2'b00; GEST_ID<=RdData; touch_state<=touch_state+1'b1; end 
		       else begin isStart <= 2'b10; WrAddr <= 8'd1; end   
		  end
	     5'd3: begin                //read TD_STATUS
		       if( Done_Sig ) begin isStart <= 2'b00; TD_Status<=RdData[3:0]; touch_state<=touch_state+1'b1; end 
		       else begin isStart <= 2'b10; WrAddr <= 8'd2; end   
		  end
		  
	     5'd4: begin                //read TOUCH1_XH
		       if( Done_Sig ) begin isStart <= 2'b00;  TF1_X2[15:8]<=RdData[7:0]; touch_state<=touch_state+1'b1; end 
		       else begin isStart <= 2'b10; WrAddr <= 8'd3;  end                   
		  end		  
	     5'd5: begin                //read TOUCH1_XL
		       if( Done_Sig ) begin isStart <= 2'b00; TF1_X2[7:0]<=RdData[7:0]; touch_state<=touch_state+1'b1; end 
		       else begin isStart <= 2'b10; WrAddr <= 8'd4; end   
		  end			  
	     5'd6: begin                //read TOUCH1_YH
		       if( Done_Sig ) begin isStart <= 2'b00; TF1_Y2[15:8]<=RdData[7:0]; touch_state<=touch_state+1'b1; end 
		       else begin isStart <= 2'b10; WrAddr <= 8'd5; end   
		  end			  
	     5'd7: begin                //read TOUCH1_YL
		       if( Done_Sig ) begin isStart <= 2'b00; TF1_Y2[7:0]<=RdData[7:0]; touch_state<=touch_state+1'b1; end 
		       else begin isStart <= 2'b10; WrAddr <= 8'd6; end   
		  end	
        5'd8:begin 
		       upd<=1'b1;
		       if(touch_int==1'b1) begin touch_state<=5'd1;end
				 else begin touch_state<=touch_state;end			
		  end		 
		  default:begin touch_state<=5'd1; end		
		endcase
   end
end	
	 
/***************************/
//I2C通信程序//
/***************************/				
iic_com U1
	 (
	     .CLK( clk ),
		  .RSTn( ~reset ),
		  .Start_Sig( isStart ),              //01 is iic write, 10 is iic read
		  .Addr_Sig( WrAddr ),                
		  .WrData( WrData ),
		  .RdData( RdData ),
		  .Done_Sig( Done_Sig ),
	     .SCL( SCL ),
		  .SDA( SDA )
);                                        



endmodule
