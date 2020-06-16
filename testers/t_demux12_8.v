// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef T_DEMUX12
`define T_DEMUX12


module t_demux1x2_8(
  output reg reset,
  output reg  clk,
  output reg  [7:0] in,
  output reg valid_in,
  output reg select,
  input push_0,
  input push_0_s,
  input  push_1,
  input push_1_s,
  input  [7:0] out0,
  input  [7:0] out0_s,
  input  [7:0] out1,
  input  [7:0] out1_s,
  input  [1:0]valid_out,
  input  [1:0] valid_out_s );



initial begin
// Defining the dumpfile NAME_OF_FILE_CHOICE_PERSONAL.vcd), or known by change dump variable, this file contains
// information about the simulator used, time scale, creation date, variable definitions, and value changes.
$dumpfile("demux12_8.vcd");
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


in = 8'h0;
valid_in = 0;
select = 0;
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
repeat (6) begin
@(posedge clk);
reset <= 0;
end

repeat (6) begin
@(posedge clk);
#4 reset <= 1;
end

@(posedge clk) begin
  in <= 8'hFF;
  select<= 0;
  reset <= 1;
  valid_in <= 1;
end
repeat(3) begin
	@(posedge clk) begin
    select<= 1;
		in <= 8'hDD;
	  end
end

@(posedge clk) begin
  select <= 0;
  in <= 8'hEE;
end

@(posedge clk) begin
	in <= 8'hCC;
  select <= 1;
end

@(posedge clk) begin
	in <= 8'hBB;
  select<= 0;
end


@(posedge clk) begin
  select <= 1;
	in <= 8'h99;
end


@(posedge clk) begin
	in <= 8'hAA;
  select <= 0;
end


@(posedge clk) begin
  select<= 1;
	in <= 8'h88;
end

@(posedge clk) begin
	in <= 8'h77;
  select<= 0;
end


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
