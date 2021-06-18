//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name: Jake Lawson
// Date: 18/06/2021
//
// Description: A testbench module to test Ex7 - Lights Selector
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
    reg sel;
	reg rst;
	reg button;
    reg err;

	//Wires
    wire [23:0] light;

	//Create clock signal
    initial begin
		clk = 1'b0;
        forever
            #(CLK_PERIOD/2) clk=~clk;
    end

	//Test signals
	initial begin
		sel = 0;
		rst = 1;
        #(0.25*CLK_PERIOD) rst=~rst; //reset at the start
		button = 0;

		forever //select signal
			#(5*CLK_PERIOD) sel=~sel; 

		forever //button signal
			#(2*CLK_PERIOD) button=~button;
	end

    //Check for failures
	always @ (posedge clk) begin
		if(~sel) begin
			if(light != 24'hFFFFFF) begin
				$display("***TEST FAILED - did not select white light on sel=0!***");
          		err=1;	
			end
		end
	end

	//End simulation and check for success
    initial begin
      #(32*CLK_PERIOD)
      if(err==0)
        $display("***TEST PASSED! :) ***");
      $finish;
    end

	//The instantiation of the user's module
     selector mymodule (
    	.clk (clk),
    	.rst (rst),
    	.button (button),
		.sel (sel),
    	.light (light)
     );

endmodule
