`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:51:35 04/12/2019 
// Design Name: 
// Module Name:    control_unit 
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
module control_unit(
    input clk,
	 input reset,
    input [5:0] op_code,
	 input carry,
	 input zero,
	 
    output reg instruction_en,    // read instruction from instruction memory
	 output reg pc_en,             // calculate next address
    output reg alu_en,	          
	 output reg rf_write_en,	 
	 output reg rf_read_en,
	 output reg io_write_en,
	 output reg io_read_en,	 
	 
    output reg pc_jump,           // set if JUMP instruction
	 output reg [3:0] alu_operate,
	 output reg alu_operand_sel,
	 output reg [1:0] rf_w_data_src
    );

    // FSM parameters
	 localparam Reset   = 3'b000;
    localparam Fetch   = 3'b001;
    localparam Decode  = 3'b010;	 
	 localparam Execute = 3'b011;
	 localparam Wback   = 3'b111;
	 localparam Alu     = 3'b101;
	 
	 // Instruction parameters
	 localparam JUMP    = 6'b100010;
	 localparam JUMPC   = 6'b111010;
	 localparam JUMPZ   = 6'b110010;
	 localparam INPUT   = 6'b001001;
	 localparam OUTPUT  = 6'b101101;	 
	 localparam LOADI   = 6'b000001;
	 localparam LOADR   = 6'b000000;
	 localparam ADDI    = 6'b010001;
	 localparam ADDR    = 6'b010000;
	 localparam COMPARE = 6'b011101;
	 localparam SUB     = 6'b011001;
	 
    reg [2:0] state;
	
	 // Mealy FSM, Next-State Logic	
	 always @ (posedge clk) begin
	     if (reset == 1)
		      state <= Reset;
		  else begin
		      case (state)			
				    Reset:
					     state <= Fetch;
					 Fetch:
					     state <= Decode;
					 Decode:
					     state <= Execute;
					 Execute:
					     if (op_code == LOADR
							 ||op_code == OUTPUT
							 ||op_code == INPUT
							   ) begin
					         state <= Wback;
						  end
						  else if (op_code == ADDI 
						    ||op_code == ADDR
							 ||op_code == SUB
							 ||op_code == COMPARE)
							   state <= Alu;
						  else begin
						      state <= Fetch;
						  end
					 Alu:
					     if (op_code == COMPARE)
						      state <= Fetch;
						  else
						      state <= Wback;
					 Wback:
					     state <= Fetch;
				 endcase
		  end
	 end
	 
	 
	 // Generate enable signal for each component
	 always @ (*) begin
	 
	     if (state == Fetch)
		      instruction_en = 1'b1;
		  else
     		   instruction_en = 1'b0;
		  
		  if (state == Execute)
		      pc_en = 1'b1;
		  else
		      pc_en = 1'b0;
				
		  if (state == Wback 
		   ||(state == Execute && op_code == LOADI)
			  )
			   rf_write_en = 1'b1;
		  else
		      rf_write_en = 1'b0;
		  
		  if (state == Execute && (op_code == LOADR || op_code == OUTPUT || op_code == ADDI || op_code == ADDR || op_code == SUB || op_code == COMPARE))
		      rf_read_en = 1'b1;
		  else 
		      rf_read_en = 1'b0;
		  
				
		  if (state == Alu)
		      alu_en = 1'b1;
		  else
		      alu_en = 1'b0;
			
		  if (state == Wback && op_code == OUTPUT)
		      io_write_en = 1'b1;
		  else
		      io_write_en = 1'b0;

	 end
	 
	 
	 // Generate control signals	
	 always @ (*) begin
	     
		  // pc_jump
        if ((op_code == JUMP)
          ||(op_code == JUMPC && carry == 1)
          ||(op_code == JUMPZ && zero == 1)) 
        begin
            pc_jump = 1'b1;
		  end
        else begin
				pc_jump = 1'b0;
        end
		  
		  // I/O read enable
		  if (op_code == INPUT)
		      io_read_en = 1'b1;
		  else
		      io_read_en = 1'b0;
				
		  
		  // rf_w_data_src[1:0]
		  if (op_code == INPUT)
		      rf_w_data_src = 2'b00;    // Data from input port
		  else if (op_code == LOADI)
				rf_w_data_src = 2'b01;    // Data from instruction[7:0]
		  else if (op_code == LOADR)
				rf_w_data_src = 2'b10;    // Data from Register File, Read2 port
		  else
				rf_w_data_src = 2'b11;    // Data from ALU result

        // ALU operand
		  if (op_code == ADDI || op_code == ADDR)
		      alu_operate = 4'b0000;
		  else
				alu_operate = 4'b0001;
				
		  // ALU 2nd operator select
		  if (op_code == ADDI || op_code == SUB || op_code == COMPARE)
		      alu_operand_sel = 1'b1;
		  else
				alu_operand_sel = 1'b0;
								
	end
	
	 
endmodule
