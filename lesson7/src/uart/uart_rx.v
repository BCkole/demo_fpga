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

module	uart_rx #(
    parameter baud    = 115200 ,
	parameter check   = 0   
)
(
	input	       		clk			,
	input	       		rst_n		,
	
	input	       		rx			,
	
	output	reg		    rx_de 		,
	output	reg [7:0]	rx_data	
);	

reg				rx_r1		; 
reg     		rx_r2   	;
reg				rx_r3   	;

wire    		rx_nege    	;
					
reg				rx_flag		;

wire    [7:0]   bit_num     ;
wire       		check_sum   ;
			
wire  	[15:0]  baud_end    ;
wire  	[15:0]  baud_mid    ;
                            
reg  	[15:0]	baud_cnt	;
reg	    [7:0]	baud_time   ;   		
reg				bit_flag	;
reg  	[7:0]	bit_cnt		;

reg				recv_de		;
reg  	[7:0]	recv_data	;

generate
if (check==0) 
	begin: none
		assign bit_num = 10;
		assign check_sum = 0;
	end 
else if (check==1) 
	begin: odd
		assign bit_num = 11;
		assign check_sum = ~(recv_data[0]+recv_data[1]+recv_data[2]+recv_data[3]+recv_data[4]+recv_data[5]+recv_data[6]+recv_data[7]);
	end
else
	begin: even
		assign bit_num = 11;
		assign check_sum = recv_data[0]+recv_data[1]+recv_data[2]+recv_data[3]+recv_data[4]+recv_data[5]+recv_data[6]+recv_data[7];
	end	
endgenerate

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
	begin
		rx_r1 <= 1'b1;
		rx_r2 <= 1'b1;
		rx_r3 <= 1'b1;
	end
else
	begin
		rx_r1 <= rx	   ;
		rx_r2 <= rx_r1 ;
		rx_r3 <= rx_r2 ;
	end

assign rx_nege = ~rx_r2&&rx_r3;		
	
always@(posedge	clk)
if (!rst_n)
	rx_flag	<= 1'b0;
else if (baud_cnt==baud_end-1&&baud_time==bit_num-1)
	rx_flag	<= 1'b0;		
else if (rx_nege==1'b1)
	rx_flag	<= 1'b1;
else 
	rx_flag	<= rx_flag;

always@(posedge	clk)
if (!rst_n)
	baud_cnt <=	0;
else if (baud_cnt==baud_end-1)
	baud_cnt <=	0;
else if (rx_flag==1'b1)
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
	recv_de <= 1'b0;
else if (bit_flag==1'b1&&bit_cnt==8)
	recv_de <= 1'b1;
else
	recv_de <= 1'b0;

always@(posedge	clk)
if (!rst_n)
	recv_data <= 0;
else if (bit_flag==1'b1&&bit_cnt>=1&&bit_cnt<=8)
	recv_data <= {rx,recv_data[7:1]};
else
	recv_data <= recv_data;
	
always@(posedge	clk)
if (!rst_n)
	rx_de <= 1'b0;
else if (recv_de==1'b1&&check==0)
	rx_de <= 1'b1;
else if (bit_flag==1'b1&&bit_cnt==bit_num-2&&check_sum==rx&&check!=0)
	rx_de <= 1'b1;
else
	rx_de <= 1'b0;

always@(posedge	clk)
if (!rst_n)
	rx_data <= 0;
else if (recv_de==1'b1&&check==0)
	rx_data <= recv_data;	
else if (bit_flag==1'b1&&bit_cnt==bit_num-2&&check_sum==rx&&check!=0)
	rx_data <= recv_data;
else
	rx_data <= rx_data;

		
		
		

endmodule



