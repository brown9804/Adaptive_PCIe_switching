// FIFO 6x8
// Proyecto 2 Digitales II

`include "memory_6x8.v"
//`include "memory_synth.v"
// DATA_SIZE: Bits de los datos
// MAIN_SIZE: "Largo" o capacidad del fifo

module fifo_6x8 #(parameter DATA_SIZE = 8, parameter MAIN_SIZE = 6)(
    input                               clk,
    input                               reset,
    input                               read,
    input                               write,
    input       [DATA_SIZE-1:0]         data_in_push,            //dato de entrada / hará push al fifo
    input       [DATA_SIZE-1:0]         almost_full_in,    
    input       [DATA_SIZE-1:0]         almost_empty_in,
    output reg                          fifo_empty, 
    output reg [DATA_SIZE-1:0]          data_out_pop,           //datos de salida / al que se le hace pop
    output reg                          fifo_error,
    output reg                          fifo_pause
);


// Cables internos

wire [DATA_SIZE-1:0] data_out;		
reg fifo_full;
reg almost_full, almost_empty;
reg [DATA_SIZE-1:0]data_count; 		
reg [MAIN_SIZE-1:0]	rd_ptr;			
reg [MAIN_SIZE-1:0]	wr_ptr;			
reg datamod;

reg [DATA_SIZE-1:0] data_to_mem;
   
    memory_6x8 #(DATA_SIZE,MAIN_SIZE) mem(
		    // Outputs
		    .data_out		(data_out[DATA_SIZE-1:0]),
		    // Inputs
		    .clk		(clk),
		    .read		(read),
		    .write		(write),
		    .reset		(reset),
		    .data_in	(data_in_push),
		    .wr_ptr		(wr_ptr[MAIN_SIZE-1:0]),
		    .rd_ptr		(rd_ptr[MAIN_SIZE-1:0])
);

always@(*) begin
        fifo_empty = 0;
        fifo_full = 0;
        almost_full = 0;
        almost_empty = 0;
        datamod = 0;
        fifo_error = 0;
        fifo_pause=0;
        if ( ~reset ) begin
            fifo_empty = 1;
            fifo_full = 0;
            almost_full = 0;
            almost_empty = 0;
            fifo_pause=0;
            fifo_error=0;
        end 

 else begin

      // Condiciones para diferente estados del fifo: full, empty, casi lleno, casi vacío, error (escribir cuando está 
      // lleno o leer cuando está vacío)
            if ( data_count == 0 )begin
                fifo_empty = 1;
                fifo_pause = 0;
            end

            if( data_count ==( (2**MAIN_SIZE)) )begin            
                fifo_full = 1;
            end

            if( data_count >= almost_full_in )begin
                almost_full = 1;
                fifo_pause=1;
            end

            if( (data_count <= almost_empty_in) && (data_count!=0) )begin
                almost_empty = 1;
                fifo_pause=0;
            end
            
            if( write && fifo_full )begin
                fifo_error = 1;
            end

            if( read && fifo_empty )begin
                fifo_error = 1;
            end
        end

    end

    // Acción del fifo
     always@( posedge clk)begin
        if ( !reset ) begin
            data_count <= 'b0;
            data_out_pop <= 'b0;
            wr_ptr          <= 'b0;
            rd_ptr          <= 'b0;
            datamod         <= 'b0;
        end else begin

     if( !fifo_full && write )begin
                wr_ptr <= wr_ptr + 1;                   
                
                if ( !fifo_empty && read )begin
                    rd_ptr <= rd_ptr + 1;               
                    data_count <= data_count;
                end else begin
                    rd_ptr <= rd_ptr;
                    data_count <= data_count + 1;
                end
            end else if( !fifo_empty && read ) begin
                rd_ptr <= rd_ptr + 1;                 
                wr_ptr <= wr_ptr;                       
                data_count  <= data_count - 1;
                data_out_pop    <= data_out; 
            end else begin
                rd_ptr <= rd_ptr;                       
                wr_ptr <= wr_ptr;                       
                
                data_count  <= data_count;
            end
        end
    end

endmodule         