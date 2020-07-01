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
input wire read0, // need to connect with df control and fifo0
input wire read1, // need to connect with df control and fifo1
input wire write0, // need to connect with write and fifo0
input wire write1, // need to connect with write and fifo1
//Outputs
output reg [MAIN_SIZE-1:0] out0, // out from fifo4x8 #0
output reg [MAIN_SIZE-1:0] out1,  // out from fifo4x8 #1
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
wire [MAIN_SIZE-1:0] out0_disp3, out1_disp3;
wire nn_alf0, nn_alf1; // almost full 1 and 2
wire nn_empty0, nn_empty1; // empty 1 and 2
// wire nn_read0, nn_write0; // for write and write
// wire nn_read1, nn_write1; // for write and write

device1  #( .DATA_SIZE(DATA_SIZE), .MAIN_SIZE(MAIN_SIZE) )
 device1_in3(/*AUTOINST*/
  //Outputs
  .out0 (outF0), // out from fifo6x8 #0
  .out1 (outF1),  // out from fifo6x8 #1
  .Error_class (Error_F0),
  .Error_route (Error_F1),
  //INPUTS
  .clk (clk),
  .clk8f (clk8f),
  .reset(reset),
  .in (in),
  .fifo0_disp2_almostfull (nn_alf0),
  .fifo1_disp2_almostfull (nn_alf1)
);


//// inital par 8 main size and 10 data size
//// 4 main size 8 data size
device2  #( .DATA_SIZE(DATA_SIZE-2), .MAIN_SIZE(MAIN_SIZE-4) )
device2_in3(/*AUTOINST*/
// Outputs
.out0 (out0_disp3),
.out1 (out1_disp3),
.almost_full_f0 (nn_alf0),
.almost_full_f1 (nn_alf1),
.empty0 (nn_empty0),
.empty1 (nn_empty1),
// Inputs
.in0 (outF0),
.in1 (outF1),
.reset (reset),
.clk (clk),
.clk8f (clk8f),
.read0 (read0),
.read1 (read1),
.write0 (write0),
.write1 (write1)
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
