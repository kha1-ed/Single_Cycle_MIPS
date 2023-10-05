module Data_Memory(
    input clk, reset,
    input WE,
    input [31:0] A, WD,
    output reg [31:0] RD,
    output reg [15:0] test_value
);
    reg [31:0] memory [255:0];
    
    integer k;
    
    always@(posedge clk, negedge reset) begin
        if(reset == 0) begin
            for(k=0;k<256;k=k+1)
                begin
                   memory[k] <= 32'b0;
                end
                        end
        else if(WE)
                memory[A] <= WD;             
                                         end

    always@* 
     begin
        RD = memory[A];
        test_value = memory[0];
     end

endmodule