/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estat�stica e Inform�tica
 * Disciplina: Arquitetura e Organiza��o de Computadores
 * 
 * Mem�ria de instru��es.
 *
 * @author Andr� Aziz (andreaziz@deinfo.ufrpe.br)
 */
//`define MEMORY_HEX
 
module IMEM (
  clk,
  address,
  instruction
);

parameter SIZE = 32'h8000;
parameter MEMORY_FILE = "memory.bin";

input clk;
input address;
output instruction;

wire [31:0] address;
reg [31:0] instruction;
reg [31:0] ROM [0:(SIZE>>2)-1];

initial begin : load_default_memory
  integer   index;
  
  for (index = 0; index < (SIZE>>2); index = index + 1)
	ROM[index] = 0;
  
  $readmemh(MEMORY_FILE, ROM);
  instruction = 0;
  
end

always @(posedge clk) begin
  
  if (address > SIZE - 4) begin
      //$display("Instruction memory out of bounds!! Memory size is %d bytes.", SIZE);
      $finish;
  end
  
  instruction = ROM[address>>2];  
end

endmodule