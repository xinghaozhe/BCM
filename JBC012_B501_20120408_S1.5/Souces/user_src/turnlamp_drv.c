
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
uchar  TLSwitchRoadwayFlashCnt;    //���3�μ���
uchar  TL_DUTY,TL_PERIOD;
uint   TurnFlashCnt;
uint  TurnLamp_CrashKeepTime;     //��ײ�����ź���ͱ���ʱ�䣬��lock.c�����и�ֵ
uchar  Crash_state_Y;            //��ײ�źű��
uint     ledcnt;
uchar  HazzardState;         //��������״̬
uchar  Turn_R_State;         //��ת����״̬
uchar  Turn_L_State;         //��ת����״̬
uchar  Turn_R_CH_State;      //��ת����״̬
uchar  Turn_L_CH_State;      //��ת����״̬
uchar  TurnState_Number;     //���ȼ�״̬����
uint   WarningTimeCnt;  	//������� 5���Ӽ���	
uchar  Warningstate;
uchar  BrakeSpeedHazards_state;  //����ɲ������״̬

extern unsigned char DIDF1f2EEPROM[2];
/////
unsigned int TURNAD;



extern u8     HornAlarmState                @0x4085;   //���ȱ���
/*********************************************************************/
/*                     ��������״̬ɨ��                              */
/*�������ƣ�Void ScanHazzardKeys(void)                               */
/*��    �룺HAZZARD_LI                                               */
/*��    ����hazzardState                                             */                                             
/*����Ҫ��void ScanTurnLampKeys(void)�����е���                    */
/*��    �ߣ�lei                 ���ʱ�䣺2007.12.03                 */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
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
/*               �͹��ı�������״̬ɨ��                              */
/*�������ƣ�Void ScanStandByHazzardKeys(void)                        */
/*��    �룺HAZZARD_LI                                               */
/*��    ����StandByhazzardState                                      */                                             
/*����Ҫ���ڵ͹����е���                                           */
/*��    �ߣ�lei                 ���ʱ�䣺2008.01.14                 */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*********************************************************************/
void ScanStandByHazzardKeys(void) 
{
	static uchar StandByhazzardYesCnt;
	 if(!HAZARD_SW) 
	 {

        	StandByState = Pressed;    //��״̬�˳��͹��ĺ�Ӧ���
        }

}

/*********************************************************************/
/*                     ���ȼ��㷨                                    */
/*�������ƣ�Void ScanTurnLampKeys(void)                              */
/*��    �룺TURN_R_LI��TURN_l_LI�HhazzardState��crashstate           */
/*��    ����TurnLampDrv                                              */                                             
/*����Ҫ����������8MS����һ��                                      */
/*��    �ߣ�lei                 ���ʱ�䣺2007.12.03                 */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
/*20080121      lei      ȡ��:���б���ת������30S      ������������  */
/*********************************************************************/
void ScanTurnLampKeys(void)
{         
      static uchar lTurnYesCnt, lTurnNoCnt;
      static uchar rTurnYesCnt, rTurnNoCnt;
      static uchar R_oldstate,L_oldstate,HAZZARD_oldstate;   
      
      static ulong  lTurnLamp_KeepTime;       /*��ת����ڱ����ź���Ч������´�ʱ���ȵ�ʱ��*/
      static ulong  rTurnLamp_KeepTime;       /*��ת����ڱ����ź���Ч������´�ʱ���ȵ�ʱ��*/
      

      static uchar  Speedwarmstate;
      ScanHazzardKeys();
      
      //��ת�򿪹�״̬ɨ��
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
                Turn_R_CH_State = Unpressed;      //ת������ ȡ�����
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
      //��ת�򿪹�״̬ɨ��
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

    //״̬��������

    

    //�ұ������
    if(( IGNstate == ON )&&(Turn_R_CH_State== Pressed) && (TLSwitchRoadwayFlashCnt < 3)\
    	&& ( HazzardState == Unpressed) &&( Crash_state_Y != 1))
    {
    	TurnState_Number = 3 ;                                                                     //�ұ����Ч
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////	
    if((TurnState_Number == 3)&&(TLSwitchRoadwayFlashCnt >= 3))    ///20091028����/////////////////////////////////bug
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

    //��������
    if(( IGNstate == ON )&&(Turn_L_CH_State == Pressed)&& (TLSwitchRoadwayFlashCnt < 3)\
    	&& ( HazzardState == Unpressed) &&( Crash_state_Y != 1))
    {   
    	TurnState_Number = 4 ;       //������Ч
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
    //��ת��
    if(( IGNstate == ON )&&(Turn_R_State == Pressed)&& (Crash_state_Y != 1))
    {
         if((TurnState_Number == 3)||(TurnState_Number == 4))
         {
             TurnLampOnCnt = 0 ;
         }
         TurnState_Number = 1 ;             //��ת��Ч ��ײ�ź���Ч��ת�������ں��浥����ֵ
    }
    else if((Turn_R_State == Unpressed)&&(TurnState_Number == 1) && (Crash_state_Y != 1))
    {
        if((TurnState_Number != 3)||(TurnState_Number != 4))
        {
            TurnState_Number = 0;               //����ת�򿪹���Ч ���־
        }
    }
	
    //��ת��
    if(( IGNstate == ON )&&(Turn_L_State == Pressed)&& (Crash_state_Y != 1))
    {     
         if((TurnState_Number == 3)||(TurnState_Number == 4))
         {
             TurnLampOnCnt = 0 ;
         }
        TurnState_Number = 2 ;             //��ת��Ч ��ײ�ź���Ч��ת�������ں��浥����ֵ
    }
    else if((Turn_L_State == Unpressed)&&(TurnState_Number == 2)&& (Crash_state_Y != 1))
    {
        if((TurnState_Number != 3)||(TurnState_Number != 4))
        {
            TurnState_Number = 0;               //�����ת�򿪹���Ч ���־
        }
    }
	
    //��/��ת��ͬʱ��ЧΪ����
    if(( Turn_R_State == Pressed) && ( Turn_L_State == Pressed)) TurnState_Number = 0; //����
    
    //��������
    if(( HazzardState == Pressed)&&(rTurnLamp_KeepTime == 0)&&(lTurnLamp_KeepTime == 0))  TurnState_Number = 5 ;                                     //������Ч
    else if((HazzardState == Unpressed)&&(TurnState_Number == 5))
    {
        TurnState_Number = 0;   //�������عأ����־
    }

    //��ײ�ź�
    if( CrashState  == Pressed) Crash_state_Y = 1;                                         //��ײ��Ч  
    
    if(( Crash_state_Y == 1 )&&(rTurnLamp_KeepTime == 0)&&(lTurnLamp_KeepTime == 0)) TurnState_Number = 6 ;
    else if(TurnState_Number == 6)
    {
         TurnState_Number = 0;
    }
	
    //�����ײ�ͱ�������Ч ȡ����/��ת������30��
    if((HazzardState == Unpressed) && (Crash_state_Y != 1))
    {
        rTurnLamp_KeepTime = 0;
        lTurnLamp_KeepTime = 0;
    }
	//����   ���б��� ת������  	
    //��������ײ����Ч   ��ת�������    
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
	
    if(rTurnLamp_KeepTime != 0) //����30�� ��ת������
    {
         rTurnLamp_KeepTime--;
         //TurnState_Number = 1;    
         if((rTurnLamp_KeepTime == 0)&&(TurnState_Number == 1))
         {
             TurnState_Number = 0 ;
         }
    }
	//����   ���б��� ת������   δ����	
    //��������ײ��Ч  ��ת������30��
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
	
    if(lTurnLamp_KeepTime != 0) //����30�� ��ת������
    {
         lTurnLamp_KeepTime--;
         if((lTurnLamp_KeepTime == 0)&&(TurnState_Number == 2))
         {
			 TurnState_Number = 0; 
         }
            
    }
	
    //��ײ�ź���Ч 4��󱨾�����״̬�б仯���ұ仯��Ϊ�� ��رձ���
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
              Crash_state_Y = 0;           //�ر���ײ����
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
                     Warningstate = 1;   //�˴�����Ӱ����䱨��  //0317
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
             Alarmstatus_RKE = 4; //��������BCM��Ҫ�ص�����״̬
         }
         if(DIDF1f2EEPROM[0] != 0x00)TurnState_Number = 7;
		 
         if ( ( !HornWarm ) && ( DIDF1f2EEPROM[0] != 0x00 ) )   //������������ж��Ƿ��������ȱ���
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

    //ɲ������

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

    //BCMΪ��ʼ����ȡ�����ⱨ������
    if((DIDF1f2EEPROM == 0x00)||(CAN_FORTIFY_state == 0x55))
    {
        if(TurnState_Number >= 7)
        {
            TurnState_Number = 0 ; ////////////////////
        }
    }
    
	
    switch(TurnState_Number)
    {

	   case 1: TurnLampDrv = TurnLampRightOn;          //����ת��   
	           //CAN_TURNRightSW_ON;
			   //CAN_TURNLeftSW_OFF;
	           if(IGNstate == OFF) {TurnLampDrv = TurnLampDrv&TurnLampRightOff; }//CAN_TURNRightSW_OFF;}
			   
               break;
       case 2: 
	   	       TurnLampDrv = TurnLampLeftOn;       	   //����ת��
	   	       //CAN_TURNLeftSW_ON;
			   //CAN_TURNRightSW_OFF;
               if(IGNstate == OFF){ TurnLampDrv = TurnLampDrv&TurnLampLeftOff;}// 	 CAN_TURNLeftSW_OFF;  }

               break;
       case 3: TurnLampDrv = TurnLampRightOn;          //����ת���
               //CAN_TURNRightSW_ON;
			   //CAN_TURNLeftSW_OFF;
       	       break;
       case 4: TurnLampDrv = TurnLampLeftOn;           //����ת���  
               //CAN_TURNLeftSW_ON;
			   //CAN_TURNRightSW_OFF;
       	       break;
       case 5: TurnLampDrv = TurnLampHazzardOn;        //�ñ������ر���  
               //CAN_TURNRightSW_ON;
			   //CAN_TURNLeftSW_ON;
       	       break;
       case 6: TurnLampDrv = TurnLampCrashOn;          //����ײ����
               //CAN_TURNRightSW_ON;
			   //CAN_TURNLeftSW_ON;
       	       break; 
	   case 7: TurnLampDrv = TurnLampHazzardOn; 	   //����������쳣����
	           //CAN_TURNRightSW_ON;
			   //CAN_TURNLeftSW_ON;
			   break;
			  //if(BCMtoGEM_AlarmStatus ==0){TurnLampDrv = 0;CAN_TURNRightSW_OFF; CAN_TURNLeftSW_OFF;break;}
	   case 8: TurnLampDrv = TurnLampHazzardOn;        //����ɲ������  
	            //     CAN_TURNRightSW_ON;
			   //CAN_TURNLeftSW_ON;
	           break;
       default: TurnLampDrv = 0x00;                    //��������κ�״̬   
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
  
    //ת��Ƶ�˿ʧЧ�궨���� 
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
	    {//Ϊ�˱�֤��˿ʧЧʱ�����ź�ת�����Ƶ�ʲ���
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
     Description :   Ѱ������ ���ű��� ������RKE���� ʵ��Ѱ��
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
/*              ���ָʾ����                                           */
/*�������ƣ�void SFLED(void)                                        */
/*��    �룺BCMtoGEM_AlarmStatus�� Warningstate                      */
/*��    ����IMMO_LED_ON                                               */                                             
/*����Ҫ���ڵ͹����е���                                           */
/*��    �ߣ�lei                 ���ʱ�䣺2008.03.5                 */
/*�����޸ļ�¼                                                       */
/*�޸�����      ����         �޸�����                   ��ע         */
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

