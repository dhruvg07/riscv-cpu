`timescale 1ns / 1ps

module led_output (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] addr,
    input  wire [31:0] write_data,
    input  wire        write_en,
    output reg  [7:0]  led
);

    localparam LED_ADDR = 32'h1000_0000; // reserved peripheral address

    always @(posedge clk or posedge rst) begin
        if (rst)
            led <= 8'b0;
        else if (write_en && addr == LED_ADDR)
            led <= write_data[7:0]; // only bottom 8 bits drive the LEDs
    end

endmodule