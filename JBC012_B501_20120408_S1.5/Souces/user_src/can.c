/*******************************************************************************
| File Name    : st79_can.c
| Description  : This file contains all CAN functions.
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
| 10-Mar-2006  1.0   CA      Created.
*******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"
#include "can.h"
#include "turnlamp_drv.h"
#include "lock_drv.h"
#include "rke_drv.h"
//#include "beam_drv.h"
#include "defrost_drv.h"
#include "warm_drv.h"
#include "gpio_macro.h"
#include "horn_drv.h"
//#include "wiper_drv.h"
#include "main.h"
#include "window_drv.h"
#include "domelamp_drv.h"
#include "lin.h"
#include "stm8_flash.h"
#include "can_nm_osek.h"
#include "UDSonCAN.h"


//#include "hom_drv.h"
//void CANSend(void);
//NM input
unsigned char cansendstate;

unsigned char cansendbusoff;


extern uint GetADCresultAverage(uchar ADCResultIndex);
//extern void DeceCount(void);   
extern void Clear_WDT(void); 
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
u8     VehicleType                   @0x4080;   //����   ͨ��CAN���� ѧϰԿ��ʱ����
u8     VehicleTypeEnable             @0x4081;
u16    RetCode                       @0x4082;   //��ʼ����״̬
u8     SecurityAccess                @0x4084;   //״̬
u8     HornAlarmState                @0x4085;   //���ȱ���
u16    PassWord1                     @0x4086;   //BCM���� 
u16    PassWord2                     @0x4088;   //BCM���� 
u8     Configuration[5]              @0x4090;
u16    ONESstate                     @0x409b;
u32    BCMnumber                     @0x409d;
u8     Hazardecestate                @0x40a1;   //���ٱ����Ƿ����ñ�־
u8     Rearfogbutton                 @0x40a2;   //����ƿ���״̬
//u16    DTCnumber[DTCLongAdress]      @0x4150;   //���ϴ��뱣��ռ�

uint  DeceSettingValueH;//         @0x4070;  //����161-224KMS
uint  DeceSettingValueL;//         @0X4074;  //����96-161KMS





u8 DTCRetcodestate;

uchar pword1,pword2;
uchar pwordwriteenble;
uchar Speedlock_ls;
vu8 Can_Page;

vu16 Rx_Stdid[1];
vu16 Rx_Extid[1];
vu8  Rx_Dlc[1];
vu8  Rx_Data[1][8];
vu8  Rx_Flag[1];

unsigned char RXITcnt=0;
unsigned char RXREcnt=0;

vu8  CanSendData[8];   //CAN�������ݴ����

tCanMsgOject Tx_Msg;
u8 Can_Tx_State;

RCanMsgOject Rx_Msg[10];    //���ջ���

uchar sendonse;

extern uchar warmstate;
extern uchar unlockdriverstate;
u8  MasterVehSpeedFault;    //���ٶȱ�־//�Ƿ���Ч
u8  BatteryVoltage;         //��ص�ѹ  //CAN  ���ܲ�Ҫ
u8  MasterVehicleSpeed;     //����2,419 ��֪����ô��
u8  TransmissionFailureStatus;    //����ʧ�ܱ�־
uchar BreakPedalSignal; //ɲ��̤���ź�  ͨ��CAN���߻��
uchar  CAN_FORTIFY_state;  //CAN��������־
uchar  WiperINTDiag;
uchar  DTCsendstate;     //DTC send state
uchar  PIDsendstate;     //PID send state
u16  battervalue;  //��ص�ѹ����
uchar PIDbattervalue;
u16 adResultTemp1,adResultTemp2 ;
uchar TCUEMSdtccnt1,TCUEMSdtccnt2;
uchar DTCsendmode=0;
//add 20100911
uchar CANsetvalue[4];
uchar CANsetstate;
uchar CAN_Auto_state;
///////////////////////////
uchar CAN_Crash;
//Diag PID
uchar CommonPID4932[4]; //PID 4932
uchar CommonPID7100[2]; //PID 7100
uchar CommonPID7110[2]; //PID 7110
uchar CommonPID7115[2]; //PID 7115
uchar CommonPID7130[2]; //PID 7130
uchar CommonPIDA141[2]; //PID A141
uchar CommonPIDA145[2]; //PID A145
uchar CommonPIDA442[2]; //PID A442
uchar CommonPIDA445[2]; //PID A445
uchar CommonPIDA452[2]; //PID A452
uchar CommonPIDA455[2]; //PID A455
uchar CommonPIDA457[2]; //PID A457
uchar CommonPIDC111[2]; //PID C111
uchar CommonPIDC136[2]; //PID A136
uchar CommonPIDC900[2]; //PID A900
//input/output PID
uchar InOutPutPID0200[1];   //pid0200
uchar InOutPutPID0202[1];   //pid0202
uchar InOutPutPIDd102[1];   //pid0102
uchar InOutPutPIDe114[1];   //pide114
//PACK PID
uchar PACKPIDa442[2];       //pida442
uchar PACKPIDe200[4];       //pide200
uchar PACKPIDe217[4];       //pide217
uchar PACKPIDe219[2];       //pida442
uchar PACKPIDe21a[4];       //pida442

uchar salfmode;   //��ȫģʽ״̬ Ϊ1Ϊ��������TEST����   2���������

unsigned char CANBusoffcnt;
unsigned char CANBusOFF;
unsigned char CANBusOFFcnt;


///////
unsigned char gNMMsgTransitFlag  ;//@0X4500;
unsigned char gLocalWakeupFlag;
unsigned char gRemoteWakeupFlag;

unsigned short gTimeOskeBase;
unsigned char gNMCANBatFlag;
unsigned char gNMCanBusOff;
unsigned char gDectID_EMS_255_Flag;
unsigned char gDectID_IP_270_Flag;
//NM output
unsigned char gNMHasSleeped;
unsigned char gCanNormalMsgActive;
unsigned char gNodeMiss_EMS_255;
unsigned char gNodeMiss_IP_270;

NM_NetWorkStatus_TypeDef gNetWorkStatus;
CAN_Msg_TypeDef NM_CAN_DATA[NMbuslang];

////////
//uchar reknumbercnt;
//uchar LOWBeamDriverState;   //���������״̬
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/*******************************************************************************
* Function Name : CAN_Init
* Description   : This routine configures the CAN cell and active it.
* Input         : CAN_MasterCtrlReg (options of the CAN controller)
				  - CMCR_ABOM: Automatic bus-off management -> left
				  automatically by HW once 128 x 11 recessive bits,
				  - CMCR_AWUM: Automatic Wake-up mode,
				  - CMCR_NART: No Automatic Retransmission,
				  - CMCR_RFLM: Discard last message when FIFO full,
				  - CMCR_TXFP: Transmit order by FIFO -> Priority by the
				  request order or identifier of the message.
* Output        : .
* Return        : .
*******************************************************************************/  
unsigned char Busoffstate;
unsigned int busoffcnt;
unsigned int busofftimecnt=0;

void BUSoff(void)
{
   

   //if(Busoffstate == 0){ busoffcnt = 0 ;busofftimecnt = 0;}
   
   if(Busoffstate == 1)
   {
              Busoffstate = 0;
		CAN_Init(CMCR_AWUM);
		CAN_EnableDiagMode(CDGR_RX);		//  | CDGR_SILM TEST MODE
		CanCanInterruptRestore();

   }
   else if(Busoffstate == 2)
   {
        
		if(busoffcnt < 8)
		{

			 if(busofftimecnt > 30) {busoffcnt++;return;}
			 if(busofftimecnt < 24)busofftimecnt++;
			 else
			 {
                              busoffcnt++;
				  busofftimecnt = 0;
				  Busoffstate = 0;
				  CAN_Init(CMCR_AWUM);
			   	  CAN_EnableDiagMode(CDGR_RX);		//  | CDGR_SILM TEST MODE
				  CanCanInterruptRestore();
	
				  
			 }
		}
		else
		{
			 if(busofftimecnt < 500)busofftimecnt++;
			 else
			 {
                  //busoffcnt++;
				  busofftimecnt = 0;
				  Busoffstate = 0;
				  CAN_Init(CMCR_AWUM);
			   	  CAN_EnableDiagMode(CDGR_RX);		//  | CDGR_SILM TEST MODE
				  CanCanInterruptRestore();

				  
			 }
		}
			

		
   }
   else
   {

       Busoffstate = 0;
   }



}





unsigned char CANHardwave_Init(u8 gCANHardwareState)
{

	switch(gCANHardwareState)
	{
         case  1:
			//CAN_Init(CMCR_ABOM | CMCR_AWUM);
			CAN_Init(CMCR_AWUM);
			CAN_EnableDiagMode(CDGR_RX);		//  | CDGR_SILM TEST MODE
			CanCanInterruptRestore();
	        //WakeUp();
	        LIN_ENABLE;
			
            return 1;
			break;
		 case  2:
            //CAN_MCR |= CMCR_INRQ;				/// Leave the Init mode /
            //while ( (CAN_MSR & ~CMSR_INAK) );	///Wait until acknowledged /      
			CAN_MCR |=CMCR_SLEEP|CMCR_AWUM;
			
            //WakeState = 1;        //��˯�߱�־
			LIN_DISENABLE;
			
			return 1;
			//break;
		 case  4:
		 	//if()
            WakeUp();
            CAN_WakeUp();
			//CAN_MCR &= ~CMCR_INRQ;				/* Leave the Init mode */
            //while ( (CAN_MSR & CMSR_INAK) );
            //gRemoteWakeupFlag = 1;
			
			//WakeState = 0;
			return 1;
			//break;
		 case  8:
		 	
            //WakeUp();
			return 1;
			//break;
		 default:
		 	break;
	}

}

unsigned char CanSendMsg(CAN_Msg_TypeDef NM_Msg)
{ 
     //if(gCanNormalMsgActive == 0 ) return 3;
	 CAN_send2(NM_Msg.id,NM_Msg.dlc,NM_Msg.Byte[0],NM_Msg.Byte[1],NM_Msg.Byte[2],NM_Msg.Byte[3],NM_Msg.Byte[4],NM_Msg.Byte[5],NM_Msg.Byte[6],NM_Msg.Byte[7]);
     //if(gNMCanBusOff)return 2;
	 //else if(gNMCANBatFlag)return 0;
	 return 1;
}


CAN_Msg_TypeDef  NM_RecMsgSave(void)
{
     unsigned char CNT,i;
	 CAN_Msg_TypeDef Rcan;

	  
	 
	 Rcan.id  = 0;
	 if(RXREcnt != RXITcnt)
	 	{

				RXREcnt++;
			      if(RXREcnt > 4) RXREcnt = 0;
		              Rcan.id = NM_CAN_DATA[RXREcnt].id;
					  NM_CAN_DATA[RXREcnt].id = 0;
					  Rcan.dlc = NM_CAN_DATA[RXREcnt].dlc;
					  for(i=0;i<8;i++)
					  {
		   				 Rcan.Byte[i]= NM_CAN_DATA[RXREcnt].Byte[i]; 
					  }		


	 	}


     return Rcan;


}



void CAN_Init(u8 CAN_MasterCtrlReg)
{ 
	/* Abort the pending transmit requests */
    ///CAN_IER = 	CIER_WKUIE	
	CAN_FPSR = CAN_TXMB0_PG;
	CAN_MCSR |= MCSR_ABRQ;    

	CAN_FPSR = CAN_TXMB1_PG;
	CAN_MCSR |= MCSR_ABRQ;
	
	CAN_FPSR = CAN_TXMB2_PG;
	CAN_MCSR |= MCSR_ABRQ;
	
	CAN_MCR |= CMCR_INRQ;				/* Request initialisation */
	while ( !(CAN_MSR & CMSR_INAK) ); 	/* Wait until acknowledged */

	/*
		Clear Transmit mailbox empty interrupts (RQCP 0 & 1 & 2) and therefore
		clear TXOK 0 & 1 & 2 bits
	*/
	CAN_TSR |= CTSR_RQCP0 | CTSR_RQCP1 | CTSR_RQCP2;
	
	/* Release the Receive FIFO -> clear FMP bits and FULL bit */
	while(CAN_RFR & CRFR_FMP01)
	{
		CAN_RFR = CRFR_RFOM;
	}
	
	/* Clear the FIFO Overrun (FOVR) bit */
	CAN_RFR |= CRFR_FOVR;
	
	/* Clear Wake-up pending interrupt */
	CAN_MSR = CMSR_WKUI;

	/* ABOM - /NART - TXFP */
	CAN_MCR |= CAN_MasterCtrlReg;

	

	/* Filter initialization */
	/* Deactivate all filters */
	CAN_FPSR = CAN_CTRL_PG ; 
	CAN_FCR1 = 0x00;
	CAN_FCR2 = 0x00;
	CAN_FCR3 = 0x00;
	/* Filter 0, 1, 2, 3 in Identifier/Mask mode */
	CAN_FMR1 = 0x00;
	/* Filter 4, 5 in Identifier/Mask mode */
	CAN_FMR2 = 0x00;

	/* Select filter 0:1 Page */
	CAN_FPSR = CAN_FILTER01_PG;
	
////////////////////////////////////////////////////////////////////////////////
	/* All ID values are accepted */ 
	CAN_FxR0 = 0xA1;		// Stdid: 0x508
	CAN_FxR1 = 0x00;
	CAN_FxR2 = 0x00;		// 0x61 Stdid: 0x308
	CAN_FxR3 = 0x00;
	CAN_FxR4 = 0x00;	//0x83;		// Stdid: 0x418
	CAN_FxR5 = 0x00;
	CAN_FxR6 = 0x00;	//0x83;		// Stdid: 0x419
	CAN_FxR7 = 0x00;	//0x20;
////////////////////////////////////////////////////////////////////////////////
	
	CAN_FPSR = CAN_CTRL_PG ;
	/* Filter 0 in Identifier List mode */
	//CAN_FMR1 = 0x03;
	/* Filter 0 active in 1 x 32-bit registers */
	CAN_FCR1 = 0x07;

	/* Configure bit timing */
	CAN_FPSR = CAN_CTRL_PG;
	
	CAN_BTR1 = CAN_CBTR0_REGISTER;		// see can.h for modification of
	CAN_BTR2 = CAN_CBTR1_REGISTER;  	// bit timing parameters.bo te lv she zhi
    //0x12     2   6=1
    //0x01     0x1c
    CAN_BTR1 = 0x81;
	//CAN_BTR1 |= 0x01;
	CAN_BTR2 = 0x2b;
	

	CAN_DGR |= CDGR_3TX;	/* 3 Tx mailboxes */ 
  
	CAN_MCR &= ~CMCR_INRQ;				/* Leave the Init mode */
	while ( (CAN_MSR & CMSR_INAK) );	/* Wait until acknowledged */ 
      
}

/*********************************************************************/
/*            CAN����ͨ�ų���                                        */
/*�������ƣ�void CANSend(void)                                        */
/*��    �룺��                                                       */
/*��    ������                                                       */
/*����Ҫ��                                                         */
/*��    �ߣ�                    ���ʱ�䣺2008.02.26                 */
/*��������:                                                          */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/
void CANSend(void)
{
    static unsigned char period;
	  static unsigned int Time50ms;
	  
	//if(IGNstate != ON){return;}
	//else gNetWorkStatus.bussleep = 0;	
    //if(gCanNormalMsgActive == 0)return;
    //if( gNMHasSleeped == 1)return;
    if((gCanNormalMsgActive == 0)&&(HazzardState != Pressed))return;
    if((gNMHasSleeped == 1)&&(HazzardState != Pressed))return;
    //if(busoffcnt != 0) return;

	if(period < 19)period++;
	else
	{
        period = 0;
		CAN_Send1(BCM_PM_ID,8 ,CanSendData);
	}
    

}



void CAN_send2(u16 ID,u8 dlc,u8 data0,u8 data1,u8 data2,u8 data3,u8 data4,u8 data5,u8 data6,u8 data7)
{
     uchar Senddata[8];
	 Senddata[0]=data0;
	 Senddata[1]=data1;
	 Senddata[2]=data2;
	 Senddata[3]=data3;
	 Senddata[4]=data4;
	 Senddata[5]=data5;
	 Senddata[6]=data6;
	 Senddata[7]=data7;
     CAN_Send1(ID,dlc,Senddata);
}


void clearCANrx(uchar cntnumber)
{
     Rx_Msg[cntnumber].State = 0;
     Rx_Msg[cntnumber].dlc   = 0;	 
     Rx_Msg[cntnumber].extid = 0;
	 Rx_Msg[cntnumber].stdid = 0;
	 
	 Rx_Msg[cntnumber].data[0] = 0;
     Rx_Msg[cntnumber].data[1] = 0;
	 Rx_Msg[cntnumber].data[2] = 0;
	 Rx_Msg[cntnumber].data[3] = 0;
	 Rx_Msg[cntnumber].data[4] = 0;
	 Rx_Msg[cntnumber].data[5] = 0;
	 Rx_Msg[cntnumber].data[6] = 0;
	 Rx_Msg[cntnumber].data[7] = 0;
}






void CAN_Send1(u16 ID,u8 DLC ,u8 *data)
{
    unsigned char i,j;
	
    //if(cansendstate != 0) return;
	//cansendstate = 5;
    if((CommControl != 0)&&(ID < 0x700))return;
	
    //if((ID != 0x288)||(ID != 0x400)||(ID != 0x708))return;
    Tx_Msg.stdid = ID;
    Tx_Msg.dlc   = DLC;
    for( i = 0 ; i < DLC ; i++)
    {
        Tx_Msg.data[i] = data[i];
    }
    //for( j = 0 ; j <= 3 ; j++)
    //{
	    Can_Tx_State = CanMsgTransmit(&Tx_Msg);
	
    	if(Can_Tx_State == KCANTXOK)
	    {
	        //busoffcnt = 0;
	        if((Tx_Msg.stdid > 0x3ff)&&(Tx_Msg.stdid < 0x500))
	        {
                    gNMMsgTransitFlag = 1;
		      if(busoffcnt)busoffcnt--;
		      cansendbusoff = 0;
		 }

			//break;		    
	    }
	    else if(Can_Tx_State == KCANTXFAILED)
	    {
 			Can_Tx_State = CanMsgTransmit(&Tx_Msg);
			 if((Tx_Msg.stdid > 0x3ff)&&(Tx_Msg.stdid < 0x500))
		        {
	                    gNMMsgTransitFlag = 1;
			      if(busoffcnt)busoffcnt--;
			      cansendbusoff = 0;
			 }
	    }

    //}
}
/*********************************************************************/
/*            CAN���մ������                                        */
/*�������ƣ�void CANRX(void)                                        */
/*��    �룺��                                                       */
/*��    ������                                                       */
/*����Ҫ��                                                         */
/*��    �ߣ�                    ���ʱ�䣺2008.02.26                 */
/*��������:                                                          */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/
void CANRX(void)
{
    u8    Rxcnt;   //
    u16 BCMpassword1;
    u16 BCMpassword2;
    u16 BCMpassword3;
    u16 BCMpassword4;
    uchar senddata[10];
    static uint  salftime;
    uchar witecnt;
    uchar res;
    u32  temp;
	static u16 CANsetsavetime;
	u16 crashcs;
	//static uchar Crashdata;

    //��TESTͨѶ��ʱ�����ƿ��ƣ���������30���㳬ʱ
    if(salftime != 0)
    {
        //salftime--;
        if(salftime == 0)
        {
            salfmode = 0 ;
            CAN_FORTIFY_state = 0 ;
        }
    }
	
	//////////////////////////////////////////////////////////
	//save password


	//////////////////////////////////////////////////////////
	//save set 

	//////////////////////////////////////////////////////////

	
    for(Rxcnt = 0 ; Rxcnt < 10 ; Rxcnt++ )
    {
        Clear_WDT(); 
        if( Rx_Msg[Rxcnt].State == 1 )
        {
            //Rx_Msg[Rxcnt].State = 0;
            if(Rx_Msg[Rxcnt].stdid > 0x400){clearCANrx(Rxcnt);return;}
			
            switch(Rx_Msg[Rxcnt].stdid)
            {
                case EMS_ID1: 
                {   
			DTC_EMS_ID1 = 125;
                    //BYTE:0 bit 6 7 ɲ���ƶ��ź�
                    if((Rx_Msg[Rxcnt].data[0] & 0xc0 )==0x40) 
                    {
				BreakPedalSignal = BrakeOK;
			}
			else if((Rx_Msg[Rxcnt].data[0] & 0xc0 )==0x00)
			{
                           BreakPedalSignal = BrakeNO;
			}
			else if((Rx_Msg[Rxcnt].data[0] & 0xc0 )==0xc0)
			{
                           BreakPedalSignal = BrakeError;
			}
						
                }break;
                case EMS_ID2://�ֶ��� ����
                 {
			 DTC_EMS_ID2 = 125;

			 if((DTC_ABS_ID !=0)||(DTC_TCU_ID !=0))break;
                     //MT CAR SPEED
                     if((Rx_Msg[Rxcnt].data[1] & 0x10 )==0)
                     {
      					CarSpeed[2] = 	Rx_Msg[Rxcnt].data[1]&0x0f ;
				       CarSpeed[2] = (CarSpeed[2]<<8)+ Rx_Msg[Rxcnt].data[2];       

					CarSpeed[1]= (CarSpeed[2] >> 3)+(CarSpeed[2] >> 5);

					if(CarSpeed[2] > 350)
					{
						if(Speedlockcnt < 20)Speedlockcnt++;
					}
					else Speedlockcnt = 0;
					DecelerationThresholds(CarSpeed[1]);
                     }                 
                     
                 }break;
                case TCU_ID:  //�Զ��� ����
                { 
				DTC_TCU_ID =125;

				if(DTC_ABS_ID !=0) break;
				//AT CAR SPEED					
				if((Rx_Msg[Rxcnt].data[4] & 0x80 )==0)
				{
					CarSpeed[2] = 	Rx_Msg[Rxcnt].data[4]&0x0f ;
					CarSpeed[2] = (CarSpeed[2]<<8)+ Rx_Msg[Rxcnt].data[5];     

					CarSpeed[1]= (CarSpeed[2] >> 3)+(CarSpeed[2] >> 5);

					if(CarSpeed[2] > 350)
					{
						if(Speedlockcnt < 20)Speedlockcnt++;
					}
					else Speedlockcnt = 0;
					DecelerationThresholds(CarSpeed[1]);
				} 
                }break;
                case ABS_ID:
				{ 
					 DTC_ABS_ID = 125;
					//ABS CAR SPEED 
		                     if((Rx_Msg[Rxcnt].data[4] & 0x20 )==0)
		                     {
						CarSpeed[2] = 	Rx_Msg[Rxcnt].data[4]&0x0f ;
						CarSpeed[2] = (CarSpeed[2]<<8)+ Rx_Msg[Rxcnt].data[5];

						CarSpeed[1]= (CarSpeed[2] >> 3)+(CarSpeed[2] >> 5);

						if(CarSpeed[2] > 350)
						{
							if(Speedlockcnt < 20)Speedlockcnt++;
						}
						else Speedlockcnt = 0;
						DecelerationThresholds(CarSpeed[1]);
					} 
                }break;
				case SRS_ID:
				{
					 DTC_SRS_ID =125;
					 
					  //·��ȡ����ײ����
					 if((((Rx_Msg[Rxcnt].data[0]>>4)^0xf)&0x0f)==(Rx_Msg[Rxcnt].data[0]&0x0f))
					 {
					      if(((Rx_Msg[Rxcnt].data[0] & 0xf0)==0x10)||((Rx_Msg[Rxcnt].data[0] & 0xf0)==0x20)||((Rx_Msg[Rxcnt].data[0] & 0xf0)==0x40))
                     	             {   

                     	                  
						    if(Rx_Msg[Rxcnt].stdid != SRS_ID)return;
						    CAN_Crash = 0x55; 

					      }
					      else  CAN_Crash = 0x00; 
					
					 }

				}break;

   
                default:break;
            	}
			clearCANrx(Rxcnt);
			Rx_Msg[Rxcnt].State = 0;

        }
    	}
}




/*********************************************************************/
/*            CAN����3b01������                                    */
/*�������ƣ�void MMXG3b01(u8 mode ,u8 Rxcnt)                         */
/*��    �룺��                                                       */
/*��    ������                                                       */
/*����Ҫ��                                                         */
/*��    �ߣ�rexlei              ���ʱ�䣺2008.04.15                 */
/*��������:                                                          */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/
//����λ���б䶯���������ܸ��ģ�����Ӧ�ø���
void MMXG3b01(u8 mode ,u8 Rxcnt)
{
    uchar senddata[8];
    u16   BCMpassword1,BCMpassword2;
    //BCMpassword1 =  Rx_Msg[Rxcnt].data[3] << 8;
    //BCMpassword1 += Rx_Msg[Rxcnt].data[4] << 0;
    //BCMpassword2 =  Rx_Msg[Rxcnt].data[5] << 8;
    //BCMpassword2 += Rx_Msg[Rxcnt].data[6] << 0; 
    
   // if(mode == 4)
   // {
         if(IGNstate == OFF ){salfmode = 0; return;}
         pword1 = Rx_Msg[Rxcnt].data[3];
		 pword2 = Rx_Msg[Rxcnt].data[4];
		 pwordwriteenble = 0x55;
	     //////////////////////////////////////////////
         //send 7b 01 
         mode = 0x1;
  
		 CAN_send2(TesterBCM,8,0x02,WriteDatabyLocalld + 0x40,0xf8,0x00,0x00,0x00,0x00,0x00);
		 ///////////////////////////////////////////////
         
   //}

         //����3B 01����λ�����
         
 }



/*******************************************************************************
* Function Name : CAN_Sleep
* Description   : This routine puts the CAN to bed.
* Input         : .
* Output        : .
* Return        : .
*******************************************************************************/
//void CAN_Sleep(void)
//{
//	CAN_MCR |= CMCR_SLEEP;		/* Set Sleep mode */
//	while( !(CAN_MSR & CMSR_SLAK) );	/* Wait for Sleep acknowledge */
//}


/*******************************************************************************
* Function Name : CAN_WakeUp
* Description   : This routine wakes the CAN up.
* Input         : .
* Output        : .
* Return        : .
*******************************************************************************/
void CAN_WakeUp(void)
{
	CAN_MCR &= ~CMCR_SLEEP;		/* Leave Sleep mode */
	while(CAN_MSR & CMSR_SLAK);	/* Wait until slak bit cleared */
}


/*******************************************************************************
* Function Name : CAN_DiagMode
* Description   : This routine sets the CAN in Loop-back and/or silent modes.
* Input         : CAN_Mode (CDGR_LBKM, CDGR_SILM)
* Output        : .
* Return        : .
*******************************************************************************/
void CAN_EnableDiagMode(u8 CAN_Mode)
{
	CAN_MCR |= CMCR_INRQ;				/* Request initialisation */
	while ( !(CAN_MSR & CMSR_INAK) ); 	/* Wait until acknowledged */
	
	/* CAN modes */
	CAN_DGR |= CAN_Mode;
	
	CAN_MCR &= ~CMCR_INRQ;				/* Leave the Init mode */
	while ( (CAN_MSR & CMSR_INAK) );	/* Wait until acknowledged */
}


/*******************************************************************************
* Function Name : CAN_DisableDiagMode
* Description   : This routine sets the CAN in Loop-back and/or silent modes.
* Input         : CAN_Mode (CDGR_LBKM, CDGR_SILM)
* Output        : .
* Return        : .
*******************************************************************************/
void CAN_DisableDiagMode (void)
{
	CAN_MCR |= CMCR_INRQ;				/* Request initialisation */
	while ( !(CAN_MSR & CMSR_INAK) ); 	/* Wait until acknowledged */
	
	/* Disable Silent/Loop-back modes */
	CAN_DGR &= ~(CDGR_LBKM | CDGR_SILM);
	
	CAN_MCR &= ~CMCR_INRQ;				/* Leave the Init mode */
	while ( (CAN_MSR & CMSR_INAK) );	/* Wait until acknowledged */
}


/*******************************************************************************
* Function Name : CanMsgTransmit
* Description   : This service initiates the transmission for the message 
                  referenced by <txData>. 
				  This service shall not be called when the CAN driver is in
                  stop or sleep mode.
* Input         : txData - Pointer to structure which contains about CAN-Id,
                  CAN-DLC,CAN-Frame Data.
									CAN-Frame Data[0] = Mailbox number (for debug) 
* Output        : .
* Return        : KCANTXOK - Request is accepted by CAN driver.
                  KCANTXFAILED - Request is not accepted by CAN driver.
*******************************************************************************/
u8 CanMsgTransmit(tCanMsgOject *txData)
{
	u8 idx, MailboxNumber;

	if(busoffcnt !=0)
	{

		if(CAN_TPR & CTPR_TME0)			// Mailbox 1 empty ? 
		{
			CAN_FPSR = CAN_TXMB0_PG;
			MailboxNumber = 1;
		}
		else return KCANTXFAILED;
	}
      else
      	{
      		if(CAN_TPR & CTPR_TME0)			// Mailbox 1 empty ? 
		{
			CAN_FPSR = CAN_TXMB0_PG;
			MailboxNumber = 1;
		}
		else if(CAN_TPR & CTPR_TME1)	// Mailbox 2 empty ? 
		{
			CAN_FPSR = CAN_TXMB1_PG;
			MailboxNumber = 2;		
		}
		else if(CAN_TPR & CTPR_TME2)	// Mailbox 3 empty ? 
		{
			CAN_FPSR = CAN_TXMB2_PG;
			MailboxNumber = 3;		
		}
		else
		{
			return (KCANTXFAILED);
		}
      	}
     
//    if((txData->stdid == 0x280)||(txData->stdid==0x408))
//    {
//       while(1);
//	}
	CAN_MCSR &= 0xfe;	
	//CAN_MDLC = 0;

    //if(CAN_MDLC != 0 )return;
	/* Transfert ID, DLC and Data in RAM to the right Mailbox */
	CAN_MDLC = txData->dlc;
	//if(CAN_MDLC == 0x280)CAN_MDLC = 0x400;
    //if(CAN_MDLC == 0x408)CAN_MDLC = 0x288;
	/* Mask used to clear IDE, RTR, ExtID [17:16] -> Only Std frames are used */
	//CAN_MIDR12 = (txData->stdid << 2) & 0x1FFC;
	
////////////////////////////////////////////////////////////////////////////////
///////////////////added by sherry li///////////////////////////////////////////
/* Mask used to clear IDE, ExtID [17:16] -> Extended frames are used */
//CAN_MIDR12 = ((txData->stdid << 2) & 0x1FFC) | 0x4000;

    CAN_MIDR12 = ((txData->stdid << 2) & 0x1FFC);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
	//CAN_MIDR34 = txData->extid;
	
	//CAN_MDAR[0] = MailboxNumber;
	for(idx = 0; idx < CAN_MDLC; idx++)
	{
		CAN_MDAR[idx] = txData->data[idx];
	}

	 if(cansendbusoff !=0)
	 {
               if(CAN_MIDR12 != ((0x288 << 2) & 0x1FFC))  CAN_MIDR12 = 0;
	 }

        if((CAN_MIDR12 != ((0x400 << 2) & 0x1FFC))&&(CAN_MIDR12 != ((0x288 << 2) & 0x1FFC))&&(CAN_MIDR12 != ((0x708 << 2) & 0x1FFC))){CAN_MIDR12 = 0; return 0 ;}
	//if(CAN_MIDR12 == ((0x280 << 2) & 0x1FFC)) return 0;
	//if(busoffcnt >= 8) 
	//{
            
	//}
	
	CAN_MCSR |= MCSR_TXRQ;	/* Transmit Request */


	
	return (KCANTXOK);
} 


/*******************************************************************************
* Function Name : CanCanInterruptDisable
* Description   : This routine disables all CAN interrupts.
* Input         : .
* Output        : .
* Return        : .
*******************************************************************************/
void CanCanInterruptDisable (void)
{
	CanSavePg();

	CAN_IER = 0x00; 
	CAN_FPSR = CAN_CTRL_PG;         
	CAN_EIER = 0x00;

	CanRestorePg();
}


/*******************************************************************************
* Function Name : CanCanInterruptRestore
* Description   : This service restores all CAN interrupts.
* Input         : .
* Output        : .
* Return        : .
*******************************************************************************/
void CanCanInterruptRestore (void)
{
	CanSavePg();

	CAN_IER = 	CIER_WKUIE |	/* Wake-up Interrupt */
				//CIER_FOVIE | 	/* FIFO overrun Interrupt */
				//CIER_FFIE  |	/* FIFO Full Interrupt */
				CIER_FMPIE;// |	/* FIFO Message Pending Interrupt */
				//CIER_TMEIE;		/* Transmit Mailbox Empty Interrupt */

	CAN_FPSR = CAN_CTRL_PG;
	CAN_EIER =  CEIER_ERRIE|	/* Error Interrupt */
	            //CEIER_LECIE|	/* Last Error Code Interrupt */
				CEIER_BOFIE;//|	/* Bus-Off Interrupt */
				//CEIER_EPVIE|	/* Error Passive Interrupt */
				//CEIER_EWGIE;	/* Error Warning Interrupt */

	CanRestorePg();
}
/*********************************************************************/
/*           BCM����Ͽ��Ʋ���                                       */
/*�������ƣ�void CANSend(void)                                       */
/*��    �룺����Ͻӿ���Ϣ                                           */
/*��    �������״̬��Ϣ                                             */
/*����Ҫ��ÿ�������Ϣ����ǰ����                                   */
/*��    �ߣ�RexLei                    ���ʱ�䣺2008.02.29           */
/*��������:                                                          */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/
void DiagnosticateTactic(void)
{ 
/*
	//ת������
    if( Turn_R_State == Pressed )
    {
        //CanSendData[0] = CanSendData[0] | 0x80 ;
    } //ON
    else
    {
        //CanSendData[0] = CanSendData[0] & 0x7f ;
    }//off
    if( Turn_L_State == Pressed )
    {
       // CanSendData[0] =CanSendData[0] | 0x40 ;
    } //on
    else
    {
        //CanSendData[0] =CanSendData[0] & 0xbf ;
    }
    //�����ȱ���
    if( wLockProtectTimeCnt != 0 ){ CanSendData[0] |= 0x20 ;} //���ȱ���
    else{  CanSendData[0] &= 0xdf ;}
    //������Ϣ
    CanSendData[0] &= DELall ; //����ϴ�״̬��Ϣ
    CanSendData[0] |= BCMtoGEM_AlarmStatus;  //���¾�����Ϣ
    //ң������ص������
    if( RKEBatteryVoltage_State == 1 ){ CanSendData[0] |= 0x04 ;} //��ѹ̫��
    else {CanSendData[0] &= 0xfb ;}
    //��״̬
    if( DoorState & DriverDoorIsOpen ){ CanSendData[0] |= 0x02 ;} //��ʻԱ�ſ�
    else{ CanSendData[0] &= 0xfd ;}
    
    if( DoorState & OtherDoorIsOpen )
    {
        CanSendData[0] |= 0x01 ;   //��ǰ  ��
        CanSendData[1] |= 0x80 ;   //���  ��
        CanSendData[1] |= 0x40 ;   //�Һ�  ��
    }
    else
    {
        CanSendData[0] &= 0xfe ;
        CanSendData[1] &= 0x7f ;
        CanSendData[1] &= 0xbf ;
    }
    //��ȫ��״̬   ��һ����ȫ��δϵΪ0
    if( SeatState & PassengerSeated )
    {
        if(( SeatState & PSeatbeltBuckled ) &&( SeatState & DSeatbeltBuckled ))
        {
             CanSendData[1] |= 0x20 ; 
        }
        else
        {
             CanSendData[1] &= 0xdf ;
        }
    }
    else 
    {
        if( SeatState & DSeatbeltBuckled )
        {
             CanSendData[1] |=0x20 ;
        }
        else
        {
             CanSendData[1] &=0xdf ;
        }
    //}
    //�����״̬
   // if( LOWBeamDriverState == 1 ){ CanSendData[1] |= 0x02 ;}
   // else{ CanSendData[1] &= 0xfd ;}
    //���˪״̬
    if( DefrostDriverState == 1 ){ CanSendData[1] |= 0x01 ;}

    else{ CanSendData[1] &= 0xfe ;}
    //����ƹ���
    //if(( LOWBeamDriverState == 1 ) && ( LOW_BEAM_LAMP_Out == 0 ))
    //{
    //    CanSendData[2] |= 0x80 ;        //�й��� 
    //}
    //else
    //{
    //    CanSendData[2] &= 0x7f ;
    //}
    //���˪����
    if(( DefrostDriverState == 1 ) && ( REAR_DEFROSTER_OUT == 0 ))
    {
        CanSendData[2] |= 0x40 ;        //�й��� 
    }
    else
    {
        CanSendData[2] &= 0xbf ;        
    }*/
}
/*********************************************************************/
/*           CAN����/�ر�                                            */
/*�������ƣ�void CANenble(void)                                      */
/*��    �룺IGNSTATE                                                 */
/*��    ������                                                       */
/*����Ҫ����ѭ���е���                                             */
/*��    �ߣ�RexLei                    ���ʱ�䣺2008.04.14           */
/*��������:                                                          */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/
void CANenble(void)
{   
    static uchar CANenblestate;
    
   // if(( IGNstate == ON ) && (CANenblestate != 0x55))
   // {
   //     CANenblestate = 0x55 ;
        CAN_MCR &= ~CMCR_INRQ;				/* Leave the Init mode */
        while ( (CAN_MSR & CMSR_INAK) );	/* Wait until acknowledged */ 
        CAN_EN_OFF;   // }
   // else if((IGNstate == OFF) &&(CANenblestate == 0x55))
   // { 
   //     CANenblestate = 0x00 ;
   //     CAN_MCR |= CMCR_INRQ;				/* Leave the Init mode */
   //     while ( (CAN_MSR & ~CMSR_INAK) );	/* Wait until acknowledged */ 
   // }
}
/*********************************************************************/
/*           �߳�DTC���ϴ���                                         */
/*�������ƣ�void ClearDTC(void)                                      */
/*��    �룺��                                                       */
/*��    ������                                                       */
/*����Ҫ�󣺽ӵ��������                                             */
/*��    �ߣ�RexLei                    ���ʱ�䣺2008.04.14           */
/*��������:                                                          */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/
void ClearDTC(void)
{/*
    uchar number;
    for(number = 0 ;number < DTCLongAdress ; number++)
    {    

            Clear_WDT();     
            DTCnumber[number] = 0x0000;

    }*/
}
/*********************************************************************/
/*           дDTC���ϴ���                                           */
/*�������ƣ�void WriteDTC(u16 DTCvalue)                              */
/*��    �룺DTCvalue                                                 */
/*��    ������                                                       */
/*����Ҫ��д���ϴ���ʱ�������ֱ�ӵ���                             */
/*��    �ߣ�RexLei                    ���ʱ�䣺2008.04.14           */
/*��������: ����DCT���ϴ����Զ�����ռ�д��                          */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/  
void WriteDTC(u16 DTCvalue)
{/*
    uchar number,witecnt ;
    u32 temp;
    uchar res;
    //static uchar FindDTCSameState;
	uchar FindDTCSameState=0;		//modified by zhaoyong
	
    for(number = 0 ; number < DTCLongAdress ; number++)
    {
         if(DTCnumber[number] == DTCvalue)
         {
			 FindDTCSameState = 0x55 ;
			 break;
         }
    }

    if(FindDTCSameState != 0x55)
    {/*
        FindDTCSameState = 0 ;
        for(number = 0 ; number < DTCLongAdress ; number++)
        {
            if( DTCnumber[number] == 0x0000 )
            {
            	for( witecnt = 0; witecnt < EECNT ; witecnt++ )
            	{
                    temp = (u32)(&DTCnumber)+number*2;
                    res = (u8)(DTCvalue >> 8);
                    FLASH_ProgramByte(temp, res);
                    temp++;
                    res = (u8)(DTCvalue);
                    FLASH_ProgramByte(temp, res);
                    
                    if(DTCnumber[number] == DTCvalue)
                    {
                        break;
                    }
            	}
            	break;
            }
        }
    }*/
}

/*********************************************************************/
/*          ����DTC���ϴ���                                           */
/*�������ƣ�void SendDTC(void)                                       */
/*��    �룺                                                         */
/*��    ������                                                       */
/*����Ҫ�󣺷���DTCʱ����                                            */
/*��    �ߣ�RexLei                    ���ʱ�䣺2008.04.14           */
/*��������: �Զ��任���ݸ�ʽ���з���                                 */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/  
void SendDTC(void)
{/*
    uchar DCTcnt,DCTnum,DTCXX;
    static uchar NUMdtc;
    static uchar SendDTCcnt;
    static uchar sendDTCvalue[80];
    static uchar statesend;
    uchar senddata[8];
    
    static uchar ONSE;
    Clear_WDT();
    if(DTCsendstate == 0x55 )
    {
        if(statesend != 0x55)
        {
              for(DCTcnt = 0 ; DCTcnt< 80 ;DCTcnt++) //clear sendDTCvalue
              {
                      sendDTCvalue[DCTcnt] = 0 ;
              }       	      
              for( DCTcnt = 0 ; DCTcnt < DTCLongAdress ; DCTcnt++)
              {
                  if( DTCnumber[DCTcnt] != 0x0000 )
                  { 
                      DCTnum++;            
                  }
                  else
                  {
                      break;
                  }
              }
			 
             for(DTCXX = 0 ;DTCXX <= DCTnum+3; DTCXX++)
             {   
                   NUMdtc++;
                   sendDTCvalue[NUMdtc] = 0x00 ;
                   NUMdtc++;
                   //sendDTCvalue[NUMdtc] = DTCnumber[DTCXX]>>8;
                   NUMdtc++;
                   //sendDTCvalue[NUMdtc] = DTCnumber[DTCXX];
             }
              statesend = 0x55 ;
		
      	}

        if((sendonse == 0)&&(DTCsendstate == 0x55))
        {
            //     sendonse= 1;
                if(DTCsendmode == 0x55)
                {

				    CAN_send2(TesterBCM,8,0x02,0x58 ,0x00,0x00,0x00,0x00,0x00,0x00);
				}
                else
                {			

//			CAN_send2(TesterBCM,8,0x10,DCTnum * 3+2 ,0x58,DCTnum,0xsendDTCvalue[2],sendDTCvalue[3],sendDTCvalue[4],sendDTCvalue[5]);
					//sendonse = 1;

                }
									DTCsendstate = 0 ;
	   
	                SendDTCcnt = 6;
	                ONSE = 0x20;
				DTCsendmode=0;
              //  CAN_Send1(0x7ea, 8 ,senddata);
        }
        else if(sendonse == 2)
        {
            ONSE++;

			CAN_send2(TesterBCM,8,ONSE,sendDTCvalue[SendDTCcnt++] ,sendDTCvalue[SendDTCcnt++],sendDTCvalue[SendDTCcnt++],sendDTCvalue[SendDTCcnt++],sendDTCvalue[SendDTCcnt++],sendDTCvalue[SendDTCcnt++],sendDTCvalue[SendDTCcnt++]);
        }
           
        if(SendDTCcnt > NUMdtc)
        {
            DCTnum = 0 ;
            SendDTCcnt = 0 ;
            sendonse = 0 ;
            DCTcnt = 0 ;
            statesend = 0 ;
            NUMdtc = 0 ;
            DTCsendstate = 0 ;
        }
    }
*/
}

////////////////////////////////////////////////
void writeHazardecestate(u8 number)
{
    u32 temp;
	u8  res,witecnt;
    for( witecnt = 0; witecnt < EECNT ; witecnt++ )
	{	
        temp = (u32)(&Hazardecestate);
		
        FLASH_ProgramByte(temp, number);

        
        if(number == Hazardecestate)
        {
            break;
        }
	}    
}
void writeRearfogbutton(u8 number)
{
    u32 temp;
	u8  res,witecnt;
    for( witecnt = 0; witecnt < EECNT ; witecnt++ )
	{	
        temp = (u32)(&Rearfogbutton);
		
        FLASH_ProgramByte(temp, number);

        
        if(number == Rearfogbutton)
        {
            break;
        }
	}    
}


///////////////////////////////////////////////////////////////////////////////
/*********************************************************************/
/*            ����ɲ����׼ֵ�趨                                     */
/*�������ƣ�uint DeceSettingValue(uchar setting)                     */
/*��    �룺��                                                       */
/*��    ������                                                       */
/*����Ҫ��                                                         */
/*��    ��:rexlei               ���ʱ�䣺2008.02.23                 */
/*��������:��ѯ��׼ֵ                                                */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/
uint DeceSettingValue(uchar seting)
{
    uint  value;

    switch(seting)
    {
        case 0:  
        	 value = 1 ;
        	 break;
        case 1:
        	 value = 2 ;
        	 break;
        case 2:
             value = 5 ;
        	 break;
        case 3:
             value = 10 ;
        	 break;
        case 4:
        	 value = 13 ;
        	 break;
        case 5:
        	 value = 15 ;
        	 break;
        case 6:
        	 value = 16 ;
        	 break;
        case 7:
        	 value = 17 ;
        	 break;
        case 8:
        	 value = 18 ;
        	 break;
        case 9:
        	 value = 19 ;
        	 break;
        case 10:
        	 value = 20 ;
        	 break;
        case 11:
        	 value = 22 ;
        	 break;
        case 12:
        	 value = 23 ;
        	 break;
        case 13:
        	 value = 24 ;
        	 break;
        case 14:
        	 value = 25 ;
        	 break;
        case 15:
        	 value = 26 ;
        	 break;
        default : break;
    }

    return value;
}

/*********************************************************************/
/*            ���ٶȼ���                                             */
/*�������ƣ�uint DeceCount(uchar speed)                              */
/*��    �룺�ٶ�                                                     */
/*��    ���� ���ٶ�                                                  */
/*����Ҫ��CAN�����ٶ�ֵ����ʱ����                                  */
/*��    ��:rexlei               ���ʱ�䣺2008.02.23                 */
/*��������:                                                          */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/
uint DeceCount(uint speed)           
{
     uint SpeedValueMS;   //ǧ��/Сʱ---��/��
     uint Speedoldvalue;  //һ��ǰ����
     uint DeceSpeed;
     static uchar SPeedvalueCNT;
	 static uint SpeedValue[50];
     if(speed != 0)
     {
         SpeedValueMS = (speed >> 3)+(speed >> 5);//ϵ��:0.15625=1/8+1/32//ǧ��/Сʱ---��/��
     }
     else
     {
         SpeedValueMS = 0 ;
     }
     if( SPeedvalueCNT == 49) SPeedvalueCNT = 0;
     else  SPeedvalueCNT++;
     Speedoldvalue = SpeedValue[SPeedvalueCNT];
     SpeedValue[SPeedvalueCNT] = SpeedValueMS;
     if(SpeedValueMS <  Speedoldvalue)
     {
           	DeceSpeed =  Speedoldvalue - SpeedValueMS; //����1�����ٶȼ�С��
     }
     if(Speedoldvalue == SpeedValueMS)
     {
              DeceSpeed =0;
     }
     else if(SpeedValueMS >  Speedoldvalue) 
     {
             DeceSpeed = 0xffff;
     }
	 return DeceSpeed;
}


/*********************************************************************/
/*            ɲ���������Ƴ���                                       */
/*�������ƣ�void DecelerationThresholds(void)                        */
/*��    �룺��                                                       */
/*��    ������                                                       */
/*����Ҫ��                                                         */
/*��    ��:rexlei               ���ʱ�䣺2008.02.23                 */
/*��������:                                                          */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/
void DecelerationThresholds(uint VehicleSpeed)
{
    //static uchar VehicleSpeed;     //���ٶ� ͨ��CAN���߻��
    static uchar count,count1;
	uint Dececountvalue;
	static unsigned char rxcnt=0;
    //VehicleSpeed = CarSpeed;
    Dececountvalue =   DeceCount(VehicleSpeed);
	
    //if(Dececountvalue > 6000) Dececountvalue  = 0;
	
    if( VehicleSpeed < Speed96)
    {
           //ȡ������
           //BrakeSpeedHazards_state = 0;
    }
    else if(( VehicleSpeed >= Speed96) &&( BreakPedalSignal == BrakeOK ))
    {
        if(( Dececountvalue >= DeceSettingValueL )&&(Dececountvalue != 0xffff))   
        {
              //��������
              BrakeSpeedHazards_state = 1;
			  rxcnt = 0;
        }
    }
    else if(( VehicleSpeed > Speed96)&& ( BreakPedalSignal == BrakeOK ))
    {
        if( (Dececountvalue >= DeceSettingValueH )&&(Dececountvalue != 0xffff))   
        {
             //��������
             BrakeSpeedHazards_state = 1;\
             rxcnt = 0;
        }
    }

    if(((BrakeSpeedHazards_state == 1)&&(Dececountvalue == 0xffff)&&(BreakPedalSignal == BrakeNO))||(VehicleSpeed < 125))
    {
         if(rxcnt < 2)rxcnt++;
		 else
		 {
             BrakeSpeedHazards_state = 0;
		 }

    }
   
}
/*********************************************************************/
/*            ����ɲ����׼ֵ�趨                                     */
/*�������ƣ�void DecelerationSetting(void)                           */
/*��    �룺��                                                       */
/*��    ������                                                       */
/*����Ҫ��                                                         */
/*��    ��:rexlei               ���ʱ�䣺2008.02.23                 */
/*��������:                                                          */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/
void DecelerationSetting(uchar SettingValue)
{

    uchar  res, i;
    uint   DeceSetValueH,DeceSetValueL;
    u32  temp;

    //дĬ��ֵ,ϵͳ��ʼ��ʱ����
    if(( DeceSettingValueH == 0 ) || ( DeceSettingValueL == 0 ))
    {
        if( DeceSettingValueH == 0 )
        {
              DeceSetValueH = DeceSettingValue(9) ;  //��ѯ��׼ֵ
        }
        if( DeceSettingValueL == 0 )
        {
             DeceSetValueL = DeceSettingValue(8) ;
        }    
    }
    else
	 {
		    DeceSetValueH = DeceSettingValue((SettingValue & 0xf0 )>>4 );  //��ѯ��׼ֵ

        DeceSetValueL =  DeceSettingValue(SettingValue & 0x0f); 
    }
    //�����ѯ���
	for( i = 0 ; i < EECNT ; i++)
	{
             temp = (u32)(&DeceSettingValueH);
             res = (u8)(DeceSetValueH >> 8);
             FLASH_ProgramByte(temp, res);
             temp++;
             res = (u8)(DeceSetValueH);
             FLASH_ProgramByte(temp, res);
             
             temp = (u32)(&DeceSettingValueL);
             res = (u8)(DeceSetValueL >> 8);
             FLASH_ProgramByte(temp, res);
             temp++;
             res = (u8)(DeceSetValueL);
             FLASH_ProgramByte(temp, res);
             
            if(( DeceSettingValueH == DeceSetValueH ) && ( DeceSettingValueL == DeceSetValueL ))
            { 
                  break;
            }
	}
}


/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
