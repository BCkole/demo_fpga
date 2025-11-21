`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/11 20:23:53
// Design Name: 
// Module Name: test
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

// module adc_data #(
// 	parameter NUM = 16	,
// 	parameter cl = 32		
// )(
// 	input						clk						,
// 	input						rst_n					,

// 	input						en						,
// 	output 	reg					data_valid				,
// 	output	reg		[NUM-1:0]	data_adc	[cl-1:0]	
// );

// reg 						vaild 		;
// reg 		[NUM-1:0] 		data		;

// always@(posedge clk or negedge rst_n)
// if (!rst_n)
// 	vaild <= 'd0;
// else if (data == cl - 1)
// 	vaild <= 'd0;
// else if (en)
// 	vaild <= 1'b1;
// else
// 	vaild <= vaild;

// always@(posedge clk or negedge rst_n)
// if (!rst_n)
// 	data <= 'd0;
// else if (vaild)
// 	data <= data + 1'b1;
// else
// 	data <= 'd0;

// always@(posedge clk or negedge rst_n)
// if (!rst_n)
// 	data_valid <= 'd0;
// else
// 	data_valid <= vaild;

// genvar i;
// generate
// 	for (i = 0; i < cl; i = i + 1)
// 	begin : channel
// 		always @(posedge clk or negedge rst_n) begin
// 			if (!rst_n) begin
// 				data_adc[i] <= 'd0;
// 			end
// 			else if (vaild) begin
// 				data_adc[i] <= data + i;
// 			end
// 			else begin
// 				data_adc[i] <= 'd0;
// 			end
// 		end
// end
// endgenerate


// endmodule


module adc_data #(
    parameter NUM = 16		,   	
    parameter cl = 32 	
)(
    input                       		clk			,
    input                       		rst_n		,

	input								en			,
    output reg                     		data_valid	,
    output reg 		[NUM*cl-1:0] 		data_adc	
);

reg 						vaild 	;
reg 	[NUM-1:0] 			data	;

always@(posedge clk or negedge rst_n)
if (!rst_n)
	vaild <= 'd0;
else if (data == cl - 1)
	vaild <= 'd0;
else if (en)
	vaild <= 1'b1;
else
	vaild <= vaild;

always @(posedge clk or negedge rst_n) begin
if (!rst_n)
	data <= 'd0;
else if (vaild)
	data <= data + 1'b1;
else
	data <= 'd0;
end

always@(posedge clk or negedge rst_n)
if (!rst_n)
	data_valid <= 'd0;
else
	data_valid <= vaild;

genvar i;
generate
for (i = 0; i < cl; i = i + 1) 
begin : channel
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n)
			data_adc[i*NUM +: NUM] <= 'd0;
		else if (vaild)
			data_adc[i*NUM +: NUM] <= data + i;
		else
			data_adc[i*NUM +: NUM] <= 'd0;
	end
end
endgenerate

endmodule