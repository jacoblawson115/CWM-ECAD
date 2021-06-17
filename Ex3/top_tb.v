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
    wire [7:0] counter_out;
    reg clk;
    reg rst;
    reg change;
    reg on_off;
    reg [7:0] prv_val;
    reg err;

//Generate a clock signal
    initial
        begin
            clk = 1'b0;
            prv_val = counter_out;
            forever
            #(CLK_PERIOD/2) clk=~clk;
        end

//Save previous value of the counter on each negative clock edge
    always @ (negedge clk)
	begin
           prv_val = counter_out;
	end

//Drive the inputs to the counter
    initial begin
       clk=0;
       rst=1; 
       change=0;
       on_off=0;
       err=0;

       //reset and change signal generation
       #(2*CLK_PERIOD) rst=~rst;
       #(5*CLK_PERIOD) change=~change;
       #(13*CLK_PERIOD) change=~change;
       #(16*CLK_PERIOD) rst=~rst;
       
    end

    //Switch on_off between counting up and counting down to check that it counts up when 1 and down when 0:
    initial begin
       forever
         #(7*CLK_PERIOD) on_off=~on_off;
    end
    
//Check for success
    initial begin
        forever
        #(0.75*CLK_PERIOD)
          
           if(rst) begin //check reset functionality
              if(prv_val!=00000000) begin
                 $display("***TEST FAILED! - reset not working***");
                 err=1;
              end
           end
           
           if(~change) begin //check change functionality
                 if(counter_out!=prv_val) begin
                    $display("***TEST FAILED! - output not constant when change = 0***");
                    err=1;
                 end
           else if(on_off) //given change is enabled, check on_off functionality
                    if(counter_out != prv_val + 1) begin
                       $display("***TEST FAILED! - doesn't count up on on_off = 1***");
                       err=1;
                    end
           else if(~on_off)
                    if(counter_out != prv_val - 1) begin
                       $display("***TEST FAILED! - doesn't count down on on_off = 0***");
                       err=1;
                    end
           end
     end

//End test and check for success
initial begin
    #300
    if (err==0)
       $display("***TEST PASSED! :) ***");
    $finish;
end


//The instantiation of the user's module
     monitor mymodule (
     .clk (clk),
     .rst (rst),
     .change (change),
     .on_off (on_off),
     .counter_out (counter_out)
     );
 
endmodule 
