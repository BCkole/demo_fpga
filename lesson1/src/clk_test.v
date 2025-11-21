`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/13 20:54:56
// Design Name: 
// Module Name: clk_test
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


module clk_test(
	input	clk				
);

wire	clk_out1	;
wire	clk_out2    ;
wire	clk_out3    ;
wire	clk_out4    ;
wire	clk_out5    ;
wire	clk_out6    ;
wire	clk_out7    ;

wire	locked1		;

wire	clk_148p5M	;
wire	locked2		;

clk_global u1_clk_global(  
	.clk_in1		(clk		),

    .clk_out1		(clk_out1	),	
    .clk_out2		(clk_out2	),	
    .clk_out3		(clk_out3	),	
    .clk_out4		(clk_out4	),	
    .clk_out5		(clk_out5	),	
    .clk_out6		(clk_out6	),	
    .clk_out7		(clk_out7	),	

    .locked			(locked1	)
); 

clk_vga u1_clk_vga (
    .clk_in1		(clk_out7	),  
    .clk_out1		(clk_148p5M	), 
    .locked			(locked2	)     
);








endmodule
