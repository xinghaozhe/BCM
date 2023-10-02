   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 803                     ; 62 u8 ITC_GetCPUCC(void)
 803                     ; 63 {
 804                     	switch	.text
 805  0000               f_ITC_GetCPUCC:
 809                     ; 64   _asm("push cc");
 812  0000 8a            	push	cc
 814                     ; 65   _asm("pop a");
 817  0001 84            	pop	a
 819                     ; 66   return; /* Ignore compiler warning, the returned value is in A register */
 822  0002 87            	retf	
 844                     ; 93 void ITC_DeInit(void)
 844                     ; 94 {
 845                     	switch	.text
 846  0003               f_ITC_DeInit:
 850                     ; 95   ITC->ISPR1 = ITC_SPRX_RESET_VALUE;
 852  0003 35ff7f70      	mov	32624,#255
 853                     ; 96   ITC->ISPR2 = ITC_SPRX_RESET_VALUE;
 855  0007 35ff7f71      	mov	32625,#255
 856                     ; 97   ITC->ISPR3 = ITC_SPRX_RESET_VALUE;
 858  000b 35ff7f72      	mov	32626,#255
 859                     ; 98   ITC->ISPR4 = ITC_SPRX_RESET_VALUE;
 861  000f 35ff7f73      	mov	32627,#255
 862                     ; 99   ITC->ISPR5 = ITC_SPRX_RESET_VALUE;
 864  0013 35ff7f74      	mov	32628,#255
 865                     ; 100   ITC->ISPR6 = ITC_SPRX_RESET_VALUE;
 867  0017 35ff7f75      	mov	32629,#255
 868                     ; 101   ITC->ISPR7 = ITC_SPRX_RESET_VALUE;
 870  001b 35ff7f76      	mov	32630,#255
 871                     ; 102   ITC->ISPR8 = ITC_SPRX_RESET_VALUE;
 873  001f 35ff7f77      	mov	32631,#255
 874                     ; 103 }
 877  0023 87            	retf	
 901                     ; 120 u8 ITC_GetSoftIntStatus(void)
 901                     ; 121 {
 902                     	switch	.text
 903  0024               f_ITC_GetSoftIntStatus:
 907                     ; 122   return (u8)(ITC_GetCPUCC() & CPU_CC_I1I0);
 909  0024 8d000000      	callf	f_ITC_GetCPUCC
 911  0028 a428          	and	a,#40
 914  002a 87            	retf	
1180                     ; 140 ITC_PriorityLevel_TypeDef ITC_GetSoftwarePriority(ITC_IrqNum_TypeDef IrqNum)
1180                     ; 141 {
1181                     	switch	.text
1182  002b               f_ITC_GetSoftwarePriority:
1184  002b 88            	push	a
1185  002c 89            	pushw	x
1186       00000002      OFST:	set	2
1189                     ; 143   u8 Value = 0;
1191  002d 0f02          	clr	(OFST+0,sp)
1192                     ; 147   assert_param(IS_ITC_IRQ_NUM_OK((u8)IrqNum));
1194  002f a119          	cp	a,#25
1195  0031 250c          	jrult	L02
1196  0033 ae0093        	ldw	x,#147
1197  0036 89            	pushw	x
1198  0037 ae0000        	ldw	x,#L536
1199  003a 8d000000      	callf	f_assert_failed
1201  003e 85            	popw	x
1202  003f               L02:
1203                     ; 150   Mask = (u8)(0x03U << (((u8)IrqNum % 4U) * 2U));
1205  003f 7b03          	ld	a,(OFST+1,sp)
1206  0041 a403          	and	a,#3
1207  0043 48            	sll	a
1208  0044 5f            	clrw	x
1209  0045 97            	ld	xl,a
1210  0046 a603          	ld	a,#3
1211  0048 5d            	tnzw	x
1212  0049 2704          	jreq	L42
1213  004b               L62:
1214  004b 48            	sll	a
1215  004c 5a            	decw	x
1216  004d 26fc          	jrne	L62
1217  004f               L42:
1218  004f 6b01          	ld	(OFST-1,sp),a
1219                     ; 152   switch (IrqNum)
1221  0051 7b03          	ld	a,(OFST+1,sp)
1223                     ; 193     default:
1223                     ; 194       break;
1224  0053 a119          	cp	a,#25
1225  0055 245d          	jruge	L146
1226  0057 8d000000      	callf	d_jctab
1228  005b               L23:
1229  005b 0034          	dc.w	L174-L23
1230  005d 0034          	dc.w	L174-L23
1231  005f 0034          	dc.w	L174-L23
1232  0061 0034          	dc.w	L174-L23
1233  0063 0039          	dc.w	L374-L23
1234  0065 0039          	dc.w	L374-L23
1235  0067 0039          	dc.w	L374-L23
1236  0069 0039          	dc.w	L374-L23
1237  006b 003e          	dc.w	L574-L23
1238  006d 003e          	dc.w	L574-L23
1239  006f 003e          	dc.w	L574-L23
1240  0071 003e          	dc.w	L574-L23
1241  0073 0043          	dc.w	L774-L23
1242  0075 0043          	dc.w	L774-L23
1243  0077 0043          	dc.w	L774-L23
1244  0079 0043          	dc.w	L774-L23
1245  007b 0048          	dc.w	L105-L23
1246  007d 0048          	dc.w	L105-L23
1247  007f 0048          	dc.w	L105-L23
1248  0081 0048          	dc.w	L105-L23
1249  0083 004d          	dc.w	L305-L23
1250  0085 004d          	dc.w	L305-L23
1251  0087 004d          	dc.w	L305-L23
1252  0089 004d          	dc.w	L305-L23
1253  008b 0052          	dc.w	L505-L23
1254  008d 2025          	jra	L146
1255  008f               L174:
1256                     ; 154     case TLI_IRQ_N: /* TLI software priority can be read but has no meaning */
1256                     ; 155     case AWU_IRQ_N:
1256                     ; 156     case CLK_IRQ_N:
1256                     ; 157     case PORTA_IRQ_N:
1256                     ; 158       Value = (u8)(ITC->ISPR1 & Mask); /* Read software priority */
1258  008f c67f70        	ld	a,32624
1259                     ; 159       break;
1261  0092 201c          	jpf	LC001
1262  0094               L374:
1263                     ; 160     case PORTB_IRQ_N:
1263                     ; 161     case PORTC_IRQ_N:
1263                     ; 162     case PORTD_IRQ_N:
1263                     ; 163     case PORTE_IRQ_N:
1263                     ; 164       Value = (u8)(ITC->ISPR2 & Mask); /* Read software priority */
1265  0094 c67f71        	ld	a,32625
1266                     ; 165       break;
1268  0097 2017          	jpf	LC001
1269  0099               L574:
1270                     ; 166     case CAN_RX_IRQ_N:
1270                     ; 167     case CAN_TX_IRQ_N:
1270                     ; 168     case SPI_IRQ_N:
1270                     ; 169     case TIM1_OVF_IRQ_N:
1270                     ; 170       Value = (u8)(ITC->ISPR3 & Mask); /* Read software priority */
1272  0099 c67f72        	ld	a,32626
1273                     ; 171       break;
1275  009c 2012          	jpf	LC001
1276  009e               L774:
1277                     ; 172     case TIM1_CAPCOM_IRQ_N:
1277                     ; 173     case TIM2_OVF_IRQ_N:
1277                     ; 174     case TIM2_CAPCOM_IRQ_N:
1277                     ; 175     case TIM3_OVF_IRQ_N:
1277                     ; 176       Value = (u8)(ITC->ISPR4 & Mask); /* Read software priority */
1279  009e c67f73        	ld	a,32627
1280                     ; 177       break;
1282  00a1 200d          	jpf	LC001
1283  00a3               L105:
1284                     ; 178     case TIM3_CAPCOM_IRQ_N:
1284                     ; 179     case USART_TX_IRQ_N:
1284                     ; 180     case USART_RX_IRQ_N:
1284                     ; 181     case I2C_IRQ_N:
1284                     ; 182       Value = (u8)(ITC->ISPR5 & Mask); /* Read software priority */
1286  00a3 c67f74        	ld	a,32628
1287                     ; 183       break;
1289  00a6 2008          	jpf	LC001
1290  00a8               L305:
1291                     ; 184     case LINUART_TX_IRQ_N:
1291                     ; 185     case LINUART_RX_IRQ_N:
1291                     ; 186     case ADC_IRQ_N:
1291                     ; 187     case TIM4_OVF_IRQ_N:
1291                     ; 188       Value = (u8)(ITC->ISPR6 & Mask); /* Read software priority */
1293  00a8 c67f75        	ld	a,32629
1294                     ; 189       break;
1296  00ab 2003          	jpf	LC001
1297  00ad               L505:
1298                     ; 190     case EEPROM_EEC_IRQ_N:
1298                     ; 191       Value = (u8)(ITC->ISPR7 & Mask); /* Read software priority */
1300  00ad c67f76        	ld	a,32630
1301  00b0               LC001:
1302  00b0 1401          	and	a,(OFST-1,sp)
1303  00b2 6b02          	ld	(OFST+0,sp),a
1304                     ; 192       break;
1306                     ; 193     default:
1306                     ; 194       break;
1308  00b4               L146:
1309                     ; 197   Value >>= (u8)(((u8)IrqNum % 4u) * 2u);
1311  00b4 7b03          	ld	a,(OFST+1,sp)
1312  00b6 a403          	and	a,#3
1313  00b8 48            	sll	a
1314  00b9 5f            	clrw	x
1315  00ba 97            	ld	xl,a
1316  00bb 7b02          	ld	a,(OFST+0,sp)
1317  00bd 5d            	tnzw	x
1318  00be 2704          	jreq	L43
1319  00c0               L63:
1320  00c0 44            	srl	a
1321  00c1 5a            	decw	x
1322  00c2 26fc          	jrne	L63
1323  00c4               L43:
1324                     ; 199   return((ITC_PriorityLevel_TypeDef)Value);
1328  00c4 5b03          	addw	sp,#3
1329  00c6 87            	retf	
1390                     ; 219 void ITC_SetSoftwarePriority(ITC_IrqNum_TypeDef IrqNum, ITC_PriorityLevel_TypeDef PriorityValue)
1390                     ; 220 {
1391                     	switch	.text
1392  00c7               f_ITC_SetSoftwarePriority:
1394  00c7 89            	pushw	x
1395  00c8 89            	pushw	x
1396       00000002      OFST:	set	2
1399                     ; 226   assert_param(IS_ITC_IRQ_NUM_OK((u8)IrqNum));
1401  00c9 9e            	ld	a,xh
1402  00ca a119          	cp	a,#25
1403  00cc 250c          	jrult	L44
1404  00ce ae00e2        	ldw	x,#226
1405  00d1 89            	pushw	x
1406  00d2 ae0000        	ldw	x,#L536
1407  00d5 8d000000      	callf	f_assert_failed
1409  00d9 85            	popw	x
1410  00da               L44:
1411                     ; 227   assert_param(IS_ITC_PRIORITY_VALUE_OK(PriorityValue));
1413  00da 7b04          	ld	a,(OFST+2,sp)
1414  00dc a102          	cp	a,#2
1415  00de 2717          	jreq	L45
1416  00e0 4a            	dec	a
1417  00e1 2714          	jreq	L45
1418  00e3 7b04          	ld	a,(OFST+2,sp)
1419  00e5 2710          	jreq	L45
1420  00e7 a103          	cp	a,#3
1421  00e9 270c          	jreq	L45
1422  00eb ae00e3        	ldw	x,#227
1423  00ee 89            	pushw	x
1424  00ef ae0000        	ldw	x,#L536
1425  00f2 8d000000      	callf	f_assert_failed
1427  00f6 85            	popw	x
1428  00f7               L45:
1429                     ; 230   assert_param(IS_ITC_INTERRUPTS_DISABLED);
1431  00f7 8d240024      	callf	f_ITC_GetSoftIntStatus
1433  00fb a128          	cp	a,#40
1434  00fd 270c          	jreq	L46
1435  00ff ae00e6        	ldw	x,#230
1436  0102 89            	pushw	x
1437  0103 ae0000        	ldw	x,#L536
1438  0106 8d000000      	callf	f_assert_failed
1440  010a 85            	popw	x
1441  010b               L46:
1442                     ; 234   Mask = (u8)(~(u8)(0x03U << (((u8)IrqNum % 4U) * 2U)));
1444  010b 7b03          	ld	a,(OFST+1,sp)
1445  010d a403          	and	a,#3
1446  010f 48            	sll	a
1447  0110 5f            	clrw	x
1448  0111 97            	ld	xl,a
1449  0112 a603          	ld	a,#3
1450  0114 5d            	tnzw	x
1451  0115 2704          	jreq	L07
1452  0117               L27:
1453  0117 48            	sll	a
1454  0118 5a            	decw	x
1455  0119 26fc          	jrne	L27
1456  011b               L07:
1457  011b 43            	cpl	a
1458  011c 6b01          	ld	(OFST-1,sp),a
1459                     ; 237   NewPriority = (u8)((u8)(PriorityValue) << (((u8)IrqNum % 4U) * 2U));
1461  011e 7b03          	ld	a,(OFST+1,sp)
1462  0120 a403          	and	a,#3
1463  0122 48            	sll	a
1464  0123 5f            	clrw	x
1465  0124 97            	ld	xl,a
1466  0125 7b04          	ld	a,(OFST+2,sp)
1467  0127 5d            	tnzw	x
1468  0128 2704          	jreq	L47
1469  012a               L67:
1470  012a 48            	sll	a
1471  012b 5a            	decw	x
1472  012c 26fc          	jrne	L67
1473  012e               L47:
1474  012e 6b02          	ld	(OFST+0,sp),a
1475                     ; 239   switch (IrqNum)
1477  0130 7b03          	ld	a,(OFST+1,sp)
1479                     ; 295     default:
1479                     ; 296     break;
1480  0132 a119          	cp	a,#25
1481  0134 2504acee01ee  	jruge	L317
1482  013a 8d000000      	callf	d_jctab
1484  013e               L201:
1485  013e 0034          	dc.w	L346-L201
1486  0140 0034          	dc.w	L346-L201
1487  0142 0034          	dc.w	L346-L201
1488  0144 0034          	dc.w	L346-L201
1489  0146 0046          	dc.w	L546-L201
1490  0148 0046          	dc.w	L546-L201
1491  014a 0046          	dc.w	L546-L201
1492  014c 0046          	dc.w	L546-L201
1493  014e 0058          	dc.w	L746-L201
1494  0150 0058          	dc.w	L746-L201
1495  0152 0058          	dc.w	L746-L201
1496  0154 0058          	dc.w	L746-L201
1497  0156 006a          	dc.w	L156-L201
1498  0158 006a          	dc.w	L156-L201
1499  015a 006a          	dc.w	L156-L201
1500  015c 006a          	dc.w	L156-L201
1501  015e 007c          	dc.w	L356-L201
1502  0160 007c          	dc.w	L356-L201
1503  0162 007c          	dc.w	L356-L201
1504  0164 007c          	dc.w	L356-L201
1505  0166 008e          	dc.w	L556-L201
1506  0168 008e          	dc.w	L556-L201
1507  016a 008e          	dc.w	L556-L201
1508  016c 008e          	dc.w	L556-L201
1509  016e 00a0          	dc.w	L756-L201
1510  0170 207c          	jra	L317
1511  0172               L346:
1512                     ; 242     case TLI_IRQ_N: /* TLI software priority can be written but has no meaning */
1512                     ; 243     case AWU_IRQ_N:
1512                     ; 244     case CLK_IRQ_N:
1512                     ; 245     case PORTA_IRQ_N:
1512                     ; 246       ITC->ISPR1 &= Mask;
1514  0172 c67f70        	ld	a,32624
1515  0175 1401          	and	a,(OFST-1,sp)
1516  0177 c77f70        	ld	32624,a
1517                     ; 247       ITC->ISPR1 |= NewPriority;
1519  017a c67f70        	ld	a,32624
1520  017d 1a02          	or	a,(OFST+0,sp)
1521  017f c77f70        	ld	32624,a
1522                     ; 248     break;
1524  0182 206a          	jra	L317
1525  0184               L546:
1526                     ; 250     case PORTB_IRQ_N:
1526                     ; 251     case PORTC_IRQ_N:
1526                     ; 252     case PORTD_IRQ_N:
1526                     ; 253     case PORTE_IRQ_N:
1526                     ; 254       ITC->ISPR2 &= Mask;
1528  0184 c67f71        	ld	a,32625
1529  0187 1401          	and	a,(OFST-1,sp)
1530  0189 c77f71        	ld	32625,a
1531                     ; 255       ITC->ISPR2 |= NewPriority;
1533  018c c67f71        	ld	a,32625
1534  018f 1a02          	or	a,(OFST+0,sp)
1535  0191 c77f71        	ld	32625,a
1536                     ; 256     break;
1538  0194 2058          	jra	L317
1539  0196               L746:
1540                     ; 258     case CAN_RX_IRQ_N:
1540                     ; 259     case CAN_TX_IRQ_N:
1540                     ; 260     case SPI_IRQ_N:
1540                     ; 261     case TIM1_OVF_IRQ_N:
1540                     ; 262       ITC->ISPR3 &= Mask;
1542  0196 c67f72        	ld	a,32626
1543  0199 1401          	and	a,(OFST-1,sp)
1544  019b c77f72        	ld	32626,a
1545                     ; 263       ITC->ISPR3 |= NewPriority;
1547  019e c67f72        	ld	a,32626
1548  01a1 1a02          	or	a,(OFST+0,sp)
1549  01a3 c77f72        	ld	32626,a
1550                     ; 264     break;
1552  01a6 2046          	jra	L317
1553  01a8               L156:
1554                     ; 266     case TIM1_CAPCOM_IRQ_N:
1554                     ; 267     case TIM2_OVF_IRQ_N:
1554                     ; 268     case TIM2_CAPCOM_IRQ_N:
1554                     ; 269     case TIM3_OVF_IRQ_N:
1554                     ; 270       ITC->ISPR4 &= Mask;
1556  01a8 c67f73        	ld	a,32627
1557  01ab 1401          	and	a,(OFST-1,sp)
1558  01ad c77f73        	ld	32627,a
1559                     ; 271       ITC->ISPR4 |= NewPriority;
1561  01b0 c67f73        	ld	a,32627
1562  01b3 1a02          	or	a,(OFST+0,sp)
1563  01b5 c77f73        	ld	32627,a
1564                     ; 272     break;
1566  01b8 2034          	jra	L317
1567  01ba               L356:
1568                     ; 274     case TIM3_CAPCOM_IRQ_N:
1568                     ; 275     case USART_TX_IRQ_N:
1568                     ; 276     case USART_RX_IRQ_N:
1568                     ; 277     case I2C_IRQ_N:
1568                     ; 278       ITC->ISPR5 &= Mask;
1570  01ba c67f74        	ld	a,32628
1571  01bd 1401          	and	a,(OFST-1,sp)
1572  01bf c77f74        	ld	32628,a
1573                     ; 279       ITC->ISPR5 |= NewPriority;
1575  01c2 c67f74        	ld	a,32628
1576  01c5 1a02          	or	a,(OFST+0,sp)
1577  01c7 c77f74        	ld	32628,a
1578                     ; 280     break;
1580  01ca 2022          	jra	L317
1581  01cc               L556:
1582                     ; 282     case LINUART_TX_IRQ_N:
1582                     ; 283     case LINUART_RX_IRQ_N:
1582                     ; 284     case ADC_IRQ_N:
1582                     ; 285     case TIM4_OVF_IRQ_N:
1582                     ; 286       ITC->ISPR6 &= Mask;
1584  01cc c67f75        	ld	a,32629
1585  01cf 1401          	and	a,(OFST-1,sp)
1586  01d1 c77f75        	ld	32629,a
1587                     ; 287       ITC->ISPR6 |= NewPriority;
1589  01d4 c67f75        	ld	a,32629
1590  01d7 1a02          	or	a,(OFST+0,sp)
1591  01d9 c77f75        	ld	32629,a
1592                     ; 288     break;
1594  01dc 2010          	jra	L317
1595  01de               L756:
1596                     ; 290     case EEPROM_EEC_IRQ_N:
1596                     ; 291       ITC->ISPR7 &= Mask;
1598  01de c67f76        	ld	a,32630
1599  01e1 1401          	and	a,(OFST-1,sp)
1600  01e3 c77f76        	ld	32630,a
1601                     ; 292       ITC->ISPR7 |= NewPriority;
1603  01e6 c67f76        	ld	a,32630
1604  01e9 1a02          	or	a,(OFST+0,sp)
1605  01eb c77f76        	ld	32630,a
1606                     ; 293     break;
1608                     ; 295     default:
1608                     ; 296     break;
1610  01ee               L317:
1611                     ; 300 }
1614  01ee 5b04          	addw	sp,#4
1615  01f0 87            	retf	
1627                     	xdef	f_ITC_GetSoftwarePriority
1628                     	xdef	f_ITC_SetSoftwarePriority
1629                     	xdef	f_ITC_GetSoftIntStatus
1630                     	xdef	f_ITC_DeInit
1631                     	xdef	f_ITC_GetCPUCC
1632                     	xref	f_assert_failed
1633                     .const:	section	.text
1634  0000               L536:
1635  0000 736f75636573  	dc.b	"souces\src\stm8_it"
1636  0012 632e6300      	dc.b	"c.c",0
1637                     	xref.b	c_x
1657                     	xref	d_jctab
1658                     	end
