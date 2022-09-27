// sap1 - O COMPUTADOR TOP
module sap1 (
  input clk,
  input n_clr,
  input ch_s2, // 0 = load, 1 = execute
  input ch_s4, // 0 = load, 1 = execute
  input [3:0] a, // posição da memória para escrever
  input [7:0] d, // dado a ser escrito
  output [7:0] out // resultado do display
);
  wire [7:0] result; // barramento saida
  wire [7:0] s; // barramento principal
  wire [3:0] i; // barramento de instruções
  wire [5:0] t; // barramento contador anel
  wire [7:0] ac; // barramento acumulador
  wire [7:0] regB; // barramento registradorB
  wire [3:0] addr; // barramento de endereços
  wire n_hlt, ep, cp, n_lm, n_ce, n_l1, n_e1, n_la, ea, su, eu, n_lb, n_l0; // Controlador

  // Contador de programa
  contador_programa contador_inst (
    .n_clk(clk),
    .n_clr(n_clr),
    .cp(cp),
    .ep(ep),
    .s(s[3:0])
  );

  // Contador em anel
  contador_anel contadorinst (
    .n_clk(clk),
    .n_clr(n_clr),
    .q(t)
  );

  // Controlador
  controlador controlador_inst (
    .t(t),
    .a(i),
    .n_hlt(n_hlt),
    .cp(cp),
    .ep(ep),
    .n_lm(n_lm),
    .n_ce(n_ce),
    .n_l1(n_l1),
    .n_e1(n_e1),
    .n_la(n_la),
    .ea(ea),
    .su(su),
    .eu(eu),
    .n_lb(n_lb),
    .n_l0(n_l0)
  );

  // Rem and Mux
  rem_and_mux rem_and_mux_inst(
    .d(s[3:0]),
    .a(a),
    .n_lm(n_lm),
    .clk(clk),
    .ch_s2(ch_s2),
    .s(addr)
  );

  // Memória
  ram ram_inst(
    .d(d),
    .a(addr),
    .n_ce(n_ce),
    .ch_s4(ch_s4),
    .s(s)
  );

  // Registrador de instruções
  registrador_instrucoes registrador_inst(
    .d(s),
    .clk(clk),
    .clr(~n_clr),
    .n_l1(n_l1),
    .n_e1(n_e1),
    .s({i, s[3:0]})
  );

  // Acumulador
  acumulador acumulador_inst(
    .d(s),
    .clk(clk),
    .n_write(n_lb),
    .ea(ea),
    .s({s, ac})
  );

  // Somador e subtrator
  somador_subtrator somador_subtrator_inst(
    .a(ac),
    .b(regB),
    .sub(su),
    .eu(eu),
    .s(s)
  );

  // Registrador b
  registrador_8bits registrador_b_inst(
    .d(s),
    .clk(clk),
    .n_write(n_lb),
    .s(regB)
  );

  // Registrador de saída
  registrador_8bits registrador_saida_inst(
    .d(s),
    .clk(clk),
    .n_write(n_l0),
    .s(out)
  );
endmodule 
