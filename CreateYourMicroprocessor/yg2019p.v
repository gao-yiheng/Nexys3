`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:18:12 04/11/2019 
// Design Name: 
// Module Name:    yg2019p 
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
module yg2019p(
    input clk,
    input reset,
    input [17:0] instruction,
    input [7:0] in_data,
//	 output read_strobe,
	 output instruct_enable,
	 output [11:0] address,
	 output write_strobe,
    output reg [7:0] out_data,
    output reg [7:0] port_id
    );

	 localparam INPUT   = 6'b001001;
	 localparam OUTPUT  = 6'b101101;	

//    reg [7:0] read_data;
	 
    // control signal for PC module	 
	 wire pc_enable;    
	 wire pc_jump;

	 wire alu_carry, alu_zero;
	 wire alu_operand_sel;
	 wire alu_en;
    wire [3:0] alu_operate;
	 wire [7:0] alu_result;
	 reg  [7:0] alu_operand2;
	 
	 wire io_write_en;
	 wire io_read_en;
	 wire io_en;
	 
    wire rf_write_en;
	 wire rf_read_en;
	 wire [1:0] rf_w_data_src;
	 reg  [7:0] rf_write_data;
	 wire [7:0] rf_read1_data;
	 wire [7:0] rf_read2_data;


//    assign alu_carry = 1;   // for debug only
//    assign alu_zero = 0;	 // temporary for debug only
	 control_unit ctrl_unit (
	                         .clk(clk), 
									 .reset(reset), 
									 .op_code(instruction[17:12]), 
									 .carry(alu_carry),
									 .zero(alu_zero),
									 .instruction_en(instruct_enable),	
									 .pc_en(pc_enable),	
									 .alu_en(alu_en),
									 .io_read_en(io_read_en),	
									 .rf_write_en(rf_write_en),
                            .rf_read_en(rf_read_en),									 
									 .rf_w_data_src(rf_w_data_src),									 
									 .alu_operand_sel(alu_operand_sel),
									 .alu_operate(alu_operate),
									 .io_write_en(io_write_en),
									 .pc_jump(pc_jump)
									 );
									 
    // Decide source of 2nd operand
	 always @ (*) begin
        if (alu_operand_sel == 0)
		      alu_operand2 = rf_read2_data;
		  else
		      alu_operand2 = instruction[7:0];
    end	 
    alu alu_unit (
//	               .clk(clk),
						.reset(reset),
						.enable(alu_en),
						.opcode(alu_operate),
						.operand1(rf_read1_data),
						.operand2(alu_operand2),
						.result(alu_result),
						.zero(alu_zero),
						.carry(alu_carry)
						);

									 
	 // Dealing with I/O
	 assign write_strobe = io_write_en;
	 always @ (posedge io_write_en) begin
	         out_data <= rf_read1_data;
	 end
	 always @ (*) begin
	     if (instruction[17:12] == INPUT || instruction[17:12] == OUTPUT)
		      port_id = instruction[7:0];
	 end

    // Select write data source
	 always @ (*) begin
	     case (rf_w_data_src)
		      2'b00: rf_write_data = in_data;             // Read from io port
				2'b01: rf_write_data = instruction[7:0];    // Read an instance number
				2'b10: rf_write_data = rf_read2_data;       // Read a register
				default: rf_write_data = alu_result;        // Revise when ALU added!!!!!!!!!!!!!!!!!!
		  endcase
	 end
    reg_file register_file (
									 .write_en(rf_write_en),
									 .read_en(rf_read_en),
									 .write_addr(instruction[11:8]),
									 .write_data(rf_write_data),
									 .read1_addr(instruction[11:8]),
									 .read2_addr(instruction[7:4]),
									 .read1_data(rf_read1_data),
									 .read2_data(rf_read2_data)
									 );
								 	
	 
	 pc program_counter (
								.enable(pc_enable),
								.reset(reset), 
								.jump(pc_jump),
								.jump_address(instruction[11:0]), 
								.address(address)
								);

endmodule
