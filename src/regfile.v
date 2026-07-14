`timescale 1ns / 1ps

module regfile (
    input wire clk,
    input wire rst,
    input wire [4:0] rs1_addr,
    input wire [4:0] rs2_addr,
    input wire [4:0] rd_addr,
    input wire [31:0] rd_data,
    input wire reg_write,
    output reg [31:0] rs1_data,
    output reg [31:0] rs2_data
);

    // Register file: 32 registers of 32 bits each
    reg [31:0] registers [31:0];

    // Initialize registers to zero on reset
    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else if (reg_write && rd_addr != 5'b00000) begin
            // Write to the register file on the rising edge of the clock
            registers[rd_addr] <= rd_data;
        end
    end

    // --- Read logic: combinational, always available ---
    // x0 is hardwired to zero: if either read address is 0, force output
    // to 0 regardless of what's actually stored there (which will also be
    // 0 after reset, but this makes the guarantee explicit and independent
    // of reset having run).
    assign rs1_data = (rs1_addr == 5'b0) ? 32'b0 : registers[rs1_addr];
    assign rs2_data = (rs2_addr == 5'b0) ? 32'b0 : registers[rs2_addr];

endmodule