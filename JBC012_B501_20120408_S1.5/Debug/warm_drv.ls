   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 776                     	switch	.bss
 777  0000               L534_FortifySWOFFCnt:
 778  0000 00            	ds.b	1
 779  0001               L334_FortifySWONCnt:
 780  0001 00            	ds.b	1
 827                     ; 66 void ScanFortifySWState(void)
 827                     ; 67 {
 828                     	switch	.text
 829  0000               f_ScanFortifySWState:
 833                     ; 69     if(!FORTIFY_SW)
 835  0000 720400001d    	btjt	_H4021Data1,#2,L364
 836                     ; 71         FortifySWOFFCnt = 0;
 838  0005 725f0000      	clr	L534_FortifySWOFFCnt
 839                     ; 72         if(FortifySWONCnt < KEY_FILTER_CNT) FortifySWONCnt++;
 841  0009 c60001        	ld	a,L334_FortifySWONCnt
 842  000c a105          	cp	a,#5
 843  000e 2405          	jruge	L564
 846  0010 725c0001      	inc	L334_FortifySWONCnt
 849  0014 87            	retf	
 850  0015               L564:
 851                     ; 73         else if(FortifySWONCnt == KEY_FILTER_CNT)
 853  0015 a105          	cp	a,#5
 854  0017 2625          	jrne	L374
 855                     ; 75              FortifySWONCnt++;
 857  0019 725c0001      	inc	L334_FortifySWONCnt
 858                     ; 76              FORTIFYSW_state = 0x55;
 860  001d 3555004c      	mov	_FORTIFYSW_state,#85
 862  0021 87            	retf	
 863  0022               L364:
 864                     ; 81         FortifySWONCnt = 0;
 866  0022 725f0001      	clr	L334_FortifySWONCnt
 867                     ; 82         if(FortifySWOFFCnt < KEY_FILTER_CNT) FortifySWOFFCnt++;
 869  0026 c60000        	ld	a,L534_FortifySWOFFCnt
 870  0029 a105          	cp	a,#5
 871  002b 2405          	jruge	L574
 874  002d 725c0000      	inc	L534_FortifySWOFFCnt
 877  0031 87            	retf	
 878  0032               L574:
 879                     ; 83         else if(FortifySWOFFCnt == KEY_FILTER_CNT)
 881  0032 a105          	cp	a,#5
 882  0034 2608          	jrne	L374
 883                     ; 85              FortifySWOFFCnt++;
 885  0036 725c0000      	inc	L534_FortifySWOFFCnt
 886                     ; 86              FORTIFYSW_state = 0x00;
 888  003a 725f004c      	clr	_FORTIFYSW_state
 889  003e               L374:
 890                     ; 89 }
 893  003e 87            	retf	
 895                     	switch	.bss
 896  0002               L505_keyOutCnt:
 897  0002 00            	ds.b	1
 898  0003               L305_keyInCnt:
 899  0003 00            	ds.b	1
 937                     ; 101 void ScanKeyInState(void)
 937                     ; 102 {
 938                     	switch	.text
 939  003f               f_ScanKeyInState:
 943                     ; 105 	if (KEY_IN_STATE_IN)
 945  003f 7203500b1d    	btjf	20491,#1,L525
 946                     ; 107 		keyInCnt = 0;
 948  0044 725f0003      	clr	L305_keyInCnt
 949                     ; 108 		if (keyOutCnt < KEY_FILTER_CNT)
 951  0048 c60002        	ld	a,L505_keyOutCnt
 952  004b a105          	cp	a,#5
 953  004d 2405          	jruge	L725
 954                     ; 110 			keyOutCnt++;
 956  004f 725c0002      	inc	L505_keyOutCnt
 959  0053 87            	retf	
 960  0054               L725:
 961                     ; 112 		else if (keyOutCnt == KEY_FILTER_CNT)
 963  0054 a105          	cp	a,#5
 964  0056 2625          	jrne	L535
 965                     ; 114 			keyOutCnt++;
 967  0058 725c0002      	inc	L505_keyOutCnt
 968                     ; 115 			KeyInState = KeyIsInHole;
 970  005c 3501005a      	mov	_KeyInState,#1
 972  0060 87            	retf	
 973  0061               L525:
 974                     ; 120 		keyOutCnt = 0;
 976  0061 725f0002      	clr	L505_keyOutCnt
 977                     ; 121 		if (keyInCnt < KEY_FILTER_CNT)
 979  0065 c60003        	ld	a,L305_keyInCnt
 980  0068 a105          	cp	a,#5
 981  006a 2405          	jruge	L735
 982                     ; 123 			keyInCnt++;
 984  006c 725c0003      	inc	L305_keyInCnt
 987  0070 87            	retf	
 988  0071               L735:
 989                     ; 125 		else if (keyInCnt == KEY_FILTER_CNT)
 991  0071 a105          	cp	a,#5
 992  0073 2608          	jrne	L535
 993                     ; 127 			keyInCnt++;
 995  0075 725c0003      	inc	L305_keyInCnt
 996                     ; 128 			KeyInState = KeyIsOutHole;
 998  0079 725f005a      	clr	_KeyInState
 999  007d               L535:
1000                     ; 131 }
1003  007d 87            	retf	
1005                     	switch	.bss
1006  0004               L745_lamplowCnt:
1007  0004 00            	ds.b	1
1008  0005               L545_lamphighCnt:
1009  0005 00            	ds.b	1
1049                     ; 146 void ScanSmallLampSwitch(void)
1049                     ; 147 {
1050                     	switch	.text
1051  007e               f_ScanSmallLampSwitch:
1055                     ; 150 	if (!SMALL_LAMP_SW)
1057  007e 720600001d    	btjt	_H4021Data1,#3,L765
1058                     ; 152 		lamplowCnt = 0;
1060  0083 725f0004      	clr	L745_lamplowCnt
1061                     ; 153 		if (lamphighCnt < KEY_FILTER_CNT)
1063  0087 c60005        	ld	a,L545_lamphighCnt
1064  008a a105          	cp	a,#5
1065  008c 2405          	jruge	L175
1066                     ; 155 			lamphighCnt++;
1068  008e 725c0005      	inc	L545_lamphighCnt
1071  0092 87            	retf	
1072  0093               L175:
1073                     ; 157 		else if (lamphighCnt == KEY_FILTER_CNT)
1075  0093 a105          	cp	a,#5
1076  0095 2625          	jrne	L775
1077                     ; 159 			lamphighCnt++;
1079  0097 725c0005      	inc	L545_lamphighCnt
1080                     ; 160 			SmallLampSwitchState = Pressed;
1082  009b 35550059      	mov	_SmallLampSwitchState,#85
1084  009f 87            	retf	
1085  00a0               L765:
1086                     ; 165 		lamphighCnt = 0;
1088  00a0 725f0005      	clr	L545_lamphighCnt
1089                     ; 166 		if (lamplowCnt < KEY_FILTER_CNT)
1091  00a4 c60004        	ld	a,L745_lamplowCnt
1092  00a7 a105          	cp	a,#5
1093  00a9 2405          	jruge	L106
1094                     ; 168 			lamplowCnt++;
1096  00ab 725c0004      	inc	L745_lamplowCnt
1099  00af 87            	retf	
1100  00b0               L106:
1101                     ; 170 		else if (lamplowCnt == KEY_FILTER_CNT)
1103  00b0 a105          	cp	a,#5
1104  00b2 2608          	jrne	L775
1105                     ; 172 			lamplowCnt++;
1107  00b4 725c0004      	inc	L745_lamplowCnt
1108                     ; 173 			SmallLampSwitchState = Unpressed;
1110  00b8 725f0059      	clr	_SmallLampSwitchState
1111  00bc               L775:
1112                     ; 176 }
1115  00bc 87            	retf	
1140                     ; 188 void ScanStandbySmallLampSwitch(void)
1140                     ; 189 {
1141                     	switch	.text
1142  00bd               f_ScanStandbySmallLampSwitch:
1146                     ; 191 	if (!SMALL_LAMP_SW)
1148  00bd 7206000004    	btjt	_H4021Data1,#3,L126
1149                     ; 193 		StandByState = Pressed;
1151  00c2 35550000      	mov	_StandByState,#85
1152  00c6               L126:
1153                     ; 197 }
1156  00c6 87            	retf	
1158                     	switch	.bss
1159  0006               L146_FDclosecnt:
1160  0006 00            	ds.b	1
1161  0007               L736_FDopencnt:
1162  0007 00            	ds.b	1
1163  0008               L536_TDcloseCnt:
1164  0008 00            	ds.b	1
1165  0009               L336_TDopenCnt:
1166  0009 00            	ds.b	1
1167  000a               L136_ODcloseCnt:
1168  000a 00            	ds.b	1
1169  000b               L726_ODopenCnt:
1170  000b 00            	ds.b	1
1171  000c               L526_DDcloseCnt:
1172  000c 00            	ds.b	1
1173  000d               L326_DDopenCnt:
1174  000d 00            	ds.b	1
1257                     ; 210 void ScanAllDoorState(void)
1257                     ; 211 {
1258                     	switch	.text
1259  00c7               f_ScanAllDoorState:
1263                     ; 220     if (!D_DOOR_AJAR)
1265  00c7 720a500b2a    	btjt	20491,#5,L776
1266                     ; 222         DDcloseCnt = 0;
1268  00cc 725f000c      	clr	L526_DDcloseCnt
1269                     ; 223         if (DDopenCnt < KEY_FILTER_CNT)
1271  00d0 c6000d        	ld	a,L326_DDopenCnt
1272  00d3 a105          	cp	a,#5
1273  00d5 2406          	jruge	L107
1274                     ; 225    	    DDopenCnt++;
1276  00d7 725c000d      	inc	L326_DDopenCnt
1278  00db 2036          	jra	L117
1279  00dd               L107:
1280                     ; 227         else if (DDopenCnt == KEY_FILTER_CNT)
1282  00dd a105          	cp	a,#5
1283  00df 2632          	jrne	L117
1284                     ; 229    	    DDopenCnt++;
1286  00e1 725c000d      	inc	L326_DDopenCnt
1287                     ; 230    	    DoorState |= DriverDoorIsOpen;
1289  00e5 72100058      	bset	_DoorState,#0
1290                     ; 231            if (RKE_AutoLockFlag == RKE_AUTO_LOCK_YES)
1292  00e9 c60000        	ld	a,_RKE_AutoLockFlag
1293  00ec a155          	cp	a,#85
1294  00ee 2623          	jrne	L117
1295                     ; 233    			RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;
1297  00f0 725f0000      	clr	_RKE_AutoLockFlag
1298  00f4 201d          	jra	L117
1299  00f6               L776:
1300                     ; 239         DDopenCnt=0;
1302  00f6 725f000d      	clr	L326_DDopenCnt
1303                     ; 240         if (DDcloseCnt < KEY_FILTER_CNT)
1305  00fa c6000c        	ld	a,L526_DDcloseCnt
1306  00fd a105          	cp	a,#5
1307  00ff 2406          	jruge	L317
1308                     ; 242             DDcloseCnt++;
1310  0101 725c000c      	inc	L526_DDcloseCnt
1312  0105 200c          	jra	L117
1313  0107               L317:
1314                     ; 244         else if ( DDcloseCnt == KEY_FILTER_CNT)
1316  0107 a105          	cp	a,#5
1317  0109 2608          	jrne	L117
1318                     ; 246        	    DDcloseCnt++;
1320  010b 725c000c      	inc	L526_DDcloseCnt
1321                     ; 247        	    DoorState &= ~DriverDoorIsOpen;
1323  010f 72110058      	bres	_DoorState,#0
1324  0113               L117:
1325                     ; 252     if (!OTHER_DOOR_AJAR)
1327  0113 720e50152a    	btjt	20501,#7,L127
1328                     ; 254         ODcloseCnt = 0;
1330  0118 725f000a      	clr	L136_ODcloseCnt
1331                     ; 255         if (ODopenCnt < KEY_FILTER_CNT)
1333  011c c6000b        	ld	a,L726_ODopenCnt
1334  011f a105          	cp	a,#5
1335  0121 2406          	jruge	L327
1336                     ; 257        	    ODopenCnt++;
1338  0123 725c000b      	inc	L726_ODopenCnt
1340  0127 2036          	jra	L337
1341  0129               L327:
1342                     ; 259         else if(ODopenCnt == KEY_FILTER_CNT)
1344  0129 a105          	cp	a,#5
1345  012b 2632          	jrne	L337
1346                     ; 261        	    ODopenCnt++;
1348  012d 725c000b      	inc	L726_ODopenCnt
1349                     ; 262        	    DoorState |= OtherDoorIsOpen;
1351  0131 72120058      	bset	_DoorState,#1
1352                     ; 263        	    if (RKE_AutoLockFlag == RKE_AUTO_LOCK_YES)
1354  0135 c60000        	ld	a,_RKE_AutoLockFlag
1355  0138 a155          	cp	a,#85
1356  013a 2623          	jrne	L337
1357                     ; 265        			RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;
1359  013c 725f0000      	clr	_RKE_AutoLockFlag
1360  0140 201d          	jra	L337
1361  0142               L127:
1362                     ; 272         ODopenCnt=0;
1364  0142 725f000b      	clr	L726_ODopenCnt
1365                     ; 273         if (ODcloseCnt < KEY_FILTER_CNT)
1367  0146 c6000a        	ld	a,L136_ODcloseCnt
1368  0149 a105          	cp	a,#5
1369  014b 2406          	jruge	L537
1370                     ; 275        	    ODcloseCnt++;
1372  014d 725c000a      	inc	L136_ODcloseCnt
1374  0151 200c          	jra	L337
1375  0153               L537:
1376                     ; 277         else if (ODcloseCnt == KEY_FILTER_CNT)
1378  0153 a105          	cp	a,#5
1379  0155 2608          	jrne	L337
1380                     ; 279        	    ODcloseCnt++;
1382  0157 725c000a      	inc	L136_ODcloseCnt
1383                     ; 280        	    DoorState &= ~OtherDoorIsOpen;
1385  015b 72130058      	bres	_DoorState,#1
1386  015f               L337:
1387                     ; 283     if(!Alarm_IN)
1389  015f 720e00002a    	btjt	_H4021Data1,#7,L347
1390                     ; 285         FDclosecnt = 0;
1392  0164 725f0006      	clr	L146_FDclosecnt
1393                     ; 286         if (FDopencnt < KEY_FILTER_CNT)
1395  0168 c60007        	ld	a,L736_FDopencnt
1396  016b a105          	cp	a,#5
1397  016d 2406          	jruge	L547
1398                     ; 288        	   FDopencnt++;
1400  016f 725c0007      	inc	L736_FDopencnt
1402  0173 2036          	jra	L557
1403  0175               L547:
1404                     ; 290         else if (FDopencnt == KEY_FILTER_CNT)
1406  0175 a105          	cp	a,#5
1407  0177 2632          	jrne	L557
1408                     ; 292        	   FDopencnt++;
1410  0179 725c0007      	inc	L736_FDopencnt
1411                     ; 293        	   DoorState |= FDdoorisopen;
1413  017d 72160058      	bset	_DoorState,#3
1414                     ; 294 			if (RKE_AutoLockFlag == RKE_AUTO_LOCK_YES)
1416  0181 c60000        	ld	a,_RKE_AutoLockFlag
1417  0184 a155          	cp	a,#85
1418  0186 2623          	jrne	L557
1419                     ; 296 			         RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;
1421  0188 725f0000      	clr	_RKE_AutoLockFlag
1422  018c 201d          	jra	L557
1423  018e               L347:
1424                     ; 303         FDopencnt = 0;
1426  018e 725f0007      	clr	L736_FDopencnt
1427                     ; 304         if (FDclosecnt < KEY_FILTER_CNT)
1429  0192 c60006        	ld	a,L146_FDclosecnt
1430  0195 a105          	cp	a,#5
1431  0197 2406          	jruge	L757
1432                     ; 306             FDclosecnt++;
1434  0199 725c0006      	inc	L146_FDclosecnt
1436  019d 200c          	jra	L557
1437  019f               L757:
1438                     ; 308         else if (FDclosecnt == KEY_FILTER_CNT)
1440  019f a105          	cp	a,#5
1441  01a1 2608          	jrne	L557
1442                     ; 310               FDclosecnt++;
1444  01a3 725c0006      	inc	L146_FDclosecnt
1445                     ; 311         	DoorState &= ~FDdoorisopen;
1447  01a7 72170058      	bres	_DoorState,#3
1448  01ab               L557:
1449                     ; 319     if (R_Door_state_IN)
1451  01ab 720d50011f    	btjf	20481,#6,L567
1452                     ; 321        TDopenCnt = 0;
1454  01b0 725f0009      	clr	L336_TDopenCnt
1455                     ; 322        if(TDcloseCnt < KEY_FILTER_CNT)TDcloseCnt++;
1457  01b4 c60008        	ld	a,L536_TDcloseCnt
1458  01b7 a105          	cp	a,#5
1459  01b9 2406          	jruge	L767
1462  01bb 725c0008      	inc	L536_TDcloseCnt
1464  01bf 202b          	jra	L577
1465  01c1               L767:
1466                     ; 323        else if (TDcloseCnt == KEY_FILTER_CNT)
1468  01c1 a105          	cp	a,#5
1469  01c3 2627          	jrne	L577
1470                     ; 325 					TDcloseCnt++;
1472  01c5 725c0008      	inc	L536_TDcloseCnt
1473                     ; 326 					DoorState &= ~TrunkIsOpen;
1475  01c9 72150058      	bres	_DoorState,#2
1476  01cd 201d          	jra	L577
1477  01cf               L567:
1478                     ; 331     	TDcloseCnt= 0;
1480  01cf 725f0008      	clr	L536_TDcloseCnt
1481                     ; 332        if(TDopenCnt<KEY_FILTER_CNT)TDopenCnt++;
1483  01d3 c60009        	ld	a,L336_TDopenCnt
1484  01d6 a105          	cp	a,#5
1485  01d8 2406          	jruge	L777
1488  01da 725c0009      	inc	L336_TDopenCnt
1490  01de 200c          	jra	L577
1491  01e0               L777:
1492                     ; 333        else if(TDopenCnt == KEY_FILTER_CNT)
1494  01e0 a105          	cp	a,#5
1495  01e2 2608          	jrne	L577
1496                     ; 335 			TDopenCnt++;
1498  01e4 725c0009      	inc	L336_TDopenCnt
1499                     ; 336 			DoorState |= TrunkIsOpen;
1501  01e8 72140058      	bset	_DoorState,#2
1502  01ec               L577:
1503                     ; 343 	if(DoorState & TrunkIsOpen) CAN_TrunkSW_ON;
1505  01ec 7205005806    	btjf	_DoorState,#2,L5001
1508  01f1 72160002      	bset	_CanSendData+2,#3
1510  01f5 2004          	jra	L7001
1511  01f7               L5001:
1512                     ; 344 	else CAN_TrunkSW_OFF;
1514  01f7 72170002      	bres	_CanSendData+2,#3
1515  01fb               L7001:
1516                     ; 345 	if(DoorState & DriverDoorIsOpen) CAN_LFdoorSW_ON;
1518  01fb 7201005806    	btjf	_DoorState,#0,L1101
1521  0200 721e0002      	bset	_CanSendData+2,#7
1523  0204 2004          	jra	L3101
1524  0206               L1101:
1525                     ; 346 	else CAN_LFdoorSW_OFF;
1527  0206 721f0002      	bres	_CanSendData+2,#7
1528  020a               L3101:
1529                     ; 347 	if(DoorState & OtherDoorIsOpen) {CAN_RRdoorSW_ON;CAN_LRdoorSW_ON;}
1531  020a 720300580a    	btjf	_DoorState,#1,L5101
1534  020f 72180002      	bset	_CanSendData+2,#4
1537  0213 721a0002      	bset	_CanSendData+2,#5
1539  0217 2008          	jra	L7101
1540  0219               L5101:
1541                     ; 348 	else {CAN_RRdoorSW_OFF;CAN_LRdoorSW_OFF;}
1543  0219 72190002      	bres	_CanSendData+2,#4
1546  021d 721b0002      	bres	_CanSendData+2,#5
1547  0221               L7101:
1548                     ; 349 	if(DoorState & FDdoorisopen)CAN_RFdoorSW_ON;
1550  0221 7207005805    	btjf	_DoorState,#3,L1201
1553  0226 721c0002      	bset	_CanSendData+2,#6
1556  022a 87            	retf	
1557  022b               L1201:
1558                     ; 350 	else  CAN_RFdoorSW_OFF;
1560  022b 721d0002      	bres	_CanSendData+2,#6
1561                     ; 351 }
1564  022f 87            	retf	
1589                     ; 362 void ScanStandByDoorAjarSwitch(void)
1589                     ; 363 {
1590                     	switch	.text
1591  0230               f_ScanStandByDoorAjarSwitch:
1595                     ; 365 	if((!D_DOOR_AJAR)||(!OTHER_DOOR_AJAR)||(!Alarm_IN)||(!R_Door_state_IN))//||(!HORN_SW)) 
1597  0230 720b500b0f    	btjf	20491,#5,L1401
1599  0235 720f50150a    	btjf	20501,#7,L1401
1601  023a 720f000005    	btjf	_H4021Data1,#7,L1401
1603  023f 720c500104    	btjt	20481,#6,L7301
1604  0244               L1401:
1605                     ; 368         	StandByState = Pressed;    //此状态退出低功耗后应请除
1607  0244 35550000      	mov	_StandByState,#85
1608  0248               L7301:
1609                     ; 372 }
1612  0248 87            	retf	
1614                     	switch	.bss
1615  000e               L5501_pNoBuckledCnt:
1616  000e 00            	ds.b	1
1617  000f               L3501_pBuckledCnt:
1618  000f 00            	ds.b	1
1619  0010               L1501_dNoBuckledCnt:
1620  0010 00            	ds.b	1
1621  0011               L7401_dBuckledCnt:
1622  0011 00            	ds.b	1
1676                     ; 386 void ScanSeatbeltBuckleState(void)
1676                     ; 387 {
1677                     	switch	.text
1678  0249               f_ScanSeatbeltBuckleState:
1682                     ; 392     if (!D_SEATBELT_SW)
1684  0249 720c50061f    	btjt	20486,#6,L1011
1685                     ; 394         dNoBuckledCnt = 0;
1687  024e 725f0010      	clr	L1501_dNoBuckledCnt
1688                     ; 395         if (dBuckledCnt < KEY_FILTER_CNT)
1690  0252 c60011        	ld	a,L7401_dBuckledCnt
1691  0255 a105          	cp	a,#5
1692  0257 2406          	jruge	L3011
1693                     ; 397             dBuckledCnt++;
1695  0259 725c0011      	inc	L7401_dBuckledCnt
1697  025d 202b          	jra	L1111
1698  025f               L3011:
1699                     ; 399         else if (dBuckledCnt == KEY_FILTER_CNT)
1701  025f a105          	cp	a,#5
1702  0261 2627          	jrne	L1111
1703                     ; 401             dBuckledCnt++;
1705  0263 725c0011      	inc	L7401_dBuckledCnt
1706                     ; 402         	SeatState |= DSeatbeltBuckled;
1708  0267 72100056      	bset	_SeatState,#0
1709  026b 201d          	jra	L1111
1710  026d               L1011:
1711                     ; 407         dBuckledCnt = 0;
1713  026d 725f0011      	clr	L7401_dBuckledCnt
1714                     ; 408         if (dNoBuckledCnt < KEY_FILTER_CNT)
1716  0271 c60010        	ld	a,L1501_dNoBuckledCnt
1717  0274 a105          	cp	a,#5
1718  0276 2406          	jruge	L3111
1719                     ; 410             dNoBuckledCnt++;
1721  0278 725c0010      	inc	L1501_dNoBuckledCnt
1723  027c 200c          	jra	L1111
1724  027e               L3111:
1725                     ; 412         else if (dNoBuckledCnt == KEY_FILTER_CNT)
1727  027e a105          	cp	a,#5
1728  0280 2608          	jrne	L1111
1729                     ; 414             dNoBuckledCnt++;
1731  0282 725c0010      	inc	L1501_dNoBuckledCnt
1732                     ; 415         	SeatState &= ~DSeatbeltBuckled;
1734  0286 72110056      	bres	_SeatState,#0
1735  028a               L1111:
1736                     ; 420     if (!P_SEATBELT_SW)
1738  028a 720a00001d    	btjt	_H4021Data1,#5,L1211
1739                     ; 422         pNoBuckledCnt = 0;
1741  028f 725f000e      	clr	L5501_pNoBuckledCnt
1742                     ; 423         if (pBuckledCnt < KEY_FILTER_CNT)
1744  0293 c6000f        	ld	a,L3501_pBuckledCnt
1745  0296 a105          	cp	a,#5
1746  0298 2405          	jruge	L3211
1747                     ; 425             pBuckledCnt++;
1749  029a 725c000f      	inc	L3501_pBuckledCnt
1752  029e 87            	retf	
1753  029f               L3211:
1754                     ; 427         else if (pBuckledCnt == KEY_FILTER_CNT)
1756  029f a105          	cp	a,#5
1757  02a1 2625          	jrne	L1311
1758                     ; 429             pBuckledCnt++;
1760  02a3 725c000f      	inc	L3501_pBuckledCnt
1761                     ; 430         	SeatState |= PSeatbeltBuckled;
1763  02a7 72120056      	bset	_SeatState,#1
1765  02ab 87            	retf	
1766  02ac               L1211:
1767                     ; 435         pBuckledCnt = 0;
1769  02ac 725f000f      	clr	L3501_pBuckledCnt
1770                     ; 436         if (pNoBuckledCnt < KEY_FILTER_CNT)
1772  02b0 c6000e        	ld	a,L5501_pNoBuckledCnt
1773  02b3 a105          	cp	a,#5
1774  02b5 2405          	jruge	L3311
1775                     ; 438             pNoBuckledCnt++;
1777  02b7 725c000e      	inc	L5501_pNoBuckledCnt
1780  02bb 87            	retf	
1781  02bc               L3311:
1782                     ; 440         else if (pNoBuckledCnt == KEY_FILTER_CNT)
1784  02bc a105          	cp	a,#5
1785  02be 2608          	jrne	L1311
1786                     ; 442             pNoBuckledCnt++;
1788  02c0 725c000e      	inc	L5501_pNoBuckledCnt
1789                     ; 443         	SeatState &= ~PSeatbeltBuckled;
1791  02c4 72130056      	bres	_SeatState,#1
1792  02c8               L1311:
1793                     ; 446 }
1796  02c8 87            	retf	
1798                     	switch	.bss
1799  0012               L3411_noseatCnt:
1800  0012 00            	ds.b	1
1801  0013               L1411_seatCnt:
1802  0013 00            	ds.b	1
1842                     ; 460 void ScanSeatPositionState(void)
1842                     ; 461 {
1843                     	switch	.text
1844  02c9               f_ScanSeatPositionState:
1848                     ; 464     if (P_SEAT_SW)
1850  02c9 720d00001d    	btjf	_H4021Data1,#6,L3611
1851                     ; 466         seatCnt = 0;
1853  02ce 725f0013      	clr	L1411_seatCnt
1854                     ; 467         if (noseatCnt < KEY_FILTER_CNT)
1856  02d2 c60012        	ld	a,L3411_noseatCnt
1857  02d5 a105          	cp	a,#5
1858  02d7 2405          	jruge	L5611
1859                     ; 469             noseatCnt++;
1861  02d9 725c0012      	inc	L3411_noseatCnt
1864  02dd 87            	retf	
1865  02de               L5611:
1866                     ; 471         else if (noseatCnt == KEY_FILTER_CNT)
1868  02de a105          	cp	a,#5
1869  02e0 2625          	jrne	L3711
1870                     ; 473             noseatCnt++;
1872  02e2 725c0012      	inc	L3411_noseatCnt
1873                     ; 474         	SeatState &= ~PassengerSeated;
1875  02e6 72150056      	bres	_SeatState,#2
1877  02ea 87            	retf	
1878  02eb               L3611:
1879                     ; 479         noseatCnt = 0;
1881  02eb 725f0012      	clr	L3411_noseatCnt
1882                     ; 480         if (seatCnt < KEY_FILTER_CNT)
1884  02ef c60013        	ld	a,L1411_seatCnt
1885  02f2 a105          	cp	a,#5
1886  02f4 2405          	jruge	L5711
1887                     ; 482             seatCnt++;
1889  02f6 725c0013      	inc	L1411_seatCnt
1892  02fa 87            	retf	
1893  02fb               L5711:
1894                     ; 484         else if (seatCnt == KEY_FILTER_CNT)
1896  02fb a105          	cp	a,#5
1897  02fd 2608          	jrne	L3711
1898                     ; 486             seatCnt++;
1900  02ff 725c0013      	inc	L1411_seatCnt
1901                     ; 487         	SeatState |= PassengerSeated;
1903  0303 72140056      	bset	_SeatState,#2
1904  0307               L3711:
1905                     ; 490 }
1908  0307 87            	retf	
1910                     	switch	.bss
1911  0014               L3221_Buzzseattime:
1912  0014 0000          	ds.b	2
1913  0016               L7121_BuzzDoorstate:
1914  0016 00            	ds.b	1
1959                     .const:	section	.text
1960  0000               L62:
1961  0000 0000927b      	dc.l	37499
1962                     ; 509 void JudgeWarmTypeAndDriver(void)
1962                     ; 510 {
1963                     	switch	.text
1964  0308               f_JudgeWarmTypeAndDriver:
1968                     ; 523     if((SeatState & DSeatbeltBuckled)&&(IGNstate == ON)&&(CarSpeed[2] > 13))
1970  0308 7201005634    	btjf	_SeatState,#0,L3421
1972  030d c60000        	ld	a,_IGNstate
1973  0310 a155          	cp	a,#85
1974  0312 262d          	jrne	L3421
1976  0314 ce0051        	ldw	x,_CarSpeed+4
1977  0317 a3000e        	cpw	x,#14
1978  031a 2525          	jrult	L3421
1979                     ; 525         if(Buzzseattime < 37499) Buzzseattime++;
1981  031c ce0014        	ldw	x,L3221_Buzzseattime
1982  031f 8d000000      	callf	d_uitolx
1984  0323 ae0000        	ldw	x,#L62
1985  0326 8d000000      	callf	d_lcmp
1987  032a 2e07          	jrsge	L5421
1990  032c ce0014        	ldw	x,L3221_Buzzseattime
1991  032f 5c            	incw	x
1992  0330 cf0014        	ldw	L3221_Buzzseattime,x
1993  0333               L5421:
1994                     ; 526 		if((Buzzseattime % 1875)== 5)
1996  0333 ce0014        	ldw	x,L3221_Buzzseattime
1997  0336 90ae0753      	ldw	y,#1875
1998  033a 65            	divw	x,y
1999  033b 93            	ldw	x,y
2000  033c a30005        	cpw	x,#5
2001  033f 200e          	jra	L1521
2002  0341               L3421:
2003                     ; 531 	else if(((SeatState & DSeatbeltBuckled) == 0)||(IGNstate == OFF))
2005  0341 7201005605    	btjf	_SeatState,#0,L5521
2007  0346 c60000        	ld	a,_IGNstate
2008  0349 2604          	jrne	L1521
2009  034b               L5521:
2010                     ; 534 		Buzzseattime = 0;     	
2012  034b 5f            	clrw	x
2013  034c cf0014        	ldw	L3221_Buzzseattime,x
2014  034f               L1521:
2015                     ; 539 	if ((IGNstate == ON) && (DoorState != AllDoorIsClosed))//&&(Doorstate_old == 0))
2017  034f c60000        	ld	a,_IGNstate
2018  0352 a155          	cp	a,#85
2019  0354 2624          	jrne	L7521
2021  0356 c60058        	ld	a,_DoorState
2022  0359 271f          	jreq	L7521
2023                     ; 541         if(BuzzDoorstate != 0x55)
2025  035b c60016        	ld	a,L7121_BuzzDoorstate
2026  035e a155          	cp	a,#85
2027  0360 2722          	jreq	L3621
2028                     ; 543 		 	BuzzerDrv(2,125,62,Buzzdoorunclose); 
2030  0362 4b1b          	push	#27
2031  0364 ae003e        	ldw	x,#62
2032  0367 89            	pushw	x
2033  0368 ae007d        	ldw	x,#125
2034  036b 89            	pushw	x
2035  036c a602          	ld	a,#2
2036  036e 8d940394      	callf	f_BuzzerDrv
2038  0372 5b05          	addw	sp,#5
2039                     ; 544 			BuzzDoorstate = 0x55;
2041  0374 35550016      	mov	L7121_BuzzDoorstate,#85
2042  0378 200a          	jra	L3621
2043  037a               L7521:
2044                     ; 549 		ClearBuzzdrv(Buzzdoorunclose); 
2046  037a a61b          	ld	a,#27
2047  037c 8d060406      	callf	f_ClearBuzzdrv
2049                     ; 550 		BuzzDoorstate = 0;
2051  0380 725f0016      	clr	L7121_BuzzDoorstate
2052  0384               L3621:
2053                     ; 553 	if((DoorState != AllDoorIsClosed )&&(IGNstate == OFF)&&(SmallLampSwitchState == Pressed))
2055  0384 c60058        	ld	a,_DoorState
2056  0387 270a          	jreq	L7621
2058  0389 c60000        	ld	a,_IGNstate
2059  038c 2605          	jrne	L7621
2061  038e c60059        	ld	a,_SmallLampSwitchState
2062  0391 a155          	cp	a,#85
2064  0393               L7621:
2065                     ; 563 }
2068  0393 87            	retf	
2149                     ; 566 void BuzzerDrv(uchar buzzercnt,uint buzzertime,uint buzzerontime,uchar buzzyx)
2149                     ; 567 {
2150                     	switch	.text
2151  0394               f_BuzzerDrv:
2153  0394 88            	push	a
2154  0395 5203          	subw	sp,#3
2155       00000003      OFST:	set	3
2158                     ; 574 	 if(buzzstate != 1)
2160  0397 7b01          	ld	a,(OFST-2,sp)
2161  0399 4a            	dec	a
2162  039a 2767          	jreq	L3231
2163                     ; 576 	     buzzyxmin = 0x1f;
2165  039c a61f          	ld	a,#31
2166  039e 6b01          	ld	(OFST-2,sp),a
2167                     ; 577          for(buzzi=0;buzzi<5;buzzi++)
2169  03a0 4f            	clr	a
2170  03a1 6b03          	ld	(OFST+0,sp),a
2171  03a3               L5231:
2172                     ; 579              if(buzzyxmin > buzzdrvStrategy[buzzi].buzzyx){ buzzyxmin = buzzdrvStrategy[buzzi].buzzyx;buzzil = buzzi;}
2174  03a3 97            	ld	xl,a
2175  03a4 a609          	ld	a,#9
2176  03a6 42            	mul	x,a
2177  03a7 d6001d        	ld	a,(_buzzdrvStrategy+6,x)
2178  03aa 1101          	cp	a,(OFST-2,sp)
2179  03ac 2409          	jruge	L3331
2182  03ae d6001d        	ld	a,(_buzzdrvStrategy+6,x)
2183  03b1 6b01          	ld	(OFST-2,sp),a
2186  03b3 7b03          	ld	a,(OFST+0,sp)
2187  03b5 6b02          	ld	(OFST-1,sp),a
2188  03b7               L3331:
2189                     ; 580              if(buzzdrvStrategy[buzzi].buzzyx == 0)
2191  03b7 724d001d      	tnz	(_buzzdrvStrategy+6,x)
2192  03bb 261a          	jrne	L5331
2193                     ; 582                  buzzdrvStrategy[buzzi].buzzcnt     =buzzercnt;
2195  03bd 7b04          	ld	a,(OFST+1,sp)
2196  03bf 905f          	clrw	y
2197  03c1 9097          	ld	yl,a
2198  03c3 df0017        	ldw	(_buzzdrvStrategy,x),y
2199                     ; 583 				 buzzdrvStrategy[buzzi].buzzmaxtime =buzzertime;
2201  03c6 1608          	ldw	y,(OFST+5,sp)
2202  03c8 df0019        	ldw	(_buzzdrvStrategy+2,x),y
2203                     ; 584 				 buzzdrvStrategy[buzzi].buzzontime  =buzzerontime;
2205  03cb 160a          	ldw	y,(OFST+7,sp)
2206  03cd df001b        	ldw	(_buzzdrvStrategy+4,x),y
2207                     ; 585 				 buzzdrvStrategy[buzzi].buzzyx      =buzzyx;
2209  03d0 7b0c          	ld	a,(OFST+9,sp)
2210  03d2 d7001d        	ld	(_buzzdrvStrategy+6,x),a
2211                     ; 586 				 break;
2213  03d5 202c          	jra	L3231
2214  03d7               L5331:
2215                     ; 588 			 if(buzzi >= 4)
2217  03d7 7b03          	ld	a,(OFST+0,sp)
2218  03d9 a104          	cp	a,#4
2219  03db 251e          	jrult	L7331
2220                     ; 590                  buzzdrvStrategy[buzzil].buzzcnt     =buzzercnt;
2222  03dd 7b02          	ld	a,(OFST-1,sp)
2223  03df 97            	ld	xl,a
2224  03e0 a609          	ld	a,#9
2225  03e2 42            	mul	x,a
2226  03e3 7b04          	ld	a,(OFST+1,sp)
2227  03e5 905f          	clrw	y
2228  03e7 9097          	ld	yl,a
2229  03e9 df0017        	ldw	(_buzzdrvStrategy,x),y
2230                     ; 591 				 buzzdrvStrategy[buzzil].buzzmaxtime =buzzertime;
2232  03ec 1608          	ldw	y,(OFST+5,sp)
2233  03ee df0019        	ldw	(_buzzdrvStrategy+2,x),y
2234                     ; 592 				 buzzdrvStrategy[buzzil].buzzontime  =buzzerontime;
2236  03f1 160a          	ldw	y,(OFST+7,sp)
2237  03f3 df001b        	ldw	(_buzzdrvStrategy+4,x),y
2238                     ; 593 				 buzzdrvStrategy[buzzil].buzzyx      =buzzyx;
2240  03f6 7b0c          	ld	a,(OFST+9,sp)
2241  03f8 d7001d        	ld	(_buzzdrvStrategy+6,x),a
2242  03fb               L7331:
2243                     ; 577          for(buzzi=0;buzzi<5;buzzi++)
2245  03fb 0c03          	inc	(OFST+0,sp)
2248  03fd 7b03          	ld	a,(OFST+0,sp)
2249  03ff a105          	cp	a,#5
2250  0401 25a0          	jrult	L5231
2251  0403               L3231:
2252                     ; 597 }
2255  0403 5b04          	addw	sp,#4
2256  0405 87            	retf	
2295                     ; 599 void ClearBuzzdrv(u8 buzzyx)
2295                     ; 600 {
2296                     	switch	.text
2297  0406               f_ClearBuzzdrv:
2299  0406 88            	push	a
2300  0407 88            	push	a
2301       00000001      OFST:	set	1
2304                     ; 602    for(buzzi=0;buzzi<5;buzzi++)
2306  0408 4f            	clr	a
2307  0409 6b01          	ld	(OFST+0,sp),a
2308  040b               L7531:
2309                     ; 604        if(buzzdrvStrategy[buzzi].buzzyx == buzzyx)
2311  040b 97            	ld	xl,a
2312  040c a609          	ld	a,#9
2313  040e 42            	mul	x,a
2314  040f d6001d        	ld	a,(_buzzdrvStrategy+6,x)
2315  0412 1102          	cp	a,(OFST+1,sp)
2316  0414 2612          	jrne	L5631
2317                     ; 606              buzzdrvStrategy[buzzi].buzzcnt     =0;
2319  0416 905f          	clrw	y
2320  0418 df0017        	ldw	(_buzzdrvStrategy,x),y
2321                     ; 607 			 buzzdrvStrategy[buzzi].buzzmaxtime =0;
2323  041b df0019        	ldw	(_buzzdrvStrategy+2,x),y
2324                     ; 608 			 buzzdrvStrategy[buzzi].buzzontime  =0;
2326  041e df001b        	ldw	(_buzzdrvStrategy+4,x),y
2327                     ; 609 			 buzzdrvStrategy[buzzi].buzzyx      =0;
2329  0421 724f001d      	clr	(_buzzdrvStrategy+6,x)
2330                     ; 610 			 buzzdrvStrategy[buzzi].BuzzerCnt   =0;
2332  0425 df001e        	ldw	(_buzzdrvStrategy+7,x),y
2333  0428               L5631:
2334                     ; 602    for(buzzi=0;buzzi<5;buzzi++)
2336  0428 0c01          	inc	(OFST+0,sp)
2339  042a 7b01          	ld	a,(OFST+0,sp)
2340  042c a105          	cp	a,#5
2341  042e 25db          	jrult	L7531
2342                     ; 614 }
2345  0430 85            	popw	x
2346  0431 87            	retf	
2393                     ; 616 void buzzdrv2(void)
2393                     ; 617 {
2394                     	switch	.text
2395  0432               f_buzzdrv2:
2397  0432 5205          	subw	sp,#5
2398       00000005      OFST:	set	5
2401                     ; 630 	 buzzyxmin = 0x00;
2403  0434 0f03          	clr	(OFST-2,sp)
2404                     ; 631 	 buzzeri = 0;
2406  0436 0f04          	clr	(OFST-1,sp)
2407                     ; 632 	 for(buzzii=0;buzzii<5;buzzii++)
2409  0438 4f            	clr	a
2410  0439 6b05          	ld	(OFST+0,sp),a
2411  043b               L7041:
2412                     ; 634          if(buzzyxmin < buzzdrvStrategy[buzzii].buzzyx)
2414  043b 97            	ld	xl,a
2415  043c a609          	ld	a,#9
2416  043e 42            	mul	x,a
2417  043f d6001d        	ld	a,(_buzzdrvStrategy+6,x)
2418  0442 1103          	cp	a,(OFST-2,sp)
2419  0444 2309          	jrule	L5141
2420                     ; 636 		    buzzyxmin = buzzdrvStrategy[buzzii].buzzyx;
2422  0446 d6001d        	ld	a,(_buzzdrvStrategy+6,x)
2423  0449 6b03          	ld	(OFST-2,sp),a
2424                     ; 637 			buzzeri = buzzii; 
2426  044b 7b05          	ld	a,(OFST+0,sp)
2427  044d 6b04          	ld	(OFST-1,sp),a
2428  044f               L5141:
2429                     ; 632 	 for(buzzii=0;buzzii<5;buzzii++)
2431  044f 0c05          	inc	(OFST+0,sp)
2434  0451 7b05          	ld	a,(OFST+0,sp)
2435  0453 a105          	cp	a,#5
2436  0455 25e4          	jrult	L7041
2437                     ; 640     for(buzzii=0;buzzii<5;buzzii++)
2439  0457 4f            	clr	a
2440  0458 6b05          	ld	(OFST+0,sp),a
2441  045a               L7141:
2442                     ; 642 	    if ((buzzdrvStrategy[buzzii].buzzcnt)&&(buzzii !=buzzeri ))
2444  045a 97            	ld	xl,a
2445  045b a609          	ld	a,#9
2446  045d 42            	mul	x,a
2447  045e d60018        	ld	a,(_buzzdrvStrategy+1,x)
2448  0461 da0017        	or	a,(_buzzdrvStrategy,x)
2449  0464 2760          	jreq	L5241
2451  0466 7b05          	ld	a,(OFST+0,sp)
2452  0468 1104          	cp	a,(OFST-1,sp)
2453  046a 275a          	jreq	L5241
2454                     ; 644 		    buzzdrvStrategy[buzzii].BuzzerCnt++;
2456  046c 97            	ld	xl,a
2457  046d a609          	ld	a,#9
2458  046f 42            	mul	x,a
2459  0470 9093          	ldw	y,x
2460  0472 de001e        	ldw	x,(_buzzdrvStrategy+7,x)
2461  0475 5c            	incw	x
2462  0476 90df001e      	ldw	(_buzzdrvStrategy+7,y),x
2463                     ; 645 	    	if(buzzdrvStrategy[buzzii].BuzzerCnt>=	buzzdrvStrategy[buzzii].buzzmaxtime)
2465  047a 7b05          	ld	a,(OFST+0,sp)
2466  047c 97            	ld	xl,a
2467  047d a609          	ld	a,#9
2468  047f 42            	mul	x,a
2469  0480 de0019        	ldw	x,(_buzzdrvStrategy+2,x)
2470  0483 1f01          	ldw	(OFST-4,sp),x
2471  0485 7b05          	ld	a,(OFST+0,sp)
2472  0487 97            	ld	xl,a
2473  0488 a609          	ld	a,#9
2474  048a 42            	mul	x,a
2475  048b de001e        	ldw	x,(_buzzdrvStrategy+7,x)
2476  048e 1301          	cpw	x,(OFST-4,sp)
2477  0490 2534          	jrult	L5241
2478                     ; 647 	    		buzzdrvStrategy[buzzii].BuzzerCnt= 0;
2480  0492 7b05          	ld	a,(OFST+0,sp)
2481  0494 97            	ld	xl,a
2482  0495 a609          	ld	a,#9
2483  0497 42            	mul	x,a
2484  0498 905f          	clrw	y
2485  049a df001e        	ldw	(_buzzdrvStrategy+7,x),y
2486                     ; 649 	    	    buzzdrvStrategy[buzzii].buzzcnt--;    
2488  049d 9093          	ldw	y,x
2489  049f de0017        	ldw	x,(_buzzdrvStrategy,x)
2490  04a2 5a            	decw	x
2491  04a3 90df0017      	ldw	(_buzzdrvStrategy,y),x
2492                     ; 650 				if(buzzdrvStrategy[buzzii].buzzcnt == 0)
2494  04a7 7b05          	ld	a,(OFST+0,sp)
2495  04a9 97            	ld	xl,a
2496  04aa a609          	ld	a,#9
2497  04ac 42            	mul	x,a
2498  04ad d60018        	ld	a,(_buzzdrvStrategy+1,x)
2499  04b0 da0017        	or	a,(_buzzdrvStrategy,x)
2500  04b3 2611          	jrne	L5241
2501                     ; 652 				    buzzdrvStrategy[buzzii].buzzyx = 0;
2503  04b5 d7001d        	ld	(_buzzdrvStrategy+6,x),a
2504                     ; 653 					buzzdrvStrategy[buzzii].buzzcnt= 0;
2506  04b8 905f          	clrw	y
2507  04ba df0017        	ldw	(_buzzdrvStrategy,x),y
2508                     ; 654 				    buzzdrvStrategy[buzzii].buzzmaxtime= 0;
2510  04bd df0019        	ldw	(_buzzdrvStrategy+2,x),y
2511                     ; 655 					buzzdrvStrategy[buzzii].buzzontime= 0;					
2513  04c0 df001b        	ldw	(_buzzdrvStrategy+4,x),y
2514                     ; 656 					buzzdrvStrategy[buzzii].BuzzerCnt= 0;
2516  04c3 df001e        	ldw	(_buzzdrvStrategy+7,x),y
2517  04c6               L5241:
2518                     ; 640     for(buzzii=0;buzzii<5;buzzii++)
2520  04c6 0c05          	inc	(OFST+0,sp)
2523  04c8 7b05          	ld	a,(OFST+0,sp)
2524  04ca a105          	cp	a,#5
2525  04cc 258c          	jrult	L7141
2526                     ; 662     if (buzzdrvStrategy[buzzeri].buzzcnt)
2528  04ce 7b04          	ld	a,(OFST-1,sp)
2529  04d0 97            	ld	xl,a
2530  04d1 a609          	ld	a,#9
2531  04d3 42            	mul	x,a
2532  04d4 d60018        	ld	a,(_buzzdrvStrategy+1,x)
2533  04d7 da0017        	or	a,(_buzzdrvStrategy,x)
2534  04da 2604ac820582  	jreq	L3341
2535                     ; 664 	    buzzdrvStrategy[buzzeri].BuzzerCnt++;
2537  04e0 9093          	ldw	y,x
2538  04e2 de001e        	ldw	x,(_buzzdrvStrategy+7,x)
2539  04e5 5c            	incw	x
2540  04e6 90df001e      	ldw	(_buzzdrvStrategy+7,y),x
2541                     ; 665     	if (buzzdrvStrategy[buzzeri].BuzzerCnt< buzzdrvStrategy[buzzeri].buzzontime)
2543  04ea 7b04          	ld	a,(OFST-1,sp)
2544  04ec 97            	ld	xl,a
2545  04ed a609          	ld	a,#9
2546  04ef 42            	mul	x,a
2547  04f0 de001b        	ldw	x,(_buzzdrvStrategy+4,x)
2548  04f3 1f01          	ldw	(OFST-4,sp),x
2549  04f5 7b04          	ld	a,(OFST-1,sp)
2550  04f7 97            	ld	xl,a
2551  04f8 a609          	ld	a,#9
2552  04fa 42            	mul	x,a
2553  04fb de001e        	ldw	x,(_buzzdrvStrategy+7,x)
2554  04fe 1301          	cpw	x,(OFST-4,sp)
2555  0500 2415          	jruge	L5341
2556                     ; 667     		BUZZER_ON;
2558  0502 7216500f      	bset	20495,#3
2559                     ; 668 			BuzzCANsend(buzzdrvStrategy[buzzeri].buzzyx,0x55);
2561  0506 7b04          	ld	a,(OFST-1,sp)
2562  0508 97            	ld	xl,a
2563  0509 a609          	ld	a,#9
2564  050b 42            	mul	x,a
2565  050c d6001d        	ld	a,(_buzzdrvStrategy+6,x)
2566  050f ae0055        	ldw	x,#85
2567  0512 95            	ld	xh,a
2568  0513 8d920592      	callf	f_BuzzCANsend
2570  0517               L5341:
2571                     ; 670     	if (buzzdrvStrategy[buzzeri].BuzzerCnt>= buzzdrvStrategy[buzzeri].buzzontime)
2573  0517 7b04          	ld	a,(OFST-1,sp)
2574  0519 97            	ld	xl,a
2575  051a a609          	ld	a,#9
2576  051c 42            	mul	x,a
2577  051d de001b        	ldw	x,(_buzzdrvStrategy+4,x)
2578  0520 1f01          	ldw	(OFST-4,sp),x
2579  0522 7b04          	ld	a,(OFST-1,sp)
2580  0524 97            	ld	xl,a
2581  0525 a609          	ld	a,#9
2582  0527 42            	mul	x,a
2583  0528 de001e        	ldw	x,(_buzzdrvStrategy+7,x)
2584  052b 1301          	cpw	x,(OFST-4,sp)
2585  052d 2513          	jrult	L7341
2586                     ; 672     		BUZZER_OFF;
2588  052f 7217500f      	bres	20495,#3
2589                     ; 673 			BuzzCANsend(buzzdrvStrategy[buzzeri].buzzyx,0x00);
2591  0533 7b04          	ld	a,(OFST-1,sp)
2592  0535 97            	ld	xl,a
2593  0536 a609          	ld	a,#9
2594  0538 42            	mul	x,a
2595  0539 d6001d        	ld	a,(_buzzdrvStrategy+6,x)
2596  053c 5f            	clrw	x
2597  053d 95            	ld	xh,a
2598  053e 8d920592      	callf	f_BuzzCANsend
2600  0542               L7341:
2601                     ; 675     	if(buzzdrvStrategy[buzzeri].BuzzerCnt>=	buzzdrvStrategy[buzzeri].buzzmaxtime)
2603  0542 7b04          	ld	a,(OFST-1,sp)
2604  0544 97            	ld	xl,a
2605  0545 a609          	ld	a,#9
2606  0547 42            	mul	x,a
2607  0548 de0019        	ldw	x,(_buzzdrvStrategy+2,x)
2608  054b 1f01          	ldw	(OFST-4,sp),x
2609  054d 7b04          	ld	a,(OFST-1,sp)
2610  054f 97            	ld	xl,a
2611  0550 a609          	ld	a,#9
2612  0552 42            	mul	x,a
2613  0553 de001e        	ldw	x,(_buzzdrvStrategy+7,x)
2614  0556 1301          	cpw	x,(OFST-4,sp)
2615  0558 2535          	jrult	L5441
2616                     ; 677     		buzzdrvStrategy[buzzeri].BuzzerCnt= 0;
2618  055a 7b04          	ld	a,(OFST-1,sp)
2619  055c 97            	ld	xl,a
2620  055d a609          	ld	a,#9
2621  055f 42            	mul	x,a
2622  0560 905f          	clrw	y
2623  0562 df001e        	ldw	(_buzzdrvStrategy+7,x),y
2624                     ; 679     	    buzzdrvStrategy[buzzeri].buzzcnt--;    
2626  0565 9093          	ldw	y,x
2627  0567 de0017        	ldw	x,(_buzzdrvStrategy,x)
2628  056a 5a            	decw	x
2629  056b 90df0017      	ldw	(_buzzdrvStrategy,y),x
2630                     ; 680 			if(buzzdrvStrategy[buzzeri].buzzcnt == 0) buzzdrvStrategy[buzzeri].buzzyx = 0;
2632  056f 7b04          	ld	a,(OFST-1,sp)
2633  0571 97            	ld	xl,a
2634  0572 a609          	ld	a,#9
2635  0574 42            	mul	x,a
2636  0575 d60018        	ld	a,(_buzzdrvStrategy+1,x)
2637  0578 da0017        	or	a,(_buzzdrvStrategy,x)
2638  057b 2612          	jrne	L5441
2641  057d d7001d        	ld	(_buzzdrvStrategy+6,x),a
2642  0580 200d          	jra	L5441
2643  0582               L3341:
2644                     ; 685          	BUZZER_OFF;
2646  0582 7217500f      	bres	20495,#3
2647                     ; 686 		BuzzCANsend(buzzdrvStrategy[buzzeri].buzzyx,0x00);
2649  0586 d6001d        	ld	a,(_buzzdrvStrategy+6,x)
2650  0589 5f            	clrw	x
2651  058a 95            	ld	xh,a
2652  058b 8d920592      	callf	f_BuzzCANsend
2654  058f               L5441:
2655                     ; 690 }
2658  058f 5b05          	addw	sp,#5
2659  0591 87            	retf	
2698                     ; 692 void BuzzCANsend(uchar BUZZYX,uchar zt)
2698                     ; 693 {
2699                     	switch	.text
2700  0592               f_BuzzCANsend:
2702  0592 89            	pushw	x
2703       00000000      OFST:	set	0
2706                     ; 694     if(zt == ON)
2708  0593 9f            	ld	a,xl
2709  0594 a155          	cp	a,#85
2710  0596 2609          	jrne	L5641
2711                     ; 696         CanSendData[7]=(CanSendData[7]&0XE0)|BUZZYX;
2713  0598 c60007        	ld	a,_CanSendData+7
2714  059b a4e0          	and	a,#224
2715  059d 1a01          	or	a,(OFST+1,sp)
2717  059f 2005          	jra	L7641
2718  05a1               L5641:
2719                     ; 700 		CanSendData[7]=CanSendData[7]&0XE0;
2721  05a1 c60007        	ld	a,_CanSendData+7
2722  05a4 a4e0          	and	a,#224
2723  05a6               L7641:
2724  05a6 c70007        	ld	_CanSendData+7,a
2725                     ; 702 }
2728  05a9 85            	popw	x
2729  05aa 87            	retf	
2921                     	switch	.bss
2922  0017               _buzzdrvStrategy:
2923  0017 000000000000  	ds.b	45
2924                     	xdef	_buzzdrvStrategy
2925  0044               _SeatWarnOld_state:
2926  0044 00            	ds.b	1
2927                     	xdef	_SeatWarnOld_state
2928  0045               _SeatWarnType:
2929  0045 00            	ds.b	1
2930                     	xdef	_SeatWarnType
2931                     	xref	_StandByState
2932                     	xref	_RKE_AutoLockFlag
2933  0046               _RKEBatteryVoltage_turn:
2934  0046 00            	ds.b	1
2935                     	xdef	_RKEBatteryVoltage_turn
2936                     	xdef	f_BuzzCANsend
2937                     	xdef	f_ClearBuzzdrv
2938                     	xdef	f_BuzzerDrv
2939                     	xdef	f_buzzdrv2
2940                     	xdef	f_ScanStandbySmallLampSwitch
2941                     	xdef	f_ScanFortifySWState
2942                     	xdef	f_ScanStandByDoorAjarSwitch
2943                     	xdef	f_JudgeWarmTypeAndDriver
2944                     	xdef	f_ScanSeatPositionState
2945                     	xdef	f_ScanSeatbeltBuckleState
2946                     	xdef	f_ScanAllDoorState
2947                     	xdef	f_ScanSmallLampSwitch
2948                     	xdef	f_ScanKeyInState
2949  0047               _Buzzertime:
2950  0047 00            	ds.b	1
2951                     	xdef	_Buzzertime
2952  0048               _RKEopenTrunkWarm:
2953  0048 00            	ds.b	1
2954                     	xdef	_RKEopenTrunkWarm
2955  0049               _TrunkWarmTime:
2956  0049 0000          	ds.b	2
2957                     	xdef	_TrunkWarmTime
2958  004b               _WarmType:
2959  004b 00            	ds.b	1
2960                     	xdef	_WarmType
2961  004c               _FORTIFYSW_state:
2962  004c 00            	ds.b	1
2963                     	xdef	_FORTIFYSW_state
2964  004d               _CarSpeed:
2965  004d 000000000000  	ds.b	6
2966                     	xdef	_CarSpeed
2967  0053               _BuzzerPeriod:
2968  0053 00            	ds.b	1
2969                     	xdef	_BuzzerPeriod
2970  0054               _BuzzerDuty:
2971  0054 00            	ds.b	1
2972                     	xdef	_BuzzerDuty
2973  0055               _BuzzerOnCnt:
2974  0055 00            	ds.b	1
2975                     	xdef	_BuzzerOnCnt
2976  0056               _SeatState:
2977  0056 00            	ds.b	1
2978                     	xdef	_SeatState
2979  0057               _CarState:
2980  0057 00            	ds.b	1
2981                     	xdef	_CarState
2982  0058               _DoorState:
2983  0058 00            	ds.b	1
2984                     	xdef	_DoorState
2985  0059               _SmallLampSwitchState:
2986  0059 00            	ds.b	1
2987                     	xdef	_SmallLampSwitchState
2988  005a               _KeyInState:
2989  005a 00            	ds.b	1
2990                     	xdef	_KeyInState
2991                     	xref	_H4021Data1
2992                     	xref	_IGNstate
2993                     	xref	_CanSendData
3013                     	xref	d_lcmp
3014                     	xref	d_uitolx
3015                     	end
