   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 776                     	switch	.data
 777  0000               _BUZZLocktimecnt:
 778  0000 0000          	dc.w	0
 813                     ; 85 void SaveWindowDriverState(void)
 813                     ; 86 {
 814                     	switch	.text
 815  0000               f_SaveWindowDriverState:
 819                     ; 87       WindowDriverState = 0;
 821  0000 725f0045      	clr	_WindowDriverState
 822                     ; 89       if      (WIN_FL_UP_OUT)     {WindowDriverState |= flwu; WIN_FL_UP_OFF;}
 824  0004 7209500009    	btjf	20480,#4,L154
 827  0009 72100045      	bset	_WindowDriverState,#0
 830  000d 72195000      	bres	20480,#4
 833  0011 87            	retf	
 834  0012               L154:
 835                     ; 90       else if (WIN_FL_DOWN_OUT)   {WindowDriverState |= flwd; WIN_FL_DOWN_OFF;}
 837  0012 720b500008    	btjf	20480,#5,L354
 840  0017 72120045      	bset	_WindowDriverState,#1
 843  001b 721b5000      	bres	20480,#5
 844  001f               L354:
 845                     ; 92 }
 848  001f 87            	retf	
 872                     ; 104 void ResumeWindowDriverState(void)
 872                     ; 105 {
 873                     	switch	.text
 874  0020               f_ResumeWindowDriverState:
 878                     ; 106       if (!WindowDriverState) return;
 880  0020 c60045        	ld	a,_WindowDriverState
 881  0023 2601          	jrne	L764
 885  0025 87            	retf	
 886  0026               L764:
 887                     ; 108       if      (WindowDriverState & flwu) WIN_FL_UP_ON;
 889  0026 a501          	bcp	a,#1
 890  0028 2706          	jreq	L174
 893  002a 72185000      	bset	20480,#4
 895  002e 2008          	jra	L374
 896  0030               L174:
 897                     ; 109       else if (WindowDriverState & flwd) WIN_FL_DOWN_ON;
 899  0030 a502          	bcp	a,#2
 900  0032 2704          	jreq	L374
 903  0034 721a5000      	bset	20480,#5
 904  0038               L374:
 905                     ; 112       WindowDriverState = 0;
 907  0038 725f0045      	clr	_WindowDriverState
 908                     ; 113 }
 911  003c 87            	retf	
 913                     	switch	.bss
 914  0000               L774_crashCnt:
 915  0000 0000          	ds.b	2
 916  0002               L105_nocrashCnt:
 917  0002 00            	ds.b	1
 918  0003               L305_signalstate:
 919  0003 0000          	ds.b	2
 974                     ; 129 void ScanCrashInSignal(void)
 974                     ; 130 {
 975                     	switch	.text
 976  003d               f_ScanCrashInSignal:
 980                     ; 136        if (IGNstate == OFF) 
 982  003d c60000        	ld	a,_IGNstate
 983  0040 2608          	jrne	L525
 984                     ; 138             crashCnt = 0;
 986  0042 5f            	clrw	x
 987  0043 cf0000        	ldw	L774_crashCnt,x
 988                     ; 139 		nocrashCnt = 0;
 990  0046 c70002        	ld	L105_nocrashCnt,a
 991                     ; 140             return;
 994  0049 87            	retf	
 995  004a               L525:
 996                     ; 142        Crash_CAN();
 998  004a 8d150115      	callf	f_Crash_CAN
1000                     ; 144        if (!CRASH_IN)
1002  004e 7204500b73    	btjt	20491,#2,L725
1003                     ; 146             nocrashCnt = 0;
1005  0053 725f0002      	clr	L105_nocrashCnt
1006                     ; 149             if (crashCnt < 20)
1008  0057 ce0000        	ldw	x,L774_crashCnt
1009  005a a30014        	cpw	x,#20
1010  005d 2404          	jruge	L135
1011                     ; 151                   crashCnt++;			
1013  005f 5c            	incw	x
1014  0060 cf0000        	ldw	L774_crashCnt,x
1015  0063               L135:
1016                     ; 153             if (crashCnt == 20)
1018  0063 a30014        	cpw	x,#20
1019  0066 2636          	jrne	L335
1020                     ; 156                  crashCnt++;
1022  0068 5c            	incw	x
1023  0069 cf0000        	ldw	L774_crashCnt,x
1024                     ; 157                  CrashState = IsCrashed;
1026  006c 35550056      	mov	_CrashState,#85
1027                     ; 159                  LockDrvCmd |= UnlockDriverDoorCmd;
1029  0070 721e0055      	bset	_LockDrvCmd,#7
1030                     ; 160 				 crashlockstate = 0x55;
1032  0074 3555004b      	mov	_crashlockstate,#85
1033                     ; 162                  SaveWindowDriverState();  
1035  0078 8d000000      	callf	f_SaveWindowDriverState
1037                     ; 163                  if(WindowDriverState != 0x00)
1039  007c c60045        	ld	a,_WindowDriverState
1040  007f 2705          	jreq	L535
1041                     ; 165                       WindowDriverStateKeep=WindowDriverState;
1043  0081 5500450043    	mov	_WindowDriverStateKeep,_WindowDriverState
1044  0086               L535:
1045                     ; 168                  TurnLampDrv |= TurnLampCrashOn;
1047  0086 72160000      	bset	_TurnLampDrv,#3
1048                     ; 169                  TurnLamp_CrashKeepTime = CRASHKEEPTIME;
1050  008a ae01f4        	ldw	x,#500
1051  008d cf0000        	ldw	_TurnLamp_CrashKeepTime,x
1052                     ; 170 				 charshtime = 625;
1054  0090 ae0271        	ldw	x,#625
1055  0093 cf0041        	ldw	_charshtime,x
1056                     ; 171                  signalstate=AGAIN_UNLOCK_TIME;
1058  0096 ae0177        	ldw	x,#375
1059  0099 cf0003        	ldw	L305_signalstate,x
1061  009c 2045          	jra	L155
1062  009e               L335:
1063                     ; 173             else if (crashCnt < AGAIN_UNLOCK_TIME)
1065  009e a30177        	cpw	x,#375
1066  00a1 2406          	jruge	L145
1067                     ; 175                  crashCnt++;
1069  00a3 5c            	incw	x
1070  00a4 cf0000        	ldw	L774_crashCnt,x
1072  00a7 203a          	jra	L155
1073  00a9               L145:
1074                     ; 177             else if (crashCnt == AGAIN_UNLOCK_TIME)
1076  00a9 a30177        	cpw	x,#375
1077  00ac 2635          	jrne	L155
1078                     ; 180                  crashCnt++;
1080  00ae 5c            	incw	x
1081  00af cf0000        	ldw	L774_crashCnt,x
1082                     ; 181                  LockDrvCmd |= UnlockDriverDoorCmd;
1084  00b2 721e0055      	bset	_LockDrvCmd,#7
1085                     ; 182                  SaveWindowDriverState();  
1087  00b6 8d000000      	callf	f_SaveWindowDriverState
1089                     ; 183                  if(WindowDriverState != 0x00)
1091  00ba c60045        	ld	a,_WindowDriverState
1092  00bd 2724          	jreq	L155
1093                     ; 185                       WindowDriverStateKeep=WindowDriverState;
1095  00bf 5500450043    	mov	_WindowDriverStateKeep,_WindowDriverState
1096  00c4 201d          	jra	L155
1097  00c6               L725:
1098                     ; 191             crashCnt = 0;
1100  00c6 5f            	clrw	x
1101  00c7 cf0000        	ldw	L774_crashCnt,x
1102                     ; 193             if (nocrashCnt < KEY_FILTER_CNT)
1104  00ca c60002        	ld	a,L105_nocrashCnt
1105  00cd a105          	cp	a,#5
1106  00cf 2406          	jruge	L355
1107                     ; 195                   nocrashCnt++;			
1109  00d1 725c0002      	inc	L105_nocrashCnt
1111  00d5 200c          	jra	L155
1112  00d7               L355:
1113                     ; 197             else if (nocrashCnt == KEY_FILTER_CNT)
1115  00d7 a105          	cp	a,#5
1116  00d9 2608          	jrne	L155
1117                     ; 199                  nocrashCnt++;
1119  00db 725c0002      	inc	L105_nocrashCnt
1120                     ; 200                  CrashState = NoCrashed;
1122  00df 725f0056      	clr	_CrashState
1123  00e3               L155:
1124                     ; 204        if(signalstate != 0)
1126  00e3 ce0003        	ldw	x,L305_signalstate
1127  00e6 271c          	jreq	L165
1128                     ; 206             signalstate--;
1130  00e8 5a            	decw	x
1131  00e9 cf0003        	ldw	L305_signalstate,x
1132                     ; 207             if(signalstate==0)
1134  00ec 2616          	jrne	L165
1135                     ; 209                  crashlockstate = 0x55;
1137  00ee 3555004b      	mov	_crashlockstate,#85
1138                     ; 210                  LockDrvCmd |= UnlockDriverDoorCmd;
1140  00f2 721e0055      	bset	_LockDrvCmd,#7
1141                     ; 212                  SaveWindowDriverState();  
1143  00f6 8d000000      	callf	f_SaveWindowDriverState
1145                     ; 213                  if(WindowDriverState != 0x00)
1147  00fa c60045        	ld	a,_WindowDriverState
1148  00fd 2705          	jreq	L165
1149                     ; 215                        WindowDriverStateKeep=WindowDriverState;
1151  00ff 5500450043    	mov	_WindowDriverStateKeep,_WindowDriverState
1152  0104               L165:
1153                     ; 221        if((TurnLamp_CrashKeepTime)&&(LockDrvCmd == LockCmd))
1155  0104 ce0000        	ldw	x,_TurnLamp_CrashKeepTime
1156  0107 270b          	jreq	L765
1158  0109 c60055        	ld	a,_LockDrvCmd
1159  010c a120          	cp	a,#32
1160  010e 2604          	jrne	L765
1161                     ; 223                LockDrvCmd = 0;
1163  0110 725f0055      	clr	_LockDrvCmd
1164  0114               L765:
1165                     ; 227 }
1168  0114 87            	retf	
1170                     	switch	.bss
1171  0005               L175_CAN_Crashstate:
1172  0005 0000          	ds.b	2
1208                     ; 229 void Crash_CAN(void)
1208                     ; 230 {
1209                     	switch	.text
1210  0115               f_Crash_CAN:
1214                     ; 232       if(CAN_Crash == 0x55)
1216  0115 c60000        	ld	a,_CAN_Crash
1217  0118 a155          	cp	a,#85
1218  011a 2624          	jrne	L706
1219                     ; 234              CAN_Crash = 0;
1221  011c 725f0000      	clr	_CAN_Crash
1222                     ; 235 	      if((TurnLampDrv & TurnLampCrashOn)== 0)
1224  0120 720600001b    	btjt	_TurnLampDrv,#3,L706
1225                     ; 237 		      CAN_Crashstate = 500;
1227  0125 ae01f4        	ldw	x,#500
1228  0128 cf0005        	ldw	L175_CAN_Crashstate,x
1229                     ; 238 		      CrashState  =Pressed;
1231  012b 35550056      	mov	_CrashState,#85
1232                     ; 239 		      LockDrvCmd |= UnlockDriverDoorCmd;
1234  012f 721e0055      	bset	_LockDrvCmd,#7
1235                     ; 240 		      TurnLampDrv |= TurnLampCrashOn;
1237  0133 72160000      	bset	_TurnLampDrv,#3
1238                     ; 241 		      TurnLamp_CrashKeepTime = CRASHKEEPTIME;
1240  0137 cf0000        	ldw	_TurnLamp_CrashKeepTime,x
1241                     ; 242 			  charshtime = 625;
1243  013a ae0271        	ldw	x,#625
1244  013d cf0041        	ldw	_charshtime,x
1245  0140               L706:
1246                     ; 245 	if(CAN_Crashstate != 0) 
1248  0140 ce0005        	ldw	x,L175_CAN_Crashstate
1249  0143 270e          	jreq	L316
1250                     ; 247             CAN_Crashstate--;
1252  0145 5a            	decw	x
1253  0146 cf0005        	ldw	L175_CAN_Crashstate,x
1254                     ; 248             if(CAN_Crashstate == 0){LockDrvCmd |= UnlockDriverDoorCmd;CrashState = NoCrashed;}
1256  0149 2608          	jrne	L316
1259  014b 721e0055      	bset	_LockDrvCmd,#7
1262  014f 725f0056      	clr	_CrashState
1263  0153               L316:
1264                     ; 252 }
1267  0153 87            	retf	
1291                     ; 266 void ScanStandByCrashInSignal(void)
1291                     ; 267 {
1292                     	switch	.text
1293  0154               f_ScanStandByCrashInSignal:
1297                     ; 269 	if(!CRASH_IN) 
1299  0154 7204500b04    	btjt	20491,#2,L726
1300                     ; 271        	StandByState = Pressed;    //此状态退出低功耗后应请除
1302  0159 35550000      	mov	_StandByState,#85
1303  015d               L726:
1304                     ; 274 	if(!UNLOCK_STA)
1306  015d 720a501504    	btjt	20501,#5,L136
1307                     ; 276 		StandByState = Pressed;
1309  0162 35550000      	mov	_StandByState,#85
1310  0166               L136:
1311                     ; 278 }
1314  0166 87            	retf	
1316                     	switch	.bss
1317  0007               L146_Errorcnt2:
1318  0007 00            	ds.b	1
1319  0008               L736_Errorcnt1:
1320  0008 00            	ds.b	1
1321  0009               L536_unlockCnt:
1322  0009 00            	ds.b	1
1323  000a               L336_lockCnt:
1324  000a 00            	ds.b	1
1377                     ; 290 void ScanAllLockState(void)
1377                     ; 291 {
1378                     	switch	.text
1379  0167               f_ScanAllLockState:
1383                     ; 296 	if (!LOCK_STA)
1385  0167 7206500624    	btjt	20486,#3,L566
1386                     ; 298 		if (lockCnt < 5) lockCnt++;
1388  016c c6000a        	ld	a,L336_lockCnt
1389  016f a105          	cp	a,#5
1390  0171 2407          	jruge	L766
1393  0173 725c000a      	inc	L336_lockCnt
1394  0177 c6000a        	ld	a,L336_lockCnt
1395  017a               L766:
1396                     ; 299 		if (lockCnt == 5)
1398  017a a105          	cp	a,#5
1399  017c 2616          	jrne	L376
1400                     ; 301 			lockCnt++;
1402  017e 725c000a      	inc	L336_lockCnt
1403                     ; 302 			LockState = Locked;
1405  0182 35550057      	mov	_LockState,#85
1406                     ; 303 			CAN_LOCKstate_lock;
1408  0186 c60005        	ld	a,_CanSendData+5
1409  0189 a4fc          	and	a,#252
1410  018b c70005        	ld	_CanSendData+5,a
1411  018e 2004          	jra	L376
1412  0190               L566:
1413                     ; 309 		lockCnt = 0;
1415  0190 725f000a      	clr	L336_lockCnt
1416  0194               L376:
1417                     ; 312 	if (!UNLOCK_STA)
1419  0194 720a501520    	btjt	20501,#5,L576
1420                     ; 314 		if (unlockCnt < 5) unlockCnt++;
1422  0199 c60009        	ld	a,L536_unlockCnt
1423  019c a105          	cp	a,#5
1424  019e 2407          	jruge	L776
1427  01a0 725c0009      	inc	L536_unlockCnt
1428  01a4 c60009        	ld	a,L536_unlockCnt
1429  01a7               L776:
1430                     ; 315 		if (unlockCnt == 5)
1432  01a7 a105          	cp	a,#5
1433  01a9 2612          	jrne	L307
1434                     ; 317 			unlockCnt++;
1436  01ab 725c0009      	inc	L536_unlockCnt
1437                     ; 318 			LockState = Unlocked;
1439  01af 725f0057      	clr	_LockState
1440                     ; 319 			CAN_LOCKstate_unlock;
1442  01b3 72100005      	bset	_CanSendData+5,#0
1443  01b7 2004          	jra	L307
1444  01b9               L576:
1445                     ; 325 		unlockCnt = 0;
1447  01b9 725f0009      	clr	L536_unlockCnt
1448  01bd               L307:
1449                     ; 328 	if((!UNLOCK_STA)&&(!LOCK_STA))
1451  01bd 720a50151b    	btjt	20501,#5,L507
1453  01c2 7206500616    	btjt	20486,#3,L507
1454                     ; 330       if(Errorcnt1 < 40)Errorcnt1++;
1456  01c7 c60008        	ld	a,L736_Errorcnt1
1457  01ca a128          	cp	a,#40
1458  01cc 2405          	jruge	L707
1461  01ce 725c0008      	inc	L736_Errorcnt1
1464  01d2 87            	retf	
1465  01d3               L707:
1466                     ; 331 	  else if(Errorcnt1 == 40)
1468  01d3 a128          	cp	a,#40
1469  01d5 2635          	jrne	L517
1470                     ; 333 	    Errorcnt1++;
1472  01d7 725c0008      	inc	L736_Errorcnt1
1473                     ; 334 		CAN_LOCKstate_Error;
1474  01db 201e          	jpf	LC001
1475  01dd               L507:
1476                     ; 337 	else if((UNLOCK_STA)&&(LOCK_STA))
1478  01dd 720b501522    	btjf	20501,#5,L717
1480  01e2 720750061d    	btjf	20486,#3,L717
1481                     ; 339 	    if(Errorcnt2 < 40)Errorcnt2++;
1483  01e7 c60007        	ld	a,L146_Errorcnt2
1484  01ea a128          	cp	a,#40
1485  01ec 2405          	jruge	L127
1488  01ee 725c0007      	inc	L146_Errorcnt2
1491  01f2 87            	retf	
1492  01f3               L127:
1493                     ; 340 		else if(Errorcnt2 == 40)
1495  01f3 a128          	cp	a,#40
1496  01f5 2615          	jrne	L517
1497                     ; 342 		   Errorcnt2++;
1499  01f7 725c0007      	inc	L146_Errorcnt2
1500                     ; 343 		   CAN_LOCKstate_Error;
1502  01fb               LC001:
1504  01fb c60005        	ld	a,_CanSendData+5
1505  01fe aa03          	or	a,#3
1506  0200 c70005        	ld	_CanSendData+5,a
1508  0203 87            	retf	
1509  0204               L717:
1510                     ; 348         Errorcnt2 = 0;
1512  0204 725f0007      	clr	L146_Errorcnt2
1513                     ; 349 		Errorcnt1 = 0;
1515  0208 725f0008      	clr	L736_Errorcnt1
1516  020c               L517:
1517                     ; 352 }
1520  020c 87            	retf	
1522                     	switch	.data
1523  0002               L347_fif4time:
1524  0002 00            	dc.b	0
1525                     	switch	.bss
1526  000b               L337_UnlockCnt:
1527  000b 00            	ds.b	1
1528  000c               L137_LockCnt:
1529  000c 00            	ds.b	1
1530  000d               L537_lockdrvstatebf:
1531  000d 00            	ds.b	1
1532  000e               L737_Ignold:
1533  000e 00            	ds.b	1
1621                     ; 366 void ScanCentralLockSwitch(void)
1621                     ; 367 {
1622                     	switch	.text
1623  020d               f_ScanCentralLockSwitch:
1625  020d 5203          	subw	sp,#3
1626       00000003      OFST:	set	3
1629                     ; 375    	LockSwitchADV = GetADCresultAverage(0);
1631  020f 4f            	clr	a
1632  0210 8d000000      	callf	f_GetADCresultAverage
1634  0214 1f01          	ldw	(OFST-2,sp),x
1635                     ; 377     if (LockSwitchADV < UNLOCK_SW_ADV)
1637  0216 a30046        	cpw	x,#70
1638  0219 2404          	jruge	L577
1639                     ; 379     	 LockSwitchState = UnlockSWpressed;
1641  021b a602          	ld	a,#2
1643  021d 200a          	jpf	L777
1644  021f               L577:
1645                     ; 382     else if (LockSwitchADV < LOCK_SW_ADV)
1647  021f a30320        	cpw	x,#800
1648  0222 2404          	jruge	L1001
1649                     ; 384     	 LockSwitchState = LockSWpressed;
1651  0224 a601          	ld	a,#1
1653  0226 2001          	jra	L777
1654  0228               L1001:
1655                     ; 388     	 LockSwitchState = LockUnlockSWunpressed;
1657  0228 4f            	clr	a
1658  0229               L777:
1659  0229 6b03          	ld	(OFST+0,sp),a
1660                     ; 393     if (LockSwitchState == UnlockSWpressed)
1662  022b a102          	cp	a,#2
1663  022d 2639          	jrne	L5001
1664                     ; 395         LockCnt=0;
1666  022f 725f000c      	clr	L137_LockCnt
1667                     ; 396         if (UnlockCnt < AD_KEY_FILTER_CNT) 
1669  0233 c6000b        	ld	a,L337_UnlockCnt
1670  0236 a10f          	cp	a,#15
1671  0238 2408          	jruge	L7001
1672                     ; 398         	UnlockCnt++;
1674  023a 725c000b      	inc	L337_UnlockCnt
1676  023e acd902d9      	jra	L3201
1677  0242               L7001:
1678                     ; 400         else if (UnlockCnt == AD_KEY_FILTER_CNT)
1680  0242 a10f          	cp	a,#15
1681  0244 26f8          	jrne	L3201
1682                     ; 402                 UnlockCnt++;
1684  0246 725c000b      	inc	L337_UnlockCnt
1685                     ; 403                 if(wLockProtectTimeCnt ==0)TurnFlashCnt = 1;//20100719
1687  024a ce0050        	ldw	x,_wLockProtectTimeCnt
1688  024d 2603          	jrne	L5101
1691  024f 5c            	incw	x
1693  0250 2001          	jra	L7101
1694  0252               L5101:
1695                     ; 404                 else TurnFlashCnt = 0;
1697  0252 5f            	clrw	x
1698  0253               L7101:
1699                     ; 405                 if(IGNstate == ON) TurnFlashCnt = 0;
1701  0253 c60000        	ld	a,_IGNstate
1702  0256 a155          	cp	a,#85
1703  0258 2601          	jrne	L1201
1706  025a 5f            	clrw	x
1707  025b               L1201:
1708  025b cf0000        	ldw	_TurnFlashCnt,x
1709                     ; 406                 RKELOCKstate = 0x55;
1711  025e 35550000      	mov	_RKELOCKstate,#85
1712                     ; 407                 LockDrvCmd = (UnlockDriverDoorCmd);    
1714  0262 35800055      	mov	_LockDrvCmd,#128
1715  0266 2071          	jra	L3201
1716  0268               L5001:
1717                     ; 410     else if (LockSwitchState == LockSWpressed)
1719  0268 4a            	dec	a
1720  0269 2666          	jrne	L5201
1721                     ; 412           UnlockCnt = 0;
1723  026b c7000b        	ld	L337_UnlockCnt,a
1724                     ; 413           if (LockCnt < AD_KEY_FILTER_CNT) 
1726  026e c6000c        	ld	a,L137_LockCnt
1727  0271 a10f          	cp	a,#15
1728  0273 2406          	jruge	L7201
1729                     ; 415               LockCnt++;
1731  0275 725c000c      	inc	L137_LockCnt
1733  0279 205e          	jra	L3201
1734  027b               L7201:
1735                     ; 417           else if (LockCnt == AD_KEY_FILTER_CNT)
1737  027b a10f          	cp	a,#15
1738  027d 265a          	jrne	L3201
1739                     ; 419                  LockCnt++;
1741  027f 725c000c      	inc	L137_LockCnt
1742                     ; 420                  if(wLockProtectTimeCnt ==0)TurnFlashCnt = 2 ;   //new 20100719
1744  0283 ce0050        	ldw	x,_wLockProtectTimeCnt
1745  0286 2605          	jrne	L5301
1748  0288 ae0002        	ldw	x,#2
1750  028b 2001          	jra	L7301
1751  028d               L5301:
1752                     ; 421                  else  TurnFlashCnt = 0;
1754  028d 5f            	clrw	x
1755  028e               L7301:
1756                     ; 422                  if(IGNstate == ON) TurnFlashCnt = 0;
1758  028e c60000        	ld	a,_IGNstate
1759  0291 a155          	cp	a,#85
1760  0293 2601          	jrne	L1401
1763  0295 5f            	clrw	x
1764  0296               L1401:
1765  0296 cf0000        	ldw	_TurnFlashCnt,x
1766                     ; 423                  LockDrvCmd = LockCmd;
1768  0299 35200055      	mov	_LockDrvCmd,#32
1769                     ; 424                  RKELOCKstate =0xaa;
1771  029d 35aa0000      	mov	_RKELOCKstate,#170
1772                     ; 425                  if ((LockState == Unlocked)&&(DoorState & 0x1b))//取消后备箱状态
1774  02a1 c60057        	ld	a,_LockState
1775  02a4 2633          	jrne	L3201
1777  02a6 c60000        	ld	a,_DoorState
1778  02a9 a51b          	bcp	a,#27
1779  02ab 272c          	jreq	L3201
1780                     ; 430                            if(KeyInState == KeyIsOutHole)
1782  02ad c60000        	ld	a,_KeyInState
1783  02b0 2627          	jrne	L3201
1784                     ; 432                                     HornDoorunclosetime = 6;
1786  02b2 ae0006        	ldw	x,#6
1787  02b5 cf0000        	ldw	_HornDoorunclosetime,x
1788                     ; 433 					 BuzzerDrv(1,376,375,Buzzlockdoorunclose);
1790  02b8 4b15          	push	#21
1791  02ba ae0177        	ldw	x,#375
1792  02bd 89            	pushw	x
1793  02be 5c            	incw	x
1794  02bf 89            	pushw	x
1795  02c0 4c            	inc	a
1796  02c1 8d000000      	callf	f_BuzzerDrv
1798  02c5 5b05          	addw	sp,#5
1799                     ; 434 					 dooropenlock = 50;
1801  02c7 35320049      	mov	_dooropenlock,#50
1802                     ; 435 					 TurnFlashCnt = 0;
1804  02cb 5f            	clrw	x
1805  02cc cf0000        	ldw	_TurnFlashCnt,x
1806  02cf 2008          	jra	L3201
1807  02d1               L5201:
1808                     ; 443     	LockCnt = 0;
1810  02d1 725f000c      	clr	L137_LockCnt
1811                     ; 444     	UnlockCnt = 0;
1813  02d5 725f000b      	clr	L337_UnlockCnt
1814  02d9               L3201:
1815                     ; 447     if((Speedlockcnt >= 15)&&(IGNstate == ON)&&(DoorState == AllDoorIsClosed)&&(LockState == Unlocked)&&(lockdrvstatebf != 0x55)&&(DIDF1F4EEPROM[0] & Speedlock))//&&(Speedlockset))
1817  02d9 c60048        	ld	a,_Speedlockcnt
1818  02dc a10f          	cp	a,#15
1819  02de 2527          	jrult	L1501
1821  02e0 c60000        	ld	a,_IGNstate
1822  02e3 a155          	cp	a,#85
1823  02e5 2620          	jrne	L1501
1825  02e7 c60000        	ld	a,_DoorState
1826  02ea 261b          	jrne	L1501
1828  02ec c60057        	ld	a,_LockState
1829  02ef 2616          	jrne	L1501
1831  02f1 c6000d        	ld	a,L537_lockdrvstatebf
1832  02f4 a155          	cp	a,#85
1833  02f6 270f          	jreq	L1501
1835  02f8 720100000a    	btjf	_DIDF1F4EEPROM,#0,L1501
1836                     ; 449               lockdrvstatebf = 0x55;
1838  02fd 3555000d      	mov	L537_lockdrvstatebf,#85
1839                     ; 450 		      LockDrvCmd = LockCmd; 	
1841  0301 35200055      	mov	_LockDrvCmd,#32
1843  0305 200e          	jra	L3501
1844  0307               L1501:
1845                     ; 452 	else if((DoorState != AllDoorIsClosed)||(IGNstate == OFF))
1847  0307 c60000        	ld	a,_DoorState
1848  030a 2605          	jrne	L7501
1850  030c c60000        	ld	a,_IGNstate
1851  030f 2604          	jrne	L3501
1852  0311               L7501:
1853                     ; 454 	     lockdrvstatebf = 0; 
1855  0311 725f000d      	clr	L537_lockdrvstatebf
1856  0315               L3501:
1857                     ; 458 	if(KeyInState != Ignold)
1859  0315 c60000        	ld	a,_KeyInState
1860  0318 c1000e        	cp	a,L737_Ignold
1861  031b 271e          	jreq	L1601
1862                     ; 460               Ignold =  KeyInState ;
1864  031d 550000000e    	mov	L737_Ignold,_KeyInState
1865                     ; 461 	       if((IGNstate == OFF)&&(DIDF1F4EEPROM[0] & Speedlock)&&(KeyInState==KeyIsOutHole))//20120328  取消锁状态限制
1867  0322 c60000        	ld	a,_IGNstate
1868  0325 2614          	jrne	L1601
1870  0327 720100000f    	btjf	_DIDF1F4EEPROM,#0,L1601
1872  032c c60000        	ld	a,_KeyInState
1873  032f 260a          	jrne	L1601
1874                     ; 463                    LockDrvCmd = UnlockDriverDoorCmd;
1876  0331 35800055      	mov	_LockDrvCmd,#128
1877                     ; 464 		     TurnFlashCnt = 1;
1879  0335 ae0001        	ldw	x,#1
1880  0338 cf0000        	ldw	_TurnFlashCnt,x
1881  033b               L1601:
1882                     ; 477 	if(speedlockset == 0x55)
1884  033b c60058        	ld	a,_speedlockset
1885  033e a155          	cp	a,#85
1886  0340 261d          	jrne	L5601
1887                     ; 479 	         if(DIDF1F4EEPROM[0] & Speedlock) BuzzerDrv(1,126,125,buzzspeedlockon);
1889  0342 7201000004    	btjf	_DIDF1F4EEPROM,#0,L7601
1892  0347 4b02          	push	#2
1895  0349 2002          	jra	L1701
1896  034b               L7601:
1897                     ; 480 		  else  BuzzerDrv(1,126,125,buzzspeedlockoff);
1899  034b 4b03          	push	#3
1901  034d               L1701:
1902  034d ae007d        	ldw	x,#125
1903  0350 89            	pushw	x
1904  0351 5c            	incw	x
1905  0352 89            	pushw	x
1906  0353 a601          	ld	a,#1
1907  0355 8d000000      	callf	f_BuzzerDrv
1908  0359 5b05          	addw	sp,#5
1909                     ; 481 		  speedlockset = 0;		
1911  035b 725f0058      	clr	_speedlockset
1912  035f               L5601:
1913                     ; 483 }
1916  035f 5b03          	addw	sp,#3
1917  0361 87            	retf	
1919                     	switch	.bss
1920  000f               L5701_Trunk_OFF_cnt:
1921  000f 00            	ds.b	1
1922  0010               L3701_Trunk_ON_cnt:
1923  0010 00            	ds.b	1
1962                     ; 496 void ScanTrunkSwitch(void)
1962                     ; 497 {
1963                     	switch	.text
1964  0362               f_ScanTrunkSwitch:
1968                     ; 501    if(TRUNK_RELEASE_SW == 0)
1970  0362 720800001d    	btjt	_H4021Data1,#4,L5111
1971                     ; 503       Trunk_OFF_cnt = 0;
1973  0367 725f000f      	clr	L5701_Trunk_OFF_cnt
1974                     ; 504       if (Trunk_ON_cnt < KEY_FILTER_CNT) Trunk_ON_cnt++;
1976  036b c60010        	ld	a,L3701_Trunk_ON_cnt
1977  036e a105          	cp	a,#5
1978  0370 2405          	jruge	L7111
1981  0372 725c0010      	inc	L3701_Trunk_ON_cnt
1984  0376 87            	retf	
1985  0377               L7111:
1986                     ; 505       else if (Trunk_ON_cnt == KEY_FILTER_CNT)
1988  0377 a105          	cp	a,#5
1989  0379 2625          	jrne	L5211
1990                     ; 507           Trunk_ON_cnt++;
1992  037b 725c0010      	inc	L3701_Trunk_ON_cnt
1993                     ; 508           LockDrvCmd = UnlockTrunkCmd;
1995  037f 35400055      	mov	_LockDrvCmd,#64
1997  0383 87            	retf	
1998  0384               L5111:
1999                     ; 513       Trunk_ON_cnt = 0;
2001  0384 725f0010      	clr	L3701_Trunk_ON_cnt
2002                     ; 514       if(Trunk_OFF_cnt < KEY_FILTER_CNT) Trunk_OFF_cnt++;
2004  0388 c6000f        	ld	a,L5701_Trunk_OFF_cnt
2005  038b a105          	cp	a,#5
2006  038d 2405          	jruge	L7211
2009  038f 725c000f      	inc	L5701_Trunk_OFF_cnt
2012  0393 87            	retf	
2013  0394               L7211:
2014                     ; 515       else if (Trunk_OFF_cnt == KEY_FILTER_CNT)
2016  0394 a105          	cp	a,#5
2017  0396 2608          	jrne	L5211
2018                     ; 517           Trunk_OFF_cnt++;
2020  0398 725c000f      	inc	L5701_Trunk_OFF_cnt
2021                     ; 518           LockDrvCmd = NoLockCmd;
2023  039c 725f0055      	clr	_LockDrvCmd
2024  03a0               L5211:
2025                     ; 522 }
2028  03a0 87            	retf	
2030                     	switch	.bss
2031  0011               L3411_TrunkcomOK:
2032  0011 00            	ds.b	1
2033  0012               L1411_Lockbftime:
2034  0012 00            	ds.b	1
2035  0013               L5311_lockCnt:
2036  0013 00            	ds.b	1
2093                     ; 539 void JudgeLockDriver(void)
2093                     ; 540 {
2094                     	switch	.text
2095  03a1               f_JudgeLockDriver:
2099                     ; 544     if( Lockonesstate == 0x55 )
2101  03a1 c6004c        	ld	a,_Lockonesstate
2102  03a4 a155          	cp	a,#85
2103  03a6 261d          	jrne	L5611
2104                     ; 546         if(Lockbftime < 125)
2106  03a8 c60012        	ld	a,L1411_Lockbftime
2107  03ab a17d          	cp	a,#125
2108  03ad 240e          	jruge	L7611
2109                     ; 548             Lockbftime++;
2111  03af 725c0012      	inc	L1411_Lockbftime
2112                     ; 549             LockDrvCmd = NoLockCmd;
2114  03b3 725f0055      	clr	_LockDrvCmd
2115                     ; 550     	     TurnFlashCnt =0; // ADD 20100814
2117  03b7 5f            	clrw	x
2118  03b8 cf0000        	ldw	_TurnFlashCnt,x
2120  03bb 2008          	jra	L5611
2121  03bd               L7611:
2122                     ; 554             Lockbftime = 0 ;
2124  03bd 725f0012      	clr	L1411_Lockbftime
2125                     ; 555             Lockonesstate = 0 ;
2127  03c1 725f004c      	clr	_Lockonesstate
2128  03c5               L5611:
2129                     ; 561     Lockhot(); //热保护处理程序
2131  03c5 8de004e0      	callf	f_Lockhot
2133                     ; 563 if(charshtime == 0)
2135  03c9 ce0041        	ldw	x,_charshtime
2136  03cc 2627          	jrne	L3711
2137                     ; 565 	if (wLockProtectTimeCnt != 0)
2139  03ce ce0050        	ldw	x,_wLockProtectTimeCnt
2140  03d1 2726          	jreq	L5021
2141                     ; 567 	       if(crashlockstate == 0x55)
2143  03d3 c6004b        	ld	a,_crashlockstate
2144  03d6 a155          	cp	a,#85
2145  03d8 260a          	jrne	L7711
2146                     ; 569                 if(LockDrvCmd == NoLockCmd)
2148  03da c60055        	ld	a,_LockDrvCmd
2149  03dd 260d          	jrne	L3021
2150                     ; 571                       crashlockstate = 0;
2152  03df c7004b        	ld	_crashlockstate,a
2153  03e2 2008          	jra	L3021
2154  03e4               L7711:
2155                     ; 576                     LockDrvCmd = NoLockCmd;
2157  03e4 725f0055      	clr	_LockDrvCmd
2158                     ; 577 		      TurnFlashCnt =0; // ADD 20100814
2160  03e8 5f            	clrw	x
2161  03e9 cf0000        	ldw	_TurnFlashCnt,x
2162  03ec               L3021:
2163                     ; 579             wLockProtectTimeCnt--;
2165  03ec ce0050        	ldw	x,_wLockProtectTimeCnt
2166  03ef 5a            	decw	x
2167  03f0 cf0050        	ldw	_wLockProtectTimeCnt,x
2168  03f3 2004          	jra	L5021
2169  03f5               L3711:
2170                     ; 582 else charshtime--;
2172  03f5 5a            	decw	x
2173  03f6 cf0041        	ldw	_charshtime,x
2174  03f9               L5021:
2175                     ; 585      if (LOCK_OUT || UNLOCK_OUT || TRUNK_UNLOCK_OUT)
2177  03f9 720850140a    	btjt	20500,#4,L1121
2179  03fe 720e501e05    	btjt	20510,#7,L1121
2181  0403 720150142e    	btjf	20500,#0,L7021
2182  0408               L1121:
2183                     ; 587      	if (lockCnt < LOCK_RUN_TIME)
2185  0408 c60013        	ld	a,L5311_lockCnt
2186  040b a119          	cp	a,#25
2187  040d 2406          	jruge	L5121
2188                     ; 589      		lockCnt++;
2190  040f 725c0013      	inc	L5311_lockCnt
2192  0413 2021          	jra	L7021
2193  0415               L5121:
2194                     ; 593             lockCnt = 0;
2196  0415 725f0013      	clr	L5311_lockCnt
2197                     ; 594             LOCK_OFF;
2199  0419 72195014      	bres	20500,#4
2200                     ; 595             UNLOCK_OFF;	
2202  041d 721f501e      	bres	20510,#7
2203                     ; 596             TRUNK_UNLOCK_OFF;
2205  0421 72115014      	bres	20500,#0
2206                     ; 597             LockDrvCmd = NoLockCmd;
2208  0425 725f0055      	clr	_LockDrvCmd
2209                     ; 599             WindowDriverState = WindowDriverStateKeep;
2211  0429 5500430045    	mov	_WindowDriverState,_WindowDriverStateKeep
2212                     ; 600             WindowDriverStateKeep=0X00;
2214  042e 725f0043      	clr	_WindowDriverStateKeep
2215                     ; 601             ResumeWindowDriverState();
2217  0432 8d200020      	callf	f_ResumeWindowDriverState
2219  0436               L7021:
2220                     ; 605      if(LockDrvCmd & LockCmd)  TrunkcomOK = 0;
2222  0436 720b005504    	btjf	_LockDrvCmd,#5,L1221
2225  043b 725f0011      	clr	L3411_TrunkcomOK
2226  043f               L1221:
2227                     ; 606 	 if(LockDrvCmd & UnlockDriverDoorCmd) TrunkcomOK = 0x55;
2229  043f 720f005504    	btjf	_LockDrvCmd,#7,L3221
2232  0444 35550011      	mov	L3411_TrunkcomOK,#85
2233  0448               L3221:
2234                     ; 608      if (LockDrvCmd == NoLockCmd) return; 
2236  0448 c60055        	ld	a,_LockDrvCmd
2237  044b 2601          	jrne	L5221
2241  044d 87            	retf	
2242  044e               L5221:
2243                     ; 609      else if (LockDrvCmd & LockCmd)
2245  044e a520          	bcp	a,#32
2246  0450 2723          	jreq	L1321
2247                     ; 611  			  SaveWindowDriverState();
2249  0452 8d000000      	callf	f_SaveWindowDriverState
2251                     ; 612               if(WindowDriverState != 0x00)
2253  0456 c60045        	ld	a,_WindowDriverState
2254  0459 2705          	jreq	L3321
2255                     ; 614       		    WindowDriverStateKeep = WindowDriverState;
2257  045b 5500450043    	mov	_WindowDriverStateKeep,_WindowDriverState
2258  0460               L3321:
2259                     ; 616 			  DriverLOCK = 0;
2261  0460 725f0000      	clr	_DriverLOCK
2262                     ; 617               TRUNK_UNLOCK_OFF;
2264  0464 72115014      	bres	20500,#0
2265                     ; 618               UNLOCK_OFF;
2267  0468 721f501e      	bres	20510,#7
2268                     ; 619               LOCK_ON;
2270  046c 72185014      	bset	20500,#4
2271                     ; 620 							LockDrvCmd = 0;
2273  0470 725f0055      	clr	_LockDrvCmd
2276  0474 87            	retf	
2277  0475               L1321:
2278                     ; 622      else if (LockDrvCmd & UnlockDriverDoorCmd )
2280  0475 a580          	bcp	a,#128
2281  0477 2724          	jreq	L7321
2282                     ; 624  		SaveWindowDriverState();
2284  0479 8d000000      	callf	f_SaveWindowDriverState
2286                     ; 625  		if(WindowDriverState != 0x00)
2288  047d c60045        	ld	a,_WindowDriverState
2289  0480 2705          	jreq	L1421
2290                     ; 627       		    WindowDriverStateKeep = WindowDriverState;
2292  0482 5500450043    	mov	_WindowDriverStateKeep,_WindowDriverState
2293  0487               L1421:
2294                     ; 629      	LOCK_OFF;
2296  0487 72195014      	bres	20500,#4
2297                     ; 630  		TRUNK_UNLOCK_OFF;
2299  048b 72115014      	bres	20500,#0
2300                     ; 631  		if (LockDrvCmd & UnlockDriverDoorCmd)	UNLOCK_ON;
2302  048f 720f005504    	btjf	_LockDrvCmd,#7,L3421
2305  0494 721e501e      	bset	20510,#7
2306  0498               L3421:
2307                     ; 632 		 LockDrvCmd = 0;
2309  0498 725f0055      	clr	_LockDrvCmd
2312  049c 87            	retf	
2313  049d               L7321:
2314                     ; 635      else if (LockDrvCmd & UnlockTrunkCmd)
2316  049d a540          	bcp	a,#64
2317  049f 2732          	jreq	L7421
2318                     ; 637  		SaveWindowDriverState();
2320  04a1 8d000000      	callf	f_SaveWindowDriverState
2322                     ; 638  		if(WindowDriverState != 0x00)
2324  04a5 c60045        	ld	a,_WindowDriverState
2325  04a8 2705          	jreq	L1521
2326                     ; 640   		    WindowDriverStateKeep = WindowDriverState;
2328  04aa 5500450043    	mov	_WindowDriverStateKeep,_WindowDriverState
2329  04af               L1521:
2330                     ; 642  		LOCK_OFF;
2332  04af 72195014      	bres	20500,#4
2333                     ; 643  		UNLOCK_OFF;
2335  04b3 721f501e      	bres	20510,#7
2336                     ; 644  	    if(TRUNK_UNLOCK_RKEstate == 1)
2338  04b7 c60054        	ld	a,_TRUNK_UNLOCK_RKEstate
2339  04ba 4a            	dec	a
2340  04bb 2605          	jrne	L3521
2341                     ; 646                   TRUNK_UNLOCK_ON;
2343  04bd 72105014      	bset	20500,#0
2346  04c1 87            	retf	
2347  04c2               L3521:
2348                     ; 648  		else if(TrunkcomOK == 0x55)
2350  04c2 c60011        	ld	a,L3411_TrunkcomOK
2351  04c5 a155          	cp	a,#85
2352  04c7 2605          	jrne	L7521
2353                     ; 650         	    TRUNK_UNLOCK_ON;
2355  04c9 72105014      	bset	20500,#0
2358  04cd 87            	retf	
2359  04ce               L7521:
2360                     ; 654                 LockDrvCmd &= ~UnlockTrunkCmd; 
2362  04ce 721d0055      	bres	_LockDrvCmd,#6
2364  04d2 87            	retf	
2365  04d3               L7421:
2366                     ; 661               LOCK_OFF;
2368  04d3 72195014      	bres	20500,#4
2369                     ; 662               UNLOCK_OFF;
2371  04d7 721f501e      	bres	20510,#7
2372                     ; 663               TRUNK_UNLOCK_OFF;
2374  04db 72115014      	bres	20500,#0
2375                     ; 665 }   
2378  04df 87            	retf	
2380                     	switch	.bss
2381  0014               L5621_timecnt:
2382  0014 000000000000  	ds.b	20
2383  0028               L7621_passcnt:
2384  0028 000000000000  	ds.b	10
2385  0032               L1721_lockcnt:
2386  0032 00            	ds.b	1
2387  0033               L3721_LOCKcomoldstate:
2388  0033 00            	ds.b	1
2456                     ; 667 void Lockhot(void)
2456                     ; 668 {
2457                     	switch	.text
2458  04e0               f_Lockhot:
2460  04e0 88            	push	a
2461       00000001      OFST:	set	1
2464                     ; 675     if(LOCKcomoldstate != LockDrvCmd)
2466  04e1 c60033        	ld	a,L3721_LOCKcomoldstate
2467  04e4 c10055        	cp	a,_LockDrvCmd
2468  04e7 2710          	jreq	L5231
2469                     ; 677          LOCKcomoldstate = LockDrvCmd;
2471  04e9 c60055        	ld	a,_LockDrvCmd
2472  04ec c70033        	ld	L3721_LOCKcomoldstate,a
2473                     ; 678 		 if(LockDrvCmd != 0) {lockcount = 1 ;MachineLocktime = 40;}
2475  04ef 2708          	jreq	L5231
2478  04f1 35010044      	mov	_lockcount,#1
2481  04f5 3528004a      	mov	_MachineLocktime,#40
2482  04f9               L5231:
2483                     ; 682     if( lockcount == 1 )
2485  04f9 c60044        	ld	a,_lockcount
2486  04fc 4a            	dec	a
2487  04fd 265e          	jrne	L1331
2488                     ; 684         lockcount = 0 ;
2490  04ff c70044        	ld	_lockcount,a
2491                     ; 685         if(lockcnt < 9 )lockcnt++;
2493  0502 c60032        	ld	a,L1721_lockcnt
2494  0505 a109          	cp	a,#9
2495  0507 2406          	jruge	L3331
2498  0509 725c0032      	inc	L1721_lockcnt
2500  050d 2004          	jra	L5331
2501  050f               L3331:
2502                     ; 686         else lockcnt = 0;     
2504  050f 725f0032      	clr	L1721_lockcnt
2505  0513               L5331:
2506                     ; 687         timecnt[lockcnt] = 1250;
2508  0513 c60032        	ld	a,L1721_lockcnt
2509  0516 5f            	clrw	x
2510  0517 97            	ld	xl,a
2511  0518 58            	sllw	x
2512  0519 90ae04e2      	ldw	y,#1250
2513  051d df0014        	ldw	(L5621_timecnt,x),y
2514                     ; 689         for(i = 0; i < 9; i++)
2516  0520 4f            	clr	a
2517  0521 6b01          	ld	(OFST+0,sp),a
2518  0523               L7331:
2519                     ; 691            if(timecnt[i] != 0)
2521  0523 5f            	clrw	x
2522  0524 97            	ld	xl,a
2523  0525 58            	sllw	x
2524  0526 d60015        	ld	a,(L5621_timecnt+1,x)
2525  0529 da0014        	or	a,(L5621_timecnt,x)
2526  052c 2727          	jreq	L5431
2527                     ; 693               passcnt[i]++;
2529  052e 7b01          	ld	a,(OFST+0,sp)
2530  0530 5f            	clrw	x
2531  0531 97            	ld	xl,a
2532  0532 724c0028      	inc	(L7621_passcnt,x)
2533                     ; 694               if( passcnt[i] > 10 )
2535  0536 5f            	clrw	x
2536  0537 97            	ld	xl,a
2537  0538 d60028        	ld	a,(L7621_passcnt,x)
2538  053b a10b          	cp	a,#11
2539  053d 2516          	jrult	L5431
2540                     ; 696                   wLockProtectTimeCnt = 7500;
2542  053f ae1d4c        	ldw	x,#7500
2543  0542 cf0050        	ldw	_wLockProtectTimeCnt,x
2544                     ; 697                   timecnt[i] = 0;
2546  0545 7b01          	ld	a,(OFST+0,sp)
2547  0547 5f            	clrw	x
2548  0548 97            	ld	xl,a
2549  0549 58            	sllw	x
2550  054a 905f          	clrw	y
2551  054c df0014        	ldw	(L5621_timecnt,x),y
2552                     ; 698                   passcnt[i] = 0;
2554  054f 5f            	clrw	x
2555  0550 97            	ld	xl,a
2556  0551 724f0028      	clr	(L7621_passcnt,x)
2557  0555               L5431:
2558                     ; 689         for(i = 0; i < 9; i++)
2560  0555 0c01          	inc	(OFST+0,sp)
2563  0557 7b01          	ld	a,(OFST+0,sp)
2564  0559 a109          	cp	a,#9
2565  055b 25c6          	jrult	L7331
2566  055d               L1331:
2567                     ; 703     for(i = 0; i < 9; i++)
2569  055d 4f            	clr	a
2570  055e 6b01          	ld	(OFST+0,sp),a
2571  0560               L1531:
2572                     ; 705         if(timecnt[i] != 0)
2574  0560 5f            	clrw	x
2575  0561 97            	ld	xl,a
2576  0562 58            	sllw	x
2577  0563 d60015        	ld	a,(L5621_timecnt+1,x)
2578  0566 da0014        	or	a,(L5621_timecnt,x)
2579  0569 270c          	jreq	L7531
2580                     ; 707            timecnt[i]--;
2582  056b 9093          	ldw	y,x
2583  056d de0014        	ldw	x,(L5621_timecnt,x)
2584  0570 5a            	decw	x
2585  0571 90df0014      	ldw	(L5621_timecnt,y),x
2587  0575 2008          	jra	L1631
2588  0577               L7531:
2589                     ; 711            passcnt[i] = 0;
2591  0577 7b01          	ld	a,(OFST+0,sp)
2592  0579 5f            	clrw	x
2593  057a 97            	ld	xl,a
2594  057b 724f0028      	clr	(L7621_passcnt,x)
2595  057f               L1631:
2596                     ; 703     for(i = 0; i < 9; i++)
2598  057f 0c01          	inc	(OFST+0,sp)
2601  0581 7b01          	ld	a,(OFST+0,sp)
2602  0583 a109          	cp	a,#9
2603  0585 25d9          	jrult	L1531
2604                     ; 715 }
2607  0587 84            	pop	a
2608  0588 87            	retf	
2610                     	switch	.bss
2611  0034               L3631_TRUNktimecnt:
2612  0034 0000          	ds.b	2
2613  0036               L5631_TRUNKCancleState:
2614  0036 00            	ds.b	1
2655                     ; 717 void TRUNKwarm(void)
2655                     ; 718 {
2656                     	switch	.text
2657  0589               f_TRUNKwarm:
2661                     ; 722       if(IGNstate == ON )
2663  0589 c60000        	ld	a,_IGNstate
2664  058c a155          	cp	a,#85
2665  058e 2604          	jrne	L5041
2666                     ; 724           TRUNKWarmstate = 1 ;
2668  0590 3501004e      	mov	_TRUNKWarmstate,#1
2669  0594               L5041:
2670                     ; 727       if(TRUNK_UNLOCK_RKEstate == 1)
2672  0594 c60054        	ld	a,_TRUNK_UNLOCK_RKEstate
2673  0597 4a            	dec	a
2674  0598 2609          	jrne	L7041
2675                     ; 729              TRUNK_UNLOCK_RKEstate = 0 ;
2677  059a c70054        	ld	_TRUNK_UNLOCK_RKEstate,a
2678                     ; 730              TRUNktimecnt = 7500 ;
2680  059d ae1d4c        	ldw	x,#7500
2681  05a0 cf0034        	ldw	L3631_TRUNktimecnt,x
2682  05a3               L7041:
2683                     ; 732       if( TRUNktimecnt != 0)
2685  05a3 ce0034        	ldw	x,L3631_TRUNktimecnt
2686  05a6 271d          	jreq	L1141
2687                     ; 734       	      TRUNktimecnt--;
2689  05a8 5a            	decw	x
2690  05a9 cf0034        	ldw	L3631_TRUNktimecnt,x
2691                     ; 735              if(TRUNktimecnt == 0 )
2693  05ac 2606          	jrne	L3141
2694                     ; 737                     TRUNKWarmstate = 1 ;//zheng chang bao jing 
2696  05ae 3501004e      	mov	_TRUNKWarmstate,#1
2698  05b2 2011          	jra	L1141
2699  05b4               L3141:
2700                     ; 741                     if(DoorState & TrunkIsOpen)
2702  05b4 720500000c    	btjf	_DoorState,#2,L1141
2703                     ; 743                           TRUNKWarmstate = 0 ; //取消后备箱报警      
2705  05b9 725f004e      	clr	_TRUNKWarmstate
2706                     ; 744                           TRUNktimecnt = 0 ;
2708  05bd 5f            	clrw	x
2709  05be cf0034        	ldw	L3631_TRUNktimecnt,x
2710                     ; 745                           TRUNKCancleState = 1 ;
2712  05c1 35010036      	mov	L5631_TRUNKCancleState,#1
2713  05c5               L1141:
2714                     ; 749       if(TRUNKCancleState == 1)
2716  05c5 c60036        	ld	a,L5631_TRUNKCancleState
2717  05c8 4a            	dec	a
2718  05c9 260c          	jrne	L1241
2719                     ; 751 	       if((DoorState & TrunkIsOpen) == 0)
2721  05cb 7204000007    	btjt	_DoorState,#2,L1241
2722                     ; 753                     TRUNKCancleState = 0 ;
2724  05d0 c70036        	ld	L5631_TRUNKCancleState,a
2725                     ; 754                     TRUNKWarmstate = 1 ;
2727  05d3 3501004e      	mov	_TRUNKWarmstate,#1
2728  05d7               L1241:
2729                     ; 758 }
2732  05d7 87            	retf	
2734                     	switch	.bss
2735  0037               L5241_prearmedtoArmedcnt:
2736  0037 0000          	ds.b	2
2737  0039               L1341_IGNoldstate:
2738  0039 00            	ds.b	1
2739  003a               L7241_Dooroldstate:
2740  003a 00            	ds.b	1
2811                     ; 771 void WarmStatusArithmetic (void)
2811                     ; 772 {
2812                     	switch	.text
2813  05d8               f_WarmStatusArithmetic:
2815  05d8 5205          	subw	sp,#5
2816       00000005      OFST:	set	5
2819                     ; 779 	BCMtoGEM_AlarmStatus = Disarmed;
2821  05da 725f0053      	clr	_BCMtoGEM_AlarmStatus
2822                     ; 780 	return;
2824  05de 2069          	jra	L1551
2825                     ; 876         default       :    break;
2827                     ; 880        if(BCMtoGEM_AlarmStatus == Disarmed) CAN_ARMED_Disarmed;
2831  05e0 c60006        	ld	a,_CanSendData+6
2832  05e3 a4cf          	and	a,#207
2834  05e5 201b          	jpf	LC004
2835                     ; 881 	else if(BCMtoGEM_AlarmStatus == prearmed)  {CAN_ARMED_Disarmed ;CAN_ARMED_prearmed;}
2839  05e7 c60006        	ld	a,_CanSendData+6
2840  05ea a4cf          	and	a,#207
2841  05ec c70006        	ld	_CanSendData+6,a
2844  05ef 72180006      	bset	_CanSendData+6,#4
2846  05f3 201e          	jra	L3351
2847                     ; 882 	else if(BCMtoGEM_AlarmStatus == Armed) {CAN_ARMED_Disarmed ;CAN_ARMED_Armed;}
2852                     ; 883 	else if(BCMtoGEM_AlarmStatus == Actiated){CAN_ARMED_Disarmed ;CAN_ARMED_Error;}
2856  05f5 c60006        	ld	a,_CanSendData+6
2857  05f8 a4cf          	and	a,#207
2858  05fa c70006        	ld	_CanSendData+6,a
2861  05fd c60006        	ld	a,_CanSendData+6
2862  0600 aa30          	or	a,#48
2863  0602               LC004:
2864  0602 c70006        	ld	_CanSendData+6,a
2866  0605 200c          	jra	L3351
2867                     ; 884 	else {CAN_ARMED_Disarmed ; CAN_ARMED_Armed;}
2872  0607 c60006        	ld	a,_CanSendData+6
2873  060a a4cf          	and	a,#207
2874  060c c70006        	ld	_CanSendData+6,a
2876  060f 721a0006      	bset	_CanSendData+6,#5
2877  0613               L3351:
2878                     ; 890     if(warmstate != BCMtoGEM_AlarmStatus)
2880  0613 c6408b        	ld	a,_warmstate
2881  0616 c10053        	cp	a,_BCMtoGEM_AlarmStatus
2882  0619 272e          	jreq	L1551
2883                     ; 892         for( i = 0; i < EECNT ; i++ )
2885  061b 0f05          	clr	(OFST+0,sp)
2886  061d               L3551:
2887                     ; 894              temp = (u32)( &warmstate );
2889  061d ae408b        	ldw	x,#_warmstate
2890  0620 8d000000      	callf	d_uitolx
2892  0624 96            	ldw	x,sp
2893  0625 5c            	incw	x
2894  0626 8d000000      	callf	d_rtol
2896                     ; 896              FLASH_ProgramByte(temp, BCMtoGEM_AlarmStatus);                
2898  062a 3b0053        	push	_BCMtoGEM_AlarmStatus
2899  062d 1e04          	ldw	x,(OFST-1,sp)
2900  062f 89            	pushw	x
2901  0630 1e04          	ldw	x,(OFST-1,sp)
2902  0632 89            	pushw	x
2903  0633 8d000000      	callf	f_FLASH_ProgramByte
2905  0637 5b05          	addw	sp,#5
2906                     ; 897              if( warmstate == BCMtoGEM_AlarmStatus )
2908  0639 c6408b        	ld	a,_warmstate
2909  063c c10053        	cp	a,_BCMtoGEM_AlarmStatus
2910  063f 2708          	jreq	L1551
2911                     ; 899                   break;
2913                     ; 892         for( i = 0; i < EECNT ; i++ )
2915  0641 0c05          	inc	(OFST+0,sp)
2918  0643 7b05          	ld	a,(OFST+0,sp)
2919  0645 a10a          	cp	a,#10
2920  0647 25d4          	jrult	L3551
2921  0649               L1551:
2922                     ; 904 }
2925  0649 5b05          	addw	sp,#5
2926  064b 87            	retf	
2928                     	switch	.bss
2929  003b               L5651_Dooruncloselock:
2930  003b 00            	ds.b	1
2931  003c               L3651_Lockstate_old:
2932  003c 00            	ds.b	1
2980                     ; 908 void MachineKeyDrv(void)
2980                     ; 909 {
2981                     	switch	.text
2982  064c               f_MachineKeyDrv:
2986                     ; 914 	if(MachineLocktime != 0) MachineLocktime--;
2988  064c c6004a        	ld	a,_MachineLocktime
2989  064f 2704          	jreq	L5061
2992  0651 725a004a      	dec	_MachineLocktime
2993  0655               L5061:
2994                     ; 916     if( Lockstate_old  != LockState)
2996  0655 c6003c        	ld	a,L3651_Lockstate_old
2997  0658 c10057        	cp	a,_LockState
2998  065b 2604ac3d073d  	jreq	L7061
2999                     ; 918         Lockstate_old  =   LockState;      
3001  0661 c60057        	ld	a,_LockState
3002  0664 c7003c        	ld	L3651_Lockstate_old,a
3003                     ; 919         if(MachineLocktime != 0){LockDrvCmd = 0; return;}
3005  0667 725d004a      	tnz	_MachineLocktime
3006  066b 2705          	jreq	L1161
3009  066d 725f0055      	clr	_LockDrvCmd
3013  0671 87            	retf	
3014  0672               L1161:
3015                     ; 920         if(LockState == Locked )
3017  0672 a155          	cp	a,#85
3018  0674 265d          	jrne	L3161
3019                     ; 923                         if((IGNstate == OFF)&&(wLockProtectTimeCnt ==0)&&(TurnFlashCnt == 0))TurnFlashCnt = 2;
3021  0676 c60000        	ld	a,_IGNstate
3022  0679 2610          	jrne	L5161
3024  067b ce0050        	ldw	x,_wLockProtectTimeCnt
3025  067e 260b          	jrne	L5161
3027  0680 ce0000        	ldw	x,_TurnFlashCnt
3028  0683 2606          	jrne	L5161
3031  0685 ae0002        	ldw	x,#2
3032  0688 cf0000        	ldw	_TurnFlashCnt,x
3033  068b               L5161:
3034                     ; 925 				if(FindCarFlag = TRUE)  //20120308
3036  068b 35010000      	mov	_FindCarFlag,#1
3037  068f 2710          	jreq	L7161
3038                     ; 927 					FindCarFlag = FALSE;
3040  0691 725f0000      	clr	_FindCarFlag
3041                     ; 928 					if(turnfindcarstate == 1)TurnFlashCnt = 3;
3043  0695 c60000        	ld	a,_turnfindcarstate
3044  0698 4a            	dec	a
3045  0699 2606          	jrne	L7161
3048  069b ae0003        	ldw	x,#3
3049  069e cf0000        	ldw	_TurnFlashCnt,x
3050  06a1               L7161:
3051                     ; 930 			   if((IGNstate == ON)||(wLockProtectTimeCnt != 0)) TurnFlashCnt = 0;
3053  06a1 c60000        	ld	a,_IGNstate
3054  06a4 a155          	cp	a,#85
3055  06a6 2705          	jreq	L5261
3057  06a8 ce0050        	ldw	x,_wLockProtectTimeCnt
3058  06ab 2704          	jreq	L3261
3059  06ad               L5261:
3062  06ad 5f            	clrw	x
3063  06ae cf0000        	ldw	_TurnFlashCnt,x
3064  06b1               L3261:
3065                     ; 932 			   if((DoorState & 0x1b)&&(IGNstate == ON)){dooropenlock = 50;TurnFlashCnt  = 0;}//HornDoorunclosetime = 6;BuzzerDrv(1,376,375,Buzzlockdoorunclose);}20120328 取消非RKE报警
3067  06b1 c60000        	ld	a,_DoorState
3068  06b4 a51b          	bcp	a,#27
3069  06b6 270f          	jreq	L7261
3071  06b8 c60000        	ld	a,_IGNstate
3072  06bb a155          	cp	a,#85
3073  06bd 2608          	jrne	L7261
3076  06bf 35320049      	mov	_dooropenlock,#50
3079  06c3 5f            	clrw	x
3080  06c4 cf0000        	ldw	_TurnFlashCnt,x
3081  06c7               L7261:
3082                     ; 935                         LockDrvCmd |= LockCmd ;
3084  06c7 721a0055      	bset	_LockDrvCmd,#5
3085                     ; 936 		          RKELOCKstate = 0xaa;
3087  06cb 35aa0000      	mov	_RKELOCKstate,#170
3088                     ; 938 			   Dooruncloselock = 0;
3090  06cf 725f003b      	clr	L5651_Dooruncloselock
3091  06d3               L3161:
3092                     ; 940         if(LockState == Unlocked )
3094  06d3 c60057        	ld	a,_LockState
3095  06d6 2665          	jrne	L7061
3096                     ; 942                         if(Dooruncloselock != 0x55)
3098  06d8 c6003b        	ld	a,L5651_Dooruncloselock
3099  06db a155          	cp	a,#85
3100  06dd 2736          	jreq	L3361
3101                     ; 944 			                 LockDrvCmd |= UnlockDriverDoorCmd ;
3103  06df 721e0055      	bset	_LockDrvCmd,#7
3104                     ; 946 					   if((IGNstate == OFF)&&(TurnFlashCnt == 0))TurnFlashCnt = 1;
3106  06e3 c60000        	ld	a,_IGNstate
3107  06e6 2609          	jrne	L5361
3109  06e8 ce0000        	ldw	x,_TurnFlashCnt
3110  06eb 2604          	jrne	L5361
3113  06ed 5c            	incw	x
3114  06ee cf0000        	ldw	_TurnFlashCnt,x
3115  06f1               L5361:
3116                     ; 948 						if(FindCarFlag = TRUE)  //20120308
3118  06f1 35010000      	mov	_FindCarFlag,#1
3119  06f5 2710          	jreq	L7361
3120                     ; 950 							FindCarFlag = FALSE;
3122  06f7 725f0000      	clr	_FindCarFlag
3123                     ; 951 							if(turnfindcarstate == 1)TurnFlashCnt = 2;
3125  06fb c60000        	ld	a,_turnfindcarstate
3126  06fe 4a            	dec	a
3127  06ff 2606          	jrne	L7361
3130  0701 ae0002        	ldw	x,#2
3131  0704 cf0000        	ldw	_TurnFlashCnt,x
3132  0707               L7361:
3133                     ; 953 				          if((IGNstate == ON)||(wLockProtectTimeCnt != 0)) TurnFlashCnt = 0;
3135  0707 c60000        	ld	a,_IGNstate
3136  070a a155          	cp	a,#85
3137  070c 2727          	jreq	L5561
3139  070e ce0050        	ldw	x,_wLockProtectTimeCnt
3140  0711 2726          	jreq	L3561
3142                     ; 954 					   RKELOCKstate = 0x55;
3144  0713 2020          	jpf	L5561
3145  0715               L3361:
3146                     ; 959 				   Dooruncloselock = 0;
3148  0715 725f003b      	clr	L5651_Dooruncloselock
3149                     ; 960 	                        if((IGNstate == OFF)&&(wLockProtectTimeCnt ==0)&&(TurnFlashCnt == 0))TurnFlashCnt = 1;
3151  0719 c60000        	ld	a,_IGNstate
3152  071c 260e          	jrne	L1561
3154  071e ce0050        	ldw	x,_wLockProtectTimeCnt
3155  0721 2609          	jrne	L1561
3157  0723 ce0000        	ldw	x,_TurnFlashCnt
3158  0726 2604          	jrne	L1561
3161  0728 5c            	incw	x
3162  0729 cf0000        	ldw	_TurnFlashCnt,x
3163  072c               L1561:
3164                     ; 961 				   if((IGNstate == ON)||(wLockProtectTimeCnt != 0)) TurnFlashCnt = 0;
3166  072c a155          	cp	a,#85
3167  072e 2705          	jreq	L5561
3169  0730 ce0050        	ldw	x,_wLockProtectTimeCnt
3170  0733 2704          	jreq	L3561
3171  0735               L5561:
3175  0735 5f            	clrw	x
3176  0736 cf0000        	ldw	_TurnFlashCnt,x
3177  0739               L3561:
3178                     ; 962 				   RKELOCKstate = 0x55;
3181  0739 35550000      	mov	_RKELOCKstate,#85
3182  073d               L7061:
3183                     ; 970      if(dooropenlock!= 0)
3185  073d c60049        	ld	a,_dooropenlock
3186  0740 272d          	jreq	L7561
3187                     ; 972          dooropenlock--;
3189  0742 725a0049      	dec	_dooropenlock
3190                     ; 973 		 if(dooropenlock == 0)
3192  0746 2627          	jrne	L7561
3193                     ; 975                             LockDrvCmd |= UnlockDriverDoorCmd ;
3195  0748 721e0055      	bset	_LockDrvCmd,#7
3196                     ; 976 				if((IGNstate == OFF)&&(wLockProtectTimeCnt ==0)&&(TurnFlashCnt == 0))TurnFlashCnt = 0;
3198  074c c60000        	ld	a,_IGNstate
3199  074f 260e          	jrne	L3661
3201  0751 ce0050        	ldw	x,_wLockProtectTimeCnt
3202  0754 2609          	jrne	L3661
3204  0756 ce0000        	ldw	x,_TurnFlashCnt
3205  0759 2604          	jrne	L3661
3208  075b 5f            	clrw	x
3209  075c cf0000        	ldw	_TurnFlashCnt,x
3210  075f               L3661:
3211                     ; 977 				if(IGNstate == ON) TurnFlashCnt = 0;
3213  075f a155          	cp	a,#85
3214  0761 2604          	jrne	L5661
3217  0763 5f            	clrw	x
3218  0764 cf0000        	ldw	_TurnFlashCnt,x
3219  0767               L5661:
3220                     ; 978 				RKELOCKstate = 0x55;
3222  0767 35550000      	mov	_RKELOCKstate,#85
3223                     ; 979 			    Dooruncloselock = 0x55;
3225  076b 3555003b      	mov	L5651_Dooruncloselock,#85
3226  076f               L7561:
3227                     ; 983 }
3230  076f 87            	retf	
3430                     	switch	.bss
3431  003d               _timxxx2:
3432  003d 0000          	ds.b	2
3433                     	xdef	_timxxx2
3434  003f               _timexxx1:
3435  003f 0000          	ds.b	2
3436                     	xdef	_timexxx1
3437  0041               _charshtime:
3438  0041 0000          	ds.b	2
3439                     	xdef	_charshtime
3440  0043               _WindowDriverStateKeep:
3441  0043 00            	ds.b	1
3442                     	xdef	_WindowDriverStateKeep
3443  0044               _lockcount:
3444  0044 00            	ds.b	1
3445                     	xdef	_lockcount
3446  0045               _WindowDriverState:
3447  0045 00            	ds.b	1
3448                     	xdef	_WindowDriverState
3449  0046               _LockRunCount:
3450  0046 00            	ds.b	1
3451                     	xdef	_LockRunCount
3452                     	xref	_RKELOCKstate
3453                     	xref	_DriverLOCK
3454                     	xref	_FindCarFlag
3455                     	xref	_DIDF1F4EEPROM
3456                     	xref	_StandByState
3457                     	xref	f_GetADCresultAverage
3458                     	xref	f_BuzzerDrv
3459                     	xref	_FORTIFYSW_state
3460                     	xref	_KeyInState
3461                     	xref	_Warningstate
3462                     	xref	_DoorState
3463                     	xref	_TurnLamp_CrashKeepTime
3464                     	xref	_TurnLampDrv
3465                     	xref	_TurnFlashCnt
3466                     	xref	_turnfindcarstate
3467                     	xref	_HornDoorunclosetime
3468                     	xref	_H4021Data1
3469                     	xref	_IGNstate
3470                     	xdef	f_Crash_CAN
3471                     	xref	_CAN_Crash
3472                     	xref	_CanSendData
3473                     	xdef	f_MachineKeyDrv
3474                     	xdef	f_Lockhot
3475                     	xdef	f_TRUNKwarm
3476                     	xdef	f_WarmStatusArithmetic
3477                     	xdef	f_ScanStandByCrashInSignal
3478                     	xdef	f_ScanTrunkSwitch
3479                     	xdef	f_JudgeLockDriver
3480                     	xdef	f_ScanCentralLockSwitch
3481                     	xdef	f_ScanAllLockState
3482                     	xdef	f_ScanCrashInSignal
3483                     	xdef	f_ResumeWindowDriverState
3484                     	xdef	f_SaveWindowDriverState
3485  0047               _Alarm_Actiated:
3486  0047 00            	ds.b	1
3487                     	xdef	_Alarm_Actiated
3488  0048               _Speedlockcnt:
3489  0048 00            	ds.b	1
3490                     	xdef	_Speedlockcnt
3491  0049               _dooropenlock:
3492  0049 00            	ds.b	1
3493                     	xdef	_dooropenlock
3494  004a               _MachineLocktime:
3495  004a 00            	ds.b	1
3496                     	xdef	_MachineLocktime
3497  004b               _crashlockstate:
3498  004b 00            	ds.b	1
3499                     	xdef	_crashlockstate
3500  004c               _Lockonesstate:
3501  004c 00            	ds.b	1
3502                     	xdef	_Lockonesstate
3503  004d               _DoorWarmState:
3504  004d 00            	ds.b	1
3505                     	xdef	_DoorWarmState
3506                     	xdef	_BUZZLocktimecnt
3507  004e               _TRUNKWarmstate:
3508  004e 00            	ds.b	1
3509                     	xdef	_TRUNKWarmstate
3510  004f               _VehicleTypePZ:
3511  004f 00            	ds.b	1
3512                     	xdef	_VehicleTypePZ
3513  0050               _wLockProtectTimeCnt:
3514  0050 0000          	ds.b	2
3515                     	xdef	_wLockProtectTimeCnt
3516  0052               _Alarmstatus_RKE:
3517  0052 00            	ds.b	1
3518                     	xdef	_Alarmstatus_RKE
3519  0053               _BCMtoGEM_AlarmStatus:
3520  0053 00            	ds.b	1
3521                     	xdef	_BCMtoGEM_AlarmStatus
3522  0054               _TRUNK_UNLOCK_RKEstate:
3523  0054 00            	ds.b	1
3524                     	xdef	_TRUNK_UNLOCK_RKEstate
3525  0055               _LockDrvCmd:
3526  0055 00            	ds.b	1
3527                     	xdef	_LockDrvCmd
3528  0056               _CrashState:
3529  0056 00            	ds.b	1
3530                     	xdef	_CrashState
3531  0057               _LockState:
3532  0057 00            	ds.b	1
3533                     	xdef	_LockState
3534  0058               _speedlockset:
3535  0058 00            	ds.b	1
3536                     	xdef	_speedlockset
3537                     	xref	f_FLASH_ProgramByte
3557                     	xref	d_rtol
3558                     	xref	d_uitolx
3559                     	end
