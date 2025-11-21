`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/13 14:56:22
// Design Name: 
// Module Name: ram_mem_tb
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


module ram_mem_tb();

parameter NUM = 16	;
parameter cl = 8	;	

reg                 clk_100M        		;
reg                 rst_n           		;
reg     [7:0]       cnt             		;
reg                 en              		;
wire				data_valid				;		
// wire	[NUM-1:0]	data_adc	[cl-1:0]	;

wire	[NUM*cl-1:0]data_adc                ;
// reg	    [NUM-1:0]	data_reg	[cl-1:0]	;

reg                 rd_en                   ;
wire	[NUM-1:0]	data_out		        ;
wire                rd_vaild                ;
wire                addr_done               ;

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

// genvar i;
// generate
// for (i = 0; i < cl; i = i + 1)
// begin : chan
//     assign data_reg[i] = data_valid ? data_adc[i*NUM +: NUM] : 'd0;
// end
// endgenerate

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

always@(posedge clk_100M or negedge rst_n)
if (!rst_n)
    rd_en <= 'd0;
else if (cnt == 230)
    rd_en <= 1'b1;
else
    rd_en <= 'd0;

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

ram_mem #(
	.NUM	(NUM	),
	.cl		(cl		)		
)ram_mem(
	.clk			(clk_100M	),
	.rst_n			(rst_n		),

    .data_valid		(data_valid ),
    .data_adc		(data_adc   ),

	.cl_num			(1          ),
	.rd_en			(rd_en      ),
    .addr_done      (addr_done  ),
    .data_done      (data_done  ),
    .rd_vaild       (rd_vaild   ),
	.data_out		(data_out   )	
);



endmodule
