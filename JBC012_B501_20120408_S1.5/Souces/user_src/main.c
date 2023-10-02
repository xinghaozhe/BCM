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
uchar   WakeState;            //睡眠唤醒标志变量
uint    RkeScanCnt;           //RKE换醒信号扫描  
uchar   WaveFilterCnt;        //RKE换醒滤波时间
uint    WakeInTime;           //延时进入睡眠 时间  调试用变量
uint    WakeUpTime;           //唤醒时间           调试用变量
uchar   StandByState;         ////有门信号、报警、碰撞、灯光  退出低功耗模式
uchar   StandTIM3state;
ulong  StandbyTime;  //进入低功耗时间计数
uchar  RKEStandByWakeupState; //RKE唤醒标志
uchar  RKEStandByWakeupcnt;   //时间1秒计数
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
/*            进入睡眠模式初始化                                     */
/*程序名称：void WakeInit(void)                                      */
/*输    入：无                                                       */
/*输    出：无                                                       */                                             
/*调用要求：进入睡眠模式前调用                                       */
/*功能描述:                                                          */
/*作    者：                    完成时间：2008.01.11                 */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void WakeInit(void)
{
	uchar temp;

    //WakeState = 1;        //置睡眠标志

    
    AWU->CSR1 = 0x10;
    AWU->TBR  = 0x0A;
    AWU->APR  = 0x3e;
    AWU->CSR1 |=0x02;
    
    temp = AWU->CSR1;	
}
/*********************************************************************/
/*            进入睡眠模式初始化                                     */
/*程序名称：void SystemClock(void)                                      */
/*输    入：无                                                       */
/*输    出：无                                                       */                                             
/*调用要求：进入睡眠模式前调用                                       */
/*功能描述:                                                          */
/*作    者：                    完成时间：2008.06.11                 */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
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
/*            睡眠模式换醒                                           */
/*程序名称：void WakeUp(void)                                        */
/*输    入：无                                                       */
/*输    出：无                                                       */
/*调用要求：进入睡眠模式前调用                                       */
/*作    者：                    完成时间：2008.01.11                 */
/*功能描述:                                                          */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void WakeUp(void)
{
    uchar  temp;
    static uchar ii;
    WakeState = 0;           //置唤醒标志
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
    ENABLE_RX_INT;   //使能RKE
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
    static uchar  CANTimeCnt;            //CAN总线发送时间间隔计数
    
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
				CANSend();                        //CAN发送程序

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
				//CANSend();                        //CAN发送程序
				Did2esave();

				UDSDTC_main();

				UDSonCANDiag();

				// UDSonCAN_netmain();

				CANRX();                                    //CAN接收处理

				//scan bcm all input signal
				ScanIgnSwitch();                      //扫描点火开关  结果在变量  IGNstate

                ScanH4021InData();                   //扫描4021数据结果在变量 H4021Data 

                ScanBatteryVoltage();                //扫描电池电压  结果在变量 BatVoltageState

                ScanDefrostSwitch();                 //扫描后除霜开关  结果在变量 DefrostKeySta

                ScanHornSwitch();                    //扫描喇叭开关    结果在变量 HornSwitchState

                ScanKeyInState();                    //扫描钥匙状态开关  结果在变量 KeyInState

                ScanAllDoorState();                 //扫描车门位置状态  结果在变量 DoorState

                TRUNKwarm();                           //后备箱报警处理
                
                ScanCrashInSignal();    //  20120201 路试取消          //扫描碰撞信号状态  结果在变量 CrashState   变量 LockDrvCmd 该变量意义不明
                
                ScanAllLockState();   //????              //扫描门锁闭锁状态  结果在变量 LockState

                ScanCentralLockSwitch();        //中控闭锁解锁开关 结果在变量 同时检测LockState CrashState LockDrvCmd 

                ScanTrunkSwitch();                 //扫描行李箱

                ScanRkeKeys();

                ScanSeatbeltBuckleState();       //安全带状态扫描  结果在变量 SeatState

                ScanSeatPositionState();           //副驾安全带状态  结果在变量 SeatState

                ScanTurnLampState();               //转向灯状态  结果在变量 TurnLampState

                ScanTurnLampKeys();               //转向灯开关  结果在变量 	TurnLampDrv  此函数未完全看明白

                ScanWindowKeys();    //   1               //扫描车窗状态 结果在 WinKeyState

		  ScanSmallLampSwitch();

                ScanFortifySWState();              //设防开关状态扫描 为低不进入设防 已经进入设防退出设防
                //judge bcm all driver
                JudgeDefrostDriver();                 //除霜控制

                Clear_WDT();
                
                JudgeHornDriver();                     //喇叭控制

                JudgeDomeLampDriver();           //顶灯控制

                JudgeLockDriver();

                MachineKeyDrv();

                JudgeTurnLampDrv();

		  buzzdrv2();

                JudgeWarmTypeAndDriver();              

                FindCar();                                    //寻车

                WindowDriver();                //车窗驱动                

                WarmStatusArithmetic ();          //bcm警戒状态生成

                SFLED();                

		  Turnvcclow();
          
                InPutWake();                             //判断进入睡眠模式条件
                              
            }
        }

        //低功耗处理程序
        InOutputWake();
    }
    
}
/*********************************************************************/
/*           低功耗处理函数                                             */
/*程序名称：void InPutWake(void)                                                 */
/*输    入：无                                                                                           */
/*输    出：无                                                                                           */
/*调用要求：                                                                                         */
/*作    者：   rexlei                 完成时间：2008.06.11                        */
/*功能描述: 唤醒一秒无正确RKE命令自动睡眠                    */
/*                                                                                                                      */
/*程序修改记录                                                                                   */
/*修改日期      作者         修改内容                   备注                */
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
		       //此段需要移动到网络管理中
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
/*           低功耗处理函数                                             */
/*程序名称：void OneSecondWake(void)                                                 */
/*输    入：无                                                                                           */
/*输    出：无                                                                                           */
/*调用要求：                                                                                         */
/*作    者：   rexlei                 完成时间：2008.06.11                        */
/*功能描述: 唤醒一秒无正确RKE命令自动睡眠                    */
/*                                                                                                                      */
/*程序修改记录                                                                                   */
/*修改日期      作者         修改内容                   备注                */
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
                  //    ImmoOnTime = 0;       //防盗指示灯计数变量清0
                  WakeState = 1;        //置睡眠标志
                  RKEStandByWakeupState = 0;
                 AWU_Init(WakeCycle);
                 //LIN_DISENABLE;
				 CAN_EN_OFF;
				 
            }

        }                

}
 //低功耗处理程序
/*********************************************************************/
/*           低功耗处理函数                                             */
/*程序名称：void InOutputWake(void)                                                 */
/*输    入：无                                                                                           */
/*输    出：无                                                                                           */
/*调用要求：                                                                                         */
/*作    者：   rexlei                 完成时间：2008.05.29                        */
/*功能描述:  进入退出低功耗                                                     */
/*                                                                                                                      */
/*程序修改记录                                                                                   */
/*修改日期      作者         修改内容                   备注                */
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
            //BATTERY_SAVE_OFF; //30分钟时间到关闭节电继电器       
		WWDG_Refresh(0x7f);
            //delay_10us(3);   //滤掉尖波
            //判断唤醒条件    
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


			
            //有门信号、报警、碰撞、灯光  退出低功耗模式
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
                halt();         //进入低功耗
                nop();
                nop();
            }            
        }            


}


//halt; //睡眠命令
/*********************************************************************/
/*          BCM第一次启动EEPROM初始化                                             */
 /*程序名称：void ONSEINITEeprom(void)                                                 */
/*输    入：无                                                                                           */
/*输    出：无                                                                                           */
/*调用要求：初始化中调用本程序只运行一次            */
/*作    者：   rexlei                 完成时间：2008.05.27                        */
/*功能描述:  初始化:BCM密码/车型/RKE序列号空间        */
/*                                           DTC故障代码空间/启始状态          */
/*程序修改记录                                                                                   */
/*修改日期      作者         修改内容                   备注                */
/*********************************************************************/
void ONSEINITEeprom(void)
{
     u32 temp;
     u8   res,i;
     if ( ONESstate != 0x1234 )
     {
            //更改ONESSTATE
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
            // 车型默认为CV8
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
            //初始化为0x0000

            //初始密码0x00000000
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
            //初始化DTC空间
            ClearDTC();
            //RKE序列号空间
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
            //速度感应中央门控锁
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
	FLASH_Unlock(FLASH_MEMTYPE_DATA);  //程序调试取消写保护
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

