`timescale 1ns / 1ps

module pc_tb;

    // DUT signals
    reg         clk;
    reg         rst;
    reg  [31:0] pc_next;
    wire [31:0] pc_out;

    integer     errors = 0;
    integer     checks = 0;

    // Instantiate the PC
    pc dut (
        .clk     (clk),
        .rst     (rst),
        .pc_next (pc_next),
        .pc_out  (pc_out)
    );

    // 100 MHz clock: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Task to check pc_out against an expected value after the next clock edge
    task check_pc(input [31:0] expected, input string label);
        begin
            @(posedge clk);
            #1; // small delta delay to let non-blocking assignment settle
            checks = checks + 1;
            if (pc_out !== expected) begin
                errors = errors + 1;
                $display("[FAIL] %0s: expected pc_out=0x%08h, got 0x%08h at time %0t",
                          label, expected, pc_out, $time);
            end else begin
                $display("[PASS] %0s: pc_out=0x%08h at time %0t",
                          label, pc_out, $time);
            end
        end
    endtask

    initial begin
        // Optional waveform dump for GTKWave/Verilator trace viewing
        $dumpfile("pc_tb.vcd");
        $dumpvars(0, pc_tb);

        // --- Test 1: Reset behavior ---
        rst     = 1;
        pc_next = 32'hDEAD_BEEF; // garbage on pc_next; reset should override it
        @(posedge clk);
        #1;
        checks = checks + 1;
        if (pc_out !== 32'h0) begin
            errors = errors + 1;
            $display("[FAIL] Reset: expected pc_out=0x00000000, got 0x%08h at time %0t",
                      pc_out, $time);
        end else begin
            $display("[PASS] Reset: pc_out=0x%08h at time %0t", pc_out, $time);
        end

        // --- Test 2: Normal sequential update after reset deasserts ---
        rst     = 0;
        pc_next = 32'h0000_0004;
        check_pc(32'h0000_0004, "Sequential +4 update");

        // --- Test 3: Branch/jump-style non-sequential update ---
        pc_next = 32'h0000_1000;
        check_pc(32'h0000_1000, "Jump to arbitrary address");

        // --- Test 4: Another sequential step from the jumped-to address ---
        pc_next = 32'h0000_1004;
        check_pc(32'h0000_1004, "Sequential +4 after jump");

        // --- Test 5: Mid-operation reset ---
        rst = 1;
        @(posedge clk);
        #1;
        checks = checks + 1;
        if (pc_out !== 32'h0) begin
            errors = errors + 1;
            $display("[FAIL] Mid-op reset: expected pc_out=0x00000000, got 0x%08h at time %0t",
                      pc_out, $time);
        end else begin
            $display("[PASS] Mid-op reset: pc_out=0x%08h at time %0t", pc_out, $time);
        end
        rst = 0;

        // --- Test 6: Wraparound-style large address ---
        pc_next = 32'hFFFF_FFFC;
        check_pc(32'hFFFF_FFFC, "Large address update");

        // --- Test 7: Double jump (two jumps back-to-back, no sequential step between) ---
        pc_next = 32'h0000_2000;
        check_pc(32'h0000_2000, "First Jump");

        pc_next = 32'h0000_3000;
        check_pc(32'h0000_3000, "Second Jump");

        // --- Summary ---
        $display("--------------------------------------------------");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED", checks);
        else
            $display("%0d OF %0d CHECKS FAILED", errors, checks);
        $display("--------------------------------------------------");

        $finish;
    end

endmodule