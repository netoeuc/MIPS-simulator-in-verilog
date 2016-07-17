module ShiftLeftModule(value, shamt, sinalSll, valueAfterShift);

input [31:0] value;
input [4:0] shamt;
input [0:0] sinalSll;
output [31:0] valueAfterShift;

wire [31:0] value;
wire [4:0] shamt;
wire [0:0] sinalSll;
wire [31:0] valueAfterShift;


assign valueAfterShift [31:0] = sinalSll==1? (value<<shamt) : value;
//reg [27:0] valueAfterShift;

endmodule