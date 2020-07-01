/////////////////////////////////                      .        .
//  Brandon Equivel             //                        .  .
//  brandon.esquivel@ucr.ac.cr   ///////////............///////
//  Belinda Brown Ramírez         //////////.............//////    .
//  timna.brown@ucr.ac.cr        //
//  June, 2020                 //                        .    .      .
////////////////////////////////                       .
      ///           ///
    ///               ///
  ///                   ///
////                    /////

`ifndef T_MEMORY
`define T_MEMORY


module memory_tester #( parameter DATA_SIZE = 10, parameter MAIN_SIZE = 8 )(
	// Outputs
	output reg 		 			clk,
  	output reg		 			read,
  	output reg 		 			write,
	output reg 		 			reset,
	output reg [MAIN_SIZE-1:0] 	wr_ptr,
	output reg [MAIN_SIZE-1:0] 	rd_ptr,
	output reg [DATA_SIZE-1:0] 	data_in,
	// Inputs
	input wire [DATA_SIZE-1:0]  data_out,
  	input wire [DATA_SIZE-1:0]  data_out_s
);

 	initial begin

    	$dumpfile("memory.vcd");
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


    	{data_in}		= 'h0;
    	{wr_ptr}		= 'h0;
    	{rd_ptr}		= 'h0;
		#4 reset		= 	0;
    	read 			= 	0;
    	write 			= 	0;



		// Begin test
		repeat (6) begin
		@(posedge clk)
		reset 			<= 0;
		end
	
		@(posedge clk) begin
		#4 reset 		<= 1;
		end

		// IN seqs starts
		@(posedge clk) begin
		data_in 		 <= 'h1FF;
		write			 <=  1;
		wr_ptr			 <= 'h1;
		end

		@(posedge clk) begin
		data_in 		 <= 'h1EE;
		wr_ptr			 <= 'h2;
		end

		@(posedge clk) begin
		data_in 		 <= 'h1CC;
		wr_ptr			 <= 'h3;
		end
		
		@(posedge clk) begin
		data_in 		 <= 'h0FF;
		wr_ptr			 <= 'h4;
		rd_ptr			 <= 'h1;
		read 			 <=  1;
		end
		
		@(posedge clk) begin
		data_in 		 <= 'h0AA;
		wr_ptr			 <= 'h5;
		rd_ptr			 <= 'h2;
		end
		
		@(posedge clk) begin
		data_in 		 <= 'h1DD;
		rd_ptr			 <= 'h3;
		write 			 <=  0;
		end

		@(posedge clk) begin
		data_in 		 <= 'h1FA;
		rd_ptr			 <= 'h4;
		end

		@(posedge clk) begin
		data_in 		 <= 'h1DD;
		rd_ptr			 <= 'h5;
		end

		@(posedge clk) begin
		data_in 		 <= 'h0AA;
		read  			 <= 0;
		end

		@(posedge clk) begin
		reset    		<= 0;
		end
		@(posedge clk) begin
		reset    		<= 0;
		end

   		#40 $finish;
	end

    initial 	clk 	<= 0;
    always #10 	clk		<= ~clk;

endmodule


// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
