`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/13 22:11:50
// Design Name: 
// Module Name: number_display
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


module number_display(
	input                       rst_n,   
	input                       pclk,
	
	input                       i_hs,    
	input                       i_vs,    
	input                       i_de,	
	input[23:0]                 i_data,
	
	output                      o_hs,    
	output                      o_vs,    
	output                      o_de,    
	output[23:0]                o_data,
	
    input [3:0]                 min1,min2,
    input [3:0]                 sec1,sec2
    );
    
wire[11:0] pos_x;
wire[11:0] pos_y;
wire       pos_hs;
wire       pos_vs;
wire       pos_de;
wire[23:0] pos_data;
reg[23:0]  v_data;

reg[11:0]  osd_x;
reg[11:0]  osd_y;

reg[15:0]  osd_ram_addr0 , osd_ram_addr1 , osd_ram_addr2 , osd_ram_addr3 , osd_ram_addr4 , osd_ram_addr5 , osd_ram_addr6 , osd_ram_addr7 , osd_ram_addr8 , osd_ram_addr9 , osd_ram_addr10 , osd_ram_addr11 , osd_ram_addr12 , osd_ram_addr13 , osd_ram_addr14 , osd_ram_addr15;   

reg [15:0] osd_ram_addr_one , osd_ram_addr_two , osd_ram_addr_three , osd_ram_addr_four , osd_ram_addr_five , osd_ram_addr_six , osd_ram_addr_seven , osd_ram_addr_eight , osd_ram_addr_nine , osd_ram_addr_zero;
wire[15:0] osd_ram_addr_mao;
wire[7:0]  q0 , q1 , q2 , q3 , q4 , q5 , q6 , q7 , q8 , q9 , qM , qX;  

reg        region_active_0 , region_active_1 , region_active_2 , region_active_3 , region_active_4 , region_active_5 , region_active_6 , region_active_7 , region_active_8 , region_active_9 , region_active_10 , region_active_11 , region_active_12 , region_active_13 , region_active_14 , region_active_15; 
reg        region_active_0_d0 , region_active_1_d0 , region_active_2_d0 , region_active_3_d0 , region_active_4_d0 , region_active_5_d0 , region_active_6_d0 , region_active_7_d0 , region_active_8_d0 , region_active_9_d0 , region_active_10_d0 , region_active_11_d0 , region_active_12_d0 , region_active_13_d0 , region_active_14_d0 , region_active_15_d0;

reg        pos_vs_d0;
reg        pos_vs_d1;

assign o_data = v_data;
assign o_hs = pos_hs;
assign o_vs = pos_vs;
assign o_de = pos_de;

assign osd_ram_addr_mao = osd_ram_addr13;

always@(*)
begin
if(region_active_11==1'b1)
begin
osd_ram_addr_one = osd_ram_addr11;
osd_ram_addr_two = osd_ram_addr11;
osd_ram_addr_three = osd_ram_addr11;
osd_ram_addr_four = osd_ram_addr11;
osd_ram_addr_five = osd_ram_addr11;
osd_ram_addr_six = osd_ram_addr11;
osd_ram_addr_seven = osd_ram_addr11;
osd_ram_addr_eight = osd_ram_addr11;
osd_ram_addr_nine = osd_ram_addr11;
osd_ram_addr_zero = osd_ram_addr11;
end
else if(region_active_12==1'b1)
begin
osd_ram_addr_one = osd_ram_addr12;
osd_ram_addr_two = osd_ram_addr12;
osd_ram_addr_three = osd_ram_addr12;
osd_ram_addr_four = osd_ram_addr12;
osd_ram_addr_five = osd_ram_addr12;
osd_ram_addr_six = osd_ram_addr12;
osd_ram_addr_seven = osd_ram_addr12;
osd_ram_addr_eight = osd_ram_addr12;
osd_ram_addr_nine = osd_ram_addr12;
osd_ram_addr_zero = osd_ram_addr12;
end
else if(region_active_14==1'b1)
begin
osd_ram_addr_one = osd_ram_addr14;
osd_ram_addr_two = osd_ram_addr14;
osd_ram_addr_three = osd_ram_addr14;
osd_ram_addr_four = osd_ram_addr14;
osd_ram_addr_five = osd_ram_addr14;
osd_ram_addr_six = osd_ram_addr14;
osd_ram_addr_seven = osd_ram_addr14;
osd_ram_addr_eight = osd_ram_addr14;
osd_ram_addr_nine = osd_ram_addr14;
osd_ram_addr_zero = osd_ram_addr14;
end
else if(region_active_15==1'b1)
begin
osd_ram_addr_one = osd_ram_addr15;
osd_ram_addr_two = osd_ram_addr15;
osd_ram_addr_three = osd_ram_addr15;
osd_ram_addr_four = osd_ram_addr15;
osd_ram_addr_five = osd_ram_addr15;
osd_ram_addr_six = osd_ram_addr15;
osd_ram_addr_seven = osd_ram_addr15;
osd_ram_addr_eight = osd_ram_addr15;
osd_ram_addr_nine = osd_ram_addr15;
osd_ram_addr_zero = osd_ram_addr15;
end
else
begin
osd_ram_addr_one = osd_ram_addr0;
osd_ram_addr_two = osd_ram_addr0;
osd_ram_addr_three = osd_ram_addr0;
osd_ram_addr_four = osd_ram_addr0;
osd_ram_addr_five = osd_ram_addr0;
osd_ram_addr_six = osd_ram_addr0;
osd_ram_addr_seven = osd_ram_addr0;
osd_ram_addr_eight = osd_ram_addr0;
osd_ram_addr_nine = osd_ram_addr0;
osd_ram_addr_zero = osd_ram_addr0;
end
end

always@(posedge pclk)
begin
	if(pos_y >= 12'd72 && pos_y <= 12'd72 + 12'd32 - 12'd1 && pos_x >= 12'd582 && pos_x  <= 12'd582 + 12'd16 - 12'd1)
		region_active_11 <= 1'b1;
	else
		region_active_11 <= 1'b0;
	if(pos_y >= 12'd72 && pos_y <= 12'd72 + 12'd32 - 12'd1 && pos_x >= 12'd608 && pos_x  <= 12'd608 + 12'd16 - 12'd1)
		region_active_12 <= 1'b1;
	else
		region_active_12 <= 1'b0;		
	if(pos_y >= 12'd72 && pos_y <= 12'd72 + 12'd32 - 12'd1 && pos_x >= 12'd634 && pos_x  <= 12'd634 + 12'd16 - 12'd1)
		region_active_13 <= 1'b1;
	else
		region_active_13 <= 1'b0;	
	if(pos_y >= 12'd72 && pos_y <= 12'd72 + 12'd32 - 12'd1 && pos_x >= 12'd660 && pos_x  <= 12'd660 + 12'd16 - 12'd1)
		region_active_14 <= 1'b1;
	else
		region_active_14 <= 1'b0;			
	if(pos_y >= 12'd72 && pos_y <= 12'd72 + 12'd32 - 12'd1 && pos_x >= 12'd686 && pos_x  <= 12'd686 + 12'd16 - 12'd1)
		region_active_15 <= 1'b1;
	else
		region_active_15 <= 1'b0;		
                                       
end

always@(posedge pclk)
begin
                region_active_11_d0 <= region_active_11;
                region_active_12_d0 <= region_active_12;
                region_active_13_d0 <= region_active_13;
                region_active_14_d0 <= region_active_14;
                region_active_15_d0 <= region_active_15;
end

always@(posedge pclk)
begin
	pos_vs_d0 <= pos_vs;
	pos_vs_d1 <= pos_vs_d0;
end

always@(posedge pclk)
begin
	if(region_active_11_d0 == 1'b1 || region_active_12_d0 == 1'b1 || region_active_13_d0 == 1'b1 || region_active_14_d0 == 1'b1 || region_active_15_d0 == 1'b1)
		osd_x <= osd_x + 12'd1;
	else
		osd_x <= 12'd0;
end

always@(posedge pclk)
begin
	if(pos_vs_d1 == 1'b1 && pos_vs_d0 == 1'b0)
                   begin
                      osd_ram_addr11 <= 16'd0;
                      osd_ram_addr12 <= 16'd0;
                      osd_ram_addr13 <= 16'd0;
                      osd_ram_addr14 <= 16'd0;
                      osd_ram_addr15 <= 16'd0;
                   end
	else 
                   begin             
                                if(region_active_11 == 1'b1)
		osd_ram_addr11 <= osd_ram_addr11 + 16'd1;
		                        if(region_active_12 == 1'b1)
		osd_ram_addr12 <= osd_ram_addr12 + 16'd1;
		                        if(region_active_13 == 1'b1)
		osd_ram_addr13 <= osd_ram_addr13 + 16'd1;
		                        if(region_active_14 == 1'b1)
		osd_ram_addr14 <= osd_ram_addr14 + 16'd1;
		                        if(region_active_15 == 1'b1)
		osd_ram_addr15 <= osd_ram_addr15 + 16'd1;
		           end

end

always @(posedge pclk)
 begin
	if(region_active_13_d0 == 1'b1)
                                begin
		if(qM[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

             else if(region_active_11_d0 == 1'b1)
                                begin
                                if(min1==4'd0)
                 begin
    		if(q0[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                 end
                 
                                if(min1==4'd1)
                                begin
    		if(q1[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                
                                if(min1==4'd2)
                                begin
    		if(q2[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                
                                if(min1==4'd3)
                                begin
    		if(q3[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                
                                if(min1==4'd4)
                                begin
    		if(q4[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(min1==4'd5)
                                begin
    		if(q5[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(min1==4'd6)
                                begin
    		if(q6[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(min1==4'd7)
                                begin
    		if(q7[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(min1==4'd8)
                                begin
    		if(q8[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(min1==4'd9)
                                begin
    		if(q9[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                end

        else if(region_active_12_d0 == 1'b1)
                                begin
                                if(min2==4'd0)
                 begin
    		if(q0[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                 end
                 
                                if(min2==4'd1)
                                begin
    		if(q1[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                
                                if(min2==4'd2)
                                begin
    		if(q2[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                
                                if(min2==4'd3)
                                begin
    		if(q3[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                
                                if(min2==4'd4)
                                begin
    		if(q4[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(min2==4'd5)
                                begin
    		if(q5[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(min2==4'd6)
                                begin
    		if(q6[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(min2==4'd7)
                                begin
    		if(q7[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(min2==4'd8)
                                begin
    		if(q8[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(min2==4'd9)
                                begin
    		if(q9[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                end
              
            else if(region_active_14_d0 == 1'b1)
                                begin
                                if(sec1==4'd0)
                 begin
    		if(q0[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                 end
                 
                                if(sec1==4'd1)
                                begin
    		if(q1[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                
                                if(sec1==4'd2)
                                begin
    		if(q2[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                
                                if(sec1==4'd3)
                                begin
    		if(q3[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                
                                if(sec1==4'd4)
                                begin
    		if(q4[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(sec1==4'd5)
                                begin
    		if(q5[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(sec1==4'd6)
                                begin
    		if(q6[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(sec1==4'd7)
                                begin
    		if(q7[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(sec1==4'd8)
                                begin
    		if(q8[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(sec1==4'd9)
                                begin
    		if(q9[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                end

           else if(region_active_15_d0 == 1'b1)
                                begin
                                if(sec2==4'd0)
                 begin
    		if(q0[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                 end
                 
                                if(sec2==4'd1)
                                begin
    		if(q1[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                
                                if(sec2==4'd2)
                                begin
    		if(q2[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                
                                if(sec2==4'd3)
                                begin
    		if(q3[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                
                                if(sec2==4'd4)
                                begin
    		if(q4[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(sec2==4'd5)
                                begin
    		if(q5[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(sec2==4'd6)
                                begin
    		if(q6[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(sec2==4'd7)
                                begin
    		if(q7[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(sec2==4'd8)
                                begin
    		if(q8[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end

                                if(sec2==4'd9)
                                begin
    		if(q9[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
                                end 
       else
            v_data <= pos_data;                                                                                                                      
                                                                                                                            
 end

osd_rom_a0 osd_rom_n0 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr_zero[15:3]      ), 
	.douta                      (q0                       )  
);

osd_rom_a1 osd_rom_n1 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr_one[15:3]      ), 
	.douta                      (q1                       )  
);

osd_rom_a2 osd_rom_n2 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr_two[15:3]      ), 
	.douta                      (q2                       )  
);

osd_rom_a3 osd_rom_n3 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr_three[15:3]     ), 
	.douta                      (q3                       )  
);

osd_rom_a4 osd_rom_n4 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr_four[15:3]      ), 
	.douta                      (q4                       )  
);

osd_rom_a5 osd_rom_n5 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr_five[15:3]      ), 
	.douta                      (q5                       )  
);

osd_rom_a6 osd_rom_n6 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr_six[15:3]      ), 
	.douta                      (q6                       )  
);

osd_rom_a7 osd_rom_n7 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr_seven[15:3]      ), 
	.douta                      (q7                       )  
);

osd_rom_a8 osd_rom_n8 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr_eight[15:3]      ), 
	.douta                      (q8                       )  
);

osd_rom_a9 osd_rom_n9 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr_nine[15:3]      ), 
	.douta                      (q9                       )  
);

osd_rom_am osd_rom_nm (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr_mao[15:3]      ), 
	.douta                      (qM                       )  
);

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
