`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:58:35 03/26/2019
// Design Name:   led_top
// Module Name:   /home/011/y/yx/yxg171130/microprocessor/lab3/pico_test/led_tb.v
// Project Name:  pico_test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: led_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module led_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [7:0] led;

	// Instantiate the Unit Under Test (UUT)
	led_top uut (
		.clk(clk), 
		.led(led),
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
      rst = 1;
		
		// Wait 100 ns for global reset to finish
		#40;
        
		rst = 0;
		// Add stimulus here

	end
	
	always begin
	    #10 clk = ~clk;
	end
      
endmodule

