// Probador Disp 2
// Proyecto 2 - Circuitos Digitales 2
// Michelle Gutiérrez

`include "./scr/disp2.v"
`include "./testers/t_disp2.v"

module testbench_disp2;

wire in1;
wire in2;
wire reset;
wire clk;
wire clk8f;
wire read;
wire write;
wire [7:0] out1;
wire [7:0] out2;
wire almost_full_f1;
wire almost_full_f2;


divice2 dis2 (
              .in1 (in1),
              .in2 (in2),
              .reset (reset),
              .clk   (clk),
              .clk8f (clk8f),
              .read  (read),
              .write (write),
              .out1  (out1),
              .out2  (out2),
              .almost_full_f1 (almost_full_f1),
              .almost_full_f2 (almost_full_f2)
);

disp2_tester tester (
              .in1 (in1),
              .in2 (in2),
              .reset (reset),
              .clk   (clk),
              .clk8f (clk8f),
              .read  (read),
              .write (write),
              .out1  (out1),
              .out2  (out2),
              .almost_full_f1 (almost_full_f1),
              .almost_full_f2 (almost_full_f2)
);



endmodule
