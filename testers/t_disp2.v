// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

//        &

// Brandon Esquivel Molina
// brandon.esquivel@ucr.ac.cr


`ifndef T_DISP2
`define T_DISP2

module disp2_tester (

output reg in1,
output reg in2,
output reg reset,
output reg clk,
output reg clk8f,
output reg read,
output reg write,

input [7:0] out1,
input [7:0] out2,
input almost_full_f1,
input almost_full_f2

);

reg clkbase, clk4f, clk2f;

initial begin
  $dumpfile("disp2.vcd");		// "dump" file
  $dumpvars;

  in1 = 0;
  in2 = 0;
  #4 reset = 0;
  clk = 0;
  clk8f = 0;
  read = 0;
  write = 0;


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
  in1  <=  ~in1;
  in2  <=  ~in2;
end


repeat(5) begin         // BC = 10 1111 00
  @(posedge clk8f); // write
    in1  <=  1;
    in2  <=  1;
  @(posedge clk);
    write <= 1;
    read <= 0;

  @(posedge clk8f); // read
    in1  <=  0;
    in2  <=  0;
  @(posedge clk);
    write <= 0;
    read <= 1;

  @(posedge clk8f); // write
    in1  <=  1;
    in2  <=  1;
  @(posedge clk);
    write <= 1;
    read <= 0;

  @(posedge clk8f); // write
    in1  <=  1;
    in2  <=  1;
  @(posedge clk);
    write <= 1;
    read <= 0;

  @(posedge clk8f); // read
    in1  <=  1;
    in2  <=  1;
  @(posedge clk);
    write <= 0;
    read <= 1;

  @(posedge clk8f); // read
    in1  <=  1;
    in2  <=  1;
  @(posedge clk);
    write <= 0;
    read <= 1;

  @(posedge clk8f); // write
    in1  <=  0;
    in2  <=  0;
  @(posedge clk);
    write <= 1;
    read <= 0;

  @(posedge clk8f); // read
    in1  <=  0;
    in2  <=  0;
  @(posedge clk);
    write <= 0;
    read <= 1;

end


  // AT THIS POINT YOU HAVE 5 BC> ACTIVE = 1 AND YOU RECEIVE A VALID WORD

 // ######     -> FF -> 11111111
 repeat(2) begin
 @(posedge clk8f); // write
   in1  <=  1;
   in2  <=  1;
 @(posedge clk);
   write <= 1;
   read <= 0;

 @(posedge clk8f); // read
   in1  <=  1;
   in2  <=  1;
 @(posedge clk);
   write <= 0;
   read <= 1;

 @(posedge clk8f); // write
   in1  <=  1;
   in2  <=  1;
 @(posedge clk);
   write <= 1;
   read <= 0;

 @(posedge clk8f); // write
   in1  <=  1;
   in2  <=  1;
 @(posedge clk);
   write <= 1;
   read <= 0;

 @(posedge clk8f); // read
   in1  <=  1;
   in2  <=  1;
 @(posedge clk);
   write <= 0;
   read <= 1;

 @(posedge clk8f); // read
   in1  <=  1;
   in2  <=  1;
 @(posedge clk);
   write <= 0;
   read <= 1;

 @(posedge clk8f); // write
   in1  <=  1;
   in2  <=  1;
 @(posedge clk);
   write <= 1;
   read <= 0;

 @(posedge clk8f); // read
   in1  <=  1;
   in2  <=  1;
 @(posedge clk);
   write <= 0;
   read <= 1;
end // FF -> 11111111

// #########  --> DD 11011101
repeat(2) begin
@(posedge clk8f); // write
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // write
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // write
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // read
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // write
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 0;
  read <= 1;
end // ->  DD 11011101

// #### -> EE -> 11101110
repeat(2) begin
@(posedge clk8f); // write
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // write
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // write
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // read
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // write
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 0;
  read <= 1;
end // FF ->  EE -> 11101110

//#### CC ->  11001100
repeat(2) begin
@(posedge clk8f); // write
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // write
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // write
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // read
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // write
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 0;
  read <= 1;
end // CC ->  11001100

//###### 99 -> 10011001
repeat(2) begin
@(posedge clk8f); // write // 1
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read // 0
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // write // 0
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // write // 1
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read // 1
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // read // 0
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // write
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 0;
  read <= 1;
end // end 99 -> 10011001

// ### --> AA -> 10101010
repeat(2) begin
@(posedge clk8f); // write
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // write
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // write
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // read
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // write
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 0;
  read <= 1;
end // end AA


//### 88 -> 10001000
repeat(2) begin
@(posedge clk8f); // write
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // write
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // write
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  1;
  in2  <=  1;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // read
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 0;
  read <= 1;

@(posedge clk8f); // write
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 1;
  read <= 0;

@(posedge clk8f); // read
  in1  <=  0;
  in2  <=  0;
@(posedge clk);
  write <= 0;
  read <= 1;
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
