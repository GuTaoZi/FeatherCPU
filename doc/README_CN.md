

<img src="https://s2.loli.net/2023/04/12/K7ciZAVULrT6GCt.png" alt="icon.png" width='600px' />

FeatherCPU是一个支持RV32I指令集的轻量级CPU内核，测试运行于Minisys开发板。

南方科技大学**CS214-计算机组成原理**课程项目。

英文介绍文档请移步[README](../README.md)

## Contributors

| 学号     | 姓名                                              | 贡献率 |
| -------- | ------------------------------------------------- | ------ |
| 12111624 | [GuTaoZi](https://github.com/GuTaoZi)             | 50%    |
| 12112012 | [Jayfeather233](https://github.com/Jayfeather233) | 50%    |

|      | 结构 | 指令集 | 文档 | IF   | ID   | EX   | MEM  | WB   | IO   | 汇编 | 仿真 | 视频 |
| ---- | ---- | ------ | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| 🍑    |      | ✔      | ✔    |      | ✔    | ✔    |      | ✔    | ✔    |      | ✔    | ✔    |
| 🪶    | ✔    |        |      | ✔    |      | ✔    | ✔    | ✔    | ✔    | ✔    | ✔    | ✔    |

## 待办

- [x] CPU特性
  - [x] ISA设计
  - [x] 寻址空间设计
  - [x] 多周期流水线设计
  - [x] 调试
- [x] CPU接口
  - [x] 时钟
  - [x] 复位
  - [x] Uart接口
  - [x] 其他IO: 矩阵键盘，数码管
- [x] CPU内部结构
  - [x] 子模块接口连接关系
  - [x] 子模块设计说明
- [x] 测试说明
  - [x] 基础测试集 \#1
  - [x] 基础测试集 \#2
  - [x] Bonus测试
  - [ ] Bonus展示视频
- [x] 问题与总结

## 代码规范

本项目代码规范部分参考于 [Verilog Coding Style](https://verilogcodingstyle.readthedocs.io/en/latest/index.html).

## CPU特性

### 基础信息

架构：哈佛架构

CPU频率：25 MHz

CPI：2 周期/指令

32个32位寄存器：x0-x31

### 指令集

本项目指令集基于 `RV32I` 设计，进行了小幅修改。

32位指令, 32个32位通用寄存器。

在RV23I指令集的基础上增加了若干有符号运算指令。

详参 [Feather ISA](doc/FeatherISA.md).

## CPU接口

### 时钟

- FPGA时钟频率：100 MHz
- CPU时钟频率：25 MHz

### 输入接口

- Uart接口，用于指令和数据的输入
- 4X4矩阵键盘，用于内存映射输入
- 24个拨码开关，用于debug输入和场景测试
- 重置按钮：P5
- 输入确认按钮：P10
- 重置输入按钮：P1
- 调试按钮：R1

### 输出接口

- 八段数码管，显示键盘输入数据及CPU内部信息
- 24LED灯，用于内存映射输出

## CPU内部结构

### 子模块接口连接关系图

![image.png](https://s2.loli.net/2023/05/27/CA4oYWeUBuwfrsa.png)

### 模块描述

~~这块就不翻译了，英文说明也很trivial~~

#### Top

<details><table>
    <tr>
        <td><b>Port</b></td>
        <td><b>I/O</b></td>
        <td><b>Src/Dst</b></td>
        <td><b>Description</b></td>
    </tr>
    <tr>
        <td>fpga_clk</td>
        <td>I</td>
        <td>Hardware</td>
        <td>FPGA clock signal</td>
    </tr>
    <tr>
        <td>rst_raw</td>
        <td>I</td>
        <td>Hardware</td>
        <td>Reset signal before de-jittered</td>
    </tr>
    <tr>
        <td>upg_rx</td>
        <td>I</td>
        <td>Uart</td>
        <td>Uart input data</td>
    </tr>
    <tr>
        <td>kb_row</td>
        <td>I</td>
        <td>Hardware</td>
        <td>Keyboard row signal</td>
    </tr>
    <tr>
        <td>debug_btn</td>
        <td>I</td>
        <td>Hardware</td>
        <td>Debug button signal</td>
    </tr>
    <tr>
        <td>sw</td>
        <td>I</td>
        <td>Hardware</td>
        <td>Switches signal</td>
    </tr>
    <tr>
        <td>kb_ack_btn</td>
        <td>I</td>
        <td>Hardware</td>
        <td>Keyboard ACK signal</td>
    </tr>
    <tr>
        <td>kb_cancel_btn</td>
        <td>I</td>
        <td>Hardware</td>
        <td>Keyboard input reset signal</td>
    </tr>
    <tr>
        <td>filter_test_btn</td>
        <td>I</td>
        <td>Hardware</td>
        <td>Filter test button signal</td>
    </tr>
    <tr>
        <td>kb_col</td>
        <td>O</td>
        <td>Hardware</td>
        <td>Keyboard col signal</td>
    </tr>
    <tr>
        <td>upg_tx</td>
        <td>O</td>
        <td>Uart</td>
        <td>Uart send back data</td>
    </tr>
    <tr>
        <td>led_o</td>
        <td>O</td>
        <td>Hardware</td>
        <td>LED state</td>
    </tr>
    <tr>
        <td>seg_cho</td>
        <td>O</td>
        <td>Hardware</td>
        <td>Segment tube select signal</td>
    </tr>
    <tr>
        <td>seg_lit</td>
        <td>O</td>
        <td>Hardware</td>
        <td>Segment tube data to display</td>
    </tr>
</table></details>


#### PC

<details><table>
    <tr>
        <td><b>Port</b></td>
        <td><b>I/O</b></td>
        <td><b>Src/Dst</b></td>
        <td><b>Description</b></td>
    </tr>
    <tr>
        <td>i_clk</td>
        <td>I</td>
        <td>Top</td>
        <td>CPU clock signal</td>
    </tr>
    <tr>
        <td>i_rst</td>
        <td>I</td>
        <td>Hardware</td>
        <td>Reset signal</td>
    </tr>
    <tr>
        <td>i_Jal</td>
        <td>I</td>
        <td>InstDecoder</td>
        <td>Jal instruction enable</td>
    </tr>
    <tr>
        <td>i_Jalr</td>
        <td>I</td>
        <td>InstDecoder</td>
        <td>Jalr instruction enable</td>
    </tr>
    <tr>
        <td>i_pc_en</td>
        <td>I</td>
        <td>Top</td>
        <td>PC update enable</td>
    </tr>
    <tr>
        <td>i_branch</td>
        <td>I</td>
        <td>InstDecoder</td>
        <td>Branch instruction enable</td>
    </tr>
    <tr>
        <td>i_Jal_imm</td>
        <td>I</td>
        <td>InstDecoder</td>
        <td>Jal immediate</td>
    </tr>
    <tr>
        <td>i_alu_val</td>
        <td>I</td>
        <td>InstDecoder</td>
        <td>Result of ALU for updating PC</td>
    </tr>
    <tr>
        <td>o_pc</td>
        <td>O</td>
        <td>Top</td>
        <td>Current PC</td>
    </tr>
    <tr>
        <td>o_next_pc</td>
        <td>O</td>
        <td>Top</td>
        <td>Next PC, for debugging</td>
    </tr>
    <tr>
        <td>o_pc_rb</td>
        <td>O</td>
        <td>Top</td>
        <td>PC to write back for Jal(r)</td>
    </tr>
</table></details>


#### InsMem

<details><table>
    <tr>
        <td><b>Port</b></td>
        <td><b>I/O</b></td>
        <td><b>Src/Dst</b></td>
        <td><b>Description</b></td>
    </tr>
    <tr>
        <td>i_pc</td>
        <td>I</td>
        <td>PC</td>
        <td>Program counter</td>
    </tr>
    <tr>
        <td>i_clk</td>
        <td>I</td>
        <td>Hardware</td>
        <td>FPGA clock signal</td>
    </tr>
    <tr>
        <td>i_uart_ena</td>
        <td>I</td>
        <td>Uart</td>
        <td>Uart-write enable signal</td>
    </tr>
    <tr>
        <td>i_uart_done</td>
        <td>I</td>
        <td>Uart</td>
        <td>Uart write-complete signal</td>
    </tr>
    <tr>
        <td>i_uart_clk</td>
        <td>I</td>
        <td>Uart</td>
        <td>Uart clock signal</td>
    </tr>
    <tr>
        <td>i_uart_addr</td>
        <td>I</td>
        <td>Uart</td>
        <td>Uart-write memory address</td>
    </tr>
    <tr>
        <td>i_uart_data</td>
        <td>I</td>
        <td>Uart</td>
        <td>Data to write in, from uart</td>
    </tr>
    <tr>
        <td>o_inst</td>
        <td>O</td>
        <td>ID</td>
        <td>Instruction read out</td>
    </tr>
</table></details>


#### InstDecoder

<details><table>
    <tr>
        <td><b>Port</b></td>
        <td><b>I/O</b></td>
        <td><b>Src/Dst</b></td>
        <td><b>Description</b></td>
    </tr>
    <tr>
        <td>i_inst</td>
        <td>I</td>
        <td>InstMem</td>
        <td>Instruction to decode</td>
    </tr>
    <tr>
        <td>o_rs1_idx</td>
        <td>O</td>
        <td>ALU</td>
        <td>Index of first register</td>
    </tr>
    <tr>
        <td>o_rs2_idx</td>
        <td>O</td>
        <td>ALU</td>
        <td>Index of second register</td>
    </tr>
    <tr>
        <td>o_imm</td>
        <td>O</td>
        <td>ALU</td>
        <td>Immediate number decoded</td>
    </tr>
    <tr>
        <td>o_alu_op</td>
        <td>O</td>
        <td>ALU</td>
        <td>ALU operator number</td>
    </tr>
    <tr>
        <td>o_mem_read</td>
        <td>O</td>
        <td>DMA</td>
        <td>Memory read enable</td>
    </tr>
    <tr>
        <td>o_mem_write</td>
        <td>O</td>
        <td>DMA</td>
        <td>Memory write enable</td>
    </tr>
    <tr>
        <td>o_mem_to_reg</td>
        <td>O</td>
        <td>DMA</td>
        <td>Memory write back</td>
    </tr>
    <tr>
        <td>o_inst_type</td>
        <td>O</td>
        <td>ALU</td>
        <td>Instruction type</td>
    </tr>
    <tr>
        <td>funct10</td>
        <td>O</td>
        <td>Top</td>
        <td>{funct3, funct7}</td>
    </tr>
</table></details>


#### Register

<details><table>
    <tr>
        <td><b>Port</b></td>
        <td><b>I/O</b></td>
        <td><b>Src/Dst</b></td>
        <td><b>Description</b></td>
    </tr>
    <tr>
        <td>i_read_addr1</td>
        <td>I</td>
        <td>InstDecoder</td>
        <td>Index of first register</td>
    </tr>
    <tr>
        <td>i_read_addr2</td>
        <td>I</td>
        <td>InstDecoder</td>
        <td>Index of second register</td>
    </tr>
    <tr>
        <td>i_write_addr</td>
        <td>I</td>
        <td>InstDecoder</td>
        <td>Index of write-back register</td>
    </tr>
    <tr>
        <td>i_write_data</td>
        <td>I</td>
        <td>Top</td>
        <td>Data to write back</td>
    </tr>
    <tr>
        <td>i_write_en</td>
        <td>I</td>
        <td>Top</td>
        <td>Write back enable</td>
    </tr>
    <tr>
        <td>i_clk</td>
        <td>I</td>
        <td>Top</td>
        <td>CPU clock signal</td>
    </tr>
    <tr>
        <td>i_rst</td>
        <td>I</td>
        <td>Hardware</td>
        <td>Reset signal</td>
    </tr>
    <tr>
        <td>i_debug_idx</td>
        <td>I</td>
        <td>Top</td>
        <td>Index of register to display</td>
    </tr>
    <tr>
        <td>o_read_data1</td>
        <td>O</td>
        <td>ALU</td>
        <td>Value of first register</td>
    </tr>
    <tr>
        <td>o_read_data2</td>
        <td>O</td>
        <td>ALU</td>
        <td>Value of second register</td>
    </tr>
    <tr>
        <td>o_debug_data</td>
        <td>O</td>
        <td>ALU</td>
        <td>Value of display register</td>
    </tr>
</table></details>


#### ALU

<details><table>
    <tr>
        <td><b>Port</b></td>
        <td><b>I/O</b></td>
        <td><b>Src/Dst</b></td>
        <td><b>Description</b></td>
    </tr>
    <tr>
        <td>i_src1</td>
        <td>I</td>
        <td>InstDecoder</td>
        <td>First operand</td>
    </tr>
    <tr>
        <td>i_src2</td>
        <td>I</td>
        <td>InstDecoder</td>
        <td>Second operand</td>
    </tr>
    <tr>
        <td>i_branch_val_i</td>
        <td>I</td>
        <td>InstDecoder</td>
        <td>Immediate for B inst</td>
    </tr>
    <tr>
        <td>i_ALU_op</td>
        <td>I</td>
        <td>InstDecoder</td>
        <td>ALU operator number</td>
    </tr>
    <tr>
        <td>i_rst</td>
        <td>I</td>
        <td>Top</td>
        <td>Reset signal</td>
    </tr>
    <tr>
        <td>o_ALU_ouput</td>
        <td>O</td>
        <td>Top</td>
        <td>Result</td>
    </tr>
    <tr>
        <td>o_overflow</td>
        <td>O</td>
        <td>Top</td>
        <td>Overflow identifier</td>
    </tr>
</table></details>


#### DMA

<details><table>
    <tr>
        <td><b>Port</b></td>
        <td><b>I/O</b></td>
        <td><b>Src/Dst</b></td>
        <td><b>Description</b></td>
    </tr>
    <tr>
        <td>hdw_clk</td>
        <td>I</td>
        <td>Top</td>
        <td>FPGA clock signal</td>
    </tr>
    <tr>
        <td>cpu_clk</td>
        <td>I</td>
        <td>Top</td>
        <td>CPU clock signal</td>
    </tr>
    <tr>
        <td>cpu_mem_ena</td>
        <td>I</td>
        <td>Top</td>
        <td>CPU-access memory signal</td>
    </tr>
    <tr>
        <td>cpu_addr</td>
        <td>I</td>
        <td>Top</td>
        <td>CPU-access memory address</td>
    </tr>
    <tr>
        <td>cpu_write_data</td>
        <td>I</td>
        <td>Top</td>
        <td>Data to write in, from CPU</td>
    </tr>
    <tr>
        <td>cpu_mem_read_ena</td>
        <td>I</td>
        <td>Top</td>
        <td>CPU-read memory signal</td>
    </tr>
    <tr>
        <td>cpu_mem_write_ena</td>
        <td>I</td>
        <td>Top</td>
        <td>CPU-write memory signal</td>
    </tr>
    <tr>
        <td>hdw_sw_data</td>
        <td>I</td>
        <td>Hardware</td>
        <td>MMIO data from switches</td>
    </tr>
    <tr>
        <td>hdw_keybd_data</td>
        <td>I</td>
        <td>Hardware</td>
        <td>MMIO data from keyboard</td>
    </tr>
    <tr>
        <td>hdw_ack_btn</td>
        <td>I</td>
        <td>Hardware</td>
        <td>MMIO data from ACK button</td>
    </tr>
    <tr>
        <td>uart_ena</td>
        <td>I</td>
        <td>Uart</td>
        <td>Uart-write memory signal</td>
    </tr>
    <tr>
        <td>uart_done</td>
        <td>I</td>
        <td>Uart</td>
        <td>Uart-complete signal</td>
    </tr>
    <tr>
        <td>uart_clk</td>
        <td>I</td>
        <td>Uart</td>
        <td>Uart clock signal</td>
    </tr>
    <tr>
        <td>uart_addr</td>
        <td>I</td>
        <td>Uart</td>
        <td>Uart-write memory address</td>
    </tr>
    <tr>
        <td>uart_data</td>
        <td>I</td>
        <td>Uart</td>
        <td>Data to write in, from uart</td>
    </tr>
    <tr>
        <td>read_data</td>
        <td>O</td>
        <td>Top</td>
        <td>Data read from data memory</td>
    </tr>
    <tr>
        <td>hdw_led_data</td>
        <td>O</td>
        <td>Hardware</td>
        <td>MMIO data for leds</td>
    </tr>
</table></details>


#### DataMem

<details><table>
    <tr>
        <td><b>Port</b></td>
        <td><b>I/O</b></td>
        <td><b>Src/Dst</b></td>
        <td><b>Description</b></td>
    </tr>
    <tr>
        <td>i_addr</td>
        <td>I</td>
        <td>DMA</td>
        <td>The address of demanded data</td>
    </tr>
    <tr>
        <td>i_write_data</td>
        <td>I</td>
        <td>DMA</td>
        <td>The data to write in</td>
    </tr>
    <tr>
        <td>i_mem_read</td>
        <td>I</td>
        <td>DMA</td>
        <td>Read enable</td>
    </tr>
    <tr>
        <td>i_mem_write</td>
        <td>I</td>
        <td>DMA</td>
        <td>Write enable</td>
    </tr>
    <tr>
        <td>i_clk</td>
        <td>I</td>
        <td>Hardware</td>
        <td>FPGA clock signal</td>
    </tr>
    <tr>
        <td>o_read_data</td>
        <td>O</td>
        <td>DMA</td>
        <td>Data read out</td>
    </tr>
</table></details>



## 测试说明

### 模块测试

| 测试方法  | 模块                  | 结果 | 描述                                                     |
| :-------: | --------------------- | :--: | -------------------------------------------------------- |
|   仿真    | InstDecoder           |  ✔   | 检查组合逻辑正确译码                                     |
| 仿真+上板 | Filter                |  ✔   | 检查消抖滤镜正常工作                                     |
|   上板    | Uart                  |  ✔   | 检查Uart串口正常通信                                     |
|   上板    | DMA and IO interfaces |  ✔   | 键盘、数码管、开关、LED正常工作，DMA模块正常访问数据内存 |
|   上板    | PC                    |  ✔   | PC寄存器正常更新                                         |
|   上板    | ALU                   |  ✔   | ALU对所有指令得出正确计算结果                            |
|   上板    | Register              |  ✔   | 读取、写回寄存器正常                                     |

### 集成测试

| 测试方法 | 对象          | 结果 | 描述                                                         |
| :------: | ------------- | :--: | ------------------------------------------------------------ |
|   仿真   | ID - EX - Reg |  ✔   | 组合逻辑与寄存器联合模块正常工作                             |
|   上板   | Top           |  ✔   | 所有指令可用性测试通过                                       |
|   上板   | Top           |  ✔   | [测试场景1](https://github.com/GuTaoZi/FeatherCPU/tree/main/asm). 见 [项目测试说明](https://github.com/GuTaoZi/FeatherCPU/blob/main/doc/Project Requirements.pdf) |
|   上板   | Top           |  ✔   | [测试场景2](https://github.com/GuTaoZi/FeatherCPU/tree/main/asm). 见 [项目测试说明](https://github.com/GuTaoZi/FeatherCPU/blob/main/doc/Project Requirements.pdf) |

### 额外测试

| 测试集     | 描述                               | 结果 |
| ---------- | ---------------------------------- | ---- |
| 跑马灯$^+$ | 以内存映射的方式实时控制跑马灯速度 | ✔    |
| 斐波那契   | 矩阵快速幂加速计算斐波那契数列     | ✔    |

## 问题与总结

### 总结

首先，感谢您能阅读README到这里。

本项目中，我们几乎从零开始实现了一个基于RV32I指令集的轻量级单周期CPU，并在Minisys开发板上运行，独立的设计带来了结构与时序设计的独特性。我们在开发过程中也遇到了各式各样的问题，但在精心调试下最终都得到了解决。亲自动手写一个CPU对于理解计算机架构意义深刻，充分激发了我们对于软硬件协同方式开发的兴趣。

最后，诚挚感谢辛苦付出的张进老师、王薇老师、学生助教们，以及所有对本项目提供支持和帮助的人们。

### 遇到的问题

- 不同的指令集导致CPU设计架构存在不同
- Vivado首次将比特流烧写到开发板时总是失败，需要第二次才成功，怪麻烦的
- 由Hold time违例导致的若干时序交叉错误，Vivado的板上规划算法有待提升
- Vivado和Git的协同使用体感很差，随时随地都在conflict和merge

### 如何用硬件debug

- 仿真通过的，上板就不一定行了
- 为测试模块烧写一个简单测试来分模块debug
- 实现debug模式，在输出接口上输出各类调试信息

## 版本修改记录

详参 [CHANGELOG.md](https://github.com/GuTaoZi/FeatherCPU/blob/main/CHANGELOG.md).

