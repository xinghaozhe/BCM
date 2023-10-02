
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H
#define ENTRY_STANDBY_DELAY     227000//150000 //250////1//进入低功耗时间
#define IMMO_LED_DUTY         1       //设防指示灯点亮时间
#define IMMO_LED_PERIOD      50      //设防指示灯周期
#define RKEShortDownTime     9
#define WakeCycle                   9//             // 7= 16ms 8=32ms 9=64ms 
/*********************************************************************
 INCLUDE HEADER FILES
*********************************************************************/
#include "stm8_lib.h"
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
extern uchar   SysTimeFlag_2MS;
extern uchar   SysTimeFlag_8MS;
extern uchar   WakeState;            //睡眠唤醒标志变量
extern uint    WakeInTime;           //延时进入睡眠 时间  调试用变量
extern uint    WakeUpTime;           //唤醒时间           调试用变量
extern uchar   StandByState;         ////有门信号、报警、碰撞、灯光  退出低功耗模式
extern uchar   StandTIM3state;
extern ulong  StandbyTime;  //进入低功耗时间计数
extern uint wakestate;

/*********************************************************************
 API DECLARATION
*********************************************************************/
extern void delay_ms(u16 n_ms);
extern void delay_10us(u16 n_10us);
extern void ONSEINITEeprom(void);

extern void WakeUp(void);

extern unsigned char Weeprommain(unsigned long temp,unsigned char value);

#define winbftime   5500
#endif /* __MAIN_H */
