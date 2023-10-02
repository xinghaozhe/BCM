/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              foglamp_drv.c
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
#include "gpio_macro.h"
#include "foglamp_drv.h"
#include "horn_drv.h"
#include "warm_drv.h"
#include "beam_drv.h"

/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
u8 FrontFogLampSwitchState;    //前雾灯开关状态
u8 RearFogLampSwitchState;     //后雾灯开关状态

/*********************************************************************
Name    :   void ScanFogLampSwitch(void)
Function:   V101BCM function description
Input   :
  H4021Data<FRONT_FOG_SW_Pressed>
			H4021Data<REAR_FOG_SW_Pressed>
Output  :   FrontFogLampSwitchState <Pressed / Unpressed>
			RearFogLampSwitchState <Pressed / Unpressed>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanFogLampSwitch(void)
{   
    static u8 fflpCnt,ffluCnt;
    static u8 rflpCnt,rfluCnt;
    
 	//scan front fog lamps switch state
    if (!FRONT_FOG_SW) 
    {  
        ffluCnt = 0;
        if (fflpCnt < KEY_FILTER_CNT)
   	{ 
   	    fflpCnt++;
   	}
        else if(fflpCnt == KEY_FILTER_CNT)
   	{  
   	    fflpCnt++;
   	    FrontFogLampSwitchState = Pressed;
   	}
    }
    else
    {  
        fflpCnt = 0;
        if (ffluCnt < KEY_FILTER_CNT)
	{
   	   ffluCnt++;
   	}
        else if(ffluCnt == KEY_FILTER_CNT)
   	{  
   	    ffluCnt++;
              FrontFogLampSwitchState = Unpressed;
   	}
    }
    

    //更改后雾灯开关取消车型影响  20090831 更改
    if (!REAR_FOG_SW) 
    {
           if(rfluCnt <KEY_FILTER_CNT) rfluCnt++;
           else if(rfluCnt == KEY_FILTER_CNT)
           {
                  rfluCnt++;
                  if(RearFogLampSwitchState == Pressed)
                  {
                         RearFogLampSwitchState =Unpressed;
                  }
                  else
                  {
                       // if((SmallLampSwitchState == Pressed) &&((LowBeamSwitchState == Pressed) || (FrontFogLampSwitchState == Pressed) ))RearFogLampSwitchState =Pressed;
                  }
           }
    }
    else
    {
          rfluCnt = 0;
    }

}

/*********************************************************************
Name    :   void JudgeFogLampDriver(void)
Function:   V101BCM function description
Input   :
  FrontFogLampSwitchState <Pressed / Unpressed>
			RearFogLampSwitchState <Pressed / Unpressed>
Output  :   FRONT_FOG_LAMP_ON/OFF
			REAR_FOG_LAMP_ON/OFF
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void JudgeFogLampDriver(void)
{
	//judge front fog lamps deiver
	if ((IGNstate == ON) && (SmallLampSwitchState == Pressed) && (FrontFogLampSwitchState == Pressed))
	{
		FRONT_FOG_LAMP_ON;
	}
	else
	{
		FRONT_FOG_LAMP_OFF;
	}
	//judge front fog lamps deiver|| (HighBeamSwitchState == 	Pressed) 
	//20090521 更改取消远光的激活条件  
	//if ((IGNstate == ON) && (RearFogLampSwitchState == Pressed)&&(SmallLampSwitchState == Pressed) &&((LowBeamSwitchState == Pressed) || (FrontFogLampSwitchState == Pressed) ))
	//{
	//	REAR_FOG_LAMP_ON;  
	//}	
	//else if((RearFogLampSwitchState == Unpressed)||(SmallLampSwitchState == Unpressed)||(IGNstate == OFF) )
	//{
	//       //RearFogLampSwitchState = Unpressed;
	//	   REAR_FOG_LAMP_OFF;
	//       RearFogLampSwitchState =Unpressed;
	//}

}


/*********************************************************************
 end of the foglamp_drv.c file
*********************************************************************/

