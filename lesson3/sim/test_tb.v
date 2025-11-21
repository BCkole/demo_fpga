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

reg		clk		;
reg     rst_n	;

initial begin
	clk   = 0;
	rst_n = 0;
	
	#95
	
	rst_n = 1;
end

always #5 clk = ~clk;

test #(
	.e	(16'd5),
	.g  (16'd30)
) 
u1_test(
	.clk	(clk	),
	.rst_n	(rst_n	)
);






    
endmodule
