// FIFO 6x8 tester
// Proyecto 2 Digitales II

//`include "fifo_synth.v"
//`include "fifo.v"

module fifo_tester #(
    //Parametros
    parameter DATA_SIZE = 8,         
    parameter MAIN_SIZE=6          
)(
    input wire fifo_empty,        
    input wire [DATA_SIZE-1:0] data_out_pop,    
    input wire fifo_error,
    input wire fifo_pause,
    input wire  almost_full,   
    input wire  almost_empty,
    output reg clk,
    output reg reset,
    output reg read,
    output reg write,
    output reg [DATA_SIZE-1:0] data_in_push,           
    // Para sintetizado
    input wire fifo_syn_empty,        
    input wire [DATA_SIZE-1:0] data_out_pop_s,    
    input wire fifo_syn_error,
    input wire fifo_syn_pause,
    input wire  almost_full_s,   
    input wire almost_empty_s
);
 

 initial begin

    $dumpfile("fifo_6x8_c_s.vcd");        
    $dumpvars;
    write ='b0;
    read ='b0;
    data_in_push ='b0;
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
