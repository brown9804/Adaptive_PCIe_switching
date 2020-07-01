
//////////////////////////////////////////
// Brandon Esquivel Molina           ////
// brandon.esquivel@ucr.ac.cr        ///
// JUne,2020                         //
//////////////////////////////////////

`ifndef ROUTING
`define ROUTING

`timescale 1ns/1ps

`include "./src/mux2x1.v"
`include "./src/demux1x2.v"
`include "./src/fifo.v"


module router #(
  parameter DATA_SIZE = 10, 
  parameter MAIN_SIZE = 8) 

  // Outputs from fifos 8x10
// Assign 0 relative to fifo0
// Assign 1 relative to fifo1

( // Outputs
output reg [DATA_SIZE-3:0]      out0,           
output reg [DATA_SIZE-3:0]      out1,           
output reg                      Error,
output reg                      pop_0,
output reg                      pop_1,
output reg                      fifo0_almost_empty, 
output reg                      fifo1_almost_empty,
// Inputs
input wire [DATA_SIZE-1:0]      in0,
input wire [DATA_SIZE-1:0]      in1,
input wire                      clk,
input wire                      reset,
input wire                      pop_0_in, 
input wire                      pop_1_in,
input wire                      fifo_empty0,
input wire                      fifo_empty1 

);
// Internal wires and nodes

wire                            fifo_up0_almostfull;
wire                            fifo_up1_almostfull;
wire [DATA_SIZE-1:0]            out_mux;
wire [DATA_SIZE-3:0]            out0_demux;
wire [DATA_SIZE-3:0]            out1_demux;
wire [DATA_SIZE-3:0]            data_out_fifo0_to_out;
wire                            wire_fifo0_almost_full;
wire                            wire_fifo0_almost_empty;
wire                            wire_fifo0_full;
wire                            wire_fifo0_empty;
wire                            wire_fifo0_error;

wire  [DATA_SIZE-3:0]           data_out_fifo1_to_out;
wire                            wire_fifo1_almost_full;
wire                            wire_fifo1_almost_empty;
wire                            wire_fifo1_full;
wire                            wire_fifo1_empty;
wire                            wire_fifo1_error;

wire                            valid;
wire                            n_pop0;
wire                            n_pop1;
wire                            push_0;
wire                            push_1;


  mux21 #(.DATA_SIZE(DATA_SIZE) ) 
    mux21_TB (/*AUTOINST*/
    // Outputs
    .out                    (out_mux),
    .valid                  (valid),
    .pop_0                  (n_pop0),
    .pop_1                  (n_pop1),
    //Inputs
    .clk                    (clk),
    .reset                  (reset),
    .fifo_empty0            (fifo_empty0),
    .fifo_empty1            (fifo_empty1),
    .fifo_up0_almostfull    (wire_fifo0_almost_full),   
    .fifo_up1_almostfull    (wire_fifo0_almost_full),
    .in0                    (in0),
    .in1                    (in1)
  );




demux12  #(	  .DATA_SIZE        (DATA_SIZE-2)                     // OVERWRITING INTERNAL PARAMETER 
)  

    demux1x2_Routering ( /*AUTOINST*/
        // Outputs
        .push_0                 (push_0),
        .push_1                 (push_1),
        .out0                   (out0_demux),
        .out1                   (out1_demux),
        // Inputs   
        .reset                  (reset),
        .clk                    (clk),
        .valid                  (valid),
        .in                     (out_mux[(DATA_SIZE-3):0]),
        .fifo_up0_almostfull    (wire_fifo0_almost_full),
        .fifo_up1_almostfull    (wire_fifo1_almost_full),
        .classif                (out_mux[ (DATA_SIZE-2) ])
    );


  fifo_param  #(	  .DATA_SIZE        (DATA_SIZE-2), .MAIN_SIZE ((DATA_SIZE - 4)) ) 
  fifo6x8_routering_0 (/*AUTOINST*/
      // Outputs
      .data_out_pop             (data_out_fifo0_to_out),
      .almost_full              (wire_fifo0_almost_full),
      .almost_empty             (wire_fifo0_almost_empty),
      .Fifo_full                (wire_fifo0_full),        // not connected
      .fifo_empty               (wire_fifo0_empty),
      .fifo_error               (wire_fifo0_error),
       //Inputs
      .clk                      (clk),                
      .reset                    (reset),    
      .read                     (pop_0_in),    
      .write                    (push_0),    
      .data_in_push             (out0_demux)            
  );


  fifo_param  #(	  .DATA_SIZE        (DATA_SIZE-2), .MAIN_SIZE ((DATA_SIZE - 4)) ) 
  fifo6x8_routering_1 (/*AUTOINST*/
      // Outputs
      .data_out_pop             (data_out_fifo1_to_out),
      .almost_full              (wire_fifo1_almost_full),
      .almost_empty             (wire_fifo1_almost_empty),
      .Fifo_full                (wire_fifo1_full),        // not connected
      .fifo_empty               (wire_fifo1_empty),
      .fifo_error               (wire_fifo1_error),
       //Inputs
      .clk                      (clk),                
      .reset                    (reset),    
      .read                     (pop_1_in),    
      .write                    (push_1),    
      .data_in_push             (out1_demux)            
  );


  always@(*) begin      // pass to outputs
    out0                = data_out_fifo0_to_out;
    out1                = data_out_fifo1_to_out;
    pop_0               = n_pop0;
    pop_1               = n_pop1;
    Error               = (wire_fifo0_error | wire_fifo1_error );
    fifo0_almost_empty  = wire_fifo0_almost_empty;
    fifo1_almost_empty  = wire_fifo1_almost_empty;
  end

endmodule


// Local Variables:
// verilog-library-directories:("."):
// verilog-auto-wire-type:\"logic\"
// End:

`endif
