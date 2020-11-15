`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/12 20:11:55
// Design Name: 
// Module Name: fliter_slider
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


module fliter_slider(
	 input                   pclk,
	 input                   video_clk,
	 input                   rst_n,
	 
	 input                    touch_int,
	 input  [11:0]            TOUCH1_X2,
     input  [11:0]            TOUCH1_Y2,
	
	 input                    i_hs,    
	 input                    i_vs,    
	 input                    i_de,	
	 input[23:0]              i_data,
	 
	 output                   o_hs,    
	 output                   o_vs,    
	 output                   o_de,    
	 output[23:0]             o_data,
	
     input                    update,
     
     output reg [2:0]         gain_one, 
     output reg [2:0]         gain_two,
     output reg [2:0]         gain_thr, 
     output reg [2:0]         gain_fou, 
     output reg [2:0]         gain_fiv, 
     output reg [2:0]         gain_six              
	
    );
    
wire[11:0] pos_x;
wire[11:0] pos_y;
wire       pos_hs;
wire       pos_vs;
wire       pos_de;
wire[23:0] pos_data;
reg[23:0]  v_data;

reg        region_active0,region_active1,region_active2,region_active3,region_active4,region_active5;

assign o_data = v_data;
assign o_hs = pos_hs;
assign o_vs = pos_vs;
assign o_de = pos_de;

always@(posedge video_clk)
begin
	            if(pos_y >= 12'd290 && pos_y <= 12'd430 && pos_x >= 12'd275 && pos_x  <= 12'd375)	
		region_active0 <= 1'b1;
	else
		region_active0 <= 1'b0;
                if(pos_y >= 12'd290 && pos_y <= 12'd430 && pos_x >= 12'd150 && pos_x  <= 12'd250)	
		region_active1 <= 1'b1;
	else
		region_active1 <= 1'b0;
                if(pos_y >= 12'd290 && pos_y <= 12'd430 && pos_x >= 12'd25 && pos_x  <= 12'd125)	
		region_active2 <= 1'b1;
	else
		region_active2 <= 1'b0;
               if(pos_y >= 12'd50 && pos_y <= 12'd190 && pos_x >= 12'd275 && pos_x  <= 12'd375)	
		region_active3 <= 1'b1;
	else
		region_active3 <= 1'b0;
               if(pos_y >= 12'd50 && pos_y <= 12'd190 && pos_x >= 12'd150 && pos_x  <= 12'd250)	
		region_active4 <= 1'b1;
	else
		region_active4 <= 1'b0;
               if(pos_y >= 12'd50 && pos_y <= 12'd190 && pos_x >= 12'd25 && pos_x  <= 12'd125)	
		region_active5 <= 1'b1;
	else
		region_active5 <= 1'b0;
end

always @(posedge pclk)
  begin
  if(rst_n==1'b0)
        gain_six <= 3'd3;
	else if(TOUCH1_Y2 >= 12'd50 && TOUCH1_Y2 <= 12'd70 && TOUCH1_X2 >= 12'd25 && TOUCH1_X2  <= 12'd125 && update==1'b1)	
		gain_six <= 3'd0;
    else if(TOUCH1_Y2 >= 12'd70 && TOUCH1_Y2 <= 12'd90 && TOUCH1_X2 >= 12'd25 && TOUCH1_X2  <= 12'd125 && update==1'b1)	
		gain_six <= 3'd1;
    else if(TOUCH1_Y2 >= 12'd90 && TOUCH1_Y2 <= 12'd110 && TOUCH1_X2 >= 12'd25 && TOUCH1_X2  <= 12'd125 && update==1'b1)	
		gain_six <= 3'd2;
    else if(TOUCH1_Y2 >= 12'd110 && TOUCH1_Y2 <= 12'd130 && TOUCH1_X2 >= 12'd25 && TOUCH1_X2  <= 12'd125 && update==1'b1)	
		gain_six <= 3'd3;
    else if(TOUCH1_Y2 >= 12'd130 && TOUCH1_Y2 <= 12'd150 && TOUCH1_X2 >= 12'd25 && TOUCH1_X2  <= 12'd125 && update==1'b1)	
		gain_six <= 3'd4;
    else if(TOUCH1_Y2 >= 12'd150 && TOUCH1_Y2 <= 12'd170 && TOUCH1_X2 >= 12'd25 && TOUCH1_X2  <= 12'd125 && update==1'b1)	
		gain_six <= 3'd5;
    else if(TOUCH1_Y2 >= 12'd170 && TOUCH1_Y2 <= 12'd190 && TOUCH1_X2 >= 12'd25 && TOUCH1_X2  <= 12'd125 && update==1'b1)	
		gain_six <= 3'd6;
	else
	    gain_six <= gain_six;

  end
  
  always @(posedge pclk)
  begin
  if(rst_n==1'b0)
        gain_thr <= 3'd3;
	else if(TOUCH1_Y2 >= 12'd290 && TOUCH1_Y2 <= 12'd310 && TOUCH1_X2 >= 12'd25 && TOUCH1_X2  <= 12'd125 && update==1'b1)	
		gain_thr <= 3'd0;
    else if(TOUCH1_Y2 >= 12'd310 && TOUCH1_Y2 <= 12'd330 && TOUCH1_X2 >= 12'd25 && TOUCH1_X2  <= 12'd125 && update==1'b1)	
		gain_thr <= 3'd1;
    else if(TOUCH1_Y2 >= 12'd330 && TOUCH1_Y2 <= 12'd350 && TOUCH1_X2 >= 12'd25 && TOUCH1_X2  <= 12'd125 && update==1'b1)	
		gain_thr <= 3'd2;
    else if(TOUCH1_Y2 >= 12'd350 && TOUCH1_Y2 <= 12'd370 && TOUCH1_X2 >= 12'd25 && TOUCH1_X2  <= 12'd125 && update==1'b1)	
		gain_thr <= 3'd3;
    else if(TOUCH1_Y2 >= 12'd370 && TOUCH1_Y2 <= 12'd390 && TOUCH1_X2 >= 12'd25 && TOUCH1_X2  <= 12'd125 && update==1'b1)	
		gain_thr <= 3'd4;
    else if(TOUCH1_Y2 >= 12'd390 && TOUCH1_Y2 <= 12'd410 && TOUCH1_X2 >= 12'd25 && TOUCH1_X2  <= 12'd125 && update==1'b1)	
		gain_thr <= 3'd5;
    else if(TOUCH1_Y2 >= 12'd410 && TOUCH1_Y2 <= 12'd430 && TOUCH1_X2 >= 12'd25 && TOUCH1_X2  <= 12'd125 && update==1'b1)	
		gain_thr <= 3'd6;
	else
	    gain_thr <= gain_thr;

  end
  
  always @(posedge pclk)
  begin
  if(rst_n==1'b0)
        gain_two <= 3'd3;
	else if(TOUCH1_Y2 >= 12'd290 && TOUCH1_Y2 <= 12'd310 && TOUCH1_X2 >= 12'd150 && TOUCH1_X2  <= 12'd250 && update==1'b1)	
		gain_two <= 3'd0;
    else if(TOUCH1_Y2 >= 12'd310 && TOUCH1_Y2 <= 12'd330 && TOUCH1_X2 >= 12'd150 && TOUCH1_X2  <= 12'd250 && update==1'b1)	
		gain_two <= 3'd1;
    else if(TOUCH1_Y2 >= 12'd330 && TOUCH1_Y2 <= 12'd350 && TOUCH1_X2 >= 12'd150 && TOUCH1_X2  <= 12'd250 && update==1'b1)	
		gain_two <= 3'd2;
    else if(TOUCH1_Y2 >= 12'd350 && TOUCH1_Y2 <= 12'd370 && TOUCH1_X2 >= 12'd150 && TOUCH1_X2  <= 12'd250 && update==1'b1)	
		gain_two <= 3'd3;
    else if(TOUCH1_Y2 >= 12'd370 && TOUCH1_Y2 <= 12'd390 && TOUCH1_X2 >= 12'd150 && TOUCH1_X2  <= 12'd250 && update==1'b1)	
		gain_two <= 3'd4;
    else if(TOUCH1_Y2 >= 12'd390 && TOUCH1_Y2 <= 12'd410 && TOUCH1_X2 >= 12'd150 && TOUCH1_X2  <= 12'd250 && update==1'b1)	
		gain_two <= 3'd5;
    else if(TOUCH1_Y2 >= 12'd410 && TOUCH1_Y2 <= 12'd430 && TOUCH1_X2 >= 12'd150 && TOUCH1_X2  <= 12'd250 && update==1'b1)	
		gain_two <= 3'd6;
	else
	    gain_two <= gain_two;

  end
  
  always @(posedge pclk)
  begin
  if(rst_n==1'b0)
        gain_fiv <= 3'd3;
	else if(TOUCH1_Y2 >= 12'd50 && TOUCH1_Y2 <= 12'd70 && TOUCH1_X2 >= 12'd150 && TOUCH1_X2  <= 12'd250 && update==1'b1)	
		gain_fiv <= 3'd0;
    else if(TOUCH1_Y2 >= 12'd70 && TOUCH1_Y2 <= 12'd90 && TOUCH1_X2 >= 12'd150 && TOUCH1_X2  <= 12'd250 && update==1'b1)	
		gain_fiv <= 3'd1;
    else if(TOUCH1_Y2 >= 12'd90 && TOUCH1_Y2 <= 12'd110 && TOUCH1_X2 >= 12'd150 && TOUCH1_X2  <= 12'd250 && update==1'b1)	
		gain_fiv <= 3'd2;
    else if(TOUCH1_Y2 >= 12'd110 && TOUCH1_Y2 <= 12'd130 && TOUCH1_X2 >= 12'd150 && TOUCH1_X2  <= 12'd250 && update==1'b1)	
		gain_fiv <= 3'd3;
    else if(TOUCH1_Y2 >= 12'd130 && TOUCH1_Y2 <= 12'd150 && TOUCH1_X2 >= 12'd150 && TOUCH1_X2  <= 12'd250 && update==1'b1)	
		gain_fiv <= 3'd4;
    else if(TOUCH1_Y2 >= 12'd150 && TOUCH1_Y2 <= 12'd170 && TOUCH1_X2 >= 12'd150 && TOUCH1_X2  <= 12'd250 && update==1'b1)	
		gain_fiv <= 3'd5;
    else if(TOUCH1_Y2 >= 12'd170 && TOUCH1_Y2 <= 12'd190 && TOUCH1_X2 >= 12'd150 && TOUCH1_X2  <= 12'd250 && update==1'b1)	
		gain_fiv <= 3'd6;
	else
	    gain_fiv <= gain_fiv;

  end
  
always @(posedge pclk)
  begin
  if(rst_n==1'b0)
        gain_fou <= 3'd3;
	else if(TOUCH1_Y2 >= 12'd50 && TOUCH1_Y2 <= 12'd70 && TOUCH1_X2 >= 12'd275 && TOUCH1_X2  <= 12'd375 && update==1'b1)	
		gain_fou <= 3'd0;
    else if(TOUCH1_Y2 >= 12'd70 && TOUCH1_Y2 <= 12'd90 && TOUCH1_X2 >= 12'd275 && TOUCH1_X2  <= 12'd375 && update==1'b1)	
		gain_fou <= 3'd1;
    else if(TOUCH1_Y2 >= 12'd90 && TOUCH1_Y2 <= 12'd110 && TOUCH1_X2 >= 12'd275 && TOUCH1_X2  <= 12'd375 && update==1'b1)	
		gain_fou <= 3'd2;
    else if(TOUCH1_Y2 >= 12'd110 && TOUCH1_Y2 <= 12'd130 && TOUCH1_X2 >= 12'd275 && TOUCH1_X2  <= 12'd375 && update==1'b1)	
		gain_fou <= 3'd3;
    else if(TOUCH1_Y2 >= 12'd130 && TOUCH1_Y2 <= 12'd150 && TOUCH1_X2 >= 12'd275 && TOUCH1_X2  <= 12'd375 && update==1'b1)	
		gain_fou <= 3'd4;
    else if(TOUCH1_Y2 >= 12'd150 && TOUCH1_Y2 <= 12'd170 && TOUCH1_X2 >= 12'd275 && TOUCH1_X2  <= 12'd375 && update==1'b1)	
		gain_fou <= 3'd5;
    else if(TOUCH1_Y2 >= 12'd170 && TOUCH1_Y2 <= 12'd190 && TOUCH1_X2 >= 12'd275 && TOUCH1_X2  <= 12'd375 && update==1'b1)	
		gain_fou <= 3'd6;
	else
	    gain_fou <= gain_fou;

  end
  
always @(posedge pclk)
  begin
  if(rst_n==1'b0)
        gain_one <= 3'd3;
	else if(TOUCH1_Y2 >= 12'd290 && TOUCH1_Y2 <= 12'd310 && TOUCH1_X2 >= 12'd275 && TOUCH1_X2  <= 12'd375 && update==1'b1)	
		gain_one <= 3'd0;
    else if(TOUCH1_Y2 >= 12'd310 && TOUCH1_Y2 <= 12'd330 && TOUCH1_X2 >= 12'd275 && TOUCH1_X2  <= 12'd375 && update==1'b1)	
		gain_one <= 3'd1;
    else if(TOUCH1_Y2 >= 12'd330 && TOUCH1_Y2 <= 12'd350 && TOUCH1_X2 >= 12'd275 && TOUCH1_X2  <= 12'd375 && update==1'b1)	
		gain_one <= 3'd2;
    else if(TOUCH1_Y2 >= 12'd350 && TOUCH1_Y2 <= 12'd370 && TOUCH1_X2 >= 12'd275 && TOUCH1_X2  <= 12'd375 && update==1'b1)	
		gain_one <= 3'd3;
    else if(TOUCH1_Y2 >= 12'd370 && TOUCH1_Y2 <= 12'd390 && TOUCH1_X2 >= 12'd275 && TOUCH1_X2  <= 12'd375 && update==1'b1)	
		gain_one <= 3'd4;
    else if(TOUCH1_Y2 >= 12'd390 && TOUCH1_Y2 <= 12'd410 && TOUCH1_X2 >= 12'd275 && TOUCH1_X2  <= 12'd375 && update==1'b1)	
		gain_one <= 3'd5;
    else if(TOUCH1_Y2 >= 12'd410 && TOUCH1_Y2 <= 12'd430 && TOUCH1_X2 >= 12'd275 && TOUCH1_X2  <= 12'd375 && update==1'b1)	
		gain_one <= 3'd6;
	else
	    gain_one <= gain_one;

  end
  
always @(posedge video_clk)
  begin
  
  if(region_active0==1'b1)
   begin
    if(gain_one==3'd0)
    begin
    if(pos_y >= 12'd290 && pos_y <= 12'd310 && pos_x >= 12'd275 && pos_x <= 12'd375)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_one==3'd1)
    begin
    if(pos_y >= 12'd310 && pos_y <= 12'd330 && pos_x >= 12'd275 && pos_x <= 12'd375)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_one==3'd2)
    begin
    if(pos_y >= 12'd330 && pos_y <= 12'd350 && pos_x >= 12'd275 && pos_x <= 12'd375)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end  
    else if(gain_one==3'd3)
    begin
    if(pos_y >= 12'd350 && pos_y <= 12'd370 && pos_x >= 12'd275 && pos_x <= 12'd375)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end   
    else if(gain_one==3'd4)
    begin
    if(pos_y >= 12'd370 && pos_y <= 12'd390 && pos_x >= 12'd275 && pos_x <= 12'd375)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end   
    else if(gain_one==3'd5)
    begin
    if(pos_y >= 12'd390 && pos_y <= 12'd410 && pos_x >= 12'd275 && pos_x <= 12'd375)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_one==3'd6)
    begin
    if(pos_y >= 12'd410 && pos_y <= 12'd430 && pos_x >= 12'd275 && pos_x <= 12'd375)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else
    v_data<=pos_data;      
   end
 
  else if(region_active3==1'b1)
   begin
    if(gain_fou==3'd0)
    begin
    if(pos_y >= 12'd50 && pos_y <= 12'd70 && pos_x >= 12'd275 && pos_x <= 12'd375)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_fou==3'd1)
    begin
    if(pos_y >= 12'd70 && pos_y <= 12'd90 && pos_x >= 12'd275 && pos_x <= 12'd375)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_fou==3'd2)
    begin
    if(pos_y >= 12'd90 && pos_y <= 12'd110 && pos_x >= 12'd275 && pos_x <= 12'd375)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end  
    else if(gain_fou==3'd3)
    begin
    if(pos_y >= 12'd110 && pos_y <= 12'd130 && pos_x >= 12'd275 && pos_x <= 12'd375)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end   
    else if(gain_fou==3'd4)
    begin
    if(pos_y >= 12'd130 && pos_y <= 12'd150 && pos_x >= 12'd275 && pos_x <= 12'd375)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end   
    else if(gain_fou==3'd5)
    begin
    if(pos_y >= 12'd150 && pos_y <= 12'd170 && pos_x >= 12'd275 && pos_x <= 12'd375)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_fou==3'd6)
    begin
    if(pos_y >= 12'd170 && pos_y <= 12'd190 && pos_x >= 12'd275 && pos_x <= 12'd375)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else
    v_data<=pos_data;      
   end
   
  else if(region_active4==1'b1)
   begin
    if(gain_fiv==3'd0)
    begin
    if(pos_y >= 12'd50 && pos_y <= 12'd70 && pos_x >= 12'd150 && pos_x <= 12'd250)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_fiv==3'd1)
    begin
    if(pos_y >= 12'd70 && pos_y <= 12'd90 && pos_x >= 12'd150 && pos_x <= 12'd250)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_fiv==3'd2)
    begin
    if(pos_y >= 12'd90 && pos_y <= 12'd110 && pos_x >= 12'd150 && pos_x <= 12'd250)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end  
    else if(gain_fiv==3'd3)
    begin
    if(pos_y >= 12'd110 && pos_y <= 12'd130 && pos_x >= 12'd150 && pos_x <= 12'd250)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end   
    else if(gain_fiv==3'd4)
    begin
    if(pos_y >= 12'd130 && pos_y <= 12'd150 && pos_x >= 12'd150 && pos_x <= 12'd250)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end   
    else if(gain_fiv==3'd5)
    begin
    if(pos_y >= 12'd150 && pos_y <= 12'd170 && pos_x >= 12'd150 && pos_x <= 12'd250)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_fiv==3'd6)
    begin
    if(pos_y >= 12'd170 && pos_y <= 12'd190 && pos_x >= 12'd150 && pos_x <= 12'd250)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else
    v_data<=pos_data;      
   end
   
  else if(region_active5==1'b1)
   begin
    if(gain_six==3'd0)
    begin
    if(pos_y >= 12'd50 && pos_y <= 12'd70 && pos_x >= 12'd25 && pos_x <= 12'd125)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_six==3'd1)
    begin
    if(pos_y >= 12'd70 && pos_y <= 12'd90 && pos_x >= 12'd25 && pos_x <= 12'd125)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_six==3'd2)
    begin
    if(pos_y >= 12'd90 && pos_y <= 12'd110 && pos_x >= 12'd25 && pos_x <= 12'd125)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end  
    else if(gain_six==3'd3)
    begin
    if(pos_y >= 12'd110 && pos_y <= 12'd130 && pos_x >= 12'd25 && pos_x <= 12'd125)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end   
    else if(gain_six==3'd4)
    begin
    if(pos_y >= 12'd130 && pos_y <= 12'd150 && pos_x >= 12'd25 && pos_x <= 12'd125)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end   
    else if(gain_six==3'd5)
    begin
    if(pos_y >= 12'd150 && pos_y <= 12'd170 && pos_x >= 12'd25 && pos_x <= 12'd125)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_six==3'd6)
    begin
    if(pos_y >= 12'd170 && pos_y <= 12'd190 && pos_x >= 12'd25 && pos_x <= 12'd125)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else
    v_data<=pos_data;      
   end  
   
  else if(region_active1==1'b1)
   begin
    if(gain_two==3'd0)
    begin
    if(pos_y >= 12'd290 && pos_y <= 12'd310 && pos_x >= 12'd150 && pos_x <= 12'd250)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_two==3'd1)
    begin
    if(pos_y >= 12'd310 && pos_y <= 12'd330 && pos_x >= 12'd150 && pos_x <= 12'd250)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_two==3'd2)
    begin
    if(pos_y >= 12'd330 && pos_y <= 12'd350 && pos_x >= 12'd150 && pos_x <= 12'd250)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end  
    else if(gain_two==3'd3)
    begin
    if(pos_y >= 12'd350 && pos_y <= 12'd370 && pos_x >= 12'd150 && pos_x <= 12'd250)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end   
    else if(gain_two==3'd4)
    begin
    if(pos_y >= 12'd370 && pos_y <= 12'd390 && pos_x >= 12'd150 && pos_x <= 12'd250)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end   
    else if(gain_two==3'd5)
    begin
    if(pos_y >= 12'd390 && pos_y <= 12'd410 && pos_x >= 12'd150 && pos_x <= 12'd250)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_two==3'd6)
    begin
    if(pos_y >= 12'd410 && pos_y <= 12'd430 && pos_x >= 12'd150 && pos_x <= 12'd250)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else
    v_data<=pos_data;      
   end 
   
  else if(region_active2==1'b1)
   begin
    if(gain_thr==3'd0)
    begin
    if(pos_y >= 12'd290 && pos_y <= 12'd310 && pos_x >= 12'd25 && pos_x <= 12'd125)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_thr==3'd1)
    begin
    if(pos_y >= 12'd310 && pos_y <= 12'd330 && pos_x >= 12'd25 && pos_x <= 12'd125)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_thr==3'd2)
    begin
    if(pos_y >= 12'd330 && pos_y <= 12'd350 && pos_x >= 12'd25 && pos_x <= 12'd125)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end  
    else if(gain_thr==3'd3)
    begin
    if(pos_y >= 12'd350 && pos_y <= 12'd370 && pos_x >= 12'd25 && pos_x <= 12'd125)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end   
    else if(gain_thr==3'd4)
    begin
    if(pos_y >= 12'd370 && pos_y <= 12'd390 && pos_x >= 12'd25 && pos_x <= 12'd125)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end   
    else if(gain_thr==3'd5)
    begin
    if(pos_y >= 12'd390 && pos_y <= 12'd410 && pos_x >= 12'd25 && pos_x <= 12'd125)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else if(gain_thr==3'd6)
    begin
    if(pos_y >= 12'd410 && pos_y <= 12'd430 && pos_x >= 12'd25 && pos_x <= 12'd125)
    v_data<=24'h000000;
    else
    v_data<=pos_data;
    end
    else
    v_data<=pos_data;      
   end
   
   else
   v_data<=pos_data;    
   
  end


    
    

timing_gen_xy_1 timing_gen_xy_m0(
	.rst_n    (rst_n    ),
	.clk      (video_clk),
	.i_hs     (i_hs     ),
	.i_vs     (i_vs     ),
	.i_de     (i_de     ),
	.i_data   (i_data   ),
	.o_hs     (pos_hs   ),
	.o_vs     (pos_vs   ),
	.o_de     (pos_de   ),
	.o_data   (pos_data ),
	.x        (pos_x    ),
	.y        (pos_y    )
);
    
endmodule
