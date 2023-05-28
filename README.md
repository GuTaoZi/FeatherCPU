

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
| 🍑    |        | ✔    | ✔    |      | ✔    | ✔    |      | ✔    | ✔    |      | ✔    | ✔     |
| 🪶    | ✔      |      |      | ✔    |      | ✔    | ✔    | ✔    | ✔    | ✔    | ✔    | ✔     |

\* Uncountable detailed contributions are omitted here.

## Style Guide

This project is written in [Verilog Coding Style](https://verilogcodingstyle.readthedocs.io/en/latest/index.html).

## CPU Features

### Basic Information

Harvard architecture

CPU frequency: 25 MHz

CPI: 2 cycles/instruction

32-bit Registers: x0 - x31

### Instructions

This custom ISA is designed based on `RV32I`. 

32-bit Instructions, 32 General Registers of 32-bit width.

Some signed instructions beyond RV32I are implemented in this ISA. 

For more details, see [Feather ISA](doc/FeatherISA.md).

## CPU Interfaces

### **Clocks**

- FPGA frequency: 100 MHz
- CPU frequency: 25 MHz

### **Input interfaces**

- Uart interface, for instruction and data memory input
- 4X4 matrix keyboard, for memory-mapped input
- 24 switches, for debugging input
- Reset button: P5
- Input acknowledge button: P10
- Input reset button: P1
- Debugging state button: R1

### **Output interfaces**

- 8 segment tubes, displaying input data and CPU state information
- 24 leds, for memory-mapped output

## Internal Structures

### Inter-module connection diagram

![image.png](https://s2.loli.net/2023/05/27/CA4oYWeUBuwfrsa.png)

### Module descriptions

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


## Tests

### Module tests

|   Method   | Module                | Result | Descriptions                                                 |
| :--------: | --------------------- | :----: | ------------------------------------------------------------ |
| Simulation | InstDecoder           |   ✔    | Check whether the combinational logic module correctly decodes the instructions |
| Simulation | Filter                |   ✔    | The filter de-jitters the input signals and outputs stable signals. |
|  On-board  | Uart                  |   ✔    | The uart interface works well.                               |
|  On-board  | DMA and IO interfaces |   ✔    | The keyboard, segtubes, switches and LEDs work, and DMA accesses the memory correctly. |
|  On-board  | PC                    |   ✔    | PC is updated correctly according to controller and ALU.     |
|  On-board  | ALU                   |   ✔    | ALU correctly calculates the results for all instructions.   |
|  On-board  | Register              |   ✔    | The input and output of registers are correct.               |

### Integrated tests

|   Method   | Object        | Result | Descriptions                                                 |
| :--------: | ------------- | :----: | ------------------------------------------------------------ |
| Simulation | ID - EX - Reg |   ✔    | The combinatorial part works.                                |
|  On-board  | Top           |   ✔    | The usability test of all types of instructions              |
|  On-board  | Top           |   ✔    | [Test scenario 1](https://github.com/GuTaoZi/FeatherCPU/tree/main/asm). See [project requirement](https://github.com/GuTaoZi/FeatherCPU/blob/main/doc/Project%20Requirements.pdf) |
|  On-board  | Top           |   ✔    | [Test scenario 2](https://github.com/GuTaoZi/FeatherCPU/tree/main/asm). See [project requirement](https://github.com/GuTaoZi/FeatherCPU/blob/main/doc/Project%20Requirements.pdf) |

### Bonus tests

| Testcase  | Descriptions                                                 | Result |
| --------- | ------------------------------------------------------------ | ------ |
| Marquee   | Use MMIO to control the running speed of the marquee.        | ✔      |
| Fibonacci | Calculate the Fibonacci sequence with fast matrix exponential. | ✔      |

## Summary

### Conclusion

In this project, we implement a single-cycle CPU for FeatherISA running on Minisys from scratch without referencing others' implementations. Though many bugs were met during the process of development, they were then solved with great efforts. This is really meaningful for understanding the architectures of computers, and stimulates our interest of hardware-software cooperating development.

Great thanks for Prof. Zhang, TA Wang Wei, SAs, and everyone else who contributes to the development of this project!

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

## TODOs

- [x] CPU Features
  - [x] ISA Design
  - [x] Address Space Design
  - [x] Fast Single Cycle Design
  - [x] Debugging
- [x] CPU Interfaces
  - [x] Clock
  - [x] Reset
  - [x] Uart
  - [x] Others: Keyboard, segment tubes
- [x] Internal Structures
  - [x] Module interconnections
  - [x] Module introduction
- [x] Tests
  - [x] Basic testcases \#1
  - [x] Basic testcases \#2
  - [x] Bonus testcases
  - [x] Video for bonus part
- [x] Summary
