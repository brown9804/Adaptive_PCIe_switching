// 	//	 /////  //////	
//  //   //		//	//	
// 	//	 //	    ///_ 	
//////   /////  //  // 	

////////////////////////////////
// Belinda Brown Ramírez      //
// timna.brown@ucr.ac.cr      // 
// Brandon Esquivel Molina    //
// brandon.esquivel@ucr.ac.cr //
// Revision: June, 2020 	  //
////////////////////////////////

// Tester for module FIFO
						
`ifndef T_FIFO
`define T_FIFO


module fifo_tester #(
    //Parameters
    parameter DATA_SIZE = 10,
    parameter MAIN_SIZE = 8
)(
	// Outputs
	output reg 					clk,
	output reg 					reset,
	output reg 					read,
	output reg 					write,
	output reg [DATA_SIZE-1:0] 	data_in_push,
	// Inputs
	input wire 					fifo_empty,
	input wire 					fifo_empty_s,
	input wire 					fifo_error,
	input wire 					fifo_error_s,
	input wire 					almost_full,
	input wire 					almost_full_s,
	input wire 					almost_empty,
	input wire 					almost_empty_s,
	input wire 					Fifo_full,	
	input wire 					Fifo_full_s,
	input wire [DATA_SIZE-1:0]  data_out_pop,
	input wire [DATA_SIZE-1:0] 	data_out_pop_s
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

		@(posedge clk) begin
			data_in_push <= 'h1FF;
		  	write <= 1;
		end

    	@(posedge clk) begin
    		data_in_push <= 'h1EE;
    	end

		@(posedge clk) begin
    		data_in_push <= 'h0CC;
    	end

		@(posedge clk) begin
    		data_in_push <= 'h1DD;
				read 		 <= 1;
    	end

		@(posedge clk) begin
    		data_in_push <= 'h1AA;
    	end

		@(posedge clk) begin
    		data_in_push <= 'h0EA;
			
    	end

		@(posedge clk) begin
    		data_in_push <= 'h1AA;
    	end

		@(posedge clk) begin
    		data_in_push <= 'h1AF;
    	end

		@(posedge clk) begin
    		data_in_push <= 'h1AA;
    	end

		@(posedge clk) begin
			read <= 1;
    	end
		
		@(posedge clk) begin
    		read <= 0;
    	end

		@(posedge clk) begin
			reset <= 0;
    	end
		@(posedge clk) begin
			reset <= 1;
    	end

		@(posedge clk) begin
    		data_in_push <= 'h11F;
    	end
		@(posedge clk) begin
    		data_in_push <= 'h12F;
    	end
		@(posedge clk) begin
    		data_in_push <= 'h13F;
    	end
		@(posedge clk) begin
    		data_in_push <= 'h14F;
    	end
		@(posedge clk) begin
    		data_in_push <= 'h15F;
    	end
		@(posedge clk) begin
    		data_in_push <= 'h16F;
    	end
		@(posedge clk) begin
    		data_in_push <= 'h17F;
    	end
		@(posedge clk) begin
    		data_in_push <= 'h18F;
    	end


    	#40 $finish;
	end

    initial clk		 <= 0;
    always #10 clk	 <= ~clk;

endmodule


// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
