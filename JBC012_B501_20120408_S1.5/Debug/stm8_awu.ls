   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 776                     .const:	section	.text
 777  0000               _APR_Array:
 778  0000 00            	dc.b	0
 779  0001 1e            	dc.b	30
 780  0002 1e            	dc.b	30
 781  0003 1e            	dc.b	30
 782  0004 1e            	dc.b	30
 783  0005 1e            	dc.b	30
 784  0006 1e            	dc.b	30
 785  0007 1e            	dc.b	30
 786  0008 1e            	dc.b	30
 787  0009 1e            	dc.b	30
 788  000a 1e            	dc.b	30
 789  000b 1e            	dc.b	30
 790  000c 1e            	dc.b	30
 791  000d 3d            	dc.b	61
 792  000e 17            	dc.b	23
 793  000f 17            	dc.b	23
 794  0010 3e            	dc.b	62
 795  0011               _TBR_Array:
 796  0011 00            	dc.b	0
 797  0012 01            	dc.b	1
 798  0013 02            	dc.b	2
 799  0014 03            	dc.b	3
 800  0015 04            	dc.b	4
 801  0016 05            	dc.b	5
 802  0017 06            	dc.b	6
 803  0018 07            	dc.b	7
 804  0019 08            	dc.b	8
 805  001a 09            	dc.b	9
 806  001b 0a            	dc.b	10
 807  001c 0b            	dc.b	11
 808  001d 0c            	dc.b	12
 809  001e 0c            	dc.b	12
 810  001f 0e            	dc.b	14
 811  0020 0f            	dc.b	15
 812  0021 0f            	dc.b	15
 841                     ; 77 void AWU_DeInit(void)
 841                     ; 78 {
 842                     	switch	.text
 843  0000               f_AWU_DeInit:
 847                     ; 79   AWU->CSR1 = AWU_CSR_RESET_VALUE;
 849  0000 725f50f0      	clr	20720
 850                     ; 80   AWU->APR = AWU_APR_RESET_VALUE;
 852  0004 353f50f1      	mov	20721,#63
 853                     ; 81   AWU->TBR = AWU_TBR_RESET_VALUE;
 855  0008 725f50f2      	clr	20722
 856                     ; 82 }
 859  000c 87            	retf	
 906                     	switch	.const
 907  0022               L21:
 908  0022 000186a0      	dc.l	100000
 909  0026               L41:
 910  0026 00030d41      	dc.l	200001
 911  002a               L22:
 912  002a 000003e8      	dc.l	1000
 913                     ; 109 void AWU_LSICalibrationConfig(u32 LSIFreqHz)
 913                     ; 110 {
 914                     	switch	.text
 915  000d               f_AWU_LSICalibrationConfig:
 917  000d 5206          	subw	sp,#6
 918       00000006      OFST:	set	6
 921                     ; 116   assert_param(IS_LSI_FREQ_OK(LSIFreqHz));
 923  000f 96            	ldw	x,sp
 924  0010 1c000a        	addw	x,#OFST+4
 925  0013 8d000000      	callf	d_ltor
 927  0017 ae0022        	ldw	x,#L21
 928  001a 8d000000      	callf	d_lcmp
 930  001e 2511          	jrult	L01
 931  0020 96            	ldw	x,sp
 932  0021 1c000a        	addw	x,#OFST+4
 933  0024 8d000000      	callf	d_ltor
 935  0028 ae0026        	ldw	x,#L41
 936  002b 8d000000      	callf	d_lcmp
 938  002f 250c          	jrult	L61
 939  0031               L01:
 940  0031 ae0074        	ldw	x,#116
 941  0034 89            	pushw	x
 942  0035 ae002e        	ldw	x,#L174
 943  0038 8d000000      	callf	f_assert_failed
 945  003c 85            	popw	x
 946  003d               L61:
 947                     ; 118   LSIFreqkHz = (u16)(LSIFreqHz / 1000); /* Converts value in kHz */
 949  003d 96            	ldw	x,sp
 950  003e 1c000a        	addw	x,#OFST+4
 951  0041 8d000000      	callf	d_ltor
 953  0045 ae002a        	ldw	x,#L22
 954  0048 8d000000      	callf	d_ludv
 956  004c be02          	ldw	x,c_lreg+2
 957  004e 1f03          	ldw	(OFST-3,sp),x
 958                     ; 122   A = (u16)(LSIFreqkHz >> 2U); /* Division by 4, keep integer part only */
 960  0050 54            	srlw	x
 961  0051 54            	srlw	x
 962  0052 1f05          	ldw	(OFST-1,sp),x
 963                     ; 124   if ((4U * A) >= ((LSIFreqkHz - (4U * A)) * (1U + (2U * A))))
 965  0054 58            	sllw	x
 966  0055 58            	sllw	x
 967  0056 1f01          	ldw	(OFST-5,sp),x
 968  0058 1e03          	ldw	x,(OFST-3,sp)
 969  005a 72f001        	subw	x,(OFST-5,sp)
 970  005d 1605          	ldw	y,(OFST-1,sp)
 971  005f 9058          	sllw	y
 972  0061 905c          	incw	y
 973  0063 8d000000      	callf	d_imul
 975  0067 1605          	ldw	y,(OFST-1,sp)
 976  0069 9058          	sllw	y
 977  006b 9058          	sllw	y
 978  006d bf01          	ldw	c_x+1,x
 979  006f 90b301        	cpw	y,c_x+1
 980  0072 7b06          	ld	a,(OFST+0,sp)
 981  0074 2504          	jrult	L374
 982                     ; 126     AWU->APR = (u8)(A - 2U);
 984  0076 a002          	sub	a,#2
 986  0078 2001          	jra	L574
 987  007a               L374:
 988                     ; 130     AWU->APR = (u8)(A - 1U);
 990  007a 4a            	dec	a
 991  007b               L574:
 992  007b c750f1        	ld	20721,a
 993                     ; 134   AWU->CSR1 |= AWU_CSR_MR;
 995  007e 721250f0      	bset	20720,#1
 996                     ; 136 }
 999  0082 5b06          	addw	sp,#6
1000  0084 87            	retf	
1072                     ; 154 ErrorStatus AWU_AutoLSICalibration(void)
1072                     ; 155 {
1073                     	switch	.text
1074  0085               f_AWU_AutoLSICalibration:
1076  0085 5209          	subw	sp,#9
1077       00000009      OFST:	set	9
1080                     ; 162   fmaster = CLK_GetClockFreq();
1082  0087 96            	ldw	x,sp
1083  0088 5c            	incw	x
1084  0089 8d000000      	callf	d_ltor
1086  008d 8d000000      	callf	f_CLK_GetClockFreq
1088                     ; 165   AWU->CSR1 |= AWU_CSR_MSR;
1090  0091 721050f0      	bset	20720,#0
1091                     ; 171   AWU->CSR1 &= (u8)(~AWU_CSR_MSR);
1093  0095 721150f0      	bres	20720,#0
1094                     ; 173   if ((lsi_freq_hz >= LSI_FREQ_MIN) && (lsi_freq_hz <= LSI_FREQ_MAX))
1096  0099 96            	ldw	x,sp
1097  009a 1c0005        	addw	x,#OFST-4
1098  009d 8d000000      	callf	d_ltor
1100  00a1 ae0022        	ldw	x,#L21
1101  00a4 8d000000      	callf	d_lcmp
1103  00a8 2521          	jrult	L135
1105  00aa 96            	ldw	x,sp
1106  00ab 1c0005        	addw	x,#OFST-4
1107  00ae 8d000000      	callf	d_ltor
1109  00b2 ae0026        	ldw	x,#L41
1110  00b5 8d000000      	callf	d_lcmp
1112  00b9 2410          	jruge	L135
1113                     ; 176     AWU_LSICalibrationConfig(lsi_freq_hz);
1115  00bb 1e07          	ldw	x,(OFST-2,sp)
1116  00bd 89            	pushw	x
1117  00be 1e07          	ldw	x,(OFST-2,sp)
1118  00c0 89            	pushw	x
1119  00c1 8d0d000d      	callf	f_AWU_LSICalibrationConfig
1121  00c5 5b04          	addw	sp,#4
1122                     ; 177     status = SUCCESS;
1124  00c7 a601          	ld	a,#1
1126  00c9 2001          	jra	L335
1127  00cb               L135:
1128                     ; 181     status = ERROR;
1130  00cb 4f            	clr	a
1131  00cc               L335:
1132                     ; 184   return status;
1136  00cc 5b09          	addw	sp,#9
1137  00ce 87            	retf	
1299                     ; 201 void AWU_Init(AWU_Timebase_TypeDef AWU_TimeBase)
1299                     ; 202 {
1300                     	switch	.text
1301  00cf               f_AWU_Init:
1303  00cf 88            	push	a
1304       00000000      OFST:	set	0
1307                     ; 205   assert_param(IS_AWU_TIMEBASE_OK(AWU_TimeBase));
1309  00d0 4d            	tnz	a
1310  00d1 274c          	jreq	L04
1311  00d3 a101          	cp	a,#1
1312  00d5 2748          	jreq	L04
1313  00d7 a102          	cp	a,#2
1314  00d9 2744          	jreq	L04
1315  00db a103          	cp	a,#3
1316  00dd 2740          	jreq	L04
1317  00df a104          	cp	a,#4
1318  00e1 273c          	jreq	L04
1319  00e3 a105          	cp	a,#5
1320  00e5 2738          	jreq	L04
1321  00e7 a106          	cp	a,#6
1322  00e9 2734          	jreq	L04
1323  00eb a107          	cp	a,#7
1324  00ed 2730          	jreq	L04
1325  00ef a108          	cp	a,#8
1326  00f1 272c          	jreq	L04
1327  00f3 a109          	cp	a,#9
1328  00f5 2728          	jreq	L04
1329  00f7 a10a          	cp	a,#10
1330  00f9 2724          	jreq	L04
1331  00fb a10b          	cp	a,#11
1332  00fd 2720          	jreq	L04
1333  00ff a10c          	cp	a,#12
1334  0101 271c          	jreq	L04
1335  0103 a10d          	cp	a,#13
1336  0105 2718          	jreq	L04
1337  0107 a10e          	cp	a,#14
1338  0109 2714          	jreq	L04
1339  010b a10f          	cp	a,#15
1340  010d 2710          	jreq	L04
1341  010f a110          	cp	a,#16
1342  0111 270c          	jreq	L04
1343  0113 ae00cd        	ldw	x,#205
1344  0116 89            	pushw	x
1345  0117 ae002e        	ldw	x,#L174
1346  011a 8d000000      	callf	f_assert_failed
1348  011e 85            	popw	x
1349  011f               L04:
1350                     ; 208   AWU->CSR1 |= AWU_CSR_AWUEN;
1352  011f 721850f0      	bset	20720,#4
1353                     ; 211   AWU->TBR &= (u8)(~AWU_TBR_AWUTB);
1355  0123 c650f2        	ld	a,20722
1356  0126 a4f0          	and	a,#240
1357  0128 c750f2        	ld	20722,a
1358                     ; 212   AWU->TBR |= TBR_Array[(u8)AWU_TimeBase];
1360  012b 7b01          	ld	a,(OFST+1,sp)
1361  012d 5f            	clrw	x
1362  012e 97            	ld	xl,a
1363  012f c650f2        	ld	a,20722
1364  0132 da0011        	or	a,(_TBR_Array,x)
1365  0135 c750f2        	ld	20722,a
1366                     ; 215   AWU->APR &= (u8)(~AWU_APR_APR);
1368  0138 c650f1        	ld	a,20721
1369  013b a4c0          	and	a,#192
1370  013d c750f1        	ld	20721,a
1371                     ; 216   AWU->APR |= APR_Array[(u8)AWU_TimeBase];
1373  0140 7b01          	ld	a,(OFST+1,sp)
1374  0142 5f            	clrw	x
1375  0143 97            	ld	xl,a
1376  0144 c650f1        	ld	a,20721
1377  0147 da0000        	or	a,(_APR_Array,x)
1378  014a c750f1        	ld	20721,a
1379                     ; 218 }
1382  014d 84            	pop	a
1383  014e 87            	retf	
1437                     ; 233 void AWU_Cmd(FunctionalState NewState)
1437                     ; 234 {
1438                     	switch	.text
1439  014f               f_AWU_Cmd:
1443                     ; 235   if (NewState != DISABLE)
1445  014f 4d            	tnz	a
1446  0150 2705          	jreq	L746
1447                     ; 238     AWU->CSR1 |= AWU_CSR_AWUEN;
1449  0152 721850f0      	bset	20720,#4
1452  0156 87            	retf	
1453  0157               L746:
1454                     ; 243     AWU->CSR1 &= (u8)(~AWU_CSR_AWUEN);
1456  0157 721950f0      	bres	20720,#4
1457                     ; 245 }
1460  015b 87            	retf	
1482                     ; 261 void AWU_ClearFlag(void)
1482                     ; 262 {
1483                     	switch	.text
1484  015c               f_AWU_ClearFlag:
1488                     ; 264   (void)AWU->CSR1;
1490  015c c650f0        	ld	a,20720
1491                     ; 265 }
1494  015f 87            	retf	
1537                     ; 283 FlagStatus AWU_GetFlagStatus(void)
1537                     ; 284 {
1538                     	switch	.text
1539  0160               f_AWU_GetFlagStatus:
1543                     ; 285   return((FlagStatus)(((u8)(AWU->CSR1 & AWU_CSR_AWUF) == (u8)0x00) ? RESET : SET));
1545  0160 720a50f002    	btjt	20720,#5,L25
1546  0165 4f            	clr	a
1548  0166 87            	retf	
1549  0167               L25:
1550  0167 a601          	ld	a,#1
1553  0169 87            	retf	
1575                     ; 302 void AWU_IdleModeEnable(void)
1575                     ; 303 {
1576                     	switch	.text
1577  016a               f_AWU_IdleModeEnable:
1581                     ; 306   AWU->CSR1 &= (u8)(~AWU_CSR_AWUEN);
1583  016a 721950f0      	bres	20720,#4
1584                     ; 309   AWU->TBR &= (u8)(~AWU_TBR_AWUTB);
1586  016e c650f2        	ld	a,20722
1587  0171 a4f0          	and	a,#240
1588  0173 c750f2        	ld	20722,a
1589                     ; 311 }
1592  0176 87            	retf	
1614                     ; 327 void AWU_ReInitCounter(void)
1614                     ; 328 {
1615                     	switch	.text
1616  0177               f_AWU_ReInitCounter:
1620                     ; 329   AWU->CSR1 |= AWU_CSR_MR;
1622  0177 721250f0      	bset	20720,#1
1623                     ; 330 }
1626  017b 87            	retf	
1660                     	xdef	_TBR_Array
1661                     	xdef	_APR_Array
1662                     	xdef	f_AWU_ReInitCounter
1663                     	xdef	f_AWU_IdleModeEnable
1664                     	xdef	f_AWU_GetFlagStatus
1665                     	xdef	f_AWU_ClearFlag
1666                     	xdef	f_AWU_Cmd
1667                     	xdef	f_AWU_AutoLSICalibration
1668                     	xdef	f_AWU_LSICalibrationConfig
1669                     	xdef	f_AWU_Init
1670                     	xdef	f_AWU_DeInit
1671                     	xref	f_CLK_GetClockFreq
1672                     	xref	f_assert_failed
1673                     	switch	.const
1674  002e               L174:
1675  002e 736f75636573  	dc.b	"souces\src\stm8_aw"
1676  0040 752e6300      	dc.b	"u.c",0
1677                     	xref.b	c_lreg
1678                     	xref.b	c_x
1698                     	xref	d_imul
1699                     	xref	d_ludv
1700                     	xref	d_lcmp
1701                     	xref	d_ltor
1702                     	end
