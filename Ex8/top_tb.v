//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8  - Simple End-to-End Design
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex8
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
   //No ports are defined! 
   );

    //Parameters    
    parameter CLK_PERIOD = 10;
	parameter TEMP_PERIOD = 4*CLK_PERIOD;

	//Variables
	reg [4:0] temperature;
	reg clk_p;
	reg err;
	wire clk_n;
	wire heating;
	wire cooling;


	//Generate clock signal
	initial begin
       clk_p = 1'b1;
       forever
         #(CLK_PERIOD/2) clk_p=~clk_p;
    end

	assign clk_n = ~clk_p; //generate negative clock signal from positive

	
	//Generate temperature signal (taken from previous top_tb.v for exercise 5
	initial begin
		temperature = 5'd20; //should set the ac to idle

        #(TEMP_PERIOD) temperature = 5'd25; //should enable cooling
        #(TEMP_PERIOD) temperature = 5'd27; //should maintain cooling
        #(TEMP_PERIOD) temperature = 5'd19; //should go back to idle
	   	#(TEMP_PERIOD) temperature = 5'd21; //should maintain idle
       	#(TEMP_PERIOD) temperature = 5'd15; //should enable heating
       	#(TEMP_PERIOD) temperature = 5'd19; //should maintain heating
       	#(TEMP_PERIOD) temperature = 5'd20; //should go back to idle
	end

	//End the simulation end check for success
    initial begin
      #(32*CLK_PERIOD)
      $finish;
    end

	//instance of the top module
	top mymodule(
    	.clk_p (clk_p),
		.clk_n (clk_n),
		.rst_n (rst_n),
        .temperature (temperature), 
        .heating (heating), 
        .cooling (cooling)
	);

endmodule
