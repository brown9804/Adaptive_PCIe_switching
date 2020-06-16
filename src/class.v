// COnexion 

`ifndef CLASS
`define CLASS

`timescale 1ns / 1ps
`include "./src/fifo.v"
`include "./src/demux1x2_behav.v"

// Considering class and destiny

module classswitching #(parameter DATA_SIZE = 10, parameter MAIN_SIZE = 8) (

    input wire  reset,
    input wire  clk,
    input wire  [DATA_SIZE-1:0] in,
    input wire  valid_in,
    input wire  read1,
    input wire  read2,

    output reg  [DATA_SIZE-1:0] out0,
    output reg  [DATA_SIZE-1:0] out1,
    
    output reg almost_full1_in,
    output reg almost_empty1_in,
    output reg fifo1_empty,
    output reg fifo1_error,
    output reg fifo1_pause,
    output reg almost_full2_in,
    output reg almost_empty2_in,
    output reg fifo2_empty,
    output reg fifo2_error,
    output reg fifo2_pause
);

// INternal
wire  npush_0;    // signals from demux to fifo 
wire  npush_1;
wire [DATA_SIZE-1:0] n0, n1, n2, n3;  // data from demux to fifo
wire [1:0] nv;            // valid node 

// nodes for spreads
wire n_almost_full1_in;
wire n_almost_empty1_in;
wire n_fifo1_empty;
wire n_fifo1_error;
wire n_fifo1_pause;
wire n_almost_full2_in;
wire n_almost_empty2_in;
wire n_fifo2_empty;
wire n_fifo2_error;
wire n_fifo2_pause;



demux12 demux12A(
  //outputs
  .out0(n0),
  .out1(n1),
  .push_0(npush_0),
  .push_1(npush_1),
  .valid_out(nv),
  //inputs
  .reset(reset),
  .clk(clk),
  .in(in),
  .valid_in(valid_in),
  .select(in[DATA_SIZE-1])      // switching by data class 
);

fifo  #(DATA_SIZE,MAIN_SIZE) fifo1(

  .clk(clk),
  .reset(reset),
  .read(read1),        ///********Implementar logica de read-peso****************
  .write(npush_0),
  .data_in_push(n0),            //dato de entrada / hará push al fifo
  .almost_full_in( n_almost_full1_in),   //***********************    
  .almost_empty_in( n_almost_empty1_in),   //***********************
  .fifo_empty( n_fifo_empty1),      //***********************
  .data_out_pop(n2),           //datos de salida / al que se le hace pop
  .fifo_error(n_fifo1_error),    //***********************
  .fifo_pause(n_fifo1_pause)   //***********************

);



fifo  #(DATA_SIZE,MAIN_SIZE) fifo2(

  .clk(clk),
  .reset(reset),
  .read(read2),       
  .write(npush_1),
  .data_in_push(n1),            //dato de entrada / hará push al fifo
  .almost_full_in (n_almost_full2_in),   //***********************    
  .almost_empty_in(n_almost_empty2_in),   //***********************
  .fifo_empty     (n_fifo2_empty),      //***********************
  .data_out_pop(n3),           //datos de salida / al que se le hace pop
  .fifo_error(n_fifo2_error),    //***********************
  .fifo_pause(n_fifo2_pause)   //***********************

);





always@(*) begin      // spread data to out
  out0 = n2;
  out0 = n3;

  almost_full1_in     = n_almost_full1_in;
  almost_empty1_in    = n_almost_empty1_in;
  fifo1_empty         = n_fifo1_empty;
  fifo1_error         = n_fifo1_error;
  fifo1_pause         = n_fifo1_pause;
  almost_full2_in     = n_almost_full2_in;
  almost_empty2_in    = n_almost_empty2_in;
  fifo2_empty         = n_fifo2_empty;
  fifo2_error         = n_fifo2_error;
  fifo2_pause         = n_fifo2_pause;

end

endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
