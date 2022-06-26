module divider (div1_in, div1_ten, div1_1);
	input [5:0] div1_in;
	output [3:0] div1_ten;
	output [3:0] div1_1;
	reg [3:0] div1_ten;
	reg [3:0] div1_1;
	

always @(div1_in)

	if (div1_in < 10) begin
		div1_ten <= 0; div1_1 <= div1_in;
	end
	else if (div1_in >= 10 && div1_in < 20) begin
		div1_ten <= 1; div1_1 <= div1_in - 10;
	end
	else if (div1_in >= 20 && div1_in < 30) begin
		div1_ten <= 2; div1_1 <= div1_in - 20;
	end
	else if (div1_in >= 30 && div1_in < 40) begin
		div1_ten <= 3; div1_1 <= div1_in - 30;
	end
	else if (div1_in >= 40 && div1_in < 50) begin
		div1_ten <= 4; div1_1 <= div1_in - 40;
	end
	else if (div1_in >= 50 && div1_in < 60) begin
		div1_ten <= 5; div1_1 <= div1_in - 50;
	end
	else begin
		div1_ten <= 0;
		div1_1 <= 0;
	end


endmodule