//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

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

    //Wires
    wire colour;

    //Create clock signal
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

     //Move through states and check each step is successful
     initial
     begin
	rst = 1;
	button = 0;
	err = 0;
	#(CLK_PERIOD/2) rst=~rst; 

	forever
	   #CLK_PERIOD button=~button;	
     end

//The instantiation of the user's module
     leds mymodule (
     .clk (clk),
     .rst (rst),
     .button (button),
     .colour (colour)
     );
