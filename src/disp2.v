// Dispositivo 2
// Proyecto 2 - Circuitos Digitales 2
// Michelle Gutiérrez
`include "./src/fifo_4x8.v"
`include "./src/serieparalelo.v"


module device2 (

input in1,
input in2,
input reset,
input clk,
input clk8f,
input read,
input write,
output reg [7:0] out1,
output reg [7:0] out2,
output reg almost_full_f1,
output reg almost_full_f2
);

wire [7:0] salida1;
wire valid_ptos1;
wire active_ptos1;
wire almost_full_f11;
wire almost_empty_f1;
wire fifo_empty_f1;
wire Fifo_full_f1;
wire [7:0] outa1;
wire fifo_error_f1;
wire fifo_pause_f1;

serieparalelo stop1(
     .in (in1),                         
     .clk8f (clk8f),                   
     .clk (clk),                      
     .reset (reset),
     .out (salida1),
     .valid (valid_ptos1),                          
     .active (active_ptos1)
);

fifo_4x8 fifo1 (
                  .clk (clk8f),
                  .reset (reset),
                  .read (read),
                  .write (write),
                  .data_in_push (salida1),
                  .almost_full (almost_full_f11),
                  .almost_empty (almost_empty_f1),
                  .fifo_empty   (fifo_empty_f1),
                  .Fifo_full   (Fifo_full_f1),
                  .data_out_pop (outa1),         
                  .fifo_error (fifo_error_f1),
                  .fifo_pause (fifo_pause_f1)
);

wire [7:0] salida2;
wire valid_ptos2;
wire active_ptos2;
wire almost_full_f22;
wire almost_empty_f2;
wire fifo_empty_f2;
wire Fifo_full_f2;
wire [7:0] outa2 ;
wire fifo_error_f2;
wire fifo_pause_f2;

serieparalelo stop2(
     .in (in2),                         
     .clk8f (clk8f),                   
     .clk (clk),                      
     .reset (reset),
     .out (salida2),
     .valid (valid_ptos2),                          
     .active (active_ptos2)
);

fifo_4x8 fifo2 (
                  .clk (clk8f),
                  .reset (reset),
                  .read (read),
                  .write (write),
                  .data_in_push (salida2),
                  .almost_full (almost_full_f22),
                  .almost_empty (almost_empty_f2),
                  .fifo_empty   (fifo_empty_f2),
                  .Fifo_full   (Fifo_full_f2),
                  .data_out_pop (outa2),         
                  .fifo_error (fifo_error_f2),
                  .fifo_pause (fifo_pause_f2)
);

always @(posedge clk8f) begin
out1 <= outa1;
out2 <= outa2;
almost_full_f1 <= almost_full_f11;
almost_full_f2 <= almost_full_f22;

end

endmodule

