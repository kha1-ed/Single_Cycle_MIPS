`timescale 1ns / 1ps

module Mips_Top(
    input clk, reset,
    output [15:0] test_value
    );
    
    wire mem_write, reg_write;
    wire reg_dest, alu_src;
    wire memtoreg, jump;
    wire pcsrc, zero;
    wire [2:0] Alu_control;
    wire [31:0] instr;
    wire [31:0] PC;
    wire [31:0] Alu_Result;
    wire [31:0] Witre_data;
    wire [31:0] Read_data;
    
    
    data_path datapath(
        .clk(clk),
        .reset(reset),
        .reg_write(reg_write),
        .reg_dest(reg_dest),
        .alu_src(alu_src),
        .pcsrc(pcsrc),
        .memtoreg(memtoreg),
        .jump(jump),
        .Alu_control(Alu_control),
        .read_data(Read_data),
        .instr(instr),
        .PC(PC),
        .Alu_Result(Alu_Result),
        .Witre_data(Witre_data),
        .zero(zero)
    );
    
    
    controller controll(
        .funct(instr [5:0]),
        .opcode(instr [31:26]),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .reg_dest(reg_dest),
        .alu_src(alu_src),
        .memtoreg(memtoreg),
        .jump(jump),
        .pcsrc(pcsrc),
        .zero(zero),
        .Alu_control(Alu_control)
    );
    
    instruction_memory inst_mem(
        .A(PC),
        .RD(instr)
    );
    
    Data_Memory DAta_mem(
        .clk(clk),
        .reset(reset),
        .WE(mem_write),
        .A(Alu_Result),
        .WD(Witre_data),
        .RD(Read_data),
        .test_value(test_value)
    );
endmodule
