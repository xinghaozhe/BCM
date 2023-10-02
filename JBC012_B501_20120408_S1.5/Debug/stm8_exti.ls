   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 803                     ; 63 void EXTI_DeInit(void)
 803                     ; 64 {
 804                     	switch	.text
 805  0000               f_EXTI_DeInit:
 809                     ; 65   EXTI->CR1 = EXTI_CR1_RESET_VALUE;
 811  0000 725f50a0      	clr	20640
 812                     ; 66   EXTI->CR2 = EXTI_CR2_RESET_VALUE;
 814  0004 725f50a1      	clr	20641
 815                     ; 67 }
 818  0008 87            	retf	
 939                     ; 86 void EXTI_SetExtIntSensitivity(EXTI_PortNum_TypeDef PortNum, EXTI_Sensitivity_TypeDef SensitivityValue)
 939                     ; 87 {
 940                     	switch	.text
 941  0009               f_EXTI_SetExtIntSensitivity:
 943  0009 89            	pushw	x
 944       00000000      OFST:	set	0
 947                     ; 90   assert_param(IS_EXTI_PORTNUM_OK(PortNum));
 949  000a 9e            	ld	a,xh
 950  000b 4d            	tnz	a
 951  000c 271f          	jreq	L41
 952  000e 9e            	ld	a,xh
 953  000f 4a            	dec	a
 954  0010 271b          	jreq	L41
 955  0012 9e            	ld	a,xh
 956  0013 a102          	cp	a,#2
 957  0015 2716          	jreq	L41
 958  0017 9e            	ld	a,xh
 959  0018 a103          	cp	a,#3
 960  001a 2711          	jreq	L41
 961  001c 9e            	ld	a,xh
 962  001d a104          	cp	a,#4
 963  001f 270c          	jreq	L41
 964  0021 ae005a        	ldw	x,#90
 965  0024 89            	pushw	x
 966  0025 ae0000        	ldw	x,#L145
 967  0028 8d000000      	callf	f_assert_failed
 969  002c 85            	popw	x
 970  002d               L41:
 971                     ; 91   assert_param(IS_EXTI_SENSITIVITY_VALUE_OK(SensitivityValue));
 973  002d 7b02          	ld	a,(OFST+2,sp)
 974  002f 2718          	jreq	L42
 975  0031 a101          	cp	a,#1
 976  0033 2714          	jreq	L42
 977  0035 a102          	cp	a,#2
 978  0037 2710          	jreq	L42
 979  0039 a103          	cp	a,#3
 980  003b 270c          	jreq	L42
 981  003d ae005b        	ldw	x,#91
 982  0040 89            	pushw	x
 983  0041 ae0000        	ldw	x,#L145
 984  0044 8d000000      	callf	f_assert_failed
 986  0048 85            	popw	x
 987  0049               L42:
 988                     ; 94   switch (PortNum)
 990  0049 7b01          	ld	a,(OFST+1,sp)
 992                     ; 116     default:
 992                     ; 117     break;
 993  004b 270e          	jreq	L154
 994  004d 4a            	dec	a
 995  004e 271a          	jreq	L354
 996  0050 4a            	dec	a
 997  0051 2725          	jreq	L554
 998  0053 4a            	dec	a
 999  0054 2731          	jreq	L754
1000  0056 4a            	dec	a
1001  0057 2745          	jreq	L164
1002  0059 2053          	jra	L545
1003  005b               L154:
1004                     ; 96     case EXTI_GPIOA:
1004                     ; 97       EXTI->CR1 &= (u8)(~EXTI_CR1_PAIS);
1006  005b c650a0        	ld	a,20640
1007  005e a4fc          	and	a,#252
1008  0060 c750a0        	ld	20640,a
1009                     ; 98       EXTI->CR1 |= (u8)(SensitivityValue);
1011  0063 c650a0        	ld	a,20640
1012  0066 1a02          	or	a,(OFST+2,sp)
1013                     ; 99     break;
1015  0068 202f          	jpf	LC001
1016  006a               L354:
1017                     ; 100     case EXTI_GPIOB:
1017                     ; 101       EXTI->CR1 &= (u8)(~EXTI_CR1_PBIS);
1019  006a c650a0        	ld	a,20640
1020  006d a4f3          	and	a,#243
1021  006f c750a0        	ld	20640,a
1022                     ; 102       EXTI->CR1 |= (u8)((u8)(SensitivityValue) << 2);
1024  0072 7b02          	ld	a,(OFST+2,sp)
1025  0074 48            	sll	a
1026  0075 48            	sll	a
1027                     ; 103     break;
1029  0076 201e          	jpf	LC002
1030  0078               L554:
1031                     ; 104     case EXTI_GPIOC:
1031                     ; 105       EXTI->CR1 &= (u8)(~EXTI_CR1_PCIS);
1033  0078 c650a0        	ld	a,20640
1034  007b a4cf          	and	a,#207
1035  007d c750a0        	ld	20640,a
1036                     ; 106       EXTI->CR1 |= (u8)((u8)(SensitivityValue) << 4);
1038  0080 7b02          	ld	a,(OFST+2,sp)
1039  0082 97            	ld	xl,a
1040  0083 a610          	ld	a,#16
1041                     ; 107     break;
1043  0085 200d          	jpf	LC003
1044  0087               L754:
1045                     ; 108     case EXTI_GPIOD:
1045                     ; 109       EXTI->CR1 &= (u8)(~EXTI_CR1_PDIS);
1047  0087 c650a0        	ld	a,20640
1048  008a a43f          	and	a,#63
1049  008c c750a0        	ld	20640,a
1050                     ; 110       EXTI->CR1 |= (u8)((u8)(SensitivityValue) << 6);
1052  008f 7b02          	ld	a,(OFST+2,sp)
1053  0091 97            	ld	xl,a
1054  0092 a640          	ld	a,#64
1055  0094               LC003:
1056  0094 42            	mul	x,a
1057  0095 9f            	ld	a,xl
1058  0096               LC002:
1059  0096 ca50a0        	or	a,20640
1060  0099               LC001:
1061  0099 c750a0        	ld	20640,a
1062                     ; 111     break;
1064  009c 2010          	jra	L545
1065  009e               L164:
1066                     ; 112     case EXTI_GPIOE:
1066                     ; 113       EXTI->CR2 &= (u8)(~EXTI_CR2_PEIS);
1068  009e c650a1        	ld	a,20641
1069  00a1 a4fc          	and	a,#252
1070  00a3 c750a1        	ld	20641,a
1071                     ; 114       EXTI->CR2 |= (u8)(SensitivityValue);
1073  00a6 c650a1        	ld	a,20641
1074  00a9 1a02          	or	a,(OFST+2,sp)
1075  00ab c750a1        	ld	20641,a
1076                     ; 115     break;
1078                     ; 116     default:
1078                     ; 117     break;
1080  00ae               L545:
1081                     ; 119 }
1084  00ae 85            	popw	x
1085  00af 87            	retf	
1141                     ; 134 void EXTI_SetTLISensitivity(EXTI_TLISensitivity_TypeDef SensitivityValue)
1141                     ; 135 {
1142                     	switch	.text
1143  00b0               f_EXTI_SetTLISensitivity:
1145  00b0 88            	push	a
1146       00000000      OFST:	set	0
1149                     ; 138   assert_param(IS_EXTI_TLISENSITIVITY_VALUE_OK(SensitivityValue));
1151  00b1 4d            	tnz	a
1152  00b2 2710          	jreq	L63
1153  00b4 a104          	cp	a,#4
1154  00b6 270c          	jreq	L63
1155  00b8 ae008a        	ldw	x,#138
1156  00bb 89            	pushw	x
1157  00bc ae0000        	ldw	x,#L145
1158  00bf 8d000000      	callf	f_assert_failed
1160  00c3 85            	popw	x
1161  00c4               L63:
1162                     ; 141   EXTI->CR2 &= (u8)(~EXTI_CR2_TLIS);
1164  00c4 721550a1      	bres	20641,#2
1165                     ; 142   EXTI->CR2 |= (u8)(SensitivityValue);
1167  00c8 c650a1        	ld	a,20641
1168  00cb 1a01          	or	a,(OFST+1,sp)
1169  00cd c750a1        	ld	20641,a
1170                     ; 144 }
1173  00d0 84            	pop	a
1174  00d1 87            	retf	
1218                     ; 161 EXTI_Sensitivity_TypeDef EXTI_GetExtIntSensitivity(EXTI_PortNum_TypeDef PortNum)
1218                     ; 162 {
1219                     	switch	.text
1220  00d2               f_EXTI_GetExtIntSensitivity:
1222  00d2 88            	push	a
1223  00d3 88            	push	a
1224       00000001      OFST:	set	1
1227                     ; 164   u8 value = 0;
1229  00d4 0f01          	clr	(OFST+0,sp)
1230                     ; 167   assert_param(IS_EXTI_PORTNUM_OK(PortNum));
1232  00d6 4d            	tnz	a
1233  00d7 271c          	jreq	L05
1234  00d9 a101          	cp	a,#1
1235  00db 2718          	jreq	L05
1236  00dd a102          	cp	a,#2
1237  00df 2714          	jreq	L05
1238  00e1 a103          	cp	a,#3
1239  00e3 2710          	jreq	L05
1240  00e5 a104          	cp	a,#4
1241  00e7 270c          	jreq	L05
1242  00e9 ae00a7        	ldw	x,#167
1243  00ec 89            	pushw	x
1244  00ed ae0000        	ldw	x,#L145
1245  00f0 8d000000      	callf	f_assert_failed
1247  00f4 85            	popw	x
1248  00f5               L05:
1249                     ; 169   switch (PortNum)
1251  00f5 7b02          	ld	a,(OFST+1,sp)
1253                     ; 186     default:
1253                     ; 187     break;
1254  00f7 2710          	jreq	L575
1255  00f9 4a            	dec	a
1256  00fa 2712          	jreq	L775
1257  00fc 4a            	dec	a
1258  00fd 2718          	jreq	L106
1259  00ff 4a            	dec	a
1260  0100 271b          	jreq	L306
1261  0102 4a            	dec	a
1262  0103 2722          	jreq	L506
1263  0105 7b01          	ld	a,(OFST+0,sp)
1264  0107 2023          	jra	LC004
1265  0109               L575:
1266                     ; 171     case EXTI_GPIOA:
1266                     ; 172       value = (u8)(EXTI->CR1 & EXTI_CR1_PAIS);
1268  0109 c650a0        	ld	a,20640
1269                     ; 173     break;
1271  010c 201c          	jpf	LC005
1272  010e               L775:
1273                     ; 174     case EXTI_GPIOB:
1273                     ; 175       value = (u8)((EXTI->CR1 & EXTI_CR1_PBIS) >> 2);
1275  010e c650a0        	ld	a,20640
1276  0111 a40c          	and	a,#12
1277  0113 44            	srl	a
1278  0114 44            	srl	a
1279                     ; 176     break;
1281  0115 2015          	jpf	LC004
1282  0117               L106:
1283                     ; 177     case EXTI_GPIOC:
1283                     ; 178       value = (u8)((EXTI->CR1 & EXTI_CR1_PCIS) >> 4);
1285  0117 c650a0        	ld	a,20640
1286  011a 4e            	swap	a
1287                     ; 179     break;
1289  011b 200d          	jpf	LC005
1290  011d               L306:
1291                     ; 180     case EXTI_GPIOD:
1291                     ; 181       value = (u8)((EXTI->CR1 & EXTI_CR1_PDIS) >> 6);
1293  011d c650a0        	ld	a,20640
1294  0120 4e            	swap	a
1295  0121 a40c          	and	a,#12
1296  0123 44            	srl	a
1297  0124 44            	srl	a
1298                     ; 182     break;
1300  0125 2003          	jpf	LC005
1301  0127               L506:
1302                     ; 183     case EXTI_GPIOE:
1302                     ; 184       value = (u8)(EXTI->CR2 & EXTI_CR2_PEIS);
1304  0127 c650a1        	ld	a,20641
1305  012a               LC005:
1306  012a a403          	and	a,#3
1307  012c               LC004:
1308                     ; 185     break;
1310                     ; 186     default:
1310                     ; 187     break;
1312                     ; 190   return((EXTI_Sensitivity_TypeDef)value);
1316  012c 85            	popw	x
1317  012d 87            	retf	
1350                     ; 210 EXTI_TLISensitivity_TypeDef EXTI_GetTLISensitivity(void)
1350                     ; 211 {
1351                     	switch	.text
1352  012e               f_EXTI_GetTLISensitivity:
1354  012e 88            	push	a
1355       00000001      OFST:	set	1
1358                     ; 216   value = (u8)(EXTI->CR2 & EXTI_CR2_TLIS);
1360  012f c650a1        	ld	a,20641
1361  0132 a404          	and	a,#4
1362                     ; 218   return((EXTI_TLISensitivity_TypeDef)value);
1366  0134 5b01          	addw	sp,#1
1367  0136 87            	retf	
1379                     	xdef	f_EXTI_GetTLISensitivity
1380                     	xdef	f_EXTI_GetExtIntSensitivity
1381                     	xdef	f_EXTI_SetTLISensitivity
1382                     	xdef	f_EXTI_SetExtIntSensitivity
1383                     	xdef	f_EXTI_DeInit
1384                     	xref	f_assert_failed
1385                     .const:	section	.text
1386  0000               L145:
1387  0000 736f75636573  	dc.b	"souces\src\stm8_ex"
1388  0012 74692e6300    	dc.b	"ti.c",0
1408                     	end
