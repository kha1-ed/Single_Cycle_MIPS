module data_path(
    input clk, reset,
    input reg_write, reg_dest,
    input alu_src, pcsrc,
    input memtoreg, jump,
    input [2:0] Alu_control,
    input [31:0] read_data, instr,
    output [31:0] PC, Alu_Result,
    output [31:0] Witre_data,
    output zero
);

    wire [4:0] Write_reg;
    wire [31:0] SrcA, SrcB;
    wire [31:0] Result, Signlmm;
    wire [31:0] shift_out1, shift_out2;
    wire [31:0] PcBranch, PcPlus4;
    wire [31:0] mux_4out, mux_Pc;

    //reg_file instantiation
    reg_file regfile1(
        .clk(clk),
        .reset(reset),
        .we3(reg_write),
        .A1(instr[25:21]),
        .A2(instr[20:16]),
        .A3(Write_reg),
        .WD3(Result),
        .RD1(SrcA),
        .RD2(Witre_data)
    );

    //shifter instantiation 1
    left_shifter sh1(
        .x(Signlmm),
        .y(shift_out1)
    );

    //shifter instantiation 2
    left_shifter sh2(
        .x({6'd0 ,instr[25:0]}),
        .y(shift_out2)
    );


    //alu instatiation
    Alu #(.N(32)) ALu1(
        .A(SrcA),
        .B(SrcB),
        .sel(Alu_control),
        .out(Alu_Result),
        .zero(zero)
    );

    //signe exention
    sign_ex sign_ex1(
        .x(instr[15:0]),
        .y(Signlmm)
    );

    // mux number 1
    mux_2N #(.N(32)) mux1(
        .a0(Alu_Result),
        .a1(read_data),
        .sel(memtoreg),
        .y(Result)
    );

    // mux number 2
    mux_2N #(.N(32)) mux2(
        .a0(Witre_data),
        .a1(Signlmm),
        .sel(alu_src),
        .y(SrcB)
    );

    // mux number 3
    mux_2N #(.N(5)) mux3(
        .a0(instr[20:16]),
        .a1(instr[15:11]),
        .sel(reg_dest),
        .y(Write_reg)
    );

    // mux number 4
    mux_2N #(.N(32)) mux4(
        .a0(PcPlus4),
        .a1(PcBranch),
        .sel(pcsrc),
        .y(mux_4out)
    );

    // mux number 5
    mux_2N #(.N(32)) mux5(
        .a0(mux_4out),
        .a1({PcPlus4[31:28] ,shift_out2[27:0]}),
        .sel(jump),
        .y(mux_Pc)
    );

    //adder 1
    adder add1(
        .a(shift_out1),
        .b(PcPlus4),
        .c(PcBranch)
    );

    //adder 2
    adder add2(
        .a(PC),
        .b(32'd4),
        .c(PcPlus4)
    );

    //pc
    PC #(.N(32)) Pcm(
    .clk(clk),
    .reset(reset),
    .Pc_in(mux_Pc),
    .Pc_out(PC)
    );
    
endmodule