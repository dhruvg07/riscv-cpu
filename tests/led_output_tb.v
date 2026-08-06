`timescale 1ns / 1ps

module led_output_tb;

    reg         clk, rst;
    reg  [31:0] addr, write_data;
    reg         write_en;
    wire [7:0]  led;

    integer errors = 0;
    integer checks = 0;

    led_output dut (
        .clk        (clk),
        .rst        (rst),
        .addr       (addr),
        .write_data (write_data),
        .write_en   (write_en),
        .led        (led)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    task check_led(input [7:0] expected, input string label);
        begin
            #1;
            checks = checks + 1;
            if (led !== expected) begin
                errors = errors + 1;
                $display("[FAIL] %0s: expected led=0x%02h, got 0x%02h", label, expected, led);
            end else begin
                $display("[PASS] %0s: led=0x%02h", label, led);
            end
        end
    endtask

    initial begin
        rst = 1; write_en = 0; addr = 0; write_data = 0;
        @(posedge clk);
        #1;
        check_led(8'h00, "Reset clears LEDs");
        rst = 0;

        addr       = 32'h1000_0000;
        write_data = 32'hABCD_1234;
        write_en   = 1;
        @(posedge clk);
        #1;
        write_en = 0;
        check_led(8'h34, "Write to LED address, only bottom byte latched");

        addr       = 32'h0000_0004;
        write_data = 32'hFFFF_FFFF;
        write_en   = 1;
        @(posedge clk);
        #1;
        write_en = 0;
        check_led(8'h34, "Write to non-LED address leaves LEDs unchanged");

        addr       = 32'h1000_0000;
        write_data = 32'h0000_0099;
        write_en   = 0;
        @(posedge clk);
        #1;
        check_led(8'h34, "write_en=0 at LED address has no effect");

        $display("--------------------------------------------------");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED", checks);
        else
            $display("%0d OF %0d CHECKS FAILED", errors, checks);
        $display("--------------------------------------------------");

        $finish;
    end

endmodule