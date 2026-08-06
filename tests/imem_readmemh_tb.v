`timescale 1ns / 1ps

module imem_readmemh_tb;

    reg  [31:0] addr;
    wire [31:0] instr;

    integer errors = 0;
    integer checks = 0;

    imem #(
        .MEM_SIZE_WORDS(256),
        .MEM_INIT_FILE("program.hex")
    ) dut (
        .addr  (addr),
        .instr (instr)
    );

    task check_instr(input [31:0] test_addr, input [31:0] expected, input string label);
        begin
            addr = test_addr;
            #1;
            checks = checks + 1;
            if (instr !== expected) begin
                errors = errors + 1;
                $display("[FAIL] %0s: addr=0x%08h expected 0x%08h, got 0x%08h",
                          label, test_addr, expected, instr);
            end else begin
                $display("[PASS] %0s: addr=0x%08h -> 0x%08h", label, test_addr, instr);
            end
        end
    endtask

    initial begin
        check_instr(32'h00, 32'h00500093, "addi x1,x0,5");
        check_instr(32'h04, 32'h00a00113, "addi x2,x0,10");
        check_instr(32'h08, 32'h002081b3, "add x3,x1,x2");
        check_instr(32'h0C, 32'h40110233, "sub x4,x2,x1");
        check_instr(32'h10, 32'h00408463, "beq x1,x4,+8");
        check_instr(32'h14, 32'h06300293, "addi x5,x0,99");
        check_instr(32'h18, 32'h00100313, "addi x6,x0,1");

        $display("--------------------------------------------------");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED", checks);
        else
            $display("%0d OF %0d CHECKS FAILED", errors, checks);
        $display("--------------------------------------------------");

        $finish;
    end

endmodule