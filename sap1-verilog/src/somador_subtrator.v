// somador_subtrator - somador e subtrator de 4 bits, com entrada de sinal de subtração
// 8 bits de entrada, 8 bits de saída, usando ci74183
module somador_subtrator(
  input [7:0] a,
  input [7:0] b,
  input sub,
  input eu,
  output [7:0] s,
  output cout
);
  wire cout1;
  wire [7:0] saida;

  ci74183 u1(
    .a(a[3:0]),
    .b(sub ? ~b[3:0] : b[3:0]),
    .cin(sub),
    .cout(cout1),
    .s(saida[3:0])
  );

  ci74183 u2(
    .a(a[7:4]),
    .b(sub ? ~b[7:4] : b[7:4]),
    .cin(cout1),
    .cout(cout),
    .s(saida[7:4])
  );

  assign s = eu ? saida : 8'bZ;

endmodule 

