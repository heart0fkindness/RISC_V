# 🚀 RV32I Single Cycle RISC-V CPU

A fully synthesizable **32-bit single-cycle RISC-V processor** implementing the **RV32I base ISA**. Designed in Verilog with a clean **controller–datapath architecture** and validated using a **self-checking testbench**.

---

## 📌 Overview
This project implements a **single-cycle RISC-V CPU core** capable of executing arithmetic, logical, memory, branch, and jump instructions in a single clock cycle.

**Design Highlights:**
* **Modular Architecture:** Easy to navigate and scale.
* **Logical Separation:** Clean distinction between Control Unit and Datapath.
* **Functional Rigor:** Verified for timing and logical correctness.

---

## 🧠 Features

### ⚙️ CPU Architecture
* Fully synthesizable RV32I core.
* Integrated instruction ROM + data RAM.
* Debug-friendly memory override support.

### 🔗 Datapath
* **PC Logic:** 32-bit Program Counter with branch/jump offset calculation.
* **Imm Gen:** Immediate generation for I, S, B, and J formats.
* **Reg File:** 32×32 Register File (2 read ports, 1 write port).
* **ALU Operations:** * Arithmetic: `ADD`, `SUB`
    * Logic: `AND`, `OR`, `XOR`
    * Shifts: `SLL`, `SRL`, `SRA`
    * Comparison: `SLT`, `SLTU`
* **Condition Flags:** `Zero`, `LT`, `LTU`.

### 🎛️ Control Unit
Decodes instructions to generate critical signals including `RegWrite`, `MemWrite`, `ALUSrc`, `PCSrc`, `Jump`, `Jalr`, `ImmSrc`, `ResultSrc`, and `UpperSel`.

**Supported Instructions:**
* **Integer Computation:** ALU-immediate & Register-Register.
* **Memory Access:** Load/Store operations.
* **Control Flow:** Branches (`BEQ`, `BNE`, `BLT`, etc.) and Jumps (`JAL`, `JALR`).
* **Special:** `LUI`, `AUIPC`.

### 💾 Memory Subsystem
* **Instruction Memory:** 512 × 32-bit (ROM).
* **Data Memory:** 64 × 32-bit (RAM).
* **Load/Store Support:** `LB`, `LH`, `LW`, `LBU`, `LHU`, `SB`, `SH`, `SW`.
* Byte-addressable memory with proper sign/zero extension.

---

## 🧪 Verification



The design is validated using a **fully automated self-checking testbench**:
* **Instruction Coverage:** Validates 38 distinct RV32I instruction groups.
* **Automated Checks:** Monitors ALU outputs, memory state, and PC flow.
* **Reporting:** Generates a `pass/fail` results file.

> **Status:** All tests passed with 0 errors.

---

## 🛠️ Tech Stack
* **HDL:** Verilog HDL
* **Simulation:** ModelSim / Icarus Verilog
* **Architecture:** Single-cycle RISC-V (RV32I)

---

## 🧩 Project Structure


.
├── src/
│   ├── datapath.v         # Data processing elements
│   ├── controller.v       # Main & ALU decoder logic
│   ├── alu.v              # Arithmetic Logic Unit
│   ├── register_file.v    # 32x32 General Purpose Registers
│   └── memory.v           # Unified/Separate Memory blocks
├── testbench/
│   ├── cpu_tb.v           # Self-checking top-level testbench
│   └── test_programs/     # Hex/Assembly test files
├── results/
│   └── output_log.txt     # Simulation results
└── README.md

##📈 Future Improvements
*5-stage Pipelined implementation.
*Hazard detection and data forwarding.
*Instruction and Data Cache integration.
