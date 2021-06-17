//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name: Jake Lawson
// Date: 16/06/2021
//
// Description: A testbench module to test Ex5 - Air Conditioning
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

module top_tb(
   //No ports are defined! 
   );

    //Parameters    
    parameter CLK_PERIOD = 10;
    parameter TEMP_PERIOD = 4*CLK_PERIOD;

    //Registers
    reg clk;
    reg [4:0] temperature;
    reg err;

    //Wires
    wire heating;
    wire cooling;
    wire [1:0] state;
    assign state = {heating,cooling};

    //Create clock signal
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
    end

    //Create temperature signal
    initial
    begin
       //set initial state to idle
       temperature = 5'd20; //should set the ac to idle

           #(TEMP_PERIOD) temperature = 5'd25; //should enable cooling
           #(TEMP_PERIOD) temperature = 5'd27; //should maintain cooling
           #(TEMP_PERIOD) temperature = 5'd19; //should go back to idle
	   #(TEMP_PERIOD) temperature = 5'd21; //should maintain idle
           #(TEMP_PERIOD) temperature = 5'd15; //should enable heating
           #(TEMP_PERIOD) temperature = 5'd19; //should maintain heating
           #(TEMP_PERIOD) temperature = 5'd20; //should go back to idle

    end

    //Check for failures
    initial begin
      err = 0;

      #(2*CLK_PERIOD) if(state != 2'b00) begin
          $display("***TEST FAILED on setting to idle!***");
          err=1;
          end
      #(TEMP_PERIOD) if(state != 2'b01) begin
          $display("***TEST FAILED on transition idle -> cooling!***");
          err=1;
          end
      #(TEMP_PERIOD) if(state != 2'b01) begin
          $display("***TEST FAILED on maintaining cooling!***");
          err=1;
          end
      #(TEMP_PERIOD) if(state != 2'b00) begin
          $display("***TEST FAILED on transition cooling -> idle!***");
          err=1;
          end
      #(TEMP_PERIOD) if(state != 2'b00) begin
          $display("***TEST FAILED on maintaining idle!***");
          err=1;
          end
      #(TEMP_PERIOD) if(state != 2'b10) begin
          $display("***TEST FAILED on transition idle -> heating!***");
          err=1;
          end
      #(TEMP_PERIOD) if(state != 2'b10) begin
          $display("***TEST FAILED on maintaining heating!***");
          err=1;
          end
      #(TEMP_PERIOD) if(state != 2'b00) begin
          $display("***TEST FAILED on transition heating -> idle!***");
          err=1;
          end
    end

    //Check for illegal states
    always @ (posedge clk or negedge clk)
        if(state == 2'b11) begin
          $display("***TEST FAILED - detected illegal state!***");
          err=1;
        end

    //End the simulation end check for success
    initial begin
      #(32*CLK_PERIOD)
      if(err==0)
        $display("***TEST PASSED! :) ***");
      $finish;
    end
    
   //The instantiation of the ac module
     ac mymodule (
     .clk (clk),
     .temperature (temperature),
     .heating (heating),
     .cooling (cooling)
     );

endmodule
