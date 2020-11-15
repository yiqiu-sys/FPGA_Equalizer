//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
//                                                                              //
//  Author: meisq                                                               //
//          msq@qq.com                                                          //
//          ALINX(shanghai) Technology Co.,Ltd                                  //
//          heijin                                                              //
//     WEB: http://www.alinx.cn/                                                //
//     BBS: http://www.heijin.org/                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
// Copyright (c) 2017,ALINX(shanghai) Technology Co.,Ltd                        //
//                    All rights reserved                                       //
//                                                                              //
// This source file may be used and distributed without restriction provided    //
// that this copyright statement is not removed from the file and that any      //
// derivative work contains the original copyright notice and the associated    //
// disclaimer.                                                                  //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

//================================================================================
//  Revision History:
//  Date          By            Revision    Change Description
//--------------------------------------------------------------------------------
//2017/8/20                    1.0          Original
//*******************************************************************************/
module button_display(
	input                       rst_n,   
	input                       pclk,
	input                       i_hs,    
	input                       i_vs,    
	input                       i_de,	
	input[23:0]               i_data,
                input                       touch_int,
                input[11:0]               TOUCH1_X2,TOUCH1_Y2,
	output                      o_hs,    
	output                      o_vs,    
	output                      o_de,    
	output[23:0]                o_data
);
wire[11:0] pos_x;
wire[11:0] pos_y;
wire       pos_hs;
wire       pos_vs;
wire       pos_de;
wire[23:0] pos_data;
reg[23:0]  v_data;
reg        region_active0,region_active1,region_active2,region_active3,region_active4,region_active5,region_active6,region_active7,region_active8,region_active9,region_active10,region_active11;
reg        button_active0,button_active1,button_active2,button_active3,button_active4,button_active5,button_active6,button_active7,button_active8,button_active9,button_active10,button_active11;

assign o_data = v_data;
assign o_hs = pos_hs;
assign o_vs = pos_vs;
assign o_de = pos_de;
always@(posedge pclk)
begin
	if(TOUCH1_Y2 >= 12'd160 && TOUCH1_Y2 <= 12'd220 && TOUCH1_X2 >= 12'd480 && TOUCH1_X2  <= 12'd565 && touch_int==1'b0)	
		button_active0 <= 1'b1;
	else
		button_active0 <= 1'b0;
                if(TOUCH1_Y2 >= 12'd160 && TOUCH1_Y2 <= 12'd220 && TOUCH1_X2 >= 12'd586 && TOUCH1_X2  <= 12'd671 && touch_int==1'b0)	
		button_active1 <= 1'b1;
	else
		button_active1 <= 1'b0;
               if(TOUCH1_Y2 >= 12'd160 && TOUCH1_Y2 <= 12'd220 && TOUCH1_X2 >= 12'd693 && TOUCH1_X2  <= 12'd778 && touch_int==1'b0)	
		button_active2 <= 1'b1;
	else
		button_active2 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd240 && TOUCH1_Y2 <= 12'd300 && TOUCH1_X2 >= 12'd480 && TOUCH1_X2  <= 12'd565 && touch_int==1'b0)	
		button_active3 <= 1'b1;
	else
		button_active3 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd240 && TOUCH1_Y2 <= 12'd300 && TOUCH1_X2 >= 12'd586 && TOUCH1_X2  <= 12'd671 && touch_int==1'b0)	
		button_active4 <= 1'b1;
	else
		button_active4 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd240 && TOUCH1_Y2 <= 12'd300 && TOUCH1_X2 >= 12'd693 && TOUCH1_X2  <= 12'd778 && touch_int==1'b0)	
		button_active5 <= 1'b1;
	else
		button_active5 <= 1'b0;		
              if(TOUCH1_Y2 >= 12'd320 && TOUCH1_Y2 <= 12'd380 && TOUCH1_X2 >= 12'd480 && TOUCH1_X2  <= 12'd565 && touch_int==1'b0)	
		button_active6 <= 1'b1;
	else
		button_active6 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd320 && TOUCH1_Y2 <= 12'd380 && TOUCH1_X2 >= 12'd586 && TOUCH1_X2  <= 12'd671 && touch_int==1'b0)	
		button_active7 <= 1'b1;
	else
		button_active7 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd320 && TOUCH1_Y2 <= 12'd380 && TOUCH1_X2 >= 12'd693 && TOUCH1_X2  <= 12'd778 && touch_int==1'b0)	
		button_active8 <= 1'b1;
	else
		button_active8 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd400 && TOUCH1_Y2 <= 12'd460 && TOUCH1_X2 >= 12'd480 && TOUCH1_X2  <= 12'd565 && touch_int==1'b0)	
		button_active9 <= 1'b1;
	else
		button_active9 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd400 && TOUCH1_Y2 <= 12'd460 && TOUCH1_X2 >= 12'd586 && TOUCH1_X2  <= 12'd671 && touch_int==1'b0)	
		button_active10 <= 1'b1;
	else
		button_active10 <= 1'b0;
              if(TOUCH1_Y2 >= 12'd400 && TOUCH1_Y2 <= 12'd460 && TOUCH1_X2 >= 12'd693 && TOUCH1_X2  <= 12'd778 && touch_int==1'b0)	
		button_active11 <= 1'b1;
	else
		button_active11 <= 1'b0;				
end

always@(posedge pclk)
begin
	if(pos_y >= 12'd160 && pos_y <= 12'd220 && pos_x >= 12'd480 && pos_x  <= 12'd565)	
		region_active0 <= 1'b1;
	else
		region_active0 <= 1'b0;
                if(pos_y >= 12'd160 && pos_y <= 12'd220 && pos_x >= 12'd586 && pos_x  <= 12'd671)	
		region_active1 <= 1'b1;
	else
		region_active1 <= 1'b0;
               if(pos_y >= 12'd160 && pos_y <= 12'd220 && pos_x >= 12'd693 && pos_x  <= 12'd778)	
		region_active2 <= 1'b1;
	else
		region_active2 <= 1'b0;
	if(pos_y >= 12'd240 && pos_y <= 12'd300 && pos_x >= 12'd480 && pos_x  <= 12'd565)	
		region_active3 <= 1'b1;
	else
		region_active3 <= 1'b0;
                if(pos_y >= 12'd240 && pos_y <= 12'd300 && pos_x >= 12'd586 && pos_x  <= 12'd671)	
		region_active4 <= 1'b1;
	else
		region_active4 <= 1'b0;
               if(pos_y >= 12'd240 && pos_y <= 12'd300 && pos_x >= 12'd693 && pos_x  <= 12'd778)	
		region_active5 <= 1'b1;
	else
		region_active5 <= 1'b0;
	if(pos_y >= 12'd320 && pos_y <= 12'd380 && pos_x >= 12'd480 && pos_x  <= 12'd565)	
		region_active6 <= 1'b1;
	else
		region_active6 <= 1'b0;
                if(pos_y >= 12'd320 && pos_y <= 12'd380 && pos_x >= 12'd586 && pos_x  <= 12'd671)	
		region_active7 <= 1'b1;
	else
		region_active7 <= 1'b0;
               if(pos_y >= 12'd320 && pos_y <= 12'd380 && pos_x >= 12'd693 && pos_x  <= 12'd778)	
		region_active8 <= 1'b1;
	else
		region_active8 <= 1'b0;
	if(pos_y >= 12'd400 && pos_y <= 12'd460 && pos_x >= 12'd480 && pos_x  <= 12'd565)	
		region_active9 <= 1'b1;
	else
		region_active9 <= 1'b0;
                if(pos_y >= 12'd400 && pos_y <= 12'd460 && pos_x >= 12'd586 && pos_x  <= 12'd671)	
		region_active10 <= 1'b1;
	else
		region_active10 <= 1'b0;
               if(pos_y >= 12'd400 && pos_y <= 12'd460 && pos_x >= 12'd693 && pos_x  <= 12'd778)	
		region_active11 <= 1'b1;
	else
		region_active11 <= 1'b0;		
end

always@(posedge pclk)
begin
	v_data <= pos_data;

	if(region_active0 == 1'b1)
                                begin
		if(button_active0 == 1'b0)
			v_data <= {8'hff,8'hff,8'h00};
		else
			v_data <= {8'hff,8'h00,8'hff};
                                end
	if(region_active1 == 1'b1)
                                begin
		if(button_active1 == 1'b0)
			v_data <= {8'hff,8'hff,8'h00};
		else
			v_data <= {8'hff,8'h00,8'hff};
                                end
	if(region_active2 == 1'b1)
                                begin
		if(button_active2 == 1'b0)
			v_data <= {8'hff,8'hff,8'h00};
		else
			v_data <= {8'hff,8'h00,8'hff};
                                end
	if(region_active3 == 1'b1)
                                begin
		if(button_active3 == 1'b0)
			v_data <= {8'hff,8'hff,8'h00};
		else
			v_data <= {8'hff,8'h00,8'hff};
                                end
	if(region_active4 == 1'b1)
                                begin
		if(button_active4 == 1'b0)
			v_data <= {8'hff,8'hff,8'h00};
		else
			v_data <= {8'hff,8'h00,8'hff};
                                end
	if(region_active5 == 1'b1)
                                begin
		if(button_active5 == 1'b0)
			v_data <= {8'hff,8'hff,8'h00};
		else
			v_data <= {8'hff,8'h00,8'hff};
                                end    
	if(region_active6 == 1'b1)
                                begin
		if(button_active6 == 1'b0)
			v_data <= {8'hff,8'hff,8'h00};
		else
			v_data <= {8'hff,8'h00,8'hff};
                                end
	if(region_active7 == 1'b1)
                                begin
		if(button_active7 == 1'b0)
			v_data <= {8'hff,8'hff,8'h00};
		else
			v_data <= {8'hff,8'h00,8'hff};
                                end
	if(region_active8 == 1'b1)
                                begin
		if(button_active8 == 1'b0)
			v_data <= {8'hff,8'hff,8'h00};
		else
			v_data <= {8'hff,8'h00,8'hff};
                                end
	if(region_active9 == 1'b1)
                                begin
		if(button_active9 == 1'b0)
			v_data <= {8'hff,8'hff,8'h00};
		else
			v_data <= {8'hff,8'h00,8'hff};
                                end
	if(region_active10 == 1'b1)
                                begin
		if(button_active10 == 1'b0)
			v_data <= {8'hff,8'hff,8'h00};
		else
			v_data <= {8'hff,8'h00,8'hff};
                                end
	if(region_active11 == 1'b1)
                                begin
		if(button_active11 == 1'b0)
			v_data <= {8'hff,8'hff,8'h00};
		else
			v_data <= {8'hff,8'h00,8'hff};
                                end                                                             

end

timing_gen_xy_1 timing_gen_xy_m0(
	.rst_n    (rst_n    ),
	.clk      (pclk     ),
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