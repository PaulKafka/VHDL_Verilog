module orgate

(
	input SW0, SW1,
	output LEDR2
);

assign LEDR2 = SW0 | SW1;


endmodule
