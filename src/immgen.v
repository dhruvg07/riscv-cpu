`timescale 1ns / 1ps

module immgen (
    input  wire [31:0] instr,
    output reg  [31:0] imm
);

    localparam OP_I_TYPE  = 7'b0010011; // addi, andi, etc.
    localparam OP_LOAD    = 7'b0000011; // lw
    localparam OP_B_TYPE  = 7'b1100011; // beq, bne, etc.
    localparam OP_S_TYPE  = 7'b0100011; // sw

    always @(*) begin
        case (instr[6:0])
            OP_I_TYPE, OP_LOAD:
                imm = {{20{instr[31]}}, instr[31:20]};
            OP_S_TYPE:
                imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            OP_B_TYPE:
                imm = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            default:
                imm = 32'b0;
        endcase
    end

endmodule