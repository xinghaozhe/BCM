   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 780                     	switch	.bss
 781  0000               L534_hazzardNoCnt:
 782  0000 00            	ds.b	1
 783  0001               L334_hazzardYesCnt:
 784  0001 00            	ds.b	1
 835                     ; 69 void ScanHazzardKeys(void)
 835                     ; 70 {
 836                     	switch	.text
 837  0000               f_ScanHazzardKeys:
 841                     ; 73 	if(TurnLamp_CrashKeepTime != 0) return ;
 843  0000 ce0068        	ldw	x,_TurnLamp_CrashKeepTime
 844  0003 2701          	jreq	L364
 848  0005 87            	retf	
 849  0006               L364:
 850                     ; 75 	if(!HAZARD_SW)
 852  0006 720c501545    	btjt	20501,#6,L564
 853                     ; 77             hazzardNoCnt = 0;      
 855  000b 725f0000      	clr	L534_hazzardNoCnt
 856                     ; 78             if (hazzardYesCnt < KEY_FILTER_CNT)
 858  000f c60001        	ld	a,L334_hazzardYesCnt
 859  0012 a105          	cp	a,#5
 860  0014 2405          	jruge	L764
 861                     ; 80                  hazzardYesCnt++;
 863  0016 725c0001      	inc	L334_hazzardYesCnt
 866  001a 87            	retf	
 867  001b               L764:
 868                     ; 82             else if (hazzardYesCnt == KEY_FILTER_CNT)
 870  001b a105          	cp	a,#5
 871  001d 2649          	jrne	L705
 872                     ; 84                  hazzardYesCnt++;
 874  001f 725c0001      	inc	L334_hazzardYesCnt
 875                     ; 85 				 BrakeSpeedHazards_state=0;
 877  0023 725f0060      	clr	_BrakeSpeedHazards_state
 878                     ; 86                  if(Crash_state_Y == 1)
 880  0027 c60063        	ld	a,_Crash_state_Y
 881  002a 4a            	dec	a
 882  002b 2604          	jrne	L574
 883                     ; 88                       Crash_state_Y = 0 ;
 885  002d c70063        	ld	_Crash_state_Y,a
 888  0030 87            	retf	
 889  0031               L574:
 890                     ; 92                       if (HazzardState == Pressed)
 892  0031 c60064        	ld	a,_HazzardState
 893  0034 a155          	cp	a,#85
 894  0036 2605          	jrne	L105
 895                     ; 94                            HazzardState = Unpressed;
 897  0038 725f0064      	clr	_HazzardState
 900  003c 87            	retf	
 901  003d               L105:
 902                     ; 98                            HazzardState = Pressed;
 904  003d 35550064      	mov	_HazzardState,#85
 905                     ; 99 				if(FindCarFlag = TRUE)  //20120308
 907  0041 35010000      	mov	_FindCarFlag,#1
 908  0045 2704          	jreq	L505
 909                     ; 101 					FindCarFlag = FALSE;
 911  0047 725f0000      	clr	_FindCarFlag
 912                     ; 103 					TurnFlashCnt = 0;
 914  004b               L505:
 915                     ; 105 			      TurnFlashCnt = 0;//ADD close findcar 20120308
 917  004b 5f            	clrw	x
 918  004c cf006d        	ldw	_TurnFlashCnt,x
 920  004f 87            	retf	
 921  0050               L564:
 922                     ; 112     	if (hazzardNoCnt < KEY_FILTER_CNT)
 924  0050 c60000        	ld	a,L534_hazzardNoCnt
 925  0053 a105          	cp	a,#5
 926  0055 2405          	jruge	L115
 927                     ; 114     		hazzardNoCnt++;
 929  0057 725c0000      	inc	L534_hazzardNoCnt
 932  005b 87            	retf	
 933  005c               L115:
 934                     ; 116     	else if (hazzardNoCnt == KEY_FILTER_CNT)
 936  005c a105          	cp	a,#5
 937  005e 2608          	jrne	L705
 938                     ; 118     		hazzardNoCnt++;
 940  0060 725c0000      	inc	L534_hazzardNoCnt
 941                     ; 119     		hazzardYesCnt = 0;    	
 943  0064 725f0001      	clr	L334_hazzardYesCnt
 944  0068               L705:
 945                     ; 122 }
 948  0068 87            	retf	
 972                     ; 133 void ScanStandByHazzardKeys(void) 
 972                     ; 134 {
 973                     	switch	.text
 974  0069               f_ScanStandByHazzardKeys:
 978                     ; 136 	 if(!HAZARD_SW) 
 980  0069 720c501504    	btjt	20501,#6,L135
 981                     ; 139         	StandByState = Pressed;    //此状态退出低功耗后应请除
 983  006e 35550000      	mov	_StandByState,#85
 984  0072               L135:
 985                     ; 142 }
 988  0072 87            	retf	
 990                     	switch	.bss
 991  0002               L355_rTurnLamp_KeepTime:
 992  0002 00000000      	ds.b	4
 993  0006               L155_lTurnLamp_KeepTime:
 994  0006 00000000      	ds.b	4
 995  000a               L735_rTurnYesCnt:
 996  000a 00            	ds.b	1
 997  000b               L335_lTurnYesCnt:
 998  000b 00            	ds.b	1
 999  000c               L145_rTurnNoCnt:
1000  000c 00            	ds.b	1
1001  000d               L535_lTurnNoCnt:
1002  000d 00            	ds.b	1
1003  000e               L745_HAZZARD_oldstate:
1004  000e 00            	ds.b	1
1005  000f               L545_L_oldstate:
1006  000f 00            	ds.b	1
1007  0010               L345_R_oldstate:
1008  0010 00            	ds.b	1
1009  0011               L555_Speedwarmstate:
1010  0011 00            	ds.b	1
1131                     .const:	section	.text
1132  0000               L41:
1133  0000 0000927d      	dc.l	37501
1134                     ; 155 void ScanTurnLampKeys(void)
1134                     ; 156 {         
1135                     	switch	.text
1136  0073               f_ScanTurnLampKeys:
1140                     ; 166       ScanHazzardKeys();
1142  0073 8d000000      	callf	f_ScanHazzardKeys
1144                     ; 169       if(!TURN_RIGHT_SW) 
1146  0077 720250063e    	btjt	20486,#1,L736
1147                     ; 171            rTurnNoCnt = 0;
1149  007c 725f000c      	clr	L145_rTurnNoCnt
1150                     ; 172            if(rTurnYesCnt < 100 )
1152  0080 c6000a        	ld	a,L735_rTurnYesCnt
1153  0083 a164          	cp	a,#100
1154  0085 2407          	jruge	L146
1155                     ; 174                 rTurnYesCnt++;
1157  0087 725c000a      	inc	L735_rTurnYesCnt
1158  008b c6000a        	ld	a,L735_rTurnYesCnt
1159  008e               L146:
1160                     ; 176            if((rTurnYesCnt >= 5) && (rTurnYesCnt <=12) && (Turn_R_CH_State == Unpressed) && (Turn_L_CH_State == Unpressed))
1162  008e a105          	cp	a,#5
1163  0090 2516          	jrult	L346
1165  0092 a10d          	cp	a,#13
1166  0094 2412          	jruge	L346
1168  0096 725d0059      	tnz	_Turn_R_CH_State
1169  009a 260c          	jrne	L346
1171  009c 725d0058      	tnz	_Turn_L_CH_State
1172  00a0 2606          	jrne	L346
1173                     ; 178                 Turn_R_State = Pressed; 
1175  00a2 35550067      	mov	_Turn_R_State,#85
1177  00a6 206f          	jra	L156
1178  00a8               L346:
1179                     ; 184            else if(rTurnYesCnt > 87)
1181  00a8 a158          	cp	a,#88
1182  00aa 256b          	jrult	L156
1183                     ; 186                 Turn_R_State = Pressed;
1185  00ac 35550067      	mov	_Turn_R_State,#85
1186                     ; 187                 Turn_L_CH_State = Unpressed;
1188  00b0 725f0058      	clr	_Turn_L_CH_State
1189                     ; 188                 Turn_R_CH_State = Unpressed;  
1191  00b4 725f0059      	clr	_Turn_R_CH_State
1192  00b8 205d          	jra	L156
1193  00ba               L736:
1194                     ; 193            if((rTurnYesCnt > 12) && (rTurnYesCnt <= 87 ))
1196  00ba c6000a        	ld	a,L735_rTurnYesCnt
1197  00bd a10d          	cp	a,#13
1198  00bf 2529          	jrult	L356
1200  00c1 a158          	cp	a,#88
1201  00c3 2425          	jruge	L356
1202                     ; 195                 Turn_R_State = Unpressed;
1204  00c5 725f0067      	clr	_Turn_R_State
1205                     ; 196                 if(TLSwitchRoadwayFlashCnt >= 3)
1207  00c9 c6005c        	ld	a,_TLSwitchRoadwayFlashCnt
1208  00cc a103          	cp	a,#3
1209  00ce 2511          	jrult	L556
1210                     ; 198 	                if(IGNstate == ON)TLSwitchRoadwayFlashCnt = 0;
1212  00d0 c60000        	ld	a,_IGNstate
1213  00d3 a155          	cp	a,#85
1214  00d5 2604          	jrne	L756
1217  00d7 725f005c      	clr	_TLSwitchRoadwayFlashCnt
1218  00db               L756:
1219                     ; 199 	                Turn_R_CH_State = Pressed;
1221  00db 35550059      	mov	_Turn_R_CH_State,#85
1222                     ; 200 	                Turn_L_CH_State = Unpressed;
1224  00df 2015          	jpf	LC001
1225  00e1               L556:
1226                     ; 202                 else if(Turn_R_CH_State == Pressed)
1228  00e1 c60059        	ld	a,_Turn_R_CH_State
1229  00e4 a155          	cp	a,#85
1230  00e6 2612          	jrne	L566
1231                     ; 204                      Turn_L_CH_State = Unpressed;
1232  00e8 200c          	jpf	LC001
1233  00ea               L356:
1234                     ; 208            else if(rTurnYesCnt > 87)
1236  00ea a158          	cp	a,#88
1237  00ec 250c          	jrult	L566
1238                     ; 211                 TLSwitchRoadwayFlashCnt = 3;
1240  00ee 3503005c      	mov	_TLSwitchRoadwayFlashCnt,#3
1241                     ; 212                 Turn_R_CH_State = Unpressed;      //转向优先 取消变道
1243  00f2 725f0059      	clr	_Turn_R_CH_State
1244                     ; 213                 Turn_L_CH_State = Unpressed;
1246  00f6               LC001:
1249  00f6 725f0058      	clr	_Turn_L_CH_State
1250  00fa               L566:
1251                     ; 216            rTurnYesCnt= 0;
1253  00fa 725f000a      	clr	L735_rTurnYesCnt
1254                     ; 217            if (rTurnNoCnt < KEY_FILTER_CNT)
1256  00fe c6000c        	ld	a,L145_rTurnNoCnt
1257  0101 a105          	cp	a,#5
1258  0103 2406          	jruge	L176
1259                     ; 219                 rTurnNoCnt++;
1261  0105 725c000c      	inc	L145_rTurnNoCnt
1263  0109 200c          	jra	L156
1264  010b               L176:
1265                     ; 221            else if (rTurnNoCnt == KEY_FILTER_CNT)
1267  010b a105          	cp	a,#5
1268  010d 2608          	jrne	L156
1269                     ; 223                 rTurnNoCnt++;
1271  010f 725c000c      	inc	L145_rTurnNoCnt
1272                     ; 224                 Turn_R_State = Unpressed;   
1274  0113 725f0067      	clr	_Turn_R_State
1275  0117               L156:
1276                     ; 228       if(!TURN_LEFT_SW) 
1278  0117 720450063e    	btjt	20486,#2,L776
1279                     ; 230             lTurnNoCnt = 0;      
1281  011c 725f000d      	clr	L535_lTurnNoCnt
1282                     ; 231             if ( lTurnYesCnt < 100)
1284  0120 c6000b        	ld	a,L335_lTurnYesCnt
1285  0123 a164          	cp	a,#100
1286  0125 2407          	jruge	L107
1287                     ; 233                  lTurnYesCnt++;
1289  0127 725c000b      	inc	L335_lTurnYesCnt
1290  012b c6000b        	ld	a,L335_lTurnYesCnt
1291  012e               L107:
1292                     ; 235             if((lTurnYesCnt >= 5)&&(lTurnYesCnt <=12) && (Turn_R_CH_State == Unpressed) && (Turn_L_CH_State == Unpressed))
1294  012e a105          	cp	a,#5
1295  0130 2516          	jrult	L307
1297  0132 a10d          	cp	a,#13
1298  0134 2412          	jruge	L307
1300  0136 725d0059      	tnz	_Turn_R_CH_State
1301  013a 260c          	jrne	L307
1303  013c 725d0058      	tnz	_Turn_L_CH_State
1304  0140 2606          	jrne	L307
1305                     ; 237                  Turn_L_State = Pressed; 
1307  0142 35550066      	mov	_Turn_L_State,#85
1309  0146 206f          	jra	L117
1310  0148               L307:
1311                     ; 243             else if( lTurnYesCnt > 87)
1313  0148 a158          	cp	a,#88
1314  014a 256b          	jrult	L117
1315                     ; 245                   Turn_L_State = Pressed;
1317  014c 35550066      	mov	_Turn_L_State,#85
1318                     ; 246                   Turn_L_CH_State = Unpressed;
1320  0150 725f0058      	clr	_Turn_L_CH_State
1321                     ; 247                   Turn_R_CH_State = Unpressed;
1323  0154 725f0059      	clr	_Turn_R_CH_State
1324  0158 205d          	jra	L117
1325  015a               L776:
1326                     ; 252           if((lTurnYesCnt > 12) && (lTurnYesCnt <= 87))
1328  015a c6000b        	ld	a,L335_lTurnYesCnt
1329  015d a10d          	cp	a,#13
1330  015f 2529          	jrult	L317
1332  0161 a158          	cp	a,#88
1333  0163 2425          	jruge	L317
1334                     ; 254                Turn_L_State = Unpressed;
1336  0165 725f0066      	clr	_Turn_L_State
1337                     ; 255                if( TLSwitchRoadwayFlashCnt >= 3 ) 
1339  0169 c6005c        	ld	a,_TLSwitchRoadwayFlashCnt
1340  016c a103          	cp	a,#3
1341  016e 2511          	jrult	L517
1342                     ; 257                     Turn_L_CH_State = Pressed; 
1344  0170 35550058      	mov	_Turn_L_CH_State,#85
1345                     ; 258                     if(IGNstate == ON)TLSwitchRoadwayFlashCnt = 0;
1347  0174 c60000        	ld	a,_IGNstate
1348  0177 a155          	cp	a,#85
1349  0179 261b          	jrne	LC002
1352  017b 725f005c      	clr	_TLSwitchRoadwayFlashCnt
1353                     ; 259                     Turn_R_CH_State = Unpressed;
1355  017f 2015          	jpf	LC002
1356  0181               L517:
1357                     ; 261                else if(Turn_L_CH_State == Pressed)
1359  0181 c60058        	ld	a,_Turn_L_CH_State
1360  0184 a155          	cp	a,#85
1361  0186 2612          	jrne	L527
1362                     ; 263                     Turn_R_CH_State =Unpressed;
1363  0188 200c          	jpf	LC002
1364  018a               L317:
1365                     ; 266           else if(lTurnYesCnt > 87) 
1367  018a a158          	cp	a,#88
1368  018c 250c          	jrult	L527
1369                     ; 269                TLSwitchRoadwayFlashCnt = 3;
1371  018e 3503005c      	mov	_TLSwitchRoadwayFlashCnt,#3
1372                     ; 270                Turn_L_CH_State = Unpressed;
1374  0192 725f0058      	clr	_Turn_L_CH_State
1375                     ; 271                Turn_R_CH_State = Unpressed;
1377  0196               LC002:
1380  0196 725f0059      	clr	_Turn_R_CH_State
1381  019a               L527:
1382                     ; 273           lTurnYesCnt= 0;
1384  019a 725f000b      	clr	L335_lTurnYesCnt
1385                     ; 274           if (lTurnNoCnt < KEY_FILTER_CNT)
1387  019e c6000d        	ld	a,L535_lTurnNoCnt
1388  01a1 a105          	cp	a,#5
1389  01a3 2406          	jruge	L137
1390                     ; 276                lTurnNoCnt++;
1392  01a5 725c000d      	inc	L535_lTurnNoCnt
1394  01a9 200c          	jra	L117
1395  01ab               L137:
1396                     ; 278           else if (lTurnNoCnt == KEY_FILTER_CNT)
1398  01ab a105          	cp	a,#5
1399  01ad 2608          	jrne	L117
1400                     ; 280                lTurnNoCnt++;
1402  01af 725c000d      	inc	L535_lTurnNoCnt
1403                     ; 281                Turn_L_State = Unpressed;   
1405  01b3 725f0066      	clr	_Turn_L_State
1406  01b7               L117:
1407                     ; 290     if(( IGNstate == ON )&&(Turn_R_CH_State== Pressed) && (TLSwitchRoadwayFlashCnt < 3)\
1407                     ; 291     	&& ( HazzardState == Unpressed) &&( Crash_state_Y != 1))
1409  01b7 c60000        	ld	a,_IGNstate
1410  01ba a155          	cp	a,#85
1411  01bc 261d          	jrne	L737
1413  01be c60059        	ld	a,_Turn_R_CH_State
1414  01c1 a155          	cp	a,#85
1415  01c3 2616          	jrne	L737
1417  01c5 c6005c        	ld	a,_TLSwitchRoadwayFlashCnt
1418  01c8 a103          	cp	a,#3
1419  01ca 240f          	jruge	L737
1421  01cc c60064        	ld	a,_HazzardState
1422  01cf 260a          	jrne	L737
1424  01d1 c60063        	ld	a,_Crash_state_Y
1425  01d4 4a            	dec	a
1426  01d5 2704          	jreq	L737
1427                     ; 293     	TurnState_Number = 3 ;                                                                     //右变道有效
1429  01d7 35030057      	mov	_TurnState_Number,#3
1430  01db               L737:
1431                     ; 296     if((TurnState_Number == 3)&&(TLSwitchRoadwayFlashCnt >= 3))    ///20091028更改/////////////////////////////////bug
1433  01db c60057        	ld	a,_TurnState_Number
1434  01de a103          	cp	a,#3
1435  01e0 260f          	jrne	L147
1437  01e2 c6005c        	ld	a,_TLSwitchRoadwayFlashCnt
1438  01e5 a103          	cp	a,#3
1439  01e7 2508          	jrult	L147
1440                     ; 298         Turn_R_CH_State = Unpressed;
1442  01e9 725f0059      	clr	_Turn_R_CH_State
1443                     ; 301            TurnState_Number = 0;
1445  01ed 725f0057      	clr	_TurnState_Number
1446  01f1               L147:
1447                     ; 306     if(( IGNstate == ON )&&(TLSwitchRoadwayFlashCnt < 3) &&(( HazzardState == Pressed)||(Crash_state_Y == 1)))
1449  01f1 c60000        	ld	a,_IGNstate
1450  01f4 a155          	cp	a,#85
1451  01f6 261c          	jrne	L347
1453  01f8 c6005c        	ld	a,_TLSwitchRoadwayFlashCnt
1454  01fb a103          	cp	a,#3
1455  01fd 2415          	jruge	L347
1457  01ff c60064        	ld	a,_HazzardState
1458  0202 a155          	cp	a,#85
1459  0204 2706          	jreq	L547
1461  0206 c60063        	ld	a,_Crash_state_Y
1462  0209 4a            	dec	a
1463  020a 2608          	jrne	L347
1464  020c               L547:
1465                     ; 308         Turn_R_CH_State = Unpressed;
1467  020c 725f0059      	clr	_Turn_R_CH_State
1468                     ; 309         TLSwitchRoadwayFlashCnt = 3;
1470  0210 3503005c      	mov	_TLSwitchRoadwayFlashCnt,#3
1471  0214               L347:
1472                     ; 313     if(( IGNstate == ON )&&(Turn_L_CH_State == Pressed)&& (TLSwitchRoadwayFlashCnt < 3)\
1472                     ; 314     	&& ( HazzardState == Unpressed) &&( Crash_state_Y != 1))
1474  0214 c60000        	ld	a,_IGNstate
1475  0217 a155          	cp	a,#85
1476  0219 261d          	jrne	L747
1478  021b c60058        	ld	a,_Turn_L_CH_State
1479  021e a155          	cp	a,#85
1480  0220 2616          	jrne	L747
1482  0222 c6005c        	ld	a,_TLSwitchRoadwayFlashCnt
1483  0225 a103          	cp	a,#3
1484  0227 240f          	jruge	L747
1486  0229 c60064        	ld	a,_HazzardState
1487  022c 260a          	jrne	L747
1489  022e c60063        	ld	a,_Crash_state_Y
1490  0231 4a            	dec	a
1491  0232 2704          	jreq	L747
1492                     ; 316     	TurnState_Number = 4 ;       //左变道有效
1494  0234 35040057      	mov	_TurnState_Number,#4
1495  0238               L747:
1496                     ; 320     if((TurnState_Number == 4)&&(TLSwitchRoadwayFlashCnt >= 3))
1498  0238 c60057        	ld	a,_TurnState_Number
1499  023b a104          	cp	a,#4
1500  023d 260f          	jrne	L157
1502  023f c6005c        	ld	a,_TLSwitchRoadwayFlashCnt
1503  0242 a103          	cp	a,#3
1504  0244 2508          	jrult	L157
1505                     ; 322         Turn_L_CH_State = Unpressed;
1507  0246 725f0058      	clr	_Turn_L_CH_State
1508                     ; 325 	        TurnState_Number = 0;
1510  024a 725f0057      	clr	_TurnState_Number
1511  024e               L157:
1512                     ; 330     if(( IGNstate == ON )&&(TLSwitchRoadwayFlashCnt < 3) &&(( HazzardState == Pressed)||(Crash_state_Y == 1)))
1514  024e c60000        	ld	a,_IGNstate
1515  0251 a155          	cp	a,#85
1516  0253 261c          	jrne	L357
1518  0255 c6005c        	ld	a,_TLSwitchRoadwayFlashCnt
1519  0258 a103          	cp	a,#3
1520  025a 2415          	jruge	L357
1522  025c c60064        	ld	a,_HazzardState
1523  025f a155          	cp	a,#85
1524  0261 2706          	jreq	L557
1526  0263 c60063        	ld	a,_Crash_state_Y
1527  0266 4a            	dec	a
1528  0267 2608          	jrne	L357
1529  0269               L557:
1530                     ; 332         Turn_L_CH_State = Unpressed;
1532  0269 725f0058      	clr	_Turn_L_CH_State
1533                     ; 333         TLSwitchRoadwayFlashCnt = 3;
1535  026d 3503005c      	mov	_TLSwitchRoadwayFlashCnt,#3
1536  0271               L357:
1537                     ; 336     if(( IGNstate == ON )&&(Turn_R_State == Pressed)&& (Crash_state_Y != 1))
1539  0271 c60000        	ld	a,_IGNstate
1540  0274 a155          	cp	a,#85
1541  0276 2622          	jrne	L757
1543  0278 c60067        	ld	a,_Turn_R_State
1544  027b a155          	cp	a,#85
1545  027d 261b          	jrne	L757
1547  027f c60063        	ld	a,_Crash_state_Y
1548  0282 4a            	dec	a
1549  0283 2715          	jreq	L757
1550                     ; 338          if((TurnState_Number == 3)||(TurnState_Number == 4))
1552  0285 c60057        	ld	a,_TurnState_Number
1553  0288 a103          	cp	a,#3
1554  028a 2704          	jreq	L367
1556  028c a104          	cp	a,#4
1557  028e 2604          	jrne	L167
1558  0290               L367:
1559                     ; 340              TurnLampOnCnt = 0 ;
1561  0290 725f005e      	clr	_TurnLampOnCnt
1562  0294               L167:
1563                     ; 342          TurnState_Number = 1 ;             //右转有效 碰撞信号有效右转向优先在后面单独付值
1565  0294 35010057      	mov	_TurnState_Number,#1
1567  0298 2020          	jra	L567
1568  029a               L757:
1569                     ; 344     else if((Turn_R_State == Unpressed)&&(TurnState_Number == 1) && (Crash_state_Y != 1))
1571  029a c60067        	ld	a,_Turn_R_State
1572  029d 261b          	jrne	L567
1574  029f c60057        	ld	a,_TurnState_Number
1575  02a2 4a            	dec	a
1576  02a3 2615          	jrne	L567
1578  02a5 c60063        	ld	a,_Crash_state_Y
1579  02a8 4a            	dec	a
1580  02a9 270f          	jreq	L567
1581                     ; 346         if((TurnState_Number != 3)||(TurnState_Number != 4))
1583  02ab c60057        	ld	a,_TurnState_Number
1584  02ae a103          	cp	a,#3
1585  02b0 2604          	jrne	L377
1587  02b2 a104          	cp	a,#4
1588  02b4 2704          	jreq	L567
1589  02b6               L377:
1590                     ; 348             TurnState_Number = 0;               //如右转向开关无效 清标志
1592  02b6 725f0057      	clr	_TurnState_Number
1593  02ba               L567:
1594                     ; 353     if(( IGNstate == ON )&&(Turn_L_State == Pressed)&& (Crash_state_Y != 1))
1596  02ba c60000        	ld	a,_IGNstate
1597  02bd a155          	cp	a,#85
1598  02bf 2622          	jrne	L577
1600  02c1 c60066        	ld	a,_Turn_L_State
1601  02c4 a155          	cp	a,#85
1602  02c6 261b          	jrne	L577
1604  02c8 c60063        	ld	a,_Crash_state_Y
1605  02cb 4a            	dec	a
1606  02cc 2715          	jreq	L577
1607                     ; 355          if((TurnState_Number == 3)||(TurnState_Number == 4))
1609  02ce c60057        	ld	a,_TurnState_Number
1610  02d1 a103          	cp	a,#3
1611  02d3 2704          	jreq	L1001
1613  02d5 a104          	cp	a,#4
1614  02d7 2604          	jrne	L777
1615  02d9               L1001:
1616                     ; 357              TurnLampOnCnt = 0 ;
1618  02d9 725f005e      	clr	_TurnLampOnCnt
1619  02dd               L777:
1620                     ; 359         TurnState_Number = 2 ;             //左转有效 碰撞信号有效左转向优先在后面单独付值
1622  02dd 35020057      	mov	_TurnState_Number,#2
1624  02e1 2021          	jra	L3001
1625  02e3               L577:
1626                     ; 361     else if((Turn_L_State == Unpressed)&&(TurnState_Number == 2)&& (Crash_state_Y != 1))
1628  02e3 c60066        	ld	a,_Turn_L_State
1629  02e6 261c          	jrne	L3001
1631  02e8 c60057        	ld	a,_TurnState_Number
1632  02eb a102          	cp	a,#2
1633  02ed 2615          	jrne	L3001
1635  02ef c60063        	ld	a,_Crash_state_Y
1636  02f2 4a            	dec	a
1637  02f3 270f          	jreq	L3001
1638                     ; 363         if((TurnState_Number != 3)||(TurnState_Number != 4))
1640  02f5 c60057        	ld	a,_TurnState_Number
1641  02f8 a103          	cp	a,#3
1642  02fa 2604          	jrne	L1101
1644  02fc a104          	cp	a,#4
1645  02fe 2704          	jreq	L3001
1646  0300               L1101:
1647                     ; 365             TurnState_Number = 0;               //如果左转向开关无效 清标志
1649  0300 725f0057      	clr	_TurnState_Number
1650  0304               L3001:
1651                     ; 370     if(( Turn_R_State == Pressed) && ( Turn_L_State == Pressed)) TurnState_Number = 0; //错误
1653  0304 c60067        	ld	a,_Turn_R_State
1654  0307 a155          	cp	a,#85
1655  0309 260b          	jrne	L3101
1657  030b c60066        	ld	a,_Turn_L_State
1658  030e a155          	cp	a,#85
1659  0310 2604          	jrne	L3101
1662  0312 725f0057      	clr	_TurnState_Number
1663  0316               L3101:
1664                     ; 373     if(( HazzardState == Pressed)&&(rTurnLamp_KeepTime == 0)&&(lTurnLamp_KeepTime == 0))  TurnState_Number = 5 ;                                     //报警有效
1666  0316 c60064        	ld	a,_HazzardState
1667  0319 a155          	cp	a,#85
1668  031b 2618          	jrne	L5101
1670  031d ae0002        	ldw	x,#L355_rTurnLamp_KeepTime
1671  0320 8d000000      	callf	d_lzmp
1673  0324 260f          	jrne	L5101
1675  0326 ae0006        	ldw	x,#L155_lTurnLamp_KeepTime
1676  0329 8d000000      	callf	d_lzmp
1678  032d 2606          	jrne	L5101
1681  032f 35050057      	mov	_TurnState_Number,#5
1683  0333 2010          	jra	L7101
1684  0335               L5101:
1685                     ; 374     else if((HazzardState == Unpressed)&&(TurnState_Number == 5))
1687  0335 c60064        	ld	a,_HazzardState
1688  0338 260b          	jrne	L7101
1690  033a c60057        	ld	a,_TurnState_Number
1691  033d a105          	cp	a,#5
1692  033f 2604          	jrne	L7101
1693                     ; 376         TurnState_Number = 0;   //报警开关关，清标志
1695  0341 725f0057      	clr	_TurnState_Number
1696  0345               L7101:
1697                     ; 380     if( CrashState  == Pressed) Crash_state_Y = 1;                                         //碰撞有效  
1699  0345 c60000        	ld	a,_CrashState
1700  0348 a155          	cp	a,#85
1701  034a 2604          	jrne	L3201
1704  034c 35010063      	mov	_Crash_state_Y,#1
1705  0350               L3201:
1706                     ; 382     if(( Crash_state_Y == 1 )&&(rTurnLamp_KeepTime == 0)&&(lTurnLamp_KeepTime == 0)) TurnState_Number = 6 ;
1708  0350 c60063        	ld	a,_Crash_state_Y
1709  0353 4a            	dec	a
1710  0354 2618          	jrne	L5201
1712  0356 ae0002        	ldw	x,#L355_rTurnLamp_KeepTime
1713  0359 8d000000      	callf	d_lzmp
1715  035d 260f          	jrne	L5201
1717  035f ae0006        	ldw	x,#L155_lTurnLamp_KeepTime
1718  0362 8d000000      	callf	d_lzmp
1720  0366 2606          	jrne	L5201
1723  0368 35060057      	mov	_TurnState_Number,#6
1725  036c 200b          	jra	L7201
1726  036e               L5201:
1727                     ; 383     else if(TurnState_Number == 6)
1729  036e c60057        	ld	a,_TurnState_Number
1730  0371 a106          	cp	a,#6
1731  0373 2604          	jrne	L7201
1732                     ; 385          TurnState_Number = 0;
1734  0375 725f0057      	clr	_TurnState_Number
1735  0379               L7201:
1736                     ; 389     if((HazzardState == Unpressed) && (Crash_state_Y != 1))
1738  0379 c60064        	ld	a,_HazzardState
1739  037c 2613          	jrne	L3301
1741  037e c60063        	ld	a,_Crash_state_Y
1742  0381 4a            	dec	a
1743  0382 270d          	jreq	L3301
1744                     ; 391         rTurnLamp_KeepTime = 0;
1746  0384 5f            	clrw	x
1747  0385 cf0004        	ldw	L355_rTurnLamp_KeepTime+2,x
1748  0388 cf0002        	ldw	L355_rTurnLamp_KeepTime,x
1749                     ; 392         lTurnLamp_KeepTime = 0;
1751  038b cf0008        	ldw	L155_lTurnLamp_KeepTime+2,x
1752  038e cf0006        	ldw	L155_lTurnLamp_KeepTime,x
1753  0391               L3301:
1754                     ; 396     if(R_oldstate != Turn_R_State)
1756  0391 c60010        	ld	a,L345_R_oldstate
1757  0394 c10067        	cp	a,_Turn_R_State
1758  0397 2604ac260426  	jreq	L5301
1759                     ; 398         if((HazzardState == Pressed)&&( IGNstate == ON )&&(Turn_R_State == Pressed))
1761  039d c60064        	ld	a,_HazzardState
1762  03a0 a155          	cp	a,#85
1763  03a2 261e          	jrne	L7301
1765  03a4 c60000        	ld	a,_IGNstate
1766  03a7 a155          	cp	a,#85
1767  03a9 2617          	jrne	L7301
1769  03ab c60067        	ld	a,_Turn_R_State
1770  03ae a155          	cp	a,#85
1771  03b0 2610          	jrne	L7301
1772                     ; 400             rTurnLamp_KeepTime = 375000;  
1774  03b2 aeb8d8        	ldw	x,#47320
1775  03b5 cf0004        	ldw	L355_rTurnLamp_KeepTime+2,x
1776  03b8 ae0005        	ldw	x,#5
1777  03bb cf0002        	ldw	L355_rTurnLamp_KeepTime,x
1778                     ; 401             TurnState_Number = 1;   
1780  03be 35010057      	mov	_TurnState_Number,#1
1781  03c2               L7301:
1782                     ; 403         if((HazzardState == Pressed)&&( IGNstate == ON )&&(Turn_R_State == Unpressed))
1784  03c2 c60064        	ld	a,_HazzardState
1785  03c5 a155          	cp	a,#85
1786  03c7 2617          	jrne	L1401
1788  03c9 c60000        	ld	a,_IGNstate
1789  03cc a155          	cp	a,#85
1790  03ce 2610          	jrne	L1401
1792  03d0 c60067        	ld	a,_Turn_R_State
1793  03d3 260b          	jrne	L1401
1794                     ; 405             rTurnLamp_KeepTime = 0;  
1796  03d5 5f            	clrw	x
1797  03d6 cf0004        	ldw	L355_rTurnLamp_KeepTime+2,x
1798  03d9 cf0002        	ldw	L355_rTurnLamp_KeepTime,x
1799                     ; 406             TurnState_Number =   5 ; 
1801  03dc 35050057      	mov	_TurnState_Number,#5
1802  03e0               L1401:
1803                     ; 408         if((Crash_state_Y == 1 ) &&( IGNstate == ON )&&(Turn_R_State == Pressed))
1805  03e0 c60063        	ld	a,_Crash_state_Y
1806  03e3 4a            	dec	a
1807  03e4 261e          	jrne	L3401
1809  03e6 c60000        	ld	a,_IGNstate
1810  03e9 a155          	cp	a,#85
1811  03eb 2617          	jrne	L3401
1813  03ed c60067        	ld	a,_Turn_R_State
1814  03f0 a155          	cp	a,#85
1815  03f2 2610          	jrne	L3401
1816                     ; 410             rTurnLamp_KeepTime = 375000;
1818  03f4 aeb8d8        	ldw	x,#47320
1819  03f7 cf0004        	ldw	L355_rTurnLamp_KeepTime+2,x
1820  03fa ae0005        	ldw	x,#5
1821  03fd cf0002        	ldw	L355_rTurnLamp_KeepTime,x
1822                     ; 411             TurnState_Number = 1;   
1824  0400 35010057      	mov	_TurnState_Number,#1
1825  0404               L3401:
1826                     ; 413         if((Crash_state_Y == 1 ) &&( IGNstate == ON )&&(Turn_R_State == Unpressed))
1828  0404 c60063        	ld	a,_Crash_state_Y
1829  0407 4a            	dec	a
1830  0408 2617          	jrne	L5401
1832  040a c60000        	ld	a,_IGNstate
1833  040d a155          	cp	a,#85
1834  040f 2610          	jrne	L5401
1836  0411 c60067        	ld	a,_Turn_R_State
1837  0414 260b          	jrne	L5401
1838                     ; 415             rTurnLamp_KeepTime = 0;
1840  0416 5f            	clrw	x
1841  0417 cf0004        	ldw	L355_rTurnLamp_KeepTime+2,x
1842  041a cf0002        	ldw	L355_rTurnLamp_KeepTime,x
1843                     ; 416             TurnState_Number = 6;
1845  041d 35060057      	mov	_TurnState_Number,#6
1846  0421               L5401:
1847                     ; 418         R_oldstate = Turn_R_State;
1849  0421 5500670010    	mov	L345_R_oldstate,_Turn_R_State
1850  0426               L5301:
1851                     ; 421     if(rTurnLamp_KeepTime != 0) //优先30秒 右转向优先
1853  0426 ae0002        	ldw	x,#L355_rTurnLamp_KeepTime
1854  0429 8d000000      	callf	d_lzmp
1856  042d 2715          	jreq	L7401
1857                     ; 423          rTurnLamp_KeepTime--;
1859  042f a601          	ld	a,#1
1860  0431 8d000000      	callf	d_lgsbc
1862                     ; 425          if((rTurnLamp_KeepTime == 0)&&(TurnState_Number == 1))
1864  0435 8d000000      	callf	d_lzmp
1866  0439 2609          	jrne	L7401
1868  043b c60057        	ld	a,_TurnState_Number
1869  043e 4a            	dec	a
1870  043f 2603          	jrne	L7401
1871                     ; 427              TurnState_Number = 0 ;
1873  0441 c70057        	ld	_TurnState_Number,a
1874  0444               L7401:
1875                     ; 432     if(L_oldstate != Turn_L_State)
1877  0444 c6000f        	ld	a,L545_L_oldstate
1878  0447 c10066        	cp	a,_Turn_L_State
1879  044a 2604acd904d9  	jreq	L3501
1880                     ; 434         if((HazzardState == Pressed)&&( IGNstate == ON )&&(Turn_L_State == Pressed))
1882  0450 c60064        	ld	a,_HazzardState
1883  0453 a155          	cp	a,#85
1884  0455 261e          	jrne	L5501
1886  0457 c60000        	ld	a,_IGNstate
1887  045a a155          	cp	a,#85
1888  045c 2617          	jrne	L5501
1890  045e c60066        	ld	a,_Turn_L_State
1891  0461 a155          	cp	a,#85
1892  0463 2610          	jrne	L5501
1893                     ; 436             lTurnLamp_KeepTime = 375000;  
1895  0465 aeb8d8        	ldw	x,#47320
1896  0468 cf0008        	ldw	L155_lTurnLamp_KeepTime+2,x
1897  046b ae0005        	ldw	x,#5
1898  046e cf0006        	ldw	L155_lTurnLamp_KeepTime,x
1899                     ; 437             TurnState_Number = 2;  
1901  0471 35020057      	mov	_TurnState_Number,#2
1902  0475               L5501:
1903                     ; 439         if((HazzardState == Pressed)&&( IGNstate == ON )&&(Turn_L_State == Unpressed))
1905  0475 c60064        	ld	a,_HazzardState
1906  0478 a155          	cp	a,#85
1907  047a 2617          	jrne	L7501
1909  047c c60000        	ld	a,_IGNstate
1910  047f a155          	cp	a,#85
1911  0481 2610          	jrne	L7501
1913  0483 c60066        	ld	a,_Turn_L_State
1914  0486 260b          	jrne	L7501
1915                     ; 441             lTurnLamp_KeepTime = 0;  
1917  0488 5f            	clrw	x
1918  0489 cf0008        	ldw	L155_lTurnLamp_KeepTime+2,x
1919  048c cf0006        	ldw	L155_lTurnLamp_KeepTime,x
1920                     ; 442             TurnState_Number =   5 ; 
1922  048f 35050057      	mov	_TurnState_Number,#5
1923  0493               L7501:
1924                     ; 444         if((Crash_state_Y == 1 ) &&( IGNstate == ON )&&(Turn_L_State == Pressed))
1926  0493 c60063        	ld	a,_Crash_state_Y
1927  0496 4a            	dec	a
1928  0497 261e          	jrne	L1601
1930  0499 c60000        	ld	a,_IGNstate
1931  049c a155          	cp	a,#85
1932  049e 2617          	jrne	L1601
1934  04a0 c60066        	ld	a,_Turn_L_State
1935  04a3 a155          	cp	a,#85
1936  04a5 2610          	jrne	L1601
1937                     ; 446             lTurnLamp_KeepTime = 375000;
1939  04a7 aeb8d8        	ldw	x,#47320
1940  04aa cf0008        	ldw	L155_lTurnLamp_KeepTime+2,x
1941  04ad ae0005        	ldw	x,#5
1942  04b0 cf0006        	ldw	L155_lTurnLamp_KeepTime,x
1943                     ; 447             TurnState_Number = 2;  
1945  04b3 35020057      	mov	_TurnState_Number,#2
1946  04b7               L1601:
1947                     ; 449         if((Crash_state_Y == 1 ) &&( IGNstate == ON )&&(Turn_L_State == Unpressed))
1949  04b7 c60063        	ld	a,_Crash_state_Y
1950  04ba 4a            	dec	a
1951  04bb 2617          	jrne	L3601
1953  04bd c60000        	ld	a,_IGNstate
1954  04c0 a155          	cp	a,#85
1955  04c2 2610          	jrne	L3601
1957  04c4 c60066        	ld	a,_Turn_L_State
1958  04c7 260b          	jrne	L3601
1959                     ; 451             lTurnLamp_KeepTime = 0;
1961  04c9 5f            	clrw	x
1962  04ca cf0008        	ldw	L155_lTurnLamp_KeepTime+2,x
1963  04cd cf0006        	ldw	L155_lTurnLamp_KeepTime,x
1964                     ; 452             TurnState_Number = 6;
1966  04d0 35060057      	mov	_TurnState_Number,#6
1967  04d4               L3601:
1968                     ; 454         L_oldstate = Turn_L_State;
1970  04d4 550066000f    	mov	L545_L_oldstate,_Turn_L_State
1971  04d9               L3501:
1972                     ; 457     if(lTurnLamp_KeepTime != 0) //优先30秒 左转向优先
1974  04d9 ae0006        	ldw	x,#L155_lTurnLamp_KeepTime
1975  04dc 8d000000      	callf	d_lzmp
1977  04e0 2717          	jreq	L5601
1978                     ; 459          lTurnLamp_KeepTime--;
1980  04e2 a601          	ld	a,#1
1981  04e4 8d000000      	callf	d_lgsbc
1983                     ; 460          if((lTurnLamp_KeepTime == 0)&&(TurnState_Number == 2))
1985  04e8 8d000000      	callf	d_lzmp
1987  04ec 260b          	jrne	L5601
1989  04ee c60057        	ld	a,_TurnState_Number
1990  04f1 a102          	cp	a,#2
1991  04f3 2604          	jrne	L5601
1992                     ; 462 			 TurnState_Number = 0; 
1994  04f5 725f0057      	clr	_TurnState_Number
1995  04f9               L5601:
1996                     ; 468     if(TurnLamp_CrashKeepTime != 0) 
1998  04f9 ce0068        	ldw	x,_TurnLamp_CrashKeepTime
1999  04fc 2704          	jreq	L1701
2000                     ; 470         TurnLamp_CrashKeepTime--; 
2002  04fe 5a            	decw	x
2003  04ff cf0068        	ldw	_TurnLamp_CrashKeepTime,x
2004  0502               L1701:
2005                     ; 473     if((TurnLamp_CrashKeepTime == 0)&&(HAZZARD_oldstate != HazzardState) && (Crash_state_Y == 1 ))
2007  0502 ce0068        	ldw	x,_TurnLamp_CrashKeepTime
2008  0505 2619          	jrne	L3701
2010  0507 c6000e        	ld	a,L745_HAZZARD_oldstate
2011  050a c10064        	cp	a,_HazzardState
2012  050d 2711          	jreq	L3701
2014  050f c60063        	ld	a,_Crash_state_Y
2015  0512 4a            	dec	a
2016  0513 260b          	jrne	L3701
2017                     ; 475          HAZZARD_oldstate = HazzardState;
2019  0515 550064000e    	mov	L745_HAZZARD_oldstate,_HazzardState
2020                     ; 476          HazzardState = Unpressed ;
2022  051a c70064        	ld	_HazzardState,a
2023                     ; 479               Crash_state_Y = 0;           //关闭碰撞报警
2025  051d c70063        	ld	_Crash_state_Y,a
2026  0520               L3701:
2027                     ; 486     if(( BCMtoGEM_AlarmStatus == Armed ) &&( Warningstate == 0 ))
2029  0520 c60000        	ld	a,_BCMtoGEM_AlarmStatus
2030  0523 a110          	cp	a,#16
2031  0525 263d          	jrne	L5701
2033  0527 c60065        	ld	a,_Warningstate
2034  052a 2638          	jrne	L5701
2035                     ; 488         if( TRUNKWarmstate == 1 )
2037  052c c60000        	ld	a,_TRUNKWarmstate
2038  052f 4a            	dec	a
2039  0530 2613          	jrne	L7701
2040                     ; 490               if( ( DoorState != 0 ) || (IGNstate == ON))
2042  0532 c60000        	ld	a,_DoorState
2043  0535 2607          	jrne	L3011
2045  0537 c60000        	ld	a,_IGNstate
2046  053a a155          	cp	a,#85
2047  053c 2626          	jrne	L5701
2048  053e               L3011:
2049                     ; 492                   if(DoorWarmState == 0)//??
2051  053e c60000        	ld	a,_DoorWarmState
2052  0541 261d          	jrne	L1211
2053                     ; 494                      Warningstate = 1;   //此处可能影响后备箱报警  //0317
2055  0543 2015          	jpf	LC004
2056                     ; 498                      Warningstate = 0;
2057  0545               L7701:
2058                     ; 504              if( (( DoorState != 0 ) && (( DoorState & TrunkIsOpen ) == 0)) || (IGNstate == ON))
2060  0545 c60000        	ld	a,_DoorState
2061  0548 2704          	jreq	L7111
2063  054a a504          	bcp	a,#4
2064  054c 2707          	jreq	L5111
2065  054e               L7111:
2067  054e c60000        	ld	a,_IGNstate
2068  0551 a155          	cp	a,#85
2069  0553 260f          	jrne	L5701
2070  0555               L5111:
2071                     ; 506                   if(DoorWarmState == 0)//??
2073  0555 c60000        	ld	a,_DoorWarmState
2074  0558 2606          	jrne	L1211
2075                     ; 508                      Warningstate = 1;
2077  055a               LC004:
2079  055a 35010065      	mov	_Warningstate,#1
2081  055e 2004          	jra	L5701
2082  0560               L1211:
2083                     ; 512                      Warningstate = 0;
2086  0560 725f0065      	clr	_Warningstate
2087  0564               L5701:
2088                     ; 520     if(((FORTIFYSW_state != 0x55 )||(CAN_FORTIFY_state != 0x55))&&( Warningstate == 1 )&& (WarningTimeCnt <= 37500))
2090  0564 c60000        	ld	a,_FORTIFYSW_state
2091  0567 a155          	cp	a,#85
2092  0569 2607          	jrne	L7211
2094  056b c60000        	ld	a,_CAN_FORTIFY_state
2095  056e a155          	cp	a,#85
2096  0570 2758          	jreq	L5211
2097  0572               L7211:
2099  0572 c60065        	ld	a,_Warningstate
2100  0575 4a            	dec	a
2101  0576 2652          	jrne	L5211
2103  0578 ce0061        	ldw	x,_WarningTimeCnt
2104  057b 8d000000      	callf	d_uitolx
2106  057f ae0000        	ldw	x,#L41
2107  0582 8d000000      	callf	d_lcmp
2109  0586 2e42          	jrsge	L5211
2110                     ; 522          WarningTimeCnt++;    
2112  0588 ce0061        	ldw	x,_WarningTimeCnt
2113  058b 5c            	incw	x
2114  058c cf0061        	ldw	_WarningTimeCnt,x
2115                     ; 523          CarState |= CarIsAttack;
2117  058f c60000        	ld	a,_CarState
2118  0592 aa55          	or	a,#85
2119  0594 c70000        	ld	_CarState,a
2120                     ; 524          if( WarningTimeCnt == 1 )
2122  0597 5a            	decw	x
2123  0598 2604          	jrne	L1311
2124                     ; 526              Alarmstatus_RKE = 4; //报警激活BCM需要回到警戒状态
2126  059a 35040000      	mov	_Alarmstatus_RKE,#4
2127  059e               L1311:
2128                     ; 528          if(DIDF1f2EEPROM[0] != 0x00)TurnState_Number = 7;
2130  059e 725d0000      	tnz	_DIDF1f2EEPROM
2131  05a2 2704          	jreq	L3311
2134  05a4 35070057      	mov	_TurnState_Number,#7
2135  05a8               L3311:
2136                     ; 530          if ( ( !HornWarm ) && ( DIDF1f2EEPROM[0] != 0x00 ) )   //根据诊断设置判断是否驱动喇叭报警
2138  05a8 725d0000      	tnz	_Configuration
2139  05ac 2605          	jrne	L61
2140  05ae ae0001        	ldw	x,#1
2141  05b1 2001          	jra	L02
2142  05b3               L61:
2143  05b3 5f            	clrw	x
2144  05b4               L02:
2145  05b4 01            	rrwa	x,a
2146  05b5 a540          	bcp	a,#64
2147  05b7 270b          	jreq	L5311
2149  05b9 c60000        	ld	a,_DIDF1f2EEPROM
2150  05bc 2706          	jreq	L5311
2151                     ; 532              CarHornstate = 1 ;
2153  05be 35010000      	mov	_CarHornstate,#1
2155  05c2 201d          	jra	L1411
2156  05c4               L5311:
2157                     ; 536              CarHornstate = 0 ;
2159  05c4 725f0000      	clr	_CarHornstate
2160  05c8 2017          	jra	L1411
2161  05ca               L5211:
2162                     ; 539     else if (TurnState_Number == 7)
2164  05ca c60057        	ld	a,_TurnState_Number
2165  05cd a107          	cp	a,#7
2166  05cf 2604          	jrne	L3411
2167                     ; 541          TurnState_Number = 0;
2169  05d1 725f0057      	clr	_TurnState_Number
2170                     ; 542          CarHornstate = 0;
2171                     ; 543          WarningTimeCnt = 0;
2172                     ; 544          Warningstate = 0;
2174  05d5               L3411:
2175                     ; 548          CarHornstate = 0;
2177                     ; 549          WarningTimeCnt = 0;
2179                     ; 550          Warningstate = 0;
2182  05d5 725f0000      	clr	_CarHornstate
2184  05d9 5f            	clrw	x
2185  05da cf0061        	ldw	_WarningTimeCnt,x
2187  05dd 725f0065      	clr	_Warningstate
2188  05e1               L1411:
2189                     ; 556     if( BrakeSpeedHazards_state == 1 )
2191  05e1 c60060        	ld	a,_BrakeSpeedHazards_state
2192  05e4 4a            	dec	a
2193  05e5 2606          	jrne	L7411
2194                     ; 564                 TurnState_Number = 8;                
2196  05e7 35080057      	mov	_TurnState_Number,#8
2198  05eb 200f          	jra	L1511
2199  05ed               L7411:
2200                     ; 577     else if( TurnState_Number == 8 )
2202  05ed c60057        	ld	a,_TurnState_Number
2203  05f0 a108          	cp	a,#8
2204  05f2 2608          	jrne	L1511
2205                     ; 579          TurnState_Number = 0;
2207  05f4 725f0057      	clr	_TurnState_Number
2208                     ; 580          Speedwarmstate = 0 ;
2210  05f8 725f0011      	clr	L555_Speedwarmstate
2211  05fc               L1511:
2212                     ; 585     if((DIDF1f2EEPROM == 0x00)||(CAN_FORTIFY_state == 0x55))
2214  05fc ae0000        	ldw	x,#_DIDF1f2EEPROM
2215  05ff 2707          	jreq	L7511
2217  0601 c60000        	ld	a,_CAN_FORTIFY_state
2218  0604 a155          	cp	a,#85
2219  0606 260b          	jrne	L5511
2220  0608               L7511:
2221                     ; 587         if(TurnState_Number >= 7)
2223  0608 c60057        	ld	a,_TurnState_Number
2224  060b a107          	cp	a,#7
2225  060d 2504          	jrult	L5511
2226                     ; 589             TurnState_Number = 0 ; ////////////////////
2228  060f 725f0057      	clr	_TurnState_Number
2229  0613               L5511:
2230                     ; 594     switch(TurnState_Number)
2232  0613 c60057        	ld	a,_TurnState_Number
2234                     ; 638        	       break;
2235  0616 4a            	dec	a
2236  0617 271a          	jreq	L755
2237  0619 4a            	dec	a
2238  061a 2725          	jreq	L165
2239  061c 4a            	dec	a
2240  061d 2730          	jreq	L365
2241  061f 4a            	dec	a
2242  0620 2732          	jreq	L565
2243  0622 4a            	dec	a
2244  0623 2739          	jreq	L375
2245  0625 4a            	dec	a
2246  0626 2731          	jreq	L175
2247  0628 4a            	dec	a
2248  0629 2733          	jreq	L375
2249  062b 4a            	dec	a
2250  062c 2730          	jreq	L375
2251                     ; 635        default: TurnLampDrv = 0x00;                    //错误或无任何状态   
2253  062e 725f006a      	clr	_TurnLampDrv
2254                     ; 638        	       break;
2257  0632 87            	retf	
2258  0633               L755:
2259                     ; 597 	   case 1: TurnLampDrv = TurnLampRightOn;          //置右转向   
2261  0633 3502006a      	mov	_TurnLampDrv,#2
2262                     ; 600 	           if(IGNstate == OFF) {TurnLampDrv = TurnLampDrv&TurnLampRightOff; }//CAN_TURNRightSW_OFF;}
2264  0637 725d0000      	tnz	_IGNstate
2265  063b 2625          	jrne	L5611
2268  063d c7006a        	ld	_TurnLampDrv,a
2270  0640 87            	retf	
2271  0641               L165:
2272                     ; 603        case 2: 
2272                     ; 604 	   	       TurnLampDrv = TurnLampLeftOn;       	   //置左转向
2274  0641 3501006a      	mov	_TurnLampDrv,#1
2275                     ; 607                if(IGNstate == OFF){ TurnLampDrv = TurnLampDrv&TurnLampLeftOff;}// 	 CAN_TURNLeftSW_OFF;  }
2277  0645 725d0000      	tnz	_IGNstate
2278  0649 2617          	jrne	L5611
2281  064b c7006a        	ld	_TurnLampDrv,a
2283  064e 87            	retf	
2284  064f               L365:
2285                     ; 610        case 3: TurnLampDrv = TurnLampRightOn;          //置右转变道
2287  064f 3502006a      	mov	_TurnLampDrv,#2
2288                     ; 613        	       break;
2291  0653 87            	retf	
2292  0654               L565:
2293                     ; 614        case 4: TurnLampDrv = TurnLampLeftOn;           //置左转变道  
2295  0654 3501006a      	mov	_TurnLampDrv,#1
2296                     ; 617        	       break;
2299  0658 87            	retf	
2300                     ; 618        case 5: TurnLampDrv = TurnLampHazzardOn;        //置报警开关报警  
2301                     ; 621        	       break;
2303  0659               L175:
2304                     ; 622        case 6: TurnLampDrv = TurnLampCrashOn;          //置碰撞报警
2306  0659 3508006a      	mov	_TurnLampDrv,#8
2307                     ; 625        	       break; 
2310  065d 87            	retf	
2311  065e               L375:
2312                     ; 626 	   case 7: TurnLampDrv = TurnLampHazzardOn; 	   //进入设防后异常报警
2313                     ; 629 			   break;
2315                     ; 631 	   case 8: TurnLampDrv = TurnLampHazzardOn;        //进入刹车报警  
2319  065e 3504006a      	mov	_TurnLampDrv,#4
2320                     ; 634 	           break;
2322  0662               L5611:
2323                     ; 642 }
2326  0662 87            	retf	
2328                     	switch	.data
2329  0000               _turnfindcarstate:
2330  0000 00            	dc.b	0
2331                     	switch	.bss
2332  0012               L3711_tempFlashCnt:
2333  0012 00            	ds.b	1
2372                     ; 659 void JudgeTurnLampDrv(void)
2372                     ; 660 {
2373                     	switch	.text
2374  0663               f_JudgeTurnLampDrv:
2378                     ; 664     if(TurnLampDrv == 0) TurnLampOnCnt = 0;
2380  0663 c6006a        	ld	a,_TurnLampDrv
2381  0666 2603          	jrne	L5121
2384  0668 c7005e        	ld	_TurnLampOnCnt,a
2385  066b               L5121:
2386                     ; 681     if (TurnFlashCnt)
2388  066b ce006d        	ldw	x,_TurnFlashCnt
2389  066e 274e          	jreq	L7121
2390                     ; 683         if (++tempFlashCnt < 45) ///RKE_FLASH_TL_DUTY    080616
2392  0670 725c0012      	inc	L3711_tempFlashCnt
2393  0674 c60012        	ld	a,L3711_tempFlashCnt
2394  0677 a12d          	cp	a,#45
2395  0679 2415          	jruge	L1221
2396                     ; 685     		TURN_LEFT_LAMP_ON;
2398  067b 72185019      	bset	20505,#4
2399                     ; 686     		TURN_RIGHT_LAMP_ON;
2401  067f 721a5019      	bset	20505,#5
2402                     ; 687 			CAN_TURNRightSW_ON;
2404  0683 72180001      	bset	_CanSendData+1,#4
2405                     ; 688 			CAN_TURNLeftSW_ON;
2407  0687 721c0001      	bset	_CanSendData+1,#6
2408                     ; 689 			turnfindcarstate = 1;
2410  068b 35010000      	mov	_turnfindcarstate,#1
2413  068f 87            	retf	
2414  0690               L1221:
2415                     ; 692     	else if (tempFlashCnt < 90)//RKE_FLASH_TL_PERIOD  //080616
2417  0690 a15a          	cp	a,#90
2418  0692 241d          	jruge	L5221
2419                     ; 694     		TURN_LEFT_LAMP_OFF;
2421  0694 72195019      	bres	20505,#4
2422                     ; 695     		TURN_RIGHT_LAMP_OFF;
2424  0698 721b5019      	bres	20505,#5
2425                     ; 696 			CAN_TURNRightSW_OFF;
2427  069c c60001        	ld	a,_CanSendData+1
2428  069f a4cf          	and	a,#207
2429  06a1 c70001        	ld	_CanSendData+1,a
2430                     ; 697 			CAN_TURNLeftSW_OFF;
2432  06a4 c60001        	ld	a,_CanSendData+1
2433  06a7 a43f          	and	a,#63
2434  06a9 c70001        	ld	_CanSendData+1,a
2435                     ; 698 			turnfindcarstate = 1;
2437  06ac 35010000      	mov	_turnfindcarstate,#1
2440  06b0 87            	retf	
2441  06b1               L5221:
2442                     ; 702     	       turnfindcarstate = 0;
2444  06b1 725f0000      	clr	_turnfindcarstate
2445                     ; 703     		TurnFlashCnt--;
2447  06b5 5a            	decw	x
2448  06b6 cf006d        	ldw	_TurnFlashCnt,x
2449                     ; 704     		tempFlashCnt = 0;
2451  06b9 725f0012      	clr	L3711_tempFlashCnt
2453  06bd 87            	retf	
2454  06be               L7121:
2455                     ; 708     else if (TurnLampDrv)
2457  06be c6006a        	ld	a,_TurnLampDrv
2458  06c1 2604acfd07fd  	jreq	L3321
2459                     ; 710     	tempFlashCnt = 0;
2461  06c7 725f0012      	clr	L3711_tempFlashCnt
2462                     ; 711         TurnLampOnCnt++;
2464  06cb 725c005e      	inc	_TurnLampOnCnt
2465                     ; 712         if (TurnLampOnCnt < TL_DUTY)
2467  06cf c6005e        	ld	a,_TurnLampOnCnt
2468  06d2 c1005b        	cp	a,_TL_DUTY
2469  06d5 2504aca707a7  	jruge	L5321
2470                     ; 714             if (TurnLampDrv == 0xff)
2472  06db c6006a        	ld	a,_TurnLampDrv
2473  06de a1ff          	cp	a,#255
2474  06e0 2625          	jrne	L7321
2475                     ; 716 	            TURN_LEFT_LAMP_ON;
2477  06e2 72185019      	bset	20505,#4
2478                     ; 717 				TURN_RIGHT_LAMP_OFF;
2480  06e6 721b5019      	bres	20505,#5
2481                     ; 718 				CAN_TURNRightSW_OFF;
2483  06ea c60001        	ld	a,_CanSendData+1
2484  06ed a4cf          	and	a,#207
2485  06ef c70001        	ld	_CanSendData+1,a
2486                     ; 719 				CAN_TURNLeftSW_ON;
2488  06f2 721c0001      	bset	_CanSendData+1,#6
2489                     ; 721 	            if (TurnLampOnCnt <= TL_WAIT_TIME)
2491  06f6 c6005e        	ld	a,_TurnLampOnCnt
2492  06f9 a10b          	cp	a,#11
2493  06fb 2405          	jruge	L1421
2494                     ; 723                     TurnLampCScmd = TLCSCMD_NO;
2496  06fd 725f005d      	clr	_TurnLampCScmd
2499  0701 87            	retf	
2500  0702               L1421:
2501                     ; 727 	        		TurnLampCScmd |= TLCSCMD_L_OPEN;
2503  0702 7210005d      	bset	_TurnLampCScmd,#0
2505  0706 87            	retf	
2506  0707               L7321:
2507                     ; 730             else if (TurnLampDrv == TurnLampLeftOn)
2509  0707 a101          	cp	a,#1
2510  0709 2625          	jrne	L7421
2511                     ; 732                 TURN_LEFT_LAMP_ON ;
2513  070b 72185019      	bset	20505,#4
2514                     ; 733                 TURN_RIGHT_LAMP_OFF;
2516  070f 721b5019      	bres	20505,#5
2517                     ; 734 				CAN_TURNRightSW_OFF;
2519  0713 c60001        	ld	a,_CanSendData+1
2520  0716 a4cf          	and	a,#207
2521  0718 c70001        	ld	_CanSendData+1,a
2522                     ; 735 				CAN_TURNLeftSW_ON;
2524  071b 721c0001      	bset	_CanSendData+1,#6
2525                     ; 736                 if( TurnLampOnCnt <= TL_WAIT_TIME)
2527  071f c6005e        	ld	a,_TurnLampOnCnt
2528  0722 a10b          	cp	a,#11
2529  0724 2405          	jruge	L1521
2530                     ; 738                     TurnLampCScmd = TLCSCMD_NO ;
2532  0726 725f005d      	clr	_TurnLampCScmd
2535  072a 87            	retf	
2536  072b               L1521:
2537                     ; 742                     TurnLampCScmd |= TLCSCMD_L_OPEN ;
2539  072b 7210005d      	bset	_TurnLampCScmd,#0
2541  072f 87            	retf	
2542  0730               L7421:
2543                     ; 745 	        else if (TurnLampDrv == TurnLampRightOn)
2545  0730 a102          	cp	a,#2
2546  0732 2625          	jrne	L7521
2547                     ; 747 	            TURN_RIGHT_LAMP_ON;
2549  0734 721a5019      	bset	20505,#5
2550                     ; 748 	            TURN_LEFT_LAMP_OFF;
2552  0738 72195019      	bres	20505,#4
2553                     ; 749 				CAN_TURNRightSW_ON;
2555  073c 72180001      	bset	_CanSendData+1,#4
2556                     ; 750 			         CAN_TURNLeftSW_OFF;
2558  0740 c60001        	ld	a,_CanSendData+1
2559  0743 a43f          	and	a,#63
2560  0745 c70001        	ld	_CanSendData+1,a
2561                     ; 752 	            if (TurnLampOnCnt <= TL_WAIT_TIME)
2563  0748 c6005e        	ld	a,_TurnLampOnCnt
2564  074b a10b          	cp	a,#11
2565  074d 2405          	jruge	L1621
2566                     ; 754                     TurnLampCScmd = TLCSCMD_NO;
2568  074f 725f005d      	clr	_TurnLampCScmd
2571  0753 87            	retf	
2572  0754               L1621:
2573                     ; 758 	        		TurnLampCScmd |= TLCSCMD_R_OPEN;
2575  0754 7214005d      	bset	_TurnLampCScmd,#2
2577  0758 87            	retf	
2578  0759               L7521:
2579                     ; 761 	        else if ((TurnLampDrv == TurnLampHazzardOn ) ||(TurnLampDrv == TurnLampCrashOn))
2581  0759 a104          	cp	a,#4
2582  075b 2704          	jreq	L1721
2584  075d a108          	cp	a,#8
2585  075f 2625          	jrne	L7621
2586  0761               L1721:
2587                     ; 763         		TURN_LEFT_LAMP_ON;
2589  0761 72185019      	bset	20505,#4
2590                     ; 764         		TURN_RIGHT_LAMP_ON;
2592  0765 721a5019      	bset	20505,#5
2593                     ; 765 			CAN_TURNRightSW_ON;
2595  0769 72180001      	bset	_CanSendData+1,#4
2596                     ; 766 			CAN_TURNLeftSW_ON;
2598  076d 721c0001      	bset	_CanSendData+1,#6
2599                     ; 768 	            if (TurnLampOnCnt <= TL_WAIT_TIME)
2601  0771 c6005e        	ld	a,_TurnLampOnCnt
2602  0774 a10b          	cp	a,#11
2603  0776 2405          	jruge	L3721
2604                     ; 770                     TurnLampCScmd = TLCSCMD_NO;
2606  0778 725f005d      	clr	_TurnLampCScmd
2609  077c 87            	retf	
2610  077d               L3721:
2611                     ; 774 	        		TurnLampCScmd |= TLCSCMD_L_OPEN;
2613  077d 7210005d      	bset	_TurnLampCScmd,#0
2614                     ; 775 	        		TurnLampCScmd |= TLCSCMD_R_OPEN;	
2616  0781 7214005d      	bset	_TurnLampCScmd,#2
2618  0785 87            	retf	
2619  0786               L7621:
2620                     ; 780 	        	TurnLampDrv = 0;
2622  0786 725f006a      	clr	_TurnLampDrv
2623                     ; 781 	        	TURN_LEFT_LAMP_OFF;
2625  078a 72195019      	bres	20505,#4
2626                     ; 782 	        	TURN_RIGHT_LAMP_OFF;
2628  078e 721b5019      	bres	20505,#5
2629                     ; 783 							CAN_TURNRightSW_OFF;
2631  0792 c60001        	ld	a,_CanSendData+1
2632  0795 a4cf          	and	a,#207
2633  0797 c70001        	ld	_CanSendData+1,a
2634                     ; 784 			CAN_TURNLeftSW_OFF;
2636  079a c60001        	ld	a,_CanSendData+1
2637  079d a43f          	and	a,#63
2638  079f c70001        	ld	_CanSendData+1,a
2639                     ; 785 	        	TurnLampCScmd = TLCSCMD_NO;
2641  07a2 725f005d      	clr	_TurnLampCScmd
2643  07a6 87            	retf	
2644  07a7               L5321:
2645                     ; 788         else if(TurnLampOnCnt < TL_PERIOD)
2647  07a7 c1005a        	cp	a,_TL_PERIOD
2648  07aa 243d          	jruge	L3031
2649                     ; 790         	TURN_LEFT_LAMP_OFF;
2651  07ac 72195019      	bres	20505,#4
2652                     ; 791         	TURN_RIGHT_LAMP_OFF;
2654  07b0 721b5019      	bres	20505,#5
2655                     ; 792 			CAN_TURNRightSW_OFF;
2657  07b4 c60001        	ld	a,_CanSendData+1
2658  07b7 a4cf          	and	a,#207
2659  07b9 c70001        	ld	_CanSendData+1,a
2660                     ; 793 			CAN_TURNLeftSW_OFF;
2662  07bc c60001        	ld	a,_CanSendData+1
2663  07bf a43f          	and	a,#63
2664  07c1 c70001        	ld	_CanSendData+1,a
2665                     ; 795             if (TurnLampOnCnt <=  (TL_DUTY + TL_WAIT_TIME))
2667  07c4 c6005e        	ld	a,_TurnLampOnCnt
2668  07c7 5f            	clrw	x
2669  07c8 97            	ld	xl,a
2670  07c9 bf01          	ldw	c_x+1,x
2671  07cb c6005b        	ld	a,_TL_DUTY
2672  07ce 905f          	clrw	y
2673  07d0 9097          	ld	yl,a
2674  07d2 72a9000a      	addw	y,#10
2675  07d6 90b301        	cpw	y,c_x+1
2676  07d9 2f05          	jrslt	L5031
2677                     ; 797                 TurnLampCScmd = TLCSCMD_NO;
2679  07db 725f005d      	clr	_TurnLampCScmd
2682  07df 87            	retf	
2683  07e0               L5031:
2684                     ; 801         		TurnLampCScmd |= TLCSCMD_L_SHORT;
2686  07e0 7212005d      	bset	_TurnLampCScmd,#1
2687                     ; 802         		TurnLampCScmd |= TLCSCMD_R_SHORT;	
2689  07e4 7216005d      	bset	_TurnLampCScmd,#3
2691  07e8 87            	retf	
2692  07e9               L3031:
2693                     ; 807             TurnLampOnCnt = 0;
2695  07e9 725f005e      	clr	_TurnLampOnCnt
2696                     ; 808 	       	TurnLampCScmd = TLCSCMD_NO;
2698  07ed 725f005d      	clr	_TurnLampCScmd
2699                     ; 809            	if (TLSwitchRoadwayFlashCnt < 3) 
2701  07f1 c6005c        	ld	a,_TLSwitchRoadwayFlashCnt
2702  07f4 a103          	cp	a,#3
2703  07f6 2420          	jruge	L1321
2704                     ; 811 	         	TLSwitchRoadwayFlashCnt++;
2706  07f8 725c005c      	inc	_TLSwitchRoadwayFlashCnt
2708  07fc 87            	retf	
2709  07fd               L3321:
2710                     ; 817        	TurnLampCScmd = TLCSCMD_NO;
2712  07fd c7005d        	ld	_TurnLampCScmd,a
2713                     ; 818     	TURN_LEFT_LAMP_OFF;
2715  0800 72195019      	bres	20505,#4
2716                     ; 819     	TURN_RIGHT_LAMP_OFF;
2718  0804 721b5019      	bres	20505,#5
2719                     ; 820 					CAN_TURNRightSW_OFF;
2721  0808 c60001        	ld	a,_CanSendData+1
2722  080b a4cf          	and	a,#207
2723  080d c70001        	ld	_CanSendData+1,a
2724                     ; 821 			CAN_TURNLeftSW_OFF;
2726  0810 c60001        	ld	a,_CanSendData+1
2727  0813 a43f          	and	a,#63
2728  0815 c70001        	ld	_CanSendData+1,a
2729  0818               L1321:
2730                     ; 825 }
2733  0818 87            	retf	
2735                     	switch	.bss
2736  0013               L1231_TurnLtime1:
2737  0013 0000          	ds.b	2
2738  0015               L7131_TurnRtime1:
2739  0015 0000          	ds.b	2
2740  0017               L5231_turnlt:
2741  0017 00            	ds.b	1
2742  0018               L3231_turnrt:
2743  0018 00            	ds.b	1
2744  0019               L1331_turnok2:
2745  0019 00            	ds.b	1
2746  001a               L7231_turnok1:
2747  001a 00            	ds.b	1
2828                     ; 840 void ScanTurnLampState(void)
2828                     ; 841 {
2829                     	switch	.text
2830  0819               f_ScanTurnLampState:
2832  0819 89            	pushw	x
2833       00000002      OFST:	set	2
2836                     ; 849 	if(battervalue < 0x214) turnshortad = 300;
2838  081a ce0000        	ldw	x,_battervalue
2839  081d a30214        	cpw	x,#532
2840  0820 2405          	jruge	L3631
2843  0822 ae012c        	ldw	x,#300
2845  0825 2049          	jra	L5631
2846  0827               L3631:
2847                     ; 850 	else if(battervalue < 0x25c) turnshortad = 330;
2849  0827 a3025c        	cpw	x,#604
2850  082a 2405          	jruge	L7631
2853  082c ae014a        	ldw	x,#330
2855  082f 203f          	jra	L5631
2856  0831               L7631:
2857                     ; 851 	else if(battervalue < 0x2ac) turnshortad = 350;
2859  0831 a302ac        	cpw	x,#684
2860  0834 2405          	jruge	L3731
2863  0836 ae015e        	ldw	x,#350
2865  0839 2035          	jra	L5631
2866  083b               L3731:
2867                     ; 852 	else if(battervalue < 0x2db) turnshortad = 360;
2869  083b a302db        	cpw	x,#731
2870  083e 2405          	jruge	L7731
2873  0840 ae0168        	ldw	x,#360
2875  0843 202b          	jra	L5631
2876  0845               L7731:
2877                     ; 853 	else if(battervalue < 0x321) turnshortad = 380;	
2879  0845 a30321        	cpw	x,#801
2880  0848 2405          	jruge	L3041
2883  084a ae017c        	ldw	x,#380
2885  084d 2021          	jra	L5631
2886  084f               L3041:
2887                     ; 854 	else if(battervalue < 0x35e) turnshortad = 390;
2889  084f a3035e        	cpw	x,#862
2890  0852 2405          	jruge	L7041
2893  0854 ae0186        	ldw	x,#390
2895  0857 2017          	jra	L5631
2896  0859               L7041:
2897                     ; 855 	else if(battervalue < 0x3a3) turnshortad = 420;
2899  0859 a303a3        	cpw	x,#931
2900  085c 2405          	jruge	L3141
2903  085e ae01a4        	ldw	x,#420
2905  0861 200d          	jra	L5631
2906  0863               L3141:
2907                     ; 856 	else if(battervalue < 0x3e6) turnshortad = 430;
2909  0863 a303e6        	cpw	x,#998
2910  0866 2405          	jruge	L7141
2913  0868 ae01ae        	ldw	x,#430
2915  086b 2003          	jra	L5631
2916  086d               L7141:
2917                     ; 857 	else turnshortad = 450;
2919  086d ae01c2        	ldw	x,#450
2920  0870               L5631:
2921  0870 cf0053        	ldw	_turnshortad,x
2922                     ; 862 	if (TurnLampState == TL_IS_OK)
2924  0873 c6005f        	ld	a,_TurnLampState
2925                     ; 864 		TL_DUTY = TL_NORMAL_DUTY;
2926                     ; 865 		TL_PERIOD = TL_NORMAL_PERIOD;
2928  0876 270b          	jreq	L1341
2929                     ; 870 	    if ((TurnLampDrv ==TurnLampHazzardOn )||(TurnLampDrv== TurnLampCrashOn))
2931  0878 c6006a        	ld	a,_TurnLampDrv
2932  087b a104          	cp	a,#4
2933  087d 2704          	jreq	L1341
2935  087f a108          	cp	a,#8
2936  0881 262a          	jrne	L7241
2937  0883               L1341:
2938                     ; 872 		    TL_DUTY = TL_NORMAL_DUTY;
2940                     ; 873 		    TL_PERIOD = TL_NORMAL_PERIOD;
2944  0883 352d005b      	mov	_TL_DUTY,#45
2947  0887 355a005a      	mov	_TL_PERIOD,#90
2949  088b               L5241:
2950                     ; 899 	if(TurnLampDrv &  TurnLampLeftOn )
2952  088b 7200006a04ac  	btjf	_TurnLampDrv,#0,L5441
2953                     ; 901                TURN_AD_LEFT_EN;
2955  0894 721f5019      	bres	20505,#7
2956                     ; 902                adResultTemp =  GetADCresultAverage(3);
2958  0898 a603          	ld	a,#3
2959  089a 8d000000      	callf	f_GetADCresultAverage
2961  089e 1f01          	ldw	(OFST-1,sp),x
2962                     ; 906                if(turnlt < turntlcnt) turnlt++;
2964  08a0 c60017        	ld	a,L5231_turnlt
2965  08a3 a10f          	cp	a,#15
2966  08a5 242d          	jruge	L7441
2969  08a7 725c0017      	inc	L5231_turnlt
2971  08ab 2050          	jra	L1541
2972  08ad               L7241:
2973                     ; 877 	              if(((TurnLampDrv == TurnLampRightOn)&&(TurnLampState == TLR_IS_OPEN))||((TurnLampDrv == TurnLampLeftOn)&&(TurnLampState == TLL_IS_OPEN)))
2975  08ad a102          	cp	a,#2
2976  08af 260a          	jrne	L1441
2978  08b1 c6005f        	ld	a,_TurnLampState
2979  08b4 a108          	cp	a,#8
2980  08b6 270d          	jreq	L7341
2981  08b8 c6006a        	ld	a,_TurnLampDrv
2982  08bb               L1441:
2984  08bb 4a            	dec	a
2985  08bc 26c5          	jrne	L1341
2987  08be c6005f        	ld	a,_TurnLampState
2988  08c1 a102          	cp	a,#2
2989  08c3 26be          	jrne	L1341
2990  08c5               L7341:
2991                     ; 879               		TurnLampState &= TL_STA_MASK;
2993  08c5 a40f          	and	a,#15
2994  08c7 c7005f        	ld	_TurnLampState,a
2995                     ; 880               		TL_DUTY = TL_FAST_DUTY;
2997  08ca 3514005b      	mov	_TL_DUTY,#20
2998                     ; 881               		TL_PERIOD = TL_FAST_PERIOD;		
3000  08ce 3528005a      	mov	_TL_PERIOD,#40
3002  08d2 20b7          	jra	L5241
3003                     ; 888               		TL_DUTY = TL_NORMAL_DUTY;
3004                     ; 889               		TL_PERIOD = TL_NORMAL_PERIOD;
3005  08d4               L7441:
3006                     ; 911                       TURNAD =  adResultTemp;
3008  08d4 cf0055        	ldw	_TURNAD,x
3009                     ; 912                       if ((adResultTemp > TL_OPEN_VALUE)||( adResultTemp < turnshortad ))
3011  08d7 a303e9        	cpw	x,#1001
3012  08da 2405          	jruge	L5541
3014  08dc c30053        	cpw	x,_turnshortad
3015  08df 240b          	jruge	L3541
3016  08e1               L5541:
3017                     ; 914                                if ( TurnLtime1 < (turnTL+5) )TurnLtime1++ ;                    
3019  08e1 ce0013        	ldw	x,L1231_TurnLtime1
3020  08e4 a30041        	cpw	x,#65
3021  08e7 2414          	jruge	L1541
3024  08e9 5c            	incw	x
3025  08ea 200e          	jpf	LC008
3026  08ec               L3541:
3027                     ; 918                              if(turnok1 < 5) turnok1++;
3029  08ec c6001a        	ld	a,L7231_turnok1
3030  08ef a105          	cp	a,#5
3031  08f1 2406          	jruge	L3641
3034  08f3 725c001a      	inc	L7231_turnok1
3036  08f7 2004          	jra	L1541
3037  08f9               L3641:
3038                     ; 919 				 else  TurnLtime1 = 0;
3040  08f9 5f            	clrw	x
3041  08fa               LC008:
3042  08fa cf0013        	ldw	L1231_TurnLtime1,x
3043  08fd               L1541:
3044                     ; 922 		 if ( TurnLtime1 > turnTL )
3046  08fd ce0013        	ldw	x,L1231_TurnLtime1
3047  0900 a3003d        	cpw	x,#61
3048  0903 250c          	jrult	L7641
3049                     ; 924                     TurnLtime1 = turnTL;
3051  0905 ae003c        	ldw	x,#60
3052  0908 cf0013        	ldw	L1231_TurnLtime1,x
3053                     ; 925                     TurnLampState = TLL_IS_OPEN;
3055  090b 3502005f      	mov	_TurnLampState,#2
3057  090f 200a          	jra	L3741
3058  0911               L7641:
3059                     ; 931                     TurnLampState = 0;
3061  0911 725f005f      	clr	_TurnLampState
3062  0915 2004          	jra	L3741
3063  0917               L5441:
3064                     ; 938                turnlt=0;
3066  0917 725f0017      	clr	L5231_turnlt
3067  091b               L3741:
3068                     ; 943 	if(TurnLampDrv &  TurnLampRightOn)
3070  091b 7203006a66    	btjf	_TurnLampDrv,#1,L5741
3071                     ; 945 	       TURN_AD_RIGHT_EN;
3073  0920 721e5019      	bset	20505,#7
3074                     ; 946              adResultTemp = GetADCresultAverage(3);
3076  0924 a603          	ld	a,#3
3077  0926 8d000000      	callf	f_GetADCresultAverage
3079  092a 1f01          	ldw	(OFST-1,sp),x
3080                     ; 949              TURNAD =  adResultTemp;
3082  092c cf0055        	ldw	_TURNAD,x
3083                     ; 951              if(turnrt < turntlcnt) turnrt++;
3085  092f c60018        	ld	a,L3231_turnrt
3086  0932 a10f          	cp	a,#15
3087  0934 2406          	jruge	L7741
3090  0936 725c0018      	inc	L3231_turnrt
3092  093a 2029          	jra	L1051
3093  093c               L7741:
3094                     ; 955                   TURNAD =  adResultTemp;
3096  093c cf0055        	ldw	_TURNAD,x
3097                     ; 956                   if ((adResultTemp > TL_OPEN_VALUE)||( adResultTemp < turnshortad ))
3099  093f a303e9        	cpw	x,#1001
3100  0942 2405          	jruge	L5051
3102  0944 c30053        	cpw	x,_turnshortad
3103  0947 240b          	jruge	L3051
3104  0949               L5051:
3105                     ; 958                          if ( TurnRtime1 < (turnTL+5) )TurnRtime1++ ;                      
3107  0949 ce0015        	ldw	x,L7131_TurnRtime1
3108  094c a30041        	cpw	x,#65
3109  094f 2414          	jruge	L1051
3112  0951 5c            	incw	x
3113  0952 200e          	jpf	LC009
3114  0954               L3051:
3115                     ; 962                               if(turnok2 < 5) turnok2++;
3117  0954 c60019        	ld	a,L1331_turnok2
3118  0957 a105          	cp	a,#5
3119  0959 2406          	jruge	L3151
3122  095b 725c0019      	inc	L1331_turnok2
3124  095f 2004          	jra	L1051
3125  0961               L3151:
3126                     ; 963 				 else  TurnRtime1 = 0;
3128  0961 5f            	clrw	x
3129  0962               LC009:
3130  0962 cf0015        	ldw	L7131_TurnRtime1,x
3131  0965               L1051:
3132                     ; 967               if ( TurnRtime1 > turnTL )
3134  0965 ce0015        	ldw	x,L7131_TurnRtime1
3135  0968 a3003d        	cpw	x,#61
3136  096b 2513          	jrult	L7151
3137                     ; 969                       TurnRtime1 = turnTL ;
3139  096d ae003c        	ldw	x,#60
3140  0970 cf0015        	ldw	L7131_TurnRtime1,x
3141                     ; 970                       TurnLampState = TLR_IS_OPEN;
3143  0973 3508005f      	mov	_TurnLampState,#8
3144                     ; 972                       WriteDTC(0x9003) ; //error
3146  0977 ae9003        	ldw	x,#36867
3147  097a 8d000000      	callf	f_WriteDTC
3150  097e 200a          	jra	L3251
3151  0980               L7151:
3152                     ; 976                       TurnLampState = 0;
3154  0980 725f005f      	clr	_TurnLampState
3155  0984 2004          	jra	L3251
3156  0986               L5741:
3157                     ; 983               turnrt=0;
3159  0986 725f0018      	clr	L3231_turnrt
3160  098a               L3251:
3161                     ; 986 }
3164  098a 85            	popw	x
3165  098b 87            	retf	
3167                     	switch	.bss
3168  001b               L1351_turnnumber:
3169  001b 00            	ds.b	1
3170  001c               L7251_turnadd:
3171  001c 00000000      	ds.b	4
3172  0020               L5251_turnaddd:
3173  0020 000000000000  	ds.b	40
3235                     ; 989 void turnbd(unsigned int turnad)
3235                     ; 990 {
3236                     	switch	.text
3237  098c               f_turnbd:
3239  098c 89            	pushw	x
3240  098d 88            	push	a
3241       00000001      OFST:	set	1
3244                     ; 995 	if(turnnumber < 20)turnnumber++;
3246  098e c6001b        	ld	a,L1351_turnnumber
3247  0991 a114          	cp	a,#20
3248  0993 2407          	jruge	L1651
3251  0995 725c001b      	inc	L1351_turnnumber
3252  0999 c6001b        	ld	a,L1351_turnnumber
3253  099c               L1651:
3254                     ; 997     turnaddd[turnnumber] = turnad;
3256  099c 5f            	clrw	x
3257  099d 97            	ld	xl,a
3258  099e 58            	sllw	x
3259  099f 1602          	ldw	y,(OFST+1,sp)
3260  09a1 df0020        	ldw	(L5251_turnaddd,x),y
3261                     ; 999 	for(turnnumber1= 0;turnnumber1<16;turnnumber1++)
3263  09a4 0f01          	clr	(OFST+0,sp)
3264  09a6               L3651:
3265                     ; 1001 	    turnadd += turnaddd[turnnumber];
3267  09a6 c6001b        	ld	a,L1351_turnnumber
3268  09a9 5f            	clrw	x
3269  09aa 97            	ld	xl,a
3270  09ab 58            	sllw	x
3271  09ac de0020        	ldw	x,(L5251_turnaddd,x)
3272  09af 8d000000      	callf	d_uitolx
3274  09b3 ae001c        	ldw	x,#L7251_turnadd
3275  09b6 8d000000      	callf	d_lgadd
3277                     ; 999 	for(turnnumber1= 0;turnnumber1<16;turnnumber1++)
3279  09ba 0c01          	inc	(OFST+0,sp)
3282  09bc 7b01          	ld	a,(OFST+0,sp)
3283  09be a110          	cp	a,#16
3284  09c0 25e4          	jrult	L3651
3285                     ; 1004 	turnaverad = turnadd>>4;
3287  09c2 8d000000      	callf	d_ltor
3289  09c6 a604          	ld	a,#4
3290  09c8 8d000000      	callf	d_lursh
3292  09cc be02          	ldw	x,c_lreg+2
3293  09ce cf0051        	ldw	_turnaverad,x
3294                     ; 1007 }
3297  09d1 5b03          	addw	sp,#3
3298  09d3 87            	retf	
3300                     	switch	.bss
3301  0048               L5751_tempFlag:
3302  0048 00            	ds.b	1
3303  0049               L1751_FINDDRIVERTIME:
3304  0049 0000          	ds.b	2
3345                     ; 1024 void FindCar(void)
3345                     ; 1025 {
3346                     	switch	.text
3347  09d4               f_FindCar:
3351                     ; 1030     if (FindCarFlag == TRUE)
3353  09d4 c60000        	ld	a,_FindCarFlag
3354  09d7 a101          	cp	a,#1
3355  09d9 2638          	jrne	L5161
3356                     ; 1033         FINDDRIVERTIME++;
3358  09db ce0049        	ldw	x,L1751_FINDDRIVERTIME
3359  09de 5c            	incw	x
3360  09df cf0049        	ldw	L1751_FINDDRIVERTIME,x
3361                     ; 1034         if(FINDDRIVERTIME == 1) TurnFlashCnt = 35;
3363  09e2 a30001        	cpw	x,#1
3364  09e5 2609          	jrne	L7161
3367  09e7 ae0023        	ldw	x,#35
3368  09ea cf006d        	ldw	_TurnFlashCnt,x
3369  09ed ce0049        	ldw	x,L1751_FINDDRIVERTIME
3370  09f0               L7161:
3371                     ; 1037         if (FINDDRIVERTIME <= 16)		{ HORN_ON;  tempFlag |= findCarHornOn;}	//250ms
3373  09f0 a30011        	cpw	x,#17
3377  09f3 250a          	jrult	LC011
3378                     ; 1038         else if (FINDDRIVERTIME <= 32)	{ HORN_OFF; tempFlag &= findCarHornOff;}
3380  09f5 a30021        	cpw	x,#33
3384  09f8 250f          	jrult	L1361
3385                     ; 1039         else if (FINDDRIVERTIME <= 48)	{ HORN_ON;  tempFlag |= findCarHornOn;}
3387  09fa a30031        	cpw	x,#49
3388  09fd 240a          	jruge	L1361
3393  09ff               LC011:
3395  09ff 7210500f      	bset	20495,#0
3397  0a03 72120048      	bset	L5751_tempFlag,#1
3399  0a07 2021          	jra	L5361
3400  0a09               L1361:
3401                     ; 1040   	 else { HORN_OFF; tempFlag &= findCarHornOff;}
3406  0a09 7211500f      	bres	20495,#0
3408  0a0d 72130048      	bres	L5751_tempFlag,#1
3409  0a11 2017          	jra	L5361
3410  0a13               L5161:
3411                     ; 1045 		if (tempFlag & findCarHornOn)	
3413  0a13 7203004808    	btjf	L5751_tempFlag,#1,L7361
3414                     ; 1047 			HORN_OFF; 
3416  0a18 7211500f      	bres	20495,#0
3417                     ; 1048 			tempFlag &= findCarHornOff;
3419  0a1c 72130048      	bres	L5751_tempFlag,#1
3420  0a20               L7361:
3421                     ; 1051              if(FindCarFlag == TRUE)FindCarFlag = FALSE;
3423  0a20 4a            	dec	a
3424  0a21 2603          	jrne	L1461
3427  0a23 c70000        	ld	_FindCarFlag,a
3428  0a26               L1461:
3429                     ; 1052              FINDDRIVERTIME = 0x00;
3431  0a26 5f            	clrw	x
3432  0a27 cf0049        	ldw	L1751_FINDDRIVERTIME,x
3433  0a2a               L5361:
3434                     ; 1055 	if (DoorState!=0) //&& (KeyInState == KeyIsOutHole))
3436  0a2a c60000        	ld	a,_DoorState
3437  0a2d 270d          	jreq	L3461
3438                     ; 1057 		if(FindCarFlag == TRUE)  //20120308
3440  0a2f c60000        	ld	a,_FindCarFlag
3441  0a32 4a            	dec	a
3442  0a33 2607          	jrne	L3461
3443                     ; 1059 			FindCarFlag = FALSE;
3445  0a35 c70000        	ld	_FindCarFlag,a
3446                     ; 1061 		      TurnFlashCnt = 0;
3448  0a38 5f            	clrw	x
3449  0a39 cf006d        	ldw	_TurnFlashCnt,x
3450  0a3c               L3461:
3451                     ; 1064 	if(IGNstate==ON)
3453  0a3c c60000        	ld	a,_IGNstate
3454  0a3f a155          	cp	a,#85
3455  0a41 260d          	jrne	L7461
3456                     ; 1066 		if(FindCarFlag == TRUE)  //20120308
3458  0a43 c60000        	ld	a,_FindCarFlag
3459  0a46 4a            	dec	a
3460  0a47 2607          	jrne	L7461
3461                     ; 1068 			FindCarFlag = FALSE;
3463  0a49 c70000        	ld	_FindCarFlag,a
3464                     ; 1070 			TurnFlashCnt = 0;
3466  0a4c 5f            	clrw	x
3467  0a4d cf006d        	ldw	_TurnFlashCnt,x
3468  0a50               L7461:
3469                     ; 1075 }
3472  0a50 87            	retf	
3474                     	switch	.bss
3475  004b               L3561_ptime:
3476  004b 0000          	ds.b	2
3477  004d               L7561_Leddrvom:
3478  004d 00            	ds.b	1
3479  004e               L5561_ptime1:
3480  004e 0000          	ds.b	2
3526                     ; 1086 void SFLED(void)
3526                     ; 1087 {    
3527                     	switch	.text
3528  0a51               f_SFLED:
3532                     ; 1090        if( Alarm_Actiated == 0x55 )
3534  0a51 c60000        	ld	a,_Alarm_Actiated
3535  0a54 a155          	cp	a,#85
3536  0a56 2606          	jrne	L1071
3537                     ; 1092               Leddrvom = 1;
3539  0a58 3501004d      	mov	L7561_Leddrvom,#1
3541  0a5c 2017          	jra	L3071
3542  0a5e               L1071:
3543                     ; 1094 	else if( BCMtoGEM_AlarmStatus == Armed )
3545  0a5e c60000        	ld	a,_BCMtoGEM_AlarmStatus
3546  0a61 a110          	cp	a,#16
3547  0a63 260c          	jrne	L5071
3548                     ; 1096 	       if(Leddrvom != 1)Leddrvom = 2;   //new  20090903
3550  0a65 c6004d        	ld	a,L7561_Leddrvom
3551  0a68 4a            	dec	a
3552  0a69 270a          	jreq	L3071
3555  0a6b 3502004d      	mov	L7561_Leddrvom,#2
3556  0a6f 2004          	jra	L3071
3557  0a71               L5071:
3558                     ; 1100            Leddrvom = 0;
3560  0a71 725f004d      	clr	L7561_Leddrvom
3561  0a75               L3071:
3562                     ; 1103 	if(BCMtoGEM_AlarmStatus == prearmed) 
3564  0a75 c60000        	ld	a,_BCMtoGEM_AlarmStatus
3565  0a78 a108          	cp	a,#8
3566  0a7a 2605          	jrne	L3171
3567                     ; 1105            IMMO_LED_ON;
3569  0a7c 721c501e      	bset	20510,#6
3570                     ; 1106 	     return;
3573  0a80 87            	retf	
3574  0a81               L3171:
3575                     ; 1108     if(Leddrvom == 1)//( Warningstate == 1 )
3577  0a81 c6004d        	ld	a,L7561_Leddrvom
3578  0a84 a101          	cp	a,#1
3579  0a86 262a          	jrne	L5171
3580                     ; 1110         ptime++;
3582  0a88 ce004b        	ldw	x,L3561_ptime
3583  0a8b 5c            	incw	x
3584  0a8c cf004b        	ldw	L3561_ptime,x
3585                     ; 1111         if( ptime < 13 )
3587  0a8f a3000d        	cpw	x,#13
3588  0a92 2405          	jruge	L7171
3589                     ; 1113             IMMO_LED_ON;
3591  0a94 721c501e      	bset	20510,#6
3594  0a98 87            	retf	
3595  0a99               L7171:
3596                     ; 1115 		else if(ptime < 25 )
3598  0a99 a30019        	cpw	x,#25
3599                     ; 1117             IMMO_LED_OFF;
3601  0a9c 253a          	jrult	LC012
3602                     ; 1119 		else if(ptime < 38 )
3604  0a9e a30026        	cpw	x,#38
3605  0aa1 2405          	jruge	L7271
3606                     ; 1121             IMMO_LED_ON;
3608  0aa3 721c501e      	bset	20510,#6
3611  0aa7 87            	retf	
3612  0aa8               L7271:
3613                     ; 1123         else if( ptime < 125 )
3615  0aa8 a3007d        	cpw	x,#125
3616                     ; 1125             IMMO_LED_OFF;
3618  0aab 252b          	jrult	LC012
3619                     ; 1129             ptime = 0 ;
3621  0aad 5f            	clrw	x
3622  0aae cf004b        	ldw	L3561_ptime,x
3624  0ab1 87            	retf	
3625  0ab2               L5171:
3626                     ; 1132     else if(Leddrvom == 2)//( BCMtoGEM_AlarmStatus == Armed )
3628  0ab2 a102          	cp	a,#2
3629  0ab4 261b          	jrne	L1471
3630                     ; 1134         ptime1++;
3632  0ab6 ce004e        	ldw	x,L5561_ptime1
3633  0ab9 5c            	incw	x
3634  0aba cf004e        	ldw	L5561_ptime1,x
3635                     ; 1135         if( ptime1< 13 )
3637  0abd a3000d        	cpw	x,#13
3638  0ac0 2405          	jruge	L3471
3639                     ; 1137             IMMO_LED_ON;
3641  0ac2 721c501e      	bset	20510,#6
3644  0ac6 87            	retf	
3645  0ac7               L3471:
3646                     ; 1139         else if( ptime1< 125 )
3648  0ac7 a3007d        	cpw	x,#125
3649                     ; 1141             IMMO_LED_OFF;
3651  0aca 250c          	jrult	LC012
3652                     ; 1145             ptime1= 0 ;
3654  0acc 5f            	clrw	x
3655  0acd cf004e        	ldw	L5561_ptime1,x
3657  0ad0 87            	retf	
3658  0ad1               L1471:
3659                     ; 1151          ptime= 0;
3661  0ad1 5f            	clrw	x
3662  0ad2 cf004b        	ldw	L3561_ptime,x
3663                     ; 1152 		 ptime1= 0;
3665  0ad5 cf004e        	ldw	L5561_ptime1,x
3666                     ; 1153 		 IMMO_LED_OFF;
3668  0ad8               LC012:
3672  0ad8 721d501e      	bres	20510,#6
3673                     ; 1155 }
3676  0adc 87            	retf	
3678                     	switch	.bss
3679  0050               L5571_turnproid:
3680  0050 00            	ds.b	1
3714                     ; 1159 void Turnvcclow(void)
3714                     ; 1160 {
3715                     	switch	.text
3716  0add               f_Turnvcclow:
3720                     ; 1162   if(RKEBatteryVoltageturnstate != 0)
3722  0add c60000        	ld	a,_RKEBatteryVoltageturnstate
3723  0ae0 2769          	jreq	L3771
3724                     ; 1164             if(IGNstate == OFF)
3726  0ae2 c60000        	ld	a,_IGNstate
3727  0ae5 2658          	jrne	L5771
3728                     ; 1166                   if(++turnproid < 21){TURN_LEFT_LAMP_ON;  TURN_RIGHT_LAMP_ON; CAN_TURNRightSW_ON;CAN_TURNLeftSW_ON;}
3730  0ae7 725c0050      	inc	L5571_turnproid
3731  0aeb c60050        	ld	a,L5571_turnproid
3732  0aee a115          	cp	a,#21
3733  0af0 2411          	jruge	L7771
3736  0af2 72185019      	bset	20505,#4
3739  0af6 721a5019      	bset	20505,#5
3742  0afa 72180001      	bset	_CanSendData+1,#4
3745  0afe 721c0001      	bset	_CanSendData+1,#6
3748  0b02 87            	retf	
3749  0b03               L7771:
3750                     ; 1167                   else if(++turnproid < 47){TURN_LEFT_LAMP_OFF;TURN_RIGHT_LAMP_OFF;CAN_TURNRightSW_OFF;CAN_TURNLeftSW_OFF;}
3752  0b03 725c0050      	inc	L5571_turnproid
3753  0b07 c60050        	ld	a,L5571_turnproid
3754  0b0a a12f          	cp	a,#47
3755  0b0c 2419          	jruge	L3002
3758  0b0e 72195019      	bres	20505,#4
3761  0b12 721b5019      	bres	20505,#5
3764  0b16 c60001        	ld	a,_CanSendData+1
3765  0b19 a4cf          	and	a,#207
3766  0b1b c70001        	ld	_CanSendData+1,a
3769  0b1e c60001        	ld	a,_CanSendData+1
3770  0b21 a43f          	and	a,#63
3771  0b23 c70001        	ld	_CanSendData+1,a
3774  0b26 87            	retf	
3775  0b27               L3002:
3776                     ; 1170                          turnproid=0;
3778  0b27 725f0050      	clr	L5571_turnproid
3779                     ; 1171                          RKEBatteryVoltage_turn++;
3781  0b2b 725c0000      	inc	_RKEBatteryVoltage_turn
3782                     ; 1172                          if(RKEBatteryVoltage_turn > 9)
3784  0b2f c60000        	ld	a,_RKEBatteryVoltage_turn
3785  0b32 a10a          	cp	a,#10
3786  0b34 2515          	jrult	L3771
3787                     ; 1175                                RKEBatteryVoltage_turn=0;
3789  0b36 725f0000      	clr	_RKEBatteryVoltage_turn
3790                     ; 1176                                RKEBatteryVoltageturnstate = 0;
3792  0b3a 725f0000      	clr	_RKEBatteryVoltageturnstate
3794  0b3e 87            	retf	
3795  0b3f               L5771:
3796                     ; 1183                    RKEBatteryVoltage_turn =0;
3798  0b3f 725f0000      	clr	_RKEBatteryVoltage_turn
3799                     ; 1184 	               RKEBatteryVoltageturnstate = 0;
3801  0b43 725f0000      	clr	_RKEBatteryVoltageturnstate
3802                     ; 1185                    turnproid=0;
3804  0b47 725f0050      	clr	L5571_turnproid
3805  0b4b               L3771:
3806                     ; 1190 }
3809  0b4b 87            	retf	
4001                     	switch	.bss
4002  0051               _turnaverad:
4003  0051 0000          	ds.b	2
4004                     	xdef	_turnaverad
4005  0053               _turnshortad:
4006  0053 0000          	ds.b	2
4007                     	xdef	_turnshortad
4008                     	xdef	f_ScanHazzardKeys
4009  0055               _TURNAD:
4010  0055 0000          	ds.b	2
4011                     	xdef	_TURNAD
4012                     	xref	_DIDF1f2EEPROM
4013  0057               _TurnState_Number:
4014  0057 00            	ds.b	1
4015                     	xdef	_TurnState_Number
4016  0058               _Turn_L_CH_State:
4017  0058 00            	ds.b	1
4018                     	xdef	_Turn_L_CH_State
4019  0059               _Turn_R_CH_State:
4020  0059 00            	ds.b	1
4021                     	xdef	_Turn_R_CH_State
4022  005a               _TL_PERIOD:
4023  005a 00            	ds.b	1
4024                     	xdef	_TL_PERIOD
4025  005b               _TL_DUTY:
4026  005b 00            	ds.b	1
4027                     	xdef	_TL_DUTY
4028  005c               _TLSwitchRoadwayFlashCnt:
4029  005c 00            	ds.b	1
4030                     	xdef	_TLSwitchRoadwayFlashCnt
4031  005d               _TurnLampCScmd:
4032  005d 00            	ds.b	1
4033                     	xdef	_TurnLampCScmd
4034  005e               _TurnLampOnCnt:
4035  005e 00            	ds.b	1
4036                     	xdef	_TurnLampOnCnt
4037                     	xref	_StandByState
4038                     	xref	_CarHornstate
4039                     	xref	f_WriteDTC
4040                     	xref	_Configuration
4041                     	xref	_battervalue
4042                     	xref	_CAN_FORTIFY_state
4043                     	xref	_CanSendData
4044                     	xref	_FORTIFYSW_state
4045                     	xref	_CarState
4046                     	xref	_Alarm_Actiated
4047                     	xref	_DoorWarmState
4048                     	xref	_TRUNKWarmstate
4049                     	xref	_Alarmstatus_RKE
4050                     	xref	_BCMtoGEM_AlarmStatus
4051                     	xref	_CrashState
4052                     	xref	f_GetADCresultAverage
4053                     	xref	_RKEBatteryVoltageturnstate
4054                     	xref	_FindCarFlag
4055                     	xref	_IGNstate
4056                     	xdef	f_turnbd
4057                     	xdef	f_Turnvcclow
4058                     	xdef	f_SFLED
4059                     	xdef	f_ScanTurnLampState
4060                     	xdef	f_ScanStandByHazzardKeys
4061                     	xdef	f_JudgeTurnLampDrv
4062                     	xdef	f_ScanTurnLampKeys
4063                     	xdef	f_FindCar
4064  005f               _TurnLampState:
4065  005f 00            	ds.b	1
4066                     	xdef	_TurnLampState
4067  0060               _BrakeSpeedHazards_state:
4068  0060 00            	ds.b	1
4069                     	xdef	_BrakeSpeedHazards_state
4070                     	xref	_RKEBatteryVoltage_turn
4071  0061               _WarningTimeCnt:
4072  0061 0000          	ds.b	2
4073                     	xdef	_WarningTimeCnt
4074  0063               _Crash_state_Y:
4075  0063 00            	ds.b	1
4076                     	xdef	_Crash_state_Y
4077  0064               _HazzardState:
4078  0064 00            	ds.b	1
4079                     	xdef	_HazzardState
4080  0065               _Warningstate:
4081  0065 00            	ds.b	1
4082                     	xdef	_Warningstate
4083  0066               _Turn_L_State:
4084  0066 00            	ds.b	1
4085                     	xdef	_Turn_L_State
4086  0067               _Turn_R_State:
4087  0067 00            	ds.b	1
4088                     	xdef	_Turn_R_State
4089                     	xref	_DoorState
4090  0068               _TurnLamp_CrashKeepTime:
4091  0068 0000          	ds.b	2
4092                     	xdef	_TurnLamp_CrashKeepTime
4093  006a               _TurnLampDrv:
4094  006a 00            	ds.b	1
4095                     	xdef	_TurnLampDrv
4096  006b               _ledcnt:
4097  006b 0000          	ds.b	2
4098                     	xdef	_ledcnt
4099  006d               _TurnFlashCnt:
4100  006d 0000          	ds.b	2
4101                     	xdef	_TurnFlashCnt
4102                     	xdef	_turnfindcarstate
4103                     	xref.b	c_lreg
4104                     	xref.b	c_x
4124                     	xref	d_lursh
4125                     	xref	d_ltor
4126                     	xref	d_lgadd
4127                     	xref	d_lcmp
4128                     	xref	d_uitolx
4129                     	xref	d_lgsbc
4130                     	xref	d_lzmp
4131                     	end
