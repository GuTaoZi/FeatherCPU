

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
- Input reset button: ?
- Debugging state button: R1

**Output interfaces**

- 8 segment tubes, displaying input data and CPU state information
- 24 leds, for memory-mapped output

**Todo**

- [ ] Beeping?
- [ ] VGA?

## Internal Structures

Ø CPU内部各子模块的接口连接关系图 

Ø CPU内部子模块的设计说明（模块功能、子模块端口规格及功能说明）

## Tests

以表格的方式罗列出测试方法（仿真、上板）、测试类型（单元、集成）、测试用例描述、测试结果（通过、不通过）；以及最终的测试结论。

## Summary

### Problems met

- Different ISAs bring about different architectures
- Writing bitstreams to the board always fails for the first time for unknown reason, kind of annoying
- VIVADO cooperates BAD with Git

### How to debug with hardware

- Simulation on modules
- Implement debug modes, output the current information of CPU

## Changelog

See [CHANGELOG.md](https://github.com/GuTaoZi/FeatherCPU/blob/main/CHANGELOG.md).

