module ci74189(
  input [3:0] a,
  input [3:0] d,
  input n_we,
  input n_ce,
  output [3:0] q
);
  
  wire [63:0] celulas [15:0][3:0];
  reg [3:0] q_aux;
  wire write_mode;
  integer select_line;

  assign write_mode = !n_ce && !n_we;

  initial begin
    q_aux = 4'b0;
    select_line = 0;
  end

  always @(a)
    select_line <= a[0] + 2*a[1] + 4*a[2] + 8*a[3];
 
  generate 
    genvar i, j;
    for (i=0; i<16; i=i+1) begin: row
      for (j=0; j<4; j=j+1) begin: column
        celula_ram c(.d(d[j]), .w(write_mode), .sel(!n_ce && (i == select_line)), .q(celulas[i][j]));
      end
    end
  endgenerate

  always @(celulas)
  begin
    q_aux[0] <= celulas[select_line][0];
    q_aux[1] <= celulas[select_line][1];
    q_aux[2] <= celulas[select_line][2];
    q_aux[3] <= celulas[select_line][3];
  end
  assign q = !n_ce && n_we ? q_aux : 4'bZ;
endmodule 
