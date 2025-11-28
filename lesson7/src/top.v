`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/04 21:10:14
// Design Name: 
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
	input		sys_clk_p		,
	input		sys_clk_n		,
	
	input		uart_rxd		,
	output		uart_txd		
);

wire			clk_100M		;	
wire			rst_n			;
	
reg		[31:0]	cnt				;
		
reg				tx_de			;
reg		[7:0]	tx_data			;

wire			tx_done	    	;

wire			uart_tx_de		;		
wire	[7:0]	uart_tx_data	;

wire			tx				;
wire			rx				;

wire			uart_rx_de		;
wire	[7:0]	uart_rx_data	;

wire			rx_de			;
wire	[7:0]	rx_data	    	;

localparam baud   =  921600	;
localparam check  =  2		;

clk_global u1_clk_global ( 
    .clk_in1_p		(sys_clk_p	), 
    .clk_in1_n		(sys_clk_n	), 
    .clk_out1		(clk_100M	),   
    .locked			(rst_n		)        
);     

always@(posedge clk_100M)
if (!rst_n)
	cnt <= 0;
else if (cnt==100000000*2-1)
	cnt <= 0;
else
	cnt <= cnt + 1'b1;

always@(posedge clk_100M)
if (!rst_n)
	tx_de <= 1'b0;		
else if (cnt>=1&&cnt<33)
	tx_de <= 1'b1;	
else
	tx_de <= 1'b0;

always@(posedge clk_100M)
if (!rst_n)
	tx_data <= 0;		
else if (tx_de==1'b1)
	tx_data <= tx_data + 1'b1;	
else
	tx_data <= tx_data;

uart_tx_buf u1_uart_tx_buf (
	.clk	 		(clk_100M		),	
	.rst_n	 		(rst_n			),
							
	.rx_de			(tx_de			),
    .rx_data		(tx_data		),
						
	.tx_done		(tx_done		),
					
	.tx_de			(uart_tx_de		),
	.tx_data		(uart_tx_data	)	
);

uart_tx #(
    .baud    		(baud ),	
	.check   		(check)		
)	
u1_uart_tx	
(	
	.clk			(clk_100M		),
	.rst_n			(rst_n			),
		
	.tx_de			(uart_tx_de		),
	.tx_data		(uart_tx_data	),
		
	.tx				(uart_txd		),
	.tx_done    	(tx_done		) 
);	

uart_rx #(
    .baud    		(baud  ),
	.check   		(check )
)
u1_uart_rx
(
	.clk			(clk_100M		),
	.rst_n			(rst_n			),
		
	.rx				(uart_rxd		),
		
	.rx_de 			(uart_rx_de		),
	.rx_data       	(uart_rx_data	)
);	

uart_rx_buf #(
	.data_len (32) 
)
u1_uart_rx_buf
(
	.clk	 		(clk_100M		),	
	.rst_n	 		(rst_n	 		),
						
	.rx_de			(uart_rx_de		),
    .rx_data		(uart_rx_data	),
						
	.tx_de			(rx_de			),
	.tx_data		(rx_data		)	
);

ila_0 u1_ila_0 (
	.clk(clk_100M), // input wire clk
	.probe0({
		rx_de			,	
	    rx_data			,
	
		uart_rx_de		,	
		uart_rx_data	,
		
		tx_de			,
	    tx_data			,
		
		uart_tx_de		,
		uart_tx_data	
	}) // input wire [99:0] probe0
);








endmodule
