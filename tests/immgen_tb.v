`timescale 1ns / 1ps

module immgen_tb;

    reg  [31:0] instr;
    wire [31:0] imm;

    integer     errors = 0;
    integer     checks = 0;
 
    immgen dut (
        .instr (instr),
        .imm   (imm)
    );
 
    task check_imm(input [31:0] expected, input string label);
        begin
            #1;
            checks = checks + 1;
            if (imm !== expected) begin
                errors = errors + 1;
                $display("[FAIL] %0s: expected 0x%08h, got 0x%08h", label, expected, imm);
            end else begin
                $display("[PASS] %0s: imm=0x%08h", label, imm);
            end
        end
    endtask
 
    initial begin
        $dumpfile("immgen_tb.vcd");
        $dumpvars(0, immgen_tb);
 
        // I-type: imm=5, positive, straightforward case
        instr = {12'd5, 5'd0, 3'd0, 5'd0, 7'b0010011};
        check_imm(32'd5, "I-type positive imm");
 
        // I-type: imm=-1 (all 1s), tests sign extension
        instr = {12'hFFF, 5'd0, 3'd0, 5'd0, 7'b0010011};
        check_imm(32'hFFFF_FFFF, "I-type negative imm (-1)");
 
        // B-type: imm=8, built from real field layout
        // imm[12]=0 imm[11]=0 imm[10:5]=000000 imm[4:1]=1000 (bit0 implied 0)
        instr = {1'b0, 6'b000000, 5'd0, 5'd0, 3'd0, 4'b0100, 1'b0, 7'b1100011};
        check_imm(32'd8, "B-type positive imm (+8)");
 
        // B-type: imm=-8, tests sign extension on the B-type path specifically
        // imm[12]=1 imm[11]=1 imm[10:5]=111111 imm[4:1]=1100 (bit0 implied 0)
        instr = {1'b1, 6'b111111, 5'd0, 5'd0, 3'd0, 4'b1100, 1'b1, 7'b1100011};
        check_imm(32'hFFFF_FFF8, "B-type negative imm (-8)");
 
        // R-type opcode: immgen should output 0 (unused for this format)
        instr = {25'b0, 7'b0110011};
        check_imm(32'b0, "R-type opcode produces imm=0 (unused)");
 
        $display("--------------------------------------------------");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED", checks);
        else
            $display("%0d OF %0d CHECKS FAILED", errors, checks);
        $display("--------------------------------------------------");
 
        $finish;
    end
 
endmodule