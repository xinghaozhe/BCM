   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 914                     ; 80 void LINUART_ClearFlag(LINUART_Flag_TypeDef LINUART_FLAG)
 914                     ; 81 {
 915                     	switch	.text
 916  0000               f_LINUART_ClearFlag:
 918  0000 88            	push	a
 919  0001 88            	push	a
 920       00000001      OFST:	set	1
 923                     ; 82   u8 dummy =0x00;
 925  0002 0f01          	clr	(OFST+0,sp)
 926                     ; 83   assert_param(IS_LINUART_FLAG_VALUE_OK(LINUART_FLAG));
 928  0004 a177          	cp	a,#119
 929  0006 2737          	jreq	L21
 930  0008 a166          	cp	a,#102
 931  000a 2733          	jreq	L21
 932  000c a155          	cp	a,#85
 933  000e 272f          	jreq	L21
 934  0010 a144          	cp	a,#68
 935  0012 272b          	jreq	L21
 936  0014 a153          	cp	a,#83
 937  0016 2727          	jreq	L21
 938  0018 a102          	cp	a,#2
 939  001a 2723          	jreq	L21
 940  001c a101          	cp	a,#1
 941  001e 271f          	jreq	L21
 942  0020 4d            	tnz	a
 943  0021 271c          	jreq	L21
 944  0023 a164          	cp	a,#100
 945  0025 2718          	jreq	L21
 946  0027 a121          	cp	a,#33
 947  0029 2714          	jreq	L21
 948  002b a110          	cp	a,#16
 949  002d 2710          	jreq	L21
 950  002f a120          	cp	a,#32
 951  0031 270c          	jreq	L21
 952  0033 ae0053        	ldw	x,#83
 953  0036 89            	pushw	x
 954  0037 ae0008        	ldw	x,#L735
 955  003a 8d000000      	callf	f_assert_failed
 957  003e 85            	popw	x
 958  003f               L21:
 959                     ; 85   switch (LINUART_FLAG)
 961  003f 7b02          	ld	a,(OFST+1,sp)
 963                     ; 128     default:
 963                     ; 129       break;
 964  0041 2739          	jreq	L144
 965  0043 4a            	dec	a
 966  0044 2736          	jreq	L144
 967  0046 4a            	dec	a
 968  0047 2733          	jreq	L144
 969  0049 a00e          	sub	a,#14
 970  004b 2740          	jreq	L744
 971  004d a010          	sub	a,#16
 972  004f 2742          	jreq	L154
 973  0051 a024          	sub	a,#36
 974  0053 2727          	jreq	L144
 975  0055 a00f          	sub	a,#15
 976  0057 2723          	jreq	L144
 977  0059 a002          	sub	a,#2
 978  005b 271a          	jreq	L734
 979  005d a00f          	sub	a,#15
 980  005f 2726          	jreq	L344
 981  0061 a002          	sub	a,#2
 982  0063 2709          	jreq	L534
 983  0065 a011          	sub	a,#17
 984  0067 262e          	jrne	L345
 985                     ; 88     case LINUART_FLAG_TXE:
 985                     ; 89       LINUART->DR = (u8)0x00;
 987  0069 c75231        	ld	21041,a
 988                     ; 90 		  break;
 990  006c 2029          	jra	L345
 991  006e               L534:
 992                     ; 92     case LINUART_FLAG_TC:
 992                     ; 93      dummy = LINUART->SR;
 994  006e c65230        	ld	a,21040
 995                     ; 94      LINUART->DR = (u8)0x00;
 997  0071 725f5231      	clr	21041
 998                     ; 95       break;
1000  0075 2020          	jra	L345
1001  0077               L734:
1002                     ; 97     case LINUART_FLAG_RXNE:
1002                     ; 98       dummy = LINUART->DR; /*< Read Data Register   */
1004  0077 c65231        	ld	a,21041
1005                     ; 99       break;
1007  007a 201b          	jra	L345
1008  007c               L144:
1009                     ; 101     case LINUART_FLAG_IDLE:
1009                     ; 102       /*< Clear the Overrun Error flag or Clear the LIN Header Error flag       */
1009                     ; 103     case LINUART_FLAG_ORE_LHE:
1009                     ; 104       /*< Clear the Noise Error flag                */
1009                     ; 105     case LINUART_FLAG_NE:
1009                     ; 106       /*< Clear the Framing Error flag              */
1009                     ; 107     case LINUART_FLAG_FE:
1009                     ; 108       /*< Clear the Parity Error flag               */
1009                     ; 109     case LINUART_FLAG_PE:
1009                     ; 110       dummy = LINUART->SR; /*< Read Status Register */
1011  007c c65230        	ld	a,21040
1012                     ; 111       dummy = LINUART->SR; /*< Read Status Register */  /*TBD*/
1014  007f c65230        	ld	a,21040
1015                     ; 112       dummy = LINUART->DR; /*< Read Data Register   */
1017  0082 c65231        	ld	a,21041
1018                     ; 113       break;
1020  0085 2010          	jra	L345
1021  0087               L344:
1022                     ; 116     case LINUART_FLAG_LBD:
1022                     ; 117       LINUART->CR4 &= (u8)(~LINUART_CR4_LBDF);
1024  0087 72195237      	bres	21047,#4
1025                     ; 118       break;
1027  008b 200a          	jra	L345
1028                     ; 119     case LINUART_FLAG_LHDF:
1028                     ; 120       /* LINUART->CR5; */ /*TBD*/
1028                     ; 121       break;
1030  008d               L744:
1031                     ; 122     case LINUART_FLAG_LSF:
1031                     ; 123       LINUART->CR5 &= (u8)(~LINUART_CR5_LSF); /*TBD*/
1033  008d 72115239      	bres	21049,#0
1034                     ; 124       break;
1036  0091 2004          	jra	L345
1037  0093               L154:
1038                     ; 125     case LINUART_FLAG_SBK:
1038                     ; 126       LINUART->CR2 &= (u8)(~LINUART_CR2_SBK);
1040  0093 72115235      	bres	21045,#0
1041                     ; 127       break;
1043                     ; 128     default:
1043                     ; 129       break;
1045  0097               L345:
1046                     ; 131 }
1049  0097 85            	popw	x
1050  0098 87            	retf	
1093                     ; 158 void LINUART_ClearITPendingBit(LINUART_Flag_TypeDef LINUART_FLAG)
1093                     ; 159 {
1094                     	switch	.text
1095  0099               f_LINUART_ClearITPendingBit:
1097  0099 88            	push	a
1098  009a 88            	push	a
1099       00000001      OFST:	set	1
1102                     ; 160   u8 dummy =0x00;
1104  009b 0f01          	clr	(OFST+0,sp)
1105                     ; 161   assert_param(IS_LINUART_ITPENDINGBIT_VALUE_OK(LINUART_FLAG));
1107  009d a177          	cp	a,#119
1108  009f 2727          	jreq	L42
1109  00a1 a166          	cp	a,#102
1110  00a3 2723          	jreq	L42
1111  00a5 a155          	cp	a,#85
1112  00a7 271f          	jreq	L42
1113  00a9 a144          	cp	a,#68
1114  00ab 271b          	jreq	L42
1115  00ad a153          	cp	a,#83
1116  00af 2717          	jreq	L42
1117  00b1 4d            	tnz	a
1118  00b2 2714          	jreq	L42
1119  00b4 a164          	cp	a,#100
1120  00b6 2710          	jreq	L42
1121  00b8 a121          	cp	a,#33
1122  00ba 270c          	jreq	L42
1123  00bc ae00a1        	ldw	x,#161
1124  00bf 89            	pushw	x
1125  00c0 ae0008        	ldw	x,#L735
1126  00c3 8d000000      	callf	f_assert_failed
1128  00c7 85            	popw	x
1129  00c8               L42:
1130                     ; 163   switch (LINUART_FLAG)
1132  00c8 7b02          	ld	a,(OFST+1,sp)
1134                     ; 197     case LINUART_FLAG_NE:
1134                     ; 198     case LINUART_FLAG_FE:
1134                     ; 199     case LINUART_FLAG_LSF:
1134                     ; 200     case LINUART_FLAG_SBK:
1134                     ; 201     default:
1134                     ; 202       break;
1135  00ca 272b          	jreq	L355
1136  00cc a044          	sub	a,#68
1137  00ce 2727          	jreq	L355
1138  00d0 a00f          	sub	a,#15
1139  00d2 2723          	jreq	L355
1140  00d4 a002          	sub	a,#2
1141  00d6 271a          	jreq	L155
1142  00d8 a00f          	sub	a,#15
1143  00da 2726          	jreq	L555
1144  00dc a002          	sub	a,#2
1145  00de 2709          	jreq	L745
1146  00e0 a011          	sub	a,#17
1147  00e2 2622          	jrne	L506
1148                     ; 166     case LINUART_FLAG_TXE:
1148                     ; 167       LINUART->DR = (u8)0x00;
1150  00e4 c75231        	ld	21041,a
1151                     ; 168 	    break;
1153  00e7 201d          	jra	L506
1154  00e9               L745:
1155                     ; 170     case LINUART_FLAG_TC:
1155                     ; 171       dummy = LINUART->SR;
1157  00e9 c65230        	ld	a,21040
1158                     ; 172       LINUART->DR = (u8)0x00;
1160  00ec 725f5231      	clr	21041
1161                     ; 173       break;
1163  00f0 2014          	jra	L506
1164  00f2               L155:
1165                     ; 175     case LINUART_FLAG_RXNE:
1165                     ; 176       dummy = LINUART->DR; /*< Read Data Register   */
1167  00f2 c65231        	ld	a,21041
1168                     ; 177 			dummy = LINUART->DR; /*< Read Data Register   */
1169                     ; 178       break;
1171  00f5 2006          	jpf	LC001
1172  00f7               L355:
1173                     ; 180     case LINUART_FLAG_IDLE:
1173                     ; 181       /*< Clear the Overrun Error flag or Clear the LIN Header Error pending bit       */
1173                     ; 182     case LINUART_FLAG_ORE_LHE:
1173                     ; 183       /*< Clear the Parity Error pending bit               */
1173                     ; 184     case LINUART_FLAG_PE:
1173                     ; 185       dummy = LINUART->SR; /*< Read Status Register */
1175  00f7 c65230        	ld	a,21040
1176                     ; 186       dummy = LINUART->SR; /*< Read Status Register */  /*TBD*/
1178  00fa c65230        	ld	a,21040
1179                     ; 187       dummy = LINUART->DR; /*< Read Data Register   */
1181  00fd               LC001:
1183  00fd c65231        	ld	a,21041
1184                     ; 188       break;
1186  0100 2004          	jra	L506
1187  0102               L555:
1188                     ; 191     case LINUART_FLAG_LBD:
1188                     ; 192       LINUART->CR4 &= (u8)(~LINUART_CR4_LBDF);
1190  0102 72195237      	bres	21047,#4
1191                     ; 193       break;
1193                     ; 194     case LINUART_FLAG_LHDF:
1193                     ; 195       /* LINUART->CR5; */ /*TBD*/
1193                     ; 196       break;
1195                     ; 197     case LINUART_FLAG_NE:
1195                     ; 198     case LINUART_FLAG_FE:
1195                     ; 199     case LINUART_FLAG_LSF:
1195                     ; 200     case LINUART_FLAG_SBK:
1195                     ; 201     default:
1195                     ; 202       break;
1197  0106               L506:
1198                     ; 204 }
1201  0106 85            	popw	x
1202  0107 87            	retf	
1256                     ; 223 void LINUART_Cmd(FunctionalState NewState)
1256                     ; 224 {
1257                     	switch	.text
1258  0108               f_LINUART_Cmd:
1262                     ; 226   if (NewState)
1264  0108 4d            	tnz	a
1265  0109 2705          	jreq	L536
1266                     ; 228     LINUART->CR1 &= (u8)(~LINUART_CR1_UARTD); /**< LINUART Enable */
1268  010b 721b5234      	bres	21044,#5
1271  010f 87            	retf	
1272  0110               L536:
1273                     ; 232     LINUART->CR1 |= LINUART_CR1_UARTD;  /**< LINUART Disable (for low power consumption) */
1275  0110 721a5234      	bset	21044,#5
1276                     ; 234 }
1279  0114 87            	retf	
1310                     ; 252 void LINUART_DeInit(void)
1310                     ; 253 {
1311                     	switch	.text
1312  0115               f_LINUART_DeInit:
1314       00000001      OFST:	set	1
1317                     ; 257   dummy = LINUART->SR;
1319  0115 c65230        	ld	a,21040
1320                     ; 258   dummy = LINUART->DR;
1322  0118 c65231        	ld	a,21041
1323                     ; 260   LINUART->BRR2 = LINUART_BRR2_RESET_VALUE;  /*< Set LINUART_BRR2 to reset value 0x00 */
1325  011b 725f5233      	clr	21043
1326                     ; 261   LINUART->BRR1 = LINUART_BRR1_RESET_VALUE;  /*< Set LINUART_BRR1 to reset value 0x00 */
1328  011f 725f5232      	clr	21042
1329                     ; 263   LINUART->CR1 = LINUART_CR1_RESET_VALUE; /*< Set LINUART_CR1 to reset value 0x00  */
1331  0123 725f5234      	clr	21044
1332                     ; 264   LINUART->CR2 = LINUART_CR2_RESET_VALUE; /*< Set LINUART_CR2 to reset value 0x00  */
1334  0127 725f5235      	clr	21045
1335                     ; 265   LINUART->CR3 = LINUART_CR3_RESET_VALUE;  /*< Set LINUART_CR3 to reset value 0x00  */
1337  012b 725f5236      	clr	21046
1338                     ; 266   LINUART->CR4 = LINUART_CR4_RESET_VALUE;  /*< Set LINUART_CR4 to reset value 0x00  */
1340  012f 725f5237      	clr	21047
1341                     ; 267   LINUART->CR5 = LINUART_CR5_RESET_VALUE; /*< Set LINUART_CR5 to reset value 0x00  */
1343  0133 725f5239      	clr	21049
1344                     ; 269 }
1347  0137 87            	retf	
1421                     ; 302 FlagStatus LINUART_GetFlagStatus(LINUART_Flag_TypeDef LINUART_FLAG)
1421                     ; 303 {
1422                     	switch	.text
1423  0138               f_LINUART_GetFlagStatus:
1425  0138 88            	push	a
1426  0139 89            	pushw	x
1427       00000002      OFST:	set	2
1430                     ; 304   FlagStatus status = RESET;
1432  013a 0f02          	clr	(OFST+0,sp)
1433                     ; 305   u8 itpos = 0;
1435                     ; 308   assert_param(IS_LINUART_FLAG_VALUE_OK(LINUART_FLAG));
1437  013c 7b03          	ld	a,(OFST+1,sp)
1438  013e a177          	cp	a,#119
1439  0140 273a          	jreq	L24
1440  0142 a166          	cp	a,#102
1441  0144 2736          	jreq	L24
1442  0146 a155          	cp	a,#85
1443  0148 2732          	jreq	L24
1444  014a a144          	cp	a,#68
1445  014c 272e          	jreq	L24
1446  014e a153          	cp	a,#83
1447  0150 272a          	jreq	L24
1448  0152 a102          	cp	a,#2
1449  0154 2726          	jreq	L24
1450  0156 a101          	cp	a,#1
1451  0158 2722          	jreq	L24
1452  015a 7b03          	ld	a,(OFST+1,sp)
1453  015c 271e          	jreq	L24
1454  015e a164          	cp	a,#100
1455  0160 271a          	jreq	L24
1456  0162 a121          	cp	a,#33
1457  0164 2716          	jreq	L24
1458  0166 a110          	cp	a,#16
1459  0168 2712          	jreq	L24
1460  016a a120          	cp	a,#32
1461  016c 270e          	jreq	L24
1462  016e ae0134        	ldw	x,#308
1463  0171 89            	pushw	x
1464  0172 ae0008        	ldw	x,#L735
1465  0175 8d000000      	callf	f_assert_failed
1467  0179 85            	popw	x
1468  017a 7b03          	ld	a,(OFST+1,sp)
1469  017c               L24:
1470                     ; 311   itpos = (u8)((u8)1 << (u8)((u8)LINUART_FLAG & (u8)0x0F));
1472  017c a40f          	and	a,#15
1473  017e 5f            	clrw	x
1474  017f 97            	ld	xl,a
1475  0180 a601          	ld	a,#1
1476  0182 5d            	tnzw	x
1477  0183 2704          	jreq	L64
1478  0185               L05:
1479  0185 48            	sll	a
1480  0186 5a            	decw	x
1481  0187 26fc          	jrne	L05
1482  0189               L64:
1483  0189 6b01          	ld	(OFST-1,sp),a
1484                     ; 314   switch (LINUART_FLAG)
1486  018b 7b03          	ld	a,(OFST+1,sp)
1488                     ; 383       break;
1489  018d 2730          	jreq	L756
1490  018f 4a            	dec	a
1491  0190 272d          	jreq	L756
1492  0192 4a            	dec	a
1493  0193 272a          	jreq	L756
1494  0195 a00e          	sub	a,#14
1495  0197 2736          	jreq	L366
1496  0199 a010          	sub	a,#16
1497  019b 2727          	jreq	L166
1498  019d 4a            	dec	a
1499  019e 272f          	jreq	L366
1500  01a0 a023          	sub	a,#35
1501  01a2 271b          	jreq	L756
1502  01a4 a00f          	sub	a,#15
1503  01a6 2717          	jreq	L756
1504  01a8 a002          	sub	a,#2
1505  01aa 2713          	jreq	L756
1506  01ac a00f          	sub	a,#15
1507  01ae 270a          	jreq	L556
1508  01b0 a002          	sub	a,#2
1509  01b2 270b          	jreq	L756
1510  01b4 a011          	sub	a,#17
1511  01b6 2707          	jreq	L756
1512                     ; 381     default:
1512                     ; 382       status = SET;
1513                     ; 383       break;
1515  01b8 2011          	jpf	LC003
1516  01ba               L556:
1517                     ; 316     case LINUART_FLAG_LBD:
1517                     ; 317       if ((LINUART->CR4 & itpos) != (u8)0x00)
1519  01ba c65237        	ld	a,21047
1520                     ; 320         status = SET;
1522  01bd 2008          	jpf	LC004
1523                     ; 325         status = RESET;
1524  01bf               L756:
1525                     ; 329     case LINUART_FLAG_TXE:
1525                     ; 330       /*< Returns the Transmission Complete flag state   */
1525                     ; 331     case LINUART_FLAG_TC:
1525                     ; 332       /*< Returns the Read Data Not Empty flag state     */
1525                     ; 333     case LINUART_FLAG_RXNE:
1525                     ; 334       /*< Returns the IDLE Detection flag state          */
1525                     ; 335     case LINUART_FLAG_IDLE:
1525                     ; 336       /*< Returns the Overrun Error flag state           */
1525                     ; 337     case LINUART_FLAG_ORE_LHE:
1525                     ; 338       /*< Returns the Noise Error flag state             */
1525                     ; 339     case LINUART_FLAG_NE:
1525                     ; 340       /*< Returns the Framing Error flag state           */
1525                     ; 341     case LINUART_FLAG_FE:
1525                     ; 342       /*< Returns the Parity Error flag state            */
1525                     ; 343     case LINUART_FLAG_PE:
1525                     ; 344 
1525                     ; 345       if ((LINUART->SR & itpos) != (u8)0x00)
1527  01bf c65230        	ld	a,21040
1528                     ; 348         status = SET;
1530  01c2 2003          	jpf	LC004
1531                     ; 353         status = RESET;
1532  01c4               L166:
1533                     ; 358     case LINUART_FLAG_SBK:
1533                     ; 359       if ((LINUART->CR2 & itpos) != (u8)0x00)
1535  01c4 c65235        	ld	a,21045
1536  01c7               LC004:
1537  01c7 1501          	bcp	a,(OFST-1,sp)
1538  01c9 270b          	jreq	L347
1539                     ; 362         status = SET;
1541  01cb               LC003:
1546  01cb a601          	ld	a,#1
1548  01cd 2008          	jra	L527
1549                     ; 367         status = RESET;
1550  01cf               L366:
1551                     ; 370     case LINUART_FLAG_LHDF:
1551                     ; 371     case LINUART_FLAG_LSF:
1551                     ; 372       if ((LINUART->CR5 & itpos) != (u8)0x00)
1553  01cf c65239        	ld	a,21049
1554  01d2 1501          	bcp	a,(OFST-1,sp)
1555                     ; 374         status = SET;
1557  01d4 26f5          	jrne	LC003
1558  01d6               L347:
1559                     ; 378         status = RESET;
1564  01d6 4f            	clr	a
1565  01d7               L527:
1566                     ; 386   return  status;
1570  01d7 5b03          	addw	sp,#3
1571  01d9 87            	retf	
1646                     ; 413 ITStatus LINUART_GetITStatus(LINUART_Flag_TypeDef LINUART_FLAG)
1646                     ; 414 {
1647                     	switch	.text
1648  01da               f_LINUART_GetITStatus:
1650  01da 88            	push	a
1651  01db 5203          	subw	sp,#3
1652       00000003      OFST:	set	3
1655                     ; 416   ITStatus pendingbitstatus = RESET;
1657  01dd 4f            	clr	a
1658  01de 6b03          	ld	(OFST+0,sp),a
1659                     ; 417   u8 itpos = 0;
1661                     ; 418   u8 itmask1 = 0;
1663                     ; 419   u8 itmask2 = 0;
1665                     ; 420   u8 enablestatus = 0;
1667                     ; 423   assert_param(IS_LINUART_ITPENDINGBIT_VALUE_OK(LINUART_FLAG));
1669  01e0 7b04          	ld	a,(OFST+1,sp)
1670  01e2 a177          	cp	a,#119
1671  01e4 272a          	jreq	L06
1672  01e6 a166          	cp	a,#102
1673  01e8 2726          	jreq	L06
1674  01ea a155          	cp	a,#85
1675  01ec 2722          	jreq	L06
1676  01ee a144          	cp	a,#68
1677  01f0 271e          	jreq	L06
1678  01f2 a153          	cp	a,#83
1679  01f4 271a          	jreq	L06
1680  01f6 7b04          	ld	a,(OFST+1,sp)
1681  01f8 2716          	jreq	L06
1682  01fa a164          	cp	a,#100
1683  01fc 2712          	jreq	L06
1684  01fe a121          	cp	a,#33
1685  0200 270e          	jreq	L06
1686  0202 ae01a7        	ldw	x,#423
1687  0205 89            	pushw	x
1688  0206 ae0008        	ldw	x,#L735
1689  0209 8d000000      	callf	f_assert_failed
1691  020d 85            	popw	x
1692  020e 7b04          	ld	a,(OFST+1,sp)
1693  0210               L06:
1694                     ; 426   itpos = (u8)((u8)1 << (u8)((u8)LINUART_FLAG & (u8)0x0F));
1696  0210 a40f          	and	a,#15
1697  0212 5f            	clrw	x
1698  0213 97            	ld	xl,a
1699  0214 a601          	ld	a,#1
1700  0216 5d            	tnzw	x
1701  0217 2704          	jreq	L46
1702  0219               L66:
1703  0219 48            	sll	a
1704  021a 5a            	decw	x
1705  021b 26fc          	jrne	L66
1706  021d               L46:
1707  021d 6b01          	ld	(OFST-2,sp),a
1708                     ; 428   itmask1 = (u8)((u8)LINUART_FLAG >> (u8)4);
1710  021f 7b04          	ld	a,(OFST+1,sp)
1711  0221 4e            	swap	a
1712  0222 a40f          	and	a,#15
1713  0224 6b02          	ld	(OFST-1,sp),a
1714                     ; 430   itmask2 = (u8)((u8)1 << itmask1);
1716  0226 5f            	clrw	x
1717  0227 97            	ld	xl,a
1718  0228 a601          	ld	a,#1
1719  022a 5d            	tnzw	x
1720  022b 2704          	jreq	L07
1721  022d               L27:
1722  022d 48            	sll	a
1723  022e 5a            	decw	x
1724  022f 26fc          	jrne	L27
1725  0231               L07:
1726  0231 6b02          	ld	(OFST-1,sp),a
1727                     ; 432   switch (LINUART_FLAG)
1729  0233 7b04          	ld	a,(OFST+1,sp)
1731                     ; 508       break;
1732  0235 2737          	jreq	L157
1733  0237 4a            	dec	a
1734  0238 2767          	jreq	L757
1735  023a 4a            	dec	a
1736  023b 2764          	jreq	L757
1737  023d a00e          	sub	a,#14
1738  023f 2760          	jreq	L757
1739  0241 a010          	sub	a,#16
1740  0243 275c          	jreq	L757
1741  0245 4a            	dec	a
1742  0246 2747          	jreq	L557
1743  0248 a023          	sub	a,#35
1744  024a 2737          	jreq	L357
1745  024c a00f          	sub	a,#15
1746  024e 2733          	jreq	L357
1747  0250 a002          	sub	a,#2
1748  0252 272f          	jreq	L357
1749  0254 a00f          	sub	a,#15
1750  0256 270a          	jreq	L747
1751  0258 a002          	sub	a,#2
1752  025a 2727          	jreq	L357
1753  025c a011          	sub	a,#17
1754  025e 2723          	jreq	L357
1755  0260 203f          	jra	L757
1756  0262               L747:
1757                     ; 434     case LINUART_FLAG_LBD:
1757                     ; 435       /* Get the LINUART_FLAG enable bit status*/
1757                     ; 436       enablestatus = (u8)((u8)LINUART->CR4 & itmask2);
1759  0262 c65237        	ld	a,21047
1760  0265 1402          	and	a,(OFST-1,sp)
1761  0267 6b03          	ld	(OFST+0,sp),a
1762                     ; 438       if (((LINUART->CR4 & itpos) != (u8)0x00) && enablestatus)
1764  0269 c65237        	ld	a,21047
1766                     ; 441         pendingbitstatus = SET;
1768  026c 202b          	jpf	LC007
1769                     ; 446         pendingbitstatus = RESET;
1770  026e               L157:
1771                     ; 450     case LINUART_FLAG_PE:
1771                     ; 451 
1771                     ; 452       /* Get the LINUART_FLAG enable bit status*/
1771                     ; 453       enablestatus = (u8)((u8)LINUART->CR1 & itmask2);
1773  026e c65234        	ld	a,21044
1774  0271 1402          	and	a,(OFST-1,sp)
1775  0273 6b03          	ld	(OFST+0,sp),a
1776                     ; 456       if (((LINUART->SR & itpos) != (u8)0x00) && enablestatus)
1778  0275 c65230        	ld	a,21040
1779  0278 1501          	bcp	a,(OFST-2,sp)
1780  027a 2704          	jreq	L3201
1782  027c 7b03          	ld	a,(OFST+0,sp)
1783                     ; 459         pendingbitstatus = SET;
1785  027e 2621          	jrne	L757
1786  0280               L3201:
1787                     ; 464         pendingbitstatus = RESET;
1792  0280 4f            	clr	a
1793  0281 2020          	jra	L5101
1794  0283               L357:
1795                     ; 468     case LINUART_FLAG_TXE:
1795                     ; 469     case LINUART_FLAG_TC:
1795                     ; 470     case LINUART_FLAG_RXNE:
1795                     ; 471     case LINUART_FLAG_IDLE:
1795                     ; 472     case LINUART_FLAG_ORE_LHE:
1795                     ; 473       /* Get the LINUART_FLAG enable bit status*/
1795                     ; 474       enablestatus = (u8)((u8)LINUART->CR2 & itmask2);
1797  0283 c65235        	ld	a,21045
1798  0286 1402          	and	a,(OFST-1,sp)
1799  0288 6b03          	ld	(OFST+0,sp),a
1800                     ; 476       if (((LINUART->SR & itpos) != (u8)0x00) && enablestatus)
1802  028a c65230        	ld	a,21040
1804                     ; 479         pendingbitstatus = SET;
1806  028d 200a          	jpf	LC007
1807                     ; 484         pendingbitstatus = RESET;
1808  028f               L557:
1809                     ; 487     case LINUART_FLAG_LHDF:
1809                     ; 488       /* Get the LINUART_FLAG enable bit status*/
1809                     ; 489       enablestatus = (u8)((u8)LINUART->CR5 & itmask2);
1811  028f c65239        	ld	a,21049
1812  0292 1402          	and	a,(OFST-1,sp)
1813  0294 6b03          	ld	(OFST+0,sp),a
1814                     ; 491       if (((LINUART->CR5 & itpos) != (u8)0x00) && enablestatus)
1816  0296 c65239        	ld	a,21049
1818  0299               LC007:
1819  0299 1501          	bcp	a,(OFST-2,sp)
1820  029b 27e3          	jreq	L3201
1821  029d 7b03          	ld	a,(OFST+0,sp)
1822  029f 27df          	jreq	L3201
1823                     ; 494         pendingbitstatus = SET;
1825                     ; 499         pendingbitstatus = RESET;
1826  02a1               L757:
1827                     ; 502     case LINUART_FLAG_NE:
1827                     ; 503     case LINUART_FLAG_FE:
1827                     ; 504     case LINUART_FLAG_LSF:
1827                     ; 505     case LINUART_FLAG_SBK:
1827                     ; 506     default:
1827                     ; 507       pendingbitstatus = SET;
1833  02a1 a601          	ld	a,#1
1834                     ; 508       break;
1836  02a3               L5101:
1837                     ; 512   return  pendingbitstatus;
1841  02a3 5b04          	addw	sp,#4
1842  02a5 87            	retf	
2048                     ; 530 void LINUART_StructInit(LINUART_Init_TypeDef* LINUART_InitStruct)
2048                     ; 531 {
2049                     	switch	.text
2050  02a6               f_LINUART_StructInit:
2054                     ; 532   LINUART_InitStruct->WordLength          = LINUART_WORDLENGTH_8D;
2056  02a6 7f            	clr	(x)
2057                     ; 533   LINUART_InitStruct->StopBits            = LINUART_STOPBITS_1;
2059  02a7 6f01          	clr	(1,x)
2060                     ; 534   LINUART_InitStruct->Parity              = LINUART_PARITY_NO;
2062  02a9 6f02          	clr	(2,x)
2063                     ; 535   LINUART_InitStruct->BaudRate            = (u32)9600;
2065  02ab a680          	ld	a,#128
2066  02ad e706          	ld	(6,x),a
2067  02af a625          	ld	a,#37
2068  02b1 e705          	ld	(5,x),a
2069  02b3 4f            	clr	a
2070  02b4 e704          	ld	(4,x),a
2071  02b6 e703          	ld	(3,x),a
2072                     ; 536   LINUART_InitStruct->Mode                = LINUART_MODE_TXRX_ENABLE;
2074  02b8 a60c          	ld	a,#12
2075  02ba e707          	ld	(7,x),a
2076                     ; 537 }
2079  02bc 87            	retf	
2146                     .const:	section	.text
2147  0000               L231:
2148  0000 00098969      	dc.l	625001
2149  0004               L451:
2150  0004 00000064      	dc.l	100
2151                     ; 552 void LINUART_Init(LINUART_Init_TypeDef* LINUART_InitStruct)
2151                     ; 553 {
2152                     	switch	.text
2153  02bd               f_LINUART_Init:
2155  02bd 89            	pushw	x
2156  02be 520e          	subw	sp,#14
2157       0000000e      OFST:	set	14
2160                     ; 557   assert_param(IS_LINUART_WORDLENGTH_VALUE_OK(LINUART_InitStruct->WordLength));
2162  02c0 f6            	ld	a,(x)
2163  02c1 2710          	jreq	L401
2164  02c3 a110          	cp	a,#16
2165  02c5 270c          	jreq	L401
2166  02c7 ae022d        	ldw	x,#557
2167  02ca 89            	pushw	x
2168  02cb ae0008        	ldw	x,#L735
2169  02ce 8d000000      	callf	f_assert_failed
2171  02d2 85            	popw	x
2172  02d3               L401:
2173                     ; 559   assert_param(IS_LINUART_STOPBITS_VALUE_OK(LINUART_InitStruct->StopBits));
2175  02d3 1e0f          	ldw	x,(OFST+1,sp)
2176  02d5 e601          	ld	a,(1,x)
2177  02d7 2712          	jreq	L411
2178  02d9 a120          	cp	a,#32
2179  02db 270e          	jreq	L411
2180  02dd ae022f        	ldw	x,#559
2181  02e0 89            	pushw	x
2182  02e1 ae0008        	ldw	x,#L735
2183  02e4 8d000000      	callf	f_assert_failed
2185  02e8 85            	popw	x
2186  02e9 1e0f          	ldw	x,(OFST+1,sp)
2187  02eb               L411:
2188                     ; 561   assert_param(IS_LINUART_PARITY_VALUE_OK(LINUART_InitStruct->Parity));
2190  02eb e602          	ld	a,(2,x)
2191  02ed 2716          	jreq	L421
2192  02ef a104          	cp	a,#4
2193  02f1 2712          	jreq	L421
2194  02f3 a106          	cp	a,#6
2195  02f5 270e          	jreq	L421
2196  02f7 ae0231        	ldw	x,#561
2197  02fa 89            	pushw	x
2198  02fb ae0008        	ldw	x,#L735
2199  02fe 8d000000      	callf	f_assert_failed
2201  0302 85            	popw	x
2202  0303 1e0f          	ldw	x,(OFST+1,sp)
2203  0305               L421:
2204                     ; 564   assert_param(IS_LINUART_BAUDRATE_OK(LINUART_InitStruct->BaudRate));
2206  0305 1c0003        	addw	x,#3
2207  0308 8d000000      	callf	d_ltor
2209  030c ae0000        	ldw	x,#L231
2210  030f 8d000000      	callf	d_lcmp
2212  0313 250c          	jrult	L431
2213  0315 ae0234        	ldw	x,#564
2214  0318 89            	pushw	x
2215  0319 ae0008        	ldw	x,#L735
2216  031c 8d000000      	callf	f_assert_failed
2218  0320 85            	popw	x
2219  0321               L431:
2220                     ; 567   assert_param(IS_LINUART_MODE_VALUE_OK((u8)LINUART_InitStruct->Mode));
2222  0321 1e0f          	ldw	x,(OFST+1,sp)
2223  0323 e607          	ld	a,(7,x)
2224  0325 a108          	cp	a,#8
2225  0327 2728          	jreq	L441
2226  0329 a140          	cp	a,#64
2227  032b 2724          	jreq	L441
2228  032d a104          	cp	a,#4
2229  032f 2720          	jreq	L441
2230  0331 a180          	cp	a,#128
2231  0333 271c          	jreq	L441
2232  0335 a10c          	cp	a,#12
2233  0337 2718          	jreq	L441
2234  0339 a144          	cp	a,#68
2235  033b 2714          	jreq	L441
2236  033d a1c0          	cp	a,#192
2237  033f 2710          	jreq	L441
2238  0341 a188          	cp	a,#136
2239  0343 270c          	jreq	L441
2240  0345 ae0237        	ldw	x,#567
2241  0348 89            	pushw	x
2242  0349 ae0008        	ldw	x,#L735
2243  034c 8d000000      	callf	f_assert_failed
2245  0350 85            	popw	x
2246  0351               L441:
2247                     ; 572   LINUART->CR1 &= (u8)(~LINUART_CR1_M);     /**< Clear the word length bit */
2249  0351 72195234      	bres	21044,#4
2250                     ; 573   LINUART->CR1 |= (u8)LINUART_InitStruct->WordLength; /**< Set the word length bit according to LINUART_WordLength value */
2252  0355 1e0f          	ldw	x,(OFST+1,sp)
2253  0357 c65234        	ld	a,21044
2254  035a fa            	or	a,(x)
2255  035b c75234        	ld	21044,a
2256                     ; 575   LINUART->CR3 &= (u8)(~LINUART_CR3_STOP);  /**< Clear the STOP bits */
2258  035e c65236        	ld	a,21046
2259  0361 a4cf          	and	a,#207
2260  0363 c75236        	ld	21046,a
2261                     ; 576   LINUART->CR3 |= (u8)LINUART_InitStruct->StopBits;  /**< Set the STOP bits number according to LINUART_StopBits value  */
2263  0366 c65236        	ld	a,21046
2264  0369 ea01          	or	a,(1,x)
2265  036b c75236        	ld	21046,a
2266                     ; 578   LINUART->CR1 &= (u8)(~(LINUART_CR1_PCEN | LINUART_CR1_PS));  /**< Clear the Parity Control bit */
2268  036e c65234        	ld	a,21044
2269  0371 a4f9          	and	a,#249
2270  0373 c75234        	ld	21044,a
2271                     ; 579   LINUART->CR1 |= (u8)LINUART_InitStruct->Parity;     /**< Set the Parity Control bit to LINUART_Parity value */
2273  0376 c65234        	ld	a,21044
2274  0379 ea02          	or	a,(2,x)
2275  037b c75234        	ld	21044,a
2276                     ; 581   LINUART->BRR1 &= (u8)(~LINUART_BRR1_DIVM);  /**< Clear the LSB mantissa of LINUARTDIV  */
2278  037e 725f5232      	clr	21042
2279                     ; 582   LINUART->BRR2 &= (u8)(~LINUART_BRR2_DIVM);  /**< Clear the MSB mantissa of LINUARTDIV  */
2281  0382 c65233        	ld	a,21043
2282  0385 a40f          	and	a,#15
2283  0387 c75233        	ld	21043,a
2284                     ; 583   LINUART->BRR2 &= (u8)(~LINUART_BRR2_DIVF);  /**< Clear the Fraction bits of LINUARTDIV */
2286  038a c65233        	ld	a,21043
2287  038d a4f0          	and	a,#240
2288  038f c75233        	ld	21043,a
2289                     ; 586   BaudRate_Mantissa    = ((u32)CLK_GetClockFreq() / (LINUART_InitStruct->BaudRate << 4));
2291  0392 1c0003        	addw	x,#3
2292  0395 8d000000      	callf	d_ltor
2294  0399 a604          	ld	a,#4
2295  039b 8d000000      	callf	d_llsh
2297  039f 96            	ldw	x,sp
2298  03a0 5c            	incw	x
2299  03a1 8d000000      	callf	d_rtol
2301  03a5 8d000000      	callf	f_CLK_GetClockFreq
2303  03a9 96            	ldw	x,sp
2304  03aa 5c            	incw	x
2305  03ab 8d000000      	callf	d_ludv
2307  03af 96            	ldw	x,sp
2308  03b0 1c000b        	addw	x,#OFST-3
2309  03b3 8d000000      	callf	d_rtol
2311                     ; 587   BaudRate_Mantissa100 = (((u32)CLK_GetClockFreq() * 100) / (LINUART_InitStruct->BaudRate << 4));
2313  03b7 1e0f          	ldw	x,(OFST+1,sp)
2314  03b9 1c0003        	addw	x,#3
2315  03bc 8d000000      	callf	d_ltor
2317  03c0 a604          	ld	a,#4
2318  03c2 8d000000      	callf	d_llsh
2320  03c6 96            	ldw	x,sp
2321  03c7 5c            	incw	x
2322  03c8 8d000000      	callf	d_rtol
2324  03cc 8d000000      	callf	f_CLK_GetClockFreq
2326  03d0 a664          	ld	a,#100
2327  03d2 8d000000      	callf	d_smul
2329  03d6 96            	ldw	x,sp
2330  03d7 5c            	incw	x
2331  03d8 8d000000      	callf	d_ludv
2333  03dc 96            	ldw	x,sp
2334  03dd 1c0007        	addw	x,#OFST-7
2335  03e0 8d000000      	callf	d_rtol
2337                     ; 588   BRR2_1 = (u8)((u8)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
2337                     ; 589                       << 4) / 100) & (u8)0x0F); /**< Set the fraction of USARTDIV  */
2339  03e4 96            	ldw	x,sp
2340  03e5 1c000b        	addw	x,#OFST-3
2341  03e8 8d000000      	callf	d_ltor
2343  03ec a664          	ld	a,#100
2344  03ee 8d000000      	callf	d_smul
2346  03f2 96            	ldw	x,sp
2347  03f3 5c            	incw	x
2348  03f4 8d000000      	callf	d_rtol
2350  03f8 96            	ldw	x,sp
2351  03f9 1c0007        	addw	x,#OFST-7
2352  03fc 8d000000      	callf	d_ltor
2354  0400 96            	ldw	x,sp
2355  0401 5c            	incw	x
2356  0402 8d000000      	callf	d_lsub
2358  0406 a604          	ld	a,#4
2359  0408 8d000000      	callf	d_llsh
2361  040c ae0004        	ldw	x,#L451
2362  040f 8d000000      	callf	d_ludv
2364  0413 b603          	ld	a,c_lreg+3
2365  0415 a40f          	and	a,#15
2366  0417 6b05          	ld	(OFST-9,sp),a
2367                     ; 590   BRR2_2 = (u8)((BaudRate_Mantissa >> 4) & (u8)0xF0);
2369  0419 96            	ldw	x,sp
2370  041a 1c000b        	addw	x,#OFST-3
2371  041d 8d000000      	callf	d_ltor
2373  0421 a604          	ld	a,#4
2374  0423 8d000000      	callf	d_lursh
2376  0427 b603          	ld	a,c_lreg+3
2377  0429 a4f0          	and	a,#240
2378  042b b703          	ld	c_lreg+3,a
2379  042d 3f02          	clr	c_lreg+2
2380  042f 3f01          	clr	c_lreg+1
2381  0431 3f00          	clr	c_lreg
2382  0433 6b06          	ld	(OFST-8,sp),a
2383                     ; 592   LINUART->BRR2 = (u8)(BRR2_1 | BRR2_2);
2385  0435 1a05          	or	a,(OFST-9,sp)
2386  0437 c75233        	ld	21043,a
2387                     ; 593   LINUART->BRR1 = (u8)BaudRate_Mantissa;           /**< Set the LSB mantissa of LINUARTDIV  */
2389  043a 7b0e          	ld	a,(OFST+0,sp)
2390  043c c75232        	ld	21042,a
2391                     ; 595   if ((u8)LINUART_InitStruct->Mode&(u8)LINUART_MODE_TX_ENABLE)
2393  043f 1e0f          	ldw	x,(OFST+1,sp)
2394  0441 e607          	ld	a,(7,x)
2395  0443 a504          	bcp	a,#4
2396  0445 2706          	jreq	L5021
2397                     ; 597     LINUART->CR2 |= LINUART_CR2_TEN;  /**< Set the Transmitter Enable bit */
2399  0447 72165235      	bset	21045,#3
2401  044b 2004          	jra	L7021
2402  044d               L5021:
2403                     ; 601     LINUART->CR2 &= (u8)(~LINUART_CR2_TEN);  /**< Clear the Transmitter Disable bit */
2405  044d 72175235      	bres	21045,#3
2406  0451               L7021:
2407                     ; 603   if ((u8)LINUART_InitStruct->Mode & (u8)LINUART_MODE_RX_ENABLE)
2409  0451 a508          	bcp	a,#8
2410  0453 2706          	jreq	L1121
2411                     ; 605     LINUART->CR2 |= LINUART_CR2_REN;  /**< Set the Receiver Enable bit */
2413  0455 72145235      	bset	21045,#2
2415  0459 2004          	jra	L3121
2416  045b               L1121:
2417                     ; 609     LINUART->CR2 &= (u8)(~LINUART_CR2_REN);  /**< Clear the Receiver Disable bit */
2419  045b 72155235      	bres	21045,#2
2420  045f               L3121:
2421                     ; 611 }
2424  045f 5b10          	addw	sp,#16
2425  0461 87            	retf	
2525                     ; 630 void LINUART_ITConfig(LINUART_IT_TypeDef LINUART_IT, FunctionalState NewState)
2525                     ; 631 {
2526                     	switch	.text
2527  0462               f_LINUART_ITConfig:
2529  0462 89            	pushw	x
2530       00000000      OFST:	set	0
2533                     ; 632   assert_param(IS_LINUART_IT_VALUE_OK(LINUART_IT));
2535  0463 9e            	ld	a,xh
2536  0464 4a            	dec	a
2537  0465 272a          	jreq	L461
2538  0467 9e            	ld	a,xh
2539  0468 a180          	cp	a,#128
2540  046a 2725          	jreq	L461
2541  046c 9e            	ld	a,xh
2542  046d a140          	cp	a,#64
2543  046f 2720          	jreq	L461
2544  0471 9e            	ld	a,xh
2545  0472 a120          	cp	a,#32
2546  0474 271b          	jreq	L461
2547  0476 9e            	ld	a,xh
2548  0477 a110          	cp	a,#16
2549  0479 2716          	jreq	L461
2550  047b 9e            	ld	a,xh
2551  047c a108          	cp	a,#8
2552  047e 2711          	jreq	L461
2553  0480 9e            	ld	a,xh
2554  0481 a104          	cp	a,#4
2555  0483 270c          	jreq	L461
2556  0485 ae0278        	ldw	x,#632
2557  0488 89            	pushw	x
2558  0489 ae0008        	ldw	x,#L735
2559  048c 8d000000      	callf	f_assert_failed
2561  0490 85            	popw	x
2562  0491               L461:
2563                     ; 633   assert_param(IS_STATE_VALUE_OK(NewState));
2565  0491 7b02          	ld	a,(OFST+2,sp)
2566  0493 4a            	dec	a
2567  0494 2710          	jreq	L471
2568  0496 7b02          	ld	a,(OFST+2,sp)
2569  0498 270c          	jreq	L471
2570  049a ae0279        	ldw	x,#633
2571  049d 89            	pushw	x
2572  049e ae0008        	ldw	x,#L735
2573  04a1 8d000000      	callf	f_assert_failed
2575  04a5 85            	popw	x
2576  04a6               L471:
2577                     ; 635   if (NewState)
2579  04a6 7b02          	ld	a,(OFST+2,sp)
2580  04a8 272a          	jreq	L1621
2581                     ; 638     LINUART->CR2 |= (u8)(((u8)LINUART_IT) & (u8)(LINUART_CR2_TIEN | LINUART_CR2_TCIEN | LINUART_CR2_RIEN | LINUART_CR2_ILIEN));
2583  04aa 7b01          	ld	a,(OFST+1,sp)
2584  04ac a4f0          	and	a,#240
2585  04ae ca5235        	or	a,21045
2586  04b1 c75235        	ld	21045,a
2587                     ; 639     LINUART->CR1 |= (u8)((u8)LINUART_IT & LINUART_CR1_PIEN);
2589  04b4 7b01          	ld	a,(OFST+1,sp)
2590  04b6 a401          	and	a,#1
2591  04b8 ca5234        	or	a,21044
2592  04bb c75234        	ld	21044,a
2593                     ; 640     LINUART->CR4 |= (u8)((u8)((u8)LINUART_IT << 3) & LINUART_CR4_LBDIEN);
2595  04be 7b01          	ld	a,(OFST+1,sp)
2596  04c0 48            	sll	a
2597  04c1 48            	sll	a
2598  04c2 48            	sll	a
2599  04c3 a440          	and	a,#64
2600  04c5 ca5237        	or	a,21047
2601  04c8 c75237        	ld	21047,a
2602                     ; 641     LINUART->CR5 |= (u8)((u8)LINUART_IT  & LINUART_CR5_LHDIEN);
2604  04cb 7b01          	ld	a,(OFST+1,sp)
2605  04cd a404          	and	a,#4
2606  04cf ca5239        	or	a,21049
2608  04d2 202c          	jra	L3621
2609  04d4               L1621:
2610                     ; 647     LINUART->CR2 &= (u8)(~(((u8)LINUART_IT) & (u8)(LINUART_CR2_TIEN | LINUART_CR2_TCIEN | LINUART_CR2_RIEN | LINUART_CR2_ILIEN)));
2612  04d4 7b01          	ld	a,(OFST+1,sp)
2613  04d6 a4f0          	and	a,#240
2614  04d8 43            	cpl	a
2615  04d9 c45235        	and	a,21045
2616  04dc c75235        	ld	21045,a
2617                     ; 648     LINUART->CR1 &= (u8)(~((u8)LINUART_IT & LINUART_CR1_PIEN));
2619  04df 7b01          	ld	a,(OFST+1,sp)
2620  04e1 a401          	and	a,#1
2621  04e3 43            	cpl	a
2622  04e4 c45234        	and	a,21044
2623  04e7 c75234        	ld	21044,a
2624                     ; 650 LINUART->CR4 &= (u8)(~((u8)((u8)LINUART_IT << 3) & LINUART_CR4_LBDIEN));
2626  04ea 7b01          	ld	a,(OFST+1,sp)
2627  04ec 48            	sll	a
2628  04ed 48            	sll	a
2629  04ee 48            	sll	a
2630  04ef a440          	and	a,#64
2631  04f1 43            	cpl	a
2632  04f2 c45237        	and	a,21047
2633  04f5 c75237        	ld	21047,a
2634                     ; 651     LINUART->CR5 &= (u8)(~((u8)LINUART_IT  & LINUART_CR5_LHDIEN));
2636  04f8 7b01          	ld	a,(OFST+1,sp)
2637  04fa a404          	and	a,#4
2638  04fc 43            	cpl	a
2639  04fd c45239        	and	a,21049
2640  0500               L3621:
2641  0500 c75239        	ld	21049,a
2642                     ; 654 }
2645  0503 85            	popw	x
2646  0504 87            	retf	
2705                     ; 675 void LINUART_LINBreakDetectionConfig(LINUART_LINBreakDetectionLength_TypeDef LINUART_LINBreakDetectionLength)
2705                     ; 676 {
2706                     	switch	.text
2707  0505               f_LINUART_LINBreakDetectionConfig:
2709  0505 88            	push	a
2710       00000000      OFST:	set	0
2713                     ; 677   assert_param(IS_LINUART_LINBREAKDETECTIONLENGTH_VALUE_OK(LINUART_LINBreakDetectionLength));
2715  0506 a101          	cp	a,#1
2716  0508 2710          	jreq	L602
2717  050a a102          	cp	a,#2
2718  050c 270c          	jreq	L602
2719  050e ae02a5        	ldw	x,#677
2720  0511 89            	pushw	x
2721  0512 ae0008        	ldw	x,#L735
2722  0515 8d000000      	callf	f_assert_failed
2724  0519 85            	popw	x
2725  051a               L602:
2726                     ; 679   if (LINUART_LINBreakDetectionLength == LINUART_BREAK10BITS)
2728  051a 7b01          	ld	a,(OFST+1,sp)
2729  051c 4a            	dec	a
2730  051d 2606          	jrne	L3131
2731                     ; 681     LINUART->CR4 &= ((u8)~LINUART_CR4_LBDL);
2733  051f 721b5237      	bres	21047,#5
2735  0523 2004          	jra	L5131
2736  0525               L3131:
2737                     ; 685     LINUART->CR4 |= LINUART_CR4_LBDL;
2739  0525 721a5237      	bset	21047,#5
2740  0529               L5131:
2741                     ; 687 }
2744  0529 84            	pop	a
2745  052a 87            	retf	
2866                     ; 715 void LINUART_LINConfig(LINUART_Slave_TypeDef LINUART_Slave, LINUART_Autosync_TypeDef LINUART_Autosync, LINUART_DivUp_TypeDef LINUART_DivUp)
2866                     ; 716 {
2867                     	switch	.text
2868  052b               f_LINUART_LINConfig:
2870  052b 89            	pushw	x
2871       00000000      OFST:	set	0
2874                     ; 717   assert_param(IS_LINUART_SLAVE_VALUE_OK(LINUART_Slave));
2876  052c 9e            	ld	a,xh
2877  052d 4a            	dec	a
2878  052e 2711          	jreq	L022
2879  0530 9e            	ld	a,xh
2880  0531 a102          	cp	a,#2
2881  0533 270c          	jreq	L022
2882  0535 ae02cd        	ldw	x,#717
2883  0538 89            	pushw	x
2884  0539 ae0008        	ldw	x,#L735
2885  053c 8d000000      	callf	f_assert_failed
2887  0540 85            	popw	x
2888  0541               L022:
2889                     ; 719   assert_param(IS_LINUART_AUTOSYNC_VALUE_OK(LINUART_Autosync));
2891  0541 7b02          	ld	a,(OFST+2,sp)
2892  0543 a101          	cp	a,#1
2893  0545 2710          	jreq	L032
2894  0547 a102          	cp	a,#2
2895  0549 270c          	jreq	L032
2896  054b ae02cf        	ldw	x,#719
2897  054e 89            	pushw	x
2898  054f ae0008        	ldw	x,#L735
2899  0552 8d000000      	callf	f_assert_failed
2901  0556 85            	popw	x
2902  0557               L032:
2903                     ; 721   assert_param(IS_LINUART_DIVUP_VALUE_OK(LINUART_DivUp));
2905  0557 7b06          	ld	a,(OFST+6,sp)
2906  0559 a101          	cp	a,#1
2907  055b 2710          	jreq	L042
2908  055d a102          	cp	a,#2
2909  055f 270c          	jreq	L042
2910  0561 ae02d1        	ldw	x,#721
2911  0564 89            	pushw	x
2912  0565 ae0008        	ldw	x,#L735
2913  0568 8d000000      	callf	f_assert_failed
2915  056c 85            	popw	x
2916  056d               L042:
2917                     ; 723   if (LINUART_Slave == LINUART_LIN_MASTER_MODE)
2919  056d 7b01          	ld	a,(OFST+1,sp)
2920  056f 4a            	dec	a
2921  0570 2606          	jrne	L5731
2922                     ; 725     LINUART->CR5 &= ((u8)~LINUART_CR5_LSLV);
2924  0572 721b5239      	bres	21049,#5
2926  0576 2004          	jra	L7731
2927  0578               L5731:
2928                     ; 729     LINUART->CR5 |=  LINUART_CR5_LSLV;
2930  0578 721a5239      	bset	21049,#5
2931  057c               L7731:
2932                     ; 732   if (LINUART_Autosync == LINUART_LIN_AUTOSYNC_DISABLE)
2934  057c 7b02          	ld	a,(OFST+2,sp)
2935  057e a102          	cp	a,#2
2936  0580 2606          	jrne	L1041
2937                     ; 734     LINUART->CR5 &= ((u8)~ LINUART_CR5_LASE );
2939  0582 72195239      	bres	21049,#4
2941  0586 2004          	jra	L3041
2942  0588               L1041:
2943                     ; 738     LINUART->CR5 |=  LINUART_CR5_LASE ;
2945  0588 72185239      	bset	21049,#4
2946  058c               L3041:
2947                     ; 741   if (LINUART_DivUp == LINUART_LIN_DIVUP_LBRR1)
2949  058c 7b06          	ld	a,(OFST+6,sp)
2950  058e 4a            	dec	a
2951  058f 2606          	jrne	L5041
2952                     ; 743     LINUART->CR5 &= ((u8)~ LINUART_CR5_LDUM);
2954  0591 721f5239      	bres	21049,#7
2956  0595 2004          	jra	L7041
2957  0597               L5041:
2958                     ; 747     LINUART->CR5 |=  LINUART_CR5_LDUM;
2960  0597 721e5239      	bset	21049,#7
2961  059b               L7041:
2962                     ; 750 }
2965  059b 85            	popw	x
2966  059c 87            	retf	
3001                     ; 768 void LINUART_LINCmd(FunctionalState NewState)
3001                     ; 769 {
3002                     	switch	.text
3003  059d               f_LINUART_LINCmd:
3005  059d 88            	push	a
3006       00000000      OFST:	set	0
3009                     ; 770   assert_param(IS_STATE_VALUE_OK(NewState));
3011  059e a101          	cp	a,#1
3012  05a0 270f          	jreq	L252
3013  05a2 4d            	tnz	a
3014  05a3 270c          	jreq	L252
3015  05a5 ae0302        	ldw	x,#770
3016  05a8 89            	pushw	x
3017  05a9 ae0008        	ldw	x,#L735
3018  05ac 8d000000      	callf	f_assert_failed
3020  05b0 85            	popw	x
3021  05b1               L252:
3022                     ; 772   if (NewState)
3024  05b1 7b01          	ld	a,(OFST+1,sp)
3025  05b3 2706          	jreq	L7241
3026                     ; 775     LINUART->CR3 |= LINUART_CR3_LINEN;
3028  05b5 721c5236      	bset	21046,#6
3030  05b9 2004          	jra	L1341
3031  05bb               L7241:
3032                     ; 780     LINUART->CR3 &= ((u8)~LINUART_CR3_LINEN);
3034  05bb 721d5236      	bres	21046,#6
3035  05bf               L1341:
3036                     ; 782 }
3039  05bf 84            	pop	a
3040  05c0 87            	retf	
3063                     ; 798 u8 LINUART_ReceiveData8(void)
3063                     ; 799 {
3064                     	switch	.text
3065  05c1               f_LINUART_ReceiveData8:
3069                     ; 800   return LINUART->DR;
3071  05c1 c65231        	ld	a,21041
3074  05c4 87            	retf	
3097                     ; 819 u16 LINUART_ReceiveData9(void)
3097                     ; 820 {
3098                     	switch	.text
3099  05c5               f_LINUART_ReceiveData9:
3101  05c5 89            	pushw	x
3102       00000002      OFST:	set	2
3105                     ; 821   return (u16)((((u16)LINUART->DR) | ((u16)(((u16)((u16)LINUART->CR1 & (u16)LINUART_CR1_R8)) << 1))) & ((u16)0x01FF));
3107  05c6 c65234        	ld	a,21044
3108  05c9 a480          	and	a,#128
3109  05cb 5f            	clrw	x
3110  05cc 02            	rlwa	x,a
3111  05cd 58            	sllw	x
3112  05ce 1f01          	ldw	(OFST-1,sp),x
3113  05d0 c65231        	ld	a,21041
3114  05d3 5f            	clrw	x
3115  05d4 97            	ld	xl,a
3116  05d5 01            	rrwa	x,a
3117  05d6 1a02          	or	a,(OFST+0,sp)
3118  05d8 01            	rrwa	x,a
3119  05d9 1a01          	or	a,(OFST-1,sp)
3120  05db a401          	and	a,#1
3121  05dd 01            	rrwa	x,a
3124  05de 5b02          	addw	sp,#2
3125  05e0 87            	retf	
3161                     ; 840 void LINUART_ReceiverWakeUpCmd(FunctionalState NewState)
3161                     ; 841 {
3162                     	switch	.text
3163  05e1               f_LINUART_ReceiverWakeUpCmd:
3165  05e1 88            	push	a
3166       00000000      OFST:	set	0
3169                     ; 842   assert_param(IS_STATE_VALUE_OK(NewState));
3171  05e2 a101          	cp	a,#1
3172  05e4 270f          	jreq	L072
3173  05e6 4d            	tnz	a
3174  05e7 270c          	jreq	L072
3175  05e9 ae034a        	ldw	x,#842
3176  05ec 89            	pushw	x
3177  05ed ae0008        	ldw	x,#L735
3178  05f0 8d000000      	callf	f_assert_failed
3180  05f4 85            	popw	x
3181  05f5               L072:
3182                     ; 844   if (NewState)
3184  05f5 7b01          	ld	a,(OFST+1,sp)
3185  05f7 2706          	jreq	L1741
3186                     ; 847     LINUART->CR2 |= LINUART_CR2_RWU;
3188  05f9 72125235      	bset	21045,#1
3190  05fd 2004          	jra	L3741
3191  05ff               L1741:
3192                     ; 852     LINUART->CR2 &= ((u8)~LINUART_CR2_RWU);
3194  05ff 72135235      	bres	21045,#1
3195  0603               L3741:
3196                     ; 854 }
3199  0603 84            	pop	a
3200  0604 87            	retf	
3222                     ; 870 void LINUART_SendBreak(void)
3222                     ; 871 {
3223                     	switch	.text
3224  0605               f_LINUART_SendBreak:
3228                     ; 872   LINUART->CR2 |= LINUART_CR2_SBK;
3230  0605 72105235      	bset	21045,#0
3231                     ; 873 }
3234  0609 87            	retf	
3265                     ; 892 void LINUART_SendData8(u8 Data)
3265                     ; 893 {
3266                     	switch	.text
3267  060a               f_LINUART_SendData8:
3271                     ; 895   LINUART->DR = Data;
3273  060a c75231        	ld	21041,a
3274                     ; 896 }
3277  060d 87            	retf	
3308                     ; 915 void LINUART_SendData9(u16 Data)
3308                     ; 916 {
3309                     	switch	.text
3310  060e               f_LINUART_SendData9:
3312  060e 89            	pushw	x
3313       00000000      OFST:	set	0
3316                     ; 917   LINUART->CR1 &= ((u8)~LINUART_CR1_T8);                  /**< Clear the transmit data bit 8     */
3318  060f 721d5234      	bres	21044,#6
3319                     ; 918   LINUART->CR1 |= (u8)(((u8)(Data >> 2)) & LINUART_CR1_T8); /**< Write the transmit data bit [8]   */
3321  0613 54            	srlw	x
3322  0614 54            	srlw	x
3323  0615 9f            	ld	a,xl
3324  0616 a440          	and	a,#64
3325  0618 ca5234        	or	a,21044
3326  061b c75234        	ld	21044,a
3327                     ; 919   LINUART->DR   = (u8)(Data);                    /**< Write the transmit data bit [0:7] */
3329  061e 7b02          	ld	a,(OFST+2,sp)
3330  0620 c75231        	ld	21041,a
3331                     ; 921 }
3334  0623 85            	popw	x
3335  0624 87            	retf	
3367                     ; 940 void LINUART_SetAddress(u8 LINUART_Address)
3367                     ; 941 {
3368                     	switch	.text
3369  0625               f_LINUART_SetAddress:
3371  0625 88            	push	a
3372       00000000      OFST:	set	0
3375                     ; 943   assert_param(IS_LINUART_LINUART_Address_VALUE_OK(LINUART_Address));
3377  0626 a116          	cp	a,#22
3378  0628 250c          	jrult	L603
3379  062a ae03af        	ldw	x,#943
3380  062d 89            	pushw	x
3381  062e ae0008        	ldw	x,#L735
3382  0631 8d000000      	callf	f_assert_failed
3384  0635 85            	popw	x
3385  0636               L603:
3386                     ; 946   LINUART->CR4 &= ((u8)~LINUART_CR4_ADD);
3388  0636 c65237        	ld	a,21047
3389  0639 a4f0          	and	a,#240
3390  063b c75237        	ld	21047,a
3391                     ; 948   LINUART->CR4 |= LINUART_Address;
3393  063e c65237        	ld	a,21047
3394  0641 1a01          	or	a,(OFST+1,sp)
3395  0643 c75237        	ld	21047,a
3396                     ; 949 }
3399  0646 84            	pop	a
3400  0647 87            	retf	
3458                     ; 971 void LINUART_WakeUpConfig(LINUART_WakeUp_TypeDef LINUART_WakeUp)
3458                     ; 972 {
3459                     	switch	.text
3460  0648               f_LINUART_WakeUpConfig:
3462  0648 88            	push	a
3463       00000000      OFST:	set	0
3466                     ; 973   assert_param(IS_LINUART_WAKEUP_VALUE_OK(LINUART_WakeUp));
3468  0649 4d            	tnz	a
3469  064a 2710          	jreq	L023
3470  064c a108          	cp	a,#8
3471  064e 270c          	jreq	L023
3472  0650 ae03cd        	ldw	x,#973
3473  0653 89            	pushw	x
3474  0654 ae0008        	ldw	x,#L735
3475  0657 8d000000      	callf	f_assert_failed
3477  065b 85            	popw	x
3478  065c               L023:
3479                     ; 975   LINUART->CR1 &= ((u8)~LINUART_CR1_WAKE);
3481  065c 72175234      	bres	21044,#3
3482                     ; 976   LINUART->CR1 |= (u8)LINUART_WakeUp;
3484  0660 c65234        	ld	a,21044
3485  0663 1a01          	or	a,(OFST+1,sp)
3486  0665 c75234        	ld	21044,a
3487                     ; 977 }
3490  0668 84            	pop	a
3491  0669 87            	retf	
3503                     	xref	f_CLK_GetClockFreq
3504                     	xdef	f_LINUART_WakeUpConfig
3505                     	xdef	f_LINUART_SetAddress
3506                     	xdef	f_LINUART_SendData9
3507                     	xdef	f_LINUART_SendData8
3508                     	xdef	f_LINUART_SendBreak
3509                     	xdef	f_LINUART_ReceiverWakeUpCmd
3510                     	xdef	f_LINUART_ReceiveData9
3511                     	xdef	f_LINUART_ReceiveData8
3512                     	xdef	f_LINUART_LINCmd
3513                     	xdef	f_LINUART_LINConfig
3514                     	xdef	f_LINUART_LINBreakDetectionConfig
3515                     	xdef	f_LINUART_ITConfig
3516                     	xdef	f_LINUART_Init
3517                     	xdef	f_LINUART_StructInit
3518                     	xdef	f_LINUART_GetITStatus
3519                     	xdef	f_LINUART_GetFlagStatus
3520                     	xdef	f_LINUART_DeInit
3521                     	xdef	f_LINUART_Cmd
3522                     	xdef	f_LINUART_ClearITPendingBit
3523                     	xdef	f_LINUART_ClearFlag
3524                     	xref	f_assert_failed
3525                     	switch	.const
3526  0008               L735:
3527  0008 736f75636573  	dc.b	"souces\src\stm8_li"
3528  001a 6e756172742e  	dc.b	"nuart.c",0
3529                     	xref.b	c_lreg
3549                     	xref	d_lursh
3550                     	xref	d_lsub
3551                     	xref	d_smul
3552                     	xref	d_ludv
3553                     	xref	d_rtol
3554                     	xref	d_llsh
3555                     	xref	d_lcmp
3556                     	xref	d_ltor
3557                     	end
