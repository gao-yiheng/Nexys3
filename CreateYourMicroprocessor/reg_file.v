`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:17:03 04/15/2019 
// Design Name: 
// Module Name:    reg_file 
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
module reg_file(
    input write_en,
	 input read_en,
    input [3:0] write_addr,
    input [3:0] read1_addr,
    input [3:0] read2_addr,	 
	 input [7:0] write_data,
    output reg [7:0] read1_data,
    output reg [7:0] read2_data
    );

    
	 // 16 registers with 8-bit width
    reg [7:0] register_file [0:15];
	 
	 always @ (posedge write_en or posedge read_en) begin
	     if (write_en == 1) begin
		      register_file[write_addr] <= write_data;
		  end
		  else begin
		      read1_data <= register_file[read1_addr];
				read2_data <= register_file[read2_addr];
		  end
	 end

endmodule
