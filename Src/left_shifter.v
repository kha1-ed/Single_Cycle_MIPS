module left_shifter(
    input [31:0] x,
    output [31:0] y
);
    assign y = x << 2;
endmodule