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

// TESTBENCH FOR MODULE FIFO

`timescale 	1ns	/ 1ps

`include "./src/fifo.v"
`include "./syn/fifo_syn.v"
`include "./testers/t_fifo.v"
`include "./lib/cmos_cells.v"

module testbench_fifo_8X10;

  parameter DATA_SIZE = 10;
  parameter MAIN_SIZE = 8;

  wire [DATA_SIZE-1:0]   data_in_push;
  wire                   clk;
  wire                   reset;
  wire                   read;
  wire                   write;
  
  // for behav
  wire [DATA_SIZE-1:0]   data_out_pop;
  wire                   almost_full;
  wire                   almost_empty;
  wire                   Fifo_full;
  wire                   fifo_empty;
  wire                   fifo_error;

  //for syn-struct
  wire [DATA_SIZE-1:0]   data_out_pop_s;
  wire                   almost_full_s;
  wire                   almost_empty_s;
  wire                   Fifo_full_s;
  wire                   fifo_empty_s;
  wire                   fifo_error_s;


///////////////////////////////////////////////////////////
//              behavorial                             ////
//////////////////////////////////////////////////////////

fifo_param #( .DATA_SIZE (DATA_SIZE), .MAIN_SIZE (MAIN_SIZE)  ) 
  fifo_BTB (
    // OUTPUTS
    .data_out_pop             (data_out_pop),
    .almost_full              (almost_full),
    .almost_empty             (almost_empty),
    .Fifo_full                (Fifo_full),
    .fifo_empty               (fifo_empty),
    .fifo_error               (fifo_error),
    // INPUTS
    .clk                      (clk),
    .reset                    (reset),
    .read                     (read),
    .write                    (write),
    .data_in_push             (data_in_push)
  );


///////////////////////////////////////////////////////////
//            structural/synth                         ////
//////////////////////////////////////////////////////////

fifo_param_syn fifo_STB (/*AUTOINST*/
    // OUTPUTS
    .data_out_pop             (data_out_pop_s),
    .almost_full              (almost_full_s),
    .almost_empty             (almost_empty_s),
    .Fifo_full                (Fifo_full_s),
    .fifo_empty               (fifo_empty_s),
    .fifo_error               (fifo_error_s),
    // INPUTS
    .clk                      (clk),
    .reset                    (reset),
    .read                     (read),
    .write                    (write),
    .data_in_push             (data_in_push)
);


///////////////////////////////////////////////////////////
//                      tester                         ////
//////////////////////////////////////////////////////////

fifo_tester  #( .DATA_SIZE (DATA_SIZE), .MAIN_SIZE(MAIN_SIZE)  ) 
  fifo_tester_TB (/*AUTOINST*/
    // INPUTS FROM BEHAV
    .data_out_pop             (data_out_pop),
    .almost_full              (almost_full),
    .almost_empty             (almost_empty),
    .Fifo_full                (Fifo_full),
    .fifo_empty               (fifo_empty),
    .fifo_error               (fifo_error),
    // INPUTS FROM STRUCT
    .data_out_pop_s             (data_out_pop_s),
    .almost_full_s              (almost_full_s),
    .almost_empty_s             (almost_empty_s),
    .Fifo_full_s                (Fifo_full_s),
    .fifo_empty_s               (fifo_empty_s),
    .fifo_error_s               (fifo_error_s),
    // OUTPUTS
    .clk                      (clk),
    .reset                    (reset),
    .read                     (read),
    .write                    (write),
    .data_in_push             (data_in_push)
);

endmodule
