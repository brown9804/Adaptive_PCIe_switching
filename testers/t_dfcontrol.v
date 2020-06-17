
//////////////////////////////////////
// Brandon ESquivel Molina          //
// Tester for class.v               //
// brandon.esquivel@ucr.ac.cr       //
//                                  //
//////////////////////////////////////

`ifndef T_DFCONTROL
`define T_DFCONTROL

// only necessary signals
module t_dfcontrol (

  output reg  reset,
  output reg  clk,
  output reg  almost_full1,
  output reg  almost_empty1,
  output reg  fifo_empty1,
  output reg  Fifo_full1,
  output reg  fifo_error1,
  output reg  fifo_pause1,
  output reg  push_0,
  
  
  
  
  input wire  write1,
  input wire  write1s,
  input wire  read1,
  input wire  read1s,
  input wire Error,
  input wire Errors
);



initial begin

  $dumpfile("dfcontrol.vcd");
  $dumpvars;

  repeat (6) begin
  @(posedge clk);
  #4 reset <= 0;
end

repeat(7) begin
@(posedge clk);
reset <= 1;
push_0 <= 1;
fifo_empty1 <= 0;
end

@(posedge clk);
almost_empty1 <= 0;
push_0 <= 0;


@(posedge clk);
push_0 <= 1;
fifo_pause1 <= 1;
almost_full1 <= 1;

@(posedge clk);
Fifo_full1 <= 1;

@(posedge clk);
fifo_error1 <= 1;
@(posedge clk);
@(posedge clk);

#40 $finish;
end

// initial values
initial #4 reset = 0;
initial almost_full1 = 0;
initial almost_empty1 = 1;
initial fifo_empty1 = 1;
initial Fifo_full1 = 0;
initial fifo_error1 = 0;
initial fifo_pause1 = 0;
initial push_0  = 0;




// clock logic
initial	clk	 			<= 0;			// Initial value to avoid indeterminations
always	#10 clk		<= ~clk;		// toggle every 10ns

endmodule


// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
