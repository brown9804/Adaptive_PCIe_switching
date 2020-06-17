// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef TB_CLASS
`define TB_CLASS


// scale time unit (value of one) / precision
`timescale 	1ns	/ 100ps

`include "./lib/cmos_cells.v"
`include "./src/df_control.v"
`include "./syn/dfcontrol_syn.v"
`include "./testers/t_dfcontrol.v"

module TestBench; 

/*AUTOWIRE*/

// general 
wire reset;
wire write1;
wire write1s;
wire read1;
wire read1s;
wire Error;
wire Errors;
wire push_0;




///////////////////////////////////////////////////////////////////////////////////////////
              //////////// dt control behav
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

dfcontrol  dfcontrol_b(
  .reset                          ( reset ),
  .read1                          ( read1 ),
  .write1                         ( write1 ),
  
  .push_0                         ( push_0),           // from/to dtcontrol/fifo 1
  .almost_full1                   ( almost_full1  ),    
  .almost_empty1                  ( almost_empty1 ),    
  .fifo_empty1                    ( fifo_empty1  ),     
  .Fifo_full1                     ( Fifo_full1  ),      
  .fifo_error1                    ( fifo_error1  ),    
  .fifo_pause1                    ( fifo_pause1   ),   
    /*
  .read2                          ( read2 ),            // from/to dtcontrol/fifo 2       
  .write2                         ( write2 ),           
  .almost_full2                   ( almost_full2  ),    
  .almost_empty2                  ( almost_empty2 ),    
  .fifo_empty2                    ( fifo_empty2  ),     
  .Fifo_full2                     ( Fifo_full2  ),      
  .fifo_error2                    ( fifo_error2  ),    
  .fifo_pause2                    ( fifo_pause2   ),   
    */
  .Error                           ( wError)
);

///////////////////////////////////////////////////////////////////////////////////////////
              ////////////  df control SYN
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

dfcontrol_syn  dfcontrol_s(
  
  .reset                          ( reset ),
  .read1                          ( read1s ),
  .write1                         ( write1s ),

  .push_0                         ( push_0),           // from/to dtcontrol/fifo 1
  .almost_full1                   ( almost_full1  ),    
  .almost_empty1                  ( almost_empty1 ),    
  .fifo_empty1                    ( fifo_empty1  ),     
  .Fifo_full1                     ( Fifo_full1  ),      
  .fifo_error1                    ( fifo_error1  ),    
  .fifo_pause1                    ( fifo_pause1   ),   
    /*
  .read2                          ( read2 ),            // from/to dtcontrol/fifo 2       
  .write2                         ( write2 ),           
  .almost_full2                   ( almost_full2  ),    
  .almost_empty2                  ( almost_empty2 ),    
  .fifo_empty2                    ( fifo_empty2  ),     
  .Fifo_full2                     ( Fifo_full2  ),      
  .fifo_error2                    ( fifo_error2  ),    
  .fifo_pause2                    ( fifo_pause2   ),   
    */
  .Error                           ( wErrors)
);


///////////////////////////////////////////////////////////////////////////////////////////
              //////////// TESTER df control
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

t_dfcontrol t_dfcontrolTB (

  .push_0                         ( push_0),
  .read1                          ( read1 ),
  .write1                         ( write1 ),
  .read1s                         ( read1s ),
  .write1s                        ( write1s ), 
  .Error                          ( wError ),
  .Errors                          ( wErrors ),          // from/to dtcontrol/fifo 1
  
  .almost_full1                   ( almost_full1  ),    
  .almost_empty1                  ( almost_empty1 ),    
  .fifo_empty1                    ( fifo_empty1  ),     
  .Fifo_full1                     ( Fifo_full1  ),      
  .fifo_error1                    ( fifo_error1  ),    
  .fifo_pause1                    ( fifo_pause1   ),   
  .reset                          ( reset  )
);



endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
