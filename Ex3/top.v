//////////////////////////////////////////////////////////////////////////////////
// Exercise #3 - Active IoT Devices Monitor
// Student Name:Jake Lawson
// Date: 14/06/2021
//
//  Description: In this exercise, you need to design a counter of active IoT devices, where 
//  if the rst=1, the counter should be set to zero. If change=0, the value
//  should stay constant. If on-off=1, the counter should count up every
//  clock cycle, otherwise it should count down.
//  Wrap-around values are allowed.
//
//  inputs:
//           clk, rst, change, on_off
//
//  outputs:
//           counter_out[7:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module monitor (
// declare inputs
    input clk, rst, change, on_off,
    output reg [7:0]counter_out
    );

// logic
    always @ (posedge clk or posedge rst)
	begin
       if(rst)
		counter_out <= 8'b00000000;
	   else
		if(change)
		   counter_out <= counter_out;
		else
		  if(on_off)
	     	 counter_out <= counter_out + 8'b00000001;
		  else
		     counter_out <= counter_out - 8'b00000001;
	end

endmodule
