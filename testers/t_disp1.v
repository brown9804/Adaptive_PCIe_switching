// Brandon Esquivel Molina
// Tester for Device1 
// brandon.esquivel@ucr.ac.cr

`ifndef T_DISP1
`define T_DISP1

module t_device1 (
  // OUTPUTS
  output reg [9:0]  in,                       
  output reg clk,                             
  output reg clk8f,                           
  output reg reset,                           
  //output reg pop_0,                           
  //output reg pop_1,                           
  output reg fifo0_disp2_almostfull,          
  output reg fifo1_disp2_almostfull,          
  // STRUCT
  input wire out0_s,                          
  input wire out1_s,                          
  input wire Error_class_s,                   
  input wire Error_route_s,                   
  // behavorial
  input wire out0,                            
  input wire out1,                            
  input wire Error_class,                     
  input wire Error_route                                                      

);

reg clkbase, clk4f, clk2f;


initial begin

  $dumpfile("disp1.vcd");
  $dumpvars;

// INITIAL VALUES
  in = 10'h0;
  #4 reset = 0;
  fifo0_disp2_almostfull = 0;
  fifo1_disp2_almostfull = 0;

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
  end

  // TESTING PUSH BLOCK 1
  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h299;
    fifo0_disp2_almostfull <= 1;
  end

  // Sent to FiFo #0
  @(posedge clk) begin
    in                     <= 10'h0AA;
  end

  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h288;
    fifo0_disp2_almostfull <= 0;
  end

  // Sent to FiFo #1
  @(posedge clk) begin
	  in                     <= 10'h1A7;

    fifo1_disp2_almostfull <= 1;
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
// End:
`endif
