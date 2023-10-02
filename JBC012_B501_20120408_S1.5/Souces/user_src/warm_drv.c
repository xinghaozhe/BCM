/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              warm_drv.c
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
#include "horn_drv.h"
#include "warm_drv.h"
#include "defrost_drv.h"
#include "foglamp_drv.h"
#include "beam_drv.h"
#include "turnlamp_drv.h"
#include "rke_drv.h"
#include "main.h"
#include"Adc_drv.h"
/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
uchar KeyInState;                  			     //钥匙状态
uchar SmallLampSwitchState;          	    	 //小灯开关状态
uchar DoorState;                      			 //门状态
uchar CarState;
uchar SeatState;                      			 //安全带状态
uchar WarmType;                       			 //警告类型
uchar BuzzerOnCnt,BuzzerDuty,BuzzerPeriod;   	 //轰鸣器周期
uchar SeatWarnType;                              //安全带警告类型
uchar SeatWarnOld_state;                         //上一次报警状态保存
uint  CarSpeed[3];                                  //车速  通过CAN总线 给值
uchar FORTIFYSW_state;                           //设防开关状态
u16   TrunkWarmTime;   
uchar RKEopenTrunkWarm ;
extern uint BUZZLocktimecnt ;
uchar RKEBatteryVoltage_turn;
extern unsigned char RKESETBUZZ;
uchar Buzzertime;           //轰鸣器叫时间计数

BUZZER buzzdrvStrategy[5];
/*********************************************************************/
/*              设防开关     状态扫描                                */
/*程序名称：void ScanFortifySWState(void)                            */
/*输    入：FORTIFY_SW                                               */
/*输    出：FORTIFYSW_state                                          */                                             
/*调用要求：在低功耗中调用                                           */
/*作    者：lei                 完成时间：2008.01.23                 */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void ScanFortifySWState(void)
{
    static uchar FortifySWONCnt,FortifySWOFFCnt;   //滤波变量
    if(!FORTIFY_SW)
    {
        FortifySWOFFCnt = 0;
        if(FortifySWONCnt < KEY_FILTER_CNT) FortifySWONCnt++;
        else if(FortifySWONCnt == KEY_FILTER_CNT)
        {
             FortifySWONCnt++;
             FORTIFYSW_state = 0x55;
        }
    }
    else
    {
        FortifySWONCnt = 0;
        if(FortifySWOFFCnt < KEY_FILTER_CNT) FortifySWOFFCnt++;
        else if(FortifySWOFFCnt == KEY_FILTER_CNT)
        {
             FortifySWOFFCnt++;
             FORTIFYSW_state = 0x00;
        }
    }
}
/*********************************************************************
Name    :   void ScanKeyInState(void)
Function:   V101BCM function description
Input   :
  KEY_IN_STATE_IN
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanKeyInState(void)
{
	static uchar keyInCnt,keyOutCnt;
	
	if (KEY_IN_STATE_IN)
	{
		keyInCnt = 0;
		if (keyOutCnt < KEY_FILTER_CNT)
		{
			keyOutCnt++;
		}
		else if (keyOutCnt == KEY_FILTER_CNT)
		{
			keyOutCnt++;
			KeyInState = KeyIsInHole;
		}
	}
	else
	{
		keyOutCnt = 0;
		if (keyInCnt < KEY_FILTER_CNT)
		{
			keyInCnt++;
		}
		else if (keyInCnt == KEY_FILTER_CNT)
		{
			keyInCnt++;
			KeyInState = KeyIsOutHole;
		}		
	}
}


/*********************************************************************
Name    :   void ScanSmallLampSwitch(void)
Function:   V101BCM function description
Input   :
  SMALL_LAMP_SW
Output  :   SmallLampSwitchState <Pressed / Unpressed>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/

void ScanSmallLampSwitch(void)
{
	static uchar lamphighCnt,lamplowCnt;
	//应该为低边有效，此处程序逻辑可能有问题
	if (!SMALL_LAMP_SW)
	{
		lamplowCnt = 0;
		if (lamphighCnt < KEY_FILTER_CNT)
		{
			lamphighCnt++;
		}
		else if (lamphighCnt == KEY_FILTER_CNT)
		{
			lamphighCnt++;
			SmallLampSwitchState = Pressed;
		}
	}
	else
	{
		lamphighCnt = 0;
		if (lamplowCnt < KEY_FILTER_CNT)
		{
			lamplowCnt++;
		}
		else if (lamplowCnt == KEY_FILTER_CNT)
		{
			lamplowCnt++;
			SmallLampSwitchState = Unpressed;
		}
	}
}
/*********************************************************************/
/*            睡眠唤醒SmallLamp扫描                                  */
/*程序名称：void ScanStandbySmallLampSwitch(void)                    */
/*输    入：无                                                       */
/*输    出：无                                                       */
/*调用要求：进入睡眠模式前调用                                       */
/*作    者：                    完成时间：2008.01.11                 */
/*功能描述:                                                          */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void ScanStandbySmallLampSwitch(void)
{
    static uchar ScanStandbySmallLampstatecnt;
	if (!SMALL_LAMP_SW)
	{
		StandByState = Pressed;
	}


}

/*********************************************************************
Name    :   void ScanAllDoorState(void)
Function:   V101BCM function description
Input   :
  H4021Data<DRIVER_DOOR_IS_OPEN/OTHER_DOOR_IS_OPEN/TRUNK_IS_OPEN>
Output  :   DoorState
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanAllDoorState(void)
{
    static uchar DDopenCnt,DDcloseCnt;
    static uchar ODopenCnt,ODcloseCnt;
    static uchar TDopenCnt,TDcloseCnt;
    static uchar FDopencnt,	FDclosecnt;

    static uint  TunrkAD;
	
    //sacn driver door ajar signal
    if (!D_DOOR_AJAR)
    {  
        DDcloseCnt = 0;
        if (DDopenCnt < KEY_FILTER_CNT)
   	{
   	    DDopenCnt++;
   	}
        else if (DDopenCnt == KEY_FILTER_CNT)
    	{
   	    DDopenCnt++;
   	    DoorState |= DriverDoorIsOpen;
           if (RKE_AutoLockFlag == RKE_AUTO_LOCK_YES)
   	    {
   			RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;
   	    }
   	}
    }
    else
    {  
        DDopenCnt=0;
        if (DDcloseCnt < KEY_FILTER_CNT)
        {
            DDcloseCnt++;
        }
        else if ( DDcloseCnt == KEY_FILTER_CNT)
        {
       	    DDcloseCnt++;
       	    DoorState &= ~DriverDoorIsOpen;
       }
    }

    //scan other door ajar state    
    if (!OTHER_DOOR_AJAR)
    {  
        ODcloseCnt = 0;
        if (ODopenCnt < KEY_FILTER_CNT)
       	{
       	    ODopenCnt++;
       	}
        else if(ODopenCnt == KEY_FILTER_CNT)
       	{
       	    ODopenCnt++;
       	    DoorState |= OtherDoorIsOpen;
       	    if (RKE_AutoLockFlag == RKE_AUTO_LOCK_YES)
       	    {
       			RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;
       	    }

       	}
    }
    else
    {  
        ODopenCnt=0;
        if (ODcloseCnt < KEY_FILTER_CNT)
       	{
       	    ODcloseCnt++;
       	}
        else if (ODcloseCnt == KEY_FILTER_CNT)
       	{ 
       	    ODcloseCnt++;
       	    DoorState &= ~OtherDoorIsOpen;
       	}
    }
    if(!Alarm_IN)
    {
        FDclosecnt = 0;
        if (FDopencnt < KEY_FILTER_CNT)
       	{
       	   FDopencnt++;
       	}
        else if (FDopencnt == KEY_FILTER_CNT)
       	{
       	   FDopencnt++;
       	   DoorState |= FDdoorisopen;
			if (RKE_AutoLockFlag == RKE_AUTO_LOCK_YES)
			{
			         RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;
			}
		   //if (RKE_COMMAND == RKECMD_LOCK) CarState = CarIsAttack;
       	}
    }
    else
    {   
        FDopencnt = 0;
        if (FDclosecnt < KEY_FILTER_CNT)
        {
            FDclosecnt++;
        }
        else if (FDclosecnt == KEY_FILTER_CNT)
        {
              FDclosecnt++;
        	DoorState &= ~FDdoorisopen;
        }
    }
		
    //scan trunk door ajar state
   //TunrkAD =  GetADCresultAverage(4);


    if (R_Door_state_IN)
    {  
       TDopenCnt = 0;
       if(TDcloseCnt < KEY_FILTER_CNT)TDcloseCnt++;
       else if (TDcloseCnt == KEY_FILTER_CNT)
       {
					TDcloseCnt++;
					DoorState &= ~TrunkIsOpen;
	   }
    }
    else
    {   
    	TDcloseCnt= 0;
       if(TDopenCnt<KEY_FILTER_CNT)TDopenCnt++;
       else if(TDopenCnt == KEY_FILTER_CNT)
       {
			TDopenCnt++;
			DoorState |= TrunkIsOpen;
	   }
    }


	/////////////////////////////////
	//can send data door state
	if(DoorState & TrunkIsOpen) CAN_TrunkSW_ON;
	else CAN_TrunkSW_OFF;
	if(DoorState & DriverDoorIsOpen) CAN_LFdoorSW_ON;
	else CAN_LFdoorSW_OFF;
	if(DoorState & OtherDoorIsOpen) {CAN_RRdoorSW_ON;CAN_LRdoorSW_ON;}
	else {CAN_RRdoorSW_OFF;CAN_LRdoorSW_OFF;}
	if(DoorState & FDdoorisopen)CAN_RFdoorSW_ON;
	else  CAN_RFdoorSW_OFF;
}
/*********************************************************************/
/*               低功耗后雾灯状态扫描                                */
/*程序名称：void ScanStandByDoorAjarSwitch(void)                     */
/*输    入：DOOR_AJAR_LI                                             */
/*输    出：StandByhazzardState                                      */                                             
/*调用要求：在低功耗中调用                                           */
/*作    者：lei                 完成时间：2007.12.10                 */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void ScanStandByDoorAjarSwitch(void)
{
	static uchar StandByDoorOpenCnt;
	if((!D_DOOR_AJAR)||(!OTHER_DOOR_AJAR)||(!Alarm_IN)||(!R_Door_state_IN))//||(!HORN_SW)) 
    {

        	StandByState = Pressed;    //此状态退出低功耗后应请除

    }
 
}
/*********************************************************************
Name    :   void ScanSeatbeltBuckleState(void)
Function:   V101BCM function description
            scan driver and passenger seatbelt buckle
Input   :
  DRIVER_SEATBELT_BUCKLE/PASSENGER_SEATBELT_BUCKLE
Output  :   SeatState<DriverSeatbeltBuckled/PassengerSeatbeltBuckled>
            BuzzerDriver<ON/OFF>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanSeatbeltBuckleState(void)
{
    static uchar dBuckledCnt,dNoBuckledCnt;
    static uchar pBuckledCnt,pNoBuckledCnt;
    
    //scan driver seatbelt buckle switch
    if (!D_SEATBELT_SW)
    {
        dNoBuckledCnt = 0;
        if (dBuckledCnt < KEY_FILTER_CNT)
        {
            dBuckledCnt++;
        }
        else if (dBuckledCnt == KEY_FILTER_CNT)
        {
            dBuckledCnt++;
        	SeatState |= DSeatbeltBuckled;
        }
    }
    else
    {
        dBuckledCnt = 0;
        if (dNoBuckledCnt < KEY_FILTER_CNT)
        {
            dNoBuckledCnt++;
        }
        else if (dNoBuckledCnt == KEY_FILTER_CNT)
        {
            dNoBuckledCnt++;
        	SeatState &= ~DSeatbeltBuckled;
        }
    }

    //scan pdriver/passenger seatbelt buckle switch
    if (!P_SEATBELT_SW)
    {
        pNoBuckledCnt = 0;
        if (pBuckledCnt < KEY_FILTER_CNT)
        {
            pBuckledCnt++;
        }
        else if (pBuckledCnt == KEY_FILTER_CNT)
        {
            pBuckledCnt++;
        	SeatState |= PSeatbeltBuckled;
        }
    }
    else
    {
        pBuckledCnt = 0;
        if (pNoBuckledCnt < KEY_FILTER_CNT)
        {
            pNoBuckledCnt++;
        }
        else if (pNoBuckledCnt == KEY_FILTER_CNT)
        {
            pNoBuckledCnt++;
        	SeatState &= ~PSeatbeltBuckled;
        }
    }
}

/*********************************************************************
Name    :   void ScanSeatPositionState(void)
Function:   V101BCM function description
Input   :
  PASSENGER_SEAT_POSITION
Output  :   SeatState<PassengerSeated>
            BuzzerDriver<ON/OFF>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanSeatPositionState(void)
{
    static uchar seatCnt,noseatCnt;

    if (P_SEAT_SW)
    {
        seatCnt = 0;
        if (noseatCnt < KEY_FILTER_CNT)
        {
            noseatCnt++;
        }
        else if (noseatCnt == KEY_FILTER_CNT)
        {
            noseatCnt++;
        	SeatState &= ~PassengerSeated;
        }
    }
    else
    {
        noseatCnt = 0;
        if (seatCnt < KEY_FILTER_CNT)
        {
            seatCnt++;
        }
        else if (seatCnt == KEY_FILTER_CNT)
        {
            seatCnt++;
        	SeatState |= PassengerSeated;
        }
     }
}


/*********************************************************************
Name    :   void JudgeWarmTypeAndDriver(void)
Function:   V101BCM function description
Input   :
  KeyInState/LowBeamSwitchState/SmallLampSwitchState/
            RearFogLampSwitchState/DoorState/IGNstate/
Output  :   WarmType
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
   2>修改内容
   报警优先级别有修改,安全带报警有大改动,灯未关报警和门未关报警有改动
     Author      :   lei
     Date        :   2008/01/23
*********************************************************************/
void JudgeWarmTypeAndDriver(void)
{
	static uint  BuzzerCnt;
	static uchar WarmType_Old;
	static uint  SeatBuzzerOnCnt;
    static uchar doorwarmcnt;
    static uchar powerlowstate;

	static uchar turnproid;
	////////////////////////////////////
	static uchar BuzzDoorstate;
	static uchar BUZZlightstate;
	static uint  Buzzseattime;
    //SeatState warm
    if((SeatState & DSeatbeltBuckled)&&(IGNstate == ON)&&(CarSpeed[2] > 13))
    {
        if(Buzzseattime < 37499) Buzzseattime++;
		if((Buzzseattime % 1875)== 5)
		{
        	    //BuzzerDrv(6,125,62,Buzzdrvseat); 
		}
	}
	else if(((SeatState & DSeatbeltBuckled) == 0)||(IGNstate == OFF))
	{
     	       //ClearBuzzdrv(Buzzdrvseat); 
		Buzzseattime = 0;     	
	}

	
	//warm door unclose 
	if ((IGNstate == ON) && (DoorState != AllDoorIsClosed))//&&(Doorstate_old == 0))
    {
        if(BuzzDoorstate != 0x55)
        {
		 	BuzzerDrv(2,125,62,Buzzdoorunclose); 
			BuzzDoorstate = 0x55;
        }
	}
    else
    {
		ClearBuzzdrv(Buzzdoorunclose); 
		BuzzDoorstate = 0;
    }
	// light unclose
	if((DoorState != AllDoorIsClosed )&&(IGNstate == OFF)&&(SmallLampSwitchState == Pressed))
	{
		//BuzzerDrv(1,83,42,Buzzlightunclose); 
	}
	else
	{
		//ClearBuzzdrv(Buzzlightunclose); 
	}
  

}


void BuzzerDrv(uchar buzzercnt,uint buzzertime,uint buzzerontime,uchar buzzyx)
{
    
	 uchar buzzi,buzzstate,buzzyxmin,buzzil;
     //for(buzzi=0;buzzi<5;buzzi++)
     //{
     //    if(buzzdrvStrategy[buzzi].buzzyx == buzzyx) {buzzstate = 1 ;break;}	 
	 //}
	 if(buzzstate != 1)
	 {   
	     buzzyxmin = 0x1f;
         for(buzzi=0;buzzi<5;buzzi++)
         {             
             if(buzzyxmin > buzzdrvStrategy[buzzi].buzzyx){ buzzyxmin = buzzdrvStrategy[buzzi].buzzyx;buzzil = buzzi;}
             if(buzzdrvStrategy[buzzi].buzzyx == 0)
             {
                 buzzdrvStrategy[buzzi].buzzcnt     =buzzercnt;
				 buzzdrvStrategy[buzzi].buzzmaxtime =buzzertime;
				 buzzdrvStrategy[buzzi].buzzontime  =buzzerontime;
				 buzzdrvStrategy[buzzi].buzzyx      =buzzyx;
				 break;
			 }
			 if(buzzi >= 4)
			 {
                 buzzdrvStrategy[buzzil].buzzcnt     =buzzercnt;
				 buzzdrvStrategy[buzzil].buzzmaxtime =buzzertime;
				 buzzdrvStrategy[buzzil].buzzontime  =buzzerontime;
				 buzzdrvStrategy[buzzil].buzzyx      =buzzyx;
			 }
		 }
	 }
}

void ClearBuzzdrv(u8 buzzyx)
{
   uchar buzzi;
   for(buzzi=0;buzzi<5;buzzi++)
   {
       if(buzzdrvStrategy[buzzi].buzzyx == buzzyx)
       {
             buzzdrvStrategy[buzzi].buzzcnt     =0;
			 buzzdrvStrategy[buzzi].buzzmaxtime =0;
			 buzzdrvStrategy[buzzi].buzzontime  =0;
			 buzzdrvStrategy[buzzi].buzzyx      =0;
			 buzzdrvStrategy[buzzi].BuzzerCnt   =0;
	   }

   }
}

void buzzdrv2(void)
{
     uchar buzzii,buzzeri,buzzyxmin;
	 //static uint BuzzerCnt[5];
     /*
	 if(Buzz10sstate != 0)
	 {
	    Buzz10sstate--;		
		BUZZER_ON;
		CanSendData[7]=(CanSendData[7]&0XE0)|0x0f;
		if(Buzz10sstate = 0) CanSendData[7]=(CanSendData[7]&0XE0)&0xf0;
		return;
	 }
	 */
	 buzzyxmin = 0x00;
	 buzzeri = 0;
	 for(buzzii=0;buzzii<5;buzzii++)
	 {
         if(buzzyxmin < buzzdrvStrategy[buzzii].buzzyx)
		 {
		    buzzyxmin = buzzdrvStrategy[buzzii].buzzyx;
			buzzeri = buzzii; 
		 }
	 }
    for(buzzii=0;buzzii<5;buzzii++)
    {
	    if ((buzzdrvStrategy[buzzii].buzzcnt)&&(buzzii !=buzzeri ))
		{
		    buzzdrvStrategy[buzzii].BuzzerCnt++;
	    	if(buzzdrvStrategy[buzzii].BuzzerCnt>=	buzzdrvStrategy[buzzii].buzzmaxtime)
	    	{	
	    		buzzdrvStrategy[buzzii].BuzzerCnt= 0;

	    	    buzzdrvStrategy[buzzii].buzzcnt--;    
				if(buzzdrvStrategy[buzzii].buzzcnt == 0)
				{
				    buzzdrvStrategy[buzzii].buzzyx = 0;
					buzzdrvStrategy[buzzii].buzzcnt= 0;
				    buzzdrvStrategy[buzzii].buzzmaxtime= 0;
					buzzdrvStrategy[buzzii].buzzontime= 0;					
					buzzdrvStrategy[buzzii].BuzzerCnt= 0;
				}
	    	}
		}
	}

    if (buzzdrvStrategy[buzzeri].buzzcnt)
	{
	    buzzdrvStrategy[buzzeri].BuzzerCnt++;
    	if (buzzdrvStrategy[buzzeri].BuzzerCnt< buzzdrvStrategy[buzzeri].buzzontime)
    	{
    		BUZZER_ON;
			BuzzCANsend(buzzdrvStrategy[buzzeri].buzzyx,0x55);
    	}
    	if (buzzdrvStrategy[buzzeri].BuzzerCnt>= buzzdrvStrategy[buzzeri].buzzontime)
    	{
    		BUZZER_OFF;
			BuzzCANsend(buzzdrvStrategy[buzzeri].buzzyx,0x00);
    	}
    	if(buzzdrvStrategy[buzzeri].BuzzerCnt>=	buzzdrvStrategy[buzzeri].buzzmaxtime)
    	{	
    		buzzdrvStrategy[buzzeri].BuzzerCnt= 0;

    	    buzzdrvStrategy[buzzeri].buzzcnt--;    
			if(buzzdrvStrategy[buzzeri].buzzcnt == 0) buzzdrvStrategy[buzzeri].buzzyx = 0;
    	}
	}
	else
	{
         	BUZZER_OFF;
		BuzzCANsend(buzzdrvStrategy[buzzeri].buzzyx,0x00);
	}
		

}

void BuzzCANsend(uchar BUZZYX,uchar zt)
{
    if(zt == ON)
    {
        CanSendData[7]=(CanSendData[7]&0XE0)|BUZZYX;
	}
	else
	{
		CanSendData[7]=CanSendData[7]&0XE0;
	}
}

/*********************************************************************
 end of the warm_drv.c file
*********************************************************************/

