// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef TB_MUX21
`define TB_MUX21



// scale time unit (value of one) / precision
`timescale 	1ns		/ 1ps
// includes verilog files
// Can be omitted and called from the testbench
// Cmos
`include "./lib/cmos_cells.v"
`include "./src/mux2x1_behav.v"
`include "./syn/mux2x1_behav_syn.v"
`include "./testers/t_mux21.v"

module TestBench; // Testbench
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
wire reset_TB, clk_TB, in0_valid_TB, in1_valid_TB;
wire pop0_TB, pop1_TB;
wire valid_out_BTB, valid_out_STB;
wire [9:0] in0_TB, in1_TB;
wire [7:0] out_BTB;
wire [7:0] out_STB;

///////////////////////////////////////////////////////////////////////////////////////////
              //////////// MUX 2:1 BEHAVIORAL
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

mux21 mux21_TB (/*AUTOINST*/
// Outputs
.out (out_BTB),
.valid_out (valid_out_BTB),
//Inputs
.clk (clk_TB),
.reset (reset_TB),
.pop0 (pop0_TB),
.pop1 (pop1_TB),
.in0 (in0_TB),
.in1 (in1_TB),
.in0_valid (in0_valid_TB),
.in1_valid (in1_valid_TB)
);



///////////////////////////////////////////////////////////////////////////////////////////
              //////////// MUX 2:1 SYN
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

mux21_syn mux21_syn_TB (/*AUTOINST*/
// Outputs
.out (out_STB),
.valid_out (valid_out_STB),
//Inputs
.clk (clk_TB),
.reset (reset_TB),
.pop0 (pop0_TB),
.pop1 (pop1_TB),
.in0 (in0_TB),
.in1 (in1_TB),
.in0_valid (in0_valid_TB),
.in1_valid (in1_valid_TB)
);


///////////////////////////////////////////////////////////////////////////////////////////
              //////////// TESTER MUX 2:1
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

t_mux21 t_mux21_TB (/*AUTOINST*/
// Outputs
.out (out_BTB),
.valid_out (valid_out_BTB),
.out_s (out_STB),
.valid_out_s (valid_out_STB),
//Inputs
.clk (clk_TB),
.reset (reset_TB),
.pop0 (pop0_TB),
.pop1 (pop1_TB),
.in0 (in0_TB),
.in1 (in1_TB),
.in0_valid (in0_valid_TB),
.in1_valid (in1_valid_TB)
);




endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
