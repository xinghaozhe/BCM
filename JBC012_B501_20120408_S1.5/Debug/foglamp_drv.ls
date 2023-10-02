   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 776                     	switch	.bss
 777  0000               L144_rfluCnt:
 778  0000 00            	ds.b	1
 779  0001               L534_ffluCnt:
 780  0001 00            	ds.b	1
 781  0002               L334_fflpCnt:
 782  0002 00            	ds.b	1
 836                     ; 49 void ScanFogLampSwitch(void)
 836                     ; 50 {   
 837                     	switch	.text
 838  0000               f_ScanFogLampSwitch:
 842                     ; 55     if (!FRONT_FOG_SW) 
 844  0000 720850151f    	btjt	20501,#4,L174
 845                     ; 57         ffluCnt = 0;
 847  0005 725f0001      	clr	L534_ffluCnt
 848                     ; 58         if (fflpCnt < KEY_FILTER_CNT)
 850  0009 c60002        	ld	a,L334_fflpCnt
 851  000c a105          	cp	a,#5
 852  000e 2406          	jruge	L374
 853                     ; 60    	    fflpCnt++;
 855  0010 725c0002      	inc	L334_fflpCnt
 857  0014 202b          	jra	L105
 858  0016               L374:
 859                     ; 62         else if(fflpCnt == KEY_FILTER_CNT)
 861  0016 a105          	cp	a,#5
 862  0018 2627          	jrne	L105
 863                     ; 64    	    fflpCnt++;
 865  001a 725c0002      	inc	L334_fflpCnt
 866                     ; 65    	    FrontFogLampSwitchState = Pressed;
 868  001e 35550004      	mov	_FrontFogLampSwitchState,#85
 869  0022 201d          	jra	L105
 870  0024               L174:
 871                     ; 70         fflpCnt = 0;
 873  0024 725f0002      	clr	L334_fflpCnt
 874                     ; 71         if (ffluCnt < KEY_FILTER_CNT)
 876  0028 c60001        	ld	a,L534_ffluCnt
 877  002b a105          	cp	a,#5
 878  002d 2406          	jruge	L305
 879                     ; 73    	   ffluCnt++;
 881  002f 725c0001      	inc	L534_ffluCnt
 883  0033 200c          	jra	L105
 884  0035               L305:
 885                     ; 75         else if(ffluCnt == KEY_FILTER_CNT)
 887  0035 a105          	cp	a,#5
 888  0037 2608          	jrne	L105
 889                     ; 77    	    ffluCnt++;
 891  0039 725c0001      	inc	L534_ffluCnt
 892                     ; 78               FrontFogLampSwitchState = Unpressed;
 894  003d 725f0004      	clr	_FrontFogLampSwitchState
 895  0041               L105:
 896                     ; 84     if (!REAR_FOG_SW) 
 898  0041 7206501520    	btjt	20501,#3,L115
 899                     ; 86            if(rfluCnt <KEY_FILTER_CNT) rfluCnt++;
 901  0046 c60000        	ld	a,L144_rfluCnt
 902  0049 a105          	cp	a,#5
 903  004b 2405          	jruge	L315
 906  004d 725c0000      	inc	L144_rfluCnt
 909  0051 87            	retf	
 910  0052               L315:
 911                     ; 87            else if(rfluCnt == KEY_FILTER_CNT)
 913  0052 a105          	cp	a,#5
 914  0054 2614          	jrne	L525
 915                     ; 89                   rfluCnt++;
 917  0056 725c0000      	inc	L144_rfluCnt
 918                     ; 90                   if(RearFogLampSwitchState == Pressed)
 920  005a c60003        	ld	a,_RearFogLampSwitchState
 921  005d a155          	cp	a,#85
 922  005f 2609          	jrne	L525
 923                     ; 92                          RearFogLampSwitchState =Unpressed;
 925  0061 725f0003      	clr	_RearFogLampSwitchState
 928  0065 87            	retf	
 929  0066               L115:
 930                     ; 102           rfluCnt = 0;
 932  0066 725f0000      	clr	L144_rfluCnt
 933  006a               L525:
 934                     ; 105 }
 937  006a 87            	retf	
 962                     ; 120 void JudgeFogLampDriver(void)
 962                     ; 121 {
 963                     	switch	.text
 964  006b               f_JudgeFogLampDriver:
 968                     ; 123 	if ((IGNstate == ON) && (SmallLampSwitchState == Pressed) && (FrontFogLampSwitchState == Pressed))
 970  006b c60000        	ld	a,_IGNstate
 971  006e a155          	cp	a,#85
 972  0070 2613          	jrne	L735
 974  0072 c60000        	ld	a,_SmallLampSwitchState
 975  0075 a155          	cp	a,#85
 976  0077 260c          	jrne	L735
 978  0079 c60004        	ld	a,_FrontFogLampSwitchState
 979  007c a155          	cp	a,#85
 980  007e 2605          	jrne	L735
 981                     ; 125 		FRONT_FOG_LAMP_ON;
 983  0080 7218500a      	bset	20490,#4
 986  0084 87            	retf	
 987  0085               L735:
 988                     ; 129 		FRONT_FOG_LAMP_OFF;
 990  0085 7219500a      	bres	20490,#4
 991                     ; 144 }
 994  0089 87            	retf	
1024                     	xref	_SmallLampSwitchState
1025                     	xref	_IGNstate
1026                     	xdef	f_JudgeFogLampDriver
1027                     	xdef	f_ScanFogLampSwitch
1028                     	switch	.bss
1029  0003               _RearFogLampSwitchState:
1030  0003 00            	ds.b	1
1031                     	xdef	_RearFogLampSwitchState
1032  0004               _FrontFogLampSwitchState:
1033  0004 00            	ds.b	1
1034                     	xdef	_FrontFogLampSwitchState
1054                     	end
