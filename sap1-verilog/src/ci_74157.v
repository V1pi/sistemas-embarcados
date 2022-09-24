// ci74157 - multiplexador de 4 bits com 1 bit de seleção de entrada e saída
module ci74157 (
  input [3:0] d0,
  input [3:0] d1,
  input sel,
  output [3:0]s
);
  assign s[3:0] = sel ? d1[3:0] : d0[3:0];
endmodule 
