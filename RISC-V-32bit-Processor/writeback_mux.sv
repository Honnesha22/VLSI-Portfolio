module writeback_mux (
    input  [31:0] ALU_Result,
    input  [31:0] Memory_Data,
    input         MemToReg,
    output [31:0] WriteBack_Data
);

    assign WriteBack_Data = MemToReg ? Memory_Data : ALU_Result;

endmodule
