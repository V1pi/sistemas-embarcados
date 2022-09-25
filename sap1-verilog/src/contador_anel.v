// contador_anel - contador em anel de 6 estados
module contador_anel (
  input n_clk,
  input n_clr,
  output reg [5:0] q
);
  
    always @(negedge n_clk or negedge n_clr) begin
      if (!n_clr)
        q <= 6'b000001;
      else begin
        q <= q<<1;
        q[0] <= q[5];
      end
    end

endmodule
