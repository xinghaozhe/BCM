   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 825                     ; 34 void UDSDTC_main(void)
 825                     ; 35 {
 826                     	switch	.text
 827  0000               f_UDSDTC_main:
 831                     ; 36      if(DTCRuningstate != 0) return;
 833  0000 c60000        	ld	a,_DTCRuningstate
 834  0003 2701          	jreq	L154
 838  0005 87            	retf	
 839  0006               L154:
 840                     ; 38      UDSDTC9001();
 842  0006 8d5a005a      	callf	f_UDSDTC9001
 844                     ; 40 	 UDSDTC9003();
 846  000a 8df000f0      	callf	f_UDSDTC9003
 848                     ; 42 	 UDSDTC9015();
 850  000e 8d8a018a      	callf	f_UDSDTC9015
 852                     ; 44 	 UDSDTC9111();
 854  0012 8d1a021a      	callf	f_UDSDTC9111
 856                     ; 46 	 UDSDTC9091();
 858  0016 8daa02aa      	callf	f_UDSDTC9091
 860                     ; 48 	 UDSDTC9083();
 862  001a 8d060306      	callf	f_UDSDTC9083
 864                     ; 50 	 UDSDTC9011();
 866  001e 8d5f035f      	callf	f_UDSDTC9011
 868                     ; 52 	 UDSDTC9023();
 870  0022 8d0a040a      	callf	f_UDSDTC9023
 872                     ; 54 	 UDSDTC9007();
 874  0026 8db504b5      	callf	f_UDSDTC9007
 876                     ; 56 	 UDSDTC9043();
 878  002a 8d600560      	callf	f_UDSDTC9043
 880                     ; 58 	 UDSDTC9093();
 882  002e 8d020602      	callf	f_UDSDTC9093
 884                     ; 60 	 UDSDTC9061();
 886  0032 8d870687      	callf	f_UDSDTC9061
 888                     ; 62 	 UDSDTC9067();
 890  0036 8d880688      	callf	f_UDSDTC9067
 892                     ; 64 	 UDSDTC9045();
 894  003a 8d890689      	callf	f_UDSDTC9045
 896                     ; 66 	 UDSDTC9073();
 898  003e 8d650765      	callf	f_UDSDTC9073
 900                     ; 68 	 UDSDTC900c();
 902  0042 8dba07ba      	callf	f_UDSDTC900c
 904                     ; 70 	 UDSDTCd001();
 906  0046 8dbb07bb      	callf	f_UDSDTCd001
 908                     ; 72 	 UDSDTCd002();
 910  004a 8d560856      	callf	f_UDSDTCd002
 912                     ; 74 	 UDSDTCd003();
 914  004e 8d0b090b      	callf	f_UDSDTCd003
 916                     ; 76 	 UDSDTCd004();
 918  0052 8d570957      	callf	f_UDSDTCd004
 920                     ; 78 	 UDSDTCd005();
 923                     ; 80 }
 926  0056 aca309a3      	jpf	f_UDSDTCd005
 928                     	switch	.data
 929  0000               L354_dtctime:
 930  0000 0000          	dc.w	0
 931  0002               L554_dtctime2:
 932  0002 0000          	dc.w	0
 973                     ; 83 void UDSDTC9001(void)
 973                     ; 84 {
 974                     	switch	.text
 975  005a               f_UDSDTC9001:
 979                     ; 88      if(TurnLampState & TLL_IS_OPEN)
 981  005a 720300000c    	btjf	_TurnLampState,#1,L574
 982                     ; 90         if((DTCstate[DTC9001] & DTCcycleFail)==0)
 984  005f 7202000025    	btjt	_DTCstate,#1,L105
 985                     ; 93 			Weeprommain((unsigned long)(&DTCstate[DTC9001]),DTCstate[DTC9001] | DTCcycleFail);
 987  0064 c60000        	ld	a,_DTCstate
 988  0067 aa02          	or	a,#2
 991  0069 200a          	jpf	LC001
 992  006b               L574:
 993                     ; 98 	    if((DTCstate[DTC9001] & DTCcycleFail)!=0)
 995  006b 7203000019    	btjf	_DTCstate,#1,L105
 996                     ; 101 			Weeprommain((unsigned long)(&DTCstate[DTC9001]),DTCstate[DTC9001] & (~DTCcycleFail));
 998  0070 c60000        	ld	a,_DTCstate
 999  0073 a4fd          	and	a,#253
1002  0075               LC001:
1003  0075 88            	push	a
1004  0076 ae0000        	ldw	x,#_DTCstate
1005  0079 8d000000      	callf	d_uitolx
1006  007d be02          	ldw	x,c_lreg+2
1007  007f 89            	pushw	x
1008  0080 be00          	ldw	x,c_lreg
1009  0082 89            	pushw	x
1010  0083 8d000000      	callf	f_Weeprommain
1011  0087 5b05          	addw	sp,#5
1012  0089               L105:
1013                     ; 105      if((TurnLampDrv &  TurnLampLeftOn )&&(TurnLampState & TLL_IS_OPEN))
1015  0089 7201000022    	btjf	_TurnLampDrv,#0,L505
1017  008e 720300001d    	btjf	_TurnLampState,#1,L505
1018                     ; 107           dtctime2 = 0;
1020  0093 5f            	clrw	x
1021  0094 cf0002        	ldw	L554_dtctime2,x
1022                     ; 108           if(dtctime < DTC10000MS) dtctime++;
1024  0097 ce0000        	ldw	x,L354_dtctime
1025  009a a304e2        	cpw	x,#1250
1026  009d 2405          	jruge	L705
1029  009f 5c            	incw	x
1030  00a0 cf0000        	ldw	L354_dtctime,x
1033  00a3 87            	retf	
1034  00a4               L705:
1035                     ; 111 		        if((DTCstate[DTC9001] & DTCconfirmed)==0)
1037  00a4 7206000046    	btjt	_DTCstate,#3,L515
1038                     ; 114 					Weeprommain((unsigned long)(&DTCstate[DTC9001]),DTCstate[DTC9001] | DTCconfirmed);
1040  00a9 c60000        	ld	a,_DTCstate
1041  00ac aa08          	or	a,#8
1044  00ae 2023          	jpf	LC003
1045  00b0               L505:
1046                     ; 119 	 else if((TurnLampDrv &  TurnLampLeftOn )&&((TurnLampState & TLL_IS_OPEN)==0))
1048  00b0 7201000033    	btjf	_TurnLampDrv,#0,L715
1050  00b5 720200002e    	btjt	_TurnLampState,#1,L715
1051                     ; 121 	      dtctime = 0;
1053  00ba 5f            	clrw	x
1054  00bb cf0000        	ldw	L354_dtctime,x
1055                     ; 122           if(dtctime2 < DTC10000MS) dtctime2++;
1057  00be ce0002        	ldw	x,L554_dtctime2
1058  00c1 a304e2        	cpw	x,#1250
1059  00c4 2403          	jruge	L125
1062  00c6 5c            	incw	x
1064  00c7 2023          	jpf	LC002
1065  00c9               L125:
1066                     ; 125 		        if((DTCstate[DTC9001] & DTCconfirmed)!=0)
1068  00c9 7207000021    	btjf	_DTCstate,#3,L515
1069                     ; 128 					Weeprommain((unsigned long)(&DTCstate[DTC9001]),DTCstate[DTC9001] & (~DTCconfirmed));
1071  00ce c60000        	ld	a,_DTCstate
1072  00d1 a4f7          	and	a,#247
1075  00d3               LC003:
1076  00d3 88            	push	a
1077  00d4 ae0000        	ldw	x,#_DTCstate
1078  00d7 8d000000      	callf	d_uitolx
1079  00db be02          	ldw	x,c_lreg+2
1080  00dd 89            	pushw	x
1081  00de be00          	ldw	x,c_lreg
1082  00e0 89            	pushw	x
1083  00e1 8d000000      	callf	f_Weeprommain
1084  00e5 5b05          	addw	sp,#5
1086  00e7 87            	retf	
1087  00e8               L715:
1088                     ; 135 		dtctime = 0 ;
1090  00e8 5f            	clrw	x
1091  00e9 cf0000        	ldw	L354_dtctime,x
1092                     ; 136 		dtctime2 = 0;
1094  00ec               LC002:
1095  00ec cf0002        	ldw	L554_dtctime2,x
1096  00ef               L515:
1097                     ; 139 }
1100  00ef 87            	retf	
1102                     	switch	.data
1103  0004               L135_dtctime:
1104  0004 0000          	dc.w	0
1105  0006               L335_dtctime2:
1106  0006 0000          	dc.w	0
1147                     ; 141 void UDSDTC9003(void)
1147                     ; 142 {
1148                     	switch	.text
1149  00f0               f_UDSDTC9003:
1153                     ; 147      if(TurnLampState & TLR_IS_OPEN)
1155  00f0 7207000010    	btjf	_TurnLampState,#3,L355
1156                     ; 149         if((DTCstate[DTC9003] & DTCcycleFail)==0)
1158  00f5 7202000129    	btjt	_DTCstate+1,#1,L755
1159                     ; 151          	DTCstate[DTC9003] |= DTCcycleFail;
1161  00fa 72120001      	bset	_DTCstate+1,#1
1162                     ; 152 			Weeprommain((unsigned long)(&DTCstate[DTC9003]),DTCstate[DTC9003] | DTCcycleFail);
1164  00fe c60001        	ld	a,_DTCstate+1
1165  0101 aa02          	or	a,#2
1168  0103 200a          	jpf	LC004
1169  0105               L355:
1170                     ; 157 	    if((DTCstate[DTC9003] & DTCcycleFail)!=0)
1172  0105 7203000119    	btjf	_DTCstate+1,#1,L755
1173                     ; 160 			Weeprommain((unsigned long)(&DTCstate[DTC9003]),DTCstate[DTC9003] & (~DTCcycleFail));
1175  010a c60001        	ld	a,_DTCstate+1
1176  010d a4fd          	and	a,#253
1179  010f               LC004:
1180  010f 88            	push	a
1181  0110 ae0001        	ldw	x,#_DTCstate+1
1182  0113 8d000000      	callf	d_uitolx
1183  0117 be02          	ldw	x,c_lreg+2
1184  0119 89            	pushw	x
1185  011a be00          	ldw	x,c_lreg
1186  011c 89            	pushw	x
1187  011d 8d000000      	callf	f_Weeprommain
1188  0121 5b05          	addw	sp,#5
1189  0123               L755:
1190                     ; 164      if((TurnLampDrv &  TurnLampRightOn )&&(TurnLampState & TLR_IS_OPEN))
1192  0123 7203000022    	btjf	_TurnLampDrv,#1,L365
1194  0128 720700001d    	btjf	_TurnLampState,#3,L365
1195                     ; 166           dtctime2 = 0;
1197  012d 5f            	clrw	x
1198  012e cf0006        	ldw	L335_dtctime2,x
1199                     ; 167           if(dtctime < DTC10000MS) dtctime++;
1201  0131 ce0004        	ldw	x,L135_dtctime
1202  0134 a304e2        	cpw	x,#1250
1203  0137 2405          	jruge	L565
1206  0139 5c            	incw	x
1207  013a cf0004        	ldw	L135_dtctime,x
1210  013d 87            	retf	
1211  013e               L565:
1212                     ; 170 		        if((DTCstate[DTC9003] & DTCconfirmed)==0)
1214  013e 7206000146    	btjt	_DTCstate+1,#3,L375
1215                     ; 173 					Weeprommain((unsigned long)(&DTCstate[DTC9003]),DTCstate[DTC9003] | DTCconfirmed);
1217  0143 c60001        	ld	a,_DTCstate+1
1218  0146 aa08          	or	a,#8
1221  0148 2023          	jpf	LC006
1222  014a               L365:
1223                     ; 180 	 else if((TurnLampDrv &  TurnLampRightOn)&&((TurnLampState & TLR_IS_OPEN)==0))
1225  014a 7203000033    	btjf	_TurnLampDrv,#1,L575
1227  014f 720600002e    	btjt	_TurnLampState,#3,L575
1228                     ; 182 	      dtctime = 0;
1230  0154 5f            	clrw	x
1231  0155 cf0004        	ldw	L135_dtctime,x
1232                     ; 183           if(dtctime2 < DTC10000MS) dtctime2++;
1234  0158 ce0006        	ldw	x,L335_dtctime2
1235  015b a304e2        	cpw	x,#1250
1236  015e 2403          	jruge	L775
1239  0160 5c            	incw	x
1241  0161 2023          	jpf	LC005
1242  0163               L775:
1243                     ; 186 		        if((DTCstate[DTC9003] & DTCconfirmed)!=0)
1245  0163 7207000121    	btjf	_DTCstate+1,#3,L375
1246                     ; 189 					Weeprommain((unsigned long)(&DTCstate[DTC9003]),DTCstate[DTC9003] & (~DTCconfirmed));
1248  0168 c60001        	ld	a,_DTCstate+1
1249  016b a4f7          	and	a,#247
1252  016d               LC006:
1253  016d 88            	push	a
1254  016e ae0001        	ldw	x,#_DTCstate+1
1255  0171 8d000000      	callf	d_uitolx
1256  0175 be02          	ldw	x,c_lreg+2
1257  0177 89            	pushw	x
1258  0178 be00          	ldw	x,c_lreg
1259  017a 89            	pushw	x
1260  017b 8d000000      	callf	f_Weeprommain
1261  017f 5b05          	addw	sp,#5
1263  0181 87            	retf	
1264  0182               L575:
1265                     ; 196 		dtctime = 0 ;
1267  0182 5f            	clrw	x
1268  0183 cf0004        	ldw	L135_dtctime,x
1269                     ; 197 		dtctime2 = 0;
1271  0186               LC005:
1272  0186 cf0006        	ldw	L335_dtctime2,x
1273  0189               L375:
1274                     ; 199 }
1277  0189 87            	retf	
1279                     	switch	.data
1280  0008               L706_dtctime:
1281  0008 0000          	dc.w	0
1282  000a               L116_dtctime2:
1283  000a 0000          	dc.w	0
1323                     ; 201 void UDSDTC9015(void)
1323                     ; 202 {
1324                     	switch	.text
1325  018a               f_UDSDTC9015:
1329                     ; 206      if(battervalue > Batter16V)
1331  018a ce0000        	ldw	x,_battervalue
1332  018d a303e7        	cpw	x,#999
1333  0190 5f            	clrw	x
1334  0191 253a          	jrult	L136
1335                     ; 208         dtctime2 = 0;
1337  0193 cf000a        	ldw	L116_dtctime2,x
1338                     ; 210         if((DTCstate[DTC9015] & DTCcycleFail)==0)
1340  0196 7202000219    	btjt	_DTCstate+2,#1,L336
1341                     ; 213 			Weeprommain((unsigned long)(&DTCstate[DTC9015]),DTCstate[DTC9015] | DTCcycleFail);
1343  019b c60002        	ld	a,_DTCstate+2
1344  019e aa02          	or	a,#2
1345  01a0 88            	push	a
1346  01a1 ae0002        	ldw	x,#_DTCstate+2
1347  01a4 8d000000      	callf	d_uitolx
1349  01a8 be02          	ldw	x,c_lreg+2
1350  01aa 89            	pushw	x
1351  01ab be00          	ldw	x,c_lreg
1352  01ad 89            	pushw	x
1353  01ae 8d000000      	callf	f_Weeprommain
1355  01b2 5b05          	addw	sp,#5
1356  01b4               L336:
1357                     ; 216 		if(dtctime < DTC10000MS)dtctime++;
1359  01b4 ce0008        	ldw	x,L706_dtctime
1360  01b7 a304e2        	cpw	x,#1250
1361  01ba 2405          	jruge	L536
1364  01bc 5c            	incw	x
1365  01bd cf0008        	ldw	L706_dtctime,x
1368  01c0 87            	retf	
1369  01c1               L536:
1370                     ; 219 			if((DTCstate[DTC9015] & DTCconfirmed)==0)
1372  01c1 7206000253    	btjt	_DTCstate+2,#3,L346
1373                     ; 222 				Weeprommain((unsigned long)(&DTCstate[DTC9015]),DTCstate[DTC9015] | DTCconfirmed);
1375  01c6 c60002        	ld	a,_DTCstate+2
1376  01c9 aa08          	or	a,#8
1379  01cb 2038          	jpf	LC007
1380  01cd               L136:
1381                     ; 229 	    dtctime = 0;
1383  01cd cf0008        	ldw	L706_dtctime,x
1384                     ; 231 	    if((DTCstate[DTC9015] & DTCcycleFail)!=0)
1386  01d0 7203000219    	btjf	_DTCstate+2,#1,L546
1387                     ; 234 			Weeprommain((unsigned long)(&DTCstate[DTC9015]),DTCstate[DTC9015] & (~DTCcycleFail));
1389  01d5 c60002        	ld	a,_DTCstate+2
1390  01d8 a4fd          	and	a,#253
1391  01da 88            	push	a
1392  01db ae0002        	ldw	x,#_DTCstate+2
1393  01de 8d000000      	callf	d_uitolx
1395  01e2 be02          	ldw	x,c_lreg+2
1396  01e4 89            	pushw	x
1397  01e5 be00          	ldw	x,c_lreg
1398  01e7 89            	pushw	x
1399  01e8 8d000000      	callf	f_Weeprommain
1401  01ec 5b05          	addw	sp,#5
1402  01ee               L546:
1403                     ; 237 		if(dtctime2 < DTC1Min)dtctime2++;
1405  01ee ce000a        	ldw	x,L116_dtctime2
1406  01f1 a31d4c        	cpw	x,#7500
1407  01f4 2405          	jruge	L746
1410  01f6 5c            	incw	x
1411  01f7 cf000a        	ldw	L116_dtctime2,x
1414  01fa 87            	retf	
1415  01fb               L746:
1416                     ; 240 			if((DTCstate[DTC9015] & DTCconfirmed)!=0)
1418  01fb 7207000219    	btjf	_DTCstate+2,#3,L346
1419                     ; 243 				Weeprommain((unsigned long)(&DTCstate[DTC9015]),DTCstate[DTC9015] & (~DTCconfirmed));
1421  0200 c60002        	ld	a,_DTCstate+2
1422  0203 a4f7          	and	a,#247
1425  0205               LC007:
1426  0205 88            	push	a
1427  0206 ae0002        	ldw	x,#_DTCstate+2
1428  0209 8d000000      	callf	d_uitolx
1429  020d be02          	ldw	x,c_lreg+2
1430  020f 89            	pushw	x
1431  0210 be00          	ldw	x,c_lreg
1432  0212 89            	pushw	x
1433  0213 8d000000      	callf	f_Weeprommain
1434  0217 5b05          	addw	sp,#5
1435  0219               L346:
1436                     ; 248 }
1439  0219 87            	retf	
1441                     	switch	.data
1442  000c               L556_dtctime:
1443  000c 0000          	dc.w	0
1444  000e               L756_dtctime2:
1445  000e 0000          	dc.w	0
1485                     ; 249 void UDSDTC9111(void)
1485                     ; 250 {
1486                     	switch	.text
1487  021a               f_UDSDTC9111:
1491                     ; 254      if(battervalue < Batter9V)
1493  021a ce0000        	ldw	x,_battervalue
1494  021d a30214        	cpw	x,#532
1495  0220 5f            	clrw	x
1496  0221 243a          	jruge	L776
1497                     ; 256         dtctime2 = 0;
1499  0223 cf000e        	ldw	L756_dtctime2,x
1500                     ; 258         if((DTCstate[DTC9111] & DTCcycleFail)==0)
1502  0226 7202000319    	btjt	_DTCstate+3,#1,L107
1503                     ; 261 			Weeprommain((unsigned long)(&DTCstate[DTC9111]),DTCstate[DTC9111] | DTCcycleFail);
1505  022b c60003        	ld	a,_DTCstate+3
1506  022e aa02          	or	a,#2
1507  0230 88            	push	a
1508  0231 ae0003        	ldw	x,#_DTCstate+3
1509  0234 8d000000      	callf	d_uitolx
1511  0238 be02          	ldw	x,c_lreg+2
1512  023a 89            	pushw	x
1513  023b be00          	ldw	x,c_lreg
1514  023d 89            	pushw	x
1515  023e 8d000000      	callf	f_Weeprommain
1517  0242 5b05          	addw	sp,#5
1518  0244               L107:
1519                     ; 264 		if(dtctime < DTC10000MS)dtctime++;
1521  0244 ce000c        	ldw	x,L556_dtctime
1522  0247 a304e2        	cpw	x,#1250
1523  024a 2405          	jruge	L307
1526  024c 5c            	incw	x
1527  024d cf000c        	ldw	L556_dtctime,x
1530  0250 87            	retf	
1531  0251               L307:
1532                     ; 267 			if((DTCstate[DTC9111] & DTCconfirmed)==0)
1534  0251 7206000353    	btjt	_DTCstate+3,#3,L117
1535                     ; 270 				Weeprommain((unsigned long)(&DTCstate[DTC9111]),DTCstate[DTC9111] | DTCconfirmed);
1537  0256 c60003        	ld	a,_DTCstate+3
1538  0259 aa08          	or	a,#8
1541  025b 2038          	jpf	LC008
1542  025d               L776:
1543                     ; 276 	    dtctime = 0;
1545  025d cf000c        	ldw	L556_dtctime,x
1546                     ; 278 	    if((DTCstate[DTC9111] & DTCcycleFail)!=0)
1548  0260 7203000319    	btjf	_DTCstate+3,#1,L317
1549                     ; 281 			Weeprommain((unsigned long)(&DTCstate[DTC9111]),DTCstate[DTC9111] & (~DTCcycleFail));
1551  0265 c60003        	ld	a,_DTCstate+3
1552  0268 a4fd          	and	a,#253
1553  026a 88            	push	a
1554  026b ae0003        	ldw	x,#_DTCstate+3
1555  026e 8d000000      	callf	d_uitolx
1557  0272 be02          	ldw	x,c_lreg+2
1558  0274 89            	pushw	x
1559  0275 be00          	ldw	x,c_lreg
1560  0277 89            	pushw	x
1561  0278 8d000000      	callf	f_Weeprommain
1563  027c 5b05          	addw	sp,#5
1564  027e               L317:
1565                     ; 284 		if(dtctime2 < DTC1Min)dtctime2++;
1567  027e ce000e        	ldw	x,L756_dtctime2
1568  0281 a31d4c        	cpw	x,#7500
1569  0284 2405          	jruge	L517
1572  0286 5c            	incw	x
1573  0287 cf000e        	ldw	L756_dtctime2,x
1576  028a 87            	retf	
1577  028b               L517:
1578                     ; 287 			if((DTCstate[DTC9111] & DTCconfirmed)!=0)
1580  028b 7207000319    	btjf	_DTCstate+3,#3,L117
1581                     ; 290 				Weeprommain((unsigned long)(&DTCstate[DTC9111]),DTCstate[DTC9111] & (~DTCconfirmed));
1583  0290 c60003        	ld	a,_DTCstate+3
1584  0293 a4f7          	and	a,#247
1587  0295               LC008:
1588  0295 88            	push	a
1589  0296 ae0003        	ldw	x,#_DTCstate+3
1590  0299 8d000000      	callf	d_uitolx
1591  029d be02          	ldw	x,c_lreg+2
1592  029f 89            	pushw	x
1593  02a0 be00          	ldw	x,c_lreg
1594  02a2 89            	pushw	x
1595  02a3 8d000000      	callf	f_Weeprommain
1596  02a7 5b05          	addw	sp,#5
1597  02a9               L117:
1598                     ; 294 }
1601  02a9 87            	retf	
1603                     	switch	.data
1604  0010               L327_lockstatetime:
1605  0010 00            	dc.b	0
1606  0011               L527_lockcnt:
1607  0011 00            	dc.b	0
1648                     ; 296 void UDSDTC9091(void)
1648                     ; 297 {
1649                     	switch	.text
1650  02aa               f_UDSDTC9091:
1654                     ; 300      if(LockDrvCmd & UnlockDriverDoorCmd)
1656  02aa 720f000004    	btjf	_LockDrvCmd,#7,L547
1657                     ; 302 		lockstatetime = 10;
1659  02af 350a0010      	mov	L327_lockstatetime,#10
1660  02b3               L547:
1661                     ; 304 	 if(lockstatetime)
1663  02b3 c60010        	ld	a,L327_lockstatetime
1664  02b6 274d          	jreq	L747
1665                     ; 306         lockstatetime--;
1667  02b8 725a0010      	dec	L327_lockstatetime
1668                     ; 307 		if(lockstatetime == 0)
1670  02bc 2647          	jrne	L747
1671                     ; 309             if(LockState == Locked)
1673  02be c60000        	ld	a,_LockState
1674  02c1 a155          	cp	a,#85
1675  02c3 2610          	jrne	L357
1676                     ; 311                 lockcnt = 0;
1678  02c5 725f0011      	clr	L527_lockcnt
1679                     ; 312 				if((DTCstate[DTC9091] & DTCconfirmed)==0)
1681  02c9 7206000437    	btjt	_DTCstate+4,#3,L747
1682                     ; 315 					Weeprommain((unsigned long)(&DTCstate[DTC9091]),DTCstate[DTC9091] | DTCconfirmed);
1684  02ce c60004        	ld	a,_DTCstate+4
1685  02d1 aa08          	or	a,#8
1688  02d3 201c          	jpf	LC009
1689  02d5               L357:
1690                     ; 320                 if(lockcnt < 12)lockcnt++;
1692  02d5 c60011        	ld	a,L527_lockcnt
1693  02d8 a10c          	cp	a,#12
1694  02da 2407          	jruge	L167
1697  02dc 725c0011      	inc	L527_lockcnt
1698  02e0 c60011        	ld	a,L527_lockcnt
1699  02e3               L167:
1700                     ; 321 				if(lockcnt > 10)
1702  02e3 a10b          	cp	a,#11
1703  02e5 251e          	jrult	L747
1704                     ; 323 					if((DTCstate[DTC9091] & DTCconfirmed)!=0)
1706  02e7 7207000419    	btjf	_DTCstate+4,#3,L747
1707                     ; 326 						Weeprommain((unsigned long)(&DTCstate[DTC9091]),DTCstate[DTC9091] & (~DTCconfirmed));
1709  02ec c60004        	ld	a,_DTCstate+4
1710  02ef a4f7          	and	a,#247
1713  02f1               LC009:
1714  02f1 88            	push	a
1715  02f2 ae0004        	ldw	x,#_DTCstate+4
1716  02f5 8d000000      	callf	d_uitolx
1717  02f9 be02          	ldw	x,c_lreg+2
1718  02fb 89            	pushw	x
1719  02fc be00          	ldw	x,c_lreg
1720  02fe 89            	pushw	x
1721  02ff 8d000000      	callf	f_Weeprommain
1722  0303 5b05          	addw	sp,#5
1723  0305               L747:
1724                     ; 332 }
1727  0305 87            	retf	
1729                     	switch	.data
1730  0012               L767_lockstatetime:
1731  0012 00            	dc.b	0
1732  0013               L177_lockcnt:
1733  0013 00            	dc.b	0
1774                     ; 335 void UDSDTC9083(void)
1774                     ; 336 {
1775                     	switch	.text
1776  0306               f_UDSDTC9083:
1780                     ; 339      if(LockDrvCmd & LockCmd)
1782  0306 720b000004    	btjf	_LockDrvCmd,#5,L1101
1783                     ; 341 		lockstatetime = 10;
1785  030b 350a0012      	mov	L767_lockstatetime,#10
1786  030f               L1101:
1787                     ; 343 	 if(lockstatetime)
1789  030f c60012        	ld	a,L767_lockstatetime
1790  0312 274a          	jreq	L3101
1791                     ; 345         lockstatetime--;
1793  0314 725a0012      	dec	L767_lockstatetime
1794                     ; 346 		if(lockstatetime == 0)
1796  0318 2644          	jrne	L3101
1797                     ; 348             if(LockState == Unlocked)
1799  031a c60000        	ld	a,_LockState
1800  031d 260f          	jrne	L7101
1801                     ; 350                 lockcnt = 0;
1803  031f c70013        	ld	L177_lockcnt,a
1804                     ; 351 				if((DTCstate[DTC9083] & DTCconfirmed)==0)
1806  0322 7206000537    	btjt	_DTCstate+5,#3,L3101
1807                     ; 354 					Weeprommain((unsigned long)(&DTCstate[DTC9083]),DTCstate[DTC9083] | DTCconfirmed);
1809  0327 c60005        	ld	a,_DTCstate+5
1810  032a aa08          	or	a,#8
1813  032c 201c          	jpf	LC010
1814  032e               L7101:
1815                     ; 359                 if(lockcnt < 12)lockcnt++;
1817  032e c60013        	ld	a,L177_lockcnt
1818  0331 a10c          	cp	a,#12
1819  0333 2407          	jruge	L5201
1822  0335 725c0013      	inc	L177_lockcnt
1823  0339 c60013        	ld	a,L177_lockcnt
1824  033c               L5201:
1825                     ; 360 				if(lockcnt > 10)
1827  033c a10b          	cp	a,#11
1828  033e 251e          	jrult	L3101
1829                     ; 362 					if((DTCstate[DTC9083] & DTCconfirmed)!=0)
1831  0340 7207000519    	btjf	_DTCstate+5,#3,L3101
1832                     ; 365 						Weeprommain((unsigned long)(&DTCstate[DTC9083]),DTCstate[DTC9083] & (~DTCconfirmed));
1834  0345 c60005        	ld	a,_DTCstate+5
1835  0348 a4f7          	and	a,#247
1838  034a               LC010:
1839  034a 88            	push	a
1840  034b ae0005        	ldw	x,#_DTCstate+5
1841  034e 8d000000      	callf	d_uitolx
1842  0352 be02          	ldw	x,c_lreg+2
1843  0354 89            	pushw	x
1844  0355 be00          	ldw	x,c_lreg
1845  0357 89            	pushw	x
1846  0358 8d000000      	callf	f_Weeprommain
1847  035c 5b05          	addw	sp,#5
1848  035e               L3101:
1849                     ; 371 }
1852  035e 87            	retf	
1854                     	switch	.bss
1855  0000               L3301_lockcnt:
1856  0000 00            	ds.b	1
1857  0001               L7301_dtccnt2:
1858  0001 00            	ds.b	1
1859  0002               L5301_dtccnt1:
1860  0002 00            	ds.b	1
1908                     ; 373 void UDSDTC9011(void)
1908                     ; 374 {
1909                     	switch	.text
1910  035f               f_UDSDTC9011:
1914                     ; 377      if(LockState == Locked)
1916  035f c60000        	ld	a,_LockState
1917  0362 a155          	cp	a,#85
1918  0364 2704ac090409  	jrne	L1601
1919                     ; 379          if(lockcnt < DTC48MS) lockcnt++;
1921  036a c60000        	ld	a,L3301_lockcnt
1922  036d a106          	cp	a,#6
1923  036f 2405          	jruge	L3601
1926  0371 725c0000      	inc	L3301_lockcnt
1929  0375 87            	retf	
1930  0376               L3601:
1931                     ; 380 		 else if(lockcnt == DTC48MS)
1933  0376 a106          	cp	a,#6
1934  0378 26ec          	jrne	L1601
1935                     ; 382 		 	 lockcnt++;
1937  037a 725c0000      	inc	L3301_lockcnt
1938                     ; 383 			 if(DoorState & DriverDoorIsOpen)
1940  037e 720100003a    	btjf	_DoorState,#0,L1701
1941                     ; 385 	             dtccnt2 = 0;
1943  0383 725f0001      	clr	L7301_dtccnt2
1944                     ; 387 		        if((DTCstate[DTC9011] & DTCcycleFail)==0)
1946  0387 7202000619    	btjt	_DTCstate+6,#1,L3701
1947                     ; 390 					Weeprommain((unsigned long)(&DTCstate[DTC9011]),DTCstate[DTC9011] | DTCcycleFail);
1949  038c c60006        	ld	a,_DTCstate+6
1950  038f aa02          	or	a,#2
1951  0391 88            	push	a
1952  0392 ae0006        	ldw	x,#_DTCstate+6
1953  0395 8d000000      	callf	d_uitolx
1955  0399 be02          	ldw	x,c_lreg+2
1956  039b 89            	pushw	x
1957  039c be00          	ldw	x,c_lreg
1958  039e 89            	pushw	x
1959  039f 8d000000      	callf	f_Weeprommain
1961  03a3 5b05          	addw	sp,#5
1962  03a5               L3701:
1963                     ; 394 				if(dtccnt1 < 10) dtccnt1++;
1965  03a5 c60002        	ld	a,L5301_dtccnt1
1966  03a8 a10a          	cp	a,#10
1967  03aa 2405          	jruge	L5701
1970  03ac 725c0002      	inc	L5301_dtccnt1
1973  03b0 87            	retf	
1974  03b1               L5701:
1975                     ; 397 			        if((DTCstate[DTC9011] & DTCconfirmed)==0)
1977  03b1 7206000653    	btjt	_DTCstate+6,#3,L1601
1978                     ; 400 						Weeprommain((unsigned long)(&DTCstate[DTC9011]),DTCstate[DTC9011] | DTCconfirmed);
1980  03b6 c60006        	ld	a,_DTCstate+6
1981  03b9 aa08          	or	a,#8
1984  03bb 2038          	jpf	LC011
1985  03bd               L1701:
1986                     ; 406 			    dtccnt1 = 0;
1988  03bd 725f0002      	clr	L5301_dtccnt1
1989                     ; 408 		        if((DTCstate[DTC9011] & DTCcycleFail)!=0)
1991  03c1 7203000619    	btjf	_DTCstate+6,#1,L5011
1992                     ; 411 					Weeprommain((unsigned long)(&DTCstate[DTC9011]),DTCstate[DTC9011] & (~DTCcycleFail));
1994  03c6 c60006        	ld	a,_DTCstate+6
1995  03c9 a4fd          	and	a,#253
1996  03cb 88            	push	a
1997  03cc ae0006        	ldw	x,#_DTCstate+6
1998  03cf 8d000000      	callf	d_uitolx
2000  03d3 be02          	ldw	x,c_lreg+2
2001  03d5 89            	pushw	x
2002  03d6 be00          	ldw	x,c_lreg
2003  03d8 89            	pushw	x
2004  03d9 8d000000      	callf	f_Weeprommain
2006  03dd 5b05          	addw	sp,#5
2007  03df               L5011:
2008                     ; 414 				if(dtccnt2 < 10) dtccnt2++;
2010  03df c60001        	ld	a,L7301_dtccnt2
2011  03e2 a10a          	cp	a,#10
2012  03e4 2405          	jruge	L7011
2015  03e6 725c0001      	inc	L7301_dtccnt2
2018  03ea 87            	retf	
2019  03eb               L7011:
2020                     ; 417 			        if((DTCstate[DTC9011] & DTCconfirmed)!=0)
2022  03eb 7207000619    	btjf	_DTCstate+6,#3,L1601
2023                     ; 420 						Weeprommain((unsigned long)(&DTCstate[DTC9011]),DTCstate[DTC9011] & (~DTCconfirmed));
2025  03f0 c60006        	ld	a,_DTCstate+6
2026  03f3 a4f7          	and	a,#247
2029  03f5               LC011:
2030  03f5 88            	push	a
2031  03f6 ae0006        	ldw	x,#_DTCstate+6
2032  03f9 8d000000      	callf	d_uitolx
2033  03fd be02          	ldw	x,c_lreg+2
2034  03ff 89            	pushw	x
2035  0400 be00          	ldw	x,c_lreg
2036  0402 89            	pushw	x
2037  0403 8d000000      	callf	f_Weeprommain
2038  0407 5b05          	addw	sp,#5
2039  0409               L1601:
2040                     ; 428 }
2043  0409 87            	retf	
2045                     	switch	.bss
2046  0003               L5111_lockcnt:
2047  0003 00            	ds.b	1
2048  0004               L1211_dtccnt2:
2049  0004 00            	ds.b	1
2050  0005               L7111_dtccnt1:
2051  0005 00            	ds.b	1
2099                     ; 429 void UDSDTC9023(void)
2099                     ; 430 {
2100                     	switch	.text
2101  040a               f_UDSDTC9023:
2105                     ; 433      if(LockState == Locked)
2107  040a c60000        	ld	a,_LockState
2108  040d a155          	cp	a,#85
2109  040f 2704acb404b4  	jrne	L3411
2110                     ; 435          if(lockcnt < DTC48MS) lockcnt++;
2112  0415 c60003        	ld	a,L5111_lockcnt
2113  0418 a106          	cp	a,#6
2114  041a 2405          	jruge	L5411
2117  041c 725c0003      	inc	L5111_lockcnt
2120  0420 87            	retf	
2121  0421               L5411:
2122                     ; 436 		 else if(lockcnt == DTC48MS)
2124  0421 a106          	cp	a,#6
2125  0423 26ec          	jrne	L3411
2126                     ; 438 		 	 lockcnt++;
2128  0425 725c0003      	inc	L5111_lockcnt
2129                     ; 439 			 if(DoorState & OtherDoorIsOpen)
2131  0429 720300003a    	btjf	_DoorState,#1,L3511
2132                     ; 441 	             dtccnt2 = 0;
2134  042e 725f0004      	clr	L1211_dtccnt2
2135                     ; 443 		        if((DTCstate[DTC9023] & DTCcycleFail)==0)
2137  0432 7202000719    	btjt	_DTCstate+7,#1,L5511
2138                     ; 446 					Weeprommain((unsigned long)(&DTCstate[DTC9023]),DTCstate[DTC9023] | DTCcycleFail);
2140  0437 c60007        	ld	a,_DTCstate+7
2141  043a aa02          	or	a,#2
2142  043c 88            	push	a
2143  043d ae0007        	ldw	x,#_DTCstate+7
2144  0440 8d000000      	callf	d_uitolx
2146  0444 be02          	ldw	x,c_lreg+2
2147  0446 89            	pushw	x
2148  0447 be00          	ldw	x,c_lreg
2149  0449 89            	pushw	x
2150  044a 8d000000      	callf	f_Weeprommain
2152  044e 5b05          	addw	sp,#5
2153  0450               L5511:
2154                     ; 450 				if(dtccnt1 < 10) dtccnt1++;
2156  0450 c60005        	ld	a,L7111_dtccnt1
2157  0453 a10a          	cp	a,#10
2158  0455 2405          	jruge	L7511
2161  0457 725c0005      	inc	L7111_dtccnt1
2164  045b 87            	retf	
2165  045c               L7511:
2166                     ; 453 			        if((DTCstate[DTC9023] & DTCconfirmed)==0)
2168  045c 7206000753    	btjt	_DTCstate+7,#3,L3411
2169                     ; 456 						Weeprommain((unsigned long)(&DTCstate[DTC9023]),DTCstate[DTC9023] | DTCconfirmed);
2171  0461 c60007        	ld	a,_DTCstate+7
2172  0464 aa08          	or	a,#8
2175  0466 2038          	jpf	LC012
2176  0468               L3511:
2177                     ; 462 			    dtccnt1 = 0;
2179  0468 725f0005      	clr	L7111_dtccnt1
2180                     ; 464 		        if((DTCstate[DTC9023] & DTCcycleFail)!=0)
2182  046c 7203000719    	btjf	_DTCstate+7,#1,L7611
2183                     ; 467 					Weeprommain((unsigned long)(&DTCstate[DTC9023]),DTCstate[DTC9023] & (~DTCcycleFail));
2185  0471 c60007        	ld	a,_DTCstate+7
2186  0474 a4fd          	and	a,#253
2187  0476 88            	push	a
2188  0477 ae0007        	ldw	x,#_DTCstate+7
2189  047a 8d000000      	callf	d_uitolx
2191  047e be02          	ldw	x,c_lreg+2
2192  0480 89            	pushw	x
2193  0481 be00          	ldw	x,c_lreg
2194  0483 89            	pushw	x
2195  0484 8d000000      	callf	f_Weeprommain
2197  0488 5b05          	addw	sp,#5
2198  048a               L7611:
2199                     ; 470 				if(dtccnt2 < 10) dtccnt2++;
2201  048a c60004        	ld	a,L1211_dtccnt2
2202  048d a10a          	cp	a,#10
2203  048f 2405          	jruge	L1711
2206  0491 725c0004      	inc	L1211_dtccnt2
2209  0495 87            	retf	
2210  0496               L1711:
2211                     ; 473 			        if((DTCstate[DTC9023] & DTCconfirmed)!=0)
2213  0496 7207000719    	btjf	_DTCstate+7,#3,L3411
2214                     ; 476 						Weeprommain((unsigned long)(&DTCstate[DTC9023]),DTCstate[DTC9023] & (~DTCconfirmed));
2216  049b c60007        	ld	a,_DTCstate+7
2217  049e a4f7          	and	a,#247
2220  04a0               LC012:
2221  04a0 88            	push	a
2222  04a1 ae0007        	ldw	x,#_DTCstate+7
2223  04a4 8d000000      	callf	d_uitolx
2224  04a8 be02          	ldw	x,c_lreg+2
2225  04aa 89            	pushw	x
2226  04ab be00          	ldw	x,c_lreg
2227  04ad 89            	pushw	x
2228  04ae 8d000000      	callf	f_Weeprommain
2229  04b2 5b05          	addw	sp,#5
2230  04b4               L3411:
2231                     ; 484 }
2234  04b4 87            	retf	
2236                     	switch	.bss
2237  0006               L7711_lockcnt:
2238  0006 00            	ds.b	1
2239  0007               L3021_dtccnt2:
2240  0007 00            	ds.b	1
2241  0008               L1021_dtccnt1:
2242  0008 00            	ds.b	1
2290                     ; 487 void UDSDTC9007(void)
2290                     ; 488 {
2291                     	switch	.text
2292  04b5               f_UDSDTC9007:
2296                     ; 491      if(LockState == Locked)
2298  04b5 c60000        	ld	a,_LockState
2299  04b8 a155          	cp	a,#85
2300  04ba 2704ac5f055f  	jrne	L5221
2301                     ; 493          if(lockcnt < DTC48MS) lockcnt++;
2303  04c0 c60006        	ld	a,L7711_lockcnt
2304  04c3 a106          	cp	a,#6
2305  04c5 2405          	jruge	L7221
2308  04c7 725c0006      	inc	L7711_lockcnt
2311  04cb 87            	retf	
2312  04cc               L7221:
2313                     ; 494 		 else if(lockcnt == DTC48MS)
2315  04cc a106          	cp	a,#6
2316  04ce 26ec          	jrne	L5221
2317                     ; 496 		 	 lockcnt++;
2319  04d0 725c0006      	inc	L7711_lockcnt
2320                     ; 497 			 if(DoorState & FDdoorisopen)
2322  04d4 720700003a    	btjf	_DoorState,#3,L5321
2323                     ; 499 	             dtccnt2 = 0;
2325  04d9 725f0007      	clr	L3021_dtccnt2
2326                     ; 501 		        if((DTCstate[DTC9007] & DTCcycleFail)==0)
2328  04dd 7202000819    	btjt	_DTCstate+8,#1,L7321
2329                     ; 504 					Weeprommain((unsigned long)(&DTCstate[DTC9007]),DTCstate[DTC9007] | DTCcycleFail);
2331  04e2 c60008        	ld	a,_DTCstate+8
2332  04e5 aa02          	or	a,#2
2333  04e7 88            	push	a
2334  04e8 ae0008        	ldw	x,#_DTCstate+8
2335  04eb 8d000000      	callf	d_uitolx
2337  04ef be02          	ldw	x,c_lreg+2
2338  04f1 89            	pushw	x
2339  04f2 be00          	ldw	x,c_lreg
2340  04f4 89            	pushw	x
2341  04f5 8d000000      	callf	f_Weeprommain
2343  04f9 5b05          	addw	sp,#5
2344  04fb               L7321:
2345                     ; 508 				if(dtccnt1 < 10) dtccnt1++;
2347  04fb c60008        	ld	a,L1021_dtccnt1
2348  04fe a10a          	cp	a,#10
2349  0500 2405          	jruge	L1421
2352  0502 725c0008      	inc	L1021_dtccnt1
2355  0506 87            	retf	
2356  0507               L1421:
2357                     ; 511 			        if((DTCstate[DTC9007] & DTCconfirmed)==0)
2359  0507 7206000853    	btjt	_DTCstate+8,#3,L5221
2360                     ; 514 						Weeprommain((unsigned long)(&DTCstate[DTC9007]),DTCstate[DTC9007] | DTCconfirmed);
2362  050c c60008        	ld	a,_DTCstate+8
2363  050f aa08          	or	a,#8
2366  0511 2038          	jpf	LC013
2367  0513               L5321:
2368                     ; 520 			    dtccnt1 = 0;
2370  0513 725f0008      	clr	L1021_dtccnt1
2371                     ; 522 		        if((DTCstate[DTC9007] & DTCcycleFail)!=0)
2373  0517 7203000819    	btjf	_DTCstate+8,#1,L1521
2374                     ; 525 					Weeprommain((unsigned long)(&DTCstate[DTC9007]),DTCstate[DTC9007] & (~DTCcycleFail));
2376  051c c60008        	ld	a,_DTCstate+8
2377  051f a4fd          	and	a,#253
2378  0521 88            	push	a
2379  0522 ae0008        	ldw	x,#_DTCstate+8
2380  0525 8d000000      	callf	d_uitolx
2382  0529 be02          	ldw	x,c_lreg+2
2383  052b 89            	pushw	x
2384  052c be00          	ldw	x,c_lreg
2385  052e 89            	pushw	x
2386  052f 8d000000      	callf	f_Weeprommain
2388  0533 5b05          	addw	sp,#5
2389  0535               L1521:
2390                     ; 528 				if(dtccnt2 < 10) dtccnt2++;
2392  0535 c60007        	ld	a,L3021_dtccnt2
2393  0538 a10a          	cp	a,#10
2394  053a 2405          	jruge	L3521
2397  053c 725c0007      	inc	L3021_dtccnt2
2400  0540 87            	retf	
2401  0541               L3521:
2402                     ; 531 			        if((DTCstate[DTC9007] & DTCconfirmed)!=0)
2404  0541 7207000819    	btjf	_DTCstate+8,#3,L5221
2405                     ; 534 						Weeprommain((unsigned long)(&DTCstate[DTC9007]),DTCstate[DTC9007] & (~DTCconfirmed));
2407  0546 c60008        	ld	a,_DTCstate+8
2408  0549 a4f7          	and	a,#247
2411  054b               LC013:
2412  054b 88            	push	a
2413  054c ae0008        	ldw	x,#_DTCstate+8
2414  054f 8d000000      	callf	d_uitolx
2415  0553 be02          	ldw	x,c_lreg+2
2416  0555 89            	pushw	x
2417  0556 be00          	ldw	x,c_lreg
2418  0558 89            	pushw	x
2419  0559 8d000000      	callf	f_Weeprommain
2420  055d 5b05          	addw	sp,#5
2421  055f               L5221:
2422                     ; 542 }
2425  055f 87            	retf	
2427                     	switch	.bss
2428  0009               L5621_cnt:
2429  0009 00            	ds.b	1
2430  000a               L3621_turncnt2:
2431  000a 0000          	ds.b	2
2432  000c               L1621_turncnt1:
2433  000c 00            	ds.b	1
2479                     ; 544 void UDSDTC9043(void)
2479                     ; 545 {
2480                     	switch	.text
2481  0560               f_UDSDTC9043:
2485                     ; 549     if((!TURN_LEFT_SW)&&(!TURN_RIGHT_SW))
2487  0560 720450064b    	btjt	20486,#2,L7031
2489  0565 7202500646    	btjt	20486,#1,L7031
2490                     ; 551         turncnt2 = 0;
2492  056a 5f            	clrw	x
2493  056b cf000a        	ldw	L3621_turncnt2,x
2494                     ; 552 		if(cnt <DTC48MS) {cnt++;return ;}
2496  056e c60009        	ld	a,L5621_cnt
2497  0571 a106          	cp	a,#6
2498  0573 2405          	jruge	L1131
2501  0575 725c0009      	inc	L5621_cnt
2505  0579 87            	retf	
2506  057a               L1131:
2507                     ; 554         if((DTCstate[DTC9043] & DTCcycleFail)==0)
2509  057a 7202000919    	btjt	_DTCstate+9,#1,L3131
2510                     ; 557 			Weeprommain((unsigned long)(&DTCstate[DTC9043]),DTCstate[DTC9043] | DTCcycleFail);
2512  057f c60009        	ld	a,_DTCstate+9
2513  0582 aa02          	or	a,#2
2514  0584 88            	push	a
2515  0585 ae0009        	ldw	x,#_DTCstate+9
2516  0588 8d000000      	callf	d_uitolx
2518  058c be02          	ldw	x,c_lreg+2
2519  058e 89            	pushw	x
2520  058f be00          	ldw	x,c_lreg
2521  0591 89            	pushw	x
2522  0592 8d000000      	callf	f_Weeprommain
2524  0596 5b05          	addw	sp,#5
2525  0598               L3131:
2526                     ; 560 		if(turncnt1 < DTC1000MS)turncnt1++;
2528  0598 c6000c        	ld	a,L1621_turncnt1
2529  059b a17d          	cp	a,#125
2530  059d 2405          	jruge	L5131
2533  059f 725c000c      	inc	L1621_turncnt1
2536  05a3 87            	retf	
2537  05a4               L5131:
2538                     ; 563 	        if((DTCstate[DTC9043] & DTCconfirmed)==0)
2540  05a4 7206000958    	btjt	_DTCstate+9,#3,L3231
2541                     ; 566 				Weeprommain((unsigned long)(&DTCstate[DTC9043]),DTCstate[DTC9043] | DTCconfirmed);
2543  05a9 c60009        	ld	a,_DTCstate+9
2544  05ac aa08          	or	a,#8
2547  05ae 203d          	jpf	LC014
2548  05b0               L7031:
2549                     ; 573 	    cnt = 0;
2551  05b0 725f0009      	clr	L5621_cnt
2552                     ; 574 	    turncnt1 = 0;
2554  05b4 725f000c      	clr	L1621_turncnt1
2555                     ; 576         if((DTCstate[DTC9043] & DTCcycleFail)!=0)
2557  05b8 7203000919    	btjf	_DTCstate+9,#1,L5231
2558                     ; 579 			Weeprommain((unsigned long)(&DTCstate[DTC9043]),DTCstate[DTC9043] & (~DTCcycleFail));
2560  05bd c60009        	ld	a,_DTCstate+9
2561  05c0 a4fd          	and	a,#253
2562  05c2 88            	push	a
2563  05c3 ae0009        	ldw	x,#_DTCstate+9
2564  05c6 8d000000      	callf	d_uitolx
2566  05ca be02          	ldw	x,c_lreg+2
2567  05cc 89            	pushw	x
2568  05cd be00          	ldw	x,c_lreg
2569  05cf 89            	pushw	x
2570  05d0 8d000000      	callf	f_Weeprommain
2572  05d4 5b05          	addw	sp,#5
2573  05d6               L5231:
2574                     ; 582 		if(turncnt2 < DTC1000MS)turncnt2++;
2576  05d6 ce000a        	ldw	x,L3621_turncnt2
2577  05d9 a3007d        	cpw	x,#125
2578  05dc 2405          	jruge	L7231
2581  05de 5c            	incw	x
2582  05df cf000a        	ldw	L3621_turncnt2,x
2585  05e2 87            	retf	
2586  05e3               L7231:
2587                     ; 585 	        if((DTCstate[DTC9043] & DTCconfirmed)!=0)
2589  05e3 7207000919    	btjf	_DTCstate+9,#3,L3231
2590                     ; 588 				Weeprommain((unsigned long)(&DTCstate[DTC9043]),DTCstate[DTC9043] & (~DTCconfirmed));
2592  05e8 c60009        	ld	a,_DTCstate+9
2593  05eb a4f7          	and	a,#247
2596  05ed               LC014:
2597  05ed 88            	push	a
2598  05ee ae0009        	ldw	x,#_DTCstate+9
2599  05f1 8d000000      	callf	d_uitolx
2600  05f5 be02          	ldw	x,c_lreg+2
2601  05f7 89            	pushw	x
2602  05f8 be00          	ldw	x,c_lreg
2603  05fa 89            	pushw	x
2604  05fb 8d000000      	callf	f_Weeprommain
2605  05ff 5b05          	addw	sp,#5
2606  0601               L3231:
2607                     ; 592 }
2610  0601 87            	retf	
2612                     	switch	.bss
2613  000d               L7331_keyincnt2:
2614  000d 00            	ds.b	1
2615  000e               L5331_keyincnt1:
2616  000e 00            	ds.b	1
2617  000f               L1431_keyincnt3:
2618  000f 00            	ds.b	1
2666                     ; 593 void UDSDTC9093(void)
2666                     ; 594 {
2667                     	switch	.text
2668  0602               f_UDSDTC9093:
2672                     ; 596      if((KeyInState == KeyIsOutHole)&&(IGNstate == ON))
2674  0602 c60000        	ld	a,_KeyInState
2675  0605 2627          	jrne	L3631
2677  0607 c60000        	ld	a,_IGNstate
2678  060a a155          	cp	a,#85
2679  060c 2620          	jrne	L3631
2680                     ; 598          if(keyincnt1 < DTC48MS) keyincnt1++;
2682  060e c6000e        	ld	a,L5331_keyincnt1
2683  0611 a106          	cp	a,#6
2684  0613 2405          	jruge	L5631
2687  0615 725c000e      	inc	L5331_keyincnt1
2690  0619 87            	retf	
2691  061a               L5631:
2692                     ; 599 		 else if(keyincnt1 == DTC48MS )
2694  061a a106          	cp	a,#6
2695  061c 2668          	jrne	L5731
2696                     ; 601             keyincnt1++;
2698  061e 725c000e      	inc	L5331_keyincnt1
2699                     ; 602 	        if((DTCstate[DTC9093] & DTCconfirmed)==0)
2701  0622 7206000a5f    	btjt	_DTCstate+10,#3,L5731
2702                     ; 605 				Weeprommain((unsigned long)(&DTCstate[DTC9093]),DTCstate[DTC9093] | DTCconfirmed);
2704  0627 c6000a        	ld	a,_DTCstate+10
2705  062a aa08          	or	a,#8
2708  062c 2037          	jpf	LC015
2709  062e               L3631:
2710                     ; 611 	 else if((KeyInState == KeyIsInHole)&&(IGNstate == ON))
2712  062e c60000        	ld	a,_KeyInState
2713  0631 4a            	dec	a
2714  0632 2646          	jrne	L7731
2716  0634 c60000        	ld	a,_IGNstate
2717  0637 a155          	cp	a,#85
2718  0639 263f          	jrne	L7731
2719                     ; 613          if(keyincnt2 < DTC48MS) keyincnt2++;
2721  063b c6000d        	ld	a,L7331_keyincnt2
2722  063e a106          	cp	a,#6
2723  0640 2405          	jruge	L1041
2726  0642 725c000d      	inc	L7331_keyincnt2
2729  0646 87            	retf	
2730  0647               L1041:
2731                     ; 614 		 else if(keyincnt2 == DTC48MS )
2733  0647 a106          	cp	a,#6
2734  0649 263b          	jrne	L5731
2735                     ; 616             keyincnt2++;
2737  064b 725c000d      	inc	L7331_keyincnt2
2738                     ; 617 			if(keyincnt3 < 10 )keyincnt3++;
2740  064f c6000f        	ld	a,L1431_keyincnt3
2741  0652 a10a          	cp	a,#10
2742  0654 2405          	jruge	L7041
2745  0656 725c000f      	inc	L1431_keyincnt3
2748  065a 87            	retf	
2749  065b               L7041:
2750                     ; 620 		        if((DTCstate[DTC9093] & DTCconfirmed)!=0)
2752  065b 7207000a26    	btjf	_DTCstate+10,#3,L5731
2753                     ; 623 					Weeprommain((unsigned long)(&DTCstate[DTC9093]),DTCstate[DTC9093] & (~DTCconfirmed));
2755  0660 c6000a        	ld	a,_DTCstate+10
2756  0663 a4f7          	and	a,#247
2759  0665               LC015:
2760  0665 88            	push	a
2761  0666 ae000a        	ldw	x,#_DTCstate+10
2762  0669 8d000000      	callf	d_uitolx
2763  066d be02          	ldw	x,c_lreg+2
2764  066f 89            	pushw	x
2765  0670 be00          	ldw	x,c_lreg
2766  0672 89            	pushw	x
2767  0673 8d000000      	callf	f_Weeprommain
2768  0677 5b05          	addw	sp,#5
2770  0679 87            	retf	
2771  067a               L7731:
2772                     ; 631          keyincnt1 = 0;
2774  067a 725f000e      	clr	L5331_keyincnt1
2775                     ; 632 		 keyincnt2 = 0;
2777  067e 725f000d      	clr	L7331_keyincnt2
2778                     ; 633 		 keyincnt3 = 0;
2780  0682 725f000f      	clr	L1431_keyincnt3
2781  0686               L5731:
2782                     ; 636 }
2785  0686 87            	retf	
2807                     ; 638 void UDSDTC9061(void)
2807                     ; 639 {
2808                     	switch	.text
2809  0687               f_UDSDTC9061:
2813                     ; 641 }
2816  0687 87            	retf	
2838                     ; 643 void UDSDTC9067(void)
2838                     ; 644 {
2839                     	switch	.text
2840  0688               f_UDSDTC9067:
2844                     ; 646 }
2847  0688 87            	retf	
2849                     	switch	.bss
2850  0010               L7341_hazardcnt1:
2851  0010 0000          	ds.b	2
2852  0012               L3441_hazardcnt3:
2853  0012 0000          	ds.b	2
2854  0014               L1441_hazardcnt2:
2855  0014 0000          	ds.b	2
2901                     ; 648 void UDSDTC9045(void)
2901                     ; 649 {
2902                     	switch	.text
2903  0689               f_UDSDTC9045:
2907                     ; 652     if(!HAZARD_SW)
2909  0689 ce0010        	ldw	x,L7341_hazardcnt1
2910  068c 720c501579    	btjt	20501,#6,L5641
2911                     ; 654 		if(hazardcnt1 < DTC1Min)hazardcnt1++;
2913  0691 a31d4c        	cpw	x,#7500
2914  0694 2404          	jruge	L7641
2917  0696 5c            	incw	x
2918  0697 cf0010        	ldw	L7341_hazardcnt1,x
2919  069a               L7641:
2920                     ; 655 		if(hazardcnt1 == DTC10000MS)
2922  069a a304e2        	cpw	x,#1250
2923  069d 2653          	jrne	L1741
2924                     ; 657             hazardcnt2++;
2926  069f ce0014        	ldw	x,L1441_hazardcnt2
2927  06a2 5c            	incw	x
2928  06a3 cf0014        	ldw	L1441_hazardcnt2,x
2929                     ; 658 			hazardcnt3 = 0;
2931  06a6 5f            	clrw	x
2932  06a7 cf0012        	ldw	L3441_hazardcnt3,x
2933                     ; 660 	        if((DTCstate[DTC9045] & DTCcycleFail)==0)
2935  06aa 7202000d19    	btjt	_DTCstate+13,#1,L3741
2936                     ; 663 				Weeprommain((unsigned long)(&DTCstate[DTC9045]),DTCstate[DTC9045] | DTCcycleFail);
2938  06af c6000d        	ld	a,_DTCstate+13
2939  06b2 aa02          	or	a,#2
2940  06b4 88            	push	a
2941  06b5 ae000d        	ldw	x,#_DTCstate+13
2942  06b8 8d000000      	callf	d_uitolx
2944  06bc be02          	ldw	x,c_lreg+2
2945  06be 89            	pushw	x
2946  06bf be00          	ldw	x,c_lreg
2947  06c1 89            	pushw	x
2948  06c2 8d000000      	callf	f_Weeprommain
2950  06c6 5b05          	addw	sp,#5
2951  06c8               L3741:
2952                     ; 665 			if(hazardcnt2 > 5)
2954  06c8 ce0014        	ldw	x,L1441_hazardcnt2
2955  06cb a30006        	cpw	x,#6
2956  06ce 2522          	jrult	L1741
2957                     ; 667 			    hazardcnt3 = 0;
2959  06d0 5f            	clrw	x
2960  06d1 cf0012        	ldw	L3441_hazardcnt3,x
2961                     ; 669 		        if((DTCstate[DTC9045] & DTCconfirmed)==0)
2963  06d4 7206000d19    	btjt	_DTCstate+13,#3,L1741
2964                     ; 672 					Weeprommain((unsigned long)(&DTCstate[DTC9045]),DTCstate[DTC9045] | DTCconfirmed);
2966  06d9 c6000d        	ld	a,_DTCstate+13
2967  06dc aa08          	or	a,#8
2968  06de 88            	push	a
2969  06df ae000d        	ldw	x,#_DTCstate+13
2970  06e2 8d000000      	callf	d_uitolx
2972  06e6 be02          	ldw	x,c_lreg+2
2973  06e8 89            	pushw	x
2974  06e9 be00          	ldw	x,c_lreg
2975  06eb 89            	pushw	x
2976  06ec 8d000000      	callf	f_Weeprommain
2978  06f0 5b05          	addw	sp,#5
2979  06f2               L1741:
2980                     ; 676 		if(hazardcnt1 > (DTC1Min>>1))
2982  06f2 ce0010        	ldw	x,L7341_hazardcnt1
2983  06f5 a30ea7        	cpw	x,#3751
2984  06f8 256a          	jrult	L5051
2985                     ; 678 		        hazardcnt3 = 0;
2987  06fa 5f            	clrw	x
2988  06fb cf0012        	ldw	L3441_hazardcnt3,x
2989                     ; 680 		        if((DTCstate[DTC9045] & DTCconfirmed)==0)
2991  06fe 7206000d61    	btjt	_DTCstate+13,#3,L5051
2992                     ; 683 					Weeprommain((unsigned long)(&DTCstate[DTC9045]),DTCstate[DTC9045] | DTCconfirmed);
2994  0703 c6000d        	ld	a,_DTCstate+13
2995  0706 aa08          	or	a,#8
2998  0708 2046          	jpf	LC016
2999  070a               L5641:
3000                     ; 689 		if((hazardcnt1 > 5)&&(hazardcnt1 < DTC10000MS))
3002  070a a30006        	cpw	x,#6
3003  070d 2555          	jrult	L5051
3005  070f a304e2        	cpw	x,#1250
3006  0712 2450          	jruge	L5051
3007                     ; 691             hazardcnt1 = 0;
3009  0714 5f            	clrw	x
3010  0715 cf0010        	ldw	L7341_hazardcnt1,x
3011                     ; 692 			hazardcnt2 = 0;
3013  0718 cf0014        	ldw	L1441_hazardcnt2,x
3014                     ; 693 			if((DTCstate[DTC9045] & DTCcycleFail)!=0)
3016  071b 7203000d19    	btjf	_DTCstate+13,#1,L1151
3017                     ; 696 				Weeprommain((unsigned long)(&DTCstate[DTC9045]),DTCstate[DTC9045] & (~DTCcycleFail));
3019  0720 c6000d        	ld	a,_DTCstate+13
3020  0723 a4fd          	and	a,#253
3021  0725 88            	push	a
3022  0726 ae000d        	ldw	x,#_DTCstate+13
3023  0729 8d000000      	callf	d_uitolx
3025  072d be02          	ldw	x,c_lreg+2
3026  072f 89            	pushw	x
3027  0730 be00          	ldw	x,c_lreg
3028  0732 89            	pushw	x
3029  0733 8d000000      	callf	f_Weeprommain
3031  0737 5b05          	addw	sp,#5
3032  0739               L1151:
3033                     ; 699 			if(hazardcnt3 > 10)hazardcnt3++;
3035  0739 ce0012        	ldw	x,L3441_hazardcnt3
3036  073c a3000b        	cpw	x,#11
3037  073f 2505          	jrult	L3151
3040  0741 5c            	incw	x
3041  0742 cf0012        	ldw	L3441_hazardcnt3,x
3044  0745 87            	retf	
3045  0746               L3151:
3046                     ; 702 				if((DTCstate[DTC9045] & DTCconfirmed)!=0)
3048  0746 7207000d19    	btjf	_DTCstate+13,#3,L5051
3049                     ; 705 					Weeprommain((unsigned long)(&DTCstate[DTC9045]),DTCstate[DTC9045] & (~DTCconfirmed));
3051  074b c6000d        	ld	a,_DTCstate+13
3052  074e a4f7          	and	a,#247
3055  0750               LC016:
3056  0750 88            	push	a
3057  0751 ae000d        	ldw	x,#_DTCstate+13
3058  0754 8d000000      	callf	d_uitolx
3059  0758 be02          	ldw	x,c_lreg+2
3060  075a 89            	pushw	x
3061  075b be00          	ldw	x,c_lreg
3062  075d 89            	pushw	x
3063  075e 8d000000      	callf	f_Weeprommain
3064  0762 5b05          	addw	sp,#5
3065  0764               L5051:
3066                     ; 710 }
3069  0764 87            	retf	
3071                     	switch	.bss
3072  0016               L3251_lockadcnt2:
3073  0016 0000          	ds.b	2
3074  0018               L1251_lockadcnt1:
3075  0018 0000          	ds.b	2
3122                     ; 712 void UDSDTC9073(void)
3122                     ; 713 {
3123                     	switch	.text
3124  0765               f_UDSDTC9073:
3126  0765 89            	pushw	x
3127       00000002      OFST:	set	2
3130                     ; 717    lockadva = GetADCresultAverage(0);
3132  0766 4f            	clr	a
3133  0767 8d000000      	callf	f_GetADCresultAverage
3135  076b 1f01          	ldw	(OFST-1,sp),x
3136                     ; 718    if(lockadva < 100)
3138  076d a30064        	cpw	x,#100
3139  0770 241a          	jruge	L5451
3140                     ; 720 		if(lockadcnt1 < DTC10000MS) lockadcnt1++;
3142  0772 ce0018        	ldw	x,L1251_lockadcnt1
3143  0775 a304e2        	cpw	x,#1250
3144  0778 2406          	jruge	L7451
3147  077a 5c            	incw	x
3148  077b cf0018        	ldw	L1251_lockadcnt1,x
3150  077e 2038          	jra	L5551
3151  0780               L7451:
3152                     ; 724 	        if((DTCstate[DTC9073] & DTCconfirmed)==0)
3154  0780 7206000e33    	btjt	_DTCstate+14,#3,L5551
3155                     ; 727 				Weeprommain((unsigned long)(&DTCstate[DTC9073]),DTCstate[DTC9073] | DTCconfirmed);
3157  0785 c6000e        	ld	a,_DTCstate+14
3158  0788 aa08          	or	a,#8
3161  078a 2018          	jpf	LC017
3162  078c               L5451:
3163                     ; 734         if(lockadcnt2 < DTC48MS)lockadcnt2++;
3165  078c ce0016        	ldw	x,L3251_lockadcnt2
3166  078f a30006        	cpw	x,#6
3167  0792 2406          	jruge	L7551
3170  0794 5c            	incw	x
3171  0795 cf0016        	ldw	L3251_lockadcnt2,x
3173  0798 201e          	jra	L5551
3174  079a               L7551:
3175                     ; 738 	        if((DTCstate[DTC9073] & DTCconfirmed)!=0)
3177  079a 7207000e19    	btjf	_DTCstate+14,#3,L5551
3178                     ; 741 				Weeprommain((unsigned long)(&DTCstate[DTC9073]),DTCstate[DTC9073] & (~DTCconfirmed));
3180  079f c6000e        	ld	a,_DTCstate+14
3181  07a2 a4f7          	and	a,#247
3184  07a4               LC017:
3185  07a4 88            	push	a
3186  07a5 ae000e        	ldw	x,#_DTCstate+14
3187  07a8 8d000000      	callf	d_uitolx
3188  07ac be02          	ldw	x,c_lreg+2
3189  07ae 89            	pushw	x
3190  07af be00          	ldw	x,c_lreg
3191  07b1 89            	pushw	x
3192  07b2 8d000000      	callf	f_Weeprommain
3193  07b6 5b05          	addw	sp,#5
3194  07b8               L5551:
3195                     ; 749 }
3198  07b8 85            	popw	x
3199  07b9 87            	retf	
3221                     ; 752 void UDSDTC900c(void)
3221                     ; 753 {
3222                     	switch	.text
3223  07ba               f_UDSDTC900c:
3227                     ; 755 }
3230  07ba 87            	retf	
3232                     	switch	.data
3233  0014               L5751_BCMcantime:
3234  0014 04e2          	dc.w	1250
3235  0016               L7751_BCMcantime1:
3236  0016 007d          	dc.w	125
3281                     ; 758 void UDSDTCd001(void)
3281                     ; 759 {
3282                     	switch	.text
3283  07bb               f_UDSDTCd001:
3287                     ; 761     if(IGNstate != ON) return;
3289  07bb c60000        	ld	a,_IGNstate
3290  07be a155          	cp	a,#85
3291  07c0 2701          	jreq	L7161
3295  07c2 87            	retf	
3296  07c3               L7161:
3297                     ; 762     if((DTC_ABS_ID)||(DTC_EMS_ID1)||(DTC_EMS_ID2)||(DTC_SRS_ID)||(DTC_TCU_ID))
3299  07c3 c60000        	ld	a,_DTC_ABS_ID
3300  07c6 2614          	jrne	L3261
3302  07c8 c60000        	ld	a,_DTC_EMS_ID1
3303  07cb 260f          	jrne	L3261
3305  07cd c60000        	ld	a,_DTC_EMS_ID2
3306  07d0 260a          	jrne	L3261
3308  07d2 c60000        	ld	a,_DTC_SRS_ID
3309  07d5 2605          	jrne	L3261
3311  07d7 c60000        	ld	a,_DTC_TCU_ID
3312  07da 2733          	jreq	L1261
3313  07dc               L3261:
3314                     ; 764 		if(DTC_ABS_ID)DTC_ABS_ID--;
3316  07dc c60000        	ld	a,_DTC_ABS_ID
3317  07df 2704          	jreq	L3361
3320  07e1 725a0000      	dec	_DTC_ABS_ID
3321  07e5               L3361:
3322                     ; 765 		if(DTC_EMS_ID1)DTC_EMS_ID1--;
3324  07e5 c60000        	ld	a,_DTC_EMS_ID1
3325  07e8 2704          	jreq	L5361
3328  07ea 725a0000      	dec	_DTC_EMS_ID1
3329  07ee               L5361:
3330                     ; 766 		if(DTC_EMS_ID2)DTC_EMS_ID2--;
3332  07ee c60000        	ld	a,_DTC_EMS_ID2
3333  07f1 2704          	jreq	L7361
3336  07f3 725a0000      	dec	_DTC_EMS_ID2
3337  07f7               L7361:
3338                     ; 767 		if(DTC_SRS_ID)DTC_SRS_ID --;
3340  07f7 c60000        	ld	a,_DTC_SRS_ID
3341  07fa 2704          	jreq	L1461
3344  07fc 725a0000      	dec	_DTC_SRS_ID
3345  0800               L1461:
3346                     ; 768 		if(DTC_TCU_ID)DTC_TCU_ID --;
3348  0800 c60000        	ld	a,_DTC_TCU_ID
3349  0803 2704          	jreq	L3461
3352  0805 725a0000      	dec	_DTC_TCU_ID
3353  0809               L3461:
3354                     ; 769 		BCMcantime = DTC10000MS;		
3356  0809 ae04e2        	ldw	x,#1250
3357  080c cf0014        	ldw	L5751_BCMcantime,x
3358  080f               L1261:
3359                     ; 776     if(BCMcantime != 0)
3361  080f ce0014        	ldw	x,L5751_BCMcantime
3362  0812 271e          	jreq	L5461
3363                     ; 778 		BCMcantime--;
3365  0814 5a            	decw	x
3366  0815 cf0014        	ldw	L5751_BCMcantime,x
3367                     ; 779 		if(BCMcantime < 5)
3369  0818 a30005        	cpw	x,#5
3370  081b 2415          	jruge	L5461
3371                     ; 782 			Weeprommain((unsigned long)(&DTCstate[DTCD001]),DTCconfirmed);
3373  081d 4b08          	push	#8
3374  081f ae0010        	ldw	x,#_DTCstate+16
3375  0822 8d000000      	callf	d_uitolx
3377  0826 be02          	ldw	x,c_lreg+2
3378  0828 89            	pushw	x
3379  0829 be00          	ldw	x,c_lreg
3380  082b 89            	pushw	x
3381  082c 8d000000      	callf	f_Weeprommain
3383  0830 5b05          	addw	sp,#5
3384  0832               L5461:
3385                     ; 786 	if(BCMcantime1 != 0)
3387  0832 ce0016        	ldw	x,L7751_BCMcantime1
3388  0835 271e          	jreq	L1561
3389                     ; 788 		BCMcantime1--;
3391  0837 5a            	decw	x
3392  0838 cf0016        	ldw	L7751_BCMcantime1,x
3393                     ; 789 		if(BCMcantime1 < 5)
3395  083b a30005        	cpw	x,#5
3396  083e 2415          	jruge	L1561
3397                     ; 791 			 Weeprommain((unsigned long)(&DTCstate[DTCD001]),0x00);
3399  0840 4b00          	push	#0
3400  0842 ae0010        	ldw	x,#_DTCstate+16
3401  0845 8d000000      	callf	d_uitolx
3403  0849 be02          	ldw	x,c_lreg+2
3404  084b 89            	pushw	x
3405  084c be00          	ldw	x,c_lreg
3406  084e 89            	pushw	x
3407  084f 8d000000      	callf	f_Weeprommain
3409  0853 5b05          	addw	sp,#5
3410  0855               L1561:
3411                     ; 797 }
3414  0855 87            	retf	
3416                     	switch	.bss
3417  001a               L5561_dtcTIME:
3418  001a 00            	ds.b	1
3419  001b               L7561_dtcON:
3420  001b 00            	ds.b	1
3461                     ; 799 void UDSDTCd002(void)
3461                     ; 800 {
3462                     	switch	.text
3463  0856               f_UDSDTCd002:
3467                     ; 804 	if(dtcTIME < DTC1000MS)dtcTIME++;
3469  0856 c6001a        	ld	a,L5561_dtcTIME
3470  0859 a17d          	cp	a,#125
3471  085b 2404          	jruge	L7761
3474  085d 725c001a      	inc	L5561_dtcTIME
3475  0861               L7761:
3476                     ; 805     if((DTC_EMS_ID1)||(DTC_EMS_ID2))
3478  0861 c60000        	ld	a,_DTC_EMS_ID1
3479  0864 2605          	jrne	L3071
3481  0866 c60000        	ld	a,_DTC_EMS_ID2
3482  0869 274d          	jreq	L1071
3483  086b               L3071:
3484                     ; 809 		dtcTIME = 0;
3486  086b 725f001a      	clr	L5561_dtcTIME
3487                     ; 811         if((DTCstate[DTCD002] & DTCcycleFail)!=0)
3489  086f 7203001119    	btjf	_DTCstate+17,#1,L5071
3490                     ; 814 			Weeprommain((unsigned long)(&DTCstate[DTCD002]),DTCstate[DTCD002] & (~DTCcycleFail));
3492  0874 c60011        	ld	a,_DTCstate+17
3493  0877 a4fd          	and	a,#253
3494  0879 88            	push	a
3495  087a ae0011        	ldw	x,#_DTCstate+17
3496  087d 8d000000      	callf	d_uitolx
3498  0881 be02          	ldw	x,c_lreg+2
3499  0883 89            	pushw	x
3500  0884 be00          	ldw	x,c_lreg
3501  0886 89            	pushw	x
3502  0887 8d000000      	callf	f_Weeprommain
3504  088b 5b05          	addw	sp,#5
3505  088d               L5071:
3506                     ; 816 		if(dtcON < 10)dtcON++;
3508  088d c6001b        	ld	a,L7561_dtcON
3509  0890 a10a          	cp	a,#10
3510  0892 2406          	jruge	L7071
3513  0894 725c001b      	inc	L7561_dtcON
3515  0898 201e          	jra	L1071
3516  089a               L7071:
3517                     ; 820 	        if((DTCstate[DTCD002] & DTCconfirmed)!=0)
3519  089a 7207001119    	btjf	_DTCstate+17,#3,L1071
3520                     ; 823 				Weeprommain((unsigned long)(&DTCstate[DTCD002]),DTCstate[DTCD002] & (~DTCconfirmed));
3522  089f c60011        	ld	a,_DTCstate+17
3523  08a2 a4f7          	and	a,#247
3524  08a4 88            	push	a
3525  08a5 ae0011        	ldw	x,#_DTCstate+17
3526  08a8 8d000000      	callf	d_uitolx
3528  08ac be02          	ldw	x,c_lreg+2
3529  08ae 89            	pushw	x
3530  08af be00          	ldw	x,c_lreg
3531  08b1 89            	pushw	x
3532  08b2 8d000000      	callf	f_Weeprommain
3534  08b6 5b05          	addw	sp,#5
3535  08b8               L1071:
3536                     ; 828     if(dtcTIME > DTC96MS)
3538  08b8 c6001a        	ld	a,L5561_dtcTIME
3539  08bb a10d          	cp	a,#13
3540  08bd 2522          	jrult	L5171
3541                     ; 830         dtcON = 0;
3543  08bf 725f001b      	clr	L7561_dtcON
3544                     ; 832         if((DTCstate[DTCD002] & DTCcycleFail)==0)
3546  08c3 7202001119    	btjt	_DTCstate+17,#1,L5171
3547                     ; 835 			Weeprommain((unsigned long)(&DTCstate[DTCD002]),DTCstate[DTCD002] | DTCcycleFail);
3549  08c8 c60011        	ld	a,_DTCstate+17
3550  08cb aa02          	or	a,#2
3551  08cd 88            	push	a
3552  08ce ae0011        	ldw	x,#_DTCstate+17
3553  08d1 8d000000      	callf	d_uitolx
3555  08d5 be02          	ldw	x,c_lreg+2
3556  08d7 89            	pushw	x
3557  08d8 be00          	ldw	x,c_lreg
3558  08da 89            	pushw	x
3559  08db 8d000000      	callf	f_Weeprommain
3561  08df 5b05          	addw	sp,#5
3562  08e1               L5171:
3563                     ; 838 	if(dtcTIME >= DTC1000MS)
3565  08e1 c6001a        	ld	a,L5561_dtcTIME
3566  08e4 a17d          	cp	a,#125
3567  08e6 2522          	jrult	L1271
3568                     ; 840 	    dtcON = 0;
3570  08e8 725f001b      	clr	L7561_dtcON
3571                     ; 842         if((DTCstate[DTCD002] & DTCconfirmed)==0)
3573  08ec 7206001119    	btjt	_DTCstate+17,#3,L1271
3574                     ; 845 			Weeprommain((unsigned long)(&DTCstate[DTCD002]),DTCstate[DTCD002] | DTCconfirmed);
3576  08f1 c60011        	ld	a,_DTCstate+17
3577  08f4 aa08          	or	a,#8
3578  08f6 88            	push	a
3579  08f7 ae0011        	ldw	x,#_DTCstate+17
3580  08fa 8d000000      	callf	d_uitolx
3582  08fe be02          	ldw	x,c_lreg+2
3583  0900 89            	pushw	x
3584  0901 be00          	ldw	x,c_lreg
3585  0903 89            	pushw	x
3586  0904 8d000000      	callf	f_Weeprommain
3588  0908 5b05          	addw	sp,#5
3589  090a               L1271:
3590                     ; 849 }
3593  090a 87            	retf	
3595                     	switch	.bss
3596  001c               L5271_dtcTIME:
3597  001c 00            	ds.b	1
3598  001d               L7271_dtcON:
3599  001d 00            	ds.b	1
3638                     ; 851 void UDSDTCd003(void)
3638                     ; 852 {
3639                     	switch	.text
3640  090b               f_UDSDTCd003:
3644                     ; 856 	if(dtcTIME < DTC1000MS)dtcTIME++;
3646  090b c6001c        	ld	a,L5271_dtcTIME
3647  090e a17d          	cp	a,#125
3648  0910 2404          	jruge	L7471
3651  0912 725c001c      	inc	L5271_dtcTIME
3652  0916               L7471:
3653                     ; 857     if(DTC_TCU_ID)
3655  0916 c60000        	ld	a,_DTC_TCU_ID
3656  0919 271b          	jreq	L1571
3657                     ; 861 		dtcTIME = 0;
3659  091b 725f001c      	clr	L5271_dtcTIME
3660                     ; 863         if((DTCstate[DTCD003] & DTCcycleFail)!=0)
3662  091f c60012        	ld	a,_DTCstate+18
3663  0922 a502          	bcp	a,#2
3664                     ; 868 		if(dtcON < 10)dtcON++;
3666  0924 c6001d        	ld	a,L7271_dtcON
3667  0927 a10a          	cp	a,#10
3668  0929 2406          	jruge	L5571
3671  092b 725c001d      	inc	L7271_dtcON
3673  092f 2005          	jra	L1571
3674  0931               L5571:
3675                     ; 872 	        if((DTCstate[DTCD003] & DTCconfirmed)!=0)
3677  0931 c60012        	ld	a,_DTCstate+18
3678  0934 a508          	bcp	a,#8
3679  0936               L1571:
3680                     ; 880     if(dtcTIME > DTC96MS)
3682  0936 c6001c        	ld	a,L5271_dtcTIME
3683  0939 a10d          	cp	a,#13
3684  093b 250c          	jrult	L3671
3685                     ; 882         dtcON = 0;
3687  093d 725f001d      	clr	L7271_dtcON
3688                     ; 884         if((DTCstate[DTCD003] & DTCcycleFail)==0)
3690  0941 c60012        	ld	a,_DTCstate+18
3691  0944 a502          	bcp	a,#2
3692  0946 c6001c        	ld	a,L5271_dtcTIME
3693  0949               L3671:
3694                     ; 890 	if(dtcTIME >= DTC1000MS)
3696  0949 a17d          	cp	a,#125
3697  094b 2509          	jrult	L7671
3698                     ; 892 	    dtcON = 0;
3700  094d 725f001d      	clr	L7271_dtcON
3701                     ; 894         if((DTCstate[DTCD003] & DTCconfirmed)==0)
3703  0951 c60012        	ld	a,_DTCstate+18
3704  0954 a508          	bcp	a,#8
3705  0956               L7671:
3706                     ; 901 }
3709  0956 87            	retf	
3711                     	switch	.bss
3712  001e               L3771_dtcTIME:
3713  001e 00            	ds.b	1
3714  001f               L5771_dtcON:
3715  001f 00            	ds.b	1
3754                     ; 903 void UDSDTCd004(void)
3754                     ; 904 {
3755                     	switch	.text
3756  0957               f_UDSDTCd004:
3760                     ; 908 	if(dtcTIME < DTC1000MS)dtcTIME++;
3762  0957 c6001e        	ld	a,L3771_dtcTIME
3763  095a a17d          	cp	a,#125
3764  095c 2404          	jruge	L5102
3767  095e 725c001e      	inc	L3771_dtcTIME
3768  0962               L5102:
3769                     ; 909     if(DTC_ABS_ID)
3771  0962 c60000        	ld	a,_DTC_ABS_ID
3772  0965 271b          	jreq	L7102
3773                     ; 913 		dtcTIME = 0;
3775  0967 725f001e      	clr	L3771_dtcTIME
3776                     ; 915         if((DTCstate[DTCD004] & DTCcycleFail)!=0)
3778  096b c60013        	ld	a,_DTCstate+19
3779  096e a502          	bcp	a,#2
3780                     ; 920 		if(dtcON < 10)dtcON++;
3782  0970 c6001f        	ld	a,L5771_dtcON
3783  0973 a10a          	cp	a,#10
3784  0975 2406          	jruge	L3202
3787  0977 725c001f      	inc	L5771_dtcON
3789  097b 2005          	jra	L7102
3790  097d               L3202:
3791                     ; 924 	        if((DTCstate[DTCD004] & DTCconfirmed)!=0)
3793  097d c60013        	ld	a,_DTCstate+19
3794  0980 a508          	bcp	a,#8
3795  0982               L7102:
3796                     ; 932     if(dtcTIME > DTC96MS)
3798  0982 c6001e        	ld	a,L3771_dtcTIME
3799  0985 a10d          	cp	a,#13
3800  0987 250c          	jrult	L1302
3801                     ; 934         dtcON = 0;
3803  0989 725f001f      	clr	L5771_dtcON
3804                     ; 936         if((DTCstate[DTCD004] & DTCcycleFail)==0)
3806  098d c60013        	ld	a,_DTCstate+19
3807  0990 a502          	bcp	a,#2
3808  0992 c6001e        	ld	a,L3771_dtcTIME
3809  0995               L1302:
3810                     ; 942 	if(dtcTIME >=DTC1000MS)
3812  0995 a17d          	cp	a,#125
3813  0997 2509          	jrult	L5302
3814                     ; 944 	    dtcON = 0;
3816  0999 725f001f      	clr	L5771_dtcON
3817                     ; 946         if((DTCstate[DTCD004] & DTCconfirmed)==0)
3819  099d c60013        	ld	a,_DTCstate+19
3820  09a0 a508          	bcp	a,#8
3821  09a2               L5302:
3822                     ; 953 }
3825  09a2 87            	retf	
3827                     	switch	.bss
3828  0020               L1402_dtcTIME:
3829  0020 00            	ds.b	1
3830  0021               L3402_dtcON:
3831  0021 00            	ds.b	1
3870                     ; 955 void UDSDTCd005(void)
3870                     ; 956 {
3871                     	switch	.text
3872  09a3               f_UDSDTCd005:
3876                     ; 960 	if(dtcTIME < DTC1000MS)dtcTIME++;
3878  09a3 c60020        	ld	a,L1402_dtcTIME
3879  09a6 a17d          	cp	a,#125
3880  09a8 2404          	jruge	L3602
3883  09aa 725c0020      	inc	L1402_dtcTIME
3884  09ae               L3602:
3885                     ; 961     if(DTC_SRS_ID)
3887  09ae c60000        	ld	a,_DTC_SRS_ID
3888  09b1 271b          	jreq	L5602
3889                     ; 965 		dtcTIME = 0;
3891  09b3 725f0020      	clr	L1402_dtcTIME
3892                     ; 967         if((DTCstate[DTCD005] & DTCcycleFail)!=0)
3894  09b7 c60014        	ld	a,_DTCstate+20
3895  09ba a502          	bcp	a,#2
3896                     ; 972 		if(dtcON < 10)dtcON++;
3898  09bc c60021        	ld	a,L3402_dtcON
3899  09bf a10a          	cp	a,#10
3900  09c1 2406          	jruge	L1702
3903  09c3 725c0021      	inc	L3402_dtcON
3905  09c7 2005          	jra	L5602
3906  09c9               L1702:
3907                     ; 976 	        if((DTCstate[DTCD005] & DTCconfirmed)!=0)
3909  09c9 c60014        	ld	a,_DTCstate+20
3910  09cc a508          	bcp	a,#8
3911  09ce               L5602:
3912                     ; 984     if(dtcTIME > DTC96MS)
3914  09ce c60020        	ld	a,L1402_dtcTIME
3915  09d1 a10d          	cp	a,#13
3916  09d3 250c          	jrult	L7702
3917                     ; 986         dtcON = 0;
3919  09d5 725f0021      	clr	L3402_dtcON
3920                     ; 988         if((DTCstate[DTCD005] & DTCcycleFail)==0)
3922  09d9 c60014        	ld	a,_DTCstate+20
3923  09dc a502          	bcp	a,#2
3924  09de c60020        	ld	a,L1402_dtcTIME
3925  09e1               L7702:
3926                     ; 994 	if(dtcTIME >= DTC1000MS)
3928  09e1 a17d          	cp	a,#125
3929  09e3 2509          	jrult	L3012
3930                     ; 996 	    dtcON = 0;
3932  09e5 725f0021      	clr	L3402_dtcON
3933                     ; 998         if((DTCstate[DTCD005] & DTCconfirmed)==0)
3935  09e9 c60014        	ld	a,_DTCstate+20
3936  09ec a508          	bcp	a,#8
3937  09ee               L3012:
3938                     ; 1005 }
3941  09ee 87            	retf	
3953                     	xref	_IGNstate
3954                     	xref	_battervalue
3955                     	xref	_KeyInState
3956                     	xref	_TurnLampState
3957                     	xref	_DoorState
3958                     	xref	_LockState
3959                     	xref	_LockDrvCmd
3960                     	xref	_TurnLampDrv
3961                     	xref	f_GetADCresultAverage
3962                     	xref	f_Weeprommain
3963                     	xref	_DTCRuningstate
3964                     	xref	_DTC_EMS_ID2
3965                     	xref	_DTC_EMS_ID1
3966                     	xref	_DTC_TCU_ID
3967                     	xref	_DTC_ABS_ID
3968                     	xref	_DTC_SRS_ID
3969                     	xref	_DTCstate
3970                     	xdef	f_UDSDTCd005
3971                     	xdef	f_UDSDTCd004
3972                     	xdef	f_UDSDTCd003
3973                     	xdef	f_UDSDTCd002
3974                     	xdef	f_UDSDTCd001
3975                     	xdef	f_UDSDTC900c
3976                     	xdef	f_UDSDTC9073
3977                     	xdef	f_UDSDTC9045
3978                     	xdef	f_UDSDTC9067
3979                     	xdef	f_UDSDTC9061
3980                     	xdef	f_UDSDTC9093
3981                     	xdef	f_UDSDTC9043
3982                     	xdef	f_UDSDTC9007
3983                     	xdef	f_UDSDTC9023
3984                     	xdef	f_UDSDTC9011
3985                     	xdef	f_UDSDTC9083
3986                     	xdef	f_UDSDTC9091
3987                     	xdef	f_UDSDTC9111
3988                     	xdef	f_UDSDTC9015
3989                     	xdef	f_UDSDTC9003
3990                     	xdef	f_UDSDTC9001
3991                     	xdef	f_UDSDTC_main
3992                     	xref.b	c_lreg
4011                     	xref	d_uitolx
4012                     	end
