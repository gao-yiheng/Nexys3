`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:27:09 04/03/2019
// Design Name:   top_module
// Module Name:   /home/011/y/yx/yxg171130/microprocessor/lab3/segment/tb_top_module.v
// Project Name:  segment
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_top_module;

	// Inputs
	reg [7:0] SW;
	reg clk;
	reg rst;

	// Outputs
	wire [7:0] LEDs;
	wire [3:0] AN;
	wire CA;
	wire CB;
	wire CC;
	wire CD;
	wire CE;
	wire CF;
	wire CG;

	// Instantiate the Unit Under Test (UUT)
	top_module uut (
		.sw(SW), 
		.led(LEDs), 
		.an(AN), 
		.clk(clk), 
		.rst(rst),
		.ca(CA), 
		.cb(CB), 
		.cc(CC), 
		.cd(CD), 
		.ce(CE), 
		.cf(CF), 
		.cg(CG)
	);
	
	always begin
	    #5 clk = ~clk;
   end
	
//   integer i;
	initial begin
		// Initialize Inputs
		SW = 0;
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
        
		// Add stimulus here
//      for (i=1; i<256; i=i+1) begin
		    SW <= 8'b00010010;
			 #400;
			 SW <= 8'b10100100;
			 #400
			 SW <= 8'b01101111;
			 #400
			 
			 #100;    // wait for last data output
//		end
		
		$stop();

	end
	

      
endmodule

