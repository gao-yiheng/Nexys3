`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:52:45 04/03/2019 
// Design Name: 
// Module Name:    bcd_display 
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
module bcd_display(
    input clk,
    input rst,
    input [7:0] data,
	 output [3:0] an,
	 output ca,
	 output cb,
	 output cc,
	 output cd,
	 output ce,
	 output cf,
	 output cg
    );

    wire [3:0] thous;
    wire [3:0] huns;
    wire [3:0] tens;
    wire [3:0] ones;
	 
	 reg [3:0] digit;
	 reg [2:0] count;
	 reg [10:0] divide;
	 reg [3:0] an_ini;
	 
	 
	 always @ (posedge clk) begin
	     if (rst == 1'b1) begin
		      count <= 3'b000;
				divide <= 11'd0;
		  end
		  else begin
		      if (divide == 2000) begin
				    divide <= 11'd0;
		          count <= count + 1;
				    if(count == 3'h4)
				        count <= 3'b001;
				end
				else begin
				    divide <= divide + 1;
				end
		  end
	 end
	 
	 always @ (*) begin
	     an_ini = 4'b1111;
		  if (count == 3'h1) begin
		      digit = ones;
				an_ini[0] = 0;
		  end

/*		  else  begin
		      digit = tens;
//            digit = 4'h7;
				an_ini[1] = 0;
		  end
*/
		  else if (count == 3'h2) begin
		      digit = tens;
				an_ini[1] = 0;
		  end
		  else if (count == 3'h3) begin
		      digit = huns;
				an_ini[2] = 0;
		  end
		  else if (count == 3'h4) begin
		      digit = thous;
				an_ini[3] = 0;
		  end
		  else begin
		      digit = 4'h0;
		  end
	 end
	 assign an = an_ini;
	 
    number_decoder num_decoder (
	                             .data(data),
										  .thous(thous),
										  .huns(huns),
										  .tens(tens),
										  .ones(ones));

    seg7_decoder sgement_decoder(
	              .digit(digit), 
					  .ca(ca), 
					  .cb(cb), 
					  .cc(cc), 
					  .cd(cd), 
					  .ce(ce), 
					  .cf(cf), 
					  .cg(cg));
	
endmodule
