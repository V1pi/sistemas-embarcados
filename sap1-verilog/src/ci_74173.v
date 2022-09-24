// CI 74173 - registrador de 4 bits
// input e_saida ativa o tri state para saida
// input n_IE retorna o valor atual do registrador, quando positivo, senão
// registra no clock de subida
module ci74173 (
  input clk,
  input rst,
  input e_saida,
  input n_IE,
  input [3:0] d,
  output [3:0] q
);
  reg [3:0] q_reg;
  
  initial q_reg <= 4'b0;

  always @(posedge clk or posedge rst)
    if (rst)
      q_reg <= 4'b0;
    else if (n_IE)
      q_reg <= d;

  assign q = e_saida ? q_reg : 4'bZ;

endmodule
