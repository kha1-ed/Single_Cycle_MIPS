module mux_2N #(parameter N = 2)(
    input  [N-1:0] a0, a1,
    input sel,
    output [N-1:0] y
);
    assign y = sel ? a1 : a0;
endmodule