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
  wire [7:0] s; // barramento principal
  wire [3:0] i; // barramento de instruções
  wire [5:0] t; // barramento contador anel
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

  rem_and_mux rem_and_mux_inst(
    .d(s[3:0]),
    .a(a),
    .n_lm(n_lm),
    .clk(clk),
    .ch_s2(ch_s2),
    .s(addr)
  );
endmodule 
