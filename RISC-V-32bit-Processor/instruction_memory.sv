module instruction_memory (
    input [31:0] address,
    output [31:0] instruction
);

    reg [31:0] memory [0:63];
    integer i;

    initial begin
        for (i = 0; i < 64; i = i + 1)
            memory[i] = 32'h00000013;

        memory[0]  = 32'h00500093; // ADDI x1, x0, 5
        memory[1]  = 32'h00A00113; // ADDI x2, x0, 10
        memory[2]  = 32'h002081B3; // ADD x3, x1, x2
        memory[3]  = 32'h40110233; // SUB x4, x2, x1
        memory[4]  = 32'h00302023; // SW x3, 0(x0)
        memory[5]  = 32'h00002283; // LW x5, 0(x0)
        memory[6]  = 32'h00208463; // BEQ x1, x2, +8
        memory[7]  = 32'h06300313; // ADDI x6, x0, 99 (skipped)
        memory[8]  = 32'h00700313; // ADDI x6, x0, 7
        memory[9]  = 32'h008003EF; // JAL x7, +8
        memory[10] = 32'h06300413; // ADDI x8, x0, 99 (skipped)
        memory[11] = 32'h00300413; // ADDI x8, x0, 3
    end

    assign instruction = memory[address[7:2]];

endmodule
