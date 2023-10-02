
/**
  ******************************************************************************
  * @file   st79_it.c
  * @brief  This file contains all the interrupt routines.
  * @author STMicroelectronics - MCD Application Team
  ******************************************************************************
  * <h3>History:</h3>
  * <table border=2>
  * <tr><td>Date</td>        <td>Changes</td></tr>
  * <tr><td>23-APR-2007</td> <td>First version</td></tr>
  * </table>
  ******************************************************************************
  *
  * THE PRESENT SOFTWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2007 STMicroelectronics</center></h2>
  * <center><a href="http://mcu.st.com/mcu/">Microcontrollers Division</a></center>
  * @image html logo.bmp
  ******************************************************************************
  */

/*********************************************************************
 INCLUDE HEADER FILES
*********************************************************************/
#include "st79_it.h"
#include "main.h"
#include "adc_drv.h"
#include "rke_drv.h"
#include "gpio_macro.h"

//#include "st79_it.h"
#include "stm8_lib.h"
#include "stm8_map.h"
#include "can.h"
#include "st79_tim4.h"
//#include "Lin.h"
#include "can_nm_osek.h"
#include "udsoncan.h"
//#include "Rke_key.h"

/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
extern void LIN_SCIOFF(void);
extern void LIN_SCIReciveData(void);
extern uchar  LIN_IDFlag ;
extern uchar  LIN_StateFlag ;
uchar   bitCnt;
extern uchar WaveFilterCnt;
extern CAN_Msg_TypeDef NM_CAN_DATA[NMbuslang];
//uint zy[]
extern uchar KeyInState;
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

extern u16 ITcounter; /* Counter used to count how many external interrupts occur. */

/* Public functions ----------------------------------------------------------*/


@interrupt void NonHandledInterrupt(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  return;
}
 
/**
  * @brief TRAP interrupt routine
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
*/
@interrupt void TRAP_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  return;
}

/**
  * @brief Top Level Interrupt Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void TLI_IRQHandler (void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  return;
}

/**
  * @brief Auto Wake Up Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void AWU_IRQHandler (void)
{
    uchar wake;
		
     /* In order to detect unexpected events during development,
        it is recommended to set a breakpoint on the following instruction.
     */
     wake = AWU->CSR1;  //清出标志

     return;
}

/**
  * @brief Clock Controller Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void CLK_IRQHandler (void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  return;
}

/**
  * @brief External Interrupt PORTA Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void EXTI_PORTA_IRQHandler (void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  return;
}

/**
  * @brief External Interrupt PORTB Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void EXTI_PORTB_IRQHandler (void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  return;
}

/**
  * @brief External Interrupt PORTC Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void EXTI_PORTC_IRQHandler (void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  return;
}

/**
  * @brief External Interrupt PORTD Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void EXTI_PORTE_IRQHandler (void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  return;
}

/**
  * @brief External Interrupt PORTE Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */

uint  Tim3CntTemp;


@interrupt void EXTI_PORTD_IRQHandler(void)
{ 
	//static uint  Tim3CntTemp;
	static uchar PreambleCnt, IntStatus;
	uchar headercount[3];
	//static uint  rketimecnt1,rketimecnt2;
	uchar i,CheckSum;

	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()
	nop()

	if(IntStatus && (!RKE_DATA_IN))
		{IntStatus = RKE_DATA_IN;	return;}
	if((!IntStatus) && (RKE_DATA_IN))
		{IntStatus = RKE_DATA_IN;	return;}

	Tim3CntTemp = (TIM3->CNTRH << 8);
	Tim3CntTemp += TIM3->CNTRL;

	sjs = Tim3CntTemp;
	//Tim3CntTemp = TIM3->CNTR;	//high/low byte can't write&read together
	
   	TIM3->CNTRL = 0;
	TIM3->CNTRH = 0;
	//TIM3->CNTR = 0;	//high/low byte can't write&read together
	if(WakeState == 1)
	{
              if ((Tim3CntTemp >= 200) && (Tim3CntTemp <= 1000))
              {
             	      WaveFilterCnt++;
					  
              }
              else
              {
                      WaveFilterCnt = 0;
              }
	}
    switch (RKE_STEP)
    {
    	case RKE_Idle:
    	{

			if ((Tim3CntTemp >= 3500) && (Tim3CntTemp <= 4500) && (RKE_DATA_IN))
			{
        			RKE_STEP = RKE_RecData;

        			bitCnt = 0;

			}


			if (RKE_DATA_IN)	{FALL_EDGE_INT;	IntStatus = 0;}
			else				{RISE_EDGE_INT;	IntStatus = 1;}
	    }break;
    	
    	case RKE_RecData:
    	{
    		i=bitCnt/16;
			
    		if (RKE_DATA_IN)	
    		{
    		
   	    		 FALL_EDGE_INT;	IntStatus = 0;	//falling edge 
    		}
 			else 	 
 			{
     			    if((Tim3CntTemp > 200)&&(Tim3CntTemp< 500))
     			    {
                        RKE_FIFO_DATA[i] &= ~(1 << (bitCnt % 16));
    				}
    				else if((Tim3CntTemp > 500)&&(Tim3CntTemp < 1000))
    				{
                        RKE_FIFO_DATA[i] |= (1 << (bitCnt % 16));
    				}
					else 
					{
                        RKE_DATA_OK = 0x00;
						RKE_STEP = RKE_Idle;
						bitCnt=0;
					}
		            if (++bitCnt >= 96)
                    {

						RKE_outtime = 50;
                     	headercount[0] =(uchar)RKE_FIFO_DATA[0];
						headercount[1] =(uchar)RKE_FIFO_DATA[1];
						headercount[2] =(uchar)(RKE_FIFO_DATA[1]>>8);
						headercount[0] = headercount[0]^headercount[1];//+headercount[2];
					    headercount[0] = headercount[0]^headercount[2];
						headercount[1] =(uchar)(RKE_FIFO_DATA[0]>>8);
						if(headercount[0]==headercount[1])
                     	//if(((Header[0]+(RKE_FIFO_DATA[1]>>8)&0x00ff)==((RKE_FIFO_DATA[0]>>8)&0x00ff)))
                        {
                     	    RKE_STEP = RKE_Idle;
							//PreambleCnt = 0;
               
                            Header[0] = RKE_FIFO_DATA[0];
                            Header[1] = RKE_FIFO_DATA[1];
                            
                            A_Code[0] = RKE_FIFO_DATA[2];
                            A_Code[1] = RKE_FIFO_DATA[3];
                            
                            B_Code[0] = RKE_FIFO_DATA[4];
                            B_Code[1] = RKE_FIFO_DATA[5];
							
                     	    //RKE_STEP = RKE_Idle;
							
							
							RKE_DATA_OK = 0x55;
                     	    bitCnt=0;
                     	}
						else
						{
                            RKE_STEP = RKE_Idle;
						}
                     }
 				     RISE_EDGE_INT;	IntStatus = 1;	//rising edge
 			}


 			

    	}break;
    	

    	default :
    	{
    		RKE_RECEIVE_RESET(); 
    	}break;
    }
}

/**
  * @brief CAN RX Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
  uchar  canrextime;

@interrupt void CAN_RX_IRQHandler (void)
{
	static u8 filter_match_index, data_len = 0;
	u8 idx;
    u8 Rx_Cnt, RX_Data_Cnt;
	static unsigned char Rx_Cnt1;
	CanSavePg();  
    //if((((CAN_MIDR12 & 0xBFFF)>> 2)!= 0x050)&&(((CAN_MIDR12 & 0xBFFF)>> 2)!= 0x265)&&(((CAN_MIDR12 & 0xBFFF)>> 2)!= 0x218)&&(((CAN_MIDR12 & 0xBFFF)>> 2)!= 0x700)&&(((CAN_MIDR12 & 0xBFFF)>> 2)> 0x500))
    //{
	//	return;
	//}

/*  
    if(CAN_ESR & 0x04)
	{
        CAN_ESR &= 0xff;  
		CANHardwave_Init(1);
		//gNMCanBusOff = 2;
	}
	*/
	if (CAN_MSR & CMSR_WKUI)	/* If Wake-Up Interrupt */
	{
		CAN_MSR = CMSR_WKUI;	/* then clear this bit */
		//WakeUp();
	
	}
	if (CAN_RFR & CRFR_FOVR)
	{
		CAN_RFR |= CRFR_FOVR;		/* clear the FIFO Overrun (FOVR) bit */
	}                
	else if (CAN_RFR & CRFR_FULL)
	{
		CAN_RFR |= CRFR_FULL;		/* clear the FIFO full (FULL) bit */      
	}
	while (CAN_RFR & CRFR_FMP01)	/* Check until FMP != 0 */
	{
		CAN_FPSR = CAN_FIFO_PG;		/* Select Rx_FIFO page */
		filter_match_index = CAN_MFMI;	/* Get FMI value */
         //busoffcnt = 0;
         gNMCanBusOff = 0;   //nm
         if(WakeState == 1){WakeState = 0;}
		 
              if((((CAN_MIDR12 & 0xBFFF)>> 2) < 0x400)&&(((CAN_MIDR12 & 0xBFFF)>> 2) !=0x270))
              {
				//gLocalWakeupFlag = 1;
				//WakeUp();
				//canrextime = 250;
	        }


		 
		if((((CAN_MIDR12 & 0xBFFF)>> 2) < 0x400)&&(((CAN_MIDR12 & 0xBFFF)>> 2)!= 0x050)&&(((CAN_MIDR12 & 0xBFFF)>> 2)!= 0x265)&&(((CAN_MIDR12 & 0xBFFF)>> 2)!= 0x218))
		{
		       CAN_RFR |= CRFR_RFOM;
			return;
		}
		



		   
	        for(Rx_Cnt = 0 ; Rx_Cnt < 10 ; Rx_Cnt ++ )
	        {
	            if( Rx_Msg[Rx_Cnt].State == 0 )
	            {
					 	
	                 Rx_Msg[Rx_Cnt].stdid  =  (CAN_MIDR12 & 0xBFFF)>> 2;//Rx_Stdid[filter_match_index] ;
	                 Rx_Msg[Rx_Cnt].extid  =  CAN_MIDR34;//Rx_Extid[filter_match_index] ;
	                 Rx_Msg[Rx_Cnt].dlc    =  CAN_MDLC; //Rx_Dlc[filter_match_index] ;
	                 for(RX_Data_Cnt = 0; RX_Data_Cnt < CAN_MDLC ; RX_Data_Cnt++)
	                 {
	                     Rx_Msg[Rx_Cnt].data[RX_Data_Cnt] = CAN_MDAR[RX_Data_Cnt];//Rx_Data[filter_match_index][RX_Data_Cnt];
	                 }
	                 Rx_Msg[Rx_Cnt].State  = 1;	
	                 Rx_Flag[filter_match_index] = TRUE;

				    if((Rx_Msg[Rx_Cnt].stdid > 0x3ff)&&(Rx_Msg[Rx_Cnt].stdid < 0x500))
				    {
							RXITcnt++;
							if(RXITcnt > 4) RXITcnt = 0;
							NM_CAN_DATA[RXITcnt].id = Rx_Msg[Rx_Cnt].stdid;
							NM_CAN_DATA[RXITcnt].dlc = Rx_Msg[Rx_Cnt].dlc;
							for(RX_Data_Cnt = 0; RX_Data_Cnt < 8 ;RX_Data_Cnt++)
							{
								NM_CAN_DATA[RXITcnt].Byte[RX_Data_Cnt]=Rx_Msg[Rx_Cnt].data[RX_Data_Cnt];
							}

				    }
					else if((Rx_Msg[Rx_Cnt].stdid > 0x6ff)&&(Rx_Msg[Rx_Cnt].stdid < 0x7ff))
					{     
					         if(Rx_Msg[Rx_Cnt].dlc != 8) return;  //数据长度不为8不响应 数据不存缓存
                                            //if((Rx_Msg[Rx_Cnt].data[0] == 0)||(Rx_Msg[Rx_Cnt].data[0] > 7))return;
						  //if(UDSRITcnt >= Reclong ) UDSRITcnt = 0;
					         UDSRITcnt++;
						  if(UDSRITcnt >= Reclong)UDSRITcnt = 0;
						  
					         RecData[UDSRITcnt].AI = Rx_Msg[Rx_Cnt].stdid;
						  RecData[UDSRITcnt].PCI= Rx_Msg[Rx_Cnt].data[0];
						  
  						  for(RX_Data_Cnt = 0; RX_Data_Cnt < 7 ;RX_Data_Cnt++)
  						  {
  							  RecData[UDSRITcnt].Data[RX_Data_Cnt]=Rx_Msg[Rx_Cnt].data[RX_Data_Cnt+1];
  						  }

						 //////////cs
						 /*
						 if((RecData[UDSRITcnt].PCI & 0xf0)==0x30)
						 {
						         UDSRITcnt++;
							  if(UDSRITcnt >= Reclong)UDSRITcnt = 0;
                                                   RecData[UDSRITcnt].AI = 0x700;
							  RecData[UDSRITcnt].PCI = 0x03;
							  RecData[UDSRITcnt].Data[0] = 0x22;
							  RecData[UDSRITcnt].Data[1] = 0xf1;
							 RecData[UDSRITcnt].Data[2] = 0xf1;
							 //RecData[UDSRITcnt].Data[0] = 0x22;							 
						 }*/
						 //////////


						  
						  Rx_Msg[Rx_Cnt].stdid = 0;
						  Rx_Msg[Rx_Cnt].data[0] = 0;
						  Rx_Msg[Rx_Cnt].data[1] = 0;
						  Rx_Msg[Rx_Cnt].data[2] = 0;
						  Rx_Msg[Rx_Cnt].data[3] = 0;
						  Rx_Msg[Rx_Cnt].data[4] = 0;
						  Rx_Msg[Rx_Cnt].data[5] = 0;
						  Rx_Msg[Rx_Cnt].data[6] = 0;
						  Rx_Msg[Rx_Cnt].data[7] = 0;
						  

					}

	                 switch(Rx_Msg[Rx_Cnt].stdid)
	                 {
	                     case 0x255:gDectID_EMS_255_Flag = 1;
						 	break;
						 case 0x270:gDectID_IP_270_Flag = 1;
						 	break;
						 default:break;
					 }
					 ///////
	                 CAN_RFR |= CRFR_RFOM;		// Release mailbox       	
	                 break;           
	            }
	                  
	        }
		//}
        
	CAN_RFR |= CRFR_RFOM;		// Release mailbox       	
    }
	CanRestorePg();





}

/**
  * @brief CAN TX Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void CAN_TX_IRQHandler (void)
{
	CanSavePg();

    
    //if(Busoffstate == 1) return;
	//if((CAN_MCSR & 0x08)==0)return;
	
	//WWDG_Refresh(0x7f);

	CAN_MCSR &= 0xf7;
	
	if (CAN_MSR & CMSR_ERRI)	/* If Error Interrupt */
	{
		CAN_MSR = CMSR_ERRI;	/* then clear this bit */
		//CANHardwave_Init(1);
		Busoffstate = 2;
		cansendbusoff = 1;
		busofftimecnt=0;
	}

	if (CAN_MSR & CMSR_WKUI)	/* If Wake-Up Interrupt */
	{
		CAN_MSR = CMSR_WKUI;	/* then clear this bit */
		
		gLocalWakeupFlag = 1;
		WakeUp();
		
		
	}

	
	if(CAN_ESR & 0x04)
	{
              CAN_ESR &= 0xff;  
		//CANHardwave_Init(1);
		//gNMCanBusOff = 2;
		busofftimecnt = 0;
		Busoffstate = 2;
		cansendbusoff = 1;
		busofftimecnt=0;
	}

	


	CAN_MCSR |= MCSR_RQCP;		/* Clear status bits */

	//while((CAN_MCSR & 0x08)==0);
 
	CanRestorePg();
}

/**
  * @brief SPI Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void SPI_IRQHandler (void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  return;
}

/**
  * @brief Timer1 Update/Overflow/Trigger/Break Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void TIM1_UPD_OVF_TRG_BRK_IRQHandler (void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  return;
}

/**
  * @brief Timer1 Capture/Compare Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void TIM1_CAP_COM_IRQHandler (void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  return;
}

/**
  * @brief Timer2 Update/Overflow/Break Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void TIM2_UPD_OVF_BRK_IRQHandler (void)
{
    uchar i, tempMode, CheckSum;
    
	TIM2_Clear_IT_Flag(UIF);
}

/**
  * @brief Timer2 Capture/Compare Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void TIM2_CAP_COM_IRQHandler (void)
{

	TIM2_Clear_IT_Flag(CC3IF|CC2IF|CC1IF);
}

/**
  * @brief Timer3 Update/Overflow/Break Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void TIM3_UPD_OVF_BRK_IRQHandler (void)
{
	TIM3_Clear_IT_Flag(UIF);

	RKE_RECEIVE_RESET();

   /*
    RKE_STEP = RKE_Idle;
	TIM3_OVFINT_DISABLE;
	TIM3_OCINT_DISABLE;
    RISE_EDGE_INT;
    ENABLE_RX_INT;
    return;*/
}   

/**
  * @brief Timer3 Capture/Compare Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void TIM3_CAP_COM_IRQHandler (void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
    uchar i, tempMode, CheckSum;

    if (!(TIM3->SR1 & CC1IF))
    {
		TIM3_Clear_IT_Flag(CC3IF|CC2IF|CC1IF);
		return;
    }
    
	TIM3_Clear_IT_Flag(CC3IF|CC2IF|CC1IF);
	
    switch (RKE_STEP)
    {
    	case RKE_Idle:
    	{
    		RKE_RECEIVE_RESET();
    	}break;
    	
    	case RKE_RecData:
    	{
			TIM3_OCINT_DISABLE;
 			ENABLE_RX_INT;
 			
    		i = bitCnt / 16;
    		//turn left lamp triget
    		//GPIOA->ODR ^=  GPIO_Pin_3;
    		if (RKE_DATA_IN)	
    		{
	    		RKE_FIFO_DATA[i] |= (1 << (bitCnt % 16));
	    		FALL_EDGE_INT;	//falling edge 
    		}
 			else 	 
 			{
 				RKE_FIFO_DATA[i] &= ~(1 << (bitCnt % 16));
 				RISE_EDGE_INT;	//rising edge
 			}
 			
 			//judge received "MODE" byte
 			if (bitCnt == 7)
 			{   
 			    tempMode = (RKE_FIFO_DATA[0] & MODE_MASK);
 			    if ((tempMode != LEARN_MODE) && (tempMode != NORMAL_MODE) && (tempMode != CLOSE_WIN_MODE))
 			    {
 			        //rke received "Mode" is error
 			        RKE_RECEIVE_RESET();
 			    }
 			}
 			
			if (++bitCnt >= 80)
			{
				DISABLE_RX_INT;
				TIM3_OCINT_DISABLE;
				
				CheckSum = 0;
                for (i=0;i<10;i++)
				    CheckSum ^= *((uchar*)RKE_FIFO_DATA + i);
                if (CheckSum)
                {
                	RKE_RECEIVE_RESET();
                }
				else
				{
				    RKE_STEP = RKE_RecFinished;
				}
			}
    	}break;
    	
    	case RKE_RecFinished:
    	{
    		TIM3_OCINT_DISABLE;
        }break;
    	
    	default:
    	{
			RKE_RECEIVE_RESET();
    	}break;
    }	
}

/**
  * @brief USART TX Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void USART_TX_IRQHandler (void)
{
  
  return;
}

/**
  * @brief USART RX Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void USART_RX_IRQHandler (void)
{
  
  return;
}

/**
  * @brief I2C Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void I2C_IRQHandler (void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	
  return;
}

/**
  * @brief LINUART TX Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void LINUART_TX_IRQHandler (void)
{
     /* In order to detect unexpected events during development,
    it is recommended to set a breakpoint on the following instruction.
    */

    /* Send Data of LIN FRAME routine */
	/*
    if ((LINUART->SR) & LINUART_SR_TXE)
    {       
        if (LIN_StateFlag == LIN_SendData)
        {  
                LINUART_ITConfig(LINUART_IT_RIEN,DISABLE);
                if (TxBufIndex < LINsendLen)
                {  
                    LINUART->DR = LinTxBuffer[TxBufIndex+1];
                    TxBufIndex++;
                }
       }
    }        

    /* judge lin frame sending finished routine */
	 /*
    if ((LINUART->SR) & LINUART_SR_TC)
    {
        if ((TxBufIndex == LINsendLen) && (LIN_StateFlag == LIN_SendData))
        {  
        	if ((LIN_IDFlag == ID_BCM1) || (LIN_IDFlag == ID_BCM2))
        	{
                     LIN_SCIOFF();
                     LIN_StateFlag = LIN_Idle;
                     TxBufIndex = 0;            
        	}
              else if ((LIN_IDFlag == ID_DDCU) || (LIN_IDFlag == ID_PDCU) || (LIN_IDFlag == ID_RLDCU) || (LIN_IDFlag == ID_RRDCU) || (LIN_IDFlag == ID_RAINS))
              {
                      LIN_StateFlag = LIN_ReceiveData;
                      LIN_SCIReciveData();
                      TxBufIndex = 0;            
              }
              else
              {
                      LIN_SCIOFF();
                      LIN_StateFlag = LIN_Idle;
                      TxBufIndex = 0;            
              }
        }
    }*/
}

/**
  * @brief LINUART RX Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void LINUART_RX_IRQHandler (void)
{
    /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
    */
    //uchar utemp; 
    
    /* Receive Data of LIN FRAME routine */
	/*
    if ((LINUART->SR) & LINUART_SR_RXNE) 
     {  
         utemp = LINUART->DR;
         
         if (LIN_StateFlag == LIN_ReceiveData)                                   
         {
             if (RxBufIndex < LIN_RECIVE_DataLength)
             {   
                 LinRcBuffer[RxBufIndex] = utemp ;
                 RxBufIndex++;
             }             
             else if (RxBufIndex == LIN_RECIVE_DataLength)     
             {   
                 LinRcBuffer[RxBufIndex] = utemp ;
                 LIN_StateFlag = LIN_ReceiveFinished;
                 LIN_SCIOFF();
             }
             else
             {
                 LIN_SCIOFF();
                 LIN_StateFlag = LIN_Idle ;
                 
                 //LIN_OUT_TIME_FLAG = 0 ;
             }
         } 			 
    }

    /* Receive Data of LIN FRAME routine */
    /*if ((LINUART->SR) & LINUART_SR_RXNE) 
    { 
        if (LIN_StateFlag == LIN_ReceiveData)
        {    
            if(TxBufIndex < 2 )
            {  
                LINUART->DR = LinTxBuffer[TxBufIndex+1];
                TxBufIndex++;
            }            
            else
            {
                LIN_StateFlag = LIN_Idle;
                LIN_SCIOFF();
                TxBufIndex = 0;        
            }  
        }
    }  */
}

/**
  * @brief ADC Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void ADC_IRQHandler (void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  return;
}

/**
  * @brief Timer4 Update/Overflow Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void TIM4_UPD_OVF_IRQHandler (void)
{
	static uchar temp,temp1,temp2,tempwinad;
	//every 2 ms ,happen timer4 overflow interrupt
  	TIM4_Clear_Int_Flag();

    //check ADC convert isn't completed or convert is time out
    ADCerrorCnt++;
    //SysTimeFlag_2MS = TRUE;
    gTimeOskeBase++;
    //set main loop flag
    if (++temp1 >= 2)
    {
	    SysTimeFlag_2MS = TRUE;  	//every 8ms interrupt
	    
	    temp1 = 0;
    }
    if(++temp2 >= 4)
    {
   	     NM_Function_Main(); 
		     temp2 = 0;
	}
	
    //set main loop flag
    if (++temp >= 8)
    {
	    SysTimeFlag_8MS = TRUE;  	//every 8ms interrupt
	    temp = 0;
    }

}

/**
  * @brief Eeprom EEC Interruption routine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */
@interrupt void EEPROM_EEC_IRQHandler (void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  return;
}

/**
  * @}
  */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/



/** @addtogroup IT_Public_Functions
  * @{
  */

/**
  * @brief Dummy interrupt routine
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
*/

