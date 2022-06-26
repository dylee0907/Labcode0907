module LCD_Default
	(
		CLOCK_50,						//	50 MHz
		LCD_ON,							//	LCD Power ON/OFF
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		USA,
		ENG,
		CHA,
		CAL
	);


input			   CLOCK_50;				//	50 MHz

////////////////////	LCD Module 16X2	////////////////////////////
inout	 [7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_ON;					//	LCD Power ON/OFF
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
input			USA, ENG, CHA, CAL;

//	LCD ON
assign			LCD_ON		=	1'b1;
assign			LCD_BLON	=	1'b1;
wire				DLY_RST;


Reset_Delay			r0	(	.iCLK(CLOCK_50),.oRESET(DLY_RST)	);


LCD_TEST 			u5	(	//	Host Side
							.iCLK(CLOCK_50),
							.iRST_N(DLY_RST),
							//	LCD Side
							.LCD_DATA(LCD_DATA),
							.LCD_RW(LCD_RW),
							.LCD_EN(LCD_EN),
							.LCD_RS(LCD_RS),
							.USA(USA),
							.ENG(ENG),
							.CHA(CHA),
							.CAL(CAL));

endmodule
