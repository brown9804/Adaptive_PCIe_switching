// Serialización de Datos
// Michelle Gutiérrez - Proyecto 2
// Circuitos Digitales II

`ifndef PARATOSERIAL
`define PARATOSERIAL


`timescale 1ns/1ps
`include "./src/paralelltoserial.v"


module paratoserial #( parameter DATA_SIZE = 8) (

input wire [DATA_SIZE-1:0] in0,
input wire [DATA_SIZE-1:0] in1,
input wire clk,                 // MUST BE 8 TIMES FASTER THAN DATA IN CLK
input wire clk1f,               // same clk of data in
input wire fifo_empty0,         // Enable data out from FiFo0 if fifo_empty0 != 0
input wire fifo_empty1,         // Enable data out from FiFo1 if fifo_empty0 = 0
input wire fifo0_almost_empty,
input wire fifo1_almost_empty,
input wire fifo_up0_almostfull,
input wire fifo_up1_almostfull,
input wire reset,

output reg out0,
output reg out1,
output reg pop_0,
output reg pop_1

);
/*AUTOWIRE*/
// internal nodes
wire out00 , out11;
reg valid_0;
reg valid_1;

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



// data flow control push pop logic
always@(posedge clk1f) begin
  if(fifo_empty0 | fifo0_almost_empty | fifo_up0_almostfull ) begin
  pop_0 = 0;
  end else begin
    pop_0 = 1;
  end 
  if(fifo_empty1 | fifo1_almost_empty | fifo_up1_almostfull ) begin
  pop_1 = 0;
  end else begin
    pop_1 = 1;
  end 
end 



always @(*) begin
out0 = out00;
out1 = out11;
valid_0 = pop_0;
valid_1 = pop_1;
end


endmodule




// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
