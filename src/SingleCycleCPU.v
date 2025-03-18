module SingleCycleCPU (
    input   wire        clk,
    input   wire        start, //reset when == 0
    output  wire [7:0]  segments,
    output  wire [3:0]  an
);

// When input start is zero, cpu should reset
// When input start is high, cpu start running

// TODO: Connect wires to realize SingleCycleCPU and instantiate all modules related to seven-segment displays
// The following provides simple template,

wire [31:0] to_pc;
wire [31:0] from_pc;
PC m_PC(
    .clk(clk),
    .rst(start),
    .pc_i(to_pc),
    .pc_o(from_pc)
);

integer b = 4;
wire [31:0] from_pcadder;
Adder m_Adder_1(
    .a(from_pc),
    .b(b),
    .sum(from_pcadder)
);

wire [31:0] from_instmem;
InstructionMemory m_InstMem(
    .readAddr(from_pc),
    .inst(from_instmem)
);

wire MemRead;
wire MemToReg;
wire ALUOp;
wire MemWrite;
wire PCSel;
wire ALUSrc1;
wire ALUSrc2;
wire RegWrite;
Control m_Control(
    .opcode(from_instmem[6:0]),
    .memRead(MemRead),
    .memtoReg(MemToReg),
    .ALUOp(ALUOp),
    .memWrite(MemWrite),
    .ALUSrc1(ALUSrc1),
    .ALUSrc2(ALUSrc2),
    .regWrite(RegWrite),
    .PCSel(PCSel)
);

// ------------------------------------------
// For Student:
// Do not change the modules' instance names and I/O port names!!
// Or you will fail validation.
// By the way, you still have to wire up these modules

wire [31:0] regdata1;
wire [31:0] regdata2;
wire [31:0] from_31mux;
wire [31:0] for_sevenSegDis;
Register m_Register(
    .clk(clk),
    .rst(start),
    .regWrite(RegWrite),
    .readReg1(from_instmem[19:15]),
    .readReg2(from_instmem[24:20]),
    .writeReg(from_instmem[11:7]),
    .writeData(from_31mux),
    .readData1(regdata1),
    .readData2(regdata2),
    .reg5Data(for_sevenSegDis)
);

SevenSegmentDisplay sevenSegDis(
    .DataIn(for_sevenSegDis[15:0]), //4(32)
    .Clk(clk),
    .Reset(!start) //reset when == 0
);

wire [31:0] read_from_mem;
wire [31:0] from_ALU;
DataMemory m_DataMemory(
    .rst(start),
    .clk(clk),
    .memWrite(MemWrite),
    .memRead(MemRead),
    .address(from_ALU),
    .writeData(regdata2),
    .readData(read_from_mem)
);

// ------------------------------------------

wire [31:0] from_immgen;
ImmGen m_ImmGen(
    .inst(from_instmem[31:0]),
    .imm(from_immgen)
);

Mux2to1 #(.size(32)) m_Mux_PC(
    .sel(PCSel),
    .s0(from_pcadder),
    .s1(from_ALU),
    .out(to_pc)
);

wire [31:0] from_21mux1;
Mux2to1 #(.size(32)) m_Mux_ALU_1(
    .sel(ALUSrc1),
    .s0(regdata1),
    .s1(from_pc),
    .out(from_21mux1)
);

wire [31:0] from_21mux2;
Mux2to1 #(.size(32)) m_Mux_ALU_2(
    .sel(ALUSrc2),
    .s0(regdata1),
    .s1(from_immgen),
    .out(from_21mux2)
);

wire [3:0] from_ALUCtrl;
ALUCtrl m_ALUCtrl(
    .ALUOp(ALUOp),
    .funct7(from_instmem[30]),
    .funct3(from_instmem[14:12]),
    .ALUCtl(from_ALUCtrl)
);

wire brlt;
wire breq;
ALU m_ALU(
    .ALUctl(from_ALUCtrl),
    .brLt(brlt),
    .brEq(breq),
    .A(from_21mux1),
    .B(from_21mux2),
    .ALUOut(from_ALU)
);

Mux3to1 #(.size(32)) m_Mux_WriteData(
    .sel(MemToReg),
    .s0(from_ALU),
    .s1(read_from_mem),
    .s2(from_pcadder),
    .out(from_31mux)
);

BranchComp m_BranchComp(
    .rs1(regdata1),
    .rs2(regdata2),
    .brLt(brlt),
    .brEq(breq)
);

endmodule
