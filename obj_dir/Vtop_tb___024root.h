// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop_tb.h for the primary calling header

#ifndef VERILATED_VTOP_TB___024ROOT_H_
#define VERILATED_VTOP_TB___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vtop_tb__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vtop_tb___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ top_tb__DOT__clk;
    CData/*0:0*/ top_tb__DOT__rst;
    CData/*0:0*/ top_tb__DOT__dut__DOT__reg_write;
    CData/*0:0*/ top_tb__DOT__dut__DOT__alu_src;
    CData/*0:0*/ top_tb__DOT__dut__DOT__branch;
    CData/*3:0*/ top_tb__DOT__dut__DOT__alu_ctrl;
    CData/*6:0*/ top_tb__DOT__dut__DOT__opcode;
    CData/*4:0*/ top_tb__DOT__dut__DOT__rd_addr;
    CData/*2:0*/ top_tb__DOT__dut__DOT__funct3;
    CData/*4:0*/ top_tb__DOT__dut__DOT__rs1_addr;
    CData/*4:0*/ top_tb__DOT__dut__DOT__rs2_addr;
    CData/*0:0*/ top_tb__DOT__dut__DOT__funct7_b5;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__top_tb__DOT__clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__top_tb__DOT__rst__0;
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ top_tb__DOT__errors;
    IData/*31:0*/ top_tb__DOT__checks;
    IData/*31:0*/ top_tb__DOT__dut__DOT__pc_out;
    IData/*31:0*/ top_tb__DOT__dut__DOT__pc_next;
    IData/*31:0*/ top_tb__DOT__dut__DOT__instr;
    IData/*31:0*/ top_tb__DOT__dut__DOT__rs1_data;
    IData/*31:0*/ top_tb__DOT__dut__DOT__alu_b;
    IData/*31:0*/ top_tb__DOT__dut__DOT__alu_result;
    IData/*31:0*/ top_tb__DOT__dut__DOT__imm;
    IData/*31:0*/ top_tb__DOT__dut__DOT__imem_inst__DOT__i;
    IData/*31:0*/ top_tb__DOT__dut__DOT__regfile_inst__DOT__i;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<IData/*31:0*/, 256> top_tb__DOT__dut__DOT__imem_inst__DOT__mem;
    VlUnpacked<IData/*31:0*/, 32> top_tb__DOT__dut__DOT__regfile_inst__DOT__registers;
    VlUnpacked<CData/*0:0*/, 4> __Vm_traceActivity;
    VlDelayScheduler __VdlySched;
    VlTriggerScheduler __VtrigSched_h5710a71e__0;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<3> __VactTriggered;
    VlTriggerVec<3> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vtop_tb__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtop_tb___024root(Vtop_tb__Syms* symsp, const char* v__name);
    ~Vtop_tb___024root();
    VL_UNCOPYABLE(Vtop_tb___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
