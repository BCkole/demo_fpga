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

module uart_tx_buf (
	input 				clk	 		,	
	input 				rst_n	 	,
	
	input 				rx_de		,
    input 		[7:0] 	rx_data		,
	
	input				tx_done		,
	
	output reg  		tx_de		,
	output 		[7:0]	tx_data			
);
				
wire 		empty	;

reg  [1:0]  state   ;

fifo_uart_tx_buf u1_fifo_uart_tx_buf (
	.wr_clk			(clk		), 
	.rd_clk			(clk		), 
	.din			(rx_data	), 
	.wr_en			(rx_de		), 
	.rd_en			(tx_de		), 
	.dout			(tx_data	), 
	.full			(			), 
	.empty			(empty		)
);	
			
always@(posedge clk)
if (!rst_n)	begin
	tx_de <= 1'b0;
	state <= 0;
end
else case(state)
	0:   
		if (empty==1'b0) begin
			tx_de <= 1'b0;
			state <= 1;
		end	
		else begin
			tx_de <= 1'b0;
			state <= state;
		end
	1 : 
		begin 
			tx_de <= 1'b1;
			state <= 2;
		end
	2 :   
		if (empty==1'b1) begin
			tx_de <= 1'b0;
			state <= 0;
		end
		else if (tx_done==1'b1&&empty==1'b0) begin
			tx_de <= 1'b1;
			state <= state;
		end
		else begin
			tx_de <= 1'b0;
			state <= state;
		end
	default: begin
			tx_de <= 1'b0;
			state <= 0;
		end	   
endcase


endmodule
