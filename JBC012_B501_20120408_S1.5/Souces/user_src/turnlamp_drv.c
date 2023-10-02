
/*
*****************************************************************************************
*                     Copyright (C) 2006 CJAE, Inc.                                     *
*                           All Rights Reserved									       	*
*file name       : turn_drv.c                                                           *
*file description: This file contains all the event                                     * 
*author          : kevin                                                                *
*creation date   : 2007/6/5                                                             *
*revision date   :                                                                      *
*****************************************************************************************

/*********************************************************************
 INCLUDE HEADER FILES
*********************************************************************/
//#include "pio_def.h"
#include "turnlamp_drv.h"
#include "rke_drv.h"
#include "adc_drv.h"
#include "defrost_drv.h"
#include "lock_drv.h"
#include "gpio_macro.h"
#include "warm_drv.h"
#include "horn_drv.h"
#include "main.h"
#include "can.h"

//#define  HornWarm  Configuration[0]&0x40
/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
uchar  TurnLampDrv;
uchar  TurnLampOnCnt;  
uchar  TurnLampCScmd;
uchar  TurnLampState;
uchar  TLSwitchRoadwayFlashCnt;    //变道3次计数
uchar  TL_DUTY,TL_PERIOD;
uint   TurnFlashCnt;
uint  TurnLamp_CrashKeepTime;     //碰撞报警信号最低保持时间，在lock.c函数中赋值
uchar  Crash_state_Y;            //碰撞信号标记
uint     ledcnt;
uchar  HazzardState;         //报警开关状态
uchar  Turn_R_State;         //右转开关状态
uchar  Turn_L_State;         //左转开关状态
uchar  Turn_R_CH_State;      //右转开关状态
uchar  Turn_L_CH_State;      //左转开关状态
uchar  TurnState_Number;     //优先级状态代号
uint   WarningTimeCnt;  	//设防报警 5分钟计数	
uchar  Warningstate;
uchar  BrakeSpeedHazards_state;  //减速刹车报警状态

extern unsigned char DIDF1f2EEPROM[2];
/////
unsigned int TURNAD;



extern u8     HornAlarmState                @0x4085;   //喇叭报警
/*********************************************************************/
/*                     报警开关状态扫描                              */
/*程序名称：Void ScanHazzardKeys(void)                               */
/*输    入：HAZZARD_LI                                               */
/*输    出：hazzardState                                             */                                             
/*调用要求：void ScanTurnLampKeys(void)函数中调用                    */
/*作    者：lei                 完成时间：2007.12.03                 */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void ScanHazzardKeys(void)
{
	static uchar hazzardYesCnt,hazzardNoCnt;

	if(TurnLamp_CrashKeepTime != 0) return ;
	
	if(!HAZARD_SW)
       {
            hazzardNoCnt = 0;      
            if (hazzardYesCnt < KEY_FILTER_CNT)
            {
                 hazzardYesCnt++;
            }
            else if (hazzardYesCnt == KEY_FILTER_CNT)
            {
                 hazzardYesCnt++;
				 BrakeSpeedHazards_state=0;
                 if(Crash_state_Y == 1)
                 {
                      Crash_state_Y = 0 ;
                 }
                 else
                 {
                      if (HazzardState == Pressed)
                      {
                           HazzardState = Unpressed;
                      }
                      else
                      {
                           HazzardState = Pressed;
				if(FindCarFlag = TRUE)  //20120308
				{
					FindCarFlag = FALSE;
					//if(turnfindcarstate == 1)TurnFlashCnt = 1;
					TurnFlashCnt = 0;
				}
			      TurnFlashCnt = 0;//ADD close findcar 20120308
                      }
                 }
            }
     }
    else 
    {
    	if (hazzardNoCnt < KEY_FILTER_CNT)
    	{
    		hazzardNoCnt++;
    	}
    	else if (hazzardNoCnt == KEY_FILTER_CNT)
    	{
    		hazzardNoCnt++;
    		hazzardYesCnt = 0;    	
    	}
    }	
}
/*********************************************************************/
/*               低功耗报警开关状态扫描                              */
/*程序名称：Void ScanStandByHazzardKeys(void)                        */
/*输    入：HAZZARD_LI                                               */
/*输    出：StandByhazzardState                                      */                                             
/*调用要求：在低功耗中调用                                           */
/*作    者：lei                 完成时间：2008.01.14                 */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void ScanStandByHazzardKeys(void) 
{
	static uchar StandByhazzardYesCnt;
	 if(!HAZARD_SW) 
	 {

        	StandByState = Pressed;    //此状态退出低功耗后应请除
        }

}

/*********************************************************************/
/*                     优先级算法                                    */
/*程序名称：Void ScanTurnLampKeys(void)                              */
/*输    入：TURN_R_LI、TURN_l_LIhazzardState、crashstate           */
/*输    出：TurnLampDrv                                              */                                             
/*调用要求：主函数中8MS调用一次                                      */
/*作    者：lei                 完成时间：2007.12.03                 */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*20080121      lei      取消:先有报警转向优先30S      长安技术更改  */
/*********************************************************************/
void ScanTurnLampKeys(void)
{         
      static uchar lTurnYesCnt, lTurnNoCnt;
      static uchar rTurnYesCnt, rTurnNoCnt;
      static uchar R_oldstate,L_oldstate,HAZZARD_oldstate;   
      
      static ulong  lTurnLamp_KeepTime;       /*左转向灯在报警信号有效的情况下打开时优先的时间*/
      static ulong  rTurnLamp_KeepTime;       /*右转向灯在报警信号有效的情况下打开时优先的时间*/
      

      static uchar  Speedwarmstate;
      ScanHazzardKeys();
      
      //右转向开关状态扫描
      if(!TURN_RIGHT_SW) 
      {
           rTurnNoCnt = 0;
           if(rTurnYesCnt < 100 )
           {
                rTurnYesCnt++;
           }
           if((rTurnYesCnt >= 5) && (rTurnYesCnt <=12) && (Turn_R_CH_State == Unpressed) && (Turn_L_CH_State == Unpressed))
           {
                Turn_R_State = Pressed; 
		   //Turn_L_State = Unpressed;              // add 20120309
		  // Turn_L_CH_State = Unpressed;
		   //if(TLSwitchRoadwayFlashCnt=3);
		   //TurnLampOnCnt=0;
           }
           else if(rTurnYesCnt > 87)
           {
                Turn_R_State = Pressed;
                Turn_L_CH_State = Unpressed;
                Turn_R_CH_State = Unpressed;  
           }
      }
      else 
      {
           if((rTurnYesCnt > 12) && (rTurnYesCnt <= 87 ))
           {
                Turn_R_State = Unpressed;
                if(TLSwitchRoadwayFlashCnt >= 3)
                {
	                if(IGNstate == ON)TLSwitchRoadwayFlashCnt = 0;
	                Turn_R_CH_State = Pressed;
	                Turn_L_CH_State = Unpressed;
                }
                else if(Turn_R_CH_State == Pressed)
                {
                     Turn_L_CH_State = Unpressed;
                 
                }
           }
           else if(rTurnYesCnt > 87)
           {
                //Turn_R_State = pressedDefKey;
                TLSwitchRoadwayFlashCnt = 3;
                Turn_R_CH_State = Unpressed;      //转向优先 取消变道
                Turn_L_CH_State = Unpressed;
           }
           
           rTurnYesCnt= 0;
           if (rTurnNoCnt < KEY_FILTER_CNT)
           {
                rTurnNoCnt++;
           }
           else if (rTurnNoCnt == KEY_FILTER_CNT)
           {
                rTurnNoCnt++;
                Turn_R_State = Unpressed;   
           }
      }
      //左转向开关状态扫描
      if(!TURN_LEFT_SW) 
      {
            lTurnNoCnt = 0;      
            if ( lTurnYesCnt < 100)
            {
                 lTurnYesCnt++;
            }
            if((lTurnYesCnt >= 5)&&(lTurnYesCnt <=12) && (Turn_R_CH_State == Unpressed) && (Turn_L_CH_State == Unpressed))
            {
                 Turn_L_State = Pressed; 
		   //Turn_R_State = Unpressed;              // add 20120309
		   //Turn_R_CH_State = Unpressed;
		   //TLSwitchRoadwayFlashCnt=3;
		   //TurnLampOnCnt=0;
            }
            else if( lTurnYesCnt > 87)
            {
                  Turn_L_State = Pressed;
                  Turn_L_CH_State = Unpressed;
                  Turn_R_CH_State = Unpressed;
            }
     }
     else 
    {
          if((lTurnYesCnt > 12) && (lTurnYesCnt <= 87))
          {
               Turn_L_State = Unpressed;
               if( TLSwitchRoadwayFlashCnt >= 3 ) 
               {
                    Turn_L_CH_State = Pressed; 
                    if(IGNstate == ON)TLSwitchRoadwayFlashCnt = 0;
                    Turn_R_CH_State = Unpressed;
               }
               else if(Turn_L_CH_State == Pressed)
               {
                    Turn_R_CH_State =Unpressed;
               }
          }
          else if(lTurnYesCnt > 87) 
          { 
               //Turn_L_State = pressedDefKey;
               TLSwitchRoadwayFlashCnt = 3;
               Turn_L_CH_State = Unpressed;
               Turn_R_CH_State = Unpressed;
          }
          lTurnYesCnt= 0;
          if (lTurnNoCnt < KEY_FILTER_CNT)
          {
               lTurnNoCnt++;
          }
          else if (lTurnNoCnt == KEY_FILTER_CNT)
          {
               lTurnNoCnt++;
               Turn_L_State = Unpressed;   
          }
    }

    //状态代号生成

    

    //右变道处理
    if(( IGNstate == ON )&&(Turn_R_CH_State== Pressed) && (TLSwitchRoadwayFlashCnt < 3)\
    	&& ( HazzardState == Unpressed) &&( Crash_state_Y != 1))
    {
    	TurnState_Number = 3 ;                                                                     //右变道有效
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////	
    if((TurnState_Number == 3)&&(TLSwitchRoadwayFlashCnt >= 3))    ///20091028更改/////////////////////////////////bug
    {
        Turn_R_CH_State = Unpressed;
        //if(TurnState_Number == 3)
        //{
           TurnState_Number = 0;
        //}
    }

	
    if(( IGNstate == ON )&&(TLSwitchRoadwayFlashCnt < 3) &&(( HazzardState == Pressed)||(Crash_state_Y == 1)))
    {
        Turn_R_CH_State = Unpressed;
        TLSwitchRoadwayFlashCnt = 3;
    }

    //左变道处理
    if(( IGNstate == ON )&&(Turn_L_CH_State == Pressed)&& (TLSwitchRoadwayFlashCnt < 3)\
    	&& ( HazzardState == Unpressed) &&( Crash_state_Y != 1))
    {   
    	TurnState_Number = 4 ;       //左变道有效
    	//Turn_L_CH_State = unpressedDefKey;
    }
	
    if((TurnState_Number == 4)&&(TLSwitchRoadwayFlashCnt >= 3))
    {
        Turn_L_CH_State = Unpressed;
        //if(TurnState_Number == 4)
        //{
	        TurnState_Number = 0;
        //}
    }

	
    if(( IGNstate == ON )&&(TLSwitchRoadwayFlashCnt < 3) &&(( HazzardState == Pressed)||(Crash_state_Y == 1)))
    {
        Turn_L_CH_State = Unpressed;
        TLSwitchRoadwayFlashCnt = 3;
    }
    //右转向
    if(( IGNstate == ON )&&(Turn_R_State == Pressed)&& (Crash_state_Y != 1))
    {
         if((TurnState_Number == 3)||(TurnState_Number == 4))
         {
             TurnLampOnCnt = 0 ;
         }
         TurnState_Number = 1 ;             //右转有效 碰撞信号有效右转向优先在后面单独付值
    }
    else if((Turn_R_State == Unpressed)&&(TurnState_Number == 1) && (Crash_state_Y != 1))
    {
        if((TurnState_Number != 3)||(TurnState_Number != 4))
        {
            TurnState_Number = 0;               //如右转向开关无效 清标志
        }
    }
	
    //左转向
    if(( IGNstate == ON )&&(Turn_L_State == Pressed)&& (Crash_state_Y != 1))
    {     
         if((TurnState_Number == 3)||(TurnState_Number == 4))
         {
             TurnLampOnCnt = 0 ;
         }
        TurnState_Number = 2 ;             //左转有效 碰撞信号有效左转向优先在后面单独付值
    }
    else if((Turn_L_State == Unpressed)&&(TurnState_Number == 2)&& (Crash_state_Y != 1))
    {
        if((TurnState_Number != 3)||(TurnState_Number != 4))
        {
            TurnState_Number = 0;               //如果左转向开关无效 清标志
        }
    }
	
    //左/右转向同时有效为错误
    if(( Turn_R_State == Pressed) && ( Turn_L_State == Pressed)) TurnState_Number = 0; //错误
    
    //报警开关
    if(( HazzardState == Pressed)&&(rTurnLamp_KeepTime == 0)&&(lTurnLamp_KeepTime == 0))  TurnState_Number = 5 ;                                     //报警有效
    else if((HazzardState == Unpressed)&&(TurnState_Number == 5))
    {
        TurnState_Number = 0;   //报警开关关，清标志
    }

    //碰撞信号
    if( CrashState  == Pressed) Crash_state_Y = 1;                                         //碰撞有效  
    
    if(( Crash_state_Y == 1 )&&(rTurnLamp_KeepTime == 0)&&(lTurnLamp_KeepTime == 0)) TurnState_Number = 6 ;
    else if(TurnState_Number == 6)
    {
         TurnState_Number = 0;
    }
	
    //如果碰撞和报警都无效 取消左/右转向优先30秒
    if((HazzardState == Unpressed) && (Crash_state_Y != 1))
    {
        rTurnLamp_KeepTime = 0;
        lTurnLamp_KeepTime = 0;
    }
	//更改   先有报警 转向优先  	
    //报警或碰撞先有效   右转向灯优先    
    if(R_oldstate != Turn_R_State)
    {
        if((HazzardState == Pressed)&&( IGNstate == ON )&&(Turn_R_State == Pressed))
        {
            rTurnLamp_KeepTime = 375000;  
            TurnState_Number = 1;   
        }    
        if((HazzardState == Pressed)&&( IGNstate == ON )&&(Turn_R_State == Unpressed))
        {
            rTurnLamp_KeepTime = 0;  
            TurnState_Number =   5 ; 
        } 
        if((Crash_state_Y == 1 ) &&( IGNstate == ON )&&(Turn_R_State == Pressed))
        {
            rTurnLamp_KeepTime = 375000;
            TurnState_Number = 1;   
        }
        if((Crash_state_Y == 1 ) &&( IGNstate == ON )&&(Turn_R_State == Unpressed))
        {
            rTurnLamp_KeepTime = 0;
            TurnState_Number = 6;
        }
        R_oldstate = Turn_R_State;
    }  
	
    if(rTurnLamp_KeepTime != 0) //优先30秒 右转向优先
    {
         rTurnLamp_KeepTime--;
         //TurnState_Number = 1;    
         if((rTurnLamp_KeepTime == 0)&&(TurnState_Number == 1))
         {
             TurnState_Number = 0 ;
         }
    }
	//更改   先有报警 转向优先   未测试	
    //报警或碰撞有效  左转向优先30秒
    if(L_oldstate != Turn_L_State)
    {
        if((HazzardState == Pressed)&&( IGNstate == ON )&&(Turn_L_State == Pressed))
        {
            lTurnLamp_KeepTime = 375000;  
            TurnState_Number = 2;  
        }    
        if((HazzardState == Pressed)&&( IGNstate == ON )&&(Turn_L_State == Unpressed))
        {
            lTurnLamp_KeepTime = 0;  
            TurnState_Number =   5 ; 
        } 
        if((Crash_state_Y == 1 ) &&( IGNstate == ON )&&(Turn_L_State == Pressed))
        {
            lTurnLamp_KeepTime = 375000;
            TurnState_Number = 2;  
        }
        if((Crash_state_Y == 1 ) &&( IGNstate == ON )&&(Turn_L_State == Unpressed))
        {
            lTurnLamp_KeepTime = 0;
            TurnState_Number = 6;
        }
        L_oldstate = Turn_L_State;
    }
	
    if(lTurnLamp_KeepTime != 0) //优先30秒 左转向优先
    {
         lTurnLamp_KeepTime--;
         if((lTurnLamp_KeepTime == 0)&&(TurnState_Number == 2))
         {
			 TurnState_Number = 0; 
         }
            
    }
	
    //碰撞信号有效 4秒后报警开关状态有变化并且变化后为关 则关闭报警
    if(TurnLamp_CrashKeepTime != 0) 
    {
        TurnLamp_CrashKeepTime--; 

    }
    if((TurnLamp_CrashKeepTime == 0)&&(HAZZARD_oldstate != HazzardState) && (Crash_state_Y == 1 ))
    {
         HAZZARD_oldstate = HazzardState;
         HazzardState = Unpressed ;
         if(HazzardState == Unpressed)
         {
              Crash_state_Y = 0;           //关闭碰撞报警
         }

    }


    //////////////////////////////////////////////////////////////new
    if(( BCMtoGEM_AlarmStatus == Armed ) &&( Warningstate == 0 ))
    {
        if( TRUNKWarmstate == 1 )
        {
              if( ( DoorState != 0 ) || (IGNstate == ON))
              {
                  if(DoorWarmState == 0)//??
                  {
                     Warningstate = 1;   //此处可能影响后备箱报警  //0317
                  }   
                  else
                  {
                     Warningstate = 0;
                  }
              }
        }
        else
        {
             if( (( DoorState != 0 ) && (( DoorState & TrunkIsOpen ) == 0)) || (IGNstate == ON))
           	{
                  if(DoorWarmState == 0)//??
                  {
                     Warningstate = 1;
                  }   
                  else
                  {
                     Warningstate = 0;
                  }
             }
        }
       
    }    


    if(((FORTIFYSW_state != 0x55 )||(CAN_FORTIFY_state != 0x55))&&( Warningstate == 1 )&& (WarningTimeCnt <= 37500))
    {   
         WarningTimeCnt++;    
         CarState |= CarIsAttack;
         if( WarningTimeCnt == 1 )
         {
             Alarmstatus_RKE = 4; //报警激活BCM需要回到警戒状态
         }
         if(DIDF1f2EEPROM[0] != 0x00)TurnState_Number = 7;
		 
         if ( ( !HornWarm ) && ( DIDF1f2EEPROM[0] != 0x00 ) )   //根据诊断设置判断是否驱动喇叭报警
         {
             CarHornstate = 1 ;
         }
         else
         {
             CarHornstate = 0 ;
         }
    }
    else if (TurnState_Number == 7)
    {
         TurnState_Number = 0;
         CarHornstate = 0;
         WarningTimeCnt = 0;
         Warningstate = 0;
    }
    else 
    {
         CarHornstate = 0;
         WarningTimeCnt = 0;
         Warningstate = 0;
        // TrunkWarmTime = 0;
    }

    //刹车报警

    if( BrakeSpeedHazards_state == 1 )
    {           
         //if(((TurnState_Number ==TurnLampRightOn)||(TurnState_Number == TurnLampLeftOn)&&(Speedwarmstate == 0x55)))
         //{
              // Speedwarmstate = 0;                               
         // }
         // else
         // {
                TurnState_Number = 8;                
         // }
        //  if(TurnState_Number == 8)
       //   {
               //Speedwarmstate = 0x55;
               //f(HazzardState == Pressed)
               //{
               //       TurnState_Number  = 0 ;
               //       HazzardState = Unpressed ;
               //}
      //    }

    }
    else if( TurnState_Number == 8 )
    {
         TurnState_Number = 0;
         Speedwarmstate = 0 ;
    }
   // else  Speedwarmstate = 0 ;

    //BCM为初始密码取消声光报警功能
    if((DIDF1f2EEPROM == 0x00)||(CAN_FORTIFY_state == 0x55))
    {
        if(TurnState_Number >= 7)
        {
            TurnState_Number = 0 ; ////////////////////
        }
    }
    
	
    switch(TurnState_Number)
    {

	   case 1: TurnLampDrv = TurnLampRightOn;          //置右转向   
	           //CAN_TURNRightSW_ON;
			   //CAN_TURNLeftSW_OFF;
	           if(IGNstate == OFF) {TurnLampDrv = TurnLampDrv&TurnLampRightOff; }//CAN_TURNRightSW_OFF;}
			   
               break;
       case 2: 
	   	       TurnLampDrv = TurnLampLeftOn;       	   //置左转向
	   	       //CAN_TURNLeftSW_ON;
			   //CAN_TURNRightSW_OFF;
               if(IGNstate == OFF){ TurnLampDrv = TurnLampDrv&TurnLampLeftOff;}// 	 CAN_TURNLeftSW_OFF;  }

               break;
       case 3: TurnLampDrv = TurnLampRightOn;          //置右转变道
               //CAN_TURNRightSW_ON;
			   //CAN_TURNLeftSW_OFF;
       	       break;
       case 4: TurnLampDrv = TurnLampLeftOn;           //置左转变道  
               //CAN_TURNLeftSW_ON;
			   //CAN_TURNRightSW_OFF;
       	       break;
       case 5: TurnLampDrv = TurnLampHazzardOn;        //置报警开关报警  
               //CAN_TURNRightSW_ON;
			   //CAN_TURNLeftSW_ON;
       	       break;
       case 6: TurnLampDrv = TurnLampCrashOn;          //置碰撞报警
               //CAN_TURNRightSW_ON;
			   //CAN_TURNLeftSW_ON;
       	       break; 
	   case 7: TurnLampDrv = TurnLampHazzardOn; 	   //进入设防后异常报警
	           //CAN_TURNRightSW_ON;
			   //CAN_TURNLeftSW_ON;
			   break;
			  //if(BCMtoGEM_AlarmStatus ==0){TurnLampDrv = 0;CAN_TURNRightSW_OFF; CAN_TURNLeftSW_OFF;break;}
	   case 8: TurnLampDrv = TurnLampHazzardOn;        //进入刹车报警  
	            //     CAN_TURNRightSW_ON;
			   //CAN_TURNLeftSW_ON;
	           break;
       default: TurnLampDrv = 0x00;                    //错误或无任何状态   
               //CAN_TURNRightSW_OFF; 
			   //CAN_TURNLeftSW_OFF;
       	       break;
    }
  
    
}
    

/*********************************************************************
Name    :   void JudgeTurnLampDrv(void)
Function:   V101BCM function description
Call    :   None
Input   :   TurnFlashCnt/TurnLampDrv/TurnLampOnCnt
Output  :   TURN_LEFT_LAMP_ON/OFF / TURN_RIGHT_LAMP_ON/OFF
            TurnLampCScmd
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
unsigned char turnfindcarstate=0;

void JudgeTurnLampDrv(void)
{
    static uchar tempFlashCnt;
    static uchar turnold,turntime;

    if(TurnLampDrv == 0) TurnLampOnCnt = 0;
//////////////////////////////////////////////////////////20120302  hafei 
   /* if(turnold != TurnFlashCnt)
    {
            turnold = TurnFlashCnt;
	     //if(TurnFlashCnt == 1) 
	     if(TurnFlashCnt == 0)turntime =30;
     }
     if(turntime)
     {
           turntime--;
	    TurnFlashCnt =0;
     }
     */

//////////////////////////////////////////////////////////	
	//RKE flash turn lamps control
    if (TurnFlashCnt)
    {   
        if (++tempFlashCnt < 45) ///RKE_FLASH_TL_DUTY    080616
    	{
    		TURN_LEFT_LAMP_ON;
    		TURN_RIGHT_LAMP_ON;
			CAN_TURNRightSW_ON;
			CAN_TURNLeftSW_ON;
			turnfindcarstate = 1;
			
     	}
    	else if (tempFlashCnt < 90)//RKE_FLASH_TL_PERIOD  //080616
    	{
    		TURN_LEFT_LAMP_OFF;
    		TURN_RIGHT_LAMP_OFF;
			CAN_TURNRightSW_OFF;
			CAN_TURNLeftSW_OFF;
			turnfindcarstate = 1;
    	}
    	else
    	{    		
    	       turnfindcarstate = 0;
    		TurnFlashCnt--;
    		tempFlashCnt = 0;
		//if(TurnFlashCnt == 0)turntime =50;
    	}
    }
    else if (TurnLampDrv)
    {
    	tempFlashCnt = 0;
        TurnLampOnCnt++;
        if (TurnLampOnCnt < TL_DUTY)
        {   
            if (TurnLampDrv == 0xff)
	        {
	            TURN_LEFT_LAMP_ON;
				TURN_RIGHT_LAMP_OFF;
				CAN_TURNRightSW_OFF;
				CAN_TURNLeftSW_ON;
	            //set checking circuit time phase
	            if (TurnLampOnCnt <= TL_WAIT_TIME)
	            {
                    TurnLampCScmd = TLCSCMD_NO;
	            }
	        	else 
	        	{
	        		TurnLampCScmd |= TLCSCMD_L_OPEN;
    	    	}
	        }
            else if (TurnLampDrv == TurnLampLeftOn)
            {
                TURN_LEFT_LAMP_ON ;
                TURN_RIGHT_LAMP_OFF;
				CAN_TURNRightSW_OFF;
				CAN_TURNLeftSW_ON;
                if( TurnLampOnCnt <= TL_WAIT_TIME)
                {
                    TurnLampCScmd = TLCSCMD_NO ;
                }
                else
                {
                    TurnLampCScmd |= TLCSCMD_L_OPEN ;
                }
            }
	        else if (TurnLampDrv == TurnLampRightOn)
	        {
	            TURN_RIGHT_LAMP_ON;
	            TURN_LEFT_LAMP_OFF;
				CAN_TURNRightSW_ON;
			         CAN_TURNLeftSW_OFF;
	            //set checking circuit time phase
	            if (TurnLampOnCnt <= TL_WAIT_TIME)
	            {
                    TurnLampCScmd = TLCSCMD_NO;
	            }
	        	else 
	        	{
	        		TurnLampCScmd |= TLCSCMD_R_OPEN;
    	    	}
	        }
	        else if ((TurnLampDrv == TurnLampHazzardOn ) ||(TurnLampDrv == TurnLampCrashOn))
	        {
        		TURN_LEFT_LAMP_ON;
        		TURN_RIGHT_LAMP_ON;
			CAN_TURNRightSW_ON;
			CAN_TURNLeftSW_ON;
	            //set checking circuit time phase
	            if (TurnLampOnCnt <= TL_WAIT_TIME)
	            {
                    TurnLampCScmd = TLCSCMD_NO;
	            }
	        	else 
	        	{
	        		TurnLampCScmd |= TLCSCMD_L_OPEN;
	        		TurnLampCScmd |= TLCSCMD_R_OPEN;	
    	    	}
	        }
	        else	//error state
	        {
	        	TurnLampDrv = 0;
	        	TURN_LEFT_LAMP_OFF;
	        	TURN_RIGHT_LAMP_OFF;
							CAN_TURNRightSW_OFF;
			CAN_TURNLeftSW_OFF;
	        	TurnLampCScmd = TLCSCMD_NO;
	        }
        } 	
        else if(TurnLampOnCnt < TL_PERIOD)
        {
        	TURN_LEFT_LAMP_OFF;
        	TURN_RIGHT_LAMP_OFF;
			CAN_TURNRightSW_OFF;
			CAN_TURNLeftSW_OFF;

            if (TurnLampOnCnt <=  (TL_DUTY + TL_WAIT_TIME))
            {
                TurnLampCScmd = TLCSCMD_NO;
            }
        	else 
        	{
        		TurnLampCScmd |= TLCSCMD_L_SHORT;
        		TurnLampCScmd |= TLCSCMD_R_SHORT;	
   	    	}
        }
        else
        {
            TurnLampOnCnt = 0;
	       	TurnLampCScmd = TLCSCMD_NO;
           	if (TLSwitchRoadwayFlashCnt < 3) 
         	{
	         	TLSwitchRoadwayFlashCnt++;
           	}
        }
    }
    else
    {
       	TurnLampCScmd = TLCSCMD_NO;
    	TURN_LEFT_LAMP_OFF;
    	TURN_RIGHT_LAMP_OFF;
					CAN_TURNRightSW_OFF;
			CAN_TURNLeftSW_OFF;
    }

    
}

/*********************************************************************
Name    :   void ScanTurnLampState(void)
Function:   V101BCM function description
Call    :   GetADCresultAverage(TurnLADchl)
Input   :   TurnLampState/IGNstate/TurnLampCScmd
Output  :   TL_DUTY/TL_PERIOD
            TurnLampCScmd
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     escription :   Build
*********************************************************************/
  unsigned int turnshortad;
void ScanTurnLampState(void)
{
	uint adResultTemp;
	static u16  TurnRtime1,TurnLtime1;
	static unsigned char turnrt,turnlt,turnok1,turnok2;

      // TURNAD = GetADCresultAverage(3);
  
    //转向灯灯丝失效标定参数 
	if(battervalue < 0x214) turnshortad = 300;
	else if(battervalue < 0x25c) turnshortad = 330;
	else if(battervalue < 0x2ac) turnshortad = 350;
	else if(battervalue < 0x2db) turnshortad = 360;
	else if(battervalue < 0x321) turnshortad = 380;	
	else if(battervalue < 0x35e) turnshortad = 390;
	else if(battervalue < 0x3a3) turnshortad = 420;
	else if(battervalue < 0x3e6) turnshortad = 430;
	else turnshortad = 450;
	


	   
	if (TurnLampState == TL_IS_OK)
	{
		TL_DUTY = TL_NORMAL_DUTY;
		TL_PERIOD = TL_NORMAL_PERIOD;

	}
	else
	{  
	    if ((TurnLampDrv ==TurnLampHazzardOn )||(TurnLampDrv== TurnLampCrashOn))
	    {//为了保证灯丝失效时报警信号转向灯闪频率不变
		    TL_DUTY = TL_NORMAL_DUTY;
		    TL_PERIOD = TL_NORMAL_PERIOD;
	    }
	    else 
	    {
	              if(((TurnLampDrv == TurnLampRightOn)&&(TurnLampState == TLR_IS_OPEN))||((TurnLampDrv == TurnLampLeftOn)&&(TurnLampState == TLL_IS_OPEN)))
	              {
              		TurnLampState &= TL_STA_MASK;
              		TL_DUTY = TL_FAST_DUTY;
              		TL_PERIOD = TL_FAST_PERIOD;		

					//if(TurnLampDrv == TurnLampRightOn)CAN_TURNRightSW_Error;
					//if(TurnLampDrv == TurnLampLeftOn)CAN_TURNLeftSW_Error;
	              }
		       else
		       {
              		TL_DUTY = TL_NORMAL_DUTY;
              		TL_PERIOD = TL_NORMAL_PERIOD;
			}
	    }
	}
	

	//if ((IGNstate == OFF) || (TurnLampCScmd == TLCSCMD_NO)) return;

	//check turn left lamps is open or short ?
	//read turn left lamps adc value
	if(TurnLampDrv &  TurnLampLeftOn )
	{
               TURN_AD_LEFT_EN;
               adResultTemp =  GetADCresultAverage(3);
	           // test code
                
			 
               if(turnlt < turntlcnt) turnlt++;
               // adResultTemp1 = 6tyh;       		//judge turn left lamps is open ?
               else
               {
                      //turnbd(adResultTemp);
                      TURNAD =  adResultTemp;
                      if ((adResultTemp > TL_OPEN_VALUE)||( adResultTemp < turnshortad ))
                      {
                               if ( TurnLtime1 < (turnTL+5) )TurnLtime1++ ;                    
                      }
                      else
                      {
                             if(turnok1 < 5) turnok1++;
				 else  TurnLtime1 = 0;
                      }
               }
		 if ( TurnLtime1 > turnTL )
              {
                    TurnLtime1 = turnTL;
                    TurnLampState = TLL_IS_OPEN;
					//CAN_TURNLeftSW_Error;
                    //WriteDTC(0x9001) ; //error
               }
               else
               {
                    TurnLampState = 0;
       
               }
        }
        else
        {
               //TurnLtime1 = 0 ;
               turnlt=0;
        }


	//check turn right lamps is open or short ?
	if(TurnLampDrv &  TurnLampRightOn)
	{
	       TURN_AD_RIGHT_EN;
             adResultTemp = GetADCresultAverage(3);

	      // test code
             TURNAD =  adResultTemp;
			
             if(turnrt < turntlcnt) turnrt++;
             else
             {  
                  //turnbd(adResultTemp);
                  TURNAD =  adResultTemp;
                  if ((adResultTemp > TL_OPEN_VALUE)||( adResultTemp < turnshortad ))
                  {
                         if ( TurnRtime1 < (turnTL+5) )TurnRtime1++ ;                      
                  }
                  else
                  {
                              if(turnok2 < 5) turnok2++;
				 else  TurnRtime1 = 0;
                  }
              }
       
              if ( TurnRtime1 > turnTL )
              {
                      TurnRtime1 = turnTL ;
                      TurnLampState = TLR_IS_OPEN;
			  //CAN_TURNRightSW_Error;
                      WriteDTC(0x9003) ; //error
              }
              else
              {
                      TurnLampState = 0;
              }
              
       }
       else
       {
              //TurnRtime1 = 0;
              turnrt=0;
       }
       
}

unsigned int turnaverad;
void turnbd(unsigned int turnad)
{
    static unsigned int turnaddd[20];
   static ulong turnadd;
	static unsigned char turnnumber;
	unsigned char turnnumber1;
	if(turnnumber < 20)turnnumber++;
	
    turnaddd[turnnumber] = turnad;

	for(turnnumber1= 0;turnnumber1<16;turnnumber1++)
	{
	    turnadd += turnaddd[turnnumber];
	}
	
	turnaverad = turnadd>>4;
    

}




/*********************************************************************
Name    :   void FindCar(void)
Function:   V101BCM function description
Call    :   
Input   :   Keyinstate/RKE
Output  :   TurnLamp/turnsound/vehiclehorn
            TurnLampCScmd
History :   
   1>Author      :   lei
     Date        :   2007/11/15
     Description :   寻车功能 四门闭锁 按两次RKE闭锁 实现寻车
*********************************************************************/
void FindCar(void)
{
    static unsigned short FINDDRIVERTIME;			//25s
    static unsigned char  RKEnumber; 
	static unsigned char  tempFlag;					//horn/turn lamp driver flag
	
    if (FindCarFlag == TRUE)
    {
    	 //TurnFlashCnt = 0;   //20120308
        FINDDRIVERTIME++;
        if(FINDDRIVERTIME == 1) TurnFlashCnt = 35;

		//need horn 
        if (FINDDRIVERTIME <= 16)		{ HORN_ON;  tempFlag |= findCarHornOn;}	//250ms
        else if (FINDDRIVERTIME <= 32)	{ HORN_OFF; tempFlag &= findCarHornOff;}
        else if (FINDDRIVERTIME <= 48)	{ HORN_ON;  tempFlag |= findCarHornOn;}
  	 else { HORN_OFF; tempFlag &= findCarHornOff;}
 
    }
    else
    {
		if (tempFlag & findCarHornOn)	
		{
			HORN_OFF; 
			tempFlag &= findCarHornOff;
		}

             if(FindCarFlag == TRUE)FindCarFlag = FALSE;
             FINDDRIVERTIME = 0x00;
    }    

	if (DoorState!=0) //&& (KeyInState == KeyIsOutHole))
	{
		if(FindCarFlag == TRUE)  //20120308
		{
			FindCarFlag = FALSE;
			//if(turnfindcarstate == 1)TurnFlashCnt = 1;
		      TurnFlashCnt = 0;
		}
	}
	if(IGNstate==ON)
	{
		if(FindCarFlag == TRUE)  //20120308
		{
			FindCarFlag = FALSE;
			//if(turnfindcarstate == 1)TurnFlashCnt = 1;
			TurnFlashCnt = 0;
		}
	}//FindCarFlag = FALSE;  //add 20120308

	
}
/*********************************************************************/
/*              设防指示驱动                                           */
/*程序名称：void SFLED(void)                                        */
/*输    入：BCMtoGEM_AlarmStatus， Warningstate                      */
/*输    出：IMMO_LED_ON                                               */                                             
/*调用要求：在低功耗中调用                                           */
/*作    者：lei                 完成时间：2008.03.5                 */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void SFLED(void)
{    
       static uint ptime,ptime1;
       static unsigned char Leddrvom;
       if( Alarm_Actiated == 0x55 )
       {
              Leddrvom = 1;
       }
	else if( BCMtoGEM_AlarmStatus == Armed )
	{
	       if(Leddrvom != 1)Leddrvom = 2;   //new  20090903
	}
       else 
      {
           Leddrvom = 0;
	}
	   
	if(BCMtoGEM_AlarmStatus == prearmed) 
	{
           IMMO_LED_ON;
	     return;
	}
    if(Leddrvom == 1)//( Warningstate == 1 )
    {
        ptime++;
        if( ptime < 13 )
        {
            IMMO_LED_ON;
        }
		else if(ptime < 25 )
		{
            IMMO_LED_OFF;
		}
		else if(ptime < 38 )
		{
            IMMO_LED_ON;
		}
        else if( ptime < 125 )
        {
            IMMO_LED_OFF;
        } 
        else
        {
            ptime = 0 ;
        }
    }
    else if(Leddrvom == 2)//( BCMtoGEM_AlarmStatus == Armed )
    {
        ptime1++;
        if( ptime1< 13 )
        {
            IMMO_LED_ON;
        }
        else if( ptime1< 125 )
        {
            IMMO_LED_OFF;
        }
        else
        {
            ptime1= 0 ;
        }
        
    }
    else
    {
         ptime= 0;
		 ptime1= 0;
		 IMMO_LED_OFF;
    }
}



void Turnvcclow(void)
{
  static uchar turnproid;
  if(RKEBatteryVoltageturnstate != 0)
  	{
            if(IGNstate == OFF)
            {
                  if(++turnproid < 21){TURN_LEFT_LAMP_ON;  TURN_RIGHT_LAMP_ON; CAN_TURNRightSW_ON;CAN_TURNLeftSW_ON;}
                  else if(++turnproid < 47){TURN_LEFT_LAMP_OFF;TURN_RIGHT_LAMP_OFF;CAN_TURNRightSW_OFF;CAN_TURNLeftSW_OFF;}
                  else
                  {
                         turnproid=0;
                         RKEBatteryVoltage_turn++;
                         if(RKEBatteryVoltage_turn > 9)
                         {

                               RKEBatteryVoltage_turn=0;
                               RKEBatteryVoltageturnstate = 0;
                         }
                  }
            
            }
            else
            {
                   RKEBatteryVoltage_turn =0;
	               RKEBatteryVoltageturnstate = 0;
                   turnproid=0;

            }
  	}

}


/*********************************************************************
 end of the turnlamp_drv.c file
*********************************************************************/

