   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 812                     ; 55 void FLASH_ClearFlags(void)
 812                     ; 56 {
 813                     	switch	.text
 814  0000               f_FLASH_ClearFlags:
 816       00000001      OFST:	set	1
 819                     ; 58   temp = FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
 821  0000 c6505f        	ld	a,20575
 822                     ; 59 }
 825  0003 87            	retf	
 856                     ; 75 void FLASH_DeInit(void)
 856                     ; 76 {
 857                     	switch	.text
 858  0004               f_FLASH_DeInit:
 860       00000001      OFST:	set	1
 863                     ; 78   FLASH->CR1 = FLASH_CR1_RESET_VALUE;
 865  0004 725f505a      	clr	20570
 866                     ; 79   FLASH->CR2 = FLASH_CR2_RESET_VALUE;
 868  0008 725f505b      	clr	20571
 869                     ; 80   FLASH->NCR2 = FLASH_NCR2_RESET_VALUE;
 871  000c 35ff505c      	mov	20572,#255
 872                     ; 81   FLASH->IAPSR &= (u8)(~FLASH_IAPSR_DUL);
 874  0010 7217505f      	bres	20575,#3
 875                     ; 82   FLASH->IAPSR &= (u8)(~FLASH_IAPSR_PUL);         ///????????
 877  0014 7213505f      	bres	20575,#1
 878                     ; 83   temp = FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
 880  0018 c6505f        	ld	a,20575
 881                     ; 84 }
 884  001b 87            	retf	
1003                     ; 102 FLASH_Status_Typedef FLASH_EraseBlock(FLASH_MemType_TypeDef MemType, u16 BlockNum)
1003                     ; 103 {
1004                     	switch	.text
1005  001c               f_FLASH_EraseBlock:
1007  001c 88            	push	a
1008  001d 5207          	subw	sp,#7
1009       00000007      OFST:	set	7
1012                     ; 108   assert_param(IS_MEMORY_TYPE_OK(MemType));
1014  001f 4d            	tnz	a
1015  0020 2714          	jreq	L61
1016  0022 a101          	cp	a,#1
1017  0024 2710          	jreq	L61
1018  0026 a102          	cp	a,#2
1019  0028 270c          	jreq	L61
1020  002a ae006c        	ldw	x,#108
1021  002d 89            	pushw	x
1022  002e ae0018        	ldw	x,#L345
1023  0031 8d000000      	callf	f_assert_failed
1025  0035 85            	popw	x
1026  0036               L61:
1027                     ; 109   if (MemType == FLASH_MEMTYPE_PROG)
1029  0036 7b08          	ld	a,(OFST+1,sp)
1030  0038 2618          	jrne	L545
1031                     ; 111     assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1033  003a 1e0c          	ldw	x,(OFST+5,sp)
1034  003c a30400        	cpw	x,#1024
1035  003f 250c          	jrult	L42
1036  0041 ae006f        	ldw	x,#111
1037  0044 89            	pushw	x
1038  0045 ae0018        	ldw	x,#L345
1039  0048 8d000000      	callf	f_assert_failed
1041  004c 85            	popw	x
1042  004d               L42:
1043                     ; 112     StartAddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1045  004d ae8000        	ldw	x,#32768
1047  0050 2016          	jra	L745
1048  0052               L545:
1049                     ; 116     assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1051  0052 1e0c          	ldw	x,(OFST+5,sp)
1052  0054 a30010        	cpw	x,#16
1053  0057 250c          	jrult	L23
1054  0059 ae0074        	ldw	x,#116
1055  005c 89            	pushw	x
1056  005d ae0018        	ldw	x,#L345
1057  0060 8d000000      	callf	f_assert_failed
1059  0064 85            	popw	x
1060  0065               L23:
1061                     ; 117     StartAddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1063  0065 ae4000        	ldw	x,#16384
1064  0068               L745:
1065  0068 1f06          	ldw	(OFST-1,sp),x
1066  006a 5f            	clrw	x
1067  006b 1f04          	ldw	(OFST-3,sp),x
1068                     ; 121   StartAddress = StartAddress + ((u32)BlockNum * (u32)FLASH_BLOCK_SIZE);
1070  006d 1e0c          	ldw	x,(OFST+5,sp)
1071  006f a680          	ld	a,#128
1072  0071 8d000000      	callf	d_cmulx
1074  0075 96            	ldw	x,sp
1075  0076 1c0004        	addw	x,#OFST-3
1076  0079 8d000000      	callf	d_lgadd
1078                     ; 122   pFlash = (@far u8 *) StartAddress;
1080  007d 7b05          	ld	a,(OFST-2,sp)
1081  007f 6b01          	ld	(OFST-6,sp),a
1082  0081 7b06          	ld	a,(OFST-1,sp)
1083  0083 6b02          	ld	(OFST-5,sp),a
1084  0085 7b07          	ld	a,(OFST+0,sp)
1085  0087 6b03          	ld	(OFST-4,sp),a
1086                     ; 125   FLASH->CR2 |= FLASH_CR2_ERASE;
1088  0089 721a505b      	bset	20571,#5
1089                     ; 126   FLASH->NCR2 &= (u8)(~FLASH_NCR2_NERASE);
1091  008d 721b505c      	bres	20572,#5
1092                     ; 128   *(pFlash + 0) = (u8)0x00;
1094  0091 7b01          	ld	a,(OFST-6,sp)
1095  0093 b700          	ld	c_x,a
1096  0095 1e02          	ldw	x,(OFST-5,sp)
1097  0097 bf01          	ldw	c_x+1,x
1098  0099 4f            	clr	a
1099  009a 92bd0000      	ldf	[c_x.e],a
1100                     ; 129   *(pFlash + 1) = (u8)0x00;
1102  009e 90ae0001      	ldw	y,#1
1103  00a2 93            	ldw	x,y
1104  00a3 92a70000      	ldf	([c_x.e],x),a
1105                     ; 130   *(pFlash + 2) = (u8)0x00;
1107  00a7 905c          	incw	y
1108  00a9 93            	ldw	x,y
1109  00aa 92a70000      	ldf	([c_x.e],x),a
1110                     ; 131   *(pFlash + 3) = (u8)0x00;
1112  00ae 905c          	incw	y
1113  00b0 93            	ldw	x,y
1114  00b1 92a70000      	ldf	([c_x.e],x),a
1116  00b5               L555:
1117                     ; 134   while ((FLASH->CR2 & FLASH_CR2_ERASE) != (u8)0x00)
1119  00b5 720a505bfb    	btjt	20571,#5,L555
1120                     ; 137   return(FLASH_WaitForLastOperation());
1122  00ba 8d160516      	callf	f_FLASH_WaitForLastOperation
1126  00be 5b08          	addw	sp,#8
1127  00c0 87            	retf	
1171                     .const:	section	.text
1172  0000               L05:
1173  0000 00008000      	dc.l	32768
1174  0004               L25:
1175  0004 00028000      	dc.l	163840
1176  0008               L45:
1177  0008 00004000      	dc.l	16384
1178  000c               L65:
1179  000c 00004800      	dc.l	18432
1180                     ; 156 FLASH_Status_Typedef FLASH_EraseByte(u32 Address)
1180                     ; 157 {
1181                     	switch	.text
1182  00c1               f_FLASH_EraseByte:
1184  00c1 5203          	subw	sp,#3
1185       00000003      OFST:	set	3
1188                     ; 160   assert_param(IS_FLASH_ADDRESS_OK(Address));
1190  00c3 96            	ldw	x,sp
1191  00c4 1c0007        	addw	x,#OFST+4
1192  00c7 8d000000      	callf	d_ltor
1194  00cb ae0000        	ldw	x,#L05
1195  00ce 8d000000      	callf	d_lcmp
1197  00d2 2511          	jrult	L64
1198  00d4 96            	ldw	x,sp
1199  00d5 1c0007        	addw	x,#OFST+4
1200  00d8 8d000000      	callf	d_ltor
1202  00dc ae0004        	ldw	x,#L25
1203  00df 8d000000      	callf	d_lcmp
1205  00e3 252e          	jrult	L06
1206  00e5               L64:
1207  00e5 96            	ldw	x,sp
1208  00e6 1c0007        	addw	x,#OFST+4
1209  00e9 8d000000      	callf	d_ltor
1211  00ed ae0008        	ldw	x,#L45
1212  00f0 8d000000      	callf	d_lcmp
1214  00f4 2511          	jrult	L24
1215  00f6 96            	ldw	x,sp
1216  00f7 1c0007        	addw	x,#OFST+4
1217  00fa 8d000000      	callf	d_ltor
1219  00fe ae000c        	ldw	x,#L65
1220  0101 8d000000      	callf	d_lcmp
1222  0105 250c          	jrult	L06
1223  0107               L24:
1224  0107 ae00a0        	ldw	x,#160
1225  010a 89            	pushw	x
1226  010b ae0018        	ldw	x,#L345
1227  010e 8d000000      	callf	f_assert_failed
1229  0112 85            	popw	x
1230  0113               L06:
1231                     ; 162   pFlash = (@far u8 *) Address;
1233  0113 7b08          	ld	a,(OFST+5,sp)
1234  0115 6b01          	ld	(OFST-2,sp),a
1235  0117 7b09          	ld	a,(OFST+6,sp)
1236  0119 6b02          	ld	(OFST-1,sp),a
1237  011b 7b0a          	ld	a,(OFST+7,sp)
1238  011d 6b03          	ld	(OFST+0,sp),a
1239                     ; 163   *(pFlash) = (u8)0x00; /* Erase byte */
1241  011f 7b01          	ld	a,(OFST-2,sp)
1242  0121 b700          	ld	c_x,a
1243  0123 1e02          	ldw	x,(OFST-1,sp)
1244  0125 bf01          	ldw	c_x+1,x
1245  0127 4f            	clr	a
1246  0128 92bd0000      	ldf	[c_x.e],a
1247                     ; 165   return(FLASH_WaitForLastOperation());
1249  012c 8d160516      	callf	f_FLASH_WaitForLastOperation
1253  0130 5b03          	addw	sp,#3
1254  0132 87            	retf	
1309                     	switch	.const
1310  0010               L27:
1311  0010 00004801      	dc.l	18433
1312  0014               L47:
1313  0014 00004812      	dc.l	18450
1314                     ; 184 FLASH_Status_Typedef FLASH_EraseOptionByte(u32 Address)
1314                     ; 185 {
1315                     	switch	.text
1316  0133               f_FLASH_EraseOptionByte:
1318  0133 5203          	subw	sp,#3
1319       00000003      OFST:	set	3
1322                     ; 190   assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
1324  0135 96            	ldw	x,sp
1325  0136 1c0007        	addw	x,#OFST+4
1326  0139 8d000000      	callf	d_ltor
1328  013d ae0010        	ldw	x,#L27
1329  0140 8d000000      	callf	d_lcmp
1331  0144 2511          	jrult	L07
1332  0146 96            	ldw	x,sp
1333  0147 1c0007        	addw	x,#OFST+4
1334  014a 8d000000      	callf	d_ltor
1336  014e ae0014        	ldw	x,#L47
1337  0151 8d000000      	callf	d_lcmp
1339  0155 250c          	jrult	L67
1340  0157               L07:
1341  0157 ae00be        	ldw	x,#190
1342  015a 89            	pushw	x
1343  015b ae0018        	ldw	x,#L345
1344  015e 8d000000      	callf	f_assert_failed
1346  0162 85            	popw	x
1347  0163               L67:
1348                     ; 193   FLASH->CR2 |= FLASH_CR2_OPT;
1350  0163 721e505b      	bset	20571,#7
1351                     ; 194   FLASH->NCR2 &= (u8)(~FLASH_NCR2_NOPT);
1353  0167 721f505c      	bres	20572,#7
1354                     ; 197   pFlash = (u8 *)Address;
1356  016b 1e09          	ldw	x,(OFST+6,sp)
1357  016d 1f02          	ldw	(OFST-1,sp),x
1358                     ; 198   *pFlash = (u8)0x00;
1360  016f 7f            	clr	(x)
1361                     ; 199   pFlash = (u8 *)(Address + 1 );
1363  0170 96            	ldw	x,sp
1364  0171 1c0007        	addw	x,#OFST+4
1365  0174 8d000000      	callf	d_ltor
1367  0178 a601          	ld	a,#1
1368  017a 8d000000      	callf	d_ladc
1370  017e be02          	ldw	x,c_lreg+2
1371  0180 1f02          	ldw	(OFST-1,sp),x
1372                     ; 200   *pFlash = (u8)0xFF;
1374  0182 a6ff          	ld	a,#255
1375  0184 f7            	ld	(x),a
1376                     ; 202   status = FLASH_WaitForLastOperation();
1378  0185 8d160516      	callf	f_FLASH_WaitForLastOperation
1380  0189 6b01          	ld	(OFST-2,sp),a
1381                     ; 205   FLASH->CR2 &= (u8)(~FLASH_CR2_OPT);
1383  018b 721f505b      	bres	20571,#7
1384                     ; 206   FLASH->NCR2 |= FLASH_NCR2_NOPT;
1386  018f 721e505c      	bset	20572,#7
1387                     ; 208   return(status);
1391  0193 5b03          	addw	sp,#3
1392  0195 87            	retf	
1424                     ; 227 u32 FLASH_GetBootMemSize(void)
1424                     ; 228 {
1425                     	switch	.text
1426  0196               f_FLASH_GetBootMemSize:
1428  0196 5204          	subw	sp,#4
1429       00000004      OFST:	set	4
1432                     ; 233   temp = (u32)((u32)FLASH->FPR * (u32)512);
1434  0198 c6505d        	ld	a,20573
1435  019b 5f            	clrw	x
1436  019c 97            	ld	xl,a
1437  019d 90ae0200      	ldw	y,#512
1438  01a1 8d000000      	callf	d_umul
1440  01a5 96            	ldw	x,sp
1441  01a6 5c            	incw	x
1442  01a7 8d000000      	callf	d_rtol
1444                     ; 236   if (FLASH->FPR == 0xFF)
1446  01ab c6505d        	ld	a,20573
1447  01ae 4c            	inc	a
1448  01af 260e          	jrne	L146
1449                     ; 238 	  temp += 512;
1451  01b1 ae0200        	ldw	x,#512
1452  01b4 bf02          	ldw	c_lreg+2,x
1453  01b6 5f            	clrw	x
1454  01b7 bf00          	ldw	c_lreg,x
1455  01b9 96            	ldw	x,sp
1456  01ba 5c            	incw	x
1457  01bb 8d000000      	callf	d_lgadd
1459  01bf               L146:
1460                     ; 242   return(temp);
1462  01bf 96            	ldw	x,sp
1463  01c0 5c            	incw	x
1464  01c1 8d000000      	callf	d_ltor
1468  01c5 5b04          	addw	sp,#4
1469  01c7 87            	retf	
1512                     ; 261 ITStatus FLASH_GetITStatus(void)
1512                     ; 262 {
1513                     	switch	.text
1514  01c8               f_FLASH_GetITStatus:
1518                     ; 263   return((ITStatus)(((u8)(FLASH->CR1 & FLASH_CR1_IE) == (u8)0x00) ? RESET : SET));
1520  01c8 7202505a02    	btjt	20570,#1,L011
1521  01cd 4f            	clr	a
1523  01ce 87            	retf	
1524  01cf               L011:
1525  01cf a601          	ld	a,#1
1528  01d1 87            	retf	
1590                     ; 281 FLASH_LPMode_Typedef FLASH_GetLowPowerMode(void)
1590                     ; 282 {
1591                     	switch	.text
1592  01d2               f_FLASH_GetLowPowerMode:
1596                     ; 283   return((FLASH_LPMode_Typedef)(FLASH->CR1 & (FLASH_CR1_HALT | FLASH_CR1_AHALT)));
1598  01d2 c6505a        	ld	a,20570
1599  01d5 a40c          	and	a,#12
1602  01d7 87            	retf	
1648                     ; 301 FLASH_ProgramTime_Typedef FLASH_GetProgrammingTime(void)
1648                     ; 302 {
1649                     	switch	.text
1650  01d8               f_FLASH_GetProgrammingTime:
1654                     ; 303   return((FLASH_ProgramTime_Typedef)(FLASH->CR1 & FLASH_CR1_FIX));
1656  01d8 c6505a        	ld	a,20570
1657  01db a401          	and	a,#1
1660  01dd 87            	retf	
1714                     ; 319 void FLASH_ITConfig(FunctionalState NewState)
1714                     ; 320 {
1715                     	switch	.text
1716  01de               f_FLASH_ITConfig:
1720                     ; 321   if (NewState == ENABLE)
1722  01de 4a            	dec	a
1723  01df 2605          	jrne	L557
1724                     ; 323     FLASH->CR1 |= FLASH_CR1_IE; /* Enables the interrupt sources */
1726  01e1 7212505a      	bset	20570,#1
1729  01e5 87            	retf	
1730  01e6               L557:
1731                     ; 327     FLASH->CR1 &= (u8)(~FLASH_CR1_IE); /* Disables the interrupt sources */
1733  01e6 7213505a      	bres	20570,#1
1734                     ; 329 }
1737  01ea 87            	retf	
1772                     ; 344 void FLASH_Lock(FLASH_MemType_TypeDef MemType)
1772                     ; 345 {
1773                     	switch	.text
1774  01eb               f_FLASH_Lock:
1776  01eb 88            	push	a
1777       00000000      OFST:	set	0
1780                     ; 348   assert_param(IS_MEMORY_TYPE_OK(MemType));
1782  01ec 4d            	tnz	a
1783  01ed 2714          	jreq	L031
1784  01ef a101          	cp	a,#1
1785  01f1 2710          	jreq	L031
1786  01f3 a102          	cp	a,#2
1787  01f5 270c          	jreq	L031
1788  01f7 ae015c        	ldw	x,#348
1789  01fa 89            	pushw	x
1790  01fb ae0018        	ldw	x,#L345
1791  01fe 8d000000      	callf	f_assert_failed
1793  0202 85            	popw	x
1794  0203               L031:
1795                     ; 351   if ((MemType == FLASH_MEMTYPE_PROG) || (MemType == FLASH_MEMTYPE_PROG_DATA))
1797  0203 7b01          	ld	a,(OFST+1,sp)
1798  0205 2704          	jreq	L1001
1800  0207 a102          	cp	a,#2
1801  0209 2604          	jrne	L777
1802  020b               L1001:
1803                     ; 353     FLASH->IAPSR &= (u8)(~FLASH_IAPSR_PUL);
1805  020b 7213505f      	bres	20575,#1
1806  020f               L777:
1807                     ; 357   if ((MemType == FLASH_MEMTYPE_DATA) || (MemType == FLASH_MEMTYPE_PROG_DATA))
1809  020f a101          	cp	a,#1
1810  0211 2704          	jreq	L5001
1812  0213 a102          	cp	a,#2
1813  0215 2604          	jrne	L3001
1814  0217               L5001:
1815                     ; 359     FLASH->IAPSR &= (u8)(~FLASH_IAPSR_DUL);
1817  0217 7217505f      	bres	20575,#3
1818  021b               L3001:
1819                     ; 362 }
1822  021b 84            	pop	a
1823  021c 87            	retf	
1933                     ; 388 FLASH_Status_Typedef FLASH_ProgramBlock(FLASH_MemType_TypeDef MemType, u16 BlockNum, FLASH_ProgramMode_Typedef ProgMode, u8 *Buffer)
1933                     ; 389 {
1934                     	switch	.text
1935  021d               f_FLASH_ProgramBlock:
1937  021d 88            	push	a
1938  021e 5209          	subw	sp,#9
1939       00000009      OFST:	set	9
1942                     ; 391   u16 Count = 0;
1944                     ; 395   assert_param(IS_MEMORY_TYPE_OK(MemType));
1946  0220 4d            	tnz	a
1947  0221 2714          	jreq	L241
1948  0223 a101          	cp	a,#1
1949  0225 2710          	jreq	L241
1950  0227 a102          	cp	a,#2
1951  0229 270c          	jreq	L241
1952  022b ae018b        	ldw	x,#395
1953  022e 89            	pushw	x
1954  022f ae0018        	ldw	x,#L345
1955  0232 8d000000      	callf	f_assert_failed
1957  0236 85            	popw	x
1958  0237               L241:
1959                     ; 396   assert_param(IS_FLASH_PROGRAM_MODE_OK(ProgMode));
1961  0237 7b10          	ld	a,(OFST+7,sp)
1962  0239 2710          	jreq	L251
1963  023b a110          	cp	a,#16
1964  023d 270c          	jreq	L251
1965  023f ae018c        	ldw	x,#396
1966  0242 89            	pushw	x
1967  0243 ae0018        	ldw	x,#L345
1968  0246 8d000000      	callf	f_assert_failed
1970  024a 85            	popw	x
1971  024b               L251:
1972                     ; 397   if (MemType == FLASH_MEMTYPE_PROG)
1974  024b 7b0a          	ld	a,(OFST+1,sp)
1975  024d 2618          	jrne	L7501
1976                     ; 399     assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1978  024f 1e0e          	ldw	x,(OFST+5,sp)
1979  0251 a30400        	cpw	x,#1024
1980  0254 250c          	jrult	L061
1981  0256 ae018f        	ldw	x,#399
1982  0259 89            	pushw	x
1983  025a ae0018        	ldw	x,#L345
1984  025d 8d000000      	callf	f_assert_failed
1986  0261 85            	popw	x
1987  0262               L061:
1988                     ; 400     StartAddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1990  0262 ae8000        	ldw	x,#32768
1992  0265 2016          	jra	L1601
1993  0267               L7501:
1994                     ; 404     assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1996  0267 1e0e          	ldw	x,(OFST+5,sp)
1997  0269 a30010        	cpw	x,#16
1998  026c 250c          	jrult	L661
1999  026e ae0194        	ldw	x,#404
2000  0271 89            	pushw	x
2001  0272 ae0018        	ldw	x,#L345
2002  0275 8d000000      	callf	f_assert_failed
2004  0279 85            	popw	x
2005  027a               L661:
2006                     ; 405     StartAddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
2008  027a ae4000        	ldw	x,#16384
2009  027d               L1601:
2010  027d 1f06          	ldw	(OFST-3,sp),x
2011  027f 5f            	clrw	x
2012  0280 1f04          	ldw	(OFST-5,sp),x
2013                     ; 409   StartAddress = StartAddress + (BlockNum * FLASH_BLOCK_SIZE);
2015  0282 1e0e          	ldw	x,(OFST+5,sp)
2016  0284 4f            	clr	a
2017  0285 02            	rlwa	x,a
2018  0286 44            	srl	a
2019  0287 56            	rrcw	x
2020  0288 8d000000      	callf	d_uitolx
2022  028c 96            	ldw	x,sp
2023  028d 1c0004        	addw	x,#OFST-5
2024  0290 8d000000      	callf	d_lgadd
2026                     ; 410   pFlash = (@far u8 *) StartAddress;
2028  0294 7b05          	ld	a,(OFST-4,sp)
2029  0296 6b01          	ld	(OFST-8,sp),a
2030  0298 7b06          	ld	a,(OFST-3,sp)
2031  029a 6b02          	ld	(OFST-7,sp),a
2032  029c 7b07          	ld	a,(OFST-2,sp)
2033  029e 6b03          	ld	(OFST-6,sp),a
2034                     ; 413   if (ProgMode == FLASH_PROGRAMMODE_STANDARD)
2036  02a0 7b10          	ld	a,(OFST+7,sp)
2037  02a2 260a          	jrne	L3601
2038                     ; 416 	FLASH->CR2 |= FLASH_CR2_PRG;
2040  02a4 7210505b      	bset	20571,#0
2041                     ; 417 	FLASH->NCR2 &= (u8)(~FLASH_NCR2_NPRG);
2043  02a8 7211505c      	bres	20572,#0
2045  02ac 2008          	jra	L5601
2046  02ae               L3601:
2047                     ; 422     FLASH->CR2 |= FLASH_CR2_FPRG;
2049  02ae 7218505b      	bset	20571,#4
2050                     ; 423     FLASH->NCR2 &= (u8)(~FLASH_NCR2_NFPRG);
2052  02b2 7219505c      	bres	20572,#4
2053  02b6               L5601:
2054                     ; 427   for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
2056  02b6 5f            	clrw	x
2057  02b7 1f08          	ldw	(OFST-1,sp),x
2058  02b9               L7601:
2059                     ; 429     *(pFlash + Count) = ((u8)(Buffer[Count]));
2061  02b9 1e11          	ldw	x,(OFST+8,sp)
2062  02bb 72fb08        	addw	x,(OFST-1,sp)
2063  02be f6            	ld	a,(x)
2064  02bf 88            	push	a
2065  02c0 7b02          	ld	a,(OFST-7,sp)
2066  02c2 b700          	ld	c_x,a
2067  02c4 1e03          	ldw	x,(OFST-6,sp)
2068  02c6 bf01          	ldw	c_x+1,x
2069  02c8 84            	pop	a
2070  02c9 1e08          	ldw	x,(OFST-1,sp)
2071  02cb 92a70000      	ldf	([c_x.e],x),a
2072                     ; 427   for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
2074  02cf 5c            	incw	x
2075  02d0 1f08          	ldw	(OFST-1,sp),x
2078  02d2 a30080        	cpw	x,#128
2079  02d5 25e2          	jrult	L7601
2080                     ; 432   return(FLASH_WaitForLastOperation());
2082  02d7 8d160516      	callf	f_FLASH_WaitForLastOperation
2086  02db 5b0a          	addw	sp,#10
2087  02dd 87            	retf	
2138                     ; 454 FLASH_Status_Typedef FLASH_ProgramByte(u32 Address, u8 Data)
2138                     ; 455 {
2139                     	switch	.text
2140  02de               f_FLASH_ProgramByte:
2142  02de 5203          	subw	sp,#3
2143       00000003      OFST:	set	3
2146                     ; 459   assert_param(IS_FLASH_ADDRESS_OK(Address));
2148  02e0 96            	ldw	x,sp
2149  02e1 1c0007        	addw	x,#OFST+4
2150  02e4 8d000000      	callf	d_ltor
2152  02e8 ae0000        	ldw	x,#L05
2153  02eb 8d000000      	callf	d_lcmp
2155  02ef 2511          	jrult	L202
2156  02f1 96            	ldw	x,sp
2157  02f2 1c0007        	addw	x,#OFST+4
2158  02f5 8d000000      	callf	d_ltor
2160  02f9 ae0004        	ldw	x,#L25
2161  02fc 8d000000      	callf	d_lcmp
2163  0300 252e          	jrult	L402
2164  0302               L202:
2165  0302 96            	ldw	x,sp
2166  0303 1c0007        	addw	x,#OFST+4
2167  0306 8d000000      	callf	d_ltor
2169  030a ae0008        	ldw	x,#L45
2170  030d 8d000000      	callf	d_lcmp
2172  0311 2511          	jrult	L671
2173  0313 96            	ldw	x,sp
2174  0314 1c0007        	addw	x,#OFST+4
2175  0317 8d000000      	callf	d_ltor
2177  031b ae000c        	ldw	x,#L65
2178  031e 8d000000      	callf	d_lcmp
2180  0322 250c          	jrult	L402
2181  0324               L671:
2182  0324 ae01cb        	ldw	x,#459
2183  0327 89            	pushw	x
2184  0328 ae0018        	ldw	x,#L345
2185  032b 8d000000      	callf	f_assert_failed
2187  032f 85            	popw	x
2188  0330               L402:
2189                     ; 461   pFlash = (@far u8 *) Address;
2191  0330 7b08          	ld	a,(OFST+5,sp)
2192  0332 6b01          	ld	(OFST-2,sp),a
2193  0334 7b09          	ld	a,(OFST+6,sp)
2194  0336 6b02          	ld	(OFST-1,sp),a
2195  0338 7b0a          	ld	a,(OFST+7,sp)
2196  033a 6b03          	ld	(OFST+0,sp),a
2197                     ; 462   *pFlash = Data;
2199  033c 7b0b          	ld	a,(OFST+8,sp)
2200  033e 88            	push	a
2201  033f 7b02          	ld	a,(OFST-1,sp)
2202  0341 b700          	ld	c_x,a
2203  0343 1e03          	ldw	x,(OFST+0,sp)
2204  0345 bf01          	ldw	c_x+1,x
2205  0347 84            	pop	a
2206  0348 92bd0000      	ldf	[c_x.e],a
2207                     ; 463   return(FLASH_WaitForLastOperation());
2209  034c 8d160516      	callf	f_FLASH_WaitForLastOperation
2213  0350 5b03          	addw	sp,#3
2214  0352 87            	retf	
2276                     ; 483 FLASH_Status_Typedef FLASH_ProgramOptionByte(u32 Address, u8 Data)
2276                     ; 484 {
2277                     	switch	.text
2278  0353               f_FLASH_ProgramOptionByte:
2280  0353 5203          	subw	sp,#3
2281       00000003      OFST:	set	3
2284                     ; 489   assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
2286  0355 96            	ldw	x,sp
2287  0356 1c0007        	addw	x,#OFST+4
2288  0359 8d000000      	callf	d_ltor
2290  035d ae0010        	ldw	x,#L27
2291  0360 8d000000      	callf	d_lcmp
2293  0364 2511          	jrult	L412
2294  0366 96            	ldw	x,sp
2295  0367 1c0007        	addw	x,#OFST+4
2296  036a 8d000000      	callf	d_ltor
2298  036e ae0014        	ldw	x,#L47
2299  0371 8d000000      	callf	d_lcmp
2301  0375 250c          	jrult	L612
2302  0377               L412:
2303  0377 ae01e9        	ldw	x,#489
2304  037a 89            	pushw	x
2305  037b ae0018        	ldw	x,#L345
2306  037e 8d000000      	callf	f_assert_failed
2308  0382 85            	popw	x
2309  0383               L612:
2310                     ; 492   FLASH->CR2 |= FLASH_CR2_OPT;
2312  0383 721e505b      	bset	20571,#7
2313                     ; 493   FLASH->NCR2 &= (u8)(~FLASH_NCR2_NOPT);
2315  0387 721f505c      	bres	20572,#7
2316                     ; 496   pFlash = (u8 *)Address;
2318  038b 1e09          	ldw	x,(OFST+6,sp)
2319  038d 1f02          	ldw	(OFST-1,sp),x
2320                     ; 497   *pFlash = Data;
2322  038f 7b0b          	ld	a,(OFST+8,sp)
2323  0391 f7            	ld	(x),a
2324                     ; 498   pFlash = (u8 *)(Address + 1);
2326  0392 96            	ldw	x,sp
2327  0393 1c0007        	addw	x,#OFST+4
2328  0396 8d000000      	callf	d_ltor
2330  039a a601          	ld	a,#1
2331  039c 8d000000      	callf	d_ladc
2333  03a0 be02          	ldw	x,c_lreg+2
2334  03a2 1f02          	ldw	(OFST-1,sp),x
2335                     ; 499   *pFlash = (u8)(~Data);
2337  03a4 7b0b          	ld	a,(OFST+8,sp)
2338  03a6 43            	cpl	a
2339  03a7 f7            	ld	(x),a
2340                     ; 501   status = FLASH_WaitForLastOperation();
2342  03a8 8d160516      	callf	f_FLASH_WaitForLastOperation
2344  03ac 6b01          	ld	(OFST-2,sp),a
2345                     ; 504   FLASH->CR2 &= (u8)(~FLASH_CR2_OPT);
2347  03ae 721f505b      	bres	20571,#7
2348                     ; 505   FLASH->NCR2 |= FLASH_NCR2_NOPT;
2350  03b2 721e505c      	bset	20572,#7
2351                     ; 507   return(status);
2355  03b6 5b03          	addw	sp,#3
2356  03b8 87            	retf	
2402                     ; 530 FLASH_Status_Typedef FLASH_ProgramWord(u8 *Address, u8 *data)
2402                     ; 531 {
2403                     	switch	.text
2404  03b9               f_FLASH_ProgramWord:
2406  03b9 89            	pushw	x
2407       00000000      OFST:	set	0
2410                     ; 539   FLASH->CR2 |= FLASH_CR2_WPRG;
2412  03ba 721c505b      	bset	20571,#6
2413                     ; 540   FLASH->NCR2 &= (u8)(~FLASH_NCR2_NWPRG);
2415  03be 721d505c      	bres	20572,#6
2416                     ; 544   Address[0] = data[0]; /* Write one byte */
2418  03c2 1e06          	ldw	x,(OFST+6,sp)
2419  03c4 f6            	ld	a,(x)
2420  03c5 1e01          	ldw	x,(OFST+1,sp)
2421  03c7 f7            	ld	(x),a
2422                     ; 545   Address[1]  = data[1]; /* Write one byte */
2424  03c8 1e06          	ldw	x,(OFST+6,sp)
2425  03ca e601          	ld	a,(1,x)
2426  03cc 1e01          	ldw	x,(OFST+1,sp)
2427  03ce e701          	ld	(1,x),a
2428                     ; 546   Address[2]  = data[2]; /* Write one byte */
2430  03d0 1e06          	ldw	x,(OFST+6,sp)
2431  03d2 e602          	ld	a,(2,x)
2432  03d4 1e01          	ldw	x,(OFST+1,sp)
2433  03d6 e702          	ld	(2,x),a
2434                     ; 547   Address[3]  = data[3]; /* Write one byte */
2436  03d8 1e06          	ldw	x,(OFST+6,sp)
2437  03da e603          	ld	a,(3,x)
2438  03dc 1e01          	ldw	x,(OFST+1,sp)
2439  03de e703          	ld	(3,x),a
2440                     ; 549   return(FLASH_WaitForLastOperation());
2442  03e0 8d160516      	callf	f_FLASH_WaitForLastOperation
2446  03e4 85            	popw	x
2447  03e5 87            	retf	
2489                     ; 567 u8 FLASH_ReadByte(u32 Address)
2489                     ; 568 {
2490                     	switch	.text
2491  03e6               f_FLASH_ReadByte:
2493  03e6 5203          	subw	sp,#3
2494       00000003      OFST:	set	3
2497                     ; 572   assert_param(IS_FLASH_ADDRESS_OK(Address));
2499  03e8 96            	ldw	x,sp
2500  03e9 1c0007        	addw	x,#OFST+4
2501  03ec 8d000000      	callf	d_ltor
2503  03f0 ae0000        	ldw	x,#L05
2504  03f3 8d000000      	callf	d_lcmp
2506  03f7 2511          	jrult	L632
2507  03f9 96            	ldw	x,sp
2508  03fa 1c0007        	addw	x,#OFST+4
2509  03fd 8d000000      	callf	d_ltor
2511  0401 ae0004        	ldw	x,#L25
2512  0404 8d000000      	callf	d_lcmp
2514  0408 252e          	jrult	L042
2515  040a               L632:
2516  040a 96            	ldw	x,sp
2517  040b 1c0007        	addw	x,#OFST+4
2518  040e 8d000000      	callf	d_ltor
2520  0412 ae0008        	ldw	x,#L45
2521  0415 8d000000      	callf	d_lcmp
2523  0419 2511          	jrult	L232
2524  041b 96            	ldw	x,sp
2525  041c 1c0007        	addw	x,#OFST+4
2526  041f 8d000000      	callf	d_ltor
2528  0423 ae000c        	ldw	x,#L65
2529  0426 8d000000      	callf	d_lcmp
2531  042a 250c          	jrult	L042
2532  042c               L232:
2533  042c ae023c        	ldw	x,#572
2534  042f 89            	pushw	x
2535  0430 ae0018        	ldw	x,#L345
2536  0433 8d000000      	callf	f_assert_failed
2538  0437 85            	popw	x
2539  0438               L042:
2540                     ; 574   pFlash = (@far u8 *) Address;
2542  0438 7b08          	ld	a,(OFST+5,sp)
2543  043a 6b01          	ld	(OFST-2,sp),a
2544  043c 7b09          	ld	a,(OFST+6,sp)
2545  043e 6b02          	ld	(OFST-1,sp),a
2546  0440 7b0a          	ld	a,(OFST+7,sp)
2547  0442 6b03          	ld	(OFST+0,sp),a
2548                     ; 575   return(*pFlash); /* Read byte */
2550  0444 7b01          	ld	a,(OFST-2,sp)
2551  0446 b700          	ld	c_x,a
2552  0448 1e02          	ldw	x,(OFST-1,sp)
2553  044a bf01          	ldw	c_x+1,x
2554  044c 92bc0000      	ldf	a,[c_x.e]
2557  0450 5b03          	addw	sp,#3
2558  0452 87            	retf	
2623                     ; 593 u16 FLASH_ReadOptionByte(u32 Address)
2623                     ; 594 {
2624                     	switch	.text
2625  0453               f_FLASH_ReadOptionByte:
2627  0453 5207          	subw	sp,#7
2628       00000007      OFST:	set	7
2631                     ; 601   assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
2633  0455 96            	ldw	x,sp
2634  0456 1c000b        	addw	x,#OFST+4
2635  0459 8d000000      	callf	d_ltor
2637  045d ae0010        	ldw	x,#L27
2638  0460 8d000000      	callf	d_lcmp
2640  0464 2511          	jrult	L642
2641  0466 96            	ldw	x,sp
2642  0467 1c000b        	addw	x,#OFST+4
2643  046a 8d000000      	callf	d_ltor
2645  046e ae0014        	ldw	x,#L47
2646  0471 8d000000      	callf	d_lcmp
2648  0475 250c          	jrult	L052
2649  0477               L642:
2650  0477 ae0259        	ldw	x,#601
2651  047a 89            	pushw	x
2652  047b ae0018        	ldw	x,#L345
2653  047e 8d000000      	callf	f_assert_failed
2655  0482 85            	popw	x
2656  0483               L052:
2657                     ; 603   pFlash = (@far u8 *)Address;
2659  0483 7b0c          	ld	a,(OFST+5,sp)
2660  0485 6b01          	ld	(OFST-6,sp),a
2661  0487 7b0d          	ld	a,(OFST+6,sp)
2662  0489 6b02          	ld	(OFST-5,sp),a
2663  048b 7b0e          	ld	a,(OFST+7,sp)
2664  048d 6b03          	ld	(OFST-4,sp),a
2665                     ; 605   value_optbyte = *pFlash; /* Read option byte */
2667  048f 7b01          	ld	a,(OFST-6,sp)
2668  0491 b700          	ld	c_x,a
2669  0493 1e02          	ldw	x,(OFST-5,sp)
2670  0495 bf01          	ldw	c_x+1,x
2671  0497 92bc0000      	ldf	a,[c_x.e]
2672  049b 6b04          	ld	(OFST-3,sp),a
2673                     ; 606   value_optbyte_complement = *(pFlash + 1); /* Read option byte complement*/
2675  049d 90ae0001      	ldw	y,#1
2676  04a1 93            	ldw	x,y
2677  04a2 92af0000      	ldf	a,([c_x.e],x)
2678  04a6 6b05          	ld	(OFST-2,sp),a
2679                     ; 608   if (value_optbyte == (u8)(~value_optbyte_complement))
2681  04a8 43            	cpl	a
2682  04a9 1104          	cp	a,(OFST-3,sp)
2683  04ab 2614          	jrne	L5321
2684                     ; 610     res_value = (u16)((u16)value_optbyte << 8);
2686  04ad 7b04          	ld	a,(OFST-3,sp)
2687  04af 97            	ld	xl,a
2688  04b0 4f            	clr	a
2689  04b1 02            	rlwa	x,a
2690  04b2 1f06          	ldw	(OFST-1,sp),x
2691                     ; 611     res_value = res_value | (u16)value_optbyte_complement;
2693  04b4 7b05          	ld	a,(OFST-2,sp)
2694  04b6 5f            	clrw	x
2695  04b7 97            	ld	xl,a
2696  04b8 01            	rrwa	x,a
2697  04b9 1a07          	or	a,(OFST+0,sp)
2698  04bb 01            	rrwa	x,a
2699  04bc 1a06          	or	a,(OFST-1,sp)
2700  04be 01            	rrwa	x,a
2702  04bf 2003          	jra	L7321
2703  04c1               L5321:
2704                     ; 615     res_value = FLASH_OPTIONBYTE_ERROR;
2706  04c1 ae5555        	ldw	x,#21845
2707  04c4               L7321:
2708                     ; 618   return(res_value);
2712  04c4 5b07          	addw	sp,#7
2713  04c6 87            	retf	
2749                     ; 635 void FLASH_SetLowPowerMode(FLASH_LPMode_Typedef LPMode)
2749                     ; 636 {
2750                     	switch	.text
2751  04c7               f_FLASH_SetLowPowerMode:
2753  04c7 88            	push	a
2754       00000000      OFST:	set	0
2757                     ; 639   assert_param(IS_FLASH_LOW_POWER_MODE_OK(LPMode));
2759  04c8 a104          	cp	a,#4
2760  04ca 2717          	jreq	L262
2761  04cc a108          	cp	a,#8
2762  04ce 2713          	jreq	L262
2763  04d0 4d            	tnz	a
2764  04d1 2710          	jreq	L262
2765  04d3 a10c          	cp	a,#12
2766  04d5 270c          	jreq	L262
2767  04d7 ae027f        	ldw	x,#639
2768  04da 89            	pushw	x
2769  04db ae0018        	ldw	x,#L345
2770  04de 8d000000      	callf	f_assert_failed
2772  04e2 85            	popw	x
2773  04e3               L262:
2774                     ; 641   FLASH->CR1 &= (u8)(~(FLASH_CR1_HALT | FLASH_CR1_AHALT)); /* Clears the two bits */
2776  04e3 c6505a        	ld	a,20570
2777  04e6 a4f3          	and	a,#243
2778  04e8 c7505a        	ld	20570,a
2779                     ; 642   FLASH->CR1 |= (u8)LPMode; /* Sets the new mode */
2781  04eb c6505a        	ld	a,20570
2782  04ee 1a01          	or	a,(OFST+1,sp)
2783  04f0 c7505a        	ld	20570,a
2784                     ; 644 }
2787  04f3 84            	pop	a
2788  04f4 87            	retf	
2824                     ; 659 void FLASH_SetProgrammingTime(FLASH_ProgramTime_Typedef ProgTime)
2824                     ; 660 {
2825                     	switch	.text
2826  04f5               f_FLASH_SetProgrammingTime:
2828  04f5 88            	push	a
2829       00000000      OFST:	set	0
2832                     ; 663   assert_param(IS_FLASH_PROGRAM_TIME_OK(ProgTime));
2834  04f6 4d            	tnz	a
2835  04f7 270f          	jreq	L472
2836  04f9 4a            	dec	a
2837  04fa 270c          	jreq	L472
2838  04fc ae0297        	ldw	x,#663
2839  04ff 89            	pushw	x
2840  0500 ae0018        	ldw	x,#L345
2841  0503 8d000000      	callf	f_assert_failed
2843  0507 85            	popw	x
2844  0508               L472:
2845                     ; 665   FLASH->CR1 &= (u8)(~FLASH_CR1_FIX);
2847  0508 7211505a      	bres	20570,#0
2848                     ; 666   FLASH->CR1 |= (u8)ProgTime;
2850  050c c6505a        	ld	a,20570
2851  050f 1a01          	or	a,(OFST+1,sp)
2852  0511 c7505a        	ld	20570,a
2853                     ; 668 }
2856  0514 84            	pop	a
2857  0515 87            	retf	
2897                     ; 685 FLASH_Status_Typedef FLASH_WaitForLastOperation(void)
2897                     ; 686 {
2898                     	switch	.text
2899  0516               f_FLASH_WaitForLastOperation:
2901  0516 89            	pushw	x
2902       00000002      OFST:	set	2
2905                     ; 687   u8 timeout = 0x19;
2907  0517 a619          	ld	a,#25
2908  0519 6b01          	ld	(OFST-1,sp),a
2909                     ; 688   u8 My_FlagStatus = 0x01;
2911  051b a601          	ld	a,#1
2912  051d 6b02          	ld	(OFST+0,sp),a
2914  051f 2009          	jra	L7131
2915  0521               L3131:
2916                     ; 694     My_FlagStatus = (u8)(FLASH->IAPSR & FLASH_IAPSR_EOP);
2918  0521 c6505f        	ld	a,20575
2919  0524 a404          	and	a,#4
2920  0526 6b02          	ld	(OFST+0,sp),a
2921                     ; 695     timeout--;
2923  0528 0a01          	dec	(OFST-1,sp)
2924  052a               L7131:
2925                     ; 691   while ((My_FlagStatus != 0x00) && (timeout != 0x00)) /* TBD Doesn't work on TC */
2927  052a 7b02          	ld	a,(OFST+0,sp)
2928  052c 2704          	jreq	L3231
2930  052e 0d01          	tnz	(OFST-1,sp)
2931  0530 26ef          	jrne	L3131
2932  0532               L3231:
2933                     ; 698   return((FLASH_Status_Typedef)My_FlagStatus);
2937  0532 85            	popw	x
2938  0533 87            	retf	
2973                     ; 715 void FLASH_Unlock(FLASH_MemType_TypeDef MemType)
2973                     ; 716 {
2974                     	switch	.text
2975  0534               f_FLASH_Unlock:
2977  0534 88            	push	a
2978       00000000      OFST:	set	0
2981                     ; 719   assert_param(IS_MEMORY_TYPE_OK(MemType));
2983  0535 4d            	tnz	a
2984  0536 2714          	jreq	L013
2985  0538 a101          	cp	a,#1
2986  053a 2710          	jreq	L013
2987  053c a102          	cp	a,#2
2988  053e 270c          	jreq	L013
2989  0540 ae02cf        	ldw	x,#719
2990  0543 89            	pushw	x
2991  0544 ae0018        	ldw	x,#L345
2992  0547 8d000000      	callf	f_assert_failed
2994  054b 85            	popw	x
2995  054c               L013:
2996                     ; 722   if ((MemType == FLASH_MEMTYPE_PROG) || (MemType == FLASH_MEMTYPE_PROG_DATA))
2998  054c 7b01          	ld	a,(OFST+1,sp)
2999  054e 2704          	jreq	L5431
3001  0550 a102          	cp	a,#2
3002  0552 2608          	jrne	L3431
3003  0554               L5431:
3004                     ; 724     FLASH->PUKR = FLASH_RASS_KEY1;
3006  0554 35565062      	mov	20578,#86
3007                     ; 725     FLASH->PUKR = FLASH_RASS_KEY2;
3009  0558 35ae5062      	mov	20578,#174
3010  055c               L3431:
3011                     ; 729   if ((MemType == FLASH_MEMTYPE_DATA) || (MemType == FLASH_MEMTYPE_PROG_DATA))
3013  055c a101          	cp	a,#1
3014  055e 2704          	jreq	L1531
3016  0560 a102          	cp	a,#2
3017  0562 2608          	jrne	L7431
3018  0564               L1531:
3019                     ; 731     FLASH->DUKR = FLASH_RASS_KEY2; /* Warning: keys are reversed on data memory !!! */
3021  0564 35ae5064      	mov	20580,#174
3022                     ; 732     FLASH->DUKR = FLASH_RASS_KEY1;
3024  0568 35565064      	mov	20580,#86
3025  056c               L7431:
3026                     ; 735 }
3029  056c 84            	pop	a
3030  056d 87            	retf	
3042                     	xdef	f_FLASH_Lock
3043                     	xdef	f_FLASH_Unlock
3044                     	xdef	f_FLASH_WaitForLastOperation
3045                     	xdef	f_FLASH_SetProgrammingTime
3046                     	xdef	f_FLASH_SetLowPowerMode
3047                     	xdef	f_FLASH_ReadOptionByte
3048                     	xdef	f_FLASH_ReadByte
3049                     	xdef	f_FLASH_ProgramWord
3050                     	xdef	f_FLASH_ProgramOptionByte
3051                     	xdef	f_FLASH_ProgramByte
3052                     	xdef	f_FLASH_ProgramBlock
3053                     	xdef	f_FLASH_ITConfig
3054                     	xdef	f_FLASH_GetProgrammingTime
3055                     	xdef	f_FLASH_GetLowPowerMode
3056                     	xdef	f_FLASH_GetITStatus
3057                     	xdef	f_FLASH_GetBootMemSize
3058                     	xdef	f_FLASH_EraseOptionByte
3059                     	xdef	f_FLASH_EraseByte
3060                     	xdef	f_FLASH_EraseBlock
3061                     	xdef	f_FLASH_DeInit
3062                     	xdef	f_FLASH_ClearFlags
3063                     	xref	f_assert_failed
3064                     	switch	.const
3065  0018               L345:
3066  0018 736f75636573  	dc.b	"souces\src\stm8_fl"
3067  002a 6173682e6300  	dc.b	"ash.c",0
3068                     	xref.b	c_lreg
3069                     	xref.b	c_x
3089                     	xref	d_uitolx
3090                     	xref	d_rtol
3091                     	xref	d_umul
3092                     	xref	d_ladc
3093                     	xref	d_lcmp
3094                     	xref	d_ltor
3095                     	xref	d_lgadd
3096                     	xref	d_cmulx
3097                     	end
