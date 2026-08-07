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

        // Program (13 instructions, one per 4-byte word):
        //   0x00: addi x1, x0, 5          x1 = 5
        //   0x04: addi x2, x0, 10         x2 = 10
        //   0x08: add  x3, x1, x2         x3 = 15
        //   0x0C: sub  x4, x2, x1         x4 = 5
        //   0x10: beq  x1, x4, +8         x1==x4 (5==5) -> branch taken, skip 0x14
        //   0x14: addi x5, x0, 99         SHOULD BE SKIPPED, x5 stays 0
        //   0x18: addi x6, x0, 1          branch target, x6 = 1
        //   0x1C: sw   x1, 0(x0)          mem[0] = x1 = 5
        //   0x20: lw   x7, 0(x0)          x7 = mem[0] = 5
        //   0x24: jal  x8, +8             x8 = 0x28 (return addr), jump to 0x2C
        //   0x28: addi x11, x0, 42        NOT run yet -- reached later via jalr
        //   0x2C: addi x9, x0, 7          jal's target: "function body", x9 = 7
        //   0x30: jalr x10, 0(x8)         x10 = 0x34 (return addr), jump to x8 (0x28)

        dut.imem_inst.mem[0]  = {12'd5,  5'd0, 3'b000, 5'd1, 7'b0010011};
        dut.imem_inst.mem[1]  = {12'd10, 5'd0, 3'b000, 5'd2, 7'b0010011};
        dut.imem_inst.mem[2]  = {7'b0000000, 5'd2, 5'd1, 3'b000, 5'd3, 7'b0110011};
        dut.imem_inst.mem[3]  = {7'b0100000, 5'd1, 5'd2, 3'b000, 5'd4, 7'b0110011};
        dut.imem_inst.mem[4]  = {1'b0, 6'b000000, 5'd4, 5'd1, 3'b000, 4'b0100, 1'b0, 7'b1100011};
        dut.imem_inst.mem[5]  = {12'd99, 5'd0, 3'b000, 5'd5, 7'b0010011};
        dut.imem_inst.mem[6]  = {12'd1,  5'd0, 3'b000, 5'd6, 7'b0010011};
        dut.imem_inst.mem[7]  = {7'b0000000, 5'd1, 5'd0, 3'b010, 5'b00000, 7'b0100011};
        dut.imem_inst.mem[8]  = {12'd0, 5'd0, 3'b010, 5'd7, 7'b0000011};
        dut.imem_inst.mem[9]  = {1'b0, 10'b0000000100, 1'b0, 8'b00000000, 5'd8, 7'b1101111}; // jal x8, +8
        dut.imem_inst.mem[10] = {12'd42, 5'd0, 3'b000, 5'd11, 7'b0010011};                    // addi x11, x0, 42
        dut.imem_inst.mem[11] = {12'd7,  5'd0, 3'b000, 5'd9,  7'b0010011};                    // addi x9, x0, 7
        dut.imem_inst.mem[12] = {12'd0, 5'd8, 3'b000, 5'd10, 7'b1100111};                     // jalr x10, 0(x8)

        @(posedge clk);
        #1;
        rst = 0;

        // Execution order isn't linear once jal/jalr redirect the PC:
        // idx0..8 (9 cycles) -> idx9(jal) -> idx11(addi x9=7) -> idx12(jalr)
        // -> idx10(addi x11=42, reached via jalr's jump back)
        // = 13 total instructions retired, so 13 clock edges.
        repeat (13) @(posedge clk);
        #1;

        check_reg(5'd1, 32'd5,  "x1 = 5 (addi)");
        check_reg(5'd2, 32'd10, "x2 = 10 (addi)");
        check_reg(5'd3, 32'd15, "x3 = 15 (add)");
        check_reg(5'd4, 32'd5,  "x4 = 5 (sub)");
        check_reg(5'd5, 32'd0,  "x5 = 0 (skipped by branch)");
        check_reg(5'd6, 32'd1,  "x6 = 1 (branch target reached)");
        check_reg(5'd7, 32'd5,  "x7 = 5 (loaded back from memory via lw)");
        check_reg(5'd8, 32'h28, "x8 = 0x28 (jal return address)");
        check_reg(5'd9, 32'd7,  "x9 = 7 (jal jumped to function body)");
        check_reg(5'd10, 32'h34, "x10 = 0x34 (jalr return address)");
        check_reg(5'd11, 32'd42, "x11 = 42 (jalr jumped back correctly)");

        checks = checks + 1;
        if (dut.dmem_inst.mem[0] !== 32'd5) begin
            errors = errors + 1;
            $display("[FAIL] dmem[0] expected 5, got %0d", dut.dmem_inst.mem[0]);
        end else begin
            $display("[PASS] dmem[0] correctly holds 5 after sw");
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