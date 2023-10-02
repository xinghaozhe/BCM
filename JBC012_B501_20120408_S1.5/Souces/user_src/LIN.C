/*******************************************************************************
| File Name    : st79_LIN.c
| Description  : This file contains all LIN functions.
| Group        : APG/Car Body Division/Microcontroller & Car Networking
|===============================================================================
|                C O P Y R I G H T
|===============================================================================
| (C) COPYRIGHT 2007 STMicroelectronics
| THE SOFTWARE INCLUDED IN THIS FILE IS FOR GUIDANCE ONLY. ST MICROELECTRONICS
| SHALL NOT BE HELD LIABLE FOR ANY DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES
| WITH RESPECT TO ANY CLAIMS ARISING FROM USE OF THIS SOFTWARE.
|===============================================================================
|                A U T H O R    I D E N T I T Y
|===============================================================================
| Initials   Name                          Company
| --------   ----------------------------  -------------------------------------
| CA         Claude ANGUILLE               STMicroelectronics
|===============================================================================
|                R E V I S I O N    H I S T O R Y
|===============================================================================
| Date         Ver   Author  Description
| -----------  ----  ------  ---------------------------------------------------
| 9-Mar-2008  0.1  ZJJ      Created.
*******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"
#include "lin.h"
#include "turnlamp_drv.h"
#include "lock_drv.h"
#include "rke_drv.h"
#include "beam_drv.h"
#include "defrost_drv.h"
#include "warm_drv.h"
#include "gpio_macro.h"
#include "stm8_linuart.h"
#include "can.h"
void HORNFJwarm(void);

extern void Clear_WDT(void); 

uchar  LIN_StateFlag ;
uchar  LIN_IDFlag ;
uchar  LIN_IDProperty;

uchar  LIN_OUT_TIME_FLAG;
uchar  LIN_RECIVE_DataLength =0;
uchar  RxBufIndex = 0;
uchar  TxBufIndex = 0;

uchar  LINsendLen;

uchar LinRcBuffer[8],LinTxBuffer[8];

u16  LostCommunication[7];  

uchar FJwarmstate;

uint FJwarmTime;

void LIN_LinRcBuffer_init(void);
void LIN_SCISendBreak(void);
void LIN_Init(void);
void LIN_LinRcBuffer_init(void);
void LIN_BCM1_init(void);
void LIN_BCM2_init(void);
void LIN_DDCU_init(void);
void LIN_PDCU_init(void);
void LIN_RLDCU_init(void);
void LIN_RRDCU_init(void);
void LIN_RAINS_init(void);
void LIN_FrameInit(void);
void LIN_SCISendSYNField(void);
void LIN_SCISendHeader(void);
void LIN_SCISendData(void);
void LIN_SCIReciveData(void);
void LIN_SCIOFF(void);


LINUART_Init_TypeDef LINcfg; 

struct BCM_LIN_FRAME1  LIN_BCM_FRAME1;
struct BCM_LIN_FRAME2  LIN_BCM_FRAME2;
struct DDCU_LIN_FRAME  LIN_DDCU_FRAME;
struct PDCU_LIN_FRAME  LIN_PDCU_FRAME;
struct RLDCU_LIN_FRAME LIN_RLDCU_FRAME;
struct RRDCU_LIN_FRAME LIN_RRDCU_FRAME;
struct RAINS_LIN_FRAME LIN_RAINS_FRAME;


void LIN_Init(void)
{
    LINUART_StructInit(&LINcfg);
    LINUART_Init(&LINcfg);
    LINUART_LINCmd(ENABLE);
    LINUART_LINConfig(LINUART_LIN_MASTER_MODE,LINUART_LIN_AUTOSYNC_DISABLE,LINUART_LIN_DIVUP_NEXTRXNE);
    LINUART_LINBreakDetectionConfig(LINUART_BREAK11BITS);  
	LIN_ENABLE;
}

void LIN_LinRcBuffer_init(void)
{
    uchar  i;
    
    for(i=0;i<8;i++)
    LinRcBuffer[i] = 0x00;
}

void LIN_BCM1_init(void)
{
    /*BYTE0 Initialize */

    LIN1_BCM_WindowEnable = Windowdisable;   
   
    if( (VehicleType & 0xf0) == CV8 )
    {
        LIN1_BCM_VehicleModel = VehicleModel_CV8;//VehicleModel_CV8; //V101
    }
    else if((VehicleType & 0xf0) == CV101)
    {
        //LIN1_BCM_VehicleModel = VehicleModel_CV101; //V101
    }
    
    /*BYTE1 Initialize*/
       	
    /*BYTE2 Initialize*/
      
    /*BYTE3 Initialize*/
    //LIN1_BCM_GlobleClose = RF_Window_close_off;
    //LIN1_BCM_IGN =  BCM_IGN_OFF;
    //LIN1_BCM_GlobleOpen = RF_Window_Open_off;    
}

void LIN_BCM2_init(void)
{
    /*BYTE0 Initialize */
    LIN2_BCM_WiperSwitchPosition = WiperSwitchPosition_OFF;
    
    /*BYTE1 Initialize*/
    LIN2_BCM_SensitivitySetting = BCM_SensitivitySetting_1D;  
    
    /*BYTE2 Initialize*/ 
    LIN2_BCM_AmbientTemperature = BCM_AmbientTemperature_Default;
    /*BYTE3 Initialize*/    
}



void LIN_DDCU_init(void)
{  
    /*BYTE0 Initialize */
    LIN_DDCU_BYTE0 = 0x00;
    /*BYTE1 Initialize */
    LIN_DDCU_BYTE1= 0x00;
}

void LIN_PDCU_init(void)
{  
    /*BYTE0 Initialize */
    LIN_PDCU_BYTE0 = 0x00;
    /*BYTE1 Initialize */
    LIN_PDCU_BYTE1= 0x00;
}

void LIN_RLDCU_init(void)
{
    /*BYTE0 Initialize */
    LIN_RLDCU_BYTE0 = 0x00;
    /*BYTE1 Initialize */
    LIN_RLDCU_BYTE1= 0x00;    
}
 
void LIN_RRDCU_init(void)
{
    /*BYTE0 Initialize */
    LIN_RRDCU_BYTE0 = 0x00;
    /*BYTE1 Initialize */
    LIN_RRDCU_BYTE1= 0x00;
 
}

void LIN_RAINS_init(void)
{
    /*BYTE0 Initialize */
    LIN_RAINS_BYTE0 = 0x00;
    /*BYTE1 Initialize */
    LIN_RAINS_BYTE1= 0x00;
}
  
void LIN_FrameInit(void)
{
    LIN_BCM1_init();
    LIN_BCM2_init();
    LIN_DDCU_init();
    LIN_PDCU_init();
    LIN_RLDCU_init();
    LIN_RRDCU_init();
    LIN_RAINS_init();
}


/**************************************************************************
*                       LIN_SCISendBreak																		  *
***************************************************************************/ 
void LIN_SCISendBreak(void)
{ 
    //LINUART->CR2 |= (u8)(LINUART_CR2_REN);  
    //LINUART->CR2 |= (u8)(LINUART_CR2_TEN);  
    //LINUART_ITConfig(LINUART_IT_TIEN,ENABLE);
    //LINUART_ITConfig(LINUART_IT_LBDIEN,ENABLE);
    LINUART_SendBreak();
    LINUART->CR2 |= (u8)(LINUART_CR2_TEN);
}

/**************************************************************************
*                       LIN_SCISendSYNField																		  *
***************************************************************************/ 
void LIN_SCISendSYNField(void)
{ 
    LINUART_ITConfig(LINUART_IT_TIEN,ENABLE);
    LINUART_SendData8(0x55);
}

/**************************************************************************
*                       LIN_SCISendHeader																		  *
***************************************************************************/ 
void LIN_SCISendHeader(void)
{
    (LinTxBuffer[2]);
    LINUART_ITConfig(LINUART_IT_TIEN,ENABLE);
}

/**************************************************************************
*                       LIN_SCISendData																		  *
***************************************************************************/ 
void LIN_SCISendData(void)
{ 
    LINUART_ITConfig(LINUART_IT_RIEN,DISABLE);
    LINUART_ITConfig(LINUART_IT_TIEN,ENABLE);
    //LINUART_ITConfig(LINUART_IT_TCIEN,ENABLE);
}

 void LIN_SCIReciveData(void)
{ 
    LINUART_ITConfig(LINUART_IT_TIEN,DISABLE);
    LINUART_ITConfig(LINUART_IT_RIEN,ENABLE);
}


void LIN_SCIOFF(void)
{ 
    LINUART_ITConfig(LINUART_IT_RIEN,DISABLE);
    LINUART_ITConfig(LINUART_IT_TIEN,DISABLE);  
    //LINUART->CR2 &= (u8)(~LINUART_CR2_REN);  /**< Clear the Receiver Disable bit */
    //LINUART->CR2 &= (u8)(~LINUART_CR2_TEN);  /**< Clear the Transmitter Disable bit */
}

/***************************************************************************
 * Function :   LIN_PutMsg
 *
 * Description: Find message and copy the message data to the buffer
 *
 * Notes:       API function, OPTIM
 **************************************************************************/
void LIN_PutMsg(uchar msgId)
{
    LinTxBuffer[1] = 0x55;
    //(msgId & ~0x40 | 0x80) ^ ( ((msgId << 2) ^ ((msgId << 3) & 0x80) ^ (msgId << 4) ^((msgId << 5) & 0x40)  ^ (msgId << 6) ) & 0xc0);
    LinTxBuffer[2] = msgId;
   
    switch(msgId)
    {
        case ID_BCM1 :
        {
            LIN1_BCM_VehicleModel = VehicleModel_CV8;//VehicleModel_CV8; //V101
            LinTxBuffer[3] = LIN1_BCM_BYTE0;
            LinTxBuffer[4] = LIN1_BCM_BYTE1;
            LinTxBuffer[5] = LIN1_BCM_BYTE2;
            LinTxBuffer[6] = LIN1_BCM_BYTE3;
            //sum
            LinTxBuffer[7] =ID_BCM1 + LinTxBuffer[3] + LinTxBuffer[4] + LinTxBuffer[5] + LinTxBuffer[6] ;
            LinTxBuffer[7] = ~LinTxBuffer[7] ;
            LINsendLen = LIN_BCM1_DataLength + 1 ;
            
            //LINsendLen = LIN_BCM1_DataLength  ;
            TxBufIndex = 0;
            LIN_StateFlag = LIN_SendData;
            LIN_IDFlag = ID_BCM1;
            LIN_RECIVE_DataLength = 0;
        } break;
        
        case ID_BCM2 :
        {
            LIN1_BCM_VehicleModel = VehicleModel_CV8;//VehicleModel_CV8; //V101
            LinTxBuffer[3] = LIN2_BCM_BYTE0;
            LinTxBuffer[4] = LIN2_BCM_BYTE1;
            LinTxBuffer[5] = LIN2_BCM_BYTE2;
            LinTxBuffer[6] = LIN2_BCM_BYTE3;
            //sum
            LinTxBuffer[7] =ID_BCM2+ LinTxBuffer[3] + LinTxBuffer[4] + LinTxBuffer[5] + LinTxBuffer[6] ;
            LinTxBuffer[7] = ~LinTxBuffer[7] ;
            LINsendLen = LIN_BCM1_DataLength + 1 ;
            
            //LINsendLen = LIN_BCM2_DataLength ;
            TxBufIndex = 0;
            LIN_StateFlag = LIN_SendData;
            LIN_IDFlag = ID_BCM2;
            LIN_RECIVE_DataLength = 0;

        } break;

        case ID_DDCU:
        {
            LINsendLen = LIN_DDCU_DataLength ;
            TxBufIndex = 0;
            RxBufIndex = 0;
            LIN_StateFlag = LIN_SendData;
            LIN_IDFlag = ID_DDCU;
            LIN_RECIVE_DataLength = LIN_DDCU_DataLength ;//+ 1 ;
        }break;
    
        case ID_PDCU:
        {
            LINsendLen = LIN_PDCU_DataLength ;
            TxBufIndex = 0;
            RxBufIndex = 0;
            LIN_StateFlag = LIN_SendData;
            LIN_IDFlag = ID_PDCU;
            LIN_RECIVE_DataLength = LIN_PDCU_DataLength ;//+ 1 ;
        }break;
        
        case ID_RLDCU:
        {
            LINsendLen = LIN_RLDCU_DataLength ;
            TxBufIndex = 0;
            RxBufIndex = 0;
            LIN_StateFlag = LIN_SendData;
            LIN_IDFlag = ID_RLDCU;
            LIN_RECIVE_DataLength = LIN_RLDCU_DataLength ;//+ 1 ;
        }break;
    
        case ID_RRDCU:
        {
            LINsendLen = LIN_RRDCU_DataLength ;
            TxBufIndex = 0;
            RxBufIndex = 0;
            LIN_StateFlag = LIN_SendData;
            LIN_IDFlag = ID_RRDCU;
            LIN_RECIVE_DataLength = LIN_RRDCU_DataLength ;//+ 1 ;
        }break;
        
        case ID_RAINS:
        {
            LINsendLen = LIN_RAINS_DataLength ;
            TxBufIndex = 0;
            RxBufIndex = 0;
            LIN_StateFlag = LIN_SendData;
            LIN_IDFlag = ID_RAINS;
            LIN_RECIVE_DataLength = LIN_RAINS_DataLength ;//+ 1 ;;
        }break;
        
        default:
        {
            LIN_SCIOFF();
        	RxBufIndex = 0;
            LIN_StateFlag = LIN_Idle;   
        	LIN_OUT_TIME_FLAG = 0;
        	break;
        }
    }
}

/*********************************************************************
Name    :   void LinTaskScheduler(void)
Function:   linframe_in_out
Call    :   
Call by :	None
Input   :   
Output  :   
History :   
   1>Author      :   Kevin
     Date        :   2008/05/17
     Description :   Build
*********************************************************************/
void LinTaskScheduler(void)
{
	Clear_WDT();
    //lin bus task's scheduler
    LIN_OUT_TIME_FLAG++;
    switch(LIN_OUT_TIME_FLAG)
    {
        //-----------------------------------------------------------
        //master task 1 ->send BCM1 lin frame
        case SendBCM1frame: 
        {
            if (LIN_StateFlag == LIN_Idle)
            {
                LIN_PutMsg(ID_BCM1);
                LIN_SCISendBreak();
                LIN_SCISendData();
            }        
        }break; 

        //master task 1 ->time out error
        case SendBCM1frame_timeout:
        {
            LIN_SCIOFF();
            LIN_StateFlag = LIN_Idle;        
        }break;
        
        //-----------------------------------------------------------
        //master task 2 ->send BCM2 lin frame
        case SendBCM2frame: 
        {
            LIN_PutMsg(ID_BCM2);
            LIN_SCISendBreak();
            LIN_SCISendData();
        }break; 

        //master task 2 ->time out error
        case SendBCM2frame_timeout:
        {
            LIN_SCIOFF();
            LIN_StateFlag = LIN_Idle;
        }break;

        //-----------------------------------------------------------
        //slave task 1 -> send DDCU frame
       
        case SendDDCUframe: 
        {
            if (LIN_StateFlag == LIN_Idle)
            {
                LIN_PutMsg(ID_DDCU);
                LIN_SCISendBreak();
                LIN_SCISendData();
            }
        }break;

        //slave task 1 -> time out error
        case ReceiveDDCUframe_timeout:
        {
            if ((LIN_IDFlag == ID_DDCU) && (LIN_StateFlag == LIN_ReceiveFinished))
            {
                LIN_DDCU_BYTE0 = LinRcBuffer[1];
                LIN_DDCU_BYTE1 = LinRcBuffer[2]; 
                LIN_LinRcBuffer_init();
                LostCommunication[2] = 0 ;
            }
            else if (LostCommunication[2] < 10 )
            {
                LostCommunication[2] ++ ;   //lost communication
            }

            LIN_SCIOFF();
            LIN_StateFlag = LIN_Idle;
        } break;

        //-----------------------------------------------------------
        //slave task 2 -> send PDCU lin frame
        case SendPDCUframe:
        {
            if (LIN_StateFlag == LIN_Idle)
            {
                LIN_PutMsg(ID_PDCU);
                LIN_SCISendBreak();
                LIN_SCISendData();
            } 
        }break;
        
        //slave task 2 -> time out error
        case ReceivePDCUframe_timeout:
        { 
            if ((LIN_IDFlag == ID_PDCU) && (LIN_StateFlag == LIN_ReceiveFinished))
            {
                LIN_PDCU_BYTE0 = LinRcBuffer[1];
                LIN_PDCU_BYTE1 = LinRcBuffer[2]; 
                LIN_LinRcBuffer_init();
                LostCommunication[3] = 0;
            }
            else if (LostCommunication[3] < 10 )
            {
                LostCommunication[3] ++ ;   //lost communication
            }
            
            LIN_SCIOFF();
            LIN_StateFlag = LIN_Idle;
        }break;

      //-----------------------------------------------------------
        //slave task 3 -> send RLDCU lin frame
        case SendRLDCUframe: 
        {
            if (LIN_StateFlag == LIN_Idle)
            {
                LIN_PutMsg(ID_RLDCU);
                LIN_SCISendBreak();
                LIN_SCISendData();
            }
        }break;

        //slave task 3 -> time out error
        case ReceiveRLDCUframe_timeout:
        {  
            if ((LIN_IDFlag == ID_RLDCU) && (LIN_StateFlag == LIN_ReceiveFinished))
            {
                LIN_RLDCU_BYTE0 = LinRcBuffer[1];
                LIN_RLDCU_BYTE1 = LinRcBuffer[2]; 
                LIN_LinRcBuffer_init();
                LostCommunication[4] = 0 ;
            }
            else if(LostCommunication[4] < 10 )
            {
                LostCommunication[4] ++;   //lost communication
            }
            
            LIN_SCIOFF();
            LIN_StateFlag = LIN_Idle;
        }break;

        //-----------------------------------------------------------
        //slave task 4 -> send RRDCU lin frame
        case SendRRDCUframe: 
        {
            if (LIN_StateFlag == LIN_Idle)
            {
                LIN_PutMsg(ID_RRDCU);
                LIN_SCISendBreak();
                LIN_SCISendData();
            }            
        }break;

        //slave task 4 -> time out error
        case ReceiveRRDCUframe_timeout:
        {
            if ((LIN_IDFlag == ID_RRDCU) && (LIN_StateFlag == LIN_ReceiveFinished))
            {
                LIN_RRDCU_BYTE0 = LinRcBuffer[1];
                LIN_RRDCU_BYTE1 = LinRcBuffer[2]; 
                LIN_LinRcBuffer_init();
                LostCommunication[5] = 0 ;
            }
            else  if(LostCommunication[5] < 10 )
            {
                LostCommunication[5] ++;   //lost communication
            }
            
            LIN_SCIOFF();
            LIN_StateFlag = LIN_Idle;            
        }break;

        //-----------------------------------------------------------
        //slave task 5 -> send RAIN SENSOR lin frame
     /*   case SendRAINSframe: 
        {
            if (LIN_StateFlag == LIN_Idle)
            {
                LIN_PutMsg(ID_RAINS);
                LIN_SCISendBreak();
                LIN_SCISendData();
            }            
        }break;
*/
        //slave task 5 -> time out error
        /*
        case ReceiveRAINSframe_timeout:
        {
            if ((LIN_IDFlag == ID_RAINS) && (LIN_StateFlag == LIN_ReceiveFinished))
            {
                LIN_RAINS_BYTE0 = LinRcBuffer[2];
                LIN_RAINS_BYTE1 = LinRcBuffer[1]; 
                LIN_LinRcBuffer_init();
                LostCommunication[6] = 0 ;
            }
            else  if(LostCommunication[6] < 10 )
            {
                LostCommunication[6]++ ;   //lost communication
            }
            
            LIN_SCIOFF();
            LIN_StateFlag = LIN_Idle;            
        }break;
        
        //-----------------------------------------------------------
        //all task scheduler cycle duty
        case LINFrame_Cycle_duty: 
        {
            LIN_OUT_TIME_FLAG  = 0;
            LIN_StateFlag = LIN_Idle;            
        }break;
       */ 
        //-----------------------------------------------------------
        //lin bus scheduler error manage
        default:
        {  
            if (LIN_OUT_TIME_FLAG > LINFrame_Cycle_duty)
            {
                LIN_SCIOFF();
                LIN_StateFlag = LIN_Idle;
                LIN_OUT_TIME_FLAG  = 0;
                LINWINDOWSTATE++;
            }            
        }break;
    }
}

/*********************************************************************
Name    :   void LINControlDTC(void)
Function:   LINControlDTC
Call    :   
Call by :	None
Input   :   
Output  :   
History :   
   1>Author      :   Kevin
     Date        :   2008/05/17
     Description :   Build
*********************************************************************/
void LINControlDTC(void)
{
   static uchar openwindowtime;
    

    if( (VehicleType & 0xf0) == CV8 )
    {
        //if( LIN1_BCM_GlobleClose == RF_Window_close_on )  //ÖÃ¹Ø´°±êÖ¾
        //{
        //        openwindowtime = 5;
        //}
        //if(LIN1_BCM_GlobleOpen == RF_Window_Open_on) 
        //{
        //        openwindowtime = 5;
        //}

        
        if(openwindowtime != 0)
        {
              openwindowtime--;
              if( openwindowtime == 0 )
              {
                  // LIN1_BCM_GlobleOpen = RF_Window_Open_off ;
                   //LIN1_BCM_GlobleClose = RF_Window_close_off ;
              }
        }
        // save window DTC
        //DDCU
        if( LIN_DDCU_BYTE0 == 5 )
        {
            WriteDTC(0xa310) ; //relay failure
        }
        else if( LIN_DDCU_BYTE0 == 6 )
        {
            WriteDTC(0xa311) ; //hall sensor
        }
        else if(LIN_DDCU_BYTE0 == 4 ) //·À¼Ð
        {
              FJwarmstate = 0x55 ;
        }
        else
        {
            // FJwarmstate = 0x00 ;
        }
        //DDCU Lost communation
        if(LostCommunication[2] >= 5 )
        {
            WriteDTC(0xc222) ; //lost communation
        }
       //PDCU
        if( LIN_PDCU_BYTE0 == 5 )
        {
            WriteDTC(0xa320) ;
        }
        else if(LIN_PDCU_BYTE0 == 6 )
        {
            WriteDTC(0xa321) ;
        }
        else if(LIN_PDCU_BYTE0 == 4 ) //·À¼Ð
        {
              FJwarmstate = 0x55 ;
        }
        else
        {
             //FJwarmstate = 0x00 ;
        }
        //PDCU Lost communation
        if(LostCommunication[3] >= 5  )
        {
            WriteDTC(0xc223) ; //lost communation
        }
        //RLDCU
        if(LIN_RLDCU_BYTE0 == 5 )
        {
            WriteDTC(0xa330) ;
        }
        else if(LIN_RLDCU_BYTE0 == 6 )
        {
            WriteDTC(0xa331) ;
        }
        else if(LIN_RLDCU_BYTE0 == 4 ) //·À¼Ð
        {
              FJwarmstate = 0x55 ;
        }
        else
        {
             //FJwarmstate = 0x00 ;
        }
        //RLDCU Lost communation
        if(LostCommunication[4] >= 5  )
        {
            WriteDTC(0xc224) ; //lost communation
        }
        //RRDCU
        if(LIN_RRDCU_BYTE0 == 5 )
        {
            WriteDTC(0xa340) ;
        }
        else if ( LIN_RRDCU_BYTE0 == 6 )
        {
            WriteDTC(0xa341) ;
        }
        else if(LIN_RRDCU_BYTE0 == 4 ) //·À¼Ð
        {
              FJwarmstate = 0x55 ;
        }
        else
        {
             //FJwarmstate = 0x00 ;
        }
        //RRDCU Lost communation
        if(LostCommunication[5] >= 5  )
        {
            WriteDTC(0xc225) ; //lost communation
        }
        //RAIN
        if(LIN_RAINS_BYTE0 == 7)
        {
            WriteDTC(0xa350) ;
        }
        // RAIN Lost communation
        if(LostCommunication[6] >= 5  )
        {
            WriteDTC(0xc231) ; //lost communation
        }       

        //
        //HORNFJwarm();

    } 
}
void  HORNFJwarm(void)
{
     static  uchar FJwarmcnt ;
     static  uint    ProtectTime;

     if(ProtectTime != 0)
    	{
        	ProtectTime--;
              FJwarmstate = 0 ;
     }
     if((FJwarmstate == 0x55 )&&(FJwarmTime == 0)&&(ProtectTime == 0))
     {
          FJwarmstate = 0 ;
          FJwarmTime = 500 ;
          FJwarmcnt = 0 ;
          ProtectTime= 1250 ;
     }

     if(FJwarmTime != 0 )
     {
            FJwarmTime--;
            FJwarmcnt++;
            if(FJwarmcnt <64) HORN_ON;
            else if(FJwarmcnt < 125)HORN_OFF;
            else
            {
                FJwarmcnt = 0;
            }    
            
            if(FJwarmTime == 0)
            {
                  HORN_OFF ;
                  //return 1;
            }
            
     }

   
}


void WAKElin(void)
{
    static uint WAKEtime;
    WAKEtime++;
    if(WAKEtime >= 100)
    {
       WAKEtime = 0 ;
       LIN_PutMsg(ID_BCM1);
       LIN_SCISendBreak();
       LIN_SCISendData();
       //LIN_DISENABLE;
    }

}
