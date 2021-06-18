//////////////////////////////////////////////////////////////////////////////////
// Exercise #7 - Lights Selector
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to implement a selector between RGB 
// lights and a white light, coded in RGB. If sel is 0, white light is used. If
//  the sel=1, the coded RGB colour is the output.
//
//  inputs:
//           clk, sel, rst, button
//
//  outputs:
//           light [23:0]
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module selector(
// declare inputs
    input clk, sel, rst, button,
    output [23:0] light
    );

	//wires to capture module outputs
	wire [2:0] colour;
	wire [23:0] rgb;
	wire [23:0] light;


	//instance of lights module
	lights mylights(
    	.clk (clk), 
        .rst (rst), 
        .button (button), 
        .colour (colour)
	);

	//instance of converter module
	converter myconverter(
        .clk (clk), 
        .colour (colour), 
        .enable (1'b1),
        .rgb (rgb)
    );
	
	//instance of multiplexer module
	multiplexer mymultiplexer(
    	.a (24'hFFFFFF),
		.b (rgb),
		.sel (sel),
		.out (light)
	);

endmodule



