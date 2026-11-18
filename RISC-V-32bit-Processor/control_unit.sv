
module control_unit (

    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg MemToReg,
    output reg Branch,
    output reg ALUSrc,
    output reg Jump,

    output reg [3:0] ALU_Control

);

always @(*) begin

    // Default values
    RegWrite = 0;
    MemRead = 0;
    MemWrite = 0;
    MemToReg = 0;
    Branch = 0;
    ALUSrc = 0;
    Jump = 0;
    ALU_Control = 4'b0000;

    case (opcode)

        // R-type instructions
        7'b0110011: begin

            RegWrite = 1;

            case (funct3)

                3'b000:
                    ALU_Control = (funct7[5]) ?
                                  4'b0001 : 4'b0000;

                3'b111: ALU_Control = 4'b0010;
                3'b110: ALU_Control = 4'b0011;
                3'b100: ALU_Control = 4'b0100;
                3'b010: ALU_Control = 4'b0101;

                default: RegWrite = 0;

            endcase
        end

        // I-type arithmetic instructions
        7'b0010011: begin

            RegWrite = 1;
            ALUSrc = 1;

            case (funct3)

                3'b000: ALU_Control = 4'b0000;
                3'b111: ALU_Control = 4'b0010;
                3'b110: ALU_Control = 4'b0011;
                3'b100: ALU_Control = 4'b0100;
                3'b010: ALU_Control = 4'b0101;

                default: RegWrite = 0;

            endcase
        end

        // Load instruction
        7'b0000011: begin
            RegWrite = 1;
            MemRead = 1;
            MemToReg = 1;
            ALUSrc = 1;
            ALU_Control = 4'b0000;
        end

        // Store instruction
        7'b0100011: begin
            MemWrite = 1;
            ALUSrc = 1;
            ALU_Control = 4'b0000;
        end

        // Branch instruction: BEQ
        7'b1100011: begin
            Branch = 1;
            ALU_Control = 4'b0001;
        end

        // Jump instruction: JAL
        7'b1101111: begin
            RegWrite = 1;
            Jump = 1;
        end

        default: begin
            // All control signals remain zero
        end

    endcase

end

endmodule

