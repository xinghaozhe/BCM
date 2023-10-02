
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              defrost_drv.h
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
//EngineState bits definition 
#define  ENGINE_700RPM          0x01
#define  ENGINE_STARTING        0x02

//BatVoltageState bits definition
#define  batvolOkay				0x00
#define  batvolLow				0x55

/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/
#define  DEFROST_FILTER_PHASE   25      //10*8=80ms
#define  DEFROST_TIMEOUT_PHASE  105000  //105000*8ms=840s=14m
#define  BATTERY_VOLTAGE_CNT	100		//100*2ms=200ms	

// 8v*47k/(100k+47k) = 2.5578v
// 256*2.5578v/5v = 131 = 0x83
// 1024*2.5578v/5v = 524 = 0x20c
#define  BATTERY_VOLTAGE_9V		524

//EngineSpeed value constant definition


/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/
extern uchar  BatVoltageState;
extern uchar  DefrostKeySta;
extern uchar  DefrostDriverState;    //后除霜工作状态  诊断用
/*********************************************************************
 API DECLARATION
*********************************************************************/
extern void ScanDefrostSwitch(void);
extern void ScanBatteryVoltage(void);
extern void JudgeDefrostDriver(void);

/*********************************************************************
 end of the defrost_drv.h file
*********************************************************************/

