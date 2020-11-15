`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/05 20:56:10
// Design Name: 
// Module Name: filter
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


module filter(
input                       fclk,                        // filter data update clock
input                       clk,                         // 50MHz system clock
input[31:0]                rd_left_data,                // initial left channel audio data
input[31:0]                rd_right_data,               // initial right channel audio data
output[31:0]               tx_left_data,
output[31:0]               tx_right_data,
input[3:0]                 gain_one,
input[3:0]                 gain_two,
input[3:0]                 gain_thr,
input[3:0]                 gain_fou,
input[3:0]                 gain_fiv,
input[3:0]                 gain_six,
input[3:0]                 gain_sev
    );

reg [31:0]                       left_audio_shift[44:0];   //one left audio shift register
reg [31:0]                       right_audio_shift[44:0];  //one right audio shift register
wire[31:0]                       left_audio[21:0];   
wire[31:0]                       right_audio[21:0];
wire[31:0]                       left_audi[21:0];   
wire[31:0]                       right_audi[21:0];
wire                             left_aud[21:0];   
wire                             right_aud[21:0];  

wire jmp_one,jmp_two,jmp_thr,jmp_fou,jmp_fiv,jmp_six,jmp_sev;
reg  jmp_one_0,jmp_two_0,jmp_thr_0,jmp_fou_0,jmp_fiv_0,jmp_six_0,jmp_sev_0;
reg  jmp_one_1,jmp_two_1,jmp_thr_1,jmp_fou_1,jmp_fiv_1,jmp_six_1,jmp_sev_1;
reg  jmp_one_2,jmp_two_2,jmp_thr_2,jmp_fou_2,jmp_fiv_2,jmp_six_2,jmp_sev_2;
reg  jmp_one_3,jmp_two_3,jmp_thr_3,jmp_fou_3,jmp_fiv_3,jmp_six_3,jmp_sev_3;
reg  jmp_one_4,jmp_two_4,jmp_thr_4,jmp_fou_4,jmp_fiv_4,jmp_six_4,jmp_sev_4;
reg  jmp_one_5,jmp_two_5,jmp_thr_5,jmp_fou_5,jmp_fiv_5,jmp_six_5,jmp_sev_5;
reg  jmp_one_6,jmp_two_6,jmp_thr_6,jmp_fou_6,jmp_fiv_6,jmp_six_6,jmp_sev_6;

wire [31:0] au0,bu0,cu0,du0,eu0,fu0,gu0,hu0,iu0,ju0,ku0,lu0,mu0,nu0,ou0,pu0,qu0,ru0,su0,tu0,uu0,vu0;
wire [31:0] au1,bu1,cu1,du1,eu1,fu1,gu1,hu1,iu1,ju1,ku1,lu1,mu1,nu1,ou1,pu1,qu1,ru1,su1,tu1,uu1,vu1;
    
reg [31:0] one_left_data,two_left_data,thr_left_data,fou_left_data,fiv_left_data,six_left_data,sev_left_data;
reg [31:0] one_right_data,two_right_data,thr_right_data,fou_right_data,fiv_right_data,six_right_data,sev_right_data;

reg [4:0] state=5'd0;
reg [31:0]                       filemeter[21:0];        //Filter parameters register
reg                              filesign[21:0];         //Filter parameters sign register

wire [31:0]                      le_infilegister[21:0];     //left Filter unsign calculation data register
wire [31:0]                      ri_infilegister[21:0];     //right Filter unsign calculation data register
wire [31:0]                      le_filegister[21:0];       //left Filter signed calculation data register
wire [31:0]                      ri_filegister[21:0];       //right Filter signed calculation data register
wire [31:0]                      le_result;                 //Filter lest audio output 
wire [31:0]                      ri_result;                 //filter right audio output
wire [31:0]                      ale_result;                 //Filter lest audio output 
wire [31:0]                      ari_result;                 //filter right audio output
wire [31:0]                      aale_result;                 //Filter lest audio output 
wire [31:0]                      aari_result;                 //filter right audio output
wire [31:0]                      ainle_result;                 //Filter lest audio output 
wire [31:0]                      ainri_result;                 //filter right audio output
wire [31:0]                      inle_result;                 //Filter lest audio output 
wire [31:0]                      inri_result;                 //filter right audio output

reg  [3:0]                       gain;


assign tx_left_data=one_left_data+fiv_left_data+thr_left_data+fou_left_data+six_left_data+sev_left_data;//+two_left_data
assign tx_right_data=one_right_data+fiv_right_data+thr_right_data+fou_right_data+six_right_data+sev_right_data;//+two_right_data

assign au0=left_audi[0]; assign bu0=left_audi[1]; assign cu0=left_audi[2]; assign du0=left_audi[3]; assign eu0=left_audi[4]; assign fu0=left_audi[5];
assign gu0=left_audi[6]; assign hu0=left_audi[7]; assign iu0=left_audi[8]; assign ju0=left_audi[9]; assign ku0=left_audi[10]; assign lu0=left_audi[11];
assign mu0=left_audi[12]; assign nu0=left_audi[13]; assign ou0=left_audi[14]; assign pu0=left_audi[15]; assign qu0=left_audi[16]; assign ru0=left_audi[17];
assign su0=left_audi[18]; assign tu0=left_audi[19]; assign uu0=left_audi[20]; assign vu0=left_audi[21];

assign au1=right_audi[0]; assign bu1=right_audi[1]; assign cu1=right_audi[2]; assign du1=right_audi[3]; assign eu1=right_audi[4]; assign fu1=right_audi[5];
assign gu1=right_audi[6]; assign hu1=right_audi[7]; assign iu1=right_audi[8]; assign ju1=right_audi[9]; assign ku1=right_audi[10]; assign lu1=right_audi[11];
assign mu1=right_audi[12]; assign nu1=right_audi[13]; assign ou1=right_audi[14]; assign pu1=right_audi[15]; assign qu1=right_audi[16]; assign ru1=right_audi[17];
assign su1=right_audi[18]; assign tu1=right_audi[19]; assign uu1=right_audi[20]; assign vu1=right_audi[21];

assign left_aud[0]=au0[31]; assign left_aud[1]=bu0[31]; assign left_aud[2]=cu0[31]; assign left_aud[3]=du0[31]; assign left_aud[4]=eu0[31]; assign left_aud[5]=fu0[31];
assign left_aud[6]=gu0[31]; assign left_aud[7]=hu0[31]; assign left_aud[8]=iu0[31]; assign left_aud[9]=ju0[31]; assign left_aud[10]=ku0[31]; assign left_aud[11]=lu0[31];
assign left_aud[12]=mu0[31]; assign left_aud[13]=nu0[31]; assign left_aud[14]=ou0[31]; assign left_aud[15]=pu0[31]; assign left_aud[16]=qu0[31]; assign left_aud[17]=ru0[31];
assign left_aud[18]=su0[31]; assign left_aud[19]=tu0[31]; assign left_aud[20]=uu0[31]; assign left_aud[21]=vu0[31];

assign right_aud[0]=au1[31]; assign right_aud[1]=bu1[31]; assign right_aud[2]=cu1[31]; assign right_aud[3]=du1[31]; assign right_aud[4]=eu1[31]; assign right_aud[5]=fu1[31];
assign right_aud[6]=gu1[31]; assign right_aud[7]=hu1[31]; assign right_aud[8]=iu1[31]; assign right_aud[9]=ju1[31]; assign right_aud[10]=ku1[31]; assign right_aud[11]=lu1[31];
assign right_aud[12]=mu1[31]; assign right_aud[13]=nu1[31]; assign right_aud[14]=ou1[31]; assign right_aud[15]=pu1[31]; assign right_aud[16]=qu1[31]; assign right_aud[17]=ru1[31];
assign right_aud[18]=su1[31]; assign right_aud[19]=tu1[31]; assign right_aud[20]=uu1[31]; assign right_aud[21]=vu1[31];

genvar i;

    generate
        for (i = 10'd0; i <= 10'd21; i = i + 1) begin: unsign_data
          assign left_audi[i]=left_audio_shift[i]+left_audio_shift[44-i];
          assign right_audi[i]=right_audio_shift[i]+right_audio_shift[44-i];
          assign left_audio[i]=(left_aud[i]==1'b1)?~left_audi[i]+32'd1:left_audi[i];
          assign right_audio[i]=(right_aud[i]==1'b1)?~right_audi[i]+32'd1:right_audi[i];
          assign le_infilegister[i]=filemeter[i]*(left_audio[i]);
          assign ri_infilegister[i]=filemeter[i]*(right_audio[i]);  
        end
    endgenerate   

genvar j;

    generate
        for (j = 10'd0; j <= 10'd21; j = j + 1) begin: signed_data
          assign le_filegister[j]=(filesign[j]^left_aud[j])?le_infilegister[j]:~le_infilegister[j]+32'd1;
          assign ri_filegister[j]=(filesign[j]^right_aud[j])?ri_infilegister[j]:~ri_infilegister[j]+32'd1;  
        end
    endgenerate    

assign inle_result=le_filegister[0]+le_filegister[1]+le_filegister[2] +le_filegister[3] +le_filegister[4] +le_filegister[5] +le_filegister[6] +le_filegister[7] +le_filegister[8] +le_filegister[9] +le_filegister[10] +le_filegister[11] +le_filegister[12] +le_filegister[13] +le_filegister[14] +le_filegister[15] +le_filegister[16] +le_filegister[17]+le_filegister[18] +le_filegister[19] +le_filegister[20] +le_filegister[21];  
assign inri_result=ri_filegister[0]+ri_filegister[1]+ri_filegister[2] +ri_filegister[3] +ri_filegister[4] +ri_filegister[5] +ri_filegister[6] +ri_filegister[7] +ri_filegister[8] +ri_filegister[9] +ri_filegister[10] +ri_filegister[11] +ri_filegister[12] +ri_filegister[13] +ri_filegister[14] +ri_filegister[15] +ri_filegister[16] +ri_filegister[17]+ri_filegister[18] +ri_filegister[19] +ri_filegister[20] +ri_filegister[21];

assign ainle_result=(inle_result[31]==1'b1)?~inle_result+32'd1:inle_result;
assign ainri_result=(inri_result[31]==1'b1)?~inri_result+32'd1:inri_result;

assign aale_result=ale_result*{28'd0,gain};
assign aari_result=ari_result*{28'd0,gain};

assign le_result=(inle_result[31]==1'b1)?~aale_result+32'd1:aale_result;
assign ri_result=(inri_result[31]==1'b1)?~aari_result+32'd1:aari_result;

assign jmp_one=(state==5'd1)?1'b1:1'b0;
assign jmp_two=(state==5'd2)?1'b1:1'b0;
assign jmp_thr=(state==5'd3)?1'b1:1'b0;
assign jmp_fou=(state==5'd4)?1'b1:1'b0;
assign jmp_fiv=(state==5'd5)?1'b1:1'b0;
assign jmp_six=(state==5'd6)?1'b1:1'b0;
assign jmp_sev=(state==5'd7)?1'b1:1'b0;

always @(*)
begin
if(state==5'd1)
gain=gain_one;
else if(state==5'd2)
gain=gain_two;
else if(state==5'd3)
gain=gain_thr;
else if(state==5'd4)
gain=gain_fou;
else if(state==5'd5)
gain=gain_fiv;
else if(state==5'd6)
gain=gain_six;
else if(state==5'd7)
gain=gain_sev;
else
gain=4'd0;
end

always @(posedge clk)
begin
jmp_one_0<=jmp_one;
jmp_one_1<=jmp_one_0;
jmp_one_2<=jmp_one_1;
jmp_one_3<=jmp_one_2;
jmp_one_4<=jmp_one_3;
jmp_one_5<=jmp_one_4;
jmp_one_6<=jmp_one_5;

jmp_two_0<=jmp_two;
jmp_two_1<=jmp_two_0;
jmp_two_2<=jmp_two_1;
jmp_two_3<=jmp_two_2;
jmp_two_4<=jmp_two_3;
jmp_two_5<=jmp_two_4;
jmp_two_6<=jmp_two_5;

jmp_thr_0<=jmp_thr;
jmp_thr_1<=jmp_thr_0;
jmp_thr_2<=jmp_thr_1;
jmp_thr_3<=jmp_thr_2;
jmp_thr_4<=jmp_thr_3;
jmp_thr_5<=jmp_thr_4;
jmp_thr_6<=jmp_thr_5;

jmp_fou_0<=jmp_fou;
jmp_fou_1<=jmp_fou_0;
jmp_fou_2<=jmp_fou_1;
jmp_fou_3<=jmp_fou_2;
jmp_fou_4<=jmp_fou_3;
jmp_fou_5<=jmp_fou_4;
jmp_fou_6<=jmp_fou_5;

jmp_fiv_0<=jmp_fiv;
jmp_fiv_1<=jmp_fiv_0;
jmp_fiv_2<=jmp_fiv_1;
jmp_fiv_3<=jmp_fiv_2;
jmp_fiv_4<=jmp_fiv_3;
jmp_fiv_5<=jmp_fiv_4;
jmp_fiv_6<=jmp_fiv_5;

jmp_six_0<=jmp_six;
jmp_six_1<=jmp_six_0;
jmp_six_2<=jmp_six_1;
jmp_six_3<=jmp_six_2;
jmp_six_4<=jmp_six_3;
jmp_six_5<=jmp_six_4;
jmp_six_6<=jmp_six_5;

jmp_sev_0<=jmp_sev;
jmp_sev_1<=jmp_sev_0;
jmp_sev_2<=jmp_sev_1;
jmp_sev_3<=jmp_sev_2;
jmp_sev_4<=jmp_sev_3;
jmp_sev_5<=jmp_sev_4;
jmp_sev_6<=jmp_sev_5;

end

genvar a;

    generate
        for (a = 10'd44; a > 0; a = a - 1) begin: inc_delay
            always @(posedge clk) 
            begin
                if(fclk==1'b1) 
                begin
                left_audio_shift[a] <= left_audio_shift[a-1];
                right_audio_shift[a] <= right_audio_shift[a-1];
                end
            end
        end
    endgenerate   
    
    always @(posedge clk) 
     begin
      if(fclk==1'b1) 
       begin
        left_audio_shift[0] <= rd_left_data;
        right_audio_shift[0] <= rd_right_data;
       end
     end
     
     always @(posedge clk)
      begin
      
      case(state)
      
      5'd0:
      begin
      if(fclk==1'b1)
      state<=5'd1;
      end
      
      5'd1:
      begin
      filemeter[0]<=32'd0;
      filemeter[1]<=32'd0;
      filemeter[2]<=32'd1;
      filemeter[3]<=32'd2;
      filemeter[4]<=32'd3;
      filemeter[5]<=32'd5;
      filemeter[6]<=32'd9;
      filemeter[7]<=32'd13;
      filemeter[8]<=32'd19;
      filemeter[9]<=32'd27;
      filemeter[10]<=32'd36;
      filemeter[11]<=32'd47;
      filemeter[12]<=32'd59;
      filemeter[13]<=32'd73;
      filemeter[14]<=32'd87;
      filemeter[15]<=32'd100;
      filemeter[16]<=32'd120;
      filemeter[17]<=32'd130;
      filemeter[18]<=32'd140;
      filemeter[19]<=32'd150;
      filemeter[20]<=32'd160;
      filemeter[21]<=32'd170;
      filesign[0]<=1'b1;
      filesign[1]<=1'b1;
      filesign[2]<=1'b1;
      filesign[3]<=1'b1;
      filesign[4]<=1'b1;
      filesign[5]<=1'b1;
      filesign[6]<=1'b1;
      filesign[7]<=1'b1;
      filesign[8]<=1'b1;
      filesign[9]<=1'b1;
      filesign[10]<=1'b1;
      filesign[11]<=1'b1;
      filesign[12]<=1'b1;
      filesign[13]<=1'b1;
      filesign[14]<=1'b1;
      filesign[15]<=1'b1;
      filesign[16]<=1'b1;
      filesign[17]<=1'b1;
      filesign[18]<=1'b1;
      filesign[19]<=1'b1;
      filesign[20]<=1'b1;
      filesign[21]<=1'b1;
      if(jmp_one_6==1'b1)
      begin
      one_left_data<=le_result;
      one_right_data<=ri_result;
      state<=5'd2;
      end
      end
      
      5'd2:
      begin
      filemeter[0]<=32'd0;
      filemeter[1]<=32'd1;
      filemeter[2]<=32'd2;
      filemeter[3]<=32'd4;
      filemeter[4]<=32'd8;
      filemeter[5]<=32'd15;
      filemeter[6]<=32'd24;
      filemeter[7]<=32'd36;
      filemeter[8]<=32'd52;
      filemeter[9]<=32'd73;
      filemeter[10]<=32'd98;
      filemeter[11]<=32'd130;
      filemeter[12]<=32'd160;
      filemeter[13]<=32'd200;
      filemeter[14]<=32'd240;
      filemeter[15]<=32'd280;
      filemeter[16]<=32'd320;
      filemeter[17]<=32'd360;
      filemeter[18]<=32'd390;
      filemeter[19]<=32'd420;
      filemeter[20]<=32'd440;
      filemeter[21]<=32'd450;
      filesign[0]<=1'b1;
      filesign[1]<=1'b1;
      filesign[2]<=1'b1;
      filesign[3]<=1'b1;
      filesign[4]<=1'b1;
      filesign[5]<=1'b1;
      filesign[6]<=1'b1;
      filesign[7]<=1'b1;
      filesign[8]<=1'b1;
      filesign[9]<=1'b1;
      filesign[10]<=1'b1;
      filesign[11]<=1'b1;
      filesign[12]<=1'b1;
      filesign[13]<=1'b1;
      filesign[14]<=1'b1;
      filesign[15]<=1'b1;
      filesign[16]<=1'b1;
      filesign[17]<=1'b1;
      filesign[18]<=1'b1;
      filesign[19]<=1'b1;
      filesign[20]<=1'b1;
      filesign[21]<=1'b1;
      if(jmp_two_6==1'b1)
      begin
      two_left_data<=le_result;
      two_right_data<=ri_result;
      state<=5'd3;
      end
      end
     
      5'd3:
      begin
      filemeter[0]<=32'd0;
      filemeter[1]<=32'd2;
      filemeter[2]<=32'd4;
      filemeter[3]<=32'd10;
      filemeter[4]<=32'd19;
      filemeter[5]<=32'd35;
      filemeter[6]<=32'd58;
      filemeter[7]<=32'd92;
      filemeter[8]<=32'd140;
      filemeter[9]<=32'd200;
      filemeter[10]<=32'd270;
      filemeter[11]<=32'd360;
      filemeter[12]<=32'd470;
      filemeter[13]<=32'd590;
      filemeter[14]<=32'd710;
      filemeter[15]<=32'd850;
      filemeter[16]<=32'd980;
      filemeter[17]<=32'd1110;
      filemeter[18]<=32'd1230;
      filemeter[19]<=32'd1320;
      filemeter[20]<=32'd1400;
      filemeter[21]<=32'd1440;
      filesign[0]<=1'b1;
      filesign[1]<=1'b1;
      filesign[2]<=1'b1;
      filesign[3]<=1'b1;
      filesign[4]<=1'b1;
      filesign[5]<=1'b1;
      filesign[6]<=1'b1;
      filesign[7]<=1'b1;
      filesign[8]<=1'b1;
      filesign[9]<=1'b1;
      filesign[10]<=1'b1;
      filesign[11]<=1'b1;
      filesign[12]<=1'b1;
      filesign[13]<=1'b1;
      filesign[14]<=1'b1;
      filesign[15]<=1'b1;
      filesign[16]<=1'b1;
      filesign[17]<=1'b1;
      filesign[18]<=1'b1;
      filesign[19]<=1'b1;
      filesign[20]<=1'b1;
      filesign[21]<=1'b1;
      if(jmp_thr_6==1'b1)
      begin
      thr_left_data<=le_result;
      thr_right_data<=ri_result;
      state<=5'd4;
      end
      end
      
      5'd4:
      begin
      filemeter[0]<=32'd1;
      filemeter[1]<=32'd4;
      filemeter[2]<=32'd14;
      filemeter[3]<=32'd32;
      filemeter[4]<=32'd65;
      filemeter[5]<=32'd110;
      filemeter[6]<=32'd180;
      filemeter[7]<=32'd260;
      filemeter[8]<=32'd340;
      filemeter[9]<=32'd400;
      filemeter[10]<=32'd410;
      filemeter[11]<=32'd330;
      filemeter[12]<=32'd120;
      filemeter[13]<=32'd230;
      filemeter[14]<=32'd760;
      filemeter[15]<=32'd1460;
      filemeter[16]<=32'd2290;
      filemeter[17]<=32'd3200;
      filemeter[18]<=32'd4130;
      filemeter[19]<=32'd4970;
      filemeter[20]<=32'd5650;
      filemeter[21]<=32'd6100;
      filesign[0]<=1'b0;
      filesign[1]<=1'b0;
      filesign[2]<=1'b0;
      filesign[3]<=1'b0;
      filesign[4]<=1'b0;
      filesign[5]<=1'b0;
      filesign[6]<=1'b0;
      filesign[7]<=1'b0;
      filesign[8]<=1'b0;
      filesign[9]<=1'b0;
      filesign[10]<=1'b0;
      filesign[11]<=1'b0;
      filesign[12]<=1'b0;
      filesign[13]<=1'b1;
      filesign[14]<=1'b1;
      filesign[15]<=1'b1;
      filesign[16]<=1'b1;
      filesign[17]<=1'b1;
      filesign[18]<=1'b1;
      filesign[19]<=1'b1;
      filesign[20]<=1'b1;
      filesign[21]<=1'b1;
      if(jmp_fou_6==1'b1)
      begin
      fou_left_data<=le_result;
      fou_right_data<=ri_result;
      state<=5'd5;
      end
      end
      
      5'd5:
      begin
      filemeter[0]<=32'd1;
      filemeter[1]<=32'd4;
      filemeter[2]<=32'd10;
      filemeter[3]<=32'd14;
      filemeter[4]<=32'd10;
      filemeter[5]<=32'd2;
      filemeter[6]<=32'd0;
      filemeter[7]<=32'd55;
      filemeter[8]<=32'd200;
      filemeter[9]<=32'd420;
      filemeter[10]<=32'd580;
      filemeter[11]<=32'd440;
      filemeter[12]<=32'd270;
      filemeter[13]<=32'd1680;
      filemeter[14]<=32'd3600;
      filemeter[15]<=32'd5440;
      filemeter[16]<=32'd6320;
      filemeter[17]<=32'd5450;
      filemeter[18]<=32'd2490;
      filemeter[19]<=32'd2110;
      filemeter[20]<=32'd7130;
      filemeter[21]<=32'd11030;
      filesign[0]<=1'b1;
      filesign[1]<=1'b1;
      filesign[2]<=1'b1;
      filesign[3]<=1'b1;
      filesign[4]<=1'b1;
      filesign[5]<=1'b0;
      filesign[6]<=1'b0;
      filesign[7]<=1'b1;
      filesign[8]<=1'b1;
      filesign[9]<=1'b1;
      filesign[10]<=1'b1;
      filesign[11]<=1'b1;
      filesign[12]<=1'b0;
      filesign[13]<=1'b0;
      filesign[14]<=1'b0;
      filesign[15]<=1'b0;
      filesign[16]<=1'b0;
      filesign[17]<=1'b0;
      filesign[18]<=1'b0;
      filesign[19]<=1'b1;
      filesign[20]<=1'b1;
      filesign[21]<=1'b1;
      if(jmp_fiv_6==1'b1)
      begin
      fiv_left_data<=le_result;
      fiv_right_data<=ri_result;
      state<=5'd6;
      end
      end
      
      5'd6:
      begin
      filemeter[0]<=32'd1;
      filemeter[1]<=32'd2;
      filemeter[2]<=32'd3;
      filemeter[3]<=32'd17;
      filemeter[4]<=32'd24;
      filemeter[5]<=32'd8;
      filemeter[6]<=32'd0;
      filemeter[7]<=32'd65;
      filemeter[8]<=32'd160;
      filemeter[9]<=32'd29;
      filemeter[10]<=32'd580;
      filemeter[11]<=32'd1350;
      filemeter[12]<=32'd1270;
      filemeter[13]<=32'd590;
      filemeter[14]<=32'd3600;
      filemeter[15]<=32'd5160;
      filemeter[16]<=32'd2620;
      filemeter[17]<=32'd3650;
      filemeter[18]<=32'd9280;
      filemeter[19]<=32'd8970;
      filemeter[20]<=32'd1530;
      filemeter[21]<=32'd8110;
      filesign[0]<=1'b0;
      filesign[1]<=1'b0;
      filesign[2]<=1'b1;
      filesign[3]<=1'b1;
      filesign[4]<=1'b1;
      filesign[5]<=1'b1;
      filesign[6]<=1'b1;
      filesign[7]<=1'b1;
      filesign[8]<=1'b1;
      filesign[9]<=1'b1;
      filesign[10]<=1'b0;
      filesign[11]<=1'b0;
      filesign[12]<=1'b0;
      filesign[13]<=1'b1;
      filesign[14]<=1'b1;
      filesign[15]<=1'b1;
      filesign[16]<=1'b1;
      filesign[17]<=1'b0;
      filesign[18]<=1'b0;
      filesign[19]<=1'b0;
      filesign[20]<=1'b0;
      filesign[21]<=1'b1;
      if(jmp_six_6==1'b1)
      begin
      six_left_data<=le_result;
      six_right_data<=ri_result;
      state<=5'd7;
      end
      end
      
      5'd7:
      begin
      filemeter[0]<=32'd0;
      filemeter[1]<=32'd2;
      filemeter[2]<=32'd0;
      filemeter[3]<=32'd19;
      filemeter[4]<=32'd34;
      filemeter[5]<=32'd37;
      filemeter[6]<=32'd180;
      filemeter[7]<=32'd120;
      filemeter[8]<=32'd360;
      filemeter[9]<=32'd730;
      filemeter[10]<=32'd0;
      filemeter[11]<=32'd1500;
      filemeter[12]<=32'd1550;
      filemeter[13]<=32'd1090;
      filemeter[14]<=32'd3600;
      filemeter[15]<=32'd1690;
      filemeter[16]<=32'd3700;
      filemeter[17]<=32'd5590;
      filemeter[18]<=32'd0;
      filemeter[19]<=32'd6870;
      filemeter[20]<=32'd5600;
      filemeter[21]<=32'd3150;
      filesign[0]<=1'b1;
      filesign[1]<=1'b1;
      filesign[2]<=1'b1;
      filesign[3]<=1'b0;
      filesign[4]<=1'b0;
      filesign[5]<=1'b1;
      filesign[6]<=1'b1;
      filesign[7]<=1'b1;
      filesign[8]<=1'b0;
      filesign[9]<=1'b0;
      filesign[10]<=1'b1;
      filesign[11]<=1'b1;
      filesign[12]<=1'b1;
      filesign[13]<=1'b0;
      filesign[14]<=1'b0;
      filesign[15]<=1'b0;
      filesign[16]<=1'b1;
      filesign[17]<=1'b1;
      filesign[18]<=1'b1;
      filesign[19]<=1'b0;
      filesign[20]<=1'b0;
      filesign[21]<=1'b1;
      if(jmp_sev_6==1'b1)
      begin
      sev_left_data<=le_result;
      sev_right_data<=ri_result;
      state<=5'd0;
      end
      end
      
      
      endcase     
      
      end


ChuFa  ChuF1(
.a(ainle_result), 
.b(32'd800000),
.yshang(ale_result),
.yyushu(),
.Error()
);

ChuFa  ChuF2(
.a(ainri_result), 
.b(32'd800000),
.yshang(ari_result),
.yyushu(),
.Error()
);

    
endmodule
