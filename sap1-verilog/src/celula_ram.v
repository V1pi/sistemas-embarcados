// celula_ram - celula de RAM com w, d, sel.
module celula_ram (
  input d,
  input w,
  input sel,
  output q
 );
  reg tempW, tempSel, tempQ;
  initial begin
    tempW <= 0;
    tempSel <= 0;
    tempQ <= 0;
  end

  always @(w or d) begin
    if (w) tempW <= d;
  end

  always @(sel, tempQ) begin
    if (sel) tempSel <= tempQ;
  end
  
  always @(w or tempSel or tempW or sel) begin
    if (w) begin
      if(sel) tempQ <= tempW;
      else tempQ <= tempSel;
    end;
  end
  assign q = sel ? tempQ : 1'bZ;
endmodule 
