// Serialización de Datos
// Michelle Gutiérrez - Proyecto 2
// Circuitos Digitales II
`include "./src/paralelltoserial.v"


module paratoserial (

input wire [7:0] in0,
input wire [7:0] in1,
input wire clk,
input wire valid_0,
input wire valid_1,
input wire reset,
output reg out0,
output reg out1
);

wire out00 , out11;

paralelltoserial ptos1 (
                     .in  (in0),
                     .in_valid (valid_0),
                     .reset    (reset),
                     .clk      (clk),
                     .out      (out00)
);


paralelltoserial ptos2 (
                     .in      (in1),
                     .in_valid (valid_1),
                     .reset    (reset),
                     .clk      (clk),
                     .out      (out11)
);

always @(posedge clk) begin
out0 <= out00;
out1 <= out11;

end


endmodule