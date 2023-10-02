
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              window_drv.c
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
#include "gpio_macro.h"
#include "window_drv.h"
#include "adc_drv.h"
#include "rke_drv.h"

#include "beam_drv.h"
#include "can.h"

/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
//Window Ram Definition
u8  WinKeyState;                 //winsow keys state
u8  FLWinState;                  //window motor state

uchar WINFLdrv;

u8    IgnOffCtrl;



/*********************************************************************
Name    :   void ScanWindowKeys(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanWindowKeys(void)
{
    static uchar WinFLupcnt,WinFLdowncnt;

    uint winKeyADvalue;
   
        WinKeyState = NoWinKeyPressed;
		
        if ((IgnOffCtrl & EnableWinKey) == 0)  return;
    
        winKeyADvalue = GetADCresultAverage(1);
        if (winKeyADvalue < WIN_KEY_DOWN_ADV)
        {
            if(WinFLdowncnt <KEY_FILTER_CNT)WinFLdowncnt++;
            else if(WinFLdowncnt < 40)
            {
                  WinFLdowncnt++;
                   WINFLdrv = DowncontCOM ;
            }
            else 
            {
                   WINFLdrv = DownCOM;
            }
        }
        else if (winKeyADvalue < WIN_KEY_UP_ADV)
        {  
             if(WinFLupcnt <KEY_FILTER_CNT) WinFLupcnt++;
             else if(WinFLupcnt == KEY_FILTER_CNT)
             	{
             	      WinFLupcnt++;
                    WINFLdrv |= UpCOM ;
             	}
        }
        else
        {
              WinFLupcnt = 0;
              WinFLdowncnt = 0;
    	       if( WINFLdrv != DowncontCOM) WINFLdrv = 0;
        }
        

	}







/*********************************************************************
Name    :   void WindowUp(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void WindowUp(void)
{
    WIN_FL_UP_ON; WIN_FL_DOWN_OFF; FLWinState |= Uping; FLWinState &= ~Stop;
	CAN_FLwindowDrv_ON;

}   



	
/*********************************************************************
Name    :   void WindowDown(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void WindowDown(void)
{
    WIN_FL_UP_OFF; WIN_FL_DOWN_ON; FLWinState |= Downing; FLWinState &= ~Stop;
	CAN_FLwindowDrv_ON;

} 

/*********************************************************************
Name    :   void WindowStop(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void WindowStop(void)
{ 
    WIN_FL_UP_OFF; WIN_FL_DOWN_OFF; FLWinState |= Stop; FLWinState &= ~(Uping+Downing);
	CAN_FLwindowDrv_OFF;

} 


/*********************************************************************
Name    :   void WindowDriver(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void WindowDriver(void)
{	  
    static uint  FLDowncontcnt;
	static uint  FLBFtime;
	static uchar WINFLdrv_old;
       //  FL  WINDOW
       if(WINFLdrv == DownCOM )   {  WindowDown(); FLDowncontcnt = 0 ; }
       else if(WINFLdrv == UpCOM )  {  WindowUp();  FLDowncontcnt = 0 ;  }
       else if(WINFLdrv == DowncontCOM)
       {
             FLDowncontcnt++;
             if(FLDowncontcnt < Downconttime)
             	{
                   WindowDown();
             	}
              else
              {    
                    FLDowncontcnt = 0;
                    WINFLdrv = 0 ;
                    WindowStop();
              }
       }
       else   {     WindowStop();  FLDowncontcnt = 0 ; }
	

	///////////////////////////////////////////////////////////////////////////////////////
	if(WINFLdrv != WINFLdrv_old)
	{
             WINFLdrv_old = WINFLdrv;
	         FLBFtime = Downconttime;
	}
	if(FLBFtime != 0)
	{
              FLBFtime--;
			  if(FLBFtime == 0)
			  {
				  WindowStop();  FLDowncontcnt = 0  ;
			  }
	}
 
    
}    


