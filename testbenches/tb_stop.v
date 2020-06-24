`timescale 1ns / 1ps



`include "./testers/t_stop.v"
`include "./src/serieparalelo.v"
`include "./lib/cmos_cells.v" 

module bancoPruebas();
    wire in;
    wire [7:0] outc;
    wire [7:0] outs;
    wire reset;
    wire clk;
    wire valid;
    wire clk8f;

tester Probador(
                    .outc(outc),
 		            .outs(outs),
                    .in(in),
                    .clk(clk),
                    .clk8f(clk8f),
                    .reset(reset),
                    .valid(valid)
    );

serieparalelo spc (
                    .in(in),
                    .clk8f(clk8f),
                    .clk(clk),
                    .reset(reset),
                    .out(outc),
                    .valid(valid)
);

serieparalelo sps (
                    .in(in),
                    .clk8f(clk8f),
                    .clk(clk),
                    .reset(reset),
                    .out(outs),
                    .valid(valid)
);
endmodule
