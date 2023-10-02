   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 826                     ; 55 void System_Init(void)
 826                     ; 56 {
 827                     	switch	.text
 828  0000               f_System_Init:
 832                     ; 57     Clear_WDT();
 834  0000 8dee00ee      	callf	f_Clear_WDT
 836                     ; 59 	GPIO_SysInit();
 838  0004 8d950095      	callf	f_GPIO_SysInit
 840                     ; 60 	RAM_Init();	
 842  0008 8ded00ed      	callf	f_RAM_Init
 844                     ; 61 	RKE_RECEIVE_RESET();//RKE_Init(); 替换
 846  000c 8d000000      	callf	f_RKE_RECEIVE_RESET
 848                     ; 62 	ADC_init();
 850  0010 8d000000      	callf	f_ADC_init
 852                     ; 63 	ADC_Start();
 854  0014 8d000000      	callf	f_ADC_Start
 856                     ; 66 	EXTI_SetExtIntSensitivity(EXTI_GPIOD, EXTI_RISE_ONLY);
 858  0018 ae0001        	ldw	x,#1
 859  001b a603          	ld	a,#3
 860  001d 95            	ld	xh,a
 861  001e 8d000000      	callf	f_EXTI_SetExtIntSensitivity
 863                     ; 69 	TIM4_Init();
 865  0022 8d000000      	callf	f_TIM4_Init
 867                     ; 73 	TIM2_Counter_Cycle_OVIE_init(T3PERIOD);
 869  0026 ae1388        	ldw	x,#5000
 870  0029 8d000000      	callf	f_TIM2_Counter_Cycle_OVIE_init
 872                     ; 76 	TIM2_PWM_Init(3, 0,  PWM_1,  Output_ActiveHigh);
 874  002d 4b01          	push	#1
 875  002f 4b60          	push	#96
 876  0031 5f            	clrw	x
 877  0032 89            	pushw	x
 878  0033 a603          	ld	a,#3
 879  0035 8d000000      	callf	f_TIM2_PWM_Init
 881  0039 5b04          	addw	sp,#4
 882                     ; 77   	TIM2_OCINT_DISABLE;
 884  003b a606          	ld	a,#6
 885  003d 8d000000      	callf	f_TIM2_Disable_IT
 887                     ; 78   	TIM2_OVFINT_DISABLE;
 889  0041 a601          	ld	a,#1
 890  0043 8d000000      	callf	f_TIM2_Disable_IT
 892                     ; 83   	TIM3_Counter_Cycle_OVIE_init(25000);
 894  0047 ae61a8        	ldw	x,#25000
 895  004a 8d000000      	callf	f_TIM3_Counter_Cycle_OVIE_init
 897                     ; 86 	TIM3_OCMP_Init(1, 20000,  Frozen,  NotOutput_ActiveLow);
 899  004e 4b02          	push	#2
 900  0050 4b00          	push	#0
 901  0052 ae4e20        	ldw	x,#20000
 902  0055 89            	pushw	x
 903  0056 a601          	ld	a,#1
 904  0058 8d000000      	callf	f_TIM3_OCMP_Init
 906  005c 5b04          	addw	sp,#4
 907                     ; 88 	TIM3_OCINT_DISABLE;
 909  005e a606          	ld	a,#6
 910  0060 8d000000      	callf	f_TIM3_Disable_IT
 912                     ; 89 	TIM3_OVFINT_DISABLE;
 914  0064 a601          	ld	a,#1
 915  0066 8d000000      	callf	f_TIM3_Disable_IT
 917                     ; 92 	FLASH_DeInit( );
 919  006a 8d000000      	callf	f_FLASH_DeInit
 921                     ; 93 	FLASH_Unlock(FLASH_MEMTYPE_DATA);  //程序调试取消写保护
 923  006e a601          	ld	a,#1
 924  0070 8d000000      	callf	f_FLASH_Unlock
 926                     ; 94 	FLASH_Unlock(FLASH_MEMTYPE_PROG);
 928  0074 4f            	clr	a
 929  0075 8d000000      	callf	f_FLASH_Unlock
 931                     ; 95 	DecelerationSetting(0); //写刹车初始参数   默认
 933  0079 4f            	clr	a
 934  007a 8d000000      	callf	f_DecelerationSetting
 936                     ; 97 	CAN_WakeUp();
 938  007e 8d000000      	callf	f_CAN_WakeUp
 940                     ; 98 	CAN_Init(CMCR_AWUM);
 942  0082 a620          	ld	a,#32
 943  0084 8d000000      	callf	f_CAN_Init
 945                     ; 100 	CAN_EnableDiagMode(CDGR_RX);		//  | CDGR_SILM TEST MODE
 947  0088 a608          	ld	a,#8
 948  008a 8d000000      	callf	f_CAN_EnableDiagMode
 950                     ; 101 	CanCanInterruptRestore();
 952  008e 8d000000      	callf	f_CanCanInterruptRestore
 954                     ; 106 	enableInterrupts();
 957  0092 9a            	rim	
 959                     ; 112   	rim()
 963  0093 9a            	rim	
 965                     ; 113 }
 968  0094 87            	retf	
 992                     ; 116 void GPIO_SysInit(void)
 992                     ; 117 {
 993                     	switch	.text
 994  0095               f_GPIO_SysInit:
 998                     ; 118     GPIO_UserInit(GPIOA);
1000  0095 ae5000        	ldw	x,#20480
1001  0098 8df300f3      	callf	f_GPIO_UserInit
1003                     ; 119     GPIO_UserInit(GPIOB);
1005  009c ae5005        	ldw	x,#20485
1006  009f 8df300f3      	callf	f_GPIO_UserInit
1008                     ; 120     GPIO_UserInit(GPIOC);
1010  00a3 ae500a        	ldw	x,#20490
1011  00a6 8df300f3      	callf	f_GPIO_UserInit
1013                     ; 121     GPIO_UserInit(GPIOD);
1015  00aa ae500f        	ldw	x,#20495
1016  00ad 8df300f3      	callf	f_GPIO_UserInit
1018                     ; 122     GPIO_UserInit(GPIOE);
1020  00b1 ae5014        	ldw	x,#20500
1021  00b4 8df300f3      	callf	f_GPIO_UserInit
1023                     ; 123     GPIO_UserInit(GPIOF);
1025  00b8 ae5019        	ldw	x,#20505
1026  00bb 8df300f3      	callf	f_GPIO_UserInit
1028                     ; 124     GPIO_UserInit(GPIOG);
1030  00bf ae501e        	ldw	x,#20510
1031  00c2 8df300f3      	callf	f_GPIO_UserInit
1033                     ; 125     GPIO_UserInit(GPIOH);
1035  00c6 ae5023        	ldw	x,#20515
1036  00c9 8df300f3      	callf	f_GPIO_UserInit
1038                     ; 126     GPIO_UserInit(GPIOI);
1040  00cd ae5028        	ldw	x,#20520
1041  00d0 8df300f3      	callf	f_GPIO_UserInit
1043                     ; 127 	TURN_LEFT_LAMP_OFF;
1045  00d4 72195019      	bres	20505,#4
1046                     ; 128 	TURN_RIGHT_LAMP_OFF;
1048  00d8 721b5019      	bres	20505,#5
1049                     ; 129 	CAN_TURNRightSW_OFF;
1051  00dc c60001        	ld	a,_CanSendData+1
1052  00df a4cf          	and	a,#207
1053  00e1 c70001        	ld	_CanSendData+1,a
1054                     ; 130 	CAN_TURNLeftSW_OFF;
1056  00e4 c60001        	ld	a,_CanSendData+1
1057  00e7 a43f          	and	a,#63
1058  00e9 c70001        	ld	_CanSendData+1,a
1059                     ; 131 }
1062  00ec 87            	retf	
1084                     ; 135 void RAM_Init(void)
1084                     ; 136 {
1085                     	switch	.text
1086  00ed               f_RAM_Init:
1090                     ; 138 }
1093  00ed 87            	retf	
1115                     ; 142 void Clear_WDT(void)
1115                     ; 143 {
1116                     	switch	.text
1117  00ee               f_Clear_WDT:
1121                     ; 145       IWDG->KR = 0xaa;
1123  00ee 35aa50e0      	mov	20704,#170
1124                     ; 153 }
1127  00f2 87            	retf	
1205                     ; 158 void GPIO_UserInit(GPIO_TypeDef* GPIOx)
1205                     ; 159 {
1206                     	switch	.text
1207  00f3               f_GPIO_UserInit:
1209  00f3 89            	pushw	x
1210       00000000      OFST:	set	0
1213                     ; 160     switch ((u16)(GPIOx))
1216                     ; 243         default:
1216                     ; 244              break;
1217  00f4 1d5000        	subw	x,#20480
1218  00f7 272a          	jreq	L105
1219  00f9 1d0005        	subw	x,#5
1220  00fc 276f          	jreq	L715
1221  00fe 1d0005        	subw	x,#5
1222  0101 272f          	jreq	L505
1223  0103 1d0005        	subw	x,#5
1224  0106 2733          	jreq	L705
1225  0108 1d0005        	subw	x,#5
1226  010b 273d          	jreq	L115
1227  010d 1d0005        	subw	x,#5
1228  0110 2741          	jreq	L315
1229  0112 1d0005        	subw	x,#5
1230  0115 274b          	jreq	L515
1231  0117 1d0005        	subw	x,#5
1232  011a 2751          	jreq	L715
1233  011c 1d0005        	subw	x,#5
1234  011f 2757          	jreq	L125
1235  0121 2062          	jra	L565
1236  0123               L105:
1237                     ; 164                 GPIOx->ODR = GPIOA_ODR_RESET_VALUE; /* Reset Output Data Register */
1239  0123 1e01          	ldw	x,(OFST+1,sp)
1240  0125 7f            	clr	(x)
1241                     ; 165                 GPIOx->IDR = GPIOA_IDR_RESET_VALUE; /* Reset Input Data Register */
1243  0126 6f01          	clr	(1,x)
1244                     ; 166                 GPIOx->DDR = GPIOA_DDR_RESET_VALUE; /* Reset Data Direction Register */
1246  0128 a638          	ld	a,#56
1247  012a e702          	ld	(2,x),a
1248                     ; 167                 GPIOx->CR1 = GPIOA_CR1_RESET_VALUE; /* Reset Control Register 1 */
1250  012c e703          	ld	(3,x),a
1251                     ; 168                 GPIOx->CR2 = GPIOA_CR2_RESET_VALUE; /* Reset Control Register 2 */
1253  012e a608          	ld	a,#8
1254                     ; 169             }break;
1256  0130 202c          	jpf	LC003
1257                     ; 173                 GPIOx->ODR = GPIOB_ODR_RESET_VALUE; /* Reset Output Data Register */
1258                     ; 174                 GPIOx->IDR = GPIOB_IDR_RESET_VALUE; /* Reset Input Data Register */
1259                     ; 175                 GPIOx->DDR = GPIOB_DDR_RESET_VALUE; /* Reset Data Direction Register */
1260                     ; 176                 GPIOx->CR1 = GPIOB_CR1_RESET_VALUE; /* Reset Control Register 1 */
1261                     ; 177                 GPIOx->CR2 = GPIOB_CR2_RESET_VALUE; /* Reset Control Register 2 */
1262                     ; 178             }break;
1264  0132               L505:
1265                     ; 182                 GPIOx->ODR = GPIOC_ODR_RESET_VALUE; /* Reset Output Data Register */
1267  0132 1e01          	ldw	x,(OFST+1,sp)
1268  0134 a680          	ld	a,#128
1269  0136 f7            	ld	(x),a
1270                     ; 183                 GPIOx->IDR = GPIOC_IDR_RESET_VALUE; /* Reset Input Data Register */
1272  0137 6f01          	clr	(1,x)
1273                     ; 184                 GPIOx->DDR = GPIOC_DDR_RESET_VALUE; /* Reset Data Direction Register */
1274                     ; 185                 GPIOx->CR1 = GPIOC_CR1_RESET_VALUE; /* Reset Control Register 1 */
1275                     ; 186                 GPIOx->CR2 = GPIOC_CR2_RESET_VALUE; /* Reset Control Register 2 */
1276                     ; 187             }break;
1278  0139 201f          	jpf	LC004
1279  013b               L705:
1280                     ; 191                 GPIOx->ODR = GPIOD_ODR_RESET_VALUE; /* Reset Output Data Register */
1282  013b 1e01          	ldw	x,(OFST+1,sp)
1283  013d 7f            	clr	(x)
1284                     ; 192                 GPIOx->IDR = GPIOD_IDR_RESET_VALUE; /* Reset Input Data Register */
1286  013e 6f01          	clr	(1,x)
1287                     ; 193                 GPIOx->DDR = GPIOD_DDR_RESET_VALUE; /* Reset Data Direction Register */
1289  0140 a639          	ld	a,#57
1290  0142 e702          	ld	(2,x),a
1291                     ; 194                 GPIOx->CR1 = GPIOD_CR1_RESET_VALUE; /* Reset Control Register 1 */
1293  0144 e703          	ld	(3,x),a
1294                     ; 195                 GPIOx->CR2 = GPIOD_CR2_RESET_VALUE; /* Reset Control Register 2 */
1296  0146 a63d          	ld	a,#61
1297                     ; 196             }break;
1299  0148 2014          	jpf	LC003
1300  014a               L115:
1301                     ; 200                 GPIOx->ODR = GPIOE_ODR_RESET_VALUE; /* Reset Output Data Register */
1303  014a 1e01          	ldw	x,(OFST+1,sp)
1304  014c 7f            	clr	(x)
1305                     ; 201                 GPIOx->IDR = GPIOE_IDR_RESET_VALUE; /* Reset Input Data Register */
1307  014d 6f01          	clr	(1,x)
1308                     ; 202                 GPIOx->DDR = GPIOE_DDR_RESET_VALUE; /* Reset Data Direction Register */
1310  014f a61f          	ld	a,#31
1311                     ; 203                 GPIOx->CR1 = GPIOE_CR1_RESET_VALUE; /* Reset Control Register 1 */
1312                     ; 204                 GPIOx->CR2 = GPIOE_CR2_RESET_VALUE; /* Reset Control Register 2 */
1313                     ; 205             }break;
1315  0151 2007          	jpf	LC004
1316  0153               L315:
1317                     ; 209                 GPIOx->ODR = GPIOF_ODR_RESET_VALUE; /* Reset Output Data Register */
1319  0153 1e01          	ldw	x,(OFST+1,sp)
1320  0155 7f            	clr	(x)
1321                     ; 210                 GPIOx->IDR = GPIOF_IDR_RESET_VALUE; /* Reset Input Data Register */
1323  0156 6f01          	clr	(1,x)
1324                     ; 211                 GPIOx->DDR = GPIOF_DDR_RESET_VALUE; /* Reset Data Direction Register */
1326  0158 a6b0          	ld	a,#176
1327                     ; 212                 GPIOx->CR1 = GPIOF_CR1_RESET_VALUE; /* Reset Control Register 1 */
1329  015a               LC004:
1331  015a e702          	ld	(2,x),a
1335  015c e703          	ld	(3,x),a
1336                     ; 213                 GPIOx->CR2 = GPIOF_CR2_RESET_VALUE; /* Reset Control Register 2 */
1338  015e               LC003:
1342  015e e704          	ld	(4,x),a
1343                     ; 214             }break;
1345  0160 2023          	jra	L565
1346  0162               L515:
1347                     ; 218                 GPIOx->ODR = GPIOG_ODR_RESET_VALUE; /* Reset Output Data Register */
1349  0162 1e01          	ldw	x,(OFST+1,sp)
1350  0164 a601          	ld	a,#1
1351  0166 f7            	ld	(x),a
1352                     ; 219                 GPIOx->IDR = GPIOG_IDR_RESET_VALUE; /* Reset Input Data Register */
1354  0167 6f01          	clr	(1,x)
1355                     ; 220                 GPIOx->DDR = GPIOG_DDR_RESET_VALUE; /* Reset Data Direction Register */
1357  0169 a6ed          	ld	a,#237
1358                     ; 221                 GPIOx->CR1 = GPIOG_CR1_RESET_VALUE; /* Reset Control Register 1 */
1359                     ; 222                 GPIOx->CR2 = GPIOG_CR2_RESET_VALUE; /* Reset Control Register 2 */
1360                     ; 223             }break;
1362  016b 20ed          	jpf	LC004
1363  016d               L715:
1364                     ; 227                 GPIOx->ODR = GPIOH_ODR_RESET_VALUE; /* Reset Output Data Register */
1366                     ; 228                 GPIOx->IDR = GPIOH_IDR_RESET_VALUE; /* Reset Input Data Register */
1368                     ; 229                 GPIOx->DDR = GPIOH_DDR_RESET_VALUE; /* Reset Data Direction Register */
1370                     ; 230                 GPIOx->CR1 = GPIOH_CR1_RESET_VALUE; /* Reset Control Register 1 */
1373  016d 1e01          	ldw	x,(OFST+1,sp)
1374  016f 7f            	clr	(x)
1376  0170 6f01          	clr	(1,x)
1378  0172 6f02          	clr	(2,x)
1380  0174 6f03          	clr	(3,x)
1381                     ; 231                 GPIOx->CR2 = GPIOH_CR2_RESET_VALUE; /* Reset Control Register 2 */
1382                     ; 232             }break;
1384  0176 200b          	jpf	LC001
1385  0178               L125:
1386                     ; 236                 GPIOx->ODR = GPIOI_ODR_RESET_VALUE; /* Reset Output Data Register */
1388  0178 1e01          	ldw	x,(OFST+1,sp)
1389  017a 7f            	clr	(x)
1390                     ; 237                 GPIOx->IDR = GPIOI_IDR_RESET_VALUE; /* Reset Input Data Register */
1392  017b 6f01          	clr	(1,x)
1393                     ; 238                 GPIOx->DDR = GPIOI_DDR_RESET_VALUE; /* Reset Data Direction Register */
1395  017d a601          	ld	a,#1
1396  017f e702          	ld	(2,x),a
1397                     ; 239                 GPIOx->CR1 = GPIOI_CR1_RESET_VALUE; /* Reset Control Register 1 */
1399  0181 e703          	ld	(3,x),a
1400                     ; 240                 GPIOx->CR2 = GPIOI_CR2_RESET_VALUE; /* Reset Control Register 2 */
1402  0183               LC001:
1405  0183 6f04          	clr	(4,x)
1406                     ; 241             }break;
1408                     ; 243         default:
1408                     ; 244              break;
1410  0185               L565:
1411                     ; 246 }
1414  0185 85            	popw	x
1415  0186 87            	retf	
1427                     	xdef	f_System_Init
1428                     	xdef	f_GPIO_UserInit
1429                     	xref	f_TIM4_Init
1430                     	xref	f_DecelerationSetting
1431                     	xref	f_CanCanInterruptRestore
1432                     	xref	f_CAN_EnableDiagMode
1433                     	xref	f_CAN_WakeUp
1434                     	xref	f_CAN_Init
1435                     	xref	_CanSendData
1436                     	xref	f_ADC_Start
1437                     	xref	f_TIM3_Disable_IT
1438                     	xref	f_TIM3_OCMP_Init
1439                     	xref	f_TIM3_Counter_Cycle_OVIE_init
1440                     	xref	f_TIM2_Disable_IT
1441                     	xref	f_TIM2_PWM_Init
1442                     	xref	f_TIM2_Counter_Cycle_OVIE_init
1443                     	xref	f_RKE_RECEIVE_RESET
1444                     	xdef	f_Clear_WDT
1445                     	xdef	f_RAM_Init
1446                     	xdef	f_GPIO_SysInit
1447                     	xref	f_EXTI_SetExtIntSensitivity
1448                     	xref	f_FLASH_Unlock
1449                     	xref	f_FLASH_DeInit
1450                     	xref	f_ADC_init
1469                     	end
