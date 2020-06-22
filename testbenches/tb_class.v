// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef TB_CLASS
`define TB_CLASS


// scale time unit (value of one) / precision
`timescale 	1ns	/ 1ps

`include "./lib/cmos_cells.v"
`include "./src/class.v"
`include "./syn/class_syn.v"
`include "./testers/t_class.v"

module TestBench; 


parameter DATA_SIZE = 10;       
parameter MAIN_SIZE = 8;

// Testbench
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

//wire emptyF0, emptyF1; 

// behav wires
wire almost_full0_BTB, almost_empty0_BTB, fifo0_empty_BTB, fifo_full0_BTB, fifo0_error_BTB, fifo0_pause_BTB;   // almost_full1_in_BTB;
wire almost_full1_BTB, almost_empty1_BTB, fifo1_empty_BTB, fifo_full1_BTB, fifo1_error_BTB, fifo1_pause_BTB;
// struct wires
wire almost_full0_STB, almost_empty0_STB, fifo0_empty_STB, fifo_full0_STB, fifo0_error_STB, fifo0_pause_STB;   // almost_full1_in_STB;
wire almost_full1_STB, almost_empty1_STB, fifo1_empty_STB, fifo_full1_STB, fifo1_error_STB, fifo1_pause_STB;
// behav out
wire [DATA_SIZE-1:0] out0_BTB;
wire [DATA_SIZE-1:0] out1_BTB;
// struct out
wire  [DATA_SIZE-1:0] out0_STB;
wire  [DATA_SIZE-1:0] out1_STB;
// general 
wire  reset;
wire  clk;
wire  [DATA_SIZE-1:0] in;
wire Error;


///////////////////////////////////////////////////////////////////////////////////////////
              //////////// class switching behavorial
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

classswitching  class_b(/*AUTOINST*/
    // Outputs   
    .out0     ( out0_BTB ),
    .out1     ( out1_BTB ),
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
    .in       ( in     ),
    .clk      ( clk    ),
    .reset    ( reset  )
);


///////////////////////////////////////////////////////////////////////////////////////////
              ////////////  class SYN
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////


classswitching_syn  class_s(/*AUTOINST*/
    // Outputs
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
    .in       ( in     ),
    .clk      ( clk    ),
    .reset    ( reset  )
);





///////////////////////////////////////////////////////////////////////////////////////////
              //////////// TESTER class
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

t_class t_classTB (/*AUTOINST*/
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
    .Error    (Error),
  // Inputs
    .in       ( in     ),
    .clk      ( clk    ),
    .reset    ( reset  )

);



endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
