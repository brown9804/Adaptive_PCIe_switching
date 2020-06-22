// Tester serialización
// Michelle Gutiérrez - Proyecto 2
// Circuitos Digitales II



module paratoserial_tester (

output reg [7:0] in0,
output reg [7:0] in1,
output reg clk,
output reg clk8f,
output reg valid_0,
output reg valid_1,
output reg reset,
input wire out0,
input wire out1,
// Para sintetizado 
input wire out0_s,
input wire out1_s
);

reg  clk16f, clk32f, clk4f;


initial begin
		$dumpfile("patatoserial.vcd");	
		$dumpvars;			
	    	
		 valid_0 = 0;
		 valid_1 <= 0;
         reset <= 0;

		repeat (2) begin			
		@(posedge clk8f);
		in0 <= 'hFF;	
        in1 <= 'hFF;		
		#4 reset <= 0;
		 
		end
		
		@(posedge clk8f);
		#10 reset <= 1;

		repeat (4) begin		
       		 @(posedge clk8f);	
			in0 <= 8'hFF;
            in1 <= 8'hFF;
            valid_0 <= 0;
            valid_1 <= 1;
		end
	

		@(posedge clk8f);	
		    in0 <= 8'hAA;
            in1 <= 8'hAA;
			valid_0 <= 1;
            valid_1 <= 0;	
	

        	repeat (5) begin			
		@(posedge clk8f);	
		    in0 <= 8'hBC;
            in1 <= 8'hEE;
	        valid_0 <= 1;
            valid_1 <= 1;
		end
    
		@(posedge clk8f);	
		    in0 <= 8'hBB;
            in1 <= 8'hCC;
			valid_0 <= 1;
            valid_1 <= 1;	
		

		@(posedge clk8f);	
		   in0 <= 8'hCC;
           in1 <= 8'hBB;	
		   valid_0 <= 1;
           valid_1 <= 1;	

        repeat (5) begin			
		@(posedge clk8f);	
		    in0 <= 8'hEE;
            in1 <= 8'hEE;
            valid_0 <= 0;
            valid_1 <= 0;
	
		end		
        		
		$finish;		
	end

    // clks 

	initial clk32f <= 0;
    initial clk16f <= 0;
    initial clk8f <= 0;
    initial clk4f <= 0;
    


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
   



	 // clock logic
	
	initial	clk	 				<= 0;			// Initial value to avoid indeterminations
	always	#5 	clk			<= ~clk;		// toggle every 2ns
	

endmodule
