   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 814                     ; 60 void ScanH4021InData(void)
 814                     ; 61 {
 815                     	switch	.text
 816  0000               f_ScanH4021InData:
 818  0000 88            	push	a
 819       00000001      OFST:	set	1
 822                     ; 65     H4021Data1 = 0;    
 824  0001 725f0012      	clr	_H4021Data1
 825                     ; 66     H4021_PARALLEL_IN_MODE;
 827  0005 7217501e      	bres	20510,#3
 828                     ; 67     H4021_CLK_LOW;
 830  0009 7215501e      	bres	20510,#2
 831                     ; 69     for (i=7;i>=0;i--)
 833  000d a607          	ld	a,#7
 834  000f 6b01          	ld	(OFST+0,sp),a
 835  0011               L554:
 836                     ; 72 	 H4021_CLK_LOW;
 838  0011 7215501e      	bres	20510,#2
 839                     ; 73         delay_10us(2);
 841  0015 ae0002        	ldw	x,#2
 842  0018 8d000000      	callf	f_delay_10us
 844                     ; 74         if (H4021_DATA_IN1)
 846  001c 7209501f17    	btjf	20511,#4,L364
 847                     ; 76             _bset(H4021Data1,i);
 849  0021 7b01          	ld	a,(OFST+0,sp)
 850  0023 5f            	clrw	x
 851  0024 4d            	tnz	a
 852  0025 2a01          	jrpl	L01
 853  0027 53            	cplw	x
 854  0028               L01:
 855  0028 97            	ld	xl,a
 856  0029 a601          	ld	a,#1
 857  002b 5d            	tnzw	x
 858  002c 2704          	jreq	L21
 859  002e               L41:
 860  002e 48            	sll	a
 861  002f 5a            	decw	x
 862  0030 26fc          	jrne	L41
 863  0032               L21:
 864  0032 ca0012        	or	a,_H4021Data1
 865  0035 c70012        	ld	_H4021Data1,a
 866  0038               L364:
 867                     ; 78         H4021_CLK_HIGH;
 869  0038 7214501e      	bset	20510,#2
 870                     ; 79         delay_10us(2);
 872  003c ae0002        	ldw	x,#2
 873  003f 8d000000      	callf	f_delay_10us
 875                     ; 69     for (i=7;i>=0;i--)
 877  0043 0a01          	dec	(OFST+0,sp)
 880  0045 2aca          	jrpl	L554
 881                     ; 81     H4021_SERIAL_IN_MODE;
 883  0047 7216501e      	bset	20510,#3
 884                     ; 82     H4021_CLK_LOW;
 886  004b 7215501e      	bres	20510,#2
 887                     ; 83 }
 890  004f 84            	pop	a
 891  0050 87            	retf	
 893                     	switch	.bss
 894  0000               L764_ignoffCnt:
 895  0000 0000          	ds.b	2
 896  0002               L564_ignonCnt:
 897  0002 0000          	ds.b	2
 898  0004               L174_IgnOnOffCnt:
 899  0004 00            	ds.b	1
 900  0005               L374_IgnTime6S:
 901  0005 0000          	ds.b	2
 960                     .const:	section	.text
 961  0000               L22:
 962  0000 0000006b      	dc.l	107
 963                     ; 97 void ScanIgnSwitch(void)
 963                     ; 98 {
 964                     	switch	.text
 965  0051               f_ScanIgnSwitch:
 969                     ; 103 	if (IGN_ON_STATE_IN)
 971  0051 5f            	clrw	x
 972  0052 7209500648    	btjf	20486,#4,L715
 973                     ; 105 		ignoffCnt = 0;
 975  0057 cf0000        	ldw	L764_ignoffCnt,x
 976                     ; 106 		if (ignonCnt < KEY_FILTER_CNT)
 978  005a ce0002        	ldw	x,L564_ignonCnt
 979  005d a30005        	cpw	x,#5
 980  0060 2406          	jruge	L125
 981                     ; 108 			ignonCnt++;
 983  0062 5c            	incw	x
 984  0063 cf0002        	ldw	L564_ignonCnt,x
 986  0066 207a          	jra	L535
 987  0068               L125:
 988                     ; 110 		else if (ignonCnt == KEY_FILTER_CNT)
 990  0068 a30005        	cpw	x,#5
 991  006b 2675          	jrne	L535
 992                     ; 112 			ignonCnt++;
 994  006d 5c            	incw	x
 995  006e cf0002        	ldw	L564_ignonCnt,x
 996                     ; 114 			IGNstate = ON;
 998  0071 35550013      	mov	_IGNstate,#85
 999                     ; 117 			if (IgnOnOffCnt != 0)
1001  0075 c60004        	ld	a,L174_IgnOnOffCnt
1002  0078 2706          	jreq	L725
1003                     ; 119 				IgnOnOffCnt++;				
1005  007a 725c0004      	inc	L174_IgnOnOffCnt
1007  007e 200a          	jra	L135
1008  0080               L725:
1009                     ; 123 				IgnOnOffCnt = 1;
1011  0080 35010004      	mov	L174_IgnOnOffCnt,#1
1012                     ; 124 				IgnTime6S = 750;//set 6s
1014  0084 ae02ee        	ldw	x,#750
1015  0087 cf0005        	ldw	L374_IgnTime6S,x
1016  008a               L135:
1017                     ; 127 			IgnOffCtrl |= (EnableWinKey + EnableCentralKey);
1019  008a c60000        	ld	a,_IgnOffCtrl
1020  008d aa03          	or	a,#3
1021  008f c70000        	ld	_IgnOffCtrl,a
1022                     ; 129        		if (RKE_AutoLockFlag == RKE_AUTO_LOCK_YES)
1024  0092 c60000        	ld	a,_RKE_AutoLockFlag
1025  0095 a155          	cp	a,#85
1026  0097 2649          	jrne	L535
1027                     ; 131        			RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;
1029  0099 725f0000      	clr	_RKE_AutoLockFlag
1030  009d 2043          	jra	L535
1031  009f               L715:
1032                     ; 137 		ignonCnt = 0;
1034  009f cf0002        	ldw	L564_ignonCnt,x
1035                     ; 138 		if (ignoffCnt < KEY_FILTER_CNT)
1037  00a2 ce0000        	ldw	x,L764_ignoffCnt
1038  00a5 a30005        	cpw	x,#5
1039                     ; 140 			ignoffCnt++;
1041  00a8 251a          	jrult	LC001
1042                     ; 142 		else if (ignoffCnt == KEY_FILTER_CNT)
1044  00aa 2613          	jrne	L345
1045                     ; 144 			ignoffCnt++;
1047  00ac 5c            	incw	x
1048  00ad cf0000        	ldw	L764_ignoffCnt,x
1049                     ; 146 			IGNstate = OFF;
1051  00b0 725f0013      	clr	_IGNstate
1052                     ; 148 			if (IgnTime6S != 0)
1054  00b4 ce0005        	ldw	x,L374_IgnTime6S
1055  00b7 2729          	jreq	L535
1056                     ; 150 				IgnOnOffCnt++;				
1058  00b9 725c0004      	inc	L174_IgnOnOffCnt
1059  00bd 2023          	jra	L535
1060  00bf               L345:
1061                     ; 153 		else if (ignoffCnt < WIN_KEYS_DISABLE_TIME)
1063  00bf a31d4c        	cpw	x,#7500
1064  00c2 2406          	jruge	L155
1065                     ; 155 			ignoffCnt++;
1067  00c4               LC001:
1069  00c4 5c            	incw	x
1070  00c5 cf0000        	ldw	L764_ignoffCnt,x
1072  00c8 2018          	jra	L535
1073  00ca               L155:
1074                     ; 157 		else if (ignoffCnt == WIN_KEYS_DISABLE_TIME)
1076  00ca a31d4c        	cpw	x,#7500
1077  00cd 2613          	jrne	L535
1078                     ; 159 		       ignoffCnt++;
1080  00cf 5c            	incw	x
1081  00d0 cf0000        	ldw	L764_ignoffCnt,x
1082                     ; 160 			IgnOffCtrl &= (~(EnableWinKey | EnableCentralKey));
1084  00d3 c60000        	ld	a,_IgnOffCtrl
1085  00d6 a4fc          	and	a,#252
1086  00d8 c70000        	ld	_IgnOffCtrl,a
1087                     ; 161 			ImmoOnTime = 0;
1089  00db 5f            	clrw	x
1090  00dc cf0002        	ldw	_ImmoOnTime+2,x
1091  00df cf0000        	ldw	_ImmoOnTime,x
1092  00e2               L535:
1093                     ; 166 	if (EnalbeLearnRkeTime20s != 0)
1095  00e2 ce0010        	ldw	x,_EnalbeLearnRkeTime20s
1096  00e5 2704          	jreq	L165
1097                     ; 168 		EnalbeLearnRkeTime20s--;
1099  00e7 5a            	decw	x
1100  00e8 cf0010        	ldw	_EnalbeLearnRkeTime20s,x
1102  00eb               L165:
1103                     ; 175 	if(RX_SerialNum == 0x6b)
1105  00eb ae0000        	ldw	x,#_RX_SerialNum
1106  00ee 8d000000      	callf	d_ltor
1108  00f2 ae0000        	ldw	x,#L22
1109  00f5 8d000000      	callf	d_lcmp
1111  00f9 2618          	jrne	L365
1112                     ; 177                if(LockState == 0x55) LockDrvCmd =0x80;
1114  00fb c60000        	ld	a,_LockState
1115  00fe a155          	cp	a,#85
1116  0100 2606          	jrne	L565
1119  0102 35800000      	mov	_LockDrvCmd,#128
1121  0106 2004          	jra	L765
1122  0108               L565:
1123                     ; 178 		 else LockDrvCmd =0x20;
1125  0108 35200000      	mov	_LockDrvCmd,#32
1126  010c               L765:
1127                     ; 179 		 RX_SerialNum = 0;
1129  010c 5f            	clrw	x
1130  010d cf0002        	ldw	_RX_SerialNum+2,x
1131  0110 cf0000        	ldw	_RX_SerialNum,x
1132  0113               L365:
1133                     ; 181 }
1136  0113 87            	retf	
1160                     ; 193 void ScanStandbyIgnSwitch(void)
1160                     ; 194 {
1161                     	switch	.text
1162  0114               f_ScanStandbyIgnSwitch:
1166                     ; 196 	if( (IGN_ON_STATE_IN)||(KEY_IN_STATE_IN))//||(R_Door_state_IN)||(!TRUNK_AJAR)||(!Alarm_IN))//||(!TRUNK_AJAR)) //Alarm_IN == frdoor;
1168  0114 7208500605    	btjt	20486,#4,L506
1170  0119 7203500b04    	btjf	20491,#1,L306
1171  011e               L506:
1172                     ; 198                  StandByState = Pressed;
1174  011e 35550000      	mov	_StandByState,#85
1175  0122               L306:
1176                     ; 202 }
1179  0122 87            	retf	
1181                     	switch	.bss
1182  0007               L116_offHornCnt:
1183  0007 00            	ds.b	1
1184  0008               L706_onHornCnt:
1185  0008 00            	ds.b	1
1223                     ; 215 void ScanHornSwitch(void)
1223                     ; 216 {
1224                     	switch	.text
1225  0123               f_ScanHornSwitch:
1229                     ; 220 	if (!HORN_SW)
1231  0123 7208500b1d    	btjt	20491,#4,L136
1232                     ; 222    	       offHornCnt = 0;
1234  0128 725f0007      	clr	L116_offHornCnt
1235                     ; 224 		if (onHornCnt < 4)
1237  012c c60008        	ld	a,L706_onHornCnt
1238  012f a104          	cp	a,#4
1239  0131 2405          	jruge	L336
1240                     ; 226 			onHornCnt++;			
1242  0133 725c0008      	inc	L706_onHornCnt
1245  0137 87            	retf	
1246  0138               L336:
1247                     ; 228 		else if (onHornCnt == 4)
1249  0138 a104          	cp	a,#4
1250  013a 2625          	jrne	L146
1251                     ; 230 			onHornCnt++;
1253  013c 725c0008      	inc	L706_onHornCnt
1254                     ; 231 		       HornSwitchState = Pressed;
1256  0140 3555000c      	mov	_HornSwitchState,#85
1258  0144 87            	retf	
1259  0145               L136:
1260                     ; 236 		onHornCnt = 0;
1262  0145 725f0008      	clr	L706_onHornCnt
1263                     ; 238 		if (offHornCnt < 4)
1265  0149 c60007        	ld	a,L116_offHornCnt
1266  014c a104          	cp	a,#4
1267  014e 2405          	jruge	L346
1268                     ; 240 			offHornCnt++;			
1270  0150 725c0007      	inc	L116_offHornCnt
1273  0154 87            	retf	
1274  0155               L346:
1275                     ; 242 		else if (offHornCnt == 4)
1277  0155 a104          	cp	a,#4
1278  0157 2608          	jrne	L146
1279                     ; 244 			offHornCnt++;
1281  0159 725c0007      	inc	L116_offHornCnt
1282                     ; 245 		       HornSwitchState = Unpressed;
1284  015d 725f000c      	clr	_HornSwitchState
1285  0161               L146:
1286                     ; 248 }
1289  0161 87            	retf	
1291                     	switch	.bss
1292  0009               L356_HornPtime:
1293  0009 00            	ds.b	1
1294  000a               L156_Carhorntimecnt:
1295  000a 0000          	ds.b	2
1338                     ; 266 void JudgeHornDriver(void)
1338                     ; 267 {
1339                     	switch	.text
1340  0162               f_JudgeHornDriver:
1344                     ; 275     if(HornDoorunclosetime)
1346  0162 ce000d        	ldw	x,_HornDoorunclosetime
1347  0165 2705          	jreq	L376
1348                     ; 277         HORN_ON;return;
1350  0167 7210500f      	bset	20495,#0
1354  016b 87            	retf	
1355  016c               L376:
1356                     ; 280     if((DoorState == AllDoorIsClosed)||(IGNstate == ON)) {HornDoorunclosetime = 0;ClearBuzzdrv(Buzzlockdoorunclose);}
1358  016c c60000        	ld	a,_DoorState
1359  016f 2707          	jreq	L776
1361  0171 c60013        	ld	a,_IGNstate
1362  0174 a155          	cp	a,#85
1363  0176 260a          	jrne	L576
1364  0178               L776:
1367  0178 5f            	clrw	x
1368  0179 cf000d        	ldw	_HornDoorunclosetime,x
1371  017c a615          	ld	a,#21
1372  017e 8d000000      	callf	f_ClearBuzzdrv
1374  0182               L576:
1375                     ; 285     if (HornSwitchState == Pressed)  
1377  0182 c6000c        	ld	a,_HornSwitchState
1378  0185 a155          	cp	a,#85
1379  0187 2606          	jrne	L107
1380                     ; 287         HORN_ON;
1382  0189 7210500f      	bset	20495,#0
1384  018d 2013          	jra	L307
1385  018f               L107:
1386                     ; 289     else if (HornSwitchState == Unpressed) 
1388  018f c6000c        	ld	a,_HornSwitchState
1389  0192 2606          	jrne	L507
1390                     ; 291         HORN_OFF;
1392  0194 7211500f      	bres	20495,#0
1394  0198 2008          	jra	L307
1395  019a               L507:
1396                     ; 295         HORN_OFF;
1398  019a 7211500f      	bres	20495,#0
1399                     ; 296         HornSwitchState = Unpressed;
1401  019e 725f000c      	clr	_HornSwitchState
1402  01a2               L307:
1403                     ; 299     if(CarHornstate ==1 )   // 2hz
1405  01a2 c6000f        	ld	a,_CarHornstate
1406  01a5 4a            	dec	a
1407  01a6 262a          	jrne	L117
1408                     ; 301         if(Carhorntimecnt < 3500)
1410  01a8 ce000a        	ldw	x,L156_Carhorntimecnt
1411  01ab a30dac        	cpw	x,#3500
1412  01ae 241d          	jruge	L317
1413                     ; 303             Carhorntimecnt++;
1415  01b0 5c            	incw	x
1416  01b1 cf000a        	ldw	L156_Carhorntimecnt,x
1417                     ; 304             HornPtime++;
1419  01b4 725c0009      	inc	L356_HornPtime
1420                     ; 305             if ( HornPtime < 31 )  //喇叭改为1s周期报警
1422  01b8 c60009        	ld	a,L356_HornPtime
1423  01bb a11f          	cp	a,#31
1424  01bd 2405          	jruge	L517
1425                     ; 307                 HORN_ON;
1427  01bf 7210500f      	bset	20495,#0
1430  01c3 87            	retf	
1431  01c4               L517:
1432                     ; 309             else if ( HornPtime  < 63 )
1434  01c4 a13f          	cp	a,#63
1435                     ; 311                 HORN_OFF;
1437  01c6 2505          	jrult	L317
1438                     ; 315                 HornPtime = 0 ;
1440  01c8 725f0009      	clr	L356_HornPtime
1442  01cc 87            	retf	
1443  01cd               L317:
1444                     ; 320             HORN_OFF;
1447  01cd 7211500f      	bres	20495,#0
1449  01d1 87            	retf	
1450  01d2               L117:
1451                     ; 325         Carhorntimecnt = 0;     
1453  01d2 5f            	clrw	x
1454  01d3 cf000a        	ldw	L156_Carhorntimecnt,x
1455                     ; 327 }
1458  01d6 87            	retf	
1516                     	switch	.bss
1517  000c               _HornSwitchState:
1518  000c 00            	ds.b	1
1519                     	xdef	_HornSwitchState
1520                     	xref	_LockState
1521                     	xref	_LockDrvCmd
1522                     	xref	f_ClearBuzzdrv
1523                     	xref	_DoorState
1524                     	xref	_IgnOffCtrl
1525                     	xref	_ImmoOnTime
1526                     	xref	_RKE_AutoLockFlag
1527                     	xref	_RX_SerialNum
1528                     	xdef	f_ScanStandbyIgnSwitch
1529                     	xdef	f_ScanH4021InData
1530                     	xdef	f_JudgeHornDriver
1531                     	xdef	f_ScanHornSwitch
1532                     	xdef	f_ScanIgnSwitch
1533  000d               _HornDoorunclosetime:
1534  000d 0000          	ds.b	2
1535                     	xdef	_HornDoorunclosetime
1536  000f               _CarHornstate:
1537  000f 00            	ds.b	1
1538                     	xdef	_CarHornstate
1539  0010               _EnalbeLearnRkeTime20s:
1540  0010 0000          	ds.b	2
1541                     	xdef	_EnalbeLearnRkeTime20s
1542  0012               _H4021Data1:
1543  0012 00            	ds.b	1
1544                     	xdef	_H4021Data1
1545  0013               _IGNstate:
1546  0013 00            	ds.b	1
1547                     	xdef	_IGNstate
1548                     	xref	f_delay_10us
1549                     	xref	_StandByState
1569                     	xref	d_lcmp
1570                     	xref	d_ltor
1571                     	end
