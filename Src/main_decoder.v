module main_decoder(
    input [5:0] opcode,
    output reg mem_write, reg_write,
    output reg reg_dest, alu_src,
    output reg memtoreg, branch, jump,
    output reg [1:0] alu_op
);
    
    always@(*) begin
        alu_op = 2'b00;
        mem_write = 1'b0;
        reg_write = 1'b0;
        reg_dest = 1'b0;
        alu_src = 1'b0;
        memtoreg = 1'b0;
        branch = 1'b0;
        jump = 1'b0;
        
        case(opcode)
            6'b000000: begin
                         alu_op = 2'b10;
                         reg_write = 1'b1;
                         reg_dest = 1'b1;
                       end
                       
            6'b100011: begin
                         alu_src = 1'b1;
                         reg_write = 1'b1;
                         memtoreg = 1'b1;
                       end
                       
            6'b101011: begin
                          mem_write = 1'b1;
                          alu_src = 1'b1;
                          memtoreg = 1'b1;
                       end
                       
            6'b000100: begin
                         alu_op = 2'b01;
                         branch = 1'b1; 
                       end
                       
            6'b001000: begin
                         reg_write = 1'b1;
                         alu_src = 1'b1;
                       end
                                             
            6'b000010: begin
                         jump = 1'b1;
                       end
                       
            default: begin
                         alu_op = 2'b00;
                         mem_write = 1'b0;
                         reg_write = 1'b0;
                         reg_dest = 1'b0;
                         alu_src = 1'b0;
                         memtoreg = 1'b0;
                         branch = 1'b0;
                         jump = 1'b0;
                     end
        endcase 
    end

endmodule