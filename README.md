

<img src="https://s2.loli.net/2023/04/12/K7ciZAVULrT6GCt.png" alt="icon.png" width='600px' />

A lightweight CPU core for basic RV32I instructions running on Minisys. Project for CS214 Computer Organization.

For Chinese README, see [README_CN](doc/README_CN.md).

## Contributors

| SID      | Name                                              | Contribution Rate |
| -------- | ------------------------------------------------- | ----------------- |
| 12111624 | [GuTaoZi](https://github.com/GuTaoZi)             | 50%               |
| 12112012 | [Jayfeather233](https://github.com/Jayfeather233) | 50%               |

|      | Struct | ISA  | Doc  | IF   | ID   | EX   | MEM  | WB   | IO   | ASM  | Sim  | Video |
| ---- | ------ | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ----- |
| 🍑    |        | ✔    | ✔    |      | ✔    | ✔    |      | ✔    | ✔    |      |      |       |
| 🪶    | ✔      |      |      | ✔    |      | ✔    | ✔    | ✔    | ✔    | ✔    |      |       |

\* Uncountable detailed contributions are omitted here.

## TODOs

- [ ] CPU Features
  - [x] ISA Design
  - [x] Address Space Design
  - [x] Fast Single Cycle Design
  - [ ] Debugging
- [ ] CPU Interfaces
  - [x] Clock
  - [x] Reset
  - [x] Uart
  - [x] Others: Keyboard, segment tubes
- [ ] Internal Structures
  - [x] Module interconnections
  - [ ] Module introduction
- [ ] Tests
  - [ ] Basic testcases \#1
  - [ ] Basic testcases \#2
  - [ ] Bonus testcases
  - [ ] Video for bonus part
- [ ] Summary

## Style Guide

This project is written in [Verilog Coding Style](https://verilogcodingstyle.readthedocs.io/en/latest/index.html).

## CPU Features

### Basic Information

CPU frequency: 25 MHz

CPI: 2 cycles/instruction

32-bit Registers: x0 - x31

### Instructions

This custom ISA is designed based on `RV32I`. 

32-bit Instructions, 32 General Registers of 32-bit width.

Some signed instructions beyond RV32I are implemented in this ISA. 

For more details, see [Feather ISA](doc/FeatherISA.md).

## CPU Interfaces

**Clocks**

- FPGA frequency: 100 MHz
- CPU frequency: 25 MHz

**Input interfaces**

- Uart interface, for instruction and data memory input
- 4X4 matrix keyboard, for memory-mapped input
- 24 switches, for debugging input
- Reset button: P5
- Input done button: P10
- Input reset button: P1
- Debugging state button: R1

**Output interfaces**

- 8 segment tubes, displaying input data and CPU state information
- 24 leds, for memory-mapped output

## Internal Structures

### Inter-module connection diagram

![image.png](https://s2.loli.net/2023/05/27/CA4oYWeUBuwfrsa.png)

### Module descriptions

#### Top

| Port            | I/O  | Src/Dst  | Description                         |
| :-------------- | :--: | :------: | ----------------------------------- |
| fpga_clk        |  I   | Hardware | FPGA clock signal                   |
| rst_raw         |  I   | Hardware | Reset signal before de**-**jittered |
| upg_rx          |  I   |   Uart   | Uart input data                     |
| kb_row          |  I   | Hardware | Keyboard row signal                 |
| debug_btn       |  I   | Hardware | Debug button signal                 |
| sw              |  I   | Hardware | Switches signal                     |
| kb_ack_btn      |  I   | Hardware | Keyboard ACK signal                 |
| kb_cancel_btn   |  I   | Hardware | Keyboard input reset signal         |
| filter_test_btn |  I   | Hardware | Filter test button signal           |
| kb_col          |  O   | Hardware | Keyboard col signal                 |
| upg_tx          |  O   |   Uart   | Uart send back data                 |
| led_o           |  O   | Hardware | LED state                           |
| seg_cho         |  O   | Hardware | Segment tube select signal          |
| seg_lit         |  O   | Hardware | Segment tube data to display        |

#### PC

| Port      | I/O  |   Src/Dst   | Description                   |
| :-------- | :--: | :---------: | ----------------------------- |
| i_clk     |  I   |     Top     | CPU clock signal              |
| i_rst     |  I   |  Hardware   | Reset signal                  |
| i_Jal     |  I   | InstDecoder | Jal instruction enable        |
| i_Jalr    |  I   | InstDecoder | Jalr instruction enable       |
| i_pc_en   |  I   |     Top     | PC update enable              |
| i_branch  |  I   | InstDecoder | Branch instruction enable     |
| i_Jal_imm |  I   | InstDecoder | Jal immediate                 |
| i_alu_val |  I   | InstDecoder | Result of ALU for updating PC |
| o_pc      |  O   |     Top     | Current PC                    |
| o_next_pc |  O   |     Top     | Next PC, for debugging        |
| o_pc_rb   |  O   |     Top     | PC to write back for Jal(r)   |

#### InsMem

| Port        | I/O  | Src/Dst  | Description                 |
| :---------- | :--: | :------: | --------------------------- |
| i_pc        |  I   |    PC    | Program counter             |
| i_clk       |  I   | Hardware | FPGA clock signal           |
| i_uart_ena  |  I   |   Uart   | Uart-write enable signal    |
| i_uart_done |  I   |   Uart   | Uart write-complete signal  |
| i_uart_clk  |  I   |   Uart   | Uart clock signal           |
| i_uart_addr |  I   |   Uart   | Uart-write memory address   |
| i_uart_data |  I   |   Uart   | Data to write in, from uart |
| o_inst      |  O   |    ID    | Instruction read out        |

## Tests

以表格的方式罗列出测试方法（仿真、上板）、测试类型（单元、集成）、测试用例描述、测试结果（通过、不通过）；以及最终的测试结论。

## Summary

### Problems met

- Different ISAs bring about different architectures
- Writing bitstreams to the board always fails for the first time for unknown reason, kind of annoying
- The hold time violation leads to some sequential time failure
- VIVADO cooperates BAD with Git

### How to debug with hardware

- Simulation on modules
- Implement debug modes, output the current information of CPU

## Changelog

See [CHANGELOG.md](https://github.com/GuTaoZi/FeatherCPU/blob/main/CHANGELOG.md).

