module MuxJal(saidaMux1, sinalDoControleMux2, saidaMux2);
// Mux para selecionar entre jal ou nao jal (onde o $ra sera, a entrada do banco de registradores)

input [4:0] saidaMux1;
input [0:0] sinalDoControleMux2;

wire [4:0] saidaMux1;
wire [0:0] sinalDoControleMux2;

output [4:0] saidaMux2;
wire [4:0] saidaMux2;
reg [4:0] ra = 5'b11111; // $ra eh o registrador 31 (5'b11111)

assign saidaMux2 = sinalDoControleMux2==0 ? saidaMux1 : ra;

//always @(sinalDoControleMux2)
	//begin
	//	saidaMux2 = sinalDoControleMux2==0 ? saidaMux1 : ra;
//	end
endmodule


