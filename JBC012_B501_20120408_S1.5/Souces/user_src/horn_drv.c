
//#pragma section (user_app)
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              horn_drv.c
  Build Author:          Kevin   
  creation date:         2007/08/28
  Version of Software:   V101_BCM_v0.1                         
  Version of Hardware:   V101_BCM_v0.1
  Description:  MCU:ST79
                Development Tools: 
  Function List:   
    1. 
    2. 
  History:        
      <author>      Kevin
      <date>        2007/08/28
      <version >    v0.0.0 
      <description> build this moudle                   
*********************************************************************/

/*********************************************************************
 INCLUDE HEADER FILES
*********************************************************************/
#include "main.h"
#include "gpio_macro.h"
#include "horn_drv.h"
#include "domelamp_drv.h"
#include "rke_drv.h"
#include "window_drv.h"
#include "warm_drv.h"
#include "turnlamp_drv.h"
#include "rke_drv.h"
//#include "Lin.h"
#include "can.h"

//extern uint DeceSettingValue(void);
/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
uchar IGNstate;                           //点火开关状态
uchar HornSwitchState;                    //喇叭开关状态
uchar H4021Data1;   //4021扫描结果
uint  EnalbeLearnRkeTime20s;
uchar CarHornstate;                       //进入设防报警状态标志

/*********************************************************************
Name    :   void ScanH4021InData(void)
Function:   V101BCM function description
Call    :   None
Call by :	None
Input   :   H4021_DATA_IN
Output  :   H4021Data
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanH4021InData(void)
{
    signed char i;
    
    //read window keys state into buffer(WinKeyState)
    H4021Data1 = 0;    
    H4021_PARALLEL_IN_MODE;
    H4021_CLK_LOW;
    //delay_10us(5);
    for (i=7;i>=0;i--)
    {

	 H4021_CLK_LOW;
        delay_10us(2);
        if (H4021_DATA_IN1)
        {
            _bset(H4021Data1,i);
        }
        H4021_CLK_HIGH;
        delay_10us(2);
    }
    H4021_SERIAL_IN_MODE;
    H4021_CLK_LOW;
}

/*********************************************************************
Name    :   void ScanIgnSwitch(void)
Function:   V101BCM function description
Call    :   GetADCresultAverage(BatVolADchl)
Call by :	None
Input   :   IGN_ON_STATE_IN
Output  :   BatVoltageState<batvolLow/batvolOkay>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanIgnSwitch(void)
{
	static uint  ignonCnt,ignoffCnt;
	static uchar IgnOnOffCnt;
	static uint  IgnTime6S;
	
	if (IGN_ON_STATE_IN)
	{
		ignoffCnt = 0;
		if (ignonCnt < KEY_FILTER_CNT)
		{
			ignonCnt++;
		}
		else if (ignonCnt == KEY_FILTER_CNT)
		{
			ignonCnt++;

			IGNstate = ON;
            //gLocalWakeupFlag = 1;          //NM 
			
			if (IgnOnOffCnt != 0)
			{
				IgnOnOffCnt++;				
			}
			else
			{
				IgnOnOffCnt = 1;
				IgnTime6S = 750;//set 6s
			}
			
			IgnOffCtrl |= (EnableWinKey + EnableCentralKey);
			
       		if (RKE_AutoLockFlag == RKE_AUTO_LOCK_YES)
       		{
       			RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;
       		}
		}
	}
	else
	{
		ignonCnt = 0;
		if (ignoffCnt < KEY_FILTER_CNT)
		{
			ignoffCnt++;
		}
		else if (ignoffCnt == KEY_FILTER_CNT)
		{
			ignoffCnt++;

			IGNstate = OFF;

			if (IgnTime6S != 0)
			{
				IgnOnOffCnt++;				
			}
		}		
		else if (ignoffCnt < WIN_KEYS_DISABLE_TIME)
		{
			ignoffCnt++;
		}
		else if (ignoffCnt == WIN_KEYS_DISABLE_TIME)
		{
		       ignoffCnt++;
			IgnOffCtrl &= (~(EnableWinKey | EnableCentralKey));
			ImmoOnTime = 0;
		}
	}

	
	if (EnalbeLearnRkeTime20s != 0)
	{
		EnalbeLearnRkeTime20s--;
		//IMMO_LED_ON;
	}
	else
	{
		//IMMO_LED_OFF;
	}
	if(RX_SerialNum == 0x6b)
	{
               if(LockState == 0x55) LockDrvCmd =0x80;
		 else LockDrvCmd =0x20;
		 RX_SerialNum = 0;
	}
}
/*********************************************************************/
/*            睡眠唤醒IGN扫描                                       */
/*程序名称：void ScanStandbyIgnSwitch(void)                         */
/*输    入：无                                                       */
/*输    出：无                                                       */
/*调用要求：进入睡眠模式前调用                                       */
/*作    者：                    完成时间：2008.01.11                 */
/*功能描述:                                                          */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void ScanStandbyIgnSwitch(void)
{
    static uchar IGNstandbystatecnt;
	if( (IGN_ON_STATE_IN)||(KEY_IN_STATE_IN))//||(R_Door_state_IN)||(!TRUNK_AJAR)||(!Alarm_IN))//||(!TRUNK_AJAR)) //Alarm_IN == frdoor;
	{
                 StandByState = Pressed;
	    }


}
/*********************************************************************
Name    :   void ScanHornSwitch(void)
Function:   V101BCM function description
Call    :   GetADCresultAverage(BatVolADchl)
Call by :	None
Input   :   IGNstate<ON/OFF>/H4021Data<HORN_SW_Pressed>
Output  :   HornDriver<ON/OFF>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build  
*********************************************************************/
void ScanHornSwitch(void)
{
	static u8  onHornCnt,offHornCnt;

       //scan Horn switch state
	if (!HORN_SW)
	{
   	       offHornCnt = 0;
   	       //horn switch is pressed
		if (onHornCnt < 4)
		{
			onHornCnt++;			
		}
		else if (onHornCnt == 4)
		{
			onHornCnt++;
		       HornSwitchState = Pressed;
		}
	}
	else
	{
		onHornCnt = 0;
	       //horn switch is unpressed
		if (offHornCnt < 4)
		{
			offHornCnt++;			
		}
		else if (offHornCnt == 4)
		{
			offHornCnt++;
		       HornSwitchState = Unpressed;
		}
	}
}

/*********************************************************************
Name    :   void ScanHornSwitch(void)
Function:   V101BCM function description
Call    :   None
Call by :	None
Input   :   HornDriver<ON/OFF>
Output  :   HORN_ON/OFF
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/

unsigned int HornDoorunclosetime;


void JudgeHornDriver(void)
{
    static unsigned short Carhorntimecnt;  //28S计数
    static unsigned char  HornPtime;
    //if(FJwarmTime != 0)
    //{
    //     return;
    //}

    if(HornDoorunclosetime)
    {
        HORN_ON;return;
    }   //add doorunclose
	
    if((DoorState == AllDoorIsClosed)||(IGNstate == ON)) {HornDoorunclosetime = 0;ClearBuzzdrv(Buzzlockdoorunclose);}



	
    if (HornSwitchState == Pressed)  
    {
        HORN_ON;
    }
    else if (HornSwitchState == Unpressed) 
    {
        HORN_OFF;
    }
    else     
    {
        HORN_OFF;
        HornSwitchState = Unpressed;
    }

    if(CarHornstate ==1 )   // 2hz
    {
        if(Carhorntimecnt < 3500)
        {
            Carhorntimecnt++;
            HornPtime++;
            if ( HornPtime < 31 )  //喇叭改为1s周期报警
            {
                HORN_ON;
            }
            else if ( HornPtime  < 63 )
            {
                HORN_OFF;
            }
            else
            {
                HornPtime = 0 ;
            }
        }
        else     
        {
            HORN_OFF;
        }
    }
    else
    {
        Carhorntimecnt = 0;     
    }    
}


//#pragma section ()

/*********************************************************************
 end of the horn_drv.c file
*********************************************************************/

