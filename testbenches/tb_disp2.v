// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef TB_DISP2
`define TB_DISP2


// scale time unit (value of one) / precision
`timescale 	1ns	/ 1ps


`include "./src/disp2.v"
`include "./syn/disp2_syn.v"
`include "./testers/t_disp2.v"

module TestBench;

// Usually the signals in the test bench are wires.
// They do not store a value, they are handled by other module instances.
// Since they require matching the size of the inputs and outputs, they must be assigned their size
// defined in the modules

// If you define quantity format, it is recommended to keep it in the same format being the
// same used in the module for the number of bits - [1: 0] ---, another way to do it is with
// [0: 1]

// We are going to use AUTOINST: It is responsible for replacing the connections (considering it is HDL)
// pin to an instance (module) with variables as they change over time automatically in the instantiated module

// It's needed /*AUTOWIRE*/ because: Creates wires for outputs that ins't declare

/*AUTOWIRE*/
// Outputs
wire [7:0] out0_BTB, out1_BTB;
wire almost_full_f0_BTB, almost_full_f1_BTB;
wire empty0_BTB, empty1_BTB;
// Syn
wire [7:0] out0_STB, out1_STB;
wire almost_full_f0_STB, almost_full_f1_STB;
wire empty0_STB, empty1_STB;
// Inputs
wire reset;
wire clk, clk8f;
wire read0_TB, write0_TB, read1_TB, write1_TB;

wire in0_TB, in1_TB;

///////////////////////////////////////////////////////////////////////////////////////////
							//////////// Device 2 BEHAV
							////////////
///////////////////////////////////////////////////////////////////////////////////////////


device2  device2_TB (/*AUTOINST*/
	// Outputs
	.out0  (out0_BTB),
	.out1  (out1_BTB),
	.almost_full_f0 (almost_full_f0_BTB),
	.almost_full_f1 (almost_full_f1_BTB),
	.empty0 (empty0_BTB),
	.empty1 (empty1_BTB),
	// Inputs
	.clk   (clk),
	.clk8f (clk8f),
	.reset (reset),
	.read0  (read0_TB),
	.read1  (read1_TB),
	.write0 (write0_TB),
	.write1 (write1_TB),
	.in0 (in0_TB),
	.in1 (in1_TB)
);


///////////////////////////////////////////////////////////////////////////////////////////
							////////////  Device 2 SYN
							////////////
///////////////////////////////////////////////////////////////////////////////////////////

device2_syn device2_syn_TB (/*AUTOINST*/
	// Outputs
	.out0  (out0_BTB),
	.out1  (out1_BTB),
	.almost_full_f0 (almost_full_f0_BTB),
	.almost_full_f1 (almost_full_f1_BTB),
	.empty0 (empty0_STB),
	.empty1 (empty1_STB),
	// Inputs
	.clk   (clk),
	.clk8f (clk8f),
	.reset (reset),
	.read0  (read0_TB),
	.read1  (read1_TB),
	.write0 (write0_TB),
	.write1 (write1_TB),
	.in0 (in0_TB),
	.in1 (in1_TB)
);

///////////////////////////////////////////////////////////////////////////////////////////
							//////////// TESTER device 2
							////////////
///////////////////////////////////////////////////////////////////////////////////////////


t_device2 t_device2_TB (/*AUTOINST*/
		// Outputs
		.out0  (out0_BTB),
		.out1  (out1_BTB),
		.almost_full_f0 (almost_full_f0_BTB),
		.almost_full_f1 (almost_full_f1_BTB),
		.empty0 (empty0_BTB),
		.empty1 (empty1_BTB),

		.out0_s  (out0_STB),
		.out1_s  (out1_STB),
		.almost_full_f0_s (almost_full_f0_STB),
		.almost_full_f1_s (almost_full_f1_STB),
		.empty0_s (empty0_STB),
		.empty1_s (empty1_STB),
		// Inputs
		.clk   (clk),
		.clk8f (clk8f),
		.reset (reset),
		.read0  (read0_TB),
		.read1  (read1_TB),
		.write0 (write0_TB),
		.write1 (write1_TB),
		.in0 (in0_TB),
		.in1 (in1_TB)
);



endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
