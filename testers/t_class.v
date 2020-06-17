
//////////////////////////////////////
// Brandon ESquivel Molina          //
// Tester for class.v               //
// brandon.esquivel@ucr.ac.cr       //
//                                  //
//////////////////////////////////////

`ifndef T_CLASS
`define T_CLASS

// only necessary signals
module t_class #(
    //Parameters
    parameter DATA_SIZE = 10,         
    parameter MAIN_SIZE=8          
) (
  output reg  reset,
  output reg  clk,
  output reg  [DATA_SIZE-1:0] in,
  output reg  valid_in,
/*
  input wire AF1_up,
  input wire AF2_up,
  input wire AF1_up_s,
  input wire AF2_up_s,

  
  output reg AE1_up,
  output reg AE2_up,
  output reg AE1_up_s,
  output reg AE2_up_s,
 */
  input wire [DATA_SIZE-1:0] out0,
  input wire [DATA_SIZE-1:0] out0_s,
  input wire [DATA_SIZE-1:0] out1,
  input wire [DATA_SIZE-1:0] out1_s,
  input wire Error
  );



initial begin

  $dumpfile("class.vcd");
  $dumpvars;
   
   valid_in = 0;
   in = 10'h0;
   reset = 0;
   /*
   AE1_up = 1;
   AE2_up = 1;
   AE1_up_s = 1;
   AE2_up_s = 1;
*/
    repeat (3) begin
    @(posedge clk)
    reset <= 0;
    end

    @(posedge clk);
    reset <= 1;


// fill FIFO 1 CLASS 1
repeat(6) begin
@(posedge clk);
valid_in <= 1;
in <= 10'hFF;
end
/*
// test class switching for FIFO 2 class 0
repeat(7) begin

@(posedge clk);
in <= 10'hFF;

@(posedge clk);
in <= 10'b0111111111;

end

repeat(7) begin
@(posedge clk);
valid_in <= 0;
end

*/

repeat(6) begin

@(posedge clk);
valid_in <= 0;

end



#40 $finish;
end

// initial values


// clock logic
initial	clk	 			<= 0;			// Initial value to avoid indeterminations
always	#10 clk		<= ~clk;		// toggle every 10ns

endmodule


// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
