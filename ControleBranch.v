module ControleBranch(sinalBranch, zeroULA, outputControleBranch);

input [1:0] sinalBranch;
input [0:0] zeroULA;
output [0:0] outputControleBranch;

wire [1:0] sinalBranch;
wire [0:0] zeroULA;
wire [0:0] outputControleBranch;
//reg [0:0] outputControleBranch;
wire [0:0] beq;
wire [0:0] bne;

assign beq = ((sinalBranch==2'b10)&&(zeroULA==2'b1)) ? 1 : 0;
assign bne = ((sinalBranch==2'b01)&&(zeroULA==1'b0)) ? 1 : 0;

//assign outputControleBranch [0:0] = ( ((sinalBranch==10)&&(zeroULA==1)) || ((sinalBranch==01)&&(zeroULA==0)) ) ? 1 : 0;
assign outputControleBranch [0:0] = (bne || beq);


//initial
//begin
//outputControleBranch = 0;
//end
//always @(sinalBranch or zeroULA or clk)
//	begin
//		if ( (sinalBranch==10) && (zeroULA==1) )begin //beq
//			outputControleBranch = 1;
//		end
//		if ( (sinalBranch==01) && (zeroULA==0) )begin //bne
//			outputControleBranch = 1;
//		end
//		if (  (sinalBranch==00) || (sinalBranch==11) ||  ((sinalBranch==01) && (zeroULA==1))  ||  ((sinalBranch==10) && (zeroULA==0)))begin
//			outputControleBranch = 0;	
//		end
//
//	end
endmodule
