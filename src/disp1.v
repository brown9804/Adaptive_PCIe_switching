/////////////////////////////////                      .        .
//  Brandon Equivel             //                        .  .
//  brandon.esquivel@ucr.ac.cr   ///////////............///////
//  Belinda Brown Ramírez         //////////.............//////    .
//  timna.brown@ucr.ac.cr        //
//  June, 2020                 //                        .    .      .
////////////////////////////////                       .
      ///           ///
    ///               ///
  ///                   ///
////                    /////

`ifndef DISP1
`define DISP1

`timescale 1ns/1ps

`include "./src/class.v"
`include "./src/routing.v"
`include "./src/paratoserial.v"

// Implementation of first layer "device 1" for Adaptative PCIe Switching, 
// Assign 0 relative to fifo0
// Assign 1 relative to fifo1

module device1 #(
  parameter DATA_SIZE = 10, 
  parameter MAIN_SIZE = 8) 
  (


//Outputs
output reg                      out0,                  // out from serial parallel #0
output reg                      out1,                  // out from serial parallel #0
output reg                      Error_class,
output reg                      Error_route,
//INPUTS                                                          
input wire [DATA_SIZE-1:0]      in,
input wire                      clk,
input wire                      clk8f,
input wire                      reset,
//input wire                      pop_0,
//input wire                      pop_1,
input wire                      fifo0_disp2_almostfull,
input wire                      fifo1_disp2_almostfull
);


// Internal nodes and wires

wire [DATA_SIZE-1:0]            out0_class;
wire [DATA_SIZE-1:0]            out1_class;
wire                            error_class;
wire                            fifo0_empty_class;
wire                            fifo1_empty_class;
wire                            n_pop0_class;
wire                            n_pop1_class;
wire                            n_pop0_route;
wire                            n_pop1_route;
wire [DATA_SIZE-3:0]            out0_route;
wire [DATA_SIZE-3:0]            out1_route;
wire                            fifo0_almost_empty_route;
wire                            fifo1_almost_empty_route;
wire                            error_route;
wire                            out0_serial;
wire                            out1_serial;

classswitching #(.DATA_SIZE(DATA_SIZE),.MAIN_SIZE(MAIN_SIZE) )
  classwit(/*AUTOINST*/
    // Outputs   
    .out0                   ( out0_class ),
    .out1                   ( out1_class ),
    .Error                  ( error_class),
    .fifo_empty0            ( fifo0_empty_class),
    .fifo_empty1            ( fifo1_empty_class),

    // Inputs
    .in                     ( in     ),
    .clk                    ( clk    ),
    .reset                  ( reset  ), 
    .pop_0                  ( n_pop0_class),   // from tester/disp
    .pop_1                  ( n_pop1_class)

);



router #( .DATA_SIZE(DATA_SIZE), .MAIN_SIZE(MAIN_SIZE) )
  route_TB(/*AUTOINST*/
    //Outputs
    .out0                   (out0_route),
    .out1                   (out1_route),
    .pop_0                  (n_pop0_class),
    .pop_1                  (n_pop1_class),
    .fifo0_almost_empty     (fifo0_almost_empty_route),
    .fifo1_almost_empty     (fifo1_almost_empty_route),
    .Error                  (error_route),

    // Input_route
    .clk                    (clk),
    .reset                  (reset),
    .in0                    (out0_class),
    .in1                    (out1_class),
    .fifo_empty0            (fifo0_empty_class),        //priority P0 
    .fifo_empty1            (fifo1_empty_class),
    .pop_0_in               (n_pop0_route),
    .pop_1_in               (n_pop1_route)

);




paratoserial #( .DATA_SIZE(DATA_SIZE-2) )
  paralleltoSerial(
    // Outputs
    .out0                   (out0_serial),
    .out1                   (out1_serial),
    .pop_0                  (n_pop0_route),   // to routering
    .pop_1                  (n_pop1_route),
    // Inputs
    .fifo_empty0            (fifo0_almost_empty_route),  
    .fifo_empty1            (fifo1_almost_empty_route),
    .fifo_up0_almostfull    (fifo0_disp2_almostfull),     
    .fifo_up1_almostfull    (fifo1_disp2_almostfull), 
    .in0                    (out0_route),
    .in1                    (out1_route),
    .clk                    (clk8f),
    .reset                  (reset)

);



  always@(*) begin      // pass to outputs
    out0              = out0_serial;
    out1              = out1_serial;
    Error_class       = error_class;
    Error_route       = error_route;
  end



endmodule


// Local Variables:
// verilog-library-directories:("."):
// verilog-auto-wire-type:\"logic\"
// End:

`endif
