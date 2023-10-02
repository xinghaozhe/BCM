
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              lock_drv.h
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
#include "lock_drv.h"
#include "horn_drv.h"
#include "turnlamp_drv.h"
#include "warm_drv.h"
#include "adc_drv.h"
#include "turnlamp_drv.h"
#include "window_drv.h"
#include "main.h"
#include "beam_drv.h"
#include "udsoncan.h"
#include"rke_drv.h"

/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
uchar   LockDrvCmd;               //中控锁驱动状态
uchar  	LockState;                //中控锁状态
uchar   LockRunCount;             //开闭锁运行时间计数
uchar   WindowDriverState;        //车窗驱动状态
uchar   CrashState;               //撞车信号状态
uchar   lockcount;                //解锁闭琐次数
u16     wLockProtectTimeCnt;      //一分钟时间计数
uchar   WindowDriverStateKeep;    //保存车窗状态
uchar   TRUNK_UNLOCK_RKEstate;    //RKE开后备箱标志
uchar   BCMtoGEM_AlarmStatus;     //BCM警戒状态信息20MS发送一次到GEM
uchar   Alarmstatus_RKE;          //rke状态信息
uchar   TRUNKWarmstate;
uchar   VehicleTypePZ;            //车型  CV8 /CV101
uint    BUZZLocktimecnt=0;
uchar   DoorWarmState;
uchar   Lockonesstate;
uchar   crashlockstate;
uchar   MachineLocktime;
uchar   dooropenlock;

uchar   Alarm_Actiated;
uchar   Speedlockcnt;
uchar   speedlockset;

uchar   warmstate                   @0x408b;

//extern ulong fade_out_time;
extern uchar RKELOCKstate;
extern uchar DriverLOCK;

unsigned int charshtime;

extern uchar Speedlockcnt;

/*********************************************************************
Name    :   void SaveWindowDriverState(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void SaveWindowDriverState(void)
{
      WindowDriverState = 0;
      
      if      (WIN_FL_UP_OUT)     {WindowDriverState |= flwu; WIN_FL_UP_OFF;}
      else if (WIN_FL_DOWN_OUT)   {WindowDriverState |= flwd; WIN_FL_DOWN_OFF;}

}

/*********************************************************************
Name    :   void ResumeWindowDriverState(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ResumeWindowDriverState(void)
{
      if (!WindowDriverState) return;
      
      if      (WindowDriverState & flwu) WIN_FL_UP_ON;
      else if (WindowDriverState & flwd) WIN_FL_DOWN_ON;

      
      WindowDriverState = 0;
}

/*********************************************************************
Name    :   void ScanCrashInSignal(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
   2>Author		: lei
     date		:2007/11/19
     Description:修改碰撞信号开锁 
*********************************************************************/
unsigned int timexxx1,timxxx2;
void ScanCrashInSignal(void)
{
       static u16  crashCnt;
       static u8   nocrashCnt;
       static u16  signalstate;
	  
       //when IGN=ON,scan crash signal
       if (IGNstate == OFF) 
       {
            crashCnt = 0;
		nocrashCnt = 0;
            return;
       }
       Crash_CAN();
       //scan crash input signal
       if (!CRASH_IN)
       {
            nocrashCnt = 0;
	     //HornDoorunclosetime = 5000;
            //crash has happened
            if (crashCnt < 20)
            {
                  crashCnt++;			
            }
            if (crashCnt == 20)
            {
                 //first unlock,after crash has happened
                 crashCnt++;
                 CrashState = IsCrashed;
		       //    HornDoorunclosetime = 5000;
                 LockDrvCmd |= UnlockDriverDoorCmd;
				 crashlockstate = 0x55;
                 //保存当前车窗状态
                 SaveWindowDriverState();  
                 if(WindowDriverState != 0x00)
                 {
                      WindowDriverStateKeep=WindowDriverState;
                 }
                 /*碰撞信号激活报警，4s后才可以由报警开关关闭*/
                 TurnLampDrv |= TurnLampCrashOn;
                 TurnLamp_CrashKeepTime = CRASHKEEPTIME;
				 charshtime = 625;
                 signalstate=AGAIN_UNLOCK_TIME;
            }
            else if (crashCnt < AGAIN_UNLOCK_TIME)
            {
                 crashCnt++;
            }
            else if (crashCnt == AGAIN_UNLOCK_TIME)
            { 
                 //again unlock,after crash has happened
                 crashCnt++;
                 LockDrvCmd |= UnlockDriverDoorCmd;
                 SaveWindowDriverState();  
                 if(WindowDriverState != 0x00)
                 {
                      WindowDriverStateKeep=WindowDriverState;
                 }
            }	
       }
       else
       {
            crashCnt = 0;
            //crash hasn't happened
            if (nocrashCnt < KEY_FILTER_CNT)
            {
                  nocrashCnt++;			
            }
            else if (nocrashCnt == KEY_FILTER_CNT)
            {
                 nocrashCnt++;
                 CrashState = NoCrashed;
            }		
       }
       
       if(signalstate != 0)
       {
            signalstate--;
            if(signalstate==0)
            {
                 crashlockstate = 0x55;
                 LockDrvCmd |= UnlockDriverDoorCmd;

                 SaveWindowDriverState();  
                 if(WindowDriverState != 0x00)
                 {
                       WindowDriverStateKeep=WindowDriverState;
                 }
            }
       }	

       //add chash
       if((TurnLamp_CrashKeepTime)&&(LockDrvCmd == LockCmd))
       {
               LockDrvCmd = 0;
	}

	   
}
/////////////////////////////////////////////////////////////////////////
void Crash_CAN(void)
{
      static u16 CAN_Crashstate;
      if(CAN_Crash == 0x55)
      {
             CAN_Crash = 0;
	      if((TurnLampDrv & TurnLampCrashOn)== 0)
	      	{
		      CAN_Crashstate = 500;
		      CrashState  =Pressed;
		      LockDrvCmd |= UnlockDriverDoorCmd;
		      TurnLampDrv |= TurnLampCrashOn;
		      TurnLamp_CrashKeepTime = CRASHKEEPTIME;
			  charshtime = 625;
	      	}
	}
	if(CAN_Crashstate != 0) 
	{
            CAN_Crashstate--;
            if(CAN_Crashstate == 0){LockDrvCmd |= UnlockDriverDoorCmd;CrashState = NoCrashed;}

	}

}



/*********************************************************************/
/*               低功耗碰撞信号状态扫描                              */
/*程序名称：Void ScanStandByCrashInSignal(void)                      */
/*输    入：CRASH_LI                                                 */
/*输    出：StandByhazzardState                                      */                                             
/*调用要求：在低功耗中调用                                           */
/*作    者：lei                 完成时间：2007.12.10                 */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void ScanStandByCrashInSignal(void)
{
	//static uchar StandByCrashInYesCnt;
	if(!CRASH_IN) 
    {
       	StandByState = Pressed;    //此状态退出低功耗后应请除
    }

	if(!UNLOCK_STA)
	{
		StandByState = Pressed;
	}
}

/*********************************************************************
Name    :   void ScanAllLockState(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanAllLockState(void)
{
	static uchar lockCnt,unlockCnt;
	static uchar Errorcnt1,Errorcnt2;

	//scan lock's "locked" state
	if (!LOCK_STA)
	{   
		if (lockCnt < 5) lockCnt++;
		if (lockCnt == 5)
		{
			lockCnt++;
			LockState = Locked;
			CAN_LOCKstate_lock;
			
		}
	}
	else
	{
		lockCnt = 0;
	}
	//scan lock's "unlocked" state
	if (!UNLOCK_STA)
	{   
		if (unlockCnt < 5) unlockCnt++;
		if (unlockCnt == 5)
		{
			unlockCnt++;
			LockState = Unlocked;
			CAN_LOCKstate_unlock;
			//Errorcnt1 = 0;
		}
	}
	else
	{
		unlockCnt = 0;
	}

	if((!UNLOCK_STA)&&(!LOCK_STA))
	{
      if(Errorcnt1 < 40)Errorcnt1++;
	  else if(Errorcnt1 == 40)
	  {
	    Errorcnt1++;
		CAN_LOCKstate_Error;
	  }
	}
	else if((UNLOCK_STA)&&(LOCK_STA))
	{
	    if(Errorcnt2 < 40)Errorcnt2++;
		else if(Errorcnt2 == 40)
		{
		   Errorcnt2++;
		   CAN_LOCKstate_Error;
		}
	}
	else
	{
        Errorcnt2 = 0;
		Errorcnt1 = 0;
	}
	
}
/*********************************************************************
Name    :   void ScanCentralLockSwitch(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
   2>Author		: lei
     date		:2007/11/21
     Description:重新修改修改 
*********************************************************************/
void ScanCentralLockSwitch(void)
{
    static uchar LockCnt,UnlockCnt;
    uint  LockSwitchADV;
    uchar LockSwitchState;
	static uchar lockdrvstatebf;	
	static uchar Ignold;
	static uchar  fif4lod;
	static uchar  fif4time=0;
   	LockSwitchADV = GetADCresultAverage(0);

    if (LockSwitchADV < UNLOCK_SW_ADV)
    {
    	 LockSwitchState = UnlockSWpressed;
	
    }
    else if (LockSwitchADV < LOCK_SW_ADV)
    {
    	 LockSwitchState = LockSWpressed;
    }
    else
    {
    	 LockSwitchState = LockUnlockSWunpressed;
    } 
 
     // suan fa  

    if (LockSwitchState == UnlockSWpressed)
    {
        LockCnt=0;
        if (UnlockCnt < AD_KEY_FILTER_CNT) 
        {
        	UnlockCnt++;
        }
        else if (UnlockCnt == AD_KEY_FILTER_CNT)
        {
                UnlockCnt++;
                if(wLockProtectTimeCnt ==0)TurnFlashCnt = 1;//20100719
                else TurnFlashCnt = 0;
                if(IGNstate == ON) TurnFlashCnt = 0;
                RKELOCKstate = 0x55;
                LockDrvCmd = (UnlockDriverDoorCmd);    
        }
    }
    else if (LockSwitchState == LockSWpressed)
    {
          UnlockCnt = 0;
          if (LockCnt < AD_KEY_FILTER_CNT) 
          {
              LockCnt++;
          }
          else if (LockCnt == AD_KEY_FILTER_CNT)
          {
                 LockCnt++;
                 if(wLockProtectTimeCnt ==0)TurnFlashCnt = 2 ;   //new 20100719
                 else  TurnFlashCnt = 0;
                 if(IGNstate == ON) TurnFlashCnt = 0;
                 LockDrvCmd = LockCmd;
                 RKELOCKstate =0xaa;
                 if ((LockState == Unlocked)&&(DoorState & 0x1b))//取消后备箱状态
                 {
                     //if(wLockProtectTimeCnt ==0)TurnFlashCnt = 3; //20100719
                     //BUZZLocktimecnt = 225 ;
                     //BuzzerDrv(3,125,63,Buzzlockdoorunclose); 
                           if(KeyInState == KeyIsOutHole)
                           	{
                                    HornDoorunclosetime = 6;
					 BuzzerDrv(1,376,375,Buzzlockdoorunclose);
					 dooropenlock = 50;
					 TurnFlashCnt = 0;
                           	}

                 }
          }
    }
    else   
    {
    	LockCnt = 0;
    	UnlockCnt = 0;
    }        

    if((Speedlockcnt >= 15)&&(IGNstate == ON)&&(DoorState == AllDoorIsClosed)&&(LockState == Unlocked)&&(lockdrvstatebf != 0x55)&&(DIDF1F4EEPROM[0] & Speedlock))//&&(Speedlockset))
    {
              lockdrvstatebf = 0x55;
		      LockDrvCmd = LockCmd; 	
	}
	else if((DoorState != AllDoorIsClosed)||(IGNstate == OFF))
	{
	     lockdrvstatebf = 0; 

	} 

	if(KeyInState != Ignold)
	{
              Ignold =  KeyInState ;
	       if((IGNstate == OFF)&&(DIDF1F4EEPROM[0] & Speedlock)&&(KeyInState==KeyIsOutHole))//20120328  取消锁状态限制
	       {
                   LockDrvCmd = UnlockDriverDoorCmd;
		     TurnFlashCnt = 1;
		}
	}
	/*
	if(fif4time<10) {fif4time++;fif4lod =DIDF1F4EEPROM[0] ;return;}
		
       if(fif4lod !=DIDF1F4EEPROM[0] )
       {
                fif4lod =DIDF1F4EEPROM[0];
	         if(DIDF1F4EEPROM[0] & Speedlock) BuzzerDrv(1,126,125,buzzspeedlockon);
		  else  BuzzerDrv(1,126,125,buzzspeedlockoff);
       }*/
	//}
	if(speedlockset == 0x55)
	{
	         if(DIDF1F4EEPROM[0] & Speedlock) BuzzerDrv(1,126,125,buzzspeedlockon);
		  else  BuzzerDrv(1,126,125,buzzspeedlockoff);
		  speedlockset = 0;		
	}
}
//////////////////////////////////////////////////////////////////////////

/*********************************************************************
Name    :   void ScanTrunkSwitch(void)
Function:   V101BCM function description
Input   :   TRUNK_RELEASE_SW
Output  :   TURNK_UNLOCK_ON/OFF
History :   
   1>Author      :   lei
     Date        :   2007/11/20   
     Description :   Build
**********************************************************************/
void ScanTrunkSwitch(void)
{
   static unsigned char Trunk_ON_cnt,Trunk_OFF_cnt;


   if(TRUNK_RELEASE_SW == 0)
   {
      Trunk_OFF_cnt = 0;
      if (Trunk_ON_cnt < KEY_FILTER_CNT) Trunk_ON_cnt++;
      else if (Trunk_ON_cnt == KEY_FILTER_CNT)
      {
          Trunk_ON_cnt++;
          LockDrvCmd = UnlockTrunkCmd;
      }
   }
   else
   {
      Trunk_ON_cnt = 0;
      if(Trunk_OFF_cnt < KEY_FILTER_CNT) Trunk_OFF_cnt++;
      else if (Trunk_OFF_cnt == KEY_FILTER_CNT)
      {
          Trunk_OFF_cnt++;
          LockDrvCmd = NoLockCmd;
	   //TurnFlashCnt =0; // ADD 20100814
      }
   }
}
  
/*********************************************************************
Name    :   void JudgeLockDriver(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
**********************************************************************
   2>Author		: lei
     date		:2007/11/19
     Description:修改锁电机热保护 
     
*********************************************************************/
void JudgeLockDriver(void)
{
	static u8   lockCnt,unlockcnt;    
    static uchar Lockbftime;
	static uchar TrunkcomOK;
    if( Lockonesstate == 0x55 )
    {
        if(Lockbftime < 125)
        {
            Lockbftime++;
            LockDrvCmd = NoLockCmd;
    	     TurnFlashCnt =0; // ADD 20100814
        }   
        else
        {
            Lockbftime = 0 ;
            Lockonesstate = 0 ;
        }
    }

// 10scnt
//////////////////////////////////////////////////////////////////////////////////
    Lockhot(); //热保护处理程序
//////////////////////////////////////////////////////////////////////////////////
if(charshtime == 0)
{
	if (wLockProtectTimeCnt != 0)
	{
	       if(crashlockstate == 0x55)
	       {
                if(LockDrvCmd == NoLockCmd)
                {
                      crashlockstate = 0;
				}
		   }
		   else
		   {
                    LockDrvCmd = NoLockCmd;
		      TurnFlashCnt =0; // ADD 20100814
		   }
            wLockProtectTimeCnt--;
	}
}
else charshtime--;

	//judge stop lock motor 
     if (LOCK_OUT || UNLOCK_OUT || TRUNK_UNLOCK_OUT)
     {
     	if (lockCnt < LOCK_RUN_TIME)
     	{
     		lockCnt++;
     	}
     	else
   	    {
            lockCnt = 0;
            LOCK_OFF;
            UNLOCK_OFF;	
            TRUNK_UNLOCK_OFF;
            LockDrvCmd = NoLockCmd;
            
            WindowDriverState = WindowDriverStateKeep;
            WindowDriverStateKeep=0X00;
            ResumeWindowDriverState();
   	    }
     }

     if(LockDrvCmd & LockCmd)  TrunkcomOK = 0;
	 if(LockDrvCmd & UnlockDriverDoorCmd) TrunkcomOK = 0x55;
     //judge start lock/unlock driver
     if (LockDrvCmd == NoLockCmd) return; 
     else if (LockDrvCmd & LockCmd)
     {
 			  SaveWindowDriverState();
              if(WindowDriverState != 0x00)
              {
      		    WindowDriverStateKeep = WindowDriverState;
              }
			  DriverLOCK = 0;
              TRUNK_UNLOCK_OFF;
              UNLOCK_OFF;
              LOCK_ON;
							LockDrvCmd = 0;
     }
     else if (LockDrvCmd & UnlockDriverDoorCmd )
     {
 		SaveWindowDriverState();
 		if(WindowDriverState != 0x00)
        {
      		    WindowDriverStateKeep = WindowDriverState;
        }
     	LOCK_OFF;
 		TRUNK_UNLOCK_OFF;
 		if (LockDrvCmd & UnlockDriverDoorCmd)	UNLOCK_ON;
		 LockDrvCmd = 0;
 		
     }
     else if (LockDrvCmd & UnlockTrunkCmd)
     {
 		SaveWindowDriverState();
 		if(WindowDriverState != 0x00)
        {
  		    WindowDriverStateKeep = WindowDriverState;
        }
 		LOCK_OFF;
 		UNLOCK_OFF;
 	    if(TRUNK_UNLOCK_RKEstate == 1)
 		{
                  TRUNK_UNLOCK_ON;
 		}
 		else if(TrunkcomOK == 0x55)
 		{
        	    TRUNK_UNLOCK_ON;
 		}
 		else
 		{
                LockDrvCmd &= ~UnlockTrunkCmd; 
 		}
 
     }
     else
     {   
              //error condition,clear lock driver flag and turn off driver i/o
              LOCK_OFF;
              UNLOCK_OFF;
              TRUNK_UNLOCK_OFF;
     }
}   
////////////////////////////////////////////////////////////////////////////////
void Lockhot(void)
{
    static u16   timecnt[10];
    static uchar passcnt[10];
    static uchar lockcnt;
    uchar i;
	static uchar LOCKcomoldstate;
	
    if(LOCKcomoldstate != LockDrvCmd)
    {
         LOCKcomoldstate = LockDrvCmd;
		 if(LockDrvCmd != 0) {lockcount = 1 ;MachineLocktime = 40;}
	}

	
    if( lockcount == 1 )
    {
        lockcount = 0 ;
        if(lockcnt < 9 )lockcnt++;
        else lockcnt = 0;     
        timecnt[lockcnt] = 1250;
        //passcnt[lockcnt]++;
        for(i = 0; i < 9; i++)
        {
           if(timecnt[i] != 0)
           {
              passcnt[i]++;
              if( passcnt[i] > 10 )
              {
                  wLockProtectTimeCnt = 7500;
                  timecnt[i] = 0;
                  passcnt[i] = 0;
              }
           }
        }
    }
    for(i = 0; i < 9; i++)
    {
        if(timecnt[i] != 0)
        {
           timecnt[i]--;
        }
        else
        {
           passcnt[i] = 0;
        }
    }
    
}
////////////////////////////////////////////////////////////////////////////////
void TRUNKwarm(void)
{
      //
      static uint TRUNktimecnt;  
      static uchar TRUNKCancleState;
      if(IGNstate == ON )
      {
          TRUNKWarmstate = 1 ;
      }
      
      if(TRUNK_UNLOCK_RKEstate == 1)
      {
             TRUNK_UNLOCK_RKEstate = 0 ;
             TRUNktimecnt = 7500 ;
      }
      if( TRUNktimecnt != 0)
      	{
      	      TRUNktimecnt--;
             if(TRUNktimecnt == 0 )
             	{
                    TRUNKWarmstate = 1 ;//zheng chang bao jing 
             }
             else
            	{
                    if(DoorState & TrunkIsOpen)
                    {
                          TRUNKWarmstate = 0 ; //取消后备箱报警      
                          TRUNktimecnt = 0 ;
                          TRUNKCancleState = 1 ;
                    }
             }
      }
      if(TRUNKCancleState == 1)
	{
	       if((DoorState & TrunkIsOpen) == 0)
	       {
                    TRUNKCancleState = 0 ;
                    TRUNKWarmstate = 1 ;
	       }              
      }
      
}

/***********************************************************************/
/*        报警状态算法函数(报警控制策略)                               */
/*程序名称：void WarmStatusArithmetic (void)                           */
/*输    入：Alarmstatus_RKE\DOORSTATE\IGSTATE\CARSTATE\FORTIFYSW_state */
/*输    出：BCMtoGEM_AlarmStatus                                       */
/*调用要求：主函数中8MS调用一次                                        */
/*作    者:rexlei                    完成时间：2008.02.23              */
/*功能描述:                                                            */
/*程序修改记录                                                         */
/*修改日期      作者         修改内容                   备注           */
/***********************************************************************/
void WarmStatusArithmetic (void)
{
    static uint prearmedtoArmedcnt;      //20S计数变量
    static uchar  Dooroldstate ;
    static uchar  IGNoldstate;
    uchar i;
    u32   temp;
    // 	取消防盗报警
	BCMtoGEM_AlarmStatus = Disarmed;
	return;
		
	/////////////////////////////////////////////////////
    if(Dooroldstate != DoorState )//&&(DoorState == AllDoorIsClosed))
    {   
        Dooroldstate = DoorState ;
        DoorWarmState = 0 ;
    }
    if(IGNoldstate != IGNstate)
    {
        IGNoldstate = IGNstate;
        DoorWarmState = 0 ;
    }
    if((BCMtoGEM_AlarmStatus !=Disarmed)&&(BCMtoGEM_AlarmStatus != prearmed)&&(BCMtoGEM_AlarmStatus !=Armed)&&(BCMtoGEM_AlarmStatus !=Actiated))
    {
         BCMtoGEM_AlarmStatus = Armed ;
    }

    
    switch(BCMtoGEM_AlarmStatus)
    {
        case Disarmed:
        {  
        	prearmedtoArmedcnt = 0;
		Alarm_Actiated = 0;
            if(DoorState != AllDoorIsClosed){Alarmstatus_RKE = 0;return;}
			
        	if(( Alarmstatus_RKE == 1)&&(IGNstate == OFF)&&(KeyInState == KeyIsOutHole) )   //RKE闭锁立即进入预警戒状态
        	{//更改；有点火钥匙在时遥控闭锁不进入设防状态
                    BCMtoGEM_AlarmStatus = prearmed;
					
                    Alarmstatus_RKE = 0;
        	}
        	if(( Alarmstatus_RKE == 3 ) && (IGNstate == OFF)) //自动30S闭锁直接进入警戒状态
             {
                    BCMtoGEM_AlarmStatus = Armed;
                    Alarmstatus_RKE = 0;
        	}
        	break;
        }
        case prearmed:
        {                        
            prearmedtoArmedcnt++;
            if( prearmedtoArmedcnt >= 625 )     //5S后进入警戒状态
            {
                BCMtoGEM_AlarmStatus = Armed; 
                prearmedtoArmedcnt = 0;
            }

            if(( DoorState != 0 ) || ( IGNstate == ON )) //有车门被打开解除报警
            {
                BCMtoGEM_AlarmStatus = Disarmed;
                prearmedtoArmedcnt = 0;
            }
            break;
        }
        case Armed:
        {
        	prearmedtoArmedcnt = 0;
        	if( Alarmstatus_RKE == 2 )  //RKE解锁报警解除 
        	{
                    BCMtoGEM_AlarmStatus = Disarmed;
                    Alarmstatus_RKE = 0;                
        	}        	
        	if(( Warningstate == 1 ) && (FORTIFYSW_state != 0x55 )&&(DoorWarmState != 1))//非RKE开门激活报警
        	{//有更改门打开也可以解除设防
                    BCMtoGEM_AlarmStatus = Actiated ;
                    DoorWarmState = 1; 
        	}
			if(IGNstate == ON)
			{
                          BCMtoGEM_AlarmStatus = Actiated ;
			}
        	break;
        }
        case Actiated:
        {
	     Alarm_Actiated = 0x55;
            prearmedtoArmedcnt = 0;
            if(Alarmstatus_RKE == 2 )    //RKE解锁报警解除 
            {
                   BCMtoGEM_AlarmStatus = Disarmed;
                   Alarmstatus_RKE = 0;    
            }
            else if( Alarmstatus_RKE == 4 )
            {
                //STATUSstate = 1 ;
                Alarmstatus_RKE = 0;
               // DoorWarmState = 1; 
                BCMtoGEM_AlarmStatus = Armed ;
            }
            else if( Warningstate == 0)
            {
                    BCMtoGEM_AlarmStatus = Armed ;
            }
        }
        default       :    break;
    }
    //////////////////////////////////////////////
    //can send data armed
       if(BCMtoGEM_AlarmStatus == Disarmed) CAN_ARMED_Disarmed;
	else if(BCMtoGEM_AlarmStatus == prearmed)  {CAN_ARMED_Disarmed ;CAN_ARMED_prearmed;}
	else if(BCMtoGEM_AlarmStatus == Armed) {CAN_ARMED_Disarmed ;CAN_ARMED_Armed;}
	else if(BCMtoGEM_AlarmStatus == Actiated){CAN_ARMED_Disarmed ;CAN_ARMED_Error;}
	else {CAN_ARMED_Disarmed ; CAN_ARMED_Armed;}


	
    //保存当前警戒状态
    
    if(warmstate != BCMtoGEM_AlarmStatus)
    {
        for( i = 0; i < EECNT ; i++ )
        {
             temp = (u32)( &warmstate );
             //Clear_WDT();
             FLASH_ProgramByte(temp, BCMtoGEM_AlarmStatus);                
             if( warmstate == BCMtoGEM_AlarmStatus )
             {
                  break;
             }
        }
    }
    
}


//20090824 更改
void MachineKeyDrv(void)
{
     static uchar Lockstate_old;
	 static uchar Dooruncloselock;
	

	if(MachineLocktime != 0) MachineLocktime--;
	
    if( Lockstate_old  != LockState)
    {
        Lockstate_old  =   LockState;      
        if(MachineLocktime != 0){LockDrvCmd = 0; return;}
        if(LockState == Locked )
        {
              
                        if((IGNstate == OFF)&&(wLockProtectTimeCnt ==0)&&(TurnFlashCnt == 0))TurnFlashCnt = 2;
				//FindCarFlag = FALSE;     //ADD close findcar 20120308
				if(FindCarFlag = TRUE)  //20120308
				{
					FindCarFlag = FALSE;
					if(turnfindcarstate == 1)TurnFlashCnt = 3;
				}
			   if((IGNstate == ON)||(wLockProtectTimeCnt != 0)) TurnFlashCnt = 0;
			  // if((DoorState != 0)&&(KeyInState == KeyIsOutHole)){dooropenlock = 50;TurnFlashCnt  = 0;HornDoorunclosetime = 6;BuzzerDrv(1,376,375,Buzzlockdoorunclose);}
			   if((DoorState & 0x1b)&&(IGNstate == ON)){dooropenlock = 50;TurnFlashCnt  = 0;}//HornDoorunclosetime = 6;BuzzerDrv(1,376,375,Buzzlockdoorunclose);}20120328 取消非RKE报警
                        if((DoorState & AllDoorIsClosed)&&(IGNstate == OFF)){dooropenlock = 50;TurnFlashCnt  = 0;}//
						//取消后备箱门状态限制
                        LockDrvCmd |= LockCmd ;
		          RKELOCKstate = 0xaa;

			   Dooruncloselock = 0;
        }
        if(LockState == Unlocked )
        {
                        if(Dooruncloselock != 0x55)
			   {
			                 LockDrvCmd |= UnlockDriverDoorCmd ;

					   if((IGNstate == OFF)&&(TurnFlashCnt == 0))TurnFlashCnt = 1;
					   //FindCarFlag = FALSE;//ADD close findcar 20120308
						if(FindCarFlag = TRUE)  //20120308
						{
							FindCarFlag = FALSE;
							if(turnfindcarstate == 1)TurnFlashCnt = 2;
						}
				          if((IGNstate == ON)||(wLockProtectTimeCnt != 0)) TurnFlashCnt = 0;
					   RKELOCKstate = 0x55;

			   }
			   else 
			   {
				   Dooruncloselock = 0;
	                        if((IGNstate == OFF)&&(wLockProtectTimeCnt ==0)&&(TurnFlashCnt == 0))TurnFlashCnt = 1;
				   if((IGNstate == ON)||(wLockProtectTimeCnt != 0)) TurnFlashCnt = 0;
				   RKELOCKstate = 0x55;
			   }
			   
			    
        }
            
     }
   
     if(dooropenlock!= 0)
     {
         dooropenlock--;
		 if(dooropenlock == 0)
		 {
                            LockDrvCmd |= UnlockDriverDoorCmd ;
				if((IGNstate == OFF)&&(wLockProtectTimeCnt ==0)&&(TurnFlashCnt == 0))TurnFlashCnt = 0;
				if(IGNstate == ON) TurnFlashCnt = 0;
				RKELOCKstate = 0x55;
			    Dooruncloselock = 0x55;
		 }
	 }

}



/*********************************************************************
 end of the lock_drv.c file
*********************************************************************/

