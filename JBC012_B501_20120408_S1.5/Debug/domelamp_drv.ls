   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 776                     	switch	.bss
 777  0000               L144_duty:
 778  0000 0000          	ds.b	2
 779  0002               L734_bClosing:
 780  0002 00            	ds.b	1
 781  0003               L534_bOpening:
 782  0003 00            	ds.b	1
 783  0004               L334_bLastLampDrv:
 784  0004 00            	ds.b	1
 847                     ; 55 void JudgeDomeLampDriver(void)
 847                     ; 56 {
 848                     	switch	.text
 849  0000               f_JudgeDomeLampDriver:
 853                     ; 61     DomeLampsDriver();
 855  0000 8d840084      	callf	f_DomeLampsDriver
 857                     ; 63 	if(bOpening)
 859  0004 c60003        	ld	a,L534_bOpening
 860  0007 271f          	jreq	L374
 861                     ; 65 		if(duty > 5000)//T1PERIOD)
 863  0009 ce0000        	ldw	x,L144_duty
 864  000c a31389        	cpw	x,#5001
 865  000f 2509          	jrult	L574
 866                     ; 67 			bOpening = 0;
 868  0011 725f0003      	clr	L534_bOpening
 869                     ; 68 			duty = 5002;//T1PERIOD;
 871  0015 ae138a        	ldw	x,#5002
 873  0018 2003          	jra	L774
 874  001a               L574:
 875                     ; 72 			duty += 57;				//fade in time = (5000-41)/57*8ms=700ms
 877  001a 1c0039        	addw	x,#57
 878  001d               L774:
 879  001d cf0000        	ldw	L144_duty,x
 880                     ; 74 		TIM2_CCR_WRITE(3, duty);
 882  0020 89            	pushw	x
 883  0021 a603          	ld	a,#3
 884  0023 8d000000      	callf	f_TIM2_CCR_WRITE
 886  0027 85            	popw	x
 887  0028               L374:
 888                     ; 78 	if(bClosing)
 890  0028 c60002        	ld	a,L734_bClosing
 891  002b 272b          	jreq	L105
 892                     ; 80 		if(duty < 57)
 894  002d ce0000        	ldw	x,L144_duty
 895  0030 a30039        	cpw	x,#57
 896  0033 2415          	jruge	L305
 897                     ; 82 			bClosing = 0;
 899  0035 725f0002      	clr	L734_bClosing
 900                     ; 83 			duty = 0;
 902  0039 5f            	clrw	x
 903  003a cf0000        	ldw	L144_duty,x
 904                     ; 84 			TIM2_CCR_WRITE( 3, duty);
 906  003d 89            	pushw	x
 907  003e a603          	ld	a,#3
 908  0040 8d000000      	callf	f_TIM2_CCR_WRITE
 910  0044 72175000      	bres	20480,#3
 911  0048 85            	popw	x
 912                     ; 85 			DOME_LAMP_OFF;
 914                     ; 86 			return;
 917  0049 87            	retf	
 918  004a               L305:
 919                     ; 90 			duty -= 57;				//fade out time = 5000/57*8ms=700ms
 921  004a 1d0039        	subw	x,#57
 922  004d cf0000        	ldw	L144_duty,x
 923                     ; 92 		TIM2_CCR_WRITE( 3, duty);
 925  0050 89            	pushw	x
 926  0051 a603          	ld	a,#3
 927  0053 8d000000      	callf	f_TIM2_CCR_WRITE
 929  0057 85            	popw	x
 930  0058               L105:
 931                     ; 95 	if(DomeLampDrv == bLastLampDrv) return;
 933  0058 c60011        	ld	a,_DomeLampDrv
 934  005b c10004        	cp	a,L334_bLastLampDrv
 935  005e 2601          	jrne	L705
 939  0060 87            	retf	
 940  0061               L705:
 941                     ; 96 	bLastLampDrv = DomeLampDrv;
 943  0061 c70004        	ld	L334_bLastLampDrv,a
 944                     ; 97     if (DomeLampDrv == ON)
 946  0064 a155          	cp	a,#85
 947  0066 260d          	jrne	L115
 948                     ; 99 	    bOpening = 1; 
 950  0068 35010003      	mov	L534_bOpening,#1
 951                     ; 100 	    bClosing = 0;
 953  006c 725f0002      	clr	L734_bClosing
 954                     ; 101 	    duty = 41;
 956  0070 ae0029        	ldw	x,#41
 958  0073 200b          	jra	L315
 959  0075               L115:
 960                     ; 105 	    bClosing = 1;
 962  0075 35010002      	mov	L734_bClosing,#1
 963                     ; 106 	    bOpening = 0;
 965  0079 725f0003      	clr	L534_bOpening
 966                     ; 107     	duty = 5000;//T1PERIOD;
 968  007d ae1388        	ldw	x,#5000
 969  0080               L315:
 970  0080 cf0000        	ldw	L144_duty,x
 971                     ; 109 }
 974  0083 87            	retf	
 976                     	switch	.bss
 977  0005               L715_DoorState_Old:
 978  0005 00            	ds.b	1
 979  0006               L515_IGNstate_0ld:
 980  0006 00            	ds.b	1
1022                     ; 125 void DomeLampsDriver(void)
1022                     ; 126 {
1023                     	switch	.text
1024  0084               f_DomeLampsDriver:
1028                     ; 131     if (fade_out_time) 
1030  0084 ae000d        	ldw	x,#_fade_out_time
1031  0087 8d000000      	callf	d_lzmp
1033  008b 2713          	jreq	L735
1034                     ; 133         fade_out_time--;
1036  008d a601          	ld	a,#1
1037  008f 8d000000      	callf	d_lgsbc
1039                     ; 134         if (DomeLampDrv != ON)
1041  0093 c60011        	ld	a,_DomeLampDrv
1042  0096 a155          	cp	a,#85
1043  0098 270f          	jreq	L345
1044                     ; 136             DomeLampDrv = ON;
1046  009a 35550011      	mov	_DomeLampDrv,#85
1047  009e 2009          	jra	L345
1048  00a0               L735:
1049                     ; 141         if (DomeLampDrv != OFF)
1051  00a0 c60011        	ld	a,_DomeLampDrv
1052  00a3 2704          	jreq	L345
1053                     ; 143             DomeLampDrv = OFF;
1055  00a5 725f0011      	clr	_DomeLampDrv
1056  00a9               L345:
1057                     ; 152      if(IGNstate_0ld != IGNstate)
1059  00a9 c60006        	ld	a,L515_IGNstate_0ld
1060  00ac c10000        	cp	a,_IGNstate
1061  00af 272e          	jreq	L745
1062                     ; 154           IGNstate_0ld = IGNstate;
1064  00b1 c60000        	ld	a,_IGNstate
1065  00b4 c70006        	ld	L515_IGNstate_0ld,a
1066                     ; 155           if(IGNstate == OFF)                    //¸ü¸Ä20081128
1068  00b7 261b          	jrne	L155
1069                     ; 157 		      if(DoorState == AllDoorIsClosed) fade_out_time = 3125; 
1071  00b9 725d0000      	tnz	_DoorState
1072  00bd 2609          	jrne	L355
1075  00bf ae0c35        	ldw	x,#3125
1076  00c2 cf000f        	ldw	_fade_out_time+2,x
1077  00c5 5f            	clrw	x
1079  00c6 2009          	jpf	LC001
1080  00c8               L355:
1081                     ; 158 		      else fade_out_time = 75000;
1083  00c8 ae24f8        	ldw	x,#9464
1084  00cb cf000f        	ldw	_fade_out_time+2,x
1085  00ce ae0001        	ldw	x,#1
1086  00d1               LC001:
1087  00d1 cf000d        	ldw	_fade_out_time,x
1088  00d4               L155:
1089                     ; 160           if(IGNstate == ON )  fade_out_time = 0;
1091  00d4 a155          	cp	a,#85
1092  00d6 2607          	jrne	L745
1095  00d8 5f            	clrw	x
1096  00d9 cf000f        	ldw	_fade_out_time+2,x
1097  00dc cf000d        	ldw	_fade_out_time,x
1098  00df               L745:
1099                     ; 162       if((IGNstate == ON ) &&(DoorState == AllDoorIsClosed)) fade_out_time = 0;
1101  00df c60000        	ld	a,_IGNstate
1102  00e2 a155          	cp	a,#85
1103  00e4 260c          	jrne	L165
1105  00e6 c60000        	ld	a,_DoorState
1106  00e9 2607          	jrne	L165
1109  00eb 5f            	clrw	x
1110  00ec cf000f        	ldw	_fade_out_time+2,x
1111  00ef cf000d        	ldw	_fade_out_time,x
1112  00f2               L165:
1113                     ; 164      if(DoorState_Old != DoorState)
1115  00f2 c60005        	ld	a,L715_DoorState_Old
1116  00f5 c10000        	cp	a,_DoorState
1117  00f8 272e          	jreq	L365
1118                     ; 166            DoorState_Old = DoorState;
1120  00fa c60000        	ld	a,_DoorState
1121  00fd c70005        	ld	L715_DoorState_Old,a
1122                     ; 167            if(DoorState & AllDoorIsOpen)  fade_out_time = 75000 ;
1124  0100 a51f          	bcp	a,#31
1125  0102 270c          	jreq	L565
1128  0104 ae24f8        	ldw	x,#9464
1129  0107 cf000f        	ldw	_fade_out_time+2,x
1130  010a ae0001        	ldw	x,#1
1131  010d cf000d        	ldw	_fade_out_time,x
1132  0110               L565:
1133                     ; 168            if((DoorState == AllDoorIsClosed)&&(fade_out_time != 0))fade_out_time = 3125 ;
1135  0110 c60000        	ld	a,_DoorState
1136  0113 2613          	jrne	L365
1138  0115 ae000d        	ldw	x,#_fade_out_time
1139  0118 8d000000      	callf	d_lzmp
1141  011c 270a          	jreq	L365
1144  011e ae0c35        	ldw	x,#3125
1145  0121 cf000f        	ldw	_fade_out_time+2,x
1146  0124 5f            	clrw	x
1147  0125 cf000d        	ldw	_fade_out_time,x
1148  0128               L365:
1149                     ; 171      if(RKELOCKstate == 0x55)
1151  0128 c6000b        	ld	a,_RKELOCKstate
1152  012b a155          	cp	a,#85
1153  012d 261f          	jrne	L175
1154                     ; 173            RKELOCKstate = 0;
1156  012f 725f000b      	clr	_RKELOCKstate
1157                     ; 174            if(IGNstate == OFF ) 
1159  0133 c60000        	ld	a,_IGNstate
1160  0136 2616          	jrne	L175
1161                     ; 176                 if(DoorState & AllDoorIsOpen) fade_out_time = 7500 ;
1163  0138 c60000        	ld	a,_DoorState
1164  013b a51f          	bcp	a,#31
1165  013d 2705          	jreq	L575
1168  013f ae1d4c        	ldw	x,#7500
1170  0142 2003          	jpf	LC002
1171  0144               L575:
1172                     ; 179                     fade_out_time = 3125 ;
1174  0144 ae0c35        	ldw	x,#3125
1175  0147               LC002:
1176  0147 cf000f        	ldw	_fade_out_time+2,x
1177  014a 5f            	clrw	x
1178  014b cf000d        	ldw	_fade_out_time,x
1179  014e               L175:
1180                     ; 183      if(RKELOCKstate == 0xaa)
1182  014e c6000b        	ld	a,_RKELOCKstate
1183  0151 a1aa          	cp	a,#170
1184  0153 2610          	jrne	L106
1185                     ; 185            RKELOCKstate = 0;
1187  0155 725f000b      	clr	_RKELOCKstate
1188                     ; 186            if(DoorState == AllDoorIsClosed)fade_out_time = 0 ;
1190  0159 c60000        	ld	a,_DoorState
1191  015c 2607          	jrne	L106
1194  015e 5f            	clrw	x
1195  015f cf000f        	ldw	_fade_out_time+2,x
1196  0162 cf000d        	ldw	_fade_out_time,x
1197  0165               L106:
1198                     ; 189 }
1201  0165 87            	retf	
1250                     	xref	f_TIM2_CCR_WRITE
1251                     	xref	_DoorState
1252                     	xdef	f_DomeLampsDriver
1253                     	xdef	f_JudgeDomeLampDriver
1254                     	switch	.bss
1255  0007               _Battertime:
1256  0007 00000000      	ds.b	4
1257                     	xdef	_Battertime
1258  000b               _RKELOCKstate:
1259  000b 00            	ds.b	1
1260                     	xdef	_RKELOCKstate
1261  000c               _count:
1262  000c 00            	ds.b	1
1263                     	xdef	_count
1264  000d               _fade_out_time:
1265  000d 00000000      	ds.b	4
1266                     	xdef	_fade_out_time
1267  0011               _DomeLampDrv:
1268  0011 00            	ds.b	1
1269                     	xdef	_DomeLampDrv
1270                     	xref	_IGNstate
1290                     	xref	d_lgsbc
1291                     	xref	d_lzmp
1292                     	end
