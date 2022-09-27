// ram - 8 bits - dois CI 74189
module ram (
  input [7:0] d,
  input [3:0] a,
  input n_ce,
  input ch_s4,
  output [7:0] s
);
  ci74189 c1 (
    .a(a),
    .d(d[3:0]),
    .n_ce(n_ce),
    .n_we(ch_s4),
    .q(s[3:0])
  );

  ci74189 c2 (
    .a(a),
    .d(d[7:4]),
    .n_ce(n_ce),
    .n_we(ch_s4),
    .q(s[7:4])
  );
endmodule 
