// Memoria 6x8 banco de pruebas
// Proyecto 2 Digitales II

`timescale 	1ns	/ 100ps		
`include "memory_6x8.v"
`include "memory_6x8_syn.v"
`include "t_memory_6x8.v"
`include "cmos_cells.v"

module memory_tb;
parameter MAIN_SIZE = 6;
parameter DATA_SIZE = 8;

    wire clk;
    wire read;       
    wire write;       
    wire reset;
    wire [DATA_SIZE-1:0] data_in;
    wire [MAIN_SIZE -1:0] wr_ptr;
    wire [MAIN_SIZE -1:0] rd_ptr;
    wire [DATA_SIZE -1:0] data_out;
    // Para el sintetizado
    wire [DATA_SIZE - 1:0] data_out_s;

memory6x8 mem (
            .clk    (clk),
            .read   (read),
            .write  (write),
            .reset  (reset),
            .data_in (data_in),
            .wr_ptr  (wr_ptr),
            .rd_ptr (rd_ptr),
            .data_out (data_out)
);

memory6x8_syn mems (
             .clk    (clk),
            .read   (read),
            .write  (write),
            .reset  (reset),
            .data_in (data_in),
            .wr_ptr  (wr_ptr),
            .rd_ptr (rd_ptr),
            .data_out (data_out_s)

);

memory_tester tester (
            .clk    (clk),
            .read   (read),
            .write  (write),
            .reset  (reset),
            .data_in (data_in),
            .wr_ptr  (wr_ptr),
            .rd_ptr (rd_ptr),
            .data_out (data_out),
            .data_out_s (data_out_s)
);


endmodule 
