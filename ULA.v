/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estat�stica e Inform�tica
 * Disciplina: Arquitetura e Organiza��o de Computadores
 * 
 * Unidade L�gica e Aritm�tica - ULA - de 32 bits.
 *
 * @author Andr� Aziz (andreaziz@deinfo.ufrpe.br)
 */

module ULA (
	A,    	       // Operando A
	B,             // Operando B
	S,             // Resultado
	OP,            // Sele��o da opera��o
	Z              // Indica que o resultado � zero.
);

	input [31:0] A;
	input [31:0] B;
	input [3:0] OP;
	output [31:0] S;
	output Z;

	wire signed [31:0] A, B;
	wire [3:0] OP;
	reg signed [31:0] S;
	reg Z;
	reg unsigned [31:0] UA, UB;

	initial begin
	  S = 0;
	  Z = 0;
	end
	
	always @ (A or B or OP)
	begin : operacoes_ula
		UA = A;
		UB = B;

		case (OP)
		  
		// S = A & B
		4'b0000: 
		  begin 
		    S = A & B;
		  end
			
		// S = A | B
		4'b0001:
		  begin
  		    S = A | B;  
		  end
		    
		// S = A + B
		4'b0010:
		  begin
		    S = A + B;
		  end
		
		// S = A - B
		4'b0110:
		  begin
		    S = A - B;
		  end

		// S = A < B
		4'b0111:
		  begin
		    S = (A < B) ? 1 : 0;
		  end
		  
		// S = ~(A | B)
		4'b1100:
		  begin
 		    S = ~(A | B);
		  end

		// S = uA < uB
		4'b1000:
		  begin
 		    S = (UA < UB)? 1 : 0;
		  end

		default:
		  begin
		    S = 0;
		  end

		endcase

    		Z = (S == 0) ? 1'b1 : 1'b0;	
	end

endmodule
