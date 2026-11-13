`timescale 1ns/1ps

module alu_tb;

reg [3:0] A, B;
reg [2:0] sel;
wire [4:0] result;

alu uut (
    .A(A),
    .B(B),
    .sel(sel),
    .result(result)
);

initial begin

    $dumpfile("alu.vcd");
    $dumpvars(0, alu_tb);

    A = 4'd5;
    B = 4'd3;

    sel = 3'b000;
    #10;
    $display("ADD: %d", result);

    sel = 3'b001;
    #10;
    $display("SUB: %d", result);

    sel = 3'b010;
    #10;
    $display("AND: %d", result);

    sel = 3'b011;
    #10;
    $display("OR: %d", result);

    sel = 3'b100;
    #10;
    $display("XOR: %d", result);

    sel = 3'b101;
    #10;
    $display("NOT: %d", result);

    $finish;

end

endmodule
