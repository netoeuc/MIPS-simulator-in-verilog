module OverflowModule (
	A,    	       // Operando A
	B,             // Operando B
	OP,            // Seleção da operação
	sinalMayCauseOverflow,
	saidaOverflow
);

	input [31:0] A;
	input [31:0] B;
	input [0:0] sinalMayCauseOverflow;
	input [3:0] OP;
	output [0:0] saidaOverflow;

	wire signed [31:0] A, B;
	wire [0:0] sinalMayCauseOverflow;
	wire [3:0] OP;
	reg signed [31:0] S;
	reg Z;
	reg [0:0] saidaOverflow;

	reg signed [31:0] resultadoTemporario;
	reg [0:0] overflow;

	initial begin
	  S = 0;
	  Z = 0;
	  overflow = 0;
	  saidaOverflow = 0;
	end
	
	always @ (A or B or OP or sinalMayCauseOverflow)
	begin : operacoes_overflow

		case (OP)
		  
		
		// S = A + B
		4'b0010:
		  begin
		    saidaOverflow = 0;
		    S = A + B;
		    resultadoTemporario = A+B;
		    if ( (A>0 && B>0 && resultadoTemporario<=0 && sinalMayCauseOverflow==1) || 
			 (A<0 && B<0 && resultadoTemporario>=0 && sinalMayCauseOverflow==1))begin
				overflow = 1;
				//$display(A);
				//$display(B);
				//$display(OP);
				//$display(sinalMayCauseOverflow);
				//$display("Overflow!");
      				//$finish;
				saidaOverflow = 1;
		    end
		  end
		
		// S = A - B
		4'b0110:
		  begin
		    saidaOverflow = 0;
		    S = A - B;
		    resultadoTemporario = A-B;			

		    if ( (A>0 && B<0 && resultadoTemporario<=0 && sinalMayCauseOverflow==1) ||
			 (A<0 && B>0 && resultadoTemporario>=0 && sinalMayCauseOverflow==1))begin
				overflow = 1;
				//$display(sinalMayCauseOverflow);
				//$display("Overflow!");
      				//$finish;
				saidaOverflow = 1;
		    end
		  end

		// S = A < B
		4'b0111:
		  begin
		    saidaOverflow = 0;
		    S = (A < B) ? 1 : 0;
		  end
		  
		// S = ~(A | B)
		4'b1100:
		  begin
		    saidaOverflow = 0;
 		    S = ~(A | B);
		  end

		default:
		  begin
		    saidaOverflow = 0;
		    S = 0;
		  end

		endcase

    		Z = (S == 0) ? 1'b1 : 1'b0;	
	end

endmodule