module PC(clk, address, outputPC);

input [31:0] address;
input [0:0] clk;

output [31:0] outputPC;
reg [31:0] outputPC;

always @(posedge clk)
	begin
		outputPC = address;
	end
endmodule
