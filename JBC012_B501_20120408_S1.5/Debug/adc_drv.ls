   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 776                     .const:	section	.text
 777  0000               _adChannelTable:
 778  0000 0a            	dc.b	10
 779  0001 07            	dc.b	7
 780  0002 0b            	dc.b	11
 781  0003 0e            	dc.b	14
 782  0004 00            	dc.b	0
 814                     ; 62 void ADC_Start(void)
 814                     ; 63 {
 815                     	switch	.text
 816  0000               f_ADC_Start:
 820                     ; 64 	adChIndex = 0;
 822  0000 725f003d      	clr	_adChIndex
 823                     ; 65 	adRstIndex = 0;
 825  0004 725f003c      	clr	_adRstIndex
 826                     ; 66 	ADC->CSR = adChannelTable[adChIndex];
 828  0008 350a5400      	mov	21504,#10
 829                     ; 67 	ADC->CR1 |= 1;			//This bit must be written twice.
 831  000c 72105401      	bset	21505,#0
 832                     ; 68 	ADC->CR1 |= 1;			//Enable ADC and to start conversion
 834  0010 72105401      	bset	21505,#0
 835                     ; 70 }
 838  0014 87            	retf	
 860                     ; 82 void ADC_Stop(void)
 860                     ; 83 {
 861                     	switch	.text
 862  0015               f_ADC_Stop:
 866                     ; 84 	ADC->CSR = 0;		    //disable ADC convertion interrupt
 868  0015 725f5400      	clr	21504
 869                     ; 85 	ADC->CSR &= 0xdf;		//disable ADC convertion interrupt
 871  0019 721b5400      	bres	21504,#5
 872                     ; 86 	ADC->CR1 &= 0xfe;
 874  001d 72115401      	bres	21505,#0
 875                     ; 87 	ADC->CR1 &= 0xfe;		//This bit must be written twice.To power off ADC module 
 877  0021 72115401      	bres	21505,#0
 878                     ; 88 }
 881  0025 87            	retf	
 916                     ; 100 void ADC_Scan(void)      
 916                     ; 101 {
 917                     	switch	.text
 918  0026               f_ADC_Scan:
 920  0026 5205          	subw	sp,#5
 921       00000005      OFST:	set	5
 924                     ; 105 	for (i=0;i<AD_CH_INDEX_MAX;i++)
 926  0028 4f            	clr	a
 927  0029 6b05          	ld	(OFST+0,sp),a
 928  002b               L574:
 929                     ; 107 		adResult[i][adRstIndex] = ADC_GetValue(adChannelTable[i]);
 931  002b 5f            	clrw	x
 932  002c 97            	ld	xl,a
 933  002d d60000        	ld	a,(_adChannelTable,x)
 934  0030 8d000000      	callf	f_ADC_GetValue
 936  0034 1f03          	ldw	(OFST-2,sp),x
 937  0036 c6003c        	ld	a,_adRstIndex
 938  0039 5f            	clrw	x
 939  003a 97            	ld	xl,a
 940  003b 58            	sllw	x
 941  003c 1f01          	ldw	(OFST-4,sp),x
 942  003e 7b05          	ld	a,(OFST+0,sp)
 943  0040 97            	ld	xl,a
 944  0041 a60c          	ld	a,#12
 945  0043 42            	mul	x,a
 946  0044 72fb01        	addw	x,(OFST-4,sp)
 947  0047 1603          	ldw	y,(OFST-2,sp)
 948  0049 df0000        	ldw	(_adResult,x),y
 949                     ; 105 	for (i=0;i<AD_CH_INDEX_MAX;i++)
 951  004c 0c05          	inc	(OFST+0,sp)
 954  004e 7b05          	ld	a,(OFST+0,sp)
 955  0050 a105          	cp	a,#5
 956  0052 25d7          	jrult	L574
 957                     ; 109 	if (++adRstIndex >= AD_RST_INDEX_MAX)	
 959  0054 725c003c      	inc	_adRstIndex
 960  0058 c6003c        	ld	a,_adRstIndex
 961  005b a106          	cp	a,#6
 962  005d 2504          	jrult	L305
 963                     ; 111         adRstIndex = 0;
 965  005f 725f003c      	clr	_adRstIndex
 966  0063               L305:
 967                     ; 115 }
 970  0063 5b05          	addw	sp,#5
 971  0065 87            	retf	
1039                     ; 128 uint GetADCresultAverage(uchar ADCResultIndex)
1039                     ; 129 {
1040                     	switch	.text
1041  0066               f_GetADCresultAverage:
1043  0066 88            	push	a
1044  0067 5212          	subw	sp,#18
1045       00000012      OFST:	set	18
1048                     ; 133 	sum = adcMax = adcMin = adResult[ADCResultIndex][0];
1050  0069 97            	ld	xl,a
1051  006a a60c          	ld	a,#12
1052  006c 42            	mul	x,a
1053  006d de0000        	ldw	x,(_adResult,x)
1054  0070 1f0d          	ldw	(OFST-5,sp),x
1055  0072 1f0f          	ldw	(OFST-3,sp),x
1056  0074 8d000000      	callf	d_uitolx
1058  0078 96            	ldw	x,sp
1059  0079 1c0009        	addw	x,#OFST-9
1060  007c 8d000000      	callf	d_rtol
1062                     ; 136 	for (i=1;i<AD_RST_INDEX_MAX;i++)
1064  0080 ae0001        	ldw	x,#1
1065  0083 1f11          	ldw	(OFST-1,sp),x
1066  0085               L335:
1067                     ; 139 		sum += adResult[ADCResultIndex][i];
1069  0085 58            	sllw	x
1070  0086 1f07          	ldw	(OFST-11,sp),x
1071  0088 7b13          	ld	a,(OFST+1,sp)
1072  008a 97            	ld	xl,a
1073  008b a60c          	ld	a,#12
1074  008d 42            	mul	x,a
1075  008e 72fb07        	addw	x,(OFST-11,sp)
1076  0091 de0000        	ldw	x,(_adResult,x)
1077  0094 8d000000      	callf	d_uitolx
1079  0098 96            	ldw	x,sp
1080  0099 1c0009        	addw	x,#OFST-9
1081  009c 8d000000      	callf	d_lgadd
1083                     ; 141 		if (adcMax < adResult[ADCResultIndex][i])
1085  00a0 1e11          	ldw	x,(OFST-1,sp)
1086  00a2 58            	sllw	x
1087  00a3 1f07          	ldw	(OFST-11,sp),x
1088  00a5 7b13          	ld	a,(OFST+1,sp)
1089  00a7 97            	ld	xl,a
1090  00a8 a60c          	ld	a,#12
1091  00aa 42            	mul	x,a
1092  00ab 72fb07        	addw	x,(OFST-11,sp)
1093  00ae de0000        	ldw	x,(_adResult,x)
1094  00b1 130f          	cpw	x,(OFST-3,sp)
1095  00b3 2313          	jrule	L145
1096                     ; 143 			adcMax = adResult[ADCResultIndex][i];
1098  00b5 1e11          	ldw	x,(OFST-1,sp)
1099  00b7 58            	sllw	x
1100  00b8 1f07          	ldw	(OFST-11,sp),x
1101  00ba 7b13          	ld	a,(OFST+1,sp)
1102  00bc 97            	ld	xl,a
1103  00bd a60c          	ld	a,#12
1104  00bf 42            	mul	x,a
1105  00c0 72fb07        	addw	x,(OFST-11,sp)
1106  00c3 de0000        	ldw	x,(_adResult,x)
1107  00c6 1f0f          	ldw	(OFST-3,sp),x
1108  00c8               L145:
1109                     ; 145 		if (adcMin > adResult[ADCResultIndex][i])
1111  00c8 1e11          	ldw	x,(OFST-1,sp)
1112  00ca 58            	sllw	x
1113  00cb 1f07          	ldw	(OFST-11,sp),x
1114  00cd 7b13          	ld	a,(OFST+1,sp)
1115  00cf 97            	ld	xl,a
1116  00d0 a60c          	ld	a,#12
1117  00d2 42            	mul	x,a
1118  00d3 72fb07        	addw	x,(OFST-11,sp)
1119  00d6 de0000        	ldw	x,(_adResult,x)
1120  00d9 130d          	cpw	x,(OFST-5,sp)
1121  00db 2413          	jruge	L345
1122                     ; 147 			adcMin = adResult[ADCResultIndex][i];
1124  00dd 1e11          	ldw	x,(OFST-1,sp)
1125  00df 58            	sllw	x
1126  00e0 1f07          	ldw	(OFST-11,sp),x
1127  00e2 7b13          	ld	a,(OFST+1,sp)
1128  00e4 97            	ld	xl,a
1129  00e5 a60c          	ld	a,#12
1130  00e7 42            	mul	x,a
1131  00e8 72fb07        	addw	x,(OFST-11,sp)
1132  00eb de0000        	ldw	x,(_adResult,x)
1133  00ee 1f0d          	ldw	(OFST-5,sp),x
1134  00f0               L345:
1135                     ; 136 	for (i=1;i<AD_RST_INDEX_MAX;i++)
1137  00f0 1e11          	ldw	x,(OFST-1,sp)
1138  00f2 5c            	incw	x
1139  00f3 1f11          	ldw	(OFST-1,sp),x
1142  00f5 a30006        	cpw	x,#6
1143  00f8 258b          	jrult	L335
1144                     ; 151 	sum = sum - adcMin - adcMax;
1146  00fa 1e0f          	ldw	x,(OFST-3,sp)
1147  00fc 8d000000      	callf	d_uitolx
1149  0100 96            	ldw	x,sp
1150  0101 1c0005        	addw	x,#OFST-13
1151  0104 8d000000      	callf	d_rtol
1153  0108 1e0d          	ldw	x,(OFST-5,sp)
1154  010a 8d000000      	callf	d_uitolx
1156  010e 96            	ldw	x,sp
1157  010f 5c            	incw	x
1158  0110 8d000000      	callf	d_rtol
1160  0114 96            	ldw	x,sp
1161  0115 1c0009        	addw	x,#OFST-9
1162  0118 8d000000      	callf	d_ltor
1164  011c 96            	ldw	x,sp
1165  011d 5c            	incw	x
1166  011e 8d000000      	callf	d_lsub
1168  0122 96            	ldw	x,sp
1169  0123 1c0005        	addw	x,#OFST-13
1170  0126 8d000000      	callf	d_lsub
1172  012a 96            	ldw	x,sp
1173  012b 1c0009        	addw	x,#OFST-9
1174  012e 8d000000      	callf	d_rtol
1176                     ; 153 	Average = sum >> 2; 
1178  0132 96            	ldw	x,sp
1179  0133 1c0009        	addw	x,#OFST-9
1180  0136 8d000000      	callf	d_ltor
1182  013a a602          	ld	a,#2
1183  013c 8d000000      	callf	d_lursh
1185  0140 be02          	ldw	x,c_lreg+2
1186                     ; 155 	return Average;
1190  0142 5b13          	addw	sp,#19
1191  0144 87            	retf	
1247                     	xdef	_adChannelTable
1248                     	xdef	f_GetADCresultAverage
1249                     	xdef	f_ADC_Scan
1250                     	xdef	f_ADC_Stop
1251                     	xdef	f_ADC_Start
1252                     	switch	.bss
1253  0000               _adResult:
1254  0000 000000000000  	ds.b	60
1255                     	xdef	_adResult
1256  003c               _adRstIndex:
1257  003c 00            	ds.b	1
1258                     	xdef	_adRstIndex
1259  003d               _adChIndex:
1260  003d 00            	ds.b	1
1261                     	xdef	_adChIndex
1262  003e               _ADCerrorCnt:
1263  003e 00            	ds.b	1
1264                     	xdef	_ADCerrorCnt
1265                     	xref	f_ADC_GetValue
1266                     	xref.b	c_lreg
1286                     	xref	d_lursh
1287                     	xref	d_lsub
1288                     	xref	d_ltor
1289                     	xref	d_lgadd
1290                     	xref	d_rtol
1291                     	xref	d_uitolx
1292                     	end
