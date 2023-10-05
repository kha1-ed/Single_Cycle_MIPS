`timescale 1ns / 1ps

module MIPS_Tb();
    reg clk;
    reg reset;
    wire test_value;

    Mips_Top DUT (
    .clk(clk),
    .reset(reset),
    .test_value(test_value)
    );
    
    always #10 clk = !clk;
        initial begin
        clk = 1;
        reset = 0;
        #20
        reset = 1;
        #1000
        $stop;
        end
        
endmodule