//////////////////////////////////
// data class switching layer   //
// Brandon ESquivel             // 
// brandon.esquivel@ucr.ac.cr   //
//////////////////////////////////

`ifndef CLASS
`define CLASS

`timescale 1ns / 1ps

`include "./src/fifo.v"
`include "./src/demux1x2_behav.v"
`include "./src/df_control.v"

// Considering class and destiny

module classswitching #(
  parameter DATA_SIZE = 10, 
  parameter MAIN_SIZE = 8) 
  
  (
    input wire  reset,
    input wire  clk,
    input wire  [DATA_SIZE-1:0] in,

    output reg  [DATA_SIZE-1:0] out0,
    output reg  [DATA_SIZE-1:0] out1,
    
    // dataflow fifo control:      up and down refers to FIFOS at next or back stage
    output reg AF1_up,               // control signal output for dataflow control Almost full up for fifo 1
    output reg AF2_up,               // control signal output for dataflow control Almost full up for fifo 2
    output reg AE1_down,             // control signal output for dataflow control Almost empty down for fifo 1
    output reg AE2_down,             // control signal output for dataflow control Almost empty down for fifo 2
    output reg Full_up1,             // control signal output for dataflow control full up for fifo 1
    output reg Full_up2,             // control signal output for dataflow control full up for fifo 2
    output reg Error,

    input wire Full_down1,           // control signal output for dataflow control full down for fifo 1
    input wire Full_down2,            // control signal output for dataflow control full down for fifo 2
    input wire AF1_down,             // control signal input for dataflow control Almost full down for fifo 1
    input wire AF2_down,             // control signal input for dataflow control Almost full down for fifo 2
    input wire AE1_up,               // control signal input for dataflow control Almost empty up for fifo 1
    input wire AE2_up               // control signal input for dataflow control Almost empty up for fifo 2
  
);  

// Internal nodes
wire  npush_0;    // signals from demux to fifo 
wire  npush_1;
wire [DATA_SIZE-1:0] n0, n1, n2, n3;  // data from demux to fifo
wire [1:0] nv;            // valid node 
wire wAF1_up;
wire wAF2_up;
wire wAE1_down;
wire wAE2_down;
wire wFull_up1;
wire wFull_up2;
wire wError;
wire Fifo_full1;
wire Fifo_full2;


demux12 demux12A(
  //outputs
  .out0(n0),
  .out1(n1),
  .push_0(npush_0),
  .push_1(npush_1),
  //inputs
  .reset(reset),
  .clk(clk),
  .in(in),
  .classif(in[DATA_SIZE-1])      // switching by data class 
);

fifo  fifo1(

  .clk                            ( clk ),
  .reset                          ( reset ),
  .read                           ( read1 ),            // from/to dtcontrol        
  .write                          ( write1 ),           // from/to dtcontrol
  .data_in_push                   ( n0 ),               // data in from demux to FIFO
  .almost_full                    ( almost_full1  ),    // from/to dtcontrol
  .almost_empty                   ( almost_empty1 ),    // from/to dtcontrol
  .fifo_empty                     ( fifo_empty1  ),     // from/to dtcontrol
  .Fifo_full                      ( Fifo_full1  ),      // from/to dtcontrol
  .data_out_pop                   ( n2 ),               // data out from FIFO pop
  .fifo_error                     ( fifo_error1  ),    
  .fifo_pause                     ( fifo_pause1   )   

);

fifo fifo2(

  .clk                            ( clk ),
  .reset                          ( reset ),
  .read                           ( read2 ),            // from/to dtcontrol        
  .write                          ( write2 ),           // from/to dtcontrol
  .data_in_push                   ( n1 ),               // data in from demux to FIFO
  .almost_full                    ( almost_full2  ),    // from/to dtcontrol
  .almost_empty                   ( almost_empty2 ),    // from/to dtcontrol
  .fifo_empty                     ( fifo_empty2  ),     // from/to dtcontrol
  .Fifo_full                      ( Fifo_full2  ),      // from/to dtcontrol
  .data_out_pop                   ( n3 ),               // data out from FIFO pop
  .fifo_error                     ( fifo_error2  ),    
  .fifo_pause                     ( fifo_pause2   )   

);




dfcontrol datacontrol(
  .clk                            ( clk ),
  .reset                          ( reset ),
  .push_0                         ( npush_0),
  .push_1                         ( npush_1),
  .read1                          ( read1 ),
  .write1                         ( write1 ),           // from/to dtcontrol/fifo 1
  .almost_full1                   ( almost_full1  ),    
  .almost_empty1                  ( almost_empty1 ),    
  .fifo_empty1                    ( fifo_empty1  ),     
  .Fifo_full1                     ( Fifo_full1  ),      
  .fifo_error1                    ( fifo_error1  ),    
  .fifo_pause1                    ( fifo_pause1   ),   

  .read2                          ( read2 ),            // from/to dtcontrol/fifo 2       
  .write2                         ( write2 ),           
  .almost_full2                   ( almost_full2  ),    
  .almost_empty2                  ( almost_empty2 ),    
  .fifo_empty2                    ( fifo_empty2  ),     
  .Fifo_full2                     ( Fifo_full2  ),      
  .fifo_error2                    ( fifo_error2  ),    
  .fifo_pause2                    ( fifo_pause2   ),   
    
    // out/in of layer
  /*.AF1_up                          ( wAF1_up  ),
  .AF2_up                          ( wAF2_up  ),
  .AE1_down                        ( wAE1_down  ), 
  .AE2_down                        ( wAE2_down  ),
  .Full_up1                        ( wFull_up1 ),
  .Full_up2                        ( wFull_up2 ),
  

  .Full_down1                      ( Full_down1 ),    
  .Full_down2                      ( Full_down2 ),   
  .AF1_down                        ( AF1_down  ),
  .AF2_down                        ( AF2_down  ),
  .AE1_up                          ( AE1_up  ),
  .AE2_up                          ( AE2_up  )

*/.Error                           ( wError)
);



always@(*) begin      // spread data/signals to out
  out0     =   n2;
  out1     =   n3;
  /*AF1_up   =   wAF1_up;
  AF2_up   =   wAF2_up;
  AE1_down =   wAE1_down;
  AE2_down =   wAE2_down;
  Full_up1 =   wFull_up1;
  Full_up2 =   wFull_up2;
  */
  Error    =   wError;

end

endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
