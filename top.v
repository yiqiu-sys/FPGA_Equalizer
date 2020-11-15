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
//  2017/7/24    meisq         1.0         Original
//*************************************************************************/
`timescale 1ps/1ps
module top
(
input                           rst_n,	                //reset input，low active
input                           find,enter,play,up,     //record play button
output[3:0]                     led,                    // leds show stae
input                           wm8731_bclk,            //audio bit clock
input                           wm8731_daclrc,          //DAC sample rate left right clock
output                          wm8731_dacdat,          //DAC audio data output 
input                           wm8731_adclrc,          //ADC sample rate left right clock
input                           wm8731_adcdat,          //ADC audio data input
inout                           wm8731_scl,             //I2C clock
inout                           wm8731_sda,             //I2C data
output                          sd_ncs,                 //SD card chip select (SPI mode)
output                          sd_dclk,                //SD card clock
output                          sd_mosi,                //SD card controller data output
input                           sd_miso,                //SD card controller data input	
input                           sys_clk,                 //system clock 50Mhz on board

//Uart signal
input                           rxd,                     //UART rxd
output                          txd,                      //UART txd

//Hdmi signal
output                          tmds_clk_p,      //HDMI differential clock positive
output                          tmds_clk_n,      //HDMI differential clock negative
output[2:0]                     tmds_data_p,     //HDMI differential data positive       
output[2:0]                     tmds_data_n,     //HDMI differential data negative
output [0:0]                    hdmi_oen,        //HDMI out enable

//Digital display
output [5:0]                    sel,             //position selective signal
output [6:0]                    dig,             //segment selection signal 


//input                         scrsho           //screen data update control  

//input                         display
//input                         modify,

//touch screen signal
output[7:0]                     video_r,  //RED
output[7:0]                     video_g,  //GREEN
output[7:0]                     video_b,  //BLUE
output                          video_hs, //HSYNC
output                          video_vs, //VSYNC
output                          video_de, //DE
output                          videoclk, //screen video Pixel clock
output                          lcd_pwm,  //control screen brightness
output                          SCL,      //touch_screen device I2C bus SCL
inout                           SDA,      //touch_screen device I2C bus SDA
input                           touch_int //touch_screen touch reminder

);
wire [9:0]                      lut_index;
wire [31:0]                     lut_data;
wire [3:0]                      state_code;

wire [6:0]                      amount;//((((((((((((((((((((( 目前输出给UART
wire [6:0]                      now;
wire [2:0]                      uart_state;

wire                            read_data_en;                  //fifo read enable
wire                            rdempty;                       //fifo read empty

wire[31:0]                      left_data;                     //Audio left data out
wire[31:0]                      right_data;                    //Audio right data out

wire[31:0]                      tx_left_data;                     //Audio left data in
wire[31:0]                      tx_right_data;                    //Audio right data in

wire                            modify;

wire [2:0]                      gain_one; 
wire [2:0]                      gain_two;
wire [2:0]                      gain_thr; 
wire [2:0]                      gain_fou; 
wire [2:0]                      gain_fiv; 
wire [2:0]                      gain_six; 

wire [8:0]                      min_mod;                     //modify minute 
wire [5:0]                      sec_mod;                     //modify second

wire [8:0]                      min_now;                     //now minute
wire [5:0]                      sec_now;                     //now second
wire [8:0]                      minute_n;                    //Audio minute length currently
wire [5:0]                      second_n;                    //Audio second length currently


//assign led              =       state_code;

assign              led[2:0]=state_code[2:0];

assign              left_data=(rdempty==1'b0)?tx_left_data:32'd0;
assign              right_data=(rdempty==1'b0)?tx_right_data:32'd0;


/*************************************************************************
I2C master controller configure the WM8731 registers
****************************************************************************/
i2c_config i2c_config_m0
(
.rst                            (~rst_n                 ),
.clk                            (sys_clk                ),
.clk_div_cnt                    (16'd99                 ),//99:100Khz
.i2c_addr_2byte                 (1'b0                   ),
.lut_index                      (lut_index              ),
.lut_dev_addr                   (lut_data[31:24]        ),
.lut_reg_addr                   (lut_data[23:8]         ),
.lut_reg_data                   (lut_data[7:0]          ),
.error                          (                       ),
.done                           (                       ),
.i2c_scl                        (wm8731_scl             ),
.i2c_sda                        (wm8731_sda             )
);
/*************************************************************************
wm8731 configure look-up table
****************************************************************************/
lut_wm8731 lut_wm8731_m0
(
.lut_index                      (lut_index              ),
.lut_data                       (lut_data               )
);
/*************************************************************************
//with a led display of state_code
// 0(4'b0000):SD card is initializing
// 1(4'b0001):wait for the button to press
// 2(4'b0010):looking for the WAV file
// 3(4'b0011):playing
****************************************************************************/
sd_card_audio  sd_card_audio_m0
(
.clk                            (sys_clk                ),
.rst_n                          (rst_n                  ),
.key1                           ({find,enter,play,up}   ),
.state_code                     (state_code             ),
.bclk                           (wm8731_bclk            ),
.daclrc                         (wm8731_daclrc          ),
.dacdat                         (wm8731_dacdat          ),
.adclrc                         (wm8731_adclrc          ),
.adcdat                         (wm8731_adcdat          ),
.sd_ncs                         (sd_ncs                 ),
.sd_dclk                        (sd_dclk                ),
.sd_mosi                        (sd_mosi                ),
.sd_miso                        (sd_miso                ),
.now                            (now                    ),
.over                           (led[3]                 ),
.amount                         (amount                 ),
.sd_sec_read_copy               (                       ),
.read_data_en                   (read_data_en           ),                  //fifo read enable
.rdempty                        (rdempty                ),                  //fifo read empty
.tx_left_data                   (tx_left_data           ),
.tx_right_data                  (tx_right_data          ),
.modify                         (modify                 ),
.gain_one                       (gain_one               ),
.gain_two                       (gain_two               ),
.gain_thr                       (gain_thr               ),
.gain_fou                       (gain_fou               ),
.gain_fiv                       (gain_fiv               ),
.gain_six                       (gain_six               ),
.min_mod                        (min_mod                ),
.sec_mod                        (sec_mod                ),
.min_now                        (min_now                ),                 
.sec_now                        (sec_now                ),                 
.minute_n                       (minute_n               ),                
.second_n                       (second_n               )                     
);

uart_top uart(
 .txd                           (txd                    ),
 .rxd                           (rxd                    ),
 .clk                           (sys_clk                ),
 .over_n                        (led[3]                 ),
 .amount                        (amount                 ),
 .rst                           (~rst_n                 ),
 .state                         (uart_state             ),
 .display                       (1'b0                   )
 );

video_display video_dis
(
.rst_n                          (rst_n                  ),    
.sys_clk                        (sys_clk                ),    
.scrsho                         (1'b1                   ),    
.read_data_en                   (read_data_en           ),    
.left_data                      (left_data              ),
.right_data                     (right_data             ),
.tmds_clk_p                     (tmds_clk_p             ),    
.tmds_clk_n                     (tmds_clk_n             ),    
.tmds_data_p                    (tmds_data_p            ),    
.tmds_data_n                    (tmds_data_n            ),
.hdmi_oen                       (hdmi_oen               )     
);

touch_screen_top touch_screen(
    //clk and reset
.sys_clk                        (sys_clk                ), //50MHz clk
.rst_n                          (rst_n                  ),   //reset
    //touch screen signal
.video_r                        (video_r                ),  //RED
.video_g                        (video_g                ),  //GREEN
.video_b                        (video_b                ),  //BLUE
.video_hs                       (video_hs               ), //HSYNC
.video_vs                       (video_vs               ), //VSYNC
.video_de                       (video_de               ), //DE
.videoclk                       (videoclk               ), //screen video Pixel clock
.lcd_pwm                        (lcd_pwm                ),  //control screen brightness
.SCL                            (SCL                    ),  //touch_screen device I2C bus SCL
.SDA                            (SDA                    ),  //touch_screen device I2C bus SDA
.touch_int                      (touch_int              ),  //touch_screen touch reminder
    //fliter parameter
.gain_one                       (gain_one               ),
.gain_two                       (gain_two               ),
.gain_thr                       (gain_thr               ),
.gain_fou                       (gain_fou               ),
.gain_fiv                       (gain_fiv               ),
.gain_six                       (gain_six               ),
    //player control signal
.modify                         (modify                 ),
.min_mod                        (min_mod                ),
.sec_mod                        (sec_mod                ),
.min_now                        (min_now                ),                 
.sec_now                        (sec_now                ),                 
.minute_n                       (minute_n               ),                
.second_n                       (second_n               ) 
);

digital_display digital(
.amount                         (amount                 ),          //wav file amount
.now                            (now+7'd1               ),          //wav file current
.sel                            (sel                    ),          //position selective signal
.dig                            (dig                    ),           //segment selection signal 
.clk                            (sys_clk                ),
.rst                            (~rst_n                 ) 
    );

endmodule