
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              wiper_drv.h
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
/*FrontWiperDrv bits definition */
#define FrontWiperHighOn		0x01
#define FrontWiperSlowOn		0x02
#define FrontWiperIntOn			0x04
#define FrontWiperWasherOn		0x08
#define FrontWiperWasherOn2		0x10
#define FrontWiperOff			0x00

/*RearWiperDrv bits definition */
#define RearWiperIntOn			0x01
#define RearWiperWasherOn		0x02
#define RearWiperWasherOn2		0x04
#define RearWiperOff			0x00

/*WiperParkSta bits definition */
#define fWiperParkYes			0x01
#define rWiperParkYes			0x02
#define WiperParkNo				0x00

/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/
#define wiper_park_filter_cnt            4
#define WIPER_KEY_FILTER_CNT   	4    	// filter time = 5*8ms = 40ms
#define WIPER_KEY_FILTER_CNT_OFF   	2    	// filter time = 5*8ms = 100ms
#define WASHER_KEY_FILTER_CNT  	37    	// filter time = 37*8ms = 300ms
#define WIPER_WASHER_1_CYCLE  	100   	// runing time = 100*8ms = 800ms
#define WIPER_WASHER_3_CYCLE  	500   	// runing time = 500*8ms = 4s
#define WIPER_WASHER_PERIOD		1250   	// runing time = 1250*8ms = 10s
#define WIPER_INT_DUTY   		100   	// runing time = 100*8ms = 800ms
#define WIPER_INT_PERIOD       	750		// period time = 750*8ms = 6s
#define FR_WIPER_INT_PERIOD    	1250    // period time = 1250*8ms = 10s 
#define WIPER_WASHER_CYCLE_CNT	2		// wiper runing 2 times (3+1 cycle)

//front wiper int resistor AD value
#define	WIPER_INT_1_ADV			1000		//  2K/ 1  S/5.14~6.43V/255
#define	WIPER_INT_2_ADV			550// 4*150		//  7K/ 3.5S/2.11~2.65V/107~136
#define	WIPER_INT_3_ADV			260// 4*80		// 17K/ 6  S/0.97~1.22V/ 49~ 63
#define	WIPER_INT_4_ADV			160 // 4*40		// 35K/ 9.6S/0.49~0.62V/ 25~ 32
#define	WIPER_INT_5_ADV			80 // 4*20		// 67K/15.5S/0.26~0.33V/ 13~ 17
#define	WIPER_INT_6_ADV			40 // 4*10		//137K/22  S/0.13~0.16V/  6~  9

//front wiper int period value
#define	WIPER_INT_1_TIME		125		// 125*8ms= 1  S/  2K/5.14~6.43V/255
#define	WIPER_INT_2_TIME		437		// 437*8ms= 3.5S/  7K/2.11~2.65V/107~136
#define	WIPER_INT_3_TIME		750		// 750*8ms= 6  S/ 17K/0.97~1.22V/ 49~ 63
#define	WIPER_INT_4_TIME		1200	//1200*8ms= 9.6S/ 35K/0.49~0.62V/ 25~ 32
#define	WIPER_INT_5_TIME		1937	//1937*8ms=15.5S/ 67K/0.26~0.33V/ 13~ 17
#define	WIPER_INT_6_TIME		2750	//2750*8ms=22  S/137K/0.13~0.16V/  6~  9

/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/
extern  uchar  FrontWiperDrv;
extern  uchar  RearWiperDrv;
extern  uint   FrontWiperIntTime;
extern  uchar  FrontWiperHighDrv;
/*********************************************************************
 API DECLARATION
*********************************************************************/
extern void ScanWiperSwitch(void);
extern void JudgeFrontWiperDriver(void);
extern void JudgeRearWiperDriver(void);
//void HighWiperdrv(void);

/*********************************************************************
 end of the wiper_drv.h file
*********************************************************************/


