module Mux5(rt, rd, sinalDoControleMux5, saidaMux5);

input [4:0] rt;
input [4:0] rd;
input [1:0] sinalDoControleMux5;

wire [4:0] rt, rd;
wire [0:0] sinalDoControleMux5;

output [4:0] saidaMux5;
wire [4:0] saidaMux5;

assign saidaMux5 [4:0]= sinalDoControleMux5==0 ? rt : rd;
//reg [4:0] saidaMux5;

//always @(sinalDoControleMux5)
//	begin
//		saidaMux5 = sinalDoControleMux5==0 ? rt : rd;
//	end
endmodule


