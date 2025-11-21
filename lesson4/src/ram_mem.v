`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/13 13:30:08
// Design Name: 
// Module Name: ram_mem
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


module ram_mem #(
	parameter NUM = 16	,	
	parameter cl = 8		
)(
	input								clk				,
	input								rst_n			,

    input                     			data_valid		,
    input 		[NUM*cl-1:0] 			data_adc		,

	input		[cl-1:0]				cl_num			,
	input								rd_en			,
	output 								addr_done		,
	output								data_done		,
	output								rd_vaild		,
	output		[NUM-1:0]				data_out			
);

reg 	[NUM-1:0]		addra				;
reg 	[NUM-1:0]		addrb				;
wire 	[NUM-1:0]		doutb	[cl-1:0]	;
reg 					rd_en_vaild			;
reg 	[1:0]			rd_up				;
reg 	[1:0]			data_done_reg		;

always@(posedge clk or negedge rst_n)
if (!rst_n)
	addra <= 'd0;
else if (data_valid)
	addra <= addra + 1'b1;
else
	addra <= 'd0;

always@(posedge clk or negedge rst_n)
if (!rst_n)
	rd_en_vaild <= 'd0;
else if (rd_en)
	rd_en_vaild <= 1'b1;
else if (addrb == cl-1)
	rd_en_vaild <= 'd0;
else
	rd_en_vaild <= rd_en_vaild;

always@(posedge clk or negedge rst_n)
if (!rst_n) begin
	rd_up[0] <= 'd0;
	rd_up[1] <= 'd0;
end
else begin
	rd_up[0] <= rd_en_vaild;
	rd_up[1] <= rd_up[0];
end

assign addr_done = addrb == cl-1 ? 1 : 0;
assign rd_vaild = rd_up[1];

always@(posedge clk or negedge rst_n)
if (!rst_n)
	addrb <= 'd0;
else if (addrb == cl-1)
	addrb <= 'd0;
else if (rd_en_vaild)
	addrb <= addrb + 1'b1;
else
	addrb <= 'd0;

always@(posedge clk or negedge rst_n)
if (!rst_n) begin
	data_done_reg[0] <= 'd0;
	data_done_reg[1] <= 'd0;
end
else begin
	data_done_reg[0] <= addr_done;
	data_done_reg[1] <= data_done_reg[0];
end

assign data_done = data_done_reg[1];

genvar i;
generate
	for (i = 0; i < cl; i = i + 1) 
	begin : cl0 
		ram_chanel ram_chanel_u0 (
			.clka		(clk					), 
			.wea		(data_valid				), 
			.addra		(addra					), 
			.dina		(data_adc[i*NUM +: NUM]	), 
			.clkb		(clk					), 
			.addrb		(addrb					), 
			.doutb		(doutb[i]				)  
		);
	end
endgenerate

assign data_out = doutb[cl_num];


endmodule
