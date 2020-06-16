// FIFO tester
// Proyecto 2 Digitales II

`include "fifo_synth.v"
`include "fifo.v"

module fifo_tester #(
    //Parametros
    parameter DATA_SIZE = 10,         
    parameter MAIN_SIZE=8          
)(
    input wire fifo_empty,        
    input wire [DATA_SIZE-1:0] data_out_pop,    
    input wire fifo_error,
    input wire fifo_pause,
    output reg clk,
    output reg reset,
    output reg read,
    output reg write,
    output reg [DATA_SIZE-1:0] data_in_push,           
    output reg [DATA_SIZE-1:0] almost_full_in,   
    output reg [DATA_SIZE-1:0] almost_empty_in,
    // Para sintetizado
    input wire fifo_empty_s,        
    input wire [DATA_SIZE-1:0] data_out_pop_s,    
    input wire fifo_error_s,
    input wire fifo_pause_s
);
 

 initial begin

    $dumpfile("fifo_c_s.vcd");        
    $dumpvars;
    write ='b0;
    read ='b0;
    data_in_push ='b0;
    almost_empty_in = 'h3;
    almost_full_in ='h6;

    reset = 'b0;                             
    read  = 'b0;
    write = 'b0;

    #4;
    @(posedge clk)
    reset <= 	'b1;
    data_in_push <= 'h3;
    
    repeat(6)begin
        @(posedge clk)
        data_in_push <= data_in_push+1;
    end

    
    @(posedge clk)
    data_in_push <= data_in_push+1;
    repeat(12)begin
        @(posedge clk)
        write <= 1;     
        data_in_push <= data_in_push + 1;
        
    end

    
    @(posedge clk)
        write<=0;
        // read <= 1;
        

    repeat(2)begin
        @(posedge clk)
        //mandar direcciones random a wr_ptr
        read <= 1;
    end
        
    repeat(2)begin
        @(posedge clk)
            write<=0;
            read <= 0;
    end

    repeat(4)begin
        @(posedge clk)
            //mandar direcciones random a wr_ptr
            read<=0; 
    end

    repeat(7)begin
        @(posedge clk)
            read <= 1;
    end
    @(posedge clk)
        read <= 1;

    // @(posedge clk)
    //     //mandar direcciones random a wr_ptr
    //     read<=1;

    repeat(4)begin
        @(posedge clk)
        read<=1;
        write <= 0;
        // data_in_push<='h4;
    end

    $finish;
end
    initial clk <= 0;
    always # 2 clk <= ~clk;       //genera señal 4 ns 

endmodule