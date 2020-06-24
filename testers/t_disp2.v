// Tester Dispositivo 2
// Proyecto 2
// Circuitos Digitales II

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
    
    // AUXILIARES
    reg clk16f;
    reg clk32f;
    reg clk2f;
    reg clk1f;
    reg clk4f;
    
    initial begin
		$dumpfile("disp2.vcd");																						// "dump" file
	$dumpvars;
	
      repeat (6) begin
		@(posedge clk);	
		reset = 0;
		end		

		repeat (6) begin																							
		@(posedge clk);																																								 	
		reset = 1;
		end

        @(posedge clk);

        // pruebas 

        repeat(3) begin         // 01010101  -> NO HAY ACTIVE YA QUE BC < 4
        @(posedge clk);
        in1  <=  ~in1;
        in2  <=  ~in2;
        end


        repeat(5) begin         // BC = 10 1111 00        
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        end
    // Para controlar fifo
        @(posedge clk8f);
        write <= 1;
        read <= 0;
        @(posedge clk8f);
        write <= 0;
        read <= 1;
        @(posedge clk8f);
        write <= 1;
        read <= 0;
        @(posedge clk8f);
        write <= 0;
        read <= 1;
        @(posedge clk8f);
        write <= 1;
        read <= 0;
        @(posedge clk8f);
        write <= 0;
        read <= 1;
        @(posedge clk8f);
        write <= 1;
        read <= 0;
        @(posedge clk8f);
        write <= 0;
        read <= 1;
        @(posedge clk8f);
        write <= 1;
        read <= 0;
        @(posedge clk8f);
        write <= 0;
        read <= 1;
        @(posedge clk8f);
        write <= 1;
        read <= 0;
        @(posedge clk8f);
        write <= 0;
        read <= 1;


        
        // EN ESTE PUNTO SE TIENEN 5 BC > ACTIVE = 1 Y SE RECIBE UNA PALABRA valida
        
             // Nueva palabra a enviar  -> FF -> 11111111
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;

        // nueva palabra DD 11011101
        
         @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;



         // Nueva palabra a enviar  -> EE -> 11101110
      @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        
        // nueva palabra CC ->  11001100
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;

        // NUEVA PALABRA BB -> 10111011 

        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;

        // NUEVA PALABRA 99 -> 10011001
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;

        // NUEVA PALABRA 10101010 -> AA 
            
@(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;

        // Nueva palabra a enviar  -88 -> 10001000
      @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
        in1  <=  1;
        in2  <=  1;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;
        @(posedge clk);
       in1  <=  0;
       in2  <=  0;
        @(posedge clk);
        in1  <=  0;
        in2  <=  0;

         repeat(8) begin         
        @(posedge clk);
         end
       

        $finish;
    end


	// Initial Values
	initial in1			= 0;
    initial in2			= 0;	
	initial reset 		= 0;

	// clock logic
	initial	clk	 	    = 0;			// Initial value to avoid indeterminations
	always	#5 clk	    = ~clk;		// toggle every 1ns

	// clks 

	initial clk32f <= 0;
    initial clk16f <= 0;
    initial clk8f <= 0;
    initial clk4f <= 0;
    initial clk2f <= 0;
    initial clk1f <= 0;

	

	// checker
//reg test;

//always@(posedge clk) begin
  //  if(outc != outs)
  //  begin
  //     test <= 0;
  //   end // end display

  //   else begin
  //      test <= 1;
  //    end //else
//end // always checker



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
    // At 2 Hz
    always @(posedge clk4f) begin
        clk2f <= ~clk2f; // if was LOW change to HIGH
        end

    //////////////////////////////
    // At 1 HZ
    always @(posedge clk2f) begin
    clk1f <= ~clk1f; // if was LOW change to HIGH
 	end

endmodule // t_mux42
