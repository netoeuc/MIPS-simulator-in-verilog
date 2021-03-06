module JumpAddrModule(PC_4, address, newAddress);

input [31:0] PC_4;
input [25:0] address;
output [31:0] newAddress;

wire [31:0] PC_4;
wire [25:0] address;
wire [31:0] newAddress;

assign newAddress [31:28] = PC_4[31:28];
assign newAddress [1:0] = 2'b00;
assign newAddress [27:2] = address;

endmodule