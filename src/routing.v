// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef ROUTING
`define ROUTING

`timescale 1ns/1ps

`include "./src/mux2x1_behav.v"
`include "./src/demux1x2_8_behav.v"
`include "./src/fifo_6x8.v"

module route(
input wire clk,
input wire reset,
input wire [9:0] in0,
input wire in0_valid,
input wire in1_valid,
input wire [9:0] in1,
input wire  read0,
input wire  read1,
output reg [7:0]out0,
output reg [7:0] out1,
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
output reg fifo1_pause
);

wire inter_select;

wire [7:0] out_mux;
wire valid_indemux;
wire [7:0] out0_demux, out1_demux;
wire [1:0] nm;

//Regs for outputs of module routing
wire [7:0] n_out0;
wire [7:0] n_out1;
wire n_almost_full0;
wire n_almost_empty0;
wire n_fifo0_empty;
wire n_fifo0_error;
wire n_fifo0_pause;
wire n_almost_full;
wire n_almost_empty1;
wire n_fifo1_empty;
wire n_fifo1_error;
wire n_fifo1_pause;
wire npop0, npop1;
wire n_Fifo_full0;
wire n_Fifo_full1;


mux21 mux21_routing(/*AUTOINST*/
    // Outputs
    .out (out_mux),
    .valid_out (valid_indemux),
    // Inputs
    .clk (clk),
    .reset (reset),
    .pop0 (npop0),
    .pop1 (npop1),
    .in0 (in0),
    .in1 (in1),
    .in0_valid (in0_valid),
    .in1_valid (in1_valid)
);


demux12_8 demux12_8_routing (/*AUTOINST*/
    // Outputs
    .out0 (out0_demux),
    .out1 (out1_demux),
    .valid_out (nm),
    // Inputs
    .reset (reset),
    .clk (clk),
    .in (out_mux),
    .valid_in (valid_indemux),
    .select (inter_select),
    .push_0 (npop0),
    .push_1 (npop1)
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
      .write (npop0),
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
    .write (npop1),
    .data_in_push (out1_demux),
    .almost_full (n_almost_full1),
    .almost_empty (n_almost_empty1)
  );



  always@(*) begin      // pass to outputs
    out0 = n_out0;
    out1 = n_out1;

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
