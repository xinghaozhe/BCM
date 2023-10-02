
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              rke_drv.h
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

/*********************************************************************
 VARIABLES BITS DEFINITION
*********************************************************************/


/* return value definition */
//extern ulong f_RKE_SerialNum[KEY_COUNT];

#define     Okay        0x66
#define 	Fail		0x00
#define		CommandOk	0x01
#define     LearnKeyOk 	0x02

/* RKE flash turn lamps time */
#define		RKE_FLASH_TL_DUTY       30
#define     RKE_FLASH_TL_PERIOD     50

/* rke receive time out */
#define     RKE_RECEIVE_TIME_OUT    15      //15*8ms=120ms

/* rke auto lock time */
#define 	RKE_AUTO_LOCK_CNT		3750    //3750*8ms=30s

/* time out for receiving rke close windows command */
#define     RKE_CLOSE_WIN_CNT       40      //40*8ms=320ms

/* remote key count */
#define     KEY_COUNT               4       //Remote key count=4

//Immo led on time
#define     IMMO_LED_ON_TIME        225000  //225000*8ms=30m

//after rke send lock/close window command 2m,entry standby mode
//#define     ENTRY_STANDBY_DELAY     15000   //15000*8ms=2m

/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/
/* key switch definition in "B_Code[0]" */
//RKE命令重新编码  4位的最高位为电池电压标志位
//#define   	UnlockOtherDoorKey	  0x3000	//unlock other door key pressed
#define   	LockKey 	          0x2000	//lock all doors key pressed
#define   	UnlockTrunkKey        0x1000	//unlock trunk key pressed 
#define   	UnlockDriverDoorKey   0x4000	//unlock driver door key pressed
//#define     CLOSEWIN_CMD          0X6000
//#define     CLOSEWIN_STOP_CMD     0x7000
#define     UnlockDriver_set_CMD  0x6000
//#define     OPENWIN_CMD           0x5000
#define     RKEfindcar                0x8000

//extern uchar	FindCarFlag;
/* RKE_STEP definition */
#define     RKE_Idle            0x00
#define     RKE_RecData         0x01
#define     RKE_RecFinished  	0x02

/* Sync counter window definition */
#define 	SYNC_CNT_WIN_SINGLE	128
#define 	SYNC_CNT_WIN_DOUBLE	4096

/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/
#define     TWMIN 		    2400
#define     TWMAX 		    2600
//#define     T1PERIOD 	    5000
#define     T3PERIOD        5000

//engine rotate speed signal definition
#define     TIME_3S         600     // 600*5ms = 3s
#define     SPEED_700RPM    70      //  70/3 =  23.3Hz
#define     SPEED_1000RPM   100     // 100/3 =  33.3Hz
#define     SPEED_2000RPM   200     // 200/3 =  66.7Hz
#define     SPEED_3000RPM   300     // 300/3 = 100  Hz
#define     SPEED_4000RPM   400     // 400/3 = 133.3Hz
#define     SPEED_5000RPM   500     // 500/3 = 166.7Hz

//rke constant definition

#define     TE_ONE         1000     // 1  TE
#define     TE_HALF         500     // 0.5  TE
#define     TE_QUARTER      250     // 0.25 TE 

//rke mode definition
#define     LEARN_MODE      0x00a5
#define     NORMAL_MODE     0x00d2
#define     CLOSE_WIN_MODE  0x0069
#define     MODE_MASK       0x00ff
/*RKE_AUTO_LOCK bits definition*/
#define     RKE_AUTO_LOCK_YES	0x55
#define     RKE_AUTO_LOCK_NO	0x0

/*RKE_COMMAND bits definition */
#define     RKECMD_LOCK			0x01
#define     RKECMD_UNLOCK		0x02
#define     RKECMD_LEARN        0x04
#define     RKECMD_CLOSEWIN     0x08
#define     RKECMD_NO			0x00

/*********************************************************************
 MACRO DEFINITION
*********************************************************************/
#define ROTL(x,y) (((x)<<(y&(w-1))) | ((x)>>(w-(y&(w-1)))))


/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/
//extern uchar INITrkenumberstate ;
/*rke receive frame definition*/
extern unsigned int    Header[2];
extern unsigned int    A_Code[2];
extern unsigned int    B_Code[2];


extern uchar RKE_STEP;
extern uchar nPrecodeCnt;
extern uchar RKE_COMMAND;
extern ulong RX_SerialNum;
extern uint  RKE_FIFO_DATA[6];
extern uint  RX_Sync_Code,LAST_RX_sync_Code;
//extern uint  ROM_Sync_Code[KEY_COUNT];
//extern uint  SKey_B[13];
extern uchar IGNstate;
extern uchar RKE_AutoLockFlag;
extern uint  RKE_AutoLockCnt;
extern uchar RKE_COMMAND;
/* time out for receiving rke close windows command */
//extern uchar RkeCloseWinCnt;
//Immo led on time
extern ulong ImmoOnTime; 
extern uchar FindCarFlag;
extern uchar RKE_COMMAND_StandBy_state; //rke 按键状态
extern uchar   keyindex;
extern uint  B_Code_new;
//extern uchar RKEBatteryVoltage_State;   //RKE电池电压报警状态
extern uchar RKEBatteryVoltageturnstate;
extern uchar RKEWarmCancle;  //RKE取消报警状态
//extern uchar  reknumbercnt;
extern uchar RKE_DATA_OK;
extern uchar  RKE_outtime;
extern uchar DriverLOCK;
extern uchar RKEstadynumber;


extern unsigned int Buzz10sstate;
/*********************************************************************
 API DECLARATION
*********************************************************************/
extern void ScanRkeKeys(void);
extern void RKE_RECEIVE_RESET(void);
extern void RKE_RECEIVE_STOP(void);
//extern void RKE_Init(void);
extern void RkeStudy(void);
extern void RKEBatteryVoltage(void);
extern void SAVE_BatterVol_CODE(uchar keyindex,uchar data);
extern void SAVEunlockdriverstate(uchar x);
extern uchar RKEnumberRead(void);
extern void INITrkenumber(void);
extern void SAVE_SERIAL_NUMBER(uchar keyindex);

extern uchar LINWINDOWSTATE;
extern uchar RKELOCKstate;
/*********************************************************************
 end of the rke_drv.h file
*********************************************************************/


