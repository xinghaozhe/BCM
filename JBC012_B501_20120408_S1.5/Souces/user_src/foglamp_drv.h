
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              foglamp_drv.h
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
/*
#define     KeyIsInHole             0x01
#define     KeyIsOutHole            0x00
*/
//"DoorState" bits definition


/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/
//#define	    KEY_FILTER_CNT		    25    // 25*2ms = 50ms

/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/
extern u8 FrontFogLampSwitchState;
extern u8 RearFogLampSwitchState;

/*********************************************************************
 API DECLARATION
*********************************************************************/
extern void ScanFogLampSwitch(void);
extern void JudgeFogLampDriver(void);

/*********************************************************************
 end of the foglamp_drv.h file
*********************************************************************/


