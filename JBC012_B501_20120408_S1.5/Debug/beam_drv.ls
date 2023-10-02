   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 776                     	switch	.bss
 777  0000               L144_pLowCnt:
 778  0000 00            	ds.b	1
 779  0001               L734_uLowCnt:
 780  0001 00            	ds.b	1
 781  0002               L534_pHighCnt:
 782  0002 00            	ds.b	1
 783  0003               L334_uHighCnt:
 784  0003 00            	ds.b	1
 846                     ; 51 void ScanHighLowBeamSwitch(void)
 846                     ; 52 {
 847                     	switch	.text
 848  0000               f_ScanHighLowBeamSwitch:
 852                     ; 57 	if (!HIGH_BEAM_SW)
 854  0000 720050291f    	btjt	20521,#0,L374
 855                     ; 59 		uHighCnt = 0;
 857  0005 725f0003      	clr	L334_uHighCnt
 858                     ; 60 		if (pHighCnt < KEY_FILTER_CNT)
 860  0009 c60002        	ld	a,L534_pHighCnt
 861  000c a105          	cp	a,#5
 862  000e 2406          	jruge	L574
 863                     ; 62 			pHighCnt++;
 865  0010 725c0002      	inc	L534_pHighCnt
 867  0014 202b          	jra	L305
 868  0016               L574:
 869                     ; 64 		else if (pHighCnt == KEY_FILTER_CNT)
 871  0016 a105          	cp	a,#5
 872  0018 2627          	jrne	L305
 873                     ; 66 			pHighCnt++;
 875  001a 725c0002      	inc	L534_pHighCnt
 876                     ; 67 			HighBeamSwitchState = Pressed;
 878  001e 3555000c      	mov	_HighBeamSwitchState,#85
 879  0022 201d          	jra	L305
 880  0024               L374:
 881                     ; 72 		pHighCnt = 0;
 883  0024 725f0002      	clr	L534_pHighCnt
 884                     ; 73 		if (uHighCnt < KEY_FILTER_CNT)
 886  0028 c60003        	ld	a,L334_uHighCnt
 887  002b a105          	cp	a,#5
 888  002d 2406          	jruge	L505
 889                     ; 75 			uHighCnt++;
 891  002f 725c0003      	inc	L334_uHighCnt
 893  0033 200c          	jra	L305
 894  0035               L505:
 895                     ; 77 		else if (uHighCnt == KEY_FILTER_CNT)
 897  0035 a105          	cp	a,#5
 898  0037 2608          	jrne	L305
 899                     ; 79 			uHighCnt++;
 901  0039 725c0003      	inc	L334_uHighCnt
 902                     ; 80 			HighBeamSwitchState = Unpressed;
 904  003d 725f000c      	clr	_HighBeamSwitchState
 905  0041               L305:
 906                     ; 85 	if (!LOW_BEAM_SW)
 908  0041 720450291d    	btjt	20521,#2,L315
 909                     ; 88 		uLowCnt = 0;
 911  0046 725f0001      	clr	L734_uLowCnt
 912                     ; 89 		if (pLowCnt < KEY_FILTER_CNT)
 914  004a c60000        	ld	a,L144_pLowCnt
 915  004d a105          	cp	a,#5
 916  004f 2405          	jruge	L515
 917                     ; 91 			pLowCnt++;
 919  0051 725c0000      	inc	L144_pLowCnt
 922  0055 87            	retf	
 923  0056               L515:
 924                     ; 93 		else if (pLowCnt == KEY_FILTER_CNT)
 926  0056 a105          	cp	a,#5
 927  0058 2625          	jrne	L325
 928                     ; 95 			pLowCnt++;
 930  005a 725c0000      	inc	L144_pLowCnt
 931                     ; 96 			LowBeamSwitchState = Pressed;
 933  005e 3555000b      	mov	_LowBeamSwitchState,#85
 935  0062 87            	retf	
 936  0063               L315:
 937                     ; 101 		pLowCnt = 0;
 939  0063 725f0000      	clr	L144_pLowCnt
 940                     ; 102 		if (uLowCnt < KEY_FILTER_CNT)
 942  0067 c60001        	ld	a,L734_uLowCnt
 943  006a a105          	cp	a,#5
 944  006c 2405          	jruge	L525
 945                     ; 104 			uLowCnt++;
 947  006e 725c0001      	inc	L734_uLowCnt
 950  0072 87            	retf	
 951  0073               L525:
 952                     ; 106 		else if (uLowCnt == KEY_FILTER_CNT)
 954  0073 a105          	cp	a,#5
 955  0075 2608          	jrne	L325
 956                     ; 108 			uLowCnt++;
 958  0077 725c0001      	inc	L734_uLowCnt
 959                     ; 109 			LowBeamSwitchState = Unpressed;
 961  007b 725f000b      	clr	_LowBeamSwitchState
 962  007f               L325:
 963                     ; 112 } 
 966  007f 87            	retf	
 968                     	switch	.bss
 969  0004               L535_GoHomeNumber:
 970  0004 00            	ds.b	1
 971  0005               L335_LowBeamGoHomeCnt:
 972  0005 0000          	ds.b	2
 973  0007               L545_Gohomestate:
 974  0007 00            	ds.b	1
 975  0008               L735_GoHomeTime:
 976  0008 00            	ds.b	1
1034                     ; 127 void JudgeLowBeamDriver(void)
1034                     ; 128 {
1035                     	switch	.text
1036  0080               f_JudgeLowBeamDriver:
1040                     ; 138         if ((IGNstate == ON) && (LowBeamSwitchState == Pressed)) //&& (HighBeamSwitchState	==Unpressed))
1042  0080 c60000        	ld	a,_IGNstate
1043  0083 a155          	cp	a,#85
1044  0085 260f          	jrne	L175
1046  0087 c6000b        	ld	a,_LowBeamSwitchState
1047  008a a155          	cp	a,#85
1048  008c 2608          	jrne	L175
1049                     ; 140             LOW_BEAM_LAMP_ON;
1051  008e 7216500a      	bset	20490,#3
1052                     ; 142             LOWBeamDriverState = 1 ;
1054  0092 35010009      	mov	_LOWBeamDriverState,#1
1055  0096               L175:
1056                     ; 144         if((IGNstate == ON) && (LowBeamSwitchState == Pressed) && (HighBeamSwitchState	==  Pressed))
1058  0096 c60000        	ld	a,_IGNstate
1059  0099 a155          	cp	a,#85
1060  009b 261a          	jrne	L375
1062  009d c6000b        	ld	a,_LowBeamSwitchState
1063  00a0 a155          	cp	a,#85
1064  00a2 2613          	jrne	L375
1066  00a4 c6000c        	ld	a,_HighBeamSwitchState
1067  00a7 a155          	cp	a,#85
1068  00a9 260c          	jrne	L375
1069                     ; 146             HIGH_BEAM_ON;
1071  00ab 721a5023      	bset	20515,#5
1072                     ; 147             LOW_BEAM_LAMP_ON;
1074  00af 7216500a      	bset	20490,#3
1075                     ; 148             LOWBeamDriverState = 1;
1077  00b3 35010009      	mov	_LOWBeamDriverState,#1
1078  00b7               L375:
1079                     ; 150         if((IGNstate == ON) &&((SmallLampSwitchState == Unpressed)|| (HighBeamSwitchState	==  Unpressed)))
1081  00b7 c60000        	ld	a,_IGNstate
1082  00ba a155          	cp	a,#85
1083  00bc 2614          	jrne	L575
1085  00be 725d0000      	tnz	_SmallLampSwitchState
1086  00c2 2706          	jreq	L775
1088  00c4 725d000c      	tnz	_HighBeamSwitchState
1089  00c8 2608          	jrne	L575
1090  00ca               L775:
1091                     ; 152             HIGH_BEAM_OFF;
1093  00ca 721b5023      	bres	20515,#5
1094                     ; 154             LOWBeamDriverState = 0 ;
1096  00ce 725f0009      	clr	_LOWBeamDriverState
1097  00d2               L575:
1098                     ; 156         if ((IGNstate == ON) && (LowBeamSwitchState == Unpressed)) //&& (HighBeamSwitchState	==Unpressed))
1100  00d2 a155          	cp	a,#85
1101  00d4 2610          	jrne	L106
1103  00d6 c6000b        	ld	a,_LowBeamSwitchState
1104  00d9 260b          	jrne	L106
1105                     ; 158             LOW_BEAM_LAMP_OFF;
1107  00db 7217500a      	bres	20490,#3
1108                     ; 159 			 HIGH_BEAM_OFF;  //20090521  更改关近光灯同时关闭远光灯
1110  00df 721b5023      	bres	20515,#5
1111                     ; 161             LOWBeamDriverState = 0 ;
1113  00e3 c70009        	ld	_LOWBeamDriverState,a
1114  00e6               L106:
1115                     ; 163         if((LowBeamGoHomeCnt == 0) && (IGNstate == OFF))
1117  00e6 ce0005        	ldw	x,L335_LowBeamGoHomeCnt
1118  00e9 260d          	jrne	L306
1120  00eb c60000        	ld	a,_IGNstate
1121  00ee 2608          	jrne	L306
1122                     ; 165             HIGH_BEAM_OFF;
1124  00f0 721b5023      	bres	20515,#5
1125                     ; 166             LOW_BEAM_LAMP_OFF;
1127  00f4 7217500a      	bres	20490,#3
1128  00f8               L306:
1129                     ; 171 	if(GoHomeNumber!=0)
1131  00f8 c60004        	ld	a,L535_GoHomeNumber
1132  00fb 271a          	jreq	L506
1133                     ; 173 	     if(GoHomeNumber !=5)
1135  00fd a105          	cp	a,#5
1136  00ff 2704          	jreq	L706
1137                     ; 175              GoHomeTime++;
1139  0101 725c0008      	inc	L735_GoHomeTime
1140  0105               L706:
1141                     ; 177             if((GoHomeTime>250)&&(GoHomeNumber!=5))
1143  0105 c60008        	ld	a,L735_GoHomeTime
1144  0108 a1fb          	cp	a,#251
1145  010a 250b          	jrult	L506
1147  010c c60004        	ld	a,L535_GoHomeNumber
1148  010f a105          	cp	a,#5
1149  0111 2704          	jreq	L506
1150                     ; 179                 GoHomeNumber=0;
1152  0113 725f0004      	clr	L535_GoHomeNumber
1153  0117               L506:
1154                     ; 183     if ((IGNstate == OFF) && (LowBeamSwitchState == Unpressed) && (SmallLampSwitchState ==Unpressed)&&(GoHomeNumber==0))
1156  0117 c60000        	ld	a,_IGNstate
1157  011a 2613          	jrne	L316
1159  011c c6000b        	ld	a,_LowBeamSwitchState
1160  011f 260e          	jrne	L316
1162  0121 c60000        	ld	a,_SmallLampSwitchState
1163  0124 2609          	jrne	L316
1165  0126 c60004        	ld	a,L535_GoHomeNumber
1166  0129 2604          	jrne	L316
1167                     ; 185         GoHomeNumber=1;
1169  012b 4c            	inc	a
1170  012c c70004        	ld	L535_GoHomeNumber,a
1171  012f               L316:
1172                     ; 187     if(GoHomeNumber==1)
1174  012f c60004        	ld	a,L535_GoHomeNumber
1175  0132 4a            	dec	a
1176  0133 2615          	jrne	L516
1177                     ; 189         if ((IGNstate == OFF) && (LowBeamSwitchState == Unpressed) && (SmallLampSwitchState ==Pressed))
1179  0135 c60000        	ld	a,_IGNstate
1180  0138 2610          	jrne	L516
1182  013a c6000b        	ld	a,_LowBeamSwitchState
1183  013d 260b          	jrne	L516
1185  013f c60000        	ld	a,_SmallLampSwitchState
1186  0142 a155          	cp	a,#85
1187  0144 2604          	jrne	L516
1188                     ; 191        	    GoHomeNumber=2;
1190  0146 35020004      	mov	L535_GoHomeNumber,#2
1191  014a               L516:
1192                     ; 194     if(GoHomeNumber==2)
1194  014a c60004        	ld	a,L535_GoHomeNumber
1195  014d a102          	cp	a,#2
1196  014f 2617          	jrne	L126
1197                     ; 196         if ((IGNstate == OFF) && (LowBeamSwitchState == Pressed) && (SmallLampSwitchState ==Pressed))
1199  0151 c60000        	ld	a,_IGNstate
1200  0154 2612          	jrne	L126
1202  0156 c6000b        	ld	a,_LowBeamSwitchState
1203  0159 a155          	cp	a,#85
1204  015b 260b          	jrne	L126
1206  015d c60000        	ld	a,_SmallLampSwitchState
1207  0160 a155          	cp	a,#85
1208  0162 2604          	jrne	L126
1209                     ; 198        	     GoHomeNumber=3;
1211  0164 35030004      	mov	L535_GoHomeNumber,#3
1212  0168               L126:
1213                     ; 201 	if(GoHomeNumber==3)
1215  0168 c60004        	ld	a,L535_GoHomeNumber
1216  016b a103          	cp	a,#3
1217  016d 2615          	jrne	L526
1218                     ; 203             if ((IGNstate == OFF) && (LowBeamSwitchState == Unpressed) && (SmallLampSwitchState == Pressed))
1220  016f c60000        	ld	a,_IGNstate
1221  0172 2610          	jrne	L526
1223  0174 c6000b        	ld	a,_LowBeamSwitchState
1224  0177 260b          	jrne	L526
1226  0179 c60000        	ld	a,_SmallLampSwitchState
1227  017c a155          	cp	a,#85
1228  017e 2604          	jrne	L526
1229                     ; 205                 GoHomeNumber=4;
1231  0180 35040004      	mov	L535_GoHomeNumber,#4
1232  0184               L526:
1233                     ; 208 	if(GoHomeNumber==4)
1235  0184 c60004        	ld	a,L535_GoHomeNumber
1236  0187 a104          	cp	a,#4
1237  0189 2621          	jrne	L136
1238                     ; 210             if ((IGNstate == OFF) && (LowBeamSwitchState == Unpressed) && (SmallLampSwitchState ==Unpressed))
1240  018b c60000        	ld	a,_IGNstate
1241  018e 261c          	jrne	L136
1243  0190 c6000b        	ld	a,_LowBeamSwitchState
1244  0193 2617          	jrne	L136
1246  0195 c60000        	ld	a,_SmallLampSwitchState
1247  0198 2612          	jrne	L136
1248                     ; 212        	        GoHomeNumber=5;
1250  019a 35050004      	mov	L535_GoHomeNumber,#5
1251                     ; 213 			    LowBeamGoHomeCnt = 22500;	//22500*8ms=180s
1253  019e ae57e4        	ldw	x,#22500
1254  01a1 cf0005        	ldw	L335_LowBeamGoHomeCnt,x
1255                     ; 214 			    Buzzertime = 125 ;          // 1s 有修改
1257  01a4 357d000a      	mov	_Buzzertime,#125
1258                     ; 215 			    Gohomestate = 0x55 ;
1260  01a8 35550007      	mov	L545_Gohomestate,#85
1261  01ac               L136:
1262                     ; 219       if ((DoorState == AllDoorIsClosed ) && ( Gohomestate == 0x55 ) && (LowBeamGoHomeCnt > 7500))
1264  01ac c60000        	ld	a,_DoorState
1265  01af 2618          	jrne	L536
1267  01b1 c60007        	ld	a,L545_Gohomestate
1268  01b4 a155          	cp	a,#85
1269  01b6 2611          	jrne	L536
1271  01b8 a31d4d        	cpw	x,#7501
1272  01bb 250c          	jrult	L536
1273                     ; 221       	     Gohomestate = 0 ;
1275  01bd 725f0007      	clr	L545_Gohomestate
1276                     ; 222             LowBeamGoHomeCnt = 7500;	//7500*8ms=60s
1278  01c1 ae1d4c        	ldw	x,#7500
1279  01c4 cf0005        	ldw	L335_LowBeamGoHomeCnt,x
1281  01c7 2009          	jra	L736
1282  01c9               L536:
1283                     ; 225       else if ((LowBeamGoHomeCnt <= 7500))
1285  01c9 a31d4d        	cpw	x,#7501
1286  01cc 2404          	jruge	L736
1287                     ; 227              Gohomestate = 0 ;
1289  01ce 725f0007      	clr	L545_Gohomestate
1290  01d2               L736:
1291                     ; 230 	if((GoHomeNumber==5)&&(LowBeamGoHomeCnt!=0)&&(IGNstate == OFF))
1293  01d2 c60004        	ld	a,L535_GoHomeNumber
1294  01d5 a105          	cp	a,#5
1295  01d7 2617          	jrne	L346
1297  01d9 ce0005        	ldw	x,L335_LowBeamGoHomeCnt
1298  01dc 2712          	jreq	L346
1300  01de 725d0000      	tnz	_IGNstate
1301  01e2 260c          	jrne	L346
1302                     ; 232 	     LowBeamGoHomeCnt--;	   
1304  01e4 5a            	decw	x
1305  01e5 cf0005        	ldw	L335_LowBeamGoHomeCnt,x
1306                     ; 233             LOW_BEAM_LAMP_ON;       
1308  01e8 7216500a      	bset	20490,#3
1309                     ; 234             LOWBeamDriverState = 1;
1311  01ec 35010009      	mov	_LOWBeamDriverState,#1
1312  01f0               L346:
1313                     ; 236 	if((GoHomeNumber==5)&&(LowBeamGoHomeCnt!=0)&&(IGNstate == OFF)&&(LowBeamSwitchState == Pressed))
1315  01f0 a105          	cp	a,#5
1316  01f2 261d          	jrne	L546
1318  01f4 ce0005        	ldw	x,L335_LowBeamGoHomeCnt
1319  01f7 2718          	jreq	L546
1321  01f9 c60000        	ld	a,_IGNstate
1322  01fc 2613          	jrne	L546
1324  01fe c6000b        	ld	a,_LowBeamSwitchState
1325  0201 a155          	cp	a,#85
1326  0203 260c          	jrne	L546
1327                     ; 238             LOW_BEAM_LAMP_OFF;    
1329  0205 7217500a      	bres	20490,#3
1330                     ; 239             GoHomeNumber = 0;
1332  0209 725f0004      	clr	L535_GoHomeNumber
1333                     ; 240             LOWBeamDriverState = 0;
1335  020d 725f0009      	clr	_LOWBeamDriverState
1336  0211               L546:
1337                     ; 242        if(((GoHomeNumber==5)&&(LowBeamGoHomeCnt==0)))
1339  0211 c60004        	ld	a,L535_GoHomeNumber
1340  0214 a105          	cp	a,#5
1341  0216 2611          	jrne	L746
1343  0218 ce0005        	ldw	x,L335_LowBeamGoHomeCnt
1344  021b 260c          	jrne	L746
1345                     ; 244             LOW_BEAM_LAMP_OFF; 
1347  021d 7217500a      	bres	20490,#3
1348                     ; 245              GoHomeNumber = 0;
1350  0221 725f0004      	clr	L535_GoHomeNumber
1351                     ; 246             LOWBeamDriverState = 0;
1353  0225 725f0009      	clr	_LOWBeamDriverState
1354  0229               L746:
1355                     ; 248 	if((LowBeamGoHomeCnt != 0)&& ((IGNstate == ON )||(SmallLampSwitchState == Pressed)))  //增加小灯关闭回家条件
1357  0229 ce0005        	ldw	x,L335_LowBeamGoHomeCnt
1358  022c 2716          	jreq	L156
1360  022e c60000        	ld	a,_IGNstate
1361  0231 a155          	cp	a,#85
1362  0233 2707          	jreq	L356
1364  0235 c60000        	ld	a,_SmallLampSwitchState
1365  0238 a155          	cp	a,#85
1366  023a 2608          	jrne	L156
1367  023c               L356:
1368                     ; 250             LOW_BEAM_LAMP_OFF; 
1370  023c 7217500a      	bres	20490,#3
1371                     ; 251             LowBeamGoHomeCnt  = 0 ;
1373  0240 5f            	clrw	x
1374  0241 cf0005        	ldw	L335_LowBeamGoHomeCnt,x
1375  0244               L156:
1376                     ; 254 	if((LowBeamSwitchState == Pressed) ||(SmallLampSwitchState == Pressed))// || (FrontFogLampSwitchState == Pressed) ||(RearFogLampSwitchState == Pressed))20100712取消前后雾灯对回家功能的影响
1378  0244 c6000b        	ld	a,_LowBeamSwitchState
1379  0247 a155          	cp	a,#85
1380  0249 2707          	jreq	L756
1382  024b c60000        	ld	a,_SmallLampSwitchState
1383  024e a155          	cp	a,#85
1384  0250 2604          	jrne	L556
1385  0252               L756:
1386                     ; 256              LowBeamGoHomeCnt  = 0;   //new
1388  0252 5f            	clrw	x
1389  0253 cf0005        	ldw	L335_LowBeamGoHomeCnt,x
1390  0256               L556:
1391                     ; 258 } 
1394  0256 87            	retf	
1437                     	xdef	f_JudgeLowBeamDriver
1438                     	xdef	f_ScanHighLowBeamSwitch
1439                     	switch	.bss
1440  0009               _LOWBeamDriverState:
1441  0009 00            	ds.b	1
1442                     	xdef	_LOWBeamDriverState
1443  000a               _Buzzertime:
1444  000a 00            	ds.b	1
1445                     	xdef	_Buzzertime
1446  000b               _LowBeamSwitchState:
1447  000b 00            	ds.b	1
1448                     	xdef	_LowBeamSwitchState
1449  000c               _HighBeamSwitchState:
1450  000c 00            	ds.b	1
1451                     	xdef	_HighBeamSwitchState
1452                     	xref	_DoorState
1453                     	xref	_SmallLampSwitchState
1454                     	xref	_IGNstate
1474                     	end
