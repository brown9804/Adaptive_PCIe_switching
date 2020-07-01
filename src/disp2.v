// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr


`ifndef DISP2
`define DISP2

`include "./src/fifo.v"
`include "./src/serieparalelo.v"


module device2 #(
	parameter DATA_SIZE = 8,
	parameter MAIN_SIZE = 4)
	(
input clk, // just to see
input clk8f, // used to data manipulation
input reset, // always requiered a reset in each block
input in0, // output Paralelo - Serie #0
input in1, // output Paralelo - Serie #1
input read0, // need to connect with df control and fifo0
input read1, // need to connect with df control and fifo1
input write0, // need to connect with write and fifo0
input write1, // need to connect with write and fifo1
output reg [DATA_SIZE-1:0] out0, // out from fifo0
output reg [DATA_SIZE-1:0] out1,  // out from fifo1
output reg almost_full_f0, // output from fifo 0
output reg almost_full_f1, // output from fifo 0
output reg empty0, // output from fifo 0
output reg empty1 // output from fifo  1
);

// Wires requiered to connect
// About serial - parallel
wire nn_valid0, nn_valid1;
wire nn_active0, nn_active1;

wire [DATA_SIZE-1:0] out_sp0;
wire [DATA_SIZE-1:0] out_sp1;
// About fifos
wire n_almost_full0,n_almost_full1;
wire nn_almost_empty0, nn_almost_empty1;
wire n_fifo_empty0, n_fifo_empty1;
wire nn_Fifo_full0, nn_Fifo_full1;
wire nn_fifo_error0,nn_fifo_error1;
wire nn_fifo_pause0, nn_fifo_pause1;

wire [DATA_SIZE-1:0] n_outF0;
wire [DATA_SIZE-1:0] n_outF1;



// fist module
serieparalelo serie_paralelo_0(/*AUTOINST*/
		// Outputs
		.out (out_sp0), // 8 bits
		.valid (nn_valid0),
		.active (nn_active0),
		// Inputs
		.clk (clk),
		.clk8f (clk8f),
		.reset (reset),
		.in  (in0)
);

// second module
serieparalelo serie_paralelo_1(/*AUTOINST*/
		// Outputs
		.out (out_sp1), // 8 bits
		.valid (nn_valid1),
		.active (nn_active1),
		// Inputs
		.clk (clk),
		.clk8f (clk8f),
		.reset (reset),
		.in  (in1)
);


fifo_param  #( .DATA_SIZE(DATA_SIZE), .MAIN_SIZE(MAIN_SIZE) )
fifo_4x8_0(/*AUTOINST*/
		// Outputs
		.almost_full (n_almost_full0), // output disp2
		.almost_empty (nn_almost_empty0),// output disp2 as empty0
		.fifo_empty (n_fifo_empty0),
		.Fifo_full (nn_Fifo_full0),
		.fifo_error (nn_fifo_error0),
		.data_out_pop (n_outF0), // 8 bits
		// Inputs
		.clk (clk8f),
		.reset (reset),
		.read (read0), // Because not df right know it comming from tester
		.write (write0),
		.data_in_push (out_sp0) // 8 bits
);

fifo_param  #( .DATA_SIZE(DATA_SIZE), .MAIN_SIZE(MAIN_SIZE) )
fifo_4x8_1(/*AUTOINST*/
		// Outputs
		.almost_full (n_almost_full1), // output disp2
		.almost_empty (nn_almost_empty1),// output disp2 as empty1
		.fifo_empty (n_fifo_empty1),
		.Fifo_full (nn_Fifo_full1),
		.fifo_error (nn_fifo_error1),
		.data_out_pop (n_outF1), // 8 bits
		// Inputs
		.clk (clk8f),
		.reset (reset),
		.read (read1), // Because not df right know it comming from tester
		.write (write1),
		.data_in_push (out_sp1) // 8 bits
);

// We have 6 outputs
// [DATA_SIZE-1:0] out0, // out from fifo0
// [DATA_SIZE-1:0] out1,  // out from fifo1
// almost_full_f0, // output from fifo 0
// almost_full_f1 // output from fifo 0
// empty0, // output from fifo 0
// empty1 // output from fifo  1
// So we need an bloking assing
always @(*) begin
out0 = n_outF0;
out1 = n_outF1;
almost_full_f0 = n_almost_full0;
almost_full_f1 = n_almost_full1;
empty0 = n_fifo_empty0;
empty1 = n_fifo_empty1;
end

endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
