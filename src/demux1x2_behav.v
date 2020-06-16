// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef DEMUX12_BEHAV
`define DEMUX12_BEHAV

`timescale 1ns/1ps

// Considering class and destiny

module demux12 (
    input wire  reset,
    input wire  clk,
    input wire  [9:0] in,
    input wire  valid_in,
    input wire  select,
    output reg  push_0,
    output reg  push_1,
    output reg  [9:0] out0,
    output reg  [9:0] out1,
    output reg  [1:0] valid_out

    );

always @(posedge clk) begin
   if (reset ==0) begin
       out0 <= 0;
       out1 <= 0;
       valid_out <= 0;
       push_0   <= 0;
       push_1   <= 0;
   end // end reset zero

 else begin // reset == 1
   case(select)
   0:   begin
       if (valid_in == 1)
         begin
          out0 <= in;
          push_0 <= 1;
          valid_out[0] <= valid_in;
          valid_out[1] <= 0;
          end // end valid_in  = 1
        else begin
          valid_out[0] <= 0;
        end // end valid_in  = 0
      end // end select = 0
    1:  begin
        if (valid_in == 1)
          begin
           out1 <= in;
           push_1 <= 1;
           valid_out[0] <= 0;
           valid_out[1] <= valid_in;
           end // end valid_in  = 1
         else begin
           valid_out[0] <= 0;
         end // end valid_in  = 0
       end // end select = 1

     default: begin
         valid_out <= 2'b00;
         out0 <= 10'h0;
         out1 <= 10'h0;
     end // end default
    endcase // end case selec == 0 or select == 1
  end // end reset ==1
end // end posedge clk

endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
