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


	output reg [DATA_SIZE-1:0] out0, // out from fifo0
	output reg [DATA_SIZE-1:0] out1,  // out from fifo1
	output reg almost_full_f0, // output from fifo 0
	output reg almost_full_f1, // output from fifo 0	
	output reg pop_0,
	output reg pop_1,
	
	input wire clk, 	// just to see
	input wire clk8f, 	// used to data manipulation
	input wire reset, 	// always requiered a reset in each block
	input wire in0,		// output Paralelo - Serie #0
	input wire in1,		// output Paralelo - Serie #1
	input wire empty0,  // output from fifo 0
	input wire empty1,
	input wire fifo_almost_empty0,
	input wire fifo_almost_empty1

);

reg read0;
reg read1;

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
		.write (pop_0),
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
		.write (pop_1),
		.data_in_push (out_sp1) // 8 bits
);


always @(*) begin
	out0 = n_outF0;
	out1 = n_outF1;
	almost_full_f0 = n_almost_full0;
	almost_full_f1 = n_almost_full1;

	if ( empty0 | fifo_almost_empty0) begin
	  read0 = 0;
	end else begin
	  read0 = 1;
	end

	if( empty1 | fifo_almost_empty1) begin
	  read1 = 0;
	end else begin
	  read1 = 1;
	end

	end


  always @(posedge clk) begin      // Each positive edge of the clock make these changes
    // Reset synchronous
    if (!reset) begin             // If reset in LOW nonblobking assing zero
      pop_0         <= 0;
      pop_1         <= 0;
    end           // end reset zero
    else begin      // reset == 1
      // data flow control push pop logig
    if( empty0 | fifo_almost_empty0 ) begin
        pop_0       <= 0;
	end else begin
        pop_0 <= 1;
	end
    
	if( empty1 | fifo_almost_empty1 ) begin
          pop_1      <= 0;
        end else begin
          pop_1      <= 1;
        end 
	end
	end   

endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
