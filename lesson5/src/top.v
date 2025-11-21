`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/20
// Design Name: BCKL
// Module Name: top
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

module top(
	input	sys_clk		
);
	
wire			clk_100M 	;
wire			clk_50M		;	
wire			rst_n	 	;

reg				data_de		;
reg		[15:0]	data		;

wire			data_de0	;
wire	[15:0]	data0		;

wire			data_de1	;
wire	[15:0]	data1	    ;
	
clk_global u1_clk_global (
    .clk_in1		(sys_clk	),
	.clk_out1		(clk_100M 	),
	.clk_out2		(clk_50M 	),
    .locked			(rst_n		)   
);  
  
always@(posedge clk_100M)
if (!rst_n)
	data_de <= 1'b0;
else
	data_de <= 1'b1;	

always@(posedge clk_100M)
if (!rst_n)
	data <= 0;
else if (data_de==1'b1)
	data <= data + 1'b1;
else
	data <= data;
		
pp_fifo u1_pp_fifo(
	.wr_clk			(clk_100M 	),
	.rd_clk         (clk_50M 	),
	.rst_n			(rst_n		),
					
	.data_de		(data_de	),
	.data 		    (data 		),
	
	.data_de0		(data_de0	),	
	.data0		    (data0		),
	
	.data_de1		(data_de1	),
	.data1		    (data1		)
);

reg			rd_en0			;	
wire [15:0]	dout0			;
wire [9:0] 	rd_data_count0	;		
reg	 [7:0]	rd_cnt0			;

reg			rd_en1			;	
wire [15:0]	dout1			;
wire [9:0] 	rd_data_count1	;
reg	 [7:0]	rd_cnt1			;
wire		empty1			;

fifo_ch0 u1_fifo_ch0 (
	.wr_clk			(clk_50M  		),	
	.rd_clk			(clk_100M 		),	
	.din			(data0			),	
	.wr_en			(data_de0	    ),	
	.rd_en			(rd_en0			),	
	.dout			(dout0			),	
	.full			(				),	
	.empty			(				),	
	.rd_data_count	(rd_data_count0	),	
	.wr_data_count	(				) 	
);	

fifo_ch0 u2_fifo_ch0 (
	.wr_clk			(clk_50M 		),	
	.rd_clk			(clk_100M 		),	
	.din			(data1			),	
	.wr_en			(data_de1		),	
	.rd_en			(rd_en1			),	
	.dout			(dout1			),	
	.full			(				),	
	.empty			(empty1			),	
	.rd_data_count	(rd_data_count1	),	
	.wr_data_count	(				) 	
);

always@(posedge clk_100M)
if (!rst_n)
	rd_en0 <= 1'b0;
else if (rd_cnt0==255)
	rd_en0 <= 1'b0;
else if (rd_data_count0>=256)
	rd_en0 <= 1'b1;
else
	rd_en0 <= rd_en0;

always@(posedge clk_100M)
if (!rst_n)
	rd_cnt0 <= 0;
else if (rd_cnt0==255)
	rd_cnt0 <= 0;
else if (rd_en0==1'b1)
	rd_cnt0 <= rd_cnt0 + 1'b1;
else
	rd_cnt0 <= rd_cnt0;
	
always@(posedge clk_100M)
if (!rst_n)
	rd_en1 <= 1'b0;
else if (rd_cnt1==255)
	rd_en1 <= 1'b0;
else if (rd_cnt0==255)
	rd_en1 <= 1'b1;
else
	rd_en1 <= rd_en1;

always@(posedge clk_100M)
if (!rst_n)
	rd_cnt1 <= 0;
else if (rd_cnt1==255)
	rd_cnt1 <= 0;
else if (rd_en1==1'b1)
	rd_cnt1 <= rd_cnt1 + 1'b1;
else
	rd_cnt1 <= rd_cnt1;	


endmodule
