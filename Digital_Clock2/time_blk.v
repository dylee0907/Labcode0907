module time_blk (clk1, clk2, mode, increment, decrement, hour, min, sec, rst, stp, stpw, hold, timer, hold1, USA, ENG, CHA, CAL);
	input clk1, clk2;
	input increment, decrement;
	input rst;
	input stp;
	input stpw;
	input hold, hold1;
	input timer;
	input USA, ENG, CHA, CAL;
	input [1:0] mode;
	output [4:0] hour;
	output [5:0] min;
	output [5:0] sec;
	reg decision;
	reg [4:0] hour;
	reg [5:0] min;
	reg [5:0] sec;
	reg inc_hur;
	reg inc_min;
	reg inc_sec;
	reg dec_hur;
	reg dec_min;
	reg dec_sec;
	reg [19:0] v_secc;
	reg [4:0] v_hur;
	reg [5:0] v_min;
	reg [5:0] v_sec;
	reg [19:0] v1_secc;
	reg [4:0] v1_hur;
	reg [5:0] v1_min;
	reg [5:0] v1_sec;

always @(increment or decrement or mode)
begin : set_gen
	if (increment)
		begin
			if (mode == 2'b01)
				inc_hur <= 1'b1;//set to hour
			else if (mode == 2'b10)
				inc_min <= 1'b1;//set to min
			else if (mode ==2'b11)
				inc_sec <= 1'b1;//set to second
			else
				begin
					inc_hur <= 0;
					inc_min <= 0;
					inc_sec <= 0;
				end
		end
	else
		begin
			inc_hur <= 0;
			inc_min <= 0;
			inc_sec <= 0;
		end
		
	if (decrement)
		begin
			if (mode == 2'b01)
				dec_hur <= 1'b1;//set to hour
			else if (mode == 2'b10)
				dec_min <= 1'b1;//set to min
			else if (mode == 2'b11)
				dec_sec <= 1'b1;//set to second
			else
				begin
					dec_hur <= 0;
					dec_min <= 0;
					dec_sec <= 0;
				end
		end
	else
		begin
			dec_hur <= 0;
			dec_min <= 0;
			dec_sec <= 0;
		end
end


always @(posedge clk2)
begin : time_gen
	if (stpw) begin
	 if (~hold)
		v1_secc <= v1_secc + 1;
	 else if (hold) 
	   v1_secc<=v1_secc;
		if (v1_secc == 20'd999999) begin // 1 MHz 는
			v1_sec <= v1_sec + 1;
	
			if (v1_sec == 6'd59) begin
				v1_min <= v1_min + 1;
				v1_sec <= 6'd0;
			end
	
			if (v1_min == 6'd59) begin
				v1_hur <= v1_hur + 1;
				v1_min <= 6'd0;
			end
	
			if (v1_hur == 5'd23)
				v1_hur <= 5'd0;	
		
			v1_secc <= 20'd0;
		end
	end
	else if (~(stpw && hold)) begin
	 v1_sec<=0;
	 v1_min<=0;
	 v1_hur<=0;
	end
	end

		
	
always @(posedge clk1)
begin : stop_watch//1

	if (~stp) begin//stop clock when setting time//2
		v_secc <= v_secc + 1;
		if (v_secc == 20'd999999) begin // 1 MHz 는//3
			v_sec <= v_sec + 1;
	
			if (v_sec == 6'd59) begin//4
				v_min <= v_min + 1;
				v_sec <= 6'd0;
			end//4
	
			if (v_min == 6'd59) begin//5
				v_hur <= v_hur + 1;
				v_min <= 6'd0;
			end//5
	
			if (v_hur == 5'd23)
				v_hur <= 5'd0;	
		
			if	(rst==0) begin//6
				v_hur<=0;
				v_min<=0;
				v_sec<=0;
			end//6
		
			v_secc <= 20'd0;
		end//3
	end//2
			
	
	if (stp) begin//7
	if (increment) begin//increase number//8
		if (inc_sec) begin//9
			if (v_sec==6'd59)begin//10
				v_sec <= 6'd0;
				v_min <= v_min + 1;
			end//10
		   else
				v_sec <= v_sec +1;
		end//9
			
		if (inc_min) begin//11
			if (v_min == 6'd59)begin//12
				v_min <= 6'd0;
				v_hur <= v_hur + 1;
			end//12
			else
				v_min <= v_min + 1;
		end//11

		if (inc_hur) begin//13
			if (v_hur == 5'd23)
				v_hur <= 5'd0;
			else
				v_hur <= v_hur + 1;
		end//13
	end//8
	
	if (decrement)begin//decrease number//14
		if (dec_sec)begin//15
			if (v_sec==0)
				v_sec <= 0;
			else
				v_sec <= v_sec-1;
		end//15
			
		if (dec_min) begin//16
			if (v_min==0)
				v_min<=0;
			else
				v_min<=v_min-1;
		end//16
	
		if (dec_hur) begin//17
			if (v_hur==0)
				v_hur<=0;
			else
				v_hur<=v_hur-1;
		end//17
	end//14
	end//7
	
	if (USA) begin
		if(~stpw) begin//19
		hour <= v_hur+11;
		min <= v_min;
		sec <= v_sec;
		end//19
		
		if(stpw) begin//20
		hour <= v1_hur;
		min <= v1_min;
		sec <= v1_sec;
		end//20
	end
	
	else if (CHA) begin
		if(~stpw) begin//19
		hour <= v_hur+23;
		min <= v_min;
		sec <= v_sec;
		end//19
		
		if(stpw) begin//20
		hour <= v1_hur;
		min <= v1_min;
		sec <= v1_sec;
		end//20
	end
	
	else if (ENG) begin
		if(~stpw) begin//19
		hour <= v_hur+16;
		min <= v_min;
		sec <= v_sec;
		end//19
		
		if(stpw) begin//20
		hour <= v1_hur;
		min <= v1_min;
		sec <= v1_sec;
		end//20
	end
	
	else if (CAL)begin
		if(~stpw) begin//19
		hour <= v_hur+8;
		min <= v_min;
		sec <= v_sec;
		end//19
		
		if(stpw) begin//20
		hour <= v1_hur;
		min <= v1_min;
		sec <= v1_sec;
		end//20
	end
	
	else
	begin
		if(~stpw) begin//19
		hour <= v_hur;
		min <= v_min;
		sec <= v_sec;
		end//19
		
		if(stpw) begin//20
		hour <= v1_hur;
		min <= v1_min;
		sec <= v1_sec;
		end//20
	end

		end//1
endmodule