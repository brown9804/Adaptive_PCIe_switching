// Tester serialización
// Michelle Gutiérrez - Proyecto 2
// Circuitos Digitales II



module paratoserial_tester (

output reg [7:0] in0,
output reg [7:0] in1,
output reg clk8f,
output reg reset,

output reg fifo_empty0, 
output reg fifo_empty1,
output reg fifo_up0_almostfull,
output reg fifo_up1_almostfull,

input wire out0,
input wire out1,

input wire out0_s,
input wire out1_s
);

reg clk,  clk16f, clk32f, clk4f, clk2f, clk1f;


initial begin
		$dumpfile("paratoserial.vcd");	
		$dumpvars;			
	    	
	reset 		= 0;
	fifo_empty0 = 0;
	fifo_empty1 = 0;
	fifo_up0_almostfull = 0;
	fifo_up1_almostfull = 0;
		 

		repeat (2) begin			// checking reset
		@(posedge clk1f);
		in0 <= 'hFF;
        in1 <= 'hFF;		
		#4 reset <= 0;
		 
		end
		
		@(posedge clk1f);
		#10 reset <= 1;

		repeat (4) begin			// insert BC 10111100 x4 because Valid = 0	
       		 @(posedge clk1f);	
			in0 <= 8'hFF;
            in1 <= 8'hFF;
		end
	

		@(posedge clk1f);	
		    in0 <= 8'hAA;
	        in1 <= 8'hAA;
	

        	repeat (2) begin			// 1110 1110
		@(posedge clk1f);	
		    in0 <= 8'hEE;
            in1 <= 8'hEE;
	
		end
    
		@(posedge clk1f);	
		    in0 <= 8'hCC;
		    in1 <= 8'hCC;	
		

		@(posedge clk1f);	
		    in0 <= 8'hBB;	
            in1 <= 8'hBB;			
        


        repeat (2) begin			// 1110 1110
		@(posedge clk1f);	
		    in0 <= 8'hEE;
            in1 <= 8'hAA;
	
		end
    
		@(posedge clk1f);	
		    in0 <= 8'hCC;
		    in1 <= 8'hFF;
		

		@(posedge clk1f);	
		    in0 <= 8'hBB;	
            in1 <= 8'hEE;		

			repeat (2) begin			// 1110 1110
		@(posedge clk1f);	
		    in0 <= 8'hEE;
            in1 <= 8'hAA;
		
    
		@(posedge clk1f);	
		    in0 <= 8'hCC;
		    in1 <= 8'hFF;
			fifo_empty0 <= 1;
			fifo_empty1 <= 1;
	
		

		@(posedge clk1f);	
		    in0 <= 8'hBB;	
            in1 <= 8'hEE;	
		
	    
		@(posedge clk1f);	
		    in0 <= 8'hCC;
		    in1 <= 8'hFF;

		end

		@(posedge clk1f) begin
		    in0 <= 8'hCC;
		    in1 <= 8'hFF;
			fifo_empty0 <= 0;
			fifo_empty1 <= 0;
		end
		

		@(posedge clk1f) begin
		    in0 <= 8'hBB;	
            in1 <= 8'hEE;	
		
		end
		@(posedge clk1f) begin	
		    in0 <= 8'hCC;
		    in1 <= 8'hFF;

		end
		
		@(posedge clk1f) begin
		    in0 <= 8'hCC;
		    in1 <= 8'hFF;
			fifo_up0_almostfull <= 1;
			fifo_up1_almostfull <= 1;
		end

		@(posedge clk1f) begin
		    in0 <= 8'hBB;	
            in1 <= 8'hEE;
		end

		@(posedge clk1f) begin
		    in0 <= 8'hBB;	
            in1 <= 8'hEE;	
		end
	    
		@(posedge clk1f) begin
		    in0 <= 8'hCC;
		    in1 <= 8'hFF;

		end
		$finish;		
	end

// clks 
		
	initial clk32f <= 0;
    initial clk16f <= 0;
    initial clk8f <= 0;
    initial clk4f <= 0;
    initial clk2f <= 0;
    initial clk1f <= 0;
    


    // Faster frequency
    always @(posedge clk) begin
		clk32f <= ~clk32f; // if was LOW change to HIGH
        end 
    //////////////////////////////
    // For 16 Hz
    always @(posedge clk32f) begin
        clk16f <= ~clk16f; // if was LOW change to HIGH
        end
    //////////////////////////////
    // For 8 Hz
    always @(posedge clk16f) begin
            clk8f <= ~clk8f; // if was LOW change to HIGH
    end
    //////////////////////////////
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
        clk1f <= ~clk1f; // if was LOW change to HIGH
        end
   

  
	 // clock logic
	
	initial	clk	 				<= 0;			// Initial value to avoid indeterminations
	always	#5 	clk			    <= ~clk;		// toggle every 5ns
	

endmodule
