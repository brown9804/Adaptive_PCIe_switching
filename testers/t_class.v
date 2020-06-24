
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
  // outputs
  output reg reset,
  output reg clk,
  output reg [DATA_SIZE-1:0] in,

  // BEHAV
  input wire [DATA_SIZE-1:0] out0,
  input wire [DATA_SIZE-1:0] out1,
  // FIFO 0
  input wire almost_full0,
  input wire almost_empty0,
  input wire fifo0_empty,
  input wire fifo0_error,
  input wire fifo0_pause,
  input wire fifo_full0,
  // FIFO 1
  input wire fifo_full1,
  input wire almost_full1,
  input wire almost_empty1,
  input wire fifo1_empty,
  input wire fifo1_error,
  input wire fifo1_pause,
  //Syn
  input wire [DATA_SIZE-1:0] out0_s,
  input wire [DATA_SIZE-1:0] out1_s,
  // FIFO 0 SYN
  input wire almost_full0_s,
  input wire almost_empty0_s,
  input wire fifo0_empty_s,
  input wire fifo0_error_s,
  input wire fifo0_pause_s,
  input wire fifo_full0_s,
  // FIFO 1 SYN
  input wire fifo_full1_s,
  input wire almost_full1_s,
  input wire almost_empty1_s,
  input wire fifo1_empty_s,
  input wire fifo1_error_s,
  input wire fifo1_pause_s,

  input wire Error

  );


initial begin

  $dumpfile("class.vcd");
  $dumpvars;


in = 10'h0;
#4 reset = 0;
reset <= 0;

  @(posedge clk);
  #4 reset <= 1;

repeat (2) begin
@(posedge clk) begin
  in <= 10'h0FF;
end

@(posedge clk) begin
    in <= 10'h3DD;
	  end

@(posedge clk) begin
  in <= 10'h0EE;
end

@(posedge clk) begin
	in <= 10'h3CC;
end

@(posedge clk) begin
	in <= 10'h0BB;
end

@(posedge clk) begin
	in <= 10'h399;
end

@(posedge clk) begin
	in <= 10'h0AA;
end

@(posedge clk) begin
	in <= 10'h388;
end

@(posedge clk) begin
	in <= 10'h377;
end

end
#40 $finish;
end

// clock logic
initial	clk	 			<= 0;			// Initial value to avoid indeterminations
always	#10 clk				<= ~clk;		// toggle every 10ns

endmodule


// Local Variables:
// verilog-library-directories:("."):
// End:
`endif