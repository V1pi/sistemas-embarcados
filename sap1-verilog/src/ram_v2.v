// ram_V2 - circuito de memoria RAM de 8 bits com 16 linhas

module ram_v2 (
  inout [7:0]d, // entrada de dados
  input [3:0] a, // entrada de enderecos
  input n_we,
  input n_ce,
  output [7:0] s // saida de dados
);
  reg [7:0] mem [0:15]; // memoria de 16 linhas de 8 bits
  reg [7:0] result;
  

  always @(n_we or n_ce or a or d)
  begin
    mem[0] = 8'b00001101;
    mem[1] = 8'b00011110;
    mem[2] = 8'b1110XXXX;
    mem[3] = 8'b1111XXXX;
    mem[4] = 8'b00000000;
    mem[5] = 8'b00000000;
    mem[6] = 8'b00000000;
    mem[7] = 8'b00000000;
    mem[8] = 8'b00000000;
    mem[9] = 8'b00000000;
    mem[10] = 8'b00000000;
    mem[11] = 8'b00000000;
    mem[12] = 8'b00000000;
    mem[13] = 8'b00000111;
    mem[14] = 8'b00000010;
    mem[15] = 8'b00000000;

    /* if (!n_we && !n_ce) */
    /*   mem[a] <= d; */
    if (!n_ce)
      result = mem[a];
  end
  
  assign s = !n_ce ? result : 8'bZ;
endmodule 
