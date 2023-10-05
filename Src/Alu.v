module Alu #(parameter N = 32)(
    input [N-1 : 0] A, B,
    input [2:0] sel,
    output reg [N-1 : 0] out,
    output reg zero
);
    always@(*) begin
    case(sel)
        3'b000: out = A & B;
        3'b001: out = A | B;
        3'b010: out = A + B;
        3'b100: out = A - B;
        3'b101: out = A * B;
        3'b110: begin 
                  if(A<B)
                        out = 32'b1;
                  else
                        out = 32'b0;
                end
        
        default: out = 32'b0;   
    endcase
    end

    always@(*)
    begin
        if(out == 0)
            zero = 1;
        else
            zero = 0;
    end
    
endmodule