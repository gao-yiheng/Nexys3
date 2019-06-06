`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:05:53 04/11/2019 
// Design Name: 
// Module Name:    top_module_fib 
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
module top_module_fib(
    input clk,
    input reset,
    input [7:0] sw,
//  output [7:0] led
	 output [3:0] an,
	 output ca,
	 output cb,
	 output cc,
	 output cd,
	 output ce,
	 output cf,
	 output cg
    );

    // Generic KCPSM6 I/O
    wire	[11:0]	address;
    wire	[17:0]	instruction;
    wire	[7:0]		port_id, out_port;	 
	 wire [7:0]    in_port;
    wire			   write_strobe,  bram_enable;
//    wire       	 k_write_strobe, read_strobe, interrupt_ack;
	 
//    wire			interrupt;            //See note above
//    wire			kcpsm6_sleep;         //See note above
    wire			kcpsm6_reset;         //See note above

    // Some additional signals are required if your system also needs to reset KCPSM6. 
//    wire			cpu_reset;
    wire			rdl;

    // When interrupt is to be used then the recommended circuit included below requires 
    // the following signal to represent the request made from your system.
//    wire			int_request;


    // customized signals
	 reg [7:0] in_data;
    reg [7:0] data_out;



  // Instantiate KCPSM6 and connect to Program Memory
    yg2019p processor (
	  .address 		   (address),
	  .instruction 	(instruction),
	  .instruct_enable(bram_enable),
	  .port_id 		   (port_id),
	  .write_strobe 	(write_strobe),
//	  .k_write_strobe (k_write_strobe),
	  .out_data 		(out_port),
//	  .read_strobe 	(read_strobe),
	  .in_data 		   (in_port),
//	  .interrupt 		(interrupt),
//	  .interrupt_ack 	(interrupt_ack),
	  .reset 		   (kcpsm6_reset),
//	  .sleep		      (kcpsm6_sleep),
	  .clk 			   (clk)); 

    fib_prog #(
	  .C_FAMILY		   ("S6"),   
	  .C_RAM_SIZE_KWORDS	(1),  
	  .C_JTAG_LOADER_ENABLE	(1))  	//Include JTAG Loader when set to '1' 
    program_rom (    				
 	  .rdl 			   (rdl),
	  .enable 		   (bram_enable),
	  .address 		   (address),
	  .instruction 	(instruction),
	  .clk 			   (clk));
	  
	  assign kcpsm6_reset = reset;
	  assign rdl = reset;

	  
//	 assign led = out_port;
    // Output
	 always @ (posedge clk) begin
	     if (write_strobe == 1) begin
		      if (port_id == 3) begin
				    data_out <= out_port;
				end
			end
	  end

    // Input
	 assign in_port = in_data;
	 always @ (posedge clk) begin
//	     if (read_strobe == 1) begin
		      if (port_id == 1) begin
				    in_data <= sw;
				end
//		  end
	 end
//	 assign in_port = sw; 

     bcd_display seg7(
	                  .clk(clk),
                     .rst(rst),
                     .data(data_out),
	                  .an(an),
	                  .ca(ca),
	                  .cb(cb),
	                  .cc(cc),
	                  .cd(cd),
	                  .ce(ce),
	                  .cf(cf),
	                  .cg(cg));

endmodule
