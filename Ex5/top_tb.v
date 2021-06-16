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

    //Registers
    reg clk;
    reg [4:0] temperature;
    reg [1:0] initState; //define an initial state so we can make sure our implementation works with all initial states and rejects illegal states

    //Wires
    wire heating;
    wire cooling;

    //Create clock signal
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
    end

    //Create temperature signal (use different signals depending on initial state so we can cycle through states in order each time)
    initial
    begin
       initState = 2'b00; //choose initial state to try

       //starts from idle or illegal(->idle) state
       if(initState == 2'b00 || initState == 2'b11 || initState == 2'bx) begin
           temperature = 5'd20; //should maintain idle
           #(2*CLK_PERIOD) temperature = 5'd25; //should enable cooling
           #(4*CLK_PERIOD) temperature = 5'd27; //should maintain cooling
           #(6*CLK_PERIOD) temperature = 5'd19; //should go back to idle
           #(8*CLK_PERIOD) temperature = 5'd15; //should enable heating
           #(10*CLK_PERIOD) temperature = 5'd19; //should maintain heating
           #(12*CLK_PERIOD) temperature = 5'd20; //should go back to idle
       end

       //starts from cooling
       if(initState == 2'b01) begin
           temperature = 5'd23; //should maintain cooling
           #(2*CLK_PERIOD) temperature = 5'd17; //should go to idle
           #(4*CLK_PERIOD) temperature = 5'd19; //should maintain idle
           #(6*CLK_PERIOD) temperature = 5'd18; //should enable heating
           #(8*CLK_PERIOD) temperature = 5'd19; //should maintain heating
           #(10*CLK_PERIOD) temperature = 5'd22; //should go back to idle
           #(12*CLK_PERIOD) temperature = 5'd21; //should maintain idle
       end

       //starts from heating
       if(initState == 2'b10) begin
           temperature = 5'd13; //should maintain heating
           #(2*CLK_PERIOD) temperature = 5'd20; //should go to idle
           #(4*CLK_PERIOD) temperature = 5'd19; //should maintain idle
           #(6*CLK_PERIOD) temperature = 5'd26; //should enable cooling
           #(8*CLK_PERIOD) temperature = 5'd24; //should maintain cooling
           #(10*CLK_PERIOD) temperature = 5'd17; //should go back to idle
           #(12*CLK_PERIOD) temperature = 5'd19; //should maintain idle
       end

    end

    //Check for failures/successes and end the simulation
    

//The instantiation of the ac module
     ac mymodule (
     .clk (clk),
     .temperature (temperature),
     .initState (initState),
     .heating (heating),
     .cooling (cooling)
     );

endmodule
