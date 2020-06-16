// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef MUX21_BEHAV
`define MUX21_BEHAV



`timescale 1ns/1ps

module mux21 (
    input clk,
    input reset,
    input  pop0,
    input  pop1,
    input  [9:0] in0,
    input  [9:0] in1,
    // Valid for inputs
    input wire in0_valid,
    input wire in1_valid,
    output reg  [9:0] out,
    output reg valid_out
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
          valid_out <= 0;
      end // end reset zero

    else begin // reset == 1

    case(pop0)
        0:   begin
              valid_out <= 0;
        end // end pop0 == 0

        1: begin
            if (in0_valid == 1)
            begin
                valid_out <= in0_valid;
                out <= in0;
            end // in0_valid == 1
        end // end pop0 == 1

        default: begin
            valid_out <= 0;
            out <= 10'h00;
        end // end default
    endcase // end case pop0 == 0 or pop0 == 1


    case(pop1)
        0:   begin
              valid_out <= 0;
        end // end pop0 == 0

        1: begin
            if (in1_valid == 1)
            begin
                valid_out <= in1_valid;
                out <= in1;
            end // in1_valid == 1
        end // end pop1 == 1

        default: begin
            valid_out <= 0;
            out <= 10'h00;
        end // end default
    endcase // end case pop1 == 0 or pop1 == 1

  end // end reset
 end // end posedge clk
endmodule


// Local Variables:
// verilog-library-directories:("."):
// verilog-auto-wire-type:\"logic\"
// End:

`endif
