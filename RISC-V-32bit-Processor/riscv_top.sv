
module riscv_top (
    input clk,
    input reset
);

    // =====================================
    // 1. PROGRAM COUNTER
    // =====================================

    wire [31:0] PC;
    wire [31:0] Next_PC;

    // =====================================
    // 2. INSTRUCTION MEMORY
    // =====================================

    wire [31:0] Instruction;

    // =====================================
    // 3. REGISTER FILE
    // =====================================

    wire [31:0] Read_Data1;
    wire [31:0] Read_Data2;
    wire [31:0] Write_Back_Data;

    // =====================================
    // 4. IMMEDIATE GENERATOR
    // =====================================

    wire [31:0] Immediate;

    // =====================================
    // 5. CONTROL UNIT
    // =====================================

    wire RegWrite;
    wire MemRead;
    wire MemWrite;
    wire MemToReg;
    wire Branch;
    wire ALUSrc;
    wire Jump;

    wire [3:0] ALU_Control;

    // =====================================
    // 6. ALU
    // =====================================

    wire [31:0] ALU_Result;
    wire [31:0] ALU_Input_B;
    wire Zero;

    // =====================================
    // 7. DATA MEMORY
    // =====================================

    wire [31:0] Memory_Data;

    // =====================================
    // 8. BRANCH LOGIC
    // =====================================

    wire [31:0] Branch_Target;
    wire PCSrc;

    // =====================================
    // 9. WRITEBACK
    // =====================================

    wire [31:0] Write_Back_Base;

    // =====================================
    // PROGRAM COUNTER
    // =====================================

    program_counter PC_UNIT (
        .clk(clk),
        .reset(reset),
        .enable(1'b1),
        .next_pc(Next_PC),
        .pc(PC)
    );

    // =====================================
    // INSTRUCTION MEMORY
    // =====================================

    instruction_memory IMEM (
        .address(PC),
        .instruction(Instruction)
    );

    // =====================================
    // IMMEDIATE GENERATOR
    // =====================================

    immediate_generator IMM_GEN (
        .instruction(Instruction),
        .immediate(Immediate)
    );

    // =====================================
    // CONTROL UNIT
    // =====================================

    control_unit CU (
        .opcode(Instruction[6:0]),
        .funct3(Instruction[14:12]),
        .funct7(Instruction[31:25]),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .Branch(Branch),
        .ALUSrc(ALUSrc),
        .Jump(Jump),
        .ALU_Control(ALU_Control)
    );

    // =====================================
    // REGISTER FILE
    // =====================================

    register_file RF (
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .rs1(Instruction[19:15]),
        .rs2(Instruction[24:20]),
        .rd(Instruction[11:7]),
        .write_data(Write_Back_Data),
        .read_data1(Read_Data1),
        .read_data2(Read_Data2)
    );

    // =====================================
    // ALU INPUT MUX
    // =====================================

    assign ALU_Input_B = ALUSrc ? Immediate : Read_Data2;

    // =====================================
    // ALU
    // =====================================

    alu ALU_UNIT (
        .A(Read_Data1),
        .B(ALU_Input_B),
        .ALU_Control(ALU_Control),
        .Result(ALU_Result),
        .Zero(Zero)
    );

    // =====================================
    // DATA MEMORY
    // =====================================

    data_memory DMEM (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(ALU_Result),
        .write_data(Read_Data2),
        .read_data(Memory_Data)
    );

    // =====================================
    // BRANCH ADDER
    // =====================================

    branch_adder BA (
        .PC(PC),
        .Immediate(Immediate),
        .Branch_Target(Branch_Target)
    );

    // =====================================
    // BRANCH CONTROL
    // =====================================

    branch_control BC (
        .Branch(Branch),
        .Zero(Zero),
        .PCSrc(PCSrc)
    );

    // =====================================
    // PC SELECTION MUX
    // =====================================

    wire [31:0] Normal_Next_PC;

    pc_mux PC_MUX (
        .PC(PC),
        .Branch_Target(Branch_Target),
        .PCSrc(PCSrc),
        .Next_PC(Normal_Next_PC)
    );

    // Include JAL target selection
    assign Next_PC = Jump ? Branch_Target : Normal_Next_PC;

    // =====================================
    // WRITEBACK MUX
    // =====================================

    writeback_mux WB_MUX (
        .ALU_Result(ALU_Result),
        .Memory_Data(Memory_Data),
        .MemToReg(MemToReg),
        .WriteBack_Data(Write_Back_Base)
    );

    // JAL writes PC + 4 to destination register
    assign Write_Back_Data = Jump ? (PC + 4) : Write_Back_Base;

endmodule

