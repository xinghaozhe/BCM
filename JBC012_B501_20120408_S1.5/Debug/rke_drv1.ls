   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 776                     .const:	section	.text
 777  0000               _f_SKey_B:
 778  0000 a5d5          	dc.w	-23083
 779  0002 0921          	dc.w	2337
 780  0004 b973          	dc.w	-18061
 781  0006 5546          	dc.w	21830
 782  0008 ecbf          	dc.w	-4929
 783  000a 4e1d          	dc.w	19997
 784  000c 69da          	dc.w	27098
 785  000e a2b1          	dc.w	-23887
 786  0010 5da2          	dc.w	23970
 787  0012 6583          	dc.w	25987
 788  0014 fb6b          	dc.w	-1173
 789  0016 c545          	dc.w	-15035
 790  0018 4592          	dc.w	17810
 791                     	switch	.data
 792  0000               _DriverLOCK:
 793  0000 00            	dc.b	0
 794  0001               _RKESETBUZZ:
 795  0001 00            	dc.b	0
 796  0002               _RKEERRORSTATE:
 797  0002 00            	dc.b	0
 808  0003               _PW:
 809  0003 b7e1          	dc.w	-18463
 810  0005               _QW:
 811  0005 9e37          	dc.w	-25033
 852                     ; 232 void INITrkenumber(void)
 852                     ; 233 {
 853                     	switch	.text
 854  0000               f_INITrkenumber:
 856  0000 88            	push	a
 857       00000001      OFST:	set	1
 860                     ; 238     RX_SerialNum = 0x00000000;
 862  0001 5f            	clrw	x
 863  0002 cf003c        	ldw	_RX_SerialNum+2,x
 864  0005 cf003a        	ldw	_RX_SerialNum,x
 865                     ; 239     for(numberxx= 0; numberxx< 4; numberxx++ )
 867  0008 4f            	clr	a
 868  0009 6b01          	ld	(OFST+0,sp),a
 869  000b               L554:
 870                     ; 241         SAVE_SERIAL_NUMBER(numberxx);
 872  000b 8df300f3      	callf	f_SAVE_SERIAL_NUMBER
 874                     ; 242 	 WWDG_Refresh(0x7f);
 876  000f a67f          	ld	a,#127
 877  0011 8d000000      	callf	f_WWDG_Refresh
 879                     ; 239     for(numberxx= 0; numberxx< 4; numberxx++ )
 881  0015 0c01          	inc	(OFST+0,sp)
 884  0017 7b01          	ld	a,(OFST+0,sp)
 885  0019 a104          	cp	a,#4
 886  001b 25ee          	jrult	L554
 887                     ; 246 }
 890  001d 84            	pop	a
 891  001e 87            	retf	
 947                     ; 261 void SAVE_SYNC_CODE(uchar keyindex)
 947                     ; 262 {
 948                     	switch	.text
 949  001f               f_SAVE_SYNC_CODE:
 951  001f 88            	push	a
 952  0020 520a          	subw	sp,#10
 953       0000000a      OFST:	set	10
 956                     ; 266 	for( witecnt = 0; witecnt < EECNT ; witecnt++ )
 958  0022 0f05          	clr	(OFST-5,sp)
 959  0024               L505:
 960                     ; 268               temp = (u32)(&f_RKE_SysnCode)+keyindex*2;
 962  0024 7b0b          	ld	a,(OFST+1,sp)
 963  0026 5f            	clrw	x
 964  0027 97            	ld	xl,a
 965  0028 58            	sllw	x
 966  0029 8d000000      	callf	d_itolx
 968  002d 96            	ldw	x,sp
 969  002e 5c            	incw	x
 970  002f 8d000000      	callf	d_rtol
 972  0033 ae4020        	ldw	x,#_f_RKE_SysnCode
 973  0036 8d000000      	callf	d_uitolx
 975  003a 96            	ldw	x,sp
 976  003b 5c            	incw	x
 977  003c 8d000000      	callf	d_ladd
 979  0040 96            	ldw	x,sp
 980  0041 1c0006        	addw	x,#OFST-4
 981  0044 8d000000      	callf	d_rtol
 983                     ; 269               Clear_WDT();
 985  0048 8d000000      	callf	f_Clear_WDT
 987                     ; 270               res = (RX_Sync_Code >> 8);
 989  004c c6002c        	ld	a,_RX_Sync_Code
 990  004f 6b0a          	ld	(OFST+0,sp),a
 991                     ; 271               FLASH_ProgramByte(temp, res);
 993  0051 88            	push	a
 994  0052 1e09          	ldw	x,(OFST-1,sp)
 995  0054 89            	pushw	x
 996  0055 1e09          	ldw	x,(OFST-1,sp)
 997  0057 89            	pushw	x
 998  0058 8d000000      	callf	f_FLASH_ProgramByte
1000  005c 5b05          	addw	sp,#5
1001                     ; 272               Clear_WDT();
1003  005e 8d000000      	callf	f_Clear_WDT
1005                     ; 273               res = (RX_Sync_Code >> 8);
1007  0062 c6002c        	ld	a,_RX_Sync_Code
1008  0065 6b0a          	ld	(OFST+0,sp),a
1009                     ; 274               FLASH_ProgramByte(temp, res);
1011  0067 88            	push	a
1012  0068 1e09          	ldw	x,(OFST-1,sp)
1013  006a 89            	pushw	x
1014  006b 1e09          	ldw	x,(OFST-1,sp)
1015  006d 89            	pushw	x
1016  006e 8d000000      	callf	f_FLASH_ProgramByte
1018  0072 5b05          	addw	sp,#5
1019                     ; 275               temp++;
1021  0074 96            	ldw	x,sp
1022  0075 1c0006        	addw	x,#OFST-4
1023  0078 a601          	ld	a,#1
1024  007a 8d000000      	callf	d_lgadc
1026                     ; 276               Clear_WDT();
1028  007e 8d000000      	callf	f_Clear_WDT
1030                     ; 277               res = (u8)(RX_Sync_Code);
1032  0082 c6002d        	ld	a,_RX_Sync_Code+1
1033  0085 6b0a          	ld	(OFST+0,sp),a
1034                     ; 278               FLASH_ProgramByte(temp, res);	
1036  0087 88            	push	a
1037  0088 1e09          	ldw	x,(OFST-1,sp)
1038  008a 89            	pushw	x
1039  008b 1e09          	ldw	x,(OFST-1,sp)
1040  008d 89            	pushw	x
1041  008e 8d000000      	callf	f_FLASH_ProgramByte
1043  0092 5b05          	addw	sp,#5
1044                     ; 279               Clear_WDT();
1046  0094 8d000000      	callf	f_Clear_WDT
1048                     ; 280               if(RX_Sync_Code == f_RKE_SysnCode[keyindex])
1050  0098 7b0b          	ld	a,(OFST+1,sp)
1051  009a 5f            	clrw	x
1052  009b 97            	ld	xl,a
1053  009c 58            	sllw	x
1054  009d 9093          	ldw	y,x
1055  009f 90de4020      	ldw	y,(_f_RKE_SysnCode,y)
1056  00a3 90c3002c      	cpw	y,_RX_Sync_Code
1057  00a7 270c          	jreq	L115
1058                     ; 282                   break;
1060                     ; 266 	for( witecnt = 0; witecnt < EECNT ; witecnt++ )
1062  00a9 0c05          	inc	(OFST-5,sp)
1065  00ab 7b05          	ld	a,(OFST-5,sp)
1066  00ad a10a          	cp	a,#10
1067  00af 2404ac240024  	jrult	L505
1068  00b5               L115:
1069                     ; 286 }
1072  00b5 5b0b          	addw	sp,#11
1073  00b7 87            	retf	
1129                     ; 299 void SAVEunlockdriverstate(uchar x)
1129                     ; 300 {
1130                     	switch	.text
1131  00b8               f_SAVEunlockdriverstate:
1133  00b8 88            	push	a
1134  00b9 5206          	subw	sp,#6
1135       00000006      OFST:	set	6
1138                     ; 304 	for( witecnt = 0; witecnt < EECNT ; witecnt++ )
1140  00bb 0f06          	clr	(OFST+0,sp)
1141  00bd               L735:
1142                     ; 306              temp = (u32)(&unlockdriverstate);
1144  00bd ae408a        	ldw	x,#_unlockdriverstate
1145  00c0 8d000000      	callf	d_uitolx
1147  00c4 96            	ldw	x,sp
1148  00c5 1c0002        	addw	x,#OFST-4
1149  00c8 8d000000      	callf	d_rtol
1151                     ; 307              Clear_WDT();
1153  00cc 8d000000      	callf	f_Clear_WDT
1155                     ; 308              res = x;
1157  00d0 7b07          	ld	a,(OFST+1,sp)
1158  00d2 6b01          	ld	(OFST-5,sp),a
1159                     ; 309              FLASH_ProgramByte(temp, res);
1161  00d4 88            	push	a
1162  00d5 1e05          	ldw	x,(OFST-1,sp)
1163  00d7 89            	pushw	x
1164  00d8 1e05          	ldw	x,(OFST-1,sp)
1165  00da 89            	pushw	x
1166  00db 8d000000      	callf	f_FLASH_ProgramByte
1168  00df 5b05          	addw	sp,#5
1169                     ; 311              if( x == unlockdriverstate )
1171  00e1 7b07          	ld	a,(OFST+1,sp)
1172  00e3 c1408a        	cp	a,_unlockdriverstate
1173  00e6 2708          	jreq	L345
1174                     ; 313                  break;
1176                     ; 304 	for( witecnt = 0; witecnt < EECNT ; witecnt++ )
1178  00e8 0c06          	inc	(OFST+0,sp)
1181  00ea 7b06          	ld	a,(OFST+0,sp)
1182  00ec a10a          	cp	a,#10
1183  00ee 25cd          	jrult	L735
1184  00f0               L345:
1185                     ; 316 }
1188  00f0 5b07          	addw	sp,#7
1189  00f2 87            	retf	
1245                     ; 328 void SAVE_SERIAL_NUMBER(uchar keyindex)
1245                     ; 329 {
1246                     	switch	.text
1247  00f3               f_SAVE_SERIAL_NUMBER:
1249  00f3 88            	push	a
1250  00f4 520a          	subw	sp,#10
1251       0000000a      OFST:	set	10
1254                     ; 334        for( i = 0 ; i < EECNT ; i++ )
1256  00f6 0f05          	clr	(OFST-5,sp)
1257  00f8               L175:
1258                     ; 336        	temp = (u32)(&f_RKE_SerialNum) + keyindex*4;
1260  00f8 7b0b          	ld	a,(OFST+1,sp)
1261  00fa 97            	ld	xl,a
1262  00fb a604          	ld	a,#4
1263  00fd 42            	mul	x,a
1264  00fe 8d000000      	callf	d_itolx
1266  0102 96            	ldw	x,sp
1267  0103 5c            	incw	x
1268  0104 8d000000      	callf	d_rtol
1270  0108 ae4000        	ldw	x,#_f_RKE_SerialNum
1271  010b 8d000000      	callf	d_uitolx
1273  010f 96            	ldw	x,sp
1274  0110 5c            	incw	x
1275  0111 8d000000      	callf	d_ladd
1277  0115 96            	ldw	x,sp
1278  0116 1c0007        	addw	x,#OFST-3
1279  0119 8d000000      	callf	d_rtol
1281                     ; 337        	Clear_WDT();
1283  011d 8d000000      	callf	f_Clear_WDT
1285                     ; 338        	res = (u8)(RX_SerialNum >> 24);
1287  0121 c6003a        	ld	a,_RX_SerialNum
1288  0124 6b06          	ld	(OFST-4,sp),a
1289                     ; 339        	FLASH_ProgramByte(temp, res);
1291  0126 88            	push	a
1292  0127 1e0a          	ldw	x,(OFST+0,sp)
1293  0129 89            	pushw	x
1294  012a 1e0a          	ldw	x,(OFST+0,sp)
1295  012c 89            	pushw	x
1296  012d 8d000000      	callf	f_FLASH_ProgramByte
1298  0131 5b05          	addw	sp,#5
1299                     ; 340        	temp++;
1301  0133 96            	ldw	x,sp
1302  0134 1c0007        	addw	x,#OFST-3
1303  0137 a601          	ld	a,#1
1304  0139 8d000000      	callf	d_lgadc
1306                     ; 341        	Clear_WDT();
1308  013d 8d000000      	callf	f_Clear_WDT
1310                     ; 342        	res = (u8)(RX_SerialNum >> 16);
1312  0141 c6003b        	ld	a,_RX_SerialNum+1
1313  0144 6b06          	ld	(OFST-4,sp),a
1314                     ; 343        	FLASH_ProgramByte(temp, res);
1316  0146 88            	push	a
1317  0147 1e0a          	ldw	x,(OFST+0,sp)
1318  0149 89            	pushw	x
1319  014a 1e0a          	ldw	x,(OFST+0,sp)
1320  014c 89            	pushw	x
1321  014d 8d000000      	callf	f_FLASH_ProgramByte
1323  0151 5b05          	addw	sp,#5
1324                     ; 344        	temp++;
1326  0153 96            	ldw	x,sp
1327  0154 1c0007        	addw	x,#OFST-3
1328  0157 a601          	ld	a,#1
1329  0159 8d000000      	callf	d_lgadc
1331                     ; 345        	Clear_WDT();
1333  015d 8d000000      	callf	f_Clear_WDT
1335                     ; 346        	res = (u8)(RX_SerialNum >> 8);
1337  0161 c6003c        	ld	a,_RX_SerialNum+2
1338  0164 6b06          	ld	(OFST-4,sp),a
1339                     ; 347        	FLASH_ProgramByte(temp, res);
1341  0166 88            	push	a
1342  0167 1e0a          	ldw	x,(OFST+0,sp)
1343  0169 89            	pushw	x
1344  016a 1e0a          	ldw	x,(OFST+0,sp)
1345  016c 89            	pushw	x
1346  016d 8d000000      	callf	f_FLASH_ProgramByte
1348  0171 5b05          	addw	sp,#5
1349                     ; 348        	temp++;
1351  0173 96            	ldw	x,sp
1352  0174 1c0007        	addw	x,#OFST-3
1353  0177 a601          	ld	a,#1
1354  0179 8d000000      	callf	d_lgadc
1356                     ; 349        	Clear_WDT();
1358  017d 8d000000      	callf	f_Clear_WDT
1360                     ; 350        	res = (u8)(RX_SerialNum);
1362  0181 c6003d        	ld	a,_RX_SerialNum+3
1363  0184 6b06          	ld	(OFST-4,sp),a
1364                     ; 351        	FLASH_ProgramByte(temp, res);
1366  0186 88            	push	a
1367  0187 1e0a          	ldw	x,(OFST+0,sp)
1368  0189 89            	pushw	x
1369  018a 1e0a          	ldw	x,(OFST+0,sp)
1370  018c 89            	pushw	x
1371  018d 8d000000      	callf	f_FLASH_ProgramByte
1373  0191 5b05          	addw	sp,#5
1374                     ; 352        	temp++;
1376  0193 96            	ldw	x,sp
1377  0194 1c0007        	addw	x,#OFST-3
1378  0197 a601          	ld	a,#1
1379  0199 8d000000      	callf	d_lgadc
1381                     ; 353        	Clear_WDT();
1383  019d 8d000000      	callf	f_Clear_WDT
1385                     ; 355        	if(RX_SerialNum == f_RKE_SerialNum[keyindex])
1387  01a1 7b0b          	ld	a,(OFST+1,sp)
1388  01a3 97            	ld	xl,a
1389  01a4 a604          	ld	a,#4
1390  01a6 42            	mul	x,a
1391  01a7 1c4000        	addw	x,#_f_RKE_SerialNum
1392  01aa 8d000000      	callf	d_ltor
1394  01ae ae003a        	ldw	x,#_RX_SerialNum
1395  01b1 8d000000      	callf	d_lcmp
1397  01b5 270c          	jreq	L575
1398                     ; 357                break;
1400                     ; 334        for( i = 0 ; i < EECNT ; i++ )
1402  01b7 0c05          	inc	(OFST-5,sp)
1405  01b9 7b05          	ld	a,(OFST-5,sp)
1406  01bb a10a          	cp	a,#10
1407  01bd 2404acf800f8  	jrult	L175
1408  01c3               L575:
1409                     ; 360 }
1412  01c3 5b0b          	addw	sp,#11
1413  01c5 87            	retf	
1445                     ; 469 uchar RKEnumberRead(void)
1445                     ; 470 {
1446                     	switch	.text
1447  01c6               f_RKEnumberRead:
1449  01c6 88            	push	a
1450       00000001      OFST:	set	1
1453                     ; 471     uchar reknumbercnt=0;
1455                     ; 472 	reknumbercnt = 0;
1457  01c7 0f01          	clr	(OFST+0,sp)
1458                     ; 474     if( f_RKE_SerialNum[0] != 0 ) { reknumbercnt++;   } 
1460  01c9 ae4000        	ldw	x,#_f_RKE_SerialNum
1461  01cc 8d000000      	callf	d_lzmp
1463  01d0 2702          	jreq	L516
1466  01d2 0c01          	inc	(OFST+0,sp)
1467  01d4               L516:
1468                     ; 475 	if( f_RKE_SerialNum[1] != 0 ) { reknumbercnt++;   } 
1470  01d4 ae4004        	ldw	x,#_f_RKE_SerialNum+4
1471  01d7 8d000000      	callf	d_lzmp
1473  01db 2702          	jreq	L716
1476  01dd 0c01          	inc	(OFST+0,sp)
1477  01df               L716:
1478                     ; 476 	if( f_RKE_SerialNum[2] != 0 ) { reknumbercnt++;   } 
1480  01df ae4008        	ldw	x,#_f_RKE_SerialNum+8
1481  01e2 8d000000      	callf	d_lzmp
1483  01e6 2702          	jreq	L126
1486  01e8 0c01          	inc	(OFST+0,sp)
1487  01ea               L126:
1488                     ; 477     if( f_RKE_SerialNum[3] != 0 ) { reknumbercnt++;   } 
1490  01ea ae400c        	ldw	x,#_f_RKE_SerialNum+12
1491  01ed 8d000000      	callf	d_lzmp
1493  01f1 2702          	jreq	L326
1496  01f3 0c01          	inc	(OFST+0,sp)
1497  01f5               L326:
1498                     ; 479     return reknumbercnt;
1500  01f5 7b01          	ld	a,(OFST+0,sp)
1503  01f7 5b01          	addw	sp,#1
1504  01f9 87            	retf	
1545                     ; 493 unsigned char DECODE_PROC(void)
1545                     ; 494 {
1546                     	switch	.text
1547  01fa               f_DECODE_PROC:
1549  01fa 5204          	subw	sp,#4
1550       00000004      OFST:	set	4
1553                     ; 503     Decrypt(f_SKey_B,Header);
1555  01fc ae0049        	ldw	x,#_Header
1556  01ff 89            	pushw	x
1557  0200 ae0000        	ldw	x,#_f_SKey_B
1558  0203 8d000000      	callf	f_Decrypt
1560  0207 85            	popw	x
1561                     ; 510 	RX_SerialNum =((ulong)(A_Code[1] & 0x0fff) << 16) + A_Code[0];
1563  0208 ce0045        	ldw	x,_A_Code
1564  020b 8d000000      	callf	d_uitolx
1566  020f 96            	ldw	x,sp
1567  0210 5c            	incw	x
1568  0211 8d000000      	callf	d_rtol
1570  0215 c60047        	ld	a,_A_Code+2
1571  0218 97            	ld	xl,a
1572  0219 c60048        	ld	a,_A_Code+3
1573  021c 41            	exg	a,xl
1574  021d a40f          	and	a,#15
1575  021f 41            	exg	a,xl
1576  0220 8d000000      	callf	d_uitol
1578  0224 a610          	ld	a,#16
1579  0226 8d000000      	callf	d_llsh
1581  022a 96            	ldw	x,sp
1582  022b 5c            	incw	x
1583  022c 8d000000      	callf	d_ladd
1585  0230 ae003a        	ldw	x,#_RX_SerialNum
1586  0233 8d000000      	callf	d_rtol
1588                     ; 512 	if      (f_RKE_SerialNum[0] == RX_SerialNum) {keyindex = 0; RKE_COMMAND_StandBy_state = 0x11;}
1590  0237 ae4000        	ldw	x,#_f_RKE_SerialNum
1591  023a 8d000000      	callf	d_ltor
1593  023e ae003a        	ldw	x,#_RX_SerialNum
1594  0241 8d000000      	callf	d_lcmp
1596  0245 2606          	jrne	L146
1599  0247 725f0020      	clr	_keyindex
1602  024b 2040          	jpf	LC001
1603  024d               L146:
1604                     ; 513 	else if (f_RKE_SerialNum[1] == RX_SerialNum) {keyindex = 1; RKE_COMMAND_StandBy_state = 0x11;}
1606  024d ae4004        	ldw	x,#_f_RKE_SerialNum+4
1607  0250 8d000000      	callf	d_ltor
1609  0254 ae003a        	ldw	x,#_RX_SerialNum
1610  0257 8d000000      	callf	d_lcmp
1612  025b 2606          	jrne	L546
1615  025d 35010020      	mov	_keyindex,#1
1618  0261 202a          	jpf	LC001
1619  0263               L546:
1620                     ; 514 	else if (f_RKE_SerialNum[2] == RX_SerialNum) {keyindex = 2; RKE_COMMAND_StandBy_state = 0x11;}
1622  0263 ae4008        	ldw	x,#_f_RKE_SerialNum+8
1623  0266 8d000000      	callf	d_ltor
1625  026a ae003a        	ldw	x,#_RX_SerialNum
1626  026d 8d000000      	callf	d_lcmp
1628  0271 2606          	jrne	L156
1631  0273 35020020      	mov	_keyindex,#2
1634  0277 2014          	jpf	LC001
1635  0279               L156:
1636                     ; 515 	else if (f_RKE_SerialNum[3] == RX_SerialNum) {keyindex = 3; RKE_COMMAND_StandBy_state = 0x11;}
1638  0279 ae400c        	ldw	x,#_f_RKE_SerialNum+12
1639  027c 8d000000      	callf	d_ltor
1641  0280 ae003a        	ldw	x,#_RX_SerialNum
1642  0283 8d000000      	callf	d_lcmp
1644  0287 260a          	jrne	L556
1647  0289 35030020      	mov	_keyindex,#3
1650  028d               LC001:
1654  028d 35110021      	mov	_RKE_COMMAND_StandBy_state,#17
1656  0291 2011          	jra	L346
1657  0293               L556:
1658                     ; 516 	else if (EnalbeLearnRkeTime20s == 0) //有改动
1660  0293 ce0000        	ldw	x,_EnalbeLearnRkeTime20s
1661  0296 2608          	jrne	L166
1662                     ; 518 	    RKE_COMMAND_StandBy_state = 0x55;
1664  0298 35550021      	mov	_RKE_COMMAND_StandBy_state,#85
1665                     ; 519 		return Fail;	// this remote key isn't learn!!!
1667  029c ac2a032a      	jpf	LC003
1668  02a0               L166:
1669                     ; 523         RKE_COMMAND_StandBy_state = 0x55;   
1671  02a0 35550021      	mov	_RKE_COMMAND_StandBy_state,#85
1672  02a4               L346:
1673                     ; 526 	    RkeStudy(); //进入学习状态
1675  02a4 8dc406c4      	callf	f_RkeStudy
1677                     ; 531 		RX_Sync_Code = B_Code[1];
1679  02a8 ce0043        	ldw	x,_B_Code+2
1680  02ab cf002c        	ldw	_RX_Sync_Code,x
1681                     ; 532 		itemp = RX_Sync_Code - f_RKE_SysnCode[keyindex];
1683  02ae c60020        	ld	a,_keyindex
1684  02b1 905f          	clrw	y
1685  02b3 9097          	ld	yl,a
1686  02b5 9058          	sllw	y
1687  02b7 90de4020      	ldw	y,(_f_RKE_SysnCode,y)
1688  02bb 90bf00        	ldw	c_x,y
1689  02be 72b00000      	subw	x,c_x
1690  02c2 cf0008        	ldw	_itemp,x
1691                     ; 535         B_Code_new = B_Code[0] & 0xf000;
1693  02c5 c60041        	ld	a,_B_Code
1694  02c8 a4f0          	and	a,#240
1695  02ca 97            	ld	xl,a
1696  02cb 4f            	clr	a
1697  02cc c7001f        	ld	_B_Code_new+1,a
1698  02cf 9f            	ld	a,xl
1699  02d0 c7001e        	ld	_B_Code_new,a
1700                     ; 540 		if (itemp == 0) 	
1702  02d3 ce0008        	ldw	x,_itemp
1703  02d6 260c          	jrne	L566
1704                     ; 543 			if(RKE_CODE_OK == 0x55)return CommandOk;	    // check sync_code invalid
1706  02d8 c6000a        	ld	a,_RKE_CODE_OK
1707  02db a155          	cp	a,#85
1708  02dd 264b          	jrne	LC003
1711  02df               LC002:
1713  02df a601          	ld	a,#1
1715  02e1               L001:
1717  02e1 5b04          	addw	sp,#4
1718  02e3 87            	retf	
1719                     ; 544 			else return Fail;
1721  02e4               L566:
1722                     ; 549 		else if(itemp > SYNC_CNT_WIN_DOUBLE)
1724  02e4 a31001        	cpw	x,#4097
1725                     ; 551                     return Fail;
1727  02e7 2441          	jruge	LC003
1728                     ; 554 		else if (itemp < SYNC_CNT_WIN_SINGLE)	
1730  02e9 a30080        	cpw	x,#128
1731  02ec 2411          	jruge	L107
1732                     ; 556 			SAVE_SYNC_CODE(keyindex);
1734  02ee c60020        	ld	a,_keyindex
1735  02f1 8d1f001f      	callf	f_SAVE_SYNC_CODE
1737                     ; 557 			RKE_CODE_OK = 0X55;
1739  02f5 3555000a      	mov	_RKE_CODE_OK,#85
1740                     ; 558 			RKEERRORSTATE = 0; //add two key 20100731
1742  02f9 725f0002      	clr	_RKEERRORSTATE
1743                     ; 560 			return CommandOk;  	// single time valid
1745  02fd 20e0          	jpf	LC002
1746  02ff               L107:
1747                     ; 563 		else if ((RX_Sync_Code - LAST_RX_sync_Code) < 20)		
1749  02ff ce002c        	ldw	x,_RX_Sync_Code
1750  0302 72b0002a      	subw	x,_LAST_RX_sync_Code
1751  0306 a30014        	cpw	x,#20
1752  0309 2411          	jruge	L507
1753                     ; 565 			SAVE_SYNC_CODE(keyindex);
1755  030b c60020        	ld	a,_keyindex
1756  030e 8d1f001f      	callf	f_SAVE_SYNC_CODE
1758                     ; 566 			RKE_CODE_OK = 0X55;
1760  0312 3555000a      	mov	_RKE_CODE_OK,#85
1761                     ; 567 			RKEERRORSTATE = 0;//add two key 20100731
1763  0316 725f0002      	clr	_RKEERRORSTATE
1764                     ; 569 			return Fail;	// double time valid
1766  031a 200e          	jpf	LC003
1767  031c               L507:
1768                     ; 571 		else if(itemp <= 4096)
1770  031c ce0008        	ldw	x,_itemp
1771  031f a31001        	cpw	x,#4097
1772  0322 2406          	jruge	LC003
1773                     ; 575 			LAST_RX_sync_Code = RX_Sync_Code;
1775  0324 ce002c        	ldw	x,_RX_Sync_Code
1776  0327 cf002a        	ldw	_LAST_RX_sync_Code,x
1777                     ; 577 			return Fail;	    // sync_code invalid
1779  032a               LC003:
1785  032a 4f            	clr	a
1787  032b 20b4          	jra	L001
1788                     ; 579 		else return Fail;
1791                     	switch	.bss
1792  0000               L137_rke_UnlockDriver_setcnt:
1793  0000 00            	ds.b	1
1794  0001               L727_rke_closewincnt:
1795  0001 00            	ds.b	1
1796  0002               L327_rke_UnlockTrunkcnt:
1797  0002 00            	ds.b	1
1798  0003               L527_rke_openwincnt:
1799  0003 00            	ds.b	1
1800  0004               L717_RkeLockCnt:
1801  0004 00            	ds.b	1
1802  0005               L517_FindCarTime:
1803  0005 0000          	ds.b	2
1912                     ; 594 void ScanRkeKeys(void)
1912                     ; 595 {
1913                     	switch	.text
1914  032d               f_ScanRkeKeys:
1916  032d 88            	push	a
1917       00000001      OFST:	set	1
1920                     ; 605      if(IGNstate == ON) RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;   // new0917
1922  032e c60000        	ld	a,_IGNstate
1923  0331 a155          	cp	a,#85
1924  0333 2604          	jrne	L367
1927  0335 725f0029      	clr	_RKE_AutoLockFlag
1928  0339               L367:
1929                     ; 607     if(RKE_outtime != 0)
1931  0339 c6001a        	ld	a,_RKE_outtime
1932  033c 2746          	jreq	L567
1933                     ; 609         RKE_outtime--;
1935  033e 725a001a      	dec	_RKE_outtime
1936                     ; 610 		if((RKE_outtime == 0)&&(rke_closewincnt > 10)&&(B_Code_new == LockKey))
1938  0342 2629          	jrne	L767
1940  0344 c60001        	ld	a,L727_rke_closewincnt
1941  0347 a10b          	cp	a,#11
1942  0349 2522          	jrult	L767
1944  034b ce001e        	ldw	x,_B_Code_new
1945  034e a32000        	cpw	x,#8192
1946  0351 261a          	jrne	L767
1947                     ; 612 			RKE_Resive_cnt  = 0;
1949  0353 725f000b      	clr	_RKE_Resive_cnt
1950                     ; 613 			rke_UnlockTrunkcnt = 0;
1952  0357 725f0002      	clr	L327_rke_UnlockTrunkcnt
1953                     ; 614 			RKE_CODE_OK = 0;
1955  035b 725f000a      	clr	_RKE_CODE_OK
1956                     ; 615 			rke_openwincnt=0;
1958  035f 725f0003      	clr	L527_rke_openwincnt
1959                     ; 616 			rke_closewincnt= 0;
1961  0363 725f0001      	clr	L727_rke_closewincnt
1962                     ; 617 			rke_UnlockDriver_setcnt=0;
1964  0367 725f0000      	clr	L137_rke_UnlockDriver_setcnt
1966  036b 2017          	jra	L567
1967  036d               L767:
1968                     ; 619 		else if(RKE_outtime == 0)
1970  036d c6001a        	ld	a,_RKE_outtime
1971  0370 2612          	jrne	L567
1972                     ; 621 		    RKE_CODE_OK = 0;
1974  0372 c7000a        	ld	_RKE_CODE_OK,a
1975                     ; 622 			rke_UnlockTrunkcnt = 0;
1977  0375 c70002        	ld	L327_rke_UnlockTrunkcnt,a
1978                     ; 623 			rke_openwincnt=0;
1980  0378 c70003        	ld	L527_rke_openwincnt,a
1981                     ; 624 			rke_closewincnt = 0;
1983  037b c70001        	ld	L727_rke_closewincnt,a
1984                     ; 625 			rke_UnlockDriver_setcnt= 0;
1986  037e c70000        	ld	L137_rke_UnlockDriver_setcnt,a
1987                     ; 626 			RKE_Resive_cnt = 0;
1989  0381 c7000b        	ld	_RKE_Resive_cnt,a
1990  0384               L567:
1991                     ; 630     if(RKE_DATA_OK == 0x55)
1993  0384 c6001b        	ld	a,_RKE_DATA_OK
1994  0387 a155          	cp	a,#85
1995  0389 2704acd705d7  	jrne	L577
1996                     ; 632      	 RKE_DATA_OK = 0x00;
1998  038f 725f001b      	clr	_RKE_DATA_OK
1999                     ; 633 	 	 temp = DECODE_PROC();
2001  0393 8dfa01fa      	callf	f_DECODE_PROC
2003  0397 6b01          	ld	(OFST+0,sp),a
2004                     ; 636     	if (temp == CommandOk)
2006  0399 4a            	dec	a
2007  039a 2704acc705c7  	jrne	L777
2008                     ; 638 				gNetWorkStatus.bussleep = 0;
2010  03a0 c70002        	ld	_gNetWorkStatus+2,a
2011                     ; 639 				gLocalWakeupFlag = 1;
2013  03a3 35010000      	mov	_gLocalWakeupFlag,#1
2014                     ; 640     	      RKEBatteryVoltage();           //电池电压检测
2016  03a7 8d370737      	callf	f_RKEBatteryVoltage
2018                     ; 650          if ((B_Code_new == LockKey)||(B_Code_new == RKEfindcar))       
2020  03ab ce001e        	ldw	x,_B_Code_new
2021  03ae a32000        	cpw	x,#8192
2022  03b1 2709          	jreq	L3001
2024  03b3 a38000        	cpw	x,#32768
2025  03b6 2704ac900490  	jrne	L1001
2026  03bc               L3001:
2027                     ; 653 	              if(rke_closewincnt < 20) rke_closewincnt++;		
2029  03bc c60001        	ld	a,L727_rke_closewincnt
2030  03bf a114          	cp	a,#20
2031  03c1 2407          	jruge	L5001
2034  03c3 725c0001      	inc	L727_rke_closewincnt
2035  03c7 c60001        	ld	a,L727_rke_closewincnt
2036  03ca               L5001:
2037                     ; 654 			if(rke_closewincnt == 1)
2039  03ca 4a            	dec	a
2040  03cb 26cf          	jrne	L777
2041                     ; 656 			        if(IGNstate == ON) return;
2043  03cd c60000        	ld	a,_IGNstate
2044  03d0 a155          	cp	a,#85
2045  03d2 2602          	jrne	L1101
2049  03d4 84            	pop	a
2050  03d5 87            	retf	
2051  03d6               L1101:
2052                     ; 657                              if(KeyInState == KeyIsInHole) return;
2054  03d6 c60000        	ld	a,_KeyInState
2055  03d9 4a            	dec	a
2056  03da 2602          	jrne	L3101
2060  03dc 84            	pop	a
2061  03dd 87            	retf	
2062  03de               L3101:
2063                     ; 659 				if ((DoorState ==0) && (KeyInState == KeyIsOutHole)&&(LockState == Locked)&&(B_Code_new == RKEfindcar))//add lockstate 20120308
2065  03de c60000        	ld	a,_DoorState
2066  03e1 2621          	jrne	L5101
2068  03e3 c60000        	ld	a,_KeyInState
2069  03e6 261c          	jrne	L5101
2071  03e8 c60000        	ld	a,_LockState
2072  03eb a155          	cp	a,#85
2073  03ed 2615          	jrne	L5101
2075  03ef a38000        	cpw	x,#32768
2076  03f2 2610          	jrne	L5101
2077                     ; 661 					if(FindCarFlag != TRUE){FindCarFlag = TRUE;RkeLockCnt=0;}
2079  03f4 c60022        	ld	a,_FindCarFlag
2080  03f7 4a            	dec	a
2081  03f8 2708          	jreq	L7101
2084  03fa 35010022      	mov	_FindCarFlag,#1
2087  03fe 725f0004      	clr	L717_RkeLockCnt
2088  0402               L7101:
2089                     ; 662 					return;
2092  0402 84            	pop	a
2093  0403 87            	retf	
2094  0404               L5101:
2095                     ; 665 				 DriverLOCK = 0;
2097  0404 725f0000      	clr	_DriverLOCK
2098                     ; 666 				 RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;
2100  0408 725f0029      	clr	_RKE_AutoLockFlag
2101                     ; 668 	    			if (RkeLockCnt != 0)
2103  040c c60004        	ld	a,L717_RkeLockCnt
2104  040f 2706          	jreq	L1201
2105                     ; 670 	    				RkeLockCnt++;				
2107  0411 725c0004      	inc	L717_RkeLockCnt
2109  0415 200a          	jra	L3201
2110  0417               L1201:
2111                     ; 674 	    				RkeLockCnt = 1;
2113  0417 35010004      	mov	L717_RkeLockCnt,#1
2114                     ; 675 	    				FindCarTime = 250;//set 8ms*250=2s
2116  041b ae00fa        	ldw	x,#250
2117  041e cf0005        	ldw	L517_FindCarTime,x
2118  0421               L3201:
2119                     ; 677 	                     RKELOCKstate = 0xaa;
2121  0421 35aa0000      	mov	_RKELOCKstate,#170
2122                     ; 679 			       TurnFlashCnt = 2;	//\__lock:turn lamps flash 2 time 
2124  0425 ae0002        	ldw	x,#2
2125  0428 cf0000        	ldw	_TurnFlashCnt,x
2126                     ; 680 	                     Alarmstatus_RKE = 1;    //置RKE闭锁标志
2128  042b 35010000      	mov	_Alarmstatus_RKE,#1
2129                     ; 681                             if(FindCarFlag = TRUE) //20120308
2131  042f 35010022      	mov	_FindCarFlag,#1
2132  0433 270e          	jreq	L5201
2133                     ; 683 				         FindCarFlag = FALSE;
2135  0435 725f0022      	clr	_FindCarFlag
2136                     ; 684 					  if(turnfindcarstate == 1)TurnFlashCnt = 3;
2138  0439 c60000        	ld	a,_turnfindcarstate
2139  043c 4a            	dec	a
2140  043d 2604          	jrne	L5201
2143  043f 5c            	incw	x
2144  0440 cf0000        	ldw	_TurnFlashCnt,x
2145  0443               L5201:
2146                     ; 687 	        		if (( IGNstate == OFF ) && (DoorState & AllDoorIsOpen))//AllDoorIsOpen  0x1b  取消后备箱状态//20120310
2148  0443 c60000        	ld	a,_IGNstate
2149  0446 2629          	jrne	L1301
2151  0448 c60000        	ld	a,_DoorState
2152  044b a51f          	bcp	a,#31
2153  044d 2722          	jreq	L1301
2154                     ; 690 						if(KeyInState == KeyIsOutHole)
2156  044f c60000        	ld	a,_KeyInState
2157  0452 261d          	jrne	L1301
2158                     ; 692 						      HornDoorunclosetime = 6;
2160  0454 ae0006        	ldw	x,#6
2161  0457 cf0000        	ldw	_HornDoorunclosetime,x
2162                     ; 693 						      BuzzerDrv(1,376,375,Buzzlockdoorunclose);
2164  045a 4b15          	push	#21
2165  045c ae0177        	ldw	x,#375
2166  045f 89            	pushw	x
2167  0460 5c            	incw	x
2168  0461 89            	pushw	x
2169  0462 4c            	inc	a
2170  0463 8d000000      	callf	f_BuzzerDrv
2172  0467 5b05          	addw	sp,#5
2173                     ; 694 						      TurnFlashCnt = 0;
2175  0469 5f            	clrw	x
2176  046a cf0000        	ldw	_TurnFlashCnt,x
2177                     ; 695 						      dooropenlock = 50;
2179  046d 35320000      	mov	_dooropenlock,#50
2180  0471               L1301:
2181                     ; 701 	                if(( IGNstate == ON )||(wLockProtectTimeCnt !=0)) //20100719
2183  0471 c60000        	ld	a,_IGNstate
2184  0474 a155          	cp	a,#85
2185  0476 2705          	jreq	L7301
2187  0478 ce0000        	ldw	x,_wLockProtectTimeCnt
2188  047b 2707          	jreq	L5301
2189  047d               L7301:
2190                     ; 703 	                      TurnFlashCnt = 0;
2192  047d 5f            	clrw	x
2193  047e cf0000        	ldw	_TurnFlashCnt,x
2194                     ; 704 			        BUZZLocktimecnt = 0;	  
2196  0481 cf0000        	ldw	_BUZZLocktimecnt,x
2197  0484               L5301:
2198                     ; 706 	                RKE_COMMAND = RKECMD_LOCK;
2200  0484 3501003e      	mov	_RKE_COMMAND,#1
2201                     ; 708 	                LockDrvCmd = LockCmd;
2203  0488 35200000      	mov	_LockDrvCmd,#32
2204  048c acc705c7      	jra	L777
2205  0490               L1001:
2206                     ; 713 		else if (B_Code_new == UnlockDriverDoorKey )// || (B_Code_new ==  UnlockOtherDoorKey))
2208  0490 a34000        	cpw	x,#16384
2209  0493 2704ac4b054b  	jrne	L3401
2210                     ; 715              		  if(rke_openwincnt < 20) rke_openwincnt++;
2212  0499 c60003        	ld	a,L527_rke_openwincnt
2213  049c a114          	cp	a,#20
2214  049e 2407          	jruge	L5401
2217  04a0 725c0003      	inc	L527_rke_openwincnt
2218  04a4 c60003        	ld	a,L527_rke_openwincnt
2219  04a7               L5401:
2220                     ; 716 			  if(rke_openwincnt == 1)
2222  04a7 4a            	dec	a
2223  04a8 26e2          	jrne	L777
2224                     ; 718 				if(IGNstate == ON) return;
2226  04aa c60000        	ld	a,_IGNstate
2227  04ad a155          	cp	a,#85
2228  04af 2602          	jrne	L1501
2232  04b1 84            	pop	a
2233  04b2 87            	retf	
2234  04b3               L1501:
2235                     ; 719 				if(KeyInState == KeyIsInHole) return;
2237  04b3 c60000        	ld	a,_KeyInState
2238  04b6 4a            	dec	a
2239  04b7 2602          	jrne	L3501
2243  04b9 84            	pop	a
2244  04ba 87            	retf	
2245  04bb               L3501:
2246                     ; 723 				RKE_COMMAND = RKECMD_UNLOCK;
2248  04bb 3502003e      	mov	_RKE_COMMAND,#2
2249                     ; 724 				RKELOCKstate  =0x55 ;
2251  04bf 35550000      	mov	_RKELOCKstate,#85
2252                     ; 725 				Alarmstatus_RKE = 2;    //置RKE开锁标志
2254  04c3 35020000      	mov	_Alarmstatus_RKE,#2
2255                     ; 726 				HornDoorunclosetime = 0;    //new add
2257  04c7 5f            	clrw	x
2258  04c8 cf0000        	ldw	_HornDoorunclosetime,x
2259                     ; 728 				ClearBuzzdrv(Buzzlockdoorunclose);
2261  04cb a615          	ld	a,#21
2262  04cd 8d000000      	callf	f_ClearBuzzdrv
2264                     ; 729 				RkeLockCnt = 0;    //20100317
2266  04d1 725f0004      	clr	L717_RkeLockCnt
2267                     ; 730 				FindCarTime =0;
2269  04d5 5f            	clrw	x
2270  04d6 cf0005        	ldw	L517_FindCarTime,x
2271                     ; 732 				LockDrvCmd |= UnlockDriverDoorCmd;
2273  04d9 721e0000      	bset	_LockDrvCmd,#7
2274                     ; 744 				if(RKEERRORSTATE != 0x55)//add two key 20100731
2276  04dd c60002        	ld	a,_RKEERRORSTATE
2277  04e0 a155          	cp	a,#85
2278  04e2 2761          	jreq	L5501
2279                     ; 746 					if (CarState == CarIsAttack)	
2281  04e4 c60000        	ld	a,_CarState
2282  04e7 a155          	cp	a,#85
2283  04e9 262e          	jrne	L7501
2284                     ; 749 						CarState = CarIsOkay;
2286  04eb 725f0000      	clr	_CarState
2287                     ; 750 						TurnFlashCnt = 4;	//unlock:if car is attacked,flash 4 times
2289  04ef ae0004        	ldw	x,#4
2290  04f2 cf0000        	ldw	_TurnFlashCnt,x
2291                     ; 752 						BuzzerDrv(4,250,125,BuzzlockoutArim); 
2293  04f5 4b14          	push	#20
2294  04f7 ae007d        	ldw	x,#125
2295  04fa 89            	pushw	x
2296  04fb 58            	sllw	x
2297  04fc 89            	pushw	x
2298  04fd a604          	ld	a,#4
2299  04ff 8d000000      	callf	f_BuzzerDrv
2301  0503 5b05          	addw	sp,#5
2302                     ; 753 						Warningstate = 0 ;
2304  0505 725f0000      	clr	_Warningstate
2305                     ; 754 						TrunkWarmTime = 0 ;
2307  0509 5f            	clrw	x
2308  050a cf0000        	ldw	_TrunkWarmTime,x
2309                     ; 755 						Alarmstatus_RKE = 4; 
2311  050d 35040000      	mov	_Alarmstatus_RKE,#4
2312                     ; 756 						BCMtoGEM_AlarmStatus = Disarmed; //20090917
2314  0511 725f0000      	clr	_BCMtoGEM_AlarmStatus
2316  0515 acc705c7      	jra	L777
2317  0519               L7501:
2318                     ; 761 					 	TurnFlashCnt = 1;	//\__unlock:turn lamps flash 1 times
2320  0519 5c            	incw	x
2321  051a cf0000        	ldw	_TurnFlashCnt,x
2322                     ; 762 						if(FindCarFlag = TRUE)  //20120308
2324  051d 35010022      	mov	_FindCarFlag,#1
2325  0521 270e          	jreq	L3601
2326                     ; 764 							FindCarFlag = FALSE;
2328  0523 725f0022      	clr	_FindCarFlag
2329                     ; 765 							if(turnfindcarstate == 1)TurnFlashCnt = 2;
2331  0527 c60000        	ld	a,_turnfindcarstate
2332  052a 4a            	dec	a
2333  052b 2604          	jrne	L3601
2336  052d 5c            	incw	x
2337  052e cf0000        	ldw	_TurnFlashCnt,x
2338  0531               L3601:
2339                     ; 767 						if(( IGNstate == ON )||(wLockProtectTimeCnt !=0))  //20100719
2341  0531 c60000        	ld	a,_IGNstate
2342  0534 a155          	cp	a,#85
2343  0536 2705          	jreq	L1701
2345  0538 ce0000        	ldw	x,_wLockProtectTimeCnt
2346  053b 27d8          	jreq	L777
2347  053d               L1701:
2348                     ; 769 							TurnFlashCnt = 0;
2350  053d 5f            	clrw	x
2351  053e cf0000        	ldw	_TurnFlashCnt,x
2352  0541 acc705c7      	jra	L777
2353  0545               L5501:
2354                     ; 775 					LockDrvCmd = 0;
2356  0545 725f0000      	clr	_LockDrvCmd
2357  0549 207c          	jra	L777
2358  054b               L3401:
2359                     ; 783 		else if (B_Code_new ==UnlockTrunkKey)
2361  054b a31000        	cpw	x,#4096
2362  054e 2627          	jrne	L7701
2363                     ; 786 				if(rke_UnlockTrunkcnt < 5)rke_UnlockTrunkcnt++;
2365  0550 c60002        	ld	a,L327_rke_UnlockTrunkcnt
2366  0553 a105          	cp	a,#5
2367  0555 2407          	jruge	L1011
2370  0557 725c0002      	inc	L327_rke_UnlockTrunkcnt
2371  055b c60002        	ld	a,L327_rke_UnlockTrunkcnt
2372  055e               L1011:
2373                     ; 787 				if(rke_UnlockTrunkcnt == 3)
2375  055e a103          	cp	a,#3
2376  0560 2665          	jrne	L777
2377                     ; 789 				     if(IGNstate == OFF) return;
2379  0562 c60000        	ld	a,_IGNstate
2380  0565 2602          	jrne	L5011
2384  0567 84            	pop	a
2385  0568 87            	retf	
2386  0569               L5011:
2387                     ; 790 				    rke_UnlockTrunkcnt++;
2389  0569 725c0002      	inc	L327_rke_UnlockTrunkcnt
2390                     ; 792 					LockDrvCmd = UnlockTrunkCmd;
2392  056d 35400000      	mov	_LockDrvCmd,#64
2393                     ; 793 					TRUNK_UNLOCK_RKEstate = 1;
2395  0571 35010000      	mov	_TRUNK_UNLOCK_RKEstate,#1
2396  0575 2050          	jra	L777
2397  0577               L7701:
2398                     ; 797  		else if(B_Code_new == RKEfindcar)
2400  0577 a38000        	cpw	x,#32768
2401  057a 2611          	jrne	L1111
2402                     ; 799 			if ((DoorState == AllDoorIsClosed) && (KeyInState == KeyIsOutHole)&&(LockState == Locked))//add lockstate 20120308
2404  057c c60000        	ld	a,_DoorState
2405  057f 2646          	jrne	L777
2407  0581 c60000        	ld	a,_KeyInState
2408  0584 2641          	jrne	L777
2410  0586 c60000        	ld	a,_LockState
2411  0589 a155          	cp	a,#85
2412  058b 203a          	jra	L777
2413  058d               L1111:
2414                     ; 806           else if(B_Code_new == UnlockDriver_set_CMD) //暂时取消调试
2416  058d a36000        	cpw	x,#24576
2417  0590 2635          	jrne	L777
2418                     ; 808               if(rke_UnlockDriver_setcnt < 15)	rke_UnlockDriver_setcnt++;
2420  0592 c60000        	ld	a,L137_rke_UnlockDriver_setcnt
2421  0595 a10f          	cp	a,#15
2422  0597 2407          	jruge	L1211
2425  0599 725c0000      	inc	L137_rke_UnlockDriver_setcnt
2426  059d c60000        	ld	a,L137_rke_UnlockDriver_setcnt
2427  05a0               L1211:
2428                     ; 809     		  if(rke_UnlockDriver_setcnt == 15 )
2430  05a0 a10f          	cp	a,#15
2431  05a2 2623          	jrne	L777
2432                     ; 811     		         rke_UnlockDriver_setcnt++;
2434  05a4 725c0000      	inc	L137_rke_UnlockDriver_setcnt
2435                     ; 814                      if(unlockdriverstate == 0)unlockdriverstate = 1;//SAVEunlockdriverstate(1);     
2437  05a8 c6408a        	ld	a,_unlockdriverstate
2438  05ab 2606          	jrne	L5211
2441  05ad 3501408a      	mov	_unlockdriverstate,#1
2443  05b1 2004          	jra	L7211
2444  05b3               L5211:
2445                     ; 815     				 else unlockdriverstate = 0;//SAVEunlockdriverstate(0);
2447  05b3 725f408a      	clr	_unlockdriverstate
2448  05b7               L7211:
2449                     ; 816     				 BuzzerDrv(1,126,125,BuzzDrvunlockset); 
2451  05b7 4b05          	push	#5
2452  05b9 ae007d        	ldw	x,#125
2453  05bc 89            	pushw	x
2454  05bd 5c            	incw	x
2455  05be 89            	pushw	x
2456  05bf a601          	ld	a,#1
2457  05c1 8d000000      	callf	f_BuzzerDrv
2459  05c5 5b05          	addw	sp,#5
2460  05c7               L777:
2461                     ; 823         if ((IGNstate == ON)||(wLockProtectTimeCnt !=0)) //20100719
2463  05c7 c60000        	ld	a,_IGNstate
2464  05ca a155          	cp	a,#85
2465  05cc 2705          	jreq	L3311
2467  05ce ce0000        	ldw	x,_wLockProtectTimeCnt
2468  05d1 2704          	jreq	L577
2469  05d3               L3311:
2470                     ; 825             TurnFlashCnt = 0;
2472  05d3 5f            	clrw	x
2473  05d4 cf0000        	ldw	_TurnFlashCnt,x
2474  05d7               L577:
2475                     ; 871     if (RKE_AutoLockFlag == RKE_AUTO_LOCK_YES)
2477  05d7 c60029        	ld	a,_RKE_AutoLockFlag
2478  05da a155          	cp	a,#85
2479  05dc 263b          	jrne	L5311
2480                     ; 873     	if (++RKE_AutoLockCnt > RKE_AUTO_LOCK_CNT)
2482  05de ce0027        	ldw	x,_RKE_AutoLockCnt
2483  05e1 5c            	incw	x
2484  05e2 cf0027        	ldw	_RKE_AutoLockCnt,x
2485  05e5 a30ea7        	cpw	x,#3751
2486  05e8 2533          	jrult	L5411
2487                     ; 875               RKE_AutoLockCnt = 0;
2489  05ea 5f            	clrw	x
2490  05eb cf0027        	ldw	_RKE_AutoLockCnt,x
2491                     ; 877               RKE_COMMAND = RKECMD_LOCK;
2493  05ee 3501003e      	mov	_RKE_COMMAND,#1
2494                     ; 879               if((IGNstate == OFF)&&(wLockProtectTimeCnt ==0))TurnFlashCnt = 2;	//\__lock:turn lamps flash 2 time 
2496  05f2 c60000        	ld	a,_IGNstate
2497  05f5 260b          	jrne	L1411
2499  05f7 ce0000        	ldw	x,_wLockProtectTimeCnt
2500  05fa 2606          	jrne	L1411
2503  05fc ae0002        	ldw	x,#2
2504  05ff cf0000        	ldw	_TurnFlashCnt,x
2505  0602               L1411:
2506                     ; 880               RKELOCKstate = 0xaa;
2508  0602 35aa0000      	mov	_RKELOCKstate,#170
2509                     ; 881               LockDrvCmd = LockCmd;
2511  0606 35200000      	mov	_LockDrvCmd,#32
2512                     ; 882               if(KeyInState ==  KeyIsOutHole )Alarmstatus_RKE = 3; //自动重锁状态
2514  060a c60000        	ld	a,_KeyInState
2515  060d 2604          	jrne	L3411
2518  060f 35030000      	mov	_Alarmstatus_RKE,#3
2519  0613               L3411:
2520                     ; 883               RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;
2522  0613 725f0029      	clr	_RKE_AutoLockFlag
2523  0617 2004          	jra	L5411
2524  0619               L5311:
2525                     ; 888     	    RKE_AutoLockCnt = 0;
2527  0619 5f            	clrw	x
2528  061a cf0027        	ldw	_RKE_AutoLockCnt,x
2529  061d               L5411:
2530                     ; 890 }
2533  061d 84            	pop	a
2534  061e 87            	retf	
2563                     ; 902 void RKE_RECEIVE_RESET(void) 
2563                     ; 903 {
2564                     	switch	.text
2565  061f               f_RKE_RECEIVE_RESET:
2569                     ; 907 	Header[0] = 0x00;
2571  061f 5f            	clrw	x
2572  0620 cf0049        	ldw	_Header,x
2573                     ; 908 	Header[1] = 0x00;
2575  0623 cf004b        	ldw	_Header+2,x
2576                     ; 909 	A_Code[0] = A_Code[1] = 0x00;
2578  0626 cf0047        	ldw	_A_Code+2,x
2579  0629 cf0045        	ldw	_A_Code,x
2580                     ; 910 	B_Code[0] = B_Code[1] = 0x00;
2582  062c cf0043        	ldw	_B_Code+2,x
2583  062f cf0041        	ldw	_B_Code,x
2584                     ; 912 	RKE_FIFO_DATA[0] = 0x00;
2586  0632 cf002e        	ldw	_RKE_FIFO_DATA,x
2587                     ; 913 	RKE_FIFO_DATA[1] = 0x00;
2589  0635 cf0030        	ldw	_RKE_FIFO_DATA+2,x
2590                     ; 914 	RKE_FIFO_DATA[2] = 0x00;
2592  0638 cf0032        	ldw	_RKE_FIFO_DATA+4,x
2593                     ; 915 	RKE_FIFO_DATA[3] = 0x00;
2595  063b cf0034        	ldw	_RKE_FIFO_DATA+6,x
2596                     ; 916 	RKE_FIFO_DATA[4] = 0x00;
2598  063e cf0036        	ldw	_RKE_FIFO_DATA+8,x
2599                     ; 917 	RKE_FIFO_DATA[5] = 0x00;
2601  0641 cf0038        	ldw	_RKE_FIFO_DATA+10,x
2602                     ; 919     TIM3_OVFINT_DISABLE;
2604  0644 a601          	ld	a,#1
2605  0646 8d000000      	callf	f_TIM3_Disable_IT
2607                     ; 920     TIM3_OCINT_DISABLE;
2609  064a a606          	ld	a,#6
2610  064c 8d000000      	callf	f_TIM3_Disable_IT
2612                     ; 921     RISE_EDGE_INT;
2614  0650 ae0001        	ldw	x,#1
2615  0653 a603          	ld	a,#3
2616  0655 95            	ld	xh,a
2617  0656 8d000000      	callf	f_EXTI_SetExtIntSensitivity
2619                     ; 922 	ENABLE_RX_INT;
2621  065a 72145013      	bset	20499,#2
2622                     ; 924 	RKE_STEP = RKE_Idle;
2625  065e 725f0040      	clr	_RKE_STEP
2626                     ; 925 }
2629  0662 87            	retf	
2658                     ; 937 void RKE_RECEIVE_STOP(void)
2658                     ; 938 {
2659                     	switch	.text
2660  0663               f_RKE_RECEIVE_STOP:
2664                     ; 942 	Header[0] = 0x00;
2666  0663 5f            	clrw	x
2667  0664 cf0049        	ldw	_Header,x
2668                     ; 943 	Header[1] = 0x00;
2670  0667 cf004b        	ldw	_Header+2,x
2671                     ; 944 	A_Code[0] = A_Code[1] = 0x00;
2673  066a cf0047        	ldw	_A_Code+2,x
2674  066d cf0045        	ldw	_A_Code,x
2675                     ; 945 	B_Code[0] = B_Code[1] = 0x00;
2677  0670 cf0043        	ldw	_B_Code+2,x
2678  0673 cf0041        	ldw	_B_Code,x
2679                     ; 947 	RKE_FIFO_DATA[0] = 0x00;
2681  0676 cf002e        	ldw	_RKE_FIFO_DATA,x
2682                     ; 948 	RKE_FIFO_DATA[1] = 0x00;
2684  0679 cf0030        	ldw	_RKE_FIFO_DATA+2,x
2685                     ; 949 	RKE_FIFO_DATA[2] = 0x00;
2687  067c cf0032        	ldw	_RKE_FIFO_DATA+4,x
2688                     ; 950 	RKE_FIFO_DATA[3] = 0x00;
2690  067f cf0034        	ldw	_RKE_FIFO_DATA+6,x
2691                     ; 951 	RKE_FIFO_DATA[4] = 0x00;
2693  0682 cf0036        	ldw	_RKE_FIFO_DATA+8,x
2694                     ; 954     TIM3_OCINT_DISABLE;
2696  0685 a606          	ld	a,#6
2697  0687 8d000000      	callf	f_TIM3_Disable_IT
2699                     ; 955     TIM3_OVFINT_DISABLE;
2701  068b a601          	ld	a,#1
2702  068d 8d000000      	callf	f_TIM3_Disable_IT
2704                     ; 956     RISE_EDGE_INT;
2706  0691 ae0001        	ldw	x,#1
2707  0694 a603          	ld	a,#3
2708  0696 95            	ld	xh,a
2709  0697 8d000000      	callf	f_EXTI_SetExtIntSensitivity
2711                     ; 957     DISABLE_RX_INT;
2713  069b 72155013      	bres	20499,#2
2714                     ; 959 	RKE_STEP = RKE_Idle;
2717  069f 725f0040      	clr	_RKE_STEP
2718                     ; 960 }
2721  06a3 87            	retf	
2723                     	switch	.bss
2724  0007               L7611_RKETimeOutCnt:
2725  0007 00            	ds.b	1
2758                     ; 972 void Check_RKE_Receive_Timeout(void)
2758                     ; 973 {
2759                     	switch	.text
2760  06a4               f_Check_RKE_Receive_Timeout:
2764                     ; 977     if (RKE_STEP == RKE_Idle)
2766  06a4 c60040        	ld	a,_RKE_STEP
2767  06a7 2604          	jrne	L5021
2768                     ; 979     	RKETimeOutCnt = 0;
2770  06a9 c70007        	ld	L7611_RKETimeOutCnt,a
2773  06ac 87            	retf	
2774  06ad               L5021:
2775                     ; 983 		if ((++RKETimeOutCnt > RKE_RECEIVE_TIME_OUT) && ((RKE_STEP != RKE_RecFinished)))
2777  06ad 725c0007      	inc	L7611_RKETimeOutCnt
2778  06b1 c60007        	ld	a,L7611_RKETimeOutCnt
2779  06b4 a110          	cp	a,#16
2780  06b6 250b          	jrult	L7021
2782  06b8 c60040        	ld	a,_RKE_STEP
2783  06bb a102          	cp	a,#2
2784  06bd 2704          	jreq	L7021
2785                     ; 985 			RKE_RECEIVE_RESET();
2787  06bf 8d1f061f      	callf	f_RKE_RECEIVE_RESET
2789  06c3               L7021:
2790                     ; 991 }
2793  06c3 87            	retf	
2826                     ; 1005 void RkeStudy(void)
2826                     ; 1006 {
2827                     	switch	.text
2828  06c4               f_RkeStudy:
2832                     ; 1009     if (EnalbeLearnRkeTime20s != 0)
2834  06c4 ce0000        	ldw	x,_EnalbeLearnRkeTime20s
2835  06c7 276d          	jreq	L1421
2836                     ; 1011         if(EnalbeLearnRkeTime20s > 1240) keyindex = 0;
2838  06c9 a304d9        	cpw	x,#1241
2839  06cc 2504          	jrult	L5221
2842  06ce 725f0020      	clr	_keyindex
2843  06d2               L5221:
2844                     ; 1013 		RKE_COMMAND = RKECMD_LEARN;
2846  06d2 3504003e      	mov	_RKE_COMMAND,#4
2847                     ; 1016        	if(RKE_COMMAND_StandBy_state == 0x11)
2849  06d6 c60021        	ld	a,_RKE_COMMAND_StandBy_state
2850  06d9 a111          	cp	a,#17
2851  06db 260f          	jrne	L7221
2852                     ; 1019           		RX_Sync_Code = B_Code[1];	
2854  06dd ce0043        	ldw	x,_B_Code+2
2855  06e0 cf002c        	ldw	_RX_Sync_Code,x
2856                     ; 1021           		SAVE_SYNC_CODE(keyindex);		//read sync code and save it into flash 
2858  06e3 c60020        	ld	a,_keyindex
2859  06e6 8d1f001f      	callf	f_SAVE_SYNC_CODE
2861                     ; 1024 				 BuzzerDrv(1,125,62,buzzlearnkey); 
2864  06ea 2038          	jpf	LC004
2865  06ec               L7221:
2866                     ; 1030 				if( f_RKE_SerialNum[0] == 0x00000000 )
2868  06ec ae4000        	ldw	x,#_f_RKE_SerialNum
2869  06ef 8d000000      	callf	d_lzmp
2871  06f3 2606          	jrne	L3321
2872                     ; 1032 				 keyindex = 0;
2874  06f5 725f0020      	clr	_keyindex
2876  06f9 200d          	jra	L5321
2877  06fb               L3321:
2878                     ; 1034 				else if(  f_RKE_SerialNum[1] == 0x00000000 )
2880  06fb ae4004        	ldw	x,#_f_RKE_SerialNum+4
2881  06fe 8d000000      	callf	d_lzmp
2883  0702 2604          	jrne	L5321
2884                     ; 1036 				 keyindex = 1;
2886  0704 35010020      	mov	_keyindex,#1
2887  0708               L5321:
2888                     ; 1054 				SAVE_SERIAL_NUMBER(keyindex);
2890  0708 c60020        	ld	a,_keyindex
2891  070b 8df300f3      	callf	f_SAVE_SERIAL_NUMBER
2893                     ; 1059 				RKEstadynumber++;
2895  070f 725c0019      	inc	_RKEstadynumber
2896                     ; 1060 				RX_Sync_Code = B_Code[1];		
2898  0713 ce0043        	ldw	x,_B_Code+2
2899  0716 cf002c        	ldw	_RX_Sync_Code,x
2900                     ; 1061 				SAVE_SYNC_CODE(keyindex);		//read sync code and save it into flash
2902  0719 c60020        	ld	a,_keyindex
2903  071c 8d1f001f      	callf	f_SAVE_SYNC_CODE
2905                     ; 1063 				keyindex++;
2907  0720 725c0020      	inc	_keyindex
2908                     ; 1065 				BuzzerDrv(1,125,62,buzzlearnkey); 
2911  0724               LC004:
2913  0724 4b04          	push	#4
2914  0726 ae003e        	ldw	x,#62
2915  0729 89            	pushw	x
2916  072a ae007d        	ldw	x,#125
2917  072d 89            	pushw	x
2918  072e a601          	ld	a,#1
2919  0730 8d000000      	callf	f_BuzzerDrv
2920  0734 5b05          	addw	sp,#5
2921  0736               L1421:
2922                     ; 1074 }
2925                     ; 1072        return;
2928  0736 87            	retf	
2966                     ; 1086 void RKEBatteryVoltage(void)
2966                     ; 1087 {
2967                     	switch	.text
2968  0737               f_RKEBatteryVoltage:
2970  0737 88            	push	a
2971       00000001      OFST:	set	1
2974                     ; 1090     if(KeyInState == KeyIsInHole) return;
2976  0738 c60000        	ld	a,_KeyInState
2977  073b 4a            	dec	a
2978  073c 2602          	jrne	L7521
2982  073e 84            	pop	a
2983  073f 87            	retf	
2984  0740               L7521:
2985                     ; 1092     if((Header[0]& 0x0003)== 0x0003)
2987  0740 c6004a        	ld	a,_Header+1
2988  0743 a403          	and	a,#3
2989  0745 5f            	clrw	x
2990  0746 02            	rlwa	x,a
2991  0747 a30003        	cpw	x,#3
2992  074a 262b          	jrne	L1621
2993                     ; 1096        BatterVolcnt = RKEVOlCNT[keyindex]+1;
2995  074c c60020        	ld	a,_keyindex
2996  074f 5f            	clrw	x
2997  0750 97            	ld	xl,a
2998  0751 d64060        	ld	a,(_RKEVOlCNT,x)
2999  0754 4c            	inc	a
3000  0755 6b01          	ld	(OFST+0,sp),a
3001                     ; 1097        if(BatterVolcnt >= 3)
3003  0757 a103          	cp	a,#3
3004  0759 2524          	jrult	L5621
3005                     ; 1100 		   BuzzerDrv(9,125,62,buzzvcclow); 
3007  075b 4b16          	push	#22
3008  075d ae003e        	ldw	x,#62
3009  0760 89            	pushw	x
3010  0761 ae007d        	ldw	x,#125
3011  0764 89            	pushw	x
3012  0765 a609          	ld	a,#9
3013  0767 8d000000      	callf	f_BuzzerDrv
3015  076b 5b05          	addw	sp,#5
3016                     ; 1101            RKEBatteryVoltageturnstate = 1;
3018  076d 3501001d      	mov	_RKEBatteryVoltageturnstate,#1
3019                     ; 1102            BatterVolcnt = 3;
3021  0771 a603          	ld	a,#3
3022  0773 6b01          	ld	(OFST+0,sp),a
3023  0775 2008          	jra	L5621
3024  0777               L1621:
3025                     ; 1107            BatterVolcnt = 0;
3027  0777 0f01          	clr	(OFST+0,sp)
3028                     ; 1108            RKEBatteryVoltageturnstate  = 0;
3030  0779 725f001d      	clr	_RKEBatteryVoltageturnstate
3031  077d 7b01          	ld	a,(OFST+0,sp)
3032  077f               L5621:
3033                     ; 1110      SAVE_BatterVol_CODE(keyindex,BatterVolcnt);   // 保存电池电压信息      
3035  077f 97            	ld	xl,a
3036  0780 c60020        	ld	a,_keyindex
3037  0783 95            	ld	xh,a
3038  0784 8d8a078a      	callf	f_SAVE_BatterVol_CODE
3040                     ; 1113 }
3043  0788 84            	pop	a
3044  0789 87            	retf	
3100                     ; 1125 void SAVE_BatterVol_CODE(uchar keyindex,uchar data)
3100                     ; 1126 {
3101                     	switch	.text
3102  078a               f_SAVE_BatterVol_CODE:
3104  078a 89            	pushw	x
3105  078b 5209          	subw	sp,#9
3106       00000009      OFST:	set	9
3109                     ; 1130 	temp = (u32)(&RKEVOlCNT) + keyindex*1;
3111  078d 9e            	ld	a,xh
3112  078e b703          	ld	c_lreg+3,a
3113  0790 3f02          	clr	c_lreg+2
3114  0792 3f01          	clr	c_lreg+1
3115  0794 3f00          	clr	c_lreg
3116  0796 96            	ldw	x,sp
3117  0797 5c            	incw	x
3118  0798 8d000000      	callf	d_rtol
3120  079c ae4060        	ldw	x,#_RKEVOlCNT
3121  079f 8d000000      	callf	d_uitolx
3123  07a3 96            	ldw	x,sp
3124  07a4 5c            	incw	x
3125  07a5 8d000000      	callf	d_ladd
3127  07a9 96            	ldw	x,sp
3128  07aa 1c0006        	addw	x,#OFST-3
3129  07ad 8d000000      	callf	d_rtol
3131                     ; 1132 	Clear_WDT();
3133  07b1 8d000000      	callf	f_Clear_WDT
3135                     ; 1133 	res = (u8)(data);
3137  07b5 7b0b          	ld	a,(OFST+2,sp)
3138  07b7 6b05          	ld	(OFST-4,sp),a
3139                     ; 1134 	FLASH_ProgramByte(temp++, res);	
3141  07b9 88            	push	a
3142  07ba 96            	ldw	x,sp
3143  07bb 1c0007        	addw	x,#OFST-2
3144  07be 8d000000      	callf	d_ltor
3146  07c2 96            	ldw	x,sp
3147  07c3 1c0007        	addw	x,#OFST-2
3148  07c6 a601          	ld	a,#1
3149  07c8 8d000000      	callf	d_lgadc
3151  07cc be02          	ldw	x,c_lreg+2
3152  07ce 89            	pushw	x
3153  07cf be00          	ldw	x,c_lreg
3154  07d1 89            	pushw	x
3155  07d2 8d000000      	callf	f_FLASH_ProgramByte
3157  07d6 5b05          	addw	sp,#5
3158                     ; 1135 	Clear_WDT();
3160  07d8 8d000000      	callf	f_Clear_WDT
3162                     ; 1136 }
3165  07dc 5b0b          	addw	sp,#11
3166  07de 87            	retf	
3482                     	xdef	f_Check_RKE_Receive_Timeout
3483                     	xdef	f_DECODE_PROC
3484                     	switch	.bss
3485  0008               _itemp:
3486  0008 0000          	ds.b	2
3487                     	xdef	_itemp
3488                     	xdef	f_SAVE_SYNC_CODE
3489                     	xdef	_QW
3490                     	xdef	_PW
3491  000a               _RKE_CODE_OK:
3492  000a 00            	ds.b	1
3493                     	xdef	_RKE_CODE_OK
3494                     	xdef	_RKEERRORSTATE
3495                     	xdef	_RKESETBUZZ
3496  000b               _RKE_Resive_cnt:
3497  000b 00            	ds.b	1
3498                     	xdef	_RKE_Resive_cnt
3499  000c               _studyunlockcnt:
3500  000c 0000          	ds.b	2
3501                     	xdef	_studyunlockcnt
3502  000e               _ROM_Sync_Code:
3503  000e 000000000000  	ds.b	8
3504                     	xdef	_ROM_Sync_Code
3505                     	xdef	_f_SKey_B
3506                     	xref	f_Decrypt
3507                     	xref	f_Clear_WDT
3508                     	xref	_HornDoorunclosetime
3509                     	xref	_EnalbeLearnRkeTime20s
3510                     	xref	f_ClearBuzzdrv
3511                     	xref	f_BuzzerDrv
3512                     	xref	_TrunkWarmTime
3513                     	xref	_CarState
3514                     	xref	_KeyInState
3515                     	xref	_Warningstate
3516                     	xref	_DoorState
3517                     	xref	_TurnFlashCnt
3518                     	xref	_turnfindcarstate
3519                     	xref	_dooropenlock
3520                     	xref	_BUZZLocktimecnt
3521                     	xref	_wLockProtectTimeCnt
3522                     	xref	_Alarmstatus_RKE
3523                     	xref	_BCMtoGEM_AlarmStatus
3524                     	xref	_TRUNK_UNLOCK_RKEstate
3525                     	xref	_LockDrvCmd
3526                     	xref	_LockState
3527                     	xref	f_TIM3_Disable_IT
3528                     	xref	_RKELOCKstate
3529  0016               _LINWINDOWSTATE:
3530  0016 00            	ds.b	1
3531                     	xdef	_LINWINDOWSTATE
3532                     	xdef	f_SAVE_SERIAL_NUMBER
3533                     	xdef	f_INITrkenumber
3534                     	xdef	f_RKEnumberRead
3535                     	xdef	f_SAVEunlockdriverstate
3536                     	xdef	f_SAVE_BatterVol_CODE
3537                     	xdef	f_RKEBatteryVoltage
3538                     	xdef	f_RkeStudy
3539                     	xdef	f_RKE_RECEIVE_STOP
3540                     	xdef	f_RKE_RECEIVE_RESET
3541                     	xdef	f_ScanRkeKeys
3542  0017               _Buzz10sstate:
3543  0017 0000          	ds.b	2
3544                     	xdef	_Buzz10sstate
3545  0019               _RKEstadynumber:
3546  0019 00            	ds.b	1
3547                     	xdef	_RKEstadynumber
3548                     	xdef	_DriverLOCK
3549  001a               _RKE_outtime:
3550  001a 00            	ds.b	1
3551                     	xdef	_RKE_outtime
3552  001b               _RKE_DATA_OK:
3553  001b 00            	ds.b	1
3554                     	xdef	_RKE_DATA_OK
3555  001c               _RKEWarmCancle:
3556  001c 00            	ds.b	1
3557                     	xdef	_RKEWarmCancle
3558  001d               _RKEBatteryVoltageturnstate:
3559  001d 00            	ds.b	1
3560                     	xdef	_RKEBatteryVoltageturnstate
3561  001e               _B_Code_new:
3562  001e 0000          	ds.b	2
3563                     	xdef	_B_Code_new
3564  0020               _keyindex:
3565  0020 00            	ds.b	1
3566                     	xdef	_keyindex
3567  0021               _RKE_COMMAND_StandBy_state:
3568  0021 00            	ds.b	1
3569                     	xdef	_RKE_COMMAND_StandBy_state
3570  0022               _FindCarFlag:
3571  0022 00            	ds.b	1
3572                     	xdef	_FindCarFlag
3573  0023               _ImmoOnTime:
3574  0023 00000000      	ds.b	4
3575                     	xdef	_ImmoOnTime
3576  0027               _RKE_AutoLockCnt:
3577  0027 0000          	ds.b	2
3578                     	xdef	_RKE_AutoLockCnt
3579  0029               _RKE_AutoLockFlag:
3580  0029 00            	ds.b	1
3581                     	xdef	_RKE_AutoLockFlag
3582                     	xref	_IGNstate
3583  002a               _LAST_RX_sync_Code:
3584  002a 0000          	ds.b	2
3585                     	xdef	_LAST_RX_sync_Code
3586  002c               _RX_Sync_Code:
3587  002c 0000          	ds.b	2
3588                     	xdef	_RX_Sync_Code
3589  002e               _RKE_FIFO_DATA:
3590  002e 000000000000  	ds.b	12
3591                     	xdef	_RKE_FIFO_DATA
3592  003a               _RX_SerialNum:
3593  003a 00000000      	ds.b	4
3594                     	xdef	_RX_SerialNum
3595  003e               _RKE_COMMAND:
3596  003e 00            	ds.b	1
3597                     	xdef	_RKE_COMMAND
3598  003f               _nPrecodeCnt:
3599  003f 00            	ds.b	1
3600                     	xdef	_nPrecodeCnt
3601  0040               _RKE_STEP:
3602  0040 00            	ds.b	1
3603                     	xdef	_RKE_STEP
3604  0041               _B_Code:
3605  0041 00000000      	ds.b	4
3606                     	xdef	_B_Code
3607  0045               _A_Code:
3608  0045 00000000      	ds.b	4
3609                     	xdef	_A_Code
3610  0049               _Header:
3611  0049 00000000      	ds.b	4
3612                     	xdef	_Header
3613                     	xref	_gNetWorkStatus
3614                     	xref	_gLocalWakeupFlag
3615                     	xref	f_WWDG_Refresh
3616                     	xref	f_EXTI_SetExtIntSensitivity
3617                     	xref	f_FLASH_ProgramByte
3618                     	xref.b	c_lreg
3619                     	xref.b	c_x
3639                     	xref	d_llsh
3640                     	xref	d_uitol
3641                     	xref	d_lzmp
3642                     	xref	d_lcmp
3643                     	xref	d_ltor
3644                     	xref	d_lgadc
3645                     	xref	d_ladd
3646                     	xref	d_rtol
3647                     	xref	d_itolx
3648                     	xref	d_uitolx
3649                     	end
