   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 820                     ; 66 void WWDG_Init(u8 ControlValue, u8 WindowLimitValue)
 820                     ; 67 {
 821                     	switch	.text
 822  0000               f_WWDG_Init:
 824  0000 89            	pushw	x
 825       00000000      OFST:	set	0
 828                     ; 70   assert_param(IS_WWDG_WINDOWLIMITVALUE_OK(WindowLimitValue));
 830  0001 9f            	ld	a,xl
 831  0002 a180          	cp	a,#128
 832  0004 250c          	jrult	L01
 833  0006 ae0046        	ldw	x,#70
 834  0009 89            	pushw	x
 835  000a ae0000        	ldw	x,#L754
 836  000d 8d000000      	callf	f_assert_failed
 838  0011 85            	popw	x
 839  0012               L01:
 840                     ; 72   WWDG->WR = WWDG_WR_RESET_VALUE;
 842  0012 357f50d2      	mov	20690,#127
 843                     ; 73   WWDG->CR = (u8)(WWDG_CR_WDGA | WWDG_CR_T6 | ControlValue);
 845  0016 7b01          	ld	a,(OFST+1,sp)
 846  0018 aac0          	or	a,#192
 847  001a c750d1        	ld	20689,a
 848                     ; 74   WWDG->WR = (u8)((u8)(~WWDG_CR_WDGA) & (u8)(WWDG_CR_T6 | WindowLimitValue));
 850  001d 7b02          	ld	a,(OFST+2,sp)
 851  001f a47f          	and	a,#127
 852  0021 aa40          	or	a,#64
 853  0023 c750d2        	ld	20690,a
 854                     ; 76 }
 857  0026 85            	popw	x
 858  0027 87            	retf	
 890                     ; 95 void WWDG_Refresh(u8 CounterValue)
 890                     ; 96 {
 891                     	switch	.text
 892  0028               f_WWDG_Refresh:
 894  0028 88            	push	a
 895       00000000      OFST:	set	0
 898                     ; 99   assert_param(IS_WWDG_COUNTERVALUE_OK(CounterValue));
 900  0029 a180          	cp	a,#128
 901  002b 250c          	jrult	L02
 902  002d ae0063        	ldw	x,#99
 903  0030 89            	pushw	x
 904  0031 ae0000        	ldw	x,#L754
 905  0034 8d000000      	callf	f_assert_failed
 907  0038 85            	popw	x
 908  0039               L02:
 909                     ; 101   if ((WWDG->CR & (u8)(~WWDG_CR_WDGA)) < (WWDG->WR))
 911  0039 c650d1        	ld	a,20689
 912  003c a47f          	and	a,#127
 913  003e c150d2        	cp	a,20690
 914  0041 2407          	jruge	L574
 915                     ; 103     WWDG->CR = (u8)(WWDG_CR_WDGA | WWDG_CR_T6 | CounterValue);
 917  0043 7b01          	ld	a,(OFST+1,sp)
 918  0045 aac0          	or	a,#192
 919  0047 c750d1        	ld	20689,a
 920  004a               L574:
 921                     ; 106 }
 924  004a 84            	pop	a
 925  004b 87            	retf	
 948                     ; 126 u8 WWDG_GetControlValue(void)
 948                     ; 127 {
 949                     	switch	.text
 950  004c               f_WWDG_GetControlValue:
 954                     ; 128   return(WWDG->CR);
 956  004c c650d1        	ld	a,20689
 959  004f 87            	retf	
 981                     ; 147 void WWDG_SWReset(void)
 981                     ; 148 {
 982                     	switch	.text
 983  0050               f_WWDG_SWReset:
 987                     ; 149   WWDG->CR = WWDG_CR_WDGA; /* Activate WWDG, with clearing T6 */
 989  0050 358050d1      	mov	20689,#128
 990                     ; 150 }
 993  0054 87            	retf	
1005                     	xdef	f_WWDG_SWReset
1006                     	xdef	f_WWDG_GetControlValue
1007                     	xdef	f_WWDG_Refresh
1008                     	xdef	f_WWDG_Init
1009                     	xref	f_assert_failed
1010                     .const:	section	.text
1011  0000               L754:
1012  0000 736f75636573  	dc.b	"souces\src\stm8_ww"
1013  0012 64672e6300    	dc.b	"dg.c",0
1033                     	end
