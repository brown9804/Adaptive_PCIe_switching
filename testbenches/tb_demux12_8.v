// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef TB_DEMUX12_8
`define TB_DEMUX12_8


// scale time unit (value of one) / precision
`timescale 	1ns				/ 1ps
// includes verilog files
// Can be omitted and called from the testbench
// Cmos
`include "./lib/cmos_cells.v"
`include "./src/demux1x2_8_behav.v"
`include "./syn/demux1x2_8_behav_syn.v"
`include "./testers/t_demux12_8.v"

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
wire reset_TB, clk_TB, valid_in_TB, select_TB;
wire push_0_BTB, push_1_BTB;
wire push_0_STB, push_1_STB;
wire [1:0] valid_out_BTB, valid_out_STB;
wire [7:0] in_TB;
wire [7:0] out0_BTB;
wire [7:0] out1_BTB;
wire [7:0] out0_STB;
wire [7:0] out1_STB;

///////////////////////////////////////////////////////////////////////////////////////////
              //////////// DEMUX 1:2 BEHAVIORAL
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

demux12_8 demux12_8_TB (/*AUTOINST*/
// Outputs
.push_0 (push_0_BTB),
.push_1 (push_1_BTB),
.out0 (out0_BTB),
.out1 (out1_BTB),
.valid_out (valid_out_BTB),
//Inputs
.reset (reset_TB),
.clk (clk_TB),
.in (in_TB),
.valid_in (valid_in_TB),
.select (select_TB)
);


///////////////////////////////////////////////////////////////////////////////////////////
              //////////// DEMUX 1:2 SYN
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

demux12_8_syn demux12_8_syn_TB (/*AUTOINST*/
// Outputs
.push_0 (push_0_STB),
.push_1 (push_1_STB),
.out0 (out0_STB),
.out1 (out1_STB),
.valid_out (valid_out_STB),
// Inputs
.reset (reset_TB),
.clk (clk_TB),
.in (in_TB),
.valid_in (valid_in_TB),
.select (select_TB)
);


///////////////////////////////////////////////////////////////////////////////////////////
              //////////// TESTER DEMUX 1:2
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

t_demux1x2_8 t_demux1x2_8_TB (/*AUTOINST*/
// Outputs
.push_0 (push_0_BTB),
.push_1 (push_1_BTB),
.out0 (out0_BTB),
.out1 (out1_BTB),
.valid_out (valid_out_BTB),
.push_0_s (push_0_STB),
.push_1_s (push_1_STB),
.out0_s (out0_STB),
.out1_s (out1_STB),
.valid_out_s (valid_out_STB),
//Inputs
.reset (reset_TB),
.clk (clk_TB),
.in (in_TB),
.valid_in (valid_in_TB),
.select (select_TB)
);



endmodule



// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
