// registrador_instrucoes
module registrador_instrucoes (
  input [7:0] d,
  input clk,
  input clr,
  input n_e1,
  input n_l1,
  output [7:0] s
);
  
  ci74173 ci74173_inst1 (
    .d(d[3:0]),
    .clk(clk),
    .rst(1'b0),
    .n_IE(n_l1),
    .e_saida(~n_e1),
    .q(s[3:0])
  );

  ci74173 ci74173_inst2 (
    .d(d[7:4]),
    .clk(clk),
    .rst(clr),
    .n_IE(n_l1),
    .e_saida(1'b1),
    .q(s[7:4])
  );
endmodule 
