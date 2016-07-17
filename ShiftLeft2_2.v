module ShiftLeft2(addressIn, addressAfterShift);

input [25:0] addressIn;
output [27:0] addressAfterShift;

wire [25:0] addressIn;
wire [27:0] addressAfterShift;


assign addressAfterShift [27:2] = addressIn;
assign addressAfterShift [1:0]= 2'b00;
//reg [27:0] addressAfterShift;

endmodule