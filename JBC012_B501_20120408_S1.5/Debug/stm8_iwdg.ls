   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 839                     ; 69 void IWDG_WriteAccessCmd(IWDG_WriteAccess_TypeDef IWDG_WriteAccess)
 839                     ; 70 {
 840                     	switch	.text
 841  0000               f_IWDG_WriteAccessCmd:
 843  0000 88            	push	a
 844       00000000      OFST:	set	0
 847                     ; 73   assert_param(IS_IWDG_WRITEACCESS_MODE_OK(IWDG_WriteAccess));
 849  0001 a155          	cp	a,#85
 850  0003 270f          	jreq	L21
 851  0005 4d            	tnz	a
 852  0006 270c          	jreq	L21
 853  0008 ae0049        	ldw	x,#73
 854  000b 89            	pushw	x
 855  000c ae0000        	ldw	x,#L764
 856  000f 8d000000      	callf	f_assert_failed
 858  0013 85            	popw	x
 859  0014               L21:
 860                     ; 75   IWDG->KR = (u8)IWDG_WriteAccess; /* Write Access */
 862  0014 7b01          	ld	a,(OFST+1,sp)
 863  0016 c750e0        	ld	20704,a
 864                     ; 77 }
 867  0019 84            	pop	a
 868  001a 87            	retf	
 958                     ; 104 void IWDG_SetPrescaler(IWDG_Prescaler_TypeDef IWDG_Prescaler)
 958                     ; 105 {
 959                     	switch	.text
 960  001b               f_IWDG_SetPrescaler:
 962  001b 88            	push	a
 963       00000000      OFST:	set	0
 966                     ; 108   assert_param(IS_IWDG_PRESCALER_VALUE_OK(IWDG_Prescaler));
 968  001c 4d            	tnz	a
 969  001d 2724          	jreq	L42
 970  001f a101          	cp	a,#1
 971  0021 2720          	jreq	L42
 972  0023 a102          	cp	a,#2
 973  0025 271c          	jreq	L42
 974  0027 a103          	cp	a,#3
 975  0029 2718          	jreq	L42
 976  002b a104          	cp	a,#4
 977  002d 2714          	jreq	L42
 978  002f a105          	cp	a,#5
 979  0031 2710          	jreq	L42
 980  0033 a106          	cp	a,#6
 981  0035 270c          	jreq	L42
 982  0037 ae006c        	ldw	x,#108
 983  003a 89            	pushw	x
 984  003b ae0000        	ldw	x,#L764
 985  003e 8d000000      	callf	f_assert_failed
 987  0042 85            	popw	x
 988  0043               L42:
 989                     ; 110   IWDG->PR = (u8)IWDG_Prescaler;
 991  0043 7b01          	ld	a,(OFST+1,sp)
 992  0045 c750e1        	ld	20705,a
 993                     ; 112 }
 996  0048 84            	pop	a
 997  0049 87            	retf	
1028                     ; 129 void IWDG_SetReload(u8 IWDG_Reload)
1028                     ; 130 {
1029                     	switch	.text
1030  004a               f_IWDG_SetReload:
1034                     ; 131   IWDG->RLR = IWDG_Reload;
1036  004a c750e2        	ld	20706,a
1037                     ; 132 }
1040  004d 87            	retf	
1062                     ; 153 void IWDG_ReloadCounter(void)
1062                     ; 154 {
1063                     	switch	.text
1064  004e               f_IWDG_ReloadCounter:
1068                     ; 155   IWDG->KR = IWDG_KEY_REFRESH;
1070  004e 35aa50e0      	mov	20704,#170
1071                     ; 156 }
1074  0052 87            	retf	
1096                     ; 176 void IWDG_Enable(void)
1096                     ; 177 {
1097                     	switch	.text
1098  0053               f_IWDG_Enable:
1102                     ; 178   IWDG->KR = IWDG_KEY_ENABLE;
1104  0053 35cc50e0      	mov	20704,#204
1105                     ; 179 }
1108  0057 87            	retf	
1120                     	xdef	f_IWDG_Enable
1121                     	xdef	f_IWDG_ReloadCounter
1122                     	xdef	f_IWDG_SetReload
1123                     	xdef	f_IWDG_SetPrescaler
1124                     	xdef	f_IWDG_WriteAccessCmd
1125                     	xref	f_assert_failed
1126                     .const:	section	.text
1127  0000               L764:
1128  0000 736f75636573  	dc.b	"souces\src\stm8_iw"
1129  0012 64672e6300    	dc.b	"dg.c",0
1149                     	end
