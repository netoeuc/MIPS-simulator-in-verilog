module ZeroExtend(immediate, signExtendImmediate);

input [15:0] immediate;
wire [15:0] immediate;
output [31:0] signExtendImmediate;
wire [31:0] signExtendImmediate;


assign signExtendImmediate [15:0]= immediate;
assign signExtendImmediate[16] = 0; 
assign signExtendImmediate[17] = 0; 
assign signExtendImmediate[18] = 0; 
assign signExtendImmediate[19] = 0; 
assign signExtendImmediate[20] = 0; 
assign signExtendImmediate[21] = 0; 
assign signExtendImmediate[22] = 0; 
assign signExtendImmediate[23] = 0; 
assign signExtendImmediate[24] = 0; 
assign signExtendImmediate[25] = 0; 
assign signExtendImmediate[26] = 0; 
assign signExtendImmediate[27] = 0; 
assign signExtendImmediate[28] = 0; 
assign signExtendImmediate[29] = 0; 
assign signExtendImmediate[30] = 0; 
assign signExtendImmediate[31] = 0; 



endmodule