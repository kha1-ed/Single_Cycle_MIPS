module controller(
    input [5:0] funct, opcode,
    output mem_write, reg_write,
    output reg_dest, alu_src,
    output memtoreg, jump,
    output pcsrc, zero,
    output [2:0] Alu_control
);
    wire [1:0] Alu_op;
    wire branch;

    main_decoder mde1(
        .opcode(opcode),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .reg_dest(reg_dest),
        .alu_src(alu_src),
        .memtoreg(memtoreg),
        .branch(branch),
        .jump(jump),
        .alu_op(Alu_op)
    );
    
    Alu_decoder alucont1(
        .funct(funct),
        .Alu_op(Alu_op),
        .Alu_control(Alu_control)
    );
    
    assign pcsrc = branch & zero;

endmodule