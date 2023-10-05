module instruction_memory(
    input [31:0] A,
    output reg [31:0] RD
);
    reg [31:0] memory [0:255];
    
    /*
    initial begin
    memory [0] = 32'h00008020;    
    memory [1] = 32'h20100078;      
    memory [2] = 32'h00008820;  
    memory [3] = 32'h201100B4;     
    memory [4] = 32'h00009020;      
    memory [5] = 32'h12110006;     
    memory [6] = 32'h0211482A;      
    memory [7] = 32'h11200002;     
    memory [8] = 32'h02308822;      
    memory [9] = 32'h08000005;     
    memory [10] = 32'h02118022;   
    memory [11] = 32'h08000005;     
    memory [12] = 32'h00109020;     
    memory [13] = 32'hAC120000;
    end
    */
    
    initial begin
    memory[0] = 32'h0000_8020;
    memory[1] = 32'h2010_0007;
    memory[2] = 32'h0000_8820;
    memory[3] = 32'h2011_0001;
    memory[4] = 32'h1200_0003;
    memory[5] = 32'h0230_881C;
    memory[6] = 32'h2210_FFFF;
    memory[7] = 32'h0800_0004;
    memory[8] = 32'hAC11_0000;    
    end
    
    always@*
     begin
        RD = memory[A>>2];
     end
     
endmodule