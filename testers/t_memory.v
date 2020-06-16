// Memoria tester
// Proyecto 2 Digitales II
//`include "memory.v"
//`include "memory_synth.v"
//`include "cmos_cells.lib"
//`include "cmos_cells.v"

module memory_tester #( parameter MAIN_SIZE=8, parameter DATA_SIZE = 10)(
	output reg  clk, 
    output reg	read,         
    output reg  write,      
	output reg  reset,
	output reg [MAIN_SIZE-1:0] wr_ptr,
	output reg [MAIN_SIZE-1:0] rd_ptr,
	output reg [DATA_SIZE-1:0] data_in,
	input  [DATA_SIZE-1:0] data_out,
// Para el sintetizado
    input [DATA_SIZE-1:0] data_out_s
);

 initial begin

    $dumpfile("memory_con_sin.vcd");       
    $dumpvars;
    data_in = 'b0;
    wr_ptr  = 'b0;					
    rd_ptr  = 'b0;                    
    reset = 'b0;                            
    read = 'b0;
    write = 'b0;

  
    @(posedge clk)
    reset <= 1;     
    write <= 1;
    
    repeat(30)begin
        @(posedge clk)
        data_in <= data_in + 1;
        wr_ptr <= wr_ptr + 1;
    end
        # 25;

        @(posedge clk)
        read <= 1;

    repeat(30)begin
        @(posedge clk)
        data_in <= data_in + 1;
        rd_ptr <= rd_ptr + 1;
        wr_ptr <= wr_ptr + 1;
    end
        

    # 18;
    @(posedge clk)
    data_in   <= data_in + 1;
    write     <= 0;

    repeat(16)begin  
        @(posedge clk)
        data_in   <= data_in + 1;
        rd_ptr <= rd_ptr + 1;
    end

    @(posedge clk)
    reset <= 0;
    #20

    $finish;
end
    initial clk <= 0;
    always # 2 clk <= ~clk;    

endmodule
