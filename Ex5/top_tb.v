//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name:
// Date: 
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
    reg [4:0]temperature;
    reg initState; //define an initial state so we can make sure our implementation works with all initial states and rejects illegal states

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

    //Create temperature signal (use different signals depending on initial state so we can cycle through states in order)
    initial
    begin
       if(initState == 2'b00 || initState == 2'b11):
       end

       if(initState == 2'b01):
       end

       if(initState == 2'b10):
       end


       temperature = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
    end
    

//The instantiation of the user's module
     ac mymodule (
     .clk (clk),
     .initState (initState),
     .temperature (temp),
     .heating (heating),
     .cooling (cooling),
     );

endmodule
