

<img src="https://s2.loli.net/2023/04/12/K7ciZAVULrT6GCt.png" alt="icon.png" width='600px' />

A lightweight CPU core for basic RV32I instructions running on MINISYS. Project for CS214 Computer Organization.

## Contributors

| SID      | Name                                              | Contributions | Contribution Rate |
| -------- | ------------------------------------------------- | ------------- | ----------------- |
| 12111624 | [GuTaoZi](https://github.com/GuTaoZi)             |               |                   |
| 12112012 | [Jayfeather233](https://github.com/Jayfeather233) |               |                   |

## TODOs

The TODOs itself is now the main todo to do (^^ ;





## Style Guide

This project is written in [Verilog Coding Style](https://verilogcodingstyle.readthedocs.io/en/latest/index.html).

## CPU Features

Ø ISA（含所有指令（指令名、对应编码、使用方式），参考的ISA，基于参考ISA本次作业所做的更新或优化；寄存器（位宽和数目）等信息）；对于异常处理的支持情况。 

### Instruction Format

<img src="https://five-embeddev.com/riscv-isa-manual/latest/rv32_02.png" style="zoom: 67%;" />

### Instructions

Instructions with \* are custom instructions beyond `RV32I`.

#### R type

<details>
<table>
    <tr>
        <td><b>Inst</b></td>
        <td><b>Name</b></td>
        <td><b>Opcode</b></td>
        <td><b>funct3</b></td>
        <td><b>funct7</b></td>
        <td><b>Description</b></td>
        <td><b>Note</b></td>
        </tr>
    <tr>
        <td>add</td>
        <td>Add</td>
        <td>0110011</td>
        <td>000</td>
        <td>0x00</td>
        <td>rd = rs1 + rs2</td>
        <td></td>
    </tr>
    <tr>
        <td>*addu</td>
        <td>Unsigned Add</td>
        <td>0110011</td>
        <td>000</td>
        <td>0x10</td>
        <td>rd = rs1 + rs2</td>
        <td>ignore overflow</td>
    </tr>
    <tr>
        <td>sub</td>
        <td>Sub</td>
        <td>0110011</td>
        <td>000</td>
        <td>0x20</td>
        <td>rd = rs1 - rs2</td>
        <td></td>
    </tr>
    <tr>
        <td>*subu</td>
        <td>Unsigned Sub</td>
        <td>0110011</td>
        <td>000</td>
        <td>0x30</td>
        <td>rd = rs1 - rs2</td>
        <td>ignore overflow</td>
    </tr>
    <tr>
        <td>sll</td>
        <td>Shift Left Logical</td>
        <td>0110011</td>
        <td>001</td>
        <td>0x00</td>
        <td>rd = rs1 &lt;&lt; rs2</td>
        <td></td>
    </tr>
    <tr>
        <td>slt</td>
        <td>Set Less Than</td>
        <td>0110011</td>
        <td>010</td>
        <td>0x00</td>
        <td>rd = rs1 &lt; rs2</td>
        <td></td>
    </tr>
    <tr>
        <td>sltu</td>
        <td>Unsigned Set Less Than</td>
        <td>0110011</td>
        <td>011</td>
        <td>0x00</td>
        <td>rd = rs1 &lt; rs2</td>
        <td>zero-extends</td>
    </tr>
    <tr>
        <td>xor</td>
        <td>Xor</td>
        <td>0110011</td>
        <td>100</td>
        <td>0x00</td>
        <td>rd = rs1 ^ rs2</td>
        <td></td>
    </tr>
    <tr>
        <td>srl</td>
        <td>Shift Right Logical</td>
        <td>0110011</td>
        <td>101</td>
        <td>0x00</td>
        <td>rd = rs1 &gt;&gt; rs2</td>
        <td></td>
    </tr>
    <tr>
        <td>sra</td>
        <td>Shift Right Arithmetic</td>
        <td>0110011</td>
        <td>101</td>
        <td>0x20</td>
        <td>rd = rs1 &gt;&gt; rs2</td>
        <td>msb-extends</td>
    </tr>
    <tr>
        <td>or</td>
        <td>Or</td>
        <td>0110011</td>
        <td>110</td>
        <td>0x00</td>
        <td>rd = rs1 | rs2</td>
        <td></td>
    </tr>
    <tr>
        <td>and</td>
        <td>And</td>
        <td>0110011</td>
        <td>111</td>
        <td>0x00</td>
        <td>rd = rs1 &amp; rs2</td>
        <td></td>
    </tr>
</table>
</details>

#### I type
<details>
<table>
    <tr>
        <td>Inst</td>
        <td>Name</td>
        <td>Opcode</td>
        <td>funct3</td>
        <td>imm[11:5]</td>
        <td>Description</td>
        <td>Note</td>
    </tr>
    <tr>
        <td>addi</td>
        <td>Add Imm</td>
        <td>0010011</td>
        <td>000</td>
        <td></td>
        <td>rd = rs1 + imm</td>
        <td></td>
    </tr>
    <tr>
        <td>slli</td>
        <td>Shift Left Logical Imm</td>
        <td>0010011</td>
        <td>001</td>
        <td>0x00</td>
        <td>rd = rs1 &lt;&lt; imm</td>
        <td></td>
    </tr>
    <tr>
        <td>slti</td>
        <td>Set Less Than Imm</td>
        <td>0010011</td>
        <td>010</td>
        <td></td>
        <td>rd = rs1 &lt; imm</td>
        <td></td>
    </tr>
    <tr>
        <td>sltiu</td>
        <td>Unsigned Set Less Than Imm</td>
        <td>0010011</td>
        <td>011</td>
        <td></td>
        <td>rd = rs1 &lt; imm</td>
        <td>zero-extends</td>
    </tr>
    <tr>
        <td>xori</td>
        <td>Xor Imm</td>
        <td>0010011</td>
        <td>100</td>
        <td></td>
        <td>rd = rs1 ^ imm</td>
        <td></td>
    </tr>
    <tr>
        <td>srli</td>
        <td>Shift Right Logical Imm</td>
        <td>0010011</td>
        <td>101</td>
        <td>0x00</td>
        <td>rd = rs1 &gt;&gt; imm</td>
        <td></td>
    </tr>
    <tr>
        <td>srai</td>
        <td>Shift Right Arithmetic Imm</td>
        <td>0010011</td>
        <td>101</td>
        <td>0x20</td>
        <td>rd = rs1 &gt;&gt; imm</td>
        <td>msb-extends</td>
    </tr>
    <tr>
        <td>ori</td>
        <td>Or Imm</td>
        <td>0010011</td>
        <td>110</td>
        <td></td>
        <td>rd = rs1 \| imm</td>
        <td></td>
    </tr>
    <tr>
        <td>andi</td>
        <td>And Imm</td>
        <td>0010011</td>
        <td>111</td>
        <td></td>
        <td>rd = rs1 &amp; imm</td>
        <td></td>
    </tr>
    <tr>
        <td>lb</td>
        <td>Load Byte</td>
        <td>0000011</td>
        <td>000</td>
        <td></td>
        <td>rd = M[rs1+imm][0:7]</td>
        <td></td>
    </tr>
    <tr>
        <td>lh</td>
        <td>Load Half</td>
        <td>0000011</td>
        <td>001</td>
        <td></td>
        <td>rd = M[rs1+imm][0:15]</td>
        <td></td>
    </tr>
    <tr>
        <td>lw</td>
        <td>Load Word</td>
        <td>0000011</td>
        <td>010</td>
        <td></td>
        <td>rd = M[rs1+imm][0:31]</td>
        <td></td>
    </tr>
    <tr>
        <td>lbu</td>
        <td>Load Byte (U)</td>
        <td>0000011</td>
        <td>100</td>
        <td></td>
        <td>rd = M[rs1+imm][0:7]</td>
        <td>zero-extends</td>
    </tr>
    <tr>
        <td>lhu</td>
        <td>Load Half (U)</td>
        <td>0000011</td>
        <td>101</td>
        <td></td>
        <td>rd = M[rs1+imm][0:15]</td>
        <td>zero-extends</td>
    </tr>
    <tr>
        <td>ecall</td>
        <td>Environment Call</td>
        <td>1110011</td>
        <td>000</td>
        <td></td>
        <td>Transfer control to OS</td>
        <td></td>
    </tr>
    <tr>
        <td>ebreak</td>
        <td>Environment Break</td>
        <td>1110011</td>
        <td>000</td>
        <td></td>
        <td>Transfer control to debugger</td>
        <td></td>
    </tr>
</table>
</details>

#### S type

|      |      |      |      |      |      |
| ---- | ---- | ---- | ---- | ---- | ---- |
|      |      |      |      |      |      |
|      |      |      |      |      |      |
|      |      |      |      |      |      |

Ø 寻址空间设计：属于冯.诺依曼结构还是哈佛结构；寻址单位，指令空间、数据空间的大小。 

Ø 对外设IO的支持：采用单独的访问外设的指令（以及相应的指令）还是MMIO（以及相关外设对应的地址），采用轮询还是中断的方式访问IO。

Ø CPU的CPI，属于单周期还是多周期CPU，是否支持pipeline（如支持，是几级流水，采用什么方式解决的流水线冲突问题）。

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

