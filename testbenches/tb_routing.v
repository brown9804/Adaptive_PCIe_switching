//////////////////////////////////////
// Brandon ESquivel Molina          //
// Tester for routering.v           //
// brandon.esquivel@ucr.ac.cr       //
// JUne, 2020                       //
//////////////////////////////////////


`ifndef TB_ROUTING
`define TB_ROUTING


// scale time unit (value of one) / precision
`timescale 	1ns				/ 1ps

`include "./lib/cmos_cells.v"
`include "./src/routing.v"
`include "./syn/routing_syn.v"
`include "./testers/t_routing.v"

module TestBench; 

// It's needed /*AUTOWIRE*/ because: Creates wires for outputs that ins't declare

/*AUTOWIRE*/
  wire [7:0]          out0_BTB;
  wire [7:0]          out1_BTB;
  wire                error_BTB;
  wire                pop_0_BTB;
  wire                pop_1_BTB;
  wire                fifo0_almost_empty_BTB;
  wire                fifo1_almost_empty_BTB;
             
  wire [7:0]          out0_STB;
  wire [7:0]          out1_STB;
  wire                error_STB;
  wire                pop_0_STB;
  wire                pop_1_STB;
  wire                fifo0_almost_empty_STB;
  wire                fifo1_almost_empty_STB;
              
  wire                clk;
  wire                reset;
  wire [9:0]          in0;
  wire [9:0]          in1;
  wire                pop_0_in;
  wire                pop_1_in;
  wire                fifo_empty0;
  wire                fifo_empty1;

/////////////////////////////////////////////////////////
//    ROUTING BEHAVIORAL
//  
/////////////////////////////////////////////////////////


router route_TB(/*AUTOINST*/
  // Outputs
  .out0                    (out0_BTB),                     
  .out1                    (out1_BTB),                     
  .Error                   (error_BTB),                       
  .pop_0                   (pop_0_BTB),                       
  .pop_1                   (pop_1_BTB),                       
  .fifo0_almost_empty      (fifo0_almost_empty_BTB),                                   
  .fifo1_almost_empty      (fifo1_almost_empty_BTB),                                   
  // Inputs
  .in0                     (in0),                     
  .in1                     (in1),                     
  .clk                     (clk),                     
  .reset                   (reset),                       
  .pop_0_in                (pop_0_in),                         
  .pop_1_in                (pop_1_in),                         
  .fifo_empty0             (fifo_empty0),                             
  .fifo_empty1             (fifo_empty1)                   
);


//////////////////////////
// ROUTING SYN /////      
///////////////
///////////
///////
////
//


router_syn route_syn_TB(/*AUTOINST*/
  // Outputs
  .out0                    (out0_STB),                     
  .out1                    (out1_STB),                     
  .Error                   (error_STB),                       
  .pop_0                   (pop_0_STB),                       
  .pop_1                   (pop_1_STB),                       
  .fifo0_almost_empty      (fifo0_almost_empty_STB),                                   
  .fifo1_almost_empty      (fifo1_almost_empty_STB),                                   
  // Inputs
  .in0                     (in0),                     
  .in1                     (in1),                     
  .clk                     (clk),                     
  .reset                   (reset),                       
  .pop_0_in                (pop_0_in),                         
  .pop_1_in                (pop_1_in),                         
  .fifo_empty0             (fifo_empty0),                             
  .fifo_empty1             (fifo_empty1) 

);

///////////////////////////////////////////////////////////////////////////////////////////
              //////////// TESTER ROUTING
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////


t_route t_route_TB(/*AUTOINST*/
  // Inputs
  //behav
  .out0                           (out0_BTB),            
  .out1                           (out1_BTB),            
  .Error                          (error_BTB),              
  .pop_0                          (pop_0_BTB),              
  .pop_1                          (pop_1_BTB),              
  .fifo0_almost_empty             (fifo0_almost_empty_BTB),                          
  .fifo1_almost_empty             (fifo1_almost_empty_BTB),

  // Structural
  .out0_s                         (out0_STB),          
  .out1_s                         (out1_STB),          
  .Error_s                        (error_STB),            
  .pop_0_s                        (pop_0_STB),            
  .pop_1_s                        (pop_1_STB),            
  .fifo0_almost_empty_s           (fifo0_almost_empty_STB),                        
  .fifo1_almost_empty_s           (fifo1_almost_empty_STB),                        
  
  // Outputs
  .clk                            (clk),
  .reset                          (reset),
  .in0                            (in0),
  .in1                            (in1),
  .pop_0_in                       (pop_0_in),
  .pop_1_in                       (pop_1_in),
  .fifo_empty0                    (fifo_empty0),
  .fifo_empty1                    (fifo_empty1)
);      


endmodule

// Local Variables:
// verilog-library-directories:("."):
// verilog-auto-wire-type:\"logic\"
// End:

`endif
