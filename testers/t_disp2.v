// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr
// Co- worked with Brandon Esquivel Molina
// brandon.esquivel@ucr.ac.cr


`ifndef T_DISP2
`define T_DISP2

module t_device2 (
output reg in0,
output reg in1,
output reg reset,
output reg clk,
output reg clk8f,
output reg read0,
output reg read1,
output reg write0,
output reg write1,
output reg read,
output reg write,
// Behavioral
input wire [7:0] out0,
input wire [7:0] out1,
input wire almost_full_f0,
input wire almost_full_f1,
input wire empty0, // output from fifo 0
input wire empty1, // output from fifo 1
// Syn
input [7:0] out0_s,
input [7:0] out1_s,
input almost_full_f0_s,
input almost_full_f1_s,
input wire empty0_s, // output from fifo 0
input wire empty1_s // output from fifo 1
);

reg clkbase, clk4f, clk2f;

initial begin
  $dumpfile("disp2.vcd");		// "dump" file
  $dumpvars;

  in0 = 0;
  in1 = 0;
  #4 reset = 0;
  write0 = 0;
  read0 = 0;
  write1 = 0;
  read1 = 0;

repeat (6) begin
	@(posedge clk8f);
		reset = 0;
end

repeat (6) begin
	@(posedge clk8f);
      reset <= 1;
end

  // Tests

repeat(3) begin         // 01010101  -> Active = 0 because BC < 4
  @(posedge clk8f);
  in0  <=  ~in0;
  in1  <=  ~in1;
  write0 <= 0; // Do not write and you have nothing to read
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;
end


repeat(5) begin         // BC = 10 1111 00
  @(posedge clk8f); // write on FIFO 0
    in0  <=  1;
    in1  <=  1;
  @(posedge clk8f);
    write0 <= 1;
    read0 <= 0;
    write1 <= 0;
    read1 <= 0;

  @(posedge clk8f); // write on FIFO 0
    in0  <=  0;
    in1  <=  0;
  @(posedge clk8f);
    write0 <= 1;
    read0 <= 0;
    write1 <= 0;
    read1 <= 0;

  @(posedge clk8f); // read on FIFO 0 and write on fifo 1
    in0  <=  1;
    in1  <=  1;
  @(posedge clk8f);
    write0 <= 0;
    read0 <= 1;
    write1 <= 1;
    read1 <= 0;

  @(posedge clk8f); // read on FIFO 0 and write on fifo 1
    in0  <=  1;
    in1  <=  1;
  @(posedge clk8f);
    write0 <= 0;
    read0 <= 1;
    write1 <= 1;
    read1 <= 0;

  @(posedge clk8f); // Do nothing
    in0  <=  1;
    in1  <=  1;
  @(posedge clk8f);
    write0 <= 0;
    read0 <= 0;
    write1 <= 0;
    read1 <= 0;

  @(posedge clk8f); // nothing
    in0  <=  1;
    in1  <=  1;
  @(posedge clk8f);
    write0 <= 0;
    read0 <= 0;
    write1 <= 0;
    read1 <= 0;

  @(posedge clk8f); // write FIFO 0
    in0  <=  0;
    in1  <=  0;
  @(posedge clk8f);
    write0 <= 1;
    read0 <= 0;
    write1 <= 0;
    read1 <= 0;

  @(posedge clk8f); // read FIFO 0
    in0  <=  0;
    in1  <=  0;
  @(posedge clk8f);
    write0 <= 0;
    read0 <= 1;
    write1 <= 0;
    read1 <= 0;

end

///////////////////////////////////////////
  // AT THIS POINT YOU HAVE 5 BC> ACTIVE = 1 AND YOU RECEIVE A VALID WORD
 // ######     -> FF -> 11111111
 repeat(2) begin
 @(posedge clk8f); // write on FIFO 1
   in0  <=  1;
   in1  <=  1;
 @(posedge clk8f);
   write0 <= 0;
   read0 <= 0;
   write1 <= 1;
   read1 <= 0;

 @(posedge clk8f); // write on FIFO 1
   in0  <=  1;
   in1  <=  1;
 @(posedge clk8f);
   write0 <= 0;
   read0 <= 0;
   write1 <= 1;
   read1 <= 0;

 @(posedge clk8f); // write on fifo 0 and read on FIFO 1
   in0  <=  1;
   in1  <=  1;
 @(posedge clk8f);
   write0 <= 1;
   read0 <= 0;
   write1 <= 0;
   read1 <= 1;

 @(posedge clk8f); // write on fifo 0 and read on FIFO 1
   in0  <=  1;
   in1  <=  1;
 @(posedge clk8f);
   write0 <= 1;
   read0 <= 0;
   write1 <= 0;
   read1 <= 1;

 @(posedge clk8f); // Do nothing
   in0  <=  1;
   in1  <=  1;
 @(posedge clk8f);
   write0 <= 0;
   read0 <= 0;
   write1 <= 0;
   read1 <= 0;

 @(posedge clk8f); // Do nothing
   in0  <=  1;
   in1  <=  1;
 @(posedge clk8f);
   write0 <= 0;
   read0 <= 0;
   write1 <= 0;
   read1 <= 0;

 @(posedge clk8f); // write FIFO 1
   in0  <=  1;
   in1  <=  1;
 @(posedge clk8f);
   write0 <= 0;
   read0 <= 0;
   write1 <= 1;
   read1 <= 0;

 @(posedge clk8f); // read FIFO 1
   in0  <=  1;
   in1  <=  1;
 @(posedge clk8f);
   write0 <= 0;
   read0 <= 0;
   write1 <= 0;
   read1 <= 1;
end // FF -> 11111111
///////////////////////////////////////////
///////////////////////////////////////////
// #########  --> DD 11011101
repeat(2) begin
@(posedge clk8f); // write on FIFO 0
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 1;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // write on FIFO 0
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 1;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // read on FIFO 0 and write on fifo 1
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 1;
  write1 <= 1;
  read1 <= 0;

@(posedge clk8f); // read on FIFO 0 and write on fifo 1
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 1;
  write1 <= 1;
  read1 <= 0;

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write <= 0;
  read <= 1;

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // write FIFO 0
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 1;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // read FIFO 0
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 1;
  write1 <= 0;
  read1 <= 0;
end // ->  DD 11011101
///////////////////////////////////////////
///////////////////////////////////////////
// #### -> EE -> 11101110
repeat(2) begin
@(posedge clk8f); // write on FIFO 1
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 1;
  read1 <= 0;

@(posedge clk8f); // write on FIFO 1
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 1;
  read1 <= 0;

@(posedge clk8f); // write on fifo 0 and read on FIFO 1
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 1;
  read0 <= 0;
  write1 <= 0;
  read1 <= 1;

@(posedge clk8f);  // write on fifo 0 and read on FIFO 1
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 1;
  read0 <= 0;
  write1 <= 0;
  read1 <= 1;

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // write FIFO 1
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 1;
  read1 <= 0;

@(posedge clk8f); // read FIFO 1
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 0;
  read1 <= 1;
end // EE -> 11101110
///////////////////////////////////////////
///////////////////////////////////////////
//#### CC ->  11001100
repeat(2) begin
@(posedge clk8f); // write on FIFO 0
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 1;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // write on FIFO 0
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write <= 0;
  read <= 1;

@(posedge clk8f); // read on FIFO 0 and write on fifo 1
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 1;
  write1 <= 1;
  read1 <= 0;

@(posedge clk8f); // read on FIFO 0 and write on fifo 1
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 1;
  write1 <= 1;
  read1 <= 0;

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // write FIFO 0
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 1;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // read FIFO 0
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 1;
  write1 <= 0;
  read1 <= 0;
end // CC ->  11001100
///////////////////////////////////////////
///////////////////////////////////////////
//###### 99 -> 10011001
repeat(2) begin
@(posedge clk8f); // write on FIFO 1
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 1;
  read1 <= 0;


@(posedge clk8f); // write on FIFO 1
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 1;
  read1 <= 0;


@(posedge clk8f); // write on fifo 0 and read on FIFO 1
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 1;
  read0 <= 0;
  write1 <= 0;
  read1 <= 1;

@(posedge clk8f); // write on fifo 0 and read on FIFO 1
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 1;
  read0 <= 0;
  write1 <= 0;
  read1 <= 1;

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // Do nothing
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // write FIFO 1
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 1;
  read1 <= 0;

@(posedge clk8f); // read FIFO 1
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 0;
  read1 <= 1;
end // end 99 -> 10011001

// ### --> AA -> 10101010
repeat(2) begin
@(posedge clk8f); // write on FIFO 0
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 1;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // write on FIFO 0
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 1;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // read on FIFO 0 and write on fifo 1
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 1;
  write1 <= 1;
  read1 <= 0;

@(posedge clk8f); // read on FIFO 0 and write on fifo 1
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 1;
  write1 <= 1;
  read1 <= 0;

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // Do nothing
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // write FIFO 0
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 1;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // read FIFO 0
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 1;
  write1 <= 0;
  read1 <= 0;
end // end AA


//### 88 -> 10001000
repeat(2) begin
@(posedge clk8f); // write on FIFO 1
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 1;
  read1 <= 0;

@(posedge clk8f); // write on FIFO 1
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 1;
  read1 <= 0;

@(posedge clk8f); // write on fifo 0 and read on FIFO 1
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 1;
  read0 <= 0;
  write1 <= 0;
  read1 <= 1;

@(posedge clk8f); // write on fifo 0 and read on FIFO 1
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 1;
  read0 <= 0;
  write1 <= 0;
  read1 <= 1;

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // Do nothing
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 0;
  read1 <= 0;

@(posedge clk8f); // write FIFO 1
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 1;
  read1 <= 0;

@(posedge clk8f); // read FIFO 1
  in0  <=  0;
  in1  <=  0;
@(posedge clk8f);
  write0 <= 0;
  read0 <= 0;
  write1 <= 0;
  read1 <= 1;
end // end 88

  #40  $finish;
  end // end initial

  // clock logic
    initial	clkbase	 			<= 0;			// Initial value to avoid indeterminations
    always	#10 clkbase				<= ~clkbase;		// toggle every 10ns

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
// verilog-auto-wire-type:\"logic\"
// End:

`endif
