module reg_file(
    input clk, we3, reset,
    input [4:0] A1, A2, A3,
    input [31:0] WD3,
    output reg [31:0] RD1, RD2
);
    reg [31:0] memory [31:0] ;
    integer I ;
  
      //written synchronously
    always @(posedge clk or negedge reset)
    begin
    if(reset==0)   
        begin
          for (I = 0 ; I < 32 ; I = I +1)
            begin
              memory[I] <= 32'b0; 
            end
         end
         
    else if (we3) 
       memory[A3] <= WD3 ;
      
    end 
    
    //read asynchronously
    always @*
    begin
       RD1 = memory[A1] ;
       RD2 = memory[A2] ;
    end

endmodule 
