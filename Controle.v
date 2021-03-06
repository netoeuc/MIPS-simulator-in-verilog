module Controle(clk, opcode, funct, regDst, jump, branch, memRead, memWrite, ALUop, memToReg, ALUsrc, regWrite, sinalMuxJal, sinalSll, sinalSrl,sinalZeroOrSign, sinalLui, sinalMayCauseOverflow, sinalDoControleLhu, sinalDoControleLbu, sinalJal, sinalJr);

input [0:0] clk;
input [5:0] opcode;
input [5:0] funct;
wire [5:0] opcode;
wire [5:0] funct;
wire [0:0] clk;

output [0:0] regDst;
output [0:0] jump;
output [1:0] branch;
//output [0:0] memRead;
output [1:0] memRead;
//output [0:0] memWrite;
//output [3:0] memWrite;
output [1:0] memWrite;
output [3:0] ALUop;
output [0:0] memToReg;
output [0:0] ALUsrc;
output [0:0] regWrite;
output [0:0] sinalMuxJal;
output [0:0] sinalSll;
output [0:0] sinalSrl;
output [0:0] sinalZeroOrSign;
output [0:0] sinalLui;
output [0:0] sinalMayCauseOverflow;
output [0:0] sinalDoControleLhu;
output [0:0] sinalDoControleLbu;
output [0:0] sinalJal;
output [0:0] sinalJr;

reg [0:0] regDst;
reg [0:0] jump;
reg [1:0] branch;
//reg [0:0] memRead;
reg [1:0] memRead;
//reg [0:0] memWrite;
//reg [3:0] memWrite;
reg [1:0] memWrite;
reg [3:0] ALUop;
reg [0:0] memToReg;
reg [0:0] ALUsrc;
reg [0:0] regWrite;
reg [0:0] sinalMuxJal;
reg [0:0] sinalSll;
reg [0:0] sinalSrl;
reg [0:0] sinalZeroOrSign;
reg [0:0] sinalLui;
reg [0:0] sinalMayCauseOverflow;
reg [0:0] sinalDoControleLhu;
reg [0:0] sinalDoControleLbu;
reg [0:0] sinalJal;
reg [0:0] sinalJr;

initial begin
	regDst = 0;
	jump = 0;
	branch = 00;
	memRead = 0;
	memWrite = 00;
	ALUop = 0;
	memToReg = 0;
	ALUsrc = 0;
	regWrite = 0;
	sinalMuxJal = 0;
	sinalSll = 0;
	sinalSrl = 0;
	sinalZeroOrSign = 0;
	sinalLui = 0;
	sinalMayCauseOverflow = 0;
	sinalDoControleLhu = 0;
	sinalDoControleLbu = 0;
	sinalJal = 0;
	sinalJr = 0;
end 

always @(opcode or funct or clk)
	begin:control
		case (opcode)
			
			6'b00:
				case (funct)
					6'b100000: // add
						begin
							regDst = 1; 
							jump = 0;
							branch = 2'b00;
							memRead = 0;
							memWrite = 0; 
							ALUop = 4'b0010; // add
							memToReg = 0;
							ALUsrc = 0; 
							regWrite = 1; 
							sinalMuxJal = 0;
							sinalSll = 0;
							sinalSrl = 0;
							sinalZeroOrSign = 0;
							sinalLui = 0;
							sinalMayCauseOverflow = 1; //may cause overflow
							sinalDoControleLhu = 0;
							sinalDoControleLbu = 0;
							sinalJal = 0;
							sinalJr = 0;
						end
					
					6'b100001:  // addu
						begin
							regDst = 1; 
							jump = 0;
							branch = 2'b00;
							memRead = 0;
							memWrite = 0; 
							ALUop = 4'b0010; // addu
							memToReg = 0;
							ALUsrc = 0; 
							regWrite = 1; 
							sinalMuxJal = 0;
							sinalSll = 0;
							sinalSrl = 0;
							sinalZeroOrSign = 0;
							sinalLui = 0;
							sinalMayCauseOverflow = 0;
							sinalDoControleLhu = 0;
							sinalDoControleLbu = 0;
							sinalJal = 0;
							sinalJr = 0;

						end
					
					
					6'b100100: //and
						begin
	
							regDst = 1;
							jump = 0;
							branch = 2'b00;
							memRead = 0;
							memWrite = 0;
							ALUop = 4'b0000; // and
							memToReg = 0;
							ALUsrc = 0;
							regWrite = 1;
							sinalMuxJal = 0;
							sinalSll = 0;
							sinalSrl = 0;
							sinalZeroOrSign = 0;
							sinalLui = 0;	
							sinalMayCauseOverflow = 0;	
							sinalDoControleLhu = 0;
							sinalDoControleLbu = 0;
							sinalJal = 0;
							sinalJr = 0;
				
						end
					
					6'b001000:  //jr
						begin
	
							regDst = 0;
							jump = 0;
							branch = 2'b00;
							memRead = 0;
							memWrite = 0;
							ALUop = 0;
							memToReg = 0;
							ALUsrc = 0;
							regWrite = 0;
							sinalMuxJal = 0;
							sinalSll = 0;
							sinalSrl = 0;
							sinalZeroOrSign = 0;
							sinalLui = 0;	
							sinalMayCauseOverflow = 0;	
							sinalDoControleLhu = 0;
							sinalDoControleLbu = 0;
							sinalJal = 0;
							sinalJr = 1;
				
						end
					6'b100111: //nor
						begin
							regDst = 1; 
							jump = 0;
							branch = 2'b00;
							memRead = 0;
							memWrite = 0; 
							ALUop = 1100; // nor
							memToReg = 0;
							ALUsrc = 0; 
							regWrite = 1; 
							sinalMuxJal = 0;
							sinalSll = 0;
							sinalSrl = 0;
							sinalZeroOrSign = 0;
							sinalLui = 0;
							sinalMayCauseOverflow = 0;
							sinalDoControleLhu = 0;
							sinalDoControleLbu = 0;
							sinalJal = 0;
							sinalJr = 0;

							
							
						end
					6'b100101: //or
						begin
							regDst = 1; 
							jump = 0;
							branch = 2'b00;
							memRead = 0;
							memWrite = 0; 
							ALUop = 4'b0001; // or
							memToReg = 0;
							ALUsrc = 0; 
							regWrite = 1; 
							sinalMuxJal = 0;
							sinalSll = 0;
							sinalSrl = 0;
							sinalZeroOrSign = 0;
							sinalLui = 0;
							sinalMayCauseOverflow = 0;
							sinalDoControleLhu = 0;
							sinalDoControleLbu = 0;
							sinalJal = 0;
							sinalJr = 0;

						end
					6'b101010: //slt
						begin
							regDst = 1; 
							jump = 0;
							branch = 2'b00;
							memRead = 0;
							memWrite = 0; 
							ALUop = 4'b0111; // slt
							memToReg = 0;
							ALUsrc = 0; 
							regWrite = 1; 
							sinalMuxJal = 0;
							sinalSll = 0;
							sinalSrl = 0;
							sinalZeroOrSign = 0;
							sinalLui = 0;
							sinalDoControleLhu = 0;
							sinalDoControleLbu = 0;
							sinalJal = 0;
							sinalJr = 0;

						end
					6'b101011: //sltu
						begin
							regDst = 1; 
							jump = 0;
							branch = 2'b00;
							memRead = 0;
							memWrite = 0; 
							ALUop = 4'b1000; // sltu
							memToReg = 0;
							ALUsrc = 0; 
							regWrite = 1; 
							sinalMuxJal = 0;
							sinalSll = 0;
							sinalSrl = 0;
							sinalZeroOrSign = 0;
							sinalLui = 0;
							sinalDoControleLhu = 0;
							sinalDoControleLbu = 0;
							sinalJal = 0;
							sinalJr = 0;

						end
					6'b000000: // sll
						begin
							regDst = 1; 
							jump = 0;
							branch = 2'b00;
							memRead = 0;
							memWrite = 0; 
							ALUop = 0;
							memToReg = 0;
							ALUsrc = 0; 
							regWrite = 1; 
							sinalMuxJal = 0;
							sinalSll = 1;
							sinalSrl = 0;
							sinalZeroOrSign = 0;
							sinalLui = 0;
							sinalMayCauseOverflow = 0;
							sinalDoControleLhu = 0;
							sinalDoControleLbu = 0;
							sinalJal = 0;
							sinalJr = 0;

							
						end
					6'b000010: //srl
						begin
							regDst = 1; 
							jump = 0;
							branch = 2'b00;
							memRead = 0;
							memWrite = 0; 
							ALUop = 0;
							memToReg = 0;
							ALUsrc = 0; 
							regWrite = 1; 
							sinalMuxJal = 0;
							sinalSll = 0;
							sinalSrl = 1;
							sinalZeroOrSign = 0;
							sinalLui = 0;
							sinalMayCauseOverflow = 0;
							sinalDoControleLhu = 0;
							sinalDoControleLbu = 0;
							sinalJal = 0;
							sinalJr = 0;

							
						end
					6'b100010: // sub
						begin
							regDst = 1; 
							jump = 0;
							branch = 2'b00;
							memRead = 0;
							memWrite = 0; 
							ALUop = 4'b0110; // sub
							memToReg = 0;
							ALUsrc = 0; 
							regWrite = 1; 
							sinalMuxJal = 0;
							sinalSll = 0;
							sinalSrl = 0;
							sinalZeroOrSign = 0;
							sinalLui = 0;
							sinalMayCauseOverflow = 1; // may cause overflow
							sinalDoControleLhu = 0;
							sinalDoControleLbu = 0;
							sinalJal = 0;
							sinalJr = 0;

						end
					6'b00100011: // subu
						begin
							regDst = 1; 
							jump = 0;
							branch = 2'b00;
							memRead = 0;
							memWrite = 0; 
							ALUop = 4'b0110; // sub
							memToReg = 0;
							ALUsrc = 0; 
							regWrite = 1; 
							sinalMuxJal = 0;
							sinalSll = 0;
							sinalSrl = 0;
							sinalZeroOrSign = 0;
							sinalLui = 0;
							sinalMayCauseOverflow = 0;
							sinalDoControleLhu = 0;
							sinalDoControleLbu = 0;
							sinalJal = 0;
							sinalJr = 0;

						end
					6'b001101:
						begin
							$finish;
						end
					default:
						begin
							regDst = 0; 
							jump = 0;
							branch = 2'b00;
							memRead = 0;
							memWrite = 0; 
							ALUop = 0; // sub
							memToReg = 0;
							ALUsrc = 0; 
							regWrite = 0; 
							sinalMuxJal = 0;
							sinalSll = 0;
							sinalSrl = 0;
							sinalZeroOrSign = 0;
							sinalLui = 0;
							sinalMayCauseOverflow = 0;
							sinalDoControleLhu = 0;
							sinalDoControleLbu = 0;
							sinalJal = 0;
							sinalJr = 0;

							
						end
	
				endcase
				
			6'b001000: // addi
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b00;
					memRead = 0;
					memWrite = 0; 
					ALUop = 4'b0010; // add
					memToReg = 0;
					ALUsrc = 1; // SignExtend instead of read_data_2
					regWrite = 1; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 1;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;

				end
					
			6'b001100: //andi
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b00;
					memRead = 0;
					memWrite = 0; 
					ALUop = 4'b0000; // and
					memToReg = 0;
					ALUsrc = 1; // SignExtend instead of read_data_2
					regWrite = 1; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 1; // zeroExtend, not SignExtend
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;
				end
			6'b001010: //slti
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b00;
					memRead = 0;
					memWrite = 0; 
					ALUop = 4'b0111; // slt
					memToReg = 0;
					ALUsrc = 1; // SignExtend instead of read_data_2
					regWrite = 1; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;
				end
			6'b001011: //sltiu
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b00;
					memRead = 0;
					memWrite = 0; 
					ALUop = 4'b1000; // slti
					memToReg = 0;
					ALUsrc = 1; // SignExtend instead of read_data_2
					regWrite = 1; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;
				end
			6'b001101: //ori
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b00;
					memRead = 0;
					memWrite = 0; 
					ALUop = 4'b0001; // or
					memToReg = 0;
					ALUsrc = 1; // SignExtend (or zeroExtend) instead of read_data_2
					regWrite = 1; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 1; // zeroExtend instead of SignExtend
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;
				end
			6'b001111: //lui
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b00;
					memRead = 0;
					memWrite = 0; 
					ALUop = 0;
					memToReg = 0;
					ALUsrc = 0; 
					regWrite = 1; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0; 
					sinalLui = 1; // Result of Lui in register
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;
				end
			6'b001001:  // addiu
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b00;
					memRead = 0;
					memWrite = 0; 
					ALUop = 4'b0010; // add
					memToReg = 0;
					ALUsrc = 1; // SignExtend instead of read_data_2
					regWrite = 1; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;
				end
			6'b100011:  // lw
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b00;
					memRead = 11; // the complete word
					memWrite = 0; 
					ALUop = 4'b0010; // add
					memToReg = 1;
					ALUsrc = 1; // SignExtend instead of read_data_2
					regWrite = 1; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;
				end
			6'b101011:  // sw
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b00;
					memRead = 0; 
					memWrite = 2'b11; // the complete word 
					ALUop = 4'b0010; // add
					memToReg = 0;
					ALUsrc = 1; // SignExtend instead of read_data_2
					regWrite = 0; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;
				end
			6'b101000:  // sb
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b00;
					memRead = 0; 
					memWrite = 2'b01; // 4'b0001;just one byte 
					ALUop = 4'b0010; // add
					memToReg = 0;
					ALUsrc = 1; // SignExtend instead of read_data_2
					regWrite = 0; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;
				end
			6'b101001:  // sh
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b00;
					memRead = 0; 
					memWrite = 2'b10; // just half word
					ALUop = 4'b0010; // add
					memToReg = 0;
					ALUsrc = 1; // SignExtend instead of read_data_2
					regWrite = 0; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;
				end
			6'b100100: //lbu
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b00;
					memRead = 2'b01; //just one byte
					memWrite = 0; 
					ALUop = 4'b0010; // add
					memToReg = 1;
					ALUsrc = 1; // SignExtend instead of read_data_2
					regWrite = 1; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 1;
					sinalJal = 0;
					sinalJr = 0;
				end
				
			6'b100101: //lhu
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b00;
					memRead = 2'b10; //just one byte
					memWrite = 0; 
					ALUop = 4'b0010; // add
					memToReg = 1;
					ALUsrc = 1; // SignExtend instead of read_data_2
					regWrite = 1; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 1;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;
				end
				
			6'b000010: //j
				begin
					regDst = 0; 
					jump = 1;
					branch = 2'b00;
					memRead = 0; 
					memWrite = 0; 
					ALUop = 0; 
					memToReg = 0;
					ALUsrc = 0; 
					regWrite = 0; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;
				end
			6'b0011: //jal
				begin
					regDst = 0; 
					jump = 1;
					branch = 2'b00;
					memRead = 0; 
					memWrite = 0; 
					ALUop = 0; 
					memToReg = 0;
					ALUsrc = 0; 
					regWrite = 1; 
					sinalMuxJal = 1;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 1;
					sinalJr = 0;
				end
			6'b000100: //beq
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b10; //beq
					memRead = 0; 
					memWrite = 0; 
					ALUop = 4'b0110;  //sub
					memToReg = 0;
					ALUsrc = 0; 
					regWrite = 0; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;
				end
			6'b000101: //bne
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b01; // bne
					memRead = 0; 
					memWrite = 0; 
					ALUop = 4'b0110; // sub
					memToReg = 0;
					ALUsrc = 0; 
					regWrite = 0; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;
				end
			//2'h2b:
			default:
				begin
					regDst = 0; 
					jump = 0;
					branch = 2'b00;
					memRead = 0;
					memWrite = 0; 
					ALUop = 0; 
					memToReg = 0;
					ALUsrc = 0; 
					regWrite = 0; 
					sinalMuxJal = 0;
					sinalSll = 0;
					sinalSrl = 0;
					sinalZeroOrSign = 0;
					sinalLui = 0;
					sinalMayCauseOverflow = 0;
					sinalDoControleLhu = 0;
					sinalDoControleLbu = 0;
					sinalJal = 0;
					sinalJr = 0;

				end
		endcase

	end


endmodule
