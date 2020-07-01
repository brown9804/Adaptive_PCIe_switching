// Belinda Brown Ramírez
// timna.brown@ucr.ac.cr
// ft. Brandon Esquivel
// brandon.esquivel@ucr.ac.cr
// reviewed and tested version 2.0
// June, 2020

`ifndef MEMORY
`define MEMORY


module memory #(
    parameter DATA_SIZE  = 10,
    parameter MAIN_SIZE = 8
)(
    // Outputs
    output reg [DATA_SIZE-1:0] data_out,
     //Inputs
    input wire clk,
    input wire reset,
    input wire write,
    input wire read,
    input wire [MAIN_SIZE-1:0]  wr_ptr,
    input wire [MAIN_SIZE-1:0]  rd_ptr,
    input wire [DATA_SIZE-1:0]  data_in
);
    
    // Memory declared
    reg [DATA_SIZE-1:0] mem [MAIN_SIZE-1:0];
    integer i;
    reg [DATA_SIZE-1:0] ff_mem;

    // Writing
    always @(posedge clk) begin
        if (~reset) begin
            for (i = 0; i < (MAIN_SIZE); i = i+1 ) begin
                {mem[i]} <= 'h0;
            end // end for
        end // end if
        else begin
            if (write) begin
                mem[wr_ptr] <= data_in;
            end // end if
        end // end else
    end// end posedge clk

   

    // Reading -- EXtra FF adds 1 clk cycle 
    always @(*) begin
            if (read) begin
                data_out = mem[rd_ptr];
            end  // end read

            else begin
                data_out = ff_mem;
            end // end else
    end


     // Saved flops
    always @(posedge clk) begin
        if (!reset) begin
            {ff_mem} <= 'h0;
        end // end if
        else begin
            ff_mem <= data_out;
        end
    end // end always

endmodule


// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
