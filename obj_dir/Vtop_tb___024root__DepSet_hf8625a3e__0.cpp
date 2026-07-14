// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_tb.h for the primary calling header

#include "Vtop_tb__pch.h"
#include "Vtop_tb__Syms.h"
#include "Vtop_tb___024root.h"

VL_INLINE_OPT VlCoroutine Vtop_tb___024root___eval_initial__TOP__Vtiming__0(Vtop_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root___eval_initial__TOP__Vtiming__0\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*4:0*/ __Vtask_top_tb__DOT__check_reg__0__reg_num;
    __Vtask_top_tb__DOT__check_reg__0__reg_num = 0;
    IData/*31:0*/ __Vtask_top_tb__DOT__check_reg__0__expected;
    __Vtask_top_tb__DOT__check_reg__0__expected = 0;
    std::string __Vtask_top_tb__DOT__check_reg__0__label;
    CData/*4:0*/ __Vtask_top_tb__DOT__check_reg__1__reg_num;
    __Vtask_top_tb__DOT__check_reg__1__reg_num = 0;
    IData/*31:0*/ __Vtask_top_tb__DOT__check_reg__1__expected;
    __Vtask_top_tb__DOT__check_reg__1__expected = 0;
    std::string __Vtask_top_tb__DOT__check_reg__1__label;
    CData/*4:0*/ __Vtask_top_tb__DOT__check_reg__2__reg_num;
    __Vtask_top_tb__DOT__check_reg__2__reg_num = 0;
    IData/*31:0*/ __Vtask_top_tb__DOT__check_reg__2__expected;
    __Vtask_top_tb__DOT__check_reg__2__expected = 0;
    std::string __Vtask_top_tb__DOT__check_reg__2__label;
    CData/*4:0*/ __Vtask_top_tb__DOT__check_reg__3__reg_num;
    __Vtask_top_tb__DOT__check_reg__3__reg_num = 0;
    IData/*31:0*/ __Vtask_top_tb__DOT__check_reg__3__expected;
    __Vtask_top_tb__DOT__check_reg__3__expected = 0;
    std::string __Vtask_top_tb__DOT__check_reg__3__label;
    CData/*4:0*/ __Vtask_top_tb__DOT__check_reg__4__reg_num;
    __Vtask_top_tb__DOT__check_reg__4__reg_num = 0;
    IData/*31:0*/ __Vtask_top_tb__DOT__check_reg__4__expected;
    __Vtask_top_tb__DOT__check_reg__4__expected = 0;
    std::string __Vtask_top_tb__DOT__check_reg__4__label;
    CData/*4:0*/ __Vtask_top_tb__DOT__check_reg__5__reg_num;
    __Vtask_top_tb__DOT__check_reg__5__reg_num = 0;
    IData/*31:0*/ __Vtask_top_tb__DOT__check_reg__5__expected;
    __Vtask_top_tb__DOT__check_reg__5__expected = 0;
    std::string __Vtask_top_tb__DOT__check_reg__5__label;
    VlWide<3>/*95:0*/ __Vtemp_1;
    // Body
    __Vtemp_1[0U] = 0x2e766364U;
    __Vtemp_1[1U] = 0x705f7462U;
    __Vtemp_1[2U] = 0x746fU;
    vlSymsp->_vm_contextp__->dumpfile(VL_CVT_PACK_STR_NW(3, __Vtemp_1));
    vlSymsp->_traceDumpOpen();
    vlSelfRef.top_tb__DOT__rst = 1U;
    vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem[0U] = 0x500093U;
    vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem[1U] = 0xa00113U;
    vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem[2U] = 0x2081b3U;
    vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem[3U] = 0x40110233U;
    vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem[4U] = 0x408463U;
    vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem[5U] = 0x6300293U;
    vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem[6U] = 0x100313U;
    co_await vlSelfRef.__VtrigSched_h5710a71e__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge top_tb.clk)", 
                                                         "tests/top_tb.v", 
                                                         57);
    co_await vlSelfRef.__VdlySched.delay(0x3e8ULL, 
                                         nullptr, "tests/top_tb.v", 
                                         58);
    vlSelfRef.top_tb__DOT__rst = 0U;
    co_await vlSelfRef.__VtrigSched_h5710a71e__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge top_tb.clk)", 
                                                         "tests/top_tb.v", 
                                                         63);
    co_await vlSelfRef.__VtrigSched_h5710a71e__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge top_tb.clk)", 
                                                         "tests/top_tb.v", 
                                                         63);
    co_await vlSelfRef.__VtrigSched_h5710a71e__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge top_tb.clk)", 
                                                         "tests/top_tb.v", 
                                                         63);
    co_await vlSelfRef.__VtrigSched_h5710a71e__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge top_tb.clk)", 
                                                         "tests/top_tb.v", 
                                                         63);
    co_await vlSelfRef.__VtrigSched_h5710a71e__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge top_tb.clk)", 
                                                         "tests/top_tb.v", 
                                                         63);
    co_await vlSelfRef.__VtrigSched_h5710a71e__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge top_tb.clk)", 
                                                         "tests/top_tb.v", 
                                                         63);
    co_await vlSelfRef.__VtrigSched_h5710a71e__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge top_tb.clk)", 
                                                         "tests/top_tb.v", 
                                                         63);
    co_await vlSelfRef.__VdlySched.delay(0x3e8ULL, 
                                         nullptr, "tests/top_tb.v", 
                                         64);
    __Vtask_top_tb__DOT__check_reg__0__label = std::string{"x1 = 5 (addi)"};
    __Vtask_top_tb__DOT__check_reg__0__expected = 5U;
    __Vtask_top_tb__DOT__check_reg__0__reg_num = 1U;
    vlSelfRef.top_tb__DOT__checks = ((IData)(1U) + vlSelfRef.top_tb__DOT__checks);
    if ((vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
         [__Vtask_top_tb__DOT__check_reg__0__reg_num] 
         != __Vtask_top_tb__DOT__check_reg__0__expected)) {
        vlSelfRef.top_tb__DOT__errors = ((IData)(1U) 
                                         + vlSelfRef.top_tb__DOT__errors);
        VL_WRITEF_NX("[FAIL] %0@: x%0# expected 0x%08x, got 0x%08x\n",0,
                     -1,&(__Vtask_top_tb__DOT__check_reg__0__label),
                     5,(IData)(__Vtask_top_tb__DOT__check_reg__0__reg_num),
                     32,__Vtask_top_tb__DOT__check_reg__0__expected,
                     32,vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                     [__Vtask_top_tb__DOT__check_reg__0__reg_num]);
    } else {
        VL_WRITEF_NX("[PASS] %0@: x%0# = 0x%08x\n",0,
                     -1,&(__Vtask_top_tb__DOT__check_reg__0__label),
                     5,(IData)(__Vtask_top_tb__DOT__check_reg__0__reg_num),
                     32,vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                     [__Vtask_top_tb__DOT__check_reg__0__reg_num]);
    }
    __Vtask_top_tb__DOT__check_reg__1__label = std::string{"x2 = 10 (addi)"};
    __Vtask_top_tb__DOT__check_reg__1__expected = 0xaU;
    __Vtask_top_tb__DOT__check_reg__1__reg_num = 2U;
    vlSelfRef.top_tb__DOT__checks = ((IData)(1U) + vlSelfRef.top_tb__DOT__checks);
    if ((vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
         [__Vtask_top_tb__DOT__check_reg__1__reg_num] 
         != __Vtask_top_tb__DOT__check_reg__1__expected)) {
        vlSelfRef.top_tb__DOT__errors = ((IData)(1U) 
                                         + vlSelfRef.top_tb__DOT__errors);
        VL_WRITEF_NX("[FAIL] %0@: x%0# expected 0x%08x, got 0x%08x\n",0,
                     -1,&(__Vtask_top_tb__DOT__check_reg__1__label),
                     5,(IData)(__Vtask_top_tb__DOT__check_reg__1__reg_num),
                     32,__Vtask_top_tb__DOT__check_reg__1__expected,
                     32,vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                     [__Vtask_top_tb__DOT__check_reg__1__reg_num]);
    } else {
        VL_WRITEF_NX("[PASS] %0@: x%0# = 0x%08x\n",0,
                     -1,&(__Vtask_top_tb__DOT__check_reg__1__label),
                     5,(IData)(__Vtask_top_tb__DOT__check_reg__1__reg_num),
                     32,vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                     [__Vtask_top_tb__DOT__check_reg__1__reg_num]);
    }
    __Vtask_top_tb__DOT__check_reg__2__label = std::string{"x3 = 15 (add)"};
    __Vtask_top_tb__DOT__check_reg__2__expected = 0xfU;
    __Vtask_top_tb__DOT__check_reg__2__reg_num = 3U;
    vlSelfRef.top_tb__DOT__checks = ((IData)(1U) + vlSelfRef.top_tb__DOT__checks);
    if ((vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
         [__Vtask_top_tb__DOT__check_reg__2__reg_num] 
         != __Vtask_top_tb__DOT__check_reg__2__expected)) {
        vlSelfRef.top_tb__DOT__errors = ((IData)(1U) 
                                         + vlSelfRef.top_tb__DOT__errors);
        VL_WRITEF_NX("[FAIL] %0@: x%0# expected 0x%08x, got 0x%08x\n",0,
                     -1,&(__Vtask_top_tb__DOT__check_reg__2__label),
                     5,(IData)(__Vtask_top_tb__DOT__check_reg__2__reg_num),
                     32,__Vtask_top_tb__DOT__check_reg__2__expected,
                     32,vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                     [__Vtask_top_tb__DOT__check_reg__2__reg_num]);
    } else {
        VL_WRITEF_NX("[PASS] %0@: x%0# = 0x%08x\n",0,
                     -1,&(__Vtask_top_tb__DOT__check_reg__2__label),
                     5,(IData)(__Vtask_top_tb__DOT__check_reg__2__reg_num),
                     32,vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                     [__Vtask_top_tb__DOT__check_reg__2__reg_num]);
    }
    __Vtask_top_tb__DOT__check_reg__3__label = std::string{"x4 = 5 (sub)"};
    __Vtask_top_tb__DOT__check_reg__3__expected = 5U;
    __Vtask_top_tb__DOT__check_reg__3__reg_num = 4U;
    vlSelfRef.top_tb__DOT__checks = ((IData)(1U) + vlSelfRef.top_tb__DOT__checks);
    if ((vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
         [__Vtask_top_tb__DOT__check_reg__3__reg_num] 
         != __Vtask_top_tb__DOT__check_reg__3__expected)) {
        vlSelfRef.top_tb__DOT__errors = ((IData)(1U) 
                                         + vlSelfRef.top_tb__DOT__errors);
        VL_WRITEF_NX("[FAIL] %0@: x%0# expected 0x%08x, got 0x%08x\n",0,
                     -1,&(__Vtask_top_tb__DOT__check_reg__3__label),
                     5,(IData)(__Vtask_top_tb__DOT__check_reg__3__reg_num),
                     32,__Vtask_top_tb__DOT__check_reg__3__expected,
                     32,vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                     [__Vtask_top_tb__DOT__check_reg__3__reg_num]);
    } else {
        VL_WRITEF_NX("[PASS] %0@: x%0# = 0x%08x\n",0,
                     -1,&(__Vtask_top_tb__DOT__check_reg__3__label),
                     5,(IData)(__Vtask_top_tb__DOT__check_reg__3__reg_num),
                     32,vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                     [__Vtask_top_tb__DOT__check_reg__3__reg_num]);
    }
    __Vtask_top_tb__DOT__check_reg__4__label = std::string{"x5 = 0 (skipped by branch)"};
    __Vtask_top_tb__DOT__check_reg__4__expected = 0U;
    __Vtask_top_tb__DOT__check_reg__4__reg_num = 5U;
    vlSelfRef.top_tb__DOT__checks = ((IData)(1U) + vlSelfRef.top_tb__DOT__checks);
    if ((vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
         [__Vtask_top_tb__DOT__check_reg__4__reg_num] 
         != __Vtask_top_tb__DOT__check_reg__4__expected)) {
        vlSelfRef.top_tb__DOT__errors = ((IData)(1U) 
                                         + vlSelfRef.top_tb__DOT__errors);
        VL_WRITEF_NX("[FAIL] %0@: x%0# expected 0x%08x, got 0x%08x\n",0,
                     -1,&(__Vtask_top_tb__DOT__check_reg__4__label),
                     5,(IData)(__Vtask_top_tb__DOT__check_reg__4__reg_num),
                     32,__Vtask_top_tb__DOT__check_reg__4__expected,
                     32,vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                     [__Vtask_top_tb__DOT__check_reg__4__reg_num]);
    } else {
        VL_WRITEF_NX("[PASS] %0@: x%0# = 0x%08x\n",0,
                     -1,&(__Vtask_top_tb__DOT__check_reg__4__label),
                     5,(IData)(__Vtask_top_tb__DOT__check_reg__4__reg_num),
                     32,vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                     [__Vtask_top_tb__DOT__check_reg__4__reg_num]);
    }
    __Vtask_top_tb__DOT__check_reg__5__label = std::string{"x6 = 1 (branch target reached)"};
    __Vtask_top_tb__DOT__check_reg__5__expected = 1U;
    __Vtask_top_tb__DOT__check_reg__5__reg_num = 6U;
    vlSelfRef.top_tb__DOT__checks = ((IData)(1U) + vlSelfRef.top_tb__DOT__checks);
    if ((vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
         [__Vtask_top_tb__DOT__check_reg__5__reg_num] 
         != __Vtask_top_tb__DOT__check_reg__5__expected)) {
        vlSelfRef.top_tb__DOT__errors = ((IData)(1U) 
                                         + vlSelfRef.top_tb__DOT__errors);
        VL_WRITEF_NX("[FAIL] %0@: x%0# expected 0x%08x, got 0x%08x\n",0,
                     -1,&(__Vtask_top_tb__DOT__check_reg__5__label),
                     5,(IData)(__Vtask_top_tb__DOT__check_reg__5__reg_num),
                     32,__Vtask_top_tb__DOT__check_reg__5__expected,
                     32,vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                     [__Vtask_top_tb__DOT__check_reg__5__reg_num]);
    } else {
        VL_WRITEF_NX("[PASS] %0@: x%0# = 0x%08x\n",0,
                     -1,&(__Vtask_top_tb__DOT__check_reg__5__label),
                     5,(IData)(__Vtask_top_tb__DOT__check_reg__5__reg_num),
                     32,vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                     [__Vtask_top_tb__DOT__check_reg__5__reg_num]);
    }
    VL_WRITEF_NX("--------------------------------------------------\n",0);
    if ((0U == vlSelfRef.top_tb__DOT__errors)) {
        VL_WRITEF_NX("ALL %0d CHECKS PASSED\n",0,32,
                     vlSelfRef.top_tb__DOT__checks);
    } else {
        VL_WRITEF_NX("%0d OF %0d CHECKS FAILED\n",0,
                     32,vlSelfRef.top_tb__DOT__errors,
                     32,vlSelfRef.top_tb__DOT__checks);
    }
    VL_WRITEF_NX("--------------------------------------------------\n",0);
    VL_FINISH_MT("tests/top_tb.v", 80, "");
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop_tb___024root___dump_triggers__act(Vtop_tb___024root* vlSelf);
#endif  // VL_DEBUG

void Vtop_tb___024root___eval_triggers__act(Vtop_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root___eval_triggers__act\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered.set(0U, ((IData)(vlSelfRef.top_tb__DOT__clk) 
                                       & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__top_tb__DOT__clk__0))));
    vlSelfRef.__VactTriggered.set(1U, ((IData)(vlSelfRef.top_tb__DOT__rst) 
                                       & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__top_tb__DOT__rst__0))));
    vlSelfRef.__VactTriggered.set(2U, vlSelfRef.__VdlySched.awaitingCurrentTime());
    vlSelfRef.__Vtrigprevexpr___TOP__top_tb__DOT__clk__0 
        = vlSelfRef.top_tb__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__top_tb__DOT__rst__0 
        = vlSelfRef.top_tb__DOT__rst;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtop_tb___024root___dump_triggers__act(vlSelf);
    }
#endif
}
