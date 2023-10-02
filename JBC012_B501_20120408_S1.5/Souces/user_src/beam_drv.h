
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              beam_drv.h
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
//"LightControlState" bits definition
#define 	SmallLampSWpressed		0x01	
#define 	LowBeamSWpressed		0x02
#define 	LowBeamSWunpressed		0x04
#define 	GoHomeLowBeam			0x07

/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/

/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/
extern uchar HighBeamSwitchState;
extern uchar LowBeamSwitchState;
extern uchar Buzzertime;           //轰鸣器叫时间计数
extern uchar LOWBeamDriverState;   //近光灯驱动状态

/*********************************************************************
 API DECLARATION
*********************************************************************/
extern void ScanHighLowBeamSwitch(void);
extern void JudgeLowBeamDriver(void);

/*********************************************************************
 end of the beam_drv.h file
*********************************************************************/


