
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              interiorlamp_drv.h
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
#include "share.h"
#include "gpio_macro.h"
#include "horn_drv.h"
#include "domelamp_drv.h"
#include "warm_drv.h"
#include "lock_drv.h"
#include "rke_drv.h"
#include "TIMER2_3.h"
#include "main.h"
extern void TIM2TIM3_CCR_WRITE(MTIM_TypeDef * TIMX, uc8 CC_Channel,   u16 CCR_Value);
extern uchar RKEStandByWakeupState;

/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
uchar DomeLampDrv;     //顶灯驱动标记
ulong  fade_out_time;     //亮灯时间计数
unsigned char count;
uchar RKELOCKstate;   // 0x00  0x55 0x0aa
ulong Battertime;
/*********************************************************************
Name    :   void JudgeDomeLampDriver(void)
Function:   V101BCM function description
Input   :   DomeLampDrv
Output  :   
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void JudgeDomeLampDriver(void)
{
	static u8  bLastLampDrv, bOpening, bClosing;
	static u16 duty;

    //juege interior lamps driver 
    DomeLampsDriver();
    //the Dome lamp fade in
	if(bOpening)
	{
		if(duty > 5000)//T1PERIOD)
		{
			bOpening = 0;
			duty = 5002;//T1PERIOD;
		}
		else
		{
			duty += 57;				//fade in time = (5000-41)/57*8ms=700ms
		}
		TIM2_CCR_WRITE(3, duty);
	}
	
	//the Dome lamp fade out
	if(bClosing)
	{
		if(duty < 57)
		{
			bClosing = 0;
			duty = 0;
			TIM2_CCR_WRITE( 3, duty);
			DOME_LAMP_OFF;
			return;
		}
		else
		{
			duty -= 57;				//fade out time = 5000/57*8ms=700ms
		}
		TIM2_CCR_WRITE( 3, duty);
	}

	if(DomeLampDrv == bLastLampDrv) return;
	bLastLampDrv = DomeLampDrv;
    if (DomeLampDrv == ON)
    {
	    bOpening = 1; 
	    bClosing = 0;
	    duty = 41;
    }
    else
    {
	    bClosing = 1;
	    bOpening = 0;
    	duty = 5000;//T1PERIOD;
    }
}


/*********************************************************************
Name    :   void DomeLampsDriver(void)
Function:   V101BCM function description
Input   :   DoorState / IGNstate / RKE_COMMAND
Output  :   DomeLampDrv<ON/OFF>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
   2>Author		: lei
     date		:2007/11/19
     Description: 增加顶灯熄灭两种方式
*********************************************************************/
void DomeLampsDriver(void)
{
    static uchar  IGNstate_0ld;      //上一次点火钥匙状态
    static uchar  DoorState_Old;     //上一次点车门状态

    //step1: interior fading out control
    if (fade_out_time) 
    {
        fade_out_time--;
        if (DomeLampDrv != ON)
        {
            DomeLampDrv = ON;
        }
    }
    else
    {
        if (DomeLampDrv != OFF)
        {
            DomeLampDrv = OFF;
        }
    }   



/////////////////////////////////////////////////////////////////////////////


     if(IGNstate_0ld != IGNstate)
     {
          IGNstate_0ld = IGNstate;
          if(IGNstate == OFF)                    //更改20081128
		  {
		      if(DoorState == AllDoorIsClosed) fade_out_time = 3125; 
		      else fade_out_time = 75000;
		  }
          if(IGNstate == ON )  fade_out_time = 0;
     }
      if((IGNstate == ON ) &&(DoorState == AllDoorIsClosed)) fade_out_time = 0;
     
     if(DoorState_Old != DoorState)
     {
           DoorState_Old = DoorState;
           if(DoorState & AllDoorIsOpen)  fade_out_time = 75000 ;
           if((DoorState == AllDoorIsClosed)&&(fade_out_time != 0))fade_out_time = 3125 ;
     }
     
     if(RKELOCKstate == 0x55)
     {
           RKELOCKstate = 0;
           if(IGNstate == OFF ) 
		   {
                if(DoorState & AllDoorIsOpen) fade_out_time = 7500 ;
				else
				{
                    fade_out_time = 3125 ;
				}
		   }
     }
     if(RKELOCKstate == 0xaa)
     {
           RKELOCKstate = 0;
           if(DoorState == AllDoorIsClosed)fade_out_time = 0 ;
     }

}


/*********************************************************************
 end of the interiorlamp_drv.c file
*********************************************************************/

