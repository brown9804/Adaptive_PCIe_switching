// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef DEMUX12_8_BEHAV
`define DEMUX12_8_BEHAV

`timescale 1ns/1ps

  // Considering class and destiny

  module demux12_8 (
      input wire  reset,
      input wire  clk,
      input wire  [7:0] in,
      input wire classif,
      output reg  push_0,
      output reg  push_1,
      output reg  [7:0] out0,
      output reg  [7:0] out1

      );

  always @(posedge clk) begin
     if (reset ==0) begin
         out0 <= 0;
         out1 <= 0;
         push_0   <= 0;
         push_1   <= 0;
     end // end reset zero

   else begin // reset == 1
     case(classif)
     0:   begin
            out0 <= in;
            push_0 <= 1;
            push_1 <= 0;
        end // end classif = 0
      1:  begin
             out1 <= in;
             push_0 <= 0;
             push_1 <= 1;
         end // end classif = 1

       default: begin
           out0 <= 8'h0;
           out1 <= 8'h0;
           push_0 <= 0;
           push_1 <= 0;
       end // end default
      endcase // end case classif == 0 or classif == 1
    end // end reset ==1
  end // end posedge clk

  endmodule

  // Local Variables:
  // verilog-library-directories:("."):
  // End:
  `endif
