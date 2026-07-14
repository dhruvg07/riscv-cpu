`timescale 1ns/ 1ps

module control (
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire funct7_b5, //distinguishes action
    output reg reg_write,
    output reg alu_src, //0=rs2, 1=imm
    output reg branch,
    output reg [3:0 ] alu_ctrl
);

    localparam OP_R_TYPE = 7'b0110011; // add, sub, and, or, xor, sll, srl, sra, slt, sltu
    localparam OP_I_TYPE = 7'b0010011; // addi, and
    localparam OP_B_TYPE = 7'b1100011; // beq, bne, blt, bge, bltu, bgeu

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
        alu_src = 1'b0;
        branch = 1'b0;
        alu_ctrl = ALU_ADD;

        case (opcode)
            OP_R_TYPE: begin
                reg_write = 1'b1;
                alu_src = 1'b0; //rs2
                branch = 1'b0;
                case (funct3)
                    3'b000: alu_ctrl = funct7_b5 ? ALU_SUB : ALU_ADD; //add/sub
                    3'b111: alu_ctrl = ALU_AND;
                    3'b110: alu_ctrl = ALU_OR;
                    3'b100: alu_ctrl = ALU_XOR;
                    3'b001: alu_ctrl = ALU_SLL;
                    3'b101: alu_ctrl = funct7_b5 ? ALU_SRA : ALU_SRL; //srl/sra
                    3'b010: alu_ctrl = ALU_SLT;
                    3'b011: alu_ctrl = ALU_SLTU;
                    default: alu_ctrl = ALU_ADD; //default to add
                endcase
            end

            OP_I_TYPE: begin
                reg_write = 1'b1;
                alu_src = 1'b1; //imm
                branch = 1'b0;
                case (funct3)
                    3'b000: alu_ctrl = ALU_ADD; //addi
                    3'b111: alu_ctrl = ALU_AND; //andi
                    3'b110: alu_ctrl = ALU_OR;  //ori
                    3'b100: alu_ctrl = ALU_XOR; //xori
                    3'b001: alu_ctrl = ALU_SLL; //slli
                    3'b101: alu_ctrl = funct7_b5 ? ALU_SRA : ALU_SRL; //srli/srai
                    3'b010: alu_ctrl = ALU_SLT; //slti
                    3'b011: alu_ctrl = ALU_SLTU; //sltiu
                    default: alu_ctrl = ALU_ADD; //default to addi
                endcase
            end

            OP_B_TYPE: begin
                reg_write = 1'b0;
                alu_src = 1'b0; //rs2
                branch = 1'b1;
                alu_ctrl = ALU_SUB; //for branch comparison
            end

            default: begin
                reg_write = 1'b0;
                alu_src = 1'b0;
                branch = 1'b0;
                alu_ctrl = ALU_ADD; //default to add
            end
        endcase
    end
endmodule