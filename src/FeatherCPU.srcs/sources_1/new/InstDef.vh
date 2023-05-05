`define R_TYPE 3'h1
//|-------|-----|-----| ---  |-----|-------|
//|funct7 | rs2 | rs1 |funct3| rd  |opcode |

`define I_TYPE 3'h2
//|------------|-----| ---  |-----|-------|
//| imm[11:0]  | rs1 |funct3| rd  |opcode |

`define S_TYPE 3'h3
//| ------- |-----|-----| ---  | -----  |-------|
//|imm[11:5]| rs2 | rs1 |funct3|imm[4:0]|opcode |

`define B_TYPE 3'h4
//|   -   | ------  |-----|-----| ---  | ----  |   -   |-------|
//|imm[12]|imm[10:5]| rs2 | rs1|funct3|imm[4:1]|imm[11]|opcode |

`define U_TYPE 3'h5
//|--------------------|-----|-------|
//|     imm[31:12]     | rd  |opcode |

`define J_TYPE 3'h6
//|   -   |----------|   -   | -------- |-----|-------|
//|imm[20]|imm[10:1] |imm[11]|imm[19:12]| rd  |opcode |

`define E_TYPE 3'h7
//INSTRUCTION TYPE ERROR
