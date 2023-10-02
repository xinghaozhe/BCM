   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.2 - 23 Oct 2007
   3                     ; Optimizer V4.2.2 - 23 Oct 2007
 803                     ; 64 void BEEP_DeInit(void)
 803                     ; 65 {
 804                     	switch	.text
 805  0000               f_BEEP_DeInit:
 809                     ; 66   BEEP->CSR = BEEP_CSR_RESET_VALUE;
 811  0000 725f50f3      	clr	20723
 812                     ; 67 }
 815  0004 87            	retf	
 862                     .const:	section	.text
 863  0000               L21:
 864  0000 000186a0      	dc.l	100000
 865  0004               L41:
 866  0004 00030d41      	dc.l	200001
 867  0008               L22:
 868  0008 000003e8      	dc.l	1000
 869                     ; 94 void BEEP_LSICalibrationConfig(u32 LSIFreqHz)
 869                     ; 95 {
 870                     	switch	.text
 871  0005               f_BEEP_LSICalibrationConfig:
 873  0005 5206          	subw	sp,#6
 874       00000006      OFST:	set	6
 877                     ; 101   assert_param(IS_LSI_FREQ_OK(LSIFreqHz));
 879  0007 96            	ldw	x,sp
 880  0008 1c000a        	addw	x,#OFST+4
 881  000b 8d000000      	callf	d_ltor
 883  000f ae0000        	ldw	x,#L21
 884  0012 8d000000      	callf	d_lcmp
 886  0016 2511          	jrult	L01
 887  0018 96            	ldw	x,sp
 888  0019 1c000a        	addw	x,#OFST+4
 889  001c 8d000000      	callf	d_ltor
 891  0020 ae0004        	ldw	x,#L41
 892  0023 8d000000      	callf	d_lcmp
 894  0027 250c          	jrult	L61
 895  0029               L01:
 896  0029 ae0065        	ldw	x,#101
 897  002c 89            	pushw	x
 898  002d ae000c        	ldw	x,#L174
 899  0030 8d000000      	callf	f_assert_failed
 901  0034 85            	popw	x
 902  0035               L61:
 903                     ; 103   LSIFreqkHz = (u16)(LSIFreqHz / 1000); /* Converts value in kHz */
 905  0035 96            	ldw	x,sp
 906  0036 1c000a        	addw	x,#OFST+4
 907  0039 8d000000      	callf	d_ltor
 909  003d ae0008        	ldw	x,#L22
 910  0040 8d000000      	callf	d_ludv
 912  0044 be02          	ldw	x,c_lreg+2
 913  0046 1f03          	ldw	(OFST-3,sp),x
 914                     ; 107   BEEP->CSR &= (u8)(~BEEP_CSR_BEEPDIV); /* Clear bits */
 916  0048 c650f3        	ld	a,20723
 917  004b a4e0          	and	a,#224
 918  004d c750f3        	ld	20723,a
 919                     ; 109   A = (u16)(LSIFreqkHz >> 3U); /* Division by 8, keep integer part only */
 921  0050 54            	srlw	x
 922  0051 54            	srlw	x
 923  0052 54            	srlw	x
 924  0053 1f05          	ldw	(OFST-1,sp),x
 925                     ; 111   if ((8U * A) >= ((LSIFreqkHz - (8U * A)) * (1U + (2U * A))))
 927  0055 58            	sllw	x
 928  0056 58            	sllw	x
 929  0057 58            	sllw	x
 930  0058 1f01          	ldw	(OFST-5,sp),x
 931  005a 1e03          	ldw	x,(OFST-3,sp)
 932  005c 72f001        	subw	x,(OFST-5,sp)
 933  005f 1605          	ldw	y,(OFST-1,sp)
 934  0061 9058          	sllw	y
 935  0063 905c          	incw	y
 936  0065 8d000000      	callf	d_imul
 938  0069 1605          	ldw	y,(OFST-1,sp)
 939  006b 9058          	sllw	y
 940  006d 9058          	sllw	y
 941  006f 9058          	sllw	y
 942  0071 bf01          	ldw	c_x+1,x
 943  0073 90b301        	cpw	y,c_x+1
 944  0076 7b06          	ld	a,(OFST+0,sp)
 945  0078 2504          	jrult	L374
 946                     ; 113     BEEP->CSR |= (u8)(A - 2U);
 948  007a a002          	sub	a,#2
 950  007c 2001          	jra	L574
 951  007e               L374:
 952                     ; 117     BEEP->CSR |= (u8)(A - 1U);
 954  007e 4a            	dec	a
 955  007f               L574:
 956  007f ca50f3        	or	a,20723
 957  0082 c750f3        	ld	20723,a
 958                     ; 121   AWU->CSR1 |= AWU_CSR_MR;
 960  0085 721250f0      	bset	20720,#1
 961                     ; 123 }
 964  0089 5b06          	addw	sp,#6
 965  008b 87            	retf	
1038                     ; 141 ErrorStatus BEEP_AutoLSICalibration(void)
1038                     ; 142 {
1039                     	switch	.text
1040  008c               f_BEEP_AutoLSICalibration:
1042  008c 5209          	subw	sp,#9
1043       00000009      OFST:	set	9
1046                     ; 149   fmaster = CLK_GetClockFreq();
1048  008e 8d000000      	callf	f_CLK_GetClockFreq
1050  0092 96            	ldw	x,sp
1051  0093 1c0001        	addw	x,#OFST-8
1052  0096 8d000000      	callf	d_rtol
1054                     ; 152   AWU->CSR1 |= AWU_CSR_MSR;
1056  009a 721050f0      	bset	20720,#0
1057                     ; 155   lsi_freq_hz = TIM3_ComputeLsiClockFreq(fmaster);
1059  009e 1e03          	ldw	x,(OFST-6,sp)
1060  00a0 89            	pushw	x
1061  00a1 1e03          	ldw	x,(OFST-6,sp)
1062  00a3 89            	pushw	x
1063  00a4 8d000000      	callf	f_TIM3_ComputeLsiClockFreq
1065  00a8 5b04          	addw	sp,#4
1066  00aa 96            	ldw	x,sp
1067  00ab 1c0006        	addw	x,#OFST-3
1068  00ae 8d000000      	callf	d_rtol
1070                     ; 158   AWU->CSR1 &= (u8)(~AWU_CSR_MSR);
1072  00b2 721150f0      	bres	20720,#0
1073                     ; 160   if ((lsi_freq_hz >= LSI_FREQ_MIN) && (lsi_freq_hz <= LSI_FREQ_MAX))
1075  00b6 96            	ldw	x,sp
1076  00b7 1c0006        	addw	x,#OFST-3
1077  00ba 8d000000      	callf	d_ltor
1079  00be ae0000        	ldw	x,#L21
1080  00c1 8d000000      	callf	d_lcmp
1082  00c5 2521          	jrult	L135
1084  00c7 96            	ldw	x,sp
1085  00c8 1c0006        	addw	x,#OFST-3
1086  00cb 8d000000      	callf	d_ltor
1088  00cf ae0004        	ldw	x,#L41
1089  00d2 8d000000      	callf	d_lcmp
1091  00d6 2410          	jruge	L135
1092                     ; 163     BEEP_LSICalibrationConfig(lsi_freq_hz);
1094  00d8 1e08          	ldw	x,(OFST-1,sp)
1095  00da 89            	pushw	x
1096  00db 1e08          	ldw	x,(OFST-1,sp)
1097  00dd 89            	pushw	x
1098  00de 8d050005      	callf	f_BEEP_LSICalibrationConfig
1100  00e2 5b04          	addw	sp,#4
1101                     ; 164     status = SUCCESS;
1103  00e4 a601          	ld	a,#1
1105  00e6 2001          	jra	L335
1106  00e8               L135:
1107                     ; 168     status = ERROR;
1109  00e8 4f            	clr	a
1110  00e9               L335:
1111                     ; 171   return status;
1115  00e9 5b09          	addw	sp,#9
1116  00eb 87            	retf	
1178                     ; 188 void BEEP_Init(BEEP_Frequency_TypeDef BEEP_Frequency)
1178                     ; 189 {
1179                     	switch	.text
1180  00ec               f_BEEP_Init:
1182  00ec 88            	push	a
1183       00000000      OFST:	set	0
1186                     ; 192   assert_param(IS_BEEP_FREQ_OK(BEEP_Frequency));
1188  00ed 4d            	tnz	a
1189  00ee 2714          	jreq	L24
1190  00f0 a140          	cp	a,#64
1191  00f2 2710          	jreq	L24
1192  00f4 a180          	cp	a,#128
1193  00f6 270c          	jreq	L24
1194  00f8 ae00c0        	ldw	x,#192
1195  00fb 89            	pushw	x
1196  00fc ae000c        	ldw	x,#L174
1197  00ff 8d000000      	callf	f_assert_failed
1199  0103 85            	popw	x
1200  0104               L24:
1201                     ; 195   BEEP->CSR |= BEEP_CSR_BEEPEN;
1203  0104 721a50f3      	bset	20723,#5
1204                     ; 198   if ((BEEP->CSR & BEEP_CSR_BEEPDIV) == BEEP_CSR_BEEPDIV)
1206  0108 c650f3        	ld	a,20723
1207  010b a41f          	and	a,#31
1208  010d a11f          	cp	a,#31
1209  010f 2610          	jrne	L565
1210                     ; 200     BEEP->CSR &= (u8)(~BEEP_CSR_BEEPDIV); /* Clear bits */
1212  0111 c650f3        	ld	a,20723
1213  0114 a4e0          	and	a,#224
1214  0116 c750f3        	ld	20723,a
1215                     ; 201     BEEP->CSR |= BEEP_CALIBRATION_DEFAULT;
1217  0119 c650f3        	ld	a,20723
1218  011c aa0b          	or	a,#11
1219  011e c750f3        	ld	20723,a
1220  0121               L565:
1221                     ; 205   BEEP->CSR &= (u8)(~BEEP_CSR_BEEPSEL);
1223  0121 c650f3        	ld	a,20723
1224  0124 a43f          	and	a,#63
1225  0126 c750f3        	ld	20723,a
1226                     ; 206   BEEP->CSR |= (u8)(BEEP_Frequency);
1228  0129 c650f3        	ld	a,20723
1229  012c 1a01          	or	a,(OFST+1,sp)
1230  012e c750f3        	ld	20723,a
1231                     ; 208 }
1234  0131 84            	pop	a
1235  0132 87            	retf	
1289                     ; 223 void BEEP_Cmd(FunctionalState NewState)
1289                     ; 224 {
1290                     	switch	.text
1291  0133               f_BEEP_Cmd:
1295                     ; 225   if (NewState != DISABLE)
1297  0133 4d            	tnz	a
1298  0134 2705          	jreq	L516
1299                     ; 228     BEEP->CSR |= BEEP_CSR_BEEPEN;
1301  0136 721a50f3      	bset	20723,#5
1304  013a 87            	retf	
1305  013b               L516:
1306                     ; 233     BEEP->CSR &= (u8)(~BEEP_CSR_BEEPEN);
1308  013b 721b50f3      	bres	20723,#5
1309                     ; 235 }
1312  013f 87            	retf	
1324                     	xdef	f_BEEP_Cmd
1325                     	xdef	f_BEEP_Init
1326                     	xdef	f_BEEP_AutoLSICalibration
1327                     	xdef	f_BEEP_LSICalibrationConfig
1328                     	xdef	f_BEEP_DeInit
1329                     	xref	f_CLK_GetClockFreq
1330                     	xref	f_TIM3_ComputeLsiClockFreq
1331                     	xref	f_assert_failed
1332                     	switch	.const
1333  000c               L174:
1334  000c 736f75636573  	dc.b	"souces\src\stm8_be"
1335  001e 65702e6300    	dc.b	"ep.c",0
1336                     	xref.b	c_lreg
1337                     	xref.b	c_x
1357                     	xref	d_rtol
1358                     	xref	d_imul
1359                     	xref	d_ludv
1360                     	xref	d_lcmp
1361                     	xref	d_ltor
1362                     	end
