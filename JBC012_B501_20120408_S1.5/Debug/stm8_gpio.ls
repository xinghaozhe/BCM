   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 859                     ; 65 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 859                     ; 66 {
 860                     	switch	.text
 861  0000               f_GPIO_DeInit:
 865                     ; 67   GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 867  0000 7f            	clr	(x)
 868                     ; 68   GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 870  0001 6f02          	clr	(2,x)
 871                     ; 69   GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 873  0003 6f03          	clr	(3,x)
 874                     ; 70   GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 876  0005 6f04          	clr	(4,x)
 877                     ; 71 }
 880  0007 87            	retf	
1053                     ; 94 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Init_TypeDef* GPIO_InitStruct)
1053                     ; 95 {
1054                     	switch	.text
1055  0008               f_GPIO_Init:
1057  0008 89            	pushw	x
1058       00000000      OFST:	set	0
1061                     ; 101   assert_param(IS_GPIO_MODE_OK(GPIO_InitStruct->GPIO_Mode));
1063  0009 1e06          	ldw	x,(OFST+6,sp)
1064  000b e601          	ld	a,(1,x)
1065  000d 273a          	jreq	L41
1066  000f a140          	cp	a,#64
1067  0011 2736          	jreq	L41
1068  0013 a120          	cp	a,#32
1069  0015 2732          	jreq	L41
1070  0017 a160          	cp	a,#96
1071  0019 272e          	jreq	L41
1072  001b a180          	cp	a,#128
1073  001d 272a          	jreq	L41
1074  001f a1c0          	cp	a,#192
1075  0021 2726          	jreq	L41
1076  0023 a1a0          	cp	a,#160
1077  0025 2722          	jreq	L41
1078  0027 a1e0          	cp	a,#224
1079  0029 271e          	jreq	L41
1080  002b a190          	cp	a,#144
1081  002d 271a          	jreq	L41
1082  002f a1d0          	cp	a,#208
1083  0031 2716          	jreq	L41
1084  0033 a1b0          	cp	a,#176
1085  0035 2712          	jreq	L41
1086  0037 a1f0          	cp	a,#240
1087  0039 270e          	jreq	L41
1088  003b ae0065        	ldw	x,#101
1089  003e 89            	pushw	x
1090  003f ae0000        	ldw	x,#L375
1091  0042 8d000000      	callf	f_assert_failed
1093  0046 85            	popw	x
1094  0047 1e06          	ldw	x,(OFST+6,sp)
1095  0049               L41:
1096                     ; 102   assert_param(IS_GPIO_PIN_OK(GPIO_InitStruct->GPIO_Pin));
1098  0049 f6            	ld	a,(x)
1099  004a 260e          	jrne	L22
1100  004c ae0066        	ldw	x,#102
1101  004f 89            	pushw	x
1102  0050 ae0000        	ldw	x,#L375
1103  0053 8d000000      	callf	f_assert_failed
1105  0057 85            	popw	x
1106  0058 1e06          	ldw	x,(OFST+6,sp)
1107  005a               L22:
1108                     ; 108   if ((((u8)(GPIO_InitStruct->GPIO_Mode)) & (u8)0x80) != (u8)0x00) /* Output mode */
1110  005a e601          	ld	a,(1,x)
1111  005c 2a1c          	jrpl	L575
1112                     ; 110     if ((((u8)(GPIO_InitStruct->GPIO_Mode)) & (u8)0x10) != (u8)0x00) /* High level */
1114  005e a510          	bcp	a,#16
1115  0060 2709          	jreq	L775
1116                     ; 112       GPIOx->ODR |= GPIO_InitStruct->GPIO_Pin;
1118  0062 1e01          	ldw	x,(OFST+1,sp)
1119  0064 1606          	ldw	y,(OFST+6,sp)
1120  0066 f6            	ld	a,(x)
1121  0067 90fa          	or	a,(y)
1123  0069 2008          	jra	L106
1124  006b               L775:
1125                     ; 115       GPIOx->ODR &= (u8)(~(GPIO_InitStruct->GPIO_Pin));
1127  006b 1e01          	ldw	x,(OFST+1,sp)
1128  006d 1606          	ldw	y,(OFST+6,sp)
1129  006f 90f6          	ld	a,(y)
1130  0071 43            	cpl	a
1131  0072 f4            	and	a,(x)
1132  0073               L106:
1133  0073 f7            	ld	(x),a
1134                     ; 118     GPIOx->DDR |= GPIO_InitStruct->GPIO_Pin;
1136  0074 e602          	ld	a,(2,x)
1137  0076 90fa          	or	a,(y)
1139  0078 2009          	jra	L306
1140  007a               L575:
1141                     ; 122     GPIOx->DDR &= (u8)(~(GPIO_InitStruct->GPIO_Pin));
1143  007a 1e01          	ldw	x,(OFST+1,sp)
1144  007c 1606          	ldw	y,(OFST+6,sp)
1145  007e 90f6          	ld	a,(y)
1146  0080 43            	cpl	a
1147  0081 e402          	and	a,(2,x)
1148  0083               L306:
1149  0083 e702          	ld	(2,x),a
1150                     ; 129   if ((((u8)(GPIO_InitStruct->GPIO_Mode)) & (u8)0x40) != (u8)0x00) /* Pull-Up or Push-Pull */
1152  0085 1e06          	ldw	x,(OFST+6,sp)
1153  0087 e601          	ld	a,(1,x)
1154  0089 a540          	bcp	a,#64
1155  008b 2708          	jreq	L506
1156                     ; 131     GPIOx->CR1 |= GPIO_InitStruct->GPIO_Pin;
1158  008d 1e01          	ldw	x,(OFST+1,sp)
1159  008f e603          	ld	a,(3,x)
1160  0091 90fa          	or	a,(y)
1162  0093 2007          	jra	L706
1163  0095               L506:
1164                     ; 134     GPIOx->CR1 &= (u8)(~(GPIO_InitStruct->GPIO_Pin));
1166  0095 1e01          	ldw	x,(OFST+1,sp)
1167  0097 90f6          	ld	a,(y)
1168  0099 43            	cpl	a
1169  009a e403          	and	a,(3,x)
1170  009c               L706:
1171  009c e703          	ld	(3,x),a
1172                     ; 141   if ((((u8)(GPIO_InitStruct->GPIO_Mode)) & (u8)0x20) != (u8)0x00) /* Interrupt or Slow slope */
1174  009e 1e06          	ldw	x,(OFST+6,sp)
1175  00a0 e601          	ld	a,(1,x)
1176  00a2 a520          	bcp	a,#32
1177  00a4 2708          	jreq	L116
1178                     ; 143     GPIOx->CR2 |= GPIO_InitStruct->GPIO_Pin;
1180  00a6 1e01          	ldw	x,(OFST+1,sp)
1181  00a8 e604          	ld	a,(4,x)
1182  00aa 90fa          	or	a,(y)
1184  00ac 2007          	jra	L316
1185  00ae               L116:
1186                     ; 146     GPIOx->CR2 &= (u8)(~(GPIO_InitStruct->GPIO_Pin));
1188  00ae 1e01          	ldw	x,(OFST+1,sp)
1189  00b0 90f6          	ld	a,(y)
1190  00b2 43            	cpl	a
1191  00b3 e404          	and	a,(4,x)
1192  00b5               L316:
1193  00b5 e704          	ld	(4,x),a
1194                     ; 149 }
1197  00b7 85            	popw	x
1198  00b8 87            	retf	
1234                     ; 166 void GPIO_StructInit(GPIO_Init_TypeDef* GPIO_InitStruct)
1234                     ; 167 {
1235                     	switch	.text
1236  00b9               f_GPIO_StructInit:
1240                     ; 169   GPIO_InitStruct->GPIO_Pin = GPIO_Pin_All;
1242  00b9 a6ff          	ld	a,#255
1243  00bb f7            	ld	(x),a
1244                     ; 170   GPIO_InitStruct->GPIO_Mode = GPIO_MODE_IN_FL_NO_IT;
1246  00bc 6f01          	clr	(1,x)
1247                     ; 171 }
1250  00be 87            	retf	
1293                     ; 188 void GPIO_Write(GPIO_TypeDef* GPIOx, u8 PortVal)
1293                     ; 189 {
1294                     	switch	.text
1295  00bf               f_GPIO_Write:
1297  00bf 89            	pushw	x
1298       00000000      OFST:	set	0
1301                     ; 190   GPIOx->ODR = PortVal;
1303  00c0 7b06          	ld	a,(OFST+6,sp)
1304  00c2 1e01          	ldw	x,(OFST+1,sp)
1305  00c4 f7            	ld	(x),a
1306                     ; 191 }
1309  00c5 85            	popw	x
1310  00c6 87            	retf	
1353                     ; 208 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, u8 PortPins)
1353                     ; 209 {
1354                     	switch	.text
1355  00c7               f_GPIO_WriteHigh:
1357  00c7 89            	pushw	x
1358       00000000      OFST:	set	0
1361                     ; 210   GPIOx->ODR |= PortPins;
1363  00c8 f6            	ld	a,(x)
1364  00c9 1a06          	or	a,(OFST+6,sp)
1365  00cb f7            	ld	(x),a
1366                     ; 211 }
1369  00cc 85            	popw	x
1370  00cd 87            	retf	
1413                     ; 228 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, u8 PortPins)
1413                     ; 229 {
1414                     	switch	.text
1415  00ce               f_GPIO_WriteLow:
1417  00ce 89            	pushw	x
1418       00000000      OFST:	set	0
1421                     ; 230   GPIOx->ODR &= (u8)(~PortPins);
1423  00cf 7b06          	ld	a,(OFST+6,sp)
1424  00d1 43            	cpl	a
1425  00d2 f4            	and	a,(x)
1426  00d3 f7            	ld	(x),a
1427                     ; 231 }
1430  00d4 85            	popw	x
1431  00d5 87            	retf	
1474                     ; 248 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, u8 PortPins)
1474                     ; 249 {
1475                     	switch	.text
1476  00d6               f_GPIO_WriteReverse:
1478  00d6 89            	pushw	x
1479       00000000      OFST:	set	0
1482                     ; 250   GPIOx->ODR ^= PortPins;
1484  00d7 f6            	ld	a,(x)
1485  00d8 1806          	xor	a,(OFST+6,sp)
1486  00da f7            	ld	(x),a
1487                     ; 251 }
1490  00db 85            	popw	x
1491  00dc 87            	retf	
1528                     ; 267 u8 GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
1528                     ; 268 {
1529                     	switch	.text
1530  00dd               f_GPIO_ReadOutputData:
1534                     ; 269   return ((u8)GPIOx->ODR);
1536  00dd f6            	ld	a,(x)
1539  00de 87            	retf	
1575                     ; 286 u8 GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
1575                     ; 287 {
1576                     	switch	.text
1577  00df               f_GPIO_ReadInputData:
1581                     ; 288   return ((u8)GPIOx->IDR);
1583  00df e601          	ld	a,(1,x)
1586  00e1 87            	retf	
1598                     	xdef	f_GPIO_ReadOutputData
1599                     	xdef	f_GPIO_ReadInputData
1600                     	xdef	f_GPIO_WriteReverse
1601                     	xdef	f_GPIO_WriteLow
1602                     	xdef	f_GPIO_WriteHigh
1603                     	xdef	f_GPIO_Write
1604                     	xdef	f_GPIO_StructInit
1605                     	xdef	f_GPIO_Init
1606                     	xdef	f_GPIO_DeInit
1607                     	xref	f_assert_failed
1608                     .const:	section	.text
1609  0000               L375:
1610  0000 736f75636573  	dc.b	"souces\src\stm8_gp"
1611  0012 696f2e6300    	dc.b	"io.c",0
1631                     	end
