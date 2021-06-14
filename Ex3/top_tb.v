//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
    //Parameters    
    parameter CLK_PERIOD = 10;

    //Registers
    reg [7:0] counter_out;
    reg clk;
    reg rst;
    reg change;
    reg on_off;

    //Generate a clock signal
    initial
        begin
            clk = 1'b0;
            forever
            #(CLK_PERIOD/2) clk=~clk;
        end

    //Test whether the counter works
    initial begin
       clk=0;
       on_off=1;
       counter_out=8'b00000000;
     end
    
            

//Todo: User logic
    
//Todo: Finish test, check for success

//The instantiation of the user's module
     mymodule top (
     .clk (clk),
     .rst (rst),
     .change (change),
     .on_off (on_off),
     .counter_out (counter_out)
     );
 
endmodule 
