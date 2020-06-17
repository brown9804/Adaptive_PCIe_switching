// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef T_ROUTING
`define T_ROUTING

module t_route(
// Outputs
input wire [7:0]out0,
input wire [7:0] out1,
input wire almost_full0,
input wire almost_empty0,
input wire fifo0_empty,
input wire fifo0_error,
input wire fifo0_pause,
input wire fifo_full0,
input wire fifo_full1,
input wire almost_full1,
input wire almost_empty1,
input wire fifo1_empty,
input wire fifo1_error,
input wire fifo1_pause,
input wire [7:0]out0_s,
input wire [7:0] out1_s,
input wire almost_full0_s,
input wire almost_empty0_s,
input wire fifo0_empty_s,
input wire fifo0_error_s,
input wire fifo0_pause_s,
input wire fifo_full0_s,
input wire fifo_full1_s,
input wire almost_full1_s,
input wire almost_empty1_s,
input wire fifo1_empty_s,
input wire fifo1_error_s,
input wire fifo1_pause_s,
// Inputs
output reg clk,
output reg reset,
output reg [9:0] in0,
output reg in0_valid,
output reg in1_valid,
output reg [9:0] in1,
output reg  read0,
output reg  read1
);


initial begin
// Defining the dumpfile NAME_OF_FILE_CHOICE_PERSONAL.vcd), or known by change dump variable, this file contains
// information about the simulator used, time scale, creation date, variable definitions, and value changes.
$dumpfile("routing.vcd");
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

in0 = 10'h00;
in1 = 10'h00;
in0_valid = 0;
in1_valid = 0;
read0 = 0;
read1 = 0;

// Begin test
repeat (6) begin
@(posedge clk);
reset <= 0;
end

repeat (6) begin
@(posedge clk);
#4 reset <= 1;
in0_valid <= 1;
in1_valid <= 1;
end

repeat (4) begin
@(posedge clk);
  in0 <= 10'hFF;
  in1 <= 10'hDD;
  read0 <= 0;
  read1 <= 1;
end

repeat (4) begin
@(posedge clk);
  in0 <= 10'hEE;
  in1 <= 10'hCC;
  read0 <= 1;
  read1 <= 0;
end

repeat (4) begin
@(posedge clk);
  in0 <= 10'hBB;
  in1 <= 10'h99;
  read0 <= 0;
  read1 <= 1;
end

repeat (4) begin
@(posedge clk);
  in0 <= 10'hAA;
  in1 <= 10'h88;
  read0 <= 1;
  read1 <= 0;
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
