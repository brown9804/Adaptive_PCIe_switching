// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef T_DEMUX12
`define T_DEMUX12


module t_demux1x2 #(
  parameter DATA_SIZE = 10) 
  (
  // Outputs
  output reg [DATA_SIZE-1:0]      in,
  output reg                      reset,
  output reg                      clk,
  output reg                      classif,
  output reg                      fifo_up0_almostfull,
  output reg                      fifo_up1_almostfull,
  // Inputs
  input wire                      push_0,
  input wire                      push_0_s,
  input wire                      push_1,
  input wire                      push_1_s,
  input wire [DATA_SIZE-1:0]      out0,
  input wire [DATA_SIZE-1:0]      out0_s,
  input wire [DATA_SIZE-1:0]      out1,
  input wire [DATA_SIZE-1:0]      out1_s
  );



initial begin
  // Defining the dumpfile NAME_OF_FILE_CHOICE_PERSONAL.vcd), or known by change dump variable, this file contains
  // information about the simulator used, time scale, creation date, variable definitions, and value changes.
  $dumpfile("demux12.vcd");
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

  // INITIAL VALUES
  in = 10'h0;
  classif = 0;
  fifo_up0_almostfull  = 0;
  fifo_up1_almostfull  = 0;
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

  // Sent to FiFo #0
  @(posedge clk) begin
    classif         <= 0;
    in              <= 10'h0FF;
  end

  // Sent to FiFo #1
	@(posedge clk) begin
    classif         <= 1;
    in              <= 10'h1DD;
	end

  // Sent to FiFo #0
  @(posedge clk) begin
    classif         <= 0;
    in              <= 10'h0EE;

  end

  // Sent to FiFo #1
  @(posedge clk) begin
    classif         <= 1;
	  in              <= 10'h1CC;
  end

  // TESTING PUSH BLOCK 0
  @(posedge clk) begin
    classif                <= 0;
	  in                     <= 10'h0BB;
    fifo_up0_almostfull    <= 1; 
  end

  // TESTING PUSH BLOCK 1
  // Sent to FiFo #1
  @(posedge clk) begin
    classif                <= 1;
	  in                     <= 10'h199;
    fifo_up1_almostfull    <= 1; 
  end

  // Sent to FiFo #0
  @(posedge clk) begin
    classif                <= 0;
	  in                     <= 10'h0AA;
  end

  // Sent to FiFo #1
  @(posedge clk) begin
    classif                <= 1;
	  in                     <= 10'h188;
    fifo_up0_almostfull    <= 0;
    fifo_up1_almostfull    <= 0;
  end

  // Sent to FiFo #1
  @(posedge clk) begin
    classif                <= 1;
	  in                     <= 10'h1A7;
  end

  // Sent to FiFo #1
  @(posedge clk) begin
    classif                <= 1;
	  in                     <= 10'h177;
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
