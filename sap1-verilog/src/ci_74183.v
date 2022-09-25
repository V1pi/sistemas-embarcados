// ci74183.v - somador subtrator de 4 bits com carry out
module ci74183 (
  input [3:0] a,
  input [3:0] b,
  input cin,
  output [3:0] s,
  output cout
);
  assign {cout, s} = a + b + cin;
endmodule 
