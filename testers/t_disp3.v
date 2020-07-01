//  Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr


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
	output reg valid,
	// Inputs
	input wire [MAIN_SIZE-1:0] out0,
	input wire [MAIN_SIZE-1:0] out1,
	//Syn
	input wire [MAIN_SIZE-1:0] out0_s,
	input wire [MAIN_SIZE-1:0] out1_s,

	input wire Error0_BTB, Error1_BTB,Error0_STB,Error1_STB

);

reg clkbase, clk4f, clk2f;


initial begin

	$dumpfile("disp3.vcd");
	$dumpvars;



in = 10'h0;
#4 reset = 0;
valid = 0;


repeat (6) begin
	@(posedge clk);
		reset = 0;
end


  // Begin test
  repeat (6) begin
  @(posedge clk);
  reset <= 0;
  end

  // Sent to FiFo #0
  @(posedge clk) begin
    in              <= 10'h0FF;
    reset <= 1;
    valid = 1;
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
  end

  // TESTING PUSH BLOCK 1
  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h299;
    
  end

  // Sent to FiFo #0
  @(posedge clk) begin
    in                     <= 10'h0AA;
  end

  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h288;
    
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
  end

  // TESTING PUSH BLOCK 1
  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h299;
    
  end

  // Sent to FiFo #0
  @(posedge clk) begin
    in                     <= 10'h0AA;
  end

  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h288;
    
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
  end

  // TESTING PUSH BLOCK 1
  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h299;
    
  end

  // Sent to FiFo #0
  @(posedge clk) begin
    in                     <= 10'h0AA;
  end

  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h288;
    
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
  end

  // TESTING PUSH BLOCK 1
  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h299;
    
  end

  // Sent to FiFo #0
  @(posedge clk) begin
    in                     <= 10'h0AA;
  end

  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h288;
    
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
