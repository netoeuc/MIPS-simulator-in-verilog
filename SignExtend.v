module SignExtend(immediate, signExtendImmediate);

input [15:0] immediate;
wire [15:0] immediate;
output [31:0] signExtendImmediate;
wire [31:0] signExtendImmediate;


assign signExtendImmediate [15:0]= immediate;
assign signExtendImmediate[16] = immediate[15]; 
assign signExtendImmediate[17] = immediate[15]; 
assign signExtendImmediate[18] = immediate[15]; 
assign signExtendImmediate[19] = immediate[15]; 
assign signExtendImmediate[20] = immediate[15]; 
assign signExtendImmediate[21] = immediate[15]; 
assign signExtendImmediate[22] = immediate[15]; 
assign signExtendImmediate[23] = immediate[15]; 
assign signExtendImmediate[24] = immediate[15]; 
assign signExtendImmediate[25] = immediate[15]; 
assign signExtendImmediate[26] = immediate[15]; 
assign signExtendImmediate[27] = immediate[15]; 
assign signExtendImmediate[28] = immediate[15]; 
assign signExtendImmediate[29] = immediate[15]; 
assign signExtendImmediate[30] = immediate[15]; 
assign signExtendImmediate[31] = immediate[15]; 



endmodule
