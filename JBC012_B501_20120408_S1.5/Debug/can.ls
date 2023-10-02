   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 802                     	switch	.data
 803  0000               _RXITcnt:
 804  0000 00            	dc.b	0
 805  0001               _RXREcnt:
 806  0001 00            	dc.b	0
 807  0002               _DTCsendmode:
 808  0002 00            	dc.b	0
 809  0003               _busofftimecnt:
 810  0003 0000          	dc.w	0
 845                     ; 207 void BUSoff(void)
 845                     ; 208 {
 846                     	switch	.text
 847  0000               f_BUSoff:
 851                     ; 213    if(Busoffstate == 1)
 853  0000 c600be        	ld	a,_Busoffstate
 854  0003 a101          	cp	a,#1
 855                     ; 215               Busoffstate = 0;
 856                     ; 216 		CAN_Init(CMCR_AWUM);
 858                     ; 217 		CAN_EnableDiagMode(CDGR_RX);		//  | CDGR_SILM TEST MODE
 860                     ; 218 		CanCanInterruptRestore();
 863  0005 2738          	jreq	LC001
 864                     ; 221    else if(Busoffstate == 2)
 866  0007 a102          	cp	a,#2
 867  0009 2648          	jrne	L554
 868                     ; 224 		if(busoffcnt < 8)
 870  000b ce00bc        	ldw	x,_busoffcnt
 871  000e a30008        	cpw	x,#8
 872  0011 ce0003        	ldw	x,_busofftimecnt
 873  0014 241b          	jruge	L754
 874                     ; 227 			 if(busofftimecnt > 30) {busoffcnt++;return;}
 876  0016 a3001f        	cpw	x,#31
 877  0019 2508          	jrult	L164
 880  001b ce00bc        	ldw	x,_busoffcnt
 881  001e 5c            	incw	x
 882  001f cf00bc        	ldw	_busoffcnt,x
 886  0022 87            	retf	
 887  0023               L164:
 888                     ; 228 			 if(busofftimecnt < 24)busofftimecnt++;
 890  0023 a30018        	cpw	x,#24
 893  0026 250e          	jrult	LC003
 894                     ; 231                               busoffcnt++;
 896  0028 ce00bc        	ldw	x,_busoffcnt
 897  002b 5c            	incw	x
 898  002c cf00bc        	ldw	_busoffcnt,x
 899                     ; 232 				  busofftimecnt = 0;
 900                     ; 233 				  Busoffstate = 0;
 901                     ; 234 				  CAN_Init(CMCR_AWUM);
 903                     ; 235 			   	  CAN_EnableDiagMode(CDGR_RX);		//  | CDGR_SILM TEST MODE
 905                     ; 236 				  CanCanInterruptRestore();
 907  002f 200a          	jpf	L174
 908  0031               L754:
 909                     ; 243 			 if(busofftimecnt < 500)busofftimecnt++;
 911  0031 a301f4        	cpw	x,#500
 912  0034 2405          	jruge	L174
 915  0036               LC003:
 917  0036 5c            	incw	x
 918  0037 cf0003        	ldw	_busofftimecnt,x
 921  003a 87            	retf	
 922  003b               L174:
 923                     ; 247 				  busofftimecnt = 0;
 926  003b 5f            	clrw	x
 927  003c cf0003        	ldw	_busofftimecnt,x
 928                     ; 248 				  Busoffstate = 0;
 930                     ; 249 				  CAN_Init(CMCR_AWUM);
 933                     ; 250 			   	  CAN_EnableDiagMode(CDGR_RX);		//  | CDGR_SILM TEST MODE
 936                     ; 251 				  CanCanInterruptRestore();
 938  003f               LC001:
 941  003f 725f00be      	clr	_Busoffstate
 944  0043 a620          	ld	a,#32
 945  0045 8d2f012f      	callf	f_CAN_Init
 948  0049 a608          	ld	a,#8
 949  004b 8dd605d6      	callf	f_CAN_EnableDiagMode
 954  004f accf06cf      	jpf	f_CanCanInterruptRestore
 955  0053               L554:
 956                     ; 263        Busoffstate = 0;
 958  0053 725f00be      	clr	_Busoffstate
 959                     ; 268 }
 962  0057 87            	retf	
 999                     ; 274 unsigned char CANHardwave_Init(u8 gCANHardwareState)
 999                     ; 275 {
1000                     	switch	.text
1001  0058               f_CANHardwave_Init:
1005                     ; 277 	switch(gCANHardwareState)
1008                     ; 315 		 default:
1008                     ; 316 		 	break;
1009  0058 4a            	dec	a
1010  0059 270c          	jreq	L774
1011  005b 4a            	dec	a
1012  005c 2720          	jreq	L105
1013  005e a002          	sub	a,#2
1014  0060 272b          	jreq	L305
1015  0062 a004          	sub	a,#4
1016  0064 2732          	jreq	L505
1018  0066 87            	retf	
1019  0067               L774:
1020                     ; 279          case  1:
1020                     ; 280 			//CAN_Init(CMCR_ABOM | CMCR_AWUM);
1020                     ; 281 			CAN_Init(CMCR_AWUM);
1022  0067 a620          	ld	a,#32
1023  0069 8d2f012f      	callf	f_CAN_Init
1025                     ; 282 			CAN_EnableDiagMode(CDGR_RX);		//  | CDGR_SILM TEST MODE
1027  006d a608          	ld	a,#8
1028  006f 8dd605d6      	callf	f_CAN_EnableDiagMode
1030                     ; 283 			CanCanInterruptRestore();
1032  0073 8dcf06cf      	callf	f_CanCanInterruptRestore
1034                     ; 285 	        LIN_ENABLE;
1036  0077 7218500f      	bset	20495,#4
1037                     ; 287             return 1;
1039  007b a601          	ld	a,#1
1042  007d 87            	retf	
1043  007e               L105:
1044                     ; 289 		 case  2:
1044                     ; 290             //CAN_MCR |= CMCR_INRQ;				/// Leave the Init mode /
1044                     ; 291             //while ( (CAN_MSR & ~CMSR_INAK) );	///Wait until acknowledged /      
1044                     ; 292 			CAN_MCR |=CMCR_SLEEP|CMCR_AWUM;
1047  007e c65420        	ld	a,_CAN_MCR
1048  0081 aa22          	or	a,#34
1049  0083 c75420        	ld	_CAN_MCR,a
1050                     ; 295 			LIN_DISENABLE;
1052  0086 7219500f      	bres	20495,#4
1053                     ; 297 			return 1;
1055  008a a601          	ld	a,#1
1058  008c 87            	retf	
1059  008d               L305:
1060                     ; 299 		 case  4:
1060                     ; 300 		 	//if()
1060                     ; 301             WakeUp();
1062  008d 8d000000      	callf	f_WakeUp
1064                     ; 302             CAN_WakeUp();
1066  0091 8dcc05cc      	callf	f_CAN_WakeUp
1068                     ; 308 			return 1;
1070  0095 a601          	ld	a,#1
1073  0097 87            	retf	
1074  0098               L505:
1075                     ; 310 		 case  8:
1075                     ; 311 		 	
1075                     ; 312             //WakeUp();
1075                     ; 313 			return 1;
1077  0098 4c            	inc	a
1080                     ; 315 		 default:
1080                     ; 316 		 	break;
1082                     ; 319 }
1085  0099 87            	retf	
1151                     ; 321 unsigned char CanSendMsg(CAN_Msg_TypeDef NM_Msg)
1151                     ; 322 { 
1152                     	switch	.text
1153  009a               f_CanSendMsg:
1155       00000000      OFST:	set	0
1158                     ; 324 	 CAN_send2(NM_Msg.id,NM_Msg.dlc,NM_Msg.Byte[0],NM_Msg.Byte[1],NM_Msg.Byte[2],NM_Msg.Byte[3],NM_Msg.Byte[4],NM_Msg.Byte[5],NM_Msg.Byte[6],NM_Msg.Byte[7]);
1160  009a 7b0e          	ld	a,(OFST+14,sp)
1161  009c 88            	push	a
1162  009d 7b0e          	ld	a,(OFST+14,sp)
1163  009f 88            	push	a
1164  00a0 7b0e          	ld	a,(OFST+14,sp)
1165  00a2 88            	push	a
1166  00a3 7b0e          	ld	a,(OFST+14,sp)
1167  00a5 88            	push	a
1168  00a6 7b0e          	ld	a,(OFST+14,sp)
1169  00a8 88            	push	a
1170  00a9 7b0e          	ld	a,(OFST+14,sp)
1171  00ab 88            	push	a
1172  00ac 7b0e          	ld	a,(OFST+14,sp)
1173  00ae 88            	push	a
1174  00af 7b0e          	ld	a,(OFST+14,sp)
1175  00b1 88            	push	a
1176  00b2 7b0e          	ld	a,(OFST+14,sp)
1177  00b4 88            	push	a
1178  00b5 1e0d          	ldw	x,(OFST+13,sp)
1179  00b7 8d180218      	callf	f_CAN_send2
1181  00bb 5b09          	addw	sp,#9
1182                     ; 327 	 return 1;
1184  00bd a601          	ld	a,#1
1187  00bf 87            	retf	
1232                     ; 331 CAN_Msg_TypeDef  NM_RecMsgSave(void)
1232                     ; 332 {
1233                     	switch	.text
1234  00c0               f_NM_RecMsgSave:
1236  00c0 520c          	subw	sp,#12
1237       0000000c      OFST:	set	12
1240                     ; 338 	 Rcan.id  = 0;
1242  00c2 5f            	clrw	x
1243  00c3 1f01          	ldw	(OFST-11,sp),x
1244                     ; 339 	 if(RXREcnt != RXITcnt)
1246  00c5 c60001        	ld	a,_RXREcnt
1247  00c8 c10000        	cp	a,_RXITcnt
1248  00cb 2753          	jreq	L306
1249                     ; 342 				RXREcnt++;
1251  00cd 725c0001      	inc	_RXREcnt
1252                     ; 343 			      if(RXREcnt > 4) RXREcnt = 0;
1254  00d1 c60001        	ld	a,_RXREcnt
1255  00d4 a105          	cp	a,#5
1256  00d6 2504          	jrult	L506
1259  00d8 4f            	clr	a
1260  00d9 c70001        	ld	_RXREcnt,a
1261  00dc               L506:
1262                     ; 344 		              Rcan.id = NM_CAN_DATA[RXREcnt].id;
1264  00dc 97            	ld	xl,a
1265  00dd a60b          	ld	a,#11
1266  00df 42            	mul	x,a
1267  00e0 de0068        	ldw	x,(_NM_CAN_DATA,x)
1268  00e3 1f01          	ldw	(OFST-11,sp),x
1269                     ; 345 					  NM_CAN_DATA[RXREcnt].id = 0;
1271  00e5 c60001        	ld	a,_RXREcnt
1272  00e8 97            	ld	xl,a
1273  00e9 a60b          	ld	a,#11
1274  00eb 42            	mul	x,a
1275  00ec 905f          	clrw	y
1276  00ee df0068        	ldw	(_NM_CAN_DATA,x),y
1277                     ; 346 					  Rcan.dlc = NM_CAN_DATA[RXREcnt].dlc;
1279  00f1 d6006a        	ld	a,(_NM_CAN_DATA+2,x)
1280  00f4 6b03          	ld	(OFST-9,sp),a
1281                     ; 347 					  for(i=0;i<8;i++)
1283  00f6 0f0c          	clr	(OFST+0,sp)
1284  00f8               L706:
1285                     ; 349 		   				 Rcan.Byte[i]= NM_CAN_DATA[RXREcnt].Byte[i]; 
1287  00f8 96            	ldw	x,sp
1288  00f9 1c0004        	addw	x,#OFST-8
1289  00fc 9f            	ld	a,xl
1290  00fd 5e            	swapw	x
1291  00fe 1b0c          	add	a,(OFST+0,sp)
1292  0100 2401          	jrnc	L25
1293  0102 5c            	incw	x
1294  0103               L25:
1295  0103 02            	rlwa	x,a
1296  0104 89            	pushw	x
1297  0105 c60001        	ld	a,_RXREcnt
1298  0108 97            	ld	xl,a
1299  0109 a60b          	ld	a,#11
1300  010b 42            	mul	x,a
1301  010c 01            	rrwa	x,a
1302  010d 1b0e          	add	a,(OFST+2,sp)
1303  010f 2401          	jrnc	L45
1304  0111 5c            	incw	x
1305  0112               L45:
1306  0112 02            	rlwa	x,a
1307  0113 d6006b        	ld	a,(_NM_CAN_DATA+3,x)
1308  0116 85            	popw	x
1309  0117 f7            	ld	(x),a
1310                     ; 347 					  for(i=0;i<8;i++)
1312  0118 0c0c          	inc	(OFST+0,sp)
1315  011a 7b0c          	ld	a,(OFST+0,sp)
1316  011c a108          	cp	a,#8
1317  011e 25d8          	jrult	L706
1318  0120               L306:
1319                     ; 356      return Rcan;
1321  0120 1e10          	ldw	x,(OFST+4,sp)
1322  0122 9096          	ldw	y,sp
1323  0124 905c          	incw	y
1324  0126 a60b          	ld	a,#11
1325  0128 8d000000      	callf	d_xymvx
1329  012c 5b0c          	addw	sp,#12
1330  012e 87            	retf	
1383                     ; 363 void CAN_Init(u8 CAN_MasterCtrlReg)
1383                     ; 364 { 
1384                     	switch	.text
1385  012f               f_CAN_Init:
1387  012f 88            	push	a
1388       00000000      OFST:	set	0
1391                     ; 367 	CAN_FPSR = CAN_TXMB0_PG;
1393  0130 725f5427      	clr	_CAN_FPSR
1394                     ; 368 	CAN_MCSR |= MCSR_ABRQ;    
1396  0134 721c5428      	bset	_CAN_MCSR,#6
1397                     ; 370 	CAN_FPSR = CAN_TXMB1_PG;
1399  0138 35015427      	mov	_CAN_FPSR,#1
1400                     ; 371 	CAN_MCSR |= MCSR_ABRQ;
1402  013c 721c5428      	bset	_CAN_MCSR,#6
1403                     ; 373 	CAN_FPSR = CAN_TXMB2_PG;
1405  0140 35055427      	mov	_CAN_FPSR,#5
1406                     ; 374 	CAN_MCSR |= MCSR_ABRQ;
1408  0144 721c5428      	bset	_CAN_MCSR,#6
1409                     ; 376 	CAN_MCR |= CMCR_INRQ;				/* Request initialisation */
1411  0148 72105420      	bset	_CAN_MCR,#0
1413  014c               L336:
1414                     ; 377 	while ( !(CAN_MSR & CMSR_INAK) ); 	/* Wait until acknowledged */
1416  014c 72015421fb    	btjf	_CAN_MSR,#0,L336
1417                     ; 383 	CAN_TSR |= CTSR_RQCP0 | CTSR_RQCP1 | CTSR_RQCP2;
1419  0151 c65422        	ld	a,_CAN_TSR
1420  0154 aa07          	or	a,#7
1421  0156 c75422        	ld	_CAN_TSR,a
1423  0159 2004          	jra	L146
1424  015b               L736:
1425                     ; 388 		CAN_RFR = CRFR_RFOM;
1427  015b 35205424      	mov	_CAN_RFR,#32
1428  015f               L146:
1429                     ; 386 	while(CAN_RFR & CRFR_FMP01)
1431  015f c65424        	ld	a,_CAN_RFR
1432  0162 a503          	bcp	a,#3
1433  0164 26f5          	jrne	L736
1434                     ; 392 	CAN_RFR |= CRFR_FOVR;
1436  0166 72185424      	bset	_CAN_RFR,#4
1437                     ; 395 	CAN_MSR = CMSR_WKUI;
1439  016a 35085421      	mov	_CAN_MSR,#8
1440                     ; 398 	CAN_MCR |= CAN_MasterCtrlReg;
1442  016e c65420        	ld	a,_CAN_MCR
1443  0171 1a01          	or	a,(OFST+1,sp)
1444  0173 c75420        	ld	_CAN_MCR,a
1445                     ; 404 	CAN_FPSR = CAN_CTRL_PG ; 
1447  0176 35065427      	mov	_CAN_FPSR,#6
1448                     ; 405 	CAN_FCR1 = 0x00;
1450  017a 725f5432      	clr	_CAN_FCR1
1451                     ; 406 	CAN_FCR2 = 0x00;
1453  017e 725f5433      	clr	_CAN_FCR2
1454                     ; 407 	CAN_FCR3 = 0x00;
1456  0182 725f5434      	clr	_CAN_FCR3
1457                     ; 409 	CAN_FMR1 = 0x00;
1459  0186 725f5430      	clr	_CAN_FMR1
1460                     ; 411 	CAN_FMR2 = 0x00;
1462  018a 725f5431      	clr	_CAN_FMR2
1463                     ; 414 	CAN_FPSR = CAN_FILTER01_PG;
1465  018e 35025427      	mov	_CAN_FPSR,#2
1466                     ; 418 	CAN_FxR0 = 0xA1;		// Stdid: 0x508
1468  0192 35a15428      	mov	_CAN_FxR0,#161
1469                     ; 419 	CAN_FxR1 = 0x00;
1471  0196 725f5429      	clr	_CAN_FxR1
1472                     ; 420 	CAN_FxR2 = 0x00;		// 0x61 Stdid: 0x308
1474  019a 725f542a      	clr	_CAN_FxR2
1475                     ; 421 	CAN_FxR3 = 0x00;
1477  019e 725f542b      	clr	_CAN_FxR3
1478                     ; 422 	CAN_FxR4 = 0x00;	//0x83;		// Stdid: 0x418
1480  01a2 725f542c      	clr	_CAN_FxR4
1481                     ; 423 	CAN_FxR5 = 0x00;
1483  01a6 725f542d      	clr	_CAN_FxR5
1484                     ; 424 	CAN_FxR6 = 0x00;	//0x83;		// Stdid: 0x419
1486  01aa 725f542e      	clr	_CAN_FxR6
1487                     ; 425 	CAN_FxR7 = 0x00;	//0x20;
1489  01ae 725f542f      	clr	_CAN_FxR7
1490                     ; 428 	CAN_FPSR = CAN_CTRL_PG ;
1492  01b2 35065427      	mov	_CAN_FPSR,#6
1493                     ; 432 	CAN_FCR1 = 0x07;
1495  01b6 35075432      	mov	_CAN_FCR1,#7
1496                     ; 435 	CAN_FPSR = CAN_CTRL_PG;
1498  01ba 35065427      	mov	_CAN_FPSR,#6
1499                     ; 437 	CAN_BTR1 = CAN_CBTR0_REGISTER;		// see can.h for modification of
1501  01be 3583542c      	mov	_CAN_BTR1,#131
1502                     ; 438 	CAN_BTR2 = CAN_CBTR1_REGISTER;  	// bit timing parameters.bo te lv she zhi
1504  01c2 3523542d      	mov	_CAN_BTR2,#35
1505                     ; 441     CAN_BTR1 = 0x81;
1507  01c6 3581542c      	mov	_CAN_BTR1,#129
1508                     ; 443 	CAN_BTR2 = 0x2b;
1510  01ca 352b542d      	mov	_CAN_BTR2,#43
1511                     ; 446 	CAN_DGR |= CDGR_3TX;	/* 3 Tx mailboxes */ 
1513  01ce 72185426      	bset	_CAN_DGR,#4
1514                     ; 448 	CAN_MCR &= ~CMCR_INRQ;				/* Leave the Init mode */
1516  01d2 72115420      	bres	_CAN_MCR,#0
1518  01d6               L746:
1519                     ; 449 	while ( (CAN_MSR & CMSR_INAK) );	/* Wait until acknowledged */ 
1521  01d6 72005421fb    	btjt	_CAN_MSR,#0,L746
1522                     ; 451 }
1525  01db 84            	pop	a
1526  01dc 87            	retf	
1528                     	switch	.bss
1529  0000               L356_period:
1530  0000 00            	ds.b	1
1565                     ; 464 void CANSend(void)
1565                     ; 465 {
1566                     	switch	.text
1567  01dd               f_CANSend:
1571                     ; 473     if((gCanNormalMsgActive == 0)&&(HazzardState != Pressed))return;
1573  01dd c600b6        	ld	a,_gCanNormalMsgActive
1574  01e0 2608          	jrne	L376
1576  01e2 c60000        	ld	a,_HazzardState
1577  01e5 a155          	cp	a,#85
1578  01e7 2701          	jreq	L376
1582  01e9 87            	retf	
1583  01ea               L376:
1584                     ; 474     if((gNMHasSleeped == 1)&&(HazzardState != Pressed))return;
1586  01ea c600b5        	ld	a,_gNMHasSleeped
1587  01ed 4a            	dec	a
1588  01ee 2608          	jrne	L576
1590  01f0 c60000        	ld	a,_HazzardState
1591  01f3 a155          	cp	a,#85
1592  01f5 2701          	jreq	L576
1596  01f7 87            	retf	
1597  01f8               L576:
1598                     ; 477 	if(period < 19)period++;
1600  01f8 c60000        	ld	a,L356_period
1601  01fb a113          	cp	a,#19
1602  01fd 2405          	jruge	L776
1605  01ff 725c0000      	inc	L356_period
1608  0203 87            	retf	
1609  0204               L776:
1610                     ; 480         period = 0;
1612  0204 725f0000      	clr	L356_period
1613                     ; 481 		CAN_Send1(BCM_PM_ID,8 ,CanSendData);
1615  0208 ae01aa        	ldw	x,#_CanSendData
1616  020b 89            	pushw	x
1617  020c 4b08          	push	#8
1618  020e ae0288        	ldw	x,#648
1619  0211 8d870287      	callf	f_CAN_Send1
1621  0215 5b03          	addw	sp,#3
1622                     ; 485 }
1625  0217 87            	retf	
1730                     ; 489 void CAN_send2(u16 ID,u8 dlc,u8 data0,u8 data1,u8 data2,u8 data3,u8 data4,u8 data5,u8 data6,u8 data7)
1730                     ; 490 {
1731                     	switch	.text
1732  0218               f_CAN_send2:
1734  0218 89            	pushw	x
1735  0219 5208          	subw	sp,#8
1736       00000008      OFST:	set	8
1739                     ; 492 	 Senddata[0]=data0;
1741  021b 7b0f          	ld	a,(OFST+7,sp)
1742  021d 6b01          	ld	(OFST-7,sp),a
1743                     ; 493 	 Senddata[1]=data1;
1745  021f 7b10          	ld	a,(OFST+8,sp)
1746  0221 6b02          	ld	(OFST-6,sp),a
1747                     ; 494 	 Senddata[2]=data2;
1749  0223 7b11          	ld	a,(OFST+9,sp)
1750  0225 6b03          	ld	(OFST-5,sp),a
1751                     ; 495 	 Senddata[3]=data3;
1753  0227 7b12          	ld	a,(OFST+10,sp)
1754  0229 6b04          	ld	(OFST-4,sp),a
1755                     ; 496 	 Senddata[4]=data4;
1757  022b 7b13          	ld	a,(OFST+11,sp)
1758  022d 6b05          	ld	(OFST-3,sp),a
1759                     ; 497 	 Senddata[5]=data5;
1761  022f 7b14          	ld	a,(OFST+12,sp)
1762  0231 6b06          	ld	(OFST-2,sp),a
1763                     ; 498 	 Senddata[6]=data6;
1765  0233 7b15          	ld	a,(OFST+13,sp)
1766  0235 6b07          	ld	(OFST-1,sp),a
1767                     ; 499 	 Senddata[7]=data7;
1769  0237 7b16          	ld	a,(OFST+14,sp)
1770  0239 6b08          	ld	(OFST+0,sp),a
1771                     ; 500      CAN_Send1(ID,dlc,Senddata);
1773  023b 96            	ldw	x,sp
1774  023c 5c            	incw	x
1775  023d 89            	pushw	x
1776  023e 7b10          	ld	a,(OFST+8,sp)
1777  0240 88            	push	a
1778  0241 1e0c          	ldw	x,(OFST+4,sp)
1779  0243 8d870287      	callf	f_CAN_Send1
1781  0247 5b0d          	addw	sp,#13
1782                     ; 501 }
1785  0249 87            	retf	
1817                     ; 504 void clearCANrx(uchar cntnumber)
1817                     ; 505 {
1818                     	switch	.text
1819  024a               f_clearCANrx:
1821  024a 88            	push	a
1822       00000000      OFST:	set	0
1825                     ; 506      Rx_Msg[cntnumber].State = 0;
1827  024b 97            	ld	xl,a
1828  024c a60e          	ld	a,#14
1829  024e 42            	mul	x,a
1830  024f 724f011e      	clr	(_Rx_Msg+13,x)
1831                     ; 507      Rx_Msg[cntnumber].dlc   = 0;	 
1833  0253 7b01          	ld	a,(OFST+1,sp)
1834  0255 97            	ld	xl,a
1835  0256 a60e          	ld	a,#14
1836  0258 42            	mul	x,a
1837  0259 724f0115      	clr	(_Rx_Msg+4,x)
1838                     ; 508      Rx_Msg[cntnumber].extid = 0;
1840  025d 905f          	clrw	y
1841  025f df0113        	ldw	(_Rx_Msg+2,x),y
1842                     ; 509 	 Rx_Msg[cntnumber].stdid = 0;
1844  0262 df0111        	ldw	(_Rx_Msg,x),y
1845                     ; 511 	 Rx_Msg[cntnumber].data[0] = 0;
1847  0265 724f0116      	clr	(_Rx_Msg+5,x)
1848                     ; 512      Rx_Msg[cntnumber].data[1] = 0;
1850  0269 724f0117      	clr	(_Rx_Msg+6,x)
1851                     ; 513 	 Rx_Msg[cntnumber].data[2] = 0;
1853  026d 724f0118      	clr	(_Rx_Msg+7,x)
1854                     ; 514 	 Rx_Msg[cntnumber].data[3] = 0;
1856  0271 724f0119      	clr	(_Rx_Msg+8,x)
1857                     ; 515 	 Rx_Msg[cntnumber].data[4] = 0;
1859  0275 724f011a      	clr	(_Rx_Msg+9,x)
1860                     ; 516 	 Rx_Msg[cntnumber].data[5] = 0;
1862  0279 724f011b      	clr	(_Rx_Msg+10,x)
1863                     ; 517 	 Rx_Msg[cntnumber].data[6] = 0;
1865  027d 724f011c      	clr	(_Rx_Msg+11,x)
1866                     ; 518 	 Rx_Msg[cntnumber].data[7] = 0;
1868  0281 724f011d      	clr	(_Rx_Msg+12,x)
1869                     ; 519 }
1872  0285 84            	pop	a
1873  0286 87            	retf	
1935                     ; 526 void CAN_Send1(u16 ID,u8 DLC ,u8 *data)
1935                     ; 527 {
1936                     	switch	.text
1937  0287               f_CAN_Send1:
1939  0287 89            	pushw	x
1940  0288 88            	push	a
1941       00000001      OFST:	set	1
1944                     ; 532     if((CommControl != 0)&&(ID < 0x700))return;
1946  0289 c60000        	ld	a,_CommControl
1947  028c 2709          	jreq	L5001
1949  028e a30700        	cpw	x,#1792
1950  0291 2404ac180318  	jrult	L5201
1953  0297               L5001:
1954                     ; 535     Tx_Msg.stdid = ID;
1956  0297 1e02          	ldw	x,(OFST+1,sp)
1957  0299 cf019d        	ldw	_Tx_Msg,x
1958                     ; 536     Tx_Msg.dlc   = DLC;
1960  029c 7b07          	ld	a,(OFST+6,sp)
1961  029e c701a1        	ld	_Tx_Msg+4,a
1962                     ; 537     for( i = 0 ; i < DLC ; i++)
1964  02a1 0f01          	clr	(OFST+0,sp)
1966  02a3 2015          	jra	L3101
1967  02a5               L7001:
1968                     ; 539         Tx_Msg.data[i] = data[i];
1970  02a5 5f            	clrw	x
1971  02a6 97            	ld	xl,a
1972  02a7 89            	pushw	x
1973  02a8 7b0a          	ld	a,(OFST+9,sp)
1974  02aa 97            	ld	xl,a
1975  02ab 7b0b          	ld	a,(OFST+10,sp)
1976  02ad 1b03          	add	a,(OFST+2,sp)
1977  02af 2401          	jrnc	L47
1978  02b1 5c            	incw	x
1979  02b2               L47:
1980  02b2 02            	rlwa	x,a
1981  02b3 f6            	ld	a,(x)
1982  02b4 85            	popw	x
1983  02b5 d701a2        	ld	(_Tx_Msg+5,x),a
1984                     ; 537     for( i = 0 ; i < DLC ; i++)
1986  02b8 0c01          	inc	(OFST+0,sp)
1987  02ba               L3101:
1990  02ba 7b01          	ld	a,(OFST+0,sp)
1991  02bc 1107          	cp	a,(OFST+6,sp)
1992  02be 25e5          	jrult	L7001
1993                     ; 543 	    Can_Tx_State = CanMsgTransmit(&Tx_Msg);
1995  02c0 ae019d        	ldw	x,#_Tx_Msg
1996  02c3 8d0e060e      	callf	f_CanMsgTransmit
1998  02c7 c70110        	ld	_Can_Tx_State,a
1999                     ; 545     	if(Can_Tx_State == KCANTXOK)
2001  02ca 4a            	dec	a
2002  02cb 261b          	jrne	L7101
2003                     ; 548 	        if((Tx_Msg.stdid > 0x3ff)&&(Tx_Msg.stdid < 0x500))
2005  02cd ce019d        	ldw	x,_Tx_Msg
2006  02d0 a30400        	cpw	x,#1024
2007  02d3 2543          	jrult	L5201
2009  02d5 ce019d        	ldw	x,_Tx_Msg
2010  02d8 a30500        	cpw	x,#1280
2011  02db 243b          	jruge	L5201
2012                     ; 550                     gNMMsgTransitFlag = 1;
2014  02dd 350100b9      	mov	_gNMMsgTransitFlag,#1
2015                     ; 551 		      if(busoffcnt)busoffcnt--;
2017  02e1 ce00bc        	ldw	x,_busoffcnt
2018  02e4 272e          	jreq	L3301
2020                     ; 552 		      cansendbusoff = 0;
2021  02e6 2028          	jpf	LC005
2022  02e8               L7101:
2023                     ; 557 	    else if(Can_Tx_State == KCANTXFAILED)
2025  02e8 c60110        	ld	a,_Can_Tx_State
2026  02eb 262b          	jrne	L5201
2027                     ; 559  			Can_Tx_State = CanMsgTransmit(&Tx_Msg);
2029  02ed ae019d        	ldw	x,#_Tx_Msg
2030  02f0 8d0e060e      	callf	f_CanMsgTransmit
2032  02f4 c70110        	ld	_Can_Tx_State,a
2033                     ; 560 			 if((Tx_Msg.stdid > 0x3ff)&&(Tx_Msg.stdid < 0x500))
2035  02f7 ce019d        	ldw	x,_Tx_Msg
2036  02fa a30400        	cpw	x,#1024
2037  02fd 2519          	jrult	L5201
2039  02ff ce019d        	ldw	x,_Tx_Msg
2040  0302 a30500        	cpw	x,#1280
2041  0305 2411          	jruge	L5201
2042                     ; 562 	                    gNMMsgTransitFlag = 1;
2044  0307 350100b9      	mov	_gNMMsgTransitFlag,#1
2045                     ; 563 			      if(busoffcnt)busoffcnt--;
2047  030b ce00bc        	ldw	x,_busoffcnt
2048  030e 2704          	jreq	L3301
2051  0310               LC005:
2053  0310 5a            	decw	x
2054  0311 cf00bc        	ldw	_busoffcnt,x
2055  0314               L3301:
2056                     ; 564 			      cansendbusoff = 0;
2059  0314 725f00bf      	clr	_cansendbusoff
2060  0318               L5201:
2061                     ; 569 }
2064  0318 5b03          	addw	sp,#3
2065  031a 87            	retf	
2067                     	switch	.bss
2068  0001               L5301_salftime:
2069  0001 0000          	ds.b	2
2121                     ; 581 void CANRX(void)
2121                     ; 582 {
2122                     	switch	.text
2123  031b               f_CANRX:
2125  031b 5203          	subw	sp,#3
2126       00000003      OFST:	set	3
2129                     ; 598     if(salftime != 0)
2131                     ; 601         if(salftime == 0)
2133                     ; 603             salfmode = 0 ;
2135                     ; 604             CAN_FORTIFY_state = 0 ;
2137                     ; 618     for(Rxcnt = 0 ; Rxcnt < 10 ; Rxcnt++ )
2139  031d 0f03          	clr	(OFST+0,sp)
2140  031f               L7701:
2141                     ; 620         Clear_WDT(); 
2143  031f 8d000000      	callf	f_Clear_WDT
2145                     ; 621         if( Rx_Msg[Rxcnt].State == 1 )
2147  0323 7b03          	ld	a,(OFST+0,sp)
2148  0325 97            	ld	xl,a
2149  0326 a60e          	ld	a,#14
2150  0328 42            	mul	x,a
2151  0329 d6011e        	ld	a,(_Rx_Msg+13,x)
2152  032c 4a            	dec	a
2153  032d 2704ac7c057c  	jrne	L5011
2154                     ; 624             if(Rx_Msg[Rxcnt].stdid > 0x400){clearCANrx(Rxcnt);return;}
2156  0333 9093          	ldw	y,x
2157  0335 90de0111      	ldw	y,(_Rx_Msg,y)
2158  0339 90a30401      	cpw	y,#1025
2159  033d 250a          	jrult	L7011
2162  033f 7b03          	ld	a,(OFST+0,sp)
2163  0341 8d4a024a      	callf	f_clearCANrx
2167  0345 ac5f055f      	jra	L031
2168  0349               L7011:
2169                     ; 626             switch(Rx_Msg[Rxcnt].stdid)
2171  0349 de0111        	ldw	x,(_Rx_Msg,x)
2173                     ; 730                 default:break;
2174  034c 1d0050        	subw	x,#80
2175  034f 2604ac0b050b  	jreq	L1501
2176  0355 1d01c8        	subw	x,#456
2177  0358 2604ac9d049d  	jreq	L7401
2178  035e 1d003d        	subw	x,#61
2179  0361 2712          	jreq	L1401
2180  0363 1d0010        	subw	x,#16
2181  0366 2748          	jreq	L3401
2182  0368 1d00d4        	subw	x,#212
2183  036b 2604ac2a042a  	jreq	L5401
2184  0371 ac6c056c      	jra	L3111
2185  0375               L1401:
2186                     ; 630 			DTC_EMS_ID1 = 125;
2188  0375 357d0000      	mov	_DTC_EMS_ID1,#125
2189                     ; 632                     if((Rx_Msg[Rxcnt].data[0] & 0xc0 )==0x40) 
2191  0379 7b03          	ld	a,(OFST+0,sp)
2192  037b 97            	ld	xl,a
2193  037c a60e          	ld	a,#14
2194  037e 42            	mul	x,a
2195  037f d60116        	ld	a,(_Rx_Msg+5,x)
2196  0382 a4c0          	and	a,#192
2197  0384 a140          	cp	a,#64
2198  0386 2608          	jrne	L5111
2199                     ; 634 				BreakPedalSignal = BrakeOK;
2201  0388 3501010c      	mov	_BreakPedalSignal,#1
2203  038c ac6c056c      	jra	L3111
2204  0390               L5111:
2205                     ; 636 			else if((Rx_Msg[Rxcnt].data[0] & 0xc0 )==0x00)
2207  0390 d60116        	ld	a,(_Rx_Msg+5,x)
2208  0393 a5c0          	bcp	a,#192
2209  0395 2608          	jrne	L1211
2210                     ; 638                            BreakPedalSignal = BrakeNO;
2212  0397 725f010c      	clr	_BreakPedalSignal
2214  039b ac6c056c      	jra	L3111
2215  039f               L1211:
2216                     ; 640 			else if((Rx_Msg[Rxcnt].data[0] & 0xc0 )==0xc0)
2218  039f d60116        	ld	a,(_Rx_Msg+5,x)
2219  03a2 a4c0          	and	a,#192
2220  03a4 a1c0          	cp	a,#192
2221  03a6 26f3          	jrne	L3111
2222                     ; 642                            BreakPedalSignal = BrakeError;
2224  03a8 3503010c      	mov	_BreakPedalSignal,#3
2225  03ac ac6c056c      	jra	L3111
2226  03b0               L3401:
2227                     ; 648 			 DTC_EMS_ID2 = 125;
2229  03b0 357d0000      	mov	_DTC_EMS_ID2,#125
2230                     ; 650 			 if((DTC_ABS_ID !=0)||(DTC_TCU_ID !=0))break;
2232  03b4 c60000        	ld	a,_DTC_ABS_ID
2233  03b7 26f3          	jrne	L3111
2235  03b9 c60000        	ld	a,_DTC_TCU_ID
2236  03bc 26ee          	jrne	L3111
2237                     ; 652                      if((Rx_Msg[Rxcnt].data[1] & 0x10 )==0)
2239  03be 7b03          	ld	a,(OFST+0,sp)
2240  03c0 97            	ld	xl,a
2241  03c1 a60e          	ld	a,#14
2242  03c3 42            	mul	x,a
2243  03c4 d60117        	ld	a,(_Rx_Msg+6,x)
2244  03c7 a510          	bcp	a,#16
2245  03c9 26e1          	jrne	L3111
2246                     ; 654       					CarSpeed[2] = 	Rx_Msg[Rxcnt].data[1]&0x0f ;
2248  03cb d60117        	ld	a,(_Rx_Msg+6,x)
2249  03ce a40f          	and	a,#15
2250  03d0 5f            	clrw	x
2251  03d1 97            	ld	xl,a
2252  03d2 cf0004        	ldw	_CarSpeed+4,x
2253                     ; 655 				       CarSpeed[2] = (CarSpeed[2]<<8)+ Rx_Msg[Rxcnt].data[2];       
2255  03d5 7b03          	ld	a,(OFST+0,sp)
2256  03d7 97            	ld	xl,a
2257  03d8 a60e          	ld	a,#14
2258  03da 42            	mul	x,a
2259  03db d60118        	ld	a,(_Rx_Msg+7,x)
2260  03de 6b02          	ld	(OFST-1,sp),a
2261  03e0 ce0004        	ldw	x,_CarSpeed+4
2262  03e3 4f            	clr	a
2263  03e4 1b02          	add	a,(OFST-1,sp)
2264  03e6 2401          	jrnc	L211
2265  03e8 5c            	incw	x
2266  03e9               L211:
2267  03e9 c70005        	ld	_CarSpeed+5,a
2268  03ec 9f            	ld	a,xl
2269  03ed c70004        	ld	_CarSpeed+4,a
2270                     ; 657 					CarSpeed[1]= (CarSpeed[2] >> 3)+(CarSpeed[2] >> 5);
2272  03f0 ce0004        	ldw	x,_CarSpeed+4
2273  03f3 54            	srlw	x
2274  03f4 54            	srlw	x
2275  03f5 54            	srlw	x
2276  03f6 54            	srlw	x
2277  03f7 54            	srlw	x
2278  03f8 1f01          	ldw	(OFST-2,sp),x
2279  03fa ce0004        	ldw	x,_CarSpeed+4
2280  03fd 54            	srlw	x
2281  03fe 54            	srlw	x
2282  03ff 54            	srlw	x
2283  0400 72fb01        	addw	x,(OFST-2,sp)
2284  0403 cf0002        	ldw	_CarSpeed+2,x
2285                     ; 659 					if(CarSpeed[2] > 350)
2287  0406 ce0004        	ldw	x,_CarSpeed+4
2288  0409 a3015f        	cpw	x,#351
2289  040c 250d          	jrult	L5311
2290                     ; 661 						if(Speedlockcnt < 20)Speedlockcnt++;
2292  040e c60000        	ld	a,_Speedlockcnt
2293  0411 a114          	cp	a,#20
2294  0413 240a          	jruge	L1411
2297  0415 725c0000      	inc	_Speedlockcnt
2298  0419 2004          	jra	L1411
2299  041b               L5311:
2300                     ; 663 					else Speedlockcnt = 0;
2302  041b 725f0000      	clr	_Speedlockcnt
2303  041f               L1411:
2304                     ; 664 					DecelerationThresholds(CarSpeed[1]);
2306  041f ce0002        	ldw	x,_CarSpeed+2
2307  0422 8d420842      	callf	f_DecelerationThresholds
2309  0426 ac6c056c      	jra	L3111
2310  042a               L5401:
2311                     ; 670 				DTC_TCU_ID =125;
2313  042a 357d0000      	mov	_DTC_TCU_ID,#125
2314                     ; 672 				if(DTC_ABS_ID !=0) break;
2316  042e c60000        	ld	a,_DTC_ABS_ID
2317  0431 26f3          	jrne	L3111
2320                     ; 674 				if((Rx_Msg[Rxcnt].data[4] & 0x80 )==0)
2322  0433 7b03          	ld	a,(OFST+0,sp)
2323  0435 97            	ld	xl,a
2324  0436 a60e          	ld	a,#14
2325  0438 42            	mul	x,a
2326  0439 d6011a        	ld	a,(_Rx_Msg+9,x)
2327  043c 2be8          	jrmi	L3111
2328                     ; 676 					CarSpeed[2] = 	Rx_Msg[Rxcnt].data[4]&0x0f ;
2330  043e d6011a        	ld	a,(_Rx_Msg+9,x)
2331  0441 a40f          	and	a,#15
2332  0443 5f            	clrw	x
2333  0444 97            	ld	xl,a
2334  0445 cf0004        	ldw	_CarSpeed+4,x
2335                     ; 677 					CarSpeed[2] = (CarSpeed[2]<<8)+ Rx_Msg[Rxcnt].data[5];     
2337  0448 7b03          	ld	a,(OFST+0,sp)
2338  044a 97            	ld	xl,a
2339  044b a60e          	ld	a,#14
2340  044d 42            	mul	x,a
2341  044e d6011b        	ld	a,(_Rx_Msg+10,x)
2342  0451 6b02          	ld	(OFST-1,sp),a
2343  0453 ce0004        	ldw	x,_CarSpeed+4
2344  0456 4f            	clr	a
2345  0457 1b02          	add	a,(OFST-1,sp)
2346  0459 2401          	jrnc	L611
2347  045b 5c            	incw	x
2348  045c               L611:
2349  045c c70005        	ld	_CarSpeed+5,a
2350  045f 9f            	ld	a,xl
2351  0460 c70004        	ld	_CarSpeed+4,a
2352                     ; 679 					CarSpeed[1]= (CarSpeed[2] >> 3)+(CarSpeed[2] >> 5);
2354  0463 ce0004        	ldw	x,_CarSpeed+4
2355  0466 54            	srlw	x
2356  0467 54            	srlw	x
2357  0468 54            	srlw	x
2358  0469 54            	srlw	x
2359  046a 54            	srlw	x
2360  046b 1f01          	ldw	(OFST-2,sp),x
2361  046d ce0004        	ldw	x,_CarSpeed+4
2362  0470 54            	srlw	x
2363  0471 54            	srlw	x
2364  0472 54            	srlw	x
2365  0473 72fb01        	addw	x,(OFST-2,sp)
2366  0476 cf0002        	ldw	_CarSpeed+2,x
2367                     ; 681 					if(CarSpeed[2] > 350)
2369  0479 ce0004        	ldw	x,_CarSpeed+4
2370  047c a3015f        	cpw	x,#351
2371  047f 250d          	jrult	L7411
2372                     ; 683 						if(Speedlockcnt < 20)Speedlockcnt++;
2374  0481 c60000        	ld	a,_Speedlockcnt
2375  0484 a114          	cp	a,#20
2376  0486 240a          	jruge	L3511
2379  0488 725c0000      	inc	_Speedlockcnt
2380  048c 2004          	jra	L3511
2381  048e               L7411:
2382                     ; 685 					else Speedlockcnt = 0;
2384  048e 725f0000      	clr	_Speedlockcnt
2385  0492               L3511:
2386                     ; 686 					DecelerationThresholds(CarSpeed[1]);
2388  0492 ce0002        	ldw	x,_CarSpeed+2
2389  0495 8d420842      	callf	f_DecelerationThresholds
2391  0499 ac6c056c      	jra	L3111
2392  049d               L7401:
2393                     ; 691 					 DTC_ABS_ID = 125;
2395  049d 357d0000      	mov	_DTC_ABS_ID,#125
2396                     ; 693 		                     if((Rx_Msg[Rxcnt].data[4] & 0x20 )==0)
2398  04a1 7b03          	ld	a,(OFST+0,sp)
2399  04a3 97            	ld	xl,a
2400  04a4 a60e          	ld	a,#14
2401  04a6 42            	mul	x,a
2402  04a7 d6011a        	ld	a,(_Rx_Msg+9,x)
2403  04aa a520          	bcp	a,#32
2404  04ac 26eb          	jrne	L3111
2405                     ; 695 						CarSpeed[2] = 	Rx_Msg[Rxcnt].data[4]&0x0f ;
2407  04ae d6011a        	ld	a,(_Rx_Msg+9,x)
2408  04b1 a40f          	and	a,#15
2409  04b3 5f            	clrw	x
2410  04b4 97            	ld	xl,a
2411  04b5 cf0004        	ldw	_CarSpeed+4,x
2412                     ; 696 						CarSpeed[2] = (CarSpeed[2]<<8)+ Rx_Msg[Rxcnt].data[5];
2414  04b8 7b03          	ld	a,(OFST+0,sp)
2415  04ba 97            	ld	xl,a
2416  04bb a60e          	ld	a,#14
2417  04bd 42            	mul	x,a
2418  04be d6011b        	ld	a,(_Rx_Msg+10,x)
2419  04c1 6b02          	ld	(OFST-1,sp),a
2420  04c3 ce0004        	ldw	x,_CarSpeed+4
2421  04c6 4f            	clr	a
2422  04c7 1b02          	add	a,(OFST-1,sp)
2423  04c9 2401          	jrnc	L221
2424  04cb 5c            	incw	x
2425  04cc               L221:
2426  04cc c70005        	ld	_CarSpeed+5,a
2427  04cf 9f            	ld	a,xl
2428  04d0 c70004        	ld	_CarSpeed+4,a
2429                     ; 698 						CarSpeed[1]= (CarSpeed[2] >> 3)+(CarSpeed[2] >> 5);
2431  04d3 ce0004        	ldw	x,_CarSpeed+4
2432  04d6 54            	srlw	x
2433  04d7 54            	srlw	x
2434  04d8 54            	srlw	x
2435  04d9 54            	srlw	x
2436  04da 54            	srlw	x
2437  04db 1f01          	ldw	(OFST-2,sp),x
2438  04dd ce0004        	ldw	x,_CarSpeed+4
2439  04e0 54            	srlw	x
2440  04e1 54            	srlw	x
2441  04e2 54            	srlw	x
2442  04e3 72fb01        	addw	x,(OFST-2,sp)
2443  04e6 cf0002        	ldw	_CarSpeed+2,x
2444                     ; 700 						if(CarSpeed[2] > 350)
2446  04e9 ce0004        	ldw	x,_CarSpeed+4
2447  04ec a3015f        	cpw	x,#351
2448  04ef 250d          	jrult	L7511
2449                     ; 702 							if(Speedlockcnt < 20)Speedlockcnt++;
2451  04f1 c60000        	ld	a,_Speedlockcnt
2452  04f4 a114          	cp	a,#20
2453  04f6 240a          	jruge	L3611
2456  04f8 725c0000      	inc	_Speedlockcnt
2457  04fc 2004          	jra	L3611
2458  04fe               L7511:
2459                     ; 704 						else Speedlockcnt = 0;
2461  04fe 725f0000      	clr	_Speedlockcnt
2462  0502               L3611:
2463                     ; 705 						DecelerationThresholds(CarSpeed[1]);
2465  0502 ce0002        	ldw	x,_CarSpeed+2
2466  0505 8d420842      	callf	f_DecelerationThresholds
2468  0509 2061          	jra	L3111
2469  050b               L1501:
2470                     ; 710 					 DTC_SRS_ID =125;
2472  050b 357d0000      	mov	_DTC_SRS_ID,#125
2473                     ; 713 					 if((((Rx_Msg[Rxcnt].data[0]>>4)^0xf)&0x0f)==(Rx_Msg[Rxcnt].data[0]&0x0f))
2475  050f 7b03          	ld	a,(OFST+0,sp)
2476  0511 97            	ld	xl,a
2477  0512 a60e          	ld	a,#14
2478  0514 42            	mul	x,a
2479  0515 d60116        	ld	a,(_Rx_Msg+5,x)
2480  0518 a40f          	and	a,#15
2481  051a 5f            	clrw	x
2482  051b 97            	ld	xl,a
2483  051c 1f01          	ldw	(OFST-2,sp),x
2484  051e 7b03          	ld	a,(OFST+0,sp)
2485  0520 97            	ld	xl,a
2486  0521 a60e          	ld	a,#14
2487  0523 42            	mul	x,a
2488  0524 d60116        	ld	a,(_Rx_Msg+5,x)
2489  0527 4e            	swap	a
2490  0528 a80f          	xor	a,#15
2491  052a a40f          	and	a,#15
2492  052c 5f            	clrw	x
2493  052d 02            	rlwa	x,a
2494  052e 1301          	cpw	x,(OFST-2,sp)
2495  0530 263a          	jrne	L3111
2496                     ; 715 					      if(((Rx_Msg[Rxcnt].data[0] & 0xf0)==0x10)||((Rx_Msg[Rxcnt].data[0] & 0xf0)==0x20)||((Rx_Msg[Rxcnt].data[0] & 0xf0)==0x40))
2498  0532 7b03          	ld	a,(OFST+0,sp)
2499  0534 97            	ld	xl,a
2500  0535 a60e          	ld	a,#14
2501  0537 42            	mul	x,a
2502  0538 d60116        	ld	a,(_Rx_Msg+5,x)
2503  053b a4f0          	and	a,#240
2504  053d a110          	cp	a,#16
2505  053f 2712          	jreq	L1711
2507  0541 d60116        	ld	a,(_Rx_Msg+5,x)
2508  0544 a4f0          	and	a,#240
2509  0546 a120          	cp	a,#32
2510  0548 2709          	jreq	L1711
2512  054a d60116        	ld	a,(_Rx_Msg+5,x)
2513  054d a4f0          	and	a,#240
2514  054f a140          	cp	a,#64
2515  0551 2615          	jrne	L7611
2516  0553               L1711:
2517                     ; 719 						    if(Rx_Msg[Rxcnt].stdid != SRS_ID)return;
2519  0553 9093          	ldw	y,x
2520  0555 90de0111      	ldw	y,(_Rx_Msg,y)
2521  0559 90a30050      	cpw	y,#80
2522  055d 2703          	jreq	L5711
2524  055f               L031:
2527  055f 5b03          	addw	sp,#3
2528  0561 87            	retf	
2529  0562               L5711:
2530                     ; 720 						    CAN_Crash = 0x55; 
2532  0562 355500c1      	mov	_CAN_Crash,#85
2534  0566 2004          	jra	L3111
2535  0568               L7611:
2536                     ; 723 					      else  CAN_Crash = 0x00; 
2538  0568 725f00c1      	clr	_CAN_Crash
2539                     ; 730                 default:break;
2541  056c               L3111:
2542                     ; 732 			clearCANrx(Rxcnt);
2544  056c 7b03          	ld	a,(OFST+0,sp)
2545  056e 8d4a024a      	callf	f_clearCANrx
2547                     ; 733 			Rx_Msg[Rxcnt].State = 0;
2549  0572 7b03          	ld	a,(OFST+0,sp)
2550  0574 97            	ld	xl,a
2551  0575 a60e          	ld	a,#14
2552  0577 42            	mul	x,a
2553  0578 724f011e      	clr	(_Rx_Msg+13,x)
2554  057c               L5011:
2555                     ; 618     for(Rxcnt = 0 ; Rxcnt < 10 ; Rxcnt++ )
2557  057c 0c03          	inc	(OFST+0,sp)
2560  057e 7b03          	ld	a,(OFST+0,sp)
2561  0580 a10a          	cp	a,#10
2562  0582 2404ac1f031f  	jrult	L7701
2563                     ; 737 }
2565  0588 20d5          	jra	L031
2610                     ; 754 void MMXG3b01(u8 mode ,u8 Rxcnt)
2610                     ; 755 {
2611                     	switch	.text
2612  058a               f_MMXG3b01:
2614  058a 89            	pushw	x
2615       00000000      OFST:	set	0
2618                     ; 765          if(IGNstate == OFF ){salfmode = 0; return;}
2620  058b c60000        	ld	a,_IGNstate
2621  058e 2605          	jrne	L7121
2624  0590 c700c3        	ld	_salfmode,a
2627  0593 2035          	jra	L631
2628  0595               L7121:
2629                     ; 766          pword1 = Rx_Msg[Rxcnt].data[3];
2631  0595 7b02          	ld	a,(OFST+2,sp)
2632  0597 97            	ld	xl,a
2633  0598 a60e          	ld	a,#14
2634  059a 42            	mul	x,a
2635  059b d60119        	ld	a,(_Rx_Msg+8,x)
2636  059e c700a9        	ld	_pword1,a
2637                     ; 767 		 pword2 = Rx_Msg[Rxcnt].data[4];
2639  05a1 d6011a        	ld	a,(_Rx_Msg+9,x)
2640  05a4 c700a8        	ld	_pword2,a
2641                     ; 768 		 pwordwriteenble = 0x55;
2643  05a7 355500a7      	mov	_pwordwriteenble,#85
2644                     ; 771          mode = 0x1;
2646  05ab a601          	ld	a,#1
2647  05ad 6b01          	ld	(OFST+1,sp),a
2648                     ; 773 		 CAN_send2(TesterBCM,8,0x02,WriteDatabyLocalld + 0x40,0xf8,0x00,0x00,0x00,0x00,0x00);
2650  05af 4b00          	push	#0
2651  05b1 4b00          	push	#0
2652  05b3 4b00          	push	#0
2653  05b5 4b00          	push	#0
2654  05b7 4b00          	push	#0
2655  05b9 4bf8          	push	#248
2656  05bb 4b7b          	push	#123
2657  05bd 4b02          	push	#2
2658  05bf 4b08          	push	#8
2659  05c1 ae0708        	ldw	x,#1800
2660  05c4 8d180218      	callf	f_CAN_send2
2662  05c8 5b09          	addw	sp,#9
2663                     ; 780  }
2664  05ca               L631:
2667  05ca 85            	popw	x
2668  05cb 87            	retf	
2692                     ; 805 void CAN_WakeUp(void)
2692                     ; 806 {
2693                     	switch	.text
2694  05cc               f_CAN_WakeUp:
2698                     ; 807 	CAN_MCR &= ~CMCR_SLEEP;		/* Leave Sleep mode */
2700  05cc 72135420      	bres	_CAN_MCR,#1
2702  05d0               L3321:
2703                     ; 808 	while(CAN_MSR & CMSR_SLAK);	/* Wait until slak bit cleared */
2705  05d0 72025421fb    	btjt	_CAN_MSR,#1,L3321
2706                     ; 809 }
2709  05d5 87            	retf	
2743                     ; 819 void CAN_EnableDiagMode(u8 CAN_Mode)
2743                     ; 820 {
2744                     	switch	.text
2745  05d6               f_CAN_EnableDiagMode:
2747  05d6 88            	push	a
2748       00000000      OFST:	set	0
2751                     ; 821 	CAN_MCR |= CMCR_INRQ;				/* Request initialisation */
2753  05d7 72105420      	bset	_CAN_MCR,#0
2755  05db               L5521:
2756                     ; 822 	while ( !(CAN_MSR & CMSR_INAK) ); 	/* Wait until acknowledged */
2758  05db 72015421fb    	btjf	_CAN_MSR,#0,L5521
2759                     ; 825 	CAN_DGR |= CAN_Mode;
2761  05e0 c65426        	ld	a,_CAN_DGR
2762  05e3 1a01          	or	a,(OFST+1,sp)
2763  05e5 c75426        	ld	_CAN_DGR,a
2764                     ; 827 	CAN_MCR &= ~CMCR_INRQ;				/* Leave the Init mode */
2766  05e8 72115420      	bres	_CAN_MCR,#0
2768  05ec               L3621:
2769                     ; 828 	while ( (CAN_MSR & CMSR_INAK) );	/* Wait until acknowledged */
2771  05ec 72005421fb    	btjt	_CAN_MSR,#0,L3621
2772                     ; 829 }
2775  05f1 84            	pop	a
2776  05f2 87            	retf	
2802                     ; 839 void CAN_DisableDiagMode (void)
2802                     ; 840 {
2803                     	switch	.text
2804  05f3               f_CAN_DisableDiagMode:
2808                     ; 841 	CAN_MCR |= CMCR_INRQ;				/* Request initialisation */
2810  05f3 72105420      	bset	_CAN_MCR,#0
2812  05f7               L1031:
2813                     ; 842 	while ( !(CAN_MSR & CMSR_INAK) ); 	/* Wait until acknowledged */
2815  05f7 72015421fb    	btjf	_CAN_MSR,#0,L1031
2816                     ; 845 	CAN_DGR &= ~(CDGR_LBKM | CDGR_SILM);
2818  05fc c65426        	ld	a,_CAN_DGR
2819  05ff a4fc          	and	a,#252
2820  0601 c75426        	ld	_CAN_DGR,a
2821                     ; 847 	CAN_MCR &= ~CMCR_INRQ;				/* Leave the Init mode */
2823  0604 72115420      	bres	_CAN_MCR,#0
2825  0608               L7031:
2826                     ; 848 	while ( (CAN_MSR & CMSR_INAK) );	/* Wait until acknowledged */
2828  0608 72005421fb    	btjt	_CAN_MSR,#0,L7031
2829                     ; 849 }
2832  060d 87            	retf	
2928                     ; 865 u8 CanMsgTransmit(tCanMsgOject *txData)
2928                     ; 866 {
2929                     	switch	.text
2930  060e               f_CanMsgTransmit:
2932  060e 89            	pushw	x
2933  060f 89            	pushw	x
2934       00000002      OFST:	set	2
2937                     ; 869 	if(busoffcnt !=0)
2939  0610 ce00bc        	ldw	x,_busoffcnt
2940  0613 270d          	jreq	L5531
2941                     ; 872 		if(CAN_TPR & CTPR_TME0)			// Mailbox 1 empty ? 
2943  0615 7205542306    	btjf	_CAN_TPR,#2,L7531
2944                     ; 874 			CAN_FPSR = CAN_TXMB0_PG;
2946  061a 725f5427      	clr	_CAN_FPSR
2947                     ; 875 			MailboxNumber = 1;
2950  061e 2024          	jra	L3631
2951  0620               L7531:
2952                     ; 877 		else return KCANTXFAILED;
2954  0620 203e          	jpf	L5731
2955  0622               L5531:
2956                     ; 881       		if(CAN_TPR & CTPR_TME0)			// Mailbox 1 empty ? 
2958  0622 7205542306    	btjf	_CAN_TPR,#2,L5631
2959                     ; 883 			CAN_FPSR = CAN_TXMB0_PG;
2961  0627 725f5427      	clr	_CAN_FPSR
2962                     ; 884 			MailboxNumber = 1;
2965  062b 2017          	jra	L3631
2966  062d               L5631:
2967                     ; 886 		else if(CAN_TPR & CTPR_TME1)	// Mailbox 2 empty ? 
2969  062d 7207542306    	btjf	_CAN_TPR,#3,L1731
2970                     ; 888 			CAN_FPSR = CAN_TXMB1_PG;
2972  0632 35015427      	mov	_CAN_FPSR,#1
2973                     ; 889 			MailboxNumber = 2;		
2976  0636 200c          	jra	L3631
2977  0638               L1731:
2978                     ; 891 		else if(CAN_TPR & CTPR_TME2)	// Mailbox 3 empty ? 
2980  0638 7209542323    	btjf	_CAN_TPR,#4,L5731
2981                     ; 893 			CAN_FPSR = CAN_TXMB2_PG;
2983  063d 35055427      	mov	_CAN_FPSR,#5
2984                     ; 894 			MailboxNumber = 3;		
2986  0641 7b01          	ld	a,(OFST-1,sp)
2987  0643 97            	ld	xl,a
2989  0644               L3631:
2990                     ; 906 	CAN_MCSR &= 0xfe;	
2992  0644 72115428      	bres	_CAN_MCSR,#0
2993                     ; 911 	CAN_MDLC = txData->dlc;
2995  0648 1e03          	ldw	x,(OFST+1,sp)
2996  064a e604          	ld	a,(4,x)
2997  064c c75429        	ld	_CAN_MDLC,a
2998                     ; 922     CAN_MIDR12 = ((txData->stdid << 2) & 0x1FFC);
3000  064f fe            	ldw	x,(x)
3001  0650 58            	sllw	x
3002  0651 58            	sllw	x
3003  0652 01            	rrwa	x,a
3004  0653 a4fc          	and	a,#252
3005  0655 01            	rrwa	x,a
3006  0656 a41f          	and	a,#31
3007  0658 01            	rrwa	x,a
3008  0659 cf542a        	ldw	_CAN_MIDR12,x
3009                     ; 928 	for(idx = 0; idx < CAN_MDLC; idx++)
3011  065c 0f02          	clr	(OFST+0,sp)
3013  065e 201a          	jra	L5041
3014  0660               L5731:
3015                     ; 898 			return (KCANTXFAILED);
3019  0660 4f            	clr	a
3021  0661               L251:
3023  0661 5b04          	addw	sp,#4
3024  0663 87            	retf	
3025  0664               L1041:
3026                     ; 930 		CAN_MDAR[idx] = txData->data[idx];
3028  0664 5f            	clrw	x
3029  0665 97            	ld	xl,a
3030  0666 89            	pushw	x
3031  0667 7b05          	ld	a,(OFST+3,sp)
3032  0669 97            	ld	xl,a
3033  066a 7b06          	ld	a,(OFST+4,sp)
3034  066c 1b04          	add	a,(OFST+2,sp)
3035  066e 2401          	jrnc	L051
3036  0670 5c            	incw	x
3037  0671               L051:
3038  0671 02            	rlwa	x,a
3039  0672 e605          	ld	a,(5,x)
3040  0674 85            	popw	x
3041  0675 d7542e        	ld	(_CAN_MDAR,x),a
3042                     ; 928 	for(idx = 0; idx < CAN_MDLC; idx++)
3044  0678 0c02          	inc	(OFST+0,sp)
3045  067a               L5041:
3048  067a 7b02          	ld	a,(OFST+0,sp)
3049  067c c15429        	cp	a,_CAN_MDLC
3050  067f 25e3          	jrult	L1041
3051                     ; 933 	 if(cansendbusoff !=0)
3053  0681 c600bf        	ld	a,_cansendbusoff
3054  0684 270c          	jreq	L1141
3055                     ; 935                if(CAN_MIDR12 != ((0x288 << 2) & 0x1FFC))  CAN_MIDR12 = 0;
3057  0686 ce542a        	ldw	x,_CAN_MIDR12
3058  0689 a30a20        	cpw	x,#2592
3059  068c 2704          	jreq	L1141
3062  068e 5f            	clrw	x
3063  068f cf542a        	ldw	_CAN_MIDR12,x
3064  0692               L1141:
3065                     ; 938         if((CAN_MIDR12 != ((0x400 << 2) & 0x1FFC))&&(CAN_MIDR12 != ((0x288 << 2) & 0x1FFC))&&(CAN_MIDR12 != ((0x708 << 2) & 0x1FFC))){CAN_MIDR12 = 0; return 0 ;}
3067  0692 ce542a        	ldw	x,_CAN_MIDR12
3068  0695 a31000        	cpw	x,#4096
3069  0698 2716          	jreq	L5141
3071  069a ce542a        	ldw	x,_CAN_MIDR12
3072  069d a30a20        	cpw	x,#2592
3073  06a0 270e          	jreq	L5141
3075  06a2 ce542a        	ldw	x,_CAN_MIDR12
3076  06a5 a31c20        	cpw	x,#7200
3077  06a8 2706          	jreq	L5141
3080  06aa 5f            	clrw	x
3081  06ab cf542a        	ldw	_CAN_MIDR12,x
3084  06ae 20b0          	jpf	L5731
3085  06b0               L5141:
3086                     ; 945 	CAN_MCSR |= MCSR_TXRQ;	/* Transmit Request */
3088  06b0 72105428      	bset	_CAN_MCSR,#0
3089                     ; 949 	return (KCANTXOK);
3091  06b4 a601          	ld	a,#1
3093  06b6 20a9          	jra	L251
3120                     ; 960 void CanCanInterruptDisable (void)
3120                     ; 961 {
3121                     	switch	.text
3122  06b8               f_CanCanInterruptDisable:
3126                     ; 962 	CanSavePg();
3128  06b8 55542701c0    	mov	_Can_Page,_CAN_FPSR
3129                     ; 964 	CAN_IER = 0x00; 
3131  06bd 725f5425      	clr	_CAN_IER
3132                     ; 965 	CAN_FPSR = CAN_CTRL_PG;         
3134  06c1 35065427      	mov	_CAN_FPSR,#6
3135                     ; 966 	CAN_EIER = 0x00;
3137  06c5 725f5429      	clr	_CAN_EIER
3138                     ; 968 	CanRestorePg();
3140  06c9 5501c05427    	mov	_CAN_FPSR,_Can_Page
3141                     ; 969 }
3144  06ce 87            	retf	
3171                     ; 979 void CanCanInterruptRestore (void)
3171                     ; 980 {
3172                     	switch	.text
3173  06cf               f_CanCanInterruptRestore:
3177                     ; 981 	CanSavePg();
3179  06cf 55542701c0    	mov	_Can_Page,_CAN_FPSR
3180                     ; 983 	CAN_IER = 	CIER_WKUIE |	/* Wake-up Interrupt */
3180                     ; 984 				//CIER_FOVIE | 	/* FIFO overrun Interrupt */
3180                     ; 985 				//CIER_FFIE  |	/* FIFO Full Interrupt */
3180                     ; 986 				CIER_FMPIE;// |	/* FIFO Message Pending Interrupt */
3182  06d4 35825425      	mov	_CAN_IER,#130
3183                     ; 989 	CAN_FPSR = CAN_CTRL_PG;
3185  06d8 35065427      	mov	_CAN_FPSR,#6
3186                     ; 990 	CAN_EIER =  CEIER_ERRIE|	/* Error Interrupt */
3186                     ; 991 	            //CEIER_LECIE|	/* Last Error Code Interrupt */
3186                     ; 992 				CEIER_BOFIE;//|	/* Bus-Off Interrupt */
3188  06dc 35845429      	mov	_CAN_EIER,#132
3189                     ; 996 	CanRestorePg();
3191  06e0 5501c05427    	mov	_CAN_FPSR,_Can_Page
3192                     ; 997 }
3195  06e5 87            	retf	
3218                     ; 1009 void DiagnosticateTactic(void)
3218                     ; 1010 { 
3219                     	switch	.text
3220  06e6               f_DiagnosticateTactic:
3224                     ; 1101 }
3227  06e6 87            	retf	
3251                     ; 1113 void CANenble(void)
3251                     ; 1114 {   
3252                     	switch	.text
3253  06e7               f_CANenble:
3257                     ; 1120         CAN_MCR &= ~CMCR_INRQ;				/* Leave the Init mode */
3259  06e7 72115420      	bres	_CAN_MCR,#0
3261  06eb               L3641:
3262                     ; 1121         while ( (CAN_MSR & CMSR_INAK) );	/* Wait until acknowledged */ 
3264  06eb 72005421fb    	btjt	_CAN_MSR,#0,L3641
3265                     ; 1122         CAN_EN_OFF;   // }
3267  06f0 721e500a      	bset	20490,#7
3268                     ; 1129 }
3271  06f4 87            	retf	
3293                     ; 1141 void ClearDTC(void)
3293                     ; 1142 {/*
3294                     	switch	.text
3295  06f5               f_ClearDTC:
3299                     ; 1151 }
3302  06f5 87            	retf	
3333                     ; 1163 void WriteDTC(u16 DTCvalue)
3333                     ; 1164 {/*
3334                     	switch	.text
3335  06f6               f_WriteDTC:
3339                     ; 1205 }
3342  06f6 87            	retf	
3364                     ; 1218 void SendDTC(void)
3364                     ; 1219 {/*
3365                     	switch	.text
3366  06f7               f_SendDTC:
3370                     ; 1303 }
3373  06f7 87            	retf	
3421                     ; 1306 void writeHazardecestate(u8 number)
3421                     ; 1307 {
3422                     	switch	.text
3423  06f8               f_writeHazardecestate:
3425  06f8 88            	push	a
3426  06f9 5205          	subw	sp,#5
3427       00000005      OFST:	set	5
3430                     ; 1310     for( witecnt = 0; witecnt < EECNT ; witecnt++ )
3432  06fb 0f05          	clr	(OFST+0,sp)
3433  06fd               L3451:
3434                     ; 1312         temp = (u32)(&Hazardecestate);
3436  06fd ae40a1        	ldw	x,#_Hazardecestate
3437  0700 8d000000      	callf	d_uitolx
3439  0704 96            	ldw	x,sp
3440  0705 5c            	incw	x
3441  0706 8d000000      	callf	d_rtol
3443                     ; 1314         FLASH_ProgramByte(temp, number);
3445  070a 7b06          	ld	a,(OFST+1,sp)
3446  070c 88            	push	a
3447  070d 1e04          	ldw	x,(OFST-1,sp)
3448  070f 89            	pushw	x
3449  0710 1e04          	ldw	x,(OFST-1,sp)
3450  0712 89            	pushw	x
3451  0713 8d000000      	callf	f_FLASH_ProgramByte
3453  0717 5b05          	addw	sp,#5
3454                     ; 1317         if(number == Hazardecestate)
3456  0719 7b06          	ld	a,(OFST+1,sp)
3457  071b c140a1        	cp	a,_Hazardecestate
3458  071e 2708          	jreq	L7451
3459                     ; 1319             break;
3461                     ; 1310     for( witecnt = 0; witecnt < EECNT ; witecnt++ )
3463  0720 0c05          	inc	(OFST+0,sp)
3466  0722 7b05          	ld	a,(OFST+0,sp)
3467  0724 a10a          	cp	a,#10
3468  0726 25d5          	jrult	L3451
3469  0728               L7451:
3470                     ; 1322 }
3473  0728 5b06          	addw	sp,#6
3474  072a 87            	retf	
3521                     ; 1323 void writeRearfogbutton(u8 number)
3521                     ; 1324 {
3522                     	switch	.text
3523  072b               f_writeRearfogbutton:
3525  072b 88            	push	a
3526  072c 5205          	subw	sp,#5
3527       00000005      OFST:	set	5
3530                     ; 1327     for( witecnt = 0; witecnt < EECNT ; witecnt++ )
3532  072e 0f05          	clr	(OFST+0,sp)
3533  0730               L3751:
3534                     ; 1329         temp = (u32)(&Rearfogbutton);
3536  0730 ae40a2        	ldw	x,#_Rearfogbutton
3537  0733 8d000000      	callf	d_uitolx
3539  0737 96            	ldw	x,sp
3540  0738 5c            	incw	x
3541  0739 8d000000      	callf	d_rtol
3543                     ; 1331         FLASH_ProgramByte(temp, number);
3545  073d 7b06          	ld	a,(OFST+1,sp)
3546  073f 88            	push	a
3547  0740 1e04          	ldw	x,(OFST-1,sp)
3548  0742 89            	pushw	x
3549  0743 1e04          	ldw	x,(OFST-1,sp)
3550  0745 89            	pushw	x
3551  0746 8d000000      	callf	f_FLASH_ProgramByte
3553  074a 5b05          	addw	sp,#5
3554                     ; 1334         if(number == Rearfogbutton)
3556  074c 7b06          	ld	a,(OFST+1,sp)
3557  074e c140a2        	cp	a,_Rearfogbutton
3558  0751 2708          	jreq	L7751
3559                     ; 1336             break;
3561                     ; 1327     for( witecnt = 0; witecnt < EECNT ; witecnt++ )
3563  0753 0c05          	inc	(OFST+0,sp)
3566  0755 7b05          	ld	a,(OFST+0,sp)
3567  0757 a10a          	cp	a,#10
3568  0759 25d5          	jrult	L3751
3569  075b               L7751:
3570                     ; 1339 }
3573  075b 5b06          	addw	sp,#6
3574  075d 87            	retf	
3612                     ; 1354 uint DeceSettingValue(uchar seting)
3612                     ; 1355 {
3613                     	switch	.text
3614  075e               f_DeceSettingValue:
3616  075e 89            	pushw	x
3617       00000002      OFST:	set	2
3620                     ; 1358     switch(seting)
3623                     ; 1408         default : break;
3624  075f a110          	cp	a,#16
3625  0761 2476          	jruge	L5661
3626  0763 8d000000      	callf	d_jctab
3628  0767               L602:
3629  0767 0022          	dc.w	L3061-L602
3630  0769 0027          	dc.w	L5061-L602
3631  076b 002c          	dc.w	L7061-L602
3632  076d 0031          	dc.w	L1161-L602
3633  076f 0036          	dc.w	L3161-L602
3634  0771 003b          	dc.w	L5161-L602
3635  0773 0040          	dc.w	L7161-L602
3636  0775 0045          	dc.w	L1261-L602
3637  0777 004a          	dc.w	L3261-L602
3638  0779 004f          	dc.w	L5261-L602
3639  077b 0054          	dc.w	L7261-L602
3640  077d 0059          	dc.w	L1361-L602
3641  077f 005e          	dc.w	L3361-L602
3642  0781 0063          	dc.w	L5361-L602
3643  0783 0068          	dc.w	L7361-L602
3644  0785 006d          	dc.w	L1461-L602
3645  0787 2050          	jra	L5661
3646  0789               L3061:
3647                     ; 1360         case 0:  
3647                     ; 1361         	 value = 1 ;
3649  0789 ae0001        	ldw	x,#1
3650                     ; 1362         	 break;
3652  078c 2049          	jpf	LC007
3653  078e               L5061:
3654                     ; 1363         case 1:
3654                     ; 1364         	 value = 2 ;
3656  078e ae0002        	ldw	x,#2
3657                     ; 1365         	 break;
3659  0791 2044          	jpf	LC007
3660  0793               L7061:
3661                     ; 1366         case 2:
3661                     ; 1367              value = 5 ;
3663  0793 ae0005        	ldw	x,#5
3664                     ; 1368         	 break;
3666  0796 203f          	jpf	LC007
3667  0798               L1161:
3668                     ; 1369         case 3:
3668                     ; 1370              value = 10 ;
3670  0798 ae000a        	ldw	x,#10
3671                     ; 1371         	 break;
3673  079b 203a          	jpf	LC007
3674  079d               L3161:
3675                     ; 1372         case 4:
3675                     ; 1373         	 value = 13 ;
3677  079d ae000d        	ldw	x,#13
3678                     ; 1374         	 break;
3680  07a0 2035          	jpf	LC007
3681  07a2               L5161:
3682                     ; 1375         case 5:
3682                     ; 1376         	 value = 15 ;
3684  07a2 ae000f        	ldw	x,#15
3685                     ; 1377         	 break;
3687  07a5 2030          	jpf	LC007
3688  07a7               L7161:
3689                     ; 1378         case 6:
3689                     ; 1379         	 value = 16 ;
3691  07a7 ae0010        	ldw	x,#16
3692                     ; 1380         	 break;
3694  07aa 202b          	jpf	LC007
3695  07ac               L1261:
3696                     ; 1381         case 7:
3696                     ; 1382         	 value = 17 ;
3698  07ac ae0011        	ldw	x,#17
3699                     ; 1383         	 break;
3701  07af 2026          	jpf	LC007
3702  07b1               L3261:
3703                     ; 1384         case 8:
3703                     ; 1385         	 value = 18 ;
3705  07b1 ae0012        	ldw	x,#18
3706                     ; 1386         	 break;
3708  07b4 2021          	jpf	LC007
3709  07b6               L5261:
3710                     ; 1387         case 9:
3710                     ; 1388         	 value = 19 ;
3712  07b6 ae0013        	ldw	x,#19
3713                     ; 1389         	 break;
3715  07b9 201c          	jpf	LC007
3716  07bb               L7261:
3717                     ; 1390         case 10:
3717                     ; 1391         	 value = 20 ;
3719  07bb ae0014        	ldw	x,#20
3720                     ; 1392         	 break;
3722  07be 2017          	jpf	LC007
3723  07c0               L1361:
3724                     ; 1393         case 11:
3724                     ; 1394         	 value = 22 ;
3726  07c0 ae0016        	ldw	x,#22
3727                     ; 1395         	 break;
3729  07c3 2012          	jpf	LC007
3730  07c5               L3361:
3731                     ; 1396         case 12:
3731                     ; 1397         	 value = 23 ;
3733  07c5 ae0017        	ldw	x,#23
3734                     ; 1398         	 break;
3736  07c8 200d          	jpf	LC007
3737  07ca               L5361:
3738                     ; 1399         case 13:
3738                     ; 1400         	 value = 24 ;
3740  07ca ae0018        	ldw	x,#24
3741                     ; 1401         	 break;
3743  07cd 2008          	jpf	LC007
3744  07cf               L7361:
3745                     ; 1402         case 14:
3745                     ; 1403         	 value = 25 ;
3747  07cf ae0019        	ldw	x,#25
3748                     ; 1404         	 break;
3750  07d2 2003          	jpf	LC007
3751  07d4               L1461:
3752                     ; 1405         case 15:
3752                     ; 1406         	 value = 26 ;
3754  07d4 ae001a        	ldw	x,#26
3755  07d7               LC007:
3756  07d7 1f01          	ldw	(OFST-1,sp),x
3757                     ; 1407         	 break;
3759                     ; 1408         default : break;
3761  07d9               L5661:
3762                     ; 1411     return value;
3764  07d9 1e01          	ldw	x,(OFST-1,sp)
3767  07db 5b02          	addw	sp,#2
3768  07dd 87            	retf	
3770                     	switch	.bss
3771  0003               L7661_SPeedvalueCNT:
3772  0003 00            	ds.b	1
3773  0004               L1761_SpeedValue:
3774  0004 000000000000  	ds.b	100
3842                     ; 1425 uint DeceCount(uint speed)           
3842                     ; 1426 {
3843                     	switch	.text
3844  07de               f_DeceCount:
3846  07de 89            	pushw	x
3847  07df 5208          	subw	sp,#8
3848       00000008      OFST:	set	8
3851                     ; 1432      if(speed != 0)
3853  07e1 5d            	tnzw	x
3854  07e2 2711          	jreq	L3271
3855                     ; 1434          SpeedValueMS = (speed >> 3)+(speed >> 5);//系数:0.15625=1/8+1/32//千米/小时---米/秒
3857  07e4 54            	srlw	x
3858  07e5 54            	srlw	x
3859  07e6 54            	srlw	x
3860  07e7 54            	srlw	x
3861  07e8 54            	srlw	x
3862  07e9 1f01          	ldw	(OFST-7,sp),x
3863  07eb 1e09          	ldw	x,(OFST+1,sp)
3864  07ed 54            	srlw	x
3865  07ee 54            	srlw	x
3866  07ef 54            	srlw	x
3867  07f0 72fb01        	addw	x,(OFST-7,sp)
3869  07f3 2001          	jra	L5271
3870  07f5               L3271:
3871                     ; 1438          SpeedValueMS = 0 ;
3873  07f5 5f            	clrw	x
3874  07f6               L5271:
3875  07f6 1f07          	ldw	(OFST-1,sp),x
3876                     ; 1440      if( SPeedvalueCNT == 49) SPeedvalueCNT = 0;
3878  07f8 c60003        	ld	a,L7661_SPeedvalueCNT
3879  07fb a131          	cp	a,#49
3880  07fd 2606          	jrne	L7271
3883  07ff 725f0003      	clr	L7661_SPeedvalueCNT
3885  0803 2004          	jra	L1371
3886  0805               L7271:
3887                     ; 1441      else  SPeedvalueCNT++;
3889  0805 725c0003      	inc	L7661_SPeedvalueCNT
3890  0809               L1371:
3891                     ; 1442      Speedoldvalue = SpeedValue[SPeedvalueCNT];
3893  0809 c60003        	ld	a,L7661_SPeedvalueCNT
3894  080c 5f            	clrw	x
3895  080d 97            	ld	xl,a
3896  080e 58            	sllw	x
3897  080f de0004        	ldw	x,(L1761_SpeedValue,x)
3898  0812 1f05          	ldw	(OFST-3,sp),x
3899                     ; 1443      SpeedValue[SPeedvalueCNT] = SpeedValueMS;
3901  0814 5f            	clrw	x
3902  0815 97            	ld	xl,a
3903  0816 58            	sllw	x
3904  0817 1607          	ldw	y,(OFST-1,sp)
3905  0819 df0004        	ldw	(L1761_SpeedValue,x),y
3906                     ; 1444      if(SpeedValueMS <  Speedoldvalue)
3908  081c 1e07          	ldw	x,(OFST-1,sp)
3909  081e 1305          	cpw	x,(OFST-3,sp)
3910  0820 2407          	jruge	L3371
3911                     ; 1446            	DeceSpeed =  Speedoldvalue - SpeedValueMS; //计算1秒内速度减小量
3913  0822 1e05          	ldw	x,(OFST-3,sp)
3914  0824 72f007        	subw	x,(OFST-1,sp)
3915  0827 1f03          	ldw	(OFST-5,sp),x
3916  0829               L3371:
3917                     ; 1448      if(Speedoldvalue == SpeedValueMS)
3919  0829 1e05          	ldw	x,(OFST-3,sp)
3920  082b 1307          	cpw	x,(OFST-1,sp)
3921  082d 2603          	jrne	L5371
3922                     ; 1450               DeceSpeed =0;
3924  082f 5f            	clrw	x
3926  0830 2009          	jpf	LC008
3927  0832               L5371:
3928                     ; 1452      else if(SpeedValueMS >  Speedoldvalue) 
3930  0832 1e07          	ldw	x,(OFST-1,sp)
3931  0834 1305          	cpw	x,(OFST-3,sp)
3932  0836 2305          	jrule	L7371
3933                     ; 1454              DeceSpeed = 0xffff;
3935  0838 aeffff        	ldw	x,#65535
3936  083b               LC008:
3937  083b 1f03          	ldw	(OFST-5,sp),x
3938  083d               L7371:
3939                     ; 1456 	 return DeceSpeed;
3941  083d 1e03          	ldw	x,(OFST-5,sp)
3944  083f 5b0a          	addw	sp,#10
3945  0841 87            	retf	
3947                     	switch	.data
3948  0005               L7471_rxcnt:
3949  0005 00            	dc.b	0
3999                     ; 1471 void DecelerationThresholds(uint VehicleSpeed)
3999                     ; 1472 {
4000                     	switch	.text
4001  0842               f_DecelerationThresholds:
4003  0842 89            	pushw	x
4004  0843 89            	pushw	x
4005       00000002      OFST:	set	2
4008                     ; 1478     Dececountvalue =   DeceCount(VehicleSpeed);
4010  0844 8dde07de      	callf	f_DeceCount
4012  0848 1f01          	ldw	(OFST-1,sp),x
4013                     ; 1482     if( VehicleSpeed < Speed96)
4015  084a 1e03          	ldw	x,(OFST+1,sp)
4016  084c a300cf        	cpw	x,#207
4017  084f 2531          	jrult	L3771
4019                     ; 1487     else if(( VehicleSpeed >= Speed96) &&( BreakPedalSignal == BrakeOK ))
4022  0851 c6010c        	ld	a,_BreakPedalSignal
4023  0854 a101          	cp	a,#1
4024  0856 2610          	jrne	L5771
4025                     ; 1489         if(( Dececountvalue >= DeceSettingValueL )&&(Dececountvalue != 0xffff))   
4027  0858 1e01          	ldw	x,(OFST-1,sp)
4028  085a c300c6        	cpw	x,_DeceSettingValueL
4029  085d 2523          	jrult	L3771
4031  085f 5c            	incw	x
4032  0860 2720          	jreq	L3771
4033                     ; 1492               BrakeSpeedHazards_state = 1;
4035  0862 35010000      	mov	_BrakeSpeedHazards_state,#1
4036                     ; 1493 			  rxcnt = 0;
4037  0866 2016          	jpf	LC009
4038  0868               L5771:
4039                     ; 1496     else if(( VehicleSpeed > Speed96)&& ( BreakPedalSignal == BrakeOK ))
4041  0868 a300d0        	cpw	x,#208
4042  086b 2515          	jrult	L3771
4044  086d 4a            	dec	a
4045  086e 2612          	jrne	L3771
4046                     ; 1498         if( (Dececountvalue >= DeceSettingValueH )&&(Dececountvalue != 0xffff))   
4048  0870 1e01          	ldw	x,(OFST-1,sp)
4049  0872 c300c8        	cpw	x,_DeceSettingValueH
4050  0875 250b          	jrult	L3771
4052  0877 5c            	incw	x
4053  0878 2708          	jreq	L3771
4054                     ; 1501              BrakeSpeedHazards_state = 1;\
4056  087a 4c            	inc	a
4057  087b c70000        	ld	_BrakeSpeedHazards_state,a
4058                     ; 1502              rxcnt = 0;
4060  087e               LC009:
4062  087e 725f0005      	clr	L7471_rxcnt
4063  0882               L3771:
4064                     ; 1506     if(((BrakeSpeedHazards_state == 1)&&(Dececountvalue == 0xffff)&&(BreakPedalSignal == BrakeNO))||(VehicleSpeed < 125))
4066  0882 c60000        	ld	a,_BrakeSpeedHazards_state
4067  0885 4a            	dec	a
4068  0886 260a          	jrne	L3102
4070  0888 1e01          	ldw	x,(OFST-1,sp)
4071  088a 5c            	incw	x
4072  088b 2605          	jrne	L3102
4074  088d c6010c        	ld	a,_BreakPedalSignal
4075  0890 2707          	jreq	L1102
4076  0892               L3102:
4078  0892 1e03          	ldw	x,(OFST+1,sp)
4079  0894 a3007d        	cpw	x,#125
4080  0897 2411          	jruge	L7002
4081  0899               L1102:
4082                     ; 1508          if(rxcnt < 2)rxcnt++;
4084  0899 c60005        	ld	a,L7471_rxcnt
4085  089c a102          	cp	a,#2
4086  089e 2406          	jruge	L7102
4089  08a0 725c0005      	inc	L7471_rxcnt
4091  08a4 2004          	jra	L7002
4092  08a6               L7102:
4093                     ; 1511              BrakeSpeedHazards_state = 0;
4095  08a6 725f0000      	clr	_BrakeSpeedHazards_state
4096  08aa               L7002:
4097                     ; 1516 }
4100  08aa 5b04          	addw	sp,#4
4101  08ac 87            	retf	
4172                     ; 1528 void DecelerationSetting(uchar SettingValue)
4172                     ; 1529 {
4173                     	switch	.text
4174  08ad               f_DecelerationSetting:
4176  08ad 88            	push	a
4177  08ae 520a          	subw	sp,#10
4178       0000000a      OFST:	set	10
4181                     ; 1536     if(( DeceSettingValueH == 0 ) || ( DeceSettingValueL == 0 ))
4183  08b0 ce00c8        	ldw	x,_DeceSettingValueH
4184  08b3 2705          	jreq	L3502
4186  08b5 ce00c6        	ldw	x,_DeceSettingValueL
4187  08b8 2616          	jrne	L1502
4188  08ba               L3502:
4189                     ; 1538         if( DeceSettingValueH == 0 )
4191  08ba ce00c8        	ldw	x,_DeceSettingValueH
4192  08bd 2608          	jrne	L5502
4193                     ; 1540               DeceSetValueH = DeceSettingValue(9) ;  //查询基准值
4195  08bf a609          	ld	a,#9
4196  08c1 8d5e075e      	callf	f_DeceSettingValue
4198  08c5 1f02          	ldw	(OFST-8,sp),x
4199  08c7               L5502:
4200                     ; 1542         if( DeceSettingValueL == 0 )
4202  08c7 ce00c6        	ldw	x,_DeceSettingValueL
4203  08ca 2619          	jrne	L1602
4204                     ; 1544              DeceSetValueL = DeceSettingValue(8) ;
4206  08cc a608          	ld	a,#8
4208  08ce 200f          	jpf	LC010
4209  08d0               L1502:
4210                     ; 1549 		    DeceSetValueH = DeceSettingValue((SettingValue & 0xf0 )>>4 );  //查询基准值
4212  08d0 7b0b          	ld	a,(OFST+1,sp)
4213  08d2 4e            	swap	a
4214  08d3 a40f          	and	a,#15
4215  08d5 8d5e075e      	callf	f_DeceSettingValue
4217  08d9 1f02          	ldw	(OFST-8,sp),x
4218                     ; 1551         DeceSetValueL =  DeceSettingValue(SettingValue & 0x0f); 
4220  08db 7b0b          	ld	a,(OFST+1,sp)
4221  08dd a40f          	and	a,#15
4223  08df               LC010:
4224  08df 8d5e075e      	callf	f_DeceSettingValue
4225  08e3 1f04          	ldw	(OFST-6,sp),x
4226  08e5               L1602:
4227                     ; 1554 	for( i = 0 ; i < EECNT ; i++)
4229  08e5 0f01          	clr	(OFST-9,sp)
4230  08e7               L3602:
4231                     ; 1556              temp = (u32)(&DeceSettingValueH);
4233  08e7 ae00c8        	ldw	x,#_DeceSettingValueH
4234  08ea 8d000000      	callf	d_uitolx
4236  08ee 96            	ldw	x,sp
4237  08ef 1c0007        	addw	x,#OFST-3
4238  08f2 8d000000      	callf	d_rtol
4240                     ; 1557              res = (u8)(DeceSetValueH >> 8);
4242  08f6 7b02          	ld	a,(OFST-8,sp)
4243  08f8 6b06          	ld	(OFST-4,sp),a
4244                     ; 1558              FLASH_ProgramByte(temp, res);
4246  08fa 88            	push	a
4247  08fb 1e0a          	ldw	x,(OFST+0,sp)
4248  08fd 89            	pushw	x
4249  08fe 1e0a          	ldw	x,(OFST+0,sp)
4250  0900 89            	pushw	x
4251  0901 8d000000      	callf	f_FLASH_ProgramByte
4253  0905 5b05          	addw	sp,#5
4254                     ; 1559              temp++;
4256  0907 96            	ldw	x,sp
4257  0908 1c0007        	addw	x,#OFST-3
4258  090b a601          	ld	a,#1
4259  090d 8d000000      	callf	d_lgadc
4261                     ; 1560              res = (u8)(DeceSetValueH);
4263  0911 7b03          	ld	a,(OFST-7,sp)
4264  0913 6b06          	ld	(OFST-4,sp),a
4265                     ; 1561              FLASH_ProgramByte(temp, res);
4267  0915 88            	push	a
4268  0916 1e0a          	ldw	x,(OFST+0,sp)
4269  0918 89            	pushw	x
4270  0919 1e0a          	ldw	x,(OFST+0,sp)
4271  091b 89            	pushw	x
4272  091c 8d000000      	callf	f_FLASH_ProgramByte
4274  0920 5b05          	addw	sp,#5
4275                     ; 1563              temp = (u32)(&DeceSettingValueL);
4277  0922 ae00c6        	ldw	x,#_DeceSettingValueL
4278  0925 8d000000      	callf	d_uitolx
4280  0929 96            	ldw	x,sp
4281  092a 1c0007        	addw	x,#OFST-3
4282  092d 8d000000      	callf	d_rtol
4284                     ; 1564              res = (u8)(DeceSetValueL >> 8);
4286  0931 7b04          	ld	a,(OFST-6,sp)
4287  0933 6b06          	ld	(OFST-4,sp),a
4288                     ; 1565              FLASH_ProgramByte(temp, res);
4290  0935 88            	push	a
4291  0936 1e0a          	ldw	x,(OFST+0,sp)
4292  0938 89            	pushw	x
4293  0939 1e0a          	ldw	x,(OFST+0,sp)
4294  093b 89            	pushw	x
4295  093c 8d000000      	callf	f_FLASH_ProgramByte
4297  0940 5b05          	addw	sp,#5
4298                     ; 1566              temp++;
4300  0942 96            	ldw	x,sp
4301  0943 1c0007        	addw	x,#OFST-3
4302  0946 a601          	ld	a,#1
4303  0948 8d000000      	callf	d_lgadc
4305                     ; 1567              res = (u8)(DeceSetValueL);
4307  094c 7b05          	ld	a,(OFST-5,sp)
4308  094e 6b06          	ld	(OFST-4,sp),a
4309                     ; 1568              FLASH_ProgramByte(temp, res);
4311  0950 88            	push	a
4312  0951 1e0a          	ldw	x,(OFST+0,sp)
4313  0953 89            	pushw	x
4314  0954 1e0a          	ldw	x,(OFST+0,sp)
4315  0956 89            	pushw	x
4316  0957 8d000000      	callf	f_FLASH_ProgramByte
4318  095b 5b05          	addw	sp,#5
4319                     ; 1570             if(( DeceSettingValueH == DeceSetValueH ) && ( DeceSettingValueL == DeceSetValueL ))
4321  095d ce00c8        	ldw	x,_DeceSettingValueH
4322  0960 1302          	cpw	x,(OFST-8,sp)
4323  0962 2607          	jrne	L1702
4325  0964 ce00c6        	ldw	x,_DeceSettingValueL
4326  0967 1304          	cpw	x,(OFST-6,sp)
4327  0969 270c          	jreq	L7602
4328                     ; 1572                   break;
4330  096b               L1702:
4331                     ; 1554 	for( i = 0 ; i < EECNT ; i++)
4333  096b 0c01          	inc	(OFST-9,sp)
4336  096d 7b01          	ld	a,(OFST-9,sp)
4337  096f a10a          	cp	a,#10
4338  0971 2404ace708e7  	jrult	L3602
4339  0977               L7602:
4340                     ; 1575 }
4343  0977 5b0b          	addw	sp,#11
4344  0979 87            	retf	
5253                     	xdef	f_clearCANrx
5254                     	switch	.bss
5255  0068               _NM_CAN_DATA:
5256  0068 000000000000  	ds.b	55
5257                     	xdef	_NM_CAN_DATA
5258  009f               _CANBusOFFcnt:
5259  009f 00            	ds.b	1
5260                     	xdef	_CANBusOFFcnt
5261  00a0               _CANBusOFF:
5262  00a0 00            	ds.b	1
5263                     	xdef	_CANBusOFF
5264  00a1               _CANBusoffcnt:
5265  00a1 00            	ds.b	1
5266                     	xdef	_CANBusoffcnt
5267  00a2               _CANsetstate:
5268  00a2 00            	ds.b	1
5269                     	xdef	_CANsetstate
5270                     	xdef	_DTCsendmode
5271  00a3               _TCUEMSdtccnt2:
5272  00a3 00            	ds.b	1
5273                     	xdef	_TCUEMSdtccnt2
5274  00a4               _TCUEMSdtccnt1:
5275  00a4 00            	ds.b	1
5276                     	xdef	_TCUEMSdtccnt1
5277  00a5               _TransmissionFailureStatus:
5278  00a5 00            	ds.b	1
5279                     	xdef	_TransmissionFailureStatus
5280  00a6               _sendonse:
5281  00a6 00            	ds.b	1
5282                     	xdef	_sendonse
5283  00a7               _pwordwriteenble:
5284  00a7 00            	ds.b	1
5285                     	xdef	_pwordwriteenble
5286  00a8               _pword2:
5287  00a8 00            	ds.b	1
5288                     	xdef	_pword2
5289  00a9               _pword1:
5290  00a9 00            	ds.b	1
5291                     	xdef	_pword1
5292  00aa               _DTCRetcodestate:
5293  00aa 00            	ds.b	1
5294                     	xdef	_DTCRetcodestate
5295                     	xref	f_Clear_WDT
5296                     	xref	_CommControl
5297                     	xref	_DTC_EMS_ID2
5298                     	xref	_DTC_EMS_ID1
5299                     	xref	_DTC_TCU_ID
5300                     	xref	_DTC_ABS_ID
5301                     	xref	_DTC_SRS_ID
5302                     	xref	f_WakeUp
5303                     	xref	_CarSpeed
5304                     	xref	_IGNstate
5305                     	xref	_Speedlockcnt
5306                     	xref	_BrakeSpeedHazards_state
5307                     	xref	_HazzardState
5308                     	xdef	f_CanSendMsg
5309                     	xdef	f_CANHardwave_Init
5310                     	xdef	f_NM_RecMsgSave
5311  00ab               _gNMCANBatFlag:
5312  00ab 00            	ds.b	1
5313                     	xdef	_gNMCANBatFlag
5314  00ac               _gDectID_IP_270_Flag:
5315  00ac 00            	ds.b	1
5316                     	xdef	_gDectID_IP_270_Flag
5317  00ad               _gNodeMiss_IP_270:
5318  00ad 00            	ds.b	1
5319                     	xdef	_gNodeMiss_IP_270
5320  00ae               _gDectID_EMS_255_Flag:
5321  00ae 00            	ds.b	1
5322                     	xdef	_gDectID_EMS_255_Flag
5323  00af               _gNodeMiss_EMS_255:
5324  00af 00            	ds.b	1
5325                     	xdef	_gNodeMiss_EMS_255
5326  00b0               _gNetWorkStatus:
5327  00b0 00000000      	ds.b	4
5328                     	xdef	_gNetWorkStatus
5329  00b4               _gNMCanBusOff:
5330  00b4 00            	ds.b	1
5331                     	xdef	_gNMCanBusOff
5332  00b5               _gNMHasSleeped:
5333  00b5 00            	ds.b	1
5334                     	xdef	_gNMHasSleeped
5335  00b6               _gCanNormalMsgActive:
5336  00b6 00            	ds.b	1
5337                     	xdef	_gCanNormalMsgActive
5338  00b7               _gRemoteWakeupFlag:
5339  00b7 00            	ds.b	1
5340                     	xdef	_gRemoteWakeupFlag
5341  00b8               _gLocalWakeupFlag:
5342  00b8 00            	ds.b	1
5343                     	xdef	_gLocalWakeupFlag
5344  00b9               _gNMMsgTransitFlag:
5345  00b9 00            	ds.b	1
5346                     	xdef	_gNMMsgTransitFlag
5347  00ba               _gTimeOskeBase:
5348  00ba 0000          	ds.b	2
5349                     	xdef	_gTimeOskeBase
5350                     	xref	f_FLASH_ProgramByte
5351                     	xdef	_busofftimecnt
5352  00bc               _busoffcnt:
5353  00bc 0000          	ds.b	2
5354                     	xdef	_busoffcnt
5355  00be               _Busoffstate:
5356  00be 00            	ds.b	1
5357                     	xdef	_Busoffstate
5358                     	xdef	_RXREcnt
5359                     	xdef	_RXITcnt
5360                     	xdef	f_BUSoff
5361                     	xdef	f_DecelerationSetting
5362                     	xdef	f_DecelerationThresholds
5363                     	xdef	f_DeceCount
5364                     	xdef	f_DeceSettingValue
5365  00bf               _cansendbusoff:
5366  00bf 00            	ds.b	1
5367                     	xdef	_cansendbusoff
5368  00c0               _cansendstate:
5369  00c0 00            	ds.b	1
5370                     	xdef	_cansendstate
5371                     	xdef	f_writeRearfogbutton
5372                     	xdef	f_writeHazardecestate
5373                     	xdef	f_MMXG3b01
5374                     	xdef	f_SendDTC
5375                     	xdef	f_WriteDTC
5376                     	xdef	f_ClearDTC
5377                     	xdef	f_CANenble
5378                     	xdef	f_DiagnosticateTactic
5379                     	xdef	f_CAN_send2
5380                     	xdef	f_CAN_Send1
5381                     	xdef	f_CANRX
5382                     	xdef	f_CANSend
5383                     	xdef	f_CanCanInterruptRestore
5384                     	xdef	f_CanCanInterruptDisable
5385                     	xdef	f_CanMsgTransmit
5386                     	xdef	f_CAN_DisableDiagMode
5387                     	xdef	f_CAN_EnableDiagMode
5388                     	xdef	f_CAN_WakeUp
5389                     	xdef	f_CAN_Init
5390  00c1               _CAN_Crash:
5391  00c1 00            	ds.b	1
5392                     	xdef	_CAN_Crash
5393  00c2               _CAN_Auto_state:
5394  00c2 00            	ds.b	1
5395                     	xdef	_CAN_Auto_state
5396  00c3               _salfmode:
5397  00c3 00            	ds.b	1
5398                     	xdef	_salfmode
5399  00c4               _WiperINTDiag:
5400  00c4 00            	ds.b	1
5401                     	xdef	_WiperINTDiag
5402  00c5               _Speedlock_ls:
5403  00c5 00            	ds.b	1
5404                     	xdef	_Speedlock_ls
5405  00c6               _DeceSettingValueL:
5406  00c6 0000          	ds.b	2
5407                     	xdef	_DeceSettingValueL
5408  00c8               _DeceSettingValueH:
5409  00c8 0000          	ds.b	2
5410                     	xdef	_DeceSettingValueH
5411  00ca               _CANsetvalue:
5412  00ca 00000000      	ds.b	4
5413                     	xdef	_CANsetvalue
5414  00ce               _PACKPIDe21a:
5415  00ce 00000000      	ds.b	4
5416                     	xdef	_PACKPIDe21a
5417  00d2               _PACKPIDe219:
5418  00d2 0000          	ds.b	2
5419                     	xdef	_PACKPIDe219
5420  00d4               _PACKPIDe217:
5421  00d4 00000000      	ds.b	4
5422                     	xdef	_PACKPIDe217
5423  00d8               _PACKPIDe200:
5424  00d8 00000000      	ds.b	4
5425                     	xdef	_PACKPIDe200
5426  00dc               _PACKPIDa442:
5427  00dc 0000          	ds.b	2
5428                     	xdef	_PACKPIDa442
5429  00de               _InOutPutPIDe114:
5430  00de 00            	ds.b	1
5431                     	xdef	_InOutPutPIDe114
5432  00df               _InOutPutPIDd102:
5433  00df 00            	ds.b	1
5434                     	xdef	_InOutPutPIDd102
5435  00e0               _InOutPutPID0202:
5436  00e0 00            	ds.b	1
5437                     	xdef	_InOutPutPID0202
5438  00e1               _InOutPutPID0200:
5439  00e1 00            	ds.b	1
5440                     	xdef	_InOutPutPID0200
5441  00e2               _CommonPIDC900:
5442  00e2 0000          	ds.b	2
5443                     	xdef	_CommonPIDC900
5444  00e4               _CommonPIDC136:
5445  00e4 0000          	ds.b	2
5446                     	xdef	_CommonPIDC136
5447  00e6               _CommonPIDC111:
5448  00e6 0000          	ds.b	2
5449                     	xdef	_CommonPIDC111
5450  00e8               _CommonPIDA457:
5451  00e8 0000          	ds.b	2
5452                     	xdef	_CommonPIDA457
5453  00ea               _CommonPIDA455:
5454  00ea 0000          	ds.b	2
5455                     	xdef	_CommonPIDA455
5456  00ec               _CommonPIDA452:
5457  00ec 0000          	ds.b	2
5458                     	xdef	_CommonPIDA452
5459  00ee               _CommonPIDA445:
5460  00ee 0000          	ds.b	2
5461                     	xdef	_CommonPIDA445
5462  00f0               _CommonPIDA442:
5463  00f0 0000          	ds.b	2
5464                     	xdef	_CommonPIDA442
5465  00f2               _CommonPIDA145:
5466  00f2 0000          	ds.b	2
5467                     	xdef	_CommonPIDA145
5468  00f4               _CommonPIDA141:
5469  00f4 0000          	ds.b	2
5470                     	xdef	_CommonPIDA141
5471  00f6               _CommonPID7130:
5472  00f6 0000          	ds.b	2
5473                     	xdef	_CommonPID7130
5474  00f8               _CommonPID7115:
5475  00f8 0000          	ds.b	2
5476                     	xdef	_CommonPID7115
5477  00fa               _CommonPID7110:
5478  00fa 0000          	ds.b	2
5479                     	xdef	_CommonPID7110
5480  00fc               _CommonPID7100:
5481  00fc 0000          	ds.b	2
5482                     	xdef	_CommonPID7100
5483  00fe               _CommonPID4932:
5484  00fe 00000000      	ds.b	4
5485                     	xdef	_CommonPID4932
5486  0102               _adResultTemp2:
5487  0102 0000          	ds.b	2
5488                     	xdef	_adResultTemp2
5489  0104               _adResultTemp1:
5490  0104 0000          	ds.b	2
5491                     	xdef	_adResultTemp1
5492  0106               _PIDbattervalue:
5493  0106 00            	ds.b	1
5494                     	xdef	_PIDbattervalue
5495  0107               _battervalue:
5496  0107 0000          	ds.b	2
5497                     	xdef	_battervalue
5498  0109               _PIDsendstate:
5499  0109 00            	ds.b	1
5500                     	xdef	_PIDsendstate
5501  010a               _DTCsendstate:
5502  010a 00            	ds.b	1
5503                     	xdef	_DTCsendstate
5504  010b               _CAN_FORTIFY_state:
5505  010b 00            	ds.b	1
5506                     	xdef	_CAN_FORTIFY_state
5507  010c               _BreakPedalSignal:
5508  010c 00            	ds.b	1
5509                     	xdef	_BreakPedalSignal
5510  010d               _MasterVehicleSpeed:
5511  010d 00            	ds.b	1
5512                     	xdef	_MasterVehicleSpeed
5513  010e               _BatteryVoltage:
5514  010e 00            	ds.b	1
5515                     	xdef	_BatteryVoltage
5516  010f               _MasterVehSpeedFault:
5517  010f 00            	ds.b	1
5518                     	xdef	_MasterVehSpeedFault
5519  0110               _Can_Tx_State:
5520  0110 00            	ds.b	1
5521                     	xdef	_Can_Tx_State
5522  0111               _Rx_Msg:
5523  0111 000000000000  	ds.b	140
5524                     	xdef	_Rx_Msg
5525  019d               _Tx_Msg:
5526  019d 000000000000  	ds.b	13
5527                     	xdef	_Tx_Msg
5528  01aa               _CanSendData:
5529  01aa 000000000000  	ds.b	8
5530                     	xdef	_CanSendData
5531  01b2               _Rx_Flag:
5532  01b2 00            	ds.b	1
5533                     	xdef	_Rx_Flag
5534  01b3               _Rx_Data:
5535  01b3 000000000000  	ds.b	8
5536                     	xdef	_Rx_Data
5537  01bb               _Rx_Dlc:
5538  01bb 00            	ds.b	1
5539                     	xdef	_Rx_Dlc
5540  01bc               _Rx_Extid:
5541  01bc 0000          	ds.b	2
5542                     	xdef	_Rx_Extid
5543  01be               _Rx_Stdid:
5544  01be 0000          	ds.b	2
5545                     	xdef	_Rx_Stdid
5546  01c0               _Can_Page:
5547  01c0 00            	ds.b	1
5548                     	xdef	_Can_Page
5549                     	xref.b	c_x
5569                     	xref	d_lgadc
5570                     	xref	d_jctab
5571                     	xref	d_rtol
5572                     	xref	d_uitolx
5573                     	xref	d_xymvx
5574                     	end
