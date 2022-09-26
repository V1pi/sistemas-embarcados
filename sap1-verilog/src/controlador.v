// controlador
module controlador(
  input [5:0] t,
  input [3:0] a,
  output cp, eu, ep, n_lm, n_ce, n_l1,
  n_e1, n_la, ea, su, n_lb, n_l0, n_hlt
);
  wire load, add, sub, out, hlt;

  assign load = a == 4'b0000;
  assign add = a == 4'b0001;
  assign sub = a == 4'b0010;
  assign out = a == 4'b1110;
  assign hlt = a == 4'b1111;
  
  // saída de controle
  assign n_hlt = ~hlt;
  assign ep = t[0];
  assign cp = t[1];
  assign n_lm = ~(t[0] | (load & t[3]) | (add & t[3]) | (sub & t[3]));
  assign n_ce = ~(t[2] | (load & t[4]) | (add & t[4]) | (sub & t[4]));
  assign n_l1 = ~t[2];
  assign n_e1 = ~((load & t[3]) | (add & t[3]) | (sub & t[3]));
  assign n_la = ~((load & t[4]) | (add & t[5]) | (sub & t[5]));
  assign ea = out & t[3];
  assign su = sub & t[5];
  assign eu = ((add & t[5]) | (sub & t[5]));
  assign n_lb = ~((add & t[4]) | (sub & t[4]));
  assign n_l0 = ~(out & t[3]);

endmodule
