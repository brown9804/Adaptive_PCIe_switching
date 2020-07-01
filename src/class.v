//////////////////////////////////
// Data Class switching layer   //
// Brandon ESquivel             // 
// brandon.esquivel@ucr.ac.cr   //
// JUne, 2020                   //
//////////////////////////////////

`ifndef CLASS
`define CLASS

`timescale 1ns / 1ps

`include "./src/fifo.v"
`include "./src/demux1x2.v"

// Considering class and destiny

module classswitching #(
  parameter DATA_SIZE = 10, 
  parameter MAIN_SIZE = 8) 
  
  ( // OUTPUTS
    output reg  [DATA_SIZE-1:0]   out0,
    output reg  [DATA_SIZE-1:0]   out1,
    output reg                    Error,
    output reg                    fifo_empty0,
    output reg                    fifo_empty1,
    // INPUTS
    input wire                    reset,
    input wire                    clk,
    input wire  [DATA_SIZE-1:0]   in, 
    input wire                    pop_0,
    input wire                    pop_1
    
  );  
  // INTERNAL WIRES AND NODES
    wire  [DATA_SIZE-1:0]         data_out_fifo0_to_out;
    wire                          wire_fifo0_almost_full;
    wire                          wire_fifo0_almost_empty;
    wire                          wire_fifo0_full;
    wire                          wire_fifo0_empty;
    wire                          wire_fifo0_error;

    wire  [DATA_SIZE-1:0]         data_out_fifo1_to_out;
    wire                          wire_fifo1_almost_full;
    wire                          wire_fifo1_almost_empty;
    wire                          wire_fifo1_full;
    wire                          wire_fifo1_empty;
    wire                          wire_fifo1_error;

    wire  [DATA_SIZE-1:0]         demux_out_to_fifo0;
    wire  [DATA_SIZE-1:0]         demux_out_to_fifo1;
    wire                          write_push_demux_to_fifo0;
    wire                          write_push_demux_to_fifo1;





  demux12  #(  .DATA_SIZE(DATA_SIZE)  )
    demux1x2(
      //outputs
      .out0                   (demux_out_to_fifo0),
      .out1                   (demux_out_to_fifo1),
      .push_0                 (write_push_demux_to_fifo0),
      .push_1                 (write_push_demux_to_fifo1),
      //inputs
      .reset                  (reset),
      .fifo_up0_almostfull    (wire_fifo0_almost_full),
      .fifo_up1_almostfull    (wire_fifo1_almost_full),
      .clk                    (clk),
      .in                     (in),
      .classif                (in [(DATA_SIZE-1) ] )      // switching by data class 
  );    

fifo_param  fifo0(/*AUTOINST*/
      // Outputs
      .data_out_pop             (data_out_fifo0_to_out),
      .almost_full              (wire_fifo0_almost_full),
      .almost_empty             (wire_fifo0_almost_empty),
      .Fifo_full                (wire_fifo0_full),        // not connected
      .fifo_empty               (wire_fifo0_empty),
      .fifo_error               (wire_fifo0_error),
       //Inputs
      .clk                      (clk),                
      .reset                    (reset),    
      .read                     (pop_0),    
      .write                    (write_push_demux_to_fifo0),    
      .data_in_push             (demux_out_to_fifo0)            
  );

fifo_param  fifo1(/*AUTOINST*/
      // Outputs
      .data_out_pop             (data_out_fifo1_to_out),
      .almost_full              (wire_fifo1_almost_full),
      .almost_empty             (wire_fifo1_almost_empty),
      .Fifo_full                (wire_fifo1_full),    // not connected
      .fifo_empty               (wire_fifo1_empty),
      .fifo_error               (wire_fifo1_error),
       //Inputs
      .clk                      (clk),                
      .reset                    (reset),    
      .read                     (pop_1),    
      .write                    (write_push_demux_to_fifo1),    
      .data_in_push             (demux_out_to_fifo1)            
  );

  always @(*) begin
    out0             =      data_out_fifo0_to_out;
    out1             =      data_out_fifo1_to_out;          
    fifo_empty0      =      wire_fifo0_empty;     
    fifo_empty1      =      wire_fifo1_empty;
    Error            =      (wire_fifo0_error | wire_fifo1_error); 
  end

endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
