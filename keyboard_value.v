`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/13 18:03:44
// Design Name: 
// Module Name: keyboard_value
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


module keyboard_value(
	input                       rst_n,   
	input                       pclk,
	
	input                       i_hs,    
	input                       i_vs,    
	input                       i_de,	
	input[23:0]                 i_data,
	
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

reg[11:0]  osd_x;
reg[11:0]  osd_y;
reg[15:0]  osd_ram_addr0 , osd_ram_addr1 , osd_ram_addr2 , osd_ram_addr3 , osd_ram_addr4 , osd_ram_addr5 , osd_ram_addr6 , osd_ram_addr7 , osd_ram_addr8 , osd_ram_addr9 , osd_ram_addrC , osd_ram_addrM;
wire[7:0]  q0 , q1 , q2 , q3 , q4 , q5 , q6 , q7 , q8 , q9 , qC , qM;    
    
reg        region_active_0 , region_active_1 , region_active_2 , region_active_3 , region_active_4 , region_active_5 , region_active_6 , region_active_7 , region_active_8 , region_active_9 , region_active_10 , region_active_11; 
reg        region_active_0_d0 , region_active_1_d0 , region_active_2_d0 , region_active_3_d0 , region_active_4_d0 , region_active_5_d0 , region_active_6_d0 , region_active_7_d0 , region_active_8_d0 , region_active_9_d0 , region_active_10_d0 , region_active_11_d0;   
 
reg        pos_vs_d0;
reg        pos_vs_d1;

assign o_data = v_data;
assign o_hs = pos_hs;
assign o_vs = pos_vs;
assign o_de = pos_de;

always@(posedge pclk)
begin
	if(pos_y >= 12'd174 && pos_y <= 12'd174 + 12'd32 - 12'd1 && pos_x >= 12'd515 && pos_x  <= 12'd515 + 12'd16 - 12'd1)
		region_active_0 <= 1'b1;
	else
		region_active_0 <= 1'b0;
	if(pos_y >= 12'd174 && pos_y <= 12'd174 + 12'd32 - 12'd1 && pos_x >= 12'd621 && pos_x  <= 12'd621 + 12'd16 - 12'd1)
		region_active_1 <= 1'b1;
	else
		region_active_1 <= 1'b0;
	if(pos_y >= 12'd174 && pos_y <= 12'd174 + 12'd32 - 12'd1 && pos_x >= 12'd728 && pos_x  <= 12'd728 + 12'd16 - 12'd1)
		region_active_2 <= 1'b1;
	else
		region_active_2 <= 1'b0;
	if(pos_y >= 12'd254 && pos_y <= 12'd254 + 12'd32 - 12'd1 && pos_x >= 12'd515 && pos_x  <= 12'd515 + 12'd16 - 12'd1)
		region_active_3 <= 1'b1;
	else
		region_active_3 <= 1'b0;
	if(pos_y >= 12'd254 && pos_y <= 12'd254 + 12'd32 - 12'd1 && pos_x >= 12'd621 && pos_x  <= 12'd621 + 12'd16 - 12'd1)
		region_active_4 <= 1'b1;
	else
		region_active_4 <= 1'b0;
	if(pos_y >= 12'd254 && pos_y <= 12'd254 + 12'd32 - 12'd1 && pos_x >= 12'd728 && pos_x  <= 12'd728 + 12'd16 - 12'd1)
		region_active_5 <= 1'b1;
	else
		region_active_5 <= 1'b0;
	if(pos_y >= 12'd334 && pos_y <= 12'd334 + 12'd32 - 12'd1 && pos_x >= 12'd515 && pos_x  <= 12'd515 + 12'd16 - 12'd1)
		region_active_6 <= 1'b1;
	else
		region_active_6 <= 1'b0;
	if(pos_y >= 12'd334 && pos_y <= 12'd334 + 12'd32 - 12'd1 && pos_x >= 12'd621 && pos_x  <= 12'd621 + 12'd16 - 12'd1)
		region_active_7 <= 1'b1;
	else
		region_active_7 <= 1'b0;
	if(pos_y >= 12'd334 && pos_y <= 12'd334 + 12'd32 - 12'd1 && pos_x >= 12'd728 && pos_x  <= 12'd728 + 12'd16 - 12'd1)
		region_active_8 <= 1'b1;
	else
		region_active_8 <= 1'b0;
	if(pos_y >= 12'd414 && pos_y <= 12'd414 + 12'd32 - 12'd1 && pos_x >= 12'd515 && pos_x  <= 12'd515 + 12'd16 - 12'd1)
		region_active_9 <= 1'b1;
	else
		region_active_9 <= 1'b0;
	if(pos_y >= 12'd414 && pos_y <= 12'd414 + 12'd32 - 12'd1 && pos_x >= 12'd621 && pos_x  <= 12'd621 + 12'd16 - 12'd1)
		region_active_10 <= 1'b1;
	else
		region_active_10 <= 1'b0;
	if(pos_y >= 12'd414 && pos_y <= 12'd414 + 12'd32 - 12'd1 && pos_x >= 12'd728 && pos_x  <= 12'd728 + 12'd16 - 12'd1)
		region_active_11 <= 1'b1;
	else
		region_active_11 <= 1'b0;
                                       
end

always@(posedge pclk)
begin
	            region_active_0_d0 <= region_active_0;
                region_active_1_d0 <= region_active_1;
                region_active_2_d0 <= region_active_2;
                region_active_3_d0 <= region_active_3;
                region_active_4_d0 <= region_active_4;
                region_active_5_d0 <= region_active_5;
                region_active_6_d0 <= region_active_6;
                region_active_7_d0 <= region_active_7;
                region_active_8_d0 <= region_active_8;
                region_active_9_d0 <= region_active_9;
                region_active_10_d0 <= region_active_10;
                region_active_11_d0 <= region_active_11;
end

always@(posedge pclk)
begin
	pos_vs_d0 <= pos_vs;
	pos_vs_d1 <= pos_vs_d0;
end

always@(posedge pclk)
begin
	if(region_active_0_d0 == 1'b1 || region_active_1_d0 == 1'b1 || region_active_2_d0 == 1'b1 || region_active_3_d0 == 1'b1 || region_active_4_d0 == 1'b1 ||region_active_5_d0 == 1'b1 || region_active_6_d0 == 1'b1 || region_active_7_d0 == 1'b1 || region_active_8_d0 == 1'b1 || region_active_9_d0 == 1'b1 || region_active_10_d0 == 1'b1 || region_active_11_d0 == 1'b1)
		osd_x <= osd_x + 12'd1;
	else
		osd_x <= 12'd0;
end

always@(posedge pclk)
begin
	if(pos_vs_d1 == 1'b1 && pos_vs_d0 == 1'b0)
                   begin
                      osd_ram_addr0 <= 16'd0; 
                      osd_ram_addr1 <= 16'd0; 
                      osd_ram_addr2 <= 16'd0; 
                      osd_ram_addr3 <= 16'd0;
                      osd_ram_addr4 <= 16'd0;
                      osd_ram_addr5 <= 16'd0;
                      osd_ram_addr6 <= 16'd0;
                      osd_ram_addr7 <= 16'd0;
                      osd_ram_addr8 <= 16'd0;
                      osd_ram_addr9 <= 16'd0;
                      osd_ram_addrC <= 16'd0;
                      osd_ram_addrM <= 16'd0;
                   end
	else 
                   begin             
                                if(region_active_0 == 1'b1)
		osd_ram_addr1 <= osd_ram_addr1 + 16'd1;
                                if(region_active_1 == 1'b1)
		osd_ram_addr2 <= osd_ram_addr2 + 16'd1;
                                if(region_active_2 == 1'b1)
		osd_ram_addr3 <= osd_ram_addr3 + 16'd1;
                                if(region_active_3 == 1'b1)
		osd_ram_addr4 <= osd_ram_addr4 + 16'd1;
                                if(region_active_4 == 1'b1)
		osd_ram_addr5 <= osd_ram_addr5 + 16'd1;
                                if(region_active_5 == 1'b1)
		osd_ram_addr6 <= osd_ram_addr6 + 16'd1;
                                if(region_active_6 == 1'b1)
		osd_ram_addr7 <= osd_ram_addr7 + 16'd1;
                                if(region_active_7 == 1'b1)
		osd_ram_addr8 <= osd_ram_addr8 + 16'd1;
                                if(region_active_8 == 1'b1)
		osd_ram_addr9 <= osd_ram_addr9 + 16'd1;
                                if(region_active_9 == 1'b1)
		osd_ram_addrC <= osd_ram_addrC + 16'd1;
                                if(region_active_10 == 1'b1)
		osd_ram_addr0 <= osd_ram_addr0 + 16'd1;
                                if(region_active_11 == 1'b1)
		osd_ram_addrM <= osd_ram_addrM + 16'd1;
		           end

end

always @(posedge pclk)
 begin
 	if(region_active_0_d0 == 1'b1)
                                begin
		if(q1[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
 	else if(region_active_1_d0 == 1'b1)
                                begin
		if(q2[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
    else if(region_active_2_d0 == 1'b1)
                                begin
		if(q3[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
    else if(region_active_3_d0 == 1'b1)
                                begin
		if(q4[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
    else if(region_active_4_d0 == 1'b1)
                                begin
		if(q5[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
    else if(region_active_5_d0 == 1'b1)
                                begin
		if(q6[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
    else if(region_active_6_d0 == 1'b1)
                                begin
		if(q7[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
    else if(region_active_7_d0 == 1'b1)
                                begin
		if(q8[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
    else if(region_active_8_d0 == 1'b1)
                                begin
		if(q9[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
    else if(region_active_9_d0 == 1'b1)
                                begin
		if(qC[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
    else if(region_active_10_d0 == 1'b1)
                                begin
		if(q0[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
    else if(region_active_11_d0 == 1'b1)
                                begin
		if(qM[osd_x[2:0]] == 1'b1)
			v_data <= 24'hff0000;
		else
			v_data <= pos_data;
                                end
    else 
            v_data <= pos_data;                                                                                                                                                                                                                                                                                                                                                                                                  
 end

osd_rom_0 osd_rom_m0 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr0[15:3]      ), 
	.douta                      (q0                       )  
);

osd_rom_1 osd_rom_m1 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr1[15:3]      ), 
	.douta                      (q1                       )  
);

osd_rom_2 osd_rom_m2 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr2[15:3]      ), 
	.douta                      (q2                       )  
);

osd_rom_3 osd_rom_m3 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr3[15:3]      ), 
	.douta                      (q3                       )  
);

osd_rom_4 osd_rom_m4 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr4[15:3]      ), 
	.douta                      (q4                       )  
);

osd_rom_5 osd_rom_m5 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr5[15:3]      ), 
	.douta                      (q5                       )  
);

osd_rom_6 osd_rom_m6 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr6[15:3]      ), 
	.douta                      (q6                       )  
);

osd_rom_7 osd_rom_m7 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr7[15:3]      ), 
	.douta                      (q7                       )  
);

osd_rom_8 osd_rom_m8 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr8[15:3]      ), 
	.douta                      (q8                       )  
);

osd_rom_9 osd_rom_m9 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addr9[15:3]      ), 
	.douta                      (q9                       )  
);

osd_rom_10 osd_rom_m10 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addrC[15:3]      ), 
	.douta                      (qC                       )  
);

osd_rom_11 osd_rom_m11 (
	.clka                       (pclk                    ),   
	.ena                        (1'b1                    ),     
	.addra                      (osd_ram_addrM[15:3]      ), 
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
