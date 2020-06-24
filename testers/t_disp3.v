// Assing --- Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr
//        &
// Fixes --- Brandon Esquivel Molina
// brandon.esquivel@ucr.ac.cr


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

  // Inputs
  input wire out0,
  input wire out1,
  //Syn
  input wire out0_s,
  input wire out1_s,

  input wire Error0_BTB, Error1_BTB,Error0_STB,Error1_STB

);

reg clkbase, clk4f, clk2f;


initial begin

  $dumpfile("disp3.vcd");
  $dumpvars;



in = 10'h0;
#4 reset = 0;
reset <= 0;

@(posedge clk);
#4 reset <= 1;

repeat (2) begin
@(posedge clk) begin
  in <= 10'h0FF;
end

@(posedge clk) begin
    in <= 10'h3DD;
	  end

@(posedge clk) begin
  in <= 10'h0EE;
end

@(posedge clk) begin
	in <= 10'h3CC;
end

@(posedge clk) begin
	in <= 10'h0BB;
end

@(posedge clk) begin
	in <= 10'h399;
end

@(posedge clk) begin
	in <= 10'h0AA;
end

@(posedge clk) begin
	in <= 10'h388;
end

@(posedge clk) begin
	in <= 10'h377;
end

end // end repeat
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
