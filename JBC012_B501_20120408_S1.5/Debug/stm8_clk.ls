   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 776                     .const:	section	.text
 777  0000               _HSIDivFactor:
 778  0000 01            	dc.b	1
 779  0001 02            	dc.b	2
 780  0002 04            	dc.b	4
 781  0003 08            	dc.b	8
 782  0004               _CLKPrescTable:
 783  0004 01            	dc.b	1
 784  0005 02            	dc.b	2
 785  0006 04            	dc.b	4
 786  0007 08            	dc.b	8
 787  0008 0a            	dc.b	10
 788  0009 10            	dc.b	16
 789  000a 14            	dc.b	20
 790  000b 28            	dc.b	40
 819                     ; 83 void CLK_DeInit(void)
 819                     ; 84 {
 820                     	switch	.text
 821  0000               f_CLK_DeInit:
 825                     ; 86   CLK->ICKR = CLK_ICKR_RESET_VALUE;
 827  0000 350150c0      	mov	20672,#1
 828                     ; 87   CLK->ECKR = CLK_ECKR_RESET_VALUE;
 830  0004 725f50c1      	clr	20673
 831                     ; 88   CLK->SWR  = CLK_SWR_RESET_VALUE;
 833  0008 35e150c4      	mov	20676,#225
 834                     ; 89   CLK->SWCR = CLK_SWCR_RESET_VALUE;
 836  000c 725f50c5      	clr	20677
 837                     ; 90   CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
 839  0010 351850c6      	mov	20678,#24
 840                     ; 91   CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
 842  0014 35ff50c7      	mov	20679,#255
 843                     ; 92   CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
 845  0018 35ff50ca      	mov	20682,#255
 846                     ; 93   CLK->CSSR = CLK_CSSR_RESET_VALUE;
 848  001c 725f50c8      	clr	20680
 849                     ; 94   CLK->CCOR = CLK_CCOR_RESET_VALUE;
 851  0020 725f50c9      	clr	20681
 853  0024               L554:
 854                     ; 95   while(CLK->CCOR & CLK_CCOR_CCOEN);
 856  0024 720050c9fb    	btjt	20681,#0,L554
 857                     ; 96   CLK->CCOR = CLK_CCOR_RESET_VALUE;
 859  0029 725f50c9      	clr	20681
 860                     ; 97   CLK->CANCCR = CLK_CANCCR_RESET_VALUE;
 862  002d 725f50cb      	clr	20683
 863                     ; 98   CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 865  0031 725f50cc      	clr	20684
 866                     ; 99   CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 868  0035 725f50cd      	clr	20685
 869                     ; 101 }
 872  0039 87            	retf	
1169                     ; 117 void CLK_StructInit(CLK_Init_TypeDef* CLK_InitStruct)
1169                     ; 118 {
1170                     	switch	.text
1171  003a               f_CLK_StructInit:
1175                     ; 121   CLK_InitStruct->CLK_FastHaltWakeup              = DISABLE;
1177  003a 7f            	clr	(x)
1178                     ; 124   CLK_InitStruct->CLK_HSIPrescaler                = CLK_PRESCALER_HSIDIV8;
1180  003b a618          	ld	a,#24
1181  003d e701          	ld	(1,x),a
1182                     ; 127   CLK_InitStruct->CLK_SwitchMode       = CLK_SWITCHMODE_AUTO;
1184  003f a601          	ld	a,#1
1185  0041 e702          	ld	(2,x),a
1186                     ; 130   CLK_InitStruct->CLK_NewClock         = CLK_SOURCE_HSI;
1188  0043 a6e1          	ld	a,#225
1189  0045 e703          	ld	(3,x),a
1190                     ; 133   CLK_InitStruct->CLK_SwitchIT         = DISABLE;
1192  0047 6f04          	clr	(4,x)
1193                     ; 136   CLK_InitStruct->CLK_CurrentClockState           = CLK_CURRENTCLOCKSTATE_ENABLE;
1195  0049 a601          	ld	a,#1
1196  004b e705          	ld	(5,x),a
1197                     ; 138 }
1200  004d 87            	retf	
1270                     ; 159 ErrorStatus CLK_Init(CLK_Init_TypeDef* CLK_InitStruct)
1270                     ; 160 {
1271                     	switch	.text
1272  004e               f_CLK_Init:
1274  004e 89            	pushw	x
1275  004f 88            	push	a
1276       00000001      OFST:	set	1
1279                     ; 161   ErrorStatus Status = ERROR;
1281  0050 0f01          	clr	(OFST+0,sp)
1282                     ; 164   assert_param(IS_CLK_SOURCE_OK(CLK_InitStruct->CLK_NewClock));
1284  0052 e603          	ld	a,(3,x)
1285  0054 a1e1          	cp	a,#225
1286  0056 2714          	jreq	L61
1287  0058 a1d2          	cp	a,#210
1288  005a 2710          	jreq	L61
1289  005c a1b4          	cp	a,#180
1290  005e 270c          	jreq	L61
1291  0060 ae00a4        	ldw	x,#164
1292  0063 89            	pushw	x
1293  0064 ae000c        	ldw	x,#L766
1294  0067 8d000000      	callf	f_assert_failed
1296  006b 85            	popw	x
1297  006c               L61:
1298                     ; 165   assert_param(IS_CLK_SWITCHMODE_OK(CLK_InitStruct->CLK_SwitchMode));
1300  006c 1e02          	ldw	x,(OFST+1,sp)
1301  006e e602          	ld	a,(2,x)
1302  0070 2711          	jreq	L62
1303  0072 4a            	dec	a
1304  0073 270e          	jreq	L62
1305  0075 ae00a5        	ldw	x,#165
1306  0078 89            	pushw	x
1307  0079 ae000c        	ldw	x,#L766
1308  007c 8d000000      	callf	f_assert_failed
1310  0080 85            	popw	x
1311  0081 1e02          	ldw	x,(OFST+1,sp)
1312  0083               L62:
1313                     ; 166   assert_param(IS_FUNCTIONALSTATE_OK(CLK_InitStruct->CLK_SwitchIT));
1315  0083 e604          	ld	a,(4,x)
1316  0085 4a            	dec	a
1317  0086 2712          	jreq	L63
1318  0088 e604          	ld	a,(4,x)
1319  008a 270e          	jreq	L63
1320  008c ae00a6        	ldw	x,#166
1321  008f 89            	pushw	x
1322  0090 ae000c        	ldw	x,#L766
1323  0093 8d000000      	callf	f_assert_failed
1325  0097 85            	popw	x
1326  0098 1e02          	ldw	x,(OFST+1,sp)
1327  009a               L63:
1328                     ; 167   assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_InitStruct->CLK_CurrentClockState));
1330  009a e605          	ld	a,(5,x)
1331  009c 2711          	jreq	L64
1332  009e 4a            	dec	a
1333  009f 270e          	jreq	L64
1334  00a1 ae00a7        	ldw	x,#167
1335  00a4 89            	pushw	x
1336  00a5 ae000c        	ldw	x,#L766
1337  00a8 8d000000      	callf	f_assert_failed
1339  00ac 85            	popw	x
1340  00ad 1e02          	ldw	x,(OFST+1,sp)
1341  00af               L64:
1342                     ; 168   assert_param(IS_FUNCTIONALSTATE_OK(CLK_InitStruct->CLK_FastHaltWakeup));
1344  00af f6            	ld	a,(x)
1345  00b0 4a            	dec	a
1346  00b1 2711          	jreq	L65
1347  00b3 f6            	ld	a,(x)
1348  00b4 270e          	jreq	L65
1349  00b6 ae00a8        	ldw	x,#168
1350  00b9 89            	pushw	x
1351  00ba ae000c        	ldw	x,#L766
1352  00bd 8d000000      	callf	f_assert_failed
1354  00c1 85            	popw	x
1355  00c2 1e02          	ldw	x,(OFST+1,sp)
1356  00c4               L65:
1357                     ; 169   assert_param(IS_CLK_HSIPRESCALER_OK(CLK_InitStruct->CLK_HSIPrescaler));
1359  00c4 e601          	ld	a,(1,x)
1360  00c6 271a          	jreq	L66
1361  00c8 a108          	cp	a,#8
1362  00ca 2716          	jreq	L66
1363  00cc a110          	cp	a,#16
1364  00ce 2712          	jreq	L66
1365  00d0 a118          	cp	a,#24
1366  00d2 270e          	jreq	L66
1367  00d4 ae00a9        	ldw	x,#169
1368  00d7 89            	pushw	x
1369  00d8 ae000c        	ldw	x,#L766
1370  00db 8d000000      	callf	f_assert_failed
1372  00df 85            	popw	x
1373  00e0 1e02          	ldw	x,(OFST+1,sp)
1374  00e2               L66:
1375                     ; 173   if (CLK_InitStruct->CLK_NewClock != CLK_SOURCE_HSI)
1377  00e2 e603          	ld	a,(3,x)
1378  00e4 a1e1          	cp	a,#225
1379  00e6 271a          	jreq	L176
1380                     ; 175     Status = CLK_ClockSwitchConfig(CLK_InitStruct->CLK_SwitchMode, CLK_InitStruct->CLK_NewClock, CLK_InitStruct->CLK_SwitchIT, CLK_InitStruct->CLK_CurrentClockState);
1382  00e8 e605          	ld	a,(5,x)
1383  00ea 88            	push	a
1384  00eb 1e03          	ldw	x,(OFST+2,sp)
1385  00ed e604          	ld	a,(4,x)
1386  00ef 88            	push	a
1387  00f0 1e04          	ldw	x,(OFST+3,sp)
1388  00f2 e603          	ld	a,(3,x)
1389  00f4 97            	ld	xl,a
1390  00f5 1604          	ldw	y,(OFST+3,sp)
1391  00f7 90e602        	ld	a,(2,y)
1392  00fa 95            	ld	xh,a
1393  00fb 8d720272      	callf	f_CLK_ClockSwitchConfig
1395  00ff 85            	popw	x
1397  0100 200e          	jra	L376
1398  0102               L176:
1399                     ; 179     CLK_HSIConfig(CLK_InitStruct->CLK_FastHaltWakeup, CLK_InitStruct->CLK_HSIPrescaler);
1401  0102 e601          	ld	a,(1,x)
1402  0104 97            	ld	xl,a
1403  0105 1602          	ldw	y,(OFST+1,sp)
1404  0107 90f6          	ld	a,(y)
1405  0109 95            	ld	xh,a
1406  010a 8d520352      	callf	f_CLK_HSIConfig
1408                     ; 180     Status = SUCCESS;
1410  010e a601          	ld	a,#1
1411  0110               L376:
1412                     ; 182   return Status;
1416  0110 5b03          	addw	sp,#3
1417  0112 87            	retf	
1452                     ; 197 void CLK_HSECmd(FunctionalState CLK_NewState)
1452                     ; 198 {
1453                     	switch	.text
1454  0113               f_CLK_HSECmd:
1456  0113 88            	push	a
1457       00000000      OFST:	set	0
1460                     ; 200   assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));
1462  0114 a101          	cp	a,#1
1463  0116 270f          	jreq	L401
1464  0118 4d            	tnz	a
1465  0119 270c          	jreq	L401
1466  011b ae00c8        	ldw	x,#200
1467  011e 89            	pushw	x
1468  011f ae000c        	ldw	x,#L766
1469  0122 8d000000      	callf	f_assert_failed
1471  0126 85            	popw	x
1472  0127               L401:
1473                     ; 202   if (CLK_NewState != DISABLE)
1475  0127 7b01          	ld	a,(OFST+1,sp)
1476  0129 2706          	jreq	L317
1477                     ; 205     CLK->ECKR |= CLK_ECKR_HSEEN;
1479  012b 721050c1      	bset	20673,#0
1481  012f 2004          	jra	L517
1482  0131               L317:
1483                     ; 210     CLK->ECKR &= (u8)(~CLK_ECKR_HSEEN);
1485  0131 721150c1      	bres	20673,#0
1486  0135               L517:
1487                     ; 212 }
1490  0135 84            	pop	a
1491  0136 87            	retf	
1526                     ; 226 void CLK_HSICmd(FunctionalState CLK_NewState)
1526                     ; 227 {
1527                     	switch	.text
1528  0137               f_CLK_HSICmd:
1530  0137 88            	push	a
1531       00000000      OFST:	set	0
1534                     ; 229   assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));
1536  0138 a101          	cp	a,#1
1537  013a 270f          	jreq	L611
1538  013c 4d            	tnz	a
1539  013d 270c          	jreq	L611
1540  013f ae00e5        	ldw	x,#229
1541  0142 89            	pushw	x
1542  0143 ae000c        	ldw	x,#L766
1543  0146 8d000000      	callf	f_assert_failed
1545  014a 85            	popw	x
1546  014b               L611:
1547                     ; 231   if (CLK_NewState != DISABLE)
1549  014b 7b01          	ld	a,(OFST+1,sp)
1550  014d 2706          	jreq	L537
1551                     ; 234     CLK->ICKR |= CLK_ICKR_HSIEN;
1553  014f 721050c0      	bset	20672,#0
1555  0153 2004          	jra	L737
1556  0155               L537:
1557                     ; 239     CLK->ICKR &= (u8)(~CLK_ICKR_HSIEN);
1559  0155 721150c0      	bres	20672,#0
1560  0159               L737:
1561                     ; 241 }
1564  0159 84            	pop	a
1565  015a 87            	retf	
1600                     ; 255 void CLK_LSICmd(FunctionalState CLK_NewState)
1600                     ; 256 {
1601                     	switch	.text
1602  015b               f_CLK_LSICmd:
1604  015b 88            	push	a
1605       00000000      OFST:	set	0
1608                     ; 258   assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));
1610  015c a101          	cp	a,#1
1611  015e 270f          	jreq	L031
1612  0160 4d            	tnz	a
1613  0161 270c          	jreq	L031
1614  0163 ae0102        	ldw	x,#258
1615  0166 89            	pushw	x
1616  0167 ae000c        	ldw	x,#L766
1617  016a 8d000000      	callf	f_assert_failed
1619  016e 85            	popw	x
1620  016f               L031:
1621                     ; 260   if (CLK_NewState != DISABLE)
1623  016f 7b01          	ld	a,(OFST+1,sp)
1624  0171 2706          	jreq	L757
1625                     ; 263     CLK->ICKR |= CLK_ICKR_LSIEN;
1627  0173 721650c0      	bset	20672,#3
1629  0177 2004          	jra	L167
1630  0179               L757:
1631                     ; 268     CLK->ICKR &= (u8)(~CLK_ICKR_LSIEN);
1633  0179 721750c0      	bres	20672,#3
1634  017d               L167:
1635                     ; 270 }
1638  017d 84            	pop	a
1639  017e 87            	retf	
1674                     ; 284 void CLK_CCOCmd(FunctionalState CLK_NewState)
1674                     ; 285 {
1675                     	switch	.text
1676  017f               f_CLK_CCOCmd:
1678  017f 88            	push	a
1679       00000000      OFST:	set	0
1682                     ; 287   assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));
1684  0180 a101          	cp	a,#1
1685  0182 270f          	jreq	L241
1686  0184 4d            	tnz	a
1687  0185 270c          	jreq	L241
1688  0187 ae011f        	ldw	x,#287
1689  018a 89            	pushw	x
1690  018b ae000c        	ldw	x,#L766
1691  018e 8d000000      	callf	f_assert_failed
1693  0192 85            	popw	x
1694  0193               L241:
1695                     ; 289   if (CLK_NewState != DISABLE)
1697  0193 7b01          	ld	a,(OFST+1,sp)
1698  0195 2706          	jreq	L1001
1699                     ; 292     CLK->CCOR |= CLK_CCOR_CCOEN;
1701  0197 721050c9      	bset	20681,#0
1703  019b 2004          	jra	L3001
1704  019d               L1001:
1705                     ; 297     CLK->CCOR &= (u8)(~CLK_CCOR_CCOEN);
1707  019d 721150c9      	bres	20681,#0
1708  01a1               L3001:
1709                     ; 300 }
1712  01a1 84            	pop	a
1713  01a2 87            	retf	
1748                     ; 318 void CLK_ClockSwitchCmd(FunctionalState CLK_NewState)
1748                     ; 319 {
1749                     	switch	.text
1750  01a3               f_CLK_ClockSwitchCmd:
1752  01a3 88            	push	a
1753       00000000      OFST:	set	0
1756                     ; 321   assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));
1758  01a4 a101          	cp	a,#1
1759  01a6 270f          	jreq	L451
1760  01a8 4d            	tnz	a
1761  01a9 270c          	jreq	L451
1762  01ab ae0141        	ldw	x,#321
1763  01ae 89            	pushw	x
1764  01af ae000c        	ldw	x,#L766
1765  01b2 8d000000      	callf	f_assert_failed
1767  01b6 85            	popw	x
1768  01b7               L451:
1769                     ; 323   if (CLK_NewState != DISABLE )
1771  01b7 7b01          	ld	a,(OFST+1,sp)
1772  01b9 2706          	jreq	L3201
1773                     ; 326     CLK->SWCR |= CLK_SWCR_SWEN;
1775  01bb 721250c5      	bset	20677,#1
1777  01bf 2004          	jra	L5201
1778  01c1               L3201:
1779                     ; 331     CLK->SWCR &= (u8)(~CLK_SWCR_SWEN);
1781  01c1 721350c5      	bres	20677,#1
1782  01c5               L5201:
1783                     ; 333 }
1786  01c5 84            	pop	a
1787  01c6 87            	retf	
1922                     ; 349 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState CLK_NewState)
1922                     ; 350 {
1923                     	switch	.text
1924  01c7               f_CLK_PeripheralClockConfig:
1926  01c7 89            	pushw	x
1927       00000000      OFST:	set	0
1930                     ; 353   assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));
1932  01c8 9f            	ld	a,xl
1933  01c9 4a            	dec	a
1934  01ca 2710          	jreq	L661
1935  01cc 9f            	ld	a,xl
1936  01cd 4d            	tnz	a
1937  01ce 270c          	jreq	L661
1938  01d0 ae0161        	ldw	x,#353
1939  01d3 89            	pushw	x
1940  01d4 ae000c        	ldw	x,#L766
1941  01d7 8d000000      	callf	f_assert_failed
1943  01db 85            	popw	x
1944  01dc               L661:
1945                     ; 354   assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
1947  01dc 7b01          	ld	a,(OFST+1,sp)
1948  01de 2736          	jreq	L671
1949  01e0 a101          	cp	a,#1
1950  01e2 2732          	jreq	L671
1951  01e4 a102          	cp	a,#2
1952  01e6 272e          	jreq	L671
1953  01e8 a103          	cp	a,#3
1954  01ea 272a          	jreq	L671
1955  01ec a104          	cp	a,#4
1956  01ee 2726          	jreq	L671
1957  01f0 a105          	cp	a,#5
1958  01f2 2722          	jreq	L671
1959  01f4 a106          	cp	a,#6
1960  01f6 271e          	jreq	L671
1961  01f8 a107          	cp	a,#7
1962  01fa 271a          	jreq	L671
1963  01fc a117          	cp	a,#23
1964  01fe 2716          	jreq	L671
1965  0200 a113          	cp	a,#19
1966  0202 2712          	jreq	L671
1967  0204 a112          	cp	a,#18
1968  0206 270e          	jreq	L671
1969  0208 ae0162        	ldw	x,#354
1970  020b 89            	pushw	x
1971  020c ae000c        	ldw	x,#L766
1972  020f 8d000000      	callf	f_assert_failed
1974  0213 85            	popw	x
1975  0214 7b01          	ld	a,(OFST+1,sp)
1976  0216               L671:
1977                     ; 356   if ((CLK_Peripheral & 0x10) == 0x0)
1979  0216 a510          	bcp	a,#16
1980  0218 262c          	jrne	L3011
1981                     ; 358 	  if (CLK_NewState != DISABLE)
1983  021a 0d02          	tnz	(OFST+2,sp)
1984  021c 2712          	jreq	L5011
1985                     ; 361 		  CLK->PCKENR1 |= (u8)((u8)1 << (u8)(CLK_Peripheral & (u8)0x0F));
1987  021e a40f          	and	a,#15
1988  0220 5f            	clrw	x
1989  0221 97            	ld	xl,a
1990  0222 a601          	ld	a,#1
1991  0224 5d            	tnzw	x
1992  0225 2704          	jreq	L202
1993  0227               L402:
1994  0227 48            	sll	a
1995  0228 5a            	decw	x
1996  0229 26fc          	jrne	L402
1997  022b               L202:
1998  022b ca50c7        	or	a,20679
2000  022e 2011          	jpf	LC002
2001  0230               L5011:
2002                     ; 366 		  CLK->PCKENR1 &= (u8)(~(u8)(((u8)1 << (u8)(CLK_Peripheral & (u8)0x0F))));
2004  0230 a40f          	and	a,#15
2005  0232 5f            	clrw	x
2006  0233 97            	ld	xl,a
2007  0234 a601          	ld	a,#1
2008  0236 5d            	tnzw	x
2009  0237 2704          	jreq	L602
2010  0239               L012:
2011  0239 48            	sll	a
2012  023a 5a            	decw	x
2013  023b 26fc          	jrne	L012
2014  023d               L602:
2015  023d 43            	cpl	a
2016  023e c450c7        	and	a,20679
2017  0241               LC002:
2018  0241 c750c7        	ld	20679,a
2019  0244 202a          	jra	L1111
2020  0246               L3011:
2021                     ; 371 	  if (CLK_NewState != DISABLE)
2023  0246 0d02          	tnz	(OFST+2,sp)
2024  0248 2712          	jreq	L3111
2025                     ; 374 		  CLK->PCKENR2 |= (u8)((u8)1 << (u8)(CLK_Peripheral & (u8)0x0F));
2027  024a a40f          	and	a,#15
2028  024c 5f            	clrw	x
2029  024d 97            	ld	xl,a
2030  024e a601          	ld	a,#1
2031  0250 5d            	tnzw	x
2032  0251 2704          	jreq	L212
2033  0253               L412:
2034  0253 48            	sll	a
2035  0254 5a            	decw	x
2036  0255 26fc          	jrne	L412
2037  0257               L212:
2038  0257 ca50ca        	or	a,20682
2040  025a 2011          	jpf	LC001
2041  025c               L3111:
2042                     ; 379 		  CLK->PCKENR2 &= (u8)(~(u8)(((u8)1 << (u8)(CLK_Peripheral & (u8)0x0F))));
2044  025c a40f          	and	a,#15
2045  025e 5f            	clrw	x
2046  025f 97            	ld	xl,a
2047  0260 a601          	ld	a,#1
2048  0262 5d            	tnzw	x
2049  0263 2704          	jreq	L612
2050  0265               L022:
2051  0265 48            	sll	a
2052  0266 5a            	decw	x
2053  0267 26fc          	jrne	L022
2054  0269               L612:
2055  0269 43            	cpl	a
2056  026a c450ca        	and	a,20682
2057  026d               LC001:
2058  026d c750ca        	ld	20682,a
2059  0270               L1111:
2060                     ; 382 }
2063  0270 85            	popw	x
2064  0271 87            	retf	
2159                     ; 405 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState CLK_SwitchIT, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
2159                     ; 406 {
2160                     	switch	.text
2161  0272               f_CLK_ClockSwitchConfig:
2163  0272 89            	pushw	x
2164  0273 5204          	subw	sp,#4
2165       00000004      OFST:	set	4
2168                     ; 408   u16 DownCounter = CLK_TIMEOUT;
2170  0275 ae0491        	ldw	x,#1169
2171  0278 1f03          	ldw	(OFST-1,sp),x
2172                     ; 409   ErrorStatus Swif = ERROR;
2174  027a 0f02          	clr	(OFST-2,sp)
2175                     ; 412   assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
2177  027c 7b06          	ld	a,(OFST+2,sp)
2178  027e a1e1          	cp	a,#225
2179  0280 2714          	jreq	L032
2180  0282 a1d2          	cp	a,#210
2181  0284 2710          	jreq	L032
2182  0286 a1b4          	cp	a,#180
2183  0288 270c          	jreq	L032
2184  028a ae019c        	ldw	x,#412
2185  028d 89            	pushw	x
2186  028e ae000c        	ldw	x,#L766
2187  0291 8d000000      	callf	f_assert_failed
2189  0295 85            	popw	x
2190  0296               L032:
2191                     ; 413   assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
2193  0296 7b05          	ld	a,(OFST+1,sp)
2194  0298 270f          	jreq	L042
2195  029a 4a            	dec	a
2196  029b 270c          	jreq	L042
2197  029d ae019d        	ldw	x,#413
2198  02a0 89            	pushw	x
2199  02a1 ae000c        	ldw	x,#L766
2200  02a4 8d000000      	callf	f_assert_failed
2202  02a8 85            	popw	x
2203  02a9               L042:
2204                     ; 414   assert_param(IS_FUNCTIONALSTATE_OK(CLK_SwitchIT));
2206  02a9 7b0a          	ld	a,(OFST+6,sp)
2207  02ab 4a            	dec	a
2208  02ac 2710          	jreq	L052
2209  02ae 7b0a          	ld	a,(OFST+6,sp)
2210  02b0 270c          	jreq	L052
2211  02b2 ae019e        	ldw	x,#414
2212  02b5 89            	pushw	x
2213  02b6 ae000c        	ldw	x,#L766
2214  02b9 8d000000      	callf	f_assert_failed
2216  02bd 85            	popw	x
2217  02be               L052:
2218                     ; 415   assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
2220  02be 7b0b          	ld	a,(OFST+7,sp)
2221  02c0 270f          	jreq	L062
2222  02c2 4a            	dec	a
2223  02c3 270c          	jreq	L062
2224  02c5 ae019f        	ldw	x,#415
2225  02c8 89            	pushw	x
2226  02c9 ae000c        	ldw	x,#L766
2227  02cc 8d000000      	callf	f_assert_failed
2229  02d0 85            	popw	x
2230  02d1               L062:
2231                     ; 418   if (CLK_NewClock == CLK_SOURCE_LSI)
2233  02d1 7b06          	ld	a,(OFST+2,sp)
2234  02d3 a1d2          	cp	a,#210
2235  02d5 2608          	jrne	L3711
2236                     ; 420     *(unsigned char*)0x5069 = 0x08;
2238  02d7 35085069      	mov	20585,#8
2239                     ; 421     *(unsigned char*)0x506A = (u8)(~0x08);
2241  02db 35f7506a      	mov	20586,#247
2242  02df               L3711:
2243                     ; 425   clock_master = CLK->CMSR;
2245  02df c650c3        	ld	a,20675
2246  02e2 6b01          	ld	(OFST-3,sp),a
2247                     ; 428   if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
2249  02e4 7b05          	ld	a,(OFST+1,sp)
2250  02e6 4a            	dec	a
2251  02e7 262b          	jrne	L5711
2252                     ; 431     CLK->SWCR |= CLK_SWCR_SWEN;
2254  02e9 721250c5      	bset	20677,#1
2255                     ; 433     if (CLK_SwitchIT != DISABLE)
2257  02ed 7b0a          	ld	a,(OFST+6,sp)
2258  02ef 2706          	jreq	L7711
2259                     ; 435       CLK->SWCR |= CLK_SWCR_SWIEN;
2261  02f1 721450c5      	bset	20677,#2
2263  02f5 2004          	jra	L1021
2264  02f7               L7711:
2265                     ; 439       CLK->SWCR &= (u8)(~CLK_SWCR_SWIEN);
2267  02f7 721550c5      	bres	20677,#2
2268  02fb               L1021:
2269                     ; 442     CLK->SWR = (u8)CLK_NewClock;
2271  02fb 7b06          	ld	a,(OFST+2,sp)
2272  02fd c750c4        	ld	20676,a
2274  0300 2003          	jra	L7021
2275  0302               L3021:
2276                     ; 446         DownCounter--;
2278  0302 5a            	decw	x
2279  0303 1f03          	ldw	(OFST-1,sp),x
2280  0305               L7021:
2281                     ; 444       while (((CLK->SWCR & CLK_SWCR_SWBSY) && (DownCounter != 0)))
2283  0305 720150c504    	btjf	20677,#0,L3121
2285  030a 1e03          	ldw	x,(OFST-1,sp)
2286  030c 26f4          	jrne	L3021
2287  030e               L3121:
2288                     ; 448       if (DownCounter != 0)
2290  030e 1e03          	ldw	x,(OFST-1,sp)
2291  0310 2719          	jreq	L7121
2292                     ; 450         Swif = SUCCESS;
2293  0312 2013          	jpf	LC003
2294  0314               L5711:
2295                     ; 457     if (CLK_SwitchIT != DISABLE)
2297  0314 7b0a          	ld	a,(OFST+6,sp)
2298  0316 2706          	jreq	L1221
2299                     ; 459       CLK->SWCR |= CLK_SWCR_SWIEN;
2301  0318 721450c5      	bset	20677,#2
2303  031c 2004          	jra	L3221
2304  031e               L1221:
2305                     ; 463       CLK->SWCR &= (u8)(~CLK_SWCR_SWIEN);
2307  031e 721550c5      	bres	20677,#2
2308  0322               L3221:
2309                     ; 466     CLK->SWR = (u8)CLK_NewClock;
2311  0322 7b06          	ld	a,(OFST+2,sp)
2312  0324 c750c4        	ld	20676,a
2313                     ; 469     Swif = SUCCESS;
2315  0327               LC003:
2317  0327 a601          	ld	a,#1
2318  0329 6b02          	ld	(OFST-2,sp),a
2319  032b               L7121:
2320                     ; 472   if (CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE)
2322  032b 7b0b          	ld	a,(OFST+7,sp)
2323  032d 261e          	jrne	L5221
2324                     ; 474     switch (clock_master)
2326  032f 7b01          	ld	a,(OFST-3,sp)
2328                     ; 485       default:
2328                     ; 486         break;
2329  0331 a0b4          	sub	a,#180
2330  0333 2714          	jreq	L3211
2331  0335 a01e          	sub	a,#30
2332  0337 270a          	jreq	L1211
2333  0339 a00f          	sub	a,#15
2334  033b 2610          	jrne	L5221
2335                     ; 476       case CLK_SOURCE_HSI:
2335                     ; 477         CLK->ICKR &= (u8)(~CLK_ICKR_HSIEN);
2337  033d 721150c0      	bres	20672,#0
2338                     ; 478         break;
2340  0341 200a          	jra	L5221
2341  0343               L1211:
2342                     ; 479       case CLK_SOURCE_LSI:
2342                     ; 480         CLK->ICKR &= (u8)(~CLK_ICKR_LSIEN);
2344  0343 721750c0      	bres	20672,#3
2345                     ; 481         break;
2347  0347 2004          	jra	L5221
2348  0349               L3211:
2349                     ; 482       case CLK_SOURCE_HSE:
2349                     ; 483         CLK->ECKR &= (u8)(~CLK_ECKR_HSEEN);
2351  0349 721150c1      	bres	20673,#0
2352                     ; 484         break;
2354                     ; 485       default:
2354                     ; 486         break;
2356  034d               L5221:
2357                     ; 489   return Swif;
2359  034d 7b02          	ld	a,(OFST-2,sp)
2362  034f 5b06          	addw	sp,#6
2363  0351 87            	retf	
2408                     ; 510 void CLK_HSIConfig(FunctionalState CLK_FastHaltWakeup, CLK_Prescaler_TypeDef HSIPrescaler)
2408                     ; 511 {
2409                     	switch	.text
2410  0352               f_CLK_HSIConfig:
2412  0352 89            	pushw	x
2413       00000000      OFST:	set	0
2416                     ; 514   assert_param(IS_FUNCTIONALSTATE_OK(CLK_FastHaltWakeup));
2418  0353 9e            	ld	a,xh
2419  0354 4a            	dec	a
2420  0355 2710          	jreq	L272
2421  0357 9e            	ld	a,xh
2422  0358 4d            	tnz	a
2423  0359 270c          	jreq	L272
2424  035b ae0202        	ldw	x,#514
2425  035e 89            	pushw	x
2426  035f ae000c        	ldw	x,#L766
2427  0362 8d000000      	callf	f_assert_failed
2429  0366 85            	popw	x
2430  0367               L272:
2431                     ; 515   assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
2433  0367 7b02          	ld	a,(OFST+2,sp)
2434  0369 2718          	jreq	L203
2435  036b a108          	cp	a,#8
2436  036d 2714          	jreq	L203
2437  036f a110          	cp	a,#16
2438  0371 2710          	jreq	L203
2439  0373 a118          	cp	a,#24
2440  0375 270c          	jreq	L203
2441  0377 ae0203        	ldw	x,#515
2442  037a 89            	pushw	x
2443  037b ae000c        	ldw	x,#L766
2444  037e 8d000000      	callf	f_assert_failed
2446  0382 85            	popw	x
2447  0383               L203:
2448                     ; 518   CLK->CKDIVR &= (u8)(~CLK_CKDIVR_HSIDIV);
2450  0383 c650c6        	ld	a,20678
2451  0386 a4e7          	and	a,#231
2452  0388 c750c6        	ld	20678,a
2453                     ; 521   CLK->CKDIVR |= (u8)HSIPrescaler;
2455  038b c650c6        	ld	a,20678
2456  038e 1a02          	or	a,(OFST+2,sp)
2457  0390 c750c6        	ld	20678,a
2458                     ; 523   if (CLK_FastHaltWakeup != DISABLE)
2460  0393 7b01          	ld	a,(OFST+1,sp)
2461  0395 2706          	jreq	L5521
2462                     ; 526     CLK->ICKR |= CLK_ICKR_FHWU;
2464  0397 721450c0      	bset	20672,#2
2466  039b 2004          	jra	L7521
2467  039d               L5521:
2468                     ; 531     CLK->ICKR &= (u8)(~CLK_ICKR_FHWU);
2470  039d 721550c0      	bres	20672,#2
2471  03a1               L7521:
2472                     ; 533 }
2475  03a1 85            	popw	x
2476  03a2 87            	retf	
2511                     ; 550 void CLK_LSIConfig(FunctionalState CLK_SlowActiveHalt)
2511                     ; 551 {
2512                     	switch	.text
2513  03a3               f_CLK_LSIConfig:
2515  03a3 88            	push	a
2516       00000000      OFST:	set	0
2519                     ; 553   assert_param(IS_FUNCTIONALSTATE_OK(CLK_SlowActiveHalt));
2521  03a4 a101          	cp	a,#1
2522  03a6 270f          	jreq	L413
2523  03a8 4d            	tnz	a
2524  03a9 270c          	jreq	L413
2525  03ab ae0229        	ldw	x,#553
2526  03ae 89            	pushw	x
2527  03af ae000c        	ldw	x,#L766
2528  03b2 8d000000      	callf	f_assert_failed
2530  03b6 85            	popw	x
2531  03b7               L413:
2532                     ; 555   if (CLK_SlowActiveHalt != DISABLE)
2534  03b7 7b01          	ld	a,(OFST+1,sp)
2535  03b9 2706          	jreq	L7721
2536                     ; 558     CLK->ICKR |= CLK_ICKR_SWUAH;
2538  03bb 721a50c0      	bset	20672,#5
2540  03bf 2004          	jra	L1031
2541  03c1               L7721:
2542                     ; 563     CLK->ICKR &= (u8)(~CLK_ICKR_SWUAH);
2544  03c1 721b50c0      	bres	20672,#5
2545  03c5               L1031:
2546                     ; 566 }
2549  03c5 84            	pop	a
2550  03c6 87            	retf	
2686                     ; 583 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
2686                     ; 584 {
2687                     	switch	.text
2688  03c7               f_CLK_CCOConfig:
2690  03c7 88            	push	a
2691       00000000      OFST:	set	0
2694                     ; 586   assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
2696  03c8 4d            	tnz	a
2697  03c9 273c          	jreq	L623
2698  03cb a104          	cp	a,#4
2699  03cd 2738          	jreq	L623
2700  03cf a102          	cp	a,#2
2701  03d1 2734          	jreq	L623
2702  03d3 a108          	cp	a,#8
2703  03d5 2730          	jreq	L623
2704  03d7 a10a          	cp	a,#10
2705  03d9 272c          	jreq	L623
2706  03db a10c          	cp	a,#12
2707  03dd 2728          	jreq	L623
2708  03df a10e          	cp	a,#14
2709  03e1 2724          	jreq	L623
2710  03e3 a110          	cp	a,#16
2711  03e5 2720          	jreq	L623
2712  03e7 a112          	cp	a,#18
2713  03e9 271c          	jreq	L623
2714  03eb a114          	cp	a,#20
2715  03ed 2718          	jreq	L623
2716  03ef a116          	cp	a,#22
2717  03f1 2714          	jreq	L623
2718  03f3 a118          	cp	a,#24
2719  03f5 2710          	jreq	L623
2720  03f7 a11a          	cp	a,#26
2721  03f9 270c          	jreq	L623
2722  03fb ae024a        	ldw	x,#586
2723  03fe 89            	pushw	x
2724  03ff ae000c        	ldw	x,#L766
2725  0402 8d000000      	callf	f_assert_failed
2727  0406 85            	popw	x
2728  0407               L623:
2729                     ; 589   CLK->CCOR &= (u8)(~CLK_CCOR_CCOSEL);
2731  0407 c650c9        	ld	a,20681
2732  040a a4e1          	and	a,#225
2733  040c c750c9        	ld	20681,a
2734                     ; 592   CLK->CCOR |= CLK_CCO;
2736  040f c650c9        	ld	a,20681
2737  0412 1a01          	or	a,(OFST+1,sp)
2738  0414 c750c9        	ld	20681,a
2739                     ; 595   CLK_CCOCmd(ENABLE);
2741  0417 a601          	ld	a,#1
2742  0419 8d7f017f      	callf	f_CLK_CCOCmd
2744                     ; 596 }
2747  041d 84            	pop	a
2748  041e 87            	retf	
2813                     ; 613 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState IT_NewState)
2813                     ; 614 {
2814                     	switch	.text
2815  041f               f_CLK_ITConfig:
2817  041f 89            	pushw	x
2818       00000000      OFST:	set	0
2821                     ; 616   assert_param(IS_FUNCTIONALSTATE_OK(IT_NewState));
2823  0420 9f            	ld	a,xl
2824  0421 4a            	dec	a
2825  0422 2710          	jreq	L243
2826  0424 9f            	ld	a,xl
2827  0425 4d            	tnz	a
2828  0426 270c          	jreq	L243
2829  0428 ae0268        	ldw	x,#616
2830  042b 89            	pushw	x
2831  042c ae000c        	ldw	x,#L766
2832  042f 8d000000      	callf	f_assert_failed
2834  0433 85            	popw	x
2835  0434               L243:
2836                     ; 617   assert_param(IS_CLK_IT_OK(CLK_IT));
2838  0434 7b01          	ld	a,(OFST+1,sp)
2839  0436 a101          	cp	a,#1
2840  0438 2710          	jreq	L253
2841  043a a102          	cp	a,#2
2842  043c 270c          	jreq	L253
2843  043e ae0269        	ldw	x,#617
2844  0441 89            	pushw	x
2845  0442 ae000c        	ldw	x,#L766
2846  0445 8d000000      	callf	f_assert_failed
2848  0449 85            	popw	x
2849  044a               L253:
2850                     ; 619   if (IT_NewState != DISABLE)
2852  044a 7b02          	ld	a,(OFST+2,sp)
2853  044c 2716          	jreq	L5241
2854                     ; 621     switch (CLK_IT)
2856  044e 7b01          	ld	a,(OFST+1,sp)
2858                     ; 629       default:
2858                     ; 630         break;
2859  0450 4a            	dec	a
2860  0451 2705          	jreq	L7531
2861  0453 4a            	dec	a
2862  0454 2708          	jreq	L1631
2863  0456 201a          	jra	L3341
2864  0458               L7531:
2865                     ; 623       case CLK_IT_SWIE: /* Enable the clock switch interrupt */
2865                     ; 624         CLK->SWCR |= CLK_SWCR_SWIEN;
2867  0458 721450c5      	bset	20677,#2
2868                     ; 625         break;
2870  045c 2014          	jra	L3341
2871  045e               L1631:
2872                     ; 626       case CLK_IT_CSSDIE: /* Enable the clock security system detection interrupt */
2872                     ; 627         CLK->CSSR |= CLK_CSSR_CSSDIE;
2874  045e 721450c8      	bset	20680,#2
2875                     ; 628         break;
2877  0462 200e          	jra	L3341
2878                     ; 629       default:
2878                     ; 630         break;
2881  0464               L5241:
2882                     ; 635     switch (CLK_IT)
2884  0464 7b01          	ld	a,(OFST+1,sp)
2886                     ; 643       default:
2886                     ; 644         break;
2887  0466 4a            	dec	a
2888  0467 2705          	jreq	L5631
2889  0469 4a            	dec	a
2890  046a 2708          	jreq	L7631
2891  046c 2004          	jra	L3341
2892  046e               L5631:
2893                     ; 637       case CLK_IT_SWIE: /* Disable the clock switch interrupt */
2893                     ; 638         CLK->SWCR  &= (u8)(~CLK_SWCR_SWIEN);
2895  046e 721550c5      	bres	20677,#2
2896                     ; 639         break;
2897  0472               L3341:
2898                     ; 647 }
2901  0472 85            	popw	x
2902  0473 87            	retf	
2903  0474               L7631:
2904                     ; 640       case CLK_IT_CSSDIE: /* Disable the clock security system detection interrupt */
2904                     ; 641         CLK->CSSR &= (u8)(~CLK_CSSR_CSSDIE);
2906  0474 721550c8      	bres	20680,#2
2907                     ; 642         break;
2909  0478 20f8          	jra	L3341
2910                     ; 643       default:
2910                     ; 644         break;
2946                     ; 663 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef ClockPrescaler)
2946                     ; 664 {
2947                     	switch	.text
2948  047a               f_CLK_SYSCLKConfig:
2950  047a 88            	push	a
2951       00000000      OFST:	set	0
2954                     ; 667   assert_param(IS_CLK_PRESCALER_OK(ClockPrescaler));
2956  047b 4d            	tnz	a
2957  047c 2738          	jreq	L463
2958  047e a108          	cp	a,#8
2959  0480 2734          	jreq	L463
2960  0482 a110          	cp	a,#16
2961  0484 2730          	jreq	L463
2962  0486 a118          	cp	a,#24
2963  0488 272c          	jreq	L463
2964  048a a180          	cp	a,#128
2965  048c 2728          	jreq	L463
2966  048e a181          	cp	a,#129
2967  0490 2724          	jreq	L463
2968  0492 a182          	cp	a,#130
2969  0494 2720          	jreq	L463
2970  0496 a183          	cp	a,#131
2971  0498 271c          	jreq	L463
2972  049a a184          	cp	a,#132
2973  049c 2718          	jreq	L463
2974  049e a185          	cp	a,#133
2975  04a0 2714          	jreq	L463
2976  04a2 a186          	cp	a,#134
2977  04a4 2710          	jreq	L463
2978  04a6 a187          	cp	a,#135
2979  04a8 270c          	jreq	L463
2980  04aa ae029b        	ldw	x,#667
2981  04ad 89            	pushw	x
2982  04ae ae000c        	ldw	x,#L766
2983  04b1 8d000000      	callf	f_assert_failed
2985  04b5 85            	popw	x
2986  04b6               L463:
2987                     ; 670   if ((ClockPrescaler & (u8)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
2989  04b6 7b01          	ld	a,(OFST+1,sp)
2990  04b8 2b0e          	jrmi	L7541
2991                     ; 672     CLK->CKDIVR &= (u8)(~CLK_CKDIVR_HSIDIV);
2993  04ba c650c6        	ld	a,20678
2994  04bd a4e7          	and	a,#231
2995  04bf c750c6        	ld	20678,a
2996                     ; 673     CLK->CKDIVR |= (u8)(ClockPrescaler & CLK_CKDIVR_HSIDIV);
2998  04c2 7b01          	ld	a,(OFST+1,sp)
2999  04c4 a418          	and	a,#24
3001  04c6 200c          	jra	L1641
3002  04c8               L7541:
3003                     ; 677     CLK->CKDIVR &= (u8)(~CLK_CKDIVR_CPUDIV);
3005  04c8 c650c6        	ld	a,20678
3006  04cb a4f8          	and	a,#248
3007  04cd c750c6        	ld	20678,a
3008                     ; 678     CLK->CKDIVR |= (u8)(ClockPrescaler & CLK_CKDIVR_CPUDIV);
3010  04d0 7b01          	ld	a,(OFST+1,sp)
3011  04d2 a407          	and	a,#7
3012  04d4               L1641:
3013  04d4 ca50c6        	or	a,20678
3014  04d7 c750c6        	ld	20678,a
3015                     ; 681 }
3018  04da 84            	pop	a
3019  04db 87            	retf	
3075                     ; 695 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
3075                     ; 696 {
3076                     	switch	.text
3077  04dc               f_CLK_SWIMConfig:
3079  04dc 88            	push	a
3080       00000000      OFST:	set	0
3083                     ; 698   assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
3085  04dd 4d            	tnz	a
3086  04de 270f          	jreq	L673
3087  04e0 4a            	dec	a
3088  04e1 270c          	jreq	L673
3089  04e3 ae02ba        	ldw	x,#698
3090  04e6 89            	pushw	x
3091  04e7 ae000c        	ldw	x,#L766
3092  04ea 8d000000      	callf	f_assert_failed
3094  04ee 85            	popw	x
3095  04ef               L673:
3096                     ; 700   if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
3098  04ef 7b01          	ld	a,(OFST+1,sp)
3099  04f1 2706          	jreq	L1151
3100                     ; 703     CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
3102  04f3 721050cd      	bset	20685,#0
3104  04f7 2004          	jra	L3151
3105  04f9               L1151:
3106                     ; 708     CLK->SWIMCCR &= (u8)(~CLK_SWIMCCR_SWIMDIV);
3108  04f9 721150cd      	bres	20685,#0
3109  04fd               L3151:
3110                     ; 710 }
3113  04fd 84            	pop	a
3114  04fe 87            	retf	
3211                     ; 725 void CLK_CANConfig(CLK_CANDivider_TypeDef CLK_CANDivider)
3211                     ; 726 {
3212                     	switch	.text
3213  04ff               f_CLK_CANConfig:
3215  04ff 88            	push	a
3216       00000000      OFST:	set	0
3219                     ; 728   assert_param(IS_CLK_CANDIVIDER_OK(CLK_CANDivider));
3221  0500 4d            	tnz	a
3222  0501 2728          	jreq	L014
3223  0503 a101          	cp	a,#1
3224  0505 2724          	jreq	L014
3225  0507 a102          	cp	a,#2
3226  0509 2720          	jreq	L014
3227  050b a103          	cp	a,#3
3228  050d 271c          	jreq	L014
3229  050f a104          	cp	a,#4
3230  0511 2718          	jreq	L014
3231  0513 a105          	cp	a,#5
3232  0515 2714          	jreq	L014
3233  0517 a106          	cp	a,#6
3234  0519 2710          	jreq	L014
3235  051b a107          	cp	a,#7
3236  051d 270c          	jreq	L014
3237  051f ae02d8        	ldw	x,#728
3238  0522 89            	pushw	x
3239  0523 ae000c        	ldw	x,#L766
3240  0526 8d000000      	callf	f_assert_failed
3242  052a 85            	popw	x
3243  052b               L014:
3244                     ; 731   CLK->CANCCR &= (u8)(~CLK_CANCCR_CANDIV);
3246  052b c650cb        	ld	a,20683
3247  052e a4f8          	and	a,#248
3248  0530 c750cb        	ld	20683,a
3249                     ; 734   CLK->CANCCR |= CLK_CANDivider;
3251  0533 c650cb        	ld	a,20683
3252  0536 1a01          	or	a,(OFST+1,sp)
3253  0538 c750cb        	ld	20683,a
3254                     ; 735 }
3257  053b 84            	pop	a
3258  053c 87            	retf	
3281                     ; 752 void CLK_ClockSecuritySystemEnable(void)
3281                     ; 753 {
3282                     	switch	.text
3283  053d               f_CLK_ClockSecuritySystemEnable:
3287                     ; 755   CLK->CSSR |= CLK_CSSR_CSSEN;
3289  053d 721050c8      	bset	20680,#0
3290                     ; 756 }
3293  0541 87            	retf	
3317                     ; 773 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
3317                     ; 774 {
3318                     	switch	.text
3319  0542               f_CLK_GetSYSCLKSource:
3323                     ; 775   return((CLK_Source_TypeDef)CLK->CMSR);
3325  0542 c650c3        	ld	a,20675
3328  0545 87            	retf	
3394                     ; 796 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
3394                     ; 797 {
3395                     	switch	.text
3396  0546               f_CLK_GetITStatus:
3398  0546 88            	push	a
3399  0547 88            	push	a
3400       00000001      OFST:	set	1
3403                     ; 798   ITStatus bitstatus = RESET;
3405  0548 0f01          	clr	(OFST+0,sp)
3406                     ; 801   assert_param(IS_CLK_IT_OK(CLK_IT));
3408  054a a101          	cp	a,#1
3409  054c 2710          	jreq	L624
3410  054e a102          	cp	a,#2
3411  0550 270c          	jreq	L624
3412  0552 ae0321        	ldw	x,#801
3413  0555 89            	pushw	x
3414  0556 ae000c        	ldw	x,#L766
3415  0559 8d000000      	callf	f_assert_failed
3417  055d 85            	popw	x
3418  055e               L624:
3419                     ; 803   if (CLK_IT == CLK_IT_SWIE)
3421  055e 7b02          	ld	a,(OFST+1,sp)
3422  0560 4a            	dec	a
3423  0561 2609          	jrne	L1361
3424                     ; 806     if ((CLK->SWCR & (u8)CLK_SWCR_SWIEN) != (u8)RESET)
3426  0563 720550c502    	btjf	20677,#2,L3361
3427                     ; 808       bitstatus = SET;
3429  0568 2007          	jpf	LC005
3430  056a               L3361:
3431                     ; 812       bitstatus = RESET;
3432  056a 2009          	jpf	L1461
3433  056c               L1361:
3434                     ; 818     if ((CLK->CSSR & (u8)CLK_CSSR_CSSDIE) != (u8)RESET)
3436  056c 720550c804    	btjf	20680,#2,L1461
3437                     ; 820       bitstatus = SET;
3439  0571               LC005:
3441  0571 a601          	ld	a,#1
3443  0573 2001          	jra	L7361
3444  0575               L1461:
3445                     ; 824       bitstatus = RESET;
3448  0575 4f            	clr	a
3449  0576               L7361:
3450                     ; 829   return  bitstatus;
3454  0576 85            	popw	x
3455  0577 87            	retf	
3584                     ; 846 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
3584                     ; 847 {
3585                     	switch	.text
3586  0578               f_CLK_GetFlagStatus:
3588  0578 89            	pushw	x
3589  0579 5203          	subw	sp,#3
3590       00000003      OFST:	set	3
3593                     ; 848   u16 statusreg = 0;
3595                     ; 849   u8 tmpreg = 0;
3597  057b 4f            	clr	a
3598  057c 6b03          	ld	(OFST+0,sp),a
3599                     ; 850   FlagStatus bitstatus = RESET;
3601                     ; 853   assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
3603  057e 1e04          	ldw	x,(OFST+1,sp)
3604  0580 a30110        	cpw	x,#272
3605  0583 2734          	jreq	L044
3606  0585 a30102        	cpw	x,#258
3607  0588 272f          	jreq	L044
3608  058a a30202        	cpw	x,#514
3609  058d 272a          	jreq	L044
3610  058f a30308        	cpw	x,#776
3611  0592 2725          	jreq	L044
3612  0594 a30301        	cpw	x,#769
3613  0597 2720          	jreq	L044
3614  0599 a30408        	cpw	x,#1032
3615  059c 271b          	jreq	L044
3616  059e a30402        	cpw	x,#1026
3617  05a1 2716          	jreq	L044
3618  05a3 a30504        	cpw	x,#1284
3619  05a6 2711          	jreq	L044
3620  05a8 a30502        	cpw	x,#1282
3621  05ab 270c          	jreq	L044
3622  05ad ae0355        	ldw	x,#853
3623  05b0 89            	pushw	x
3624  05b1 ae000c        	ldw	x,#L766
3625  05b4 8d000000      	callf	f_assert_failed
3627  05b8 85            	popw	x
3628  05b9               L044:
3629                     ; 857   statusreg = (CLK_FLAG &= 0xFF00);
3631  05b9 0f05          	clr	(OFST+2,sp)
3632  05bb 1e04          	ldw	x,(OFST+1,sp)
3633  05bd 1f01          	ldw	(OFST-2,sp),x
3634                     ; 858   switch (statusreg)
3637                     ; 875     default:
3637                     ; 876       break;
3638  05bf 1d0100        	subw	x,#256
3639  05c2 2716          	jreq	L5461
3640  05c4 1d0100        	subw	x,#256
3641  05c7 2716          	jreq	L7461
3642  05c9 1d0100        	subw	x,#256
3643  05cc 2716          	jreq	L1561
3644  05ce 1d0100        	subw	x,#256
3645  05d1 2716          	jreq	L3561
3646  05d3 1d0100        	subw	x,#256
3647  05d6 2716          	jreq	L5561
3648  05d8 2019          	jra	L7371
3649  05da               L5461:
3650                     ; 860     case 0x100: /* The flag to check is in ICKRregister */
3650                     ; 861       tmpreg = CLK->ICKR;
3652  05da c650c0        	ld	a,20672
3653                     ; 862       break;
3655  05dd 2012          	jpf	LC006
3656  05df               L7461:
3657                     ; 863     case 0x200: /* The flag to check is in ECKRregister */
3657                     ; 864       tmpreg = CLK->ECKR;
3659  05df c650c1        	ld	a,20673
3660                     ; 865       break;
3662  05e2 200d          	jpf	LC006
3663  05e4               L1561:
3664                     ; 866     case 0x300: /* The flag to check is in SWIC register */
3664                     ; 867       tmpreg = CLK->SWCR;
3666  05e4 c650c5        	ld	a,20677
3667                     ; 868       break;
3669  05e7 2008          	jpf	LC006
3670  05e9               L3561:
3671                     ; 869     case 0x400: /* The flag to check is in CSS register */
3671                     ; 870       tmpreg = CLK->CSSR;
3673  05e9 c650c8        	ld	a,20680
3674                     ; 871       break;
3676  05ec 2003          	jpf	LC006
3677  05ee               L5561:
3678                     ; 872     case 0x500: /* The flag to check is in CCO register */
3678                     ; 873       tmpreg = CLK->CCOR;
3680  05ee c650c9        	ld	a,20681
3681  05f1               LC006:
3682  05f1 6b03          	ld	(OFST+0,sp),a
3683                     ; 874       break;
3685                     ; 875     default:
3685                     ; 876       break;
3687  05f3               L7371:
3688                     ; 879   if ((tmpreg & (u8)CLK_FLAG) != (u8)RESET)
3690  05f3 7b05          	ld	a,(OFST+2,sp)
3691  05f5 1503          	bcp	a,(OFST+0,sp)
3692  05f7 2704          	jreq	L1471
3693                     ; 881     bitstatus = SET;
3695  05f9 a601          	ld	a,#1
3697  05fb 2001          	jra	L3471
3698  05fd               L1471:
3699                     ; 885     bitstatus = RESET;
3701  05fd 4f            	clr	a
3702  05fe               L3471:
3703                     ; 889   return (u8)bitstatus;
3707  05fe 5b05          	addw	sp,#5
3708  0600 87            	retf	
3764                     ; 906 u32 CLK_GetClockFreq(void)
3764                     ; 907 {
3765                     	switch	.text
3766  0601               f_CLK_GetClockFreq:
3768  0601 5209          	subw	sp,#9
3769       00000009      OFST:	set	9
3772                     ; 909   u32 clockfrequency = 0;
3774  0603 5f            	clrw	x
3775  0604 1f07          	ldw	(OFST-2,sp),x
3776  0606 1f05          	ldw	(OFST-4,sp),x
3777                     ; 910   CLK_Source_TypeDef clocksource = 0xE1;
3779                     ; 911   u8 tmp = 0, presc = 0;
3783                     ; 914   clocksource = CLK->CMSR;
3785  0608 c650c3        	ld	a,20675
3786  060b 6b09          	ld	(OFST+0,sp),a
3787                     ; 916   switch (clocksource)
3790                     ; 930     default:
3790                     ; 931       break;
3791  060d a0b4          	sub	a,#180
3792  060f 2748          	jreq	L1571
3793  0611 a01e          	sub	a,#30
3794  0613 273a          	jreq	L7471
3795  0615 a00f          	sub	a,#15
3796  0617 264a          	jrne	L3002
3797                     ; 918     case CLK_SOURCE_HSI:
3797                     ; 919       tmp = (u8)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
3799  0619 c650c6        	ld	a,20678
3800  061c a418          	and	a,#24
3801                     ; 920       tmp = (u8)(tmp >> 3);
3803  061e 44            	srl	a
3804  061f 44            	srl	a
3805  0620 44            	srl	a
3806                     ; 921       presc = HSIDivFactor[tmp];
3808  0621 97            	ld	xl,a
3809  0622 d60000        	ld	a,(_HSIDivFactor,x)
3810  0625 6b09          	ld	(OFST+0,sp),a
3811                     ; 922       clockfrequency = HSI_VALUE / presc;
3813  0627 b703          	ld	c_lreg+3,a
3814  0629 3f02          	clr	c_lreg+2
3815  062b 3f01          	clr	c_lreg+1
3816  062d 3f00          	clr	c_lreg
3817  062f 96            	ldw	x,sp
3818  0630 5c            	incw	x
3819  0631 8d000000      	callf	d_rtol
3821  0635 ae2400        	ldw	x,#9216
3822  0638 bf02          	ldw	c_lreg+2,x
3823  063a ae00f4        	ldw	x,#244
3824  063d bf00          	ldw	c_lreg,x
3825  063f 96            	ldw	x,sp
3826  0640 5c            	incw	x
3827  0641 8d000000      	callf	d_ludv
3829  0645 96            	ldw	x,sp
3830  0646 1c0005        	addw	x,#OFST-4
3831  0649 8d000000      	callf	d_rtol
3833                     ; 923       break;
3835  064d 2014          	jra	L3002
3836  064f               L7471:
3837                     ; 924     case CLK_SOURCE_LSI:
3837                     ; 925       clockfrequency = LSI_VALUE;
3839  064f aef400        	ldw	x,#62464
3840  0652 1f07          	ldw	(OFST-2,sp),x
3841  0654 ae0001        	ldw	x,#1
3842                     ; 926       break;
3844  0657 2008          	jpf	LC007
3845  0659               L1571:
3846                     ; 927     case CLK_SOURCE_HSE:
3846                     ; 928       clockfrequency = HSE_VALUE;
3848  0659 ae1200        	ldw	x,#4608
3849  065c 1f07          	ldw	(OFST-2,sp),x
3850  065e ae007a        	ldw	x,#122
3851  0661               LC007:
3852  0661 1f05          	ldw	(OFST-4,sp),x
3853                     ; 929       break;
3855                     ; 930     default:
3855                     ; 931       break;
3857  0663               L3002:
3858                     ; 933   return((u32)clockfrequency);
3860  0663 96            	ldw	x,sp
3861  0664 1c0005        	addw	x,#OFST-4
3862  0667 8d000000      	callf	d_ltor
3866  066b 5b09          	addw	sp,#9
3867  066d 87            	retf	
3966                     ; 950 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
3966                     ; 951 {
3967                     	switch	.text
3968  066e               f_CLK_AdjustHSICalibrationValue:
3970  066e 88            	push	a
3971       00000000      OFST:	set	0
3974                     ; 954   assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
3976  066f 4d            	tnz	a
3977  0670 2728          	jreq	L454
3978  0672 a101          	cp	a,#1
3979  0674 2724          	jreq	L454
3980  0676 a102          	cp	a,#2
3981  0678 2720          	jreq	L454
3982  067a a103          	cp	a,#3
3983  067c 271c          	jreq	L454
3984  067e a104          	cp	a,#4
3985  0680 2718          	jreq	L454
3986  0682 a105          	cp	a,#5
3987  0684 2714          	jreq	L454
3988  0686 a106          	cp	a,#6
3989  0688 2710          	jreq	L454
3990  068a a107          	cp	a,#7
3991  068c 270c          	jreq	L454
3992  068e ae03ba        	ldw	x,#954
3993  0691 89            	pushw	x
3994  0692 ae000c        	ldw	x,#L766
3995  0695 8d000000      	callf	f_assert_failed
3997  0699 85            	popw	x
3998  069a               L454:
3999                     ; 957   CLK->HSITRIMR &= (u8)(~CLK_HSITRIMR_HSITRIM);
4001  069a c650cc        	ld	a,20684
4002  069d a4f8          	and	a,#248
4003  069f c750cc        	ld	20684,a
4004                     ; 960   CLK->HSITRIMR |= (u8)CLK_HSICalibrationValue;
4006  06a2 c650cc        	ld	a,20684
4007  06a5 1a01          	or	a,(OFST+1,sp)
4008  06a7 c750cc        	ld	20684,a
4009                     ; 962 }
4012  06aa 84            	pop	a
4013  06ab 87            	retf	
4071                     ; 979 void CLK_ClearITPendingBit(CLK_PendingBit_TypeDef CLK_PendingBit)
4071                     ; 980 {
4072                     	switch	.text
4073  06ac               f_CLK_ClearITPendingBit:
4075  06ac 88            	push	a
4076       00000000      OFST:	set	0
4079                     ; 982   assert_param(IS_CLK_PENDINGBIT_OK(CLK_PendingBit));
4081  06ad 4d            	tnz	a
4082  06ae 270f          	jreq	L664
4083  06b0 4a            	dec	a
4084  06b1 270c          	jreq	L664
4085  06b3 ae03d6        	ldw	x,#982
4086  06b6 89            	pushw	x
4087  06b7 ae000c        	ldw	x,#L766
4088  06ba 8d000000      	callf	f_assert_failed
4090  06be 85            	popw	x
4091  06bf               L664:
4092                     ; 984   if (CLK_PendingBit == (u8)CLK_PENDINGBIT_CSSD)
4094  06bf 7b01          	ld	a,(OFST+1,sp)
4095  06c1 2606          	jrne	L5702
4096                     ; 987     CLK->CSSR  &= (u8)(~CLK_CSSR_CSSD);
4098  06c3 721750c8      	bres	20680,#3
4100  06c7 2004          	jra	L7702
4101  06c9               L5702:
4102                     ; 992     CLK->SWCR &= (u8)(~CLK_SWCR_SWIF);
4104  06c9 721750c5      	bres	20677,#3
4105  06cd               L7702:
4106                     ; 995 }
4109  06cd 84            	pop	a
4110  06ce 87            	retf	
4133                     ; 1014 void CLK_SYSCLKEmergencyClear(void)
4133                     ; 1015 {
4134                     	switch	.text
4135  06cf               f_CLK_SYSCLKEmergencyClear:
4139                     ; 1016   CLK->SWCR &= (u8)(~CLK_SWCR_SWBSY);
4141  06cf 721150c5      	bres	20677,#0
4142                     ; 1017 }
4145  06d3 87            	retf	
4179                     	xdef	_CLKPrescTable
4180                     	xdef	_HSIDivFactor
4181                     	xdef	f_CLK_SYSCLKEmergencyClear
4182                     	xdef	f_CLK_ClearITPendingBit
4183                     	xdef	f_CLK_AdjustHSICalibrationValue
4184                     	xdef	f_CLK_GetClockFreq
4185                     	xdef	f_CLK_GetFlagStatus
4186                     	xdef	f_CLK_GetITStatus
4187                     	xdef	f_CLK_GetSYSCLKSource
4188                     	xdef	f_CLK_ClockSecuritySystemEnable
4189                     	xdef	f_CLK_CANConfig
4190                     	xdef	f_CLK_SWIMConfig
4191                     	xdef	f_CLK_SYSCLKConfig
4192                     	xdef	f_CLK_ITConfig
4193                     	xdef	f_CLK_CCOConfig
4194                     	xdef	f_CLK_LSIConfig
4195                     	xdef	f_CLK_HSIConfig
4196                     	xdef	f_CLK_ClockSwitchConfig
4197                     	xdef	f_CLK_PeripheralClockConfig
4198                     	xdef	f_CLK_ClockSwitchCmd
4199                     	xdef	f_CLK_CCOCmd
4200                     	xdef	f_CLK_LSICmd
4201                     	xdef	f_CLK_HSICmd
4202                     	xdef	f_CLK_HSECmd
4203                     	xdef	f_CLK_Init
4204                     	xdef	f_CLK_StructInit
4205                     	xdef	f_CLK_DeInit
4206                     	xref	f_assert_failed
4207                     	switch	.const
4208  000c               L766:
4209  000c 736f75636573  	dc.b	"souces\src\stm8_cl"
4210  001e 6b2e6300      	dc.b	"k.c",0
4211                     	xref.b	c_lreg
4231                     	xref	d_ltor
4232                     	xref	d_ludv
4233                     	xref	d_rtol
4234                     	end
