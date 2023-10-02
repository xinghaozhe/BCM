/*
********************************************************************************************
*file name  : event.h                                                                      *
*description: This file is the head file for event.c                                       *
*author     : cqhubin@126.com                                                              *
*date       : 2007/06/13                                                                   *
********************************************************************************************
*/
#ifndef _EVENT_H_
#define _EVENT_H_

/*********************************************************************
 INCLUDE HEADER FILES
*********************************************************************/
#include "share.h"
#include "rke_drv.h"

/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/
#define     TWMIN 		    2400
#define     TWMAX 		    2600
#define     T1PERIOD 	    5000
#define     T2PERIOD        2500

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
#define     CLOSE_WIN_MODE  0x0069	//for CV11 BCM
#define     MODE_MASK       0x00ff



/*********************************************************************
 VARIABLES BITS DEFINITION
*********************************************************************/
//EngineSpeedState bits definition
#define     SPEED_FAST      0x55
#define     SPEED_SLOW      0x00

/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/

/*********************************************************************
 MACRO DEFINITION
*********************************************************************/


/*********************************************************************
 API DECLARATION
*********************************************************************/
extern void RTI_ISR(void);
extern void IRQ_ISR(void);
extern void T1C0(void);
extern void T1C1(void);
extern void T1C3(void);


#endif
