
/////////////////////////////////                      .        .
//  Brandon Equivel             //                        .  .
//  brandon.esquivel@ucr.ac.cr   ///////////............///////
//  Belinda Brown Ramírez         //////////.............//////    .
//  timna.brown@ucr.ac.cr        //
//  June, 2020                 //                        .    .      .
////////////////////////////////                       .
      ///           ///
    ///               ///
  ///                   ///
////                    /////

// Inplementation of Parameterizable demultiplexer 1x2

`ifndef DEMUX1x2
`define DEMUX1x2

`timescale 1ns/1ps

// Considering class and destiny in pos [DATA_SIZE-1] and [DATA_SIZE-2] resp.

module demux12 #(
  parameter DATA_SIZE = 10) 
  (

    // Outputs 
  output reg  [DATA_SIZE-1:0] out0,
  output reg  [DATA_SIZE-1:0] out1,
  output reg                  push_0,                         // works like valid for data in at FIFO
  output reg                  push_1,
  // Inputs
  input wire [DATA_SIZE-1:0]  in,
  input wire                  fifo_up0_almostfull,             // necessary for push control
  input wire                  fifo_up1_almostfull,
  input wire                  reset,
  input wire                  classif,
  input wire                  valid, 
  input wire                  clk
  );

  always @(posedge clk) begin
    if (!reset) begin   
      out0     <= 0;
      out1     <= 0;
      push_0   <= 0;
      push_1   <= 0;
   end // end reset zero

 else begin // reset == 1
   case(classif)
   0:   begin
          if (fifo_up0_almostfull | ~valid ) begin
            out0     <= 0;
            push_0   <= 0;
          end else begin
            out0     <= in;
            push_0   <= 1;
            push_1   <= 0; 
          end
      end // end classif = 0
    1:  begin
          if (fifo_up1_almostfull | ~valid) begin
            out1     <= 0;
            push_1   <= 0;
          end else begin
            out1     <= in;
            push_0   <= 0;
            push_1   <= 1;
          end
       end // end classif = 1

     default: begin
          out0       <= 0;
          out1       <= 0;
          push_0     <= 0;
          push_1     <= 0;
     end // end default
    endcase // end case classif == 0 or classif == 1
  end // end reset ==1
end // end posedge clk

endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
