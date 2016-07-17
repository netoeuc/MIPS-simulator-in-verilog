module AdderPC4(PC, novoPC);

input [31:0] PC;
output [31:0] novoPC;

wire [31:0] PC;
wire [31:0] novoPC;

assign novoPC [31:0] = PC+4;

endmodule