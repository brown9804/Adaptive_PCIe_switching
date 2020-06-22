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
wire clk;
wire clk8f;
wire valid_0;
wire valid_1;
wire reset;
wire out0;
wire out1;
wire out0_s;
wire out1_s;

paratoserial ptosgrande (
      .in0   (in0),
      .in1   (in1),
      .clk   (clk),
      .valid_0 (valid_0),
      .valid_1 (valid_1),
      .reset (reset),
      .out0 (out0),
      .out1 (out1)
);

paratoserial_syn ptosgrandesyn (
      .in0   (in0),
      .in1   (in1),
      .clk   (clk),
      .valid_0 (valid_0),
      .valid_1 (valid_1),
      .reset (reset),
      .out0 (out0_s),
      .out1 (out1_s)
);

paratoserial_tester tester (
      .in0   (in0),
      .in1   (in1),
      .clk   (clk),
      .clk8f (clk8f),
      .valid_0 (valid_0),
      .valid_1 (valid_1),
      .reset (reset),
      .out0 (out0),
      .out1 (out1),
      .out0_s (out0_s),
      .out1_s (out1_s)
);

endmodule