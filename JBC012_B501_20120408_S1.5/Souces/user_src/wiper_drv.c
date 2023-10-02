
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              wiper_drv.c
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
**********************************************************************/

/*********************************************************************
 INCLUDE HEADER FILES
*********************************************************************/
#include "share.h"
#include "gpio_macro.h"
#include "wiper_drv.h"
#include "horn_drv.h"
#include "adc_drv.h"


/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
uint	FrontWiperIntTime;
uchar   FrontWiperHighDrv;
uchar  	FrontWiperDrv;
uchar  	RearWiperDrv;
uchar  	WiperParkSta;

/*********************************************************************
Name    :   void GetFrontWiperIntTime(void)
Function:   V101BCM function description
Input   :   FRONT_WIPER_PARK_IN / REAR_WIPER_PARK_IN
Output  :   WiperParkSta <fWiperParkYes / fWiperParkNo>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void GetFrontWiperIntTime(void)
{
	uint ADValueTemp;

	//ADValueTemp = GetADCresultAverage(FWiperRADchl);
	ADValueTemp = GetADCresultAverage(0);

	if (ADValueTemp < WIPER_INT_6_ADV)
	{
		FrontWiperIntTime = WIPER_INT_6_TIME;
	}
	else if (ADValueTemp < WIPER_INT_5_ADV)
	{
		FrontWiperIntTime = WIPER_INT_5_TIME;
	}
	else if (ADValueTemp < WIPER_INT_4_ADV)
	{
		FrontWiperIntTime = WIPER_INT_4_TIME;
	}
	else if (ADValueTemp < WIPER_INT_3_ADV)
	{
		FrontWiperIntTime = WIPER_INT_3_TIME;
	}
	else if (ADValueTemp < WIPER_INT_2_ADV)
	{
		FrontWiperIntTime = WIPER_INT_2_TIME;
	}
	else 
	{
		FrontWiperIntTime = WIPER_INT_1_TIME;
	}
}
/*********************************************************************
Name    :   void ScanWiperParkSignal(void)
Function:   V101BCM function description
Input   :   FRONT_WIPER_PARK_IN / REAR_WIPER_PARK_IN
Output  :   WiperParkSta <fWiperParkYes / fWiperParkNo>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanWiperParkSignal(void)
{
	static uchar fWiperParkYesCnt,fWiperParkNoCnt;
	static uchar rWiperParkYesCnt,rWiperParkNoCnt;

    static uchar FwiperParkState,FwiperParkOldState,FFwiperParkcnt;
	// scan front wiper park keys 
    if (!F_WIPER_PARK)
    {
        fWiperParkNoCnt = 0;
        if (fWiperParkYesCnt < wiper_park_filter_cnt)
        {
        	fWiperParkYesCnt++;
        }
        else if (fWiperParkYesCnt == wiper_park_filter_cnt)
        {
        	fWiperParkYesCnt++;
        	//WiperParkSta |= fWiperParkYes;
        	FwiperParkState = 0x55;
        }
    }
    else
    {
        fWiperParkYesCnt = 0;
        if (fWiperParkNoCnt < WIPER_KEY_FILTER_CNT)
        {
        	fWiperParkNoCnt++;
        }
        else if (fWiperParkNoCnt == WIPER_KEY_FILTER_CNT)
        {
        	fWiperParkNoCnt++;
        	//WiperParkSta &= ~fWiperParkYes;
        	FwiperParkState = 0x00;
        }
    }

    if(FwiperParkOldState != FwiperParkState)
    {
        FwiperParkOldState =  FwiperParkState ;
        if(FwiperParkState == 0x55)
        {
            WiperParkSta |= fWiperParkYes;
        }
    }
    else
    {
        WiperParkSta &= ~fWiperParkYes;
    }
 
	// scan rear wiper park keys 	   
    if (!R_WIPER_PARK)
    {
        rWiperParkNoCnt = 0;
        if (rWiperParkYesCnt < WIPER_KEY_FILTER_CNT)
        {
        	rWiperParkYesCnt++;
        }
        else if (rWiperParkYesCnt == WIPER_KEY_FILTER_CNT)
        {
        	rWiperParkYesCnt++;
        	WiperParkSta |= rWiperParkYes;
        }
    }
    else
    {
        rWiperParkYesCnt = 0;
        if (rWiperParkNoCnt < WIPER_KEY_FILTER_CNT)
        {
        	rWiperParkNoCnt++;
        }
        else if (rWiperParkNoCnt == WIPER_KEY_FILTER_CNT)
        {
        	rWiperParkNoCnt++;
        	WiperParkSta &= ~rWiperParkYes;
        }
    }
}

/*********************************************************************
Name    :   void ScanWasherSwitch(void)
Function:   V101BCM function description
Input   :   FRONT_WASHER_KEY_IN / REAR_WASHER_KEY_IN / IGNstate
Output  :   FrontWiperDrv/RearWiperDrv
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanWasherSwitch(void)
{
	static uchar fWasherOnCnt,fWasherOffCnt;
	static uchar rWasherOnCnt,rWasherOffCnt;

	// judge front wiper's  high and slow switch state
	if ((FrontWiperDrv & FrontWiperSlowOn) || (FrontWiperHighDrv & FrontWiperHighOn))
	{
		//if front wiper is running in high/slow mode,and ignore front washer switch's state.
		FrontWiperDrv &= ~(FrontWiperWasherOn2 + FrontWiperWasherOn);
		fWasherOnCnt = fWasherOffCnt = 0;
	}
	// scan front washer switch's state
    else if (F_WASHER_SW)
    {
           fWasherOffCnt = 0;
           if (fWasherOnCnt < WASHER_KEY_FILTER_CNT)
           {
                  fWasherOnCnt++;
           }
           else if (fWasherOnCnt == WASHER_KEY_FILTER_CNT)
           {
                 FrontWiperDrv |= FrontWiperWasherOn2;
           }
    }
    else
    {
            fWasherOnCnt = 0;
            if (fWasherOffCnt < KEY_FILTER_CNT)
            {
                  fWasherOffCnt++;
            }
            else if (fWasherOffCnt == KEY_FILTER_CNT)
            {
                fWasherOffCnt++;
                if (FrontWiperDrv & FrontWiperWasherOn2)
                {
              	    FrontWiperDrv &= ~FrontWiperWasherOn2;
                        FrontWiperDrv |= FrontWiperWasherOn;                        
                }
            }
    }

    // scan rear washer switch's state 
    if(R_WASHER_SW)   
    {
	    rWasherOffCnt = 0;
           if (rWasherOnCnt < WASHER_KEY_FILTER_CNT)
           {
                   rWasherOnCnt++;
           }
           else if (rWasherOnCnt == WASHER_KEY_FILTER_CNT)
           {
                  RearWiperDrv |= RearWiperWasherOn2;                        
           }
    }
   else
   {
        rWasherOnCnt = 0;
        if (rWasherOffCnt < KEY_FILTER_CNT)
        {
             rWasherOffCnt++;
        }
        else if (rWasherOffCnt == KEY_FILTER_CNT)
        {
             rWasherOffCnt++;
             if (RearWiperDrv & RearWiperWasherOn2)
             {
                  RearWiperDrv &= ~RearWiperWasherOn2;
                  RearWiperDrv |= RearWiperWasherOn;                        
             }
        }
   }
}

/*********************************************************************
Name    :   void ScanWiperSwitch(void)
Function:   V101BCM function description
Call    :   GetFrontWiperIntTime()/ScanWiperParkSignal()/
			ScanWasherSwitch()
Call by :	main()			
Input   :   FRONT_WASHER_KEY_IN / REAR_WASHER_KEY_IN / IGNstate
Output  :   FrontWiperDrv/RearWiperDrv
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanWiperSwitch(void)
{
	static uchar fWiperIntOnCnt,fWiperHighOnCnt,fWiperSlowOnCnt,rWiperIntOnCnt;
	static uchar fWiperIntOffCnt,fWiperHighOffCnt,fWiperSlowOffCnt,rWiperIntOffCnt;
    
       // scan front wiper int resistor ad value 
       GetFrontWiperIntTime();
       // scan front+rear wiper park signal
       ScanWiperParkSignal();
       // scan front+rear washer switch signal 
       ScanWasherSwitch();

	// if IGN=OFF,STOP front/rear wiper
	if (IGNstate == OFF)
	{
		fWiperHighOnCnt = 0;
		fWiperSlowOnCnt = 0;
		fWiperIntOnCnt = 0;
		rWiperIntOnCnt = 0;
		
		//if front wiper high switch is pressed and ign=off,
		//front wiper turn off high deiver and turn on slow driver until front 
		// wiper park signal arrived.
		if (FrontWiperHighDrv & FrontWiperHighOn)
		{			
			FrontWiperHighDrv &= ~FrontWiperHighOn;
			FrontWiperDrv = FrontWiperSlowOn;
		}
		else
		{
			FrontWiperDrv = FrontWiperOff;
		}
		RearWiperDrv = RearWiperOff;
		return;
	}
	
	// scan front wiper int switch's state
    if(F_WIPER_INT_SW) 
    {
        fWiperIntOffCnt = 0;      
        if (fWiperIntOnCnt < WIPER_KEY_FILTER_CNT)
        {
        	fWiperIntOnCnt++;
        }
        else if (fWiperIntOnCnt == WIPER_KEY_FILTER_CNT)
        {
        	fWiperIntOnCnt++;
        	FrontWiperDrv |= FrontWiperIntOn;
        }
    }
    else 
    {
    	fWiperIntOnCnt = 0;
    	if (fWiperIntOffCnt < WIPER_KEY_FILTER_CNT_OFF)
    	{
    		fWiperIntOffCnt++;
    	}
    	else if (fWiperIntOffCnt == WIPER_KEY_FILTER_CNT_OFF)
    	{
    		fWiperIntOffCnt++;
    		FrontWiperDrv &= ~FrontWiperIntOn;
    	}
    }

	// scan front wiper slow switch's state
    if (F_WIPER_SLOW_SW)
    {
        fWiperSlowOffCnt = 0;
        if (fWiperSlowOnCnt < WIPER_KEY_FILTER_CNT)
        {
        	fWiperSlowOnCnt++;
        }
        else if (fWiperSlowOnCnt == WIPER_KEY_FILTER_CNT)
        {
        	fWiperSlowOnCnt++;
        	FrontWiperDrv |= FrontWiperSlowOn;
        }
    }
    else
    {
        fWiperSlowOnCnt = 0;
        if (fWiperSlowOffCnt < WIPER_KEY_FILTER_CNT_OFF)
        {
        	fWiperSlowOffCnt++;
        }
        else if (fWiperSlowOffCnt == WIPER_KEY_FILTER_CNT_OFF)
        {
        	fWiperSlowOffCnt++;
        	FrontWiperDrv &= ~FrontWiperSlowOn;
        }
    }

	// scan front wiper high switch's state
    if (F_WIPER_HIGH_SW)
    {
        fWiperHighOffCnt = 0;
        if (fWiperHighOnCnt < WIPER_KEY_FILTER_CNT)
        {
        	fWiperHighOnCnt++;
        }
        else if (fWiperHighOnCnt == WIPER_KEY_FILTER_CNT)
        {
        	fWiperHighOnCnt++;
        	FrontWiperHighDrv |= FrontWiperHighOn;
        }
    }
    else
    {
        fWiperHighOnCnt = 0;
        if (fWiperHighOffCnt < WIPER_KEY_FILTER_CNT)
        {
        	fWiperHighOffCnt++;
        }
        else if (fWiperHighOffCnt == WIPER_KEY_FILTER_CNT)
        {
        	//when front wiper high switch is released, 
        	//then turn off high driver,and turn on slow driver wiper
        	//untill front park signal arrived.
        	fWiperHighOffCnt++;
        	fWiperSlowOffCnt = 0;
        	if(FrontWiperHighDrv & FrontWiperHighOn)
        	{
        	    FrontWiperDrv |= FrontWiperSlowOn;	
        	}
        	FrontWiperHighDrv &= ~FrontWiperHighOn;
        }
    }
    
	// scan rear wiper int switch 
    if (R_WIPER_INT_SW)
    {
        rWiperIntOffCnt = 0;
        if (rWiperIntOnCnt < WIPER_KEY_FILTER_CNT)
        {
        	rWiperIntOnCnt++;
        }
        else if (rWiperIntOnCnt == WIPER_KEY_FILTER_CNT)
        {
        	rWiperIntOnCnt++;
        	RearWiperDrv |= RearWiperIntOn;
        }
    }
    else
    {
        rWiperIntOnCnt = 0;
        if (rWiperIntOffCnt < WIPER_KEY_FILTER_CNT_OFF)
        {
        	rWiperIntOffCnt++;
        }
        else if (rWiperIntOffCnt == WIPER_KEY_FILTER_CNT_OFF)
        {
        	rWiperIntOffCnt++;
        	RearWiperDrv &= ~RearWiperIntOn;
        }
    }
}

/*********************************************************************
Name    :   void JudgeFrontWiperDriver(void)
Function:   V101BCM function description
Call    :   none
Input   :   FrontWiperDrv / FrontWiperCycleCnt / fWiperCnt
Output  :   FRONT_WIPER_SLOW_ON / FRONT_WIPER_SLOW_OFF
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void JudgeFrontWiperDriver(void)
{
	static u16  fWiperIntCnt,fWasherCnt;
	static u16  HParktimeCNT;
	static u8   ParkDTCstate;
	if(RetCode == 0xffff)
	{
	   if(VehicleType != CV8) return;
	}
    if((ParkDTCstate == 0x55) && (((FrontWiperHighDrv & FrontWiperHighOn) == 0)||(FrontWiperDrv == FrontWiperOff)))
    {
		FRONT_WIPER_SLOW_OFF;
		FRONT_WIPER_HIGH_OFF;
		ParkDTCstate = 0;
	}
	// Judge front wiper driver priority and driver     
    if (FrontWiperHighDrv & FrontWiperHighOn)
    {
            //===============================================
            //if front slow's switch is holding pressed,front wiper high driver
            fWasherCnt = 0;
            fWiperIntCnt = 0;
            //FRONT_WIPER_SLOW_OFF;
            FRONT_WIPER_SLOW_ON;
            FRONT_WIPER_HIGH_ON;
    }
    else if (FrontWiperDrv & (FrontWiperSlowOn | FrontWiperWasherOn2))
    {      
            //===============================================
            //if front slow's or front washer's switch is holding pressed,
            //front wiper slow driver
            fWasherCnt = 0;
            fWiperIntCnt = 0;
            FRONT_WIPER_HIGH_OFF;
            FRONT_WIPER_SLOW_ON;
    }
    else if (FrontWiperDrv & FrontWiperWasherOn)
    {
              //===============================================
              //after front washer switch is released, front wiper run 3+1 cycle.
              //means: running 3 cycle->stop 6s->continue running 1 cycle->stop
              fWiperIntCnt = 0;
		if (fWasherCnt == 0)
		{
                     FRONT_WIPER_SLOW_ON;
                     if (WiperParkSta & fWiperParkYes)
                     fWasherCnt++;			// 1 cycle, in park position
		}
		//else if (fWasherCnt == 1)
		//{
        //             FRONT_WIPER_SLOW_ON;
        //             if (!(WiperParkSta & fWiperParkYes))
        //             fWasherCnt++;			//exit park position
		//}
		//else if (fWasherCnt == 2)
		//{
        //            FRONT_WIPER_SLOW_ON;
        //            if (WiperParkSta & fWiperParkYes)
        //            fWasherCnt++;			// 2 cycle, in park position
		//}
		//else if (fWasherCnt == 3)
		//{
		//	FRONT_WIPER_SLOW_ON;
		//	if (!(WiperParkSta & fWiperParkYes))
		//		fWasherCnt++;			//exit park position
		//}
		else if (fWasherCnt == 1)
		{
			FRONT_WIPER_SLOW_ON;
			if (WiperParkSta & fWiperParkYes)
			{
				FRONT_WIPER_SLOW_OFF;
				fWasherCnt++;			// 3 cycle, in park position
			}
		}
             else if (fWasherCnt == 2)
		{
			FRONT_WIPER_SLOW_ON;
			if (WiperParkSta & fWiperParkYes)
			{
				FRONT_WIPER_SLOW_OFF;
				fWasherCnt++;			// 3 cycle, in park position
			}
		}
		else if (fWasherCnt < WIPER_INT_PERIOD)
		{
			FRONT_WIPER_SLOW_OFF;
			fWasherCnt++;				//stop 6s, in park position
		}
		else if (fWasherCnt == WIPER_INT_PERIOD)
		{
			FRONT_WIPER_SLOW_ON;		//start running 4 cycle
			if (!(WiperParkSta & fWiperParkYes))
			{
				fWasherCnt = 0;			// continue 4 cycle, exit park position
				                        //waiting park signal
				FrontWiperDrv &= ~FrontWiperWasherOn;
			}	
		}
		else
		{
			fWasherCnt = 0;
		}
   }
   else if (FrontWiperDrv & FrontWiperIntOn)
   {
	   //===============================================
	   //front wiper int driver--int time(stop time)=(FrontWiperIntTime)s
	   //means: running 1 cycle -> stop (FrontWiperIntTime)s -> running 1 cycle ......
	   fWasherCnt = 0;
	   if (fWiperIntCnt == 0)
	   {
                 FRONT_WIPER_SLOW_ON;
                 if (!(WiperParkSta & fWiperParkYes))
                 fWiperIntCnt++;
	   }
	   else if ( fWiperIntCnt < FrontWiperIntTime)
	   {
		   fWiperIntCnt++;
		   if (WiperParkSta & fWiperParkYes)
		   {
			   FRONT_WIPER_SLOW_OFF; 
		   }
	   }
	   else
	   {
		   fWiperIntCnt = 0;
	   }
     }
    else
    {
           fWiperIntCnt = 0;
           fWasherCnt = 0;
           FrontWiperDrv = FrontWiperOff;
           if (WiperParkSta & fWiperParkYes)
           {
               FRONT_WIPER_SLOW_OFF;
           }
    }	

    //PARK 信号雨刮保护
    if(FRONT_WIPER_SLOW_OUT)
    {
        HParktimeCNT++;
		if(WiperParkSta & fWiperParkYes){ HParktimeCNT = 0;ParkDTCstate = 0;}
		if(HParktimeCNT > 2500)
		{
            HParktimeCNT = 0;
			ParkDTCstate = 0x55;
		}
	}
	else
	{
        HParktimeCNT = 0;
	}
    

	
}    

/*********************************************************************
Name    :   void JudgeRearWiperDriver(void)
Function:   V101BCM function description
Call    :   none
Input   :   RearWiperDrv / RearWiperCycleCnt / rWiperCnt
Output  :   REAR_WIPER_SLOW_ON / REAR_WIPER_SLOW_OFF
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void JudgeRearWiperDriver(void)
{
	static u16 rWiperIntCnt,rWasherCnt;
    static u16 RParktimeCNT;
	static u8  RParkDTCstate;
       static u8 ignstate_old=0;
	
	if(RetCode == 0xffff)
	{
	   //if(VehicleType != CV8) return;
	}

    if((RParkDTCstate == 0x55) && (RearWiperDrv == RearWiperOff))
    {
		//FRONT_WIPER_SLOW_OFF;
		REAR_WIPER_OFF;
		RParkDTCstate = 0;
	}
       if(ignstate_old != IGNstate)
       {
             ignstate_old = IGNstate;
	      if((IGNstate == ON)&&((WiperParkSta & rWiperParkYes)==0))REAR_WIPER_ON;    //20100719	 
       }
      // if((IGNstate == ON)&&((WiperParkSta & rWiperParkYes)==0))REAR_WIPER_ON;    //20100719
	
	// Judge rear wiper driver priority and driver 
	if (RearWiperDrv & RearWiperWasherOn2)
	{
             //===============================================
             //if rear washer switch is holding pressed,rear wiper is running. 
             REAR_WIPER_ON;       
             rWasherCnt = 0;
             rWiperIntCnt = 0;
	}
	else if (RearWiperDrv & RearWiperWasherOn )		
	{
              //===============================================
              //after rear washer switch is released, rear wiper run 3+1 cycle.
              //means: running 3 cycle->stop 6s->continue running 1 cycle->stop
              rWiperIntCnt = 0;
		if (rWasherCnt == 0)
		{
                    REAR_WIPER_ON;
                    if (WiperParkSta & rWiperParkYes)
                    rWasherCnt++;			// 1 cycle, in park position
		}
		else if (rWasherCnt == 1)
		{
                     REAR_WIPER_ON;
                     if (!(WiperParkSta & rWiperParkYes))
                     rWasherCnt++;			//exit park position
		}
		else if (rWasherCnt == 2)
		{
                     REAR_WIPER_ON;
                     if (WiperParkSta & rWiperParkYes)
                     rWasherCnt++;			// 2 cycle, in park position
		}
		else if (rWasherCnt == 3)
		{
                     REAR_WIPER_ON;
                     if (!(WiperParkSta & rWiperParkYes))
                     rWasherCnt++;			//exit park position
		}
		else if (rWasherCnt == 4)
		{
                     REAR_WIPER_ON;
                     if (WiperParkSta & rWiperParkYes)
                     rWasherCnt++;			// 3 cycle, in park position
		}
		else if (rWasherCnt < WIPER_INT_PERIOD)
		{  
			REAR_WIPER_OFF;           
			rWasherCnt++;				//stop 6s, in park position
		}
		else if (rWasherCnt == WIPER_INT_PERIOD)
		{
			REAR_WIPER_ON;				//start running 4 cycle
			if (!(WiperParkSta & rWiperParkYes))
			{
				rWasherCnt = 0;			// continue 4 cycle, exit park position
				                        //waiting park signal
				RearWiperDrv &= ~RearWiperWasherOn;
			}	
		}
	}
	else if (RearWiperDrv & RearWiperIntOn)
	{
              //===============================================
              //rear wiper int driver--int time(stop time)=6s
              //means: running 1 cycle -> stop 6s -> running 1 cycle ......
              rWasherCnt = 0;
		if (rWiperIntCnt == 0)
		{
			REAR_WIPER_ON;
			if (!(WiperParkSta & rWiperParkYes))
				rWiperIntCnt++;
		}
		else if ( rWiperIntCnt < WIPER_INT_PERIOD)
		{
			rWiperIntCnt++; 	
			if (WiperParkSta & rWiperParkYes)
			{
				REAR_WIPER_OFF; 
			}
		}
		else
		{
			rWiperIntCnt = 0;
		}
	}
	else
	{
		//===============================================
		//no rear wiper driver command, 
		//then stop rear wiper after waiting a rear wiper's parking signal.
		rWasherCnt = 0;
		rWiperIntCnt = 0;
		RearWiperDrv = RearWiperOff;
		if (WiperParkSta & rWiperParkYes)
		{
		    REAR_WIPER_OFF;
		}
	}

    //PARK 信号雨刮保护
    if(REAR_WIPER_OUT)
    {
    	RParktimeCNT++;
    	if(WiperParkSta & fWiperParkYes){ RParktimeCNT = 0;RParkDTCstate = 0;}
    	if(RParktimeCNT > 2500)
    	{
    		RParktimeCNT = 0;
    		RParkDTCstate = 0x55;
    	}
    }
    else
    {
    	RParktimeCNT = 0;
    }

	
} 

/*********************************************************************
 end of the wiper_drv.c file
*********************************************************************/

