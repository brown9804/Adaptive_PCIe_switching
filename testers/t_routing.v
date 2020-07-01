
//////////////////////////////////////
// Brandon ESquivel Molina          //
// Tester for routering.v           //
// brandon.esquivel@ucr.ac.cr       //
// JUne, 2020                       //
//////////////////////////////////////

`ifndef T_ROUTING
`define T_ROUTING

module t_route ( // Outputs
input wire [7:0]                out0,   
input wire [7:0]                out1,      
input wire                      Error,
input wire                      pop_0,
input wire                      pop_1,
input wire                      fifo0_almost_empty, 
input wire                      fifo1_almost_empty,


input wire [7:0]                out0_s,   
input wire [7:0]                out1_s,      
input wire                      Error_s,
input wire                      pop_0_s,
input wire                      pop_1_s,
input wire                      fifo0_almost_empty_s, 
input wire                      fifo1_almost_empty_s,
// outputs
output reg [9:0]                in0,
output reg [9:0]                in1,
output reg                      clk,
output reg                      reset,
output reg                      pop_0_in, 
output reg                      pop_1_in,
output reg                      fifo_empty0,
output reg                      fifo_empty1  
);


initial begin
  $dumpfile("routing.vcd");
  $dumpvars;

  //Initials
  in0                      = 10'h0;               
  in1                      = 10'h0;                             
  #4 reset                 = 0;                 
  pop_0_in                 = 0;                     
  pop_1_in                 = 0;                     
  fifo_empty0              = 0;                       
  fifo_empty1              = 0;
	
	// Begin test
	repeat (6) begin
	@(posedge clk);
	reset               <= 0;
	end

	@(posedge clk) begin
	#4 reset            <= 1;
	end

	@(posedge clk) begin
	in0                 <= 10'h3FF;
	in1                 <= 10'h1DD;
	end


	@(posedge clk) begin
	in0                 <= 10'h3EF;
	in1                 <= 10'h2CC;
	end

	@(posedge clk) begin
	  in0               <= 10'h0EE;
	  in1               <= 10'h0CC;
	  fifo_empty0         <= 1;
	end

	
	@(posedge clk) begin
	in0 <= 10'h0BB;
	in1 <= 10'h099;
	end


	@(posedge clk) begin
	in0 <= 10'h2BA;
	in1 <= 10'h399;
	end


	@(posedge clk) begin
	in0 <= 10'h2BA;
	in1 <= 10'h399;
  
	end



	@(posedge clk) begin
	in0             <= 10'h2BA;
	in1             <= 10'h3CC;
  fifo_empty0     <= 0;
  fifo_empty1     <= 1;

	end


  @(posedge clk) begin
	  in0               <= 10'h0EE;
	  in1               <= 10'h0CC;
	  pop_0_in          <= 1;
    pop_1_in          <= 1;
	end


	repeat(2) begin
	  @(posedge clk) begin
	    in0 <= 10'h0AA;
	    in1 <= 10'h088;
	    fifo_empty0 <= 0;
	    fifo_empty1 <= 1;
	  end
	end

	
	repeat(2) begin
	  @(posedge clk) begin
	    in0 <= 10'h077;
	    in1 <= 10'h066;
	    fifo_empty0 <= 1;
	    fifo_empty1 <= 1;
	  end
	end

	repeat(2) begin
	  @(posedge clk) begin
	    in0 <= 10'h077;
	    in1 <= 10'h066;
	    fifo_empty0 <= 1;
	    fifo_empty1 <= 1;
	  end
	end

  @(posedge clk) begin
  pop_0_in        <= 0;
  end

  @(posedge clk) begin
  pop_0_in        <= 0;
  end
  
  @(posedge clk) begin
  pop_1_in       <= 0;
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
