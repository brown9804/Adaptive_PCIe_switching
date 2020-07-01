// Banco de Pruebas serialización
// Michelle Gutiérrez - Proyecto 2
// Circuitos Digitales II

`timescale 	1ns/1ps

`include "./testers/t_paratoserial.v"
`include "./src/paratoserial.v"
`include "./syn/paratoserial_syn.v"
`include "./lib/cmos_cells.v"



module paratoserial_tb;

wire [7:0] in0;
wire [7:0] in1;
wire clk8f;                   // it means than is 8 times faster than normal clk (for data in)
wire fifo_empty0;
wire fifo_empty1;
wire fifo_up0_almostfull;
wire fifo_up1_almostfull;

wire reset;
wire out0;
wire out1;
wire out0_s;
wire out1_s;

paratoserial ptos_behav (
      .in0                    (in0),
      .in1                    (in1),
      .clk                    (clk8f),
      .fifo_empty0            (fifo_empty0),
      .fifo_empty1            (fifo_empty1),
      .fifo_up0_almostfull    (fifo_up0_almostfull),     
      .fifo_up1_almostfull    (fifo_up1_almostfull),      
      .reset                  (reset),
      .out0                   (out0),
      .out1                   (out1)
);

paratoserial_syn ptos_syn (
      .in0              (in0),
      .in1              (in1),
      .clk              (clk8f),
      .fifo_empty0            (fifo_empty0),
      .fifo_empty1            (fifo_empty1),
      .fifo_up0_almostfull    (fifo_up0_almostfull),     
      .fifo_up1_almostfull    (fifo_up1_almostfull),   
      .reset            (reset),
      .out0             (out0_s),
      .out1             (out1_s)
);

paratoserial_tester tester (
      .in0   (in0),
      .in1   (in1),
      .clk8f (clk8f),
      .fifo_empty0            (fifo_empty0),
      .fifo_empty1            (fifo_empty1),
      .fifo_up0_almostfull    (fifo_up0_almostfull),     
      .fifo_up1_almostfull    (fifo_up1_almostfull),   
      .reset (reset),
      .out0 (out0),
      .out1 (out1),
      .out0_s (out0_s),
      .out1_s (out1_s)
);

endmodule