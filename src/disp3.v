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


device1  device1_in3(/*AUTOINST*/
  //Outputs
  .out0 (), // out from fifo6x8 #0
  .out1 (),  // out from fifo6x8 #1
  .Error_class (),
  .Error_route (),
  //INPUTS
  .clk (),
  .clk8f (),

  .reset(),
  .in ()
);



device2 device2_in3(/*AUTOINST*/
// Outputs
.out1 (),
.out2 (),
.almost_full_f1 (),
.almost_full_f2 (),
// Inputs
.in1 (),
.in2 (),
.reset (),
.clk (),
.clk8f (),
.read (),
.write ()
);



  always@(*) begin      // pass to outputs
    out0 = outF0;
    out1 = outF1;
    Error0 = Error_F0;
    Error1  = Error_F1;
  end



endmodule


// Local Variables:
// verilog-library-directories:("."):
// verilog-auto-wire-type:\"logic\"
// End:

`endif
