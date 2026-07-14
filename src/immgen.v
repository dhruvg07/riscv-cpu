`timescale 1ns / 1ps

module immgen (
    input wire [31:0] instr,
    output reg [31:0] imm
);

    localparam OP_I_TYPE = 7'b0010011; // addi, andi, ori, xori, slli, srli, srai
    localparam OP_B_TYPE = 7'b1100011; // beq, bne, blt, bge, bltu, bgeu

    always @(*) begin
        case (instr[6:0])
            OP_I_TYPE:
                // I-type immediate: bits [31:20]
                imm = {{20{instr[31]}}, instr[31:20]}; // sign-extend
            OP_B_TYPE:
                // B-type immediate: bits [31], [7], [30:25], [11:8]
                imm = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}; // sign-extend and shift left by 1
            default:
                imm = 32'b0; // Default case to avoid latches
        endcase
    end
endmodule