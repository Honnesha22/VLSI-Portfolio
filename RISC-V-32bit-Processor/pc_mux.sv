module pc_mux (
    input  [31:0] PC,
    input  [31:0] Branch_Target,
    input         PCSrc,
    output [31:0] Next_PC
);

    assign Next_PC = PCSrc ? Branch_Target : PC + 4;

endmodule
