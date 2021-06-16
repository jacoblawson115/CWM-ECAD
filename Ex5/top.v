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
    input clk, [4:0]temperature, initState
    output reg heating,
    output reg cooling,
    );

// define an internal state variable and keep it in a register
    wire [1:0]st;
    reg [1:0]state;
    assign st = initState; //define initial state
    state = st;

// logic to determine on clk edge the next state from temperature input and current state
    always @ (posedge clk)
       begin
          if(state==2'b11 || state==2'bx) //illegal states - reject, go to idle
             assign st = 2'b00;
          end

          if(state==2'b00) //idle state
             assign st = (temperature >= 5'b10110) ? 2'b01: 
                    (temperature <= 5'10010) ? 2'b10:
                    2'b00;
          end

          if(state==2'b01) //cooling state
             assign st = (temperature <= 5'10100) ? 2'b00: 
                    2'b01;
          end
 
          if(state==2'b10) //heating state
             assign st = (temperature >= 5'10100) ? 2'b00: 
                    2'b10;
          end

          state = st; //update state to new state
          heating = state[1];
          cooling = state[0];
       end


endmodule
