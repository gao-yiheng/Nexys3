`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:45:26 04/03/2019 
// Design Name: 
// Module Name:    top_module 
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
module top_module(
    input clk,
	 input rst,
	 input [7:0] sw,
    output [7:0] led,
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
    wire	[7:0]		port_id, out_port, in_port;	 
    wire			   bram_enable, write_strobe, k_write_strobe, read_strobe, interrupt_ack;
	 
    wire			interrupt;            //See note above
    wire			kcpsm6_sleep;         //See note above
    wire			kcpsm6_reset;         //See note above

    // Some additional signals are required if your system also needs to reset KCPSM6. 
    wire			cpu_reset;
    wire			rdl;

    // When interrupt is to be used then the recommended circuit included below requires 
    // the following signal to represent the request made from your system.
    wire			int_request;


    // customized signals
	 reg [7:0] in_data;
    reg [7:0] led_out;
	 reg [7:0] seg_out;


  // Instantiate KCPSM6 and connect to Program Memory
    kcpsm6 #(
	  .interrupt_vector	(12'h3FF),
	  .scratch_pad_memory_size(64),
	  .hwbuild		(8'h00))
    processor (
	  .address 		   (address),
	  .instruction 	(instruction),
	  .bram_enable 	(bram_enable),
	  .port_id 		   (port_id),
	  .write_strobe 	(write_strobe),
	  .k_write_strobe (k_write_strobe),
	  .out_port 		(out_port),
	  .read_strobe 	(read_strobe),
	  .in_port 		   (in_port),
	  .interrupt 		(interrupt),
	  .interrupt_ack 	(interrupt_ack),
	  .reset 		   (kcpsm6_reset),
	  .sleep		      (kcpsm6_sleep),
	  .clk 			   (clk)); 

    seg7_prog #(
	  .C_FAMILY		   ("S6"),   
	  .C_RAM_SIZE_KWORDS	(1),  
	  .C_JTAG_LOADER_ENABLE	(1))  	//Include JTAG Loader when set to '1' 
    program_rom (    				
 	  .rdl 			   (rdl),
	  .enable 		   (bram_enable),
	  .address 		   (address),
	  .instruction 	(instruction),
	  .clk 			   (clk));
	  
	  assign kcpsm6_reset = rst;
	  assign rdl = rst;
	  assign kcpsm6_sleep = 1'b0;
	  assign interrupt = 1'b0;
	  

    // Read input from switch
	 assign in_port = in_data;
	 always @ (posedge clk) begin
        if(port_id == 8'h01)
            in_data <= sw;
    end
	 
	 // Output result to led & segment
    always @ (posedge clk) begin
	     if(rst == 1'b1) begin
		      led_out <= 8'b0;
				seg_out <= 8'b0;
		  end
		  
        if(write_strobe == 1'b1) begin
		      // Send data to led
  	         if(port_id == 8'h03) begin
		          led_out <= out_port;
		      end
				else if (port_id == 8'h02) begin
				    seg_out <= out_port;
				end
		  end
	  end
	  
	  assign led = led_out;

     bcd_display seg7(
	                  .clk(clk),
                     .rst(rst),
                     .data(seg_out),
	                  .an(an),
	                  .ca(ca),
	                  .cb(cb),
	                  .cc(cc),
	                  .cd(cd),
	                  .ce(ce),
	                  .cf(cf),
	                  .cg(cg));

endmodule