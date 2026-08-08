`timescale 1ns / 1ps

module control_tb;

    reg  [6:0] opcode;
    reg  [2:0] funct3;
    reg        funct7_b5;
    wire       reg_write;
    wire       alu_src;
    wire       branch;
    wire       mem_read;
    wire       mem_write;
    wire       jump;
    wire       jump_reg;
    wire       lui;
    wire       auipc;
    wire [3:0] alu_ctrl;

    integer    errors = 0;
    integer    checks = 0;

    localparam ALU_ADD = 4'b0000;
    localparam ALU_SUB = 4'b0001;

    control dut (
        .opcode    (opcode),
        .funct3    (funct3),
        .funct7_b5 (funct7_b5),
        .reg_write (reg_write),
        .alu_src   (alu_src),
        .branch    (branch),
        .mem_read  (mem_read),
        .mem_write (mem_write),
        .jump      (jump),
        .jump_reg  (jump_reg),
        .lui       (lui),
        .auipc     (auipc),
        .alu_ctrl  (alu_ctrl)
    );

    task check(input rw_exp, input src_exp, input br_exp, input mr_exp, input mw_exp,
               input j_exp, input jr_exp, input lui_exp, input auipc_exp,
               input [3:0] alu_exp, input string label);
        begin
            #1;
            checks = checks + 1;
            if (reg_write !== rw_exp || alu_src !== src_exp || branch !== br_exp ||
                mem_read !== mr_exp || mem_write !== mw_exp || jump !== j_exp ||
                jump_reg !== jr_exp || lui !== lui_exp || auipc !== auipc_exp ||
                alu_ctrl !== alu_exp) begin
                errors = errors + 1;
                $display("[FAIL] %0s: mismatch (see waveform for details)", label);
            end else begin
                $display("[PASS] %0s", label);
            end
        end
    endtask

    initial begin
        $dumpfile("control_tb.vcd");
        $dumpvars(0, control_tb);

        opcode = 7'b0110011; funct3 = 3'b000; funct7_b5 = 1'b0;
        check(1, 0, 0, 0, 0, 0, 0, 0, 0, ALU_ADD, "R-type add");

        opcode = 7'b0010011; funct3 = 3'b000; funct7_b5 = 1'b0;
        check(1, 1, 0, 0, 0, 0, 0, 0, 0, ALU_ADD, "I-type addi");

        opcode = 7'b1100011; funct3 = 3'b000; funct7_b5 = 1'b0;
        check(0, 0, 1, 0, 0, 0, 0, 0, 0, ALU_SUB, "B-type beq");

        opcode = 7'b0000011; funct3 = 3'b010; funct7_b5 = 1'b0;
        check(1, 1, 0, 1, 0, 0, 0, 0, 0, ALU_ADD, "Load (lw)");

        opcode = 7'b0100011; funct3 = 3'b010; funct7_b5 = 1'b0;
        check(0, 1, 0, 0, 1, 0, 0, 0, 0, ALU_ADD, "Store (sw)");

        opcode = 7'b1101111; funct3 = 3'b000; funct7_b5 = 1'b0;
        check(1, 0, 0, 0, 0, 1, 0, 0, 0, ALU_ADD, "jal");

        opcode = 7'b1100111; funct3 = 3'b000; funct7_b5 = 1'b0;
        check(1, 1, 0, 0, 0, 0, 1, 0, 0, ALU_ADD, "jalr");

        opcode = 7'b0110111; funct3 = 3'b000; funct7_b5 = 1'b0;
        check(1, 0, 0, 0, 0, 0, 0, 1, 0, ALU_ADD, "lui");

        opcode = 7'b0010111; funct3 = 3'b000; funct7_b5 = 1'b0;
        check(1, 0, 0, 0, 0, 0, 0, 0, 1, ALU_ADD, "auipc");

        opcode = 7'b1111111; funct3 = 3'b000; funct7_b5 = 1'b0;
        check(0, 0, 0, 0, 0, 0, 0, 0, 0, ALU_ADD, "Unknown opcode defaults safely");

        $display("--------------------------------------------------");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED", checks);
        else
            $display("%0d OF %0d CHECKS FAILED", errors, checks);
        $display("--------------------------------------------------");

        $finish;
    end

endmodule