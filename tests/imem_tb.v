`timescale 1ns / 1ps

module imem_tb;

    reg  [31:0] addr;
    wire [31:0] instr;

    integer     errors = 0;
    integer     checks = 0;

    imem #(.MEM_SIZE_WORDS(256)) dut (
        .addr  (addr),
        .instr (instr)
    );

    task check_instr(input [31:0] test_addr, input [31:0] expected, input string label);
        begin
            addr = test_addr;
            #1; // combinational read, just let it settle
            checks = checks + 1;
            if (instr !== expected) begin
                errors = errors + 1;
                $display("[FAIL] %0s: addr=0x%08h expected instr=0x%08h, got 0x%08h",
                          label, test_addr, expected, instr);
            end else begin
                $display("[PASS] %0s: addr=0x%08h -> instr=0x%08h",
                          label, test_addr, instr);
            end
        end
    endtask

    initial begin
        $dumpfile("imem_tb.vcd");
        $dumpvars(0, imem_tb);

        // --- Preload known instructions directly into memory for testing ---
        // (hierarchical reference into the DUT's internal array -- simulation
        // only, not something real hardware allows)
        dut.mem[0] = 32'h00A00093; // word index 0  -> byte address 0x00
        dut.mem[1] = 32'h00B00113; // word index 1  -> byte address 0x04
        dut.mem[2] = 32'h00C00193; // word index 2  -> byte address 0x08
        dut.mem[10] = 32'hDEAD_BEEF; // word index 10 -> byte address 0x28

        // --- Test 1: Fetch at address 0 (word index 0) ---
        check_instr(32'h0000_0000, 32'h00A00093, "Fetch word 0");

        // --- Test 2: Fetch at address 4 (word index 1) ---
        check_instr(32'h0000_0004, 32'h00B00113, "Fetch word 1");

        // --- Test 3: Fetch at address 8 (word index 2) ---
        check_instr(32'h0000_0008, 32'h00C00193, "Fetch word 2");

        // --- Test 4: Fetch a non-sequential address (word index 10) ---
        check_instr(32'h0000_0028, 32'hDEAD_BEEF, "Fetch word 10 (non-sequential)");

        // --- Test 5: Unwritten address reads as zero ---
        check_instr(32'h0000_0064, 32'h0000_0000, "Unwritten word reads zero");

        // --- Test 6: Re-fetch address 0 again -- confirms read is stable/
        //             repeatable, not a one-shot or accidentally-clearing read
        check_instr(32'h0000_0000, 32'h00A00093, "Re-fetch word 0 (stability check)");

        // --- Test 7: Confirm the read is purely combinational -- change addr
        //             mid-simulation with no clock involved at all and see
        //             the output track immediately
        addr = 32'h0000_0004;
        #1;
        checks = checks + 1;
        if (instr !== 32'h00B00113) begin
            errors = errors + 1;
            $display("[FAIL] Combinational check: expected 0x00B00113, got 0x%08h", instr);
        end else begin
            $display("[PASS] Combinational check: instr tracks addr with no clock, instr=0x%08h", instr);
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