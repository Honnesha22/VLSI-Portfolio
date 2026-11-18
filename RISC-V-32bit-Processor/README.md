
# 32-bit RISC-V Single-Cycle Processor

## Project Overview
Design and implementation of a 32-bit RISC-V single-cycle processor using Verilog HDL.

## Architecture
The processor consists of:
- Arithmetic Logic Unit (ALU)
- Register File (32 × 32-bit registers)
- Program Counter
- Instruction Memory
- Data Memory
- Immediate Generator
- Control Unit
- ALU Control Unit
- Branch Adder and Branch Control
- Program Counter Multiplexer
- Write-Back Multiplexer

## Instruction Support
- Arithmetic: ADD, SUB, ADDI
- Logical: AND, OR, XOR
- Comparison: SLT
- Memory: LW, SW
- Branch: BEQ
- Jump: JAL

## Tools Used
- Verilog HDL
- EDA Playground
- Icarus Verilog
- GitHub

## Verification
Individual modules were simulated using testbenches. Processor-level tests were performed for arithmetic, memory access, branching and jump operations.

## Project Status
Implementation and integration completed; further verification and RV32I compliance testing are ongoing.

## Author
Honnesha N
