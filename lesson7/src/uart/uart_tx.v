`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/16
// Design Name: 
// Module Name: uart_rx
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

module	uart_tx #(
    parameter baud    = 115200 ,
	parameter check   = 0          
)
(
	input				clk			,
	input				rst_n		,
	
	input				tx_de		,
	input  		[7:0] 	tx_data		,
	
	output	reg	 		tx		    ,
	output  reg  		tx_done     
);

reg	  [7:0]		tx_data_latch	;
reg				tx_flag			;
reg	  [15:0]	baud_cnt		;
reg	  [7:0]		baud_time		;
reg	  			bit_flag		;
reg	  [7:0]		bit_cnt			;
	
wire  		    check_sum   	;
wire  [7:0]     bit_num     	;
wire  [15:0]    baud_end    	;
wire  [15:0]    baud_mid    	;

generate
if (baud==115200) 
	begin: _115200
		assign baud_end = 868;
		assign baud_mid = 434;
	end 
else if (baud==230400) 
	begin: _230400
		assign baud_end = 434;
		assign baud_mid = 217;
	end
else if (baud==460800) 
	begin: _460800
		assign baud_end = 217;
		assign baud_mid = 108;
	end
else if (baud==921600) 
	begin: _921600
		assign baud_end = 108;
		assign baud_mid = 54;
	end			
endgenerate

always@(posedge	clk)
if (!rst_n)
	tx_data_latch <= 0;
else if (tx_de==1'b1)
	tx_data_latch <= tx_data;
else
	tx_data_latch <= tx_data_latch;
	
always@(posedge	clk)
if (!rst_n)
	tx_flag	<= 1'b0;
else if (baud_cnt==baud_end-1&&baud_time==bit_num-1)
	tx_flag	<= 1'b0;
else if (tx_de==1'b1)
	tx_flag	<= 1'b1;
else
	tx_flag	<= tx_flag;

always@(posedge	clk)
if (!rst_n)
	baud_cnt <=	0;
else if (baud_cnt==baud_end-1)
	baud_cnt <=	0;
else if (tx_flag==1'b1)
	baud_cnt <=	baud_cnt + 1'b1;
else
	baud_cnt <=	baud_cnt;

always@(posedge	clk)
if (!rst_n)
	baud_time <= 0;
else if (baud_cnt==baud_end-1&&baud_time==bit_num-1)
	baud_time <= 0;
else if (baud_cnt==baud_end-1)
	baud_time <= baud_time + 1'b1;
else
	baud_time <= baud_time;

always@(posedge	clk)
if (!rst_n)
	bit_flag <=	1'b0;
else if (baud_cnt==baud_mid-1)
	bit_flag <=	1'b1;
else 
	bit_flag <=	1'b0;

always@(posedge	clk)
if (!rst_n)
	bit_cnt	<= 0;
else if (bit_flag==1'b1&&bit_cnt==bit_num-1)
	bit_cnt	<= 0;
else if (bit_flag==1'b1)
	bit_cnt	<= bit_cnt + 1'b1;
else
	bit_cnt	<= bit_cnt;
	
always@(posedge	clk)
if (!rst_n)
	tx_done	<=	1'b0;
else if (baud_cnt==baud_end-1&&baud_time==bit_num-1)
	tx_done	<=	1'b1;
else 
	tx_done	<=	1'b0;	

generate
if (check==0)
	begin: none
		assign check_sum = 0;
		assign bit_num = 10;
		always@(posedge	clk)
			if (!rst_n)
				tx <= 1'b1;
			else if (bit_flag==1'b1)
				case(bit_cnt)
					0:  tx <= 1'b0				;
					1:  tx <= tx_data_latch[0]	;
					2:  tx <= tx_data_latch[1]	;
					3:  tx <= tx_data_latch[2]	;
					4:  tx <= tx_data_latch[3]	;
					5:  tx <= tx_data_latch[4]	;
					6:  tx <= tx_data_latch[5]	;
					7:  tx <= tx_data_latch[6]	;
					8:  tx <= tx_data_latch[7]	;
					9:  tx <= 1'b1				;
				default:tx <= 1'b1	    		;
				endcase
	end 
else if (check==1) 
	begin: odd
		assign bit_num = 11;
		assign check_sum = ~(tx_data_latch[0]+tx_data_latch[1]+tx_data_latch[2]+tx_data_latch[3]+tx_data_latch[4]+tx_data_latch[5]+tx_data_latch[6]+tx_data_latch[7]);
		always@(posedge	clk)
			if (!rst_n)
				tx	<=	1'b1;
			else if (bit_flag==1'b1)
				case(bit_cnt)
					0:	tx <= 1'b0				;
					1:	tx <= tx_data_latch[0]	;
					2:	tx <= tx_data_latch[1]	;
					3:	tx <= tx_data_latch[2]	;
					4:	tx <= tx_data_latch[3]	;
					5:	tx <= tx_data_latch[4]	;
					6:	tx <= tx_data_latch[5]	;
					7:	tx <= tx_data_latch[6]	;
					8:	tx <= tx_data_latch[7]	;
					9:  tx <= check_sum			;
					10:	tx <= 1'b1				;
				default:tx <= 1'b1	   			;
			endcase	
	end 
else
	begin: even
		assign bit_num = 11;
		assign check_sum = tx_data_latch[0]+tx_data_latch[1]+tx_data_latch[2]+tx_data_latch[3]+tx_data_latch[4]+tx_data_latch[5]+tx_data_latch[6]+tx_data_latch[7];
		always@(posedge	clk)
			if (!rst_n)
				tx <= 1'b1;
			else if (bit_flag==1'b1)
				case(bit_cnt)
					0:	tx <= 1'b0				;
					1:	tx <= tx_data_latch[0]	;
					2:	tx <= tx_data_latch[1]	;
					3:	tx <= tx_data_latch[2]	;
					4:	tx <= tx_data_latch[3]	;
					5:	tx <= tx_data_latch[4]	;
					6:	tx <= tx_data_latch[5]	;
					7:	tx <= tx_data_latch[6]	;
					8:	tx <= tx_data_latch[7]	;
					9:  tx <= check_sum			;
					10:	tx <= 1'b1				;
				default:tx <= 1'b1	    		;
			endcase	
	end 	
endgenerate
		

endmodule
