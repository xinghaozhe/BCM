
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              wiper_drv.h
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
//extern void windowcs(void);

/*********************************************************************
 INCLUDE HEADER FILES
*********************************************************************/
#include "share.h"

/*********************************************************************
 VARIABLES BITS DEFINITION
*********************************************************************/
//"FL/FR/RL/RRWinState" bits definition 
#define     Uping            0x01
#define     Downing          0x02
//#define     Close            0x04
//#define     Open             0x08
#define     Stop             0x10
                                        //assume "key pressed time" = "tp"
//"WindowKeyState" bits definition 
#define     NoWinKeyPressed  0x00
#define     FLWUKpressed     0x01
#define     FLWDKpressed     0x02


#define     DowncontCOM   0x01
#define     DownCOM          0x02
#define     UpCOM               0X03
//"RkeCloseWinState" bits definition
#define     RkeCloseWinCmd   0x55
#define     NoRkeCloseWinCmd 0x00

//"IgnOffCtrl" definition
#define     EnableWinKey      0x01
#define     DisableWinKey     0xfe
#define     EnableCentralKey  0x02
#define     DisableCentralKey 0xfd

//extern unsigned char windowbj;
/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/
//window keys ad value definition
#define		WIN_KEY_UP_ADV			800		// 1024*(1.2K/(1.2K+1K))=560 // 256*(0.6K/(1.2K+1K))=280
#define		WIN_KEY_DOWN_ADV		200		// 1024*(0  K/(1.2K+1K)) //20091023¸ü¸Ä

//window contrl time
#define     WIN_FILTER_PHASE        10      //5*8ms=40ms   if tp<40ms->no key pressed
#define     WIN_CONTINUE_PHASE      50      //50*8ms=400ms if 40ms<=tp<320ms->window continue down
#define     WIN_TIMEOUT_PHASE       1000    //1000*8ms=8s  if 8s<=tp->window stop
#define     WIN_STEP_START_UP       25//50      //25*8ms=200ms flw->frw->rlw->rr(up)-->stop

//window key contrl(enable/disable) time
#define     WIN_KEYS_DISABLE_TIME   7500    //7500*8ms=60000ms=1m   

#define     RkeOpenWindowTime    750       // 6s

//if pinch I=10A, then (10mo*10A*15/5v)*255 = 76.5
#define	    WIN_PINCH_CURRENT       200     //150 //100     //76 
#define     WIN_PINCH_FILTER_CNT    5

//window definition
#define     FLW             0x00
#define     FRW             0x01
#define     RLW             0x02
#define     RRW             0x03
#define     ALL             0x66	

#define     Downconttime  750  //////???/
//#define     wintimeBF   6400   

/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/
extern u8    IgnOffCtrl;


extern u8    WinKeyState;     
extern u8    RkeOpenWindowstate;
extern uchar WINFLdrv;
extern  void RkeOpenWindow(void);
extern  void ScanWindowKeys(void);

extern  void WindowDriver(void);
extern  void WindowUp(void);
extern  void WindowDown(void);
extern  void WindowStop(void);
//extern  void CheckWinTimeOut(void);
/*********************************************************************
 API DECLARATION
*********************************************************************/

/*********************************************************************
 end of the window_drv.h file
*********************************************************************/


