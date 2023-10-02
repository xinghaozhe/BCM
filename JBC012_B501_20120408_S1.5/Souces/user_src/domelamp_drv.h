
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              interiorlamp_drv.h
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


/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/

/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/
extern uchar DomeLampDrv;
extern ulong  fade_out_time;     //亮灯时间计数
extern unsigned char count;
extern uchar RKELOCKstate;   // 0x00  0x55 0x0aa
extern ulong Battertime;
/*********************************************************************
 API DECLARATION
*********************************************************************/
extern void JudgeDomeLampDriver(void);
//extern void OpenSaveBatter(void);
extern void DomeLampsDriver(void);
/*********************************************************************
 end of the interiorlamp_drv.h file
*********************************************************************/


