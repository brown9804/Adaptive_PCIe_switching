// DATA FLOW CONTROL
// Brandon Esquivel Molina
// brandon.esquivel@ucr.ac.cr
// Proyecto 2 Digitales II
//////////////////////////////////


`ifndef DFCONTROL
`define DFCONTROL

`timescale 1ns/1ps

module dfcontrol (
    input wire clk,
    input wire reset,
    input wire push_0,
    input wire push_1,

// signals from 2 FIFOs
    input wire  almost_full1,
    input wire  almost_empty1,
    input wire  fifo_empty1,
    input wire  Fifo_full1,
    input wire  fifo_error1,
    input wire  fifo_pause1,

    input wire almost_full2,
    input wire  almost_empty2,
    input wire  fifo_empty2,
    input wire  Fifo_full2,
    input wire  fifo_error2,
    input wire  fifo_pause2,

// to fifos
    output reg read1,
    output reg write1,
    output reg read2,
    output reg write2,
    
    output reg Error
);

// internal control

always@(posedge clk) begin
    Error = 0;
    read1 = 0;
    read2 = 0;
    write1 = 0;
    write2 = 0;
    if ( ~reset ) begin
            Error = 0;
            read1 = 0;
            read2 = 0;
            write1 = 0;
            write2 = 0;
        end

 else begin
        if (push_0 & (~Fifo_full1 | ~almost_full1 | ~fifo_pause1) ) begin
        write1 = 1;

        end
        else begin
          write1 = 0;
        end

        if (push_1 & (~Fifo_full2 | ~almost_full2 | ~fifo_pause2) ) begin
        write2 = 1;

        end
        else begin
          write2 = 0;
        end

        if (almost_empty1 | fifo_empty1) begin
            read1 = 0;
        end
        else begin
          read1 = 1;
        end


        if (almost_empty2 | fifo_empty2 ) begin
            read2 = 0;
        end
        else begin
          read2 = 1;
        end
        if ( fifo_error1 | fifo_error2 ) begin
            Error = 1;
        end
        else begin
          Error = 0;
        end

    end
end
endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
