`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:02:41 04/16/2019 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input reset,
	 input enable,
    input [3:0] opcode,
    input [7:0] operand1,
    input [7:0] operand2,
    output reg [7:0] result,
    output reg zero,
    output reg carry
    );

    localparam ADD = 4'b0000;
	 localparam SUB = 4'b0001;
	 
    always @ (posedge enable or posedge reset) begin
	     if (reset == 1) begin
		      result = 8'b0;
				zero = 1'b0;
				carry = 1'b0;
		  end
		  
		  else begin
		      case (opcode)
				    ADD: begin
					     {carry,result} = operand1 + operand2;
						  zero = 1'b0;
					 end
					 SUB: begin
					     {carry,result} = operand1 - operand2;
							if (operand1 == operand2)
								 zero = 1'b1;
							else
								 zero = 1'b0;
					 end
				endcase
				

			end
			
	 end
	 
endmodule
