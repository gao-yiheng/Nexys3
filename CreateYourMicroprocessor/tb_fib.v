`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:11:30 04/11/2019
// Design Name:   top_module_fib
// Module Name:   /home/011/y/yx/yxg171130/microprocessor/final_proj/testbench/tb_fib.v
// Project Name:  testbench
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_module_fib
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_fib;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] sw;

	// Outputs
	wire [7:0] led;

	// Instantiate the Unit Under Test (UUT)
	top_module_fib uut (
		.clk(clk), 
		.reset(reset), 
		.sw(sw), 
		.an(AN), 
		.ca(CA), 
		.cb(CB), 
		.cc(CC), 
		.cd(CD), 
		.ce(CE), 
		.cf(CF), 
		.cg(CG)
//		.led(led)
	);

   always begin
	   #5 clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		sw = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0;
        
		// Add stimulus here
//      for (i=1; i<256; i=i+1) begin
		    sw <= 8'b00000010;
			 #400;
			 sw <= 8'b00000100;
			 #400
			 sw <= 8'b00000111;
			 #400
			 
			 #10000;    // wait for last data output
//		end
		
		$stop();

	end
      
endmodule

