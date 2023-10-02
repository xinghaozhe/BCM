   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 776                     	switch	.data
 777  0000               _LIN_RECIVE_DataLength:
 778  0000 00            	dc.b	0
 779  0001               _RxBufIndex:
 780  0001 00            	dc.b	0
 781  0002               _TxBufIndex:
 782  0002 00            	dc.b	0
 817                     ; 91 void LIN_Init(void)
 817                     ; 92 {
 818                     	switch	.text
 819  0000               f_LIN_Init:
 823                     ; 93     LINUART_StructInit(&LINcfg);
 825  0000 ae0006        	ldw	x,#_LINcfg
 826  0003 8d000000      	callf	f_LINUART_StructInit
 828                     ; 94     LINUART_Init(&LINcfg);
 830  0007 ae0006        	ldw	x,#_LINcfg
 831  000a 8d000000      	callf	f_LINUART_Init
 833                     ; 95     LINUART_LINCmd(ENABLE);
 835  000e a601          	ld	a,#1
 836  0010 8d000000      	callf	f_LINUART_LINCmd
 838                     ; 96     LINUART_LINConfig(LINUART_LIN_MASTER_MODE,LINUART_LIN_AUTOSYNC_DISABLE,LINUART_LIN_DIVUP_NEXTRXNE);
 840  0014 4b02          	push	#2
 841  0016 ae0002        	ldw	x,#2
 842  0019 a601          	ld	a,#1
 843  001b 95            	ld	xh,a
 844  001c 8d000000      	callf	f_LINUART_LINConfig
 846  0020 84            	pop	a
 847                     ; 97     LINUART_LINBreakDetectionConfig(LINUART_BREAK11BITS);  
 849  0021 a602          	ld	a,#2
 850  0023 8d000000      	callf	f_LINUART_LINBreakDetectionConfig
 852                     ; 98 	LIN_ENABLE;
 854  0027 7218500f      	bset	20495,#4
 855                     ; 99 }
 858  002b 87            	retf	
 891                     ; 101 void LIN_LinRcBuffer_init(void)
 891                     ; 102 {
 892                     	switch	.text
 893  002c               f_LIN_LinRcBuffer_init:
 895  002c 88            	push	a
 896       00000001      OFST:	set	1
 899                     ; 105     for(i=0;i<8;i++)
 901  002d 4f            	clr	a
 902  002e 6b01          	ld	(OFST+0,sp),a
 903  0030               L564:
 904                     ; 106     LinRcBuffer[i] = 0x00;
 906  0030 5f            	clrw	x
 907  0031 97            	ld	xl,a
 908  0032 724f002c      	clr	(_LinRcBuffer,x)
 909                     ; 105     for(i=0;i<8;i++)
 911  0036 0c01          	inc	(OFST+0,sp)
 914  0038 7b01          	ld	a,(OFST+0,sp)
 915  003a a108          	cp	a,#8
 916  003c 25f2          	jrult	L564
 917                     ; 107 }
 920  003e 84            	pop	a
 921  003f 87            	retf	
 945                     ; 109 void LIN_BCM1_init(void)
 945                     ; 110 {
 946                     	switch	.text
 947  0040               f_LIN_BCM1_init:
 951                     ; 113     LIN1_BCM_WindowEnable = Windowdisable;   
 953  0040 72100042      	bset	_LIN_BCM_FRAME1,#0
 954                     ; 115     if( (VehicleType & 0xf0) == CV8 )
 956  0044 c60000        	ld	a,_VehicleType
 957  0047 a4f0          	and	a,#240
 958  0049 a120          	cp	a,#32
 959  004b 2609          	jrne	L305
 960                     ; 117         LIN1_BCM_VehicleModel = VehicleModel_CV8;//VehicleModel_CV8; //V101
 962  004d c60042        	ld	a,_LIN_BCM_FRAME1
 963  0050 a4f1          	and	a,#241
 964  0052 c70042        	ld	_LIN_BCM_FRAME1,a
 967  0055 87            	retf	
 968  0056               L305:
 969                     ; 119     else if((VehicleType & 0xf0) == CV101)
 971  0056 c60000        	ld	a,_VehicleType
 972  0059 a4f0          	and	a,#240
 973  005b a130          	cp	a,#48
 974                     ; 132 }
 977  005d 87            	retf	
1000                     ; 134 void LIN_BCM2_init(void)
1000                     ; 135 {
1001                     	switch	.text
1002  005e               f_LIN_BCM2_init:
1006                     ; 137     LIN2_BCM_WiperSwitchPosition = WiperSwitchPosition_OFF;
1008  005e c6003e        	ld	a,_LIN_BCM_FRAME2
1009  0061 a4f8          	and	a,#248
1010  0063 c7003e        	ld	_LIN_BCM_FRAME2,a
1011                     ; 140     LIN2_BCM_SensitivitySetting = BCM_SensitivitySetting_1D;  
1013  0066 c6003f        	ld	a,_LIN_BCM_FRAME2+1
1014  0069 a4f0          	and	a,#240
1015  006b c7003f        	ld	_LIN_BCM_FRAME2+1,a
1016                     ; 143     LIN2_BCM_AmbientTemperature = BCM_AmbientTemperature_Default;
1018  006e c60040        	ld	a,_LIN_BCM_FRAME2+2
1019  0071 aaff          	or	a,#255
1020  0073 c70040        	ld	_LIN_BCM_FRAME2+2,a
1021                     ; 145 }
1024  0076 87            	retf	
1047                     ; 149 void LIN_DDCU_init(void)
1047                     ; 150 {  
1048                     	switch	.text
1049  0077               f_LIN_DDCU_init:
1053                     ; 152     LIN_DDCU_BYTE0 = 0x00;
1055  0077 725f003c      	clr	_LIN_DDCU_FRAME
1056                     ; 154     LIN_DDCU_BYTE1= 0x00;
1058  007b 725f003d      	clr	_LIN_DDCU_FRAME+1
1059                     ; 155 }
1062  007f 87            	retf	
1085                     ; 157 void LIN_PDCU_init(void)
1085                     ; 158 {  
1086                     	switch	.text
1087  0080               f_LIN_PDCU_init:
1091                     ; 160     LIN_PDCU_BYTE0 = 0x00;
1093  0080 725f003a      	clr	_LIN_PDCU_FRAME
1094                     ; 162     LIN_PDCU_BYTE1= 0x00;
1096  0084 725f003b      	clr	_LIN_PDCU_FRAME+1
1097                     ; 163 }
1100  0088 87            	retf	
1123                     ; 165 void LIN_RLDCU_init(void)
1123                     ; 166 {
1124                     	switch	.text
1125  0089               f_LIN_RLDCU_init:
1129                     ; 168     LIN_RLDCU_BYTE0 = 0x00;
1131  0089 725f0038      	clr	_LIN_RLDCU_FRAME
1132                     ; 170     LIN_RLDCU_BYTE1= 0x00;    
1134  008d 725f0039      	clr	_LIN_RLDCU_FRAME+1
1135                     ; 171 }
1138  0091 87            	retf	
1161                     ; 173 void LIN_RRDCU_init(void)
1161                     ; 174 {
1162                     	switch	.text
1163  0092               f_LIN_RRDCU_init:
1167                     ; 176     LIN_RRDCU_BYTE0 = 0x00;
1169  0092 725f0036      	clr	_LIN_RRDCU_FRAME
1170                     ; 178     LIN_RRDCU_BYTE1= 0x00;
1172  0096 725f0037      	clr	_LIN_RRDCU_FRAME+1
1173                     ; 180 }
1176  009a 87            	retf	
1199                     ; 182 void LIN_RAINS_init(void)
1199                     ; 183 {
1200                     	switch	.text
1201  009b               f_LIN_RAINS_init:
1205                     ; 185     LIN_RAINS_BYTE0 = 0x00;
1207  009b 725f0034      	clr	_LIN_RAINS_FRAME
1208                     ; 187     LIN_RAINS_BYTE1= 0x00;
1210  009f 725f0035      	clr	_LIN_RAINS_FRAME+1
1211                     ; 188 }
1214  00a3 87            	retf	
1243                     ; 190 void LIN_FrameInit(void)
1243                     ; 191 {
1244                     	switch	.text
1245  00a4               f_LIN_FrameInit:
1249                     ; 192     LIN_BCM1_init();
1251  00a4 8d400040      	callf	f_LIN_BCM1_init
1253                     ; 193     LIN_BCM2_init();
1255  00a8 8d5e005e      	callf	f_LIN_BCM2_init
1257                     ; 194     LIN_DDCU_init();
1259  00ac 8d770077      	callf	f_LIN_DDCU_init
1261                     ; 195     LIN_PDCU_init();
1263  00b0 8d800080      	callf	f_LIN_PDCU_init
1265                     ; 196     LIN_RLDCU_init();
1267  00b4 8d890089      	callf	f_LIN_RLDCU_init
1269                     ; 197     LIN_RRDCU_init();
1271  00b8 8d920092      	callf	f_LIN_RRDCU_init
1273                     ; 198     LIN_RAINS_init();
1276                     ; 199 }
1279  00bc 20dd          	jpf	f_LIN_RAINS_init
1302                     ; 205 void LIN_SCISendBreak(void)
1302                     ; 206 { 
1303                     	switch	.text
1304  00be               f_LIN_SCISendBreak:
1308                     ; 211     LINUART_SendBreak();
1310  00be 8d000000      	callf	f_LINUART_SendBreak
1312                     ; 212     LINUART->CR2 |= (u8)(LINUART_CR2_TEN);
1314  00c2 72165235      	bset	21045,#3
1315                     ; 213 }
1318  00c6 87            	retf	
1343                     ; 218 void LIN_SCISendSYNField(void)
1343                     ; 219 { 
1344                     	switch	.text
1345  00c7               f_LIN_SCISendSYNField:
1349                     ; 220     LINUART_ITConfig(LINUART_IT_TIEN,ENABLE);
1351  00c7 ae0001        	ldw	x,#1
1352  00ca a680          	ld	a,#128
1353  00cc 95            	ld	xh,a
1354  00cd 8d000000      	callf	f_LINUART_ITConfig
1356                     ; 221     LINUART_SendData8(0x55);
1358  00d1 a655          	ld	a,#85
1360                     ; 222 }
1363  00d3 ac000000      	jpf	f_LINUART_SendData8
1387                     ; 227 void LIN_SCISendHeader(void)
1387                     ; 228 {
1388                     	switch	.text
1389  00d7               f_LIN_SCISendHeader:
1393                     ; 229     (LinTxBuffer[2]);
1395                     ; 230     LINUART_ITConfig(LINUART_IT_TIEN,ENABLE);
1397  00d7 ae0001        	ldw	x,#1
1398  00da a680          	ld	a,#128
1399  00dc 95            	ld	xh,a
1401                     ; 231 }
1404  00dd ac000000      	jpf	f_LINUART_ITConfig
1427                     ; 236 void LIN_SCISendData(void)
1427                     ; 237 { 
1428                     	switch	.text
1429  00e1               f_LIN_SCISendData:
1433                     ; 238     LINUART_ITConfig(LINUART_IT_RIEN,DISABLE);
1435  00e1 5f            	clrw	x
1436  00e2 a620          	ld	a,#32
1437  00e4 95            	ld	xh,a
1438  00e5 8d000000      	callf	f_LINUART_ITConfig
1440                     ; 239     LINUART_ITConfig(LINUART_IT_TIEN,ENABLE);
1442  00e9 ae0001        	ldw	x,#1
1443  00ec a680          	ld	a,#128
1444  00ee 95            	ld	xh,a
1446                     ; 241 }
1449  00ef ac000000      	jpf	f_LINUART_ITConfig
1472                     ; 243  void LIN_SCIReciveData(void)
1472                     ; 244 { 
1473                     	switch	.text
1474  00f3               f_LIN_SCIReciveData:
1478                     ; 245     LINUART_ITConfig(LINUART_IT_TIEN,DISABLE);
1480  00f3 5f            	clrw	x
1481  00f4 a680          	ld	a,#128
1482  00f6 95            	ld	xh,a
1483  00f7 8d000000      	callf	f_LINUART_ITConfig
1485                     ; 246     LINUART_ITConfig(LINUART_IT_RIEN,ENABLE);
1487  00fb ae0001        	ldw	x,#1
1488  00fe a620          	ld	a,#32
1489  0100 95            	ld	xh,a
1491                     ; 247 }
1494  0101 ac000000      	jpf	f_LINUART_ITConfig
1517                     ; 250 void LIN_SCIOFF(void)
1517                     ; 251 { 
1518                     	switch	.text
1519  0105               f_LIN_SCIOFF:
1523                     ; 252     LINUART_ITConfig(LINUART_IT_RIEN,DISABLE);
1525  0105 5f            	clrw	x
1526  0106 a620          	ld	a,#32
1527  0108 95            	ld	xh,a
1528  0109 8d000000      	callf	f_LINUART_ITConfig
1530                     ; 253     LINUART_ITConfig(LINUART_IT_TIEN,DISABLE);  
1532  010d 5f            	clrw	x
1533  010e a680          	ld	a,#128
1534  0110 95            	ld	xh,a
1536                     ; 256 }
1539  0111 ac000000      	jpf	f_LINUART_ITConfig
1581                     ; 265 void LIN_PutMsg(uchar msgId)
1581                     ; 266 {
1582                     	switch	.text
1583  0115               f_LIN_PutMsg:
1587                     ; 267     LinTxBuffer[1] = 0x55;
1589  0115 35550025      	mov	_LinTxBuffer+1,#85
1590                     ; 269     LinTxBuffer[2] = msgId;
1592  0119 c70026        	ld	_LinTxBuffer+2,a
1593                     ; 271     switch(msgId)
1596                     ; 368         	break;
1597  011c a011          	sub	a,#17
1598  011e 2604aced01ed  	jreq	L766
1599  0124 a00f          	sub	a,#15
1600  0126 2770          	jreq	L366
1601  0128 a030          	sub	a,#48
1602  012a 2604acd901d9  	jreq	L566
1603  0130 a030          	sub	a,#48
1604  0132 2604ac290229  	jreq	L576
1605  0138 a012          	sub	a,#18
1606  013a 2604ac010201  	jreq	L176
1607  0140 a01f          	sub	a,#31
1608  0142 2719          	jreq	L166
1609  0144 a022          	sub	a,#34
1610  0146 2604ac150215  	jreq	L376
1611                     ; 364             LIN_SCIOFF();
1613  014c 8d050105      	callf	f_LIN_SCIOFF
1615                     ; 365         	RxBufIndex = 0;
1617  0150 725f0001      	clr	_RxBufIndex
1618                     ; 366             LIN_StateFlag = LIN_Idle;   
1620  0154 725f0023      	clr	_LIN_StateFlag
1621                     ; 367         	LIN_OUT_TIME_FLAG = 0;
1623  0158 725f0020      	clr	_LIN_OUT_TIME_FLAG
1624                     ; 368         	break;
1627  015c 87            	retf	
1628  015d               L166:
1629                     ; 275             LIN1_BCM_VehicleModel = VehicleModel_CV8;//VehicleModel_CV8; //V101
1631  015d c60042        	ld	a,_LIN_BCM_FRAME1
1632  0160 a4f1          	and	a,#241
1633  0162 c70042        	ld	_LIN_BCM_FRAME1,a
1634                     ; 276             LinTxBuffer[3] = LIN1_BCM_BYTE0;
1636  0165 c70027        	ld	_LinTxBuffer+3,a
1637                     ; 277             LinTxBuffer[4] = LIN1_BCM_BYTE1;
1639  0168 5500430028    	mov	_LinTxBuffer+4,_LIN_BCM_FRAME1+1
1640                     ; 278             LinTxBuffer[5] = LIN1_BCM_BYTE2;
1642  016d 5500440029    	mov	_LinTxBuffer+5,_LIN_BCM_FRAME1+2
1643                     ; 279             LinTxBuffer[6] = LIN1_BCM_BYTE3;
1645  0172 550045002a    	mov	_LinTxBuffer+6,_LIN_BCM_FRAME1+3
1646                     ; 281             LinTxBuffer[7] =ID_BCM1 + LinTxBuffer[3] + LinTxBuffer[4] + LinTxBuffer[5] + LinTxBuffer[6] ;
1648  0177 cb0028        	add	a,_LinTxBuffer+4
1649  017a cb0029        	add	a,_LinTxBuffer+5
1650  017d cb002a        	add	a,_LinTxBuffer+6
1651  0180 abb1          	add	a,#177
1652  0182 43            	cpl	a
1653  0183 c7002b        	ld	_LinTxBuffer+7,a
1654                     ; 282             LinTxBuffer[7] = ~LinTxBuffer[7] ;
1656                     ; 283             LINsendLen = LIN_BCM1_DataLength + 1 ;
1658  0186 35070021      	mov	_LINsendLen,#7
1659                     ; 286             TxBufIndex = 0;
1661  018a 725f0002      	clr	_TxBufIndex
1662                     ; 287             LIN_StateFlag = LIN_SendData;
1664  018e 35010023      	mov	_LIN_StateFlag,#1
1665                     ; 288             LIN_IDFlag = ID_BCM1;
1667  0192 35b1001d      	mov	_LIN_IDFlag,#177
1668                     ; 289             LIN_RECIVE_DataLength = 0;
1669                     ; 290         } break;
1671  0196 203c          	jpf	LC002
1672  0198               L366:
1673                     ; 294             LIN1_BCM_VehicleModel = VehicleModel_CV8;//VehicleModel_CV8; //V101
1675  0198 c60042        	ld	a,_LIN_BCM_FRAME1
1676  019b a4f1          	and	a,#241
1677  019d c70042        	ld	_LIN_BCM_FRAME1,a
1678                     ; 295             LinTxBuffer[3] = LIN2_BCM_BYTE0;
1680  01a0 c6003e        	ld	a,_LIN_BCM_FRAME2
1681  01a3 c70027        	ld	_LinTxBuffer+3,a
1682                     ; 296             LinTxBuffer[4] = LIN2_BCM_BYTE1;
1684  01a6 55003f0028    	mov	_LinTxBuffer+4,_LIN_BCM_FRAME2+1
1685                     ; 297             LinTxBuffer[5] = LIN2_BCM_BYTE2;
1687  01ab 5500400029    	mov	_LinTxBuffer+5,_LIN_BCM_FRAME2+2
1688                     ; 298             LinTxBuffer[6] = LIN2_BCM_BYTE3;
1690  01b0 550041002a    	mov	_LinTxBuffer+6,_LIN_BCM_FRAME2+3
1691                     ; 300             LinTxBuffer[7] =ID_BCM2+ LinTxBuffer[3] + LinTxBuffer[4] + LinTxBuffer[5] + LinTxBuffer[6] ;
1693  01b5 cb0028        	add	a,_LinTxBuffer+4
1694  01b8 cb0029        	add	a,_LinTxBuffer+5
1695  01bb cb002a        	add	a,_LinTxBuffer+6
1696  01be ab20          	add	a,#32
1697  01c0 43            	cpl	a
1698  01c1 c7002b        	ld	_LinTxBuffer+7,a
1699                     ; 301             LinTxBuffer[7] = ~LinTxBuffer[7] ;
1701                     ; 302             LINsendLen = LIN_BCM1_DataLength + 1 ;
1703  01c4 35070021      	mov	_LINsendLen,#7
1704                     ; 305             TxBufIndex = 0;
1706  01c8 725f0002      	clr	_TxBufIndex
1707                     ; 306             LIN_StateFlag = LIN_SendData;
1709  01cc 35010023      	mov	_LIN_StateFlag,#1
1710                     ; 307             LIN_IDFlag = ID_BCM2;
1712  01d0 3520001d      	mov	_LIN_IDFlag,#32
1713                     ; 308             LIN_RECIVE_DataLength = 0;
1715  01d4               LC002:
1717  01d4 725f0000      	clr	_LIN_RECIVE_DataLength
1718                     ; 310         } break;
1721  01d8 87            	retf	
1722  01d9               L566:
1723                     ; 314             LINsendLen = LIN_DDCU_DataLength ;
1725  01d9 35020021      	mov	_LINsendLen,#2
1726                     ; 315             TxBufIndex = 0;
1728  01dd c70002        	ld	_TxBufIndex,a
1729                     ; 316             RxBufIndex = 0;
1731  01e0 c70001        	ld	_RxBufIndex,a
1732                     ; 317             LIN_StateFlag = LIN_SendData;
1734  01e3 35010023      	mov	_LIN_StateFlag,#1
1735                     ; 318             LIN_IDFlag = ID_DDCU;
1737  01e7 3550001d      	mov	_LIN_IDFlag,#80
1738                     ; 319             LIN_RECIVE_DataLength = LIN_DDCU_DataLength ;//+ 1 ;
1739                     ; 320         }break;
1741  01eb 204e          	jpf	LC001
1742  01ed               L766:
1743                     ; 324             LINsendLen = LIN_PDCU_DataLength ;
1745  01ed 35020021      	mov	_LINsendLen,#2
1746                     ; 325             TxBufIndex = 0;
1748  01f1 c70002        	ld	_TxBufIndex,a
1749                     ; 326             RxBufIndex = 0;
1751  01f4 c70001        	ld	_RxBufIndex,a
1752                     ; 327             LIN_StateFlag = LIN_SendData;
1754  01f7 35010023      	mov	_LIN_StateFlag,#1
1755                     ; 328             LIN_IDFlag = ID_PDCU;
1757  01fb 3511001d      	mov	_LIN_IDFlag,#17
1758                     ; 329             LIN_RECIVE_DataLength = LIN_PDCU_DataLength ;//+ 1 ;
1759                     ; 330         }break;
1761  01ff 203a          	jpf	LC001
1762  0201               L176:
1763                     ; 334             LINsendLen = LIN_RLDCU_DataLength ;
1765  0201 35020021      	mov	_LINsendLen,#2
1766                     ; 335             TxBufIndex = 0;
1768  0205 c70002        	ld	_TxBufIndex,a
1769                     ; 336             RxBufIndex = 0;
1771  0208 c70001        	ld	_RxBufIndex,a
1772                     ; 337             LIN_StateFlag = LIN_SendData;
1774  020b 35010023      	mov	_LIN_StateFlag,#1
1775                     ; 338             LIN_IDFlag = ID_RLDCU;
1777  020f 3592001d      	mov	_LIN_IDFlag,#146
1778                     ; 339             LIN_RECIVE_DataLength = LIN_RLDCU_DataLength ;//+ 1 ;
1779                     ; 340         }break;
1781  0213 2026          	jpf	LC001
1782  0215               L376:
1783                     ; 344             LINsendLen = LIN_RRDCU_DataLength ;
1785  0215 35020021      	mov	_LINsendLen,#2
1786                     ; 345             TxBufIndex = 0;
1788  0219 c70002        	ld	_TxBufIndex,a
1789                     ; 346             RxBufIndex = 0;
1791  021c c70001        	ld	_RxBufIndex,a
1792                     ; 347             LIN_StateFlag = LIN_SendData;
1794  021f 35010023      	mov	_LIN_StateFlag,#1
1795                     ; 348             LIN_IDFlag = ID_RRDCU;
1797  0223 35d3001d      	mov	_LIN_IDFlag,#211
1798                     ; 349             LIN_RECIVE_DataLength = LIN_RRDCU_DataLength ;//+ 1 ;
1799                     ; 350         }break;
1801  0227 2012          	jpf	LC001
1802  0229               L576:
1803                     ; 354             LINsendLen = LIN_RAINS_DataLength ;
1805  0229 35020021      	mov	_LINsendLen,#2
1806                     ; 355             TxBufIndex = 0;
1808  022d c70002        	ld	_TxBufIndex,a
1809                     ; 356             RxBufIndex = 0;
1811  0230 c70001        	ld	_RxBufIndex,a
1812                     ; 357             LIN_StateFlag = LIN_SendData;
1814  0233 35010023      	mov	_LIN_StateFlag,#1
1815                     ; 358             LIN_IDFlag = ID_RAINS;
1817  0237 3580001d      	mov	_LIN_IDFlag,#128
1818                     ; 359             LIN_RECIVE_DataLength = LIN_RAINS_DataLength ;//+ 1 ;;
1820  023b               LC001:
1825  023b 35020000      	mov	_LIN_RECIVE_DataLength,#2
1826                     ; 360         }break;
1828                     ; 371 }
1831  023f 87            	retf	
1869                     ; 385 void LinTaskScheduler(void)
1869                     ; 386 {
1870                     	switch	.text
1871  0240               f_LinTaskScheduler:
1875                     ; 387 	Clear_WDT();
1877  0240 8d000000      	callf	f_Clear_WDT
1879                     ; 389     LIN_OUT_TIME_FLAG++;
1881  0244 725c0020      	inc	_LIN_OUT_TIME_FLAG
1882                     ; 390     switch(LIN_OUT_TIME_FLAG)
1884  0248 c60020        	ld	a,_LIN_OUT_TIME_FLAG
1886                     ; 603         }break;
1887  024b 4a            	dec	a
1888  024c 275f          	jreq	L127
1889  024e a009          	sub	a,#9
1890  0250 2604aca003a0  	jreq	L5201
1891  0256 4a            	dec	a
1892  0257 275d          	jreq	L527
1893  0259 a009          	sub	a,#9
1894  025b 27f5          	jreq	L5201
1895  025d 4a            	dec	a
1896  025e 275a          	jreq	L137
1897  0260 a004          	sub	a,#4
1898  0262 275f          	jreq	L337
1899  0264 4a            	dec	a
1900  0265 2604acf602f6  	jreq	L537
1901  026b a004          	sub	a,#4
1902  026d 2604ac090309  	jreq	L737
1903  0273 4a            	dec	a
1904  0274 2604ac360336  	jreq	L147
1905  027a a004          	sub	a,#4
1906  027c 2604ac3f033f  	jreq	L347
1907  0282 4a            	dec	a
1908  0283 2604ac6c036c  	jreq	L547
1909  0289 a004          	sub	a,#4
1910  028b 2604ac750375  	jreq	L747
1911                     ; 596             if (LIN_OUT_TIME_FLAG > LINFrame_Cycle_duty)
1913  0291 c60020        	ld	a,_LIN_OUT_TIME_FLAG
1914  0294 a133          	cp	a,#51
1915  0296 2404aca803a8  	jrult	L567
1916                     ; 598                 LIN_SCIOFF();
1918  029c 8d050105      	callf	f_LIN_SCIOFF
1920                     ; 599                 LIN_StateFlag = LIN_Idle;
1922  02a0 725f0023      	clr	_LIN_StateFlag
1923                     ; 600                 LIN_OUT_TIME_FLAG  = 0;
1925  02a4 725f0020      	clr	_LIN_OUT_TIME_FLAG
1926                     ; 601                 LINWINDOWSTATE++;
1928  02a8 725c0000      	inc	_LINWINDOWSTATE
1930  02ac 87            	retf	
1931  02ad               L127:
1932                     ; 396             if (LIN_StateFlag == LIN_Idle)
1934  02ad c60023        	ld	a,_LIN_StateFlag
1935  02b0 26e6          	jrne	L567
1936                     ; 398                 LIN_PutMsg(ID_BCM1);
1938  02b2 a6b1          	ld	a,#177
1940                     ; 399                 LIN_SCISendBreak();
1942                     ; 400                 LIN_SCISendData();
1944  02b4 2047          	jpf	LC008
1945                     ; 407             LIN_SCIOFF();
1947                     ; 408             LIN_StateFlag = LIN_Idle;        
1948                     ; 409         }break;
1950  02b6               L527:
1951                     ; 415             LIN_PutMsg(ID_BCM2);
1953  02b6 a620          	ld	a,#32
1955                     ; 416             LIN_SCISendBreak();
1957                     ; 417             LIN_SCISendData();
1959                     ; 418         }break; 
1961  02b8 2043          	jpf	LC008
1962                     ; 423             LIN_SCIOFF();
1964                     ; 424             LIN_StateFlag = LIN_Idle;
1965                     ; 425         }break;
1967  02ba               L137:
1968                     ; 432             if (LIN_StateFlag == LIN_Idle)
1970  02ba c60023        	ld	a,_LIN_StateFlag
1971  02bd 26d9          	jrne	L567
1972                     ; 434                 LIN_PutMsg(ID_DDCU);
1974  02bf a650          	ld	a,#80
1976                     ; 435                 LIN_SCISendBreak();
1978                     ; 436                 LIN_SCISendData();
1980  02c1 203a          	jpf	LC008
1981  02c3               L337:
1982                     ; 443             if ((LIN_IDFlag == ID_DDCU) && (LIN_StateFlag == LIN_ReceiveFinished))
1984  02c3 c6001d        	ld	a,_LIN_IDFlag
1985  02c6 a150          	cp	a,#80
1986  02c8 2618          	jrne	L377
1988  02ca c60023        	ld	a,_LIN_StateFlag
1989  02cd a104          	cp	a,#4
1990  02cf 2611          	jrne	L377
1991                     ; 445                 LIN_DDCU_BYTE0 = LinRcBuffer[1];
1993  02d1 55002d003c    	mov	_LIN_DDCU_FRAME,_LinRcBuffer+1
1994                     ; 446                 LIN_DDCU_BYTE1 = LinRcBuffer[2]; 
1996  02d6 55002e003d    	mov	_LIN_DDCU_FRAME+1,_LinRcBuffer+2
1997                     ; 447                 LIN_LinRcBuffer_init();
1999  02db 8d2c002c      	callf	f_LIN_LinRcBuffer_init
2001                     ; 448                 LostCommunication[2] = 0 ;
2003  02df 5f            	clrw	x
2005  02e0 200d          	jpf	LC003
2006  02e2               L377:
2007                     ; 450             else if (LostCommunication[2] < 10 )
2009  02e2 ce0013        	ldw	x,_LostCommunication+4
2010  02e5 a3000a        	cpw	x,#10
2011  02e8 2504aca003a0  	jruge	L5201
2012                     ; 452                 LostCommunication[2] ++ ;   //lost communication
2014  02ee 5c            	incw	x
2015  02ef               LC003:
2016  02ef cf0013        	ldw	_LostCommunication+4,x
2017                     ; 455             LIN_SCIOFF();
2019                     ; 456             LIN_StateFlag = LIN_Idle;
2020                     ; 457         } break;
2022  02f2 aca003a0      	jpf	L5201
2023  02f6               L537:
2024                     ; 463             if (LIN_StateFlag == LIN_Idle)
2026  02f6 c60023        	ld	a,_LIN_StateFlag
2027  02f9 269d          	jrne	L567
2028                     ; 465                 LIN_PutMsg(ID_PDCU);
2030  02fb a611          	ld	a,#17
2032                     ; 466                 LIN_SCISendBreak();
2035                     ; 467                 LIN_SCISendData();
2037  02fd               LC008:
2038  02fd 8d150115      	callf	f_LIN_PutMsg
2044  0301 8dbe00be      	callf	f_LIN_SCISendBreak
2052  0305 ace100e1      	jpf	f_LIN_SCISendData
2053  0309               L737:
2054                     ; 474             if ((LIN_IDFlag == ID_PDCU) && (LIN_StateFlag == LIN_ReceiveFinished))
2056  0309 c6001d        	ld	a,_LIN_IDFlag
2057  030c a111          	cp	a,#17
2058  030e 2618          	jrne	L3001
2060  0310 c60023        	ld	a,_LIN_StateFlag
2061  0313 a104          	cp	a,#4
2062  0315 2611          	jrne	L3001
2063                     ; 476                 LIN_PDCU_BYTE0 = LinRcBuffer[1];
2065  0317 55002d003a    	mov	_LIN_PDCU_FRAME,_LinRcBuffer+1
2066                     ; 477                 LIN_PDCU_BYTE1 = LinRcBuffer[2]; 
2068  031c 55002e003b    	mov	_LIN_PDCU_FRAME+1,_LinRcBuffer+2
2069                     ; 478                 LIN_LinRcBuffer_init();
2071  0321 8d2c002c      	callf	f_LIN_LinRcBuffer_init
2073                     ; 479                 LostCommunication[3] = 0;
2075  0325 5f            	clrw	x
2077  0326 2009          	jpf	LC004
2078  0328               L3001:
2079                     ; 481             else if (LostCommunication[3] < 10 )
2081  0328 ce0015        	ldw	x,_LostCommunication+6
2082  032b a3000a        	cpw	x,#10
2083  032e 2470          	jruge	L5201
2084                     ; 483                 LostCommunication[3] ++ ;   //lost communication
2086  0330 5c            	incw	x
2087  0331               LC004:
2088  0331 cf0015        	ldw	_LostCommunication+6,x
2089                     ; 486             LIN_SCIOFF();
2091                     ; 487             LIN_StateFlag = LIN_Idle;
2092                     ; 488         }break;
2094  0334 206a          	jpf	L5201
2095  0336               L147:
2096                     ; 494             if (LIN_StateFlag == LIN_Idle)
2098  0336 c60023        	ld	a,_LIN_StateFlag
2099  0339 266d          	jrne	L567
2100                     ; 496                 LIN_PutMsg(ID_RLDCU);
2102  033b a692          	ld	a,#146
2104                     ; 497                 LIN_SCISendBreak();
2106                     ; 498                 LIN_SCISendData();
2108  033d 20be          	jpf	LC008
2109  033f               L347:
2110                     ; 505             if ((LIN_IDFlag == ID_RLDCU) && (LIN_StateFlag == LIN_ReceiveFinished))
2112  033f c6001d        	ld	a,_LIN_IDFlag
2113  0342 a192          	cp	a,#146
2114  0344 2618          	jrne	L3101
2116  0346 c60023        	ld	a,_LIN_StateFlag
2117  0349 a104          	cp	a,#4
2118  034b 2611          	jrne	L3101
2119                     ; 507                 LIN_RLDCU_BYTE0 = LinRcBuffer[1];
2121  034d 55002d0038    	mov	_LIN_RLDCU_FRAME,_LinRcBuffer+1
2122                     ; 508                 LIN_RLDCU_BYTE1 = LinRcBuffer[2]; 
2124  0352 55002e0039    	mov	_LIN_RLDCU_FRAME+1,_LinRcBuffer+2
2125                     ; 509                 LIN_LinRcBuffer_init();
2127  0357 8d2c002c      	callf	f_LIN_LinRcBuffer_init
2129                     ; 510                 LostCommunication[4] = 0 ;
2131  035b 5f            	clrw	x
2133  035c 2009          	jpf	LC005
2134  035e               L3101:
2135                     ; 512             else if(LostCommunication[4] < 10 )
2137  035e ce0017        	ldw	x,_LostCommunication+8
2138  0361 a3000a        	cpw	x,#10
2139  0364 243a          	jruge	L5201
2140                     ; 514                 LostCommunication[4] ++;   //lost communication
2142  0366 5c            	incw	x
2143  0367               LC005:
2144  0367 cf0017        	ldw	_LostCommunication+8,x
2145                     ; 517             LIN_SCIOFF();
2147                     ; 518             LIN_StateFlag = LIN_Idle;
2148                     ; 519         }break;
2150  036a 2034          	jpf	L5201
2151  036c               L547:
2152                     ; 525             if (LIN_StateFlag == LIN_Idle)
2154  036c c60023        	ld	a,_LIN_StateFlag
2155  036f 2637          	jrne	L567
2156                     ; 527                 LIN_PutMsg(ID_RRDCU);
2158  0371 a6d3          	ld	a,#211
2160                     ; 528                 LIN_SCISendBreak();
2162                     ; 529                 LIN_SCISendData();
2164  0373 2088          	jpf	LC008
2165  0375               L747:
2166                     ; 536             if ((LIN_IDFlag == ID_RRDCU) && (LIN_StateFlag == LIN_ReceiveFinished))
2168  0375 c6001d        	ld	a,_LIN_IDFlag
2169  0378 a1d3          	cp	a,#211
2170  037a 2618          	jrne	L3201
2172  037c c60023        	ld	a,_LIN_StateFlag
2173  037f a104          	cp	a,#4
2174  0381 2611          	jrne	L3201
2175                     ; 538                 LIN_RRDCU_BYTE0 = LinRcBuffer[1];
2177  0383 55002d0036    	mov	_LIN_RRDCU_FRAME,_LinRcBuffer+1
2178                     ; 539                 LIN_RRDCU_BYTE1 = LinRcBuffer[2]; 
2180  0388 55002e0037    	mov	_LIN_RRDCU_FRAME+1,_LinRcBuffer+2
2181                     ; 540                 LIN_LinRcBuffer_init();
2183  038d 8d2c002c      	callf	f_LIN_LinRcBuffer_init
2185                     ; 541                 LostCommunication[5] = 0 ;
2187  0391 5f            	clrw	x
2189  0392 2009          	jpf	LC006
2190  0394               L3201:
2191                     ; 543             else  if(LostCommunication[5] < 10 )
2193  0394 ce0019        	ldw	x,_LostCommunication+10
2194  0397 a3000a        	cpw	x,#10
2195  039a 2404          	jruge	L5201
2196                     ; 545                 LostCommunication[5] ++;   //lost communication
2198  039c 5c            	incw	x
2199  039d               LC006:
2200  039d cf0019        	ldw	_LostCommunication+10,x
2201  03a0               L5201:
2202                     ; 548             LIN_SCIOFF();
2205                     ; 549             LIN_StateFlag = LIN_Idle;            
2212  03a0 8d050105      	callf	f_LIN_SCIOFF
2218  03a4 725f0023      	clr	_LIN_StateFlag
2219                     ; 550         }break;
2221  03a8               L567:
2222                     ; 605 }
2225  03a8 87            	retf	
2227                     	switch	.bss
2228  0000               L3301_openwindowtime:
2229  0000 00            	ds.b	1
2268                     ; 619 void LINControlDTC(void)
2268                     ; 620 {
2269                     	switch	.text
2270  03a9               f_LINControlDTC:
2274                     ; 624     if( (VehicleType & 0xf0) == CV8 )
2276  03a9 c60000        	ld	a,_VehicleType
2277  03ac a4f0          	and	a,#240
2278  03ae a120          	cp	a,#32
2279  03b0 2704ac9c049c  	jrne	L1501
2280                     ; 636         if(openwindowtime != 0)
2282  03b6 c60000        	ld	a,L3301_openwindowtime
2283  03b9 2704          	jreq	L3501
2284                     ; 638               openwindowtime--;
2286  03bb 725a0000      	dec	L3301_openwindowtime
2287                     ; 639               if( openwindowtime == 0 )
2289  03bf               L3501:
2290                     ; 647         if( LIN_DDCU_BYTE0 == 5 )
2292  03bf c6003c        	ld	a,_LIN_DDCU_FRAME
2293  03c2 a105          	cp	a,#5
2294  03c4 2605          	jrne	L7501
2295                     ; 649             WriteDTC(0xa310) ; //relay failure
2297  03c6 aea310        	ldw	x,#41744
2300  03c9 2007          	jpf	LC009
2301  03cb               L7501:
2302                     ; 651         else if( LIN_DDCU_BYTE0 == 6 )
2304  03cb a106          	cp	a,#6
2305  03cd 2609          	jrne	L3601
2306                     ; 653             WriteDTC(0xa311) ; //hall sensor
2308  03cf aea311        	ldw	x,#41745
2309  03d2               LC009:
2310  03d2 8d000000      	callf	f_WriteDTC
2313  03d6 2008          	jra	L1601
2314  03d8               L3601:
2315                     ; 655         else if(LIN_DDCU_BYTE0 == 4 ) //滅標
2317  03d8 a104          	cp	a,#4
2318  03da 2604          	jrne	L1601
2319                     ; 657               FJwarmstate = 0x55 ;
2321  03dc 3555000e      	mov	_FJwarmstate,#85
2323  03e0               L1601:
2324                     ; 664         if(LostCommunication[2] >= 5 )
2326  03e0 ce0013        	ldw	x,_LostCommunication+4
2327  03e3 a30005        	cpw	x,#5
2328  03e6 2507          	jrult	L3701
2329                     ; 666             WriteDTC(0xc222) ; //lost communation
2331  03e8 aec222        	ldw	x,#49698
2332  03eb 8d000000      	callf	f_WriteDTC
2334  03ef               L3701:
2335                     ; 669         if( LIN_PDCU_BYTE0 == 5 )
2337  03ef c6003a        	ld	a,_LIN_PDCU_FRAME
2338  03f2 a105          	cp	a,#5
2339  03f4 2605          	jrne	L5701
2340                     ; 671             WriteDTC(0xa320) ;
2342  03f6 aea320        	ldw	x,#41760
2345  03f9 2007          	jpf	LC010
2346  03fb               L5701:
2347                     ; 673         else if(LIN_PDCU_BYTE0 == 6 )
2349  03fb a106          	cp	a,#6
2350  03fd 2609          	jrne	L1011
2351                     ; 675             WriteDTC(0xa321) ;
2353  03ff aea321        	ldw	x,#41761
2354  0402               LC010:
2355  0402 8d000000      	callf	f_WriteDTC
2358  0406 2008          	jra	L7701
2359  0408               L1011:
2360                     ; 677         else if(LIN_PDCU_BYTE0 == 4 ) //滅標
2362  0408 a104          	cp	a,#4
2363  040a 2604          	jrne	L7701
2364                     ; 679               FJwarmstate = 0x55 ;
2366  040c 3555000e      	mov	_FJwarmstate,#85
2368  0410               L7701:
2369                     ; 686         if(LostCommunication[3] >= 5  )
2371  0410 ce0015        	ldw	x,_LostCommunication+6
2372  0413 a30005        	cpw	x,#5
2373  0416 2507          	jrult	L1111
2374                     ; 688             WriteDTC(0xc223) ; //lost communation
2376  0418 aec223        	ldw	x,#49699
2377  041b 8d000000      	callf	f_WriteDTC
2379  041f               L1111:
2380                     ; 691         if(LIN_RLDCU_BYTE0 == 5 )
2382  041f c60038        	ld	a,_LIN_RLDCU_FRAME
2383  0422 a105          	cp	a,#5
2384  0424 2605          	jrne	L3111
2385                     ; 693             WriteDTC(0xa330) ;
2387  0426 aea330        	ldw	x,#41776
2390  0429 2007          	jpf	LC011
2391  042b               L3111:
2392                     ; 695         else if(LIN_RLDCU_BYTE0 == 6 )
2394  042b a106          	cp	a,#6
2395  042d 2609          	jrne	L7111
2396                     ; 697             WriteDTC(0xa331) ;
2398  042f aea331        	ldw	x,#41777
2399  0432               LC011:
2400  0432 8d000000      	callf	f_WriteDTC
2403  0436 2008          	jra	L5111
2404  0438               L7111:
2405                     ; 699         else if(LIN_RLDCU_BYTE0 == 4 ) //滅標
2407  0438 a104          	cp	a,#4
2408  043a 2604          	jrne	L5111
2409                     ; 701               FJwarmstate = 0x55 ;
2411  043c 3555000e      	mov	_FJwarmstate,#85
2413  0440               L5111:
2414                     ; 708         if(LostCommunication[4] >= 5  )
2416  0440 ce0017        	ldw	x,_LostCommunication+8
2417  0443 a30005        	cpw	x,#5
2418  0446 2507          	jrult	L7211
2419                     ; 710             WriteDTC(0xc224) ; //lost communation
2421  0448 aec224        	ldw	x,#49700
2422  044b 8d000000      	callf	f_WriteDTC
2424  044f               L7211:
2425                     ; 713         if(LIN_RRDCU_BYTE0 == 5 )
2427  044f c60036        	ld	a,_LIN_RRDCU_FRAME
2428  0452 a105          	cp	a,#5
2429  0454 2605          	jrne	L1311
2430                     ; 715             WriteDTC(0xa340) ;
2432  0456 aea340        	ldw	x,#41792
2435  0459 2007          	jpf	LC012
2436  045b               L1311:
2437                     ; 717         else if ( LIN_RRDCU_BYTE0 == 6 )
2439  045b a106          	cp	a,#6
2440  045d 2609          	jrne	L5311
2441                     ; 719             WriteDTC(0xa341) ;
2443  045f aea341        	ldw	x,#41793
2444  0462               LC012:
2445  0462 8d000000      	callf	f_WriteDTC
2448  0466 2008          	jra	L3311
2449  0468               L5311:
2450                     ; 721         else if(LIN_RRDCU_BYTE0 == 4 ) //滅標
2452  0468 a104          	cp	a,#4
2453  046a 2604          	jrne	L3311
2454                     ; 723               FJwarmstate = 0x55 ;
2456  046c 3555000e      	mov	_FJwarmstate,#85
2458  0470               L3311:
2459                     ; 730         if(LostCommunication[5] >= 5  )
2461  0470 ce0019        	ldw	x,_LostCommunication+10
2462  0473 a30005        	cpw	x,#5
2463  0476 2507          	jrult	L5411
2464                     ; 732             WriteDTC(0xc225) ; //lost communation
2466  0478 aec225        	ldw	x,#49701
2467  047b 8d000000      	callf	f_WriteDTC
2469  047f               L5411:
2470                     ; 735         if(LIN_RAINS_BYTE0 == 7)
2472  047f c60034        	ld	a,_LIN_RAINS_FRAME
2473  0482 a107          	cp	a,#7
2474  0484 2607          	jrne	L7411
2475                     ; 737             WriteDTC(0xa350) ;
2477  0486 aea350        	ldw	x,#41808
2478  0489 8d000000      	callf	f_WriteDTC
2480  048d               L7411:
2481                     ; 740         if(LostCommunication[6] >= 5  )
2483  048d ce001b        	ldw	x,_LostCommunication+12
2484  0490 a30005        	cpw	x,#5
2485  0493 2507          	jrult	L1501
2486                     ; 742             WriteDTC(0xc231) ; //lost communation
2488  0495 aec231        	ldw	x,#49713
2489  0498 8d000000      	callf	f_WriteDTC
2491  049c               L1501:
2492                     ; 749 }
2495  049c 87            	retf	
2497                     	switch	.bss
2498  0001               L3511_FJwarmcnt:
2499  0001 00            	ds.b	1
2500  0002               L5511_ProtectTime:
2501  0002 0000          	ds.b	2
2540                     ; 750 void  HORNFJwarm(void)
2540                     ; 751 {
2541                     	switch	.text
2542  049d               f_HORNFJwarm:
2546                     ; 755      if(ProtectTime != 0)
2548  049d ce0002        	ldw	x,L5511_ProtectTime
2549  04a0 2708          	jreq	L5711
2550                     ; 757         	ProtectTime--;
2552  04a2 5a            	decw	x
2553  04a3 cf0002        	ldw	L5511_ProtectTime,x
2554                     ; 758               FJwarmstate = 0 ;
2556  04a6 725f000e      	clr	_FJwarmstate
2557  04aa               L5711:
2558                     ; 760      if((FJwarmstate == 0x55 )&&(FJwarmTime == 0)&&(ProtectTime == 0))
2560  04aa c6000e        	ld	a,_FJwarmstate
2561  04ad a155          	cp	a,#85
2562  04af 261e          	jrne	L7711
2564  04b1 ce001e        	ldw	x,_FJwarmTime
2565  04b4 2619          	jrne	L7711
2567  04b6 ce0002        	ldw	x,L5511_ProtectTime
2568  04b9 2614          	jrne	L7711
2569                     ; 762           FJwarmstate = 0 ;
2571  04bb 725f000e      	clr	_FJwarmstate
2572                     ; 763           FJwarmTime = 500 ;
2574  04bf ae01f4        	ldw	x,#500
2575  04c2 cf001e        	ldw	_FJwarmTime,x
2576                     ; 764           FJwarmcnt = 0 ;
2578  04c5 725f0001      	clr	L3511_FJwarmcnt
2579                     ; 765           ProtectTime= 1250 ;
2581  04c9 ae04e2        	ldw	x,#1250
2582  04cc cf0002        	ldw	L5511_ProtectTime,x
2583  04cf               L7711:
2584                     ; 768      if(FJwarmTime != 0 )
2586  04cf ce001e        	ldw	x,_FJwarmTime
2587  04d2 272c          	jreq	L1021
2588                     ; 770             FJwarmTime--;
2590  04d4 5a            	decw	x
2591  04d5 cf001e        	ldw	_FJwarmTime,x
2592                     ; 771             FJwarmcnt++;
2594  04d8 725c0001      	inc	L3511_FJwarmcnt
2595                     ; 772             if(FJwarmcnt <64) HORN_ON;
2597  04dc c60001        	ld	a,L3511_FJwarmcnt
2598  04df a140          	cp	a,#64
2599  04e1 2406          	jruge	L3021
2602  04e3 7210500f      	bset	20495,#0
2604  04e7 200e          	jra	L5021
2605  04e9               L3021:
2606                     ; 773             else if(FJwarmcnt < 125)HORN_OFF;
2608  04e9 a17d          	cp	a,#125
2609  04eb 2406          	jruge	L7021
2612  04ed 7211500f      	bres	20495,#0
2614  04f1 2004          	jra	L5021
2615  04f3               L7021:
2616                     ; 776                 FJwarmcnt = 0;
2618  04f3 725f0001      	clr	L3511_FJwarmcnt
2619  04f7               L5021:
2620                     ; 779             if(FJwarmTime == 0)
2622  04f7 ce001e        	ldw	x,_FJwarmTime
2623  04fa 2604          	jrne	L1021
2624                     ; 781                   HORN_OFF ;
2626  04fc 7211500f      	bres	20495,#0
2627  0500               L1021:
2628                     ; 788 }
2631  0500 87            	retf	
2633                     	switch	.bss
2634  0004               L5121_WAKEtime:
2635  0004 0000          	ds.b	2
2668                     ; 791 void WAKElin(void)
2668                     ; 792 {
2669                     	switch	.text
2670  0501               f_WAKElin:
2674                     ; 794     WAKEtime++;
2676  0501 ce0004        	ldw	x,L5121_WAKEtime
2677  0504 5c            	incw	x
2678  0505 cf0004        	ldw	L5121_WAKEtime,x
2679                     ; 795     if(WAKEtime >= 100)
2681  0508 a30064        	cpw	x,#100
2682  050b 2512          	jrult	L3321
2683                     ; 797        WAKEtime = 0 ;
2685  050d 5f            	clrw	x
2686  050e cf0004        	ldw	L5121_WAKEtime,x
2687                     ; 798        LIN_PutMsg(ID_BCM1);
2689  0511 a6b1          	ld	a,#177
2690  0513 8d150115      	callf	f_LIN_PutMsg
2692                     ; 799        LIN_SCISendBreak();
2694  0517 8dbe00be      	callf	f_LIN_SCISendBreak
2696                     ; 800        LIN_SCISendData();
2698  051b 8de100e1      	callf	f_LIN_SCISendData
2700  051f               L3321:
2701                     ; 804 }
2704  051f 87            	retf	
4199                     	switch	.bss
4200  0006               _LINcfg:
4201  0006 000000000000  	ds.b	8
4202                     	xdef	_LINcfg
4203                     	xdef	f_LIN_SCIOFF
4204                     	xdef	f_LIN_SCIReciveData
4205                     	xdef	f_LIN_SCISendData
4206                     	xdef	f_LIN_SCISendHeader
4207                     	xdef	f_LIN_SCISendSYNField
4208                     	xdef	f_LIN_RAINS_init
4209                     	xdef	f_LIN_RRDCU_init
4210                     	xdef	f_LIN_RLDCU_init
4211                     	xdef	f_LIN_PDCU_init
4212                     	xdef	f_LIN_DDCU_init
4213                     	xdef	f_LIN_BCM2_init
4214                     	xdef	f_LIN_BCM1_init
4215                     	xdef	f_LIN_SCISendBreak
4216                     	xdef	f_LIN_LinRcBuffer_init
4217  000e               _FJwarmstate:
4218  000e 00            	ds.b	1
4219                     	xdef	_FJwarmstate
4220  000f               _LostCommunication:
4221  000f 000000000000  	ds.b	14
4222                     	xdef	_LostCommunication
4223  001d               _LIN_IDFlag:
4224  001d 00            	ds.b	1
4225                     	xdef	_LIN_IDFlag
4226                     	xref	f_Clear_WDT
4227                     	xdef	f_HORNFJwarm
4228                     	xref	_LINWINDOWSTATE
4229                     	xdef	f_WAKElin
4230                     	xdef	f_LINControlDTC
4231                     	xdef	f_LIN_Init
4232                     	xdef	f_LinTaskScheduler
4233                     	xdef	f_LIN_PutMsg
4234                     	xdef	f_LIN_FrameInit
4235  001e               _FJwarmTime:
4236  001e 0000          	ds.b	2
4237                     	xdef	_FJwarmTime
4238  0020               _LIN_OUT_TIME_FLAG:
4239  0020 00            	ds.b	1
4240                     	xdef	_LIN_OUT_TIME_FLAG
4241  0021               _LINsendLen:
4242  0021 00            	ds.b	1
4243                     	xdef	_LINsendLen
4244                     	xdef	_TxBufIndex
4245                     	xdef	_RxBufIndex
4246                     	xdef	_LIN_RECIVE_DataLength
4247  0022               _LIN_IDProperty:
4248  0022 00            	ds.b	1
4249                     	xdef	_LIN_IDProperty
4250  0023               _LIN_StateFlag:
4251  0023 00            	ds.b	1
4252                     	xdef	_LIN_StateFlag
4253  0024               _LinTxBuffer:
4254  0024 000000000000  	ds.b	8
4255                     	xdef	_LinTxBuffer
4256  002c               _LinRcBuffer:
4257  002c 000000000000  	ds.b	8
4258                     	xdef	_LinRcBuffer
4259  0034               _LIN_RAINS_FRAME:
4260  0034 0000          	ds.b	2
4261                     	xdef	_LIN_RAINS_FRAME
4262  0036               _LIN_RRDCU_FRAME:
4263  0036 0000          	ds.b	2
4264                     	xdef	_LIN_RRDCU_FRAME
4265  0038               _LIN_RLDCU_FRAME:
4266  0038 0000          	ds.b	2
4267                     	xdef	_LIN_RLDCU_FRAME
4268  003a               _LIN_PDCU_FRAME:
4269  003a 0000          	ds.b	2
4270                     	xdef	_LIN_PDCU_FRAME
4271  003c               _LIN_DDCU_FRAME:
4272  003c 0000          	ds.b	2
4273                     	xdef	_LIN_DDCU_FRAME
4274  003e               _LIN_BCM_FRAME2:
4275  003e 00000000      	ds.b	4
4276                     	xdef	_LIN_BCM_FRAME2
4277  0042               _LIN_BCM_FRAME1:
4278  0042 00000000      	ds.b	4
4279                     	xdef	_LIN_BCM_FRAME1
4280                     	xref	f_WriteDTC
4281                     	xref	_VehicleType
4282                     	xref	f_LINUART_SendData8
4283                     	xref	f_LINUART_SendBreak
4284                     	xref	f_LINUART_LINCmd
4285                     	xref	f_LINUART_LINConfig
4286                     	xref	f_LINUART_LINBreakDetectionConfig
4287                     	xref	f_LINUART_ITConfig
4288                     	xref	f_LINUART_Init
4289                     	xref	f_LINUART_StructInit
4309                     	end
