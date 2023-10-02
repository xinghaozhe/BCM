   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 803                     ; 65 void ADC_ClearFlag(void)
 803                     ; 66 {
 804                     	switch	.text
 805  0000               f_ADC_ClearFlag:
 809                     ; 67   ADC->CSR &= (u8)(~ADC_CSR_EOC);
 811  0000 721f5400      	bres	21504,#7
 812                     ; 68 }
 815  0004 87            	retf	
 870                     ; 84 void ADC_Cmd(FunctionalState NewState)
 870                     ; 85 {
 871                     	switch	.text
 872  0005               f_ADC_Cmd:
 874  0005 88            	push	a
 875       00000000      OFST:	set	0
 878                     ; 88   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 880  0006 a101          	cp	a,#1
 881  0008 270f          	jreq	L41
 882  000a 4d            	tnz	a
 883  000b 270c          	jreq	L41
 884  000d ae0058        	ldw	x,#88
 885  0010 89            	pushw	x
 886  0011 ae0000        	ldw	x,#L774
 887  0014 8d000000      	callf	f_assert_failed
 889  0018 85            	popw	x
 890  0019               L41:
 891                     ; 90   if (NewState != DISABLE)
 893  0019 7b01          	ld	a,(OFST+1,sp)
 894  001b 2706          	jreq	L105
 895                     ; 92     ADC->CR1 |= ADC_CR1_ADON;
 897  001d 72105401      	bset	21505,#0
 899  0021 2004          	jra	L305
 900  0023               L105:
 901                     ; 96     ADC->CR1 &= (u8)(~ADC_CR1_ADON);
 903  0023 72115401      	bres	21505,#0
 904  0027               L305:
 905                     ; 99 }
 908  0027 84            	pop	a
 909  0028 87            	retf	
 932                     ; 118 void ADC_StartConversion(void)
 932                     ; 119 {
 933                     	switch	.text
 934  0029               f_ADC_StartConversion:
 938                     ; 120   ADC->CR1 |= ADC_CR1_ADON;
 940  0029 72105401      	bset	21505,#0
 941                     ; 121 }
 944  002d 87            	retf	
 966                     ; 140 void ADC_DeInit(void)
 966                     ; 141 {
 967                     	switch	.text
 968  002e               f_ADC_DeInit:
 972                     ; 142   ADC->CSR  = ADC_CSR_RESET_VALUE;
 974  002e 725f5400      	clr	21504
 975                     ; 143   ADC->CR1  = ADC_CR1_RESET_VALUE;
 977  0032 725f5401      	clr	21505
 978                     ; 144   ADC->CR2  = ADC_CR2_RESET_VALUE;
 980  0036 725f5402      	clr	21506
 981                     ; 145   ADC->TDRH = ADC_TDRH_RESET_VALUE;
 983  003a 725f5406      	clr	21510
 984                     ; 146   ADC->TDRL = ADC_TDRL_RESET_VALUE;
 986  003e 725f5407      	clr	21511
 987                     ; 147 }
 990  0042 87            	retf	
1508                     ; 164 void ADC_StructInit(ADC_Init_TypeDef* ADC_InitStruct)
1508                     ; 165 {
1509                     	switch	.text
1510  0043               f_ADC_StructInit:
1514                     ; 168   ADC_InitStruct->ADC_ConversionMode = ADC_CONVERSIONMODE_SINGLE;
1516  0043 7f            	clr	(x)
1517                     ; 171   ADC_InitStruct->ADC_Channel = ADC_CHANNEL_0;
1519  0044 6f01          	clr	(1,x)
1520                     ; 174   ADC_InitStruct->ADC_PrescalerSelection = ADC_PRESSEL_FCPU_D2;
1522  0046 6f02          	clr	(2,x)
1523                     ; 177   ADC_InitStruct->ADC_ExtTrigger = ADC_EXTTRIG_TIM1;
1525  0048 6f03          	clr	(3,x)
1526                     ; 180   ADC_InitStruct->ADC_ExtTrigState = DISABLE;
1528  004a 6f04          	clr	(4,x)
1529                     ; 183   ADC_InitStruct->ADC_Align = ADC_ALIGN_LEFT;
1531  004c 6f05          	clr	(5,x)
1532                     ; 186   ADC_InitStruct->ADC_SchmittTriggerChannel = ADC_SCHMITTTRIG_CHANNEL0;
1534  004e 6f06          	clr	(6,x)
1535                     ; 189   ADC_InitStruct->ADC_SchmittTriggerState = ENABLE;
1537  0050 a601          	ld	a,#1
1538  0052 e707          	ld	(7,x),a
1539                     ; 190 }
1542  0054 87            	retf	
1598                     ; 212 void ADC_ConversionConfig(ADC_ConvMode_TypeDef ADC_ConversionMode, ADC_Channel_TypeDef ADC_Channel, ADC_Align_TypeDef ADC_Align)
1598                     ; 213 {
1599                     	switch	.text
1600  0055               f_ADC_ConversionConfig:
1602  0055 89            	pushw	x
1603       00000000      OFST:	set	0
1606                     ; 216   assert_param(IS_ADC_CONVERSIONMODE_OK(ADC_ConversionMode));
1608  0056 9e            	ld	a,xh
1609  0057 4d            	tnz	a
1610  0058 2710          	jreq	L43
1611  005a 9e            	ld	a,xh
1612  005b 4a            	dec	a
1613  005c 270c          	jreq	L43
1614  005e ae00d8        	ldw	x,#216
1615  0061 89            	pushw	x
1616  0062 ae0000        	ldw	x,#L774
1617  0065 8d000000      	callf	f_assert_failed
1619  0069 85            	popw	x
1620  006a               L43:
1621                     ; 217   assert_param(IS_ADC_CHANNEL_OK(ADC_Channel));
1623  006a 7b02          	ld	a,(OFST+2,sp)
1624  006c 2748          	jreq	L44
1625  006e a101          	cp	a,#1
1626  0070 2744          	jreq	L44
1627  0072 a102          	cp	a,#2
1628  0074 2740          	jreq	L44
1629  0076 a103          	cp	a,#3
1630  0078 273c          	jreq	L44
1631  007a a104          	cp	a,#4
1632  007c 2738          	jreq	L44
1633  007e a105          	cp	a,#5
1634  0080 2734          	jreq	L44
1635  0082 a106          	cp	a,#6
1636  0084 2730          	jreq	L44
1637  0086 a107          	cp	a,#7
1638  0088 272c          	jreq	L44
1639  008a a108          	cp	a,#8
1640  008c 2728          	jreq	L44
1641  008e a109          	cp	a,#9
1642  0090 2724          	jreq	L44
1643  0092 a10a          	cp	a,#10
1644  0094 2720          	jreq	L44
1645  0096 a10b          	cp	a,#11
1646  0098 271c          	jreq	L44
1647  009a a10c          	cp	a,#12
1648  009c 2718          	jreq	L44
1649  009e a10d          	cp	a,#13
1650  00a0 2714          	jreq	L44
1651  00a2 a10e          	cp	a,#14
1652  00a4 2710          	jreq	L44
1653  00a6 a10f          	cp	a,#15
1654  00a8 270c          	jreq	L44
1655  00aa ae00d9        	ldw	x,#217
1656  00ad 89            	pushw	x
1657  00ae ae0000        	ldw	x,#L774
1658  00b1 8d000000      	callf	f_assert_failed
1660  00b5 85            	popw	x
1661  00b6               L44:
1662                     ; 218   assert_param(IS_ADC_ALIGN_OK(ADC_Align));
1664  00b6 7b06          	ld	a,(OFST+6,sp)
1665  00b8 2710          	jreq	L45
1666  00ba a108          	cp	a,#8
1667  00bc 270c          	jreq	L45
1668  00be ae00da        	ldw	x,#218
1669  00c1 89            	pushw	x
1670  00c2 ae0000        	ldw	x,#L774
1671  00c5 8d000000      	callf	f_assert_failed
1673  00c9 85            	popw	x
1674  00ca               L45:
1675                     ; 220   if (ADC_ConversionMode == ADC_CONVERSIONMODE_CONTINUOUS)
1677  00ca 7b01          	ld	a,(OFST+1,sp)
1678  00cc 4a            	dec	a
1679  00cd 2606          	jrne	L5201
1680                     ; 223     ADC->CR1 |= ADC_CR1_CONT;
1682  00cf 72125401      	bset	21505,#1
1684  00d3 2004          	jra	L7201
1685  00d5               L5201:
1686                     ; 228     ADC->CR1 &= (u8)(~ADC_CR1_CONT);
1688  00d5 72135401      	bres	21505,#1
1689  00d9               L7201:
1690                     ; 232   ADC->CSR &= (u8)(~ADC_CSR_CH);
1692  00d9 c65400        	ld	a,21504
1693  00dc a4f0          	and	a,#240
1694  00de c75400        	ld	21504,a
1695                     ; 234   ADC->CSR |= (u8)(ADC_Channel);
1697  00e1 c65400        	ld	a,21504
1698  00e4 1a02          	or	a,(OFST+2,sp)
1699  00e6 c75400        	ld	21504,a
1700                     ; 237   ADC->CR2 &= (u8)(~ADC_CR2_ALIGN);
1702  00e9 72175402      	bres	21506,#3
1703                     ; 239   ADC->CR2 |= (u8)(ADC_Align);
1705  00ed c65402        	ld	a,21506
1706  00f0 1a06          	or	a,(OFST+6,sp)
1707  00f2 c75402        	ld	21506,a
1708                     ; 241 }
1711  00f5 85            	popw	x
1712  00f6 87            	retf	
1754                     ; 264 void ADC_Init(ADC_Init_TypeDef* ADC_InitStruct)
1754                     ; 265 {
1755                     	switch	.text
1756  00f7               f_ADC_Init:
1758  00f7 89            	pushw	x
1759       00000000      OFST:	set	0
1762                     ; 268   assert_param(IS_ADC_CONVERSIONMODE_OK(ADC_InitStruct->ADC_ConversionMode));
1764  00f8 f6            	ld	a,(x)
1765  00f9 270f          	jreq	L66
1766  00fb 4a            	dec	a
1767  00fc 270c          	jreq	L66
1768  00fe ae010c        	ldw	x,#268
1769  0101 89            	pushw	x
1770  0102 ae0000        	ldw	x,#L774
1771  0105 8d000000      	callf	f_assert_failed
1773  0109 85            	popw	x
1774  010a               L66:
1775                     ; 269   assert_param(IS_ADC_CHANNEL_OK(ADC_InitStruct->ADC_Channel));
1777  010a 1e01          	ldw	x,(OFST+1,sp)
1778  010c e601          	ld	a,(1,x)
1779  010e 274a          	jreq	L67
1780  0110 a101          	cp	a,#1
1781  0112 2746          	jreq	L67
1782  0114 a102          	cp	a,#2
1783  0116 2742          	jreq	L67
1784  0118 a103          	cp	a,#3
1785  011a 273e          	jreq	L67
1786  011c a104          	cp	a,#4
1787  011e 273a          	jreq	L67
1788  0120 a105          	cp	a,#5
1789  0122 2736          	jreq	L67
1790  0124 a106          	cp	a,#6
1791  0126 2732          	jreq	L67
1792  0128 a107          	cp	a,#7
1793  012a 272e          	jreq	L67
1794  012c a108          	cp	a,#8
1795  012e 272a          	jreq	L67
1796  0130 a109          	cp	a,#9
1797  0132 2726          	jreq	L67
1798  0134 a10a          	cp	a,#10
1799  0136 2722          	jreq	L67
1800  0138 a10b          	cp	a,#11
1801  013a 271e          	jreq	L67
1802  013c a10c          	cp	a,#12
1803  013e 271a          	jreq	L67
1804  0140 a10d          	cp	a,#13
1805  0142 2716          	jreq	L67
1806  0144 a10e          	cp	a,#14
1807  0146 2712          	jreq	L67
1808  0148 a10f          	cp	a,#15
1809  014a 270e          	jreq	L67
1810  014c ae010d        	ldw	x,#269
1811  014f 89            	pushw	x
1812  0150 ae0000        	ldw	x,#L774
1813  0153 8d000000      	callf	f_assert_failed
1815  0157 85            	popw	x
1816  0158 1e01          	ldw	x,(OFST+1,sp)
1817  015a               L67:
1818                     ; 270   assert_param(IS_ADC_PRESSEL_OK(ADC_InitStruct->ADC_PrescalerSelection));
1820  015a e602          	ld	a,(2,x)
1821  015c 272a          	jreq	L601
1822  015e a110          	cp	a,#16
1823  0160 2726          	jreq	L601
1824  0162 a120          	cp	a,#32
1825  0164 2722          	jreq	L601
1826  0166 a130          	cp	a,#48
1827  0168 271e          	jreq	L601
1828  016a a140          	cp	a,#64
1829  016c 271a          	jreq	L601
1830  016e a150          	cp	a,#80
1831  0170 2716          	jreq	L601
1832  0172 a160          	cp	a,#96
1833  0174 2712          	jreq	L601
1834  0176 a170          	cp	a,#112
1835  0178 270e          	jreq	L601
1836  017a ae010e        	ldw	x,#270
1837  017d 89            	pushw	x
1838  017e ae0000        	ldw	x,#L774
1839  0181 8d000000      	callf	f_assert_failed
1841  0185 85            	popw	x
1842  0186 1e01          	ldw	x,(OFST+1,sp)
1843  0188               L601:
1844                     ; 271   assert_param(IS_ADC_EXTTRIG_OK(ADC_InitStruct->ADC_ExtTrigger));
1846  0188 e603          	ld	a,(3,x)
1847  018a 2710          	jreq	L611
1848  018c a110          	cp	a,#16
1849  018e 270c          	jreq	L611
1850  0190 ae010f        	ldw	x,#271
1851  0193 89            	pushw	x
1852  0194 ae0000        	ldw	x,#L774
1853  0197 8d000000      	callf	f_assert_failed
1855  019b 85            	popw	x
1856  019c               L611:
1857                     ; 272   assert_param(IS_FUNCTIONALSTATE_OK(((ADC_InitStruct->ADC_ExtTrigState))));
1859  019c 1e01          	ldw	x,(OFST+1,sp)
1860  019e e604          	ld	a,(4,x)
1861  01a0 4a            	dec	a
1862  01a1 2712          	jreq	L621
1863  01a3 e604          	ld	a,(4,x)
1864  01a5 270e          	jreq	L621
1865  01a7 ae0110        	ldw	x,#272
1866  01aa 89            	pushw	x
1867  01ab ae0000        	ldw	x,#L774
1868  01ae 8d000000      	callf	f_assert_failed
1870  01b2 85            	popw	x
1871  01b3 1e01          	ldw	x,(OFST+1,sp)
1872  01b5               L621:
1873                     ; 273   assert_param(IS_ADC_ALIGN_OK(ADC_InitStruct->ADC_Align));
1875  01b5 e605          	ld	a,(5,x)
1876  01b7 2712          	jreq	L631
1877  01b9 a108          	cp	a,#8
1878  01bb 270e          	jreq	L631
1879  01bd ae0111        	ldw	x,#273
1880  01c0 89            	pushw	x
1881  01c1 ae0000        	ldw	x,#L774
1882  01c4 8d000000      	callf	f_assert_failed
1884  01c8 85            	popw	x
1885  01c9 1e01          	ldw	x,(OFST+1,sp)
1886  01cb               L631:
1887                     ; 274   assert_param(IS_ADC_SCHMITTTRIG_OK(ADC_InitStruct->ADC_SchmittTriggerChannel));
1889  01cb e606          	ld	a,(6,x)
1890  01cd 274e          	jreq	L641
1891  01cf a101          	cp	a,#1
1892  01d1 274a          	jreq	L641
1893  01d3 a102          	cp	a,#2
1894  01d5 2746          	jreq	L641
1895  01d7 a103          	cp	a,#3
1896  01d9 2742          	jreq	L641
1897  01db a104          	cp	a,#4
1898  01dd 273e          	jreq	L641
1899  01df a105          	cp	a,#5
1900  01e1 273a          	jreq	L641
1901  01e3 a106          	cp	a,#6
1902  01e5 2736          	jreq	L641
1903  01e7 a107          	cp	a,#7
1904  01e9 2732          	jreq	L641
1905  01eb a108          	cp	a,#8
1906  01ed 272e          	jreq	L641
1907  01ef a109          	cp	a,#9
1908  01f1 272a          	jreq	L641
1909  01f3 a10a          	cp	a,#10
1910  01f5 2726          	jreq	L641
1911  01f7 a10b          	cp	a,#11
1912  01f9 2722          	jreq	L641
1913  01fb a10c          	cp	a,#12
1914  01fd 271e          	jreq	L641
1915  01ff a10d          	cp	a,#13
1916  0201 271a          	jreq	L641
1917  0203 a10e          	cp	a,#14
1918  0205 2716          	jreq	L641
1919  0207 a10f          	cp	a,#15
1920  0209 2712          	jreq	L641
1921  020b a11f          	cp	a,#31
1922  020d 270e          	jreq	L641
1923  020f ae0112        	ldw	x,#274
1924  0212 89            	pushw	x
1925  0213 ae0000        	ldw	x,#L774
1926  0216 8d000000      	callf	f_assert_failed
1928  021a 85            	popw	x
1929  021b 1e01          	ldw	x,(OFST+1,sp)
1930  021d               L641:
1931                     ; 275   assert_param(IS_FUNCTIONALSTATE_OK(ADC_InitStruct->ADC_SchmittTriggerState));
1933  021d e607          	ld	a,(7,x)
1934  021f 4a            	dec	a
1935  0220 2710          	jreq	L651
1936  0222 e607          	ld	a,(7,x)
1937  0224 270c          	jreq	L651
1938  0226 ae0113        	ldw	x,#275
1939  0229 89            	pushw	x
1940  022a ae0000        	ldw	x,#L774
1941  022d 8d000000      	callf	f_assert_failed
1943  0231 85            	popw	x
1944  0232               L651:
1945                     ; 280   ADC_ConversionConfig(ADC_InitStruct->ADC_ConversionMode, ADC_InitStruct->ADC_Channel, ADC_InitStruct->ADC_Align);
1947  0232 1e01          	ldw	x,(OFST+1,sp)
1948  0234 e605          	ld	a,(5,x)
1949  0236 88            	push	a
1950  0237 1e02          	ldw	x,(OFST+2,sp)
1951  0239 e601          	ld	a,(1,x)
1952  023b 97            	ld	xl,a
1953  023c 1602          	ldw	y,(OFST+2,sp)
1954  023e 90f6          	ld	a,(y)
1955  0240 95            	ld	xh,a
1956  0241 8d550055      	callf	f_ADC_ConversionConfig
1958  0245 84            	pop	a
1959                     ; 282   ADC_PrescalerConfig(ADC_InitStruct->ADC_PrescalerSelection);
1961  0246 1e01          	ldw	x,(OFST+1,sp)
1962  0248 e602          	ld	a,(2,x)
1963  024a 8dad02ad      	callf	f_ADC_PrescalerConfig
1965                     ; 287   ADC_ExternalTriggerConfig(ADC_InitStruct->ADC_ExtTrigger, ADC_InitStruct->ADC_ExtTrigState);
1967  024e 1e01          	ldw	x,(OFST+1,sp)
1968  0250 e604          	ld	a,(4,x)
1969  0252 97            	ld	xl,a
1970  0253 1601          	ldw	y,(OFST+1,sp)
1971  0255 90e603        	ld	a,(3,y)
1972  0258 95            	ld	xh,a
1973  0259 8da603a6      	callf	f_ADC_ExternalTriggerConfig
1975                     ; 292   ADC_SchmittTriggerConfig(ADC_InitStruct->ADC_SchmittTriggerChannel, ADC_InitStruct->ADC_SchmittTriggerState);
1977  025d 1e01          	ldw	x,(OFST+1,sp)
1978  025f e607          	ld	a,(7,x)
1979  0261 97            	ld	xl,a
1980  0262 1601          	ldw	y,(OFST+1,sp)
1981  0264 90e606        	ld	a,(6,y)
1982  0267 95            	ld	xh,a
1983  0268 8df103f1      	callf	f_ADC_SchmittTriggerConfig
1985                     ; 295   ADC_Cmd(ENABLE);
1987  026c a601          	ld	a,#1
1988  026e 8d050005      	callf	f_ADC_Cmd
1990                     ; 297 }
1993  0272 85            	popw	x
1994  0273 87            	retf	
2018                     ; 301 void ADC_init(void)
2018                     ; 302  {
2019                     	switch	.text
2020  0274               f_ADC_init:
2024                     ; 303 	ADC->CSR &= 0xdf;		//disable ADC convertion interrupt
2026  0274 721b5400      	bres	21504,#5
2027                     ; 304 	ADC->CR1 &= 0x70;
2029  0278 c65401        	ld	a,21505
2030  027b a470          	and	a,#112
2031  027d c75401        	ld	21505,a
2032                     ; 305 	ADC->CR1 &= 0x70;		//operate twice, power off ADC module 
2034  0280 c65401        	ld	a,21505
2035  0283 a470          	and	a,#112
2036  0285 c75401        	ld	21505,a
2037                     ; 309 	ADC->CR1 |= 0b01010000;//set convertion clock frequence:  Fmaster/16
2039  0288 c65401        	ld	a,21505
2040  028b aa50          	or	a,#80
2041  028d c75401        	ld	21505,a
2042                     ; 310 	ADC->CR2 = 0x00;//08;		//right alignment:  8bit LSB in DL   ;  external triggle disable
2044  0290 725f5402      	clr	21506
2045                     ; 314 	ADC->TDRH = 0;			//0b11000001;	//channel 15~8
2047  0294 725f5406      	clr	21510
2048                     ; 315 	ADC->TDRL = 0;			//0b00111111;	//channel 15~8
2050  0298 725f5407      	clr	21511
2051                     ; 317 	ADC->CR1 |= 1;			//power on ADC
2053  029c 72105401      	bset	21505,#0
2054                     ; 318 	ADC->CR1 |= 1;			//start convertion
2056  02a0 72105401      	bset	21505,#0
2057                     ; 320 	adChIndex = 0;
2059  02a4 725f0000      	clr	_adChIndex
2060                     ; 321 	adRstIndex = 0;
2062  02a8 725f0000      	clr	_adRstIndex
2063                     ; 322  }
2066  02ac 87            	retf	
2102                     ; 341 void ADC_PrescalerConfig(ADC_PresSel_TypeDef ADC_Prescaler)
2102                     ; 342 {
2103                     	switch	.text
2104  02ad               f_ADC_PrescalerConfig:
2106  02ad 88            	push	a
2107       00000000      OFST:	set	0
2110                     ; 345   assert_param(IS_ADC_PRESSEL_OK(ADC_Prescaler));
2112  02ae 4d            	tnz	a
2113  02af 2728          	jreq	L402
2114  02b1 a110          	cp	a,#16
2115  02b3 2724          	jreq	L402
2116  02b5 a120          	cp	a,#32
2117  02b7 2720          	jreq	L402
2118  02b9 a130          	cp	a,#48
2119  02bb 271c          	jreq	L402
2120  02bd a140          	cp	a,#64
2121  02bf 2718          	jreq	L402
2122  02c1 a150          	cp	a,#80
2123  02c3 2714          	jreq	L402
2124  02c5 a160          	cp	a,#96
2125  02c7 2710          	jreq	L402
2126  02c9 a170          	cp	a,#112
2127  02cb 270c          	jreq	L402
2128  02cd ae0159        	ldw	x,#345
2129  02d0 89            	pushw	x
2130  02d1 ae0000        	ldw	x,#L774
2131  02d4 8d000000      	callf	f_assert_failed
2133  02d8 85            	popw	x
2134  02d9               L402:
2135                     ; 348   ADC->CR1 &= (u8)(~ADC_CR1_SPSEL);
2137  02d9 c65401        	ld	a,21505
2138  02dc a48f          	and	a,#143
2139  02de c75401        	ld	21505,a
2140                     ; 350   ADC->CR1 |= (u8)(ADC_Prescaler);
2142  02e1 c65401        	ld	a,21505
2143  02e4 1a01          	or	a,(OFST+1,sp)
2144  02e6 c75401        	ld	21505,a
2145                     ; 352 }
2148  02e9 84            	pop	a
2149  02ea 87            	retf	
2184                     ; 368 void ADC_ITCmd(FunctionalState ADC_ITEnable)
2184                     ; 369 {
2185                     	switch	.text
2186  02eb               f_ADC_ITCmd:
2188  02eb 88            	push	a
2189       00000000      OFST:	set	0
2192                     ; 372   assert_param(IS_FUNCTIONALSTATE_OK(ADC_ITEnable));
2194  02ec a101          	cp	a,#1
2195  02ee 270f          	jreq	L612
2196  02f0 4d            	tnz	a
2197  02f1 270c          	jreq	L612
2198  02f3 ae0174        	ldw	x,#372
2199  02f6 89            	pushw	x
2200  02f7 ae0000        	ldw	x,#L774
2201  02fa 8d000000      	callf	f_assert_failed
2203  02fe 85            	popw	x
2204  02ff               L612:
2205                     ; 374   if (ADC_ITEnable != DISABLE)
2207  02ff 7b01          	ld	a,(OFST+1,sp)
2208  0301 2706          	jreq	L5111
2209                     ; 377     ADC->CSR |= ADC_CSR_ITEN;
2211  0303 721a5400      	bset	21504,#5
2213  0307 2004          	jra	L7111
2214  0309               L5111:
2215                     ; 382     ADC->CSR &= (u8)(~ADC_CSR_ITEN);
2217  0309 721b5400      	bres	21504,#5
2218  030d               L7111:
2219                     ; 385 }
2222  030d 84            	pop	a
2223  030e 87            	retf	
2269                     ; 403 u16 ADC_GetConversionValue(void)
2269                     ; 404 {
2270                     	switch	.text
2271  030f               f_ADC_GetConversionValue:
2273  030f 5204          	subw	sp,#4
2274       00000004      OFST:	set	4
2277                     ; 406   u16 ConversionValue = 0;
2279                     ; 407   u16 tempH = 0;
2281                     ; 408   u16 tempL = 0;
2283                     ; 410  if (ADC->CR2 & ADC_CR2_ALIGN) /* Right alignment */
2285  0311 7207540210    	btjf	21506,#3,L1411
2286                     ; 413 		tempL = ADC->DRL;
2288  0316 c65405        	ld	a,21509
2289  0319 5f            	clrw	x
2290  031a 97            	ld	xl,a
2291  031b 1f01          	ldw	(OFST-3,sp),x
2292                     ; 415 		tempH = ADC->DRH;
2294  031d c65404        	ld	a,21508
2295  0320 5f            	clrw	x
2296  0321 97            	ld	xl,a
2297  0322 1f03          	ldw	(OFST-1,sp),x
2299  0324 2010          	jra	L3411
2300  0326               L1411:
2301                     ; 420 		tempH = ADC->DRH;
2303  0326 c65404        	ld	a,21508
2304  0329 5f            	clrw	x
2305  032a 97            	ld	xl,a
2306  032b 1f03          	ldw	(OFST-1,sp),x
2307                     ; 422 		tempL = ADC->DRL;
2309  032d c65405        	ld	a,21509
2310  0330 5f            	clrw	x
2311  0331 97            	ld	xl,a
2312  0332 1f01          	ldw	(OFST-3,sp),x
2313  0334 1e03          	ldw	x,(OFST-1,sp)
2314  0336               L3411:
2315                     ; 425 	ConversionValue = (u16)(tempL | (u16)(tempH << (u8)8));
2317  0336 7b02          	ld	a,(OFST-2,sp)
2318  0338 01            	rrwa	x,a
2319  0339 1a01          	or	a,(OFST-3,sp)
2320  033b 01            	rrwa	x,a
2321                     ; 426   return ((u16)ConversionValue);
2325  033c 5b04          	addw	sp,#4
2326  033e 87            	retf	
2366                     ; 430 u16 ADC_GetValue(u8 ADC_Channel)
2366                     ; 431  {
2367                     	switch	.text
2368  033f               f_ADC_GetValue:
2370  033f 88            	push	a
2371  0340 5204          	subw	sp,#4
2372       00000004      OFST:	set	4
2375                     ; 437 	ADCerrorCnt = 0;
2377  0342 725f0000      	clr	_ADCerrorCnt
2378                     ; 438 	ADC->CSR &= 0x7f;		//clear EOC flag
2380  0346 721f5400      	bres	21504,#7
2381                     ; 439 	ADC->CSR = (ADC->CSR & 0x80) | ADC_Channel;  //start A/D convertion
2383  034a c65400        	ld	a,21504
2384  034d a480          	and	a,#128
2385  034f 1a05          	or	a,(OFST+1,sp)
2386  0351 c75400        	ld	21504,a
2387                     ; 440 	ADC->CR1 |= 1;			//power on ADC
2389  0354 72105401      	bset	21505,#0
2390                     ; 441 	ADC->CR1 |= 1;			//start convertion
2392  0358 72105401      	bset	21505,#0
2394  035c 200b          	jra	L5611
2395  035e               L3611:
2396                     ; 444 		if (ADCerrorCnt) 
2398  035e c60000        	ld	a,_ADCerrorCnt
2399  0361 2706          	jreq	L5611
2400                     ; 446 			ADC_init();
2402  0363 8d740274      	callf	f_ADC_init
2404                     ; 447 			return;
2406  0367 2020          	jra	L032
2407  0369               L5611:
2408                     ; 442 	while(!(ADC->CSR & 0x80))	
2410  0369 720f5400f0    	btjf	21504,#7,L3611
2411                     ; 450 	temp = ADC->DRH;
2413  036e c65404        	ld	a,21508
2414  0371 5f            	clrw	x
2415  0372 97            	ld	xl,a
2416  0373 1f03          	ldw	(OFST-1,sp),x
2417                     ; 451 	temp <<= 2;
2419  0375 0804          	sll	(OFST+0,sp)
2420  0377 0903          	rlc	(OFST-1,sp)
2421  0379 0804          	sll	(OFST+0,sp)
2422  037b 0903          	rlc	(OFST-1,sp)
2423                     ; 452 	temp += ADC->DRL;
2425  037d c65405        	ld	a,21509
2426  0380 5f            	clrw	x
2427  0381 97            	ld	xl,a
2428  0382 1f01          	ldw	(OFST-3,sp),x
2429  0384 1e03          	ldw	x,(OFST-1,sp)
2430  0386 72fb01        	addw	x,(OFST-3,sp)
2431                     ; 453 	return temp;
2434  0389               L032:
2436  0389 5b05          	addw	sp,#5
2437  038b 87            	retf	
2489                     ; 473 FlagStatus ADC_GetFlagStatus(void)
2489                     ; 474 {
2490                     	switch	.text
2491  038c               f_ADC_GetFlagStatus:
2493  038c 88            	push	a
2494       00000001      OFST:	set	1
2497                     ; 476   u8 flagstatus = 0;
2499  038d 0f01          	clr	(OFST+0,sp)
2500                     ; 479   flagstatus |= (u8)(ADC->CSR & ADC_CSR_EOC);
2502  038f c65400        	ld	a,21504
2503  0392 a480          	and	a,#128
2504  0394 1a01          	or	a,(OFST+0,sp)
2505                     ; 481   return ((FlagStatus)flagstatus);
2509  0396 5b01          	addw	sp,#1
2510  0398 87            	retf	
2542                     ; 501 ITStatus ADC_GetITStatus(void)
2542                     ; 502 {
2543                     	switch	.text
2544  0399               f_ADC_GetITStatus:
2546  0399 88            	push	a
2547       00000001      OFST:	set	1
2550                     ; 504   u8 itstatus = 0;
2552  039a 0f01          	clr	(OFST+0,sp)
2553                     ; 506   itstatus |= (u8)(ADC->CSR & ADC_CSR_ITEN);
2555  039c c65400        	ld	a,21504
2556  039f a420          	and	a,#32
2557  03a1 1a01          	or	a,(OFST+0,sp)
2558                     ; 508   return ((ITStatus)itstatus);
2562  03a3 5b01          	addw	sp,#1
2563  03a5 87            	retf	
2609                     ; 531 void ADC_ExternalTriggerConfig(ADC_ExtTrig_TypeDef ADC_ExtTrigger, FunctionalState ADC_ExtTrigState)
2609                     ; 532 {
2610                     	switch	.text
2611  03a6               f_ADC_ExternalTriggerConfig:
2613  03a6 89            	pushw	x
2614       00000000      OFST:	set	0
2617                     ; 535   assert_param(IS_ADC_EXTTRIG_OK(ADC_ExtTrigger));
2619  03a7 9e            	ld	a,xh
2620  03a8 4d            	tnz	a
2621  03a9 2711          	jreq	L442
2622  03ab 9e            	ld	a,xh
2623  03ac a110          	cp	a,#16
2624  03ae 270c          	jreq	L442
2625  03b0 ae0217        	ldw	x,#535
2626  03b3 89            	pushw	x
2627  03b4 ae0000        	ldw	x,#L774
2628  03b7 8d000000      	callf	f_assert_failed
2630  03bb 85            	popw	x
2631  03bc               L442:
2632                     ; 536   assert_param(IS_FUNCTIONALSTATE_OK(ADC_ExtTrigState));
2634  03bc 7b02          	ld	a,(OFST+2,sp)
2635  03be 4a            	dec	a
2636  03bf 2710          	jreq	L452
2637  03c1 7b02          	ld	a,(OFST+2,sp)
2638  03c3 270c          	jreq	L452
2639  03c5 ae0218        	ldw	x,#536
2640  03c8 89            	pushw	x
2641  03c9 ae0000        	ldw	x,#L774
2642  03cc 8d000000      	callf	f_assert_failed
2644  03d0 85            	popw	x
2645  03d1               L452:
2646                     ; 538   if (ADC_ExtTrigState != DISABLE)
2648  03d1 7b02          	ld	a,(OFST+2,sp)
2649  03d3 2706          	jreq	L5521
2650                     ; 541     ADC->CR2 |= (u8)(ADC_CR2_EXTTRIG);
2652  03d5 721c5402      	bset	21506,#6
2654  03d9 2004          	jra	L7521
2655  03db               L5521:
2656                     ; 546     ADC->CR2 &= (u8)(~ADC_CR2_EXTTRIG);
2658  03db 721d5402      	bres	21506,#6
2659  03df               L7521:
2660                     ; 550   ADC->CR2 &= (u8)(~ADC_CR2_EXTSEL);
2662  03df c65402        	ld	a,21506
2663  03e2 a4cf          	and	a,#207
2664  03e4 c75402        	ld	21506,a
2665                     ; 552   ADC->CR2 |= (u8)(ADC_ExtTrigger);
2667  03e7 c65402        	ld	a,21506
2668  03ea 1a01          	or	a,(OFST+1,sp)
2669  03ec c75402        	ld	21506,a
2670                     ; 554 }
2673  03ef 85            	popw	x
2674  03f0 87            	retf	
2722                     ; 574 void ADC_SchmittTriggerConfig(ADC_SchmittTrigg_TypeDef ADC_SchmittTriggerChannel, FunctionalState ADC_SchmittTriggerState)
2722                     ; 575 {
2723                     	switch	.text
2724  03f1               f_ADC_SchmittTriggerConfig:
2726  03f1 89            	pushw	x
2727       00000000      OFST:	set	0
2730                     ; 578   assert_param(IS_ADC_SCHMITTTRIG_OK(ADC_SchmittTriggerChannel));
2732  03f2 9e            	ld	a,xh
2733  03f3 4d            	tnz	a
2734  03f4 275b          	jreq	L662
2735  03f6 9e            	ld	a,xh
2736  03f7 4a            	dec	a
2737  03f8 2757          	jreq	L662
2738  03fa 9e            	ld	a,xh
2739  03fb a102          	cp	a,#2
2740  03fd 2752          	jreq	L662
2741  03ff 9e            	ld	a,xh
2742  0400 a103          	cp	a,#3
2743  0402 274d          	jreq	L662
2744  0404 9e            	ld	a,xh
2745  0405 a104          	cp	a,#4
2746  0407 2748          	jreq	L662
2747  0409 9e            	ld	a,xh
2748  040a a105          	cp	a,#5
2749  040c 2743          	jreq	L662
2750  040e 9e            	ld	a,xh
2751  040f a106          	cp	a,#6
2752  0411 273e          	jreq	L662
2753  0413 9e            	ld	a,xh
2754  0414 a107          	cp	a,#7
2755  0416 2739          	jreq	L662
2756  0418 9e            	ld	a,xh
2757  0419 a108          	cp	a,#8
2758  041b 2734          	jreq	L662
2759  041d 9e            	ld	a,xh
2760  041e a109          	cp	a,#9
2761  0420 272f          	jreq	L662
2762  0422 9e            	ld	a,xh
2763  0423 a10a          	cp	a,#10
2764  0425 272a          	jreq	L662
2765  0427 9e            	ld	a,xh
2766  0428 a10b          	cp	a,#11
2767  042a 2725          	jreq	L662
2768  042c 9e            	ld	a,xh
2769  042d a10c          	cp	a,#12
2770  042f 2720          	jreq	L662
2771  0431 9e            	ld	a,xh
2772  0432 a10d          	cp	a,#13
2773  0434 271b          	jreq	L662
2774  0436 9e            	ld	a,xh
2775  0437 a10e          	cp	a,#14
2776  0439 2716          	jreq	L662
2777  043b 9e            	ld	a,xh
2778  043c a10f          	cp	a,#15
2779  043e 2711          	jreq	L662
2780  0440 9e            	ld	a,xh
2781  0441 a11f          	cp	a,#31
2782  0443 270c          	jreq	L662
2783  0445 ae0242        	ldw	x,#578
2784  0448 89            	pushw	x
2785  0449 ae0000        	ldw	x,#L774
2786  044c 8d000000      	callf	f_assert_failed
2788  0450 85            	popw	x
2789  0451               L662:
2790                     ; 579   assert_param(IS_FUNCTIONALSTATE_OK(ADC_SchmittTriggerState));
2792  0451 7b02          	ld	a,(OFST+2,sp)
2793  0453 4a            	dec	a
2794  0454 2710          	jreq	L672
2795  0456 7b02          	ld	a,(OFST+2,sp)
2796  0458 270c          	jreq	L672
2797  045a ae0243        	ldw	x,#579
2798  045d 89            	pushw	x
2799  045e ae0000        	ldw	x,#L774
2800  0461 8d000000      	callf	f_assert_failed
2802  0465 85            	popw	x
2803  0466               L672:
2804                     ; 581   if (ADC_SchmittTriggerChannel == ADC_SCHMITTTRIG_ALL)
2806  0466 7b01          	ld	a,(OFST+1,sp)
2807  0468 a11f          	cp	a,#31
2808  046a 261d          	jrne	L3031
2809                     ; 583     if (ADC_SchmittTriggerState != DISABLE)
2811  046c 7b02          	ld	a,(OFST+2,sp)
2812  046e 270a          	jreq	L5031
2813                     ; 585       ADC->TDRL &= (u8)0x0;
2815  0470 725f5407      	clr	21511
2816                     ; 586       ADC->TDRH &= (u8)0x0;
2818  0474 725f5406      	clr	21510
2820  0478 2063          	jra	L1131
2821  047a               L5031:
2822                     ; 590       ADC->TDRL |= (u8)0xFF;
2824  047a c65407        	ld	a,21511
2825  047d aaff          	or	a,#255
2826  047f c75407        	ld	21511,a
2827                     ; 591       ADC->TDRH |= (u8)0xFF;
2829  0482 c65406        	ld	a,21510
2830  0485 aaff          	or	a,#255
2831  0487 2051          	jpf	LC001
2832  0489               L3031:
2833                     ; 594   else if (ADC_SchmittTriggerChannel < ADC_SCHMITTTRIG_CHANNEL8)
2835  0489 a108          	cp	a,#8
2836  048b 0d02          	tnz	(OFST+2,sp)
2837  048d 2426          	jruge	L3131
2838                     ; 596     if (ADC_SchmittTriggerState != DISABLE)
2840  048f 2714          	jreq	L5131
2841                     ; 598       ADC->TDRL &= (u8)(~(u8)((u8)0x01 << (u8)ADC_SchmittTriggerChannel));
2843  0491 5f            	clrw	x
2844  0492 97            	ld	xl,a
2845  0493 a601          	ld	a,#1
2846  0495 5d            	tnzw	x
2847  0496 2704          	jreq	L203
2848  0498               L403:
2849  0498 48            	sll	a
2850  0499 5a            	decw	x
2851  049a 26fc          	jrne	L403
2852  049c               L203:
2853  049c 43            	cpl	a
2854  049d c45407        	and	a,21511
2855  04a0               LC002:
2856  04a0 c75407        	ld	21511,a
2858  04a3 2038          	jra	L1131
2859  04a5               L5131:
2860                     ; 602       ADC->TDRL |= (u8)((u8)0x01 << (u8)ADC_SchmittTriggerChannel);
2862  04a5 5f            	clrw	x
2863  04a6 97            	ld	xl,a
2864  04a7 a601          	ld	a,#1
2865  04a9 5d            	tnzw	x
2866  04aa 2704          	jreq	L603
2867  04ac               L013:
2868  04ac 48            	sll	a
2869  04ad 5a            	decw	x
2870  04ae 26fc          	jrne	L013
2871  04b0               L603:
2872  04b0 ca5407        	or	a,21511
2873  04b3 20eb          	jpf	LC002
2874  04b5               L3131:
2875                     ; 607     if (ADC_SchmittTriggerState != DISABLE)
2877  04b5 2713          	jreq	L3231
2878                     ; 609       ADC->TDRH &= (u8)(~(u8)((u8)0x01 << ((u8)ADC_SchmittTriggerChannel - (u8)8)));
2880  04b7 a008          	sub	a,#8
2881  04b9 5f            	clrw	x
2882  04ba 97            	ld	xl,a
2883  04bb a601          	ld	a,#1
2884  04bd 5d            	tnzw	x
2885  04be 2704          	jreq	L213
2886  04c0               L413:
2887  04c0 48            	sll	a
2888  04c1 5a            	decw	x
2889  04c2 26fc          	jrne	L413
2890  04c4               L213:
2891  04c4 43            	cpl	a
2892  04c5 c45406        	and	a,21510
2894  04c8 2010          	jpf	LC001
2895  04ca               L3231:
2896                     ; 613       ADC->TDRH |= (u8)((u8)0x01 << ((u8)ADC_SchmittTriggerChannel - (u8)8));
2898  04ca a008          	sub	a,#8
2899  04cc 5f            	clrw	x
2900  04cd 97            	ld	xl,a
2901  04ce a601          	ld	a,#1
2902  04d0 5d            	tnzw	x
2903  04d1 2704          	jreq	L613
2904  04d3               L023:
2905  04d3 48            	sll	a
2906  04d4 5a            	decw	x
2907  04d5 26fc          	jrne	L023
2908  04d7               L613:
2909  04d7 ca5406        	or	a,21510
2910  04da               LC001:
2911  04da c75406        	ld	21510,a
2912  04dd               L1131:
2913                     ; 617 }
2916  04dd 85            	popw	x
2917  04de 87            	retf	
2929                     	xref	_adRstIndex
2930                     	xref	_adChIndex
2931                     	xref	_ADCerrorCnt
2932                     	xdef	f_ADC_init
2933                     	xdef	f_ADC_GetValue
2934                     	xdef	f_ADC_StructInit
2935                     	xdef	f_ADC_StartConversion
2936                     	xdef	f_ADC_SchmittTriggerConfig
2937                     	xdef	f_ADC_PrescalerConfig
2938                     	xdef	f_ADC_ITCmd
2939                     	xdef	f_ADC_Init
2940                     	xdef	f_ADC_GetITStatus
2941                     	xdef	f_ADC_GetFlagStatus
2942                     	xdef	f_ADC_GetConversionValue
2943                     	xdef	f_ADC_ExternalTriggerConfig
2944                     	xdef	f_ADC_DeInit
2945                     	xdef	f_ADC_ConversionConfig
2946                     	xdef	f_ADC_Cmd
2947                     	xdef	f_ADC_ClearFlag
2948                     	xref	f_assert_failed
2949                     .const:	section	.text
2950  0000               L774:
2951  0000 736f75636573  	dc.b	"souces\src\stm8_ad"
2952  0012 632e6300      	dc.b	"c.c",0
2972                     	end
