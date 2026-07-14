# RISC-V CPU (RV32I, Single-Cycle)

A single-cycle RISC-V (RV32I) processor built in Verilog. Each module (PC, register file, instruction memory, ALU, immediate generator, control unit) has its own self-checking Verilator testbench, plus a full-CPU testbench that runs a small hand-written program end to end.

## Currently supports
- R-type instructions (add, sub, and, or, xor, slt, sltu, sll, srl, sra)
- I-type arithmetic instructions (addi, andi, ori, xori, slti, sltiu, slli, srli, srai)
- Branch instructions (beq, bne)

## Not yet implemented
- Loads/stores and data memory
- jal / jalr
- lui / auipc
- FPGA deployment (currently simulation-only)
- C firmware / toolchain integration

## Project structure
```
rtl/    - Verilog source modules
tb/     - Testbenches (one per module, plus a full-CPU test)
```

## Running the tests
```bash
verilator --binary -j 0 --trace rtl/regfile.v tb/regfile_tb.v --top-module regfile_tb
./obj_dir/Vregfile_tb
```

Full CPU test:
```bash
verilator --binary -j 0 --trace rtl/pc.v rtl/imem.v rtl/regfile.v rtl/immgen.v rtl/control.v rtl/alu.v rtl/top.v tb/top_tb.v --top-module top_tb
./obj_dir/Vtop_tb
```
