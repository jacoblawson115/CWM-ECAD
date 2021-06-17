//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning
// Student Name: Jake Lawson
// Date: 16/06/2021
//
//  Description: In this exercise, you need to an air conditioning control system
//  According to the state diagram provided in the exercise.
//
//  inputs:
//           clk, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////

module ac (
// declare inputs
    input clk, [4:0] temperature, [1:0] initState,
    output heating, cooling
    );

// define an internal state variable and keep it in a register
    reg [1:0] state; 
    state <= initState; //define initial state

    assign heating = state[0];
    assign cooling = state[1];

// logic to determine on clk edge the next state from temperature input and current state
    always @ (posedge clk) begin

          if(state==2'b11 || state==2'bx) begin //illegal states - reject, go to idle
             state <= 2'b00;
          end

          if(state==2'b00) begin //at idle state
             state <= (temperature >= 5'd22) ? 2'b01 : 
                     (temperature <= 5'd18) ? 2'b10 :
                     2'b00;
          end

          if(state==2'b01) begin //at cooling state
             state <= (temperature <= 5'd20) ? 2'b00 : 
                     2'b01;
          end
 
          if(state==2'b10) begin //at heating state
             state <= (temperature >= 5'd20) ? 2'b00 : 
                     2'b10;
          end

       end


endmodule
