   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 885                     ; 65 FlagStatus RST_GetFlagStatus(RST_Flag_TypeDef RST_Flag)
 885                     ; 66 {
 886                     	switch	.text
 887  0000               f_RST_GetFlagStatus:
 889  0000 88            	push	a
 890  0001 88            	push	a
 891       00000001      OFST:	set	1
 894                     ; 67   u8 flagstatus = 0;
 896  0002 0f01          	clr	(OFST+0,sp)
 897                     ; 70   assert_param(IS_RST_FLAG_OK(RST_Flag));
 899  0004 a110          	cp	a,#16
 900  0006 271b          	jreq	L21
 901  0008 a108          	cp	a,#8
 902  000a 2717          	jreq	L21
 903  000c a104          	cp	a,#4
 904  000e 2713          	jreq	L21
 905  0010 a102          	cp	a,#2
 906  0012 270f          	jreq	L21
 907  0014 4a            	dec	a
 908  0015 270c          	jreq	L21
 909  0017 ae0046        	ldw	x,#70
 910  001a 89            	pushw	x
 911  001b ae0000        	ldw	x,#L705
 912  001e 8d000000      	callf	f_assert_failed
 914  0022 85            	popw	x
 915  0023               L21:
 916                     ; 73   flagstatus = (u8)(RST->SR & RST_Flag);
 918  0023 c650b3        	ld	a,20659
 919  0026 1402          	and	a,(OFST+1,sp)
 920                     ; 75   return ((FlagStatus)flagstatus);
 924  0028 85            	popw	x
 925  0029 87            	retf	
 960                     ; 93 void RST_ClearFlag(RST_Flag_TypeDef RST_Flag)
 960                     ; 94 {
 961                     	switch	.text
 962  002a               f_RST_ClearFlag:
 964  002a 88            	push	a
 965       00000000      OFST:	set	0
 968                     ; 96   assert_param(IS_RST_FLAG_OK(RST_Flag));
 970  002b a110          	cp	a,#16
 971  002d 271b          	jreq	L42
 972  002f a108          	cp	a,#8
 973  0031 2717          	jreq	L42
 974  0033 a104          	cp	a,#4
 975  0035 2713          	jreq	L42
 976  0037 a102          	cp	a,#2
 977  0039 270f          	jreq	L42
 978  003b 4a            	dec	a
 979  003c 270c          	jreq	L42
 980  003e ae0060        	ldw	x,#96
 981  0041 89            	pushw	x
 982  0042 ae0000        	ldw	x,#L705
 983  0045 8d000000      	callf	f_assert_failed
 985  0049 85            	popw	x
 986  004a               L42:
 987                     ; 98   RST->SR |= (u8)RST_Flag;
 989  004a c650b3        	ld	a,20659
 990  004d 1a01          	or	a,(OFST+1,sp)
 991  004f c750b3        	ld	20659,a
 992                     ; 99 }
 995  0052 84            	pop	a
 996  0053 87            	retf	
1008                     	xdef	f_RST_ClearFlag
1009                     	xdef	f_RST_GetFlagStatus
1010                     	xref	f_assert_failed
1011                     .const:	section	.text
1012  0000               L705:
1013  0000 736f75636573  	dc.b	"souces\src\stm8_rs"
1014  0012 742e6300      	dc.b	"t.c",0
1034                     	end
