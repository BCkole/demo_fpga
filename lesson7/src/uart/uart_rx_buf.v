`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/16
// Design Name: 
// Module Name: uart_rx
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

module uart_rx_buf #(
	parameter data_len = 32
)
(
	input 				clk	 		,	
	input 				rst_n	 	,
	
	input 				rx_de		,
    input 		[7:0] 	rx_data		,
	
	output reg  		tx_de		,
	output 		[7:0]	tx_data			
);
	
wire			empty			;	
wire 	[10:0]  rd_data_count	;

reg		[7:0]   tx_cnt			;

fifo_uart_rx_buf u1_fifo_uart_rx_buf (
	.wr_clk			(clk			), 
	.rd_clk			(clk			), 
	.din			(rx_data		), 
	.wr_en			(rx_de			), 
	.rd_en			(tx_de			), 
	.dout			(tx_data		), 
	.full			(				), 
	.empty			(empty			),
	.rd_data_count	(rd_data_count	),
	.wr_data_count	(				)
);	
			
always@(posedge clk)
if (!rst_n)
	tx_de <= 1'b0;
else if (tx_cnt==data_len-1)
	tx_de <= 1'b0;
else if (rd_data_count==data_len)
	tx_de <= 1'b1;
else
	tx_de <= tx_de;
	
always@(posedge clk)
if (!rst_n)		
	tx_cnt <= 0;
else if (tx_cnt==data_len-1)
	tx_cnt <= 0;
else if (tx_de==1'b1)
	tx_cnt <= tx_cnt + 1'b1;
else
	tx_cnt <= tx_cnt;
	

	
endmodule
