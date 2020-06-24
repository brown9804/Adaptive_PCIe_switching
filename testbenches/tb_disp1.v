// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef TB_DISP1
`define TB_DISP1


// scale time unit (value of one) / precision
`timescale 	1ns	/ 1ps

`include "./lib/cmos_cells.v"
`include "./src/class.v"
`include "./syn/disp1_syn.v"
`include "./testers/t_disp1.v"

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
wire [7:0] out0_BTB, out1_BTB;
wire Error_BTB, Error_STB;
wire clk, reset;
wire [9:0] in_TB;
///////////////////////////////////////////////////////////////////////////////////////////
              //////////// Device 1
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

device1  device1_b(/*AUTOINST*/
  //Outputs
  .out0 (out0_BTB), // out from fifo6x8 #0
  .out0 (out1_BTB), // out from fifo6x8 #0
  .Error (Error_BTB),

  //control for fifos Internal - now in beta version
  /*
  output reg almost_full0,
  output reg almost_empty0,
  output reg fifo0_empty,
  output reg fifo0_error,
  output reg fifo0_pause,
  output reg fifo_full0,
  output reg fifo_full1,
  output reg almost_full1,
  output reg almost_empty1,
  output reg fifo1_empty,
  output reg fifo1_error,
  output reg fifo1_pause,*/
  //Inputs
  .clk (clk),
  .reset (reset),
  .in (in_TB)
);

///////////////////////////////////////////////////////////////////////////////////////////
              ////////////  Device 1 SYN
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

device1_syn  device1_s(/*AUTOINST*/
  //Outputs
  .out0 (out0_STB), // out from fifo6x8 #0
  .out0 (out1_STB), // out from fifo6x8 #0
  .Error (Error_STB),

  //control for fifos Internal - now in beta version
  /*
  output reg almost_full0,
  output reg almost_empty0,
  output reg fifo0_empty,
  output reg fifo0_error,
  output reg fifo0_pause,
  output reg fifo_full0,
  output reg fifo_full1,
  output reg almost_full1,
  output reg almost_empty1,
  output reg fifo1_empty,
  output reg fifo1_error,
  output reg fifo1_pause,*/
  //Inputs
  .clk (clk),
  .reset (reset),
  .in (in_TB)
);


///////////////////////////////////////////////////////////////////////////////////////////
              //////////// TESTER device 1
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

t_device1 t_device1TB (/*AUTOINST*/
  //Outputs
  .out0 (out0_BTB), // out from fifo6x8 #0
  .out0 (out1_BTB), // out from fifo6x8 #0
  .Error (Error_BTB),
  .out0_s (out0_STB), // out from fifo6x8 #0
  .out0_s (out1_STB), // out from fifo6x8 #0
  .Error_s (Error_STB),
  //control for fifos Internal - now in beta version
  /*
  output reg almost_full0,
  output reg almost_empty0,
  output reg fifo0_empty,
  output reg fifo0_error,
  output reg fifo0_pause,
  output reg fifo_full0,
  output reg fifo_full1,
  output reg almost_full1,
  output reg almost_empty1,
  output reg fifo1_empty,
  output reg fifo1_error,
  output reg fifo1_pause,*/
  //Inputs
  .clk (clk),
  .reset (reset),
  .in (in_TB)
);


endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif