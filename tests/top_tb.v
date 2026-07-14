`timescale 1ns / 1ps

`timescale 1ns / 1ps

module top_tb;

    reg clk;
    reg rst;

    integer errors = 0;
    integer checks = 0;

    top dut (
        .clk (clk),
        .rst (rst)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    task check_reg(input [4:0] reg_num, input [31:0] expected, input string label);
        begin
            checks = checks + 1;
            if (dut.regfile_inst.registers[reg_num] !== expected) begin
                errors = errors + 1;
                $display("[FAIL] %0s: x%0d expected 0x%08h, got 0x%08h",
                          label, reg_num, expected, dut.regfile_inst.registers[reg_num]);
            end else begin
                $display("[PASS] %0s: x%0d = 0x%08h", label, reg_num, dut.regfile_inst.registers[reg_num]);
            end
        end
    endtask

    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);

        rst = 1;

        // Program (7 instructions, one per 4-byte word):
        //   0x00: addi x1, x0, 5          x1 = 5
        //   0x04: addi x2, x0, 10         x2 = 10
        //   0x08: add  x3, x1, x2         x3 = 15
        //   0x0C: sub  x4, x2, x1         x4 = 5
        //   0x10: beq  x1, x4, +8         x1==x4 (5==5) -> branch taken, skip 0x14
        //   0x14: addi x5, x0, 99         SHOULD BE SKIPPED, x5 stays 0
        //   0x18: addi x6, x0, 1          branch target, x6 = 1

        dut.imem_inst.mem[0] = {12'd5,  5'd0, 3'b000, 5'd1, 7'b0010011};
        dut.imem_inst.mem[1] = {12'd10, 5'd0, 3'b000, 5'd2, 7'b0010011};
        dut.imem_inst.mem[2] = {7'b0000000, 5'd2, 5'd1, 3'b000, 5'd3, 7'b0110011};
        dut.imem_inst.mem[3] = {7'b0100000, 5'd1, 5'd2, 3'b000, 5'd4, 7'b0110011};
        dut.imem_inst.mem[4] = {1'b0, 6'b000000, 5'd4, 5'd1, 3'b000, 4'b0100, 1'b0, 7'b1100011};
        dut.imem_inst.mem[5] = {12'd99, 5'd0, 3'b000, 5'd5, 7'b0010011};
        dut.imem_inst.mem[6] = {12'd1,  5'd0, 3'b000, 5'd6, 7'b0010011};

        @(posedge clk);
        #1;
        rst = 0;

        // One instruction retires per clock edge in a single-cycle CPU.
        // Run 7 edges to execute all 7 instructions (branch counts as one).
        repeat (7) @(posedge clk);
        #1;

        check_reg(5'd1, 32'd5,  "x1 = 5 (addi)");
        check_reg(5'd2, 32'd10, "x2 = 10 (addi)");
        check_reg(5'd3, 32'd15, "x3 = 15 (add)");
        check_reg(5'd4, 32'd5,  "x4 = 5 (sub)");
        check_reg(5'd5, 32'd0,  "x5 = 0 (skipped by branch)");
        check_reg(5'd6, 32'd1,  "x6 = 1 (branch target reached)");

        $display("--------------------------------------------------");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED", checks);
        else
            $display("%0d OF %0d CHECKS FAILED", errors, checks);
        $display("--------------------------------------------------");

        $finish;
    end

endmodule