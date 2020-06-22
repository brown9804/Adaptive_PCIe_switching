// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef T_MEMORY
`define T_MEMORY


module memory_tester #( parameter MAIN_SIZE=8, parameter DATA_SIZE = 10)(
	// Outputs
	output reg  clk,
  output reg	read,
  output reg  write,
	output reg  reset,
	output reg [MAIN_SIZE-1:0] wr_ptr,
	output reg [MAIN_SIZE-1:0] rd_ptr,
	output reg [DATA_SIZE-1:0] data_in,
	// Inputs
	input  [DATA_SIZE-1:0] data_out,
  input [DATA_SIZE-1:0] data_out_s
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


    {data_in} = 'h0;
    {wr_ptr}  = 'h0;
    {rd_ptr}  = 'h0;
		#4 reset = 0;
    read = 0;
    write = 0;

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
		wr_ptr <= 'h1;
		rd_ptr <= 'h0;
		end

		repeat (4) begin
		@(posedge clk);
		  data_in <= 'hFF;
			end

		repeat (4) begin
		@(posedge clk);
		  data_in <= 'hDD;
			end
end // end repeat 2

repeat(2) begin
		repeat(4) begin
		read <= 1;
		write <= 0;
		wr_ptr <= 'h0;
		rd_ptr <= 'h1;
		end

		repeat (4) begin
		@(posedge clk);
		  data_in <= 'hEE;
			end

		repeat (4) begin
		@(posedge clk);
		  data_in <= 'hCC;
			end
end // end repeat 2

repeat(2) begin
		repeat(4) begin
		read <= 0;
		write <= 1;
		wr_ptr <= 'h1;
		rd_ptr <= 'h0;
		end


		repeat (4) begin
		@(posedge clk);
		  data_in <= 'hBB;
			end

		repeat (4) begin
		@(posedge clk);
		  data_in <= 'h99;
			end
end // end repeat 2

 repeat (2) begin
		repeat(4) begin
		read <= 1;
		write <= 0;
		wr_ptr <= 'h0;
		rd_ptr <= 'h1;
		end

		repeat (4) begin
		@(posedge clk);
		  data_in <= 'hAA;
			end

		repeat (4) begin
		@(posedge clk);
		  data_in <= 'h88;
			end
end // end repeat 2

// Same test but two write and two read  instructions

repeat(2) begin
		repeat(4) begin
		read <= 0;
		write <= 1;
		wr_ptr <= 'h1;
		rd_ptr <= 'h0;
		end

		repeat (4) begin
		@(posedge clk);
		  data_in <= 'hFF;
			end

		repeat (4) begin
		@(posedge clk);
		  data_in <= 'hDD;
			end
end // end repeat 2


repeat(2) begin
		repeat(4) begin
		read <= 0;
		write <= 1;
		wr_ptr <= 'h1;
		rd_ptr <= 'h0;
		end

		repeat (4) begin
		@(posedge clk);
		  data_in <= 'hEE;
			end

		repeat (4) begin
		@(posedge clk);
		  data_in <= 'hCC;
			end
end // end repeat 2

repeat(2) begin
		repeat(4) begin
		read <= 1;
		write <= 0;
		wr_ptr <= 'h0;
		rd_ptr <= 'h1;
		end


		repeat (4) begin
		@(posedge clk);
		  data_in <= 'hBB;
			end

		repeat (4) begin
		@(posedge clk);
		  data_in <= 'h99;
			end
end // end repeat 2

 repeat (2) begin
		repeat(4) begin
		read <= 1;
		write <= 0;
		wr_ptr <= 'h0;
		rd_ptr <= 'h1;
		end

		repeat (4) begin
		@(posedge clk);
		  data_in <= 'hAA;
			end

		repeat (4) begin
		@(posedge clk);
		  data_in <= 'h88;
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
