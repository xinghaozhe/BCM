   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
 776                     .const:	section	.text
 777  0000               __vectab:
 778  0000 82            	dc.b	130
 780  0001 00            	dc.b	page(f__stext)
 781  0002 0000          	dc.w	f__stext
 782  0004 82            	dc.b	130
 784  0005 00            	dc.b	page(f_NonHandledInterrupt)
 785  0006 0000          	dc.w	f_NonHandledInterrupt
 786  0008 82            	dc.b	130
 788  0009 00            	dc.b	page(f_NonHandledInterrupt)
 789  000a 0000          	dc.w	f_NonHandledInterrupt
 790  000c 82            	dc.b	130
 792  000d 00            	dc.b	page(f_AWU_IRQHandler)
 793  000e 0000          	dc.w	f_AWU_IRQHandler
 794  0010 82            	dc.b	130
 796  0011 00            	dc.b	page(f_NonHandledInterrupt)
 797  0012 0000          	dc.w	f_NonHandledInterrupt
 798  0014 82            	dc.b	130
 800  0015 00            	dc.b	page(f_NonHandledInterrupt)
 801  0016 0000          	dc.w	f_NonHandledInterrupt
 802  0018 82            	dc.b	130
 804  0019 00            	dc.b	page(f_NonHandledInterrupt)
 805  001a 0000          	dc.w	f_NonHandledInterrupt
 806  001c 82            	dc.b	130
 808  001d 00            	dc.b	page(f_NonHandledInterrupt)
 809  001e 0000          	dc.w	f_NonHandledInterrupt
 810  0020 82            	dc.b	130
 812  0021 00            	dc.b	page(f_EXTI_PORTD_IRQHandler)
 813  0022 0000          	dc.w	f_EXTI_PORTD_IRQHandler
 814  0024 82            	dc.b	130
 816  0025 00            	dc.b	page(f_NonHandledInterrupt)
 817  0026 0000          	dc.w	f_NonHandledInterrupt
 818  0028 82            	dc.b	130
 820  0029 00            	dc.b	page(f_CAN_RX_IRQHandler)
 821  002a 0000          	dc.w	f_CAN_RX_IRQHandler
 822  002c 82            	dc.b	130
 824  002d 00            	dc.b	page(f_CAN_TX_IRQHandler)
 825  002e 0000          	dc.w	f_CAN_TX_IRQHandler
 826  0030 82            	dc.b	130
 828  0031 00            	dc.b	page(f_NonHandledInterrupt)
 829  0032 0000          	dc.w	f_NonHandledInterrupt
 830  0034 82            	dc.b	130
 832  0035 00            	dc.b	page(f_NonHandledInterrupt)
 833  0036 0000          	dc.w	f_NonHandledInterrupt
 834  0038 82            	dc.b	130
 836  0039 00            	dc.b	page(f_NonHandledInterrupt)
 837  003a 0000          	dc.w	f_NonHandledInterrupt
 838  003c 82            	dc.b	130
 840  003d 00            	dc.b	page(f_TIM2_UPD_OVF_BRK_IRQHandler)
 841  003e 0000          	dc.w	f_TIM2_UPD_OVF_BRK_IRQHandler
 842  0040 82            	dc.b	130
 844  0041 00            	dc.b	page(f_TIM2_CAP_COM_IRQHandler)
 845  0042 0000          	dc.w	f_TIM2_CAP_COM_IRQHandler
 846  0044 82            	dc.b	130
 848  0045 00            	dc.b	page(f_TIM3_UPD_OVF_BRK_IRQHandler)
 849  0046 0000          	dc.w	f_TIM3_UPD_OVF_BRK_IRQHandler
 850  0048 82            	dc.b	130
 852  0049 00            	dc.b	page(f_TIM3_CAP_COM_IRQHandler)
 853  004a 0000          	dc.w	f_TIM3_CAP_COM_IRQHandler
 854  004c 82            	dc.b	130
 856  004d 00            	dc.b	page(f_LINUART_TX_IRQHandler)
 857  004e 0000          	dc.w	f_LINUART_TX_IRQHandler
 858  0050 82            	dc.b	130
 860  0051 00            	dc.b	page(f_LINUART_RX_IRQHandler)
 861  0052 0000          	dc.w	f_LINUART_RX_IRQHandler
 862  0054 82            	dc.b	130
 864  0055 00            	dc.b	page(f_NonHandledInterrupt)
 865  0056 0000          	dc.w	f_NonHandledInterrupt
 866  0058 82            	dc.b	130
 868  0059 00            	dc.b	page(f_NonHandledInterrupt)
 869  005a 0000          	dc.w	f_NonHandledInterrupt
 870  005c 82            	dc.b	130
 872  005d 00            	dc.b	page(f_NonHandledInterrupt)
 873  005e 0000          	dc.w	f_NonHandledInterrupt
 874  0060 82            	dc.b	130
 876  0061 00            	dc.b	page(f_NonHandledInterrupt)
 877  0062 0000          	dc.w	f_NonHandledInterrupt
 878  0064 82            	dc.b	130
 880  0065 00            	dc.b	page(f_TIM4_UPD_OVF_IRQHandler)
 881  0066 0000          	dc.w	f_TIM4_UPD_OVF_IRQHandler
 882  0068 82            	dc.b	130
 884  0069 00            	dc.b	page(f_NonHandledInterrupt)
 885  006a 0000          	dc.w	f_NonHandledInterrupt
 886  006c 82            	dc.b	130
 888  006d 00            	dc.b	page(f_NonHandledInterrupt)
 889  006e 0000          	dc.w	f_NonHandledInterrupt
 890  0070 82            	dc.b	130
 892  0071 00            	dc.b	page(f_NonHandledInterrupt)
 893  0072 0000          	dc.w	f_NonHandledInterrupt
 894  0074 82            	dc.b	130
 896  0075 00            	dc.b	page(f_NonHandledInterrupt)
 897  0076 0000          	dc.w	f_NonHandledInterrupt
 898  0078 82            	dc.b	130
 900  0079 00            	dc.b	page(f_NonHandledInterrupt)
 901  007a 0000          	dc.w	f_NonHandledInterrupt
 902  007c 82            	dc.b	130
 904  007d 00            	dc.b	page(f_NonHandledInterrupt)
 905  007e 0000          	dc.w	f_NonHandledInterrupt
 965                     	xdef	__vectab
 966                     	xref	f__stext
 967                     	xref	f_AWU_IRQHandler
 968                     	xref	f_EXTI_PORTD_IRQHandler
 969                     	xref	f_CAN_RX_IRQHandler
 970                     	xref	f_CAN_TX_IRQHandler
 971                     	xref	f_TIM2_UPD_OVF_BRK_IRQHandler
 972                     	xref	f_TIM2_CAP_COM_IRQHandler
 973                     	xref	f_TIM3_UPD_OVF_BRK_IRQHandler
 974                     	xref	f_TIM3_CAP_COM_IRQHandler
 975                     	xref	f_LINUART_TX_IRQHandler
 976                     	xref	f_LINUART_RX_IRQHandler
 977                     	xref	f_TIM4_UPD_OVF_IRQHandler
 978                     	xref	f_NonHandledInterrupt
 997                     	end
