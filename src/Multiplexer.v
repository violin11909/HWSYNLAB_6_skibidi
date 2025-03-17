`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/01/2025 02:16:55 AM
// Design Name: BCD_Counter
// Module Name: Multiplexer
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Multiplexer module for 7-Segment Display
//////////////////////////////////////////////////////////////////////////////////


module Multiplexer (
    input  wire [15:0] DataIn,
    input  wire [1:0] Selector,
    output reg [ 3:0] DataOut
);
  // Add your code here
  always @(DataIn or Selector) begin
    case(Selector)
      2'b00: DataOut <= DataIn[3:0];
      2'b01: DataOut <= DataIn[7:4];
      2'b10: DataOut <= DataIn[11:8];
      2'b11: DataOut <= DataIn[15:12];
    endcase
  end
  // End of your code
endmodule
