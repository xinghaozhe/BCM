/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              sys_init.h
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
/* "LockDrvCmd" bits definition */



/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/
//#define	 LOCK_RUN_TIME		    40    // 40*8ms = 320ms

/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/
//extern uchar  	LockState;

/*********************************************************************
 API DECLARATION
*********************************************************************/
extern void GPIO_SysInit(void);
//extern void GPIO_Init(void);
extern void RAM_Init(void);
extern void Clear_WDT(void);

/*********************************************************************
 end of the sys_init.h file
*********************************************************************/

