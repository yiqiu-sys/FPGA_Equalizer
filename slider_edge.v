`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/11 22:41:00
// Design Name: 
// Module Name: slider_edge
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


module slider_edge(
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
reg        region_active0,region_active1,region_active2,region_active3,region_active4,region_active5;

assign o_data = v_data;
assign o_hs = pos_hs;
assign o_vs = pos_vs;
assign o_de = pos_de;

always@(posedge pclk)
begin
	if((pos_y >= 12'd20 && pos_y <= 12'd50 && pos_x >= 12'd25 && pos_x  <= 12'd125)||(pos_y >= 12'd190 && pos_y <= 12'd220 && pos_x >= 12'd25 && pos_x  <= 12'd125)||(pos_y >= 12'd50 && pos_y <= 12'd190 && pos_x == 12'd75))	
		region_active0 <= 1'b1;
	else
		region_active0 <= 1'b0;
    if((pos_y >= 12'd20 && pos_y <= 12'd50 && pos_x >= 12'd150 && pos_x  <= 12'd250)||(pos_y >= 12'd190 && pos_y <= 12'd220 && pos_x >= 12'd150 && pos_x  <= 12'd250)||(pos_y >= 12'd50 && pos_y <= 12'd190 && pos_x == 12'd200))	
		region_active1 <= 1'b1;
	else
		region_active1 <= 1'b0;
    if((pos_y >= 12'd20 && pos_y <= 12'd50 && pos_x >= 12'd275 && pos_x  <= 12'd375)||(pos_y >= 12'd190 && pos_y <= 12'd220 && pos_x >= 12'd275 && pos_x  <= 12'd375)||(pos_y >= 12'd50 && pos_y <= 12'd190 && pos_x == 12'd325))	
		region_active2 <= 1'b1;
	else
		region_active2 <= 1'b0;
     if((pos_y >= 12'd260 && pos_y <= 12'd290 && pos_x >= 12'd25 && pos_x  <= 12'd125)||(pos_y >= 12'd430 && pos_y <= 12'd460 && pos_x >= 12'd25 && pos_x  <= 12'd125)||(pos_y >= 12'd290 && pos_y <= 12'd430 && pos_x == 12'd75))	
		region_active3 <= 1'b1;
	else
		region_active3 <= 1'b0;
     if((pos_y >= 12'd260 && pos_y <= 12'd290 && pos_x >= 12'd150 && pos_x  <= 12'd250)||(pos_y >= 12'd430 && pos_y <= 12'd460 && pos_x >= 12'd150 && pos_x  <= 12'd250)||(pos_y >= 12'd290 && pos_y <= 12'd430 && pos_x == 12'd200))	
		region_active4 <= 1'b1;
	else
		region_active4 <= 1'b0;
     if((pos_y >= 12'd260 && pos_y <= 12'd290 && pos_x >= 12'd275 && pos_x  <= 12'd375)||(pos_y >= 12'd430 && pos_y <= 12'd460 && pos_x >= 12'd275 && pos_x  <= 12'd375)||(pos_y >= 12'd290 && pos_y <= 12'd430 && pos_x == 12'd325))	
		region_active5 <= 1'b1;
	else
		region_active5 <= 1'b0;
end

always@(posedge pclk)
begin
	v_data <= pos_data;

	if(region_active0 == 1'b1)
                                begin
			v_data <= {8'hff,8'hff,8'h00};
                                end
	if(region_active1 == 1'b1)
                                begin
			v_data <= {8'hff,8'h00,8'h00};
                                end
	if(region_active2 == 1'b1)
                                begin
			v_data <= {8'h00,8'hff,8'hff};
                                end
	if(region_active3 == 1'b1)
                                begin
			v_data <= {8'h00,8'h00,8'hff};
                                end
	if(region_active4 == 1'b1)
                                begin
			v_data <= {8'hff,8'h00,8'hff};
                                end
	if(region_active5 == 1'b1)
                                begin
			v_data <= {8'h00,8'hff,8'h00};
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
