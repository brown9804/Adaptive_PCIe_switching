/////////////////////////////////                      .        .
//  Brandon Equivel             //                        .  .
//  brandon.esquivel@ucr.ac.cr   //////////.............//////    .
//                              //                        .    .      .
////////////////////////////////                       .
      ///           ///
    ///               ///
  ///                   ///
////                    /////


`timescale 	1ns/1ps

`include "./src/paralelltoserial.v"
`include "./testers/t_ptos.v"
`include "./syn/paralelltoserial_syn.v"
`include "./lib/cmos_cells.v"

module testbench_ptos;
// testing module with data out at 8 times faster than data in, because its a 8 bits bus.
// using a 4f clk and 32f clk for example:

 wire [7:0] in;
 wire in_valid;
 wire reset;
 wire clk4f;
 wire clk32f;
 wire outc;
wire outs;

paralelo_a_serial paralelo_a_serialtb_b(
                    .in         (in),
                    .in_valid   (in_valid),
                    .reset      (reset),
                    .clk        (clk32f),
                    .out        (outc)
);


paralelo_a_serial_syn paralelo_a_serialtb_s(
                    .in         (in),
                    .in_valid   (in_valid),
                    .reset      (reset),
                    .clk        (clk32f),
                    .out        (outs)
);

t_ptos t_ptostb(    .in         (in),
                    .in_valid   (in_valid),
                    .reset      (reset),
                    .clk4f      (clk4f),
                    .clk32f     (clk32f),
                    .outc       (outc),
			        .outs       (outs)
);

endmodule 
