`timescale 1ns / 1ps

module pc (
    input wire clk,
    input wire rst,
    input wire [31:0] pc_next,
    output reg [31:0] pc_out
    );

always @(posedge clk or posedge rst) begin
    if (rst)
        pc_out <= 32'b00; // Reset PC to 0 on reset
    else
        pc_out <= pc_next; // Update PC with the next value
end

endmodule