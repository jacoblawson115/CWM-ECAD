//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
   //No ports are defined! 
   );

    //Parameters    
    parameter CLK_PERIOD = 10;

    //Registers
    reg rst;
    reg clk;
    reg button;
    reg err;
    reg [2:0] prv_val; //register to save the previous value

    //Wires
    wire [2:0] colour;




	//The instantiation of the user's module
     rgb_converter mymodule (
     .clk (clk),
     .colour (colour),
     .enable (enable),
     .rgb (rgb)
     );

endmodule
	
