   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 803                     ; 6 void TIM4_Init(void)	//16Mhz  2mS timebase
 803                     ; 7 {
 804                     	switch	.text
 805  0000               f_TIM4_Init:
 809                     ; 9 	TIM4->PSCR = 0X07;			//128 prescale
 811  0000 35075345      	mov	21317,#7
 812                     ; 10 	TIM4->ARR = 124;
 814  0004 357c5346      	mov	21318,#124
 815                     ; 11 	TIM4->CR1 = 0X81;			//preload mode & timer4 enable
 817  0008 35815340      	mov	21312,#129
 818                     ; 12 	TIM4->IER = 0;
 820  000c 725f5341      	clr	21313
 821                     ; 13 	TIM4->SR1 = 0;				//clear interrupt flag
 823  0010 725f5342      	clr	21314
 824                     ; 14 	TIM4->CNTR = 0;
 826  0014 725f5344      	clr	21316
 827                     ; 15 	TIM4->IER = 1;				//enable interrupt
 829  0018 35015341      	mov	21313,#1
 830                     ; 17 }
 833  001c 87            	retf	
 856                     ; 19 void TIM4_Clear_Int_Flag(void)
 856                     ; 20 {
 857                     	switch	.text
 858  001d               f_TIM4_Clear_Int_Flag:
 862                     ; 21 	TIM4->SR1 = 0;
 864  001d 725f5342      	clr	21314
 865                     ; 22 }
 868  0021 87            	retf	
 880                     	xdef	f_TIM4_Clear_Int_Flag
 881                     	xdef	f_TIM4_Init
 900                     	end
