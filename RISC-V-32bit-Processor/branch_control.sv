module branch_control (
    input Branch,
    input Zero,
    output PCSrc
);

    assign PCSrc = Branch & Zero;

endmodule
