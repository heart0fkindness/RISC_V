module riscv_cpu (
    input         clk, reset,
    output [31:0] PC,
    input  [31:0] Instr,
    output        MemWrite,
    output [31:0] Mem_WrAddr, Mem_WrData,
    input  [31:0] ReadData,
    output [31:0] Result
);
  wire        ALUSrc, RegWrite, Jump, Jalr, Zero, LT, LTU, UpperSel, PCSrc;
  wire [1:0]  ResultSrc, ImmSrc;
  wire [3:0]  ALUControl;

  controller c (
    .op(Instr[6:0]), .funct3(Instr[14:12]), .funct7b5(Instr[30]),
    .Zero(Zero), .LT(LT), .LTU(LTU),
    .ResultSrc(ResultSrc), .MemWrite(MemWrite), .PCSrc(PCSrc),
    .ALUSrc(ALUSrc), .RegWrite(RegWrite), .Jump(Jump), .Jalr(Jalr),
    .ImmSrc(ImmSrc), .UpperSel(UpperSel), .ALUControl(ALUControl)
  );

  datapath dp (
    .clk(clk), .reset(reset),
    .ResultSrc(ResultSrc), .PCSrc(PCSrc),
    .ALUSrc(ALUSrc), .RegWrite(RegWrite),
    .ImmSrc(ImmSrc), .ALUControl(ALUControl),
    .Jalr(Jalr), .UpperSel(UpperSel),
    .Zero(Zero), .LT(LT), .LTU(LTU),
    .PC(PC), .Instr(Instr),
    .Mem_WrAddr(Mem_WrAddr), .Mem_WrData(Mem_WrData),
    .ReadData(ReadData), .Result(Result)
  );
endmodule
