`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/20
// Design Name: BCKL
// Module Name: tb
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

module tb();

reg		sys_clk		;

initial begin 
	sys_clk = 0;
end

always #10 sys_clk = ~sys_clk;

top u1_top(
	.sys_clk	(sys_clk)						
);


endmodule
