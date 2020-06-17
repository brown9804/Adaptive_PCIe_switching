// DATA FLOW CONTROL
// Brandon Esquivel Molina
// brandon.esquivel@ucr.ac.cr
// Proyecto 2 Digitales II
//////////////////////////////////


`ifndef DFCONTROL
`define DFCONTROL

`timescale 1ns/1ps

module dfcontrol (

    input wire reset,
    input wire push_0,
    input wire push_1,

// signals from 2 FIFOs
    input wire  almost_full1,
    input wire  almost_empty1,
    input wire  fifo_empty1,
    input wire  Fifo_full1,
    input wire  fifo_error1,
    input wire  fifo_pause1,

    input wire almost_full2,
    input wire  almost_empty2,
    input wire  fifo_empty2,
    input wire  Fifo_full2,
    input wire  fifo_error2,
    input wire  fifo_pause2,

// to fifos
    output reg read1,
    output reg write1,
    output reg read2,
    output reg write2,

// to next/back stage dt control
    /*output reg AF1_up,               // control signal output for dataflow control Almost full up for fifo 1
    output reg AF2_up,               // control signal output for dataflow control Almost full up for fifo 2
    output reg AE1_down,             // control signal output for dataflow control Almost empty down for fifo 1
    output reg AE2_down,             // control signal output for dataflow control Almost empty down for fifo 2
    output reg Full_up1,             // control signal output for dataflow control full up for fifo 1
    output reg Full_up2,             // control signal output for dataflow control full up for fifo 2
    */
    output reg Error
    
    /*
    input wire Full_down1,           // control signal output for dataflow control full down for fifo 1
    input wire Full_down2,            // control signal output for dataflow control full down for fifo 2
    input wire AF1_down,             // control signal input for dataflow control Almost full down for fifo 1
    input wire AF2_down,             // control signal input for dataflow control Almost full down for fifo 2
    input wire AE1_up,               // control signal input for dataflow control Almost empty up for fifo 1
    input wire AE2_up               // control signal input for dataflow control Almost empty up for fifo 2
    */
);

// internal control

always@(*) begin
    /*AF1_up = 0;
    AF2_up = 0;
    AE1_down = 0;
    AE2_down = 0;
    Full_up1 = 0;
    Full_up2 = 0;
    */
    
    Error = 0;
    
    read1 = 0;
    read2 = 0;
    write1 = 0;
    write2 = 0;
    if ( ~reset ) begin
            /*AF1_up = 0;
            AF2_up = 0;
            AE1_down = 1;
            AE2_down = 1;
            Full_up1 = 0;
            Full_up2 = 0;
            */
            Error = 0;
            read1 = 0;
            read2 = 0;
            write1 = 0;
            write2 = 0;
        end 


 else begin/*
AF1_up = almost_full1;
AF2_up = almost_full2;
AE1_down = almost_empty1; 
AE2_down = almost_empty2;
Full_up1 = Fifo_full1;
Full_up2 = Fifo_full2;     
          */
        if (push_0 & (~Fifo_full1 | ~almost_full1 | ~fifo_pause1) ) begin
        write1 = 1;
            
        end
        else begin
          write1 = 0;
        end

        if (push_1 & (~Fifo_full2 | ~almost_full2 | ~fifo_pause2) ) begin
        write2 = 1;
            
        end
        else begin
          write2 = 0;
        end

        if (almost_empty1 | fifo_empty1) begin
            read1 = 0;
        end
        else begin
          read1 = 1;
        end


        if (almost_empty2 | fifo_empty2 ) begin
            read2 = 0;
        end
        else begin
          read2 = 1;
        end
        if ( fifo_error1 | fifo_error2 ) begin
            Error = 1;
        end
        else begin
          Error = 0;
        end

    end
end
endmodule         

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif

