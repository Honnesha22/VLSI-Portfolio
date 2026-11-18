module alu_control (
    input  [1:0] ALUOp,
    input  [2:0] funct3,
    input        funct7_5,
    output reg [3:0] ALU_Control
);

    always @(*) begin
        case (ALUOp)

            2'b00: ALU_Control = 4'b0000; // ADD
            2'b01: ALU_Control = 4'b0001; // SUB

            2'b10: begin
                case (funct3)
                    3'b000:
                        ALU_Control = funct7_5 ? 4'b0001 : 4'b0000;
                    3'b111: ALU_Control = 4'b0010; // AND
                    3'b110: ALU_Control = 4'b0011; // OR
                    3'b100: ALU_Control = 4'b0100; // XOR
                    3'b010: ALU_Control = 4'b0101; // SLT
                    default: ALU_Control = 4'b0000;
                endcase
            end

            default: ALU_Control = 4'b0000;

        endcase
    end

endmodule
