   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 776                     	switch	.bss
 777  0000               L534_WinFLdowncnt:
 778  0000 00            	ds.b	1
 779  0001               L334_WinFLupcnt:
 780  0001 00            	ds.b	1
 836                     ; 57 void ScanWindowKeys(void)
 836                     ; 58 {
 837                     	switch	.text
 838  0000               f_ScanWindowKeys:
 840  0000 89            	pushw	x
 841       00000002      OFST:	set	2
 844                     ; 63         WinKeyState = NoWinKeyPressed;
 846  0001 725f0009      	clr	_WinKeyState
 847                     ; 65         if ((IgnOffCtrl & EnableWinKey) == 0)  return;
 849  0005 7201000a64    	btjf	_IgnOffCtrl,#0,L105
 852                     ; 67         winKeyADvalue = GetADCresultAverage(1);
 854  000a a601          	ld	a,#1
 855  000c 8d000000      	callf	f_GetADCresultAverage
 857  0010 1f01          	ldw	(OFST-1,sp),x
 858                     ; 68         if (winKeyADvalue < WIN_KEY_DOWN_ADV)
 860  0012 a300c8        	cpw	x,#200
 861  0015 2421          	jruge	L764
 862                     ; 70             if(WinFLdowncnt <KEY_FILTER_CNT)WinFLdowncnt++;
 864  0017 c60000        	ld	a,L534_WinFLdowncnt
 865  001a a105          	cp	a,#5
 866  001c 2406          	jruge	L174
 869  001e 725c0000      	inc	L534_WinFLdowncnt
 871  0022 204a          	jra	L105
 872  0024               L174:
 873                     ; 71             else if(WinFLdowncnt < 40)
 875  0024 a128          	cp	a,#40
 876  0026 240a          	jruge	L574
 877                     ; 73                   WinFLdowncnt++;
 879  0028 725c0000      	inc	L534_WinFLdowncnt
 880                     ; 74                    WINFLdrv = DowncontCOM ;
 882  002c 35010008      	mov	_WINFLdrv,#1
 884  0030 203c          	jra	L105
 885  0032               L574:
 886                     ; 78                    WINFLdrv = DownCOM;
 888  0032 35020008      	mov	_WINFLdrv,#2
 889  0036 2036          	jra	L105
 890  0038               L764:
 891                     ; 81         else if (winKeyADvalue < WIN_KEY_UP_ADV)
 893  0038 a30320        	cpw	x,#800
 894  003b 241f          	jruge	L305
 895                     ; 83              if(WinFLupcnt <KEY_FILTER_CNT) WinFLupcnt++;
 897  003d c60001        	ld	a,L334_WinFLupcnt
 898  0040 a105          	cp	a,#5
 899  0042 2406          	jruge	L505
 902  0044 725c0001      	inc	L334_WinFLupcnt
 904  0048 2024          	jra	L105
 905  004a               L505:
 906                     ; 84              else if(WinFLupcnt == KEY_FILTER_CNT)
 908  004a a105          	cp	a,#5
 909  004c 2620          	jrne	L105
 910                     ; 86              	      WinFLupcnt++;
 912  004e 725c0001      	inc	L334_WinFLupcnt
 913                     ; 87                     WINFLdrv |= UpCOM ;
 915  0052 c60008        	ld	a,_WINFLdrv
 916  0055 aa03          	or	a,#3
 917  0057 c70008        	ld	_WINFLdrv,a
 918  005a 2012          	jra	L105
 919  005c               L305:
 920                     ; 92               WinFLupcnt = 0;
 922  005c 725f0001      	clr	L334_WinFLupcnt
 923                     ; 93               WinFLdowncnt = 0;
 925  0060 725f0000      	clr	L534_WinFLdowncnt
 926                     ; 94     	       if( WINFLdrv != DowncontCOM) WINFLdrv = 0;
 928  0064 c60008        	ld	a,_WINFLdrv
 929  0067 4a            	dec	a
 930  0068 2704          	jreq	L105
 933  006a 725f0008      	clr	_WINFLdrv
 934  006e               L105:
 935                     ; 98 	}
 938  006e 85            	popw	x
 939  006f 87            	retf	
 963                     ; 116 void WindowUp(void)
 963                     ; 117 {
 964                     	switch	.text
 965  0070               f_WindowUp:
 969                     ; 118     WIN_FL_UP_ON; WIN_FL_DOWN_OFF; FLWinState |= Uping; FLWinState &= ~Stop;
 971  0070 72185000      	bset	20480,#4
 974  0074 721b5000      	bres	20480,#5
 977  0078 72100007      	bset	_FLWinState,#0
 980  007c 72190007      	bres	_FLWinState,#4
 981                     ; 119 	CAN_FLwindowDrv_ON;
 983  0080 721c0003      	bset	_CanSendData+3,#6
 984                     ; 121 }   
 987  0084 87            	retf	
1011                     ; 136 void WindowDown(void)
1011                     ; 137 {
1012                     	switch	.text
1013  0085               f_WindowDown:
1017                     ; 138     WIN_FL_UP_OFF; WIN_FL_DOWN_ON; FLWinState |= Downing; FLWinState &= ~Stop;
1019  0085 72195000      	bres	20480,#4
1022  0089 721a5000      	bset	20480,#5
1025  008d 72120007      	bset	_FLWinState,#1
1028  0091 72190007      	bres	_FLWinState,#4
1029                     ; 139 	CAN_FLwindowDrv_ON;
1031  0095 721c0003      	bset	_CanSendData+3,#6
1032                     ; 141 } 
1035  0099 87            	retf	
1059                     ; 153 void WindowStop(void)
1059                     ; 154 { 
1060                     	switch	.text
1061  009a               f_WindowStop:
1065                     ; 155     WIN_FL_UP_OFF; WIN_FL_DOWN_OFF; FLWinState |= Stop; FLWinState &= ~(Uping+Downing);
1067  009a 72195000      	bres	20480,#4
1070  009e 721b5000      	bres	20480,#5
1073  00a2 72180007      	bset	_FLWinState,#4
1076  00a6 c60007        	ld	a,_FLWinState
1077  00a9 a4fc          	and	a,#252
1078  00ab c70007        	ld	_FLWinState,a
1079                     ; 156 	CAN_FLwindowDrv_OFF;
1081  00ae c60003        	ld	a,_CanSendData+3
1082  00b1 a43f          	and	a,#63
1083  00b3 c70003        	ld	_CanSendData+3,a
1084                     ; 158 } 
1087  00b6 87            	retf	
1089                     	switch	.bss
1090  0002               L745_FLDowncontcnt:
1091  0002 0000          	ds.b	2
1092  0004               L155_FLBFtime:
1093  0004 0000          	ds.b	2
1094  0006               L355_WINFLdrv_old:
1095  0006 00            	ds.b	1
1143                     ; 171 void WindowDriver(void)
1143                     ; 172 {	  
1144                     	switch	.text
1145  00b7               f_WindowDriver:
1149                     ; 177        if(WINFLdrv == DownCOM )   {  WindowDown(); FLDowncontcnt = 0 ; }
1151  00b7 c60008        	ld	a,_WINFLdrv
1152  00ba a102          	cp	a,#2
1153  00bc 2606          	jrne	L575
1156  00be 8d850085      	callf	f_WindowDown
1160  00c2 2031          	jpf	LC001
1161  00c4               L575:
1162                     ; 178        else if(WINFLdrv == UpCOM )  {  WindowUp();  FLDowncontcnt = 0 ;  }
1164  00c4 a103          	cp	a,#3
1165  00c6 2606          	jrne	L106
1168  00c8 8d700070      	callf	f_WindowUp
1172  00cc 2027          	jpf	LC001
1173  00ce               L106:
1174                     ; 179        else if(WINFLdrv == DowncontCOM)
1176  00ce 4a            	dec	a
1177  00cf 2620          	jrne	L506
1178                     ; 181              FLDowncontcnt++;
1180  00d1 ce0002        	ldw	x,L745_FLDowncontcnt
1181  00d4 5c            	incw	x
1182  00d5 cf0002        	ldw	L745_FLDowncontcnt,x
1183                     ; 182              if(FLDowncontcnt < Downconttime)
1185  00d8 a302ee        	cpw	x,#750
1186  00db 2406          	jruge	L706
1187                     ; 184                    WindowDown();
1189  00dd 8d850085      	callf	f_WindowDown
1192  00e1 2016          	jra	L775
1193  00e3               L706:
1194                     ; 188                     FLDowncontcnt = 0;
1196  00e3 5f            	clrw	x
1197  00e4 cf0002        	ldw	L745_FLDowncontcnt,x
1198                     ; 189                     WINFLdrv = 0 ;
1200  00e7 725f0008      	clr	_WINFLdrv
1201                     ; 190                     WindowStop();
1203  00eb 8d9a009a      	callf	f_WindowStop
1205  00ef 2008          	jra	L775
1206  00f1               L506:
1207                     ; 193        else   {     WindowStop();  FLDowncontcnt = 0 ; }
1209  00f1 8d9a009a      	callf	f_WindowStop
1213  00f5               LC001:
1216  00f5 5f            	clrw	x
1217  00f6 cf0002        	ldw	L745_FLDowncontcnt,x
1218  00f9               L775:
1219                     ; 197 	if(WINFLdrv != WINFLdrv_old)
1221  00f9 c60008        	ld	a,_WINFLdrv
1222  00fc c10006        	cp	a,L355_WINFLdrv_old
1223  00ff 270b          	jreq	L516
1224                     ; 199              WINFLdrv_old = WINFLdrv;
1226  0101 5500080006    	mov	L355_WINFLdrv_old,_WINFLdrv
1227                     ; 200 	         FLBFtime = Downconttime;
1229  0106 ae02ee        	ldw	x,#750
1230  0109 cf0004        	ldw	L155_FLBFtime,x
1231  010c               L516:
1232                     ; 202 	if(FLBFtime != 0)
1234  010c ce0004        	ldw	x,L155_FLBFtime
1235  010f 270e          	jreq	L716
1236                     ; 204               FLBFtime--;
1238  0111 5a            	decw	x
1239  0112 cf0004        	ldw	L155_FLBFtime,x
1240                     ; 205 			  if(FLBFtime == 0)
1242  0115 2608          	jrne	L716
1243                     ; 207 				  WindowStop();  FLDowncontcnt = 0  ;
1245  0117 8d9a009a      	callf	f_WindowStop
1249  011b 5f            	clrw	x
1250  011c cf0002        	ldw	L745_FLDowncontcnt,x
1251  011f               L716:
1252                     ; 212 }    
1255  011f 87            	retf	
1297                     	switch	.bss
1298  0007               _FLWinState:
1299  0007 00            	ds.b	1
1300                     	xdef	_FLWinState
1301                     	xref	_CanSendData
1302                     	xref	f_GetADCresultAverage
1303                     	xdef	f_WindowStop
1304                     	xdef	f_WindowDown
1305                     	xdef	f_WindowUp
1306                     	xdef	f_WindowDriver
1307                     	xdef	f_ScanWindowKeys
1308  0008               _WINFLdrv:
1309  0008 00            	ds.b	1
1310                     	xdef	_WINFLdrv
1311  0009               _WinKeyState:
1312  0009 00            	ds.b	1
1313                     	xdef	_WinKeyState
1314  000a               _IgnOffCtrl:
1315  000a 00            	ds.b	1
1316                     	xdef	_IgnOffCtrl
1336                     	end
