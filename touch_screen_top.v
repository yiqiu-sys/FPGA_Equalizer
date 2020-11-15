`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/17 20:39:54
// Design Name: 
// Module Name: touch_screen_top
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


module   touch_screen_top(
    //clk and reset
    input                              sys_clk, //50MHz clk
    input                              rst_n,   //reset
    //touch screen signal
    output[7:0]                      video_r,  //RED
    output[7:0]                      video_g,  //GREEN
    output[7:0]                      video_b,  //BLUE
    output                           video_hs, //HSYNC
    output                           video_vs, //VSYNC
    output                           video_de, //DE
    output                           videoclk, //screen video Pixel clock
    output                           lcd_pwm,  //control screen brightness
    output                           SCL,      //touch_screen device I2C bus SCL
    inout                            SDA,      //touch_screen device I2C bus SDA
    input                            touch_int, //touch_screen touch reminder
    
    output                           modify,
    output[8:0]                      min_mod,                 
    output[5:0]                      sec_mod,
    
    input [8:0]                      min_now,                     //now minute
    input [5:0]                      sec_now,                     //now second
    input [8:0]                      minute_n,                    //Audio minute length currently
    input [5:0]                      second_n,                    //Audio second length currently    
    
    output [2:0]                     gain_one, 
    output [2:0]                     gain_two,
    output [2:0]                     gain_thr, 
    output [2:0]                     gain_fou, 
    output [2:0]                     gain_fiv, 
    output [2:0]                     gain_six  

);

wire [6:0] min_now1,min_now2,sec_now1,sec_now2,minute_n1,minute_n2,second_n1,second_n2;
wire [3:0] min1,min2,sec1,sec2;

wire                            video_clk;

reg                             I2C_clk;
wire[11:0]                      TOUCH1_X2,TOUCH1_Y2;
wire [11:0]                      button_ord;

wire                            update;

//First level signal
wire[7:0]                      init_r;  //RED
wire[7:0]                      init_g;  //GREEN
wire[7:0]                      init_b;  //BLUE
wire                           init_hs; //HSYNC
wire                           init_vs; //VSYNC
wire                           init_de; //DE

//Second level signal
wire[7:0]                      butt_r;  //RED
wire[7:0]                      butt_g;  //GREEN
wire[7:0]                      butt_b;  //BLUE
wire                           butt_hs; //HSYNC
wire                           butt_vs; //VSYNC
wire                           butt_de; //DE

//Third level signal
wire[7:0]                      slid_r;  //RED
wire[7:0]                      slid_g;  //GREEN
wire[7:0]                      slid_b;  //BLUE
wire                           slid_hs; //HSYNC
wire                           slid_vs; //VSYNC
wire                           slid_de; //DE

//Fourth level signal
wire[7:0]                      flit_r;  //RED
wire[7:0]                      flit_g;  //GREEN
wire[7:0]                      flit_b;  //BLUE
wire                           flit_hs; //HSYNC
wire                           flit_vs; //VSYNC
wire                           flit_de; //DE

//Fivth level signal
wire[7:0]                      keyb_r;  //RED
wire[7:0]                      keyb_g;  //GREEN
wire[7:0]                      keyb_b;  //BLUE
wire                           keyb_hs; //HSYNC
wire                           keyb_vs; //VSYNC
wire                           keyb_de; //DE

//Sixth level signal
wire[7:0]                      numb_r;  //RED
wire[7:0]                      numb_g;  //GREEN
wire[7:0]                      numb_b;  //BLUE
wire                           numb_hs; //HSYNC
wire                           numb_vs; //VSYNC
wire                           numb_de; //DE

assign videoclk=~video_clk;

assign video_r=numb_r;   //RED
assign video_g=numb_g;   //GREEN
assign video_b=numb_b;   //BLUE
assign video_hs=numb_hs; //HSYNC
assign video_vs=numb_vs;  //VSYNC
assign video_de=numb_de;  //DE

assign modify=button_ord[11];

//gengrate I2C_clk to configure with touch screen
always @(posedge sys_clk)
begin
I2C_clk<=I2C_clk+1'b1;
end

//PLL ip : generate pixel clk
 video_pll video_pll_m0
 (
	.clk_in1                    (sys_clk                  ),
	.clk_out1                   (video_clk                ),
	.reset                      (1'b0                     ),
	.locked                     (                         )
 );

//produce lcd_pwm signal
 ax_pwm#(.N(24)) //pass new parameters
 ax_pwm_m0(
     .clk                        (sys_clk                  ),
     .rst                        (~rst_n                   ),
     .period                     (24'd67                   ),  //(2^24)*200Hz/50MHz
     .duty                       (24'd5033164              ),  //(2^24)* 30%
     .pwm_out                    (lcd_pwm                  )
 );
 
 //White color background
 color_bar color_bar_m0(
	.clk                        (video_clk                ),
	.rst                        (~rst_n                   ),
	.hs                         (init_hs                  ),
	.vs                         (init_vs                  ),
	.de                         (init_de                  ),
	.rgb_r                      (init_r                   ),
	.rgb_g                      (init_g                   ),
	.rgb_b                      (init_b                   )
);

//configure touch screen , get touch signal and touch coordinate
touch_com ttouch(
     .clk(I2C_clk),
	 .reset(~rst_n),
	 .touch_int(touch_int),	 
	 .SCL(SCL),
	 .SDA(SDA),
	 .TOUCH1_X2(TOUCH1_X2),          
     .TOUCH1_Y2(TOUCH1_Y2),
     .update(update)     
);

//display button on the screen , touch can change color
button_display butto(
	.rst_n(rst_n),   
	.pclk(video_clk),
	.i_hs(init_hs),    
	.i_vs(init_vs),    
	.i_de(init_de),	
	.i_data({init_r,init_g,init_b}),
    .touch_int(touch_int),
    .TOUCH1_X2(TOUCH1_X2),
    .TOUCH1_Y2(TOUCH1_Y2),
	.o_hs(butt_hs),    
	.o_vs(butt_vs),    
	.o_de(butt_de),    
	.o_data({butt_r,butt_g,butt_b})
);

//feel the corresponding button pressed , returns a I2C clock cycle pulse
button_order bu(
	 .pclk(I2C_clk),
	 .touch_int(touch_int),
	 .TOUCH1_X2(TOUCH1_X2),
     .TOUCH1_Y2(TOUCH1_Y2),
	 .button_ord(button_ord),
	 .update(update)
);

//display fliter slider edge on the screen
slider_edge slider(
	.rst_n(rst_n),   
	.pclk(video_clk),
	.i_hs(butt_hs),    
	.i_vs(butt_vs),    
	.i_de(butt_de),	
	.i_data({butt_r,butt_g,butt_b}),
	.o_hs(slid_hs),    
	.o_vs(slid_vs),    
	.o_de(slid_de),    
	.o_data({slid_r,slid_g,slid_b})
);

fliter_slider flislid(
	.rst_n(rst_n),   
	.pclk(I2C_clk),
	.video_clk(video_clk),
	.touch_int(touch_int),
	.TOUCH1_X2(TOUCH1_X2),
    .TOUCH1_Y2(TOUCH1_Y2),
	.i_hs(slid_hs),    
	.i_vs(slid_vs),    
	.i_de(slid_de),	
	.i_data({slid_r,slid_g,slid_b}),
	.o_hs(flit_hs),    
	.o_vs(flit_vs),    
	.o_de(flit_de),    
	.o_data({flit_r,flit_g,flit_b}),
	.update(update),           
	.gain_one(gain_one),
    .gain_two(gain_two),
    .gain_thr(gain_thr),
    .gain_fou(gain_fou),
    .gain_fiv(gain_fiv),
    .gain_six(gain_six) 
    );
    
modify_time modif(
 .button_ord(button_ord),
 .I2C_clk(I2C_clk),
 .min_mod(min_mod),
 .sec_mod(sec_mod),
 .min1(min1),
 .min2(min2),
 .sec1(sec1),
 .sec2(sec2)    
 );
 
keyboard_value keyvalu(
.rst_n(rst_n),   
.pclk(video_clk),
.i_hs(flit_hs),    
.i_vs(flit_vs),    
.i_de(flit_de),    
.i_data({flit_r,flit_g,flit_b}),
.o_hs(keyb_hs),    
.o_vs(keyb_vs),    
.o_de(keyb_de),    
.o_data({keyb_r,keyb_g,keyb_b})
 ); 
 
number_display numdis(
.rst_n(rst_n),   
.pclk(video_clk),
.i_hs(keyb_hs),    
.i_vs(keyb_vs),    
.i_de(keyb_de),    
.i_data({keyb_r,keyb_g,keyb_b}),
.o_hs(numb_hs),    
.o_vs(numb_vs),    
.o_de(numb_de),    
.o_data({numb_r,numb_g,numb_b}),
.min1(min1),
.min2(min2),
.sec1(sec1),
.sec2(sec2)
    );    



endmodule
