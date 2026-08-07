`timescale 1ns / 1ps

module dmem #(
    parameter MEM_SIZE_WORDS = 256
) (
    input  wire        clk,
    input  wire [31:0] addr,
    input  wire [31:0] write_data,
    input  wire        mem_write,
    output wire [31:0] read_data
);

    reg [31:0] mem [0:MEM_SIZE_WORDS-1];
    localparam ADDR_WIDTH = $clog2(MEM_SIZE_WORDS);

    integer i;
    initial begin
        for (i = 0; i < MEM_SIZE_WORDS; i = i + 1) begin
            mem[i] = 32'b0;
        end
    end

    wire [ADDR_WIDTH-1:0] word_addr = addr[ADDR_WIDTH+1:2];

    always @(posedge clk) begin
        if (mem_write)
            mem[word_addr] <= write_data;
    end

    assign read_data = mem[word_addr]; // combinational read, same as imem/regfile

endmodule