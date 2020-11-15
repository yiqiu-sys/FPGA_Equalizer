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

//==========================================================================
//  Revision History:
//  Date          By            Revision    Change Description
//--------------------------------------------------------------------------
//  2017/7/14    meisq         1.0         Original
//*************************************************************************/

module wav_play(
	input                   clk,
	input                   rst,
	input                   play0,
    input                   enter0,
    input                   modify0,                   //modify time schedule control           
	input                   sd_init_done,             //SD card initialization completed
	output reg              sd_sec_read,                 //SD card sector read
	output reg[31:0]        sd_sec_read_addr,            //SD card sector read address
	input[7:0]              sd_sec_read_data,            //SD card sector read data
	input                   sd_sec_read_data_valid,      //SD card sector read data valid
	input                   sd_sec_read_end,             //SD card sector read end
                input               over,               //scan complete sign
                input               up,                //wav file choose
                input [31:0]        head,              //wav file top location 
                input [31:0]        length,            //wav file length
                input [31:0]        tail,              //wav file buttom location 
                input [6:0]         amount,            //wav file amount
                output reg [6:0]    now,              //wav file current
                output reg          play,             // play or suspend control
                output reg          enter,            //Playback mode control   
	input[15:0]             fifo_wr_cnt,                 //fifo write used words
	output reg              wav_data_wr_en,              //wav audio data write enable
	output reg[7:0]         wav_data,                     //wav audio data
	input [8:0]              min_mod,                     //modify minute 
	input [5:0]              sec_mod,                     //modify second
	output [8:0]             min_now,                     //now minute
	output [5:0]             sec_now,                      //now second
	input  [31:0]            secon                        //Audio length currently 
);

parameter  FIFO_DEPTH     = 1024;
localparam S_IDLE             = 0;
localparam S_PLAY_WAIT  = 1;
localparam S_PLAY            = 2;
localparam S_END             = 3;

localparam SIXTY = 60;
localparam SECTOR = 192000;
localparam SECTOR1= 375;

wire[31:0]        secno;               //Now Time schedule
wire[31:0]        secmo;               //Time schedule modify

wire[31:0]        min_noww;
wire[31:0]        sec_noww;

reg                modify;
reg                modify1,modify2;
wire               modify3;

reg[3:0]         state;               //state machine

reg[31:0]        play_cnt;            //play counter
reg[31:0]        file_len;            //wav file length current

assign min_now=(enter==1'b1)?min_noww[8:0]:9'd0;
assign sec_now=(enter==1'b1)?sec_noww[5:0]:6'd0;
assign secmo=(min_mod*SIXTY+sec_mod>=secon-32'd2)?secon-32'd2:min_mod*SIXTY+sec_mod;

assign modify3=~modify1&modify2;

always @(posedge clk)
begin
modify1<=modify0;
modify2<=modify1;
end

always @(posedge clk)
begin
if(rst==1'b1)
modify<=1'b0;
else if(modify3==1'b1 && enter==1'b1)
modify<=1'b1;
else if(state == S_PLAY_WAIT && modify == 1'b1)
modify<=1'b0;
end



always @(posedge clk)
begin
if(over==1'b0)
now<=7'd0;

else if(up==1'b1&&enter==1'b0)
begin
if(now>=amount-7'd1)
now<=7'd0;
else
now<=now+7'd1;
end

else
now<=now;
end

always @(posedge clk)
begin
if(over==1'b0)
play<=1'b0;
else if(state==S_IDLE)
play<=1'b1;
else if(play0==1'b1)
play<=~play;
end

always @(posedge clk)
begin
if(over==1'b0)
enter<=1'b0;
else if(enter0==1'b1)
enter<=~enter;
end

always@(posedge clk or posedge rst)
begin
	if(rst == 1'b1)
		play_cnt <= 32'd0;
	else if(state == S_PLAY_WAIT && modify == 1'b1)
	begin
	    play_cnt <= secmo*SECTOR-32'd1;
	end
	else if(state == S_PLAY)
	begin
		if(sd_sec_read_data_valid == 1'b1)
			play_cnt <= play_cnt + 32'd1;
	end
	else if(state == S_END)
		play_cnt <= 32'd0;
end

always@(posedge clk or posedge rst)
begin
	if(rst == 1'b1)
	begin
		wav_data_wr_en <= 1'b0;
		wav_data <= 8'd0;
	end
	else if(state == S_PLAY)
	begin
		//wav file header 88 bytes remove
		if(sd_sec_read_data_valid == 1'b1 && play_cnt > 32'd77 && play_cnt < file_len)
			wav_data_wr_en <= 1'b1;
		else
			wav_data_wr_en <= 1'b0;
		wav_data <= sd_sec_read_data;
	end
	else
		wav_data_wr_en <= 1'b0;

end

always@(posedge clk or posedge rst)
begin
	if(rst == 1'b1)
	begin
		state <= S_IDLE;
		sd_sec_read <= 1'b0;
		//search start address
		sd_sec_read_addr <= 32'd8196;
	end 
	else if(sd_init_done == 1'b0)
	begin
		state <= S_IDLE;
	end
	else
		case(state)
			S_IDLE:
			begin
				if(over==1'b1&&enter==1'b1)
					state <= S_PLAY_WAIT;
				sd_sec_read_addr <= head;          //address 8 aligned
                file_len <= length;
			end
			S_PLAY_WAIT:
			begin
				  if(enter==1'b0)
                   state<=S_END;
                  else if(modify==1'b1)
                   sd_sec_read_addr <= head+SECTOR1*secmo;
                  else if(play==1'b0)
                   state<=S_PLAY_WAIT;
                  else if(fifo_wr_cnt <= (FIFO_DEPTH - 512))
					state <= S_PLAY;
			end
			S_PLAY:
			begin
				if(sd_sec_read_end == 1'b1)
				begin
					sd_sec_read_addr <= sd_sec_read_addr + 32'd1;
					sd_sec_read <= 1'b0;
					if(play_cnt >= file_len)
						state <= S_END;
					else
						state <= S_PLAY_WAIT;
				end
				else
				begin
					sd_sec_read <= 1'b1;
				end
			end
			S_END:
				state <= S_IDLE;
			default:
				state <= S_IDLE;
		endcase
end

ChuFa  ChuF1(
.a(play_cnt), 
.b(32'd192000),
.yshang(secno),
.yyushu(),
.Error()
);

ChuFa  ChuF2(
.a(secno), 
.b(32'd60),
.yshang(min_noww),
.yyushu(sec_noww),
.Error()
);

endmodule