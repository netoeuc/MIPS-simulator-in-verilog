module ShiftLeft2Address(address, addressAfterShift);

input [25:0] address;
output [27:0] addressAfterShift;

wire [25:0] address;
wire [27:0] addressAfterShift;


assign addressAfterShift [27:2] = address;
assign addressAfterShift [1:0]= 2'b00;
//reg [27:0] addressAfterShift;

endmodule