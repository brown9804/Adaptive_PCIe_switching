// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr

`ifndef MEMORY_6x8
`define MEMORY_6x8


module memory6x8 #(
    parameter DATA_SIZE  = 8,
    parameter MAIN_SIZE = 6
)(
    //Inputs
    input wire clk,
    input wire  reset,
    input wire write,
    input wire read,
    input wire [MAIN_SIZE-1:0]  wr_ptr,
    input wire [MAIN_SIZE-1:0] rd_ptr,
    input wire [DATA_SIZE-1:0] data_in,
    // Outputs
    output reg [DATA_SIZE-1:0] data_out
);

// Memory declared
reg [DATA_SIZE-1:0] mem[MAIN_SIZE-1:0];
integer i;

reg [MAIN_SIZE-1:0] ff_mem;

// Writing
always @(posedge clk) begin
    if (~reset) begin
        for (i=0;i<MAIN_SIZE-1;i=i+1) begin
            {mem[i]} <= 'h0;
        end // end for
    end // end if
    else begin
        if (write) begin
            mem[wr_ptr] <= data_in;
        end // end if
    end // end else
end// end posedge clk

// Saved flops
always @(posedge clk) begin
    if (reset == 0) begin
        {ff_mem} <= 'h0;
    end // end if
    else begin
        ff_mem <= data_out;
    end
end // end always

// Reading
always @(*) begin
        if (read) begin
            data_out = mem[rd_ptr];
        end  // end read

        else begin
            data_out = ff_mem;
        end // end else
end

endmodule


// Local Variables:
// verilog-library-directories:("."):
// End:
`endif
