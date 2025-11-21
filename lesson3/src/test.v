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

module test #(
	parameter [15:0] e = 10,
	parameter [15:0] g = 20
)
(
	input	clk		,
	input	rst_n	
);

reg	 	[7:0] 	a  		;
wire	[1:0] 	b  		;
reg		[1:0] 	c  		;
reg			  	d  		;
wire	[15:0]	f  		;
wire	[15:0]	h  		;

reg		[15:0]  j  		;
reg		[15:0]  k  		;
reg		[1:0] 	l  		;
reg 	[1:0]	m		;
reg		[7:0]	n = 1	;
reg 	[7:0]	o = 2	;

reg		[7:0]	p = 1	;
reg 	[7:0]	q = 2	;

reg		[7:0]	s = 1	;
reg 	[7:0]	t = 2	;
reg 	[7:0]	u = 3	;
reg 	[7:0]	v = 4	;

reg 	[7:0]	w		;
reg 	[7:0]	x		;

always@(posedge clk)
if (!rst_n)
	a <= 0;
else
	a <= a + 1'b1;

assign b = (a==20) ? 1'b1 : 1'b0;

always@(*)
if (a==20)
	c = 2'b01;
else if (a==21)
	c = 2'b10;
else if (a==22)
	c = 2'b11;	
else
	c = 2'b00;

always@(posedge clk)
if (a==20)
	d <= 1'b1;
else
	d <= 1'b0;

assign f = e;
assign h = g;

localparam i = 60;

always@(posedge clk)
if (a==20) begin
	j <= 1;
	k <= 1;
end
else begin
	j <= 0;
	k <= 0;
end

// always@(*)
// case (a)
// 	20:l = 2'b01;
// 	21:l = 2'b10;
// 	22:l = 2'b11;
// 	default:l = 2'b00;
// endcase

always@(posedge clk)
case (a)
	20:l = 2'b01;
	21:l = 2'b10;
	22:l = 2'b11;
	default:l = 2'b00;
endcase

// always@(posedge clk)
// case (a)
// 	20:m <= 2'b01;
// 	21:m <= 2'b10;
// 	22:m <= 2'b11;
// 	default:m <= 2'b00;
// endcase

always@(*)
case (a)
	20:m <= 2'b01;
	21:m <= 2'b10;
	22:m <= 2'b11;
	default:m <= 2'b00;
endcase

always@(posedge clk) begin
    n = o;
    o = n;
end

always@(posedge clk) begin
    p <= q;
    q <= p;
end

always@(posedge clk) begin
    s = t;
    t = s;
	u <= t;
	v <= s;
end

always@(posedge clk)
if (!rst_n)
	w <= 0;
else
	w <= a;

always@(negedge clk)
if (!rst_n)
	x <= 0;
else
	x <= a;


endmodule
