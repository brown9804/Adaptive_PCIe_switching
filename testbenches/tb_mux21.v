// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef TB_MUX21
`define TB_MUX21



// scale time unit (value of one) / precision
`timescale 	1ns		/ 1ps
// includes verilog files
// Can be omitted and called from the testbench
// Cmos
`include "./lib/cmos_cells.v"
`include "./src/mux2x1.v"
`include "./syn/mux2x1_syn.v"
`include "./testers/t_mux21.v"

module TestBench; // Testbench
// Usually the signals in the test bench are wires.
// They do not store a value, they are handled by other module instances.
// Since they require matching the size of the inputs and outputs, they must be assigned their size
// defined in the modules

// If you define quantity format, it is recommended to keep it in the same format being the
// same used in the module for the number of bits - [1: 0] ---, another way to do it is with
// [0: 1]

// We are going to use AUTOINST: It is responsible for replacing the connections (considering it is HDL)
// pin to an instance (module) with variables as they change over time automatically in the instantiated module

// It's needed /*AUTOWIRE*/ because: Creates wires for outputs that ins't declare
parameter DATA_SIZE = 10; 

/*AUTOWIRE*/
wire                            reset_TB;
wire                            clk_TB;
wire                            fifo_empty0_TB;
wire                            fifo_empty1_TB;
wire                            fifo_up0_almostfull;
wire                            fifo_up1_almostfull;
wire [DATA_SIZE-1:0]            in0_TB; 
wire [DATA_SIZE-1:0]            in1_TB;
wire [DATA_SIZE-1:0]            out_BTB;
wire [DATA_SIZE-1:0]            out_STB;
wire                            valid;
wire                            valid_s;
wire                            pop_0;
wire                            pop_1;
wire                            pop_0_s;
wire                            pop_1_s;

///////////////////////////////////////////////////////////////////////////////////////////
              //////////// MUX 2:1 BEHAVIORAL
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

mux21 #(.DATA_SIZE(DATA_SIZE) ) 
mux21_TB (/*AUTOINST*/
// Outputs
.out                    (out_BTB),
.valid                  (valid),
.pop_0                  (pop_0),
.pop_1                  (pop_1),
//Inputs
.clk                    (clk_TB),
.reset                  (reset_TB),
.fifo_empty0            (fifo_empty0_TB),
.fifo_empty1            (fifo_empty1_TB),
.fifo_up0_almostfull    (fifo_up0_almostfull),   
.fifo_up1_almostfull    (fifo_up1_almostfull),
.in0                    (in0_TB),
.in1                    (in1_TB)
);



///////////////////////////////////////////////////////////////////////////////////////////
              //////////// MUX 2:1 SYN
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

mux21_syn mux21_syn_TB (/*AUTOINST*/
// Outputs
.out                    (out_STB),
.valid                  (valid_s),
.pop_0                  (pop_0_s),
.pop_1                  (pop_1_s),
//Inputs
.clk                    (clk_TB),
.reset                  (reset_TB),
.fifo_empty0            (fifo_empty0_TB),
.fifo_empty1            (fifo_empty1_TB),
.fifo_up0_almostfull    (fifo_up0_almostfull),   
.fifo_up1_almostfull    (fifo_up1_almostfull),
.in0                    (in0_TB),
.in1                    (in1_TB)

);

///////////////////////////////////////////////////////////////////////////////////////////
              //////////// TESTER MUX 2:1
              ////////////
///////////////////////////////////////////////////////////////////////////////////////////

t_mux21 t_mux21_TB (/*AUTOINST*/

// Inputs
.out                    (out_BTB),
.valid                  (valid),
.pop_0                  (pop_0),
.pop_1                  (pop_1),

.out_s                  (out_STB),
.valid_s                (valid_s),
.pop_0_s                (pop_0_s),
.pop_1_s                (pop_1_s),
//Outputs
.clk                    (clk_TB),
.reset                  (reset_TB),
.fifo_empty0            (fifo_empty0_TB),
.fifo_empty1            (fifo_empty1_TB),
.fifo_up0_almostfull    (fifo_up0_almostfull),   
.fifo_up1_almostfull    (fifo_up1_almostfull),
.in0                    (in0_TB),
.in1                    (in1_TB)

);


endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
