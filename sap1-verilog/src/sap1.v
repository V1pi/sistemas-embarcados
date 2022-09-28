// sap1 - O COMPUTADOR TOP
module sap1 (
  input clk,
  input n_clr,
  input ch_s2, // 0 = load, 1 = execute
  input ch_s4, // 0 = load, 1 = execute
  input [3:0] a, // posição da memória para escrever
  input [7:0] d, // dado a ser escrito
  output [7:0] out, // resultado do display
  output [7:0] barramento_principal, // resultado do display
  output [3:0] temp, // resultado do contador
  output [7:0] temp_mem, // resultado da memoria
  output [3:0] temp_endereco,
  output [7:0] temp_regB,
  output [7:0] temp_acumulador,
  output [5:0] temp_ring_counter,
  output n_hlt, ep, cp, n_lm, n_ce, n_l1, n_e1, n_la, ea, su, eu, n_lb, n_l0 // Controlador
);
  wire [7:0] result; // barramento said
  wire [7:0] s; // barramento principal
  wire [3:0] i; // barramento de instruções
  wire [5:0] t; // barramento contador anel
  wire [7:0] ac; // barramento acumulador
  wire [7:0] regB; // barramento registradorB
  wire [3:0] addr; // barramento de endereços

  // Contador de programa
  contador_programa contador_inst (
    .n_clk(clk),
    .n_clr(n_clr),
    .cp(cp),
    .ep(ep),
    .s(s[3:0]),
    .temp(temp)
  );

  // Contador em anel
  contador_anel contadorinst (
    .n_clk(clk),
    .n_clr(n_clr),
    .q(t)
  );

  assign temp_ring_counter = t;

  assign temp_endereco = addr;

  assign temp_mem = i;
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
  /* ram ram_inst( */
  /*   .d(d), */
  /*   .a(addr), */
  /*   .n_ce(n_ce), */
  /*   .ch_s4(ch_s4), */
  /*   .s(s), */
  /*   .temp(temp_mem) */
  /* ); */
  ram_v2 ram_inst(
    .d(d),
    .a(addr),
    .n_ce(n_ce),
    .n_we(ch_s4),
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
    .n_write(n_la),
    .ea(ea),
    .s({s, ac})
  );

  assign temp_acumulador = ac;

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

  assign temp_regB = regB;

  // Registrador de saída
  registrador_8bits registrador_saida_inst(
    .d(s),
    .clk(clk),
    .n_write(n_l0),
    .s(out)
  );

  assign barramento_principal = s;
endmodule 
