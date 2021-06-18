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
    reg clk;
    reg [2:0] colour;
    reg enable;
    reg [23:0] exp;
	reg err;


   	//Wires
    wire [23:0] rgb;


	//Create clock signal
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
    end

	
	//Enable signal
	initial begin
    	enable = 1;
		#(0.45*CLK_PERIOD)
		forever
		#(CLK_PERIOD/2) enable = ~enable;
	end
	

	//Cycle through colours and retrieve the RGB values
	initial begin
		colour = 3'b000;
		err = 0;

		forever
		#(CLK_PERIOD) colour = colour + 3'b001;
	end
    

	//Find expected values and compare this to the value we obtained with our code, look for errors
	always @ (posedge clk) begin
		
		case(colour) //find expected value from cases equivalent to the lookup table stored in memory
		     3'b000 : exp<=24'h000000;
		     3'b001 : exp<=24'h0000FF;
		     3'b010 : exp<=24'h00FF00;
		     3'b011 : exp<=24'h00FFFF;
		     3'b100 : exp<=24'hFF0000;
		     3'b101 : exp<=24'hFF00FF;
		     3'b110 : exp<=24'hFFFF00;
		     3'b111 : exp<=24'hFFFFFF;
        endcase

		#(CLK_PERIOD/4) 
		if(exp!=rgb) begin
			$display("***TEST FAILED! Retrieved RGB value is different from expected!***");
            err=1;
		end

	end


	//End the simulation end check for success
    initial begin
      #100
      if(err==0)
        $display("***TEST PASSED! :) ***");
      $finish;
    end
    

	//The instantiation of the user's module
     rgb_converter mymodule (
     	.clk (clk),
     	.colour (colour),
     	.enable (enable),
     	.rgb (rgb)
     );

endmodule
	
