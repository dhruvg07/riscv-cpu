`timescale 1ns / 1ps

module top_tb;

    reg clk;
    reg rst;
    wire [7:0] led;

    integer errors = 0;
    integer checks = 0;

    top dut (
        .clk (clk),
        .rst (rst),
        .led (led)
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

        // Program (15 instructions):
        //   0x00-0x20: same as before (arithmetic, branch, load/store) -- indices 0-8
        //   0x24: auipc x13, 0            x13 = PC = 0x24 (linear, no loop risk)
        //   0x28: jal   x8, +12           x8 = 0x2C (return addr), jump to 0x34
        //   0x2C: lui   x12, 0x10000      NOT run yet -- return target, x12 = 0x10000000
        //   0x30: sw    x1, 0(x12)        NOT run yet -- writes led = x1[7:0] = 5
        //   0x34: addi  x9, x0, 7         jal's target: "function body", x9 = 7
        //   0x38: jalr  x10, 0(x8)        x10 = 0x3C (return addr), jump back to x8 (0x2C)
        //
        // NOTE: after the jalr returns to 0x2C, execution falls through 0x2C -> 0x30
        // -> 0x34 -> 0x38 again, which would loop forever (this is a toy program, not
        // real ABI-correct code). We stop the simulation at exactly 15 cycles, right
        // after the lui+sw at the return target execute once, before the loop repeats.

        dut.imem_inst.mem[0]  = {12'd5,  5'd0, 3'b000, 5'd1, 7'b0010011};
        dut.imem_inst.mem[1]  = {12'd10, 5'd0, 3'b000, 5'd2, 7'b0010011};
        dut.imem_inst.mem[2]  = {7'b0000000, 5'd2, 5'd1, 3'b000, 5'd3, 7'b0110011};
        dut.imem_inst.mem[3]  = {7'b0100000, 5'd1, 5'd2, 3'b000, 5'd4, 7'b0110011};
        dut.imem_inst.mem[4]  = {1'b0, 6'b000000, 5'd4, 5'd1, 3'b000, 4'b0100, 1'b0, 7'b1100011};
        dut.imem_inst.mem[5]  = {12'd99, 5'd0, 3'b000, 5'd5, 7'b0010011};
        dut.imem_inst.mem[6]  = {12'd1,  5'd0, 3'b000, 5'd6, 7'b0010011};
        dut.imem_inst.mem[7]  = {7'b0000000, 5'd1, 5'd0, 3'b010, 5'b00000, 7'b0100011};
        dut.imem_inst.mem[8]  = {12'd0, 5'd0, 3'b010, 5'd7, 7'b0000011};
        dut.imem_inst.mem[9]  = {20'b0, 5'd13, 7'b0010111};                                    // auipc x13, 0
        dut.imem_inst.mem[10] = {1'b0, 10'b0000000110, 1'b0, 8'b00000000, 5'd8, 7'b1101111};   // jal x8, +12
        dut.imem_inst.mem[11] = {20'h10000, 5'd12, 7'b0110111};                                 // lui x12, 0x10000
        dut.imem_inst.mem[12] = {7'b0000000, 5'd1, 5'd12, 3'b010, 5'b00000, 7'b0100011};        // sw x1, 0(x12)
        dut.imem_inst.mem[13] = {12'd7, 5'd0, 3'b000, 5'd9, 7'b0010011};                        // addi x9, x0, 7
        dut.imem_inst.mem[14] = {12'd0, 5'd8, 3'b000, 5'd10, 7'b1100111};                       // jalr x10, 0(x8)

        @(posedge clk);
        #1;
        rst = 0;

        // Execution order: idx0-8 (9 cycles) -> idx9(auipc) -> idx10(jal)
        // -> idx13(addi x9=7, jal's target) -> idx14(jalr)
        // -> idx11(lui, return target) -> idx12(sw, writes led)
        // = 15 total instructions retired.
        repeat (15) @(posedge clk);
        #1;

        check_reg(5'd1, 32'd5,  "x1 = 5 (addi)");
        check_reg(5'd2, 32'd10, "x2 = 10 (addi)");
        check_reg(5'd3, 32'd15, "x3 = 15 (add)");
        check_reg(5'd4, 32'd5,  "x4 = 5 (sub)");
        check_reg(5'd5, 32'd0,  "x5 = 0 (skipped by branch)");
        check_reg(5'd6, 32'd1,  "x6 = 1 (branch target reached)");
        check_reg(5'd7, 32'd5,  "x7 = 5 (loaded back from memory via lw)");
        check_reg(5'd8, 32'h2C, "x8 = 0x2C (jal return address)");
        check_reg(5'd9, 32'd7,  "x9 = 7 (jal jumped to function body)");
        check_reg(5'd10, 32'h3C, "x10 = 0x3C (jalr return address)");
        check_reg(5'd12, 32'h1000_0000, "x12 = 0x10000000 (lui)");
        check_reg(5'd13, 32'h24, "x13 = 0x24 (auipc = its own PC)");

        checks = checks + 1;
        if (dut.dmem_inst.mem[0] !== 32'd5) begin
            errors = errors + 1;
            $display("[FAIL] dmem[0] expected 5, got %0d", dut.dmem_inst.mem[0]);
        end else begin
            $display("[PASS] dmem[0] correctly holds 5 after sw");
        end

        checks = checks + 1;
        if (led !== 8'h05) begin
            errors = errors + 1;
            $display("[FAIL] led expected 0x05, got 0x%02h", led);
        end else begin
            $display("[PASS] led correctly shows 0x05 (LED peripheral exercised via lui+sw)");
        end

        $display("--------------------------------------------------");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED", checks);
        else
            $display("%0d OF %0d CHECKS FAILED", errors, checks);
        $display("--------------------------------------------------");

        $finish;
    end

endmodule