// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_tb.h for the primary calling header

#include "Vtop_tb__pch.h"
#include "Vtop_tb___024root.h"

VL_ATTR_COLD void Vtop_tb___024root___eval_initial__TOP(Vtop_tb___024root* vlSelf);
VlCoroutine Vtop_tb___024root___eval_initial__TOP__Vtiming__0(Vtop_tb___024root* vlSelf);
VlCoroutine Vtop_tb___024root___eval_initial__TOP__Vtiming__1(Vtop_tb___024root* vlSelf);

void Vtop_tb___024root___eval_initial(Vtop_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root___eval_initial\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vtop_tb___024root___eval_initial__TOP(vlSelf);
    Vtop_tb___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vtop_tb___024root___eval_initial__TOP__Vtiming__1(vlSelf);
    vlSelfRef.__Vtrigprevexpr___TOP__top_tb__DOT__clk__0 
        = vlSelfRef.top_tb__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__top_tb__DOT__rst__0 
        = vlSelfRef.top_tb__DOT__rst;
}

VL_INLINE_OPT VlCoroutine Vtop_tb___024root___eval_initial__TOP__Vtiming__1(Vtop_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root___eval_initial__TOP__Vtiming__1\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    while (1U) {
        co_await vlSelfRef.__VdlySched.delay(0x1388ULL, 
                                             nullptr, 
                                             "tests/top_tb.v", 
                                             19);
        vlSelfRef.top_tb__DOT__clk = (1U & (~ (IData)(vlSelfRef.top_tb__DOT__clk)));
    }
}

void Vtop_tb___024root___act_comb__TOP__0(Vtop_tb___024root* vlSelf);

void Vtop_tb___024root___eval_act(Vtop_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root___eval_act\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((5ULL & vlSelfRef.__VactTriggered.word(0U))) {
        Vtop_tb___024root___act_comb__TOP__0(vlSelf);
        vlSelfRef.__Vm_traceActivity[1U] = 1U;
    }
}

VL_INLINE_OPT void Vtop_tb___024root___act_comb__TOP__0(Vtop_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root___act_comb__TOP__0\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.top_tb__DOT__dut__DOT__rd_addr = (0x1fU 
                                                & (vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem
                                                   [
                                                   (0xffU 
                                                    & (vlSelfRef.top_tb__DOT__dut__DOT__pc_out 
                                                       >> 2U))] 
                                                   >> 7U));
    vlSelfRef.top_tb__DOT__dut__DOT__rs1_addr = (0x1fU 
                                                 & (vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem
                                                    [
                                                    (0xffU 
                                                     & (vlSelfRef.top_tb__DOT__dut__DOT__pc_out 
                                                        >> 2U))] 
                                                    >> 0xfU));
    vlSelfRef.top_tb__DOT__dut__DOT__funct3 = (7U & 
                                               (vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem
                                                [(0xffU 
                                                  & (vlSelfRef.top_tb__DOT__dut__DOT__pc_out 
                                                     >> 2U))] 
                                                >> 0xcU));
    vlSelfRef.top_tb__DOT__dut__DOT__funct7_b5 = (1U 
                                                  & (vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem
                                                     [
                                                     (0xffU 
                                                      & (vlSelfRef.top_tb__DOT__dut__DOT__pc_out 
                                                         >> 2U))] 
                                                     >> 0x1eU));
    vlSelfRef.top_tb__DOT__dut__DOT__rs2_addr = (0x1fU 
                                                 & (vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem
                                                    [
                                                    (0xffU 
                                                     & (vlSelfRef.top_tb__DOT__dut__DOT__pc_out 
                                                        >> 2U))] 
                                                    >> 0x14U));
    vlSelfRef.top_tb__DOT__dut__DOT__instr = vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem
        [(0xffU & (vlSelfRef.top_tb__DOT__dut__DOT__pc_out 
                   >> 2U))];
    vlSelfRef.top_tb__DOT__dut__DOT__opcode = (0x7fU 
                                               & vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem
                                               [(0xffU 
                                                 & (vlSelfRef.top_tb__DOT__dut__DOT__pc_out 
                                                    >> 2U))]);
    vlSelfRef.top_tb__DOT__dut__DOT__rs1_data = ((0U 
                                                  == (IData)(vlSelfRef.top_tb__DOT__dut__DOT__rs1_addr))
                                                  ? 0U
                                                  : 
                                                 vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                                                 [vlSelfRef.top_tb__DOT__dut__DOT__rs1_addr]);
    vlSelfRef.top_tb__DOT__dut__DOT__imm = ((0x13U 
                                             == (0x7fU 
                                                 & vlSelfRef.top_tb__DOT__dut__DOT__instr))
                                             ? (((- (IData)(
                                                            (vlSelfRef.top_tb__DOT__dut__DOT__instr 
                                                             >> 0x1fU))) 
                                                 << 0xcU) 
                                                | (vlSelfRef.top_tb__DOT__dut__DOT__instr 
                                                   >> 0x14U))
                                             : ((0x63U 
                                                 == 
                                                 (0x7fU 
                                                  & vlSelfRef.top_tb__DOT__dut__DOT__instr))
                                                 ? 
                                                (((- (IData)(
                                                             (vlSelfRef.top_tb__DOT__dut__DOT__instr 
                                                              >> 0x1fU))) 
                                                  << 0xdU) 
                                                 | (((0x1000U 
                                                      & (vlSelfRef.top_tb__DOT__dut__DOT__instr 
                                                         >> 0x13U)) 
                                                     | (0x800U 
                                                        & (vlSelfRef.top_tb__DOT__dut__DOT__instr 
                                                           << 4U))) 
                                                    | ((0x7e0U 
                                                        & (vlSelfRef.top_tb__DOT__dut__DOT__instr 
                                                           >> 0x14U)) 
                                                       | (0x1eU 
                                                          & (vlSelfRef.top_tb__DOT__dut__DOT__instr 
                                                             >> 7U)))))
                                                 : 0U));
    vlSelfRef.top_tb__DOT__dut__DOT__reg_write = ((0x33U 
                                                   == (IData)(vlSelfRef.top_tb__DOT__dut__DOT__opcode)) 
                                                  || (0x13U 
                                                      == (IData)(vlSelfRef.top_tb__DOT__dut__DOT__opcode)));
    vlSelfRef.top_tb__DOT__dut__DOT__branch = ((0x33U 
                                                != (IData)(vlSelfRef.top_tb__DOT__dut__DOT__opcode)) 
                                               && ((0x13U 
                                                    != (IData)(vlSelfRef.top_tb__DOT__dut__DOT__opcode)) 
                                                   && (0x63U 
                                                       == (IData)(vlSelfRef.top_tb__DOT__dut__DOT__opcode))));
    vlSelfRef.top_tb__DOT__dut__DOT__alu_ctrl = ((0x33U 
                                                  == (IData)(vlSelfRef.top_tb__DOT__dut__DOT__opcode))
                                                  ? 
                                                 ((4U 
                                                   & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct3))
                                                   ? 
                                                  ((2U 
                                                    & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct3))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct3))
                                                     ? 2U
                                                     : 3U)
                                                    : 
                                                   ((1U 
                                                     & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct3))
                                                     ? 
                                                    ((IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct7_b5)
                                                      ? 7U
                                                      : 6U)
                                                     : 4U))
                                                   : 
                                                  ((2U 
                                                    & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct3))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct3))
                                                     ? 9U
                                                     : 8U)
                                                    : 
                                                   ((1U 
                                                     & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct3))
                                                     ? 5U
                                                     : 
                                                    ((IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct7_b5)
                                                      ? 1U
                                                      : 0U))))
                                                  : 
                                                 ((0x13U 
                                                   == (IData)(vlSelfRef.top_tb__DOT__dut__DOT__opcode))
                                                   ? 
                                                  ((4U 
                                                    & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct3))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct3))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct3))
                                                      ? 2U
                                                      : 3U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct3))
                                                      ? 
                                                     ((IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct7_b5)
                                                       ? 7U
                                                       : 6U)
                                                      : 4U))
                                                    : 
                                                   ((2U 
                                                     & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct3))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct3))
                                                      ? 9U
                                                      : 8U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__funct3))
                                                      ? 5U
                                                      : 0U)))
                                                   : 
                                                  ((0x63U 
                                                    == (IData)(vlSelfRef.top_tb__DOT__dut__DOT__opcode))
                                                    ? 1U
                                                    : 0U)));
    vlSelfRef.top_tb__DOT__dut__DOT__alu_src = ((0x33U 
                                                 != (IData)(vlSelfRef.top_tb__DOT__dut__DOT__opcode)) 
                                                && (0x13U 
                                                    == (IData)(vlSelfRef.top_tb__DOT__dut__DOT__opcode)));
    vlSelfRef.top_tb__DOT__dut__DOT__alu_b = ((IData)(vlSelfRef.top_tb__DOT__dut__DOT__alu_src)
                                               ? vlSelfRef.top_tb__DOT__dut__DOT__imm
                                               : ((0U 
                                                   == (IData)(vlSelfRef.top_tb__DOT__dut__DOT__rs2_addr))
                                                   ? 0U
                                                   : 
                                                  vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                                                  [vlSelfRef.top_tb__DOT__dut__DOT__rs2_addr]));
    vlSelfRef.top_tb__DOT__dut__DOT__alu_result = (
                                                   (8U 
                                                    & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__alu_ctrl))
                                                    ? 
                                                   ((4U 
                                                     & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__alu_ctrl))
                                                     ? 0U
                                                     : 
                                                    ((2U 
                                                      & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__alu_ctrl))
                                                      ? 0U
                                                      : 
                                                     ((1U 
                                                       & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__alu_ctrl))
                                                       ? 
                                                      ((vlSelfRef.top_tb__DOT__dut__DOT__rs1_data 
                                                        < vlSelfRef.top_tb__DOT__dut__DOT__alu_b)
                                                        ? 1U
                                                        : 0U)
                                                       : 
                                                      (VL_LTS_III(32, vlSelfRef.top_tb__DOT__dut__DOT__rs1_data, vlSelfRef.top_tb__DOT__dut__DOT__alu_b)
                                                        ? 1U
                                                        : 0U))))
                                                    : 
                                                   ((4U 
                                                     & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__alu_ctrl))
                                                     ? 
                                                    ((2U 
                                                      & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__alu_ctrl))
                                                      ? 
                                                     ((1U 
                                                       & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__alu_ctrl))
                                                       ? 
                                                      VL_SHIFTRS_III(32,32,5, vlSelfRef.top_tb__DOT__dut__DOT__rs1_data, 
                                                                     (0x1fU 
                                                                      & vlSelfRef.top_tb__DOT__dut__DOT__alu_b))
                                                       : 
                                                      (vlSelfRef.top_tb__DOT__dut__DOT__rs1_data 
                                                       >> 
                                                       (0x1fU 
                                                        & vlSelfRef.top_tb__DOT__dut__DOT__alu_b)))
                                                      : 
                                                     ((1U 
                                                       & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__alu_ctrl))
                                                       ? 
                                                      (vlSelfRef.top_tb__DOT__dut__DOT__rs1_data 
                                                       << 
                                                       (0x1fU 
                                                        & vlSelfRef.top_tb__DOT__dut__DOT__alu_b))
                                                       : 
                                                      (vlSelfRef.top_tb__DOT__dut__DOT__rs1_data 
                                                       ^ vlSelfRef.top_tb__DOT__dut__DOT__alu_b)))
                                                     : 
                                                    ((2U 
                                                      & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__alu_ctrl))
                                                      ? 
                                                     ((1U 
                                                       & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__alu_ctrl))
                                                       ? 
                                                      (vlSelfRef.top_tb__DOT__dut__DOT__rs1_data 
                                                       | vlSelfRef.top_tb__DOT__dut__DOT__alu_b)
                                                       : 
                                                      (vlSelfRef.top_tb__DOT__dut__DOT__rs1_data 
                                                       & vlSelfRef.top_tb__DOT__dut__DOT__alu_b))
                                                      : 
                                                     ((1U 
                                                       & (IData)(vlSelfRef.top_tb__DOT__dut__DOT__alu_ctrl))
                                                       ? 
                                                      (vlSelfRef.top_tb__DOT__dut__DOT__rs1_data 
                                                       - vlSelfRef.top_tb__DOT__dut__DOT__alu_b)
                                                       : 
                                                      (vlSelfRef.top_tb__DOT__dut__DOT__rs1_data 
                                                       + vlSelfRef.top_tb__DOT__dut__DOT__alu_b)))));
    vlSelfRef.top_tb__DOT__dut__DOT__pc_next = (((IData)(vlSelfRef.top_tb__DOT__dut__DOT__branch) 
                                                 & ((0U 
                                                     == vlSelfRef.top_tb__DOT__dut__DOT__alu_result) 
                                                    ^ 
                                                    (vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem
                                                     [
                                                     (0xffU 
                                                      & (vlSelfRef.top_tb__DOT__dut__DOT__pc_out 
                                                         >> 2U))] 
                                                     >> 0xcU)))
                                                 ? 
                                                (vlSelfRef.top_tb__DOT__dut__DOT__imm 
                                                 + vlSelfRef.top_tb__DOT__dut__DOT__pc_out)
                                                 : 
                                                ((IData)(4U) 
                                                 + vlSelfRef.top_tb__DOT__dut__DOT__pc_out));
}

void Vtop_tb___024root___nba_sequent__TOP__0(Vtop_tb___024root* vlSelf);

void Vtop_tb___024root___eval_nba(Vtop_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root___eval_nba\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((3ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        Vtop_tb___024root___nba_sequent__TOP__0(vlSelf);
        vlSelfRef.__Vm_traceActivity[2U] = 1U;
    }
    if ((7ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        Vtop_tb___024root___act_comb__TOP__0(vlSelf);
        vlSelfRef.__Vm_traceActivity[3U] = 1U;
    }
}

VL_INLINE_OPT void Vtop_tb___024root___nba_sequent__TOP__0(Vtop_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root___nba_sequent__TOP__0\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __VdlySet__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v0;
    __VdlySet__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v0 = 0;
    IData/*31:0*/ __VdlyVal__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v32;
    __VdlyVal__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v32 = 0;
    CData/*4:0*/ __VdlyDim0__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v32;
    __VdlyDim0__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v32 = 0;
    CData/*0:0*/ __VdlySet__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v32;
    __VdlySet__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v32 = 0;
    // Body
    __VdlySet__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v0 = 0U;
    __VdlySet__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v32 = 0U;
    if (vlSelfRef.top_tb__DOT__rst) {
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__i = 0x20U;
        __VdlySet__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v0 = 1U;
        vlSelfRef.top_tb__DOT__dut__DOT__pc_out = 0U;
    } else {
        if (((IData)(vlSelfRef.top_tb__DOT__dut__DOT__reg_write) 
             & (0U != (IData)(vlSelfRef.top_tb__DOT__dut__DOT__rd_addr)))) {
            __VdlyVal__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v32 
                = vlSelfRef.top_tb__DOT__dut__DOT__alu_result;
            __VdlyDim0__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v32 
                = vlSelfRef.top_tb__DOT__dut__DOT__rd_addr;
            __VdlySet__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v32 = 1U;
        }
        vlSelfRef.top_tb__DOT__dut__DOT__pc_out = vlSelfRef.top_tb__DOT__dut__DOT__pc_next;
    }
    if (__VdlySet__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v0) {
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[1U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[2U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[3U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[4U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[5U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[6U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[7U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[8U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[9U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0xaU] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0xbU] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0xcU] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0xdU] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0xeU] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0xfU] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x10U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x11U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x12U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x13U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x14U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x15U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x16U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x17U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x18U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x19U] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x1aU] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x1bU] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x1cU] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x1dU] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x1eU] = 0U;
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0x1fU] = 0U;
    }
    if (__VdlySet__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v32) {
        vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[__VdlyDim0__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v32] 
            = __VdlyVal__top_tb__DOT__dut__DOT__regfile_inst__DOT__registers__v32;
    }
}

void Vtop_tb___024root___timing_resume(Vtop_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root___timing_resume\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VactTriggered.word(0U))) {
        vlSelfRef.__VtrigSched_h5710a71e__0.resume(
                                                   "@(posedge top_tb.clk)");
    }
    if ((4ULL & vlSelfRef.__VactTriggered.word(0U))) {
        vlSelfRef.__VdlySched.resume();
    }
}

void Vtop_tb___024root___timing_commit(Vtop_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root___timing_commit\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((! (1ULL & vlSelfRef.__VactTriggered.word(0U)))) {
        vlSelfRef.__VtrigSched_h5710a71e__0.commit(
                                                   "@(posedge top_tb.clk)");
    }
}

void Vtop_tb___024root___eval_triggers__act(Vtop_tb___024root* vlSelf);

bool Vtop_tb___024root___eval_phase__act(Vtop_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root___eval_phase__act\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    VlTriggerVec<3> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vtop_tb___024root___eval_triggers__act(vlSelf);
    Vtop_tb___024root___timing_commit(vlSelf);
    __VactExecute = vlSelfRef.__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelfRef.__VactTriggered, vlSelfRef.__VnbaTriggered);
        vlSelfRef.__VnbaTriggered.thisOr(vlSelfRef.__VactTriggered);
        Vtop_tb___024root___timing_resume(vlSelf);
        Vtop_tb___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vtop_tb___024root___eval_phase__nba(Vtop_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root___eval_phase__nba\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelfRef.__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vtop_tb___024root___eval_nba(vlSelf);
        vlSelfRef.__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop_tb___024root___dump_triggers__nba(Vtop_tb___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop_tb___024root___dump_triggers__act(Vtop_tb___024root* vlSelf);
#endif  // VL_DEBUG

void Vtop_tb___024root___eval(Vtop_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root___eval\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vtop_tb___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("tests/top_tb.v", 5, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelfRef.__VactIterCount = 0U;
        vlSelfRef.__VactContinue = 1U;
        while (vlSelfRef.__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelfRef.__VactIterCount))) {
#ifdef VL_DEBUG
                Vtop_tb___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("tests/top_tb.v", 5, "", "Active region did not converge.");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
            vlSelfRef.__VactContinue = 0U;
            if (Vtop_tb___024root___eval_phase__act(vlSelf)) {
                vlSelfRef.__VactContinue = 1U;
            }
        }
        if (Vtop_tb___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vtop_tb___024root___eval_debug_assertions(Vtop_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root___eval_debug_assertions\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
