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
//  2017/6/21    meisq         1.0         Original
//*************************************************************************/
module sd_card_audio(
input                       clk,
input                       rst_n,
input [3:0]                 key1,
output[3:0]                 state_code,
input                       bclk,                         //audio bit clock
input                       daclrc,                       //DAC sample rate left right clock
output                      dacdat,                       //DAC audio data output 
input                       adclrc,                       //ADC sample rate left right clock
input                       adcdat,                       //ADC audio data input
output                      sd_ncs,                       //SD card chip select (SPI mode)  
output                      sd_dclk,                      //SD card clock
output                      sd_mosi,                      //SD card controller data output
input                       sd_miso,                       //SD card controller data input
output[6:0]                 amount,                         //wav file amount
output                      over,                           //scan complete sign
output[6:0]                 now,                             //wav file current 
output                      read_data_en,                  //fifo read enable
output                      rdempty,                       //fifo read empty
output[31:0]                tx_left_data,                //left channel audio data
output[31:0]                tx_right_data,               //right channel audio data
output [8:0]                min_now,                     //now minute
output [5:0]                sec_now,                     //now second
output[8:0]                 minute_n,                                    //Audio minute length currently
output[5:0]                 second_n,                                    //Audio second length currently
input [8:0]                 min_mod,                     //modify minute 
input [5:0]                 sec_mod,                     //modify second
input                       modify,                      //modify time schedule control 

output                      sd_sec_read_copy,

input [2:0]                 gain_one, 
input [2:0]                 gain_two,
input [2:0]                 gain_thr, 
input [2:0]                 gain_fou, 
input [2:0]                 gain_fiv, 
input [2:0]                 gain_six                                
);

   
reg                         sd_sec_read;                 //SD card sector read
reg [31:0]                  sd_sec_read_addr;            //SD card sector read address
wire[7:0]                   sd_sec_read_data;            //SD card sector read data
wire                        sd_sec_read_data_valid;      //SD card sector read data valid
wire                        sd_sec_read_end;             //SD card sector read end
wire                        wav_data_wr_en;              //wav audio data write enable
wire[7:0]                   wav_data;                    //wav audio data
wire[15:0]                  wrusedw;                     //fifo write Used Words
wire[31:0]                  read_data;                   //fifo read data
wire                        sd_init_done;                //SD card initialization completed

wire                        find,enter,up,play;               //one clock cycle ,record button down 

wire  [31:0]                sd_sec_read_addr_play,sd_sec_read_addr_scan;            //two module SD card sector read address
//wire                        over;                                                   //scan complete sign
//wire [6:0]                 amount;                                                 //wav file amount
wire                        sd_sec_read_scan ,sd_sec_read_play;
wire [31:0]                 head;                                         //wav file top location currently
wire [31:0]                 length;                                      //wav file length
wire [31:0]                 tail;                                        //wav file buttom location
//wire [6:0]                  now;                                         //wav file current 
wire                        play_n,enter_n;
wire[31:0]                  aulength;                                    //Audio data length currently

wire[31:0]                  secon;
wire                        filter_clk;                                  // filter data update clock

wire[31:0]                rd_left_data;                // initial left channel audio data
wire[31:0]                rd_right_data;               // initial right channel audio data

wire[31:0]                txx_left_data;                // initial left channel audio data
wire[31:0]                txx_right_data;               // initial right channel audio data

wire                      left_sign;
wire                      right_sign;

assign tx_left_data = txx_left_data;
assign tx_right_data = txx_right_data;

assign left_sign=read_data[23];
assign right_sign=read_data[7];

assign rd_left_data = {{16{left_sign}},read_data[23:16],read_data[31:24]};
assign rd_right_data = {{16{right_sign}},read_data[7:0],read_data[15:8]};
assign filter_clk=read_data_en & ~rdempty;

assign sd_sec_read_copy=sd_sec_read;

always @(*)
begin
if(enter_n==1'b0&&over==1'b0)
begin
sd_sec_read_addr=sd_sec_read_addr_scan;
sd_sec_read=sd_sec_read_scan;
end
else if(enter_n==1'b0&&over==1'b1)
begin
sd_sec_read_addr=sd_sec_read_addr_play;
sd_sec_read=sd_sec_read_play;
end
else if(enter_n==1'b1&&over==1'b1)
begin
sd_sec_read_addr=sd_sec_read_addr_play;
sd_sec_read=sd_sec_read_play;
end
else
begin
sd_sec_read_addr=32'd8196;
sd_sec_read=1'b0;
end
end

/*************************************************************************
Only one pulse is generated when a key is pressed to meet requirements
****************************************************************************/
ax_debounce#(.FREQ(50)) ax_debounce_m0
(
.clk                       (clk                        ),
.rst                       (~rst_n                     ),
.button_in                 (key1                       ),
.button_posedge            (                           ),
.button_negedge            ({find,enter,play,up}       ),
.button_out                (                           )
);
/*************************************************************************
Instantiate audio player module
****************************************************************************/
audio_tx audio_tx_m0
(
.rst                       (~rst_n                     ),        
.clk                       (clk                        ),
.sck_bclk                  (bclk                       ),
.ws_lrc                    (adclrc                     ),
.sdata                     (dacdat                     ),
.left_data                 (tx_left_data               ),
.right_data                (tx_right_data              ),
.read_data_en              (read_data_en               )
);
/*************************************************************************
Instantiate fifo
****************************************************************************/
afifo_8i_32o_1024 audio_buf
(
.rd_clk                    (clk                        ),          // Read side clock
.wr_clk                    (clk                        ),          // Write side clock
.rst                       (1'b0                       ),          // Asynchronous clear
.wr_en                     (wav_data_wr_en             ),          // Write Request
.rd_en                     (read_data_en & ~rdempty    ),          // Read Request
.din                       (wav_data                   ),          // Input Data
.empty                     (rdempty                    ),          // Read side Empty flag
.full                      (                           ),          // Write side Full flag
.rd_data_count             (                           ),          // Read Used Words
.wr_data_count             (wrusedw[9:0]               ),          // Write Used Words
.dout                      (read_data                  )
);
/*************************************************************************
Find and read audio files
****************************************************************************/
wav_scan wav_scan_m0(
.clk                        (clk                           ),
.rst                        (~rst_n                        ),
.find                       (find                          ),
.sd_init_done               (sd_init_done                  ),
.state_code                 (state_code                    ),
.sd_sec_read                (sd_sec_read_scan              ),
.sd_sec_read_addr           (sd_sec_read_addr_scan         ),
.sd_sec_read_data           (sd_sec_read_data              ),
.sd_sec_read_data_valid     (sd_sec_read_data_valid        ),
.sd_sec_read_end            (sd_sec_read_end               ),
.over                       (over                          ),
.amount                     (amount                        ),
.head_n                     (head                          ),
.length_n                   (length                        ),
.tail_n                     (tail                          ),
.aulength_n                 (aulength                      ),
.now                        (now                           ),
.enter_n                    (enter_n                       ),
.minute_now                 (minute_n                      ), 
.second_now                 (second_n                      ),
.secon                      (secon                         )     
);

wav_play wav_play_m0(
.clk                         (clk                          ),
.rst                         (~rst_n                       ),
.play0                       (play                         ),
.enter0                      (enter                        ),
.sd_init_done                (sd_init_done                 ),
.sd_sec_read                 (sd_sec_read_play             ),
.sd_sec_read_addr            (sd_sec_read_addr_play        ),
.sd_sec_read_data            (sd_sec_read_data             ),
.sd_sec_read_data_valid      (sd_sec_read_data_valid       ),
.sd_sec_read_end             (sd_sec_read_end              ),
.over                        (over                         ),
.up                          (up                           ),
.amount                      (amount                       ),
.head                        (head                         ),
.length                      (length                       ),
.tail                        (tail                         ),
.now                         (now                          ),
.play                        (play_n                       ),
.enter                       (enter_n                      ),
.fifo_wr_cnt                 (wrusedw                      ),
.wav_data_wr_en              (wav_data_wr_en               ),
.wav_data                    (wav_data                     ),
.secon                       (secon                        ),
.min_now                     (min_now                      ),                     //now minute
.sec_now                     (sec_now                      ),                     //now second
.min_mod                     (min_mod                      ),                     //modify minute 
.sec_mod                     (sec_mod                      ),                     //modify second
.modify0                     (modify                       )
);
/*************************************************************************
Read the data in the SD card
****************************************************************************/
sd_card_top  sd_card_top_m0(
.clk                       (clk                        ),
.rst                       (~rst_n                     ),
.SD_nCS                    (sd_ncs                     ),
.SD_DCLK                   (sd_dclk                    ),
.SD_MOSI                   (sd_mosi                    ),
.SD_MISO                   (sd_miso                    ),
.sd_init_done              (sd_init_done               ),
.sd_sec_read               (sd_sec_read                ),
.sd_sec_read_addr          (sd_sec_read_addr           ),
.sd_sec_read_data          (sd_sec_read_data           ),
.sd_sec_read_data_valid    (sd_sec_read_data_valid     ),
.sd_sec_read_end           (sd_sec_read_end            ),
.sd_sec_write              (1'b0                       ),
.sd_sec_write_addr         (32'd0                      ),
.sd_sec_write_data         (                           ),
.sd_sec_write_data_req     (                           ),
.sd_sec_write_end          (                           )
);

/*************************************************************************
 Filter
****************************************************************************/
filter flit(
.fclk                      (filter_clk                 ),                        // filter data update clock
.clk                       (clk                        ),                         // 50MHz system clock
.rd_left_data              (rd_left_data               ),                // initial left channel audio data
.rd_right_data             (rd_right_data              ),               // initial right channel audio data
.tx_left_data              (txx_left_data              ),
.tx_right_data             (txx_right_data             ),
.gain_one                  ({0,gain_one}               ),
.gain_two                  (4'd0                       ),
.gain_thr                  ({0,gain_two}               ),
.gain_fou                  ({0,gain_thr}               ),
.gain_fiv                  ({0,gain_fou}               ),
.gain_six                  ({0,gain_fiv}               ),
.gain_sev                  ({0,gain_six}               )
    );

endmodule 