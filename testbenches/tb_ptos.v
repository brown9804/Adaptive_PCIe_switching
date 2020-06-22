`timescale 	1ns/1ps

`include "./src/paralelltoserial.v"
`include "./testers/t_ptos.v"
`include "./syn/paralelltoserial_syn.v"
`include "./lib/cmos_cells.v"


module testbench_ptos;

 wire [7:0] in;
 wire in_valid;
 wire reset;
 wire clk;
 wire clk8f;
 wire outc;
 wire outs;

paralelltoserial mod1(
                              .in (in),
                              .in_valid  (in_valid),
                              .reset (reset),
                              .clk (clk),
                              .out    (outc)
);


paralelltoserial_syn mod2(
                              .in (in),
                              .in_valid  (in_valid),
                              .reset (reset),
                              .clk (clk),
                              .out    (outs)
);

t_ptos t_ptostb(      .in (in),
                      .in_valid (in_valid),
                      .reset (reset),
                      .clk (clk),
                      .clk8f (clk8f),
                      .outc    (outc),
			.outs    (outs)
);

endmodule 
