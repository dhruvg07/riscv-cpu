`timescale 1ns / 1ps

module immgen (
    input  wire [31:0] instr,
    output reg  [31:0] imm
);

    localparam OP_I_TYPE = 7'b0010011;
    localparam OP_LOAD   = 7'b0000011;
    localparam OP_JALR   = 7'b1100111;
    localparam OP_B_TYPE = 7'b1100011;
    localparam OP_S_TYPE = 7'b0100011;
    localparam OP_JAL    = 7'b1101111;

    always @(*) begin
        case (instr[6:0])
            OP_I_TYPE, OP_LOAD, OP_JALR:
                imm = {{20{instr[31]}}, instr[31:20]};
            OP_S_TYPE:
                imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            OP_B_TYPE:
                imm = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            OP_JAL:
                imm = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
            default:
                imm = 32'b0;
        endcase
    end

endmodule