module flip_flop_d (
	input d, clk,
	output q, n_q
);

	wire nand_1, nand_2, nand_3, nand_4;
	
	assign nand_1 = ~(d & clk);
	assign nand_2 = ~(~d & clk);
	assign nand_3 = ~(nand_4 & nand_1);
	assign nand_4 = ~(nand_3 & nand_2);
	assign q = nand_3;
	assign n_q = nand_4;

endmodule