// Brandon Esquivel Molina
// Belinda Brown Ramirez
// Testbench for Device1 
// brandon.esquivel@ucr.ac.cr
// timna.brown@ucr.ac.cr 

`ifndef TB_DISP1
`define TB_DISP1


// scale time unit (value of one) / precision
`timescale 	1ns	/ 1ps

`include "./lib/cmos_cells.v"
`include "./src/disp1.v"
`include "./syn/disp1_syn.v"
`include "./testers/t_disp1.v"

module TestBench;



parameter DATA_SIZE = 10;       
parameter MAIN_SIZE = 8;


/*AUTOWIRE*/
wire [DATA_SIZE-1:0]      in_TB;
wire                      clk1f;
wire                      clk8f;
wire                      reset;
wire                      pop_0;
wire                      pop_1;
wire                      fifo0_disp2_almostfull;
wire                      fifo1_disp2_almostfull;
wire                      out0_STB;
wire                      out1_STB;
wire                      out0_BTB;
wire                      out1_BTB;
wire                      error_class_STB;
wire                      error_route_STB;
wire                      error_class_BTB;
wire                      error_route_BTB;


///////////////////////////////////////////////////////////////////////////////////////////
              //////////// Device 1 BEHAV
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

device1  device1_b(/*AUTOINST*/
  //Outputs
  .out0                            (out0_BTB),
  .out1                            (out1_BTB),
  .Error_class                     (error_class_BTB),
  .Error_route                     (error_route_BTB),
   // INPUTS                                             
  .in                              (in_TB),           
  .clk                             (clk1f),             
  .clk8f                           (clk8f),               
  .reset                           (reset),                             
  .fifo0_disp2_almostfull          (fifo0_disp2_almostfull),                               
  .fifo1_disp2_almostfull          (fifo1_disp2_almostfull)                               

);

///////////////////////////////////////////////////////////////////////////////////////////
              ////////////  Device 1 SYN
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

device1_syn  device1_s(/*AUTOINST*/
  //Outputs
  .out0                            (out0_STB),
  .out1                            (out1_STB),
  .Error_class                     (error_class_STB),
  .Error_route                     (error_route_STB),
   // INPUTS                                             
  .in                              (in_TB),           
  .clk                             (clk1f),             
  .clk8f                           (clk8f),               
  .reset                           (reset),                            
  .fifo0_disp2_almostfull          (fifo0_disp2_almostfull),                               
  .fifo1_disp2_almostfull          (fifo1_disp2_almostfull)                               

);


///////////////////////////////////////////////////////////////////////////////////////////
              //////////// TESTER device 1
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

t_device1 t_device1TB (/*AUTOINST*/
  // OUTPUTS
  .in                              (in_TB),
  .clk                             (clk1f),
  .clk8f                           (clk8f),
  .reset                           (reset),
  .fifo0_disp2_almostfull          (fifo0_disp2_almostfull),
  .fifo1_disp2_almostfull          (fifo1_disp2_almostfull),
 
 // IMPUTS
  // Structural/synth
  .out0_s                          (out0_STB),
  .out1_s                          (out1_STB),
  .Error_class_s                   (error_class_STB),
  .Error_route_s                   (error_route_STB),
  // Behavorial
  .out0                            (out0_BTB),
  .out1                            (out1_BTB),
  .Error_class                     (error_class_BTB),
  .Error_route                     (error_route_BTB)
                                           
);


endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
