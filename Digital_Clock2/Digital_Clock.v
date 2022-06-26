module Digital_Clock (clk, sw, increase,decrease, mode, increment, decrement, hled_out1, hled_out2, mled_out1, mled_out2, sled_out1, sled_out2, reset, stop, stpw, hold, timer, hold1, LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS, LCD_DATA, USA, ENG, CHA, CAL);
	input clk;
	input sw;
	input increase, decrease;
	input reset;
	input stop;
	input stpw;
	input hold, hold1;
	input timer;
	input USA, ENG, CHA, CAL;
	output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS;
	output [7:0] LCD_DATA;
	output [1:0] mode;
	output increment, decrement;
	output hled_out1, hled_out2, mled_out1, mled_out2, sled_out1, sled_out2;
	reg [1:0] mode = 2'b00;
	reg increment, decrement;
	
	wire clk_1M;
	wire clk_2M;
	
	clock_div clk_1M_generator(.clk_in(clk), .clk_out1(clk_1M), .clk_out2(clk_2M));

	wire [4:0] h1_hour;
	wire [5:0] m1_min; 
	wire [5:0] s1_sec;
	

	time_blk time_generator(.clk1(clk_1M), .clk2(clk_2M), .mode(mode), .increment(increment), .decrement(decrement), .hour(h1_hour), .min(m1_min), .sec(s1_sec), .rst(reset), .stp(stop), .stpw(stpw), .hold(hold), .timer(timer), .hold1(hold1), .ENG(ENG), .USA(USA), .CHA(CHA), .CAL(CAL));
	LCD_Default lcd(.CLOCK_50(clk_1M), .LCD_ON(LCD_ON), .LCD_BLON(LCD_BLON), .LCD_RW(LCD_RW), .LCD_EN(LCD_EN), .LCD_RS(LCD_RS), .LCD_DATA(LCD_DATA), .ENG(ENG), .USA(USA), .CHA(CHA), .CAL(CAL));
	
	
	always @(posedge sw)
		begin : mode_gen
		if (mode == 2'b00)
			mode <= 2'b01; //control hour 시간설정 모드
		else if (mode == 2'b01)
			mode <= 2'b10; //control minute 분 설정 모드
		else if (mode == 2'b10)
			mode <= 2'b11; //control second	시계 모드
		else
			mode <= 2'b00;
		end
	
	always @(negedge clk_1M)
		begin : inc_gen
		reg [17:0] inc_cnt;
		reg [17:0] dec_cnt;
		if (~increase)
			inc_cnt <= inc_cnt + 1;
		else
			inc_cnt <= 0;
			
		if (~decrease)
			dec_cnt <= dec_cnt + 1;
		else
			dec_cnt <= 0;
			
		
		if (inc_cnt == 18'b000000000000000001)//frequency 4Hz
			increment <= 1'b1;
		else
			increment <= 1'b0;
		
		if (dec_cnt==18'b000000000000000001)//frequency 4Hz
			decrement <= 1'b1;
		else
			decrement <= 1'b0;				
	end		


	wire [3:0] hdiv1_ten;
	wire [3:0] hdiv1_1;
	wire [3:0] mdiv1_ten;
	wire [3:0] mdiv1_1;
	wire [3:0] sdiv1_ten;
	wire [3:0] sdiv1_1;


	divider d1(.div1_in(h1_hour), .div1_ten(hdiv1_ten), .div1_1(hdiv1_1));
	divider d2(.div1_in(m1_min), .div1_ten(mdiv1_ten), .div1_1(mdiv1_1));
	divider d3(.div1_in(s1_sec), .div1_ten(sdiv1_ten), .div1_1(sdiv1_1));

	wire [6:0] hled_out1;
	wire [6:0] hled_out2;
	wire [6:0] mled_out1;
	wire [6:0] mled_out2;
	wire [6:0] sled_out1;
	wire [6:0] sled_out2;
	

	led_dec ldh1(.led1_in(hdiv1_ten), .led1_out(hled_out1));
	led_dec ldh2(.led1_in(hdiv1_1), .led1_out(hled_out2));

	led_dec ldm1(.led1_in(mdiv1_ten), .led1_out(mled_out1));
	led_dec ldm2(.led1_in(mdiv1_1), .led1_out(mled_out2));

	led_dec lds1(.led1_in(sdiv1_ten), .led1_out(sled_out1));
	led_dec lds2(.led1_in(sdiv1_1), .led1_out(sled_out2));
	

endmodule