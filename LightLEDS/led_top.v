`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:45:26 03/26/2019 
// Design Name: 
// Module Name:    led_top 
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
module led_top(
    input clk,
	 input rst,
    output [7:0] led
    );

//
// Signals for connection of KCPSM6 and Program Memory.
//
wire	[11:0]	address;
wire	[17:0]	instruction;
wire			bram_enable;
wire	[7:0]		port_id;
wire	[7:0]		out_port;
reg	[7:0]		in_port;
wire			write_strobe;
wire			k_write_strobe;
wire			read_strobe;
wire			interrupt;            //See note above
wire			interrupt_ack;
wire			kcpsm6_sleep;         //See note above
wire			kcpsm6_reset;         //See note above

//
// Some additional signals are required if your system also needs to reset KCPSM6. 
//

wire			cpu_reset;
wire			rdl;

//
// When interrupt is to be used then the recommended circuit included below requires 
// the following signal to represent the request made from your system.
//

wire			int_request;

// customized signals
reg [7:0] output_port2;

//
///////////////////////////////////////////////////////////////////////////////////////////
// Circuit Descriptions
///////////////////////////////////////////////////////////////////////////////////////////
//

  //
  /////////////////////////////////////////////////////////////////////////////////////////
  // Instantiate KCPSM6 and connect to Program Memory
  /////////////////////////////////////////////////////////////////////////////////////////
  //
  // The KCPSM6 parameters can be defined as required but the default values are shown below
  // and these would be adequate for most designs.
  //

  kcpsm6 #(
	.interrupt_vector	(12'h3FF),
	.scratch_pad_memory_size(64),
	.hwbuild		(8'h00))
  processor (
	.address 		(address),
	.instruction 	(instruction),
	.bram_enable 	(bram_enable),
	.port_id 		(port_id),
	.write_strobe 	(write_strobe),
	.k_write_strobe 	(k_write_strobe),
	.out_port 		(out_port),
	.read_strobe 	(read_strobe),
	.in_port 		(in_port),
	.interrupt 		(interrupt),
	.interrupt_ack 	(interrupt_ack),
	.reset 		(kcpsm6_reset),
	.sleep		(kcpsm6_sleep),
	.clk 			(clk)); 

  //
  // In many designs (especially your first) interrupt and sleep are not used.
  // Tie these inputs Low until you need them. 
  // 

  assign kcpsm6_sleep = 1'b0;
  assign interrupt = 1'b0;

  //
  // The default Program Memory recommended for development.
  // 
  // The generics should be set to define the family, program size and enable the JTAG
  // Loader. As described in the documentation the initial recommended values are.  
  //    'S6', '1' and '1' for a Spartan-6 design.
  //    'V6', '2' and '1' for a Virtex-6 design.
  // Note that all 12-bits of the address are connected regardless of the program size
  // specified by the generic. Within the program memory only the appropriate address bits
  // will be used (e.g. 10 bits for 1K memory). This means it that you only need to modify 
  // the generic when changing the size of your program.   
  //
  // When JTAG Loader updates the contents of the program memory KCPSM6 should be reset 
  // so that the new program executes from address zero. The Reset During Load port 'rdl' 
  // is therefore connected to the reset input of KCPSM6.
  //

  led_prog #(
	.C_FAMILY		   ("S6"),   	//Family 'S6' or 'V6'
	.C_RAM_SIZE_KWORDS	(1),  	//Program size '1', '2' or '4'
	.C_JTAG_LOADER_ENABLE	(1))  	//Include JTAG Loader when set to '1' 
  program_rom (    				//Name to match your PSM file
 	.rdl 			(kcpsm6_reset),
	.enable 		(bram_enable),
	.address 		(address),
	.instruction 	(instruction),
	.clk 			(clk));
	
//  assign kcpsm6_reset = cpu_reset | rdl;
	 
    always @ (posedge clk)
	 begin
		if(rst)
		  output_port2 <= 8'b0;
		else
		  if(write_strobe == 1'b1) begin
  	       if(port_id == 2) begin
		      output_port2 <= out_port;
		    end
		  end
		
	  end
	  
	assign led = output_port2;


endmodule
