module branch_adder (
    input  [31:0] PC,
    input  [31:0] Immediate,
    output [31:0] Branch_Target
);

    assign Branch_Target = PC + Immediate;

endmodule
