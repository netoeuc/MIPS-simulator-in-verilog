module Adder(input1, input2, output1);

input [31:0] input1, input2;
output [31:0] output1;

wire [31:0] input1, input2;
wire [31:0] output1;

assign output1 [31:0] = input1+input2;

endmodule