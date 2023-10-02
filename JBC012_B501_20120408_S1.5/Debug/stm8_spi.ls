   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 803                     ; 61 void SPI_DeInit(void)
 803                     ; 62 {
 804                     	switch	.text
 805  0000               f_SPI_DeInit:
 809                     ; 63   SPI->CR1    = SPI_CR1_RESET_VALUE;
 811  0000 725f5200      	clr	20992
 812                     ; 64   SPI->CR2    = SPI_CR2_RESET_VALUE;
 814  0004 725f5201      	clr	20993
 815                     ; 65   SPI->ICR    = SPI_ICR_RESET_VALUE;
 817  0008 725f5202      	clr	20994
 818                     ; 66   SPI->SR     = SPI_SR_RESET_VALUE;
 820  000c 35025203      	mov	20995,#2
 821                     ; 67   SPI->CRCPR  = SPI_CRCPR_RESET_VALUE;
 823  0010 35075205      	mov	20997,#7
 824                     ; 68 }
 827  0014 87            	retf	
1155                     ; 84 void SPI_StructInit(SPI_Init_TypeDef* SPI_InitStruct)
1155                     ; 85 {
1156                     	switch	.text
1157  0015               f_SPI_StructInit:
1161                     ; 86   SPI_InitStruct->FirstBit          = SPI_FIRSTBIT_MSB;
1163  0015 7f            	clr	(x)
1164                     ; 87   SPI_InitStruct->BaudRatePrescaler = SPI_BAUDRATEPRESCALER_2;
1166  0016 6f01          	clr	(1,x)
1167                     ; 88   SPI_InitStruct->Mode              = SPI_MODE_MASTER;
1169  0018 a604          	ld	a,#4
1170  001a e702          	ld	(2,x),a
1171                     ; 89   SPI_InitStruct->ClockPolarity     = SPI_CPOL_LOW;
1173  001c 6f03          	clr	(3,x)
1174                     ; 90   SPI_InitStruct->ClockPhase        = SPI_CPHA_1EDGE;
1176  001e 6f04          	clr	(4,x)
1177                     ; 91   SPI_InitStruct->Data_Direction    = SPI_DATADIRECTION_2LINES_FULLDUPLEX;
1179  0020 6f05          	clr	(5,x)
1180                     ; 92   SPI_InitStruct->NSS_Software      = ENABLE;
1182  0022 a601          	ld	a,#1
1183  0024 e706          	ld	(6,x),a
1184                     ; 93   SPI_InitStruct->CRCPolynomial     = (u8)0x07;
1186  0026 a607          	ld	a,#7
1187  0028 e707          	ld	(7,x),a
1188                     ; 94 }
1191  002a 87            	retf	
1228                     ; 109 void SPI_Init(SPI_Init_TypeDef* SPI_InitStruct)
1228                     ; 110 {
1229                     	switch	.text
1230  002b               f_SPI_Init:
1232  002b 89            	pushw	x
1233       00000000      OFST:	set	0
1236                     ; 113   assert_param(IS_SPI_FIRSTBIT_OK(SPI_InitStruct->FirstBit));
1238  002c f6            	ld	a,(x)
1239  002d 2710          	jreq	L61
1240  002f a180          	cp	a,#128
1241  0031 270c          	jreq	L61
1242  0033 ae0071        	ldw	x,#113
1243  0036 89            	pushw	x
1244  0037 ae0000        	ldw	x,#L366
1245  003a 8d000000      	callf	f_assert_failed
1247  003e 85            	popw	x
1248  003f               L61:
1249                     ; 114   assert_param(IS_SPI_BAUDRATE_PRESCALER_OK(SPI_InitStruct->BaudRatePrescaler));
1251  003f 1e01          	ldw	x,(OFST+1,sp)
1252  0041 e601          	ld	a,(1,x)
1253  0043 272a          	jreq	L62
1254  0045 a108          	cp	a,#8
1255  0047 2726          	jreq	L62
1256  0049 a110          	cp	a,#16
1257  004b 2722          	jreq	L62
1258  004d a118          	cp	a,#24
1259  004f 271e          	jreq	L62
1260  0051 a120          	cp	a,#32
1261  0053 271a          	jreq	L62
1262  0055 a128          	cp	a,#40
1263  0057 2716          	jreq	L62
1264  0059 a130          	cp	a,#48
1265  005b 2712          	jreq	L62
1266  005d a138          	cp	a,#56
1267  005f 270e          	jreq	L62
1268  0061 ae0072        	ldw	x,#114
1269  0064 89            	pushw	x
1270  0065 ae0000        	ldw	x,#L366
1271  0068 8d000000      	callf	f_assert_failed
1273  006c 85            	popw	x
1274  006d 1e01          	ldw	x,(OFST+1,sp)
1275  006f               L62:
1276                     ; 115   assert_param(IS_SPI_MODE_OK(SPI_InitStruct->Mode));
1278  006f e602          	ld	a,(2,x)
1279  0071 a104          	cp	a,#4
1280  0073 2712          	jreq	L63
1281  0075 e602          	ld	a,(2,x)
1282  0077 270e          	jreq	L63
1283  0079 ae0073        	ldw	x,#115
1284  007c 89            	pushw	x
1285  007d ae0000        	ldw	x,#L366
1286  0080 8d000000      	callf	f_assert_failed
1288  0084 85            	popw	x
1289  0085 1e01          	ldw	x,(OFST+1,sp)
1290  0087               L63:
1291                     ; 116   assert_param(IS_SPI_POLARITY_OK(SPI_InitStruct->ClockPolarity));
1293  0087 e603          	ld	a,(3,x)
1294  0089 2712          	jreq	L64
1295  008b a102          	cp	a,#2
1296  008d 270e          	jreq	L64
1297  008f ae0074        	ldw	x,#116
1298  0092 89            	pushw	x
1299  0093 ae0000        	ldw	x,#L366
1300  0096 8d000000      	callf	f_assert_failed
1302  009a 85            	popw	x
1303  009b 1e01          	ldw	x,(OFST+1,sp)
1304  009d               L64:
1305                     ; 117   assert_param(IS_SPI_PHASE_OK(SPI_InitStruct->ClockPhase));
1307  009d e604          	ld	a,(4,x)
1308  009f 2711          	jreq	L65
1309  00a1 4a            	dec	a
1310  00a2 270e          	jreq	L65
1311  00a4 ae0075        	ldw	x,#117
1312  00a7 89            	pushw	x
1313  00a8 ae0000        	ldw	x,#L366
1314  00ab 8d000000      	callf	f_assert_failed
1316  00af 85            	popw	x
1317  00b0 1e01          	ldw	x,(OFST+1,sp)
1318  00b2               L65:
1319                     ; 118   assert_param(IS_SPI_DATA_DIRECTION_OK(SPI_InitStruct->Data_Direction));
1321  00b2 e605          	ld	a,(5,x)
1322  00b4 271a          	jreq	L66
1323  00b6 a104          	cp	a,#4
1324  00b8 2716          	jreq	L66
1325  00ba a180          	cp	a,#128
1326  00bc 2712          	jreq	L66
1327  00be a1c0          	cp	a,#192
1328  00c0 270e          	jreq	L66
1329  00c2 ae0076        	ldw	x,#118
1330  00c5 89            	pushw	x
1331  00c6 ae0000        	ldw	x,#L366
1332  00c9 8d000000      	callf	f_assert_failed
1334  00cd 85            	popw	x
1335  00ce 1e01          	ldw	x,(OFST+1,sp)
1336  00d0               L66:
1337                     ; 119   assert_param(IS_FUNCTIONALSTATE_OK(SPI_InitStruct->NSS_Software));
1339  00d0 e606          	ld	a,(6,x)
1340  00d2 4a            	dec	a
1341  00d3 2710          	jreq	L67
1342  00d5 e606          	ld	a,(6,x)
1343  00d7 270c          	jreq	L67
1344  00d9 ae0077        	ldw	x,#119
1345  00dc 89            	pushw	x
1346  00dd ae0000        	ldw	x,#L366
1347  00e0 8d000000      	callf	f_assert_failed
1349  00e4 85            	popw	x
1350  00e5               L67:
1351                     ; 122   SPI->CR1 = SPI_CR1_RESET_VALUE;
1353  00e5 725f5200      	clr	20992
1354                     ; 123   SPI->CR2 = SPI_CR2_RESET_VALUE;
1356  00e9 725f5201      	clr	20993
1357                     ; 126   SPI->CR1 |= (u8)((u8)(SPI_InitStruct->FirstBit) |
1357                     ; 127                    (u8)(SPI_InitStruct->BaudRatePrescaler) |
1357                     ; 128                    (u8)(SPI_InitStruct->ClockPolarity) |
1357                     ; 129                    (u8)(SPI_InitStruct->ClockPhase));
1359  00ed 1e01          	ldw	x,(OFST+1,sp)
1360  00ef e601          	ld	a,(1,x)
1361  00f1 fa            	or	a,(x)
1362  00f2 ea03          	or	a,(3,x)
1363  00f4 ea04          	or	a,(4,x)
1364  00f6 ca5200        	or	a,20992
1365  00f9 c75200        	ld	20992,a
1366                     ; 132   SPI->CR2 |= (u8)(SPI_InitStruct->Data_Direction);
1368  00fc c65201        	ld	a,20993
1369  00ff ea05          	or	a,(5,x)
1370  0101 c75201        	ld	20993,a
1371                     ; 135   if (SPI_InitStruct->NSS_Software == ENABLE)
1373  0104 e606          	ld	a,(6,x)
1374  0106 4a            	dec	a
1375  0107 260e          	jrne	L566
1376                     ; 137     SPI->CR2 |= SPI_CR2_SSM;
1378  0109 72125201      	bset	20993,#1
1379                     ; 138     if (SPI_InitStruct->Mode == SPI_MODE_MASTER)
1381  010d e602          	ld	a,(2,x)
1382  010f a104          	cp	a,#4
1383  0111 2604          	jrne	L566
1384                     ; 140       SPI->CR2 |= SPI_CR2_SSI;
1386  0113 72105201      	bset	20993,#0
1387  0117               L566:
1388                     ; 145   SPI->CR1 |= (u8)(SPI_InitStruct->Mode);
1390  0117 c65200        	ld	a,20992
1391  011a ea02          	or	a,(2,x)
1392  011c c75200        	ld	20992,a
1393                     ; 148   SPI->CRCPR = SPI_InitStruct->CRCPolynomial;
1395  011f e607          	ld	a,(7,x)
1396  0121 c75205        	ld	20997,a
1397                     ; 150 }
1400  0124 85            	popw	x
1401  0125 87            	retf	
1436                     ; 168 void SPI_Cmd(FunctionalState NewState)
1436                     ; 169 {
1437                     	switch	.text
1438  0126               f_SPI_Cmd:
1440  0126 88            	push	a
1441       00000000      OFST:	set	0
1444                     ; 172   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1446  0127 a101          	cp	a,#1
1447  0129 270f          	jreq	L011
1448  012b 4d            	tnz	a
1449  012c 270c          	jreq	L011
1450  012e ae00ac        	ldw	x,#172
1451  0131 89            	pushw	x
1452  0132 ae0000        	ldw	x,#L366
1453  0135 8d000000      	callf	f_assert_failed
1455  0139 85            	popw	x
1456  013a               L011:
1457                     ; 174   if (NewState == ENABLE)
1459  013a 7b01          	ld	a,(OFST+1,sp)
1460  013c 4a            	dec	a
1461  013d 2606          	jrne	L707
1462                     ; 176     SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
1464  013f 721c5200      	bset	20992,#6
1466  0143 2004          	jra	L117
1467  0145               L707:
1468                     ; 180     SPI->CR1 &= (u8)(~SPI_CR1_SPE); /* Disable the SPI peripheral*/
1470  0145 721d5200      	bres	20992,#6
1471  0149               L117:
1472                     ; 183 }
1475  0149 84            	pop	a
1476  014a 87            	retf	
1507                     ; 198 void SPI_SendData(u8 Data)
1507                     ; 199 {
1508                     	switch	.text
1509  014b               f_SPI_SendData:
1513                     ; 200   SPI->DR = Data; /* Write in the DR register the data to be sent*/
1515  014b c75204        	ld	20996,a
1516                     ; 201 }
1519  014e 87            	retf	
1541                     ; 217 u8 SPI_ReceiveData(void)
1541                     ; 218 {
1542                     	switch	.text
1543  014f               f_SPI_ReceiveData:
1547                     ; 219   return ((u8)SPI->DR); /* Return the data in the DR register*/
1549  014f c65204        	ld	a,20996
1552  0152 87            	retf	
1588                     ; 238 void SPI_NSSInternalSoftwareCmd(FunctionalState NewState)
1588                     ; 239 {
1589                     	switch	.text
1590  0153               f_SPI_NSSInternalSoftwareCmd:
1592  0153 88            	push	a
1593       00000000      OFST:	set	0
1596                     ; 242   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1598  0154 a101          	cp	a,#1
1599  0156 270f          	jreq	L621
1600  0158 4d            	tnz	a
1601  0159 270c          	jreq	L621
1602  015b ae00f2        	ldw	x,#242
1603  015e 89            	pushw	x
1604  015f ae0000        	ldw	x,#L366
1605  0162 8d000000      	callf	f_assert_failed
1607  0166 85            	popw	x
1608  0167               L621:
1609                     ; 244   if (NewState != DISABLE)
1611  0167 7b01          	ld	a,(OFST+1,sp)
1612  0169 2706          	jreq	L557
1613                     ; 246     SPI->CR2 |= SPI_CR2_SSI; /* Set NSS pin internally by software*/
1615  016b 72105201      	bset	20993,#0
1617  016f 2004          	jra	L757
1618  0171               L557:
1619                     ; 250     SPI->CR2 &= (u8)(~SPI_CR2_SSI); /* Reset NSS pin internally by software*/
1621  0171 72115201      	bres	20993,#0
1622  0175               L757:
1623                     ; 253 }
1626  0175 84            	pop	a
1627  0176 87            	retf	
1649                     ; 269 void SPI_TransmitCRC(void)
1649                     ; 270 {
1650                     	switch	.text
1651  0177               f_SPI_TransmitCRC:
1655                     ; 271   SPI->CR2 |= SPI_CR2_CRCNEXT; /* Enable the CRC transmission*/
1657  0177 72185201      	bset	20993,#4
1658                     ; 272 }
1661  017b 87            	retf	
1698                     ; 289 void SPI_CalculateCRCCmd(FunctionalState NewState)
1698                     ; 290 {
1699                     	switch	.text
1700  017c               f_SPI_CalculateCRCCmd:
1702  017c 88            	push	a
1703       00000000      OFST:	set	0
1706                     ; 293   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1708  017d a101          	cp	a,#1
1709  017f 270f          	jreq	L241
1710  0181 4d            	tnz	a
1711  0182 270c          	jreq	L241
1712  0184 ae0125        	ldw	x,#293
1713  0187 89            	pushw	x
1714  0188 ae0000        	ldw	x,#L366
1715  018b 8d000000      	callf	f_assert_failed
1717  018f 85            	popw	x
1718  0190               L241:
1719                     ; 296   SPI_Cmd(DISABLE);
1721  0190 4f            	clr	a
1722  0191 8d260126      	callf	f_SPI_Cmd
1724                     ; 298   if (NewState == ENABLE)
1726  0195 7b01          	ld	a,(OFST+1,sp)
1727  0197 4a            	dec	a
1728  0198 2606          	jrne	L7001
1729                     ; 300     SPI->CR2 |= SPI_CR2_CRCEN; /* Enable the CRC calculation*/
1731  019a 721a5201      	bset	20993,#5
1733  019e 2004          	jra	L1101
1734  01a0               L7001:
1735                     ; 304     SPI->CR2 &= (u8)(~SPI_CR2_CRCEN); /* Disable the CRC calculation*/
1737  01a0 721b5201      	bres	20993,#5
1738  01a4               L1101:
1739                     ; 307 }
1742  01a4 84            	pop	a
1743  01a5 87            	retf	
1805                     ; 322 u8 SPI_GetCRC(SPI_CRC_Typedef SPI_CRC)
1805                     ; 323 {
1806                     	switch	.text
1807  01a6               f_SPI_GetCRC:
1809  01a6 88            	push	a
1810  01a7 88            	push	a
1811       00000001      OFST:	set	1
1814                     ; 325   u8 crcreg = 0;
1816  01a8 0f01          	clr	(OFST+0,sp)
1817                     ; 328   assert_param(IS_SPI_CRC_OK(SPI_CRC));
1819  01aa 4d            	tnz	a
1820  01ab 270f          	jreq	L651
1821  01ad 4a            	dec	a
1822  01ae 270c          	jreq	L651
1823  01b0 ae0148        	ldw	x,#328
1824  01b3 89            	pushw	x
1825  01b4 ae0000        	ldw	x,#L366
1826  01b7 8d000000      	callf	f_assert_failed
1828  01bb 85            	popw	x
1829  01bc               L651:
1830                     ; 330   if (SPI_CRC == SPI_CRC_TX)
1832  01bc 7b02          	ld	a,(OFST+1,sp)
1833  01be 2605          	jrne	L3401
1834                     ; 332     crcreg = SPI->TXCRCR;  /* Get the Tx CRC register*/
1836  01c0 c65207        	ld	a,20999
1838  01c3 2003          	jra	L5401
1839  01c5               L3401:
1840                     ; 336     crcreg = SPI->RXCRCR; /* Get the Rx CRC register*/
1842  01c5 c65206        	ld	a,20998
1843  01c8               L5401:
1844                     ; 340   return crcreg;
1848  01c8 85            	popw	x
1849  01c9 87            	retf	
1873                     ; 357 void SPI_ResetCRC(void)
1873                     ; 358 {
1874                     	switch	.text
1875  01ca               f_SPI_ResetCRC:
1879                     ; 362   SPI_CalculateCRCCmd(ENABLE) ;
1881  01ca a601          	ld	a,#1
1882  01cc 8d7c017c      	callf	f_SPI_CalculateCRCCmd
1884                     ; 365   SPI_Cmd(ENABLE);
1886  01d0 a601          	ld	a,#1
1888                     ; 367 }
1891  01d2 ac260126      	jpf	f_SPI_Cmd
1914                     ; 384 u8 SPI_GetCRCPolynomial(void)
1914                     ; 385 {
1915                     	switch	.text
1916  01d6               f_SPI_GetCRCPolynomial:
1920                     ; 386   return SPI->CRCPR; /* Return the CRC polynomial register */
1922  01d6 c65205        	ld	a,20997
1925  01d9 87            	retf	
1981                     ; 402 void SPI_BiDirectionalLineConfig(SPI_Direction_Typedef SPI_Direction)
1981                     ; 403 {
1982                     	switch	.text
1983  01da               f_SPI_BiDirectionalLineConfig:
1985  01da 88            	push	a
1986       00000000      OFST:	set	0
1989                     ; 406   assert_param(IS_SPI_DIRECTION_OK(SPI_Direction));
1991  01db 4d            	tnz	a
1992  01dc 270f          	jreq	L002
1993  01de 4a            	dec	a
1994  01df 270c          	jreq	L002
1995  01e1 ae0196        	ldw	x,#406
1996  01e4 89            	pushw	x
1997  01e5 ae0000        	ldw	x,#L366
1998  01e8 8d000000      	callf	f_assert_failed
2000  01ec 85            	popw	x
2001  01ed               L002:
2002                     ; 408   if (SPI_Direction == SPI_DIRECTION_TX)
2004  01ed 7b01          	ld	a,(OFST+1,sp)
2005  01ef 4a            	dec	a
2006  01f0 2606          	jrne	L5111
2007                     ; 410     SPI->CR2 |= SPI_CR2_BDOE; /* Set the Tx only mode*/
2009  01f2 721c5201      	bset	20993,#6
2011  01f6 2004          	jra	L7111
2012  01f8               L5111:
2013                     ; 414     SPI->CR2 &= (u8)(~SPI_CR2_BDOE); /* Set the Rx only mode*/
2015  01f8 721d5201      	bres	20993,#6
2016  01fc               L7111:
2017                     ; 417 }
2020  01fc 84            	pop	a
2021  01fd 87            	retf	
2100                     ; 436 void SPI_ITConfig(SPI_Interrupts_Typedef Spi_IT, FunctionalState NewState)
2100                     ; 437 {
2101                     	switch	.text
2102  01fe               f_SPI_ITConfig:
2104  01fe 89            	pushw	x
2105       00000000      OFST:	set	0
2108                     ; 440   assert_param(IS_SPI_INTERRUPTS_OK(Spi_IT));
2110  01ff 9e            	ld	a,xh
2111  0200 a180          	cp	a,#128
2112  0202 271b          	jreq	L212
2113  0204 9e            	ld	a,xh
2114  0205 a140          	cp	a,#64
2115  0207 2716          	jreq	L212
2116  0209 9e            	ld	a,xh
2117  020a a120          	cp	a,#32
2118  020c 2711          	jreq	L212
2119  020e 9e            	ld	a,xh
2120  020f a110          	cp	a,#16
2121  0211 270c          	jreq	L212
2122  0213 ae01b8        	ldw	x,#440
2123  0216 89            	pushw	x
2124  0217 ae0000        	ldw	x,#L366
2125  021a 8d000000      	callf	f_assert_failed
2127  021e 85            	popw	x
2128  021f               L212:
2129                     ; 441   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2131  021f 7b02          	ld	a,(OFST+2,sp)
2132  0221 a101          	cp	a,#1
2133  0223 2712          	jreq	L222
2134  0225 0d02          	tnz	(OFST+2,sp)
2135  0227 270e          	jreq	L222
2136  0229 ae01b9        	ldw	x,#441
2137  022c 89            	pushw	x
2138  022d ae0000        	ldw	x,#L366
2139  0230 8d000000      	callf	f_assert_failed
2141  0234 85            	popw	x
2142  0235 7b02          	ld	a,(OFST+2,sp)
2143  0237               L222:
2144                     ; 443   if (NewState == ENABLE)
2146  0237 4a            	dec	a
2147  0238 2607          	jrne	L7511
2148                     ; 445     SPI->ICR |= (u8)Spi_IT; /* Enable interrupt*/
2150  023a c65202        	ld	a,20994
2151  023d 1a01          	or	a,(OFST+1,sp)
2153  023f 2006          	jra	L1611
2154  0241               L7511:
2155                     ; 449     SPI->ICR &= (u8)(~(u8)Spi_IT); /* Disable interrupt*/
2157  0241 7b01          	ld	a,(OFST+1,sp)
2158  0243 43            	cpl	a
2159  0244 c45202        	and	a,20994
2160  0247               L1611:
2161  0247 c75202        	ld	20994,a
2162                     ; 452 }
2165  024a 85            	popw	x
2166  024b 87            	retf	
2287                     ; 473 FlagStatus SPI_GetFlagStatus(SPI_Flag_Typedef SPI_FLAG)
2287                     ; 474 {
2288                     	switch	.text
2289  024c               f_SPI_GetFlagStatus:
2291  024c 88            	push	a
2292  024d 88            	push	a
2293       00000001      OFST:	set	1
2296                     ; 476   FlagStatus status = RESET;
2298  024e 0f01          	clr	(OFST+0,sp)
2299                     ; 479   assert_param(IS_SPI_FLAGS_OK(SPI_FLAG));
2301  0250 a140          	cp	a,#64
2302  0252 2724          	jreq	L432
2303  0254 a120          	cp	a,#32
2304  0256 2720          	jreq	L432
2305  0258 a110          	cp	a,#16
2306  025a 271c          	jreq	L432
2307  025c a108          	cp	a,#8
2308  025e 2718          	jreq	L432
2309  0260 a102          	cp	a,#2
2310  0262 2714          	jreq	L432
2311  0264 a101          	cp	a,#1
2312  0266 2710          	jreq	L432
2313  0268 a180          	cp	a,#128
2314  026a 270c          	jreq	L432
2315  026c ae01df        	ldw	x,#479
2316  026f 89            	pushw	x
2317  0270 ae0000        	ldw	x,#L366
2318  0273 8d000000      	callf	f_assert_failed
2320  0277 85            	popw	x
2321  0278               L432:
2322                     ; 482   if ((SPI->SR & (u8)SPI_FLAG) != (u8)RESET)
2324  0278 c65203        	ld	a,20995
2325  027b 1502          	bcp	a,(OFST+1,sp)
2326  027d 2704          	jreq	L7321
2327                     ; 484     status = SET; /* SPI_FLAG is set*/
2329  027f a601          	ld	a,#1
2331  0281 2001          	jra	L1421
2332  0283               L7321:
2333                     ; 488     status = RESET; /* SPI_FLAG is reset*/
2335  0283 4f            	clr	a
2336  0284               L1421:
2337                     ; 492   return status;
2341  0284 85            	popw	x
2342  0285 87            	retf	
2388                     ; 510 ITStatus SPI_GetITStatus(SPI_Interrupts_Typedef Spi_IT)
2388                     ; 511 {
2389                     	switch	.text
2390  0286               f_SPI_GetITStatus:
2392  0286 88            	push	a
2393  0287 88            	push	a
2394       00000001      OFST:	set	1
2397                     ; 513   ITStatus pendingbitstatus = RESET;
2399  0288 0f01          	clr	(OFST+0,sp)
2400                     ; 516   assert_param(IS_SPI_PENDINGBIT_OK(Spi_IT));
2402  028a a140          	cp	a,#64
2403  028c 271f          	jreq	L642
2404  028e a120          	cp	a,#32
2405  0290 271b          	jreq	L642
2406  0292 a110          	cp	a,#16
2407  0294 2717          	jreq	L642
2408  0296 a108          	cp	a,#8
2409  0298 2713          	jreq	L642
2410  029a a102          	cp	a,#2
2411  029c 270f          	jreq	L642
2412  029e 4a            	dec	a
2413  029f 270c          	jreq	L642
2414  02a1 ae0204        	ldw	x,#516
2415  02a4 89            	pushw	x
2416  02a5 ae0000        	ldw	x,#L366
2417  02a8 8d000000      	callf	f_assert_failed
2419  02ac 85            	popw	x
2420  02ad               L642:
2421                     ; 519   if ((SPI->ICR & (u8)Spi_IT) != (u8)0x00)
2423  02ad c65202        	ld	a,20994
2424  02b0 1502          	bcp	a,(OFST+1,sp)
2425  02b2 2704          	jreq	L5621
2426                     ; 521     pendingbitstatus = SET;  /* Spi_IT is set*/
2428  02b4 a601          	ld	a,#1
2430  02b6 2001          	jra	L7621
2431  02b8               L5621:
2432                     ; 525     pendingbitstatus = RESET; /* Spi_IT is reset*/
2434  02b8 4f            	clr	a
2435  02b9               L7621:
2436                     ; 529   return pendingbitstatus;
2440  02b9 85            	popw	x
2441  02ba 87            	retf	
2483                     ; 546 void SPI_ClearFlag(SPI_Flag_Typedef SPI_FLAG)
2483                     ; 547 {
2484                     	switch	.text
2485  02bb               f_SPI_ClearFlag:
2487  02bb 88            	push	a
2488  02bc 88            	push	a
2489       00000001      OFST:	set	1
2492                     ; 549   u8 tempreg = 0;
2494  02bd 0f01          	clr	(OFST+0,sp)
2495                     ; 552   assert_param(IS_SPI_CLEAR_FLAGS_OK(SPI_FLAG));
2497  02bf a140          	cp	a,#64
2498  02c1 2718          	jreq	L062
2499  02c3 a120          	cp	a,#32
2500  02c5 2714          	jreq	L062
2501  02c7 a110          	cp	a,#16
2502  02c9 2710          	jreq	L062
2503  02cb a108          	cp	a,#8
2504  02cd 270c          	jreq	L062
2505  02cf ae0228        	ldw	x,#552
2506  02d2 89            	pushw	x
2507  02d3 ae0000        	ldw	x,#L366
2508  02d6 8d000000      	callf	f_assert_failed
2510  02da 85            	popw	x
2511  02db               L062:
2512                     ; 555   if ((SPI_FLAG == SPI_FLAG_CRCERR) || (SPI_FLAG == SPI_FLAG_WKUP))
2514  02db 7b02          	ld	a,(OFST+1,sp)
2515  02dd a110          	cp	a,#16
2516  02df 2704          	jreq	L3131
2518  02e1 a108          	cp	a,#8
2519  02e3 2609          	jrne	L1131
2520  02e5               L3131:
2521                     ; 557     SPI->SR &= (u8)(~(u8)SPI_FLAG); /* Clear the flag*/
2523  02e5 43            	cpl	a
2524  02e6 c45203        	and	a,20995
2525  02e9 c75203        	ld	20995,a
2527  02ec               L5131:
2528                     ; 569 }
2531  02ec 85            	popw	x
2532  02ed 87            	retf	
2533  02ee               L1131:
2534                     ; 561     tempreg = SPI->SR; /* Read SR register*/
2536  02ee c65203        	ld	a,20995
2537  02f1 6b01          	ld	(OFST+0,sp),a
2538                     ; 562     if (SPI_FLAG == SPI_FLAG_MODF) /* SPI_FLAG_MODF flag clear*/
2540  02f3 7b02          	ld	a,(OFST+1,sp)
2541  02f5 a120          	cp	a,#32
2542  02f7 26f3          	jrne	L5131
2543                     ; 565       SPI->CR1 |= SPI_CR1_SPE;
2545  02f9 721c5200      	bset	20992,#6
2546  02fd 20ed          	jra	L5131
2589                     ; 584 void SPI_ClearITPendingBit(SPI_Interrupts_Typedef Spi_IT)
2589                     ; 585 {
2590                     	switch	.text
2591  02ff               f_SPI_ClearITPendingBit:
2593  02ff 88            	push	a
2594  0300 88            	push	a
2595       00000001      OFST:	set	1
2598                     ; 587   u8 tempreg = 0;
2600  0301 0f01          	clr	(OFST+0,sp)
2601                     ; 590   assert_param(IS_SPI_CLEAR_FLAGS_OK(Spi_IT));
2603  0303 a140          	cp	a,#64
2604  0305 2718          	jreq	L272
2605  0307 a120          	cp	a,#32
2606  0309 2714          	jreq	L272
2607  030b a110          	cp	a,#16
2608  030d 2710          	jreq	L272
2609  030f a108          	cp	a,#8
2610  0311 270c          	jreq	L272
2611  0313 ae024e        	ldw	x,#590
2612  0316 89            	pushw	x
2613  0317 ae0000        	ldw	x,#L366
2614  031a 8d000000      	callf	f_assert_failed
2616  031e 85            	popw	x
2617  031f               L272:
2618                     ; 593   if ((Spi_IT == SPI_FLAG_CRCERR) || (Spi_IT == SPI_FLAG_WKUP))
2620  031f 7b02          	ld	a,(OFST+1,sp)
2621  0321 a110          	cp	a,#16
2622  0323 2704          	jreq	L3431
2624  0325 a108          	cp	a,#8
2625  0327 2609          	jrne	L1431
2626  0329               L3431:
2627                     ; 595     SPI->SR &= (u8)(~(u8)Spi_IT);    /* Clear the pending bit*/
2629  0329 43            	cpl	a
2630  032a c45203        	and	a,20995
2631  032d c75203        	ld	20995,a
2633  0330               L5431:
2634                     ; 607 }
2637  0330 85            	popw	x
2638  0331 87            	retf	
2639  0332               L1431:
2640                     ; 600     tempreg = SPI->SR;  /* Read SR register*/
2642  0332 c65203        	ld	a,20995
2643  0335 6b01          	ld	(OFST+0,sp),a
2644                     ; 601     if (Spi_IT == SPI_FLAG_MODF) /* SPI_FLAG_MODF pending bit clear*/
2646  0337 7b02          	ld	a,(OFST+1,sp)
2647  0339 a120          	cp	a,#32
2648  033b 26f3          	jrne	L5431
2649                     ; 603       SPI->CR1 |= SPI_CR1_SPE;   /* Write on CR1 register*/
2651  033d 721c5200      	bset	20992,#6
2652  0341 20ed          	jra	L5431
2664                     	xdef	f_SPI_ClearITPendingBit
2665                     	xdef	f_SPI_ClearFlag
2666                     	xdef	f_SPI_GetITStatus
2667                     	xdef	f_SPI_GetFlagStatus
2668                     	xdef	f_SPI_ITConfig
2669                     	xdef	f_SPI_BiDirectionalLineConfig
2670                     	xdef	f_SPI_GetCRCPolynomial
2671                     	xdef	f_SPI_GetCRC
2672                     	xdef	f_SPI_CalculateCRCCmd
2673                     	xdef	f_SPI_TransmitCRC
2674                     	xdef	f_SPI_ResetCRC
2675                     	xdef	f_SPI_NSSInternalSoftwareCmd
2676                     	xdef	f_SPI_ReceiveData
2677                     	xdef	f_SPI_SendData
2678                     	xdef	f_SPI_Cmd
2679                     	xdef	f_SPI_Init
2680                     	xdef	f_SPI_StructInit
2681                     	xdef	f_SPI_DeInit
2682                     	xref	f_assert_failed
2683                     .const:	section	.text
2684  0000               L366:
2685  0000 736f75636573  	dc.b	"souces\src\stm8_sp"
2686  0012 692e6300      	dc.b	"i.c",0
2706                     	end
