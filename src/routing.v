// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef ROUTING
`define ROUTING

`timescale 1ns/1ps

`include "./src/mux2x1_behav.v"
`include "./src/demux1x2_8_behav.v"
`include "./src/fifo_6x8.v"
`include "./src/df_control.v"


module route(
input wire clk,
input wire reset,
// Outputs from fifos 8x10
// Assign 0 relative to fifo0
// Assign 1 relative to fifo1
input wire [9:0] in0,
input wire [9:0] in1,
input wire emptyF0,
input wire emptyF1,
//input wire classif,
//Outputs
output reg [7:0] out0, // out from fifo6x8 #0
output reg [7:0] out1,  // out from fifo6x8 #1
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
output reg fifo1_pause,
output reg Error
);

wire [9:0] out_mux;
wire [7:0] out0_demux, out1_demux;
// Push/Pop
wire PP0, PP1;
// wire Error_F;
wire  read0;
wire  read1;
wire write0;
wire write1;
// //Regs for outputs of module routing
wire n_almost_full0;
wire n_almost_empty0;
wire n_fifo0_empty;
wire n_fifo0_error;
wire n_fifo0_pause;
wire n_Fifo_full0;
wire [7:0] n_out0;

// FIFO #1
wire n_almost_full1;
wire n_almost_empty1;
wire n_fifo1_empty;
wire n_fifo1_error;
wire n_fifo1_pause;
wire n_Fifo_full1;
wire [7:0] n_out1;



mux21 mux21_routing(/*AUTOINST*/
    // Outputs
    .out (out_mux),
    // Inputs
    .clk (clk),
    .reset (reset),
    .fifo_empty0 (emptyF0),
    .fifo_empty1 (emptyF1),
    .in0 (in0), // data out pop fifo0
    .in1 (in1) // data out pop fifo1
);


demux12_8 demux12_8_routing (/*AUTOINST*/
    // Outputs
    .out0 (out0_demux),
    .out1 (out1_demux),
    // Inputs
    .reset (reset),
    .clk (clk),
    .in (out_mux[7:0]),
    .classif (out_mux[8]),
    .push_0 (PP0),
    .push_1 (PP1)
    );


  dfcontrol datacontrol(
    .clk (clk),
    .reset                          ( reset ),
    .push_0                         (PP0),
    .push_1                         (PP1),
    .almost_full1                   (n_almost_full0),
    .almost_empty1                  (n_almost_empty0),
    .fifo_empty1                    (n_fifo0_empty),
    .Fifo_full1                     (n_Fifo_full0),
    .fifo_error1                    (n_fifo0_error),
    .fifo_pause1                    (n_fifo0_pause),
    .almost_full2                   (n_almost_full1),
    .almost_empty2                  (n_almost_empty1),
    .fifo_empty2                    (n_fifo1_empty),
    .Fifo_full2                     (n_Fifo_full1),
    .fifo_error2                    (n_fifo1_error),
    .fifo_pause2                    (n_fifo1_pause),
    .read1                          (read0),
    .write1                         (write0),           // from/to dtcontrol/fifo 1
    .read2                          (read1),            // from/to dtcontrol/fifo 2
    .write2                         (write1),
    .Error (Error_F)
  );

  fifo_6x8  fifo6x8B0(/*AUTOINST*/
      // Outputs
      .fifo_empty (n_fifo0_empty),
      .Fifo_full (n_Fifo_full0),
      .data_out_pop (n_out0),
      .fifo_error (n_fifo0_error),
      .fifo_pause (n_fifo0_pause),
      //Inputs
      .clk (clk),
      .reset (reset),
      .read (read0),
      .write (write0),
      .data_in_push (out0_demux),
      .almost_full (n_almost_full0),
      .almost_empty (n_almost_empty0)
  );

  fifo_6x8  fifo6x8B1(/*AUTOINST*/
    // Outputs
    .fifo_empty (n_fifo1_empty),
    .Fifo_full (n_Fifo_full1),
    .data_out_pop (n_out1),
    .fifo_error (n_fifo1_error),
    .fifo_pause (n_fifo1_pause),
    //Inputs
    .clk (clk),
    .reset (reset),
    .read (read1),
    .write (write1),
    .data_in_push (out1_demux),
    .almost_full (n_almost_full1),
    .almost_empty (n_almost_empty1)
  );

  always@(*) begin      // pass to outputs
    out0 = n_out0;
    out1 = n_out1;
    Error = Error_F;
    almost_full0  = n_almost_full0;
    almost_empty0  = n_almost_empty0;
    fifo0_empty  = n_fifo0_empty;
    fifo0_error  = n_fifo0_error;
    fifo0_pause = n_fifo0_pause;
    almost_full1 = n_almost_full1;
    almost_empty1  = n_almost_empty1;
    fifo1_empty  = n_fifo1_empty;
    fifo1_error = n_fifo1_error;
    fifo1_pause  = n_fifo1_pause;
    fifo_full0 = n_Fifo_full0;
    fifo_full1 = n_Fifo_full1;

  end



endmodule


// Local Variables:
// verilog-library-directories:("."):
// verilog-auto-wire-type:\"logic\"
// End:

`endif
