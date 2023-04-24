

<img src="https://s2.loli.net/2023/04/12/K7ciZAVULrT6GCt.png" alt="icon.png" width='600px' />

A lightweight CPU core for basic RV32I instructions running on MINISYS. Project for CS214 Computer Organization.

For Chinese README, see [README_CN](doc/README_CN.pdf).

## Contributors

| SID      | Name                                              | Contributions | Contribution Rate |
| -------- | ------------------------------------------------- | ------------- | ----------------- |
| 12111624 | [GuTaoZi](https://github.com/GuTaoZi)             |               |                   |
| 12112012 | [Jayfeather233](https://github.com/Jayfeather233) |               |                   |

## TODOs

- [ ] CPU Features
  - [x] ISA Design
  - [ ] Address Space Design
  - [ ] Multi-cycle \& Pipeline Design
- [ ] CPU Interfaces
  - [ ] Clock
  - [ ] Reset
  - [ ] Uart
  - [ ] Others
- [ ] Internal Structures
  - [ ] Module interconnections
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

### Instructions

This custom ISA is designed based on `RV32I`. 

32-bit Instructions, 32 General Registers of 32-bit width.

Some signed instructions beyond RV32I are implemented in this ISA. 

For more details, see [Feather ISA](doc/FeatherISA.md).

## CPU Interfaces

时钟、复位、uart接口、其他常用IO接口使用说明。

## Internal Structures

Ø CPU内部各子模块的接口连接关系图 

Ø CPU内部子模块的设计说明（模块功能、子模块端口规格及功能说明）

## Tests

以表格的方式罗列出测试方法（仿真、上板）、测试类型（单元、集成）、测试用例描述、测试结果（通过、不通过）；以及最终的测试结论。

## Summary

开发过程中遇到的问题、思考、总结。

## Changelog

See [CHANGELOG.md](https://github.com/GuTaoZi/FeatherCPU/blob/main/CHANGELOG.md).

