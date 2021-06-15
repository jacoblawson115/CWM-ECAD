//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design a LED based lighting solution, 
//  following the diagram provided in the exercises documentation. The lights change 
//  as long as a button is pressed, and stay the same when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           colour [2:0]
//
//  You need to write the whole file.
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module leds (
// declare inputs
    input clk, rst, button,
    output reg [2:0]colour
    );

    always @ (posedge clk or posedge rst)
        if(rst)
	     colour = 3'b001;
	begin
	case(colour)
	     3'b000 : colour<=3'b001;
	     3'b001 : colour = (button==1) ? 3'b010 : colour;
             3'b010 : colour = (button==1) ? 3'b011 : colour;
             3'b011 : colour = (button==1) ? 3'b100 : colour;
             3'b100 : colour = (button==1) ? 3'b101 : colour;
             3'b101 : colour = (button==1) ? 3'b110 : colour;
             3'b110 : colour = (button==1) ? 3'b001 : colour;
             3'b111 : colour<=3'b001;
        endcase
	end

endmodule


