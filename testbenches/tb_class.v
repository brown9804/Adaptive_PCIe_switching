// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef TB_CLASS
`define TB_CLASS


// scale time unit (value of one) / precision
`timescale 	1ns	/ 100ps

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

// general 
wire  reset;
wire  clk;
wire  [DATA_SIZE-1:0] in;
wire  valid_in;

// behav
wire  [DATA_SIZE-1:0] out0;
wire  [DATA_SIZE-1:0] out1;
wire AF1_up;
wire AF2_up;
wire AE1_up;
wire AE2_up;

//struct
wire  [DATA_SIZE-1:0] out0_s;
wire  [DATA_SIZE-1:0] out1_s;
wire AF1_up_s;
wire AF2_up_s;
wire AE1_up_s;
wire AE2_up_s;


///////////////////////////////////////////////////////////////////////////////////////////
              //////////// class switching behavorial
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

classswitching  class_b(   
    .out0     ( out0 ),
    .out1     ( out1 ),
    .AF1_up   ( AF1_up ),
    .AF2_up   ( AF2_up ),
    .AE1_up   ( AE1_up ),
    .AE2_up   ( AE2_up ),
    .in       ( in     ),
    .clk      ( clk    ),
    .reset    ( reset  ),
    .valid_in ( valid_in)
);


///////////////////////////////////////////////////////////////////////////////////////////
              ////////////  class SYN
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////


classswitching_syn  class_s(
 
    .out0     ( out0_s ),
    .out1     ( out1_s ),
    .AF1_up   ( AF1_up_s ),
    .AF2_up   ( AF2_up_s ),
    .AE1_up   ( AE1_up_s ),
    .AE2_up   ( AE2_up_s ),
    .in       ( in     ),
    .clk      ( clk    ),
    .reset    ( reset  ),
    .valid_in ( valid_in)
);





///////////////////////////////////////////////////////////////////////////////////////////
              //////////// TESTER class
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

t_class t_classTB (

    .out0     ( out0 ),
    .out1     ( out1 ),
    .AF1_up   ( AF1_up ),
    .AF2_up   ( AF2_up ),
    .AE1_up   ( AE1_up ),
    .AE2_up   ( AE2_up ),
    
    .out0_s     ( out0_s ),
    .out1_s     ( out1_s ),
    .AF1_up_s   ( AF1_up_s ),
    .AF2_up_s   ( AF2_up_s ),
    .AE1_up_s   ( AE1_up_s ),
    .AE2_up_s   ( AE2_up_s ),

    .in       ( in     ),
    .clk      ( clk    ),
    .reset    ( reset  ),
    .valid_in ( valid_in)
);



endmodule



// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
