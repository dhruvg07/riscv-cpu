`timescale 1ns / 1ps

module top (
    input wire clk,
    input wire rst
);

    wire [31:0] pc_out, pc_plus_4, pc_next, branch_target;
    wire [31:0] instr;
    wire [31:0] rs1_data, rs2_data, alu_b, alu_result, imm;
    wire        reg_write, alu_src, branch, zero, branch_taken;
    wire [3:0]  alu_ctrl;
 
    wire [6:0] opcode    = instr[6:0];
    wire [4:0] rd_addr   = instr[11:7];
    wire [2:0] funct3    = instr[14:12];
    wire [4:0] rs1_addr  = instr[19:15];
    wire [4:0] rs2_addr  = instr[24:20];
    wire       funct7_b5 = instr[30];
 
    pc pc_inst (
        .clk     (clk),
        .rst     (rst),
        .pc_next (pc_next),
        .pc_out  (pc_out)
    );
 
    imem imem_inst (
        .addr  (pc_out),
        .instr (instr)
    );
 
    regfile regfile_inst (
        .clk       (clk),
        .rst       (rst),
        .rs1_addr  (rs1_addr),
        .rs1_data  (rs1_data),
        .rs2_addr  (rs2_addr),
        .rs2_data  (rs2_data),
        .reg_write (reg_write),
        .rd_addr   (rd_addr),
        .rd_data   (alu_result)
    );
 
    immgen immgen_inst (
        .instr (instr),
        .imm   (imm)
    );
 
    control control_inst (
        .opcode    (opcode),
        .funct3    (funct3),
        .funct7_b5 (funct7_b5),
        .reg_write (reg_write),
        .alu_src   (alu_src),
        .branch    (branch),
        .alu_ctrl  (alu_ctrl)
    );
 
    assign alu_b = alu_src ? imm : rs2_data;
 
    alu alu_inst (
        .a        (rs1_data),
        .b        (alu_b),
        .alu_ctrl (alu_ctrl),
        .result   (alu_result),
        .zero     (zero)
    );
 
    assign pc_plus_4    = pc_out + 32'd4;
    assign branch_target = pc_out + imm;
    assign branch_taken  = branch & (zero ^ funct3[0]); // beq: funct3[0]=0, bne: funct3[0]=1
    assign pc_next        = branch_taken ? branch_target : pc_plus_4;
 
endmodule