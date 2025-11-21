`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/21 21:57:32
// Design Name: 
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

reg	sys_clk;

initial begin
	
sys_clk = 0;

end

always #10 sys_clk = ~sys_clk;

sg_ram_test u1_sg_ram_test (
	.sys_clk (sys_clk)			
);





    
endmodule
