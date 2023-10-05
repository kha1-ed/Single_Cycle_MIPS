module PC #(parameter N = 32)(
    input clk, reset,
    input [N-1:0] Pc_in,
    output reg [N-1:0] Pc_out
);

    always@(posedge clk, negedge reset)
    begin
        if(~reset)
            Pc_out <= 32'b0;
        else
            Pc_out <= Pc_in;
    end

endmodule