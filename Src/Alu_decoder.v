module Alu_decoder(
    input [5:0] funct,
    input [1:0] Alu_op,
    output reg [2:0]  Alu_control
);
    always@(*) begin
        if(Alu_op == 0 )
            Alu_control = 3'b010; //add
        else if(Alu_op == 1)
            Alu_control = 3'b100; //sub
        else if(Alu_op == 2)
        begin
            case(funct)
                6'b100000: Alu_control = 3'b010; //add
                6'b100010: Alu_control = 3'b100; //sub
                6'b101010: Alu_control = 3'b110; //and
                6'b011100: Alu_control = 3'b101; //slt
                default: Alu_control = 3'b010;
            endcase
        end
        else
            Alu_control = 3'b010;
    end
endmodule