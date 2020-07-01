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

`ifndef MUX2x1
`define MUX2x1

`timescale 1ns/1ps

module mux21 #(
  parameter DATA_SIZE = 10) 
  
  ( // Outputs
    output reg [DATA_SIZE-1:0]      out,
    output reg                      valid,
    output reg                      pop_0,
    output reg                      pop_1,
    // Inputs
    input wire                      clk,
    input wire                      reset,
    input wire                      fifo_empty0,     // Enable data out from FiFo0 if fifo_empty0 != 0,. Come from class layer fifos
    input wire                      fifo_empty1,     // Enable data out from FiFo1 if fifo_empty0 != 0
    input wire                      fifo_almost_empty0,
    input wire                      fifo_almost_empty1,
    input wire [DATA_SIZE-1:0]      in0,             // Data from  FiFo0
    input wire [DATA_SIZE-1:0]      in1,             // Data from  FiFo1
    input wire                      fifo_up0_almostfull,
    input wire                      fifo_up1_almostfull

);

  always @(posedge clk) begin      // Each positive edge of the clock make these changes
    // Reset synchronous
    if (!reset) begin             // If reset in LOW nonblobking assing zero
      pop_0         <= 0;
      pop_1         <= 0;
    end           // end reset zero
    else begin      // reset == 1
      // data flow control push pop logig
      if( fifo_empty0 | fifo_almost_empty0 | fifo_up0_almostfull) begin
        pop_0       <= 0;
        if(fifo_empty1 | fifo_almost_empty1 | fifo_up1_almostfull) begin
          pop_1       <= 0;
        end else begin
          pop_1     <= 1;
        end    
      end else begin
        pop_0 <= 1;
      end
    end
  end
      
  always@(*) begin
    valid = 0;
    out  = 0;
    if (!fifo_empty0 && pop_0) begin                  // fifo0 data
        out              = in0;
        valid            = 1;
      end 
      else begin                          // if no data initial begin
        if (!fifo_empty1 && pop_1 )  begin              // fifo1 data
              out        = in1;
              valid      = 1;
        end else begin
          valid          = 0;
          out            = 0;
        end
      end                         // end fifo1 data
    end 
endmodule


// Local Variables:
// verilog-library-directories:("."):
// verilog-auto-wire-type:\"logic\"
// End:

`endif
