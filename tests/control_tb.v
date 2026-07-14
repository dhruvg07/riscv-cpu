`timescale 1ns / 1ps

module control_tb;

    reg  [6:0] opcode;
    reg  [2:0] funct3;
    reg        funct7_b5;
    wire       reg_write;
    wire       alu_src;
    wire       branch;
    wire [3:0] alu_ctrl;
 
    integer    errors = 0;
    integer    checks = 0;
 
    localparam ALU_ADD  = 4'b0000;
    localparam ALU_SUB  = 4'b0001;
    localparam ALU_AND  = 4'b0010;
    localparam ALU_OR   = 4'b0011;
    localparam ALU_XOR  = 4'b0100;
    localparam ALU_SLT  = 4'b1000;
    localparam ALU_SLTU = 4'b1001;
 
    control dut (
        .opcode    (opcode),
        .funct3    (funct3),
        .funct7_b5 (funct7_b5),
        .reg_write (reg_write),
        .alu_src   (alu_src),
        .branch    (branch),
        .alu_ctrl  (alu_ctrl)
    );
 
    task check(input rw_exp, input src_exp, input br_exp, input [3:0] alu_exp, input string label);
        begin
            #1;
            checks = checks + 1;
            if (reg_write !== rw_exp || alu_src !== src_exp || branch !== br_exp || alu_ctrl !== alu_exp) begin
                errors = errors + 1;
                $display("[FAIL] %0s: expected rw=%0b src=%0b br=%0b alu=%0b, got rw=%0b src=%0b br=%0b alu=%0b",
                          label, rw_exp, src_exp, br_exp, alu_exp, reg_write, alu_src, branch, alu_ctrl);
            end else begin
                $display("[PASS] %0s: rw=%0b src=%0b br=%0b alu=%0b", label, reg_write, alu_src, branch, alu_ctrl);
            end
        end
    endtask
 
    initial begin
        $dumpfile("control_tb.vcd");
        $dumpvars(0, control_tb);
 
        // R-type: add (funct3=000, funct7[5]=0)
        opcode = 7'b0110011; funct3 = 3'b000; funct7_b5 = 1'b0;
        check(1, 0, 0, ALU_ADD, "R-type add");
 
        // R-type: sub (same funct3, funct7[5]=1 -- the classic add/sub disambiguation)
        opcode = 7'b0110011; funct3 = 3'b000; funct7_b5 = 1'b1;
        check(1, 0, 0, ALU_SUB, "R-type sub");
 
        // R-type: and, or, xor, slt, sltu
        opcode = 7'b0110011; funct3 = 3'b111; funct7_b5 = 1'b0;
        check(1, 0, 0, ALU_AND, "R-type and");
 
        opcode = 7'b0110011; funct3 = 3'b110; funct7_b5 = 1'b0;
        check(1, 0, 0, ALU_OR, "R-type or");
 
        opcode = 7'b0110011; funct3 = 3'b100; funct7_b5 = 1'b0;
        check(1, 0, 0, ALU_XOR, "R-type xor");
 
        opcode = 7'b0110011; funct3 = 3'b010; funct7_b5 = 1'b0;
        check(1, 0, 0, ALU_SLT, "R-type slt");
 
        opcode = 7'b0110011; funct3 = 3'b011; funct7_b5 = 1'b0;
        check(1, 0, 0, ALU_SLTU, "R-type sltu");
 
        // I-type: addi -- note funct7_b5 is irrelevant here since it's part
        // of the immediate field for I-type, not a real funct7 bit
        opcode = 7'b0010011; funct3 = 3'b000; funct7_b5 = 1'b0;
        check(1, 1, 0, ALU_ADD, "I-type addi");
 
        // I-type: andi
        opcode = 7'b0010011; funct3 = 3'b111; funct7_b5 = 1'b0;
        check(1, 1, 0, ALU_AND, "I-type andi");
 
        // B-type: beq/bne share the same control signals (SUB + branch=1);
        // the equal-vs-not-equal distinction happens outside this module
        opcode = 7'b1100011; funct3 = 3'b000; funct7_b5 = 1'b0;
        check(0, 0, 1, ALU_SUB, "B-type beq");
 
        opcode = 7'b1100011; funct3 = 3'b001; funct7_b5 = 1'b0;
        check(0, 0, 1, ALU_SUB, "B-type bne");
 
        // Unknown/unsupported opcode: should default safely (no writes, no branch)
        opcode = 7'b1111111; funct3 = 3'b000; funct7_b5 = 1'b0;
        check(0, 0, 0, ALU_ADD, "Unknown opcode defaults safely");
 
        $display("--------------------------------------------------");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED", checks);
        else
            $display("%0d OF %0d CHECKS FAILED", errors, checks);
        $display("--------------------------------------------------");
 
        $finish;
    end
 
endmodule