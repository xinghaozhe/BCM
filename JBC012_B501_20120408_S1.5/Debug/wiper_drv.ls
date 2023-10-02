   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 815                     ; 51 void GetFrontWiperIntTime(void)
 815                     ; 52 {
 816                     	switch	.text
 817  0000               f_GetFrontWiperIntTime:
 819  0000 89            	pushw	x
 820       00000002      OFST:	set	2
 823                     ; 56 	ADValueTemp = GetADCresultAverage(0);
 825  0001 4f            	clr	a
 826  0002 8d000000      	callf	f_GetADCresultAverage
 828  0006 1f01          	ldw	(OFST-1,sp),x
 829                     ; 58 	if (ADValueTemp < WIPER_INT_6_ADV)
 831  0008 a30028        	cpw	x,#40
 832  000b 2405          	jruge	L554
 833                     ; 60 		FrontWiperIntTime = WIPER_INT_6_TIME;
 835  000d ae0abe        	ldw	x,#2750
 837  0010 202b          	jra	L754
 838  0012               L554:
 839                     ; 62 	else if (ADValueTemp < WIPER_INT_5_ADV)
 841  0012 a30050        	cpw	x,#80
 842  0015 2405          	jruge	L164
 843                     ; 64 		FrontWiperIntTime = WIPER_INT_5_TIME;
 845  0017 ae0791        	ldw	x,#1937
 847  001a 2021          	jra	L754
 848  001c               L164:
 849                     ; 66 	else if (ADValueTemp < WIPER_INT_4_ADV)
 851  001c a300a0        	cpw	x,#160
 852  001f 2405          	jruge	L564
 853                     ; 68 		FrontWiperIntTime = WIPER_INT_4_TIME;
 855  0021 ae04b0        	ldw	x,#1200
 857  0024 2017          	jra	L754
 858  0026               L564:
 859                     ; 70 	else if (ADValueTemp < WIPER_INT_3_ADV)
 861  0026 a30104        	cpw	x,#260
 862  0029 2405          	jruge	L174
 863                     ; 72 		FrontWiperIntTime = WIPER_INT_3_TIME;
 865  002b ae02ee        	ldw	x,#750
 867  002e 200d          	jra	L754
 868  0030               L174:
 869                     ; 74 	else if (ADValueTemp < WIPER_INT_2_ADV)
 871  0030 a30226        	cpw	x,#550
 872  0033 2405          	jruge	L574
 873                     ; 76 		FrontWiperIntTime = WIPER_INT_2_TIME;
 875  0035 ae01b5        	ldw	x,#437
 877  0038 2003          	jra	L754
 878  003a               L574:
 879                     ; 80 		FrontWiperIntTime = WIPER_INT_1_TIME;
 881  003a ae007d        	ldw	x,#125
 882  003d               L754:
 883  003d cf0022        	ldw	_FrontWiperIntTime,x
 884                     ; 82 }
 887  0040 85            	popw	x
 888  0041 87            	retf	
 890                     	switch	.bss
 891  0000               L115_FwiperParkState:
 892  0000 00            	ds.b	1
 893  0001               L705_rWiperParkNoCnt:
 894  0001 00            	ds.b	1
 895  0002               L505_rWiperParkYesCnt:
 896  0002 00            	ds.b	1
 897  0003               L305_fWiperParkNoCnt:
 898  0003 00            	ds.b	1
 899  0004               L105_fWiperParkYesCnt:
 900  0004 00            	ds.b	1
 901  0005               L315_FwiperParkOldState:
 902  0005 00            	ds.b	1
 970                     ; 93 void ScanWiperParkSignal(void)
 970                     ; 94 {
 971                     	switch	.text
 972  0042               f_ScanWiperParkSignal:
 976                     ; 100     if (!F_WIPER_PARK)
 978  0042 720800001f    	btjt	_H4021Data2,#4,L545
 979                     ; 102         fWiperParkNoCnt = 0;
 981  0047 725f0003      	clr	L305_fWiperParkNoCnt
 982                     ; 103         if (fWiperParkYesCnt < wiper_park_filter_cnt)
 984  004b c60004        	ld	a,L105_fWiperParkYesCnt
 985  004e a104          	cp	a,#4
 986  0050 2406          	jruge	L745
 987                     ; 105         	fWiperParkYesCnt++;
 989  0052 725c0004      	inc	L105_fWiperParkYesCnt
 991  0056 202b          	jra	L555
 992  0058               L745:
 993                     ; 107         else if (fWiperParkYesCnt == wiper_park_filter_cnt)
 995  0058 a104          	cp	a,#4
 996  005a 2627          	jrne	L555
 997                     ; 109         	fWiperParkYesCnt++;
 999  005c 725c0004      	inc	L105_fWiperParkYesCnt
1000                     ; 111         	FwiperParkState = 0x55;
1002  0060 35550000      	mov	L115_FwiperParkState,#85
1003  0064 201d          	jra	L555
1004  0066               L545:
1005                     ; 116         fWiperParkYesCnt = 0;
1007  0066 725f0004      	clr	L105_fWiperParkYesCnt
1008                     ; 117         if (fWiperParkNoCnt < WIPER_KEY_FILTER_CNT)
1010  006a c60003        	ld	a,L305_fWiperParkNoCnt
1011  006d a104          	cp	a,#4
1012  006f 2406          	jruge	L755
1013                     ; 119         	fWiperParkNoCnt++;
1015  0071 725c0003      	inc	L305_fWiperParkNoCnt
1017  0075 200c          	jra	L555
1018  0077               L755:
1019                     ; 121         else if (fWiperParkNoCnt == WIPER_KEY_FILTER_CNT)
1021  0077 a104          	cp	a,#4
1022  0079 2608          	jrne	L555
1023                     ; 123         	fWiperParkNoCnt++;
1025  007b 725c0003      	inc	L305_fWiperParkNoCnt
1026                     ; 125         	FwiperParkState = 0x00;
1028  007f 725f0000      	clr	L115_FwiperParkState
1029  0083               L555:
1030                     ; 129     if(FwiperParkOldState != FwiperParkState)
1032  0083 c60005        	ld	a,L315_FwiperParkOldState
1033  0086 c10000        	cp	a,L115_FwiperParkState
1034  0089 2710          	jreq	L565
1035                     ; 131         FwiperParkOldState =  FwiperParkState ;
1037  008b c60000        	ld	a,L115_FwiperParkState
1038  008e c70005        	ld	L315_FwiperParkOldState,a
1039                     ; 132         if(FwiperParkState == 0x55)
1041  0091 a155          	cp	a,#85
1042  0093 260a          	jrne	L175
1043                     ; 134             WiperParkSta |= fWiperParkYes;
1045  0095 72100020      	bset	_WiperParkSta,#0
1046  0099 2004          	jra	L175
1047  009b               L565:
1048                     ; 139         WiperParkSta &= ~fWiperParkYes;
1050  009b 72110020      	bres	_WiperParkSta,#0
1051  009f               L175:
1052                     ; 143     if (!R_WIPER_PARK)
1054  009f 720200001d    	btjt	_H4021Data2,#1,L375
1055                     ; 145         rWiperParkNoCnt = 0;
1057  00a4 725f0001      	clr	L705_rWiperParkNoCnt
1058                     ; 146         if (rWiperParkYesCnt < WIPER_KEY_FILTER_CNT)
1060  00a8 c60002        	ld	a,L505_rWiperParkYesCnt
1061  00ab a104          	cp	a,#4
1062  00ad 2405          	jruge	L575
1063                     ; 148         	rWiperParkYesCnt++;
1065  00af 725c0002      	inc	L505_rWiperParkYesCnt
1068  00b3 87            	retf	
1069  00b4               L575:
1070                     ; 150         else if (rWiperParkYesCnt == WIPER_KEY_FILTER_CNT)
1072  00b4 a104          	cp	a,#4
1073  00b6 2625          	jrne	L306
1074                     ; 152         	rWiperParkYesCnt++;
1076  00b8 725c0002      	inc	L505_rWiperParkYesCnt
1077                     ; 153         	WiperParkSta |= rWiperParkYes;
1079  00bc 72120020      	bset	_WiperParkSta,#1
1081  00c0 87            	retf	
1082  00c1               L375:
1083                     ; 158         rWiperParkYesCnt = 0;
1085  00c1 725f0002      	clr	L505_rWiperParkYesCnt
1086                     ; 159         if (rWiperParkNoCnt < WIPER_KEY_FILTER_CNT)
1088  00c5 c60001        	ld	a,L705_rWiperParkNoCnt
1089  00c8 a104          	cp	a,#4
1090  00ca 2405          	jruge	L506
1091                     ; 161         	rWiperParkNoCnt++;
1093  00cc 725c0001      	inc	L705_rWiperParkNoCnt
1096  00d0 87            	retf	
1097  00d1               L506:
1098                     ; 163         else if (rWiperParkNoCnt == WIPER_KEY_FILTER_CNT)
1100  00d1 a104          	cp	a,#4
1101  00d3 2608          	jrne	L306
1102                     ; 165         	rWiperParkNoCnt++;
1104  00d5 725c0001      	inc	L705_rWiperParkNoCnt
1105                     ; 166         	WiperParkSta &= ~rWiperParkYes;
1107  00d9 72130020      	bres	_WiperParkSta,#1
1108  00dd               L306:
1109                     ; 169 }
1112  00dd 87            	retf	
1114                     	switch	.bss
1115  0006               L516_fWasherOffCnt:
1116  0006 00            	ds.b	1
1117  0007               L126_rWasherOffCnt:
1118  0007 00            	ds.b	1
1119  0008               L316_fWasherOnCnt:
1120  0008 00            	ds.b	1
1121  0009               L716_rWasherOnCnt:
1122  0009 00            	ds.b	1
1177                     ; 181 void ScanWasherSwitch(void)
1177                     ; 182 {
1178                     	switch	.text
1179  00de               f_ScanWasherSwitch:
1183                     ; 187 	if ((FrontWiperDrv & FrontWiperSlowOn) || (FrontWiperHighDrv & FrontWiperHighOn))
1185  00de 7202002505    	btjt	_FrontWiperDrv,#1,L746
1187  00e3 7201002125    	btjf	_FrontWiperHighDrv,#0,L546
1188  00e8               L746:
1189                     ; 190 		FrontWiperDrv &= ~(FrontWiperWasherOn2 + FrontWiperWasherOn);
1191  00e8 c60025        	ld	a,_FrontWiperDrv
1192  00eb a4e7          	and	a,#231
1193  00ed c70025        	ld	_FrontWiperDrv,a
1194                     ; 191 		fWasherOnCnt = fWasherOffCnt = 0;
1196  00f0 725f0006      	clr	L516_fWasherOffCnt
1197  00f4 725f0008      	clr	L316_fWasherOnCnt
1199  00f8               L156:
1200                     ; 225     if(R_WASHER_SW)   
1202  00f8 7201000061    	btjf	_H4021Data2,#0,L576
1203                     ; 227 	    rWasherOffCnt = 0;
1205  00fd 725f0007      	clr	L126_rWasherOffCnt
1206                     ; 228            if (rWasherOnCnt < WASHER_KEY_FILTER_CNT)
1208  0101 c60009        	ld	a,L716_rWasherOnCnt
1209  0104 a125          	cp	a,#37
1210  0106 244d          	jruge	L776
1211                     ; 230                    rWasherOnCnt++;
1213  0108 725c0009      	inc	L716_rWasherOnCnt
1216  010c 87            	retf	
1217  010d               L546:
1218                     ; 194     else if (F_WASHER_SW)
1220  010d 720b00001b    	btjf	_H4021Data2,#5,L356
1221                     ; 196            fWasherOffCnt = 0;
1223  0112 725f0006      	clr	L516_fWasherOffCnt
1224                     ; 197            if (fWasherOnCnt < WASHER_KEY_FILTER_CNT)
1226  0116 c60008        	ld	a,L316_fWasherOnCnt
1227  0119 a125          	cp	a,#37
1228  011b 2406          	jruge	L556
1229                     ; 199                   fWasherOnCnt++;
1231  011d 725c0008      	inc	L316_fWasherOnCnt
1233  0121 20d5          	jra	L156
1234  0123               L556:
1235                     ; 201            else if (fWasherOnCnt == WASHER_KEY_FILTER_CNT)
1237  0123 a125          	cp	a,#37
1238  0125 26d1          	jrne	L156
1239                     ; 203                  FrontWiperDrv |= FrontWiperWasherOn2;
1241  0127 72180025      	bset	_FrontWiperDrv,#4
1242  012b 20cb          	jra	L156
1243  012d               L356:
1244                     ; 208             fWasherOnCnt = 0;
1246  012d 725f0008      	clr	L316_fWasherOnCnt
1247                     ; 209             if (fWasherOffCnt < KEY_FILTER_CNT)
1249  0131 c60006        	ld	a,L516_fWasherOffCnt
1250  0134 a105          	cp	a,#5
1251  0136 2406          	jruge	L566
1252                     ; 211                   fWasherOffCnt++;
1254  0138 725c0006      	inc	L516_fWasherOffCnt
1256  013c 20ba          	jra	L156
1257  013e               L566:
1258                     ; 213             else if (fWasherOffCnt == KEY_FILTER_CNT)
1260  013e a105          	cp	a,#5
1261  0140 26b6          	jrne	L156
1262                     ; 215                 fWasherOffCnt++;
1264  0142 725c0006      	inc	L516_fWasherOffCnt
1265                     ; 216                 if (FrontWiperDrv & FrontWiperWasherOn2)
1267  0146 72090025ad    	btjf	_FrontWiperDrv,#4,L156
1268                     ; 218               	    FrontWiperDrv &= ~FrontWiperWasherOn2;
1270  014b 72190025      	bres	_FrontWiperDrv,#4
1271                     ; 219                         FrontWiperDrv |= FrontWiperWasherOn;                        
1273  014f 72160025      	bset	_FrontWiperDrv,#3
1274  0153 20a3          	jra	L156
1275  0155               L776:
1276                     ; 232            else if (rWasherOnCnt == WASHER_KEY_FILTER_CNT)
1278  0155 a125          	cp	a,#37
1279  0157 262a          	jrne	L507
1280                     ; 234                   RearWiperDrv |= RearWiperWasherOn2;                        
1282  0159 72140024      	bset	_RearWiperDrv,#2
1284  015d 87            	retf	
1285  015e               L576:
1286                     ; 239         rWasherOnCnt = 0;
1288  015e 725f0009      	clr	L716_rWasherOnCnt
1289                     ; 240         if (rWasherOffCnt < KEY_FILTER_CNT)
1291  0162 c60007        	ld	a,L126_rWasherOffCnt
1292  0165 a105          	cp	a,#5
1293  0167 2405          	jruge	L707
1294                     ; 242              rWasherOffCnt++;
1296  0169 725c0007      	inc	L126_rWasherOffCnt
1299  016d 87            	retf	
1300  016e               L707:
1301                     ; 244         else if (rWasherOffCnt == KEY_FILTER_CNT)
1303  016e a105          	cp	a,#5
1304  0170 2611          	jrne	L507
1305                     ; 246              rWasherOffCnt++;
1307  0172 725c0007      	inc	L126_rWasherOffCnt
1308                     ; 247              if (RearWiperDrv & RearWiperWasherOn2)
1310  0176 7205002408    	btjf	_RearWiperDrv,#2,L507
1311                     ; 249                   RearWiperDrv &= ~RearWiperWasherOn2;
1313  017b 72150024      	bres	_RearWiperDrv,#2
1314                     ; 250                   RearWiperDrv |= RearWiperWasherOn;                        
1316  017f 72120024      	bset	_RearWiperDrv,#1
1317  0183               L507:
1318                     ; 254 }
1321  0183 87            	retf	
1323                     	switch	.bss
1324  000a               L337_fWiperSlowOffCnt:
1325  000a 00            	ds.b	1
1326  000b               L527_rWiperIntOnCnt:
1327  000b 00            	ds.b	1
1328  000c               L327_fWiperSlowOnCnt:
1329  000c 00            	ds.b	1
1330  000d               L127_fWiperHighOnCnt:
1331  000d 00            	ds.b	1
1332  000e               L717_fWiperIntOnCnt:
1333  000e 00            	ds.b	1
1334  000f               L537_rWiperIntOffCnt:
1335  000f 00            	ds.b	1
1336  0010               L137_fWiperHighOffCnt:
1337  0010 00            	ds.b	1
1338  0011               L727_fWiperIntOffCnt:
1339  0011 00            	ds.b	1
1426                     ; 269 void ScanWiperSwitch(void)
1426                     ; 270 {
1427                     	switch	.text
1428  0184               f_ScanWiperSwitch:
1432                     ; 275        GetFrontWiperIntTime();
1434  0184 8d000000      	callf	f_GetFrontWiperIntTime
1436                     ; 277        ScanWiperParkSignal();
1438  0188 8d420042      	callf	f_ScanWiperParkSignal
1440                     ; 279        ScanWasherSwitch();
1442  018c 8dde00de      	callf	f_ScanWasherSwitch
1444                     ; 282 	if (IGNstate == OFF)
1446  0190 c60000        	ld	a,_IGNstate
1447  0193 2624          	jrne	L177
1448                     ; 284 		fWiperHighOnCnt = 0;
1450  0195 c7000d        	ld	L127_fWiperHighOnCnt,a
1451                     ; 285 		fWiperSlowOnCnt = 0;
1453  0198 c7000c        	ld	L327_fWiperSlowOnCnt,a
1454                     ; 286 		fWiperIntOnCnt = 0;
1456  019b c7000e        	ld	L717_fWiperIntOnCnt,a
1457                     ; 287 		rWiperIntOnCnt = 0;
1459  019e c7000b        	ld	L527_rWiperIntOnCnt,a
1460                     ; 292 		if (FrontWiperHighDrv & FrontWiperHighOn)
1462  01a1 720100210a    	btjf	_FrontWiperHighDrv,#0,L377
1463                     ; 294 			FrontWiperHighDrv &= ~FrontWiperHighOn;
1465  01a6 72110021      	bres	_FrontWiperHighDrv,#0
1466                     ; 295 			FrontWiperDrv = FrontWiperSlowOn;
1468  01aa 35020025      	mov	_FrontWiperDrv,#2
1470  01ae 2004          	jra	L577
1471  01b0               L377:
1472                     ; 299 			FrontWiperDrv = FrontWiperOff;
1474  01b0 725f0025      	clr	_FrontWiperDrv
1475  01b4               L577:
1476                     ; 301 		RearWiperDrv = RearWiperOff;
1478  01b4 725f0024      	clr	_RearWiperDrv
1479                     ; 302 		return;
1482  01b8 87            	retf	
1483  01b9               L177:
1484                     ; 306     if(F_WIPER_INT_SW) 
1486  01b9 720f00001f    	btjf	_H4021Data2,#7,L777
1487                     ; 308         fWiperIntOffCnt = 0;      
1489  01be 725f0011      	clr	L727_fWiperIntOffCnt
1490                     ; 309         if (fWiperIntOnCnt < WIPER_KEY_FILTER_CNT)
1492  01c2 c6000e        	ld	a,L717_fWiperIntOnCnt
1493  01c5 a104          	cp	a,#4
1494  01c7 2406          	jruge	L1001
1495                     ; 311         	fWiperIntOnCnt++;
1497  01c9 725c000e      	inc	L717_fWiperIntOnCnt
1499  01cd 202b          	jra	L7001
1500  01cf               L1001:
1501                     ; 313         else if (fWiperIntOnCnt == WIPER_KEY_FILTER_CNT)
1503  01cf a104          	cp	a,#4
1504  01d1 2627          	jrne	L7001
1505                     ; 315         	fWiperIntOnCnt++;
1507  01d3 725c000e      	inc	L717_fWiperIntOnCnt
1508                     ; 316         	FrontWiperDrv |= FrontWiperIntOn;
1510  01d7 72140025      	bset	_FrontWiperDrv,#2
1511  01db 201d          	jra	L7001
1512  01dd               L777:
1513                     ; 321     	fWiperIntOnCnt = 0;
1515  01dd 725f000e      	clr	L717_fWiperIntOnCnt
1516                     ; 322     	if (fWiperIntOffCnt < WIPER_KEY_FILTER_CNT_OFF)
1518  01e1 c60011        	ld	a,L727_fWiperIntOffCnt
1519  01e4 a102          	cp	a,#2
1520  01e6 2406          	jruge	L1101
1521                     ; 324     		fWiperIntOffCnt++;
1523  01e8 725c0011      	inc	L727_fWiperIntOffCnt
1525  01ec 200c          	jra	L7001
1526  01ee               L1101:
1527                     ; 326     	else if (fWiperIntOffCnt == WIPER_KEY_FILTER_CNT_OFF)
1529  01ee a102          	cp	a,#2
1530  01f0 2608          	jrne	L7001
1531                     ; 328     		fWiperIntOffCnt++;
1533  01f2 725c0011      	inc	L727_fWiperIntOffCnt
1534                     ; 329     		FrontWiperDrv &= ~FrontWiperIntOn;
1536  01f6 72150025      	bres	_FrontWiperDrv,#2
1537  01fa               L7001:
1538                     ; 334     if (F_WIPER_SLOW_SW)
1540  01fa 720d00001f    	btjf	_H4021Data2,#6,L7101
1541                     ; 336         fWiperSlowOffCnt = 0;
1543  01ff 725f000a      	clr	L337_fWiperSlowOffCnt
1544                     ; 337         if (fWiperSlowOnCnt < WIPER_KEY_FILTER_CNT)
1546  0203 c6000c        	ld	a,L327_fWiperSlowOnCnt
1547  0206 a104          	cp	a,#4
1548  0208 2406          	jruge	L1201
1549                     ; 339         	fWiperSlowOnCnt++;
1551  020a 725c000c      	inc	L327_fWiperSlowOnCnt
1553  020e 202b          	jra	L7201
1554  0210               L1201:
1555                     ; 341         else if (fWiperSlowOnCnt == WIPER_KEY_FILTER_CNT)
1557  0210 a104          	cp	a,#4
1558  0212 2627          	jrne	L7201
1559                     ; 343         	fWiperSlowOnCnt++;
1561  0214 725c000c      	inc	L327_fWiperSlowOnCnt
1562                     ; 344         	FrontWiperDrv |= FrontWiperSlowOn;
1564  0218 72120025      	bset	_FrontWiperDrv,#1
1565  021c 201d          	jra	L7201
1566  021e               L7101:
1567                     ; 349         fWiperSlowOnCnt = 0;
1569  021e 725f000c      	clr	L327_fWiperSlowOnCnt
1570                     ; 350         if (fWiperSlowOffCnt < WIPER_KEY_FILTER_CNT_OFF)
1572  0222 c6000a        	ld	a,L337_fWiperSlowOffCnt
1573  0225 a102          	cp	a,#2
1574  0227 2406          	jruge	L1301
1575                     ; 352         	fWiperSlowOffCnt++;
1577  0229 725c000a      	inc	L337_fWiperSlowOffCnt
1579  022d 200c          	jra	L7201
1580  022f               L1301:
1581                     ; 354         else if (fWiperSlowOffCnt == WIPER_KEY_FILTER_CNT_OFF)
1583  022f a102          	cp	a,#2
1584  0231 2608          	jrne	L7201
1585                     ; 356         	fWiperSlowOffCnt++;
1587  0233 725c000a      	inc	L337_fWiperSlowOffCnt
1588                     ; 357         	FrontWiperDrv &= ~FrontWiperSlowOn;
1590  0237 72130025      	bres	_FrontWiperDrv,#1
1591  023b               L7201:
1592                     ; 362     if (F_WIPER_HIGH_SW)
1594  023b 720500001f    	btjf	_H4021Data2,#2,L7301
1595                     ; 364         fWiperHighOffCnt = 0;
1597  0240 725f0010      	clr	L137_fWiperHighOffCnt
1598                     ; 365         if (fWiperHighOnCnt < WIPER_KEY_FILTER_CNT)
1600  0244 c6000d        	ld	a,L127_fWiperHighOnCnt
1601  0247 a104          	cp	a,#4
1602  0249 2406          	jruge	L1401
1603                     ; 367         	fWiperHighOnCnt++;
1605  024b 725c000d      	inc	L127_fWiperHighOnCnt
1607  024f 2038          	jra	L7401
1608  0251               L1401:
1609                     ; 369         else if (fWiperHighOnCnt == WIPER_KEY_FILTER_CNT)
1611  0251 a104          	cp	a,#4
1612  0253 2634          	jrne	L7401
1613                     ; 371         	fWiperHighOnCnt++;
1615  0255 725c000d      	inc	L127_fWiperHighOnCnt
1616                     ; 372         	FrontWiperHighDrv |= FrontWiperHighOn;
1618  0259 72100021      	bset	_FrontWiperHighDrv,#0
1619  025d 202a          	jra	L7401
1620  025f               L7301:
1621                     ; 377         fWiperHighOnCnt = 0;
1623  025f 725f000d      	clr	L127_fWiperHighOnCnt
1624                     ; 378         if (fWiperHighOffCnt < WIPER_KEY_FILTER_CNT)
1626  0263 c60010        	ld	a,L137_fWiperHighOffCnt
1627  0266 a104          	cp	a,#4
1628  0268 2406          	jruge	L1501
1629                     ; 380         	fWiperHighOffCnt++;
1631  026a 725c0010      	inc	L137_fWiperHighOffCnt
1633  026e 2019          	jra	L7401
1634  0270               L1501:
1635                     ; 382         else if (fWiperHighOffCnt == WIPER_KEY_FILTER_CNT)
1637  0270 a104          	cp	a,#4
1638  0272 2615          	jrne	L7401
1639                     ; 387         	fWiperHighOffCnt++;
1641  0274 725c0010      	inc	L137_fWiperHighOffCnt
1642                     ; 388         	fWiperSlowOffCnt = 0;
1644  0278 725f000a      	clr	L337_fWiperSlowOffCnt
1645                     ; 389         	if(FrontWiperHighDrv & FrontWiperHighOn)
1647  027c 7201002104    	btjf	_FrontWiperHighDrv,#0,L7501
1648                     ; 391         	    FrontWiperDrv |= FrontWiperSlowOn;	
1650  0281 72120025      	bset	_FrontWiperDrv,#1
1651  0285               L7501:
1652                     ; 393         	FrontWiperHighDrv &= ~FrontWiperHighOn;
1654  0285 72110021      	bres	_FrontWiperHighDrv,#0
1655  0289               L7401:
1656                     ; 398     if (R_WIPER_INT_SW)
1658  0289 720700001d    	btjf	_H4021Data2,#3,L1601
1659                     ; 400         rWiperIntOffCnt = 0;
1661  028e 725f000f      	clr	L537_rWiperIntOffCnt
1662                     ; 401         if (rWiperIntOnCnt < WIPER_KEY_FILTER_CNT)
1664  0292 c6000b        	ld	a,L527_rWiperIntOnCnt
1665  0295 a104          	cp	a,#4
1666  0297 2405          	jruge	L3601
1667                     ; 403         	rWiperIntOnCnt++;
1669  0299 725c000b      	inc	L527_rWiperIntOnCnt
1672  029d 87            	retf	
1673  029e               L3601:
1674                     ; 405         else if (rWiperIntOnCnt == WIPER_KEY_FILTER_CNT)
1676  029e a104          	cp	a,#4
1677  02a0 2625          	jrne	L1701
1678                     ; 407         	rWiperIntOnCnt++;
1680  02a2 725c000b      	inc	L527_rWiperIntOnCnt
1681                     ; 408         	RearWiperDrv |= RearWiperIntOn;
1683  02a6 72100024      	bset	_RearWiperDrv,#0
1685  02aa 87            	retf	
1686  02ab               L1601:
1687                     ; 413         rWiperIntOnCnt = 0;
1689  02ab 725f000b      	clr	L527_rWiperIntOnCnt
1690                     ; 414         if (rWiperIntOffCnt < WIPER_KEY_FILTER_CNT_OFF)
1692  02af c6000f        	ld	a,L537_rWiperIntOffCnt
1693  02b2 a102          	cp	a,#2
1694  02b4 2405          	jruge	L3701
1695                     ; 416         	rWiperIntOffCnt++;
1697  02b6 725c000f      	inc	L537_rWiperIntOffCnt
1700  02ba 87            	retf	
1701  02bb               L3701:
1702                     ; 418         else if (rWiperIntOffCnt == WIPER_KEY_FILTER_CNT_OFF)
1704  02bb a102          	cp	a,#2
1705  02bd 2608          	jrne	L1701
1706                     ; 420         	rWiperIntOffCnt++;
1708  02bf 725c000f      	inc	L537_rWiperIntOffCnt
1709                     ; 421         	RearWiperDrv &= ~RearWiperIntOn;
1711  02c3 72110024      	bres	_RearWiperDrv,#0
1712  02c7               L1701:
1713                     ; 424 }
1716  02c7 87            	retf	
1718                     	switch	.bss
1719  0012               L3011_fWasherCnt:
1720  0012 0000          	ds.b	2
1721  0014               L1011_fWiperIntCnt:
1722  0014 0000          	ds.b	2
1723  0016               L5011_HParktimeCNT:
1724  0016 0000          	ds.b	2
1725  0018               L7011_ParkDTCstate:
1726  0018 00            	ds.b	1
1784                     ; 437 void JudgeFrontWiperDriver(void)
1784                     ; 438 {
1785                     	switch	.text
1786  02c8               f_JudgeFrontWiperDriver:
1790                     ; 442 	if(RetCode == 0xffff)
1792  02c8 ce0000        	ldw	x,_RetCode
1793  02cb 5c            	incw	x
1794  02cc 2608          	jrne	L3311
1795                     ; 444 	   if(VehicleType != CV8) return;
1797  02ce c60000        	ld	a,_VehicleType
1798  02d1 a120          	cp	a,#32
1799  02d3 2701          	jreq	L3311
1803  02d5 87            	retf	
1804  02d6               L3311:
1805                     ; 446     if((ParkDTCstate == 0x55) && (((FrontWiperHighDrv & FrontWiperHighOn) == 0)||(FrontWiperDrv == FrontWiperOff)))
1807  02d6 c60018        	ld	a,L7011_ParkDTCstate
1808  02d9 a155          	cp	a,#85
1809  02db 2616          	jrne	L7311
1811  02dd 7201002105    	btjf	_FrontWiperHighDrv,#0,L1411
1813  02e2 c60025        	ld	a,_FrontWiperDrv
1814  02e5 260c          	jrne	L7311
1815  02e7               L1411:
1816                     ; 448 		FRONT_WIPER_SLOW_OFF;
1818  02e7 721d500f      	bres	20495,#6
1819                     ; 449 		FRONT_WIPER_HIGH_OFF;
1821  02eb 7215500f      	bres	20495,#2
1822                     ; 450 		ParkDTCstate = 0;
1824  02ef 725f0018      	clr	L7011_ParkDTCstate
1825  02f3               L7311:
1826                     ; 453     if (FrontWiperHighDrv & FrontWiperHighOn)
1828  02f3 7201002113    	btjf	_FrontWiperHighDrv,#0,L3411
1829                     ; 457             fWasherCnt = 0;
1831  02f8 5f            	clrw	x
1832  02f9 cf0012        	ldw	L3011_fWasherCnt,x
1833                     ; 458             fWiperIntCnt = 0;
1835  02fc cf0014        	ldw	L1011_fWiperIntCnt,x
1836                     ; 460             FRONT_WIPER_SLOW_ON;
1838  02ff 721c500f      	bset	20495,#6
1839                     ; 461             FRONT_WIPER_HIGH_ON;
1841  0303 7214500f      	bset	20495,#2
1843  0307 ace003e0      	jra	L5411
1844  030b               L3411:
1845                     ; 463     else if (FrontWiperDrv & (FrontWiperSlowOn | FrontWiperWasherOn2))
1847  030b c60025        	ld	a,_FrontWiperDrv
1848  030e a512          	bcp	a,#18
1849  0310 2713          	jreq	L7411
1850                     ; 468             fWasherCnt = 0;
1852  0312 5f            	clrw	x
1853  0313 cf0012        	ldw	L3011_fWasherCnt,x
1854                     ; 469             fWiperIntCnt = 0;
1856  0316 cf0014        	ldw	L1011_fWiperIntCnt,x
1857                     ; 470             FRONT_WIPER_HIGH_OFF;
1859  0319 7215500f      	bres	20495,#2
1860                     ; 471             FRONT_WIPER_SLOW_ON;
1862  031d 721c500f      	bset	20495,#6
1864  0321 ace003e0      	jra	L5411
1865  0325               L7411:
1866                     ; 473     else if (FrontWiperDrv & FrontWiperWasherOn)
1868  0325 a508          	bcp	a,#8
1869  0327 2779          	jreq	L3511
1870                     ; 478               fWiperIntCnt = 0;
1872  0329 5f            	clrw	x
1873  032a cf0014        	ldw	L1011_fWiperIntCnt,x
1874                     ; 479 		if (fWasherCnt == 0)
1876  032d ce0012        	ldw	x,L3011_fWasherCnt
1877  0330 2611          	jrne	L5511
1878                     ; 481                      FRONT_WIPER_SLOW_ON;
1880  0332 721c500f      	bset	20495,#6
1881                     ; 482                      if (WiperParkSta & fWiperParkYes)
1883  0336 72010020e6    	btjf	_WiperParkSta,#0,L5411
1884                     ; 483                      fWasherCnt++;			// 1 cycle, in park position
1886  033b 5c            	incw	x
1887  033c cf0012        	ldw	L3011_fWasherCnt,x
1888  033f ace003e0      	jra	L5411
1889  0343               L5511:
1890                     ; 503 		else if (fWasherCnt == 1)
1892  0343 a30001        	cpw	x,#1
1893  0346 2615          	jrne	L3611
1894                     ; 505 			FRONT_WIPER_SLOW_ON;
1896  0348 721c500f      	bset	20495,#6
1897                     ; 506 			if (WiperParkSta & fWiperParkYes)
1899  034c 72010020ee    	btjf	_WiperParkSta,#0,L5411
1900                     ; 508 				FRONT_WIPER_SLOW_OFF;
1902  0351 721d500f      	bres	20495,#6
1903                     ; 509 				fWasherCnt++;			// 3 cycle, in park position
1905  0355 5c            	incw	x
1906  0356 cf0012        	ldw	L3011_fWasherCnt,x
1907  0359 ace003e0      	jra	L5411
1908  035d               L3611:
1909                     ; 512              else if (fWasherCnt == 2)
1911  035d a30002        	cpw	x,#2
1912  0360 2613          	jrne	L1711
1913                     ; 514 			FRONT_WIPER_SLOW_ON;
1915  0362 721c500f      	bset	20495,#6
1916                     ; 515 			if (WiperParkSta & fWiperParkYes)
1918  0366 7201002075    	btjf	_WiperParkSta,#0,L5411
1919                     ; 517 				FRONT_WIPER_SLOW_OFF;
1921  036b 721d500f      	bres	20495,#6
1922                     ; 518 				fWasherCnt++;			// 3 cycle, in park position
1924  036f 5c            	incw	x
1925  0370 cf0012        	ldw	L3011_fWasherCnt,x
1926  0373 206b          	jra	L5411
1927  0375               L1711:
1928                     ; 521 		else if (fWasherCnt < WIPER_INT_PERIOD)
1930  0375 a302ee        	cpw	x,#750
1931  0378 240a          	jruge	L7711
1932                     ; 523 			FRONT_WIPER_SLOW_OFF;
1934  037a 721d500f      	bres	20495,#6
1935                     ; 524 			fWasherCnt++;				//stop 6s, in park position
1937  037e 5c            	incw	x
1938  037f cf0012        	ldw	L3011_fWasherCnt,x
1940  0382 205c          	jra	L5411
1941  0384               L7711:
1942                     ; 526 		else if (fWasherCnt == WIPER_INT_PERIOD)
1944  0384 a302ee        	cpw	x,#750
1945  0387 2613          	jrne	L3021
1946                     ; 528 			FRONT_WIPER_SLOW_ON;		//start running 4 cycle
1948  0389 721c500f      	bset	20495,#6
1949                     ; 529 			if (!(WiperParkSta & fWiperParkYes))
1951  038d 720000204e    	btjt	_WiperParkSta,#0,L5411
1952                     ; 531 				fWasherCnt = 0;			// continue 4 cycle, exit park position
1954  0392 5f            	clrw	x
1955  0393 cf0012        	ldw	L3011_fWasherCnt,x
1956                     ; 533 				FrontWiperDrv &= ~FrontWiperWasherOn;
1958  0396 72170025      	bres	_FrontWiperDrv,#3
1959  039a 2044          	jra	L5411
1960  039c               L3021:
1961                     ; 538 			fWasherCnt = 0;
1963  039c 5f            	clrw	x
1964  039d cf0012        	ldw	L3011_fWasherCnt,x
1965  03a0 203e          	jra	L5411
1966  03a2               L3511:
1967                     ; 541    else if (FrontWiperDrv & FrontWiperIntOn)
1969  03a2 a504          	bcp	a,#4
1970  03a4 2726          	jreq	L3121
1971                     ; 546 	   fWasherCnt = 0;
1973  03a6 5f            	clrw	x
1974  03a7 cf0012        	ldw	L3011_fWasherCnt,x
1975                     ; 547 	   if (fWiperIntCnt == 0)
1977  03aa ce0014        	ldw	x,L1011_fWiperIntCnt
1978  03ad 260c          	jrne	L5121
1979                     ; 549                  FRONT_WIPER_SLOW_ON;
1981  03af 721c500f      	bset	20495,#6
1982                     ; 550                  if (!(WiperParkSta & fWiperParkYes))
1984  03b3 7200002028    	btjt	_WiperParkSta,#0,L5411
1985                     ; 551                  fWiperIntCnt++;
1987  03b8 5c            	incw	x
1988  03b9 200c          	jpf	LC002
1989  03bb               L5121:
1990                     ; 553 	   else if ( fWiperIntCnt < FrontWiperIntTime)
1992  03bb c30022        	cpw	x,_FrontWiperIntTime
1993  03be 2406          	jruge	L3221
1994                     ; 555 		   fWiperIntCnt++;
1996  03c0 5c            	incw	x
1997  03c1 cf0014        	ldw	L1011_fWiperIntCnt,x
1998                     ; 556 		   if (WiperParkSta & fWiperParkYes)
1999                     ; 558 			   FRONT_WIPER_SLOW_OFF; 
2000  03c4 2011          	jpf	LC001
2001  03c6               L3221:
2002                     ; 563 		   fWiperIntCnt = 0;
2004  03c6 5f            	clrw	x
2005  03c7               LC002:
2006  03c7 cf0014        	ldw	L1011_fWiperIntCnt,x
2007  03ca 2014          	jra	L5411
2008  03cc               L3121:
2009                     ; 568            fWiperIntCnt = 0;
2011  03cc 5f            	clrw	x
2012  03cd cf0014        	ldw	L1011_fWiperIntCnt,x
2013                     ; 569            fWasherCnt = 0;
2015  03d0 cf0012        	ldw	L3011_fWasherCnt,x
2016                     ; 570            FrontWiperDrv = FrontWiperOff;
2018  03d3 725f0025      	clr	_FrontWiperDrv
2019                     ; 571            if (WiperParkSta & fWiperParkYes)
2021                     ; 573                FRONT_WIPER_SLOW_OFF;
2023  03d7               LC001:
2025  03d7 7201002004    	btjf	_WiperParkSta,#0,L5411
2027  03dc 721d500f      	bres	20495,#6
2028  03e0               L5411:
2029                     ; 578     if(FRONT_WIPER_SLOW_OUT)
2031  03e0 720d500f22    	btjf	20495,#6,L5321
2032                     ; 580         HParktimeCNT++;
2034  03e5 ce0016        	ldw	x,L5011_HParktimeCNT
2035  03e8 5c            	incw	x
2036  03e9 cf0016        	ldw	L5011_HParktimeCNT,x
2037                     ; 581 		if(WiperParkSta & fWiperParkYes){ HParktimeCNT = 0;ParkDTCstate = 0;}
2039  03ec 7201002008    	btjf	_WiperParkSta,#0,L7321
2042  03f1 5f            	clrw	x
2043  03f2 cf0016        	ldw	L5011_HParktimeCNT,x
2046  03f5 725f0018      	clr	L7011_ParkDTCstate
2047  03f9               L7321:
2048                     ; 582 		if(HParktimeCNT > 2500)
2050  03f9 a309c5        	cpw	x,#2501
2051  03fc 250d          	jrult	L3421
2052                     ; 584             HParktimeCNT = 0;
2054  03fe 5f            	clrw	x
2055  03ff cf0016        	ldw	L5011_HParktimeCNT,x
2056                     ; 585 			ParkDTCstate = 0x55;
2058  0402 35550018      	mov	L7011_ParkDTCstate,#85
2060  0406 87            	retf	
2061  0407               L5321:
2062                     ; 590         HParktimeCNT = 0;
2064  0407 5f            	clrw	x
2065  0408 cf0016        	ldw	L5011_HParktimeCNT,x
2066  040b               L3421:
2067                     ; 595 }    
2070  040b 87            	retf	
2072                     	switch	.data
2073  0000               L5521_ignstate_old:
2074  0000 00            	dc.b	0
2075                     	switch	.bss
2076  0019               L7421_rWasherCnt:
2077  0019 0000          	ds.b	2
2078  001b               L5421_rWiperIntCnt:
2079  001b 0000          	ds.b	2
2080  001d               L1521_RParktimeCNT:
2081  001d 0000          	ds.b	2
2082  001f               L3521_RParkDTCstate:
2083  001f 00            	ds.b	1
2146                     ; 608 void JudgeRearWiperDriver(void)
2146                     ; 609 {
2147                     	switch	.text
2148  040c               f_JudgeRearWiperDriver:
2152                     ; 615 	if(RetCode == 0xffff)
2154                     ; 620     if((RParkDTCstate == 0x55) && (RearWiperDrv == RearWiperOff))
2156  040c c6001f        	ld	a,L3521_RParkDTCstate
2157  040f a155          	cp	a,#85
2158  0411 260c          	jrne	L5031
2160  0413 c60024        	ld	a,_RearWiperDrv
2161  0416 2607          	jrne	L5031
2162                     ; 623 		REAR_WIPER_OFF;
2164  0418 7213500a      	bres	20490,#1
2165                     ; 624 		RParkDTCstate = 0;
2167  041c c7001f        	ld	L3521_RParkDTCstate,a
2168  041f               L5031:
2169                     ; 626        if(ignstate_old != IGNstate)
2171  041f c60000        	ld	a,L5521_ignstate_old
2172  0422 c10000        	cp	a,_IGNstate
2173  0425 2713          	jreq	L7031
2174                     ; 628              ignstate_old = IGNstate;
2176  0427 c60000        	ld	a,_IGNstate
2177  042a c70000        	ld	L5521_ignstate_old,a
2178                     ; 629 	      if((IGNstate == ON)&&((WiperParkSta & rWiperParkYes)==0))REAR_WIPER_ON;    //20100719	 
2180  042d a155          	cp	a,#85
2181  042f 2609          	jrne	L7031
2183  0431 7202002004    	btjt	_WiperParkSta,#1,L7031
2186  0436 7212500a      	bset	20490,#1
2187  043a               L7031:
2188                     ; 634 	if (RearWiperDrv & RearWiperWasherOn2)
2190  043a 720500240c    	btjf	_RearWiperDrv,#2,L3131
2191                     ; 638              REAR_WIPER_ON;       
2193  043f 7212500a      	bset	20490,#1
2194                     ; 639              rWasherCnt = 0;
2196  0443 5f            	clrw	x
2197  0444 cf0019        	ldw	L7421_rWasherCnt,x
2198                     ; 640              rWiperIntCnt = 0;
2200  0447 ac120512      	jpf	LC004
2201  044b               L3131:
2202                     ; 642 	else if (RearWiperDrv & RearWiperWasherOn )		
2204  044b 5f            	clrw	x
2205  044c 7202002404ac  	btjf	_RearWiperDrv,#1,L7131
2206                     ; 647               rWiperIntCnt = 0;
2208  0455 cf001b        	ldw	L5421_rWiperIntCnt,x
2209                     ; 648 		if (rWasherCnt == 0)
2211  0458 ce0019        	ldw	x,L7421_rWasherCnt
2212  045b 2615          	jrne	L1231
2213                     ; 650                     REAR_WIPER_ON;
2215  045d 7212500a      	bset	20490,#1
2216                     ; 651                     if (WiperParkSta & rWiperParkYes)
2218  0461 7202002004ac  	btjf	_WiperParkSta,#1,L5131
2219                     ; 652                     rWasherCnt++;			// 1 cycle, in park position
2221  046a 5c            	incw	x
2222  046b cf0019        	ldw	L7421_rWasherCnt,x
2223  046e ac2a052a      	jra	L5131
2224  0472               L1231:
2225                     ; 654 		else if (rWasherCnt == 1)
2227  0472 a30001        	cpw	x,#1
2228  0475 2611          	jrne	L7231
2229                     ; 656                      REAR_WIPER_ON;
2231  0477 7212500a      	bset	20490,#1
2232                     ; 657                      if (!(WiperParkSta & rWiperParkYes))
2234  047b 72020020ee    	btjt	_WiperParkSta,#1,L5131
2235                     ; 658                      rWasherCnt++;			//exit park position
2237  0480 5c            	incw	x
2238  0481 cf0019        	ldw	L7421_rWasherCnt,x
2239  0484 ac2a052a      	jra	L5131
2240  0488               L7231:
2241                     ; 660 		else if (rWasherCnt == 2)
2243  0488 a30002        	cpw	x,#2
2244  048b 2611          	jrne	L5331
2245                     ; 662                      REAR_WIPER_ON;
2247  048d 7212500a      	bset	20490,#1
2248                     ; 663                      if (WiperParkSta & rWiperParkYes)
2250  0491 72030020ee    	btjf	_WiperParkSta,#1,L5131
2251                     ; 664                      rWasherCnt++;			// 2 cycle, in park position
2253  0496 5c            	incw	x
2254  0497 cf0019        	ldw	L7421_rWasherCnt,x
2255  049a ac2a052a      	jra	L5131
2256  049e               L5331:
2257                     ; 666 		else if (rWasherCnt == 3)
2259  049e a30003        	cpw	x,#3
2260  04a1 260f          	jrne	L3431
2261                     ; 668                      REAR_WIPER_ON;
2263  04a3 7212500a      	bset	20490,#1
2264                     ; 669                      if (!(WiperParkSta & rWiperParkYes))
2266  04a7 720200207e    	btjt	_WiperParkSta,#1,L5131
2267                     ; 670                      rWasherCnt++;			//exit park position
2269  04ac 5c            	incw	x
2270  04ad cf0019        	ldw	L7421_rWasherCnt,x
2271  04b0 2078          	jra	L5131
2272  04b2               L3431:
2273                     ; 672 		else if (rWasherCnt == 4)
2275  04b2 a30004        	cpw	x,#4
2276  04b5 260f          	jrne	L1531
2277                     ; 674                      REAR_WIPER_ON;
2279  04b7 7212500a      	bset	20490,#1
2280                     ; 675                      if (WiperParkSta & rWiperParkYes)
2282  04bb 720300206a    	btjf	_WiperParkSta,#1,L5131
2283                     ; 676                      rWasherCnt++;			// 3 cycle, in park position
2285  04c0 5c            	incw	x
2286  04c1 cf0019        	ldw	L7421_rWasherCnt,x
2287  04c4 2064          	jra	L5131
2288  04c6               L1531:
2289                     ; 678 		else if (rWasherCnt < WIPER_INT_PERIOD)
2291  04c6 a302ee        	cpw	x,#750
2292  04c9 240a          	jruge	L7531
2293                     ; 680 			REAR_WIPER_OFF;           
2295  04cb 7213500a      	bres	20490,#1
2296                     ; 681 			rWasherCnt++;				//stop 6s, in park position
2298  04cf 5c            	incw	x
2299  04d0 cf0019        	ldw	L7421_rWasherCnt,x
2301  04d3 2055          	jra	L5131
2302  04d5               L7531:
2303                     ; 683 		else if (rWasherCnt == WIPER_INT_PERIOD)
2305  04d5 a302ee        	cpw	x,#750
2306  04d8 2650          	jrne	L5131
2307                     ; 685 			REAR_WIPER_ON;				//start running 4 cycle
2309  04da 7212500a      	bset	20490,#1
2310                     ; 686 			if (!(WiperParkSta & rWiperParkYes))
2312  04de 7202002047    	btjt	_WiperParkSta,#1,L5131
2313                     ; 688 				rWasherCnt = 0;			// continue 4 cycle, exit park position
2315  04e3 5f            	clrw	x
2316  04e4 cf0019        	ldw	L7421_rWasherCnt,x
2317                     ; 690 				RearWiperDrv &= ~RearWiperWasherOn;
2319  04e7 72130024      	bres	_RearWiperDrv,#1
2320  04eb 203d          	jra	L5131
2321  04ed               L7131:
2322                     ; 694 	else if (RearWiperDrv & RearWiperIntOn)
2324  04ed 7201002425    	btjf	_RearWiperDrv,#0,L1731
2325                     ; 699               rWasherCnt = 0;
2327  04f2 cf0019        	ldw	L7421_rWasherCnt,x
2328                     ; 700 		if (rWiperIntCnt == 0)
2330  04f5 ce001b        	ldw	x,L5421_rWiperIntCnt
2331  04f8 260c          	jrne	L3731
2332                     ; 702 			REAR_WIPER_ON;
2334  04fa 7212500a      	bset	20490,#1
2335                     ; 703 			if (!(WiperParkSta & rWiperParkYes))
2337  04fe 7202002027    	btjt	_WiperParkSta,#1,L5131
2338                     ; 704 				rWiperIntCnt++;
2340  0503 5c            	incw	x
2341  0504 200c          	jpf	LC004
2342  0506               L3731:
2343                     ; 706 		else if ( rWiperIntCnt < WIPER_INT_PERIOD)
2345  0506 a302ee        	cpw	x,#750
2346  0509 2406          	jruge	L1041
2347                     ; 708 			rWiperIntCnt++; 	
2349  050b 5c            	incw	x
2350  050c cf001b        	ldw	L5421_rWiperIntCnt,x
2351                     ; 709 			if (WiperParkSta & rWiperParkYes)
2352                     ; 711 				REAR_WIPER_OFF; 
2353  050f 2010          	jpf	LC003
2354  0511               L1041:
2355                     ; 716 			rWiperIntCnt = 0;
2357  0511 5f            	clrw	x
2358  0512               LC004:
2360  0512 cf001b        	ldw	L5421_rWiperIntCnt,x
2361  0515 2013          	jra	L5131
2362  0517               L1731:
2363                     ; 724 		rWasherCnt = 0;
2365  0517 cf0019        	ldw	L7421_rWasherCnt,x
2366                     ; 725 		rWiperIntCnt = 0;
2368  051a cf001b        	ldw	L5421_rWiperIntCnt,x
2369                     ; 726 		RearWiperDrv = RearWiperOff;
2371  051d 725f0024      	clr	_RearWiperDrv
2372                     ; 727 		if (WiperParkSta & rWiperParkYes)
2374                     ; 729 		    REAR_WIPER_OFF;
2376  0521               LC003:
2378  0521 7203002004    	btjf	_WiperParkSta,#1,L5131
2380  0526 7213500a      	bres	20490,#1
2381  052a               L5131:
2382                     ; 734     if(REAR_WIPER_OUT)
2384  052a 7203500a22    	btjf	20490,#1,L3141
2385                     ; 736     	RParktimeCNT++;
2387  052f ce001d        	ldw	x,L1521_RParktimeCNT
2388  0532 5c            	incw	x
2389  0533 cf001d        	ldw	L1521_RParktimeCNT,x
2390                     ; 737     	if(WiperParkSta & fWiperParkYes){ RParktimeCNT = 0;RParkDTCstate = 0;}
2392  0536 7201002008    	btjf	_WiperParkSta,#0,L5141
2395  053b 5f            	clrw	x
2396  053c cf001d        	ldw	L1521_RParktimeCNT,x
2399  053f 725f001f      	clr	L3521_RParkDTCstate
2400  0543               L5141:
2401                     ; 738     	if(RParktimeCNT > 2500)
2403  0543 a309c5        	cpw	x,#2501
2404  0546 250d          	jrult	L1241
2405                     ; 740     		RParktimeCNT = 0;
2407  0548 5f            	clrw	x
2408  0549 cf001d        	ldw	L1521_RParktimeCNT,x
2409                     ; 741     		RParkDTCstate = 0x55;
2411  054c 3555001f      	mov	L3521_RParkDTCstate,#85
2413  0550 87            	retf	
2414  0551               L3141:
2415                     ; 746     	RParktimeCNT = 0;
2417  0551 5f            	clrw	x
2418  0552 cf001d        	ldw	L1521_RParktimeCNT,x
2419  0555               L1241:
2420                     ; 750 } 
2423  0555 87            	retf	
2472                     	xdef	f_ScanWasherSwitch
2473                     	xdef	f_ScanWiperParkSignal
2474                     	xdef	f_GetFrontWiperIntTime
2475                     	switch	.bss
2476  0020               _WiperParkSta:
2477  0020 00            	ds.b	1
2478                     	xdef	_WiperParkSta
2479                     	xref	f_GetADCresultAverage
2480                     	xref	_H4021Data2
2481                     	xref	_IGNstate
2482                     	xref	_RetCode
2483                     	xref	_VehicleType
2484                     	xdef	f_JudgeRearWiperDriver
2485                     	xdef	f_JudgeFrontWiperDriver
2486                     	xdef	f_ScanWiperSwitch
2487  0021               _FrontWiperHighDrv:
2488  0021 00            	ds.b	1
2489                     	xdef	_FrontWiperHighDrv
2490  0022               _FrontWiperIntTime:
2491  0022 0000          	ds.b	2
2492                     	xdef	_FrontWiperIntTime
2493  0024               _RearWiperDrv:
2494  0024 00            	ds.b	1
2495                     	xdef	_RearWiperDrv
2496  0025               _FrontWiperDrv:
2497  0025 00            	ds.b	1
2498                     	xdef	_FrontWiperDrv
2518                     	end
