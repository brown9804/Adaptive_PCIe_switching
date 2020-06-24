`timescale 	1ns	/ 1ps

`include "./src/fifo_4x8.v"
`include "./syn/fifo_4x8_syn.v"
`include "./testers/t_fifo_4x8.v"
`include "./lib/cmos_cells.v"


module test_bench_fifo;

parameter DATA_SIZE = 8;
parameter MAIN_SIZE = 4;

    wire    clk;
    wire    reset;
    wire    read;
    wire    write;
    wire [DATA_SIZE-1:0]   data_in_push;
    wire  almost_full;
    wire  almost_empty;
    wire [DATA_SIZE-1:0]   data_out_pop;
    wire Fifo_full;
    wire    fifo_empty;
    wire    fifo_error;
    wire    fifo_pause;
  //Para sintetizado
    wire [DATA_SIZE-1:0] data_out_pop_s;
    wire almost_full_s;
    wire almost_empty_s;
    wire fifo_empty_s;
    wire fifo_error_s;
    wire fifo_pause_s;
    wire Fifo_full_s;


fifo_4x8 fifotb (
                 .clk   (clk),
                 .reset (reset),
                 .read (read),
                 .write (write),
                 .data_in_push (data_in_push),
                 .almost_full (almost_full),
                 .almost_empty (almost_empty),
                 .Fifo_full (Fifo_full),
                 .data_out_pop (data_out_pop),
                 .fifo_empty (fifo_empty),
                 .fifo_error (fifo_error),
                 .fifo_pause (fifo_pause)
);

fifo_4x8_syn fifos (
                 .clk   (clk),
                 .reset (reset),
                 .read (read),
                 .write (write),
                 .data_in_push (data_in_push),
                 .almost_full (almost_full_s),
                 .almost_empty (almost_empty_s),
                 .Fifo_full (Fifo_full_s),
                 .data_out_pop (data_out_pop_s),
                 .fifo_empty (fifo_empty_s),
                 .fifo_error (fifo_error_s),
                 .fifo_pause (fifo_pause_s)
);


fifo_tester tester (
                 .clk   (clk),
                 .reset (reset),
                 .read (read),
                 .write (write),
                 .data_in_push (data_in_push),
                 .almost_full (almost_full),
                 .almost_empty (almost_empty),
                 .data_out_pop (data_out_pop),
                 .fifo_empty (fifo_empty),
                 .fifo_error (fifo_error),
                 .fifo_pause (fifo_pause),
                 .Fifo_full (Fifo_full),
                 .Fifo_full_s (Fifo_full_s),
                 .almost_full_s (almost_full_s),
                 .almost_empty_s (almost_empty_s),
                 .data_out_pop_s (data_out_pop_s),
                 .fifo_synth_empty (fifo_empty_s),
                 .fifo_synth_error (fifo_error_s),
                 .fifo_synth_pause (fifo_pause_s)
);


endmodule

