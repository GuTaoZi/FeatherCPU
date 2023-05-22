

<img src="https://s2.loli.net/2023/04/12/K7ciZAVULrT6GCt.png" alt="icon.png" width='600px' />

FeatherCPU是一个支持RV32I指令集的轻量级CPU内核，测试运行于MINISYS开发板。

南方科技大学**CS214-计算机组成原理**课程项目。

英文介绍文档请移步[README](../README.md)

## Contributors

| 学号     | 姓名                                              | 贡献率 |
| -------- | ------------------------------------------------- | ------ |
| 12111624 | [GuTaoZi](https://github.com/GuTaoZi)             | 50%    |
| 12112012 | [Jayfeather233](https://github.com/Jayfeather233) | 50%    |

|      | 结构 | 指令集 | 文档 | IF   | ID   | EX   | MEM  | WB   | IO   | 汇编 | 仿真 | 视频 |
| ---- | ---- | ------ | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| 🍑    |      | ✔      | ✔    |      | ✔    | ✔    |      | ✔    | ✔    |      |      |      |
| 🪶    | ✔    |        |      | ✔    |      | ✔    | ✔    | ✔    | ✔    |      |      |      |

## 代办

- [ ] CPU特性
  - [x] ISA设计
  - [x] 寻址空间设计
  - [x] 多周期流水线设计
  - [ ] 调试
- [ ] CPU接口
  - [x] 时钟
  - [x] 复位
  - [x] Uart接口
  - [x] 其他IO: 矩阵键盘，数码管
- [ ] CPU内部结构
  - [x] 子模块接口连接关系
  - [ ] 子模块设计说明
- [ ] 测试说明
  - [ ] 基础测试集 \#1
  - [ ] 基础测试集 \#2
  - [ ] Bonus测试
  - [ ] Bonus展示视频
- [ ] 问题与总结

## 代码规范

本项目代码规范部分参考于 [Verilog Coding Style](https://verilogcodingstyle.readthedocs.io/en/latest/index.html).

## CPU特性

### 指令集

本项目指令集基于 `RV32I` 设计，进行了小幅修改。

32位指令, 32个32位通用寄存器。

在RV23I指令集的基础上增加了若干有符号运算指令。

详参 [Feather ISA](doc/FeatherISA.md).

## CPU接口

时钟、复位、uart接口、其他常用IO接口使用说明。

## CPU内部结构

Ø CPU内部各子模块的接口连接关系图 

Ø CPU内部子模块的设计说明（模块功能、子模块端口规格及功能说明）

## 测试说明

以表格的方式罗列出测试方法（仿真、上板）、测试类型（单元、集成）、测试用例描述、测试结果（通过、不通过）；以及最终的测试结论。

## 问题与总结

开发过程中遇到的问题、思考、总结。

## 版本修改记录

详参 [CHANGELOG.md](https://github.com/GuTaoZi/FeatherCPU/blob/main/CHANGELOG.md).

