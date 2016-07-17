module ShiftLeft2Branch(signExtend, shiftLeft2BranchOutput);

input [31:0] signExtend;
output [31:0] shiftLeft2BranchOutput;

wire [31:0] signExtend;
wire [31:0] addressAfterShift;


assign shiftLeft2BranchOutput [31:2] = signExtend [29:0];
assign shiftLeft2BranchOutput [1:0]= 2'b00;


endmodule