/////////////////////////////////                      .        .
//  Brandon Equivel             //                        .  .
//  brandon.esquivel@ucr.ac.cr   //////////.............//////    .
//                               //////////............../////                       .    .      .
////////////////////////////////                       .
      ///           ///
    ///               ///
  ///                   ///
////                    /////


// Implementation of a single Parameterizable FIFO

`ifndef FIFO_4x8
`define FIFO_4x8

// DATA_SIZE: data bus size in bits
// MAIN_SIZE: Fifo length or capacity

`include "./src/memory_4x8.v"

module fifo_4x8 #(parameter DATA_SIZE = 8, parameter MAIN_SIZE = 4)(

    // Outputs
    output reg  [DATA_SIZE-1:0]         data_out_pop,
    output reg                          almost_full,
    output reg                          almost_empty,
    output reg                          Fifo_full,
    output reg                          fifo_empty,
    output reg                          fifo_error,
    // Inputs
    input wire                          clk,
    input wire                          reset,
    input wire                          read,
    input wire                          write,
    input wire [DATA_SIZE-1:0]          data_in_push
);


    // Internal wires

    wire  [DATA_SIZE-1:0]       data_out;

    reg   [DATA_SIZE-1:0]       data_count;
    reg   [MAIN_SIZE-1:0]	    rd_ptr;
    reg   [MAIN_SIZE-1:0]	    wr_ptr;


    memory_4x8 #(.DATA_SIZE(DATA_SIZE), .MAIN_SIZE(MAIN_SIZE) )
        mem(
		    // Outputs
		    .data_out		(data_out),
		    // Inputs
		    .clk		    (clk),
		    .read		    (read),
		    .write		    (write),
		    .reset		    (reset),
		    .data_in	    (data_in_push),
		    .wr_ptr		    (wr_ptr),
		    .rd_ptr		    (rd_ptr)
        );

    always@(*) begin
        fifo_empty                  = 0;
        Fifo_full                   = 0;
        almost_full                 = 0;
        almost_empty                = 0;
        fifo_error                  = 0;
        if ( ~reset ) begin
            fifo_empty              = 1;
            Fifo_full               = 0;
            almost_full             = 0;
            almost_empty            = 0;
            fifo_error              = 0;
        end
        else begin
      // States and combinational logic of the fifos
            if ( data_count == 0 )begin
                fifo_empty = 1;
            end
            else begin
                if( (data_count <= (MAIN_SIZE/4) ) && (data_count != 0) ) begin
                    almost_empty = 1;
                end
                else begin
                    if( (data_count > (MAIN_SIZE/4) ) && (data_count < ((MAIN_SIZE/2)+(MAIN_SIZE/4) ) ) ) begin
                       almost_empty     = 0;
                       almost_full      = 0;
                    end
                    else begin
                        if( data_count >= ((MAIN_SIZE/2)+(MAIN_SIZE/4) )  && (data_count != (MAIN_SIZE))) begin
                            almost_full = 1;
                        end
                        else begin
                            if( data_count == ( (MAIN_SIZE) ) ) begin
                                Fifo_full = 1;
                            end
                        end
                    end
                end
            end

            if( (write && Fifo_full) | ( read && fifo_empty ) ) begin
                fifo_error = 1;
            end
        end // reset = 0
    end // always (*)

    // Logic for fifo action and memory interaction
    always@( posedge clk) begin
        if ( !reset ) begin
            data_count          <= 'b0;
            data_out_pop        <= 'b0;
            wr_ptr              <= 'b000;
            rd_ptr              <= 'b000;
        end
        else begin
            case( {write, Fifo_full} )
                {2'b10}:  begin
                    if ( wr_ptr == (MAIN_SIZE-1) ) begin
                        wr_ptr       <= 'b000;
                    end
                    else begin
                        wr_ptr       <=  wr_ptr + 1;
                    end

                    if(read && !fifo_empty)  begin
                        data_count      <= data_count;
                        data_out_pop    <= data_out;

                        if (rd_ptr == (MAIN_SIZE-1) ) begin
                            rd_ptr   <= 'b000;
                        end else begin
                          rd_ptr   <= rd_ptr + 1;
                        end

                    end else begin
                      data_count     <= data_count + 1;
                      data_out_pop   <= data_out_pop;
                      rd_ptr         <= rd_ptr;

                    end

                end
                default:  begin
                    wr_ptr           <=  wr_ptr;
                    if(read && !fifo_empty)  begin
                        data_count      <= data_count -1;
                        data_out_pop    <= data_out;

                        if (rd_ptr == (MAIN_SIZE-1) ) begin
                            rd_ptr   <= 'b000;
                        end else begin
                          rd_ptr   <= rd_ptr + 1;
                        end

                    end else begin
                      data_count     <= data_count;
                      data_out_pop   <= data_out_pop;
                      rd_ptr         <= rd_ptr;
                    end
                end
            endcase
        end
    end
endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
