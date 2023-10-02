
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              horn_drv.h
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
#include "stm8_lib.h"
#include "can.h"
/*********************************************************************
 VARIABLES BITS DEFINITION
*********************************************************************/
//H4021Data1/2/3 bits definition

#define		LS_SIGNAL_IN2		       (H4021Data1 & 0x01)
#define		LS_SIGNAL_IN1			(H4021Data1 & 0x02)//????
#define		FORTIFY_SW				(H4021Data1 & 0x04)  
#define		SMALL_LAMP_SW			(H4021Data1 & 0x08)
#define		TRUNK_RELEASE_SW		(H4021Data1 & 0x10)
#define          P_SEATBELT_SW	              (H4021Data1 & 0x20)
#define		P_SEAT_SW				(H4021Data1 & 0x40)
#define		Alarm_IN				(H4021Data1 & 0x80)
/*


*/

/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/


/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/
extern uchar IGNstate;
extern uchar H4021Data1;
extern uint  EnalbeLearnRkeTime20s;
extern uchar CarHornstate;                       //进入设防报警状态标志
extern unsigned int HornDoorunclosetime;
/*********************************************************************
 API DECLARATION
*********************************************************************/
extern void ScanIgnSwitch(void);
extern void ScanHornSwitch(void);
extern void JudgeHornDriver(void);
extern void ScanH4021InData(void);


extern void ScanStandbyIgnSwitch(void);

/*********************************************************************
 end of the horn_drv.h file
*********************************************************************/


