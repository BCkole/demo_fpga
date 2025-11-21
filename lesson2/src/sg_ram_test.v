`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/21 21:19:28
// Design Name: 
// Module Name: sg_ram_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 'd0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sg_ram_test#(
	parameter depth = 256
)(
	input		sys_clk			
);

wire			clk_100M		;
wire			rst_n			;
	
reg		[15:0]	cnt				;
	
reg				wr_en			;	
reg		[7:0]   wr_cnt			;

wire	[7:0] 	dina			;
wire	[7:0]	addra			;
	
reg				rd_en			;
reg		[7:0]   rd_cnt			;
	
wire	[7:0]	douta			;

reg 			rd_en_reg		;
reg				rd_en_reg1		;
reg		[8:0]	addr2a			;
wire			rd_en2_flag		;

reg		[7:0]   rd_cnt2			;
reg				rd_en2			;

wire	[7:0]	dout2a			;
reg				rd_data_en		;
reg		[7:0]	error_sig		;
reg				complete		;

clk_global u1_clk_global (
    .clk_in1		(sys_clk	),
	.clk_out1		(clk_100M	),
	.clk_out2		(			),
    .locked			(rst_n		)         
);     

always@(posedge clk_100M)
if (!rst_n)
	cnt <= 'd0;
else if (cnt == 2047)
	cnt <= 'd0;
else 
	cnt <= cnt + 1'b1;

always@(posedge clk_100M)
if (!rst_n)
	wr_en <= 1'b0;
else if (wr_cnt == depth-1)
	wr_en <= 1'b0;
else if (cnt == 1)
	wr_en <= 1'b1;
else
	wr_en <= wr_en;

always@(posedge clk_100M)
if (!rst_n)
	wr_cnt <= 'd0;
else if (wr_cnt == depth-1)
	wr_cnt <= 'd0;
else if (wr_en == 1'b1)	
	wr_cnt <= wr_cnt + 1'b1;
else
	wr_cnt <= wr_cnt;

always@(posedge clk_100M)
if (!rst_n)
	rd_en <= 1'b0;
else if (rd_cnt == depth-1)
	rd_en <= 1'b0;
else if (cnt == depth+2)
	rd_en <= 1'b1;
else
	rd_en <= rd_en;
	
always@(posedge clk_100M)
if (!rst_n)
	rd_cnt <= 'd0;
else if (rd_cnt == depth-1)
	rd_cnt <= 'd0;
else if (rd_en == 1'b1 || rd_en2)	
	rd_cnt <= rd_cnt + 1'b1;
else
	rd_cnt <= rd_cnt;		

assign dina  = wr_cnt;
assign addra = wr_en == 1'b1 ? wr_cnt : rd_cnt;

always@(posedge clk_100M)
if (!rst_n)
	rd_en_reg <= 'd0;
else
	rd_en_reg <= rd_en;		

always@(posedge clk_100M)
if (!rst_n)
	addr2a <= 9'd100;
else if (rd_en_reg || rd_en2)
	addr2a <= addr2a + 1'b1;		
else
	addr2a <= 9'd100;

always@(posedge clk_100M)
if (!rst_n)
	rd_en_reg1 <= 'd0;
else
	rd_en_reg1 <= rd_en_reg;		

assign rd_en2_flag = rd_en_reg1 && !rd_en_reg;

always@(posedge clk_100M)
if (!rst_n)
	rd_en2 <= 'd0;
else if (rd_cnt2  == depth-1)
	rd_en2 <= 'd0;
else if (rd_en2_flag)
	rd_en2 <= 1'b1;
else
	rd_en2 <= rd_en2;

always@(posedge clk_100M)
if (!rst_n)
	rd_cnt2 <= 'd0;
else if (rd_en2)
	rd_cnt2 <= rd_cnt2 + 1'b1;
else
	rd_cnt2 <= 'd0;

always@(posedge clk_100M)
if (!rst_n)
	rd_data_en <= 'd0;
else
	rd_data_en <= rd_en2;

sg_ram u1_sg_ram (
	.clka			(clk_100M		),
	.wea			(wr_en			),
	.addra			(addra			),
	.dina			(dina			),
	.douta			(douta			) 
);

ram_next u1_ram_next (
	.clka			(clk_100M		),
	.wea			(rd_en_reg		),
	.addra			(addr2a			),
	.dina			(douta			),
	.douta			(dout2a			) 
);

assign error = rd_data_en && (douta == dout2a) ? 'd0 : 1'b1;

always@(posedge clk_100M)
if (!rst_n)
	error_sig <= 'd0;
else if (rd_data_en)
	error_sig <= error_sig + error;
else
	error_sig <= 'd0;

always@(posedge clk_100M)
if (!rst_n)
	complete <= 'd0;
else if (rd_data_en && addra == 0 && error_sig == 0)
	complete <= 1'b1;
else
	complete <= 'd0;


endmodule
