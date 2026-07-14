`timescale 1ns / 1ps

module alu_tb;

    reg  [31:0] a;
    reg  [31:0] b;
    reg  [3:0]  alu_ctrl;
    wire [31:0] result;
    wire        zero;

    integer     errors = 0;
    integer     checks = 0;

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

    alu dut (
        .a        (a),
        .b        (b),
        .alu_ctrl (alu_ctrl),
        .result   (result),
        .zero     (zero)
    );

    task check_result(input [31:0] test_a, input [31:0] test_b,
    input [3:0] op, input [31:0] expected, input string label);
        begin
            a        = test_a;
            b        = test_b;
            alu_ctrl = op;
            #1; // allow combinational logic to settle
            checks = checks + 1;
            if (result !== expected) begin
                errors = errors + 1;
                $display("[FAIL] %0s: a=0x%08h b=0x%08h op=%b expected result=0x%08h, got 0x%08h",
                          label, test_a, test_b, op, expected, result);
            end else begin
                $display("[PASS] %0s: a=0x%08h b=0x%08h op=%b -> result=0x%08h",
                          label, test_a, test_b, op, result);
            end
        end
    endtask

    initial begin
        
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);
 
        // --- Basic arithmetic ---
        check_result(32'd10, 32'd5, ALU_ADD, 32'd15, "ADD 10+5");
        check_result(32'd10, 32'd5, ALU_SUB, 32'd5,  "SUB 10-5");
 
        // --- Bitwise logic ---
        check_result(32'hFF00_FF00, 32'h0F0F_0F0F, ALU_AND, 32'h0F00_0F00, "AND");
        check_result(32'hFF00_FF00, 32'h0F0F_0F0F, ALU_OR,  32'hFF0F_FF0F, "OR");
        check_result(32'hFF00_FF00, 32'h0F0F_0F0F, ALU_XOR, 32'hF00F_F00F, "XOR");
 
        // --- Shifts ---
        check_result(32'h0000_0001, 32'd4, ALU_SLL, 32'h0000_0010, "SLL shift left by 4");
        check_result(32'h0000_0010, 32'd4, ALU_SRL, 32'h0000_0001, "SRL shift right by 4");
 
        // SRA must preserve the sign bit -- test with a negative number
        // (0x80000000 = most negative 32-bit signed value)
        check_result(32'h8000_0000, 32'd4, ALU_SRA, 32'hF800_0000, "SRA preserves sign bit");
 
        // Shift amount should only use bottom 5 bits: shifting by 32
        // should behave the same as shifting by 0 (32 & 0x1F = 0)
        check_result(32'hDEAD_BEEF, 32'd32, ALU_SLL, 32'hDEAD_BEEF, "SLL shift amount wraps (>>5 bits ignored)");
 
        // --- Signed comparison ---
        check_result(32'd5, 32'd10, ALU_SLT, 32'd1, "SLT: 5 < 10 (true)");
        check_result(32'd10, 32'd5, ALU_SLT, 32'd0, "SLT: 10 < 5 (false)");
 
        // Signed comparison with a negative number: -1 (0xFFFFFFFF) should
        // be LESS than 1, even though as raw unsigned bits it's huge
        check_result(32'hFFFF_FFFF, 32'd1, ALU_SLT, 32'd1, "SLT: -1 < 1 signed (true)");
 
        // --- Unsigned comparison ---
        // Same bit patterns as above, but SLTU must treat 0xFFFFFFFF as a
        // huge positive number, not -1 -- so this should be the OPPOSITE
        // result of the signed test above
        check_result(32'hFFFF_FFFF, 32'd1, ALU_SLTU, 32'd0, "SLTU: 0xFFFFFFFF < 1 unsigned (false)");
        check_result(32'd1, 32'd10, ALU_SLTU, 32'd1, "SLTU: 1 < 10 (true)");
 
        // --- Zero flag ---
        a        = 32'd7;
        b        = 32'd7;
        alu_ctrl = ALU_SUB;
        #1;
        checks = checks + 1;
        if (zero !== 1'b1) begin
            errors = errors + 1;
            $display("[FAIL] Zero flag: expected zero=1 when a==b, got zero=%0b", zero);
        end else begin
            $display("[PASS] Zero flag: correctly asserted when result is 0");
        end
 
        a        = 32'd7;
        b        = 32'd8;
        alu_ctrl = ALU_SUB;
        #1;
        checks = checks + 1;
        if (zero !== 1'b0) begin
            errors = errors + 1;
            $display("[FAIL] Zero flag: expected zero=0 when a!=b, got zero=%0b", zero);
        end else begin
            $display("[PASS] Zero flag: correctly deasserted when result is nonzero");
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