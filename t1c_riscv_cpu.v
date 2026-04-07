module t1c_riscv_cpu (
    input         clk, reset,
    input         Ext_MemWrite,
    input  [31:0] Ext_WriteData, Ext_DataAdr,
    output        MemWrite,
    output [31:0] WriteData, DataAdr,
    output [31:0] ReadData,
    output [31:0] PC, Result
);
  wire [31:0] Instr;
  wire        cpu_MemWrite;
  wire [31:0] cpu_DataAdr, cpu_WriteData;

  instr_mem imem (.instr_addr(PC), .instr(Instr));

  riscv_cpu core (
    .clk(clk), .reset(reset),
    .PC(PC), .Instr(Instr),
    .MemWrite(cpu_MemWrite),
    .Mem_WrAddr(cpu_DataAdr),
    .Mem_WrData(cpu_WriteData),
    .ReadData(ReadData),
    .Result(Result)
  );

  wire        dmem_wr_en   = cpu_MemWrite | Ext_MemWrite;
  wire [31:0] dmem_wr_addr = Ext_MemWrite ? Ext_DataAdr   : cpu_DataAdr;
  wire [31:0] dmem_wr_data = Ext_MemWrite ? Ext_WriteData : cpu_WriteData;

  data_mem dmem (
    .clk(clk),
    .wr_en(dmem_wr_en),
    .funct3(Instr[14:12]),
    .wr_addr(dmem_wr_addr),
    .wr_data(dmem_wr_data),
    .rd_data_mem(ReadData)
  );

  assign MemWrite  = cpu_MemWrite;
  assign DataAdr   = cpu_DataAdr;
  assign WriteData = cpu_WriteData;
endmodule
