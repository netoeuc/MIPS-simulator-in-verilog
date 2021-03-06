/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estat�stica e Inform�tica
 * Disciplina: Arquitetura e Organiza��o de Computadores
 * 
 * Mem�ria de dados.
 *
 * @author Andr� Aziz (andreaziz@deinfo.ufrpe.br)
 */
 
module DMEM (
  clk,
  write_data,
  read_data,
  write,
  read,
  address
);

parameter SIZE = 32'h8000;

input clk;
input write_data;
output read_data;
input write;
input read;
input address;

wire clk;
wire [31:0] write_data;
reg [31:0] read_data;
//wire write;
//wire [3:0] write;
wire [1:0] write;
//wire read;
wire [1:0] read;
wire [31:0] address;

reg [7:0] RAM [0:SIZE-1];

initial begin :  clear_memory
  integer   index;
  
  for (index = 0; index < SIZE; index = index + 1)
	RAM[index] = 0;
	
  read_data = 0;
end


always @(negedge clk) begin
//always @(posedge clk) begin
// always @(write or read or address)
  
  if (address >= SIZE && (write != 0 || read == 1)) begin
      $display("Data memory out of bounds!! Memory size is %d bytes.", SIZE);
      $finish;
  end
  
  // Big endian	
  //if (write == 1'b1) begin
//	  RAM[address+0] = write_data[31:24];    
//	  RAM[address+1] = write_data[23:16];
//	  RAM[address+2] = write_data[15:8];
//	  RAM[address+3] = write_data[7:0];
//  end
 //$display("write");
// $display(write[0]); 
// $display(write[1]);
// $display(write[2]);
// $display(write[3]);
 
 if(write==2'b11)begin
	RAM[address+0] = write_data[31:24];    
	RAM[address+1] = write_data[23:16];
	RAM[address+2] = write_data[15:8];
	RAM[address+3] = write_data[7:0];
 end
      

 if(write==2'b10 && ((address%4)==0))begin
	//RAM[address+2] = write_data[15:8]; 
	//RAM[address+1] = write_data[7:0];   	
	RAM[address+2] = write_data[15:8]; 
	RAM[address+3] = write_data[7:0];   

 end


 if(write==2'b10 && (((address-2)%4)==0))begin
	RAM[address-2] = write_data[15:8]; 
	RAM[address-1] = write_data[7:0];   
 end


 

 if( (write==2'b01) && ((address%4)==0) )begin
	RAM[address+3] = write_data[7:0]; 
end

 if((write==2'b01) && (((address-1)%4)==0) )begin
	RAM[address+1] = write_data[7:0];  
end

if( (write==2'b01) && (((address-2)%4)==0) )begin
	RAM[address-1] = write_data[7:0]; 
end

if( (write==2'b01) && (((address-3)%4)==0) )begin
	RAM[address-3] = write_data[7:0];  
end



 


// $display("%d,%d,%d,%d",address+0, address+1, address+2, address+3);
	
//  $display("%d,%d,%d,%d",RAM[address+0], RAM[address+1], RAM[address+2], RAM[address+3]);
//$display({RAM[address+0], RAM[address+1], RAM[address+2], RAM[address+3]}  );
//$display({RAM[address-3], RAM[address-2], RAM[address-1], RAM[address-0]}  );
	
  // Big endian	
  //if (read == 1'b1) begin
	//  read_data = {RAM[address+0], RAM[address+1], RAM[address+2], RAM[address+3]};  
  //end
if ( (read == 2'b11)) begin
	  read_data = {RAM[address+0], RAM[address+1], RAM[address+2], RAM[address+3]};  
  end


if ((read == 2'b10) && (address%4==0) ) begin
	  read_data [31:16] = 0;
	  read_data = {RAM[address+2], RAM[address+3]}; 
  end

if ((read == 2'b10) && ((address-2)%4==0) ) begin
	  read_data [31:16] = 0;
	  read_data [15:0]  = {RAM[address-2], RAM[address-1]};
  end


if ((read == 2'b01) && (address%4==0) ) begin
	  read_data [31:8] = 0;
	  read_data [7:0] = RAM[address+3]; 
  end
if ((read == 2'b01) && ((address-1)%4==0) ) begin
	  read_data [31:8] = 0;
	  read_data [7:0]  = RAM[address+1];  
  end
if ((read == 2'b01) && ((address-2)%4==0) ) begin
	  read_data [31:8] = 0;
	  read_data [7:0]  = RAM[address-1];  
  end
if ((read == 2'b01) && ((address-3)%4==0) ) begin
	  read_data [31:8] = 0;
	  read_data [7:0]  = RAM[address-3];  
  end


end

endmodule
