
//////////////////////////////////////
// Brandon ESquivel Molina          //
// Tester for class.v               //
// brandon.esquivel@ucr.ac.cr       //
//                                  //
//////////////////////////////////////

`ifndef T_CLASS
`define T_CLASS

// only necessary signals
module t_class #(
    //Parameters
    parameter DATA_SIZE = 10,         
    parameter MAIN_SIZE = 8          
) (
    // OUTPUTS
    output reg  [DATA_SIZE-1:0]   in,
    output reg                    reset,
    output reg                    clk,
    output reg                    pop_0, 
    output reg                    pop_1,
    // INPUTS
    input wire  [DATA_SIZE-1:0]   out0,
    input wire  [DATA_SIZE-1:0]   out1,
    input wire  [DATA_SIZE-1:0]   out0_s,
    input wire  [DATA_SIZE-1:0]   out1_s,
    input wire                    Error,
    input wire                    Error_s,
    input wire                    fifo_empty0,
    input wire                    fifo_empty1,
    input wire                    fifo_empty0_s,
    input wire                    fifo_empty1_s
  );


initial begin

  $dumpfile("class.vcd");
  $dumpvars;


  // INITIAL VALUES
  in = 10'h0;
  pop_0  = 0;
  pop_1  = 0;
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

  // Sent to FiFo #0
  @(posedge clk) begin
    in              <= 10'h0FF;
    reset <= 1;
  end

  // Sent to FiFo #1
	@(posedge clk) begin
    in              <= 10'h2DD;
	end

  // Sent to FiFo #0
  @(posedge clk) begin
    in              <= 10'h0EE;

  end

  // Sent to FiFo #1
  @(posedge clk) begin
	  in              <= 10'h2CC;
  end

  // TESTING PUSH BLOCK 0
  @(posedge clk) begin
	  in                     <= 10'h1BB;
    pop_0    <= 1;
  end

  // TESTING PUSH BLOCK 1
  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h299;
    pop_1    <= 1; 
  end

  // Sent to FiFo #0
  @(posedge clk) begin
    in                     <= 10'h0AA;
  end

  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h288;
    pop_0    <= 0;
    pop_1    <= 0;
  end

  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h1A7;
  end

  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h277;
  end
  @(posedge clk) begin
	  in                     <= 10'h1AA;
  end
  @(posedge clk) begin
	  in                     <= 10'h2CC;
  end

  #40 $finish;
end

// clock logic
initial	clk	 		    	<= 0;			  // Initial value to avoid indeterminations
always	#10 clk				<= ~clk;		// toggle every 10ns

endmodule


// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
