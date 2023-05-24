`define R_TYPE 3'h1
//|-------|-----|-----| ---  |-----|-------|
//|funct7 | rs2 | rs1 |funct3| rd  |opcode |

`define R_ADD   10'b000_000_0000
`define R_MUL   10'b000_000_0001
`define R_ADDU  10'b000_000_0010
`define R_SUB   10'b000_010_0000
`define R_SUBU  10'b000_000_0100
`define R_SLL   10'b001_000_0000
`define R_SLT   10'b010_000_0000
`define R_SLTU  10'b011_000_0000
`define R_XOR   10'b100_000_0000
`define R_DIV   10'b100_000_0001
`define R_SRL   10'b101_000_0000
`define R_SRA   10'b110_000_0000
`define R_OR    10'b110_000_0000
`define R_REM   10'b110_000_0001
`define R_AND   10'b111_000_0000

`define I_TYPE 3'h2
//|------------|-----| ---  |-----|-------|
//| imm[11:0]  | rs1 |funct3| rd  |opcode |

`define I_ADDI  3'b000
`define I_SLLI  3'b001
`define I_SLTI  3'b010
`define I_SLTIU 3'b011
`define I_XORI  3'b100
`define I_SRLI  10'b101_000_0000
`define I_SRAI  10'b101_010_0000
`define I_ORI   3'b110
`define I_ANDI  3'b111
`define I_LW    7'b000_0011

`define S_TYPE 3'h3
//| ------- |-----|-----| ---  | -----  |-------|
//|imm[11:5]| rs2 | rs1 |funct3|imm[4:0]|opcode |

`define B_TYPE 3'h4
//|   -   | ------  |-----|-----| ---  | ----  |   -   |-------|
//|imm[12]|imm[10:5]| rs2 | rs1|funct3|imm[4:1]|imm[11]|opcode |

`define B_BEQ   3'b000
`define B_BNE   3'b001

`define U_TYPE 3'h5
//|--------------------|-----|-------|
//|     imm[31:12]     | rd  |opcode |

`define J_TYPE 3'h6
//|   -   |----------|   -   | -------- |-----|-------|
//|imm[20]|imm[10:1] |imm[11]|imm[19:12]| rd  |opcode |
`define J_JAL   7'b110_1111
`define J_JALR   7'b110_0111

`define E_TYPE 3'h7
//INSTRUCTION TYPE ERROR
