// 	//	 /////  /////
//  //   //		  // //
// 	//	 //	    ///_
//////   /////  //  // 

////////////////////////////////
// Belinda Brown Ramírez      //
// timna.brown@ucr.ac.cr      // 
// Brandon Esquivel Molina    //
// brandon.esquivel@ucr.ac.cr //
// Revision: June, 2020 	    //
////////////////////////////////

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
wire                      wire_fifo0_empty_BTB;
wire                      wire_fifo1_empty_BTB;
wire                      wire_fifo0_empty_STB;
wire                      wire_fifo1_empty_STB;
wire                      Error_BTB;
wire                      Error_STB;
// behav out
wire [DATA_SIZE-1:0]      out0_BTB;
wire [DATA_SIZE-1:0]      out1_BTB;
// struct out
wire  [DATA_SIZE-1:0]     out0_STB;
wire  [DATA_SIZE-1:0]     out1_STB;

// general 
wire  [DATA_SIZE-1:0]     in;
wire                      reset;
wire                      clk;
wire                      fifo_up0_almostfull;
wire                      fifo_up1_almostfull;
wire                      valid;




///////////////////////////////////////////////////////////////////////////////////////////
              //////////// class switching behavorial
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

classswitching #( .DATA_SIZE (DATA_SIZE), .MAIN_SIZE (MAIN_SIZE) ) 
  class_b(/*AUTOINST*/
    // Outputs    
    .out0                   (out0_BTB),
    .out1                   (out1_BTB),
    .Error                  (Error_BTB),  
    .fifo_empty0            (wire_fifo0_empty_BTB),        
    .fifo_empty1            (wire_fifo1_empty_BTB),        

    //Inputs  
    .reset                  (reset),
    .valid                  (valid),  
    .clk                    (clk),    
    .pop_0                  (pop_0),
    .pop_1                  (pop_1),    
    .in                     (in)
    );


///////////////////////////////////////////////////////////////////////////////////////////
              ////////////  class SYN
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////


classswitching_syn  class_s(/*AUTOINST*/
    // Outputs   
    .out0                   (out0_STB),
    .out1                   (out1_STB),
    .Error                  (Error_STB),  
    .fifo_empty0            (wire_fifo0_empty_STB),        
    .fifo_empty1            (wire_fifo1_empty_STB),        

    //Inputs  
    .reset                  (reset),  
    .valid                  (valid),
    .clk                    (clk),
    .pop_0                  (pop_0),
    .pop_1                  (pop_1),    
    .in                     (in)
    );




///////////////////////////////////////////////////////////////////////////////////////////
              //////////// TESTER class
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

t_class  #( .DATA_SIZE ( DATA_SIZE), .MAIN_SIZE(MAIN_SIZE))
  t_classTB (/*AUTOINST*/
    //Outputs   
    .out0                   (out0_BTB),
    .out1                   (out1_BTB),
    .Error                  (Error_BTB),  
    .fifo_empty0            (wire_fifo0_empty_BTB),        
    .fifo_empty1            (wire_fifo1_empty_BTB),
    // Structural 
    .out0_s                 (out0_STB),
    .out1_s                 (out1_STB),
    .Error_s                (Error_STB),
    .fifo_empty0_s          (wire_fifo0_empty_STB),        
    .fifo_empty1_s          (wire_fifo1_empty_STB),        

    // OUTPUTS
    .reset                  (reset), 
    .valid                  (valid),
    .clk                    (clk),
    .pop_0                  (pop_0),
    .pop_1                  (pop_1),    
    .in                     (in)
    );


endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
