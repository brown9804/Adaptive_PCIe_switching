`timescale 	1ns	/ 100ps		

`include "./src/fifo.v"
`include "./syn/fifo_syn.v"
`include "./testers/t_fifo.v"
`include "./lib/cmos_cells.v"
module test_bench_fifo;

parameter DATA_SIZE = 10;       
parameter MAIN_SIZE = 8;

    wire    clk;
    wire    reset;
    wire    read;
    wire    write;
    wire [DATA_SIZE-1:0]   data_in_push;           
    wire [DATA_SIZE-1:0]   almost_full_in;    
    wire [DATA_SIZE-1:0]   almost_empty_in;
    wire [DATA_SIZE-1:0]   data_out_pop;
    wire    fifo_empty; 
    wire    fifo_error;
    wire    fifo_pause;
    //Para sintetizado
    wire fifo_empty_s;       
    wire [DATA_SIZE-1:0] data_out_pop_s; 
    wire fifo_error_s;
    wire fifo_pause_s;

fifo fifotb (
                 .clk   (clk),
                 .reset (reset),
                 .read (read),
                 .write (write),
                 .data_in_push (data_in_push),
                 .almost_full_in (almost_full_in),
                 .almost_empty_in (almost_empty_in),
                 .data_out_pop (data_out_pop),
                 .fifo_empty (fifo_empty),
                 .fifo_error (fifo_error),
                 .fifo_pause (fifo_pause)
);

fifo_synth fifos (
                 .clk   (clk),
                 .reset (reset),
                 .read (read),
                 .write (write),
                 .data_in_push (data_in_push),
                 .almost_full_in (almost_full_in),
                 .almost_empty_in (almost_empty_in),
                 .data_out_pop (data_out_pop_s),
                 .fifo_synth_empty (fifo_empty_s),
                 .fifo_synth_error (fifo_error_s),
                 .fifo_synth_pause (fifo_pause_s)
);


fifo_tester tester (
                 .clk   (clk),
                 .reset (reset),
                 .read (read),
                 .write (write),
                 .data_in_push (data_in_push),
                 .almost_full_in (almost_full_in),
                 .almost_empty_in (almost_empty_in),
                 .data_out_pop (data_out_pop),
                 .fifo_empty (fifo_empty),
                 .fifo_error (fifo_error),
                 .fifo_pause (fifo_pause),
                 .data_out_pop_s (data_out_pop_s),
                 .fifo_empty_s (fifo_empty_s),
                 .fifo_error_s (fifo_error_s),
                 .fifo_pause_s (fifo_pause_s)
);


endmodule
