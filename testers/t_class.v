//////////////////////////////////////
// Brandon ESquivel Molina          //
// Tester for class.v               //
// brandon.esquivel@ucr.ac.cr       //
//                                  //
//////////////////////////////////////

`ifndef T_CLASS
`define T_CLASS


module t_class(
  output reg  reset,
  output reg  clk,
  output reg  [9:0] in,
  output reg  valid_in,

  output reg read1,
  output reg read2,
 
 input wire almost_full1_in,
 input wire almost_empty1_in,
 input wire fifo1_empty,
 input wire fifo1_error,
 input wire fifo1_pause,

 input wire almost_full2_in,
 input wire almost_empty2_in,
 input wire fifo2_empty,
 input wire fifo2_error,
 input wire fifo2_pause,


  input wire [9:0] out0,
  input wire [9:0] out0_s,
  input wire [9:0] out1,
  input wire [9:0] out1_s
  );



initial begin
// Defining the dumpfile NAME_OF_FILE_CHOICE_PERSONAL.vcd), or known by change dump variable, this file contains
// information about the simulator used, time scale, creation date, variable definitions, and value changes.
$dumpfile("class.vcd");
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


in = 10'h0;
valid_in = 0;
#4 reset = 0;


// This passes the first clock cycle ... Defining initial values ​​....

  // Binary, Hexadecimal
  // 0x88 = 1000 1000
  // 0x99 = 1001 1001
  // 0xAA = 1010 1010
  // 0xBB = 1011 1011
  // 0xCC = 1100 1100
  // 0xDD = 1101 1101
  // 0XEE = 1110 1110
  // 0XFF = 1111 1111




// Begin test
repeat(4) begin
@(posedge clk) begin
    reset <= 0;
  end
end

@(posedge clk) begin
  in <= 10'h0FF;
  reset <= 1;
  valid_in <= 1;
end
repeat(3) begin
	@(posedge clk) begin
		in <= 10'h0DD;
	  end
end

@(posedge clk) begin
  in <= 10'h0EE;
end

@(posedge clk) begin
	in <= 10'h0CC;
end

@(posedge clk) begin
	in <= 10'h0BB;
end

/*
@(posedge clk) begin
	in <= 10'h099;
end


@(posedge clk) begin
	in <= 10'h0AA;
end


@(posedge clk) begin
  select<= 1;
	in <= 10'h088;
end

@(posedge clk) begin
	in <= 10'h077;
  select<= 0;
end

*/
#40 $finish;
end

// clock logic
initial	clk	 			<= 0;			// Initial value to avoid indeterminations
always	#10 clk				<= ~clk;		// toggle every 10ns

endmodule


// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
