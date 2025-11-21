`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/11 21:06:46
// Design Name: 
// Module Name: test_tb
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


module test_tb();

parameter NUM = 16	;
parameter cl = 8	;	

reg                 clk_100M        		;
reg                 rst_n           		;
reg     [7:0]       cnt             		;
reg                 en              		;
wire				data_valid				;		
// wire	[NUM-1:0]	data_adc	[cl-1:0]	;

wire	[NUM*cl-1:0]data_adc                ;
reg	    [NUM-1:0]	data_reg	[cl-1:0]	;

// genvar i;
// generate
// for (i = 0; i < cl; i = i + 1) 
// begin : chan
// 	always @(posedge clk_100M or negedge rst_n) begin
// 		if (!rst_n)
// 			data_reg[i] <= 'd0;
// 		else if (data_valid)
// 			data_reg[i] <= data_adc[i*NUM +: NUM];
// 		else
// 			data_reg[i] <= 'd0;
// 	end
// end
// endgenerate

genvar i;
generate
for (i = 0; i < cl; i = i + 1)
begin : chan
    assign data_reg[i] = data_valid ? data_adc[i*NUM +: NUM] : 'd0;
end
endgenerate

initial begin
    rst_n = 0;
    clk_100M = 0;
    #200;
    rst_n = 1;
end

always #5 clk_100M = !clk_100M;

always@(posedge clk_100M or negedge rst_n)
if (!rst_n)
    cnt <= 'd0;
else if (cnt == 255)
    cnt <= 255;
else
    cnt <= cnt + 1'b1;

always@(posedge clk_100M or negedge rst_n)
if (!rst_n)
    en <= 'd0;
else if (cnt == 100)
    en <= 1'b1;
else
    en <= 'd0;

adc_data #(
	.NUM	(NUM	),
	.cl		(cl		)		
)adc_data(
	.clk			(clk_100M	),
	.rst_n			(rst_n		),

	.en				(en			),
	.data_valid		(data_valid	),
	.data_adc		(data_adc	)
);

always @(posedge clk_100M)
if (data_valid) begin
    $display("t=%0t ns, data=%0d, CH0=%0d, CH1=%0d, CH30=%0d, CH31=%0d", 
                $time, adc_data.data, data_reg[0], data_reg[1], data_reg[30], data_reg[31]);
end


endmodule
