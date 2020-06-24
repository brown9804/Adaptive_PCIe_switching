// Brandon Esquivel Molina
// Tester for Device1 
// brandon.esquivel@ucr.ac.cr

`ifndef T_DISP1
`define T_DISP1

// only necessary signals
module t_device1 #(
    //Parameters
    parameter DATA_SIZE = 10,
    parameter MAIN_SIZE=8
) (
  // outputs
  output reg reset,
  output reg clk,
  output reg clk2f
  output reg [DATA_SIZE-1:0] in,

  // BEHAV
  input wire out0,
  input wire out1,
  // FIFO 0
/*  input wire almost_full0,
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
  input wire fifo1_pause_s,*/

  input wire Error

     );

reg clk2f;


initial begin

  $dumpfile("disp1.vcd");
  $dumpvars;


    repeat (3) begin
    @(posedge clk)
    reset <= 0;
    end

    @(posedge clk);
    #4 reset <= 1;


// fill FIFO 2 CLASS 1
repeat(8) begin
@(posedge clk);
in <= 10'b1111111111;
end

// test class switching for FIFO 1 class 0
repeat(2) begin
@(posedge clk2f);
in <= 10'b0111111111;
end

@(posedge clk);
reset = 0;

@(posedge clk);
#4 reset = 1;

@(posedge clk2f);
in = 10'b0101010101;



repeat(6) begin
@(posedge clk2f);
in = {~in[9], in[8:0]} + 1;
end




#40 $finish;
end

// initial values
initial #4 reset = 0;
initial in = 10'h0;

// clock logic
initial	clk	 			<= 0;			// Initial value to avoid indeterminations
initial	clk2f	 		<= 0;			// Initial value to avoid indeterminations
always	#10 clk		<= ~clk;		// toggle every 10ns

always@(posedge clk) begin
clk2f = ~clk2f;
end
endmodule


// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
