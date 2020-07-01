// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr


`ifndef DISP3
`define DISP3

`timescale 1ns/1ps

`include "./src/disp1.v"
`include "./src/disp2.v"


// Assign 0 relative to fifo0
// Assign 1 relative to fifo1

module device3 #(
  parameter DATA_SIZE = 10,
  parameter MAIN_SIZE = 8)
  (

//INPUTS
input wire clk,
input wire clk8f,
input wire reset,
input wire [DATA_SIZE-1:0] in,


//Outputs
output reg out0, // out from fifo4x8 #0
output reg out1,  // out from fifo4x8 #1
output reg Error0, // Error fifo4x8 #0
output reg Error1 // Error fifo4x8 #1

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


);
// // wires internally
wire outF0, outF1;
wire Error_F0, Error_F1;
wire [7:0] out0_disp3, out1_disp3;
wire nn_alf1, nn_alf2; // almost full 1 and 2
wire nn_read, nn_write; // for write and write

device1  device1_in3(/*AUTOINST*/
  //Outputs
  .out0 (outF0), // out from fifo6x8 #0 // output 1 bit
  .out1 (outF1),  // out from fifo6x8 #1 // output 1 bit
  .Error_class (Error_F0),
  .Error_route (Error_F1),
  //INPUTS
  .clk (clk),
  .clk8f (clk8f),

  .reset(reset),
  .in (in) // input 10 bits
);



device2 device2_in3(/*AUTOINST*/
// Outputs
.out1 (out0_disp3),  // output one bit
.out2 (out1_disp3), // output one bit
.almost_full_f1 (nn_alf1),
.almost_full_f2 (nn_alf2),
// Inputs
.in1 (outF0),  // input one bit
.in2 (outF1), // input one bit
.reset (reset),
.clk (clk),
.clk8f (clk8f),
.read (nn_read),
.write (nn_write)
);



  always@(*) begin      // pass to outputs
    out0 = out0_disp3;
    out1 = out1_disp3;
    Error0 = Error_F0;
    Error1  = Error_F1;
  end



endmodule


// Local Variables:
// verilog-library-directories:("."):
// verilog-auto-wire-type:\"logic\"
// End:

`endif
