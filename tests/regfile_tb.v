`timescale 1ns / 1ps

module regfile_tb;

    reg         clk;
    reg         rst;
    reg  [4:0]  rs1_addr;
    reg  [4:0]  rs2_addr;
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    reg         reg_write;
    reg  [4:0]  rd_addr;
    reg  [31:0] rd_data;

    integer     errors = 0;
    integer     checks = 0;

    regfile dut (
        .clk       (clk),
        .rst       (rst),
        .rs1_addr  (rs1_addr),
        .rs1_data  (rs1_data),
        .rs2_addr  (rs2_addr),
        .rs2_data  (rs2_data),
        .reg_write (reg_write),
        .rd_addr   (rd_addr),
        .rd_data   (rd_data)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    // Writes a value into a register on the next clock edge
    task do_write(input [4:0] addr, input [31:0] data);
        begin
            rd_addr   = addr;
            rd_data   = data;
            reg_write = 1;
            @(posedge clk);
            #1;
            reg_write = 0;
        end
    endtask

    // Checks that a given register currently reads back the expected value
    // via read port 1 (combinational -- no clock edge needed to see it)
    task check_read(input [4:0] addr, input [31:0] expected, input string label);
        begin
            rs1_addr = addr;
            #1; // allow combinational logic to settle
            checks = checks + 1;
            if (rs1_data !== expected) begin
                errors = errors + 1;
                $display("[FAIL] %0s: reg[%0d] expected 0x%08h, got 0x%08h at time %0t",
                          label, addr, expected, rs1_data, $time);
            end else begin
                $display("[PASS] %0s: reg[%0d] = 0x%08h at time %0t",
                          label, addr, rs1_data, $time);
            end
        end
    endtask

    initial begin
        $dumpfile("regfile_tb.vcd");
        $dumpvars(0, regfile_tb);

        // --- Test 1: Reset clears all registers ---
        rst       = 1;
        reg_write = 0;
        rd_addr   = 5'd0;
        rd_data   = 32'd0;
        rs1_addr  = 5'd5;
        rs2_addr  = 5'd10;
        @(posedge clk);
        #1;
        checks = checks + 1;
        if (rs1_data !== 32'b0 || rs2_data !== 32'b0) begin
            errors = errors + 1;
            $display("[FAIL] Reset: expected both read ports 0, got rs1=0x%08h rs2=0x%08h",
                      rs1_data, rs2_data);
        end else begin
            $display("[PASS] Reset: all registers cleared");
        end
        rst = 0;

        // --- Test 2: Basic write then read back ---
        do_write(5'd1, 32'hDEAD_BEEF);
        check_read(5'd1, 32'hDEAD_BEEF, "Write/read x1");

        // --- Test 3: x0 always reads zero, even if we try to write it ---
        do_write(5'd0, 32'hFFFF_FFFF);
        check_read(5'd0, 32'h0000_0000, "x0 stays zero after attempted write");

        // --- Test 4: Writing a different register doesn't disturb x1 ---
        do_write(5'd2, 32'h1234_5678);
        check_read(5'd1, 32'hDEAD_BEEF, "x1 unaffected by writing x2");
        check_read(5'd2, 32'h1234_5678, "x2 holds its own value");

        // --- Test 5: Both read ports work independently and simultaneously ---
        rs1_addr = 5'd1;
        rs2_addr = 5'd2;
        #1;
        checks = checks + 1;
        if (rs1_data !== 32'hDEAD_BEEF || rs2_data !== 32'h1234_5678) begin
            errors = errors + 1;
            $display("[FAIL] Dual-port read: expected rs1=0xDEADBEEF rs2=0x12345678, got rs1=0x%08h rs2=0x%08h",
                      rs1_data, rs2_data);
        end else begin
            $display("[PASS] Dual-port read: rs1=0x%08h rs2=0x%08h simultaneously", rs1_data, rs2_data);
        end

        // --- Test 6: reg_write deasserted means no write happens ---
        rd_addr   = 5'd3;
        rd_data   = 32'hAAAA_AAAA;
        reg_write = 0; // deliberately NOT enabling write
        @(posedge clk);
        #1;
        check_read(5'd3, 32'h0000_0000, "x3 unwritten when reg_write=0");

        // --- Test 7: Overwriting an existing register updates it ---
        do_write(5'd1, 32'h0000_0001);
        check_read(5'd1, 32'h0000_0001, "x1 overwritten with new value");

        // --- Test 8: Reading rs1 == rs2 (same register on both ports) ---
        rs1_addr = 5'd2;
        rs2_addr = 5'd2;
        #1;
        checks = checks + 1;
        if (rs1_data !== 32'h1234_5678 || rs2_data !== 32'h1234_5678) begin
            errors = errors + 1;
            $display("[FAIL] Same-register dual read: expected both 0x12345678, got rs1=0x%08h rs2=0x%08h",
                      rs1_data, rs2_data);
        end else begin
            $display("[PASS] Same-register dual read: rs1=rs2=0x%08h", rs1_data);
        end

        // --- Test 9: Checks for old values ---
        rs1_addr = 5'd1;
        rd_addr = 5'd1;
        rd_data = 32'h0000_0011;
        reg_write = 1;

        #1;
        checks = checks + 1;
        if (rs1_data !== 32'h0000_0001) begin
            errors = errors + 1;
            $display("[FAIL] Old value check: expected rs1=0x00000001, got 0x%08h", rs1_data);
        end else begin  
            $display("[PASS] Old value check: rs1=0x%08h", rs1_data);
        end

        @(posedge clk);
        #1;
        reg_write = 0;


        // --- Summary of all checks ---
        checks = checks + 1;
        if (rs1_data !== 32'h0000_0011) begin
            errors = errors + 1;
            $display("[FAIL] New value check: expected rs1=0x00000011, got 0x%08h", rs1_data);
        end else begin
            $display("[PASS] New value check: rs1=0x%08h", rs1_data);
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