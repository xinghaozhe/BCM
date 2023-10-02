   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 804                     ; 68 @interrupt void NonHandledInterrupt(void)
 804                     ; 69 {
 805                     	switch	.text
 806  0000               f_NonHandledInterrupt:
 811                     ; 73   return;
 814  0000 80            	iret	
 836                     ; 86 @interrupt void TRAP_IRQHandler(void)
 836                     ; 87 {
 837                     	switch	.text
 838  0001               f_TRAP_IRQHandler:
 843                     ; 91   return;
 846  0001 80            	iret	
 868                     ; 104 @interrupt void TLI_IRQHandler (void)
 868                     ; 105 {
 869                     	switch	.text
 870  0002               f_TLI_IRQHandler:
 875                     ; 109   return;
 878  0002 80            	iret	
 909                     ; 122 @interrupt void AWU_IRQHandler (void)
 909                     ; 123 {
 910                     	switch	.text
 911  0003               f_AWU_IRQHandler:
 914       00000001      OFST:	set	1
 917                     ; 129      wake = AWU->CSR1;  //清出标志
 919  0003 c650f0        	ld	a,20720
 920                     ; 131      return;
 923  0006 80            	iret	
 945                     ; 144 @interrupt void CLK_IRQHandler (void)
 945                     ; 145 {
 946                     	switch	.text
 947  0007               f_CLK_IRQHandler:
 952                     ; 149   return;
 955  0007 80            	iret	
 978                     ; 162 @interrupt void EXTI_PORTA_IRQHandler (void)
 978                     ; 163 {
 979                     	switch	.text
 980  0008               f_EXTI_PORTA_IRQHandler:
 985                     ; 167   return;
 988  0008 80            	iret	
1011                     ; 180 @interrupt void EXTI_PORTB_IRQHandler (void)
1011                     ; 181 {
1012                     	switch	.text
1013  0009               f_EXTI_PORTB_IRQHandler:
1018                     ; 185   return;
1021  0009 80            	iret	
1044                     ; 198 @interrupt void EXTI_PORTC_IRQHandler (void)
1044                     ; 199 {
1045                     	switch	.text
1046  000a               f_EXTI_PORTC_IRQHandler:
1051                     ; 203   return;
1054  000a 80            	iret	
1077                     ; 216 @interrupt void EXTI_PORTE_IRQHandler (void)
1077                     ; 217 {
1078                     	switch	.text
1079  000b               f_EXTI_PORTE_IRQHandler:
1084                     ; 221   return;
1087  000b 80            	iret	
1089                     	switch	.bss
1090  0000               L755_IntStatus:
1091  0000 00            	ds.b	1
1175                     ; 238 @interrupt void EXTI_PORTD_IRQHandler(void)
1175                     ; 239 { 
1176                     	switch	.text
1177  000c               f_EXTI_PORTD_IRQHandler:
1180       00000006      OFST:	set	6
1181  000c 3b0002        	push	c_x+2
1182  000f be00          	ldw	x,c_x
1183  0011 89            	pushw	x
1184  0012 3b0002        	push	c_y+2
1185  0015 be00          	ldw	x,c_y
1186  0017 89            	pushw	x
1187  0018 5206          	subw	sp,#6
1190                     ; 246 	nop()
1193  001a 9d            	nop	
1195                     ; 247 	nop()
1198  001b 9d            	nop	
1200                     ; 248 	nop()
1203  001c 9d            	nop	
1205                     ; 249 	nop()
1208  001d 9d            	nop	
1210                     ; 250 	nop()
1213  001e 9d            	nop	
1215                     ; 251 	nop()
1218  001f 9d            	nop	
1220                     ; 252 	nop()
1223  0020 9d            	nop	
1225                     ; 253 	nop()
1228  0021 9d            	nop	
1230                     ; 254 	nop()
1233  0022 9d            	nop	
1235                     ; 255 	nop()
1238  0023 9d            	nop	
1240                     ; 256 	nop()
1243  0024 9d            	nop	
1245                     ; 257 	nop()
1248  0025 9d            	nop	
1250                     ; 258 	nop()
1253  0026 9d            	nop	
1255                     ; 259 	nop()
1258  0027 9d            	nop	
1260                     ; 260 	nop()
1263  0028 9d            	nop	
1265                     ; 261 	nop()
1268  0029 9d            	nop	
1270                     ; 262 	nop()
1273  002a 9d            	nop	
1275                     ; 263 	nop()
1278  002b 9d            	nop	
1280                     ; 264 	nop()
1283  002c 9d            	nop	
1285                     ; 265 	nop()
1288  002d 9d            	nop	
1290                     ; 266 	nop()
1293  002e 9d            	nop	
1295                     ; 267 	nop()
1298  002f 9d            	nop	
1300                     ; 269 	if(IntStatus && (!RKE_DATA_IN))
1302  0030 c60000        	ld	a,L755_IntStatus
1303  0033 2709          	jreq	LC001
1305  0035 7204501002    	btjt	20496,#2,L116
1306                     ; 270 		{IntStatus = RKE_DATA_IN;	return;}
1309  003a 2007          	jpf	LC002
1310  003c               L116:
1311                     ; 271 	if((!IntStatus) && (RKE_DATA_IN))
1313  003c 261c          	jrne	L316
1314  003e               LC001:
1316  003e 7205501017    	btjf	20496,#2,L316
1317                     ; 272 		{IntStatus = RKE_DATA_IN;	return;}
1319  0043               LC002:
1321  0043 c65010        	ld	a,20496
1322  0046 a404          	and	a,#4
1323  0048 c70000        	ld	L755_IntStatus,a
1325  004b               L25:
1328  004b 5b06          	addw	sp,#6
1329  004d 85            	popw	x
1330  004e bf00          	ldw	c_y,x
1331  0050 320002        	pop	c_y+2
1332  0053 85            	popw	x
1333  0054 bf00          	ldw	c_x,x
1334  0056 320002        	pop	c_x+2
1335  0059 80            	iret	
1336  005a               L316:
1337                     ; 274 	Tim3CntTemp = (TIM3->CNTRH << 8);
1339  005a c65328        	ld	a,21288
1340  005d 97            	ld	xl,a
1341  005e 4f            	clr	a
1342  005f 02            	rlwa	x,a
1343  0060 cf0005        	ldw	_Tim3CntTemp,x
1344                     ; 275 	Tim3CntTemp += TIM3->CNTRL;
1346  0063 c65329        	ld	a,21289
1347  0066 5f            	clrw	x
1348  0067 97            	ld	xl,a
1349  0068 1f01          	ldw	(OFST-5,sp),x
1350  006a ce0005        	ldw	x,_Tim3CntTemp
1351  006d 72fb01        	addw	x,(OFST-5,sp)
1352  0070 cf0005        	ldw	_Tim3CntTemp,x
1353                     ; 277 	sjs = Tim3CntTemp;
1355  0073 cf0000        	ldw	_sjs,x
1356                     ; 280    	TIM3->CNTRL = 0;
1358  0076 725f5329      	clr	21289
1359                     ; 281 	TIM3->CNTRH = 0;
1361  007a 725f5328      	clr	21288
1362                     ; 283 	if(WakeState == 1)
1364  007e c60000        	ld	a,_WakeState
1365  0081 4a            	dec	a
1366  0082 2614          	jrne	L516
1367                     ; 285               if ((Tim3CntTemp >= 200) && (Tim3CntTemp <= 1000))
1369  0084 a300c8        	cpw	x,#200
1370  0087 250b          	jrult	L716
1372  0089 a303e9        	cpw	x,#1001
1373  008c 2406          	jruge	L716
1374                     ; 287              	      WaveFilterCnt++;
1376  008e 725c0000      	inc	_WaveFilterCnt
1378  0092 2004          	jra	L516
1379  0094               L716:
1380                     ; 292                       WaveFilterCnt = 0;
1382  0094 725f0000      	clr	_WaveFilterCnt
1383  0098               L516:
1384                     ; 295     switch (RKE_STEP)
1386  0098 c60000        	ld	a,_RKE_STEP
1388                     ; 386     	}break;
1389  009b 2709          	jreq	L165
1390  009d 4a            	dec	a
1391  009e 2745          	jreq	L365
1392                     ; 385     		RKE_RECEIVE_RESET(); 
1394  00a0 8d000000      	callf	f_RKE_RECEIVE_RESET
1396                     ; 386     	}break;
1398  00a4 20a5          	jra	L25
1399  00a6               L165:
1400                     ; 300 			if ((Tim3CntTemp >= 3500) && (Tim3CntTemp <= 4500) && (RKE_DATA_IN))
1402  00a6 a30dac        	cpw	x,#3500
1403  00a9 2511          	jrult	L726
1405  00ab a31195        	cpw	x,#4501
1406  00ae 240c          	jruge	L726
1408  00b0 7205501007    	btjf	20496,#2,L726
1409                     ; 302         			RKE_STEP = RKE_RecData;
1411  00b5 35010000      	mov	_RKE_STEP,#1
1412                     ; 304         			bitCnt = 0;
1414  00b9 c70007        	ld	_bitCnt,a
1415  00bc               L726:
1416                     ; 309 			if (RKE_DATA_IN)	{FALL_EDGE_INT;	IntStatus = 0;}
1418  00bc 7205501012    	btjf	20496,#2,L136
1424  00c1               LC004:
1426  00c1 ae0002        	ldw	x,#2
1427  00c4 a603          	ld	a,#3
1428  00c6 95            	ld	xh,a
1429  00c7 8d000000      	callf	f_EXTI_SetExtIntSensitivity
1431  00cb 725f0000      	clr	L755_IntStatus
1433  00cf ac4b004b      	jra	L25
1434  00d3               L136:
1435                     ; 310 			else				{RISE_EDGE_INT;	IntStatus = 1;}
1441  00d3 ae0001        	ldw	x,#1
1442  00d6 a603          	ld	a,#3
1443  00d8 95            	ld	xh,a
1444  00d9 8d000000      	callf	f_EXTI_SetExtIntSensitivity
1446  00dd 35010000      	mov	L755_IntStatus,#1
1447  00e1 ac4b004b      	jra	L25
1448  00e5               L365:
1449                     ; 315     		i=bitCnt/16;
1451  00e5 c60007        	ld	a,_bitCnt
1452  00e8 4e            	swap	a
1453  00e9 a40f          	and	a,#15
1454  00eb 6b03          	ld	(OFST-3,sp),a
1455                     ; 317     		if (RKE_DATA_IN)	
1457  00ed 7205501002    	btjf	20496,#2,L536
1458                     ; 320    	    		 FALL_EDGE_INT;	IntStatus = 0;	//falling edge 
1462  00f2 20cd          	jpf	LC004
1463  00f4               L536:
1464                     ; 324      			    if((Tim3CntTemp > 200)&&(Tim3CntTemp< 500))
1466  00f4 a300c9        	cpw	x,#201
1467  00f7 2526          	jrult	L146
1469  00f9 a301f4        	cpw	x,#500
1470  00fc 2421          	jruge	L146
1471                     ; 326                         RKE_FIFO_DATA[i] &= ~(1 << (bitCnt % 16));
1473  00fe 5f            	clrw	x
1474  00ff 97            	ld	xl,a
1475  0100 58            	sllw	x
1476  0101 90ae0001      	ldw	y,#1
1477  0105 c60007        	ld	a,_bitCnt
1478  0108 a40f          	and	a,#15
1479  010a 2705          	jreq	L63
1480  010c               L04:
1481  010c 9058          	sllw	y
1482  010e 4a            	dec	a
1483  010f 26fb          	jrne	L04
1484  0111               L63:
1485  0111 9053          	cplw	y
1486  0113 9001          	rrwa	y,a
1487  0115 d40001        	and	a,(_RKE_FIFO_DATA+1,x)
1488  0118 9001          	rrwa	y,a
1489  011a d40000        	and	a,(_RKE_FIFO_DATA,x)
1491  011d 2027          	jpf	LC005
1492  011f               L146:
1493                     ; 328     				else if((Tim3CntTemp > 500)&&(Tim3CntTemp < 1000))
1495  011f a301f5        	cpw	x,#501
1496  0122 2529          	jrult	L546
1498  0124 a303e8        	cpw	x,#1000
1499  0127 2424          	jruge	L546
1500                     ; 330                         RKE_FIFO_DATA[i] |= (1 << (bitCnt % 16));
1502  0129 5f            	clrw	x
1503  012a 97            	ld	xl,a
1504  012b 58            	sllw	x
1505  012c 90ae0001      	ldw	y,#1
1506  0130 c60007        	ld	a,_bitCnt
1507  0133 a40f          	and	a,#15
1508  0135 2705          	jreq	L24
1509  0137               L44:
1510  0137 9058          	sllw	y
1511  0139 4a            	dec	a
1512  013a 26fb          	jrne	L44
1513  013c               L24:
1514  013c 9001          	rrwa	y,a
1515  013e da0001        	or	a,(_RKE_FIFO_DATA+1,x)
1516  0141 9001          	rrwa	y,a
1517  0143 da0000        	or	a,(_RKE_FIFO_DATA,x)
1518  0146               LC005:
1519  0146 9001          	rrwa	y,a
1520  0148 df0000        	ldw	(_RKE_FIFO_DATA,x),y
1522  014b 200c          	jra	L346
1523  014d               L546:
1524                     ; 334                         RKE_DATA_OK = 0x00;
1526  014d 725f0000      	clr	_RKE_DATA_OK
1527                     ; 335 						RKE_STEP = RKE_Idle;
1529  0151 725f0000      	clr	_RKE_STEP
1530                     ; 336 						bitCnt=0;
1532  0155 725f0007      	clr	_bitCnt
1533  0159               L346:
1534                     ; 338 		            if (++bitCnt >= 96)
1536  0159 725c0007      	inc	_bitCnt
1537  015d c60007        	ld	a,_bitCnt
1538  0160 a160          	cp	a,#96
1539  0162 2404acd300d3  	jrult	L136
1540                     ; 341 						RKE_outtime = 50;
1542  0168 35320000      	mov	_RKE_outtime,#50
1543                     ; 342                      	headercount[0] =(uchar)RKE_FIFO_DATA[0];
1545  016c c60001        	ld	a,_RKE_FIFO_DATA+1
1546  016f 6b04          	ld	(OFST-2,sp),a
1547                     ; 343 						headercount[1] =(uchar)RKE_FIFO_DATA[1];
1549  0171 c60003        	ld	a,_RKE_FIFO_DATA+3
1550  0174 6b05          	ld	(OFST-1,sp),a
1551                     ; 344 						headercount[2] =(uchar)(RKE_FIFO_DATA[1]>>8);
1553  0176 c60002        	ld	a,_RKE_FIFO_DATA+2
1554  0179 6b06          	ld	(OFST+0,sp),a
1555                     ; 345 						headercount[0] = headercount[0]^headercount[1];//+headercount[2];
1557  017b 7b04          	ld	a,(OFST-2,sp)
1558  017d 1805          	xor	a,(OFST-1,sp)
1559                     ; 346 					    headercount[0] = headercount[0]^headercount[2];
1561  017f 1806          	xor	a,(OFST+0,sp)
1562  0181 6b04          	ld	(OFST-2,sp),a
1563                     ; 347 						headercount[1] =(uchar)(RKE_FIFO_DATA[0]>>8);
1565  0183 c60000        	ld	a,_RKE_FIFO_DATA
1566  0186 6b05          	ld	(OFST-1,sp),a
1567                     ; 348 						if(headercount[0]==headercount[1])
1569  0188 7b04          	ld	a,(OFST-2,sp)
1570  018a 1105          	cp	a,(OFST-1,sp)
1571  018c 2634          	jrne	L356
1572                     ; 351                      	    RKE_STEP = RKE_Idle;
1574  018e 725f0000      	clr	_RKE_STEP
1575                     ; 354                             Header[0] = RKE_FIFO_DATA[0];
1577  0192 ce0000        	ldw	x,_RKE_FIFO_DATA
1578  0195 cf0000        	ldw	_Header,x
1579                     ; 355                             Header[1] = RKE_FIFO_DATA[1];
1581  0198 ce0002        	ldw	x,_RKE_FIFO_DATA+2
1582  019b cf0002        	ldw	_Header+2,x
1583                     ; 357                             A_Code[0] = RKE_FIFO_DATA[2];
1585  019e ce0004        	ldw	x,_RKE_FIFO_DATA+4
1586  01a1 cf0000        	ldw	_A_Code,x
1587                     ; 358                             A_Code[1] = RKE_FIFO_DATA[3];
1589  01a4 ce0006        	ldw	x,_RKE_FIFO_DATA+6
1590  01a7 cf0002        	ldw	_A_Code+2,x
1591                     ; 360                             B_Code[0] = RKE_FIFO_DATA[4];
1593  01aa ce0008        	ldw	x,_RKE_FIFO_DATA+8
1594  01ad cf0000        	ldw	_B_Code,x
1595                     ; 361                             B_Code[1] = RKE_FIFO_DATA[5];
1597  01b0 ce000a        	ldw	x,_RKE_FIFO_DATA+10
1598  01b3 cf0002        	ldw	_B_Code+2,x
1599                     ; 366 							RKE_DATA_OK = 0x55;
1601  01b6 35550000      	mov	_RKE_DATA_OK,#85
1602                     ; 367                      	    bitCnt=0;
1604  01ba 725f0007      	clr	_bitCnt
1606  01be acd300d3      	jra	L136
1607  01c2               L356:
1608                     ; 371                             RKE_STEP = RKE_Idle;
1610  01c2 725f0000      	clr	_RKE_STEP
1611                     ; 374  				     RISE_EDGE_INT;	IntStatus = 1;	//rising edge
1614                     ; 388 }
1616  01c6 acd300d3      	jpf	L136
1618                     	switch	.data
1619  0000               L166_data_len:
1620  0000 00            	dc.b	0
1621                     	switch	.bss
1622  0001               L756_filter_match_index:
1623  0001 00            	ds.b	1
1693                     ; 402 @interrupt void CAN_RX_IRQHandler (void)
1693                     ; 403 {
1694                     	switch	.text
1695  01ca               f_CAN_RX_IRQHandler:
1698       00000004      OFST:	set	4
1699  01ca 5204          	subw	sp,#4
1702                     ; 408 	CanSavePg();  
1704  01cc 5554270000    	mov	_Can_Page,_CAN_FPSR
1705                     ; 422 	if (CAN_MSR & CMSR_WKUI)	/* If Wake-Up Interrupt */
1707  01d1 7207542104    	btjf	_CAN_MSR,#3,L517
1708                     ; 424 		CAN_MSR = CMSR_WKUI;	/* then clear this bit */
1710  01d6 35085421      	mov	_CAN_MSR,#8
1711  01da               L517:
1712                     ; 428 	if (CAN_RFR & CRFR_FOVR)
1714  01da 7209542408    	btjf	_CAN_RFR,#4,L717
1715                     ; 430 		CAN_RFR |= CRFR_FOVR;		/* clear the FIFO Overrun (FOVR) bit */
1717  01df 72185424      	bset	_CAN_RFR,#4
1719  01e3 ac250425      	jra	L727
1720  01e7               L717:
1721                     ; 432 	else if (CAN_RFR & CRFR_FULL)
1723  01e7 72075424f7    	btjf	_CAN_RFR,#3,L727
1724                     ; 434 		CAN_RFR |= CRFR_FULL;		/* clear the FIFO full (FULL) bit */      
1726  01ec 72165424      	bset	_CAN_RFR,#3
1727  01f0 ac250425      	jra	L727
1728  01f4               L527:
1729                     ; 438 		CAN_FPSR = CAN_FIFO_PG;		/* Select Rx_FIFO page */
1731  01f4 35075427      	mov	_CAN_FPSR,#7
1732                     ; 439 		filter_match_index = CAN_MFMI;	/* Get FMI value */
1734  01f8 5554280001    	mov	L756_filter_match_index,_CAN_MFMI
1735                     ; 441          gNMCanBusOff = 0;   //nm
1737  01fd 725f0000      	clr	_gNMCanBusOff
1738                     ; 442          if(WakeState == 1){WakeState = 0;}
1740  0201 c60000        	ld	a,_WakeState
1741  0204 a101          	cp	a,#1
1742  0206 2604          	jrne	L337
1745  0208 725f0000      	clr	_WakeState
1746  020c               L337:
1747                     ; 444               if((((CAN_MIDR12 & 0xBFFF)>> 2) < 0x400)&&(((CAN_MIDR12 & 0xBFFF)>> 2) !=0x270))
1749  020c ce542a        	ldw	x,_CAN_MIDR12
1750  020f 02            	rlwa	x,a
1751  0210 a4bf          	and	a,#191
1752  0212 01            	rrwa	x,a
1753  0213 54            	srlw	x
1754  0214 54            	srlw	x
1755  0215 a30400        	cpw	x,#1024
1756  0218 240c          	jruge	L537
1758  021a ce542a        	ldw	x,_CAN_MIDR12
1759  021d 02            	rlwa	x,a
1760  021e a4bf          	and	a,#191
1761  0220 01            	rrwa	x,a
1762  0221 54            	srlw	x
1763  0222 54            	srlw	x
1764  0223 a30270        	cpw	x,#624
1765  0226               L537:
1766                     ; 453 		if((((CAN_MIDR12 & 0xBFFF)>> 2) < 0x400)&&(((CAN_MIDR12 & 0xBFFF)>> 2)!= 0x050)&&(((CAN_MIDR12 & 0xBFFF)>> 2)!= 0x265)&&(((CAN_MIDR12 & 0xBFFF)>> 2)!= 0x218))
1768  0226 ce542a        	ldw	x,_CAN_MIDR12
1769  0229 02            	rlwa	x,a
1770  022a a4bf          	and	a,#191
1771  022c 01            	rrwa	x,a
1772  022d 54            	srlw	x
1773  022e 54            	srlw	x
1774  022f a30400        	cpw	x,#1024
1775  0232 2431          	jruge	L737
1777  0234 ce542a        	ldw	x,_CAN_MIDR12
1778  0237 02            	rlwa	x,a
1779  0238 a4bf          	and	a,#191
1780  023a 01            	rrwa	x,a
1781  023b 54            	srlw	x
1782  023c 54            	srlw	x
1783  023d a30050        	cpw	x,#80
1784  0240 2723          	jreq	L737
1786  0242 ce542a        	ldw	x,_CAN_MIDR12
1787  0245 02            	rlwa	x,a
1788  0246 a4bf          	and	a,#191
1789  0248 01            	rrwa	x,a
1790  0249 54            	srlw	x
1791  024a 54            	srlw	x
1792  024b a30265        	cpw	x,#613
1793  024e 2715          	jreq	L737
1795  0250 ce542a        	ldw	x,_CAN_MIDR12
1796  0253 02            	rlwa	x,a
1797  0254 a4bf          	and	a,#191
1798  0256 01            	rrwa	x,a
1799  0257 54            	srlw	x
1800  0258 54            	srlw	x
1801  0259 a30218        	cpw	x,#536
1802  025c 2707          	jreq	L737
1803                     ; 455 		       CAN_RFR |= CRFR_RFOM;
1805  025e 721a5424      	bset	_CAN_RFR,#5
1806                     ; 456 			return;
1809  0262 5b04          	addw	sp,#4
1810  0264 80            	iret	
1811  0265               L737:
1812                     ; 463 	        for(Rx_Cnt = 0 ; Rx_Cnt < 10 ; Rx_Cnt ++ )
1814  0265 4f            	clr	a
1815  0266 6b04          	ld	(OFST+0,sp),a
1816  0268               L147:
1817                     ; 465 	            if( Rx_Msg[Rx_Cnt].State == 0 )
1819  0268 97            	ld	xl,a
1820  0269 a60e          	ld	a,#14
1821  026b 42            	mul	x,a
1822  026c 724d000d      	tnz	(_Rx_Msg+13,x)
1823  0270 2704ac150415  	jrne	L747
1824                     ; 468 	                 Rx_Msg[Rx_Cnt].stdid  =  (CAN_MIDR12 & 0xBFFF)>> 2;//Rx_Stdid[filter_match_index] ;
1826  0276 90ce542a      	ldw	y,_CAN_MIDR12
1827  027a 9002          	rlwa	y,a
1828  027c a4bf          	and	a,#191
1829  027e 9001          	rrwa	y,a
1830  0280 9054          	srlw	y
1831  0282 9054          	srlw	y
1832  0284 df0000        	ldw	(_Rx_Msg,x),y
1833                     ; 469 	                 Rx_Msg[Rx_Cnt].extid  =  CAN_MIDR34;//Rx_Extid[filter_match_index] ;
1835  0287 90ce542c      	ldw	y,_CAN_MIDR34
1836  028b df0002        	ldw	(_Rx_Msg+2,x),y
1837                     ; 470 	                 Rx_Msg[Rx_Cnt].dlc    =  CAN_MDLC; //Rx_Dlc[filter_match_index] ;
1839  028e c65429        	ld	a,_CAN_MDLC
1840  0291 d70004        	ld	(_Rx_Msg+4,x),a
1841                     ; 471 	                 for(RX_Data_Cnt = 0; RX_Data_Cnt < CAN_MDLC ; RX_Data_Cnt++)
1843  0294 0f03          	clr	(OFST-1,sp)
1845  0296 2017          	jra	L557
1846  0298               L157:
1847                     ; 473 	                     Rx_Msg[Rx_Cnt].data[RX_Data_Cnt] = CAN_MDAR[RX_Data_Cnt];//Rx_Data[filter_match_index][RX_Data_Cnt];
1849  0298 42            	mul	x,a
1850  0299 01            	rrwa	x,a
1851  029a 1b03          	add	a,(OFST-1,sp)
1852  029c 2401          	jrnc	L65
1853  029e 5c            	incw	x
1854  029f               L65:
1855  029f 02            	rlwa	x,a
1856  02a0 7b03          	ld	a,(OFST-1,sp)
1857  02a2 905f          	clrw	y
1858  02a4 9097          	ld	yl,a
1859  02a6 90d6542e      	ld	a,(_CAN_MDAR,y)
1860  02aa d70005        	ld	(_Rx_Msg+5,x),a
1861                     ; 471 	                 for(RX_Data_Cnt = 0; RX_Data_Cnt < CAN_MDLC ; RX_Data_Cnt++)
1863  02ad 0c03          	inc	(OFST-1,sp)
1864  02af               L557:
1867  02af 7b03          	ld	a,(OFST-1,sp)
1868  02b1 c15429        	cp	a,_CAN_MDLC
1869  02b4 7b04          	ld	a,(OFST+0,sp)
1870  02b6 97            	ld	xl,a
1871  02b7 a60e          	ld	a,#14
1872  02b9 25dd          	jrult	L157
1873                     ; 475 	                 Rx_Msg[Rx_Cnt].State  = 1;	
1875  02bb 42            	mul	x,a
1876  02bc a601          	ld	a,#1
1877  02be d7000d        	ld	(_Rx_Msg+13,x),a
1878                     ; 476 	                 Rx_Flag[filter_match_index] = TRUE;
1880  02c1 c60001        	ld	a,L756_filter_match_index
1881  02c4 5f            	clrw	x
1882  02c5 97            	ld	xl,a
1883  02c6 a601          	ld	a,#1
1884  02c8 d70000        	ld	(_Rx_Flag,x),a
1885                     ; 478 				    if((Rx_Msg[Rx_Cnt].stdid > 0x3ff)&&(Rx_Msg[Rx_Cnt].stdid < 0x500))
1887  02cb 7b04          	ld	a,(OFST+0,sp)
1888  02cd 97            	ld	xl,a
1889  02ce a60e          	ld	a,#14
1890  02d0 42            	mul	x,a
1891  02d1 9093          	ldw	y,x
1892  02d3 90de0000      	ldw	y,(_Rx_Msg,y)
1893  02d7 90a30400      	cpw	y,#1024
1894  02db 256b          	jrult	L167
1896  02dd 9093          	ldw	y,x
1897  02df 90de0000      	ldw	y,(_Rx_Msg,y)
1898  02e3 90a30500      	cpw	y,#1280
1899  02e7 245f          	jruge	L167
1900                     ; 480 							RXITcnt++;
1902  02e9 725c0000      	inc	_RXITcnt
1903                     ; 481 							if(RXITcnt > 4) RXITcnt = 0;
1905  02ed c60000        	ld	a,_RXITcnt
1906  02f0 a105          	cp	a,#5
1907  02f2 2504          	jrult	L367
1910  02f4 725f0000      	clr	_RXITcnt
1911  02f8               L367:
1912                     ; 482 							NM_CAN_DATA[RXITcnt].id = Rx_Msg[Rx_Cnt].stdid;
1914  02f8 de0000        	ldw	x,(_Rx_Msg,x)
1915  02fb 1f01          	ldw	(OFST-3,sp),x
1916  02fd c60000        	ld	a,_RXITcnt
1917  0300 97            	ld	xl,a
1918  0301 a60b          	ld	a,#11
1919  0303 42            	mul	x,a
1920  0304 1601          	ldw	y,(OFST-3,sp)
1921  0306 df0000        	ldw	(_NM_CAN_DATA,x),y
1922                     ; 483 							NM_CAN_DATA[RXITcnt].dlc = Rx_Msg[Rx_Cnt].dlc;
1924  0309 89            	pushw	x
1925  030a 7b06          	ld	a,(OFST+2,sp)
1926  030c 97            	ld	xl,a
1927  030d a60e          	ld	a,#14
1928  030f 42            	mul	x,a
1929  0310 d60004        	ld	a,(_Rx_Msg+4,x)
1930  0313 85            	popw	x
1931  0314 d70002        	ld	(_NM_CAN_DATA+2,x),a
1932                     ; 484 							for(RX_Data_Cnt = 0; RX_Data_Cnt < 8 ;RX_Data_Cnt++)
1934  0317 0f03          	clr	(OFST-1,sp)
1935  0319               L567:
1936                     ; 486 								NM_CAN_DATA[RXITcnt].Byte[RX_Data_Cnt]=Rx_Msg[Rx_Cnt].data[RX_Data_Cnt];
1938  0319 c60000        	ld	a,_RXITcnt
1939  031c 97            	ld	xl,a
1940  031d a60b          	ld	a,#11
1941  031f 42            	mul	x,a
1942  0320 01            	rrwa	x,a
1943  0321 1b03          	add	a,(OFST-1,sp)
1944  0323 2401          	jrnc	L06
1945  0325 5c            	incw	x
1946  0326               L06:
1947  0326 02            	rlwa	x,a
1948  0327 89            	pushw	x
1949  0328 7b06          	ld	a,(OFST+2,sp)
1950  032a 97            	ld	xl,a
1951  032b a60e          	ld	a,#14
1952  032d 42            	mul	x,a
1953  032e 01            	rrwa	x,a
1954  032f 1b05          	add	a,(OFST+1,sp)
1955  0331 2401          	jrnc	L26
1956  0333 5c            	incw	x
1957  0334               L26:
1958  0334 02            	rlwa	x,a
1959  0335 d60005        	ld	a,(_Rx_Msg+5,x)
1960  0338 85            	popw	x
1961  0339 d70003        	ld	(_NM_CAN_DATA+3,x),a
1962                     ; 484 							for(RX_Data_Cnt = 0; RX_Data_Cnt < 8 ;RX_Data_Cnt++)
1964  033c 0c03          	inc	(OFST-1,sp)
1967  033e 7b03          	ld	a,(OFST-1,sp)
1968  0340 a108          	cp	a,#8
1969  0342 25d5          	jrult	L567
1971  0344 acf003f0      	jra	L377
1972  0348               L167:
1973                     ; 490 					else if((Rx_Msg[Rx_Cnt].stdid > 0x6ff)&&(Rx_Msg[Rx_Cnt].stdid < 0x7ff))
1975  0348 9093          	ldw	y,x
1976  034a 90de0000      	ldw	y,(_Rx_Msg,y)
1977  034e 90a30700      	cpw	y,#1792
1978  0352 25f0          	jrult	L377
1980  0354 9093          	ldw	y,x
1981  0356 90de0000      	ldw	y,(_Rx_Msg,y)
1982  035a 90a307ff      	cpw	y,#2047
1983  035e 24e4          	jruge	L377
1984                     ; 492 					         if(Rx_Msg[Rx_Cnt].dlc != 8) return;  //数据长度不为8不响应 数据不存缓存
1986  0360 d60004        	ld	a,(_Rx_Msg+4,x)
1987  0363 a108          	cp	a,#8
1988  0365 2703          	jreq	L777
1992  0367 5b04          	addw	sp,#4
1993  0369 80            	iret	
1994  036a               L777:
1995                     ; 495 					         UDSRITcnt++;
1997  036a 725c0000      	inc	_UDSRITcnt
1998                     ; 496 						  if(UDSRITcnt >= Reclong)UDSRITcnt = 0;
2000  036e c60000        	ld	a,_UDSRITcnt
2001  0371 a105          	cp	a,#5
2002  0373 2504          	jrult	L1001
2005  0375 725f0000      	clr	_UDSRITcnt
2006  0379               L1001:
2007                     ; 498 					         RecData[UDSRITcnt].AI = Rx_Msg[Rx_Cnt].stdid;
2009  0379 de0000        	ldw	x,(_Rx_Msg,x)
2010  037c 1f01          	ldw	(OFST-3,sp),x
2011  037e c60000        	ld	a,_UDSRITcnt
2012  0381 97            	ld	xl,a
2013  0382 a60a          	ld	a,#10
2014  0384 42            	mul	x,a
2015  0385 1601          	ldw	y,(OFST-3,sp)
2016  0387 df0000        	ldw	(_RecData,x),y
2017                     ; 499 						  RecData[UDSRITcnt].PCI= Rx_Msg[Rx_Cnt].data[0];
2019  038a 89            	pushw	x
2020  038b 7b06          	ld	a,(OFST+2,sp)
2021  038d 97            	ld	xl,a
2022  038e a60e          	ld	a,#14
2023  0390 42            	mul	x,a
2024  0391 d60005        	ld	a,(_Rx_Msg+5,x)
2025  0394 85            	popw	x
2026  0395 d70002        	ld	(_RecData+2,x),a
2027                     ; 501   						  for(RX_Data_Cnt = 0; RX_Data_Cnt < 7 ;RX_Data_Cnt++)
2029  0398 0f03          	clr	(OFST-1,sp)
2030  039a               L3001:
2031                     ; 503   							  RecData[UDSRITcnt].Data[RX_Data_Cnt]=Rx_Msg[Rx_Cnt].data[RX_Data_Cnt+1];
2033  039a c60000        	ld	a,_UDSRITcnt
2034  039d 97            	ld	xl,a
2035  039e a60a          	ld	a,#10
2036  03a0 42            	mul	x,a
2037  03a1 01            	rrwa	x,a
2038  03a2 1b03          	add	a,(OFST-1,sp)
2039  03a4 2401          	jrnc	L46
2040  03a6 5c            	incw	x
2041  03a7               L46:
2042  03a7 02            	rlwa	x,a
2043  03a8 89            	pushw	x
2044  03a9 7b06          	ld	a,(OFST+2,sp)
2045  03ab 97            	ld	xl,a
2046  03ac a60e          	ld	a,#14
2047  03ae 42            	mul	x,a
2048  03af 01            	rrwa	x,a
2049  03b0 1b05          	add	a,(OFST+1,sp)
2050  03b2 2401          	jrnc	L66
2051  03b4 5c            	incw	x
2052  03b5               L66:
2053  03b5 02            	rlwa	x,a
2054  03b6 d60006        	ld	a,(_Rx_Msg+6,x)
2055  03b9 85            	popw	x
2056  03ba d70003        	ld	(_RecData+3,x),a
2057                     ; 501   						  for(RX_Data_Cnt = 0; RX_Data_Cnt < 7 ;RX_Data_Cnt++)
2059  03bd 0c03          	inc	(OFST-1,sp)
2062  03bf 7b03          	ld	a,(OFST-1,sp)
2063  03c1 a107          	cp	a,#7
2064  03c3 25d5          	jrult	L3001
2065                     ; 523 						  Rx_Msg[Rx_Cnt].stdid = 0;
2067  03c5 7b04          	ld	a,(OFST+0,sp)
2068  03c7 97            	ld	xl,a
2069  03c8 a60e          	ld	a,#14
2070  03ca 42            	mul	x,a
2071  03cb 905f          	clrw	y
2072  03cd df0000        	ldw	(_Rx_Msg,x),y
2073                     ; 524 						  Rx_Msg[Rx_Cnt].data[0] = 0;
2075  03d0 724f0005      	clr	(_Rx_Msg+5,x)
2076                     ; 525 						  Rx_Msg[Rx_Cnt].data[1] = 0;
2078  03d4 724f0006      	clr	(_Rx_Msg+6,x)
2079                     ; 526 						  Rx_Msg[Rx_Cnt].data[2] = 0;
2081  03d8 724f0007      	clr	(_Rx_Msg+7,x)
2082                     ; 527 						  Rx_Msg[Rx_Cnt].data[3] = 0;
2084  03dc 724f0008      	clr	(_Rx_Msg+8,x)
2085                     ; 528 						  Rx_Msg[Rx_Cnt].data[4] = 0;
2087  03e0 724f0009      	clr	(_Rx_Msg+9,x)
2088                     ; 529 						  Rx_Msg[Rx_Cnt].data[5] = 0;
2090  03e4 724f000a      	clr	(_Rx_Msg+10,x)
2091                     ; 530 						  Rx_Msg[Rx_Cnt].data[6] = 0;
2093  03e8 724f000b      	clr	(_Rx_Msg+11,x)
2094                     ; 531 						  Rx_Msg[Rx_Cnt].data[7] = 0;
2096  03ec 724f000c      	clr	(_Rx_Msg+12,x)
2097  03f0               L377:
2098                     ; 536 	                 switch(Rx_Msg[Rx_Cnt].stdid)
2100  03f0 7b04          	ld	a,(OFST+0,sp)
2101  03f2 97            	ld	xl,a
2102  03f3 a60e          	ld	a,#14
2103  03f5 42            	mul	x,a
2104  03f6 de0000        	ldw	x,(_Rx_Msg,x)
2106                     ; 542 						 default:break;
2107  03f9 1d0255        	subw	x,#597
2108  03fc 2707          	jreq	L566
2109  03fe 1d001b        	subw	x,#27
2110  0401 2708          	jreq	L766
2111  0403 200a          	jra	L3101
2112  0405               L566:
2113                     ; 538 	                     case 0x255:gDectID_EMS_255_Flag = 1;
2115  0405 35010000      	mov	_gDectID_EMS_255_Flag,#1
2116                     ; 539 						 	break;
2118  0409 2004          	jra	L3101
2119  040b               L766:
2120                     ; 540 						 case 0x270:gDectID_IP_270_Flag = 1;
2122  040b 35010000      	mov	_gDectID_IP_270_Flag,#1
2123                     ; 541 						 	break;
2125                     ; 542 						 default:break;
2127  040f               L3101:
2128                     ; 545 	                 CAN_RFR |= CRFR_RFOM;		// Release mailbox       	
2130  040f 721a5424      	bset	_CAN_RFR,#5
2131                     ; 546 	                 break;           
2133  0413 200c          	jra	L547
2134  0415               L747:
2135                     ; 463 	        for(Rx_Cnt = 0 ; Rx_Cnt < 10 ; Rx_Cnt ++ )
2137  0415 0c04          	inc	(OFST+0,sp)
2140  0417 7b04          	ld	a,(OFST+0,sp)
2141  0419 a10a          	cp	a,#10
2142  041b 2404ac680268  	jrult	L147
2143  0421               L547:
2144                     ; 552 	CAN_RFR |= CRFR_RFOM;		// Release mailbox       	
2146  0421 721a5424      	bset	_CAN_RFR,#5
2147  0425               L727:
2148                     ; 436 	while (CAN_RFR & CRFR_FMP01)	/* Check until FMP != 0 */
2150  0425 c65424        	ld	a,_CAN_RFR
2151  0428 a503          	bcp	a,#3
2152  042a 2704acf401f4  	jrne	L527
2153                     ; 554 	CanRestorePg();
2155  0430 5500005427    	mov	_CAN_FPSR,_Can_Page
2156                     ; 560 }
2159  0435 5b04          	addw	sp,#4
2160  0437 80            	iret	
2192                     ; 572 @interrupt void CAN_TX_IRQHandler (void)
2192                     ; 573 {
2193                     	switch	.text
2194  0438               f_CAN_TX_IRQHandler:
2197  0438 3b0002        	push	c_x+2
2198  043b be00          	ldw	x,c_x
2199  043d 89            	pushw	x
2200  043e 3b0002        	push	c_y+2
2201  0441 be00          	ldw	x,c_y
2202  0443 89            	pushw	x
2205                     ; 574 	CanSavePg();
2207  0444 5554270000    	mov	_Can_Page,_CAN_FPSR
2208                     ; 582 	CAN_MCSR &= 0xf7;
2210  0449 72175428      	bres	_CAN_MCSR,#3
2211                     ; 584 	if (CAN_MSR & CMSR_ERRI)	/* If Error Interrupt */
2213  044d 7205542110    	btjf	_CAN_MSR,#2,L5201
2214                     ; 586 		CAN_MSR = CMSR_ERRI;	/* then clear this bit */
2216  0452 35045421      	mov	_CAN_MSR,#4
2217                     ; 588 		Busoffstate = 2;
2219  0456 35020000      	mov	_Busoffstate,#2
2220                     ; 589 		cansendbusoff = 1;
2222  045a 35010000      	mov	_cansendbusoff,#1
2223                     ; 590 		busofftimecnt=0;
2225  045e 5f            	clrw	x
2226  045f cf0000        	ldw	_busofftimecnt,x
2227  0462               L5201:
2228                     ; 593 	if (CAN_MSR & CMSR_WKUI)	/* If Wake-Up Interrupt */
2230  0462 720754210c    	btjf	_CAN_MSR,#3,L7201
2231                     ; 595 		CAN_MSR = CMSR_WKUI;	/* then clear this bit */
2233  0467 35085421      	mov	_CAN_MSR,#8
2234                     ; 597 		gLocalWakeupFlag = 1;
2236  046b 35010000      	mov	_gLocalWakeupFlag,#1
2237                     ; 598 		WakeUp();
2239  046f 8d000000      	callf	f_WakeUp
2241  0473               L7201:
2242                     ; 604 	if(CAN_ESR & 0x04)
2244  0473 7205542812    	btjf	_CAN_ESR,#2,L1301
2245                     ; 606               CAN_ESR &= 0xff;  
2247  0478 c65428        	ld	a,_CAN_ESR
2248  047b c75428        	ld	_CAN_ESR,a
2249                     ; 609 		busofftimecnt = 0;
2251                     ; 610 		Busoffstate = 2;
2253  047e 35020000      	mov	_Busoffstate,#2
2254                     ; 611 		cansendbusoff = 1;
2256  0482 35010000      	mov	_cansendbusoff,#1
2257                     ; 612 		busofftimecnt=0;
2259  0486 5f            	clrw	x
2260  0487 cf0000        	ldw	_busofftimecnt,x
2261  048a               L1301:
2262                     ; 618 	CAN_MCSR |= MCSR_RQCP;		/* Clear status bits */
2264  048a 72145428      	bset	_CAN_MCSR,#2
2265                     ; 622 	CanRestorePg();
2267  048e 5500005427    	mov	_CAN_FPSR,_Can_Page
2268                     ; 623 }
2271  0493 85            	popw	x
2272  0494 bf00          	ldw	c_y,x
2273  0496 320002        	pop	c_y+2
2274  0499 85            	popw	x
2275  049a bf00          	ldw	c_x,x
2276  049c 320002        	pop	c_x+2
2277  049f 80            	iret	
2299                     ; 635 @interrupt void SPI_IRQHandler (void)
2299                     ; 636 {
2300                     	switch	.text
2301  04a0               f_SPI_IRQHandler:
2306                     ; 640   return;
2309  04a0 80            	iret	
2332                     ; 653 @interrupt void TIM1_UPD_OVF_TRG_BRK_IRQHandler (void)
2332                     ; 654 {
2333                     	switch	.text
2334  04a1               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
2339                     ; 658   return;
2342  04a1 80            	iret	
2365                     ; 671 @interrupt void TIM1_CAP_COM_IRQHandler (void)
2365                     ; 672 {
2366                     	switch	.text
2367  04a2               f_TIM1_CAP_COM_IRQHandler:
2372                     ; 676   return;
2375  04a2 80            	iret	
2399                     ; 689 @interrupt void TIM2_UPD_OVF_BRK_IRQHandler (void)
2399                     ; 690 {
2400                     	switch	.text
2401  04a3               f_TIM2_UPD_OVF_BRK_IRQHandler:
2404  04a3 3b0002        	push	c_x+2
2405  04a6 be00          	ldw	x,c_x
2406  04a8 89            	pushw	x
2407  04a9 3b0002        	push	c_y+2
2408  04ac be00          	ldw	x,c_y
2409  04ae 89            	pushw	x
2412                     ; 693 	TIM2_Clear_IT_Flag(UIF);
2414  04af a601          	ld	a,#1
2415  04b1 8d000000      	callf	f_TIM2_Clear_IT_Flag
2417                     ; 694 }
2420  04b5 85            	popw	x
2421  04b6 bf00          	ldw	c_y,x
2422  04b8 320002        	pop	c_y+2
2423  04bb 85            	popw	x
2424  04bc bf00          	ldw	c_x,x
2425  04be 320002        	pop	c_x+2
2426  04c1 80            	iret	
2450                     ; 706 @interrupt void TIM2_CAP_COM_IRQHandler (void)
2450                     ; 707 {
2451                     	switch	.text
2452  04c2               f_TIM2_CAP_COM_IRQHandler:
2455  04c2 3b0002        	push	c_x+2
2456  04c5 be00          	ldw	x,c_x
2457  04c7 89            	pushw	x
2458  04c8 3b0002        	push	c_y+2
2459  04cb be00          	ldw	x,c_y
2460  04cd 89            	pushw	x
2463                     ; 709 	TIM2_Clear_IT_Flag(CC3IF|CC2IF|CC1IF);
2465  04ce a60e          	ld	a,#14
2466  04d0 8d000000      	callf	f_TIM2_Clear_IT_Flag
2468                     ; 710 }
2471  04d4 85            	popw	x
2472  04d5 bf00          	ldw	c_y,x
2473  04d7 320002        	pop	c_y+2
2474  04da 85            	popw	x
2475  04db bf00          	ldw	c_x,x
2476  04dd 320002        	pop	c_x+2
2477  04e0 80            	iret	
2502                     ; 722 @interrupt void TIM3_UPD_OVF_BRK_IRQHandler (void)
2502                     ; 723 {
2503                     	switch	.text
2504  04e1               f_TIM3_UPD_OVF_BRK_IRQHandler:
2507  04e1 3b0002        	push	c_x+2
2508  04e4 be00          	ldw	x,c_x
2509  04e6 89            	pushw	x
2510  04e7 3b0002        	push	c_y+2
2511  04ea be00          	ldw	x,c_y
2512  04ec 89            	pushw	x
2515                     ; 724 	TIM3_Clear_IT_Flag(UIF);
2517  04ed a601          	ld	a,#1
2518  04ef 8d000000      	callf	f_TIM3_Clear_IT_Flag
2520                     ; 726 	RKE_RECEIVE_RESET();
2522  04f3 8d000000      	callf	f_RKE_RECEIVE_RESET
2524                     ; 735 }   
2527  04f7 85            	popw	x
2528  04f8 bf00          	ldw	c_y,x
2529  04fa 320002        	pop	c_y+2
2530  04fd 85            	popw	x
2531  04fe bf00          	ldw	c_x,x
2532  0500 320002        	pop	c_x+2
2533  0503 80            	iret	
2586                     ; 747 @interrupt void TIM3_CAP_COM_IRQHandler (void)
2586                     ; 748 {
2587                     	switch	.text
2588  0504               f_TIM3_CAP_COM_IRQHandler:
2591       00000002      OFST:	set	2
2592  0504 3b0002        	push	c_x+2
2593  0507 be00          	ldw	x,c_x
2594  0509 89            	pushw	x
2595  050a 3b0002        	push	c_y+2
2596  050d be00          	ldw	x,c_y
2597  050f 89            	pushw	x
2598  0510 89            	pushw	x
2601                     ; 754     if (!(TIM3->SR1 & CC1IF))
2603  0511 a60e          	ld	a,#14
2604  0513 7202532208    	btjt	21282,#1,L3411
2605                     ; 756 		TIM3_Clear_IT_Flag(CC3IF|CC2IF|CC1IF);
2607  0518 8d000000      	callf	f_TIM3_Clear_IT_Flag
2609                     ; 757 		return;
2611  051c ac000600      	jra	L7411
2612  0520               L3411:
2613                     ; 760 	TIM3_Clear_IT_Flag(CC3IF|CC2IF|CC1IF);
2615  0520 8d000000      	callf	f_TIM3_Clear_IT_Flag
2617                     ; 762     switch (RKE_STEP)
2619  0524 c60000        	ld	a,_RKE_STEP
2621                     ; 826     	}break;
2622  0527 2712          	jreq	L3111
2623  0529 4a            	dec	a
2624  052a 2717          	jreq	L5111
2625  052c 4a            	dec	a
2626  052d 2604acfa05fa  	jreq	L7111
2627                     ; 825 			RKE_RECEIVE_RESET();
2629  0533 8d000000      	callf	f_RKE_RECEIVE_RESET
2631                     ; 826     	}break;
2633  0537 ac000600      	jra	L7411
2634  053b               L3111:
2635                     ; 766     		RKE_RECEIVE_RESET();
2637  053b 8d000000      	callf	f_RKE_RECEIVE_RESET
2639                     ; 767     	}break;
2641  053f ac000600      	jra	L7411
2642  0543               L5111:
2643                     ; 771 			TIM3_OCINT_DISABLE;
2645  0543 a606          	ld	a,#6
2646  0545 8d000000      	callf	f_TIM3_Disable_IT
2648                     ; 772  			ENABLE_RX_INT;
2650  0549 72145013      	bset	20499,#2
2651                     ; 774     		i = bitCnt / 16;
2654  054d c60007        	ld	a,_bitCnt
2655  0550 4e            	swap	a
2656  0551 a40f          	and	a,#15
2657  0553 6b02          	ld	(OFST+0,sp),a
2658                     ; 777     		if (RKE_DATA_IN)	
2660  0555 5f            	clrw	x
2661  0556 97            	ld	xl,a
2662  0557 58            	sllw	x
2663  0558 90ae0001      	ldw	y,#1
2664  055c c60007        	ld	a,_bitCnt
2665  055f a40f          	and	a,#15
2666  0561 720550101b    	btjf	20496,#2,L1511
2667                     ; 779 	    		RKE_FIFO_DATA[i] |= (1 << (bitCnt % 16));
2669  0566 2705          	jreq	L231
2670  0568               L431:
2671  0568 9058          	sllw	y
2672  056a 4a            	dec	a
2673  056b 26fb          	jrne	L431
2674  056d               L231:
2675  056d 9001          	rrwa	y,a
2676  056f da0001        	or	a,(_RKE_FIFO_DATA+1,x)
2677  0572 9001          	rrwa	y,a
2678  0574 da0000        	or	a,(_RKE_FIFO_DATA,x)
2679  0577 9001          	rrwa	y,a
2680  0579 df0000        	ldw	(_RKE_FIFO_DATA,x),y
2681                     ; 780 	    		FALL_EDGE_INT;	//falling edge 
2683  057c ae0002        	ldw	x,#2
2686  057f 201b          	jra	L3511
2687  0581               L1511:
2688                     ; 784  				RKE_FIFO_DATA[i] &= ~(1 << (bitCnt % 16));
2690  0581 2705          	jreq	L041
2691  0583               L241:
2692  0583 9058          	sllw	y
2693  0585 4a            	dec	a
2694  0586 26fb          	jrne	L241
2695  0588               L041:
2696  0588 9053          	cplw	y
2697  058a 9001          	rrwa	y,a
2698  058c d40001        	and	a,(_RKE_FIFO_DATA+1,x)
2699  058f 9001          	rrwa	y,a
2700  0591 d40000        	and	a,(_RKE_FIFO_DATA,x)
2701  0594 9001          	rrwa	y,a
2702  0596 df0000        	ldw	(_RKE_FIFO_DATA,x),y
2703                     ; 785  				RISE_EDGE_INT;	//rising edge
2705  0599 ae0001        	ldw	x,#1
2707  059c               L3511:
2708  059c a603          	ld	a,#3
2709  059e 95            	ld	xh,a
2710  059f 8d000000      	callf	f_EXTI_SetExtIntSensitivity
2711                     ; 789  			if (bitCnt == 7)
2713  05a3 c60007        	ld	a,_bitCnt
2714  05a6 a107          	cp	a,#7
2715  05a8 2615          	jrne	L5511
2716                     ; 791  			    tempMode = (RKE_FIFO_DATA[0] & MODE_MASK);
2718  05aa c60001        	ld	a,_RKE_FIFO_DATA+1
2719  05ad 6b01          	ld	(OFST-1,sp),a
2720                     ; 792  			    if ((tempMode != LEARN_MODE) && (tempMode != NORMAL_MODE) && (tempMode != CLOSE_WIN_MODE))
2722  05af a1a5          	cp	a,#165
2723  05b1 270c          	jreq	L5511
2725  05b3 a1d2          	cp	a,#210
2726  05b5 2708          	jreq	L5511
2728  05b7 a169          	cp	a,#105
2729  05b9 2704          	jreq	L5511
2730                     ; 795  			        RKE_RECEIVE_RESET();
2732  05bb 8d000000      	callf	f_RKE_RECEIVE_RESET
2734  05bf               L5511:
2735                     ; 799 			if (++bitCnt >= 80)
2737  05bf 725c0007      	inc	_bitCnt
2738  05c3 c60007        	ld	a,_bitCnt
2739  05c6 a150          	cp	a,#80
2740  05c8 2536          	jrult	L7411
2741                     ; 801 				DISABLE_RX_INT;
2743  05ca 72155013      	bres	20499,#2
2744                     ; 802 				TIM3_OCINT_DISABLE;
2747  05ce a606          	ld	a,#6
2748  05d0 8d000000      	callf	f_TIM3_Disable_IT
2750                     ; 804 				CheckSum = 0;
2752  05d4 0f01          	clr	(OFST-1,sp)
2753                     ; 805                 for (i=0;i<10;i++)
2755  05d6 4f            	clr	a
2756  05d7 6b02          	ld	(OFST+0,sp),a
2757  05d9               L3611:
2758                     ; 806 				    CheckSum ^= *((uchar*)RKE_FIFO_DATA + i);
2760  05d9 5f            	clrw	x
2761  05da 97            	ld	xl,a
2762  05db 7b01          	ld	a,(OFST-1,sp)
2763  05dd d80000        	xor	a,(_RKE_FIFO_DATA,x)
2764  05e0 6b01          	ld	(OFST-1,sp),a
2765                     ; 805                 for (i=0;i<10;i++)
2767  05e2 0c02          	inc	(OFST+0,sp)
2770  05e4 7b02          	ld	a,(OFST+0,sp)
2771  05e6 a10a          	cp	a,#10
2772  05e8 25ef          	jrult	L3611
2773                     ; 807                 if (CheckSum)
2775  05ea 7b01          	ld	a,(OFST-1,sp)
2776  05ec 2706          	jreq	L1711
2777                     ; 809                 	RKE_RECEIVE_RESET();
2779  05ee 8d000000      	callf	f_RKE_RECEIVE_RESET
2782  05f2 200c          	jra	L7411
2783  05f4               L1711:
2784                     ; 813 				    RKE_STEP = RKE_RecFinished;
2786  05f4 35020000      	mov	_RKE_STEP,#2
2787  05f8 2006          	jra	L7411
2788  05fa               L7111:
2789                     ; 820     		TIM3_OCINT_DISABLE;
2791  05fa a606          	ld	a,#6
2792  05fc 8d000000      	callf	f_TIM3_Disable_IT
2794                     ; 821         }break;
2796  0600               L7411:
2797                     ; 828 }
2800  0600 5b02          	addw	sp,#2
2801  0602 85            	popw	x
2802  0603 bf00          	ldw	c_y,x
2803  0605 320002        	pop	c_y+2
2804  0608 85            	popw	x
2805  0609 bf00          	ldw	c_x,x
2806  060b 320002        	pop	c_x+2
2807  060e 80            	iret	
2830                     ; 840 @interrupt void USART_TX_IRQHandler (void)
2830                     ; 841 {
2831                     	switch	.text
2832  060f               f_USART_TX_IRQHandler:
2837                     ; 843   return;
2840  060f 80            	iret	
2863                     ; 856 @interrupt void USART_RX_IRQHandler (void)
2863                     ; 857 {
2864                     	switch	.text
2865  0610               f_USART_RX_IRQHandler:
2870                     ; 859   return;
2873  0610 80            	iret	
2895                     ; 872 @interrupt void I2C_IRQHandler (void)
2895                     ; 873 {
2896                     	switch	.text
2897  0611               f_I2C_IRQHandler:
2902                     ; 878   return;
2905  0611 80            	iret	
2928                     ; 891 @interrupt void LINUART_TX_IRQHandler (void)
2928                     ; 892 {
2929                     	switch	.text
2930  0612               f_LINUART_TX_IRQHandler:
2935                     ; 938 }
2938  0612 80            	iret	
2961                     ; 950 @interrupt void LINUART_RX_IRQHandler (void)
2961                     ; 951 {
2962                     	switch	.text
2963  0613               f_LINUART_RX_IRQHandler:
2968                     ; 1004 }
2971  0613 80            	iret	
2993                     ; 1016 @interrupt void ADC_IRQHandler (void)
2993                     ; 1017 {
2994                     	switch	.text
2995  0614               f_ADC_IRQHandler:
3000                     ; 1021   return;
3003  0614 80            	iret	
3005                     	switch	.bss
3006  0002               L1621_temp2:
3007  0002 00            	ds.b	1
3008  0003               L7521_temp1:
3009  0003 00            	ds.b	1
3010  0004               L5521_temp:
3011  0004 00            	ds.b	1
3062                     ; 1034 @interrupt void TIM4_UPD_OVF_IRQHandler (void)
3062                     ; 1035 {
3063                     	switch	.text
3064  0615               f_TIM4_UPD_OVF_IRQHandler:
3067  0615 3b0002        	push	c_x+2
3068  0618 be00          	ldw	x,c_x
3069  061a 89            	pushw	x
3070  061b 3b0002        	push	c_y+2
3071  061e be00          	ldw	x,c_y
3072  0620 89            	pushw	x
3075                     ; 1038   	TIM4_Clear_Int_Flag();
3077  0621 8d000000      	callf	f_TIM4_Clear_Int_Flag
3079                     ; 1041     ADCerrorCnt++;
3081  0625 725c0000      	inc	_ADCerrorCnt
3082                     ; 1043     gTimeOskeBase++;
3084  0629 ce0000        	ldw	x,_gTimeOskeBase
3085  062c 5c            	incw	x
3086  062d cf0000        	ldw	_gTimeOskeBase,x
3087                     ; 1045     if (++temp1 >= 2)
3089  0630 725c0003      	inc	L7521_temp1
3090  0634 c60003        	ld	a,L7521_temp1
3091  0637 a102          	cp	a,#2
3092  0639 2508          	jrult	L5031
3093                     ; 1047 	    SysTimeFlag_2MS = TRUE;  	//every 8ms interrupt
3095  063b 35010000      	mov	_SysTimeFlag_2MS,#1
3096                     ; 1049 	    temp1 = 0;
3098  063f 725f0003      	clr	L7521_temp1
3099  0643               L5031:
3100                     ; 1051     if(++temp2 >= 4)
3102  0643 725c0002      	inc	L1621_temp2
3103  0647 c60002        	ld	a,L1621_temp2
3104  064a a104          	cp	a,#4
3105  064c 2508          	jrult	L7031
3106                     ; 1053    	     NM_Function_Main(); 
3108  064e 8d000000      	callf	f_NM_Function_Main
3110                     ; 1054 		     temp2 = 0;
3112  0652 725f0002      	clr	L1621_temp2
3113  0656               L7031:
3114                     ; 1058     if (++temp >= 8)
3116  0656 725c0004      	inc	L5521_temp
3117  065a c60004        	ld	a,L5521_temp
3118  065d a108          	cp	a,#8
3119  065f 2508          	jrult	L1131
3120                     ; 1060 	    SysTimeFlag_8MS = TRUE;  	//every 8ms interrupt
3122  0661 35010000      	mov	_SysTimeFlag_8MS,#1
3123                     ; 1061 	    temp = 0;
3125  0665 725f0004      	clr	L5521_temp
3126  0669               L1131:
3127                     ; 1064 }
3130  0669 85            	popw	x
3131  066a bf00          	ldw	c_y,x
3132  066c 320002        	pop	c_y+2
3133  066f 85            	popw	x
3134  0670 bf00          	ldw	c_x,x
3135  0672 320002        	pop	c_x+2
3136  0675 80            	iret	
3159                     ; 1076 @interrupt void EEPROM_EEC_IRQHandler (void)
3159                     ; 1077 {
3160                     	switch	.text
3161  0676               f_EEPROM_EEC_IRQHandler:
3166                     ; 1081   return;
3169  0676 80            	iret	
3204                     	switch	.bss
3205  0005               _Tim3CntTemp:
3206  0005 0000          	ds.b	2
3207                     	xdef	_Tim3CntTemp
3208                     	xref	_NM_CAN_DATA
3209                     	xref	_WaveFilterCnt
3210  0007               _bitCnt:
3211  0007 00            	ds.b	1
3212                     	xdef	_bitCnt
3213                     	xref	_UDSRITcnt
3214                     	xref	_RecData
3215                     	xref	_sjs
3216                     	xref	f_TIM4_Clear_Int_Flag
3217                     	xref	_busofftimecnt
3218                     	xref	_Busoffstate
3219                     	xref	_RXITcnt
3220                     	xref	_cansendbusoff
3221                     	xref	_Rx_Msg
3222                     	xref	_Rx_Flag
3223                     	xref	_Can_Page
3224                     	xref	f_RKE_RECEIVE_RESET
3225                     	xref	_RKE_outtime
3226                     	xref	_RKE_DATA_OK
3227                     	xref	_RKE_FIFO_DATA
3228                     	xref	_RKE_STEP
3229                     	xref	_B_Code
3230                     	xref	_A_Code
3231                     	xref	_Header
3232                     	xref	_ADCerrorCnt
3233                     	xref	f_WakeUp
3234                     	xref	_WakeState
3235                     	xref	_SysTimeFlag_8MS
3236                     	xref	_SysTimeFlag_2MS
3237                     	xref	f_NM_Function_Main
3238                     	xref	_gDectID_IP_270_Flag
3239                     	xref	_gDectID_EMS_255_Flag
3240                     	xref	_gNMCanBusOff
3241                     	xref	_gLocalWakeupFlag
3242                     	xref	_gTimeOskeBase
3243  0008               _canrextime:
3244  0008 00            	ds.b	1
3245                     	xdef	_canrextime
3246                     	xdef	f_TRAP_IRQHandler
3247                     	xdef	f_TLI_IRQHandler
3248                     	xdef	f_AWU_IRQHandler
3249                     	xdef	f_CLK_IRQHandler
3250                     	xdef	f_EXTI_PORTA_IRQHandler
3251                     	xdef	f_EXTI_PORTB_IRQHandler
3252                     	xdef	f_EXTI_PORTC_IRQHandler
3253                     	xdef	f_EXTI_PORTD_IRQHandler
3254                     	xdef	f_EXTI_PORTE_IRQHandler
3255                     	xdef	f_CAN_RX_IRQHandler
3256                     	xdef	f_CAN_TX_IRQHandler
3257                     	xdef	f_SPI_IRQHandler
3258                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
3259                     	xdef	f_TIM1_CAP_COM_IRQHandler
3260                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
3261                     	xdef	f_TIM2_CAP_COM_IRQHandler
3262                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
3263                     	xdef	f_TIM3_CAP_COM_IRQHandler
3264                     	xdef	f_USART_TX_IRQHandler
3265                     	xdef	f_USART_RX_IRQHandler
3266                     	xdef	f_I2C_IRQHandler
3267                     	xdef	f_LINUART_TX_IRQHandler
3268                     	xdef	f_LINUART_RX_IRQHandler
3269                     	xdef	f_ADC_IRQHandler
3270                     	xdef	f_TIM4_UPD_OVF_IRQHandler
3271                     	xdef	f_EEPROM_EEC_IRQHandler
3272                     	xdef	f_NonHandledInterrupt
3273                     	xref	f_TIM3_Disable_IT
3274                     	xref	f_TIM3_Clear_IT_Flag
3275                     	xref	f_TIM2_Clear_IT_Flag
3276                     	xref	f_EXTI_SetExtIntSensitivity
3277                     	xref.b	c_x
3278                     	xref.b	c_y
3298                     	end
