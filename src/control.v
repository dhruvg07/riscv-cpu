`timescale 1ns / 1ps

module control (
    input  wire [6:0] opcode,
    input  wire [2:0] funct3,
    input  wire       funct7_b5,   // funct7[5], distinguishes e.g. add/sub, srl/sra
    output reg        reg_write,
    output reg        alu_src,     // 0 = rs2, 1 = immediate
    output reg        branch,
    output reg        mem_read,
    output reg        mem_write,
    output reg        jump,        // jal
    output reg        jump_reg,    // jalr
    output reg        lui,
    output reg        auipc,
    output reg [3:0]  alu_ctrl
);

    localparam OP_R_TYPE = 7'b0110011;
    localparam OP_I_TYPE = 7'b0010011;
    localparam OP_B_TYPE = 7'b1100011;
    localparam OP_LOAD   = 7'b0000011;
    localparam OP_STORE  = 7'b0100011;
    localparam OP_JAL    = 7'b1101111;
    localparam OP_JALR   = 7'b1100111;
    localparam OP_LUI    = 7'b0110111;
    localparam OP_AUIPC  = 7'b0010111;

    localparam ALU_ADD  = 4'b0000;
    localparam ALU_SUB  = 4'b0001;
    localparam ALU_AND  = 4'b0010;
    localparam ALU_OR   = 4'b0011;
    localparam ALU_XOR  = 4'b0100;
    localparam ALU_SLL  = 4'b0101;
    localparam ALU_SRL  = 4'b0110;
    localparam ALU_SRA  = 4'b0111;
    localparam ALU_SLT  = 4'b1000;
    localparam ALU_SLTU = 4'b1001;

    always @(*) begin
        reg_write = 1'b0;
        alu_src   = 1'b0;
        branch    = 1'b0;
        mem_read  = 1'b0;
        mem_write = 1'b0;
        jump      = 1'b0;
        jump_reg  = 1'b0;
        lui       = 1'b0;
        auipc     = 1'b0;
        alu_ctrl  = ALU_ADD;

        case (opcode)
            OP_R_TYPE: begin
                reg_write = 1'b1;
                alu_src   = 1'b0;
                case (funct3)
                    3'b000: alu_ctrl = funct7_b5 ? ALU_SUB : ALU_ADD;
                    3'b111: alu_ctrl = ALU_AND;
                    3'b110: alu_ctrl = ALU_OR;
                    3'b100: alu_ctrl = ALU_XOR;
                    3'b001: alu_ctrl = ALU_SLL;
                    3'b101: alu_ctrl = funct7_b5 ? ALU_SRA : ALU_SRL;
                    3'b010: alu_ctrl = ALU_SLT;
                    3'b011: alu_ctrl = ALU_SLTU;
                    default: alu_ctrl = ALU_ADD;
                endcase
            end

            OP_I_TYPE: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
                case (funct3)
                    3'b000: alu_ctrl = ALU_ADD;  // addi
                    3'b111: alu_ctrl = ALU_AND;
                    3'b110: alu_ctrl = ALU_OR;
                    3'b100: alu_ctrl = ALU_XOR;
                    3'b010: alu_ctrl = ALU_SLT;
                    3'b011: alu_ctrl = ALU_SLTU;
                    3'b001: alu_ctrl = ALU_SLL;
                    3'b101: alu_ctrl = funct7_b5 ? ALU_SRA : ALU_SRL;
                    default: alu_ctrl = ALU_ADD;
                endcase
            end

            OP_B_TYPE: begin
                reg_write = 1'b0;
                alu_src   = 1'b0;
                branch    = 1'b1;
                alu_ctrl  = ALU_SUB; // beq/bne both compare via subtraction
            end

            OP_LOAD: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
                mem_read  = 1'b1;
                alu_ctrl  = ALU_ADD; // rs1 + offset
            end

            OP_STORE: begin
                reg_write = 1'b0;
                alu_src   = 1'b1;
                mem_write = 1'b1;
                alu_ctrl  = ALU_ADD; // rs1 + offset
            end

            OP_JAL: begin
                reg_write = 1'b1;
                jump      = 1'b1; // target = PC + imm, rd = PC + 4
            end

            OP_JALR: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
                jump_reg  = 1'b1; // target = rs1 + imm (via ALU), rd = PC + 4
                alu_ctrl  = ALU_ADD;
            end

            OP_LUI: begin
                reg_write = 1'b1;
                lui       = 1'b1; // rd = imm directly, bypasses ALU
            end

            OP_AUIPC: begin
                reg_write = 1'b1;
                auipc     = 1'b1; // rd = PC + imm, bypasses ALU
            end

            default: begin
                reg_write = 1'b0;
                alu_src   = 1'b0;
                branch    = 1'b0;
                alu_ctrl  = ALU_ADD;
            end
        endcase
    end

endmodule