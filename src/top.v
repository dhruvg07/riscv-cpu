`timescale 1ns / 1ps

module top (
    input  wire       clk,
    input  wire       rst,
    output wire [7:0] led
);

    localparam LED_ADDR = 32'h1000_0000;

    wire [31:0] pc_out, pc_plus_4, pc_next, pc_target;
    wire [31:0] instr;
    wire [31:0] rs1_data, rs2_data, alu_b, alu_result, imm;
    wire [31:0] dmem_read_data, reg_write_data;
    wire        reg_write, alu_src, branch, zero, branch_taken;
    wire        mem_read, mem_write, jump, jump_reg;
    wire [3:0]  alu_ctrl;

    wire [6:0] opcode    = instr[6:0];
    wire [4:0] rd_addr   = instr[11:7];
    wire [2:0] funct3    = instr[14:12];
    wire [4:0] rs1_addr  = instr[19:15];
    wire [4:0] rs2_addr  = instr[24:20];
    wire       funct7_b5 = instr[30];

    // Address decode: stores to LED_ADDR go to the LED peripheral instead
    // of data memory, so only one of these should ever be asserted at once.
    wire is_led_addr  = (alu_result == LED_ADDR);
    wire dmem_write   = mem_write & ~is_led_addr;
    wire led_write    = mem_write & is_led_addr;

    pc pc_inst (
        .clk     (clk),
        .rst     (rst),
        .pc_next (pc_next),
        .pc_out  (pc_out)
    );

    imem imem_inst (
        .addr  (pc_out),
        .instr (instr)
    );

    regfile regfile_inst (
        .clk       (clk),
        .rst       (rst),
        .rs1_addr  (rs1_addr),
        .rs1_data  (rs1_data),
        .rs2_addr  (rs2_addr),
        .rs2_data  (rs2_data),
        .reg_write (reg_write),
        .rd_addr   (rd_addr),
        .rd_data   (reg_write_data)
    );

    immgen immgen_inst (
        .instr (instr),
        .imm   (imm)
    );

    control control_inst (
        .opcode    (opcode),
        .funct3    (funct3),
        .funct7_b5 (funct7_b5),
        .reg_write (reg_write),
        .alu_src   (alu_src),
        .branch    (branch),
        .mem_read  (mem_read),
        .mem_write (mem_write),
        .jump      (jump),
        .jump_reg  (jump_reg),
        .alu_ctrl  (alu_ctrl)
    );

    assign alu_b = alu_src ? imm : rs2_data;

    alu alu_inst (
        .a        (rs1_data),
        .b        (alu_b),
        .alu_ctrl (alu_ctrl),
        .result   (alu_result),
        .zero     (zero)
    );

    dmem dmem_inst (
        .clk        (clk),
        .addr       (alu_result),
        .write_data (rs2_data),
        .mem_write  (dmem_write),
        .read_data  (dmem_read_data)
    );

    led_output led_inst (
        .clk        (clk),
        .rst        (rst),
        .addr       (alu_result),
        .write_data (rs2_data),
        .write_en   (led_write),
        .led        (led)
    );

    // Write-back mux: loaded value, return address (jal/jalr), or ALU result
    assign reg_write_data = mem_read        ? dmem_read_data :
                             (jump|jump_reg) ? pc_plus_4 :
                                                alu_result;

    assign pc_plus_4    = pc_out + 32'd4;
    assign pc_target    = pc_out + imm;           // used by taken branches and jal
    assign branch_taken = branch & (zero ^ funct3[0]); // beq: funct3[0]=0, bne: funct3[0]=1

    // PC mux: jal -> PC+imm, jalr -> rs1+imm (already in alu_result),
    // taken branch -> PC+imm, otherwise -> PC+4
    assign pc_next = jump             ? pc_target :
                      jump_reg        ? alu_result :
                      branch_taken    ? pc_target :
                                        pc_plus_4;

endmodule