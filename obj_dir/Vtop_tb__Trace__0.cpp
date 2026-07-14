// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtop_tb__Syms.h"


void Vtop_tb___024root__trace_chg_0_sub_0(Vtop_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vtop_tb___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root__trace_chg_0\n"); );
    // Init
    Vtop_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop_tb___024root*>(voidSelf);
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vtop_tb___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vtop_tb___024root__trace_chg_0_sub_0(Vtop_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root__trace_chg_0_sub_0\n"); );
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[1U] 
                     | vlSelfRef.__Vm_traceActivity
                     [3U]))) {
        bufp->chgIData(oldp+0,(vlSelfRef.top_tb__DOT__dut__DOT__instr),32);
        bufp->chgIData(oldp+1,(vlSelfRef.top_tb__DOT__dut__DOT__rs1_data),32);
        bufp->chgIData(oldp+2,(vlSelfRef.top_tb__DOT__dut__DOT__alu_b),32);
        bufp->chgIData(oldp+3,(vlSelfRef.top_tb__DOT__dut__DOT__alu_result),32);
        bufp->chgIData(oldp+4,(vlSelfRef.top_tb__DOT__dut__DOT__imm),32);
        bufp->chgBit(oldp+5,(vlSelfRef.top_tb__DOT__dut__DOT__reg_write));
        bufp->chgBit(oldp+6,(vlSelfRef.top_tb__DOT__dut__DOT__alu_src));
        bufp->chgBit(oldp+7,(vlSelfRef.top_tb__DOT__dut__DOT__branch));
        bufp->chgBit(oldp+8,((0U == vlSelfRef.top_tb__DOT__dut__DOT__alu_result)));
        bufp->chgCData(oldp+9,(vlSelfRef.top_tb__DOT__dut__DOT__alu_ctrl),4);
        bufp->chgCData(oldp+10,(vlSelfRef.top_tb__DOT__dut__DOT__opcode),7);
        bufp->chgCData(oldp+11,(vlSelfRef.top_tb__DOT__dut__DOT__rd_addr),5);
        bufp->chgCData(oldp+12,(vlSelfRef.top_tb__DOT__dut__DOT__funct3),3);
        bufp->chgCData(oldp+13,(vlSelfRef.top_tb__DOT__dut__DOT__rs1_addr),5);
        bufp->chgCData(oldp+14,(vlSelfRef.top_tb__DOT__dut__DOT__rs2_addr),5);
        bufp->chgBit(oldp+15,(vlSelfRef.top_tb__DOT__dut__DOT__funct7_b5));
    }
    if (VL_UNLIKELY(vlSelfRef.__Vm_traceActivity[2U])) {
        bufp->chgIData(oldp+16,(vlSelfRef.top_tb__DOT__dut__DOT__pc_out),32);
        bufp->chgIData(oldp+17,(((IData)(4U) + vlSelfRef.top_tb__DOT__dut__DOT__pc_out)),32);
        bufp->chgIData(oldp+18,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[0]),32);
        bufp->chgIData(oldp+19,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[1]),32);
        bufp->chgIData(oldp+20,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[2]),32);
        bufp->chgIData(oldp+21,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[3]),32);
        bufp->chgIData(oldp+22,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[4]),32);
        bufp->chgIData(oldp+23,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[5]),32);
        bufp->chgIData(oldp+24,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[6]),32);
        bufp->chgIData(oldp+25,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[7]),32);
        bufp->chgIData(oldp+26,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[8]),32);
        bufp->chgIData(oldp+27,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[9]),32);
        bufp->chgIData(oldp+28,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[10]),32);
        bufp->chgIData(oldp+29,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[11]),32);
        bufp->chgIData(oldp+30,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[12]),32);
        bufp->chgIData(oldp+31,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[13]),32);
        bufp->chgIData(oldp+32,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[14]),32);
        bufp->chgIData(oldp+33,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[15]),32);
        bufp->chgIData(oldp+34,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[16]),32);
        bufp->chgIData(oldp+35,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[17]),32);
        bufp->chgIData(oldp+36,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[18]),32);
        bufp->chgIData(oldp+37,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[19]),32);
        bufp->chgIData(oldp+38,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[20]),32);
        bufp->chgIData(oldp+39,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[21]),32);
        bufp->chgIData(oldp+40,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[22]),32);
        bufp->chgIData(oldp+41,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[23]),32);
        bufp->chgIData(oldp+42,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[24]),32);
        bufp->chgIData(oldp+43,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[25]),32);
        bufp->chgIData(oldp+44,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[26]),32);
        bufp->chgIData(oldp+45,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[27]),32);
        bufp->chgIData(oldp+46,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[28]),32);
        bufp->chgIData(oldp+47,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[29]),32);
        bufp->chgIData(oldp+48,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[30]),32);
        bufp->chgIData(oldp+49,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers[31]),32);
        bufp->chgIData(oldp+50,(vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__i),32);
    }
    bufp->chgBit(oldp+51,(vlSelfRef.top_tb__DOT__clk));
    bufp->chgBit(oldp+52,(vlSelfRef.top_tb__DOT__rst));
    bufp->chgIData(oldp+53,(vlSelfRef.top_tb__DOT__errors),32);
    bufp->chgIData(oldp+54,(vlSelfRef.top_tb__DOT__checks),32);
    bufp->chgIData(oldp+55,((((IData)(vlSelfRef.top_tb__DOT__dut__DOT__branch) 
                              & ((0U == vlSelfRef.top_tb__DOT__dut__DOT__alu_result) 
                                 ^ (vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem
                                    [(0xffU & (vlSelfRef.top_tb__DOT__dut__DOT__pc_out 
                                               >> 2U))] 
                                    >> 0xcU))) ? (vlSelfRef.top_tb__DOT__dut__DOT__imm 
                                                  + vlSelfRef.top_tb__DOT__dut__DOT__pc_out)
                              : ((IData)(4U) + vlSelfRef.top_tb__DOT__dut__DOT__pc_out))),32);
    bufp->chgIData(oldp+56,((vlSelfRef.top_tb__DOT__dut__DOT__imm 
                             + vlSelfRef.top_tb__DOT__dut__DOT__pc_out)),32);
    bufp->chgIData(oldp+57,(((0U == (IData)(vlSelfRef.top_tb__DOT__dut__DOT__rs2_addr))
                              ? 0U : vlSelfRef.top_tb__DOT__dut__DOT__regfile_inst__DOT__registers
                             [vlSelfRef.top_tb__DOT__dut__DOT__rs2_addr])),32);
    bufp->chgBit(oldp+58,(((IData)(vlSelfRef.top_tb__DOT__dut__DOT__branch) 
                           & ((0U == vlSelfRef.top_tb__DOT__dut__DOT__alu_result) 
                              ^ (vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__mem
                                 [(0xffU & (vlSelfRef.top_tb__DOT__dut__DOT__pc_out 
                                            >> 2U))] 
                                 >> 0xcU)))));
    bufp->chgIData(oldp+59,(vlSelfRef.top_tb__DOT__dut__DOT__imem_inst__DOT__i),32);
}

void Vtop_tb___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_tb___024root__trace_cleanup\n"); );
    // Init
    Vtop_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop_tb___024root*>(voidSelf);
    Vtop_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[3U] = 0U;
}
