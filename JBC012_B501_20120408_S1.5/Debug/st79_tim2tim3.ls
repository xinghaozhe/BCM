   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.2 - 23 Oct 2007
   3                     ; Optimizer V4.2.2 - 23 Oct 2007
 987                     ; 7 void TIM2TIM3_Counter_Cycle_OVIE_init(MTIM_TypeDef * TIMX, u16 ARR_Data)
 987                     ; 8 {	
 988                     	switch	.text
 989  0000               f_TIM2TIM3_Counter_Cycle_OVIE_init:
 991  0000 89            	pushw	x
 992       00000000      OFST:	set	0
 995                     ; 9 	if(TIMX == TIM2) 
 997  0001 a35300        	cpw	x,#21248
 998  0004 2607          	jrne	L345
 999                     ; 10 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
1001  0006 ae0001        	ldw	x,#1
1002  0009 a605          	ld	a,#5
1005  000b 2005          	jra	L545
1006  000d               L345:
1007                     ; 13 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER3, ENABLE);
1009  000d ae0001        	ldw	x,#1
1010  0010 a606          	ld	a,#6
1012  0012               L545:
1013  0012 95            	ld	xh,a
1014  0013 8d000000      	callf	f_CLK_PeripheralClockConfig
1015                     ; 16  	TIMX->CR1 |= 0X80; 				//set preload mode
1017  0017 1e01          	ldw	x,(OFST+1,sp)
1018  0019 f6            	ld	a,(x)
1019  001a aa80          	or	a,#128
1020  001c f7            	ld	(x),a
1021                     ; 17   	TIMX->PSCL = 4; 					//set prescaler
1023  001d a604          	ld	a,#4
1024  001f e70c          	ld	(12,x),a
1025                     ; 18   	TIMX->ARRH = (u8)(ARR_Data>>8);
1027  0021 7b06          	ld	a,(OFST+6,sp)
1028  0023 e70d          	ld	(13,x),a
1029                     ; 19   	TIMX->ARRL = (u8)ARR_Data;  
1031  0025 7b07          	ld	a,(OFST+7,sp)
1032  0027 e70e          	ld	(14,x),a
1033                     ; 20   	TIMX->CNTRH = 0;
1035  0029 6f0a          	clr	(10,x)
1036                     ; 21  	TIMX->CNTRL = 10; 
1038  002b a60a          	ld	a,#10
1039  002d e70b          	ld	(11,x),a
1040                     ; 23   	TIMX->IER = 1; 
1042  002f a601          	ld	a,#1
1043  0031 e701          	ld	(1,x),a
1044                     ; 24   	TIMX->SR1 &= ~1; 
1046  0033 e602          	ld	a,(2,x)
1047  0035 a4fe          	and	a,#254
1048  0037 e702          	ld	(2,x),a
1049                     ; 25   	TIMX->CR1 |= 1;
1051  0039 f6            	ld	a,(x)
1052  003a aa01          	or	a,#1
1053  003c f7            	ld	(x),a
1054                     ; 35 }
1057  003d 85            	popw	x
1058  003e 87            	retf	
1214                     ; 37 void TIM2TIM3_OCMP_Init(MTIM_TypeDef * TIMX, uc8 CC_Channel, u16 CCR_Value, TIM2TIM3_OCMP_Mode OCMP_Mode, TIM2TIM3_Output_Mode Output_Mode)
1214                     ; 38 {						// disable TIMxCCR register preload 
1215                     	switch	.text
1216  003f               f_TIM2TIM3_OCMP_Init:
1218  003f 89            	pushw	x
1219  0040 88            	push	a
1220       00000001      OFST:	set	1
1223                     ; 39 	switch(CC_Channel)
1225  0041 7b07          	ld	a,(OFST+6,sp)
1227                     ; 78 		default:
1227                     ; 79 		break;
1228  0043 4a            	dec	a
1229  0044 270a          	jreq	L745
1230  0046 4a            	dec	a
1231  0047 2735          	jreq	L155
1232  0049 4a            	dec	a
1233  004a 276b          	jreq	L355
1234  004c ace500e5      	jra	L356
1235  0050               L745:
1236                     ; 41 		case	1:
1236                     ; 42 		TIMX->CCER1 = TIMX->CCER1 & 0xfe;			//first clear CC1E bit in CCER, then you can modify the CC1S bits in CCMR.
1238  0050 1e02          	ldw	x,(OFST+1,sp)
1239  0052 e608          	ld	a,(8,x)
1240  0054 a4fe          	and	a,#254
1241  0056 e708          	ld	(8,x),a
1242                     ; 43 		TIMX->CCMR1 = 0b00000011;					//setup the CC1S bits to reserved value, then you can modify OC1M & OC1PE configurations.
1244  0058 a603          	ld	a,#3
1245  005a e705          	ld	(5,x),a
1246                     ; 44 		TIMX->CCMR1 |= OCMP_Mode;				//set output compare mode
1248  005c e605          	ld	a,(5,x)
1249  005e 1a0a          	or	a,(OFST+9,sp)
1250  0060 e705          	ld	(5,x),a
1251                     ; 46 		TIMX->CCMR1 &= 0xfc;						//clear CC1S bits for enable channel output direction
1253  0062 e605          	ld	a,(5,x)
1254  0064 a4fc          	and	a,#252
1255  0066 e705          	ld	(5,x),a
1256                     ; 47 		TIMX->CCER1 = (TIMX->CCER1 & 0xfc) | Output_Mode;
1258  0068 e608          	ld	a,(8,x)
1259  006a a4fc          	and	a,#252
1260  006c 1a0b          	or	a,(OFST+10,sp)
1261  006e e708          	ld	(8,x),a
1262                     ; 48 		TIMX->CCR1H = (u8)(CCR_Value>>8);
1264  0070 7b08          	ld	a,(OFST+7,sp)
1265  0072 e70f          	ld	(15,x),a
1266                     ; 49  		TIMX->CCR1L = (u8)(CCR_Value);
1268  0074 7b09          	ld	a,(OFST+8,sp)
1269  0076 e710          	ld	(16,x),a
1270                     ; 51 		TIMX->IER |= 2;								//enable CC1 channel output compare interrupt
1272  0078 e601          	ld	a,(1,x)
1273  007a aa02          	or	a,#2
1274                     ; 52 		break;
1276  007c 2065          	jpf	LC001
1277  007e               L155:
1278                     ; 54 		case	2:
1278                     ; 55 		TIMX->CCER1 = TIMX->CCER1 & 0xef;			//first clear CC2E bit in CCER, then you can modify the CC2S bits in CCMR.
1280  007e 1e02          	ldw	x,(OFST+1,sp)
1281  0080 e608          	ld	a,(8,x)
1282  0082 a4ef          	and	a,#239
1283  0084 e708          	ld	(8,x),a
1284                     ; 56 		TIMX->CCMR2 = 0b00000011;					//setup the CC2S bits to reserved value, then you can modify OC2M & OC2PE configurations.
1286  0086 a603          	ld	a,#3
1287  0088 e706          	ld	(6,x),a
1288                     ; 57 		TIMX->CCMR2 |= OCMP_Mode;
1290  008a e606          	ld	a,(6,x)
1291  008c 1a0a          	or	a,(OFST+9,sp)
1292  008e e706          	ld	(6,x),a
1293                     ; 59 		TIMX->CCMR2 &= 0xfc;						//clear CC2S bits for output compare mode
1295  0090 e606          	ld	a,(6,x)
1296  0092 a4fc          	and	a,#252
1297  0094 e706          	ld	(6,x),a
1298                     ; 60 		TIMX->CCER1 = (TIMX->CCER1 & 0xcf) | (Output_Mode<<4);
1300  0096 7b0b          	ld	a,(OFST+10,sp)
1301  0098 97            	ld	xl,a
1302  0099 a610          	ld	a,#16
1303  009b 42            	mul	x,a
1304  009c 9f            	ld	a,xl
1305  009d 6b01          	ld	(OFST+0,sp),a
1306  009f 1e02          	ldw	x,(OFST+1,sp)
1307  00a1 e608          	ld	a,(8,x)
1308  00a3 a4cf          	and	a,#207
1309  00a5 1a01          	or	a,(OFST+0,sp)
1310  00a7 e708          	ld	(8,x),a
1311                     ; 61 		TIMX->CCR2H = (u8)(CCR_Value>>8);
1313  00a9 7b08          	ld	a,(OFST+7,sp)
1314  00ab e711          	ld	(17,x),a
1315                     ; 62  		TIMX->CCR2L = (u8)(CCR_Value);
1317  00ad 7b09          	ld	a,(OFST+8,sp)
1318  00af e712          	ld	(18,x),a
1319                     ; 63 		TIMX->IER |= 4;								//enable CC2 channel output compare interrupt
1321  00b1 e601          	ld	a,(1,x)
1322  00b3 aa04          	or	a,#4
1323                     ; 64 		break;
1325  00b5 202c          	jpf	LC001
1326  00b7               L355:
1327                     ; 66 		case	3:
1327                     ; 67 		TIMX->CCER2 = TIMX->CCER2 & 0xfe;			//first clear CC3E bit in CCER, then you can modify the CC3S bits in CCMR.
1329  00b7 1e02          	ldw	x,(OFST+1,sp)
1330  00b9 e609          	ld	a,(9,x)
1331  00bb a4fe          	and	a,#254
1332  00bd e709          	ld	(9,x),a
1333                     ; 68 		TIMX->CCMR3 = 0b00000011;					//setup the CC3S bits to reserved value, then you can modify OC3M & OC3PE configurations.
1335  00bf a603          	ld	a,#3
1336  00c1 e707          	ld	(7,x),a
1337                     ; 69 		TIMX->CCMR3 |= OCMP_Mode;
1339  00c3 e607          	ld	a,(7,x)
1340  00c5 1a0a          	or	a,(OFST+9,sp)
1341  00c7 e707          	ld	(7,x),a
1342                     ; 71 		TIMX->CCMR3 &= 0xfc;						//clear CC3S bits for output compare mode
1344  00c9 e607          	ld	a,(7,x)
1345  00cb a4fc          	and	a,#252
1346  00cd e707          	ld	(7,x),a
1347                     ; 72 		TIMX->CCER2 = (TIMX->CCER2 & 0xfc) | Output_Mode;
1349  00cf e609          	ld	a,(9,x)
1350  00d1 a4fc          	and	a,#252
1351  00d3 1a0b          	or	a,(OFST+10,sp)
1352  00d5 e709          	ld	(9,x),a
1353                     ; 73 		TIMX->CCR3H = (u8)(CCR_Value>>8);
1355  00d7 7b08          	ld	a,(OFST+7,sp)
1356  00d9 e713          	ld	(19,x),a
1357                     ; 74  		TIMX->CCR3L = (u8)(CCR_Value);
1359  00db 7b09          	ld	a,(OFST+8,sp)
1360  00dd e714          	ld	(20,x),a
1361                     ; 75 		TIMX->IER |= 8;								//enable CC2 channel output compare interrupt
1363  00df e601          	ld	a,(1,x)
1364  00e1 aa08          	or	a,#8
1365  00e3               LC001:
1366  00e3 e701          	ld	(1,x),a
1367                     ; 76 		break;
1369                     ; 78 		default:
1369                     ; 79 		break;
1371  00e5               L356:
1372                     ; 82 }
1375  00e5 5b03          	addw	sp,#3
1376  00e7 87            	retf	
1468                     ; 84 void TIM2TIM3_PWM_Init(MTIM_TypeDef * TIMX, uc8 CC_Channel, u16 CCR_Value, TIM2TIM3_PWM_Mode PWM_Mode, TIM2TIM3_Output_Mode Output_Mode)
1468                     ; 85 {
1469                     	switch	.text
1470  00e8               f_TIM2TIM3_PWM_Init:
1472  00e8 89            	pushw	x
1473  00e9 88            	push	a
1474       00000001      OFST:	set	1
1477                     ; 86 	switch(CC_Channel)
1479  00ea 7b07          	ld	a,(OFST+6,sp)
1481                     ; 128 		default:
1481                     ; 129 		break;
1482  00ec 4a            	dec	a
1483  00ed 270a          	jreq	L556
1484  00ef 4a            	dec	a
1485  00f0 273b          	jreq	L756
1486  00f2 4a            	dec	a
1487  00f3 2777          	jreq	L166
1488  00f5 aca001a0      	jra	L537
1489  00f9               L556:
1490                     ; 88 		case	1:
1490                     ; 89 		TIMX->CCER1 = TIMX->CCER1 & 0xfe;			//first clear CC1E bit in CCER, then you can modify the CC1S bits in CCMR.
1492  00f9 1e02          	ldw	x,(OFST+1,sp)
1493  00fb e608          	ld	a,(8,x)
1494  00fd a4fe          	and	a,#254
1495  00ff e708          	ld	(8,x),a
1496                     ; 90 		TIMX->CCMR1 = 0b00000011;					//setup the CC1S bits to reserved value, then you can modify OC1M & OC1PE configurations.
1498  0101 a603          	ld	a,#3
1499  0103 e705          	ld	(5,x),a
1500                     ; 91 		TIMX->CCMR1 |= PWM_Mode;				//set PWM mode
1502  0105 e605          	ld	a,(5,x)
1503  0107 1a0a          	or	a,(OFST+9,sp)
1504  0109 e705          	ld	(5,x),a
1505                     ; 92 		TIMX->CCMR1 |= 0b00001000;					//set preload mode
1507  010b e605          	ld	a,(5,x)
1508  010d aa08          	or	a,#8
1509  010f e705          	ld	(5,x),a
1510                     ; 93 		TIMX->CCMR1 &= 0xfc;						//clear CC1S bits for enable channel output direction
1512  0111 e605          	ld	a,(5,x)
1513  0113 a4fc          	and	a,#252
1514  0115 e705          	ld	(5,x),a
1515                     ; 94 		TIMX->CCER1 = (TIMX->CCER1 & 0xfc) | Output_Mode;
1517  0117 e608          	ld	a,(8,x)
1518  0119 a4fc          	and	a,#252
1519  011b 1a0b          	or	a,(OFST+10,sp)
1520  011d e708          	ld	(8,x),a
1521                     ; 95 		TIMX->CCR1H = (u8)(CCR_Value>>8);
1523  011f 7b08          	ld	a,(OFST+7,sp)
1524  0121 e70f          	ld	(15,x),a
1525                     ; 96  		TIMX->CCR1L = (u8)(CCR_Value);
1527  0123 7b09          	ld	a,(OFST+8,sp)
1528  0125 e710          	ld	(16,x),a
1529                     ; 99 		TIMX->IER &= ~2;								//disable CC1 channel PWM interrupt
1531  0127 e601          	ld	a,(1,x)
1532  0129 a4fd          	and	a,#253
1533                     ; 100 		break;
1535  012b 2071          	jpf	LC002
1536  012d               L756:
1537                     ; 102 		case	2:
1537                     ; 103 		TIMX->CCER1 = TIMX->CCER1 & 0xef;			//first clear CC2E bit in CCER, then you can modify the CC2S bits in CCMR.
1539  012d 1e02          	ldw	x,(OFST+1,sp)
1540  012f e608          	ld	a,(8,x)
1541  0131 a4ef          	and	a,#239
1542  0133 e708          	ld	(8,x),a
1543                     ; 104 		TIMX->CCMR2 = 0b00000011;					//setup the CC2S bits to reserved value, then you can modify OC2M & OC2PE configurations.
1545  0135 a603          	ld	a,#3
1546  0137 e706          	ld	(6,x),a
1547                     ; 105 		TIMX->CCMR2 |= PWM_Mode;
1549  0139 e606          	ld	a,(6,x)
1550  013b 1a0a          	or	a,(OFST+9,sp)
1551  013d e706          	ld	(6,x),a
1552                     ; 106 		TIMX->CCMR2 |= 0b00001000;					//set preload mode
1554  013f e606          	ld	a,(6,x)
1555  0141 aa08          	or	a,#8
1556  0143 e706          	ld	(6,x),a
1557                     ; 107 		TIMX->CCMR2 &= 0xfc;						//clear CC2S bits for output compare mode
1559  0145 e606          	ld	a,(6,x)
1560  0147 a4fc          	and	a,#252
1561  0149 e706          	ld	(6,x),a
1562                     ; 108 		TIMX->CCER1 = (TIMX->CCER1 & 0xcf) | (Output_Mode<<4);
1564  014b 7b0b          	ld	a,(OFST+10,sp)
1565  014d 97            	ld	xl,a
1566  014e a610          	ld	a,#16
1567  0150 42            	mul	x,a
1568  0151 9f            	ld	a,xl
1569  0152 6b01          	ld	(OFST+0,sp),a
1570  0154 1e02          	ldw	x,(OFST+1,sp)
1571  0156 e608          	ld	a,(8,x)
1572  0158 a4cf          	and	a,#207
1573  015a 1a01          	or	a,(OFST+0,sp)
1574  015c e708          	ld	(8,x),a
1575                     ; 109 		TIMX->CCR2H = (u8)(CCR_Value>>8);
1577  015e 7b08          	ld	a,(OFST+7,sp)
1578  0160 e711          	ld	(17,x),a
1579                     ; 110  		TIMX->CCR2L = (u8)(CCR_Value);
1581  0162 7b09          	ld	a,(OFST+8,sp)
1582  0164 e712          	ld	(18,x),a
1583                     ; 112 		TIMX->IER &= ~4;								//disable CC2 channel PWM interrupt
1585  0166 e601          	ld	a,(1,x)
1586  0168 a4fb          	and	a,#251
1587                     ; 113 		break;
1589  016a 2032          	jpf	LC002
1590  016c               L166:
1591                     ; 115 		case	3:
1591                     ; 116 		TIMX->CCER2 = TIMX->CCER2 & 0xfe;			//first clear CC3E bit in CCER, then you can modify the CC3S bits in CCMR.
1593  016c 1e02          	ldw	x,(OFST+1,sp)
1594  016e e609          	ld	a,(9,x)
1595  0170 a4fe          	and	a,#254
1596  0172 e709          	ld	(9,x),a
1597                     ; 117 		TIMX->CCMR3 = 0b00000011;					//setup the CC3S bits to reserved value, then you can modify OC3M & OC3PE configurations.
1599  0174 a603          	ld	a,#3
1600  0176 e707          	ld	(7,x),a
1601                     ; 118 		TIMX->CCMR3 |= PWM_Mode;
1603  0178 e607          	ld	a,(7,x)
1604  017a 1a0a          	or	a,(OFST+9,sp)
1605  017c e707          	ld	(7,x),a
1606                     ; 119 		TIMX->CCMR3 |= 0b00001000;					//set preload mode
1608  017e e607          	ld	a,(7,x)
1609  0180 aa08          	or	a,#8
1610  0182 e707          	ld	(7,x),a
1611                     ; 120 		TIMX->CCMR3 &= 0xfc;						//clear CC3S bits for output compare mode
1613  0184 e607          	ld	a,(7,x)
1614  0186 a4fc          	and	a,#252
1615  0188 e707          	ld	(7,x),a
1616                     ; 121 		TIMX->CCER2 = (TIMX->CCER2 & 0xfc) | Output_Mode;
1618  018a e609          	ld	a,(9,x)
1619  018c a4fc          	and	a,#252
1620  018e 1a0b          	or	a,(OFST+10,sp)
1621  0190 e709          	ld	(9,x),a
1622                     ; 122 		TIMX->CCR3H = (u8)(CCR_Value>>8);
1624  0192 7b08          	ld	a,(OFST+7,sp)
1625  0194 e713          	ld	(19,x),a
1626                     ; 123  		TIMX->CCR3L = (u8)(CCR_Value);
1628  0196 7b09          	ld	a,(OFST+8,sp)
1629  0198 e714          	ld	(20,x),a
1630                     ; 125 		TIMX->IER &= ~8;								//disable CC3 channel PWM interrupt
1632  019a e601          	ld	a,(1,x)
1633  019c a4f7          	and	a,#247
1634  019e               LC002:
1635  019e e701          	ld	(1,x),a
1636                     ; 126 		break;
1638                     ; 128 		default:
1638                     ; 129 		break;
1640  01a0               L537:
1641                     ; 132 }
1644  01a0 5b03          	addw	sp,#3
1645  01a2 87            	retf	
1697                     ; 134 void TIM2TIM3_CCR_WRITE(MTIM_TypeDef * TIMX, uc8 CC_Channel,   u16 CCR_Value)
1697                     ; 135 {
1698                     	switch	.text
1699  01a3               f_TIM2TIM3_CCR_WRITE:
1701  01a3 89            	pushw	x
1702       00000000      OFST:	set	0
1705                     ; 136 	switch(CC_Channel)
1707  01a4 7b06          	ld	a,(OFST+6,sp)
1709                     ; 151 		default:
1709                     ; 152 		break;
1710  01a6 4a            	dec	a
1711  01a7 2708          	jreq	L737
1712  01a9 4a            	dec	a
1713  01aa 2711          	jreq	L147
1714  01ac 4a            	dec	a
1715  01ad 271a          	jreq	L347
1716  01af 2022          	jra	L777
1717  01b1               L737:
1718                     ; 138 		case 	1:
1718                     ; 139 		TIMX->CCR1H = (u8)(CCR_Value>>8);
1720  01b1 7b07          	ld	a,(OFST+7,sp)
1721  01b3 1e01          	ldw	x,(OFST+1,sp)
1722  01b5 e70f          	ld	(15,x),a
1723                     ; 140  		TIMX->CCR1L = (u8)(CCR_Value);
1725  01b7 7b08          	ld	a,(OFST+8,sp)
1726  01b9 e710          	ld	(16,x),a
1727                     ; 141 		break;
1729  01bb 2016          	jra	L777
1730  01bd               L147:
1731                     ; 142 		case 	2:
1731                     ; 143 		TIMX->CCR2H = (u8)(CCR_Value>>8);
1733  01bd 7b07          	ld	a,(OFST+7,sp)
1734  01bf 1e01          	ldw	x,(OFST+1,sp)
1735  01c1 e711          	ld	(17,x),a
1736                     ; 144  		TIMX->CCR2L = (u8)(CCR_Value);
1738  01c3 7b08          	ld	a,(OFST+8,sp)
1739  01c5 e712          	ld	(18,x),a
1740                     ; 145 		break;
1742  01c7 200a          	jra	L777
1743  01c9               L347:
1744                     ; 146 		case 	3:
1744                     ; 147 		TIMX->CCR3H = (u8)(CCR_Value>>8);
1746  01c9 7b07          	ld	a,(OFST+7,sp)
1747  01cb 1e01          	ldw	x,(OFST+1,sp)
1748  01cd e713          	ld	(19,x),a
1749                     ; 148  		TIMX->CCR3L = (u8)(CCR_Value);
1751  01cf 7b08          	ld	a,(OFST+8,sp)
1752  01d1 e714          	ld	(20,x),a
1753                     ; 149 		break;
1755                     ; 151 		default:
1755                     ; 152 		break;
1757  01d3               L777:
1758                     ; 154 }
1761  01d3 85            	popw	x
1762  01d4 87            	retf	
1850                     ; 156 void TIM2TIM3_Clear_IT_Flag(MTIM_TypeDef * TIMX, TIM2TIM3_IT_Flag Flag_F)
1850                     ; 157 {
1851                     	switch	.text
1852  01d5               f_TIM2TIM3_Clear_IT_Flag:
1854  01d5 89            	pushw	x
1855       00000000      OFST:	set	0
1858                     ; 158 	TIMX->SR1 &= (~Flag_F) ;
1860  01d6 7b06          	ld	a,(OFST+6,sp)
1861  01d8 43            	cpl	a
1862  01d9 e402          	and	a,(2,x)
1863  01db e702          	ld	(2,x),a
1864                     ; 159 	TIMX->SR2 = 0;				//not handle the overcapture event, clear all of the overcapture flag
1866  01dd 6f03          	clr	(3,x)
1867                     ; 160 }
1870  01df 85            	popw	x
1871  01e0 87            	retf	
1965                     ; 162 void TIM2TIM3_Enable_IT(MTIM_TypeDef * TIMX, TIM2TIM3_Enable_IT_Bit IE_Bit)
1965                     ; 163 {
1966                     	switch	.text
1967  01e1               f_TIM2TIM3_Enable_IT:
1969  01e1 89            	pushw	x
1970       00000000      OFST:	set	0
1973                     ; 164 	TIMX->IER |= IE_Bit;
1975  01e2 e601          	ld	a,(1,x)
1976  01e4 1a06          	or	a,(OFST+6,sp)
1977  01e6 e701          	ld	(1,x),a
1978                     ; 165 }
1981  01e8 85            	popw	x
1982  01e9 87            	retf	
2029                     ; 167 void TIM2TIM3_Disable_IT(MTIM_TypeDef * TIMX, TIM2TIM3_Enable_IT_Bit IE_Bit)
2029                     ; 168 {
2030                     	switch	.text
2031  01ea               f_TIM2TIM3_Disable_IT:
2033  01ea 89            	pushw	x
2034       00000000      OFST:	set	0
2037                     ; 169 	TIMX->IER &= (~IE_Bit);
2039  01eb 7b06          	ld	a,(OFST+6,sp)
2040  01ed 43            	cpl	a
2041  01ee e401          	and	a,(1,x)
2042  01f0 e701          	ld	(1,x),a
2043                     ; 170 }
2046  01f2 85            	popw	x
2047  01f3 87            	retf	
2059                     	xref	f_CLK_PeripheralClockConfig
2060                     	xdef	f_TIM2TIM3_Disable_IT
2061                     	xdef	f_TIM2TIM3_Enable_IT
2062                     	xdef	f_TIM2TIM3_Clear_IT_Flag
2063                     	xdef	f_TIM2TIM3_CCR_WRITE
2064                     	xdef	f_TIM2TIM3_PWM_Init
2065                     	xdef	f_TIM2TIM3_OCMP_Init
2066                     	xdef	f_TIM2TIM3_Counter_Cycle_OVIE_init
2085                     	end
