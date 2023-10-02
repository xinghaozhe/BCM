
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
#include "share.h"


//extern uchar LockSpeedtime;

/*********************************************************************
 VARIABLES BITS DEFINITION
*********************************************************************/
/* "LockDrvCmd" bits definition */
//#define  UnlockOtherDoorCmd     0x10
#define  LockCmd 				0x20
#define  UnlockTrunkCmd     	0x40
#define  UnlockDriverDoorCmd    0x80
#define  NoLockCmd 				0x00
#define  SpeedDoor         DoorState & DriverDoorIsOpen
/* "LockState" bits definition */
#define  Locked    			0x55
#define  Unlocked          	0x00

extern uchar   speedlockset;

//"LockSwitchState" bits definition
#define	 LockSWpressed			0x01
#define	 UnlockSWpressed		0x02
#define	 LockUnlockSWunpressed	0x00

//BCM警戒状态信息20MS发送一次到GEM   定义
#define  Disarmed               0x00      //报警解除状态
#define  prearmed               0x08      //预警戒状态
#define  Armed                  0x10      //警戒状态
#define  Actiated               0x18      //报警激活状态
#define  DELall                 0xe7      //诊断清出用


/* "CrashState" bits definition */
#define  IsCrashed          0x55
#define  NoCrashed          0x00

/* "WindowDriverState" and "WinKeyState" bits definition */
#define  flwu               0x01
#define  flwd               0x02
#define  frwu               0x04
#define  frwd               0x08
#define  rlwu               0x10
#define  rlwd               0x20
#define  rrwu               0x40
#define  rrwd               0x80

/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/
//lock hot protect time definition 
#define	 LOCK_RUN_TIME		    25    // 25*8ms = 200ms
#define  AGAIN_UNLOCK_TIME      375   // 375*8ms = 3s
#define  LOCK_HOT_PROTECT_2S    250   // 250*8ms = 2s
#define  LOCK_HOT_PROTECT_5S    625   // 625*8ms = 5s
#define  LOCK_HOT_PROTECT_10S   1250  // 1250*8ms = 10s
#define  LOCK_HOT_PROTECT_15S   1875  // 1875*8ms = 15s
#define  LOCK_HOT_PROTECT_20S   2500  // 2500*8ms = 20s
#define  LOCK_HOT_PROTECT_5M    37500 // 37500*8ms = 5m

//lock/unlock switchs' ad value definition	
#define	 LOCK_SW_ADV			800//190		// 256*(1.2K/(1.2K+1K))=140 256*(0.6K/(1.2K+1K))=70
#define	 UNLOCK_SW_ADV			70// 160//30		// 256*(0  K/(1.2K+1K))


/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/
extern uchar  LockState;
extern uchar  CrashState;
extern uchar  LockDrvCmd;
extern uchar  TRUNK_UNLOCK_RKEstate;    //RKE开后备箱标志
extern uchar  BCMtoGEM_AlarmStatus;     //BCM警戒状态信息20MS发送一次到GEM
extern uchar  Alarmstatus_RKE;          //rke状态信息
extern u16    wLockProtectTimeCnt;      //一分钟时间计数
extern uchar  VehicleTypePZ;            //车型  CV8 /CV101
extern uchar  TRUNKWarmstate;
extern uint   BUZZLocktimecnt;
extern uchar  DoorWarmState;
extern uchar  Lockonesstate;
extern uchar  crashlockstate;
extern uchar  MachineLocktime;
extern uchar   dooropenlock;

extern uchar Speedlockcnt;

extern uchar   Alarm_Actiated;



#define Speedlock  0x01

/*********************************************************************
 API DECLARATION
*********************************************************************/
extern void SaveWindowDriverState(void);
extern void ResumeWindowDriverState(void);
extern void ScanCrashInSignal(void);
extern void ScanAllLockState(void);
extern void ScanCentralLockSwitch(void);
extern void JudgeLockDriver(void);
extern void ScanTrunkSwitch(void);
extern void ScanStandByCrashInSignal(void);
extern void WarmStatusArithmetic (void);
//extern void WriteLockSpeedState (uchar value);
extern void TRUNKwarm(void);
extern void Lockhot(void);
extern void MachineKeyDrv(void);

/*********************************************************************
 end of the lock_drv.h file
*********************************************************************/


