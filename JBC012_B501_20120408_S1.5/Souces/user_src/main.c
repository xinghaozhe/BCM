/******************** (C) COPYRIGHT 2007  Chongqing Jicheng ********************
* File Name          : main.c
* Author             : MCD Tools development Team
* Date First Issued  : May 30, 2007
* Description        : This code is used for MB631 board test
********************************************************************************
* History:
* June  ??, 2007: V0.1
********************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "gpio_macro.h"
#include "adc_drv.h"
#include "st79_it.h"
#include "domelamp_drv.h"
#include "turnlamp_drv.h"
#include "lock_drv.h"
#include "warm_drv.h"
#include "horn_drv.h"
#include "rke_drv.h"
#include "window_drv.h"
#include "stm8_macro.h"
#include "defrost_drv.h"
//#include "foglamp_drv.h"
//#include "beam_drv.h"
//#include "wiper_drv.h"
#include "sys_Init.h"
#include "can.h"
//#include "Lin.h"
#include "stm8_awu.h"
#include "share.h"
#include "can_nm_osek.h"
#include "udsoncan.h"
#include "udsoncandtc.h"

extern void System_Init(void);
/*********************************************************************
 MACRO DEFINITION
*********************************************************************/
//#define SYS_CLK_HSE
#define SYS_CLK_HSI_DIV1

#define DELAY_MS_AT_16M 5000L
#define DELAY_MS_AT_24M (5000L*24/16)
#define DELAY_10US_AT_16M 50
#define DELAY_10US_AT_24M (50*24/16)

#ifdef SYS_CLK_HSE
#define DELAY_MS_VALUE   DELAY_MS_AT_24M
#define DELAY_10US_VALUE DELAY_10US_AT_24M
#else
#ifdef SYS_CLK_HSI_DIV1
#define DELAY_MS_VALUE   DELAY_MS_AT_16M
#define DELAY_10US_VALUE DELAY_10US_AT_16M
#else
#error "either SYS_CLK_HSE or SYS_CLK_HSI_DIV1 should be defined"
#endif
#endif

void InOutputWake(void);
void WakeUp(void);
void WakeInit(void);
void OneSecondWake(void);
void  InPutWake(void);
void SystemClock(void);
/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
uchar   SysTimeFlag_2MS;
uchar	SysTimeFlag_8MS;
uchar   WakeState;            //˯�߻��ѱ�־����
uint    RkeScanCnt;           //RKE�����ź�ɨ��  
uchar   WaveFilterCnt;        //RKE�����˲�ʱ��
uint    WakeInTime;           //��ʱ����˯�� ʱ��  �����ñ���
uint    WakeUpTime;           //����ʱ��           �����ñ���
uchar   StandByState;         ////�����źš���������ײ���ƹ�  �˳��͹���ģʽ
uchar   StandTIM3state;
ulong  StandbyTime;  //����͹���ʱ�����
uchar  RKEStandByWakeupState; //RKE���ѱ�־
uchar  RKEStandByWakeupcnt;   //ʱ��1�����
u32	wakelintime;

uchar  RKEZBTime;
u32     RKEwakeTime;

u16     CLOCKtimeinit;

uchar  SWSZstate ;
extern uchar warmstate;
uint wakestate;

uchar wakerkestate;
//uchar   SysTimeFlag_24MS;
//------------------------------------------------------------------------------
// Function Name : delay_ms
// Description   : delay for some time in ms unit(roughly)
// Input         : n_ms is how many ms of time to delay
//------------------------------------------------------------------------------
void delay(uint n)
{
    uchar i;
    for(i=0;i<n;i++);
}
//------------------------------------------------------------------------------
// Function Name : delay_ms
// Description   : delay for some time in ms unit(roughly)
// Input         : n_ms is how many ms of time to delay
//------------------------------------------------------------------------------
void delay_ms(u16 n_ms)
{
  u16 i;
  while(n_ms--)
  for(i=DELAY_MS_VALUE; i>0; i--)
      ;
}

//------------------------------------------------------------------------------
// Function Name : delay_10us
// Description   : delay for some time in 10us unit(roughly)
// Input         : n_10us is how many 10us of time to delay
//------------------------------------------------------------------------------
void delay_10us(u16 n_10us)
{
	u16 i;
	while(n_10us--)
	for(i=DELAY_10US_VALUE; i>0; i--)
		;
}
/*********************************************************************/
/*            ����˯��ģʽ��ʼ��                                     */
/*�������ƣ�void WakeInit(void)                                      */
/*��    �룺��                                                       */
/*��    ������                                                       */                                             
/*����Ҫ�󣺽���˯��ģʽǰ����                                       */
/*��������:                                                          */
/*��    �ߣ�                    ���ʱ�䣺2008.01.11                 */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/
void WakeInit(void)
{
	uchar temp;

    //WakeState = 1;        //��˯�߱�־

    
    AWU->CSR1 = 0x10;
    AWU->TBR  = 0x0A;
    AWU->APR  = 0x3e;
    AWU->CSR1 |=0x02;
    
    temp = AWU->CSR1;	
}
/*********************************************************************/
/*            ����˯��ģʽ��ʼ��                                     */
/*�������ƣ�void SystemClock(void)                                      */
/*��    �룺��                                                       */
/*��    ������                                                       */                                             
/*����Ҫ�󣺽���˯��ģʽǰ����                                       */
/*��������:                                                          */
/*��    �ߣ�                    ���ʱ�䣺2008.06.11                 */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/
void SystemClock(void)
{
    CLK->ECKR = 0x01;
    while((CLK->ECKR & 0X02)== 0);
	
    CLK->SWCR = 0x02;
    while(CLK->SWCR&1);
    CLK->SWR  = 0xb4;
    while(CLK->CMSR != 0XB4);
	
    //CLK->SWCR &= 0xfd;

/*
	CLK->SWCR = 0x02;
    while(CLK->SWCR&1);
    CLK->SWR  = 0xb4;
    while(CLK->SWCR&1);
    CLK->SWCR &= 0xfd;

	*/


    //CLK->PCKENR1 = 0XFF;

    //CLK->PCKENR2 = 0XFF;	
    //Init system 
}
/*********************************************************************/
/*            ˯��ģʽ����                                           */
/*�������ƣ�void WakeUp(void)                                        */
/*��    �룺��                                                       */
/*��    ������                                                       */
/*����Ҫ�󣺽���˯��ģʽǰ����                                       */
/*��    �ߣ�                    ���ʱ�䣺2008.01.11                 */
/*��������:                                                          */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/
void WakeUp(void)
{
    uchar  temp;
    static uchar ii;
    WakeState = 0;           //�û��ѱ�־
    /*
    AWU->TBR  = 0x00; //250US*256=128ms
    AWU->TBR  = 0x00;  //250US*256=128ms
    AWU->CSR1 = 0xef;

    temp = AWU->CSR1;
*/
    CLK->CKDIVR = 0x00;   
	SystemClock(); 
	
       LIN_DISENABLE;
	CAN_EN_ON;
	//gLocalWakeupFlag =1;
    WWDG_Refresh(0x7f);
    CANHardwave_Init(1);
    ENABLE_RX_INT;   //ʹ��RKE
    RKE_POWER_ON;
}
	u8  HALTUPSTATE;
//------------------------------------------------------------------------------
// Function Name : viod main(void)
// Description   : main program
// Input         : all input of bcm
// Output		 : all driver of bcm
//------------------------------------------------------------------------------
void main (void)
{	
    u32 flashAddress;
    u8  flashData;
    u8  flashDataCnt;
    u8  flashStatus;
    u8  ImmoLedCnt;

	static u8  NM_CNT;
    static uchar  CANTimeCnt;            //CAN���߷���ʱ��������
    
    // Clock divider to HSI/1, Fcpu division factor: /1
   CLK->CKDIVR = 0x00;    
   // Wait for HSE ready]
  
       SystemClock();   
	TURN_LEFT_LAMP_OFF;
	TURN_RIGHT_LAMP_OFF;
	CAN_TURNRightSW_OFF;
	CAN_TURNLeftSW_OFF;
  
   System_Init();
   CANenble();

   NM_OSEK_Init();

   DTCinit();
   
   WindowStop();
   ENABLE_RX_INT;  
   //DISABLE_RX_INT; 
   RKE_POWER_ON;
   //LIN_DISENABLE;
   CAN_EN_ON;
   
   WWDG_Init(0x7f, 0x7f);


   Did2einit();
   DoorWarmState = 0 ;
   BCMtoGEM_AlarmStatus = warmstate;
   Lockonesstate = 0x55;
   ////////
   gNetWorkStatus.bussleep = 0;
   gNMCANBatFlag = 1;  //nm
   gLocalWakeupFlag =1;

    while(1)
    {
         DeceSettingValueH = 8;
		 DeceSettingValueL = 8;
      
        // Clear_WDT();                                  	// 1 clear internal/external watch dog timer
        //WWDG_Refresh(0x7f);
        if(WakeState != 1)
        {  

            if (SysTimeFlag_2MS == TRUE)
            {
				//SWSZstate = 0 ;
				SysTimeFlag_2MS = FALSE;
				if(cansendstate != 0)cansendstate--;
				ADC_Scan();		                    //scan adc convert
				//IWDG->KR = 0xaa;
				NM_CNT++;
				if(NM_CNT & 0x01)
				{
				// NM_Function_Main();
				}
				//SendDTC();   				//DTC send       
				CANSend();                        //CAN���ͳ���

				UDSonCAN_netmain();

				BUSoff();

				if(HornDoorunclosetime)HornDoorunclosetime--; 
            }         
            if (SysTimeFlag_8MS == TRUE)
            {
				SWSZstate = 0 ;
				SysTimeFlag_8MS = FALSE;     
				//IWDG->KR = 0xaa;
				WWDG_Refresh(0x7f);
				// if(IGNstate == OFF) gNetWorkStatus.bussleep = 1;	  
				// else gNetWorkStatus.bussleep = 0;
				//CANSend();                        //CAN���ͳ���
				Did2esave();

				UDSDTC_main();

				UDSonCANDiag();

				// UDSonCAN_netmain();

				CANRX();                                    //CAN���մ���

				//scan bcm all input signal
				ScanIgnSwitch();                      //ɨ���𿪹�  ����ڱ���  IGNstate

                ScanH4021InData();                   //ɨ��4021���ݽ���ڱ��� H4021Data 

                ScanBatteryVoltage();                //ɨ���ص�ѹ  ����ڱ��� BatVoltageState

                ScanDefrostSwitch();                 //ɨ����˪����  ����ڱ��� DefrostKeySta

                ScanHornSwitch();                    //ɨ�����ȿ���    ����ڱ��� HornSwitchState

                ScanKeyInState();                    //ɨ��Կ��״̬����  ����ڱ��� KeyInState

                ScanAllDoorState();                 //ɨ�賵��λ��״̬  ����ڱ��� DoorState

                TRUNKwarm();                           //���䱨������
                
                ScanCrashInSignal();    //  20120201 ·��ȡ��          //ɨ����ײ�ź�״̬  ����ڱ��� CrashState   ���� LockDrvCmd �ñ������岻��
                
                ScanAllLockState();   //????              //ɨ����������״̬  ����ڱ��� LockState

                ScanCentralLockSwitch();        //�пر����������� ����ڱ��� ͬʱ���LockState CrashState LockDrvCmd 

                ScanTrunkSwitch();                 //ɨ��������

                ScanRkeKeys();

                ScanSeatbeltBuckleState();       //��ȫ��״̬ɨ��  ����ڱ��� SeatState

                ScanSeatPositionState();           //���ݰ�ȫ��״̬  ����ڱ��� SeatState

                ScanTurnLampState();               //ת���״̬  ����ڱ��� TurnLampState

                ScanTurnLampKeys();               //ת��ƿ���  ����ڱ��� 	TurnLampDrv  �˺���δ��ȫ������

                ScanWindowKeys();    //   1               //ɨ�賵��״̬ ����� WinKeyState

		  ScanSmallLampSwitch();

                ScanFortifySWState();              //�������״̬ɨ�� Ϊ�Ͳ�������� �Ѿ���������˳����
                //judge bcm all driver
                JudgeDefrostDriver();                 //��˪����

                Clear_WDT();
                
                JudgeHornDriver();                     //���ȿ���

                JudgeDomeLampDriver();           //���ƿ���

                JudgeLockDriver();

                MachineKeyDrv();

                JudgeTurnLampDrv();

		  buzzdrv2();

                JudgeWarmTypeAndDriver();              

                FindCar();                                    //Ѱ��

                WindowDriver();                //��������                

                WarmStatusArithmetic ();          //bcm����״̬����

                SFLED();                

		  Turnvcclow();
          
                InPutWake();                             //�жϽ���˯��ģʽ����
                              
            }
        }

        //�͹��Ĵ������
        InOutputWake();
    }
    
}
/*********************************************************************/
/*           �͹��Ĵ�����                                             */
/*�������ƣ�void InPutWake(void)                                                 */
/*��    �룺��                                                                                           */
/*��    ������                                                                                           */
/*����Ҫ��                                                                                         */
/*��    �ߣ�   rexlei                 ���ʱ�䣺2008.06.11                        */
/*��������: ����һ������ȷRKE�����Զ�˯��                    */
/*                                                                                                                      */
/*�����޸ļ�¼                                                                                   */
/*�޸�����      ����         �޸�����                   ��ע                */
/*********************************************************************/

extern NM_NetWorkStatus_TypeDef gNetWorkStatus;
unsigned char insleepnetcnt=0;
uint IGNsleeptime;
uint keyinstatesleep=0;
uint Hazzardtimecnt=0;
uint wakestate;
void  InPutWake(void)
{
      // static uint wakestate;
	static uchar  LockState_old1,KeyInState_old1,doorstate_old1;
       static uint systemsleep;
	//static uint IGNsleeptime;
       //static uint keyinstatesleep=0;
	//static uint Hazzardtimecnt=0;
	if(HazzardState == Pressed)   Hazzardtimecnt = 0;
	if(Hazzardtimecnt) Hazzardtimecnt--;
       if(canrextime)canrextime--;
	 if((IGNstate == ON)&&(KeyInState == KeyIsInHole)){ wakestate = 0; IGNsleeptime = 7500;keyinstatesleep = 0;}
	 if((IGNstate == ON)&&(KeyInState == KeyIsOutHole)){ wakestate = 0; IGNsleeptime = 7500;keyinstatesleep = 0;}
	 else if((KeyInState == KeyIsOutHole)&&(canrextime ==0)){IGNsleeptime = 0;keyinstatesleep = 0;}
	 if(IGNsleeptime) IGNsleeptime--;
	 
        //if(wakestate < 12500)wakestate++;
	 if(RKEStandByWakeupState == 0x55 ) {RKEStandByWakeupState=0 ; wakestate = 0 ;}
	 
	 if((DoorState == AllDoorIsClosed)&&(IGNsleeptime == 0)&&(keyinstatesleep!=0x55)&&(LockDrvCmd == 0))//&&(BCMtoGEM_AlarmStatus == Armed))
	 {
	          if(TURN_LEFT_LAMP_OUT||TURN_RIGHT_LAMP_OUT||(BUZZER_OUT)) wakestate = 0;
                 if(Hazzardtimecnt) wakestate=0;
	          if(wakestate < 125 ) wakestate ++;
		   else if(wakestate ==125)
		   {
		       wakestate++;
		       //�˶���Ҫ�ƶ������������
		       gNetWorkStatus.bussleep = 1;
                     insleepnetcnt=1;
		       //gLocalWakeupFlag = 0;		   

		  }
	  }
	
       if(wakerkestate ==0x55){systemsleep = 0;wakerkestate = 0;}

       if((DoorState != AllDoorIsClosed)&&(insleepnetcnt == 1) ){insleepnetcnt = 0;gLocalWakeupFlag = 1;gNetWorkStatus.bussleep = 0;systemsleep = 0;wakestate = 0;WakeUp();}
       if(KeyInState_old1!=KeyInState)
       {
            KeyInState_old1  =KeyInState;
            if((KeyInState == KeyIsInHole) &&(insleepnetcnt == 1)){insleepnetcnt = 0;keyinstatesleep = 0x55;gLocalWakeupFlag = 1;gNetWorkStatus.bussleep = 0;systemsleep = 0;wakestate = 0;WakeUp();}
       }
       if((IGNstate ==ON)&&(insleepnetcnt == 1)){insleepnetcnt = 0;gLocalWakeupFlag = 1;gNetWorkStatus.bussleep = 0;systemsleep = 0;wakestate = 0;WakeUp();}
       if((HazzardState == Pressed)&&(insleepnetcnt == 1)){insleepnetcnt = 0;gLocalWakeupFlag = 1;gNetWorkStatus.bussleep = 0;systemsleep = 0;wakestate = 0;WakeUp();}
       //if((SmallLampSwitchState == Pressed)&&(insleepnetcnt == 1)){insleepnetcnt = 0;gLocalWakeupFlag = 1;gNetWorkStatus.bussleep = 0;systemsleep = 0;wakestate = 0;WakeUp();}
       if((LOCK_OUT || UNLOCK_OUT || TRUNK_UNLOCK_OUT)&&(insleepnetcnt == 1)){insleepnetcnt = 0;gLocalWakeupFlag = 1;gNetWorkStatus.bussleep = 0;systemsleep = 0;wakestate = 0;WakeUp();}



     if((gNMHasSleeped == 1)&&(DomeLampDrv == OFF)&&(LockState == Locked))
     {
              if(TURN_LEFT_LAMP_OUT||TURN_RIGHT_LAMP_OUT||(BUZZER_OUT)) systemsleep = 0;
		if(systemsleep < 1250)systemsleep++;
		else if(systemsleep == 1250)
		{
		       //systemsleep++;
		       WakeState = 1;  
		       LIN_DISENABLE; 
			TURN_AD_RIGHT_EN;
		      //LIN_ENABLE;
			 CAN_EN_OFF;
			AWU_Init(WakeCycle);

		}
     }
     else systemsleep = 0;
}
/*********************************************************************/
/*           �͹��Ĵ�����                                             */
/*�������ƣ�void OneSecondWake(void)                                                 */
/*��    �룺��                                                                                           */
/*��    ������                                                                                           */
/*����Ҫ��                                                                                         */
/*��    �ߣ�   rexlei                 ���ʱ�䣺2008.06.11                        */
/*��������: ����һ������ȷRKE�����Զ�˯��                    */
/*                                                                                                                      */
/*�����޸ļ�¼                                                                                   */
/*�޸�����      ����         �޸�����                   ��ע                */
/*********************************************************************/
void OneSecondWake(void)
{

      if(RKEStandByWakeupState == 0x55 )
      {                   
            if (RKEStandByWakeupcnt < 250) 
            {
                  RKEStandByWakeupcnt++;
                  if(RKE_COMMAND_StandBy_state == 0x11)
                  {
                      RKE_COMMAND_StandBy_state = 0;
                      RKEStandByWakeupState = 0;
                      //BATTERY_SAVE_ON;
                  }
            }
            else if (RKEStandByWakeupcnt == 250)
            {
                 //CAN_MCR |= CMCR_INRQ ;				
                 //while ( (CAN_MSR & ~CMSR_INAK) );	
                 //LINUART_LINCmd(DISABLE);
                  //WakeInit();
                  //    ImmoOnTime = 0;       //����ָʾ�Ƽ���������0
                  WakeState = 1;        //��˯�߱�־
                  RKEStandByWakeupState = 0;
                 AWU_Init(WakeCycle);
                 //LIN_DISENABLE;
				 CAN_EN_OFF;
				 
            }

        }                

}
 //�͹��Ĵ������
/*********************************************************************/
/*           �͹��Ĵ�����                                             */
/*�������ƣ�void InOutputWake(void)                                                 */
/*��    �룺��                                                                                           */
/*��    ������                                                                                           */
/*����Ҫ��                                                                                         */
/*��    �ߣ�   rexlei                 ���ʱ�䣺2008.05.29                        */
/*��������:  �����˳��͹���                                                     */
/*                                                                                                                      */
/*�����޸ļ�¼                                                                                   */
/*�޸�����      ����         �޸�����                   ��ע                */
/*********************************************************************/
 void InOutputWake(void)
{
       static u16 ptime;
       
       if (WakeState == 1) 
       {    
            ENABLE_RX_INT;

	     //BATTERY_SAVE_OFF;
            Clear_WDT();  ////////////////////////////////////////////////
            SWSZstate = 0x55 ;

	     //if(wakelintime < 12502)wakelintime++;
          /* 
         
            if(Alarm_Actiated == 0x55 )
            {
	            ptime++;
	            if( ptime > 16 ) ptime=0;
		     if( ptime <1 )	IMMO_LED_ON;
		     else if(ptime <=3) IMMO_LED_OFF;
	            else if( ptime <=4) IMMO_LED_ON ;
	            else IMMO_LED_OFF ;
            }
	     else
	     {
                   ptime++;
	            if( ptime > 16 ) ptime=0;
		     if( ptime <2)	IMMO_LED_ON;
		     //else if(ptime <=6) IMMO_LED_OFF;
	            //else if( ptime <=9 ) IMMO_LED_ON ;
	            else IMMO_LED_OFF;
	      }
		 */
			
            //if(ledcnt == 0)
            //BATTERY_SAVE_OFF; //30����ʱ�䵽�رսڵ�̵���       
		WWDG_Refresh(0x7f);
            //delay_10us(3);   //�˵��Ⲩ
            //�жϻ�������    
            nop();
            nop();
            nop();
            RKE_POWER_ON;
            nop();
            nop();            
            nop();
            RKE_POWER_ON;            
            nop();
            nop();
            nop();           
            RkeScanCnt = 0;
            //WaveFilterCnt = 0;
            while(RkeScanCnt < RKEShortDownTime)
            {
                    Clear_WDT();	
                    delay_10us(100);
                    RkeScanCnt++;
                    if(WaveFilterCnt >= 5)
                    {
                            //WWDG_Refresh(0x7f);
				WakeUp();
				//WakeState = 0 ; 
				RKEStandByWakeupState = 0x55;
				//HALTUPSTATE=0x55;
                            //StandByState == Pressed;
				//gLocalWakeupFlag = 1;
				//gNetWorkStatus.bussleep = 0;
				//WakeState = 0;
				wakerkestate = 0x55;

				//LIN_ENABLE;
				CAN_EN_ON;

				WaveFilterCnt = 0;
				//LIN_Init();
				break;
                    }         
            }
            WaveFilterCnt = 0;

            ScanH4021InData(); 
            
            ScanStandByHazzardKeys();
           
            ScanStandByDoorAjarSwitch();

            ScanStandByCrashInSignal();

            ScanStandbyIgnSwitch();

           // ScanStandbySmallLampSwitch();


			
            //�����źš���������ײ���ƹ�  �˳��͹���ģʽ
            if(StandByState == Pressed)//||(BCMtoGEM_AlarmStatus != Armed))
            {
			StandByState = 0 ;                
			//WakeState = 0 ; 
			WakeUp();
			WakeState = 0;

			wakerkestate = 0x55;
			//System_Init();
			//open can
			//CAN_WakeUp();
			//gNetWorkStatus.bussleep = 0;
			//gLocalWakeupFlag = 1;
			//HALTUPSTATE=0x55;
			// OPEN LIN
			//LIN_ENABLE;
			CAN_EN_ON;

             }
            if(WakeState != 0)
            {      
                DISABLE_RX_INT ;
                RKE_SHUT_DOWN;
                nop();
                nop();
                RKE_SHUT_DOWN; 
                delay_10us(5);
                nop();
                nop();
                halt();         //����͹���
                nop();
                nop();
            }            
        }            


}


//halt; //˯������
/*********************************************************************/
/*          BCM��һ������EEPROM��ʼ��                                             */
 /*�������ƣ�void ONSEINITEeprom(void)                                                 */
/*��    �룺��                                                                                           */
/*��    ������                                                                                           */
/*����Ҫ�󣺳�ʼ���е��ñ�����ֻ����һ��            */
/*��    �ߣ�   rexlei                 ���ʱ�䣺2008.05.27                        */
/*��������:  ��ʼ��:BCM����/����/RKE���кſռ�        */
/*                                           DTC���ϴ���ռ�/��ʼ״̬          */
/*�����޸ļ�¼                                                                                   */
/*�޸�����      ����         �޸�����                   ��ע                */
/*********************************************************************/
void ONSEINITEeprom(void)
{
     u32 temp;
     u8   res,i;
     if ( ONESstate != 0x1234 )
     {
            //����ONESSTATE
            for(i = 0; i<EECNT; i++)
            {
                temp = (u32)(&ONESstate);                                   
                res = 0x12;
                FLASH_ProgramByte(temp, res);
                temp++ ;                                   
                res = 0x34;
                FLASH_ProgramByte(temp, res);
                if(ONESstate == 1234)
                {
                     break;
                }
            }
            // ����Ĭ��ΪCV8
            for(i = 0 ; i<EECNT;i++)
            	{
                   temp = (u32)(&VehicleType) ;                                   
                   res =  CV101;
                   FLASH_ProgramByte(temp, res);
                   if(VehicleType == CV8)
                   	{
                      break;
                   }
            	}
            //��ʼ��Ϊ0x0000

            //��ʼ����0x00000000
            for(i=0;i<EECNT;i++)
            {
                temp = (u32)(&PassWord1) ;                                   
                res = 0x00;
                FLASH_ProgramByte(temp, res);
                temp++ ;                                   
                res = 0x00;
                FLASH_ProgramByte(temp, res);
                temp = (u32)(&PassWord2) ;                                   
                res = 0x00;
                FLASH_ProgramByte(temp, res);
                temp++ ;                                   
                res = 0x00;
                FLASH_ProgramByte(temp, res);
                if ((PassWord1 == 0x0000)&&(PassWord2 ==0x0000)) break;
            }
            //��ʼ��DTC�ռ�
            ClearDTC();
            //RKE���кſռ�
            RX_SerialNum = 0x00000000 ;
            SAVE_SERIAL_NUMBER(0);
            SAVE_SERIAL_NUMBER(1);
            SAVE_SERIAL_NUMBER(2);
            SAVE_SERIAL_NUMBER(3);
            //clear BCMnumber adress
            Clear_WDT();   
            for ( i=0 ; i<EECNT;i++)
            {
                temp = (u32)( &BCMnumber );                                                                                                               
                res = 0x00 ;
                FLASH_ProgramByte(temp, res);
                temp++;
                res = 0x00 ;
                FLASH_ProgramByte(temp, res);
                temp++;
                res = 0x00 ;                                                        
                FLASH_ProgramByte(temp, res);
                temp++;
                res = 0x00 ;
                FLASH_ProgramByte(temp, res);
                if(BCMnumber == 0x00000000)break;
            }                 
            //�ٶȸ�Ӧ�����ſ���
            /*
              for( i = 0; i < EECNT ; i++ )
             {
                  temp = (u32)( &LockSpeedStudyState );
                  //Clear_WDT();
                  FLASH_ProgramByte(temp, 0);                
                  if( LockSpeedStudyState == 0 )
                  {
                       break;
                  }
             }*/
     }
}

/**
  * @brief Reports the name of the source file and the source line number where
  * the assert error has occurred.
  * User can add his own implementation to report the file name and line number.
  * ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line)
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  */

unsigned char Weeprommain(unsigned long temp,unsigned char value)
{    
    uu8 cnt;
	@far u8 *pFlash;
	//for()
	FLASH_DeInit( );
	FLASH_Unlock(FLASH_MEMTYPE_DATA);  //�������ȡ��д����
	FLASH_Unlock(FLASH_MEMTYPE_PROG);
	
	
	pFlash = (@far u8 *) temp;
	for(cnt = 0 ; cnt < 10; cnt++)
	{
		FLASH_ProgramByte(temp, value);
		if(*pFlash == value) break;
	}

    if(*pFlash == value) return 0;
	else return 1;
	
}



#ifdef FULL_ASSERT
void assert_failed (u8 *file, u16 line)
#else
void assert_failed (void)
#endif
{
  /* This variable holds the number of call to assert_failed function */
//  AssertFailedCounter++;
}

