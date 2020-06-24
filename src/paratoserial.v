// Serialización de Datos
// Michelle Gutiérrez - Proyecto 2
// Circuitos Digitales II

`ifndef PARATOSERIAL
`define PARATOSERIAL


`timescale 1ns/1ps
`include "./src/paralelltoserial.v"


module paratoserial (

input wire [7:0] in0,
input wire [7:0] in1,
input wire clk,                 // MUST BE 8 TIMES FASTER THAN DATA IN CLK
input wire valid_0,
input wire valid_1,
input wire reset,
output reg out0,
output reg out1
);
/*AUTOWIRE*/
// internal nodes
wire out00 , out11;

paralelo_a_serial ptos1 (    /*AUTOINST*/
                    // OUTPUTS
                    .out      (out00),
                    // Inputs
                    .in       (in0),
                    .in_valid (valid_0),
                    .reset    (reset),
                    .clk      (clk)
                     
);


paralelo_a_serial ptos2 (    /*AUTOINST*/  
                    // OUTPUTS
                    .out      (out11),
                    // Inputs
                    .in       (in1),
                    .in_valid (valid_1),
                    .reset    (reset),
                    .clk      (clk)
);

always @(*) begin
out0 = out00;
out1 = out11;

end


endmodule




// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
