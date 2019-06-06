`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:20:59 04/03/2019 
// Design Name: 
// Module Name:    number_decode 
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
module number_decoder(
    input [7:0] data,
    output reg [3:0] thous,
    output reg [3:0] huns,
    output reg [3:0] tens,
    output reg [3:0] ones
    );
	 
	 
    integer i;
//	 reg [4:0] th1;
//	 reg [4:0] h1;
	 reg [4:0] t1;
//	 reg [4:0] o1;

	 reg [4:0] th0;
	 reg [4:0] h0;
	 reg [4:0] t0;
	 reg [4:0] o0;
	
	 always @ (*) begin
        th0 = 0;
		  h0 = 0;
		  t0 = 0;
		  o0 = 0;
        if(data[7] == 1) begin
            th0 = th0+0; h0=h0+1; t0=t0+2; o0=o0+8;
			   if(o0 >= 10) begin
			       o0 = o0 - 10;
			       t1 = t1 + 1;
			       if(t1 >= 10) begin
			           t0 = t0 - 10;
				        h0 = h0 + 1;
				            if(h0 >=10) begin
				                h0 = h0 - 10;
					             th0 = th0 + 1;
				            end
			           end
			       end
		      end
        if(data[6] == 1) begin
            th0 = th0+0; h0=h0+0; t0=t0+6; o0=o0+4;
			   if(o0 >= 10) begin
			       o0 = o0 - 10;
			       t0 = t0 + 1;
			       if(t0 >= 10) begin
			           t0 = t0 - 10;
				        h0 = h0 + 1;
				        if(h0 >=10) begin
				            h0 = h0 - 10;
					         th0 = th0 + 1;
				        end
			       end
			   end
		  end
        if(data[5] == 1) begin
			   th0 = th0+0; h0=h0+0; t0=t0+3; o0=o0+2;
			   if(o0 >= 10) begin
			       o0 = o0 - 10;
			       t0 = t0 + 1;
			       if(t0 >= 10) begin
			           t0 = t0 - 10;
				        h0 = h0 + 1;
				        if(h0 >=10) begin
				            h0 = h0 - 10;
					         th0 = th0 + 1;
				        end
			       end
			   end
		  end
        if(data[4] == 1) begin
			   th0 = th0+0; h0=h0+0; t0=t0+1; o0=o0+6;
			   if(o0 >= 10) begin
			       o0 = o0 - 10;
			       t0 = t0 + 1;
			       if(t0 >= 10) begin
			           t0 = t0 - 10;
				        h0 = h0 + 1;
				        if(h0 >=10) begin
				            h0 = h0 - 10;
					         th0 = th0 + 1;
				        end
			       end
			   end
		  end
        if(data[3] == 1) begin
			   th0 = th0+0; h0=h0+0; t0=t0+0; o0=o0+8;
			   if(o0 >= 10) begin
			       o0 = o0 - 10;
			       t0 = t0 + 1;
			       if(t0 >= 10) begin
			           t0 = t0 - 10;
				        h0 = h0 + 1;
				        if(h0 >=10) begin
				            h0 = h0 - 10;
					         th0 = th0 + 1;
				        end
			       end
			   end
		  end
        if(data[2] == 1) begin
			   th0 = th0+0; h0=h0+0; t0=t0+0; o0=o0+4;
			   if(o0 >= 10) begin
			       o0 = o0 - 10;
			       t0 = t0 + 1;
			       if(t0 >= 10) begin
			           t0 = t0 - 10;
				        h0 = h0 + 1;
				        if(h0 >=10) begin
				            h0 = h0 - 10;
					         th0 = th0 + 1;
				        end
			       end
			   end
		  end
        if(data[1] == 1) begin
			   th0 = th0+0; h0=h0+0; t0=t0+0; o0=o0+2;
			   if(o0 >= 10) begin
			       o0 = o0 - 10;
			       t0 = t0 + 1;
			       if(t0 >= 10) begin
			           t0 = t0 - 10;
				        h0 = h0 + 1;
				        if(h0 >=10) begin
				            h0 = h0 - 10;
					         th0 = th0 + 1;
				        end
			       end
			   end
		  end
        if(data[0] == 1) begin
			   th0 = th0+0; h0=h0+0; t0=t0+0; o0=o0+1;
			   if(o0 >= 10) begin
			       o0 = o0 - 10;
			       t0 = t0 + 1;
			       if(t0 >= 10) begin
			           t0 = t0 - 10;
				        h0 = h0 + 1;
				        if(h0 >=10) begin
				            h0 = h0 - 10;
					         th0 = th0 + 1;
				        end
			       end
			   end
		  end
    end

    always @ (*) begin
		  thous = th0[3:0];
		  huns = h0[3:0];
		  tens = t0[3:0];
		  ones = o0[3:0];
	 end

endmodule
