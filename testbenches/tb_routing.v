// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef TB_ROUTING
`define TB_ROUTING


// scale time unit (value of one) / precision
`timescale 	1ns				/ 1ps
// includes verilog files
// Can be omitted and called from the testbench
// Cmos
`include "./lib/cmos_cells.v"
`include "./src/routing.v"
`include "./syn/routing_syn.v"
`include "./testers/t_routing.v"

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
wire clk, reset;
wire [9:0] in0, in1;
wire emptyF0, emptyF1;
wire classif;
wire [7:0] out0_BTB;
wire [7:0] out1_BTB;
wire almost_full0_BTB, almost_empty0_BTB;
wire fifo0_empty_BTB;
wire fifo0_error_BTB, fifo0_pause_BTB, almost_full1_in_BTB;
wire almost_empty1_BTB, fifo1_empty_BTB, fifo1_error_BTB, fifo1_pause_BTB;
wire fifo_full0_BTB, fifo_full1_BTB;
wire Error;

wire [7:0] out0_STB;
wire [7:0] out1_STB;
wire almost_full0_STB, almost_empty0_STB;
wire fifo0_emptySTB;
wire fifo0_error_STB, fifo0_pause_STB, almost_full1_in_STB;
wire almost_empty1_STB, fifo1_empty_STB, fifo1_error_STB, fifo1_pause_STB;
wire fifo_full0_STB, fifo_full1_STB;




///////////////////////////////////////////////////////////////////////////////////////////
              //////////// ROUTING BEHAVIORAL
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////


route route_TB(/*AUTOINST*/
  //Outputs
  .out0 (out0_BTB),
  .out1 (out1_BTB),
  .almost_full0 (almost_full0_BTB),
  .almost_empty0 (almost_empty0_BTB),
  .fifo0_empty (fifo0_empty_BTB),
  .fifo0_error (fifo0_error_BTB),
  .fifo0_pause (fifo0_pause_BTB),
  .almost_full1 (almost_full1_BTB),
  .almost_empty1 (almost_empty1_BTB),
  .fifo1_empty (fifo1_empty_BTB),
  .fifo1_error (fifo1_error_BTB),
  .fifo1_pause (fifo1_pause_BTB),
  .fifo_full0 (fifo_full0_BTB),
  .fifo_full1 (fifo_full1_BTB),
  .Error (Error),
  // Inputs
  .clk (clk),
  .reset (reset),
  .in0 (in0),
  .in1 (in1),
  .emptyF0 (emptyF0),
  .emptyF1 (emptyF1),
  .classif (classif)

);





///////////////////////////////////////////////////////////////////////////////////////////
              //////////// ROUTING SYN
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////


route_syn route_syn_TB(/*AUTOINST*/
  //Outputs
  .out0 (out0_STB),
  .out1 (out1_STB),
  .almost_full0 (almost_full0_STB),
  .almost_empty0 (almost_empty0_STB),
  .fifo0_empty (fifo0_empty_STB),
  .fifo0_error (fifo0_error_STB),
  .fifo0_pause (fifo0_pause_STB),
  .almost_full1 (almost_full1_STB),
  .almost_empty1 (almost_empty1_STB),
  .fifo1_empty (fifo1_empty_STB),
  .fifo1_error (fifo1_error_STB),
  .fifo1_pause (fifo1_pause_STB),
  .fifo_full0 (fifo_full0_STB),
  .fifo_full1 (fifo_full1_STB),
  .Error (Error),
  // Inputs
  .clk (clk),
  .reset (reset),
  .in0 (in0),
  .in1 (in1),
  .emptyF0 (emptyF0),
  .emptyF1 (emptyF1),
  .classif (classif)
);


///////////////////////////////////////////////////////////////////////////////////////////
              //////////// TESTER ROUTING
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////


t_route t_route_TB(/*AUTOINST*/
  //Outputs
  .out0 (out0_BTB),
  .out1 (out1_BTB),
  .almost_full0 (almost_full0_BTB),
  .almost_empty0 (almost_empty0_BTB),
  .fifo0_empty (fifo0_empty_BTB),
  .fifo0_error (fifo0_error_BTB),
  .fifo0_pause (fifo0_pause_BTB),
  .fifo_full0 (fifo_full0_BTB),
  .fifo_full1 (fifo_full1_BTB),
  .almost_full1 (almost_full1_BTB),
  .almost_empty1 (almost_empty1_BTB),
  .fifo1_empty (fifo1_empty_BTB),
  .fifo1_error (fifo1_error_BTB),
  .fifo1_pause (fifo1_pause_BTB),
  .Error (Error),
  // Structural
  .out0_s (out0_STB),
  .out1_s (out1_STB),
  .almost_full0_s (almost_full0_STB),
  .almost_empty0_s (almost_empty0_STB),
  .fifo0_empty_s (fifo0_empty_STB),
  .fifo0_error_s (fifo0_error_STB),
  .fifo0_pause_s (fifo0_pause_STB),
  .almost_full1_s (almost_full1_STB),
  .almost_empty1_s (almost_empty1_STB),
  .fifo1_empty_s (fifo1_empty_STB),
  .fifo1_error_s (fifo1_error_STB),
  .fifo1_pause_s (fifo1_pause_STB),
  .fifo_full0_s (fifo_full0_STB),
  .fifo_full1_s (fifo_full1_STB),
  // Inputs
  .clk (clk),
  .reset (reset),
  .in0 (in0),
  .in1 (in1),
  .emptyF0 (emptyF0),
  .emptyF1 (emptyF1),
  .classif (classif)
);


endmodule

// Local Variables:
// verilog-library-directories:("."):
// verilog-auto-wire-type:\"logic\"
// End:

`endif
