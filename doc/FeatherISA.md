## Feather ISA

This custom ISA is designed based on `RV32I`. 

32-bit Instructions, 32 General Registers of 32-bit width.

Some signed instructions beyond RV32I are implemented in this ISA. 

- [ ] `ebreak` interruption implementation

### Instruction Format

<img src="https://s2.loli.net/2023/04/19/74xdmlkVQotgSMf.png" style="zoom: 67%;" />

Instructions with \* are custom instructions beyond `RV32I`.

### R type

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
        <td>mul</td>
        <td>Mul</td>
        <td>0110011</td>
        <td>000</td>
        <td>0x01</td>
        <td>rd = rs1 * rs2</td>
        <td>low 32 bits</td>
    </tr>
    <tr>
        <td>*addu</td>
        <td>Unsigned Add</td>
        <td>0110011</td>
        <td>000</td>
        <td>0x02</td>
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
        <td>0x04</td>
        <td>rd = rs1 - rs2</td>
        <td>ignore overflow</td>
    </tr>
    <tr>
        <td>sll</td>
        <td>Shift Left Logical</td>
        <td>0110011</td>
        <td>001</td>
        <td>0x00</td>
        <td>rd = rs1 << rs2</td>
        <td></td>
    </tr>
    <tr>
        <td>slt</td>
        <td>Set Less Than</td>
        <td>0110011</td>
        <td>010</td>
        <td>0x00</td>
        <td>rd = rs1 < rs2</td>
        <td></td>
    </tr>
    <tr>
        <td>sltu</td>
        <td>Unsigned Set Less Than</td>
        <td>0110011</td>
        <td>011</td>
        <td>0x00</td>
        <td>rd = rs1 < rs2</td>
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
        <td>div</td>
        <td>Div</td>
        <td>0110011</td>
        <td>100</td>
        <td>0x01</td>
        <td>rs = rs1 / rs2</td>
        <td></td>
    </tr>
    <tr>
        <td>srl</td>
        <td>Shift Right Logical</td>
        <td>0110011</td>
        <td>101</td>
        <td>0x00</td>
        <td>rd = rs1 >> rs2</td>
        <td></td>
    </tr>
    <tr>
        <td>sra</td>
        <td>Shift Right Arithmetic</td>
        <td>0110011</td>
        <td>101</td>
        <td>0x20</td>
        <td>rd = rs1 >> rs2</td>
        <td>msb-extends</td>
    </tr>
    <tr>
        <td>or</td>
        <td>Or</td>
        <td>0110011</td>
        <td>110</td>
        <td>0x00</td>
        <td>rd = rs1 | rs2</td>
        <td>rs2</td>
    </tr>
    <tr>
        <td>rem</td>
        <td>Remainder</td>
        <td>0110011</td>
        <td>110</td>
        <td>0x01</td>
        <td>rd = rs1 % rs2</td>
        <td></td>
    </tr>
    <tr>
        <td>and</td>
        <td>And</td>
        <td>0110011</td>
        <td>111</td>
        <td>0x00</td>
        <td>rd = rs1 & rs2</td>
        <td></td>
    </tr>
</table>
</details>


### I type

<details>
    <table>
        <tr>
            <td><b>Inst</b></td>
            <td><b>Name</b></td>
            <td><b>Opcode</b></td>
            <td><b>funct3</b></td>
            <td><b>imm[11:5]</b></td>
            <td><b>Description</b></td>
            <td><b>Note</b></td>
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


### S type

<details>
<table>
    <tr>
        <td><b>Inst</b></td>
        <td><b>Name</b></td>
        <td><b>Opcode</b></td>
        <td><b>funct3</b></td>
        <td><b>Description</b></td>
    </tr>
    <tr>
        <td>sb</td>
        <td>Store Byte</td>
        <td>0100011</td>
        <td>000</td>
        <td>M[rs1+imm][0:7]=rs2[0:7]</td>
    </tr>
    <tr>
        <td>sh</td>
        <td>Store Half</td>
        <td>0100011</td>
        <td>001</td>
        <td>M[rs1+imm][0:15]=rs2[0:15]</td>
    </tr>
    <tr>
        <td>sw</td>
        <td>Store Word</td>
        <td>0100011</td>
        <td>010</td>
        <td>M[rs1+imm][0:31]=rs2[0:31]</td>
    </tr>
</table>
</details>


### B type 

<details>
<table>
    <tr>
        <td><b>Inst</b></td>
        <td><b>Name</b></td>
        <td><b>Opcode</b></td>
        <td><b>funct3</b></td>
        <td><b>Description</b></td>
        <td><b>Note</b></td>
    </tr>
    <tr>
        <td>beq</td>
        <td>Branch ==</td>
        <td>1100011</td>
        <td>000</td>
        <td>if(rs1 == rs2) PC+=imm</td>
        <td></td>
    </tr>
    <tr>
        <td>bne</td>
        <td>Branch !=</td>
        <td>1100011</td>
        <td>001</td>
        <td>if(rs1 != rs2) PC+=imm</td>
        <td></td>
    </tr>
    <tr>
        <td>blt</td>
        <td>Branch &lt;</td>
        <td>1100011</td>
        <td>100</td>
        <td>if(rs1 &lt; rs2) PC+=imm</td>
        <td></td>
    </tr>
    <tr>
        <td>bge</td>
        <td>Branch ≥</td>
        <td>1100011</td>
        <td>101</td>
        <td>if(rs1 &gt;= rs2) PC+=imm</td>
        <td></td>
    </tr>
    <tr>
        <td>bltu</td>
        <td>Unsigned Branch &lt;</td>
        <td>1100011</td>
        <td>110</td>
        <td>if(rs1 &lt; rs2) PC+=imm</td>
        <td>zero-extends</td>
    </tr>
    <tr>
        <td>bgeu</td>
        <td>Unsigned Branch ≥</td>
        <td>1100011</td>
        <td>111</td>
        <td>if(rs1 &gt;= rs2) PC+=imm</td>
        <td>zero-extends</td>
    </tr>
</table>
</details>


### J type

<details>
<table>
    <tr>
        <td><b>Inst</b></td>
        <td><b>Name</b></td>
        <td><b>Opcode</b></td>
        <td><b>funct3</b></td>
        <td><b>Description</b></td>
    </tr>
    <tr>
        <td>jal</td>
        <td>Jump And Link</td>
        <td>1101111</td>
        <td></td>
        <td>rd = PC + 4, PC += imm</td>
    </tr>
    <tr>
        <td>jalr</td>
        <td>Jump And Link Reg</td>
        <td>1100111</td>
        <td>000</td>
        <td>rd = PC + 4, PC = rs1 + imm</td>
    </tr>
</table>
</details>


### U type

<details>
<table>
    <tr>
        <td><b>Inst</b></td>
        <td><b>Name</b></td>
        <td><b>Opcode</b></td>
        <td><b>Description</b></td>
    </tr>
    <tr>
        <td>lui</td>
        <td>Load Upper Imm</td>
        <td>0110111</td>
        <td>rd = imm &lt;&lt; 12</td>
    </tr>
    <tr>
        <td>auipc</td>
        <td>Add Upper Imm to PC</td>
        <td>0010111</td>
        <td>rd = PC + (imm &lt;&lt; 12)</td>
    </tr>
</table>
</details>
