// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef T_MUX21
`define T_MUX21



`timescale 1ns/1ps


module t_mux21(
// Outputs
output reg clk,
output reg reset,
output reg  fifo_empty0,
output reg  fifo_empty1,
output reg [9:0] in0,
output reg [9:0] in1,
// Inputs
input [7:0] out,
input [7:0] out_s
);


initial begin
		$dumpfile("mux21.vcd");
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


in0 = 10'h0;
in1 = 10'h0;
fifo_empty0 = 0;
fifo_empty1 = 0;
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
// Both has data
repeat(2) begin
@(posedge clk) begin
in0 <= 10'h0FF;
in1 <= 10'h0DD;
fifo_empty0 <= 0;
fifo_empty1 <= 0;
end
end
// FIFO 0 is empty
repeat(2) begin
@(posedge clk) begin
in0 <= 10'h0EE;
in1 <= 10'h0CC;
fifo_empty0 <= 1;
fifo_empty1 <= 0;
end
end

// FIFO 1 is empty
repeat(2) begin
@(posedge clk) begin
in0 <= 10'h0BB;
in1 <= 10'h099;
fifo_empty0 <= 0;
fifo_empty1 <= 1;
end
end

// Both are empty
repeat(2) begin
@(posedge clk) begin
in0 <= 10'h0AA;
in1 <= 10'h088;
fifo_empty0 <= 0;
fifo_empty1 <= 1;
end
end

// Both are empty
repeat(2) begin
@(posedge clk) begin
in0 <= 10'h077;
in1 <= 10'h066;
fifo_empty0 <= 1;
fifo_empty1 <= 1;
end
end

end // end big one repeat


#40 $finish;
end

// clock logic
initial	clk	 			<= 0;			// Initial value to avoid indeterminations
always	#10 clk				<= ~clk;		// toggle every 10ns


endmodule


// Local Variables:
// verilog-library-directories:("."):
// verilog-auto-wire-type:\"logic\"
// End:

`endif
