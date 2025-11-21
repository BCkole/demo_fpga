`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/13 15:28:05
// Design Name: 
// Module Name: multichannel
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


module multichannel#(
	parameter NUM = 16	,	
	parameter cl = 8		
)(
	input								clk				,
	input								rst_n			,

    input                     			data_valid		,
    input 		[NUM*cl-1:0] 			data_adc		,

    input                     			en		        ,

	input		[cl-1:0]				channel			,
	input 								cl_en			,

	output								rd_vaild		,
	output		[NUM-1:0]				data_out			
);

reg     [cl-1:0]    cnt         ;
wire                rd_en       ;
wire                addr_done   ;
wire                data_done   ;
reg 				cl_switch	;

always@(posedge clk or negedge rst_n)
if (!rst_n)
    cnt <= 'd0;
else if ((data_done && cnt==cl-1)||(data_done && cl_switch))
    cnt <= 'd0;
else if (cl_en)
    cnt <= channel;
else if (data_done)
    cnt <= cnt + 1'b1;
else 
    cnt <= cnt;

always@(posedge clk or negedge rst_n)
if (!rst_n)
	cl_switch <= 'd0;
else if (cl_switch && data_done)
	cl_switch <= 'd0;
else if (cl_en) 
	cl_switch <= 1'b1;
else 
	cl_switch <= cl_switch;

assign rd_en = !cl_switch && (en || addr_done && cnt<cl-1) ? 1 : 0;

ram_mem #(
	.NUM	(NUM	),
	.cl		(cl		)		
)ram_mem(
	.clk			(clk	    	),
	.rst_n			(rst_n			),

    .data_valid		(data_valid 	),
    .data_adc		(data_adc   	),

	.cl_num			(cnt        	),
	.rd_en			(rd_en||cl_en	),
    .addr_done      (addr_done  	),
    .data_done      (data_done  	),
    .rd_vaild       (rd_vaild   	),
	.data_out		(data_out   	)	
);


endmodule
