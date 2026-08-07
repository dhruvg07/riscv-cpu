`timescale 1ns / 1ps

module dmem_tb;

    reg         clk;
    reg  [31:0] addr, write_data;
    reg         mem_write;
    wire [31:0] read_data;

    integer errors = 0;
    integer checks = 0;

    dmem #(.MEM_SIZE_WORDS(256)) dut (
        .clk        (clk),
        .addr       (addr),
        .write_data (write_data),
        .mem_write  (mem_write),
        .read_data  (read_data)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    task check_read(input [31:0] expected, input string label);
        begin
            #1;
            checks = checks + 1;
            if (read_data !== expected) begin
                errors = errors + 1;
                $display("[FAIL] %0s: expected 0x%08h, got 0x%08h", label, expected, read_data);
            end else begin
                $display("[PASS] %0s: read_data=0x%08h", label, read_data);
            end
        end
    endtask

    initial begin
        mem_write = 0;

        // Unwritten address reads as zero
        addr = 32'h00;
        check_read(32'h0, "Unwritten word reads zero");

        // Basic write then read back
        addr       = 32'h00;
        write_data = 32'hDEAD_BEEF;
        mem_write  = 1;
        @(posedge clk);
        #1;
        mem_write = 0;
        check_read(32'hDEAD_BEEF, "Write/read back word 0");

        // A different word isn't disturbed by that write
        addr = 32'h04;
        check_read(32'h0, "Word 4 unaffected by writing word 0");

        // Write with mem_write=0 should not actually write
        addr       = 32'h08;
        write_data = 32'hFFFF_FFFF;
        mem_write  = 0;
        @(posedge clk);
        #1;
        check_read(32'h0, "mem_write=0 means no write happens");

        // Overwrite an existing word
        addr       = 32'h00;
        write_data = 32'h1111_1111;
        mem_write  = 1;
        @(posedge clk);
        #1;
        mem_write = 0;
        check_read(32'h1111_1111, "Word 0 overwritten with new value");

        // Write doesn't take effect until the clock edge (same timing check
        // as regfile_tb -- proves the read is truly combinational)
        addr       = 32'h0C;
        write_data = 32'hCAFE_CAFE;
        mem_write  = 1;
        #1;
        checks = checks + 1;
        if (read_data !== 32'h0) begin
            errors = errors + 1;
            $display("[FAIL] Pre-edge: expected old value 0x0, got 0x%08h", read_data);
        end else begin
            $display("[PASS] Pre-edge: word 0xC still old value before clock edge");
        end
        @(posedge clk);
        #1;
        mem_write = 0;
        check_read(32'hCAFE_CAFE, "Post-edge: word 0xC now holds new value");

        $display("--------------------------------------------------");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED", checks);
        else
            $display("%0d OF %0d CHECKS FAILED", errors, checks);
        $display("--------------------------------------------------");

        $finish;
    end

endmodule