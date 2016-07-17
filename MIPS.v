`include "DMEM.v"
`include "IMEM.v"
`include "REGISTER_BANK.v"
`include "ULA.v"
`include "AdderPc4.v"
`include "Controle.v"
`include "ShiftLeft2.v"
`include "Mux1.v"
`include "Mux2.v"
`include "Mux3.v"
`include "ShiftModule.v"
`include "ShiftRightModule.v"
`include "SignExtend.v"
`include "OverflowModule.v"



module MIPS(clk);


//input [31:0] initialAddress;
input [0:0] clk;
//wire [31:0] initialAddress;
wire [0:0] clk;



///// PC //////
reg [31:0] outputPC;
initial
begin
	outputPC = 0; // initial address
end




// PC+4 //
//wire [31:0] pc_plus_4;
//AdderPC4 adderPC4(outputPC, pc_plus_4);
// PC+4 //


// JumpAddress //
//wire newAddress [31:0];
//JumpAddrModule jumpAddrModule(pc_plus_4, address, newAddress);
// JumpAddress //

//always @(negedge clk) //posedge
//	begin
//		outputPC = pc_plus_4;
//	end


/// PC //////


//// Instruction Memory ////
wire [31:0] instruction;
//reg [31:0] instruction;
IMEM instructionMemory (clk, outputPC, instruction);
//// Instruction Memory ////




wire [5:0] opcode;
wire [5:0] funct;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [4:0] shamt;
wire [15:0] immediate;
wire [25:0] address;


assign opcode = instruction [31:26];
assign funct = instruction [5:0];
assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
assign shamt = instruction[10:6];
assign immediate = instruction[15:0];
assign address = instruction[25:0];




//// Controle /////

wire [0:0] regDst;
wire [0:0] jump;
wire [1:0] branch;
//wire [0:0] memRead;
wire [1:0] memRead;
//wire [0:0] memWrite;
//wire [3:0] memWrite;
wire [1:0] memWrite;
wire [3:0] ALUop;
wire [0:0] memToReg;
wire [0:0] ALUsrc;
wire [0:0] regWrite;
wire [0:0] sinalMuxJal;
wire [0:0] sinalSll;
wire [0:0] sinalSrl;
wire [0:0] sinalZeroOrSign;
wire [0:0] sinalLui;
wire [0:0] sinalMayCauseOverflow;
wire [0:0] sinalDoControleLhu;
wire [0:0] sinalDoControleLbu;
wire [0:0] sinalJal;
wire [0:0] sinalJr;

Controle controle (clk, opcode, funct, regDst, jump, branch, memRead, memWrite, ALUop, memToReg, ALUsrc, regWrite, sinalMuxJal, sinalSll, sinalSrl, sinalZeroOrSign, sinalLui,sinalMayCauseOverflow, sinalDoControleLhu, sinalDoControleLbu, sinalJal, sinalJr);


//// Controle /////




// PC+4 //
wire [31:0] pc_plus_4;
AdderPC4 adderPC4(outputPC, pc_plus_4);
// PC+4 //


// JumpAddress //
wire [31:0] newAddress;
JumpAddrModule jumpAddrModule(pc_plus_4, address, newAddress);
// JumpAddress //

// Mux Jump //
wire [31:0] saidaJump;
wire [31:0] saidaMuxBranch; // utilizado nos branches abaixo
//Mux32 muxJump(pc_plus_4, newAddress, jump, saidaJump);
Mux32 muxJump(saidaMuxBranch, newAddress, jump, saidaJump);

// Mux Jump //


// saidas da ula //
wire [31:0] read_data_1, read_data_2;

// saidas da ula //

// Mux jr //
wire [31:0] saidaMuxJr;
Mux32 muxJr(saidaJump, read_data_1, sinalJr, saidaMuxJr);
// Mux jr //

// PC antigo//
reg [31:0] pcAntigo;
// PC antigo//

always @(negedge clk) //posedge
	begin
		pcAntigo = outputPC;
		//outputPC = saidaJump;
		outputPC = saidaMuxJr;
	end





// Mux 1 (rt ou rd) ///
wire [4:0] saidaMux1;
Mux5 mux1 (rt, rd, regDst, saidaMux1); // Mux5 = Mux of 5bits
// Mux 1 (rt ou rd) ///

// Mux 2 (jal) //
wire [4:0] saidaMuxJal;
Mux2 muxJal(saidaMux1, sinalMuxJal, saidaMuxJal); // Mux5 = Mux 5bits
// Mux 2 (jal) //



// Register Bank //
wire [31:0] write_data_reg;
// wire [31:0] read_data_1, read_data_2; definidos anteriormente, para utilizacao no jr


// Mux overflow or not //
wire [0:0] saidaOverflowModule; // utilizado no modulo de overflow, 1==overflow, 0=ok
wire [0:0] saidaMuxOverflow;
MuxOverflow muxOverflow(regWrite, saidaOverflowModule, saidaMuxOverflow);


// mudar sinal para overflow
//REGISTER_BANK registerBank(clk, regWrite, write_data_reg, saidaMuxJal, rs, rt, read_data_1, read_data_2);
REGISTER_BANK registerBank(clk, saidaMuxOverflow, write_data_reg, saidaMuxJal, rs, rt, read_data_1, read_data_2);

// Register Bank //

// SignExtend //
wire [31:0] signExtendImmediate;
SignExtend signExtend (immediate, signExtendImmediate);
// SignExtend //

// ZeroExtend //
wire [31:0] zeroExtendImmediate;
ZeroExtend zertoExtend(immediate, zeroExtendImmediate);
// ZeroExtend //

// ZeroExtend or SignExtend MUX //
wire [31:0] saidaZeroOrSign;
Mux32 zeroOrSign(signExtendImmediate, zeroExtendImmediate, sinalZeroOrSign, saidaZeroOrSign);

// ZeroExtend or SignExtend MUX //

// ALUSrc Mux //
wire [31:0] saidaMuxALUsrc;
//Mux32 MuxALUsrc (read_data_2, signExtendImmediate, ALUsrc, saidaMuxALUsrc);
Mux32 MuxALUsrc (read_data_2, saidaZeroOrSign, ALUsrc, saidaMuxALUsrc);
//ALUSrc Mux


// ULA //

wire [0:0] isALUZero;
wire [31:0] ALUOutput;
ULA alu (read_data_1, saidaMuxALUsrc, ALUOutput, ALUop, isALUZero);
// ULA //

// OverflowModule //

// Se for para continuar, zerar todos os sinais de controle no overflowModule
// wire [0:0] saidaOverflowModule; // definido anteriormente
OverflowModule overflowModule (read_data_1, saidaMuxALUsrc, ALUop, sinalMayCauseOverflow, saidaOverflowModule);

// OverflowModule //



// DMEM //
wire [31:0] DMEMOutput;
DMEM dataMemory (clk, read_data_2, DMEMOutput, memWrite, memRead, ALUOutput);

// DMEM //



// lhu//
//wire [31:0] lhu;
//assign lhu [31:16] = 0;
//assign lhu [15] = DMEMOutput[15];
//assign lhu [14] = DMEMOutput[14];
//assign lhu [13] = DMEMOutput[13];
//assign lhu [12] = DMEMOutput[12];
//assign lhu [11] = DMEMOutput[11];
//assign lhu [10] = DMEMOutput[10];
//assign lhu [9] = DMEMOutput[9];
//assign lhu [8] = DMEMOutput[8];
//assign lhu [7] = DMEMOutput[7];
//assign lhu [6] = DMEMOutput[6];
//assign lhu [5] = DMEMOutput[5];
//assign lhu [4] = DMEMOutput[4];
//assign lhu [3] = DMEMOutput[3];
//assign lhu [2] = DMEMOutput[2];
//assign lhu [1] = DMEMOutput[1];
//assign lhu [0] = DMEMOutput[0];
// lhu//
// Mux datamemory (lw or lhu)
//wire [31:0] muxLwOrLhuOutput;
//Mux32 muxLwOrLhu(DMEMOutput, lhu, sinalDoControleLhu, muxLwOrLhuOutput);
// Mux datamemory (lw or lhu)

// lbu//
//wire [31:0] lbu;
//assign lbu [31:8] = 0;
//assign lbu [7] = DMEMOutput[7];
//assign lbu [6] = DMEMOutput[6];
//assign lbu [5] = DMEMOutput[5];
//assign lbu [4] = DMEMOutput[4];
//assign lbu [3] = DMEMOutput[3];
//assign lbu [2] = DMEMOutput[2];
//assign lbu [1] = DMEMOutput[1];
//assign lbu [0] = DMEMOutput[0];
// lbu//


// Mux datamemory ( [lw or lhu]  or lbu)
//wire [31:0] muxLwOrLhuOrLbuOutput;
//Mux32 muxLwOrLhuOrLbu(muxLwOrLhuOutput, lbu, sinalDoControleLbu, muxLwOrLhuOrLbuOutput);
// Mux datamemory ( [lw or lhu] or lbu)



// Mux MemToReg //
wire [31:0] saidaMuxMemToReg;
Mux32 muxMemToReg(ALUOutput, DMEMOutput, memToReg, saidaMuxMemToReg); // Mux32 = Mux of 32bits
//Mux32 muxMemToReg(ALUOutput, muxLwOrLhuOrLbuOutput, memToReg, saidaMuxMemToReg); // Mux32 = Mux of 32bits

// Mux MemToReg //


// Shift Left Module //
wire [31:0] saidaShiftLeftModule;
ShiftLeftModule shiftLeftModule (read_data_2, shamt, sinalSll, saidaShiftLeftModule);
// originalmente deveria ser read_data_2, mas o circuito trata o segundo registrador do sll como Rs ao inves de Rt 

// Shift Left Module //



// Mux shift left//
wire [31:0] saidaMuxShiftLeft;
Mux32 muxShiftLeft(saidaMuxMemToReg, saidaShiftLeftModule, sinalSll, saidaMuxShiftLeft);
// Mux shift left //


// Shift Right Module //
wire [31:0] saidaShiftRightModule;
ShiftRightModule shiftRightModule (read_data_2, shamt, sinalSrl, saidaShiftRightModule);
// originalmente deveria ser read_data_2, mas o circuito trata o segundo registrador do sll como Rs ao inves de Rt 

// Shift Rigth Module //


// Mux shift right//
wire [31:0] saidaMuxShiftRight;
Mux32 muxShiftRight(saidaMuxShiftLeft, saidaShiftRightModule, sinalSrl, saidaMuxShiftRight);
// Mux shift left //


// Mux lui or not //
wire [31:0] imm16b;
assign imm16b [15:0] = 16'b0;
assign imm16b [31:16] = immediate[15:0];
wire [31:0] saidaMuxMemToRegShiftOrLui;
Mux32 muxMemToRegShiftOrLui(saidaMuxShiftRight, imm16b, sinalLui, saidaMuxMemToRegShiftOrLui);
// Mux lui or not //


// Mux result or PC+4 (Jal) //
wire [31:0] saidaMuxResultOrPc4Jal;
Mux32 muxResultOrPc4Jal(saidaMuxMemToRegShiftOrLui, (pcAntigo+4), sinalJal, saidaMuxResultOrPc4Jal);
// Mux result or PC+4 (Jal) //



//assign write_data_reg = saidaMuxMemToReg;
//assign write_data_reg = saidaMuxShiftRight;
//assign write_data_reg = saidaMuxMemToRegShiftOrLui;
assign write_data_reg = saidaMuxResultOrPc4Jal;



// Branches //
wire [31:0] shiftLeft2BranchOutput;
ShiftLeft2Branch shifLeft2Branch(signExtendImmediate, shiftLeft2BranchOutput);

wire [31:0] outputAdderBranch; 
Adder adder(pc_plus_4, shiftLeft2BranchOutput, outputAdderBranch);

wire [0:0] saidaControleBranch;
ControleBranch controleBranch(branch, isALUZero, saidaControleBranch);

//wire [31:0] saidaMuxBranch; // definido em cima
Mux32 muxBranches(pc_plus_4, outputAdderBranch, saidaControleBranch, saidaMuxBranch);


// Branches//

endmodule
