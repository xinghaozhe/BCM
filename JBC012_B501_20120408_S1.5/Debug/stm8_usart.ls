   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 899                     ; 77 void USART_ClearFlag(USART_Flag_TypeDef USART_FLAG)
 899                     ; 78 {
 900                     	switch	.text
 901  0000               f_USART_ClearFlag:
 903  0000 88            	push	a
 904  0001 88            	push	a
 905       00000001      OFST:	set	1
 908                     ; 79   u8 dummy = 0x00;
 910  0002 0f01          	clr	(OFST+0,sp)
 911                     ; 80   assert_param(IS_USART_FLAG_VALUE_OK(USART_FLAG));
 913  0004 a177          	cp	a,#119
 914  0006 272f          	jreq	L21
 915  0008 a166          	cp	a,#102
 916  000a 272b          	jreq	L21
 917  000c a120          	cp	a,#32
 918  000e 2727          	jreq	L21
 919  0010 a155          	cp	a,#85
 920  0012 2723          	jreq	L21
 921  0014 a144          	cp	a,#68
 922  0016 271f          	jreq	L21
 923  0018 a153          	cp	a,#83
 924  001a 271b          	jreq	L21
 925  001c a102          	cp	a,#2
 926  001e 2717          	jreq	L21
 927  0020 a101          	cp	a,#1
 928  0022 2713          	jreq	L21
 929  0024 4d            	tnz	a
 930  0025 2710          	jreq	L21
 931  0027 a164          	cp	a,#100
 932  0029 270c          	jreq	L21
 933  002b ae0050        	ldw	x,#80
 934  002e 89            	pushw	x
 935  002f ae0008        	ldw	x,#L525
 936  0032 8d000000      	callf	f_assert_failed
 938  0036 85            	popw	x
 939  0037               L21:
 940                     ; 81   switch (USART_FLAG)
 942  0037 7b02          	ld	a,(OFST+1,sp)
 944                     ; 116     default:
 944                     ; 117       break;
 945  0039 2730          	jreq	L734
 946  003b 4a            	dec	a
 947  003c 272d          	jreq	L734
 948  003e 4a            	dec	a
 949  003f 272a          	jreq	L734
 950  0041 a01e          	sub	a,#30
 951  0043 2731          	jreq	L144
 952  0045 a024          	sub	a,#36
 953  0047 2722          	jreq	L734
 954  0049 a00f          	sub	a,#15
 955  004b 271e          	jreq	L734
 956  004d a002          	sub	a,#2
 957  004f 271a          	jreq	L734
 958  0051 a00f          	sub	a,#15
 959  0053 2727          	jreq	L344
 960  0055 a002          	sub	a,#2
 961  0057 2709          	jreq	L534
 962  0059 a011          	sub	a,#17
 963  005b 2623          	jrne	L135
 964                     ; 84     case USART_FLAG_TXE:
 964                     ; 85       USART->DR = (u8)(0x00);
 966  005d c75231        	ld	21041,a
 967                     ; 86 		  break;
 969  0060 201e          	jra	L135
 970  0062               L534:
 971                     ; 88     case USART_FLAG_TC:
 971                     ; 89       dummy = USART->SR;
 973  0062 c65230        	ld	a,21040
 974                     ; 90       USART->DR = (u8)(0x00);
 976  0065 725f5231      	clr	21041
 977                     ; 91       break;
 979  0069 2015          	jra	L135
 980  006b               L734:
 981                     ; 93     case USART_FLAG_RXNE:
 981                     ; 94       /*< Clear the Idle Detection flag             */
 981                     ; 95     case USART_FLAG_IDLE:
 981                     ; 96       /*< Clear the Overrun Error flag              */
 981                     ; 97     case USART_FLAG_ORE:
 981                     ; 98       /*< Clear the Noise Error flag                */
 981                     ; 99     case USART_FLAG_NE:
 981                     ; 100       /*< Clear the Framing Error flag              */
 981                     ; 101     case USART_FLAG_FE:
 981                     ; 102       /*< Clear the Parity Error flag               */
 981                     ; 103     case USART_FLAG_PE:
 981                     ; 104       dummy = USART->SR; /*< Read Status Register */ /*TBD*/
 983  006b c65230        	ld	a,21040
 984                     ; 105       dummy = USART->SR; /*< Read Status Register */
 986  006e c65230        	ld	a,21040
 987                     ; 107       dummy = USART->DR; /*< Read Data Register   */
 989  0071 c65231        	ld	a,21041
 990                     ; 108       break;
 992  0074 200a          	jra	L135
 993  0076               L144:
 994                     ; 109     case USART_FLAG_SBK:
 994                     ; 110       USART->CR2 &= (u8)~(USART_CR2_SBK);
 996  0076 72115235      	bres	21045,#0
 997                     ; 111       break;
 999  007a 2004          	jra	L135
1000  007c               L344:
1001                     ; 113     case USART_FLAG_LBD:
1001                     ; 114       USART->CR4 &= (u8)~(USART_CR4_LBDF);
1003  007c 72195237      	bres	21047,#4
1004                     ; 115       break;
1006                     ; 116     default:
1006                     ; 117       break;
1008  0080               L135:
1009                     ; 119 }
1012  0080 85            	popw	x
1013  0081 87            	retf	
1056                     ; 145 void USART_ClearITPendingBit(USART_Flag_TypeDef USART_FLAG)
1056                     ; 146 {
1057                     	switch	.text
1058  0082               f_USART_ClearITPendingBit:
1060  0082 88            	push	a
1061  0083 88            	push	a
1062       00000001      OFST:	set	1
1065                     ; 148   assert_param(IS_USART_ITPENDINGBIT_VALUE_OK(USART_FLAG));
1067  0084 a177          	cp	a,#119
1068  0086 2723          	jreq	L42
1069  0088 a166          	cp	a,#102
1070  008a 271f          	jreq	L42
1071  008c a155          	cp	a,#85
1072  008e 271b          	jreq	L42
1073  0090 a144          	cp	a,#68
1074  0092 2717          	jreq	L42
1075  0094 a153          	cp	a,#83
1076  0096 2713          	jreq	L42
1077  0098 4d            	tnz	a
1078  0099 2710          	jreq	L42
1079  009b a164          	cp	a,#100
1080  009d 270c          	jreq	L42
1081  009f ae0094        	ldw	x,#148
1082  00a2 89            	pushw	x
1083  00a3 ae0008        	ldw	x,#L525
1084  00a6 8d000000      	callf	f_assert_failed
1086  00aa 85            	popw	x
1087  00ab               L42:
1088                     ; 149   switch (USART_FLAG)
1090  00ab 7b02          	ld	a,(OFST+1,sp)
1092                     ; 179     case USART_FLAG_NE:
1092                     ; 180     case USART_FLAG_FE:
1092                     ; 181     case USART_FLAG_SBK:
1092                     ; 182     default:
1092                     ; 183       break;
1093  00ad 2726          	jreq	L145
1094  00af a044          	sub	a,#68
1095  00b1 2722          	jreq	L145
1096  00b3 a00f          	sub	a,#15
1097  00b5 271e          	jreq	L145
1098  00b7 a002          	sub	a,#2
1099  00b9 2720          	jreq	LC001
1100  00bb a00f          	sub	a,#15
1101  00bd 2721          	jreq	L345
1102  00bf a002          	sub	a,#2
1103  00c1 2709          	jreq	L535
1104  00c3 a011          	sub	a,#17
1105  00c5 261d          	jrne	L175
1106                     ; 152     case USART_FLAG_TXE:
1106                     ; 153       USART->DR = (u8)(0x00);
1108  00c7 c75231        	ld	21041,a
1109                     ; 154 		   break;
1111  00ca 2018          	jra	L175
1112  00cc               L535:
1113                     ; 156     case USART_FLAG_TC:
1113                     ; 157      dummy = USART->SR;
1115  00cc c65230        	ld	a,21040
1116                     ; 158      USART->DR = (u8)(0x00);
1118  00cf 725f5231      	clr	21041
1119                     ; 159       break;
1121  00d3 200f          	jra	L175
1122                     ; 161     case USART_FLAG_RXNE:
1122                     ; 162       dummy = USART->DR; /*< Read Data Register   */
1123                     ; 163       break;
1125  00d5               L145:
1126                     ; 165     case USART_FLAG_IDLE:
1126                     ; 166       /*< Clear the Overrun Error flag              */
1126                     ; 167     case USART_FLAG_ORE:
1126                     ; 168       /*< Clear the Parity Error flag               */
1126                     ; 169     case USART_FLAG_PE:
1126                     ; 170       dummy = USART->SR; /*< Read Status Register */ /*TBD*/
1128  00d5 c65230        	ld	a,21040
1129                     ; 171       dummy = USART->SR; /*< Read Status Register */
1131  00d8 c65230        	ld	a,21040
1132                     ; 172       dummy = USART->DR; /*< Read Data Register   */
1134  00db               LC001:
1136  00db c65231        	ld	a,21041
1137                     ; 173       break;
1139  00de 2004          	jra	L175
1140  00e0               L345:
1141                     ; 176     case USART_FLAG_LBD:
1141                     ; 177       USART->CR4 &= (u8)~(USART_CR4_LBDF);
1143  00e0 72195237      	bres	21047,#4
1144                     ; 178       break;
1146                     ; 179     case USART_FLAG_NE:
1146                     ; 180     case USART_FLAG_FE:
1146                     ; 181     case USART_FLAG_SBK:
1146                     ; 182     default:
1146                     ; 183       break;
1148  00e4               L175:
1149                     ; 185 }
1152  00e4 85            	popw	x
1153  00e5 87            	retf	
1207                     ; 204 void USART_Cmd(FunctionalState NewState)
1207                     ; 205 {
1208                     	switch	.text
1209  00e6               f_USART_Cmd:
1213                     ; 206   if (NewState)
1215  00e6 4d            	tnz	a
1216  00e7 2705          	jreq	L126
1217                     ; 208     USART->CR1 &= (u8)(~USART_CR1_USARTD); /**< USART Enable */
1219  00e9 721b5234      	bres	21044,#5
1222  00ed 87            	retf	
1223  00ee               L126:
1224                     ; 212     USART->CR1 |= USART_CR1_USARTD;  /**< USART Disable (for low power consumption) */
1226  00ee 721a5234      	bset	21044,#5
1227                     ; 214 }
1230  00f2 87            	retf	
1261                     ; 231 void USART_DeInit(void)
1261                     ; 232 {
1262                     	switch	.text
1263  00f3               f_USART_DeInit:
1265       00000001      OFST:	set	1
1268                     ; 237   dummy = USART->SR;
1270  00f3 c65230        	ld	a,21040
1271                     ; 238   dummy = USART->DR;
1273  00f6 c65231        	ld	a,21041
1274                     ; 240   USART->BRR2 = USART_BRR2_RESET_VALUE;  /*< Set USART_BRR2 to reset value 0x00 */
1276  00f9 725f5233      	clr	21043
1277                     ; 241   USART->BRR1 = USART_BRR1_RESET_VALUE;  /*< Set USART_BRR1 to reset value 0x00 */
1279  00fd 725f5232      	clr	21042
1280                     ; 243   USART->CR1 = USART_CR1_RESET_VALUE; /*< Set USART_CR1 to reset value 0x00  */
1282  0101 725f5234      	clr	21044
1283                     ; 244   USART->CR2 = USART_CR2_RESET_VALUE; /*< Set USART_CR2 to reset value 0x00  */
1285  0105 725f5235      	clr	21045
1286                     ; 245   USART->CR3 = USART_CR3_RESET_VALUE;  /*< Set USART_CR3 to reset value 0x00  */
1288  0109 725f5236      	clr	21046
1289                     ; 246   USART->CR4 = USART_CR4_RESET_VALUE;  /*< Set USART_CR4 to reset value 0x00  */
1291  010d 725f5237      	clr	21047
1292                     ; 247   USART->CR5 = USART_CR5_RESET_VALUE; /*< Set USART_CR5 to reset value 0x00  */
1294  0111 725f5238      	clr	21048
1295                     ; 249   USART->GTR = USART_GTR_RESET_VALUE;
1297  0115 725f5239      	clr	21049
1298                     ; 250   USART->PSCR = USART_PSCR_RESET_VALUE;
1300  0119 725f523a      	clr	21050
1301                     ; 251 }
1304  011d 87            	retf	
1378                     ; 282 FlagStatus USART_GetFlagStatus(USART_Flag_TypeDef USART_FLAG)
1378                     ; 283 {
1379                     	switch	.text
1380  011e               f_USART_GetFlagStatus:
1382  011e 88            	push	a
1383  011f 89            	pushw	x
1384       00000002      OFST:	set	2
1387                     ; 285   FlagStatus status = RESET;
1389  0120 0f02          	clr	(OFST+0,sp)
1390                     ; 286   u8 itpos = 0;
1392                     ; 289   assert_param(IS_USART_FLAG_VALUE_OK(USART_FLAG));
1394  0122 7b03          	ld	a,(OFST+1,sp)
1395  0124 a177          	cp	a,#119
1396  0126 2732          	jreq	L24
1397  0128 a166          	cp	a,#102
1398  012a 272e          	jreq	L24
1399  012c a120          	cp	a,#32
1400  012e 272a          	jreq	L24
1401  0130 a155          	cp	a,#85
1402  0132 2726          	jreq	L24
1403  0134 a144          	cp	a,#68
1404  0136 2722          	jreq	L24
1405  0138 a153          	cp	a,#83
1406  013a 271e          	jreq	L24
1407  013c a102          	cp	a,#2
1408  013e 271a          	jreq	L24
1409  0140 a101          	cp	a,#1
1410  0142 2716          	jreq	L24
1411  0144 7b03          	ld	a,(OFST+1,sp)
1412  0146 2712          	jreq	L24
1413  0148 a164          	cp	a,#100
1414  014a 270e          	jreq	L24
1415  014c ae0121        	ldw	x,#289
1416  014f 89            	pushw	x
1417  0150 ae0008        	ldw	x,#L525
1418  0153 8d000000      	callf	f_assert_failed
1420  0157 85            	popw	x
1421  0158 7b03          	ld	a,(OFST+1,sp)
1422  015a               L24:
1423                     ; 292   itpos = (u8)((u8)1 << (u8)((u8)USART_FLAG & (u8)0x0F));
1425  015a a40f          	and	a,#15
1426  015c 5f            	clrw	x
1427  015d 97            	ld	xl,a
1428  015e a601          	ld	a,#1
1429  0160 5d            	tnzw	x
1430  0161 2704          	jreq	L64
1431  0163               L05:
1432  0163 48            	sll	a
1433  0164 5a            	decw	x
1434  0165 26fc          	jrne	L05
1435  0167               L64:
1436  0167 6b01          	ld	(OFST-1,sp),a
1437                     ; 295   switch (USART_FLAG)
1439  0169 7b03          	ld	a,(OFST+1,sp)
1441                     ; 345       break;
1442  016b 2722          	jreq	L146
1443  016d 4a            	dec	a
1444  016e 271f          	jreq	L146
1445  0170 4a            	dec	a
1446  0171 271c          	jreq	L146
1447  0173 a01e          	sub	a,#30
1448  0175 2728          	jreq	L546
1449  0177 a024          	sub	a,#36
1450  0179 2714          	jreq	L146
1451  017b a00f          	sub	a,#15
1452  017d 2710          	jreq	L146
1453  017f a002          	sub	a,#2
1454  0181 270c          	jreq	L146
1455  0183 a00f          	sub	a,#15
1456  0185 270d          	jreq	L346
1457  0187 a002          	sub	a,#2
1458  0189 2704          	jreq	L146
1459  018b a011          	sub	a,#17
1460                     ; 343     default:
1460                     ; 344       status = SET;
1461                     ; 345       break;
1463  018d 260c          	jrne	LC003
1464  018f               L146:
1465                     ; 297     case USART_FLAG_TXE:
1465                     ; 298     case USART_FLAG_TC:
1465                     ; 299     case USART_FLAG_RXNE:
1465                     ; 300     case USART_FLAG_IDLE:
1465                     ; 301     case USART_FLAG_ORE:
1465                     ; 302     case USART_FLAG_NE:
1465                     ; 303     case USART_FLAG_FE:
1465                     ; 304     case USART_FLAG_PE:
1465                     ; 305       if ((USART->SR & itpos) != (u8)0x00)
1467  018f c65230        	ld	a,21040
1468                     ; 308         status = SET;
1470  0192 2003          	jpf	LC004
1471                     ; 313         status = RESET;
1472  0194               L346:
1473                     ; 317     case USART_FLAG_LBD:
1473                     ; 318       if ((USART->CR4 & itpos) != (u8)0x00)
1475  0194 c65237        	ld	a,21047
1476  0197               LC004:
1477  0197 1501          	bcp	a,(OFST-1,sp)
1478  0199 270b          	jreq	L127
1479                     ; 321         status = SET;
1481  019b               LC003:
1485  019b a601          	ld	a,#1
1487  019d 2008          	jra	L707
1488                     ; 326         status = RESET;
1489  019f               L546:
1490                     ; 330     case USART_FLAG_SBK:
1490                     ; 331       if ((USART->CR2 & itpos) != (u8)0x00)
1492  019f c65235        	ld	a,21045
1493  01a2 1501          	bcp	a,(OFST-1,sp)
1494                     ; 334         status = SET;
1496  01a4 26f5          	jrne	LC003
1497  01a6               L127:
1498                     ; 339         status = RESET;
1502  01a6 4f            	clr	a
1503  01a7               L707:
1504                     ; 350   return status;
1508  01a7 5b03          	addw	sp,#3
1509  01a9 87            	retf	
1583                     ; 378 ITStatus USART_GetITStatus(USART_Flag_TypeDef USART_FLAG)
1583                     ; 379 {
1584                     	switch	.text
1585  01aa               f_USART_GetITStatus:
1587  01aa 88            	push	a
1588  01ab 5203          	subw	sp,#3
1589       00000003      OFST:	set	3
1592                     ; 381   ITStatus pendingbitstatus = RESET;
1594  01ad 4f            	clr	a
1595  01ae 6b03          	ld	(OFST+0,sp),a
1596                     ; 382   u8 itpos = 0;
1598                     ; 383   u8 itmask1 = 0;
1600                     ; 384   u8 itmask2 = 0;
1602                     ; 385   u8 enablestatus = 0;
1604                     ; 388   assert_param(IS_USART_ITPENDINGBIT_VALUE_OK(USART_FLAG));
1606  01b0 7b04          	ld	a,(OFST+1,sp)
1607  01b2 a177          	cp	a,#119
1608  01b4 2726          	jreq	L06
1609  01b6 a166          	cp	a,#102
1610  01b8 2722          	jreq	L06
1611  01ba a155          	cp	a,#85
1612  01bc 271e          	jreq	L06
1613  01be a144          	cp	a,#68
1614  01c0 271a          	jreq	L06
1615  01c2 a153          	cp	a,#83
1616  01c4 2716          	jreq	L06
1617  01c6 7b04          	ld	a,(OFST+1,sp)
1618  01c8 2712          	jreq	L06
1619  01ca a164          	cp	a,#100
1620  01cc 270e          	jreq	L06
1621  01ce ae0184        	ldw	x,#388
1622  01d1 89            	pushw	x
1623  01d2 ae0008        	ldw	x,#L525
1624  01d5 8d000000      	callf	f_assert_failed
1626  01d9 85            	popw	x
1627  01da 7b04          	ld	a,(OFST+1,sp)
1628  01dc               L06:
1629                     ; 391   itpos = (u8)((u8)1 << (u8)((u8)USART_FLAG & (u8)0x0F));
1631  01dc a40f          	and	a,#15
1632  01de 5f            	clrw	x
1633  01df 97            	ld	xl,a
1634  01e0 a601          	ld	a,#1
1635  01e2 5d            	tnzw	x
1636  01e3 2704          	jreq	L46
1637  01e5               L66:
1638  01e5 48            	sll	a
1639  01e6 5a            	decw	x
1640  01e7 26fc          	jrne	L66
1641  01e9               L46:
1642  01e9 6b01          	ld	(OFST-2,sp),a
1643                     ; 393   itmask1 = (u8)((u8)USART_FLAG >> (u8)4);
1645  01eb 7b04          	ld	a,(OFST+1,sp)
1646  01ed 4e            	swap	a
1647  01ee a40f          	and	a,#15
1648  01f0 6b02          	ld	(OFST-1,sp),a
1649                     ; 395   itmask2 = (u8)((u8)1 << itmask1);
1651  01f2 5f            	clrw	x
1652  01f3 97            	ld	xl,a
1653  01f4 a601          	ld	a,#1
1654  01f6 5d            	tnzw	x
1655  01f7 2704          	jreq	L07
1656  01f9               L27:
1657  01f9 48            	sll	a
1658  01fa 5a            	decw	x
1659  01fb 26fc          	jrne	L27
1660  01fd               L07:
1661  01fd 6b02          	ld	(OFST-1,sp),a
1662                     ; 397   switch (USART_FLAG)
1664  01ff 7b04          	ld	a,(OFST+1,sp)
1666                     ; 456       break;
1667  0201 2730          	jreq	L727
1668  0203 4a            	dec	a
1669  0204 2754          	jreq	L337
1670  0206 4a            	dec	a
1671  0207 2751          	jreq	L337
1672  0209 a01e          	sub	a,#30
1673  020b 274d          	jreq	L337
1674  020d a024          	sub	a,#36
1675  020f 2737          	jreq	L137
1676  0211 a00f          	sub	a,#15
1677  0213 2733          	jreq	L137
1678  0215 a002          	sub	a,#2
1679  0217 272f          	jreq	L137
1680  0219 a00f          	sub	a,#15
1681  021b 270a          	jreq	L527
1682  021d a002          	sub	a,#2
1683  021f 2727          	jreq	L137
1684  0221 a011          	sub	a,#17
1685  0223 2723          	jreq	L137
1686  0225 2033          	jra	L337
1687  0227               L527:
1688                     ; 399     case USART_FLAG_LBD:
1688                     ; 400       /* Get the USART_FLAG enable bit status*/
1688                     ; 401       enablestatus = (u8)((u8)USART->CR4 & itmask2);
1690  0227 c65237        	ld	a,21047
1691  022a 1402          	and	a,(OFST-1,sp)
1692  022c 6b03          	ld	(OFST+0,sp),a
1693                     ; 403       if (((USART->CR4 & itpos) != (u8)0x00) && enablestatus)
1695  022e c65237        	ld	a,21047
1697                     ; 406         pendingbitstatus = SET;
1699  0231 201f          	jpf	LC007
1700                     ; 411         pendingbitstatus = RESET;
1701  0233               L727:
1702                     ; 415     case USART_FLAG_PE:
1702                     ; 416 
1702                     ; 417       /* Get the USART_FLAG enable bit status*/
1702                     ; 418       enablestatus = (u8)((u8)USART->CR1 & itmask2);
1704  0233 c65234        	ld	a,21044
1705  0236 1402          	and	a,(OFST-1,sp)
1706  0238 6b03          	ld	(OFST+0,sp),a
1707                     ; 421       if (((USART->SR & itpos) != (u8)0x00) && enablestatus)
1709  023a c65230        	ld	a,21040
1710  023d 1501          	bcp	a,(OFST-2,sp)
1711  023f 2704          	jreq	L777
1713  0241 7b03          	ld	a,(OFST+0,sp)
1714                     ; 424         pendingbitstatus = SET;
1716  0243 2615          	jrne	L337
1717  0245               L777:
1718                     ; 429         pendingbitstatus = RESET;
1722  0245 4f            	clr	a
1723  0246 2014          	jra	L177
1724  0248               L137:
1725                     ; 432     case USART_FLAG_TXE:
1725                     ; 433     case USART_FLAG_TC:
1725                     ; 434     case USART_FLAG_RXNE:
1725                     ; 435     case USART_FLAG_IDLE:
1725                     ; 436     case USART_FLAG_ORE:
1725                     ; 437       /* Get the USART_FLAG enable bit status*/
1725                     ; 438       enablestatus = (u8)((u8)USART->CR2 & itmask2);
1727  0248 c65235        	ld	a,21045
1728  024b 1402          	and	a,(OFST-1,sp)
1729  024d 6b03          	ld	(OFST+0,sp),a
1730                     ; 440       if (((USART->SR & itpos) != (u8)0x00) && enablestatus)
1732  024f c65230        	ld	a,21040
1734  0252               LC007:
1735  0252 1501          	bcp	a,(OFST-2,sp)
1736  0254 27ef          	jreq	L777
1737  0256 7b03          	ld	a,(OFST+0,sp)
1738  0258 27eb          	jreq	L777
1739                     ; 443         pendingbitstatus = SET;
1741                     ; 448         pendingbitstatus = RESET;
1742  025a               L337:
1743                     ; 451     case USART_FLAG_NE:
1743                     ; 452     case USART_FLAG_FE:
1743                     ; 453     case USART_FLAG_SBK:
1743                     ; 454     default:
1743                     ; 455       pendingbitstatus = SET;
1748  025a a601          	ld	a,#1
1749                     ; 456       break;
1751  025c               L177:
1752                     ; 461   return  pendingbitstatus;
1756  025c 5b04          	addw	sp,#4
1757  025e 87            	retf	
1793                     ; 481 void USART_HalfDuplexCmd(FunctionalState NewState)
1793                     ; 482 {
1794                     	switch	.text
1795  025f               f_USART_HalfDuplexCmd:
1797  025f 88            	push	a
1798       00000000      OFST:	set	0
1801                     ; 483   assert_param(IS_STATE_VALUE_OK(NewState));
1803  0260 a101          	cp	a,#1
1804  0262 270f          	jreq	L201
1805  0264 4d            	tnz	a
1806  0265 270c          	jreq	L201
1807  0267 ae01e3        	ldw	x,#483
1808  026a 89            	pushw	x
1809  026b ae0008        	ldw	x,#L525
1810  026e 8d000000      	callf	f_assert_failed
1812  0272 85            	popw	x
1813  0273               L201:
1814                     ; 485   if (NewState)
1816  0273 7b01          	ld	a,(OFST+1,sp)
1817  0275 2706          	jreq	L5201
1818                     ; 487     USART->CR5 |= USART_CR5_HDSEL;  /**< USART Half Duplex Enable  */
1820  0277 72165238      	bset	21048,#3
1822  027b 2004          	jra	L7201
1823  027d               L5201:
1824                     ; 491     USART->CR5 &= (u8)~USART_CR5_HDSEL; /**< USART Half Duplex Disable */
1826  027d 72175238      	bres	21048,#3
1827  0281               L7201:
1828                     ; 493 }
1831  0281 84            	pop	a
1832  0282 87            	retf	
2127                     ; 509 void USART_StructInit(USART_Init_TypeDef* USART_InitStruct)
2127                     ; 510 {
2128                     	switch	.text
2129  0283               f_USART_StructInit:
2133                     ; 511   USART_InitStruct->WordLength          = USART_WORDLENGTH_8D;
2135  0283 7f            	clr	(x)
2136                     ; 512   USART_InitStruct->StopBits            = USART_STOPBITS_1;
2138  0284 6f01          	clr	(1,x)
2139                     ; 513   USART_InitStruct->Parity              = USART_PARITY_NO;
2141  0286 6f02          	clr	(2,x)
2142                     ; 514   USART_InitStruct->SyncMode            = USART_CLOCK_DISABLE;
2144  0288 a680          	ld	a,#128
2145  028a e703          	ld	(3,x),a
2146                     ; 515   USART_InitStruct->BaudRate            = (u32)9600;
2148  028c e707          	ld	(7,x),a
2149  028e a625          	ld	a,#37
2150  0290 e706          	ld	(6,x),a
2151  0292 4f            	clr	a
2152  0293 e705          	ld	(5,x),a
2153  0295 e704          	ld	(4,x),a
2154                     ; 516   USART_InitStruct->Mode                = USART_MODE_TXRX_ENABLE;
2156  0297 a60c          	ld	a,#12
2157  0299 e708          	ld	(8,x),a
2158                     ; 517 }
2161  029b 87            	retf	
2214                     .const:	section	.text
2215  0000               L441:
2216  0000 00098969      	dc.l	625001
2217  0004               L471:
2218  0004 00000064      	dc.l	100
2219                     ; 532 void USART_Init(USART_Init_TypeDef* USART_InitStruct)
2219                     ; 533 {
2220                     	switch	.text
2221  029c               f_USART_Init:
2223  029c 89            	pushw	x
2224  029d 520c          	subw	sp,#12
2225       0000000c      OFST:	set	12
2228                     ; 537   assert_param(IS_USART_WORDLENGTH_VALUE_OK(USART_InitStruct->WordLength));
2230  029f f6            	ld	a,(x)
2231  02a0 2710          	jreq	L611
2232  02a2 a110          	cp	a,#16
2233  02a4 270c          	jreq	L611
2234  02a6 ae0219        	ldw	x,#537
2235  02a9 89            	pushw	x
2236  02aa ae0008        	ldw	x,#L525
2237  02ad 8d000000      	callf	f_assert_failed
2239  02b1 85            	popw	x
2240  02b2               L611:
2241                     ; 539   assert_param(IS_USART_STOPBITS_VALUE_OK(USART_InitStruct->StopBits));
2243  02b2 1e0d          	ldw	x,(OFST+1,sp)
2244  02b4 e601          	ld	a,(1,x)
2245  02b6 271a          	jreq	L621
2246  02b8 a110          	cp	a,#16
2247  02ba 2716          	jreq	L621
2248  02bc a120          	cp	a,#32
2249  02be 2712          	jreq	L621
2250  02c0 a130          	cp	a,#48
2251  02c2 270e          	jreq	L621
2252  02c4 ae021b        	ldw	x,#539
2253  02c7 89            	pushw	x
2254  02c8 ae0008        	ldw	x,#L525
2255  02cb 8d000000      	callf	f_assert_failed
2257  02cf 85            	popw	x
2258  02d0 1e0d          	ldw	x,(OFST+1,sp)
2259  02d2               L621:
2260                     ; 541   assert_param(IS_USART_PARITY_VALUE_OK(USART_InitStruct->Parity));
2262  02d2 e602          	ld	a,(2,x)
2263  02d4 2716          	jreq	L631
2264  02d6 a104          	cp	a,#4
2265  02d8 2712          	jreq	L631
2266  02da a106          	cp	a,#6
2267  02dc 270e          	jreq	L631
2268  02de ae021d        	ldw	x,#541
2269  02e1 89            	pushw	x
2270  02e2 ae0008        	ldw	x,#L525
2271  02e5 8d000000      	callf	f_assert_failed
2273  02e9 85            	popw	x
2274  02ea 1e0d          	ldw	x,(OFST+1,sp)
2275  02ec               L631:
2276                     ; 544   assert_param(IS_USART_BAUDRATE_OK(USART_InitStruct->BaudRate));
2278  02ec 1c0004        	addw	x,#4
2279  02ef 8d000000      	callf	d_ltor
2281  02f3 ae0000        	ldw	x,#L441
2282  02f6 8d000000      	callf	d_lcmp
2284  02fa 250c          	jrult	L641
2285  02fc ae0220        	ldw	x,#544
2286  02ff 89            	pushw	x
2287  0300 ae0008        	ldw	x,#L525
2288  0303 8d000000      	callf	f_assert_failed
2290  0307 85            	popw	x
2291  0308               L641:
2292                     ; 547   assert_param(IS_USART_MODE_VALUE_OK((u8)USART_InitStruct->Mode));
2294  0308 1e0d          	ldw	x,(OFST+1,sp)
2295  030a e608          	ld	a,(8,x)
2296  030c a108          	cp	a,#8
2297  030e 272a          	jreq	L651
2298  0310 a140          	cp	a,#64
2299  0312 2726          	jreq	L651
2300  0314 a104          	cp	a,#4
2301  0316 2722          	jreq	L651
2302  0318 a180          	cp	a,#128
2303  031a 271e          	jreq	L651
2304  031c a10c          	cp	a,#12
2305  031e 271a          	jreq	L651
2306  0320 a144          	cp	a,#68
2307  0322 2716          	jreq	L651
2308  0324 a1c0          	cp	a,#192
2309  0326 2712          	jreq	L651
2310  0328 a188          	cp	a,#136
2311  032a 270e          	jreq	L651
2312  032c ae0223        	ldw	x,#547
2313  032f 89            	pushw	x
2314  0330 ae0008        	ldw	x,#L525
2315  0333 8d000000      	callf	f_assert_failed
2317  0337 85            	popw	x
2318  0338 1e0d          	ldw	x,(OFST+1,sp)
2319  033a               L651:
2320                     ; 551   assert_param(IS_USART_SYNCMODE_VALUE_OK((u8)USART_InitStruct->SyncMode));
2322  033a e603          	ld	a,(3,x)
2323  033c a488          	and	a,#136
2324  033e a188          	cp	a,#136
2325  0340 2718          	jreq	L261
2326  0342 e603          	ld	a,(3,x)
2327  0344 a444          	and	a,#68
2328  0346 a144          	cp	a,#68
2329  0348 2710          	jreq	L261
2330  034a e603          	ld	a,(3,x)
2331  034c a422          	and	a,#34
2332  034e a122          	cp	a,#34
2333  0350 2708          	jreq	L261
2334  0352 e603          	ld	a,(3,x)
2335  0354 a411          	and	a,#17
2336  0356 a111          	cp	a,#17
2337  0358 260c          	jrne	L461
2338  035a               L261:
2339  035a ae0227        	ldw	x,#551
2340  035d 89            	pushw	x
2341  035e ae0008        	ldw	x,#L525
2342  0361 8d000000      	callf	f_assert_failed
2344  0365 85            	popw	x
2345  0366               L461:
2346                     ; 556   USART->CR1 &= (u8)(~USART_CR1_M);     /**< Clear the word length bit */
2348  0366 72195234      	bres	21044,#4
2349                     ; 557   USART->CR1 |= (u8)USART_InitStruct->WordLength; /**< Set the word length bit according to USART_WordLength value */
2351  036a 1e0d          	ldw	x,(OFST+1,sp)
2352  036c c65234        	ld	a,21044
2353  036f fa            	or	a,(x)
2354  0370 c75234        	ld	21044,a
2355                     ; 559   USART->CR3 &= (u8)(~USART_CR3_STOP);  /**< Clear the STOP bits */
2357  0373 c65236        	ld	a,21046
2358  0376 a4cf          	and	a,#207
2359  0378 c75236        	ld	21046,a
2360                     ; 560   USART->CR3 |= (u8)USART_InitStruct->StopBits;  /**< Set the STOP bits number according to USART_StopBits value  */
2362  037b c65236        	ld	a,21046
2363  037e ea01          	or	a,(1,x)
2364  0380 c75236        	ld	21046,a
2365                     ; 562   USART->CR1 &= (u8)(~(USART_CR1_PCEN | USART_CR1_PS  ));  /**< Clear the Parity Control bit */
2367  0383 c65234        	ld	a,21044
2368  0386 a4f9          	and	a,#249
2369  0388 c75234        	ld	21044,a
2370                     ; 563   USART->CR1 |= (u8)USART_InitStruct->Parity;     /**< Set the Parity Control bit to USART_Parity value */
2372  038b c65234        	ld	a,21044
2373  038e ea02          	or	a,(2,x)
2374  0390 c75234        	ld	21044,a
2375                     ; 565   USART->BRR1 &= (u8)(~USART_BRR1_DIVM);  /**< Clear the LSB mantissa of USARTDIV  */
2377  0393 725f5232      	clr	21042
2378                     ; 566   USART->BRR2 &= (u8)(~USART_BRR2_DIVM);  /**< Clear the MSB mantissa of USARTDIV  */
2380  0397 c65233        	ld	a,21043
2381  039a a40f          	and	a,#15
2382  039c c75233        	ld	21043,a
2383                     ; 567   USART->BRR2 &= (u8)(~USART_BRR2_DIVF);  /**< Clear the Fraction bits of USARTDIV */
2385  039f c65233        	ld	a,21043
2386  03a2 a4f0          	and	a,#240
2387  03a4 c75233        	ld	21043,a
2388                     ; 570   BaudRate_Mantissa    = ((u32)CLK_GetClockFreq()/ (USART_InitStruct->BaudRate << 4));
2390  03a7 1c0004        	addw	x,#4
2391  03aa 8d000000      	callf	d_ltor
2393  03ae a604          	ld	a,#4
2394  03b0 8d000000      	callf	d_llsh
2396  03b4 96            	ldw	x,sp
2397  03b5 5c            	incw	x
2398  03b6 8d000000      	callf	d_rtol
2400  03ba 8d000000      	callf	f_CLK_GetClockFreq
2402  03be 96            	ldw	x,sp
2403  03bf 5c            	incw	x
2404  03c0 8d000000      	callf	d_ludv
2406  03c4 96            	ldw	x,sp
2407  03c5 1c0009        	addw	x,#OFST-3
2408  03c8 8d000000      	callf	d_rtol
2410                     ; 571   BaudRate_Mantissa100 = (((u32)CLK_GetClockFreq() * 100) / (USART_InitStruct->BaudRate << 4));
2412  03cc 1e0d          	ldw	x,(OFST+1,sp)
2413  03ce 1c0004        	addw	x,#4
2414  03d1 8d000000      	callf	d_ltor
2416  03d5 a604          	ld	a,#4
2417  03d7 8d000000      	callf	d_llsh
2419  03db 96            	ldw	x,sp
2420  03dc 5c            	incw	x
2421  03dd 8d000000      	callf	d_rtol
2423  03e1 8d000000      	callf	f_CLK_GetClockFreq
2425  03e5 a664          	ld	a,#100
2426  03e7 8d000000      	callf	d_smul
2428  03eb 96            	ldw	x,sp
2429  03ec 5c            	incw	x
2430  03ed 8d000000      	callf	d_ludv
2432  03f1 96            	ldw	x,sp
2433  03f2 1c0005        	addw	x,#OFST-7
2434  03f5 8d000000      	callf	d_rtol
2436                     ; 572   USART->BRR2 |= (u8)((u8)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100)) << 4) / 100) & (u8)0x0F); /**< Set the fraction of USARTDIV  */
2438  03f9 96            	ldw	x,sp
2439  03fa 1c0009        	addw	x,#OFST-3
2440  03fd 8d000000      	callf	d_ltor
2442  0401 a664          	ld	a,#100
2443  0403 8d000000      	callf	d_smul
2445  0407 96            	ldw	x,sp
2446  0408 5c            	incw	x
2447  0409 8d000000      	callf	d_rtol
2449  040d 96            	ldw	x,sp
2450  040e 1c0005        	addw	x,#OFST-7
2451  0411 8d000000      	callf	d_ltor
2453  0415 96            	ldw	x,sp
2454  0416 5c            	incw	x
2455  0417 8d000000      	callf	d_lsub
2457  041b a604          	ld	a,#4
2458  041d 8d000000      	callf	d_llsh
2460  0421 ae0004        	ldw	x,#L471
2461  0424 8d000000      	callf	d_ludv
2463  0428 b603          	ld	a,c_lreg+3
2464  042a a40f          	and	a,#15
2465  042c ca5233        	or	a,21043
2466  042f c75233        	ld	21043,a
2467                     ; 573   USART->BRR2 |= (u8)((BaudRate_Mantissa >> 4) & (u8)0xF0); /**< Set the MSB mantissa of USARTDIV  */
2469  0432 96            	ldw	x,sp
2470  0433 1c0009        	addw	x,#OFST-3
2471  0436 8d000000      	callf	d_ltor
2473  043a a604          	ld	a,#4
2474  043c 8d000000      	callf	d_lursh
2476  0440 b603          	ld	a,c_lreg+3
2477  0442 a4f0          	and	a,#240
2478  0444 b703          	ld	c_lreg+3,a
2479  0446 3f02          	clr	c_lreg+2
2480  0448 3f01          	clr	c_lreg+1
2481  044a 3f00          	clr	c_lreg
2482  044c ca5233        	or	a,21043
2483  044f c75233        	ld	21043,a
2484                     ; 574   USART->BRR1 |= (u8)BaudRate_Mantissa;           /**< Set the LSB mantissa of USARTDIV  */
2486  0452 c65232        	ld	a,21042
2487  0455 1a0c          	or	a,(OFST+0,sp)
2488  0457 c75232        	ld	21042,a
2489                     ; 576   USART->CR2 &= (u8)~(USART_CR2_TEN | USART_CR2_REN); /**< Disable the Transmitter and Receiver before seting the LBCL, CPOL and CPHA bits */
2491  045a c65235        	ld	a,21045
2492  045d a4f3          	and	a,#243
2493  045f c75235        	ld	21045,a
2494                     ; 577   USART->CR3 &= (u8)~(USART_CR3_CPOL | USART_CR3_CPHA | USART_CR3_LBCL); /**< Clear the Clock Polarity, lock Phase, Last Bit Clock pulse */
2496  0462 c65236        	ld	a,21046
2497  0465 a4f8          	and	a,#248
2498  0467 c75236        	ld	21046,a
2499                     ; 578   USART->CR3 |= (u8)((u8)USART_InitStruct->SyncMode & (u8)(USART_CR3_CPOL | USART_CR3_CPHA | USART_CR3_LBCL));  /**< Set the Clock Polarity, lock Phase, Last Bit Clock pulse */
2501  046a 1e0d          	ldw	x,(OFST+1,sp)
2502  046c e603          	ld	a,(3,x)
2503  046e a407          	and	a,#7
2504  0470 ca5236        	or	a,21046
2505  0473 c75236        	ld	21046,a
2506                     ; 580   if ((u8)USART_InitStruct->Mode & (u8)USART_MODE_TX_ENABLE)
2508  0476 e608          	ld	a,(8,x)
2509  0478 a504          	bcp	a,#4
2510  047a 2706          	jreq	L7221
2511                     ; 582     USART->CR2 |= (u8)USART_CR2_TEN;  /**< Set the Transmitter Enable bit */
2513  047c 72165235      	bset	21045,#3
2515  0480 2004          	jra	L1321
2516  0482               L7221:
2517                     ; 586     USART->CR2 &= (u8)(~USART_CR2_TEN);  /**< Clear the Transmitter Disable bit */
2519  0482 72175235      	bres	21045,#3
2520  0486               L1321:
2521                     ; 588   if ((u8)USART_InitStruct->Mode & (u8)USART_MODE_RX_ENABLE)
2523  0486 a508          	bcp	a,#8
2524  0488 2706          	jreq	L3321
2525                     ; 590     USART->CR2 |= (u8)USART_CR2_REN;  /**< Set the Receiver Enable bit */
2527  048a 72145235      	bset	21045,#2
2529  048e 2004          	jra	L5321
2530  0490               L3321:
2531                     ; 594     USART->CR2 &= (u8)(~USART_CR2_REN);  /**< Clear the Receiver Disable bit */
2533  0490 72155235      	bres	21045,#2
2534  0494               L5321:
2535                     ; 597   if ((u8)USART_InitStruct->SyncMode&(u8)USART_CLOCK_DISABLE)
2537  0494 1e0d          	ldw	x,(OFST+1,sp)
2538  0496 e603          	ld	a,(3,x)
2539  0498 2a06          	jrpl	L7321
2540                     ; 599     USART->CR3 &= (u8)(~USART_CR3_CLKEN); /**< Clear the Clock Enable bit */
2542  049a 72175236      	bres	21046,#3
2544  049e 2008          	jra	L1421
2545  04a0               L7321:
2546                     ; 604     USART->CR3 |= (u8)((u8)USART_InitStruct->SyncMode & USART_CR3_CLKEN);
2548  04a0 a408          	and	a,#8
2549  04a2 ca5236        	or	a,21046
2550  04a5 c75236        	ld	21046,a
2551  04a8               L1421:
2552                     ; 607 }
2555  04a8 5b0e          	addw	sp,#14
2556  04aa 87            	retf	
2613                     ; 627 void USART_IrDAConfig(USART_IrDAMode_TypeDef USART_IrDAMode)
2613                     ; 628 {
2614                     	switch	.text
2615  04ab               f_USART_IrDAConfig:
2617  04ab 88            	push	a
2618       00000000      OFST:	set	0
2621                     ; 629   assert_param(IS_USART_IRDAMODE_VALUE_OK(USART_IrDAMode));
2623  04ac a101          	cp	a,#1
2624  04ae 2710          	jreq	L402
2625  04b0 a102          	cp	a,#2
2626  04b2 270c          	jreq	L402
2627  04b4 ae0275        	ldw	x,#629
2628  04b7 89            	pushw	x
2629  04b8 ae0008        	ldw	x,#L525
2630  04bb 8d000000      	callf	f_assert_failed
2632  04bf 85            	popw	x
2633  04c0               L402:
2634                     ; 631   if (USART_IrDAMode == USART_IRDAMODE_NORMAL)
2636  04c0 7b01          	ld	a,(OFST+1,sp)
2637  04c2 a102          	cp	a,#2
2638  04c4 2606          	jrne	L1721
2639                     ; 633     USART->CR5 &= ((u8)~USART_CR5_IRLP);
2641  04c6 72155238      	bres	21048,#2
2643  04ca 2004          	jra	L3721
2644  04cc               L1721:
2645                     ; 637     USART->CR5 |= USART_CR5_IRLP;
2647  04cc 72145238      	bset	21048,#2
2648  04d0               L3721:
2649                     ; 639 }
2652  04d0 84            	pop	a
2653  04d1 87            	retf	
2688                     ; 658 void USART_IrDACmd(FunctionalState NewState)
2688                     ; 659 {
2689                     	switch	.text
2690  04d2               f_USART_IrDACmd:
2692  04d2 88            	push	a
2693       00000000      OFST:	set	0
2696                     ; 662   assert_param(IS_STATE_VALUE_OK(NewState));
2698  04d3 a101          	cp	a,#1
2699  04d5 270f          	jreq	L612
2700  04d7 4d            	tnz	a
2701  04d8 270c          	jreq	L612
2702  04da ae0296        	ldw	x,#662
2703  04dd 89            	pushw	x
2704  04de ae0008        	ldw	x,#L525
2705  04e1 8d000000      	callf	f_assert_failed
2707  04e5 85            	popw	x
2708  04e6               L612:
2709                     ; 664   if (NewState)
2711  04e6 7b01          	ld	a,(OFST+1,sp)
2712  04e8 2706          	jreq	L3131
2713                     ; 667     USART->CR5 |= USART_CR5_IREN;
2715  04ea 72125238      	bset	21048,#1
2717  04ee 2004          	jra	L5131
2718  04f0               L3131:
2719                     ; 672     USART->CR5 &= ((u8)~USART_CR5_IREN);
2721  04f0 72135238      	bres	21048,#1
2722  04f4               L5131:
2723                     ; 674 }
2726  04f4 84            	pop	a
2727  04f5 87            	retf	
2820                     ; 701 void USART_ITConfig(USART_IT_TypeDef USART_IT, FunctionalState NewState)
2820                     ; 702 {
2821                     	switch	.text
2822  04f6               f_USART_ITConfig:
2824  04f6 89            	pushw	x
2825       00000000      OFST:	set	0
2828                     ; 703   assert_param(IS_USART_IT_VALUE_OK(USART_IT));
2830  04f7 9e            	ld	a,xh
2831  04f8 4a            	dec	a
2832  04f9 2725          	jreq	L032
2833  04fb 9e            	ld	a,xh
2834  04fc a180          	cp	a,#128
2835  04fe 2720          	jreq	L032
2836  0500 9e            	ld	a,xh
2837  0501 a140          	cp	a,#64
2838  0503 271b          	jreq	L032
2839  0505 9e            	ld	a,xh
2840  0506 a120          	cp	a,#32
2841  0508 2716          	jreq	L032
2842  050a 9e            	ld	a,xh
2843  050b a110          	cp	a,#16
2844  050d 2711          	jreq	L032
2845  050f 9e            	ld	a,xh
2846  0510 a104          	cp	a,#4
2847  0512 270c          	jreq	L032
2848  0514 ae02bf        	ldw	x,#703
2849  0517 89            	pushw	x
2850  0518 ae0008        	ldw	x,#L525
2851  051b 8d000000      	callf	f_assert_failed
2853  051f 85            	popw	x
2854  0520               L032:
2855                     ; 704   assert_param(IS_STATE_VALUE_OK(NewState));
2857  0520 7b02          	ld	a,(OFST+2,sp)
2858  0522 4a            	dec	a
2859  0523 2710          	jreq	L042
2860  0525 7b02          	ld	a,(OFST+2,sp)
2861  0527 270c          	jreq	L042
2862  0529 ae02c0        	ldw	x,#704
2863  052c 89            	pushw	x
2864  052d ae0008        	ldw	x,#L525
2865  0530 8d000000      	callf	f_assert_failed
2867  0534 85            	popw	x
2868  0535               L042:
2869                     ; 706   if (NewState)
2871  0535 7b02          	ld	a,(OFST+2,sp)
2872  0537 2722          	jreq	L1631
2873                     ; 709     USART->CR2 |= (u8)((u8)(USART_IT) & (u8)(USART_CR2_TIEN | USART_CR2_TCIEN | USART_CR2_RIEN | USART_CR2_ILIEN));
2875  0539 7b01          	ld	a,(OFST+1,sp)
2876  053b a4f0          	and	a,#240
2877  053d ca5235        	or	a,21045
2878  0540 c75235        	ld	21045,a
2879                     ; 710     USART->CR1 |= (u8)((u8)USART_IT & USART_CR1_PIEN);
2881  0543 7b01          	ld	a,(OFST+1,sp)
2882  0545 a401          	and	a,#1
2883  0547 ca5234        	or	a,21044
2884  054a c75234        	ld	21044,a
2885                     ; 711     USART->CR4 |= (u8)((u8)((u8)USART_IT << 4) & USART_CR4_LBDIEN);
2887  054d 7b01          	ld	a,(OFST+1,sp)
2888  054f 97            	ld	xl,a
2889  0550 a610          	ld	a,#16
2890  0552 42            	mul	x,a
2891  0553 9f            	ld	a,xl
2892  0554 a440          	and	a,#64
2893  0556 ca5237        	or	a,21047
2895  0559 2023          	jra	L3631
2896  055b               L1631:
2897                     ; 716     USART->CR2 &= (u8)(~((u8)(USART_IT) & (u8)(USART_CR2_TIEN | USART_CR2_TCIEN | USART_CR2_RIEN | USART_CR2_ILIEN)));
2899  055b 7b01          	ld	a,(OFST+1,sp)
2900  055d a4f0          	and	a,#240
2901  055f 43            	cpl	a
2902  0560 c45235        	and	a,21045
2903  0563 c75235        	ld	21045,a
2904                     ; 717     USART->CR1 &= (u8)(~((u8)USART_IT & USART_CR1_PIEN));
2906  0566 7b01          	ld	a,(OFST+1,sp)
2907  0568 a401          	and	a,#1
2908  056a 43            	cpl	a
2909  056b c45234        	and	a,21044
2910  056e c75234        	ld	21044,a
2911                     ; 718     USART->CR4 &= (u8)(~((u8)((u8)USART_IT << 4) & USART_CR4_LBDIEN));
2913  0571 7b01          	ld	a,(OFST+1,sp)
2914  0573 97            	ld	xl,a
2915  0574 a610          	ld	a,#16
2916  0576 42            	mul	x,a
2917  0577 9f            	ld	a,xl
2918  0578 a440          	and	a,#64
2919  057a 43            	cpl	a
2920  057b c45237        	and	a,21047
2921  057e               L3631:
2922  057e c75237        	ld	21047,a
2923                     ; 721 }
2926  0581 85            	popw	x
2927  0582 87            	retf	
2984                     ; 743 void USART_LINBreakDetectionConfig(USART_LINBreakDetectionLength_TypeDef USART_LINBreakDetectionLength)
2984                     ; 744 {
2985                     	switch	.text
2986  0583               f_USART_LINBreakDetectionConfig:
2988  0583 88            	push	a
2989       00000000      OFST:	set	0
2992                     ; 745   assert_param(IS_USART_LINBREAKDETECTIONLENGTH_VALUE_OK(USART_LINBreakDetectionLength));
2994  0584 a101          	cp	a,#1
2995  0586 2710          	jreq	L252
2996  0588 a102          	cp	a,#2
2997  058a 270c          	jreq	L252
2998  058c ae02e9        	ldw	x,#745
2999  058f 89            	pushw	x
3000  0590 ae0008        	ldw	x,#L525
3001  0593 8d000000      	callf	f_assert_failed
3003  0597 85            	popw	x
3004  0598               L252:
3005                     ; 747   if (USART_LINBreakDetectionLength == USART_BREAK10BITS)
3007  0598 7b01          	ld	a,(OFST+1,sp)
3008  059a 4a            	dec	a
3009  059b 2606          	jrne	L3141
3010                     ; 749     USART->CR4 &= ((u8)~USART_CR4_LBDL);
3012  059d 721b5237      	bres	21047,#5
3014  05a1 2004          	jra	L5141
3015  05a3               L3141:
3016                     ; 753     USART->CR4 |= USART_CR4_LBDL;
3018  05a3 721a5237      	bset	21047,#5
3019  05a7               L5141:
3020                     ; 755 }
3023  05a7 84            	pop	a
3024  05a8 87            	retf	
3059                     ; 774 void USART_LINCmd(FunctionalState NewState)
3059                     ; 775 {
3060                     	switch	.text
3061  05a9               f_USART_LINCmd:
3063  05a9 88            	push	a
3064       00000000      OFST:	set	0
3067                     ; 776   assert_param(IS_STATE_VALUE_OK(NewState));
3069  05aa a101          	cp	a,#1
3070  05ac 270f          	jreq	L462
3071  05ae 4d            	tnz	a
3072  05af 270c          	jreq	L462
3073  05b1 ae0308        	ldw	x,#776
3074  05b4 89            	pushw	x
3075  05b5 ae0008        	ldw	x,#L525
3076  05b8 8d000000      	callf	f_assert_failed
3078  05bc 85            	popw	x
3079  05bd               L462:
3080                     ; 778   if (NewState)
3082  05bd 7b01          	ld	a,(OFST+1,sp)
3083  05bf 2706          	jreq	L5341
3084                     ; 781     USART->CR3 |= USART_CR3_LINEN;
3086  05c1 721c5236      	bset	21046,#6
3088  05c5 2004          	jra	L7341
3089  05c7               L5341:
3090                     ; 786     USART->CR3 &= ((u8)~USART_CR3_LINEN);
3092  05c7 721d5236      	bres	21046,#6
3093  05cb               L7341:
3094                     ; 788 }
3097  05cb 84            	pop	a
3098  05cc 87            	retf	
3120                     ; 806 u8 USART_ReceiveData8(void)
3120                     ; 807 {
3121                     	switch	.text
3122  05cd               f_USART_ReceiveData8:
3126                     ; 808   return USART->DR;
3128  05cd c65231        	ld	a,21041
3131  05d0 87            	retf	
3153                     ; 827 u16 USART_ReceiveData9(void)
3153                     ; 828 {
3154                     	switch	.text
3155  05d1               f_USART_ReceiveData9:
3157  05d1 89            	pushw	x
3158       00000002      OFST:	set	2
3161                     ; 829   return (u16)( (((u16) USART->DR) | ((u16)(((u16)( (u16)USART->CR1 & (u16)USART_CR1_R8)) << 1))) & ((u16)0x01FF));
3163  05d2 c65234        	ld	a,21044
3164  05d5 a480          	and	a,#128
3165  05d7 5f            	clrw	x
3166  05d8 02            	rlwa	x,a
3167  05d9 58            	sllw	x
3168  05da 1f01          	ldw	(OFST-1,sp),x
3169  05dc c65231        	ld	a,21041
3170  05df 5f            	clrw	x
3171  05e0 97            	ld	xl,a
3172  05e1 01            	rrwa	x,a
3173  05e2 1a02          	or	a,(OFST+0,sp)
3174  05e4 01            	rrwa	x,a
3175  05e5 1a01          	or	a,(OFST-1,sp)
3176  05e7 a401          	and	a,#1
3177  05e9 01            	rrwa	x,a
3180  05ea 5b02          	addw	sp,#2
3181  05ec 87            	retf	
3217                     ; 848 void USART_ReceiverWakeUpCmd(FunctionalState NewState)
3217                     ; 849 {
3218                     	switch	.text
3219  05ed               f_USART_ReceiverWakeUpCmd:
3221  05ed 88            	push	a
3222       00000000      OFST:	set	0
3225                     ; 850   assert_param(IS_STATE_VALUE_OK(NewState));
3227  05ee a101          	cp	a,#1
3228  05f0 270f          	jreq	L203
3229  05f2 4d            	tnz	a
3230  05f3 270c          	jreq	L203
3231  05f5 ae0352        	ldw	x,#850
3232  05f8 89            	pushw	x
3233  05f9 ae0008        	ldw	x,#L525
3234  05fc 8d000000      	callf	f_assert_failed
3236  0600 85            	popw	x
3237  0601               L203:
3238                     ; 852   if (NewState)
3240  0601 7b01          	ld	a,(OFST+1,sp)
3241  0603 2706          	jreq	L7741
3242                     ; 855     USART->CR2 |= USART_CR2_RWU;
3244  0605 72125235      	bset	21045,#1
3246  0609 2004          	jra	L1051
3247  060b               L7741:
3248                     ; 860     USART->CR2 &= ((u8)~USART_CR2_RWU);
3250  060b 72135235      	bres	21045,#1
3251  060f               L1051:
3252                     ; 862 }
3255  060f 84            	pop	a
3256  0610 87            	retf	
3278                     ; 878 void USART_SendBreak(void)
3278                     ; 879 {
3279                     	switch	.text
3280  0611               f_USART_SendBreak:
3284                     ; 880   USART->CR2 |= USART_CR2_SBK;
3286  0611 72105235      	bset	21045,#0
3287                     ; 881 }
3290  0615 87            	retf	
3321                     ; 900 void USART_SendData8(u8 Data)
3321                     ; 901 {
3322                     	switch	.text
3323  0616               f_USART_SendData8:
3327                     ; 903   USART->DR = Data;
3329  0616 c75231        	ld	21041,a
3330                     ; 904 }
3333  0619 87            	retf	
3364                     ; 923 void USART_SendData9(u16 Data)
3364                     ; 924 {
3365                     	switch	.text
3366  061a               f_USART_SendData9:
3368  061a 89            	pushw	x
3369       00000000      OFST:	set	0
3372                     ; 926   USART->CR1 &= ((u8)~USART_CR1_T8);                  /**< Clear the transmit data bit 8     */
3374  061b 721d5234      	bres	21044,#6
3375                     ; 927   USART->CR1 |= (u8)(((u8)(Data >> 2)) & USART_CR1_T8); /**< Write the transmit data bit [8]   */
3377  061f 54            	srlw	x
3378  0620 54            	srlw	x
3379  0621 9f            	ld	a,xl
3380  0622 a440          	and	a,#64
3381  0624 ca5234        	or	a,21044
3382  0627 c75234        	ld	21044,a
3383                     ; 928   USART->DR   = (u8)(Data);                    /**< Write the transmit data bit [0:7] */
3385  062a 7b02          	ld	a,(OFST+2,sp)
3386  062c c75231        	ld	21041,a
3387                     ; 930 }
3390  062f 85            	popw	x
3391  0630 87            	retf	
3423                     ; 951 void USART_SetAddress(u8 USART_Address)
3423                     ; 952 {
3424                     	switch	.text
3425  0631               f_USART_SetAddress:
3427  0631 88            	push	a
3428       00000000      OFST:	set	0
3431                     ; 954   assert_param(IS_USART_ADDRESS_VALUE_OK(USART_Address));
3433  0632 a116          	cp	a,#22
3434  0634 250c          	jrult	L023
3435  0636 ae03ba        	ldw	x,#954
3436  0639 89            	pushw	x
3437  063a ae0008        	ldw	x,#L525
3438  063d 8d000000      	callf	f_assert_failed
3440  0641 85            	popw	x
3441  0642               L023:
3442                     ; 957   USART->CR4 &= ((u8)~USART_CR4_ADD);
3444  0642 c65237        	ld	a,21047
3445  0645 a4f0          	and	a,#240
3446  0647 c75237        	ld	21047,a
3447                     ; 959   USART->CR4 |= USART_Address;
3449  064a c65237        	ld	a,21047
3450  064d 1a01          	or	a,(OFST+1,sp)
3451  064f c75237        	ld	21047,a
3452                     ; 960 }
3455  0652 84            	pop	a
3456  0653 87            	retf	
3487                     ; 979 void USART_SetGuardTime(u8 USART_GuardTime)
3487                     ; 980 {
3488                     	switch	.text
3489  0654               f_USART_SetGuardTime:
3493                     ; 982   USART->GTR = USART_GuardTime;
3495  0654 c75239        	ld	21049,a
3496                     ; 983 }
3499  0657 87            	retf	
3530                     ; 1017 void USART_SetPrescaler(u8 USART_Prescaler)
3530                     ; 1018 {
3531                     	switch	.text
3532  0658               f_USART_SetPrescaler:
3536                     ; 1020   USART->PSCR = USART_Prescaler;
3538  0658 c7523a        	ld	21050,a
3539                     ; 1021 }
3542  065b 87            	retf	
3577                     ; 1041 void USART_SmartCardCmd(FunctionalState NewState)
3577                     ; 1042 {
3578                     	switch	.text
3579  065c               f_USART_SmartCardCmd:
3581  065c 88            	push	a
3582       00000000      OFST:	set	0
3585                     ; 1043   assert_param(IS_STATE_VALUE_OK(NewState));
3587  065d a101          	cp	a,#1
3588  065f 270f          	jreq	L633
3589  0661 4d            	tnz	a
3590  0662 270c          	jreq	L633
3591  0664 ae0413        	ldw	x,#1043
3592  0667 89            	pushw	x
3593  0668 ae0008        	ldw	x,#L525
3594  066b 8d000000      	callf	f_assert_failed
3596  066f 85            	popw	x
3597  0670               L633:
3598                     ; 1045   if (NewState)
3600  0670 7b01          	ld	a,(OFST+1,sp)
3601  0672 2706          	jreq	L5261
3602                     ; 1048     USART->CR5 |= USART_CR5_SCEN;
3604  0674 721a5238      	bset	21048,#5
3606  0678 2004          	jra	L7261
3607  067a               L5261:
3608                     ; 1053     USART->CR5 &= ((u8)(~USART_CR5_SCEN));
3610  067a 721b5238      	bres	21048,#5
3611  067e               L7261:
3612                     ; 1055 }
3615  067e 84            	pop	a
3616  067f 87            	retf	
3652                     ; 1075 void USART_SmartCardNACKCmd(FunctionalState NewState)
3652                     ; 1076 {
3653                     	switch	.text
3654  0680               f_USART_SmartCardNACKCmd:
3656  0680 88            	push	a
3657       00000000      OFST:	set	0
3660                     ; 1077   assert_param(IS_STATE_VALUE_OK(NewState));
3662  0681 a101          	cp	a,#1
3663  0683 270f          	jreq	L053
3664  0685 4d            	tnz	a
3665  0686 270c          	jreq	L053
3666  0688 ae0435        	ldw	x,#1077
3667  068b 89            	pushw	x
3668  068c ae0008        	ldw	x,#L525
3669  068f 8d000000      	callf	f_assert_failed
3671  0693 85            	popw	x
3672  0694               L053:
3673                     ; 1079   if (NewState)
3675  0694 7b01          	ld	a,(OFST+1,sp)
3676  0696 2706          	jreq	L7461
3677                     ; 1082     USART->CR5 |= USART_CR5_NACK;
3679  0698 72185238      	bset	21048,#4
3681  069c 2004          	jra	L1561
3682  069e               L7461:
3683                     ; 1087     USART->CR5 &= ((u8)~(USART_CR5_NACK));
3685  069e 72195238      	bres	21048,#4
3686  06a2               L1561:
3687                     ; 1089 }
3690  06a2 84            	pop	a
3691  06a3 87            	retf	
3748                     ; 1110 void USART_WakeUpConfig(USART_WakeUp_TypeDef USART_WakeUp)
3748                     ; 1111 {
3749                     	switch	.text
3750  06a4               f_USART_WakeUpConfig:
3752  06a4 88            	push	a
3753       00000000      OFST:	set	0
3756                     ; 1112   assert_param(IS_USART_WAKEUP_VALUE_OK(USART_WakeUp));
3758  06a5 4d            	tnz	a
3759  06a6 2710          	jreq	L263
3760  06a8 a108          	cp	a,#8
3761  06aa 270c          	jreq	L263
3762  06ac ae0458        	ldw	x,#1112
3763  06af 89            	pushw	x
3764  06b0 ae0008        	ldw	x,#L525
3765  06b3 8d000000      	callf	f_assert_failed
3767  06b7 85            	popw	x
3768  06b8               L263:
3769                     ; 1114   USART->CR1 &= ((u8)~USART_CR1_WAKE);
3771  06b8 72175234      	bres	21044,#3
3772                     ; 1115   USART->CR1 |= (u8)USART_WakeUp;
3774  06bc c65234        	ld	a,21044
3775  06bf 1a01          	or	a,(OFST+1,sp)
3776  06c1 c75234        	ld	21044,a
3777                     ; 1116 }
3780  06c4 84            	pop	a
3781  06c5 87            	retf	
3793                     	xref	f_CLK_GetClockFreq
3794                     	xdef	f_USART_WakeUpConfig
3795                     	xdef	f_USART_SmartCardNACKCmd
3796                     	xdef	f_USART_SmartCardCmd
3797                     	xdef	f_USART_SetPrescaler
3798                     	xdef	f_USART_SetGuardTime
3799                     	xdef	f_USART_SetAddress
3800                     	xdef	f_USART_SendData9
3801                     	xdef	f_USART_SendData8
3802                     	xdef	f_USART_SendBreak
3803                     	xdef	f_USART_ReceiverWakeUpCmd
3804                     	xdef	f_USART_ReceiveData9
3805                     	xdef	f_USART_ReceiveData8
3806                     	xdef	f_USART_LINCmd
3807                     	xdef	f_USART_LINBreakDetectionConfig
3808                     	xdef	f_USART_ITConfig
3809                     	xdef	f_USART_IrDACmd
3810                     	xdef	f_USART_IrDAConfig
3811                     	xdef	f_USART_Init
3812                     	xdef	f_USART_StructInit
3813                     	xdef	f_USART_HalfDuplexCmd
3814                     	xdef	f_USART_GetITStatus
3815                     	xdef	f_USART_GetFlagStatus
3816                     	xdef	f_USART_DeInit
3817                     	xdef	f_USART_Cmd
3818                     	xdef	f_USART_ClearITPendingBit
3819                     	xdef	f_USART_ClearFlag
3820                     	xref	f_assert_failed
3821                     	switch	.const
3822  0008               L525:
3823  0008 736f75636573  	dc.b	"souces\src\stm8_us"
3824  001a 6172742e6300  	dc.b	"art.c",0
3825                     	xref.b	c_lreg
3845                     	xref	d_lursh
3846                     	xref	d_lsub
3847                     	xref	d_smul
3848                     	xref	d_ludv
3849                     	xref	d_rtol
3850                     	xref	d_llsh
3851                     	xref	d_lcmp
3852                     	xref	d_ltor
3853                     	end
