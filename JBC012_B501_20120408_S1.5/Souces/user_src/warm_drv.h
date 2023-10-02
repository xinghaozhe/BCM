
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              warm_drv.h
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

/*********************************************************************
 VARIABLES BITS DEFINITION
*********************************************************************/
//"KeyInState" bits definition
#define     KeyIsInHole             0x01
#define     KeyIsOutHole            0x00

//"DoorState" bits definition
#define     DriverDoorIsOpen        0x01
#define     OtherDoorIsOpen         0x02
#define     TrunkIsOpen             0x04
#define      FDdoorisopen		 0x08
#define     Hoodinopen              0x10
#define     AllDoorIsOpen           0x1f
#define		AllDoorIsClosed			0x00

//"SeatState"  bits definition
#define		DSeatbeltBuckled		0x01
#define		PSeatbeltBuckled		0x02
#define		PassengerSeated			0x04

//"WarmType" bits definition
#define     Seatbelt_Warning        0x01
#define     Door_Unclosed_Warning   0x02
#define     Key_In_Warning          0x04
#define     Light_On_Warning        0x08
#define     Other_Warning           0x10
#define     LOCKwarning             0x20

//"CarState" bits definition
#define		CarIsOkay				0x00
#define		CarIsAttack				0x55

#define     CarSpeedValue           0x7     //7Km/s  需要标定

typedef volatile struct
{
	u16 buzzcnt;
	u16 buzzmaxtime;
	u16 buzzontime;
	u8  buzzyx;
	u16 BuzzerCnt;
} BUZZER;
/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/
//#define	    KEY_FILTER_CNT		    25    // 25*2ms = 50ms

/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/
extern uchar KeyInState;
extern uchar SmallLampSwitchState;
extern uchar DoorState;
extern uchar CarState;
extern uchar SeatState;
extern uchar BuzzerOnCnt,BuzzerDuty,BuzzerPeriod;
extern uint  CarSpeed[3];            //车速信号  通过CAN或LIN总线取值
extern uchar BrakeSignal;
extern uchar FORTIFYSW_state;     //设防开关状态
extern uchar WarmType;                       			 //警告类型
extern u16   TrunkWarmTime;        
extern uchar RKEopenTrunkWarm ;
//extern uchar LightONOPENState;                          //灯未关标志
//extern uchar LockSpeedtime;

extern uchar Buzzertime;           //轰鸣器叫时间计数
/*********************************************************************
 API DECLARATION
*********************************************************************/
extern void ScanKeyInState(void);
extern void ScanSmallLampSwitch(void);
extern void ScanAllDoorState(void);
extern void ScanSeatbeltBuckleState(void);
extern void ScanSeatPositionState(void);
extern void JudgeWarmTypeAndDriver(void);
extern void ScanStandByDoorAjarSwitch(void);
extern void ScanFortifySWState(void);
extern void ScanStandbySmallLampSwitch(void);
extern void TrunkWarm(void);
extern void buzzdrv2(void);
extern void BuzzerDrv(uchar buzzercnt,uint buzzertime,uint buzzerontime,uchar buzzyx);
extern void ClearBuzzdrv(u8 buzzyx);
extern void BuzzCANsend(uchar BUZZYX,uchar zt);
/*********************************************************************
 end of the warm_drv.h file
*********************************************************************/

#define Buzzdoorunclose           0x1b
#define Buzzlightunclose   		  0x10
#define Buzzlockdoorunclose 	  0x15
#define BuzzlockoutArim			  0x14
#define BuzzDrvunlockset          0x05
#define Buzzdrvseat               0x19
#define buzzvcclow                0x16
#define buzzlearnkey			  0x04
#define buzzspeedlockon           0x02
#define buzzspeedlockoff           0x03