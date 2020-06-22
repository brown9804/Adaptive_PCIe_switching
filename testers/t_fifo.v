// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef T_FIFO
`define T_FIFO


module fifo_tester #(
    //Parametros
    parameter DATA_SIZE = 10,
    parameter MAIN_SIZE=8
)(
  // Outputs
  output reg clk,
  output reg reset,
  output reg read,
  output reg write,
  output reg [DATA_SIZE-1:0] data_in_push,
  // Inputs
  input wire fifo_empty,
  input wire [DATA_SIZE-1:0] data_out_pop,
  input wire fifo_error,
  input wire fifo_pause,
  input wire  almost_full,
  input wire  almost_empty,
  input wire fifo_synth_empty,
  input wire Fifo_full,
  input wire [DATA_SIZE-1:0] data_out_pop_s,
  input wire fifo_synth_error,
  input wire fifo_synth_pause,
  input wire  almost_full_s,
  input wire almost_empty_s,
  input wire Fifo_full_s
);


 initial begin

     $dumpfile("fifo.vcd");
 		// Defining the dumpfile NAME_OF_FILE_CHOICE_PERSONAL.vcd), or known by change dump variable, this file contains
 		// information about the simulator used, time scale, creation date, variable definitions, and value changes.
     $dumpvars;

 		// The stimulus must be changed, where it allows testing to give an idea of ​​the behavior of the signals.
 		// Therefore, the inputs will be initialized with a value chosen between one and zero. Since they are not defined
 		// initial conditions in the algorithm request. They are personally chosen.

 		// VERILOG ASSIGNMENTS FOR NUMBERS - FORMAT
 		// 'b binary base
 		// 'd Decimal base
 		// 'h Hexadecimal base
 		// 'or octal base
 		// and what comes after the letter is the value then in the case of binary
 		// the following examples are considered for understanding
 		// 2'b0 = 2'b00 = 00
 		// 2'b1 = 2'b01 = 01
 		// 2'b10 = 10
 		// 2'b11 = 11
 		// If it does not indicate the size, 32 bits are assigned by default, that is, 'b0 = 00000000000000000000000000000000
 		// This passes the first clock cycle ... Defining initial values ​​....

    read = 0;
    write = 0;
    data_in_push ='h0;
    #4 reset = 0;

    // Begin test
		repeat (6) begin
		@(posedge clk);
		reset <= 0;
		end

		repeat (6) begin
		@(posedge clk);
		#4 reset <= 1;
		end

    repeat(2) begin
    		repeat(4) begin
    		read <= 0;
    		write <= 1;
    		end

    		repeat (4) begin
    		@(posedge clk);
    		  data_in_push <= 'hFF;
    			end

    		repeat (4) begin
    		@(posedge clk);
    		  data_in_push <= 'hDD;
    			end
    end // end repeat 2

    repeat(2) begin
    		repeat(4) begin
    		read <= 1;
    		write <= 0;
    		end

    		repeat (4) begin
    		@(posedge clk);
    		  data_in_push <= 'hEE;
    			end

    		repeat (4) begin
    		@(posedge clk);
    		  data_in_push <= 'hCC;
    			end
    end // end repeat 2

    repeat(2) begin
    		repeat(4) begin
    		read <= 0;
    		write <= 1;
    		end


    		repeat (4) begin
    		@(posedge clk);
    		  data_in_push <= 'hBB;
    			end

    		repeat (4) begin
    		@(posedge clk);
    		  data_in_push <= 'h99;
    			end
    end // end repeat 2

    repeat (2) begin
   		repeat(4) begin
   		read <= 1;
   		write <= 0;
   		end

   		repeat (4) begin
   		@(posedge clk);
   		  data_in_push <= 'hAA;
   			end

   		repeat (4) begin
   		@(posedge clk);
   		  data_in_push <= 'h88;
   			end
   end // end repeat 2

   // Same test but two write and two read  instructions

   repeat(2) begin
   		repeat(4) begin
   		read <= 0;
   		write <= 1;
   		end

   		repeat (4) begin
   		@(posedge clk);
   		  data_in_push <= 'hFF;
   			end

   		repeat (4) begin
   		@(posedge clk);
   		  data_in_push <= 'hDD;
   			end
   end // end repeat 2


   repeat(2) begin
   		repeat(4) begin
   		read <= 0;
   		write <= 1;
   		end

   		repeat (4) begin
   		@(posedge clk);
   		  data_in_push <= 'hEE;
   			end

   		repeat (4) begin
   		@(posedge clk);
   		  data_in_push <= 'hCC;
   			end
   end // end repeat 2



    #40 $finish;
end

    initial clk <= 0;
    always # 5 clk <= ~clk;

endmodule


// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
