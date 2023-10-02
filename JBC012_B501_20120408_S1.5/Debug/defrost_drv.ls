   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 776                     	switch	.bss
 777  0000               L334_Defrostcnt:
 778  0000 00            	ds.b	1
 818                     ; 47 void ScanDefrostSwitch(void)
 818                     ; 48 {
 819                     	switch	.text
 820  0000               f_ScanDefrostSwitch:
 824                     ; 51     if((!R_DEFROSTER_SW) &&(IGNstate == ON))
 826  0000 720a500625    	btjt	20486,#5,L754
 828  0005 c60000        	ld	a,_IGNstate
 829  0008 a155          	cp	a,#85
 830  000a 261e          	jrne	L754
 831                     ; 53         if(Defrostcnt < 10 )Defrostcnt++;
 833  000c c60000        	ld	a,L334_Defrostcnt
 834  000f a10a          	cp	a,#10
 835  0011 2405          	jruge	L164
 838  0013 725c0000      	inc	L334_Defrostcnt
 841  0017 87            	retf	
 842  0018               L164:
 843                     ; 54         else if(Defrostcnt == 10 )
 845  0018 a10a          	cp	a,#10
 846  001a 2612          	jrne	L174
 847                     ; 56              Defrostcnt++;
 849  001c 725c0000      	inc	L334_Defrostcnt
 850                     ; 57              if(DefrostKeySta == Unpressed)
 852  0020 c60009        	ld	a,_DefrostKeySta
 853  0023 2609          	jrne	L174
 854                     ; 59                     DefrostKeySta = Pressed;
 856  0025 35550009      	mov	_DefrostKeySta,#85
 858  0029 87            	retf	
 859  002a               L754:
 860                     ; 65           Defrostcnt = 0;
 862  002a 725f0000      	clr	L334_Defrostcnt
 863  002e               L174:
 864                     ; 67 }
 867  002e 87            	retf	
 869                     	switch	.bss
 870  0001               L574_bathighCnt:
 871  0001 00            	ds.b	1
 872  0002               L374_batlowCnt:
 873  0002 00            	ds.b	1
 920                     ; 82 void ScanBatteryVoltage(void)
 920                     ; 83 {
 921                     	switch	.text
 922  002f               f_ScanBatteryVoltage:
 924  002f 89            	pushw	x
 925       00000002      OFST:	set	2
 928                     ; 87 	batvol = GetADCresultAverage(2);
 930  0030 a602          	ld	a,#2
 931  0032 8d000000      	callf	f_GetADCresultAverage
 933  0036 1f01          	ldw	(OFST-1,sp),x
 934                     ; 88        battervalue = batvol ;
 936  0038 cf0000        	ldw	_battervalue,x
 937                     ; 89 	if (batvol < BATTERY_VOLTAGE_9V) //if battery voltage is lower then 8v
 939  003b a3020c        	cpw	x,#524
 940  003e 2426          	jruge	L715
 941                     ; 91             bathighCnt = 0;
 943  0040 725f0001      	clr	L574_bathighCnt
 944                     ; 92             if (BatVoltageState == batvolLow) return;		
 946  0044 c6000a        	ld	a,_BatVoltageState
 947  0047 a155          	cp	a,#85
 948  0049 2724          	jreq	L21
 951                     ; 93             if (batlowCnt < BATTERY_VOLTAGE_CNT)
 953  004b c60002        	ld	a,L374_batlowCnt
 954  004e a164          	cp	a,#100
 955  0050 2406          	jruge	L325
 956                     ; 95                   batlowCnt++;
 958  0052 725c0002      	inc	L374_batlowCnt
 960  0056 2017          	jra	L21
 961  0058               L325:
 962                     ; 97             else if (batlowCnt == BATTERY_VOLTAGE_CNT)
 964  0058 a164          	cp	a,#100
 965  005a 2613          	jrne	L21
 966                     ; 99                   batlowCnt++;
 968  005c 725c0002      	inc	L374_batlowCnt
 969                     ; 100                   BatVoltageState = batvolLow;
 971  0060 3555000a      	mov	_BatVoltageState,#85
 972  0064 2009          	jra	L21
 973  0066               L715:
 974                     ; 106 		batlowCnt = 0;
 976  0066 725f0002      	clr	L374_batlowCnt
 977                     ; 107 		if (BatVoltageState == batvolOkay) return;
 979  006a c6000a        	ld	a,_BatVoltageState
 980  006d 2602          	jrne	L335
 982  006f               L21:
 985  006f 85            	popw	x
 986  0070 87            	retf	
 987  0071               L335:
 988                     ; 108 		if (bathighCnt < BATTERY_VOLTAGE_CNT)
 990  0071 c60001        	ld	a,L574_bathighCnt
 991  0074 a164          	cp	a,#100
 992  0076 2406          	jruge	L535
 993                     ; 110 			bathighCnt++;
 995  0078 725c0001      	inc	L574_bathighCnt
 997  007c 20f1          	jra	L21
 998  007e               L535:
 999                     ; 112 		else if (bathighCnt == BATTERY_VOLTAGE_CNT)
1001  007e a164          	cp	a,#100
1002  0080 26ed          	jrne	L21
1003                     ; 114 			bathighCnt++;
1005  0082 725c0001      	inc	L574_bathighCnt
1006                     ; 115 			BatVoltageState = batvolOkay;
1008  0086 725f000a      	clr	_BatVoltageState
1009                     ; 119 }
1011  008a 20e3          	jra	L21
1013                     	switch	.bss
1014  0003               L345_DefrostKeepTime:
1015  0003 00000000      	ds.b	4
1051                     ; 134 void JudgeDefrostDriver(void)
1051                     ; 135 {
1052                     	switch	.text
1053  008c               f_JudgeDefrostDriver:
1057                     ; 139     EngineState |= ENGINE_700RPM; //debug program???????
1059  008c 72100007      	bset	_EngineState,#0
1060                     ; 142     if ((IGNstate == OFF) || (BatVoltageState == batvolLow)) //|| (EngineState & ENGINE_700RPM))
1062  0090 c60000        	ld	a,_IGNstate
1063  0093 2707          	jreq	L365
1065  0095 c6000a        	ld	a,_BatVoltageState
1066  0098 a155          	cp	a,#85
1067  009a 2607          	jrne	L165
1068  009c               L365:
1069                     ; 144           DefrostKeepTime =0;
1071  009c 5f            	clrw	x
1072  009d cf0005        	ldw	L345_DefrostKeepTime+2,x
1073  00a0 cf0003        	ldw	L345_DefrostKeepTime,x
1074  00a3               L165:
1075                     ; 146     if(DefrostKeepTime == 0) //(!REAR_DEFROSTER_OUT)    		
1077  00a3 ae0003        	ldw	x,#L345_DefrostKeepTime
1078  00a6 8d000000      	callf	d_lzmp
1080  00aa 2616          	jrne	L565
1081                     ; 148           if (DefrostKeySta == Pressed)
1083  00ac c60009        	ld	a,_DefrostKeySta
1084  00af a155          	cp	a,#85
1085  00b1 2624          	jrne	L175
1086                     ; 150                    DefrostKeySta = Unpressed;
1088  00b3 725f0009      	clr	_DefrostKeySta
1089                     ; 151                    DefrostKeepTime =DEFROST_TIMEOUT_PHASE;
1091  00b7 ae9a28        	ldw	x,#39464
1092  00ba cf0005        	ldw	L345_DefrostKeepTime+2,x
1093  00bd ae0001        	ldw	x,#1
1094  00c0 200f          	jpf	LC001
1095  00c2               L565:
1096                     ; 156         if (DefrostKeySta == Pressed)
1098  00c2 c60009        	ld	a,_DefrostKeySta
1099  00c5 a155          	cp	a,#85
1100  00c7 260e          	jrne	L175
1101                     ; 158                  DefrostKeySta = Unpressed;
1103  00c9 725f0009      	clr	_DefrostKeySta
1104                     ; 159                  DefrostKeepTime = 0;//REAR_DEFROSTER_OFF; //turn off rear defroster
1106  00cd 5f            	clrw	x
1107  00ce cf0005        	ldw	L345_DefrostKeepTime+2,x
1108  00d1               LC001:
1109  00d1 cf0003        	ldw	L345_DefrostKeepTime,x
1110  00d4 ae0003        	ldw	x,#L345_DefrostKeepTime
1111  00d7               L175:
1112                     ; 162    if (DefrostKeepTime  != 0)
1114  00d7 8d000000      	callf	d_lzmp
1116  00db 2713          	jreq	L575
1117                     ; 164           DefrostKeepTime--;
1119  00dd a601          	ld	a,#1
1120  00df 8d000000      	callf	d_lgsbc
1122                     ; 165           REAR_DEFROSTER_ON;
1124  00e3 72165014      	bset	20500,#3
1125                     ; 166 		  CAN_RDefrostSW_ON;
1127  00e7 72100004      	bset	_CanSendData+4,#0
1128                     ; 167           DefrostDriverState = 1;
1130  00eb 35010008      	mov	_DefrostDriverState,#1
1133  00ef 87            	retf	
1134  00f0               L575:
1135                     ; 171           REAR_DEFROSTER_OFF;
1137  00f0 72175014      	bres	20500,#3
1138                     ; 172 		  CAN_RDefrostSW_OFF;
1140  00f4 c60004        	ld	a,_CanSendData+4
1141  00f7 a4fc          	and	a,#252
1142  00f9 c70004        	ld	_CanSendData+4,a
1143                     ; 173           DefrostDriverState = 0;
1145  00fc 725f0008      	clr	_DefrostDriverState
1146                     ; 175 }    	
1149  0100 87            	retf	
1191                     	switch	.bss
1192  0007               _EngineState:
1193  0007 00            	ds.b	1
1194                     	xdef	_EngineState
1195                     	xref	f_GetADCresultAverage
1196                     	xref	_IGNstate
1197                     	xref	_battervalue
1198                     	xref	_CanSendData
1199                     	xdef	f_JudgeDefrostDriver
1200                     	xdef	f_ScanBatteryVoltage
1201                     	xdef	f_ScanDefrostSwitch
1202  0008               _DefrostDriverState:
1203  0008 00            	ds.b	1
1204                     	xdef	_DefrostDriverState
1205  0009               _DefrostKeySta:
1206  0009 00            	ds.b	1
1207                     	xdef	_DefrostKeySta
1208  000a               _BatVoltageState:
1209  000a 00            	ds.b	1
1210                     	xdef	_BatVoltageState
1230                     	xref	d_lgsbc
1231                     	xref	d_lzmp
1232                     	end
