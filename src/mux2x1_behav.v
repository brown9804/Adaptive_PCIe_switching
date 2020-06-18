// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef MUX21_BEHAV
`define MUX21_BEHAV



`timescale 1ns/1ps

module mux21 (
    input clk,
    input reset,
    input  fifo_empty0, // Enable data out from FiFo0 if fifo_empty0 != 0
    input  fifo_empty1, // Enable data out from FiFo1 if fifo_empty0 = 0
    input  [9:0] in0, // Data from  FiFo0
    input  [9:0] in1, // Data from  FiFo1
    output reg  [7:0] out
);

// Mux 2:1 2 bits with valid
// Defining reset for Flip Flops
// In order to define flip flops: this being a two-state (bi-stable) device, which serves as
// basic memory for sequential logic operations.
always @(posedge clk) // Each positive edge of the clock make these changes
//If this happens on a positive edge of the clock, make the following changes for the next clock edge
    begin
    // Reset synchronous
    if (reset == 0) // If reset in LOW nonblobking assing zero
      begin
          out <= 0;
      end // end reset zero

    else begin // reset == 1

        if (fifo_empty0==0)
          begin// If not empty FIFO #0
                if (in0)
                begin // fifo0 data
                  out <= in0;
                end // end fifo1 data

                else begin // if no data initial begin
                  if (fifo_empty1 == 0)
                    begin // FIFO #1
                      if (in1)
                        begin // fifo1 data
                          out <= in1;
                        end // end fifo1 data
                    end // end FIFO #1
                end // end fifo0 no data
          end // end FIFO #0 is empty

        else begin // if FIFO #0 is empty
          if (fifo_empty1 == 0)
            begin // FIFO #1
              if (in1)
                begin // fifo1 data
                  out <= in1;
                end // end fifo1 data
            end // end  FIFO #1

          else begin // if fifo #1 is empty
            out <= 0;
          end // end else
        end // end else if FIFO #0 is empty
  end // end reset
 end // end posedge clk
endmodule


// Local Variables:
// verilog-library-directories:("."):
// verilog-auto-wire-type:\"logic\"
// End:

`endif
