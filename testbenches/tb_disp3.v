// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef TB_DISP3
`define TB_DISP3


// scale time unit (value of one) / precision
`timescale 	1ns				/ 1ps
// includes verilog files
// Can be omitted and called from the testbench
// Cmos
`include "./lib/cmos_cells.v"
`include "./src/disp3.v"
`include "./syn/disp3_syn.v"
`include "./testers/t_disp3.v"


module TestBench; // Testbench

parameter DATA_SIZE = 10;
parameter MAIN_SIZE = 8;
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
wire reset, clk, clk8f;
wire [DATA_SIZE-1:0] in;
wire [MAIN_SIZE-1:0] out0_BTB, out1_BTB;
wire [MAIN_SIZE-1:0] out0_STB, out1_STB;
wire Error0_BTB, Error1_BTB;
wire Error0_STB, Error1_STB;
wire valid;

///////////////////////////////////////////////////////////////////////////////////////////
              //////////// Device 3 BEHAVIORAL
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

device3 #( .DATA_SIZE (DATA_SIZE), .MAIN_SIZE (MAIN_SIZE) )
device3_TB(

//Outputs
.out0 (out0_BTB), // out from fifo4x8 #0
.out1 (out1_BTB),  // out from fifo4x8 #1
.Error0 (Error0_BTB), // Error fifo4x8 #0
.Error1 (Error1_BTB), // Error fifo4x8 #1

//INPUTS
.clk (clk),
.clk8f (clk8f),
.reset (reset),
.in (in),
.valid  (valid)
);
///////////////////////////////////////////////////////////////////////////////////////////
              //////////// Device 3 SYN
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

device3_syn device3_syn_TB (/*AUTOINST*/
//Outputs
.out0 (out0_STB), // out from fifo4x8 #0
.out1 (out1_STB),  // out from fifo4x8 #1
.Error0 (Error0_STB), // Error fifo4x8 #0
.Error1 (Error1_STB), // Error fifo4x8 #1

//INPUTS
.clk (clk),
.clk8f (clk8f),
.reset (reset),
.in (in),
.valid    (valid)
);


///////////////////////////////////////////////////////////////////////////////////////////
              //////////// TESTER Device 3
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

t_device3 #( .DATA_SIZE (DATA_SIZE), .MAIN_SIZE (MAIN_SIZE) )
 t_device3_TB (/*AUTOINST*/
  // Outputs
  .reset (reset),
  .clk (clk),
  .clk8f (clk8f),
  .in (in),
  .valid (valid),
  // Inputs
  .out0 (out0_BTB),
  .out1 (out1_BTB),
  //Syn
  .out0_s (out0_STB),
  .out1_s (out1_STB),

  .Error0_BTB (Error0_BTB),
  .Error1_BTB (Error1_BTB),
  .Error0_STB (Error0_STB),
  .Error1_STB (Error1_STB)
);


endmodule



// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
