   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 819                     ; 100 void delay(uint n)
 819                     ; 101 {
 820                     	switch	.text
 821  0000               f_delay:
 823  0000 89            	pushw	x
 824  0001 88            	push	a
 825       00000001      OFST:	set	1
 828                     ; 103     for(i=0;i<n;i++);
 830  0002 0f01          	clr	(OFST+0,sp)
 832  0004 2002          	jra	L364
 833  0006               L754:
 837  0006 0c01          	inc	(OFST+0,sp)
 838  0008               L364:
 841  0008 7b01          	ld	a,(OFST+0,sp)
 842  000a 5f            	clrw	x
 843  000b 97            	ld	xl,a
 844  000c 1302          	cpw	x,(OFST+1,sp)
 845  000e 25f6          	jrult	L754
 846                     ; 104 }
 849  0010 5b03          	addw	sp,#3
 850  0012 87            	retf	
 888                     ; 110 void delay_ms(u16 n_ms)
 888                     ; 111 {
 889                     	switch	.text
 890  0013               f_delay_ms:
 892  0013 89            	pushw	x
 893  0014 89            	pushw	x
 894       00000002      OFST:	set	2
 897  0015 2008          	jra	L705
 898  0017               L505:
 899                     ; 114   for(i=DELAY_MS_VALUE; i>0; i--)
 901  0017 ae1388        	ldw	x,#5000
 902  001a               L315:
 906  001a 5a            	decw	x
 909  001b 26fd          	jrne	L315
 910  001d 1f01          	ldw	(OFST-1,sp),x
 911  001f               L705:
 912                     ; 113   while(n_ms--)
 914  001f 1e03          	ldw	x,(OFST+1,sp)
 915  0021 5a            	decw	x
 916  0022 1f03          	ldw	(OFST+1,sp),x
 917  0024 5c            	incw	x
 918  0025 26f0          	jrne	L505
 919                     ; 116 }
 922  0027 5b04          	addw	sp,#4
 923  0029 87            	retf	
 961                     ; 123 void delay_10us(u16 n_10us)
 961                     ; 124 {
 962                     	switch	.text
 963  002a               f_delay_10us:
 965  002a 89            	pushw	x
 966  002b 89            	pushw	x
 967       00000002      OFST:	set	2
 970  002c 2008          	jra	L145
 971  002e               L735:
 972                     ; 127 	for(i=DELAY_10US_VALUE; i>0; i--)
 974  002e ae0032        	ldw	x,#50
 975  0031               L545:
 979  0031 5a            	decw	x
 982  0032 26fd          	jrne	L545
 983  0034 1f01          	ldw	(OFST-1,sp),x
 984  0036               L145:
 985                     ; 126 	while(n_10us--)
 987  0036 1e03          	ldw	x,(OFST+1,sp)
 988  0038 5a            	decw	x
 989  0039 1f03          	ldw	(OFST+1,sp),x
 990  003b 5c            	incw	x
 991  003c 26f0          	jrne	L735
 992                     ; 129 }
 995  003e 5b04          	addw	sp,#4
 996  0040 87            	retf	
1027                     ; 141 void WakeInit(void)
1027                     ; 142 {
1028                     	switch	.text
1029  0041               f_WakeInit:
1031       00000001      OFST:	set	1
1034                     ; 148     AWU->CSR1 = 0x10;
1036  0041 351050f0      	mov	20720,#16
1037                     ; 149     AWU->TBR  = 0x0A;
1039  0045 350a50f2      	mov	20722,#10
1040                     ; 150     AWU->APR  = 0x3e;
1042  0049 353e50f1      	mov	20721,#62
1043                     ; 151     AWU->CSR1 |=0x02;
1045  004d 721250f0      	bset	20720,#1
1046                     ; 153     temp = AWU->CSR1;	
1048  0051 c650f0        	ld	a,20720
1049                     ; 154 }
1052  0054 87            	retf	
1074                     ; 166 void SystemClock(void)
1074                     ; 167 {
1075                     	switch	.text
1076  0055               f_SystemClock:
1080                     ; 168     CLK->ECKR = 0x01;
1082  0055 350150c1      	mov	20673,#1
1084  0059               L306:
1085                     ; 169     while((CLK->ECKR & 0X02)== 0);
1087  0059 720350c1fb    	btjf	20673,#1,L306
1088                     ; 171     CLK->SWCR = 0x02;
1090  005e 350250c5      	mov	20677,#2
1092  0062               L316:
1093                     ; 172     while(CLK->SWCR&1);
1095  0062 720050c5fb    	btjt	20677,#0,L316
1096                     ; 173     CLK->SWR  = 0xb4;
1098  0067 35b450c4      	mov	20676,#180
1100  006b               L326:
1101                     ; 174     while(CLK->CMSR != 0XB4);
1103  006b c650c3        	ld	a,20675
1104  006e a1b4          	cp	a,#180
1105  0070 26f9          	jrne	L326
1106                     ; 192 }
1109  0072 87            	retf	
1135                     ; 204 void WakeUp(void)
1135                     ; 205 {
1136                     	switch	.text
1137  0073               f_WakeUp:
1141                     ; 208     WakeState = 0;           //置唤醒标志
1143  0073 725f0025      	clr	_WakeState
1144                     ; 216     CLK->CKDIVR = 0x00;   
1146  0077 725f50c6      	clr	20678
1147                     ; 217 	SystemClock(); 
1149  007b 8d550055      	callf	f_SystemClock
1151                     ; 219        LIN_DISENABLE;
1153  007f 7219500f      	bres	20495,#4
1154                     ; 220 	CAN_EN_ON;
1156  0083 721f500a      	bres	20490,#7
1157                     ; 222     WWDG_Refresh(0x7f);
1159  0087 a67f          	ld	a,#127
1160  0089 8d000000      	callf	f_WWDG_Refresh
1162                     ; 223     CANHardwave_Init(1);
1164  008d a601          	ld	a,#1
1165  008f 8d000000      	callf	f_CANHardwave_Init
1167                     ; 224     ENABLE_RX_INT;   //使能RKE
1169  0093 72145013      	bset	20499,#2
1170                     ; 225     RKE_POWER_ON;
1173  0097 72115028      	bres	20520,#0
1174                     ; 226 }
1177  009b 87            	retf	
1179                     	switch	.bss
1180  0000               L146_NM_CNT:
1181  0000 00            	ds.b	1
1280                     ; 234 void main (void)
1280                     ; 235 {	
1281                     	switch	.text
1282  009c               f_main:
1286                     ; 246    CLK->CKDIVR = 0x00;    
1288  009c 725f50c6      	clr	20678
1289                     ; 249        SystemClock();   
1291  00a0 8d550055      	callf	f_SystemClock
1293                     ; 250 	TURN_LEFT_LAMP_OFF;
1295  00a4 72195019      	bres	20505,#4
1296                     ; 251 	TURN_RIGHT_LAMP_OFF;
1298  00a8 721b5019      	bres	20505,#5
1299                     ; 252 	CAN_TURNRightSW_OFF;
1301  00ac c60001        	ld	a,_CanSendData+1
1302  00af a4cf          	and	a,#207
1303  00b1 c70001        	ld	_CanSendData+1,a
1304                     ; 253 	CAN_TURNLeftSW_OFF;
1306  00b4 c60001        	ld	a,_CanSendData+1
1307  00b7 a43f          	and	a,#63
1308  00b9 c70001        	ld	_CanSendData+1,a
1309                     ; 255    System_Init();
1311  00bc 8d000000      	callf	f_System_Init
1313                     ; 256    CANenble();
1315  00c0 8d000000      	callf	f_CANenble
1317                     ; 258    NM_OSEK_Init();
1319  00c4 8d000000      	callf	f_NM_OSEK_Init
1321                     ; 260    DTCinit();
1323  00c8 8d000000      	callf	f_DTCinit
1325                     ; 262    WindowStop();
1327  00cc 8d000000      	callf	f_WindowStop
1329                     ; 263    ENABLE_RX_INT;  
1331  00d0 72145013      	bset	20499,#2
1332                     ; 265    RKE_POWER_ON;
1335  00d4 72115028      	bres	20520,#0
1336                     ; 267    CAN_EN_ON;
1338  00d8 721f500a      	bres	20490,#7
1339                     ; 269    WWDG_Init(0x7f, 0x7f);
1341  00dc ae007f        	ldw	x,#127
1342  00df a67f          	ld	a,#127
1343  00e1 95            	ld	xh,a
1344  00e2 8d000000      	callf	f_WWDG_Init
1346                     ; 272    Did2einit();
1348  00e6 8d000000      	callf	f_Did2einit
1350                     ; 273    DoorWarmState = 0 ;
1352  00ea 725f0000      	clr	_DoorWarmState
1353                     ; 274    BCMtoGEM_AlarmStatus = warmstate;
1355  00ee 5500000000    	mov	_BCMtoGEM_AlarmStatus,_warmstate
1356                     ; 275    Lockonesstate = 0x55;
1358  00f3 35550000      	mov	_Lockonesstate,#85
1359                     ; 277    gNetWorkStatus.bussleep = 0;
1361  00f7 725f0002      	clr	_gNetWorkStatus+2
1362                     ; 278    gNMCANBatFlag = 1;  //nm
1364  00fb 35010000      	mov	_gNMCANBatFlag,#1
1365                     ; 279    gLocalWakeupFlag =1;
1367  00ff 35010000      	mov	_gLocalWakeupFlag,#1
1368  0103               L166:
1369                     ; 283          DeceSettingValueH = 8;
1371  0103 ae0008        	ldw	x,#8
1372  0106 cf0000        	ldw	_DeceSettingValueH,x
1373                     ; 284 		 DeceSettingValueL = 8;
1375  0109 cf0000        	ldw	_DeceSettingValueL,x
1376                     ; 288         if(WakeState != 1)
1378  010c c60025        	ld	a,_WakeState
1379  010f 4a            	dec	a
1380  0110 2604acf801f8  	jreq	L566
1381                     ; 291             if (SysTimeFlag_2MS == TRUE)
1383  0116 c60027        	ld	a,_SysTimeFlag_2MS
1384  0119 4a            	dec	a
1385  011a 262e          	jrne	L766
1386                     ; 294 				SysTimeFlag_2MS = FALSE;
1388  011c c70027        	ld	_SysTimeFlag_2MS,a
1389                     ; 295 				if(cansendstate != 0)cansendstate--;
1391  011f c60000        	ld	a,_cansendstate
1392  0122 2704          	jreq	L176
1395  0124 725a0000      	dec	_cansendstate
1396  0128               L176:
1397                     ; 296 				ADC_Scan();		                    //scan adc convert
1399  0128 8d000000      	callf	f_ADC_Scan
1401                     ; 298 				NM_CNT++;
1403  012c 725c0000      	inc	L146_NM_CNT
1404                     ; 299 				if(NM_CNT & 0x01)
1406  0130 c60000        	ld	a,L146_NM_CNT
1407  0133 a501          	bcp	a,#1
1408                     ; 304 				CANSend();                        //CAN发送程序
1410  0135 8d000000      	callf	f_CANSend
1412                     ; 306 				UDSonCAN_netmain();
1414  0139 8d000000      	callf	f_UDSonCAN_netmain
1416                     ; 308 				BUSoff();
1418  013d 8d000000      	callf	f_BUSoff
1420                     ; 310 				if(HornDoorunclosetime)HornDoorunclosetime--; 
1422  0141 ce0000        	ldw	x,_HornDoorunclosetime
1423  0144 2704          	jreq	L766
1426  0146 5a            	decw	x
1427  0147 cf0000        	ldw	_HornDoorunclosetime,x
1428  014a               L766:
1429                     ; 312             if (SysTimeFlag_8MS == TRUE)
1431  014a c60026        	ld	a,_SysTimeFlag_8MS
1432  014d 4a            	dec	a
1433  014e 26c2          	jrne	L566
1434                     ; 314 				SWSZstate = 0 ;
1436  0150 c70008        	ld	_SWSZstate,a
1437                     ; 315 				SysTimeFlag_8MS = FALSE;     
1439  0153 c70026        	ld	_SysTimeFlag_8MS,a
1440                     ; 317 				WWDG_Refresh(0x7f);
1442  0156 a67f          	ld	a,#127
1443  0158 8d000000      	callf	f_WWDG_Refresh
1445                     ; 321 				Did2esave();
1447  015c 8d000000      	callf	f_Did2esave
1449                     ; 323 				UDSDTC_main();
1451  0160 8d000000      	callf	f_UDSDTC_main
1453                     ; 325 				UDSonCANDiag();
1455  0164 8d000000      	callf	f_UDSonCANDiag
1457                     ; 329 				CANRX();                                    //CAN接收处理
1459  0168 8d000000      	callf	f_CANRX
1461                     ; 332 				ScanIgnSwitch();                      //扫描点火开关  结果在变量  IGNstate
1463  016c 8d000000      	callf	f_ScanIgnSwitch
1465                     ; 334                 ScanH4021InData();                   //扫描4021数据结果在变量 H4021Data 
1467  0170 8d000000      	callf	f_ScanH4021InData
1469                     ; 336                 ScanBatteryVoltage();                //扫描电池电压  结果在变量 BatVoltageState
1471  0174 8d000000      	callf	f_ScanBatteryVoltage
1473                     ; 338                 ScanDefrostSwitch();                 //扫描后除霜开关  结果在变量 DefrostKeySta
1475  0178 8d000000      	callf	f_ScanDefrostSwitch
1477                     ; 340                 ScanHornSwitch();                    //扫描喇叭开关    结果在变量 HornSwitchState
1479  017c 8d000000      	callf	f_ScanHornSwitch
1481                     ; 342                 ScanKeyInState();                    //扫描钥匙状态开关  结果在变量 KeyInState
1483  0180 8d000000      	callf	f_ScanKeyInState
1485                     ; 344                 ScanAllDoorState();                 //扫描车门位置状态  结果在变量 DoorState
1487  0184 8d000000      	callf	f_ScanAllDoorState
1489                     ; 346                 TRUNKwarm();                           //后备箱报警处理
1491  0188 8d000000      	callf	f_TRUNKwarm
1493                     ; 348                 ScanCrashInSignal();    //  20120201 路试取消          //扫描碰撞信号状态  结果在变量 CrashState   变量 LockDrvCmd 该变量意义不明
1495  018c 8d000000      	callf	f_ScanCrashInSignal
1497                     ; 350                 ScanAllLockState();   //????              //扫描门锁闭锁状态  结果在变量 LockState
1499  0190 8d000000      	callf	f_ScanAllLockState
1501                     ; 352                 ScanCentralLockSwitch();        //中控闭锁解锁开关 结果在变量 同时检测LockState CrashState LockDrvCmd 
1503  0194 8d000000      	callf	f_ScanCentralLockSwitch
1505                     ; 354                 ScanTrunkSwitch();                 //扫描行李箱
1507  0198 8d000000      	callf	f_ScanTrunkSwitch
1509                     ; 356                 ScanRkeKeys();
1511  019c 8d000000      	callf	f_ScanRkeKeys
1513                     ; 358                 ScanSeatbeltBuckleState();       //安全带状态扫描  结果在变量 SeatState
1515  01a0 8d000000      	callf	f_ScanSeatbeltBuckleState
1517                     ; 360                 ScanSeatPositionState();           //副驾安全带状态  结果在变量 SeatState
1519  01a4 8d000000      	callf	f_ScanSeatPositionState
1521                     ; 362                 ScanTurnLampState();               //转向灯状态  结果在变量 TurnLampState
1523  01a8 8d000000      	callf	f_ScanTurnLampState
1525                     ; 364                 ScanTurnLampKeys();               //转向灯开关  结果在变量 	TurnLampDrv  此函数未完全看明白
1527  01ac 8d000000      	callf	f_ScanTurnLampKeys
1529                     ; 366                 ScanWindowKeys();    //   1               //扫描车窗状态 结果在 WinKeyState
1531  01b0 8d000000      	callf	f_ScanWindowKeys
1533                     ; 368 		  ScanSmallLampSwitch();
1535  01b4 8d000000      	callf	f_ScanSmallLampSwitch
1537                     ; 370                 ScanFortifySWState();              //设防开关状态扫描 为低不进入设防 已经进入设防退出设防
1539  01b8 8d000000      	callf	f_ScanFortifySWState
1541                     ; 372                 JudgeDefrostDriver();                 //除霜控制
1543  01bc 8d000000      	callf	f_JudgeDefrostDriver
1545                     ; 374                 Clear_WDT();
1547  01c0 8d000000      	callf	f_Clear_WDT
1549                     ; 376                 JudgeHornDriver();                     //喇叭控制
1551  01c4 8d000000      	callf	f_JudgeHornDriver
1553                     ; 378                 JudgeDomeLampDriver();           //顶灯控制
1555  01c8 8d000000      	callf	f_JudgeDomeLampDriver
1557                     ; 380                 JudgeLockDriver();
1559  01cc 8d000000      	callf	f_JudgeLockDriver
1561                     ; 382                 MachineKeyDrv();
1563  01d0 8d000000      	callf	f_MachineKeyDrv
1565                     ; 384                 JudgeTurnLampDrv();
1567  01d4 8d000000      	callf	f_JudgeTurnLampDrv
1569                     ; 386 		  buzzdrv2();
1571  01d8 8d000000      	callf	f_buzzdrv2
1573                     ; 388                 JudgeWarmTypeAndDriver();              
1575  01dc 8d000000      	callf	f_JudgeWarmTypeAndDriver
1577                     ; 390                 FindCar();                                    //寻车
1579  01e0 8d000000      	callf	f_FindCar
1581                     ; 392                 WindowDriver();                //车窗驱动                
1583  01e4 8d000000      	callf	f_WindowDriver
1585                     ; 394                 WarmStatusArithmetic ();          //bcm警戒状态生成
1587  01e8 8d000000      	callf	f_WarmStatusArithmetic
1589                     ; 396                 SFLED();                
1591  01ec 8d000000      	callf	f_SFLED
1593                     ; 398 		  Turnvcclow();
1595  01f0 8d000000      	callf	f_Turnvcclow
1597                     ; 400                 InPutWake();                             //判断进入睡眠模式条件
1599  01f4 8d000200      	callf	f_InPutWake
1601  01f8               L566:
1602                     ; 406         InOutputWake();
1604  01f8 8d240424      	callf	f_InOutputWake
1607  01fc ac030103      	jra	L166
1609                     	switch	.data
1610  0000               _insleepnetcnt:
1611  0000 00            	dc.b	0
1612  0001               _keyinstatesleep:
1613  0001 0000          	dc.w	0
1614  0003               _Hazzardtimecnt:
1615  0003 0000          	dc.w	0
1616                     	switch	.bss
1617  0001               L707_systemsleep:
1618  0001 0000          	ds.b	2
1619  0003               L307_KeyInState_old1:
1620  0003 00            	ds.b	1
1678                     ; 429 void  InPutWake(void)
1678                     ; 430 {
1679                     	switch	.text
1680  0200               f_InPutWake:
1684                     ; 437 	if(HazzardState == Pressed)   Hazzardtimecnt = 0;
1686  0200 c60000        	ld	a,_HazzardState
1687  0203 a155          	cp	a,#85
1688  0205 2604          	jrne	L727
1691  0207 5f            	clrw	x
1692  0208 cf0003        	ldw	_Hazzardtimecnt,x
1693  020b               L727:
1694                     ; 438 	if(Hazzardtimecnt) Hazzardtimecnt--;
1696  020b ce0003        	ldw	x,_Hazzardtimecnt
1697  020e 2704          	jreq	L137
1700  0210 5a            	decw	x
1701  0211 cf0003        	ldw	_Hazzardtimecnt,x
1702  0214               L137:
1703                     ; 439        if(canrextime)canrextime--;
1705  0214 c60000        	ld	a,_canrextime
1706  0217 2704          	jreq	L337
1709  0219 725a0000      	dec	_canrextime
1710  021d               L337:
1711                     ; 440 	 if((IGNstate == ON)&&(KeyInState == KeyIsInHole)){ wakestate = 0; IGNsleeptime = 7500;keyinstatesleep = 0;}
1713  021d c60000        	ld	a,_IGNstate
1714  0220 a155          	cp	a,#85
1715  0222 2614          	jrne	L537
1717  0224 c60000        	ld	a,_KeyInState
1718  0227 4a            	dec	a
1719  0228 260e          	jrne	L537
1722  022a 5f            	clrw	x
1723  022b cf0019        	ldw	_wakestate,x
1726  022e ae1d4c        	ldw	x,#7500
1727  0231 cf0004        	ldw	_IGNsleeptime,x
1730  0234 5f            	clrw	x
1731  0235 cf0001        	ldw	_keyinstatesleep,x
1732  0238               L537:
1733                     ; 441 	 if((IGNstate == ON)&&(KeyInState == KeyIsOutHole)){ wakestate = 0; IGNsleeptime = 7500;keyinstatesleep = 0;}
1735  0238 c60000        	ld	a,_IGNstate
1736  023b a155          	cp	a,#85
1737  023d 2612          	jrne	L737
1739  023f c60000        	ld	a,_KeyInState
1740  0242 260d          	jrne	L737
1743  0244 5f            	clrw	x
1744  0245 cf0019        	ldw	_wakestate,x
1747  0248 ae1d4c        	ldw	x,#7500
1748  024b cf0004        	ldw	_IGNsleeptime,x
1751  024e 5f            	clrw	x
1753  024f 200e          	jpf	LC001
1754  0251               L737:
1755                     ; 442 	 else if((KeyInState == KeyIsOutHole)&&(canrextime ==0)){IGNsleeptime = 0;keyinstatesleep = 0;}
1757  0251 c60000        	ld	a,_KeyInState
1758  0254 260c          	jrne	L147
1760  0256 c60000        	ld	a,_canrextime
1761  0259 2607          	jrne	L147
1764  025b 5f            	clrw	x
1765  025c cf0004        	ldw	_IGNsleeptime,x
1768  025f               LC001:
1769  025f cf0001        	ldw	_keyinstatesleep,x
1770  0262               L147:
1771                     ; 443 	 if(IGNsleeptime) IGNsleeptime--;
1773  0262 ce0004        	ldw	x,_IGNsleeptime
1774  0265 2704          	jreq	L547
1777  0267 5a            	decw	x
1778  0268 cf0004        	ldw	_IGNsleeptime,x
1779  026b               L547:
1780                     ; 446 	 if(RKEStandByWakeupState == 0x55 ) {RKEStandByWakeupState=0 ; wakestate = 0 ;}
1782  026b c60015        	ld	a,_RKEStandByWakeupState
1783  026e a155          	cp	a,#85
1784  0270 2608          	jrne	L747
1787  0272 725f0015      	clr	_RKEStandByWakeupState
1790  0276 5f            	clrw	x
1791  0277 cf0019        	ldw	_wakestate,x
1792  027a               L747:
1793                     ; 448 	 if((DoorState == AllDoorIsClosed)&&(IGNsleeptime == 0)&&(keyinstatesleep!=0x55)&&(LockDrvCmd == 0))//&&(BCMtoGEM_AlarmStatus == Armed))
1795  027a c60000        	ld	a,_DoorState
1796  027d 264d          	jrne	L157
1798  027f ce0004        	ldw	x,_IGNsleeptime
1799  0282 2648          	jrne	L157
1801  0284 ce0001        	ldw	x,_keyinstatesleep
1802  0287 a30055        	cpw	x,#85
1803  028a 2740          	jreq	L157
1805  028c c60000        	ld	a,_LockDrvCmd
1806  028f 263b          	jrne	L157
1807                     ; 450 	          if(TURN_LEFT_LAMP_OUT||TURN_RIGHT_LAMP_OUT||(BUZZER_OUT)) wakestate = 0;
1809  0291 720850190a    	btjt	20505,#4,L557
1811  0296 720a501905    	btjt	20505,#5,L557
1813  029b 7207500f04    	btjf	20495,#3,L357
1814  02a0               L557:
1817  02a0 5f            	clrw	x
1818  02a1 cf0019        	ldw	_wakestate,x
1819  02a4               L357:
1820                     ; 451                  if(Hazzardtimecnt) wakestate=0;
1822  02a4 ce0003        	ldw	x,_Hazzardtimecnt
1823  02a7 2704          	jreq	L167
1826  02a9 5f            	clrw	x
1827  02aa cf0019        	ldw	_wakestate,x
1828  02ad               L167:
1829                     ; 452 	          if(wakestate < 125 ) wakestate ++;
1831  02ad ce0019        	ldw	x,_wakestate
1832  02b0 a3007d        	cpw	x,#125
1833  02b3 2406          	jruge	L367
1836  02b5 5c            	incw	x
1837  02b6 cf0019        	ldw	_wakestate,x
1839  02b9 2011          	jra	L157
1840  02bb               L367:
1841                     ; 453 		   else if(wakestate ==125)
1843  02bb a3007d        	cpw	x,#125
1844  02be 260c          	jrne	L157
1845                     ; 455 		       wakestate++;
1847  02c0 5c            	incw	x
1848  02c1 cf0019        	ldw	_wakestate,x
1849                     ; 457 		       gNetWorkStatus.bussleep = 1;
1851  02c4 35010002      	mov	_gNetWorkStatus+2,#1
1852                     ; 458                      insleepnetcnt=1;
1854  02c8 35010000      	mov	_insleepnetcnt,#1
1855  02cc               L157:
1856                     ; 464        if(wakerkestate ==0x55){systemsleep = 0;wakerkestate = 0;}
1858  02cc c60007        	ld	a,_wakerkestate
1859  02cf a155          	cp	a,#85
1860  02d1 2608          	jrne	L177
1863  02d3 5f            	clrw	x
1864  02d4 cf0001        	ldw	L707_systemsleep,x
1867  02d7 725f0007      	clr	_wakerkestate
1868  02db               L177:
1869                     ; 466        if((DoorState != AllDoorIsClosed)&&(insleepnetcnt == 1) ){insleepnetcnt = 0;gLocalWakeupFlag = 1;gNetWorkStatus.bussleep = 0;systemsleep = 0;wakestate = 0;WakeUp();}
1871  02db c60000        	ld	a,_DoorState
1872  02de 271b          	jreq	L377
1874  02e0 c60000        	ld	a,_insleepnetcnt
1875  02e3 4a            	dec	a
1876  02e4 2615          	jrne	L377
1879  02e6 c70000        	ld	_insleepnetcnt,a
1882  02e9 35010000      	mov	_gLocalWakeupFlag,#1
1885  02ed c70002        	ld	_gNetWorkStatus+2,a
1888  02f0 5f            	clrw	x
1889  02f1 cf0001        	ldw	L707_systemsleep,x
1892  02f4 cf0019        	ldw	_wakestate,x
1895  02f7 8d730073      	callf	f_WakeUp
1897  02fb               L377:
1898                     ; 467        if(KeyInState_old1!=KeyInState)
1900  02fb c60003        	ld	a,L307_KeyInState_old1
1901  02fe c10000        	cp	a,_KeyInState
1902  0301 272a          	jreq	L577
1903                     ; 469             KeyInState_old1  =KeyInState;
1905  0303 c60000        	ld	a,_KeyInState
1906  0306 c70003        	ld	L307_KeyInState_old1,a
1907                     ; 470             if((KeyInState == KeyIsInHole) &&(insleepnetcnt == 1)){insleepnetcnt = 0;keyinstatesleep = 0x55;gLocalWakeupFlag = 1;gNetWorkStatus.bussleep = 0;systemsleep = 0;wakestate = 0;WakeUp();}
1909  0309 4a            	dec	a
1910  030a 2621          	jrne	L577
1912  030c c60000        	ld	a,_insleepnetcnt
1913  030f 4a            	dec	a
1914  0310 261b          	jrne	L577
1917  0312 c70000        	ld	_insleepnetcnt,a
1920  0315 ae0055        	ldw	x,#85
1921  0318 cf0001        	ldw	_keyinstatesleep,x
1924  031b 35010000      	mov	_gLocalWakeupFlag,#1
1927  031f c70002        	ld	_gNetWorkStatus+2,a
1930  0322 5f            	clrw	x
1931  0323 cf0001        	ldw	L707_systemsleep,x
1934  0326 cf0019        	ldw	_wakestate,x
1937  0329 8d730073      	callf	f_WakeUp
1939  032d               L577:
1940                     ; 472        if((IGNstate ==ON)&&(insleepnetcnt == 1)){insleepnetcnt = 0;gLocalWakeupFlag = 1;gNetWorkStatus.bussleep = 0;systemsleep = 0;wakestate = 0;WakeUp();}
1942  032d c60000        	ld	a,_IGNstate
1943  0330 a155          	cp	a,#85
1944  0332 261b          	jrne	L1001
1946  0334 c60000        	ld	a,_insleepnetcnt
1947  0337 4a            	dec	a
1948  0338 2615          	jrne	L1001
1951  033a c70000        	ld	_insleepnetcnt,a
1954  033d 35010000      	mov	_gLocalWakeupFlag,#1
1957  0341 c70002        	ld	_gNetWorkStatus+2,a
1960  0344 5f            	clrw	x
1961  0345 cf0001        	ldw	L707_systemsleep,x
1964  0348 cf0019        	ldw	_wakestate,x
1967  034b 8d730073      	callf	f_WakeUp
1969  034f               L1001:
1970                     ; 473        if((HazzardState == Pressed)&&(insleepnetcnt == 1)){insleepnetcnt = 0;gLocalWakeupFlag = 1;gNetWorkStatus.bussleep = 0;systemsleep = 0;wakestate = 0;WakeUp();}
1972  034f c60000        	ld	a,_HazzardState
1973  0352 a155          	cp	a,#85
1974  0354 261b          	jrne	L3001
1976  0356 c60000        	ld	a,_insleepnetcnt
1977  0359 4a            	dec	a
1978  035a 2615          	jrne	L3001
1981  035c c70000        	ld	_insleepnetcnt,a
1984  035f 35010000      	mov	_gLocalWakeupFlag,#1
1987  0363 c70002        	ld	_gNetWorkStatus+2,a
1990  0366 5f            	clrw	x
1991  0367 cf0001        	ldw	L707_systemsleep,x
1994  036a cf0019        	ldw	_wakestate,x
1997  036d 8d730073      	callf	f_WakeUp
1999  0371               L3001:
2000                     ; 475        if((LOCK_OUT || UNLOCK_OUT || TRUNK_UNLOCK_OUT)&&(insleepnetcnt == 1)){insleepnetcnt = 0;gLocalWakeupFlag = 1;gNetWorkStatus.bussleep = 0;systemsleep = 0;wakestate = 0;WakeUp();}
2002  0371 720850140a    	btjt	20500,#4,L7001
2004  0376 720e501e05    	btjt	20510,#7,L7001
2006  037b 720150141b    	btjf	20500,#0,L5001
2007  0380               L7001:
2009  0380 c60000        	ld	a,_insleepnetcnt
2010  0383 4a            	dec	a
2011  0384 2615          	jrne	L5001
2014  0386 c70000        	ld	_insleepnetcnt,a
2017  0389 35010000      	mov	_gLocalWakeupFlag,#1
2020  038d c70002        	ld	_gNetWorkStatus+2,a
2023  0390 5f            	clrw	x
2024  0391 cf0001        	ldw	L707_systemsleep,x
2027  0394 cf0019        	ldw	_wakestate,x
2030  0397 8d730073      	callf	f_WakeUp
2032  039b               L5001:
2033                     ; 479      if((gNMHasSleeped == 1)&&(DomeLampDrv == OFF)&&(LockState == Locked))
2035  039b c60000        	ld	a,_gNMHasSleeped
2036  039e 4a            	dec	a
2037  039f 2645          	jrne	L3101
2039  03a1 c60000        	ld	a,_DomeLampDrv
2040  03a4 2640          	jrne	L3101
2042  03a6 c60000        	ld	a,_LockState
2043  03a9 a155          	cp	a,#85
2044  03ab 2639          	jrne	L3101
2045                     ; 481               if(TURN_LEFT_LAMP_OUT||TURN_RIGHT_LAMP_OUT||(BUZZER_OUT)) systemsleep = 0;
2047  03ad 720850190a    	btjt	20505,#4,L7101
2049  03b2 720a501905    	btjt	20505,#5,L7101
2051  03b7 7207500f04    	btjf	20495,#3,L5101
2052  03bc               L7101:
2055  03bc 5f            	clrw	x
2056  03bd cf0001        	ldw	L707_systemsleep,x
2057  03c0               L5101:
2058                     ; 482 		if(systemsleep < 1250)systemsleep++;
2060  03c0 ce0001        	ldw	x,L707_systemsleep
2061  03c3 a304e2        	cpw	x,#1250
2062  03c6 2403          	jruge	L3201
2065  03c8 5c            	incw	x
2067  03c9 201c          	jpf	LC002
2068  03cb               L3201:
2069                     ; 483 		else if(systemsleep == 1250)
2071  03cb a304e2        	cpw	x,#1250
2072  03ce 261a          	jrne	L1301
2073                     ; 486 		       WakeState = 1;  
2075  03d0 35010025      	mov	_WakeState,#1
2076                     ; 487 		       LIN_DISENABLE; 
2078  03d4 7219500f      	bres	20495,#4
2079                     ; 488 			TURN_AD_RIGHT_EN;
2081  03d8 721e5019      	bset	20505,#7
2082                     ; 490 			 CAN_EN_OFF;
2084  03dc 721e500a      	bset	20490,#7
2085                     ; 491 			AWU_Init(WakeCycle);
2087  03e0 a609          	ld	a,#9
2090  03e2 ac000000      	jpf	f_AWU_Init
2091  03e6               L3101:
2092                     ; 495      else systemsleep = 0;
2094  03e6 5f            	clrw	x
2095  03e7               LC002:
2096  03e7 cf0001        	ldw	L707_systemsleep,x
2097  03ea               L1301:
2098                     ; 496 }
2101  03ea 87            	retf	
2128                     ; 509 void OneSecondWake(void)
2128                     ; 510 {
2129                     	switch	.text
2130  03eb               f_OneSecondWake:
2134                     ; 512       if(RKEStandByWakeupState == 0x55 )
2136  03eb c60015        	ld	a,_RKEStandByWakeupState
2137  03ee a155          	cp	a,#85
2138  03f0 2631          	jrne	L3401
2139                     ; 514             if (RKEStandByWakeupcnt < 250) 
2141  03f2 c60014        	ld	a,_RKEStandByWakeupcnt
2142  03f5 a1fa          	cp	a,#250
2143  03f7 2414          	jruge	L5401
2144                     ; 516                   RKEStandByWakeupcnt++;
2146  03f9 725c0014      	inc	_RKEStandByWakeupcnt
2147                     ; 517                   if(RKE_COMMAND_StandBy_state == 0x11)
2149  03fd c60000        	ld	a,_RKE_COMMAND_StandBy_state
2150  0400 a111          	cp	a,#17
2151  0402 261f          	jrne	L3401
2152                     ; 519                       RKE_COMMAND_StandBy_state = 0;
2154  0404 725f0000      	clr	_RKE_COMMAND_StandBy_state
2155                     ; 520                       RKEStandByWakeupState = 0;
2157  0408 725f0015      	clr	_RKEStandByWakeupState
2159  040c 87            	retf	
2160  040d               L5401:
2161                     ; 524             else if (RKEStandByWakeupcnt == 250)
2163  040d a1fa          	cp	a,#250
2164  040f 2612          	jrne	L3401
2165                     ; 531                   WakeState = 1;        //置睡眠标志
2167  0411 35010025      	mov	_WakeState,#1
2168                     ; 532                   RKEStandByWakeupState = 0;
2170  0415 725f0015      	clr	_RKEStandByWakeupState
2171                     ; 533                  AWU_Init(WakeCycle);
2173  0419 a609          	ld	a,#9
2174  041b 8d000000      	callf	f_AWU_Init
2176                     ; 535 				 CAN_EN_OFF;
2178  041f 721e500a      	bset	20490,#7
2179  0423               L3401:
2180                     ; 541 }
2183  0423 87            	retf	
2237                     ; 555  void InOutputWake(void)
2237                     ; 556 {
2238                     	switch	.text
2239  0424               f_InOutputWake:
2243                     ; 559        if (WakeState == 1) 
2245  0424 c60025        	ld	a,_WakeState
2246  0427 4a            	dec	a
2247  0428 2704acdb04db  	jrne	L7601
2248                     ; 561             ENABLE_RX_INT;
2250  042e 72145013      	bset	20499,#2
2251                     ; 564             Clear_WDT();  ////////////////////////////////////////////////
2254  0432 8d000000      	callf	f_Clear_WDT
2256                     ; 565             SWSZstate = 0x55 ;
2258  0436 35550008      	mov	_SWSZstate,#85
2259                     ; 592 		WWDG_Refresh(0x7f);
2261  043a a67f          	ld	a,#127
2262  043c 8d000000      	callf	f_WWDG_Refresh
2264                     ; 595             nop();
2267  0440 9d            	nop	
2269                     ; 596             nop();
2273  0441 9d            	nop	
2275                     ; 597             nop();
2279  0442 9d            	nop	
2281                     ; 598             RKE_POWER_ON;
2284  0443 72115028      	bres	20520,#0
2285                     ; 599             nop();
2288  0447 9d            	nop	
2290                     ; 600             nop();            
2294  0448 9d            	nop	
2296                     ; 601             nop();
2300  0449 9d            	nop	
2302                     ; 602             RKE_POWER_ON;            
2305  044a 72115028      	bres	20520,#0
2306                     ; 603             nop();
2309  044e 9d            	nop	
2311                     ; 604             nop();
2315  044f 9d            	nop	
2317                     ; 605             nop();           
2321  0450 9d            	nop	
2323                     ; 606             RkeScanCnt = 0;
2326  0451 5f            	clrw	x
2327  0452 cf0017        	ldw	_RkeScanCnt,x
2328  0455               L1701:
2329                     ; 610                     Clear_WDT();	
2331  0455 8d000000      	callf	f_Clear_WDT
2333                     ; 611                     delay_10us(100);
2335  0459 ae0064        	ldw	x,#100
2336  045c 8d2a002a      	callf	f_delay_10us
2338                     ; 612                     RkeScanCnt++;
2340  0460 ce0017        	ldw	x,_RkeScanCnt
2341  0463 5c            	incw	x
2342  0464 cf0017        	ldw	_RkeScanCnt,x
2343                     ; 613                     if(WaveFilterCnt >= 5)
2345  0467 c60016        	ld	a,_WaveFilterCnt
2346  046a a105          	cp	a,#5
2347  046c 2516          	jrult	L7701
2348                     ; 616 				WakeUp();
2350  046e 8d730073      	callf	f_WakeUp
2352                     ; 618 				RKEStandByWakeupState = 0x55;
2354  0472 35550015      	mov	_RKEStandByWakeupState,#85
2355                     ; 624 				wakerkestate = 0x55;
2357  0476 35550007      	mov	_wakerkestate,#85
2358                     ; 627 				CAN_EN_ON;
2360  047a 721f500a      	bres	20490,#7
2361                     ; 629 				WaveFilterCnt = 0;
2363  047e 725f0016      	clr	_WaveFilterCnt
2364                     ; 631 				break;
2366  0482 2005          	jra	L5701
2367  0484               L7701:
2368                     ; 608             while(RkeScanCnt < RKEShortDownTime)
2370  0484 a30009        	cpw	x,#9
2371  0487 25cc          	jrult	L1701
2372  0489               L5701:
2373                     ; 634             WaveFilterCnt = 0;
2375  0489 725f0016      	clr	_WaveFilterCnt
2376                     ; 636             ScanH4021InData(); 
2378  048d 8d000000      	callf	f_ScanH4021InData
2380                     ; 638             ScanStandByHazzardKeys();
2382  0491 8d000000      	callf	f_ScanStandByHazzardKeys
2384                     ; 640             ScanStandByDoorAjarSwitch();
2386  0495 8d000000      	callf	f_ScanStandByDoorAjarSwitch
2388                     ; 642             ScanStandByCrashInSignal();
2390  0499 8d000000      	callf	f_ScanStandByCrashInSignal
2392                     ; 644             ScanStandbyIgnSwitch();
2394  049d 8d000000      	callf	f_ScanStandbyIgnSwitch
2396                     ; 651             if(StandByState == Pressed)//||(BCMtoGEM_AlarmStatus != Armed))
2398  04a1 c60020        	ld	a,_StandByState
2399  04a4 a155          	cp	a,#85
2400  04a6 2614          	jrne	L1011
2401                     ; 653 			StandByState = 0 ;                
2403  04a8 725f0020      	clr	_StandByState
2404                     ; 655 			WakeUp();
2406  04ac 8d730073      	callf	f_WakeUp
2408                     ; 656 			WakeState = 0;
2410  04b0 725f0025      	clr	_WakeState
2411                     ; 658 			wakerkestate = 0x55;
2413  04b4 35550007      	mov	_wakerkestate,#85
2414                     ; 667 			CAN_EN_ON;
2416  04b8 721f500a      	bres	20490,#7
2417  04bc               L1011:
2418                     ; 670             if(WakeState != 0)
2420  04bc c60025        	ld	a,_WakeState
2421  04bf 271a          	jreq	L7601
2422                     ; 672                 DISABLE_RX_INT ;
2424  04c1 72155013      	bres	20499,#2
2425                     ; 673                 RKE_SHUT_DOWN;
2428  04c5 72105028      	bset	20520,#0
2429                     ; 674                 nop();
2432  04c9 9d            	nop	
2434                     ; 675                 nop();
2438  04ca 9d            	nop	
2440                     ; 676                 RKE_SHUT_DOWN; 
2443  04cb 72105028      	bset	20520,#0
2444                     ; 677                 delay_10us(5);
2446  04cf ae0005        	ldw	x,#5
2447  04d2 8d2a002a      	callf	f_delay_10us
2449                     ; 678                 nop();
2452  04d6 9d            	nop	
2454                     ; 679                 nop();
2458  04d7 9d            	nop	
2460                     ; 680                 halt();         //进入低功耗
2464  04d8 8e            	halt	
2466                     ; 681                 nop();
2470  04d9 9d            	nop	
2472                     ; 682                 nop();
2476  04da 9d            	nop	
2479  04db               L7601:
2480                     ; 687 }
2483  04db 87            	retf	
2538                     ; 703 void ONSEINITEeprom(void)
2538                     ; 704 {
2539                     	switch	.text
2540  04dc               f_ONSEINITEeprom:
2542  04dc 5206          	subw	sp,#6
2543       00000006      OFST:	set	6
2546                     ; 707      if ( ONESstate != 0x1234 )
2548  04de ce0000        	ldw	x,_ONESstate
2549  04e1 a31234        	cpw	x,#4660
2550  04e4 2604ac7b067b  	jreq	L5211
2551                     ; 710             for(i = 0; i<EECNT; i++)
2553  04ea 0f01          	clr	(OFST-5,sp)
2554  04ec               L7211:
2555                     ; 712                 temp = (u32)(&ONESstate);                                   
2557  04ec ae0000        	ldw	x,#_ONESstate
2558  04ef 8d000000      	callf	d_uitolx
2560  04f3 96            	ldw	x,sp
2561  04f4 1c0002        	addw	x,#OFST-4
2562  04f7 8d000000      	callf	d_rtol
2564                     ; 713                 res = 0x12;
2566                     ; 714                 FLASH_ProgramByte(temp, res);
2568  04fb 4b12          	push	#18
2569  04fd 1e05          	ldw	x,(OFST-1,sp)
2570  04ff 89            	pushw	x
2571  0500 1e05          	ldw	x,(OFST-1,sp)
2572  0502 89            	pushw	x
2573  0503 8d000000      	callf	f_FLASH_ProgramByte
2575  0507 5b05          	addw	sp,#5
2576                     ; 715                 temp++ ;                                   
2578  0509 96            	ldw	x,sp
2579  050a 1c0002        	addw	x,#OFST-4
2580  050d a601          	ld	a,#1
2581  050f 8d000000      	callf	d_lgadc
2583                     ; 716                 res = 0x34;
2585                     ; 717                 FLASH_ProgramByte(temp, res);
2587  0513 4b34          	push	#52
2588  0515 1e05          	ldw	x,(OFST-1,sp)
2589  0517 89            	pushw	x
2590  0518 1e05          	ldw	x,(OFST-1,sp)
2591  051a 89            	pushw	x
2592  051b 8d000000      	callf	f_FLASH_ProgramByte
2594  051f 5b05          	addw	sp,#5
2595                     ; 718                 if(ONESstate == 1234)
2597  0521 ce0000        	ldw	x,_ONESstate
2598  0524 a304d2        	cpw	x,#1234
2599  0527 2708          	jreq	L3311
2600                     ; 720                      break;
2602                     ; 710             for(i = 0; i<EECNT; i++)
2604  0529 0c01          	inc	(OFST-5,sp)
2607  052b 7b01          	ld	a,(OFST-5,sp)
2608  052d a10a          	cp	a,#10
2609  052f 25bb          	jrult	L7211
2610  0531               L3311:
2611                     ; 724             for(i = 0 ; i<EECNT;i++)
2613  0531 0f01          	clr	(OFST-5,sp)
2614  0533               L7311:
2615                     ; 726                    temp = (u32)(&VehicleType) ;                                   
2617  0533 ae0000        	ldw	x,#_VehicleType
2618  0536 8d000000      	callf	d_uitolx
2620  053a 96            	ldw	x,sp
2621  053b 1c0002        	addw	x,#OFST-4
2622  053e 8d000000      	callf	d_rtol
2624                     ; 727                    res =  CV101;
2626                     ; 728                    FLASH_ProgramByte(temp, res);
2628  0542 4b30          	push	#48
2629  0544 1e05          	ldw	x,(OFST-1,sp)
2630  0546 89            	pushw	x
2631  0547 1e05          	ldw	x,(OFST-1,sp)
2632  0549 89            	pushw	x
2633  054a 8d000000      	callf	f_FLASH_ProgramByte
2635  054e 5b05          	addw	sp,#5
2636                     ; 729                    if(VehicleType == CV8)
2638  0550 c60000        	ld	a,_VehicleType
2639  0553 a120          	cp	a,#32
2640  0555 2708          	jreq	L3411
2641                     ; 731                       break;
2643                     ; 724             for(i = 0 ; i<EECNT;i++)
2645  0557 0c01          	inc	(OFST-5,sp)
2648  0559 7b01          	ld	a,(OFST-5,sp)
2649  055b a10a          	cp	a,#10
2650  055d 25d4          	jrult	L7311
2651  055f               L3411:
2652                     ; 737             for(i=0;i<EECNT;i++)
2654  055f 0f01          	clr	(OFST-5,sp)
2655  0561               L7411:
2656                     ; 739                 temp = (u32)(&PassWord1) ;                                   
2658  0561 ae0000        	ldw	x,#_PassWord1
2659  0564 8d000000      	callf	d_uitolx
2661  0568 96            	ldw	x,sp
2662  0569 1c0002        	addw	x,#OFST-4
2663  056c 8d000000      	callf	d_rtol
2665                     ; 740                 res = 0x00;
2667                     ; 741                 FLASH_ProgramByte(temp, res);
2669  0570 4b00          	push	#0
2670  0572 1e05          	ldw	x,(OFST-1,sp)
2671  0574 89            	pushw	x
2672  0575 1e05          	ldw	x,(OFST-1,sp)
2673  0577 89            	pushw	x
2674  0578 8d000000      	callf	f_FLASH_ProgramByte
2676  057c 5b05          	addw	sp,#5
2677                     ; 742                 temp++ ;                                   
2679  057e 96            	ldw	x,sp
2680  057f 1c0002        	addw	x,#OFST-4
2681  0582 a601          	ld	a,#1
2682  0584 8d000000      	callf	d_lgadc
2684                     ; 743                 res = 0x00;
2686                     ; 744                 FLASH_ProgramByte(temp, res);
2688  0588 4b00          	push	#0
2689  058a 1e05          	ldw	x,(OFST-1,sp)
2690  058c 89            	pushw	x
2691  058d 1e05          	ldw	x,(OFST-1,sp)
2692  058f 89            	pushw	x
2693  0590 8d000000      	callf	f_FLASH_ProgramByte
2695  0594 5b05          	addw	sp,#5
2696                     ; 745                 temp = (u32)(&PassWord2) ;                                   
2698  0596 ae0000        	ldw	x,#_PassWord2
2699  0599 8d000000      	callf	d_uitolx
2701  059d 96            	ldw	x,sp
2702  059e 1c0002        	addw	x,#OFST-4
2703  05a1 8d000000      	callf	d_rtol
2705                     ; 746                 res = 0x00;
2707                     ; 747                 FLASH_ProgramByte(temp, res);
2709  05a5 4b00          	push	#0
2710  05a7 1e05          	ldw	x,(OFST-1,sp)
2711  05a9 89            	pushw	x
2712  05aa 1e05          	ldw	x,(OFST-1,sp)
2713  05ac 89            	pushw	x
2714  05ad 8d000000      	callf	f_FLASH_ProgramByte
2716  05b1 5b05          	addw	sp,#5
2717                     ; 748                 temp++ ;                                   
2719  05b3 96            	ldw	x,sp
2720  05b4 1c0002        	addw	x,#OFST-4
2721  05b7 a601          	ld	a,#1
2722  05b9 8d000000      	callf	d_lgadc
2724                     ; 749                 res = 0x00;
2726                     ; 750                 FLASH_ProgramByte(temp, res);
2728  05bd 4b00          	push	#0
2729  05bf 1e05          	ldw	x,(OFST-1,sp)
2730  05c1 89            	pushw	x
2731  05c2 1e05          	ldw	x,(OFST-1,sp)
2732  05c4 89            	pushw	x
2733  05c5 8d000000      	callf	f_FLASH_ProgramByte
2735  05c9 5b05          	addw	sp,#5
2736                     ; 751                 if ((PassWord1 == 0x0000)&&(PassWord2 ==0x0000)) break;
2738  05cb ce0000        	ldw	x,_PassWord1
2739  05ce 2605          	jrne	L5511
2741  05d0 ce0000        	ldw	x,_PassWord2
2742  05d3 2708          	jreq	L3511
2745  05d5               L5511:
2746                     ; 737             for(i=0;i<EECNT;i++)
2748  05d5 0c01          	inc	(OFST-5,sp)
2751  05d7 7b01          	ld	a,(OFST-5,sp)
2752  05d9 a10a          	cp	a,#10
2753  05db 2584          	jrult	L7411
2754  05dd               L3511:
2755                     ; 754             ClearDTC();
2757  05dd 8d000000      	callf	f_ClearDTC
2759                     ; 756             RX_SerialNum = 0x00000000 ;
2761  05e1 5f            	clrw	x
2762  05e2 cf0002        	ldw	_RX_SerialNum+2,x
2763  05e5 cf0000        	ldw	_RX_SerialNum,x
2764                     ; 757             SAVE_SERIAL_NUMBER(0);
2766  05e8 4f            	clr	a
2767  05e9 8d000000      	callf	f_SAVE_SERIAL_NUMBER
2769                     ; 758             SAVE_SERIAL_NUMBER(1);
2771  05ed a601          	ld	a,#1
2772  05ef 8d000000      	callf	f_SAVE_SERIAL_NUMBER
2774                     ; 759             SAVE_SERIAL_NUMBER(2);
2776  05f3 a602          	ld	a,#2
2777  05f5 8d000000      	callf	f_SAVE_SERIAL_NUMBER
2779                     ; 760             SAVE_SERIAL_NUMBER(3);
2781  05f9 a603          	ld	a,#3
2782  05fb 8d000000      	callf	f_SAVE_SERIAL_NUMBER
2784                     ; 762             Clear_WDT();   
2786  05ff 8d000000      	callf	f_Clear_WDT
2788                     ; 763             for ( i=0 ; i<EECNT;i++)
2790  0603 0f01          	clr	(OFST-5,sp)
2791  0605 ae0000        	ldw	x,#_BCMnumber
2792  0608               L7511:
2793                     ; 765                 temp = (u32)( &BCMnumber );                                                                                                               
2795  0608 8d000000      	callf	d_uitolx
2797  060c 96            	ldw	x,sp
2798  060d 1c0002        	addw	x,#OFST-4
2799  0610 8d000000      	callf	d_rtol
2801                     ; 766                 res = 0x00 ;
2803                     ; 767                 FLASH_ProgramByte(temp, res);
2805  0614 4b00          	push	#0
2806  0616 1e05          	ldw	x,(OFST-1,sp)
2807  0618 89            	pushw	x
2808  0619 1e05          	ldw	x,(OFST-1,sp)
2809  061b 89            	pushw	x
2810  061c 8d000000      	callf	f_FLASH_ProgramByte
2812  0620 5b05          	addw	sp,#5
2813                     ; 768                 temp++;
2815  0622 96            	ldw	x,sp
2816  0623 1c0002        	addw	x,#OFST-4
2817  0626 a601          	ld	a,#1
2818  0628 8d000000      	callf	d_lgadc
2820                     ; 769                 res = 0x00 ;
2822                     ; 770                 FLASH_ProgramByte(temp, res);
2824  062c 4b00          	push	#0
2825  062e 1e05          	ldw	x,(OFST-1,sp)
2826  0630 89            	pushw	x
2827  0631 1e05          	ldw	x,(OFST-1,sp)
2828  0633 89            	pushw	x
2829  0634 8d000000      	callf	f_FLASH_ProgramByte
2831  0638 5b05          	addw	sp,#5
2832                     ; 771                 temp++;
2834  063a 96            	ldw	x,sp
2835  063b 1c0002        	addw	x,#OFST-4
2836  063e a601          	ld	a,#1
2837  0640 8d000000      	callf	d_lgadc
2839                     ; 772                 res = 0x00 ;                                                        
2841                     ; 773                 FLASH_ProgramByte(temp, res);
2843  0644 4b00          	push	#0
2844  0646 1e05          	ldw	x,(OFST-1,sp)
2845  0648 89            	pushw	x
2846  0649 1e05          	ldw	x,(OFST-1,sp)
2847  064b 89            	pushw	x
2848  064c 8d000000      	callf	f_FLASH_ProgramByte
2850  0650 5b05          	addw	sp,#5
2851                     ; 774                 temp++;
2853  0652 96            	ldw	x,sp
2854  0653 1c0002        	addw	x,#OFST-4
2855  0656 a601          	ld	a,#1
2856  0658 8d000000      	callf	d_lgadc
2858                     ; 775                 res = 0x00 ;
2860                     ; 776                 FLASH_ProgramByte(temp, res);
2862  065c 4b00          	push	#0
2863  065e 1e05          	ldw	x,(OFST-1,sp)
2864  0660 89            	pushw	x
2865  0661 1e05          	ldw	x,(OFST-1,sp)
2866  0663 89            	pushw	x
2867  0664 8d000000      	callf	f_FLASH_ProgramByte
2869  0668 5b05          	addw	sp,#5
2870                     ; 777                 if(BCMnumber == 0x00000000)break;
2872  066a ae0000        	ldw	x,#_BCMnumber
2873  066d 8d000000      	callf	d_lzmp
2875  0671 2708          	jreq	L5211
2878                     ; 763             for ( i=0 ; i<EECNT;i++)
2880  0673 0c01          	inc	(OFST-5,sp)
2883  0675 7b01          	ld	a,(OFST-5,sp)
2884  0677 a10a          	cp	a,#10
2885  0679 258d          	jrult	L7511
2886  067b               L5211:
2887                     ; 792 }
2890  067b 5b06          	addw	sp,#6
2891  067d 87            	retf	
2949                     ; 806 unsigned char Weeprommain(unsigned long temp,unsigned char value)
2949                     ; 807 {    
2950                     	switch	.text
2951  067e               f_Weeprommain:
2953  067e 5204          	subw	sp,#4
2954       00000004      OFST:	set	4
2957                     ; 811 	FLASH_DeInit( );
2959  0680 8d000000      	callf	f_FLASH_DeInit
2961                     ; 812 	FLASH_Unlock(FLASH_MEMTYPE_DATA);  //程序调试取消写保护
2963  0684 a601          	ld	a,#1
2964  0686 8d000000      	callf	f_FLASH_Unlock
2966                     ; 813 	FLASH_Unlock(FLASH_MEMTYPE_PROG);
2968  068a 4f            	clr	a
2969  068b 8d000000      	callf	f_FLASH_Unlock
2971                     ; 816 	pFlash = (@far u8 *) temp;
2973  068f 7b09          	ld	a,(OFST+5,sp)
2974  0691 6b01          	ld	(OFST-3,sp),a
2975  0693 7b0a          	ld	a,(OFST+6,sp)
2976  0695 6b02          	ld	(OFST-2,sp),a
2977  0697 7b0b          	ld	a,(OFST+7,sp)
2978  0699 6b03          	ld	(OFST-1,sp),a
2979                     ; 817 	for(cnt = 0 ; cnt < 10; cnt++)
2981  069b 0f04          	clr	(OFST+0,sp)
2982  069d               L3121:
2983                     ; 819 		FLASH_ProgramByte(temp, value);
2985  069d 7b0c          	ld	a,(OFST+8,sp)
2986  069f 88            	push	a
2987  06a0 1e0b          	ldw	x,(OFST+7,sp)
2988  06a2 89            	pushw	x
2989  06a3 1e0b          	ldw	x,(OFST+7,sp)
2990  06a5 89            	pushw	x
2991  06a6 8d000000      	callf	f_FLASH_ProgramByte
2993  06aa 5b05          	addw	sp,#5
2994                     ; 820 		if(*pFlash == value) break;
2996  06ac 7b01          	ld	a,(OFST-3,sp)
2997  06ae b700          	ld	c_x,a
2998  06b0 1e02          	ldw	x,(OFST-2,sp)
2999  06b2 bf01          	ldw	c_x+1,x
3000  06b4 92bc0000      	ldf	a,[c_x.e]
3001  06b8 110c          	cp	a,(OFST+8,sp)
3002  06ba 2708          	jreq	L7121
3005                     ; 817 	for(cnt = 0 ; cnt < 10; cnt++)
3007  06bc 0c04          	inc	(OFST+0,sp)
3010  06be 7b04          	ld	a,(OFST+0,sp)
3011  06c0 a10a          	cp	a,#10
3012  06c2 25d9          	jrult	L3121
3013  06c4               L7121:
3014                     ; 823     if(*pFlash == value) return 0;
3016  06c4 7b01          	ld	a,(OFST-3,sp)
3017  06c6 b700          	ld	c_x,a
3018  06c8 bf01          	ldw	c_x+1,x
3019  06ca 92bc0000      	ldf	a,[c_x.e]
3020  06ce 110c          	cp	a,(OFST+8,sp)
3021  06d0 2603          	jrne	L3221
3024  06d2 4f            	clr	a
3026  06d3 2002          	jra	L433
3027  06d5               L3221:
3028                     ; 824 	else return 1;
3030  06d5 a601          	ld	a,#1
3032  06d7               L433:
3034  06d7 5b04          	addw	sp,#4
3035  06d9 87            	retf	
3069                     ; 831 void assert_failed (u8 *file, u16 line)
3069                     ; 832 #else
3069                     ; 833 void assert_failed (void)
3069                     ; 834 #endif
3069                     ; 835 {
3070                     	switch	.text
3071  06da               f_assert_failed:
3075                     ; 838 }
3078  06da 87            	retf	
3262                     	xdef	_Hazzardtimecnt
3263                     	xdef	_keyinstatesleep
3264                     	switch	.bss
3265  0004               _IGNsleeptime:
3266  0004 0000          	ds.b	2
3267                     	xdef	_IGNsleeptime
3268                     	xdef	_insleepnetcnt
3269                     	xdef	f_main
3270  0006               _HALTUPSTATE:
3271  0006 00            	ds.b	1
3272                     	xdef	_HALTUPSTATE
3273                     	xdef	f_delay
3274  0007               _wakerkestate:
3275  0007 00            	ds.b	1
3276                     	xdef	_wakerkestate
3277                     	xref	_warmstate
3278  0008               _SWSZstate:
3279  0008 00            	ds.b	1
3280                     	xdef	_SWSZstate
3281  0009               _CLOCKtimeinit:
3282  0009 0000          	ds.b	2
3283                     	xdef	_CLOCKtimeinit
3284  000b               _RKEwakeTime:
3285  000b 00000000      	ds.b	4
3286                     	xdef	_RKEwakeTime
3287  000f               _RKEZBTime:
3288  000f 00            	ds.b	1
3289                     	xdef	_RKEZBTime
3290  0010               _wakelintime:
3291  0010 00000000      	ds.b	4
3292                     	xdef	_wakelintime
3293  0014               _RKEStandByWakeupcnt:
3294  0014 00            	ds.b	1
3295                     	xdef	_RKEStandByWakeupcnt
3296  0015               _RKEStandByWakeupState:
3297  0015 00            	ds.b	1
3298                     	xdef	_RKEStandByWakeupState
3299  0016               _WaveFilterCnt:
3300  0016 00            	ds.b	1
3301                     	xdef	_WaveFilterCnt
3302  0017               _RkeScanCnt:
3303  0017 0000          	ds.b	2
3304                     	xdef	_RkeScanCnt
3305                     	xdef	f_SystemClock
3306                     	xdef	f_InPutWake
3307                     	xdef	f_OneSecondWake
3308                     	xdef	f_WakeInit
3309                     	xdef	f_InOutputWake
3310                     	xref	f_System_Init
3311                     	xref	f_UDSDTC_main
3312                     	xref	f_Did2einit
3313                     	xref	f_Did2esave
3314                     	xref	f_UDSonCANDiag
3315                     	xref	f_UDSonCAN_netmain
3316                     	xref	f_DTCinit
3317                     	xref	f_Clear_WDT
3318                     	xref	f_JudgeDefrostDriver
3319                     	xref	f_ScanBatteryVoltage
3320                     	xref	f_ScanDefrostSwitch
3321                     	xref	f_WindowStop
3322                     	xref	f_WindowDriver
3323                     	xref	f_ScanWindowKeys
3324                     	xref	f_SAVE_SERIAL_NUMBER
3325                     	xref	f_ScanRkeKeys
3326                     	xref	_RKE_COMMAND_StandBy_state
3327                     	xref	_RX_SerialNum
3328                     	xref	f_ScanStandbyIgnSwitch
3329                     	xref	f_ScanH4021InData
3330                     	xref	f_JudgeHornDriver
3331                     	xref	f_ScanHornSwitch
3332                     	xref	f_ScanIgnSwitch
3333                     	xref	_HornDoorunclosetime
3334                     	xref	_IGNstate
3335                     	xref	f_BUSoff
3336                     	xref	_cansendstate
3337                     	xref	f_ClearDTC
3338                     	xref	f_CANenble
3339                     	xref	f_CANRX
3340                     	xref	f_CANSend
3341                     	xref	_DeceSettingValueL
3342                     	xref	_DeceSettingValueH
3343                     	xref	_BCMnumber
3344                     	xref	_ONESstate
3345                     	xref	_PassWord2
3346                     	xref	_PassWord1
3347                     	xref	_VehicleType
3348                     	xref	_CanSendData
3349                     	xref	f_buzzdrv2
3350                     	xref	f_ScanFortifySWState
3351                     	xref	f_ScanStandByDoorAjarSwitch
3352                     	xref	f_JudgeWarmTypeAndDriver
3353                     	xref	f_ScanSeatPositionState
3354                     	xref	f_ScanSeatbeltBuckleState
3355                     	xref	f_ScanAllDoorState
3356                     	xref	f_ScanSmallLampSwitch
3357                     	xref	f_ScanKeyInState
3358                     	xref	_KeyInState
3359                     	xref	f_MachineKeyDrv
3360                     	xref	f_TRUNKwarm
3361                     	xref	f_WarmStatusArithmetic
3362                     	xref	f_ScanStandByCrashInSignal
3363                     	xref	f_ScanTrunkSwitch
3364                     	xref	f_JudgeLockDriver
3365                     	xref	f_ScanCentralLockSwitch
3366                     	xref	f_ScanAllLockState
3367                     	xref	f_ScanCrashInSignal
3368                     	xref	_Lockonesstate
3369                     	xref	_DoorWarmState
3370                     	xref	_BCMtoGEM_AlarmStatus
3371                     	xref	f_Turnvcclow
3372                     	xref	f_SFLED
3373                     	xref	f_ScanTurnLampState
3374                     	xref	f_ScanStandByHazzardKeys
3375                     	xref	f_JudgeTurnLampDrv
3376                     	xref	f_ScanTurnLampKeys
3377                     	xref	f_FindCar
3378                     	xref	_HazzardState
3379                     	xref	_DoorState
3380                     	xref	_LockState
3381                     	xref	_LockDrvCmd
3382                     	xref	f_JudgeDomeLampDriver
3383                     	xref	_DomeLampDrv
3384                     	xref	_canrextime
3385                     	xref	f_ADC_Scan
3386                     	xdef	f_Weeprommain
3387                     	xdef	f_WakeUp
3388                     	xdef	f_ONSEINITEeprom
3389                     	xdef	f_delay_10us
3390                     	xdef	f_delay_ms
3391  0019               _wakestate:
3392  0019 0000          	ds.b	2
3393                     	xdef	_wakestate
3394  001b               _StandbyTime:
3395  001b 00000000      	ds.b	4
3396                     	xdef	_StandbyTime
3397  001f               _StandTIM3state:
3398  001f 00            	ds.b	1
3399                     	xdef	_StandTIM3state
3400  0020               _StandByState:
3401  0020 00            	ds.b	1
3402                     	xdef	_StandByState
3403  0021               _WakeUpTime:
3404  0021 0000          	ds.b	2
3405                     	xdef	_WakeUpTime
3406  0023               _WakeInTime:
3407  0023 0000          	ds.b	2
3408                     	xdef	_WakeInTime
3409  0025               _WakeState:
3410  0025 00            	ds.b	1
3411                     	xdef	_WakeState
3412  0026               _SysTimeFlag_8MS:
3413  0026 00            	ds.b	1
3414                     	xdef	_SysTimeFlag_8MS
3415  0027               _SysTimeFlag_2MS:
3416  0027 00            	ds.b	1
3417                     	xdef	_SysTimeFlag_2MS
3418                     	xref	f_CANHardwave_Init
3419                     	xref	f_NM_OSEK_Init
3420                     	xref	_gNMCANBatFlag
3421                     	xref	_gNetWorkStatus
3422                     	xref	_gNMHasSleeped
3423                     	xref	_gLocalWakeupFlag
3424                     	xref	f_WWDG_Refresh
3425                     	xref	f_WWDG_Init
3426                     	xref	f_FLASH_Unlock
3427                     	xref	f_FLASH_ProgramByte
3428                     	xref	f_FLASH_DeInit
3429                     	xref	f_AWU_Init
3430                     	xdef	f_assert_failed
3431                     	xref.b	c_x
3451                     	xref	d_lzmp
3452                     	xref	d_lgadc
3453                     	xref	d_rtol
3454                     	xref	d_uitolx
3455                     	end
