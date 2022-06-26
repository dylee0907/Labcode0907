module clock_div(clk_in, clk_out1, clk_out2);
	input clk_in;
	output reg clk_out1;
	output reg clk_out2;//clk_out==1
	reg [4:0]cnt;
always @(posedge clk_in)
begin    
      cnt <= cnt + 1'b1 ;
    if(cnt == 5'd24)//11001
      begin
      clk_out1 <= ~clk_out1;
		clk_out2 <= ~clk_out2;
      cnt <= 5'd0;
    end
end  
endmodule
