
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              beam_drv.h
  Build Author:          Kevin   
  creation date:         2007/08/21
  Version of Software:   V101_BCM_v0.1                         
  Version of Hardware:   V101_BCM_v0.1
  Description:  MCU:ST79
                Development Tools: 
  Function List:   
    1. 
    2. 
  History:         
      <author>      Kevin
      <date>        2007/06/05
      <version >    v0.0.0 
      <description> build this moudle                   
*********************************************************************/

/*********************************************************************
 INCLUDE HEADER FILES
*********************************************************************/
#include "gpio_macro.h"
#include "horn_drv.h"
#include "warm_drv.h"
#include "defrost_drv.h"
#include "foglamp_drv.h"
#include "beam_drv.h"
#include "turnlamp_drv.h"
#include "rke_drv.h"

/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
uchar HighBeamSwitchState;  //远光灯开关状态
uchar LowBeamSwitchState;   //近光灯开关状态
uchar Buzzertime;           //轰鸣器叫时间计数
uchar LOWBeamDriverState;   //近光灯驱动状态
/*********************************************************************
Name    :   void ScanHighLowBeamSwitch(void)
Function:   V101BCM function description
Input   :   HIGH_BEAM_SW/LOW_BEAM_SW
Output  :   HighBeamSwitchState/LowBeamSwitchState<Pressed/Unpressed>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanHighLowBeamSwitch(void)
{
	static u8 uHighCnt,pHighCnt; //滤波计数
	static u8 uLowCnt,pLowCnt;
    //有修改 高边信号改为低边开关信号
	//scan high beam switch(high signal valid)
	if (!HIGH_BEAM_SW)
	{
		uHighCnt = 0;
		if (pHighCnt < KEY_FILTER_CNT)
		{
			pHighCnt++;
		}
		else if (pHighCnt == KEY_FILTER_CNT)
		{
			pHighCnt++;
			HighBeamSwitchState = Pressed;
		}
	}
	else
	{
		pHighCnt = 0;
		if (uHighCnt < KEY_FILTER_CNT)
		{
			uHighCnt++;
		}
		else if (uHighCnt == KEY_FILTER_CNT)
		{
			uHighCnt++;
			HighBeamSwitchState = Unpressed;
		}
	}    

	//scan low beam switch(low signal valid)
	if (!LOW_BEAM_SW)
	//if (H4021Data & DRIVER_DOOR_IS_OPEN)
	{
		uLowCnt = 0;
		if (pLowCnt < KEY_FILTER_CNT)
		{
			pLowCnt++;
		}
		else if (pLowCnt == KEY_FILTER_CNT)
		{
			pLowCnt++;
			LowBeamSwitchState = Pressed;
		}
	}
	else
	{
		pLowCnt = 0;
		if (uLowCnt < KEY_FILTER_CNT)
		{
			uLowCnt++;
		}
		else if (uLowCnt == KEY_FILTER_CNT)
		{
			uLowCnt++;
			LowBeamSwitchState = Unpressed;
		}
	}    
} 

/*********************************************************************
Name    :   void JudgeHighLowBeamDriver(void)
Function:   V101BCM function description
Input   :   IGNstate / LowBeamSwitchState / KeyInState / HighBeamSwitchState
Output  :   LOW_BEAM_LAMP_ON / LOW_BEAM_LAMP_OFF
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
   2>Author		: lei
     date		:2007/10/25
     Description:回家功能增加 
*********************************************************************/
void JudgeLowBeamDriver(void)
{
	static uint  LowBeamGoHomeCnt;       //近光灯回家功能时间计数
       static uchar GoHomeNumber;           //回家过程状态标记
	static uchar GoHomeTime;             //两秒钟计数
	static uchar highlightswich_2s;      //远光灯开关2秒计数
	static uchar LowBeam_Oldstate;       //近光灯开关状态保存
	static uchar Gohomestate;
       //增加远光灯控制 
	//turn on/off the low beam

        if ((IGNstate == ON) && (LowBeamSwitchState == Pressed)) //&& (HighBeamSwitchState	==Unpressed))
        {
            LOW_BEAM_LAMP_ON;
            //HIGH_BEAM_OFF;
            LOWBeamDriverState = 1 ;
        }
        if((IGNstate == ON) && (LowBeamSwitchState == Pressed) && (HighBeamSwitchState	==  Pressed))
        {   
            HIGH_BEAM_ON;
            LOW_BEAM_LAMP_ON;
            LOWBeamDriverState = 1;
        }
        if((IGNstate == ON) &&((SmallLampSwitchState == Unpressed)|| (HighBeamSwitchState	==  Unpressed)))
        {
            HIGH_BEAM_OFF;
            //LOW_BEAM_LAMP_OFF;
            LOWBeamDriverState = 0 ;
        }
        if ((IGNstate == ON) && (LowBeamSwitchState == Unpressed)) //&& (HighBeamSwitchState	==Unpressed))
        {
            LOW_BEAM_LAMP_OFF;
			 HIGH_BEAM_OFF;  //20090521  更改关近光灯同时关闭远光灯
            //HIGH_BEAM_OFF;
            LOWBeamDriverState = 0 ;
        }
        if((LowBeamGoHomeCnt == 0) && (IGNstate == OFF))
        {
            HIGH_BEAM_OFF;
            LOW_BEAM_LAMP_OFF;
        }
        
	//low beam delay fading out,for going home.	
	//两秒限制
	if(GoHomeNumber!=0)
	{
	     if(GoHomeNumber !=5)
	     {
             GoHomeTime++;
	     }
            if((GoHomeTime>250)&&(GoHomeNumber!=5))
            {
                GoHomeNumber=0;
            }       
	}
	// go home 控制程序
    if ((IGNstate == OFF) && (LowBeamSwitchState == Unpressed) && (SmallLampSwitchState ==Unpressed)&&(GoHomeNumber==0))
    {
        GoHomeNumber=1;
    }
    if(GoHomeNumber==1)
    {
        if ((IGNstate == OFF) && (LowBeamSwitchState == Unpressed) && (SmallLampSwitchState ==Pressed))
       	{
       	    GoHomeNumber=2;
       	}
    }    
    if(GoHomeNumber==2)
    {
        if ((IGNstate == OFF) && (LowBeamSwitchState == Pressed) && (SmallLampSwitchState ==Pressed))
       	{
       	     GoHomeNumber=3;
       	}
    }
	if(GoHomeNumber==3)
	{
            if ((IGNstate == OFF) && (LowBeamSwitchState == Unpressed) && (SmallLampSwitchState == Pressed))
            {
                GoHomeNumber=4;
            }
	}
	if(GoHomeNumber==4)
	{
            if ((IGNstate == OFF) && (LowBeamSwitchState == Unpressed) && (SmallLampSwitchState ==Unpressed))
            {
       	        GoHomeNumber=5;
			    LowBeamGoHomeCnt = 22500;	//22500*8ms=180s
			    Buzzertime = 125 ;          // 1s 有修改
			    Gohomestate = 0x55 ;
           }
	}	
	//新增加功能更改20080616
      if ((DoorState == AllDoorIsClosed ) && ( Gohomestate == 0x55 ) && (LowBeamGoHomeCnt > 7500))
      	{
      	     Gohomestate = 0 ;
            LowBeamGoHomeCnt = 7500;	//7500*8ms=60s
            // Buzzertime = 125 ;          // 1s 有修改
      }
      else if ((LowBeamGoHomeCnt <= 7500))
      {
             Gohomestate = 0 ;
      }

	if((GoHomeNumber==5)&&(LowBeamGoHomeCnt!=0)&&(IGNstate == OFF))
	{  
	     LowBeamGoHomeCnt--;	   
            LOW_BEAM_LAMP_ON;       
            LOWBeamDriverState = 1;
	}
	if((GoHomeNumber==5)&&(LowBeamGoHomeCnt!=0)&&(IGNstate == OFF)&&(LowBeamSwitchState == Pressed))
	{
            LOW_BEAM_LAMP_OFF;    
            GoHomeNumber = 0;
            LOWBeamDriverState = 0;
 	}
       if(((GoHomeNumber==5)&&(LowBeamGoHomeCnt==0)))
	{
            LOW_BEAM_LAMP_OFF; 
             GoHomeNumber = 0;
            LOWBeamDriverState = 0;
	}
	if((LowBeamGoHomeCnt != 0)&& ((IGNstate == ON )||(SmallLampSwitchState == Pressed)))  //增加小灯关闭回家条件
	{
            LOW_BEAM_LAMP_OFF; 
            LowBeamGoHomeCnt  = 0 ;
	}
    //如果有灯未关关闭此功能   最新更改
	if((LowBeamSwitchState == Pressed) ||(SmallLampSwitchState == Pressed))// || (FrontFogLampSwitchState == Pressed) ||(RearFogLampSwitchState == Pressed))20100712取消前后雾灯对回家功能的影响
	{
             LowBeamGoHomeCnt  = 0;   //new
	}
} 
/*********************************************************************
 end of the beam_drv.c file
*********************************************************************/

