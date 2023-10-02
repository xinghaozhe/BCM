/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              defrost_drv.h
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
#include "defrost_drv.h"
#include "horn_drv.h"
#include "adc_drv.h"


/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
u8   DefrostKeySta;     //³ýËª¿ª¹Ø×´Ì¬
u8   BatVoltageState;   //µç³ØµçÑ¹×´Ì¬
u8   EngineState;       //ÒýÇæ×´Ì¬
u8   DefrostDriverState; //ºó³ýËª¹¤×÷×´Ì¬  Õï¶ÏÓÃ
/*********************************************************************
Name    :   void ScanDefrostSwitch(void)
Function:   V101BCM function description
Input   :   REAR_DEFROSTER_KEY_IN
Output  :   DefrostKeySta<Pressed/Unpressed>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanDefrostSwitch(void)
{
    static uchar Defrostcnt;
    
    if((!R_DEFROSTER_SW) &&(IGNstate == ON))
    {
        if(Defrostcnt < 10 )Defrostcnt++;
        else if(Defrostcnt == 10 )
        {
             Defrostcnt++;
             if(DefrostKeySta == Unpressed)
             {
                    DefrostKeySta = Pressed;
             }
        }
    }
    else
    {
          Defrostcnt = 0;
    }
}
/*********************************************************************
Name    :   void ScanBatteryVoltage(void)
Function:   V101BCM function description
Call    :   GetADCresultAverage(BatVolADchl)
Input   :   Batterry a/d
Output  :   BatVoltageState<batvolLow/batvolOkay>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
/* battery voltage >= 8v --> return FALSE*/
/* battery voltage <  8v --> return TRUE */

void ScanBatteryVoltage(void)
{
	uint  batvol;
	static uchar batlowCnt,bathighCnt;

	batvol = GetADCresultAverage(2);
       battervalue = batvol ;
	if (batvol < BATTERY_VOLTAGE_9V) //if battery voltage is lower then 8v
	{
            bathighCnt = 0;
            if (BatVoltageState == batvolLow) return;		
            if (batlowCnt < BATTERY_VOLTAGE_CNT)
            {
                  batlowCnt++;
            }
            else if (batlowCnt == BATTERY_VOLTAGE_CNT)
            {
                  batlowCnt++;
                  BatVoltageState = batvolLow;
				  //gNMCANBatFlag = 1;
            }
	}
	else
	{
		batlowCnt = 0;
		if (BatVoltageState == batvolOkay) return;
		if (bathighCnt < BATTERY_VOLTAGE_CNT)
		{
			bathighCnt++;
		}
		else if (bathighCnt == BATTERY_VOLTAGE_CNT)
		{
			bathighCnt++;
			BatVoltageState = batvolOkay;
			//gNMCANBatFlag = 1;
		}
	}
}

/*********************************************************************
Name    :   void JudgeDefrostDriver(void)
Function:   V101BCM function description
Call    :   GetADCresultAverage(BatVolADchl)
Input   :   IGNstate/BatVoltageState/EngineSpeed/DefrostKeySta
Output  :   REAR_DEFROSTER_OUT = HIGH/LOW
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
/* Rear Defroster driver */       

void JudgeDefrostDriver(void)
{

    static u32   DefrostKeepTime;

    EngineState |= ENGINE_700RPM; //debug program???????

	//when IGN=OFF or battery low or engine rotate speed slow,defroster turn off
    if ((IGNstate == OFF) || (BatVoltageState == batvolLow)) //|| (EngineState & ENGINE_700RPM))
    {   
          DefrostKeepTime =0;
    }    
    if(DefrostKeepTime == 0) //(!REAR_DEFROSTER_OUT)    		
    {
          if (DefrostKeySta == Pressed)
          { 
                   DefrostKeySta = Unpressed;
                   DefrostKeepTime =DEFROST_TIMEOUT_PHASE;
          }
    }
    else
    {    	
        if (DefrostKeySta == Pressed)
        { 
                 DefrostKeySta = Unpressed;
                 DefrostKeepTime = 0;//REAR_DEFROSTER_OFF; //turn off rear defroster
        } 
    }
   if (DefrostKeepTime  != 0)
   {
          DefrostKeepTime--;
          REAR_DEFROSTER_ON;
		  CAN_RDefrostSW_ON;
          DefrostDriverState = 1;
    }
    else
    {
          REAR_DEFROSTER_OFF;
		  CAN_RDefrostSW_OFF;
          DefrostDriverState = 0;
    }
}    	
 /*********************************************************************
 end of the defrost_drv.c file
*********************************************************************/

