module led_dec (led1_in, led1_out);

	input [3:0] led1_in;
	output [6:0] led1_out;
	reg [6:0] led1_out;

	
always @(led1_in)
begin
	case (led1_in)
		4'b0000 : led1_out <= 7'b1000000;
		4'b0001 : led1_out <= 7'b1111001;
		4'b0010 : led1_out <= 7'b0100100;
		4'b0011 : led1_out <= 7'b0110000;
		4'b0100 : led1_out <= 7'b0011001;
		4'b0101 : led1_out <= 7'b0010010;
		4'b0110 : led1_out <= 7'b0000010;
		4'b0111 : led1_out <= 7'b1111000;
		4'b1000 : led1_out <= 7'b0000000;
		4'b1001 : led1_out <= 7'b0010000;
		default : led1_out <= 7'b0111111;
	endcase
end

endmodule