`timescale 1ns / 1ps

module imem #(
    parameter MEM_SIZE_WORDS = 256,
    parameter MEM_INIT_FILE  = ""   // set to a .hex path to preload via $readmemh
) (
    input  wire [31:0] addr,
    output wire [31:0] instr
);

    reg [31:0] mem [0:MEM_SIZE_WORDS-1];
    localparam ADDR_WIDTH = $clog2(MEM_SIZE_WORDS);

    integer i;
    initial begin
        for (i = 0; i < MEM_SIZE_WORDS; i = i + 1) begin
            mem[i] = 32'b0;
        end
        if (MEM_INIT_FILE != "") begin
            $readmemh(MEM_INIT_FILE, mem);
        end
    end

    assign instr = mem[addr[ADDR_WIDTH+1:2]];

endmodule