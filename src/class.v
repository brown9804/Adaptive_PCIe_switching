//////////////////////////////////
// data class switching layer   //
// Brandon ESquivel             // 
// brandon.esquivel@ucr.ac.cr   //
//////////////////////////////////

`ifndef CLASS
`define CLASS

`timescale 1ns / 1ps

`include "./src/fifo.v"
`include "./src/demux1x2_behav.v"
`include "./src/df_control.v"

// Considering class and destiny

module classswitching #(
  parameter DATA_SIZE = 10, 
  parameter MAIN_SIZE = 8) 
  
  (
    input wire  reset,
    input wire  clk,
    input wire  [DATA_SIZE-1:0] in,
    output reg  [DATA_SIZE-1:0] out0,
    output reg  [DATA_SIZE-1:0] out1,
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

// Internal nodes
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
wire [DATA_SIZE-1:0] n0;
wire [DATA_SIZE-1:0] n1;
wire [DATA_SIZE-1:0] n2;
wire [DATA_SIZE-1:0] n3;

// FIFO #1
wire n_almost_full1;
wire n_almost_empty1;
wire n_fifo1_empty;
wire n_fifo1_error;
wire n_fifo1_pause;
wire n_Fifo_full1;


demux12 demux12A(
  //outputs
  .out0(n0),
  .out1(n1),
  .push_0(PP0),
  .push_1(PP1),
  //inputs
  .reset(reset),
  .clk(clk),
  .in(in),
  .classif(in[DATA_SIZE-1])      // switching by data class 
);



fifo_8x10  fifo1(/*AUTOINST*/
      // Outputs
      .fifo_empty (n_fifo0_empty),
      .Fifo_full (n_Fifo_full0),
      .data_out_pop (n2),
      .fifo_error (n_fifo0_error),
      .fifo_pause (n_fifo0_pause),
      //Inputs
      .clk (clk),
      .reset (reset),
      .read (read0),
      .write (write0),
      .data_in_push (n0),
      .almost_full (n_almost_full0),
      .almost_empty (n_almost_empty0)
  );

fifo_8x10 fifo2(/*AUTOINST*/
    // Outputs
    .fifo_empty (n_fifo1_empty),
    .Fifo_full (n_Fifo_full1),
    .data_out_pop (n3),
    .fifo_error (n_fifo1_error),
    .fifo_pause (n_fifo1_pause),
    //Inputs
    .clk (clk),
    .reset (reset),
    .read (read1),
    .write (write1),
    .data_in_push (n1),
    .almost_full (n_almost_full1),
    .almost_empty (n_almost_empty1)
  );






  dfcontrol datacontrol(/*AUTOINST*/
    .clk                            (clk),
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
    .Error                          (Error_F)
  );


always@(*) begin      // spread data/signals to out
  out0     =   n2;
  out1     =   n3;
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
// End:
`endif
