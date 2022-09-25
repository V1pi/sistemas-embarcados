// contador_programa - contador de programa de 4 bits
module contador_programa(
  input n_clk,
  input n_clr,
  input cp,
  input ep,
  output [3:0] s
);
  reg [3:0] tempS;
  always @(negedge n_clk or negedge n_clr)
    if (!n_clr)
      tempS <= 4'b0;
    else if (cp)
      tempS <= tempS + 1;

  assign s = !ep ? 4'bZ : tempS;
endmodule
