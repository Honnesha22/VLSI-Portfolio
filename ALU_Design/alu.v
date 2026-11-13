module alu (
    input  [3:0] A,
    input  [3:0] B,
    input  [2:0] sel,
    output reg [4:0] result
);

always @(*) begin

    case (sel)

        3'b000: result = A + B;
        3'b001: result = {1'b0, A} - {1'b0, B};
        3'b010: result = {1'b0, A & B};
        3'b011: result = {1'b0, A | B};
        3'b100: result = {1'b0, A ^ B};
        3'b101: result = {1'b0, ~A};

        default: result = 5'b00000;

    endcase

end

endmodule
