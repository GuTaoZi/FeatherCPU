$\Huge\text{Feather CPU 🪶}$

<img src="https://s2.loli.net/2023/04/11/4E56VmKJpYWvkXB.png" alt="icon.png" width='600px' />

A lightweight CPU for basic MIPS instructions running on MINISYS. Project for CS214 Computer Organization.

## Contributors

| SID      | Name                                              | Contributions | Contribution Rate |
| -------- | ------------------------------------------------- | ------------- | ----------------- |
| 12111624 | [GuTaoZi](https://github.com/GuTaoZi)             |               |                   |
| 12112012 | [Jayfeather233](https://github.com/Jayfeather233) |               |                   |

## TODOs

The TODOs itself is now the main todo to do (^^ ;

## CPU Features

Ø ISA（含所有指令（指令名、对应编码、使用方式），参考的ISA，基于参考ISA本次作业所做的更新或优化；寄存器（位宽和数目）等信息）；对于异常处理的支持情况。 

Ø 寻址空间设计：属于冯.诺依曼结构还是哈佛结构；寻址单位，指令空间、数据空间的大小。 

Ø 对外设IO的支持：采用单独的访问外设的指令（以及相应的指令）还是MMIO（以及相关外设对应的地址），采用轮询还是中断的方式访问IO。

Ø CPU的CPI，属于单周期还是多周期CPU，是否支持pipel ine（如支持，是几级流水，采用什么方式解决的流水线冲突问题）。

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
