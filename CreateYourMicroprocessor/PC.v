`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:22:34 04/12/2019 
// Design Name: 
// Module Name:    PC 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pc(
    input reset,
	 input enable,
    input jump,
	 input [9:0] jump_address,
    output reg [11:0] address
    ); 
	 
    always @ (posedge enable or posedge reset) begin
	     if (reset == 1) begin
		      address <= 12'h000;
		  end
		  else begin
		      if (jump == 1)
		          address <= jump_address;
		      else
		          address <= address + 1;
		  end
	 end
	 
endmodule
