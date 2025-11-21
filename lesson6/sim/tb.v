`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/14 
// Design Name: BCKL
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 

//////////////////////////////////////////////////////////////////////////////////


module tb();

reg	clk 	;
reg rst_n 	;

integer outfile;

initial begin
	clk 	= 0;	
    rst_n 	= 0;
	#20
	rst_n   = 1;
	
	outfile = $fopen("D:/Users/BCKL/Desktop/FILE/Stereo_camera/lesson/Num1/lesson0/data/post.txt","w");
end

always #5 clk = ~clk;

wire			vs		;		
wire			de		;
wire	[7:0]	data	;

img_gen 
#(
	.ACTIVE_IW (640),
	.ACTIVE_IH (480),
	.TOTAL_IW  (800),
	.TOTAL_IH  (525),
	.H_START   (143), 
	.V_START   (34 )  
)
u1_img_gen
( 
	.clk		(clk	),
	.rst_n		(rst_n	), 
	.vs			(vs		), 
	.de			(de		),
	.data		(data	)
);

reg	vs_r;

always@(posedge clk)
if (!rst_n)
	vs_r <= 1'b0;
else
	vs_r <= vs;

// always@(posedge clk)
// if (~vs && vs_r)
// 	$stop; 	
// else if (de == 1)
// 	$fdisplay(outfile, "%h", data);
		
always@(posedge clk)
if (~vs && vs_r)
	$stop;	
else if (de == 1)
	$fdisplay(outfile, "%h", data> 128 ? 8'd255:8'd0);
    
endmodule
