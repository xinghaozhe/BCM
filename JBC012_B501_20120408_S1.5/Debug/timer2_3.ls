   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 814                     ; 7 void TIM2_Counter_Cycle_OVIE_init(u16 ARR_Data)
 814                     ; 8 {	
 815                     	switch	.text
 816  0000               f_TIM2_Counter_Cycle_OVIE_init:
 818  0000 89            	pushw	x
 819       00000000      OFST:	set	0
 822                     ; 9 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 824  0001 ae0001        	ldw	x,#1
 825  0004 a605          	ld	a,#5
 826  0006 95            	ld	xh,a
 827  0007 8d000000      	callf	f_CLK_PeripheralClockConfig
 829                     ; 11  	TIM2->CR1 |= 0X80; 				//set preload mode
 831  000b 721e5300      	bset	21248,#7
 832                     ; 12   	TIM2->PSCR = 4; 					//set prescaler
 834  000f 3504530c      	mov	21260,#4
 835                     ; 13   	TIM2->ARRH = (u8)(ARR_Data>>8);
 837  0013 7b01          	ld	a,(OFST+1,sp)
 838  0015 c7530d        	ld	21261,a
 839                     ; 14   	TIM2->ARRL = (u8)ARR_Data;  
 841  0018 7b02          	ld	a,(OFST+2,sp)
 842  001a c7530e        	ld	21262,a
 843                     ; 15   	TIM2->CNTRH = 0;
 845  001d 725f530a      	clr	21258
 846                     ; 16  	TIM2->CNTRL = 10; 
 848  0021 350a530b      	mov	21259,#10
 849                     ; 18   	TIM2->IER = 1; 
 851  0025 35015301      	mov	21249,#1
 852                     ; 19   	TIM2->SR1 &= ~1; 
 854  0029 72115302      	bres	21250,#0
 855                     ; 20   	TIM2->CR1 |= 1;
 857  002d 72105300      	bset	21248,#0
 858                     ; 22 }
 861  0031 85            	popw	x
 862  0032 87            	retf	
 895                     ; 25 void TIM3_Counter_Cycle_OVIE_init(u16 ARR_Data)
 895                     ; 26 {	
 896                     	switch	.text
 897  0033               f_TIM3_Counter_Cycle_OVIE_init:
 899  0033 89            	pushw	x
 900       00000000      OFST:	set	0
 903                     ; 27 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER3, ENABLE);
 905  0034 ae0001        	ldw	x,#1
 906  0037 a606          	ld	a,#6
 907  0039 95            	ld	xh,a
 908  003a 8d000000      	callf	f_CLK_PeripheralClockConfig
 910                     ; 29  	TIM3->CR1 |= 0X80; 				//set preload mode
 912  003e 721e5320      	bset	21280,#7
 913                     ; 30   	TIM3->PSCR = 4; 					//set prescaler
 915  0042 3504532a      	mov	21290,#4
 916                     ; 31   	TIM3->ARRH = (u8)(ARR_Data>>8);
 918  0046 7b01          	ld	a,(OFST+1,sp)
 919  0048 c7532b        	ld	21291,a
 920                     ; 32   	TIM3->ARRL = (u8)ARR_Data;  
 922  004b 7b02          	ld	a,(OFST+2,sp)
 923  004d c7532c        	ld	21292,a
 924                     ; 33   	TIM3->CNTRH = 0;
 926  0050 725f5328      	clr	21288
 927                     ; 34  	TIM3->CNTRL = 10; 
 929  0054 350a5329      	mov	21289,#10
 930                     ; 36   	TIM3->IER = 1; 
 932  0058 35015321      	mov	21281,#1
 933                     ; 37   	TIM3->SR1 &= ~1; 
 935  005c 72115322      	bres	21282,#0
 936                     ; 38   	TIM3->CR1 |= 1;
 938  0060 72105320      	bset	21280,#0
 939                     ; 40 }
 942  0064 85            	popw	x
 943  0065 87            	retf	
1087                     ; 43 void TIM2_OCMP_Init(uc8 CC_Channel, u16 CCR_Value, TIM2TIM3_OCMP_Mode OCMP_Mode, TIM2TIM3_Output_Mode Output_Mode)
1087                     ; 44 {						// disable TIM2CCR register preload 
1088                     	switch	.text
1089  0066               f_TIM2_OCMP_Init:
1091  0066 88            	push	a
1092  0067 88            	push	a
1093       00000001      OFST:	set	1
1096                     ; 45 	switch(CC_Channel)
1099                     ; 84 		default:
1099                     ; 85 		break;
1100  0068 4a            	dec	a
1101  0069 270a          	jreq	L174
1102  006b 4a            	dec	a
1103  006c 2739          	jreq	L374
1104  006e 4a            	dec	a
1105  006f 2771          	jreq	L574
1106  0071 ac120112      	jra	L765
1107  0075               L174:
1108                     ; 47 		case	1:
1108                     ; 48 		TIM2->CCER1 = TIM2->CCER1 & 0xfe;			//first clear CC1E bit in CCER, then you can modify the CC1S bits in CCMR.
1110  0075 72115308      	bres	21256,#0
1111                     ; 49 		TIM2->CCMR1 = 0b00000011;					//setup the CC1S bits to reserved value, then you can modify OC1M & OC1PE configurations.
1113  0079 35035305      	mov	21253,#3
1114                     ; 50 		TIM2->CCMR1 |= OCMP_Mode;				//set output compare mode
1116  007d c65305        	ld	a,21253
1117  0080 1a08          	or	a,(OFST+7,sp)
1118  0082 c75305        	ld	21253,a
1119                     ; 52 		TIM2->CCMR1 &= 0xfc;						//clear CC1S bits for enable channel output direction
1121  0085 c65305        	ld	a,21253
1122  0088 a4fc          	and	a,#252
1123  008a c75305        	ld	21253,a
1124                     ; 53 		TIM2->CCER1 = (TIM2->CCER1 & 0xfc) | Output_Mode;
1126  008d c65308        	ld	a,21256
1127  0090 a4fc          	and	a,#252
1128  0092 1a09          	or	a,(OFST+8,sp)
1129  0094 c75308        	ld	21256,a
1130                     ; 54 		TIM2->CCR1H = (u8)(CCR_Value>>8);
1132  0097 7b06          	ld	a,(OFST+5,sp)
1133  0099 c7530f        	ld	21263,a
1134                     ; 55  		TIM2->CCR1L = (u8)(CCR_Value);
1136  009c 7b07          	ld	a,(OFST+6,sp)
1137  009e c75310        	ld	21264,a
1138                     ; 57 		TIM2->IER |= 2;								//enable CC1 channel output compare interrupt
1140  00a1 72125301      	bset	21249,#1
1141                     ; 58 		break;
1143  00a5 206b          	jra	L765
1144  00a7               L374:
1145                     ; 60 		case	2:
1145                     ; 61 		TIM2->CCER1 = TIM2->CCER1 & 0xef;			//first clear CC2E bit in CCER, then you can modify the CC2S bits in CCMR.
1147  00a7 72195308      	bres	21256,#4
1148                     ; 62 		TIM2->CCMR2 = 0b00000011;					//setup the CC2S bits to reserved value, then you can modify OC2M & OC2PE configurations.
1150  00ab 35035306      	mov	21254,#3
1151                     ; 63 		TIM2->CCMR2 |= OCMP_Mode;
1153  00af c65306        	ld	a,21254
1154  00b2 1a08          	or	a,(OFST+7,sp)
1155  00b4 c75306        	ld	21254,a
1156                     ; 65 		TIM2->CCMR2 &= 0xfc;						//clear CC2S bits for output compare mode
1158  00b7 c65306        	ld	a,21254
1159  00ba a4fc          	and	a,#252
1160  00bc c75306        	ld	21254,a
1161                     ; 66 		TIM2->CCER1 = (TIM2->CCER1 & 0xcf) | (Output_Mode<<4);
1163  00bf 7b09          	ld	a,(OFST+8,sp)
1164  00c1 97            	ld	xl,a
1165  00c2 a610          	ld	a,#16
1166  00c4 42            	mul	x,a
1167  00c5 9f            	ld	a,xl
1168  00c6 6b01          	ld	(OFST+0,sp),a
1169  00c8 c65308        	ld	a,21256
1170  00cb a4cf          	and	a,#207
1171  00cd 1a01          	or	a,(OFST+0,sp)
1172  00cf c75308        	ld	21256,a
1173                     ; 67 		TIM2->CCR2H = (u8)(CCR_Value>>8);
1175  00d2 7b06          	ld	a,(OFST+5,sp)
1176  00d4 c75311        	ld	21265,a
1177                     ; 68  		TIM2->CCR2L = (u8)(CCR_Value);
1179  00d7 7b07          	ld	a,(OFST+6,sp)
1180  00d9 c75312        	ld	21266,a
1181                     ; 69 		TIM2->IER |= 4;								//enable CC2 channel output compare interrupt
1183  00dc 72145301      	bset	21249,#2
1184                     ; 70 		break;
1186  00e0 2030          	jra	L765
1187  00e2               L574:
1188                     ; 72 		case	3:
1188                     ; 73 		TIM2->CCER2 = TIM2->CCER2 & 0xfe;			//first clear CC3E bit in CCER, then you can modify the CC3S bits in CCMR.
1190  00e2 72115309      	bres	21257,#0
1191                     ; 74 		TIM2->CCMR3 = 0b00000011;					//setup the CC3S bits to reserved value, then you can modify OC3M & OC3PE configurations.
1193  00e6 35035307      	mov	21255,#3
1194                     ; 75 		TIM2->CCMR3 |= OCMP_Mode;
1196  00ea c65307        	ld	a,21255
1197  00ed 1a08          	or	a,(OFST+7,sp)
1198  00ef c75307        	ld	21255,a
1199                     ; 77 		TIM2->CCMR3 &= 0xfc;						//clear CC3S bits for output compare mode
1201  00f2 c65307        	ld	a,21255
1202  00f5 a4fc          	and	a,#252
1203  00f7 c75307        	ld	21255,a
1204                     ; 78 		TIM2->CCER2 = (TIM2->CCER2 & 0xfc) | Output_Mode;
1206  00fa c65309        	ld	a,21257
1207  00fd a4fc          	and	a,#252
1208  00ff 1a09          	or	a,(OFST+8,sp)
1209  0101 c75309        	ld	21257,a
1210                     ; 79 		TIM2->CCR3H = (u8)(CCR_Value>>8);
1212  0104 7b06          	ld	a,(OFST+5,sp)
1213  0106 c75313        	ld	21267,a
1214                     ; 80  		TIM2->CCR3L = (u8)(CCR_Value);
1216  0109 7b07          	ld	a,(OFST+6,sp)
1217  010b c75314        	ld	21268,a
1218                     ; 81 		TIM2->IER |= 8;								//enable CC2 channel output compare interrupt
1220  010e 72165301      	bset	21249,#3
1221                     ; 82 		break;
1223                     ; 84 		default:
1223                     ; 85 		break;
1225  0112               L765:
1226                     ; 88 }
1229  0112 85            	popw	x
1230  0113 87            	retf	
1290                     ; 90 void TIM3_OCMP_Init(uc8 CC_Channel, u16 CCR_Value, TIM2TIM3_OCMP_Mode OCMP_Mode, TIM2TIM3_Output_Mode Output_Mode)
1290                     ; 91 {						// disable TIM3CCR register preload 
1291                     	switch	.text
1292  0114               f_TIM3_OCMP_Init:
1294  0114 88            	push	a
1295  0115 88            	push	a
1296       00000001      OFST:	set	1
1299                     ; 92 	switch(CC_Channel)
1302                     ; 120 		default:
1302                     ; 121 		break;
1303  0116 4a            	dec	a
1304  0117 2705          	jreq	L175
1305  0119 4a            	dec	a
1306  011a 2734          	jreq	L375
1307  011c 206b          	jra	L136
1308  011e               L175:
1309                     ; 94 		case	1:
1309                     ; 95 		TIM3->CCER1 = TIM3->CCER1 & 0xfe;			//first clear CC1E bit in CCER, then you can modify the CC1S bits in CCMR.
1311  011e 72115327      	bres	21287,#0
1312                     ; 96 		TIM3->CCMR1 = 0b00000011;					//setup the CC1S bits to reserved value, then you can modify OC1M & OC1PE configurations.
1314  0122 35035325      	mov	21285,#3
1315                     ; 97 		TIM3->CCMR1 |= OCMP_Mode;				//set output compare mode
1317  0126 c65325        	ld	a,21285
1318  0129 1a08          	or	a,(OFST+7,sp)
1319  012b c75325        	ld	21285,a
1320                     ; 99 		TIM3->CCMR1 &= 0xfc;						//clear CC1S bits for enable channel output direction
1322  012e c65325        	ld	a,21285
1323  0131 a4fc          	and	a,#252
1324  0133 c75325        	ld	21285,a
1325                     ; 100 		TIM3->CCER1 = (TIM3->CCER1 & 0xfc) | Output_Mode;
1327  0136 c65327        	ld	a,21287
1328  0139 a4fc          	and	a,#252
1329  013b 1a09          	or	a,(OFST+8,sp)
1330  013d c75327        	ld	21287,a
1331                     ; 101 		TIM3->CCR1H = (u8)(CCR_Value>>8);
1333  0140 7b06          	ld	a,(OFST+5,sp)
1334  0142 c7532d        	ld	21293,a
1335                     ; 102  		TIM3->CCR1L = (u8)(CCR_Value);
1337  0145 7b07          	ld	a,(OFST+6,sp)
1338  0147 c7532e        	ld	21294,a
1339                     ; 104 		TIM3->IER |= 2;								//enable CC1 channel output compare interrupt
1341  014a 72125321      	bset	21281,#1
1342                     ; 105 		break;
1344  014e 2039          	jra	L136
1345  0150               L375:
1346                     ; 107 		case	2:
1346                     ; 108 		TIM3->CCER1 = TIM3->CCER1 & 0xef;			//first clear CC2E bit in CCER, then you can modify the CC2S bits in CCMR.
1348  0150 72195327      	bres	21287,#4
1349                     ; 109 		TIM3->CCMR2 = 0b00000011;					//setup the CC2S bits to reserved value, then you can modify OC2M & OC2PE configurations.
1351  0154 35035326      	mov	21286,#3
1352                     ; 110 		TIM3->CCMR2 |= OCMP_Mode;
1354  0158 c65326        	ld	a,21286
1355  015b 1a08          	or	a,(OFST+7,sp)
1356  015d c75326        	ld	21286,a
1357                     ; 112 		TIM3->CCMR2 &= 0xfc;						//clear CC2S bits for output compare mode
1359  0160 c65326        	ld	a,21286
1360  0163 a4fc          	and	a,#252
1361  0165 c75326        	ld	21286,a
1362                     ; 113 		TIM3->CCER1 = (TIM3->CCER1 & 0xcf) | (Output_Mode<<4);
1364  0168 7b09          	ld	a,(OFST+8,sp)
1365  016a 97            	ld	xl,a
1366  016b a610          	ld	a,#16
1367  016d 42            	mul	x,a
1368  016e 9f            	ld	a,xl
1369  016f 6b01          	ld	(OFST+0,sp),a
1370  0171 c65327        	ld	a,21287
1371  0174 a4cf          	and	a,#207
1372  0176 1a01          	or	a,(OFST+0,sp)
1373  0178 c75327        	ld	21287,a
1374                     ; 114 		TIM3->CCR2H = (u8)(CCR_Value>>8);
1376  017b 7b06          	ld	a,(OFST+5,sp)
1377  017d c7532f        	ld	21295,a
1378                     ; 115  		TIM3->CCR2L = (u8)(CCR_Value);
1380  0180 7b07          	ld	a,(OFST+6,sp)
1381  0182 c75330        	ld	21296,a
1382                     ; 116 		TIM3->IER |= 4;								//enable CC2 channel output compare interrupt
1384  0185 72145321      	bset	21281,#2
1385                     ; 117 		break;
1387                     ; 120 		default:
1387                     ; 121 		break;
1389  0189               L136:
1390                     ; 124 }
1393  0189 85            	popw	x
1394  018a 87            	retf	
1474                     ; 128 void TIM2_PWM_Init(uc8 CC_Channel, u16 CCR_Value, TIM2TIM3_PWM_Mode PWM_Mode, TIM2TIM3_Output_Mode Output_Mode)
1474                     ; 129 {
1475                     	switch	.text
1476  018b               f_TIM2_PWM_Init:
1478  018b 88            	push	a
1479  018c 88            	push	a
1480       00000001      OFST:	set	1
1483                     ; 130 	switch(CC_Channel)
1486                     ; 172 		default:
1486                     ; 173 		break;
1487  018d 4a            	dec	a
1488  018e 270a          	jreq	L336
1489  0190 4a            	dec	a
1490  0191 273d          	jreq	L536
1491  0193 4a            	dec	a
1492  0194 2779          	jreq	L736
1493  0196 ac430243      	jra	L507
1494  019a               L336:
1495                     ; 132 		case	1:
1495                     ; 133 		TIM2->CCER1 = TIM2->CCER1 & 0xfe;			//first clear CC1E bit in CCER, then you can modify the CC1S bits in CCMR.
1497  019a 72115308      	bres	21256,#0
1498                     ; 134 		TIM2->CCMR1 = 0b00000011;					//setup the CC1S bits to reserved value, then you can modify OC1M & OC1PE configurations.
1500  019e 35035305      	mov	21253,#3
1501                     ; 135 		TIM2->CCMR1 |= PWM_Mode;				//set PWM mode
1503  01a2 c65305        	ld	a,21253
1504  01a5 1a08          	or	a,(OFST+7,sp)
1505  01a7 c75305        	ld	21253,a
1506                     ; 136 		TIM2->CCMR1 |= 0b00001000;					//set preload mode
1508  01aa 72165305      	bset	21253,#3
1509                     ; 137 		TIM2->CCMR1 &= 0xfc;						//clear CC1S bits for enable channel output direction
1511  01ae c65305        	ld	a,21253
1512  01b1 a4fc          	and	a,#252
1513  01b3 c75305        	ld	21253,a
1514                     ; 138 		TIM2->CCER1 = (TIM2->CCER1 & 0xfc) | Output_Mode;
1516  01b6 c65308        	ld	a,21256
1517  01b9 a4fc          	and	a,#252
1518  01bb 1a09          	or	a,(OFST+8,sp)
1519  01bd c75308        	ld	21256,a
1520                     ; 139 		TIM2->CCR1H = (u8)(CCR_Value>>8);
1522  01c0 7b06          	ld	a,(OFST+5,sp)
1523  01c2 c7530f        	ld	21263,a
1524                     ; 140  		TIM2->CCR1L = (u8)(CCR_Value);
1526  01c5 7b07          	ld	a,(OFST+6,sp)
1527  01c7 c75310        	ld	21264,a
1528                     ; 143 		TIM2->IER &= ~2;								//disable CC1 channel PWM interrupt
1530  01ca 72135301      	bres	21249,#1
1531                     ; 144 		break;
1533  01ce 2073          	jra	L507
1534  01d0               L536:
1535                     ; 146 		case	2:
1535                     ; 147 		TIM2->CCER1 = TIM2->CCER1 & 0xef;			//first clear CC2E bit in CCER, then you can modify the CC2S bits in CCMR.
1537  01d0 72195308      	bres	21256,#4
1538                     ; 148 		TIM2->CCMR2 = 0b00000011;					//setup the CC2S bits to reserved value, then you can modify OC2M & OC2PE configurations.
1540  01d4 35035306      	mov	21254,#3
1541                     ; 149 		TIM2->CCMR2 |= PWM_Mode;
1543  01d8 c65306        	ld	a,21254
1544  01db 1a08          	or	a,(OFST+7,sp)
1545  01dd c75306        	ld	21254,a
1546                     ; 150 		TIM2->CCMR2 |= 0b00001000;					//set preload mode
1548  01e0 72165306      	bset	21254,#3
1549                     ; 151 		TIM2->CCMR2 &= 0xfc;						//clear CC2S bits for output compare mode
1551  01e4 c65306        	ld	a,21254
1552  01e7 a4fc          	and	a,#252
1553  01e9 c75306        	ld	21254,a
1554                     ; 152 		TIM2->CCER1 = (TIM2->CCER1 & 0xcf) | (Output_Mode<<4);
1556  01ec 7b09          	ld	a,(OFST+8,sp)
1557  01ee 97            	ld	xl,a
1558  01ef a610          	ld	a,#16
1559  01f1 42            	mul	x,a
1560  01f2 9f            	ld	a,xl
1561  01f3 6b01          	ld	(OFST+0,sp),a
1562  01f5 c65308        	ld	a,21256
1563  01f8 a4cf          	and	a,#207
1564  01fa 1a01          	or	a,(OFST+0,sp)
1565  01fc c75308        	ld	21256,a
1566                     ; 153 		TIM2->CCR2H = (u8)(CCR_Value>>8);
1568  01ff 7b06          	ld	a,(OFST+5,sp)
1569  0201 c75311        	ld	21265,a
1570                     ; 154  		TIM2->CCR2L = (u8)(CCR_Value);
1572  0204 7b07          	ld	a,(OFST+6,sp)
1573  0206 c75312        	ld	21266,a
1574                     ; 156 		TIM2->IER &= ~4;								//disable CC2 channel PWM interrupt
1576  0209 72155301      	bres	21249,#2
1577                     ; 157 		break;
1579  020d 2034          	jra	L507
1580  020f               L736:
1581                     ; 159 		case	3:
1581                     ; 160 		TIM2->CCER2 = TIM2->CCER2 & 0xfe;			//first clear CC3E bit in CCER, then you can modify the CC3S bits in CCMR.
1583  020f 72115309      	bres	21257,#0
1584                     ; 161 		TIM2->CCMR3 = 0b00000011;					//setup the CC3S bits to reserved value, then you can modify OC3M & OC3PE configurations.
1586  0213 35035307      	mov	21255,#3
1587                     ; 162 		TIM2->CCMR3 |= PWM_Mode;
1589  0217 c65307        	ld	a,21255
1590  021a 1a08          	or	a,(OFST+7,sp)
1591  021c c75307        	ld	21255,a
1592                     ; 163 		TIM2->CCMR3 |= 0b00001000;					//set preload mode
1594  021f 72165307      	bset	21255,#3
1595                     ; 164 		TIM2->CCMR3 &= 0xfc;						//clear CC3S bits for output compare mode
1597  0223 c65307        	ld	a,21255
1598  0226 a4fc          	and	a,#252
1599  0228 c75307        	ld	21255,a
1600                     ; 165 		TIM2->CCER2 = (TIM2->CCER2 & 0xfc) | Output_Mode;
1602  022b c65309        	ld	a,21257
1603  022e a4fc          	and	a,#252
1604  0230 1a09          	or	a,(OFST+8,sp)
1605  0232 c75309        	ld	21257,a
1606                     ; 166 		TIM2->CCR3H = (u8)(CCR_Value>>8);
1608  0235 7b06          	ld	a,(OFST+5,sp)
1609  0237 c75313        	ld	21267,a
1610                     ; 167  		TIM2->CCR3L = (u8)(CCR_Value);
1612  023a 7b07          	ld	a,(OFST+6,sp)
1613  023c c75314        	ld	21268,a
1614                     ; 169 		TIM2->IER &= ~8;								//disable CC3 channel PWM interrupt
1616  023f 72175301      	bres	21249,#3
1617                     ; 170 		break;
1619                     ; 172 		default:
1619                     ; 173 		break;
1621  0243               L507:
1622                     ; 176 }
1625  0243 85            	popw	x
1626  0244 87            	retf	
1686                     ; 178 void TIM3_PWM_Init(uc8 CC_Channel, u16 CCR_Value, TIM2TIM3_PWM_Mode PWM_Mode, TIM2TIM3_Output_Mode Output_Mode)
1686                     ; 179 {
1687                     	switch	.text
1688  0245               f_TIM3_PWM_Init:
1690  0245 88            	push	a
1691  0246 88            	push	a
1692       00000001      OFST:	set	1
1695                     ; 180 	switch(CC_Channel)
1698                     ; 210 		default:
1698                     ; 211 		break;
1699  0247 4a            	dec	a
1700  0248 2705          	jreq	L707
1701  024a 4a            	dec	a
1702  024b 2738          	jreq	L117
1703  024d 2073          	jra	L747
1704  024f               L707:
1705                     ; 182 		case	1:
1705                     ; 183 		TIM3->CCER1 = TIM3->CCER1 & 0xfe;			//first clear CC1E bit in CCER, then you can modify the CC1S bits in CCMR.
1707  024f 72115327      	bres	21287,#0
1708                     ; 184 		TIM3->CCMR1 = 0b00000011;					//setup the CC1S bits to reserved value, then you can modify OC1M & OC1PE configurations.
1710  0253 35035325      	mov	21285,#3
1711                     ; 185 		TIM3->CCMR1 |= PWM_Mode;				//set PWM mode
1713  0257 c65325        	ld	a,21285
1714  025a 1a08          	or	a,(OFST+7,sp)
1715  025c c75325        	ld	21285,a
1716                     ; 186 		TIM3->CCMR1 |= 0b00001000;					//set preload mode
1718  025f 72165325      	bset	21285,#3
1719                     ; 187 		TIM3->CCMR1 &= 0xfc;						//clear CC1S bits for enable channel output direction
1721  0263 c65325        	ld	a,21285
1722  0266 a4fc          	and	a,#252
1723  0268 c75325        	ld	21285,a
1724                     ; 188 		TIM3->CCER1 = (TIM3->CCER1 & 0xfc) | Output_Mode;
1726  026b c65327        	ld	a,21287
1727  026e a4fc          	and	a,#252
1728  0270 1a09          	or	a,(OFST+8,sp)
1729  0272 c75327        	ld	21287,a
1730                     ; 189 		TIM3->CCR1H = (u8)(CCR_Value>>8);
1732  0275 7b06          	ld	a,(OFST+5,sp)
1733  0277 c7532d        	ld	21293,a
1734                     ; 190  		TIM3->CCR1L = (u8)(CCR_Value);
1736  027a 7b07          	ld	a,(OFST+6,sp)
1737  027c c7532e        	ld	21294,a
1738                     ; 193 		TIM3->IER &= ~2;								//disable CC1 channel PWM interrupt
1740  027f 72135321      	bres	21281,#1
1741                     ; 194 		break;
1743  0283 203d          	jra	L747
1744  0285               L117:
1745                     ; 196 		case	2:
1745                     ; 197 		TIM3->CCER1 = TIM3->CCER1 & 0xef;			//first clear CC2E bit in CCER, then you can modify the CC2S bits in CCMR.
1747  0285 72195327      	bres	21287,#4
1748                     ; 198 		TIM3->CCMR2 = 0b00000011;					//setup the CC2S bits to reserved value, then you can modify OC2M & OC2PE configurations.
1750  0289 35035326      	mov	21286,#3
1751                     ; 199 		TIM3->CCMR2 |= PWM_Mode;
1753  028d c65326        	ld	a,21286
1754  0290 1a08          	or	a,(OFST+7,sp)
1755  0292 c75326        	ld	21286,a
1756                     ; 200 		TIM3->CCMR2 |= 0b00001000;					//set preload mode
1758  0295 72165326      	bset	21286,#3
1759                     ; 201 		TIM3->CCMR2 &= 0xfc;						//clear CC2S bits for output compare mode
1761  0299 c65326        	ld	a,21286
1762  029c a4fc          	and	a,#252
1763  029e c75326        	ld	21286,a
1764                     ; 202 		TIM3->CCER1 = (TIM3->CCER1 & 0xcf) | (Output_Mode<<4);
1766  02a1 7b09          	ld	a,(OFST+8,sp)
1767  02a3 97            	ld	xl,a
1768  02a4 a610          	ld	a,#16
1769  02a6 42            	mul	x,a
1770  02a7 9f            	ld	a,xl
1771  02a8 6b01          	ld	(OFST+0,sp),a
1772  02aa c65327        	ld	a,21287
1773  02ad a4cf          	and	a,#207
1774  02af 1a01          	or	a,(OFST+0,sp)
1775  02b1 c75327        	ld	21287,a
1776                     ; 203 		TIM3->CCR2H = (u8)(CCR_Value>>8);
1778  02b4 7b06          	ld	a,(OFST+5,sp)
1779  02b6 c7532f        	ld	21295,a
1780                     ; 204  		TIM3->CCR2L = (u8)(CCR_Value);
1782  02b9 7b07          	ld	a,(OFST+6,sp)
1783  02bb c75330        	ld	21296,a
1784                     ; 206 		TIM3->IER &= ~4;								//disable CC2 channel PWM interrupt
1786  02be 72155321      	bres	21281,#2
1787                     ; 207 		break;
1789                     ; 210 		default:
1789                     ; 211 		break;
1791  02c2               L747:
1792                     ; 214 }
1795  02c2 85            	popw	x
1796  02c3 87            	retf	
1836                     ; 218 void TIM2_CCR_WRITE( uc8 CC_Channel,   u16 CCR_Value)
1836                     ; 219 {
1837                     	switch	.text
1838  02c4               f_TIM2_CCR_WRITE:
1840  02c4 88            	push	a
1841       00000000      OFST:	set	0
1844                     ; 220 	switch(CC_Channel)
1847                     ; 236 		break;
1849  02c5 4a            	dec	a
1850  02c6 2708          	jreq	L157
1851  02c8 4a            	dec	a
1852  02c9 2711          	jreq	L357
1853  02cb 4a            	dec	a
1854  02cc 271a          	jreq	L557
1855  02ce 2022          	jra	L3001
1856  02d0               L157:
1857                     ; 222 		case 	1:
1857                     ; 223 		TIM2->CCR1H = (u8)(CCR_Value>>8);
1859  02d0 7b05          	ld	a,(OFST+5,sp)
1860  02d2 c7530f        	ld	21263,a
1861                     ; 224  		TIM2->CCR1L = (u8)(CCR_Value);
1863  02d5 7b06          	ld	a,(OFST+6,sp)
1864  02d7 c75310        	ld	21264,a
1865                     ; 225 		break;
1867  02da 2016          	jra	L3001
1868  02dc               L357:
1869                     ; 226 		case 	2:
1869                     ; 227 		TIM2->CCR2H = (u8)(CCR_Value>>8);
1871  02dc 7b05          	ld	a,(OFST+5,sp)
1872  02de c75311        	ld	21265,a
1873                     ; 228  		TIM2->CCR2L = (u8)(CCR_Value);
1875  02e1 7b06          	ld	a,(OFST+6,sp)
1876  02e3 c75312        	ld	21266,a
1877                     ; 229 		break;
1879  02e6 200a          	jra	L3001
1880  02e8               L557:
1881                     ; 230 		case 	3:
1881                     ; 231 		TIM2->CCR3H = (u8)(CCR_Value>>8);
1883  02e8 7b05          	ld	a,(OFST+5,sp)
1884  02ea c75313        	ld	21267,a
1885                     ; 232  		TIM2->CCR3L = (u8)(CCR_Value);
1887  02ed 7b06          	ld	a,(OFST+6,sp)
1888  02ef c75314        	ld	21268,a
1889                     ; 233 		break;
1891                     ; 235 		default:break;
1893  02f2               L3001:
1894                     ; 238 }
1897  02f2 84            	pop	a
1898  02f3 87            	retf	
1938                     ; 240 void TIM3_CCR_WRITE(uc8 CC_Channel,   u16 CCR_Value)
1938                     ; 241 {
1939                     	switch	.text
1940  02f4               f_TIM3_CCR_WRITE:
1942  02f4 88            	push	a
1943       00000000      OFST:	set	0
1946                     ; 242 	switch(CC_Channel)
1949                     ; 253 		default:
1949                     ; 254 		break;
1950  02f5 4a            	dec	a
1951  02f6 2705          	jreq	L5001
1952  02f8 4a            	dec	a
1953  02f9 270e          	jreq	L7001
1954  02fb 2016          	jra	L5301
1955  02fd               L5001:
1956                     ; 244 		case 	1:
1956                     ; 245 		TIM3->CCR1H = (u8)(CCR_Value>>8);
1958  02fd 7b05          	ld	a,(OFST+5,sp)
1959  02ff c7532d        	ld	21293,a
1960                     ; 246  		TIM3->CCR1L = (u8)(CCR_Value);
1962  0302 7b06          	ld	a,(OFST+6,sp)
1963  0304 c7532e        	ld	21294,a
1964                     ; 247 		break;
1966  0307 200a          	jra	L5301
1967  0309               L7001:
1968                     ; 248 		case 	2:
1968                     ; 249 		TIM3->CCR2H = (u8)(CCR_Value>>8);
1970  0309 7b05          	ld	a,(OFST+5,sp)
1971  030b c7532f        	ld	21295,a
1972                     ; 250  		TIM3->CCR2L = (u8)(CCR_Value);
1974  030e 7b06          	ld	a,(OFST+6,sp)
1975  0310 c75330        	ld	21296,a
1976                     ; 251 		break;
1978                     ; 253 		default:
1978                     ; 254 		break;
1980  0313               L5301:
1981                     ; 256 }
1984  0313 84            	pop	a
1985  0314 87            	retf	
2060                     ; 260 void TIM2_Clear_IT_Flag(TIM2TIM3_IT_Flag Flag_F)
2060                     ; 261 {
2061                     	switch	.text
2062  0315               f_TIM2_Clear_IT_Flag:
2066                     ; 262 	TIM2->SR1 &= (~Flag_F) ;
2068  0315 43            	cpl	a
2069  0316 c45302        	and	a,21250
2070  0319 c75302        	ld	21250,a
2071                     ; 263 	TIM2->SR2 = 0;				//not handle the overcapture event, clear all of the overcapture flag
2073  031c 725f5303      	clr	21251
2074                     ; 264 }
2077  0320 87            	retf	
2111                     ; 266 void TIM3_Clear_IT_Flag(TIM2TIM3_IT_Flag Flag_F)
2111                     ; 267 {
2112                     	switch	.text
2113  0321               f_TIM3_Clear_IT_Flag:
2117                     ; 268 	TIM3->SR1 &= (~Flag_F) ;
2119  0321 43            	cpl	a
2120  0322 c45322        	and	a,21282
2121  0325 c75322        	ld	21282,a
2122                     ; 269 	TIM3->SR2 = 0;				//not handle the overcapture event, clear all of the overcapture flag
2124  0328 725f5323      	clr	21283
2125                     ; 270 }
2128  032c 87            	retf	
2210                     ; 274 void TIM2_Enable_IT(TIM2TIM3_Enable_IT_Bit IE_Bit)
2210                     ; 275 {
2211                     	switch	.text
2212  032d               f_TIM2_Enable_IT:
2216                     ; 276 	TIM2->IER |= IE_Bit;
2218  032d ca5301        	or	a,21249
2219  0330 c75301        	ld	21249,a
2220                     ; 277 }
2223  0333 87            	retf	
2257                     ; 279 void TIM3_Enable_IT(TIM2TIM3_Enable_IT_Bit IE_Bit)
2257                     ; 280 {
2258                     	switch	.text
2259  0334               f_TIM3_Enable_IT:
2263                     ; 281 	TIM3->IER |= IE_Bit;
2265  0334 ca5321        	or	a,21281
2266  0337 c75321        	ld	21281,a
2267                     ; 282 }
2270  033a 87            	retf	
2304                     ; 286 void TIM2_Disable_IT( TIM2TIM3_Enable_IT_Bit IE_Bit)
2304                     ; 287 {
2305                     	switch	.text
2306  033b               f_TIM2_Disable_IT:
2310                     ; 288 	TIM2->IER &= (~IE_Bit);
2312  033b 43            	cpl	a
2313  033c c45301        	and	a,21249
2314  033f c75301        	ld	21249,a
2315                     ; 289 }
2318  0342 87            	retf	
2352                     ; 290 void TIM3_Disable_IT(TIM2TIM3_Enable_IT_Bit IE_Bit)
2352                     ; 291 {
2353                     	switch	.text
2354  0343               f_TIM3_Disable_IT:
2358                     ; 292 	TIM3->IER &= (~IE_Bit);
2360  0343 43            	cpl	a
2361  0344 c45321        	and	a,21281
2362  0347 c75321        	ld	21281,a
2363                     ; 293 }
2366  034a 87            	retf	
2378                     	xref	f_CLK_PeripheralClockConfig
2379                     	xdef	f_TIM3_Disable_IT
2380                     	xdef	f_TIM3_Enable_IT
2381                     	xdef	f_TIM3_Clear_IT_Flag
2382                     	xdef	f_TIM3_CCR_WRITE
2383                     	xdef	f_TIM3_PWM_Init
2384                     	xdef	f_TIM3_OCMP_Init
2385                     	xdef	f_TIM3_Counter_Cycle_OVIE_init
2386                     	xdef	f_TIM2_Disable_IT
2387                     	xdef	f_TIM2_Enable_IT
2388                     	xdef	f_TIM2_Clear_IT_Flag
2389                     	xdef	f_TIM2_CCR_WRITE
2390                     	xdef	f_TIM2_PWM_Init
2391                     	xdef	f_TIM2_OCMP_Init
2392                     	xdef	f_TIM2_Counter_Cycle_OVIE_init
2411                     	end
