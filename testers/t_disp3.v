//  Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr


`ifndef T_DISP3
`define T_DISP3

// only necessary signals
module t_device3 #(
		//Parameters
		parameter DATA_SIZE = 10,
		parameter MAIN_SIZE = 8
) (
	// Outputs
	output reg reset,
	output reg clk,
	output reg clk8f,
	output reg [DATA_SIZE-1:0] in,
	output reg read0,
	output reg read1,
	output reg write0,
	output reg write1,
	// Inputs
	input wire [MAIN_SIZE-1:0] out0,
	input wire [MAIN_SIZE-1:0] out1,
	//Syn
	input wire [MAIN_SIZE-1:0] out0_s,
	input wire [MAIN_SIZE-1:0] out1_s,

	input wire Error0_BTB, Error1_BTB,Error0_STB,Error1_STB

);

reg clkbase, clk4f, clk2f;


initial begin

	$dumpfile("disp3.vcd");
	$dumpvars;



in = 10'h0;
#4 reset = 0;
write0= 0;
read0 = 0;
write1 = 0;
read1=0;

repeat (6) begin
	@(posedge clk);
		reset = 0;
end

@(posedge clk);
#40 reset = 1;

repeat(3) begin         // 01010101  -> Active = 0 because BC < 4
	@(posedge clk);
	in  <=  ~in;
	end

repeat (7) begin
	@(posedge clk);
end

repeat(5) begin
@(posedge clk);
	in <= 10'h0BC;
end// end five BC's

repeat(5) begin
	@(posedge clk);
	in <= 10'h07C;
end // end five 7C's


@(posedge clk); // write --> fifo 0
	in <= 10'h0FF;
	write0 <= 1;
	read0 <= 0;
	write1 <= 0;
	read1 <= 0;
	@(posedge clk); // write --> fifo 1
	write0 <= 0;
	read0 <= 0;
	write1 <= 1;
	read1 <= 0;

@(posedge clk); // read fifo 0
		write0 <= 0;
		read0 <= 1;
		write1 <= 0;
		read1 <= 0;
		@(posedge clk); // read fifo 1
		write0 <= 0;
		read0 <= 0;
		write1 <= 0;
		read1 <= 1;

@(posedge clk); // write on fifo 0
	in <= 10'h0EE;
	write0 <= 1;
	read0 <= 0;
	write1 <= 0;
	read1 <= 0;
	@(posedge clk); //  write on fifo 1
	write0 <= 0;
	read0 <= 0;
	write1 <= 1;
	read1 <= 0;

@(posedge clk); // read fifo 0
		write0 <= 0;
		read0 <= 1;
		write1 <= 0;
		read1 <= 0;
		@(posedge clk); // read fifo 1
		write0 <= 0;
		read0 <= 0;
		write1 <= 0;
		read1 <= 1;

@(posedge clk); //  write on fifo 0
	in <= 10'h0BB;
	write0 <= 1;
	read0 <= 0;
	write1 <= 0;
	read1 <= 0;
	@(posedge clk); //  write on fifo 1
	write0 <= 0;
	read0 <= 0;
	write1 <= 1;
	read1 <= 0;

@(posedge clk); // read fifo 0
		write0 <= 0;
		read0 <= 1;
		write1 <= 0;
		read1 <= 0;
		@(posedge clk); // read fifo 1
		write0 <= 0;
		read0 <= 0;
		write1 <= 0;
		read1 <= 1;

#40 $finish;
end // end initial

// clock logic
initial	clkbase	 			<= 0;			// Initial value to avoid indeterminations
always	#10 clkbase	 <= ~clkbase;		// toggle every 10ns

initial clk8f <= 0;
initial clk4f <= 0;
initial clk2f <= 0;
initial	clk	 	<= 0;			// Initial value to avoid indeterminations

// Faster frequency
always @(posedge clkbase) begin
	clk8f <= ~clk8f; // if was LOW change to HIGH
	end


// For 4 Hz
always @(posedge clk8f) begin
		clk4f <= ~clk4f; // if was LOW change to HIGH
		end
			 //////////////////////////////
// For 2 Hz
always @(posedge clk4f) begin
		clk2f <= ~clk2f; // if was LOW change to HIGH
		end
			 //////////////////////////////
// For 1 Hz
always @(posedge clk2f) begin
		clk <= ~clk; // if was LOW change to HIGH
		end


endmodule


// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
