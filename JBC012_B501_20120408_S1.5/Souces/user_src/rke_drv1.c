

/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              rke_drv.c
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

/****************************************************************************************
*****************************************************************************************
Description
  1> CR5-w/r/b {CR5-16/12/8} 
     w-bit length                  (16)
     r-roll times(encrypt/decrypt) (12) 
     b-byte of key password        ( 8)
     
  2> Baud rate : 1k bps
  
  3> Manchester Encoding 
     logic 1 : ______        
                     |
                     |______

                      ______ 
     logic 0 :       |
               ______|

  4> Frame definition
      _   _ ________ _   _       ____ _________ ________ ________ 
     | | | |        | | | |     |    |         |        |        |
     |_|_| |________| |_| |_____|    |_________|________|________|____________
     |      Preamble      | Low |high|  Header | A_Code | B_Code | Guard time |

     a>Preamble(23TE = 12 high + 11 low)
             |<-------------- 11.5 ms high --------------->|
       high:_|_   _   _   _   _   _   _   _   _   _   _   _ 
             | | | | | | | | | | | | | | | | | | | | | | | |
       low :_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |

     b>Low(8TE low)
             |<--- 4 ms low --->|
       high:_|                  |
             |                  |
       low :_|__________________|

     c>High(1TE high)
             |<-- 0.5 ms high ->|
       high:_|__________________|
             |                  |
       low :_|                  |
       
     d>Header(16 bits)
       0~7  bit: Mode code
                 Learn  mode:        = 0xa5
                 Normal mode:        = 0xd2
                 Close windows mode: = 0x69
       
       8~15 bit: CheckSum
                 = Mode ^ 
                   A_Code[0~7] ^ A_Code[8~15] ^ A_Code[16~23] ^ A_Code[24~31] ^
                   B_Code[0~7] ^ B_Code[8~15] ^ B_Code[16~23] ^ B_Code[24~31]
       
     e>A_Code(32 bits)  
             |<-31~28->|<--------- 27~0 ---------->|
             |_________|___________________________|
             | Key code|Serial number of remote key|
             |_________|___________________________|
       Key code:
       <a>normal mode:
             31 bit = x: reserved 
             30 bit = x: reserved 
             29 bit = 1: unlock command
                    = 0: no unlock command
             28 bit = 1: lock command       
                    = 0: no lock command
       <b>learn mode:
             key code 31~28 bits = "0000"

     f>B_Code
       <a>normal mode:
             |<-31~16->|<-15~12->|<-------- 11~0 -------->|
             |_________|_________|________________________|
             |Sync code|Key code |Serial number 27~16 bits|
             |_________|_________|________________________|
             B_Code[0](15~0 bits) = A_Code[1](31~16 bits)  
       <b>learn mode:
             |<-31~16->|<---15~0--->|
             |_________|____________|
             |Sync code|Random data | Random data used for generating Skey_B
             |_________|____________|
            
     g>Guard time
       25 ms 
       have noise or low
       
*****************************************************************************************
****************************************************************************************/

/*********************************************************************
 INCLUDE HEADER FILES
*********************************************************************/
#include "share.h"
#include "gpio_macro.h"
#include "rke_drv.h"
#include "window_drv.h"
#include "st79_it.h"
#include "lock_drv.h"
#include "turnlamp_drv.h"
#include "warm_drv.h"
#include "horn_drv.h"
#include "beam_drv.h"
#include "sys_Init.h"
#include "can.h"
#include "TIMER2_3.h"
//#include "Lin.h"

//#include "rke_key.h" 

#include "Decry.h"

unsigned int Buzz10sstate;

extern unsigned char Weeprom(unsigned long temp,unsigned char value);
//void DECRYPT(unsigned int* In, unsigned int* Out, unsigned int* S);
//extern W32eeprom(unsigned long tempp,unsigned long valuee);

extern void Decrypt(const unsigned int *SK,unsigned int *Header);

/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
//const unsigned int  f_SKey_B[13]  =  {0XA595,0X2D21,0XB972,0X5546,0XECBF,0X4A19,0X2B1E,0X82B1,0X5DA6,0X6583,0X7B6B,0XC541,0X41D2};  //production keys for key 1,52 byte

const unsigned int  f_SKey_B[13]  =  {0XA5D5,0X0921,0XB973,0X5546,0XECBF,0X4E1D,0X69DA,0XA2B1,0X5DA2,0X6583,0XFB6B,0XC545,0X4592};

//const unsigned int  f_SKey_B[13]  =  {0X5d5a,0X1290,0X379b,0X6455,0Xfbce,0Xd1e4,0Xad96,0X1b2a,0X2ad5,0X3856,0Xb6bf,0X545c,0X2954};

/*rke receive step state definition*/
uchar   RKE_STEP;
uchar   nPrecodeCnt;
/*rke receive buffer definition*/
uint    RKE_FIFO_DATA[6];
//uint   RKE_FEC_DATA[5];
/*rke receive frame definition*/
unsigned int    Header[2];
unsigned int    A_Code[2];
unsigned int    B_Code[2];

/*rke ram definition */
ulong   RX_SerialNum;    //receive serial number   
uint    RX_Sync_Code;
uint    LAST_RX_sync_Code;
uint    ROM_Sync_Code[KEY_COUNT];
//uint    SKey_B[t];       //temporary  production key
/*after rke unlock,if havn't door moving ,auto lock after 25s */
uchar   RKE_AutoLockFlag;
uint    RKE_AutoLockCnt;
uchar	RKE_COMMAND;
uchar   keyindex;
uint  B_Code_new;

/* time out for receiving rke close windows command */
//uchar	RkeCloseWinCnt;

//Immo led on time
ulong	ImmoOnTime;   
uchar	FindCarFlag;
//uchar  reknumbercnt;

uchar RKE_COMMAND_StandBy_state; //rke 按键状态
//uchar RKEBatteryVoltage_State;   //RKE电池电压报警状态
uchar RKEBatteryVoltageturnstate;

uchar RKEWarmCancle;  //RKE取消报警状态
//uchar RKELOCKstate;
uint   studyunlockcnt;
uchar  RKE_Resive_cnt;
uchar  RKE_outtime;
uchar DriverLOCK=0;
uchar RKESETBUZZ=0;
uchar RKEERRORSTATE=0;


uchar  RKE_CODE_OK;

// Remote key's serial number definition (default serial number)
ulong f_RKE_SerialNum[KEY_COUNT]	@0x4000;// = {0x01234567,0x02222222,0x03333333,0x04444444}; 
//f_RKE_SerialNum[KEY_COUNT] = {0x01234567,0x02222222,0x03333333,0x04444444};

// Remote key's sysn code definition (default sysn code) 
uint  f_RKE_SysnCode[KEY_COUNT]		@0x4020;

// SKey_B definition (default production keys)


uchar RKEVOlCNT[4]                  @0X4060;
uchar unlockdriverstate             @0X408a;

// Child key parameter definition 
uint	PW = 0xb7e1;		//0xb7e15163; 
uint	QW = 0x9e37;		//0x9e3779b9;


uchar LINWINDOWSTATE;
uchar RKE_DATA_OK;
uchar RKEstadynumber;
/*********************************************************************/
/*          初始化RKE序列号 全为0x00000000                           */
/*程序名称：void INITrkenumber(void)                                 */
/*输    入：无                                                       */
/*输    出：无                                                       */
/*调用要求：每次进入学习模式时调用一次                               */
/*作    者：rexlei                完成时间：2008.04.09               */
/*功能描述:                                                          */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void INITrkenumber(void)
{
    uchar numberxx,witecnt;
    u32  temp;
    uchar res;

    RX_SerialNum = 0x00000000;
    for(numberxx= 0; numberxx< 4; numberxx++ )
    {
        SAVE_SERIAL_NUMBER(numberxx);
	 WWDG_Refresh(0x7f);
    }


}



/*********************************************************************
Name    :   void SAVE_SYNC_CODE(void)
Function:   V101BCM function description
Input   :
  KEY_IN_STATE_IN
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void SAVE_SYNC_CODE(uchar keyindex)
{
	uchar res, witecnt;
	u32   temp;

	for( witecnt = 0; witecnt < EECNT ; witecnt++ )
	{
              temp = (u32)(&f_RKE_SysnCode)+keyindex*2;
              Clear_WDT();
              res = (RX_Sync_Code >> 8);
              FLASH_ProgramByte(temp, res);
              Clear_WDT();
              res = (RX_Sync_Code >> 8);
              FLASH_ProgramByte(temp, res);
              temp++;
              Clear_WDT();
              res = (u8)(RX_Sync_Code);
              FLASH_ProgramByte(temp, res);	
              Clear_WDT();
              if(RX_Sync_Code == f_RKE_SysnCode[keyindex])
              {
                  break;
              }
	}

}

/*********************************************************************/
/*           保存驾驶员单独开锁状态                                  */
/*程序名称：void WakeUp(void)                                        */
/*输    入：无                                                       */
/*输    出：无                                                       */
/*调用要求：进入睡眠模式前调用                                       */
/*作    者：                    完成时间：2008.01.11                 */
/*功能描述:                                                          */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void SAVEunlockdriverstate(uchar x)
{
  	uchar res, witecnt;
	u32   temp;

	for( witecnt = 0; witecnt < EECNT ; witecnt++ )
	{
             temp = (u32)(&unlockdriverstate);
             Clear_WDT();
             res = x;
             FLASH_ProgramByte(temp, res);
     
             if( x == unlockdriverstate )
             {
                 break;
             }
	}
}
/*********************************************************************
Name    :   void SAVE_SERIAL_AND_SKEYB(void)
Function:   V101BCM function description
Input   :
  KEY_IN_STATE_IN
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void SAVE_SERIAL_NUMBER(uchar keyindex)
{
	uchar res,i;
	u32   temp;
	
	//save rke's serial number into eeprom
       for( i = 0 ; i < EECNT ; i++ )
	{     
       	temp = (u32)(&f_RKE_SerialNum) + keyindex*4;
       	Clear_WDT();
       	res = (u8)(RX_SerialNum >> 24);
       	FLASH_ProgramByte(temp, res);
       	temp++;
       	Clear_WDT();
       	res = (u8)(RX_SerialNum >> 16);
       	FLASH_ProgramByte(temp, res);
       	temp++;
       	Clear_WDT();
       	res = (u8)(RX_SerialNum >> 8);
       	FLASH_ProgramByte(temp, res);
       	temp++;
       	Clear_WDT();
       	res = (u8)(RX_SerialNum);
       	FLASH_ProgramByte(temp, res);
       	temp++;
       	Clear_WDT();
   
       	if(RX_SerialNum == f_RKE_SerialNum[keyindex])
       	{
               break;
       	}
	}
}





/*********************************************************************
Name    :   void ENCRYPT(void)
Function:   V101BCM function description
Input   :
  KEY_IN_STATE_IN
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
/*
void ENCRYPT(unsigned int* In, unsigned int* Out, unsigned int* S)
{
	unsigned int X,Y;
	unsigned char i;

	X = In[0] + S[0];
	Y = In[1] + S[1];

	for (i=1;i<=r;i++)
	{
		X = ROTL((X^Y),Y) + S[2*i];
		Y = ROTL((Y^X),X) + S[2*i+1];
	}

	Out[0] = X;
	Out[1] = Y;
}
*/
/*********************************************************************
Name    :   void GenerateChildKey(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
/*void GenerateChildKey(void)
{
	signed char i;
    unsigned char u;
    unsigned int L[c];
    unsigned int X,Y;
    unsigned char A,B;
    unsigned char Key_B[8];
 
    Key_B[0] = B_Code[0];
    Key_B[1] = B_Code[0]>>8;
    Key_B[2] = B_Code[1];
    Key_B[3] = B_Code[1]>>8;
    Key_B[4] = A_Code[0];
    Key_B[5] = A_Code[0]>>8;
 	Key_B[6] = A_Code[1];
 	Key_B[7] = (A_Code[1]>>8) & 0x0f;
 
    /*init SKey_B */
		/*
    SKey_B[0] = PW;
    for ( i=1; i<t; i++)
    {
    	SKey_B[i] = (SKey_B[i-1] + QW);
    }

    //transform from K to L
    //initialization L
    for (i=0; i<c; i++) 
    {
    	L[i]=0;
    }
    		
    u = w/8;
    for (i = b-1; i != -1; i--)
    {
    	L[i/u] = (L[i/u] << 8) + Key_B[i]; 
    }
    
    //generate child keys 
    A = B = X = Y = 0;
    for (i = 0; i < 3*t; i++)
 	{
 		X = SKey_B[A] = ROTL(SKey_B[A] + X + Y, 3);  
 		A = (A + 1) % t;
 		Y = L[B] = ROTL(L[B] + X + Y, (X + Y)); 
 		B = (B + 1) % c;
 	} 


}
*/
/*********************************************************************/
/*           读取已学习RKE数量                                      */
/*程序名称：void RKEnumberRead(void)                                        */
/*输    入：无                                                       */
/*输    出：无                                                       */
/*调用要求：CAN                                                    */
/*作    者：rexlei             完成时间：2008.04.09                 */
/*功能描述:                                                          */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
uchar RKEnumberRead(void)
{
    uchar reknumbercnt=0;
	reknumbercnt = 0;

    if( f_RKE_SerialNum[0] != 0 ) { reknumbercnt++;   } 
	if( f_RKE_SerialNum[1] != 0 ) { reknumbercnt++;   } 
	if( f_RKE_SerialNum[2] != 0 ) { reknumbercnt++;   } 
    if( f_RKE_SerialNum[3] != 0 ) { reknumbercnt++;   } 

    return reknumbercnt;
}
	
/*********************************************************************
Name    :   void DECODE_PROC(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
	uint  itemp;
unsigned char DECODE_PROC(void)
{

    static uchar rxcnt;	
    static uint  RKE_CODE_Old;
	

    unsigned char i;
//
//    Rke_key_new(Header,A_Code,B_Code);
    Decrypt(f_SKey_B,Header);
// Decrypt(f_SKey_B,Header);
	//    Decrypt(Header,f_SKey_B);	

    //if((A_Code[1]&0xf000)!=(B_Code[0]&0xf000)) return; //new add 20100624

    //received remote key's serial number
	RX_SerialNum =((ulong)(A_Code[1] & 0x0fff) << 16) + A_Code[0];
    //judge received remote key's serial number equ serial number of bcm?
	if      (f_RKE_SerialNum[0] == RX_SerialNum) {keyindex = 0; RKE_COMMAND_StandBy_state = 0x11;}
	else if (f_RKE_SerialNum[1] == RX_SerialNum) {keyindex = 1; RKE_COMMAND_StandBy_state = 0x11;}
	else if (f_RKE_SerialNum[2] == RX_SerialNum) {keyindex = 2; RKE_COMMAND_StandBy_state = 0x11;}
	else if (f_RKE_SerialNum[3] == RX_SerialNum) {keyindex = 3; RKE_COMMAND_StandBy_state = 0x11;}
	else if (EnalbeLearnRkeTime20s == 0) //有改动
	{
	    RKE_COMMAND_StandBy_state = 0x55;
		return Fail;	// this remote key isn't learn!!!
	}
	else
	{
        RKE_COMMAND_StandBy_state = 0x55;   
	}

	    RkeStudy(); //进入学习状态
	    
	

		//calculate sync counter window
		RX_Sync_Code = B_Code[1];
		itemp = RX_Sync_Code - f_RKE_SysnCode[keyindex];
		

        B_Code_new = B_Code[0] & 0xf000;


		 //return CommandOk;	
		//judge sync counter window
		if (itemp == 0) 	
		{
		    //RKEERRORSTATE = 0x55;
			if(RKE_CODE_OK == 0x55)return CommandOk;	    // check sync_code invalid
			else return Fail;
			
			SAVE_SYNC_CODE(keyindex);

 		}
		else if(itemp > SYNC_CNT_WIN_DOUBLE)
		{
                    return Fail;

		}
		else if (itemp < SYNC_CNT_WIN_SINGLE)	
		{
			SAVE_SYNC_CODE(keyindex);
			RKE_CODE_OK = 0X55;
			RKEERRORSTATE = 0; //add two key 20100731

			return CommandOk;  	// single time valid
			
		}
		else if ((RX_Sync_Code - LAST_RX_sync_Code) < 20)		
		{
			SAVE_SYNC_CODE(keyindex);
			RKE_CODE_OK = 0X55;
			RKEERRORSTATE = 0;//add two key 20100731

			return Fail;	// double time valid
		}
		else if(itemp <= 4096)
		{   
		    //if sync counter is out of window,then save this sync counter
		    //and sure double time pressed key valid
			LAST_RX_sync_Code = RX_Sync_Code;

			return Fail;	    // sync_code invalid
		}
		else return Fail;
    	//end of normal mode------------------------------------------	
	
}

/*********************************************************************
Name    :   void ScanRkeKeys(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ScanRkeKeys(void)
{
	uchar   temp;
	static uint  FindCarTime;
	static uchar RkeLockCnt;  
	
	static uchar RKEwarmstate;

	static uchar rke_UnlockTrunkcnt,rke_openwincnt,rke_closewincnt,rke_UnlockDriver_setcnt;


     if(IGNstate == ON) RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;   // new0917
    //atic uint  B_Code_new;
    if(RKE_outtime != 0)
    {
        RKE_outtime--;
		if((RKE_outtime == 0)&&(rke_closewincnt > 10)&&(B_Code_new == LockKey))
		{
			RKE_Resive_cnt  = 0;
			rke_UnlockTrunkcnt = 0;
			RKE_CODE_OK = 0;
			rke_openwincnt=0;
			rke_closewincnt= 0;
			rke_UnlockDriver_setcnt=0;
		}
		else if(RKE_outtime == 0)
		{
		    RKE_CODE_OK = 0;
			rke_UnlockTrunkcnt = 0;
			rke_openwincnt=0;
			rke_closewincnt = 0;
			rke_UnlockDriver_setcnt= 0;
			RKE_Resive_cnt = 0;
		}
	}

    if(RKE_DATA_OK == 0x55)
    {
     	 RKE_DATA_OK = 0x00;
	 	 temp = DECODE_PROC();
	 
       
    	if (temp == CommandOk)
    	{
				gNetWorkStatus.bussleep = 0;
				gLocalWakeupFlag = 1;
    	      RKEBatteryVoltage();           //电池电压检测
    	 /*     if((WarningTimeCnt < 37500)&&(WarningTimeCnt !=0))
    	      {
                     Warningstate = 0 ;
                     TrunkWarmTime = 0 ;
                     Alarmstatus_RKE = 4; 
					 RKEERRORSTATE = 0x55;//add two key 20100731
                     return;
    	      }*/
			  
         if ((B_Code_new == LockKey)||(B_Code_new == RKEfindcar))       
  		 {
		 
	              if(rke_closewincnt < 20) rke_closewincnt++;		
			if(rke_closewincnt == 1)
			{
			        if(IGNstate == ON) return;
                             if(KeyInState == KeyIsInHole) return;
				//寻车命令不成功执行闭锁功能//20120309
				if ((DoorState ==0) && (KeyInState == KeyIsOutHole)&&(LockState == Locked)&&(B_Code_new == RKEfindcar))//add lockstate 20120308
				{
					if(FindCarFlag != TRUE){FindCarFlag = TRUE;RkeLockCnt=0;}
					return;
				}
				 
				 DriverLOCK = 0;
				 RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;
				//finding car function,"lock switch" of remote key 
	    			if (RkeLockCnt != 0)
	    			{
	    				RkeLockCnt++;				
	    			}
	    			else
	    			{
	    				RkeLockCnt = 1;
	    				FindCarTime = 250;//set 8ms*250=2s
	    			}					
	                     RKELOCKstate = 0xaa;
					
			       TurnFlashCnt = 2;	//\__lock:turn lamps flash 2 time 
	                     Alarmstatus_RKE = 1;    //置RKE闭锁标志
                            if(FindCarFlag = TRUE) //20120308
				{
				         FindCarFlag = FALSE;
					  if(turnfindcarstate == 1)TurnFlashCnt = 3;
				}
	                
	        		if (( IGNstate == OFF ) && (DoorState & AllDoorIsOpen))//AllDoorIsOpen  0x1b  取消后备箱状态//20120310
	        		{

						if(KeyInState == KeyIsOutHole)
						{
						      HornDoorunclosetime = 6;
						      BuzzerDrv(1,376,375,Buzzlockdoorunclose);
						      TurnFlashCnt = 0;
						      dooropenlock = 50;
						}
						//Buzz10sstate = 1250;

	        	    }   

	                if(( IGNstate == ON )||(wLockProtectTimeCnt !=0)) //20100719
	                {
	                      TurnFlashCnt = 0;
			        BUZZLocktimecnt = 0;	  
	                }
	                RKE_COMMAND = RKECMD_LOCK;

	                LockDrvCmd = LockCmd;

			}

               }
		else if (B_Code_new == UnlockDriverDoorKey )// || (B_Code_new ==  UnlockOtherDoorKey))
		{
             		  if(rke_openwincnt < 20) rke_openwincnt++;
			  if(rke_openwincnt == 1)
			  {
				if(IGNstate == ON) return;
				if(KeyInState == KeyIsInHole) return;

				//FindCarFlag = FALSE;

				RKE_COMMAND = RKECMD_UNLOCK;
				RKELOCKstate  =0x55 ;
				Alarmstatus_RKE = 2;    //置RKE开锁标志
				HornDoorunclosetime = 0;    //new add
				//BuzzerDrv(1,376,375,Buzzlockdoorunclose);
				ClearBuzzdrv(Buzzlockdoorunclose);
				RkeLockCnt = 0;    //20100317
				FindCarTime =0;
       
				LockDrvCmd |= UnlockDriverDoorCmd;
                            /*  20120330 取消二次闭锁
				if(DoorState == AllDoorIsClosed)//lockstate
				{
					if(KeyInState!= KeyIsInHole)RKE_AutoLockFlag = RKE_AUTO_LOCK_YES;///20100319
					RKE_AutoLockCnt = 0;		
				}
				else
				{
					RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;
				}*/
					  /////////////////////////////////////////20100731
				if(RKEERRORSTATE != 0x55)//add two key 20100731
				{
					if (CarState == CarIsAttack)	
					{    

						CarState = CarIsOkay;
						TurnFlashCnt = 4;	//unlock:if car is attacked,flash 4 times
						//BUZZLocktimecnt = 315 ;
						BuzzerDrv(4,250,125,BuzzlockoutArim); 
						Warningstate = 0 ;
						TrunkWarmTime = 0 ;
						Alarmstatus_RKE = 4; 
						BCMtoGEM_AlarmStatus = Disarmed; //20090917

					}	
					else
					{
					 	TurnFlashCnt = 1;	//\__unlock:turn lamps flash 1 times
						if(FindCarFlag = TRUE)  //20120308
						{
							FindCarFlag = FALSE;
							if(turnfindcarstate == 1)TurnFlashCnt = 2;
						}
						if(( IGNstate == ON )||(wLockProtectTimeCnt !=0))  //20100719
						{
							TurnFlashCnt = 0;
						}       
					}
				}
				else
				{ 
					LockDrvCmd = 0;
				}
				///////////////////////////////////////////////
			}


		}

		else if (B_Code_new ==UnlockTrunkKey)
		{
				//no flash turn lamps and no warming by buzzer
				if(rke_UnlockTrunkcnt < 5)rke_UnlockTrunkcnt++;
				if(rke_UnlockTrunkcnt == 3)
				{
				     if(IGNstate == OFF) return;
				    rke_UnlockTrunkcnt++;
					//FindCarFlag = FALSE;
					LockDrvCmd = UnlockTrunkCmd;
					TRUNK_UNLOCK_RKEstate = 1;
				}
				
		}
 		else if(B_Code_new == RKEfindcar)
 		{
			if ((DoorState == AllDoorIsClosed) && (KeyInState == KeyIsOutHole)&&(LockState == Locked))//add lockstate 20120308
			{
				//if(FindCarFlag != TRUE){FindCarFlag = TRUE;RkeLockCnt=0;}
			}

		}
			
          else if(B_Code_new == UnlockDriver_set_CMD) //暂时取消调试
          {
              if(rke_UnlockDriver_setcnt < 15)	rke_UnlockDriver_setcnt++;
    		  if(rke_UnlockDriver_setcnt == 15 )
    		  {
    		         rke_UnlockDriver_setcnt++;
                     //Buzzertime = 125;
					 //	RKESETBUZZ = 125;
                     if(unlockdriverstate == 0)unlockdriverstate = 1;//SAVEunlockdriverstate(1);     
    				 else unlockdriverstate = 0;//SAVEunlockdriverstate(0);
    				 BuzzerDrv(1,126,125,BuzzDrvunlockset); 
    		  }
          }

       }

    	//if ign=on,then don't flash turn lamps
        if ((IGNstate == ON)||(wLockProtectTimeCnt !=0)) //20100719
        {
            TurnFlashCnt = 0;
        }

    }
        /*
	//finding car function 
	if (DoorState == AllDoorIsClosed) //&& (KeyInState == KeyIsOutHole))
	{
	    	if (FindCarTime != 0)
	    	{
	    		FindCarTime--;
	    		if (RkeLockCnt == 2)
	    		{
	    			  //    FindCarFlag = TRUE;
				  //    BuzzerOnCnt = 2;
	        		RkeLockCnt = 0;
	        		FindCarTime = 0;
	    		}
	    	}
	    	else
	    	{
	    		RkeLockCnt = 0;
	    	}
	}
	else
	{
		RkeLockCnt = 0;
		FindCarTime = 0;
		if(FindCarFlag = TRUE)  //20120308
		{
			FindCarFlag = FALSE;
			if(turnfindcarstate == 1)TurnFlashCnt = 1;
			else TurnFlashCnt = 0;
		}
	}
	if(IGNstate==ON)
	{
		if(FindCarFlag = TRUE)  //20120308
		{
			FindCarFlag = FALSE;
			//if(turnfindcarstate == 1)TurnFlashCnt = 1;
			TurnFlashCnt = 0;
		}
	}//FindCarFlag = FALSE;  //add 20120308
	*/
    //after rke unlock,if havn't door moving,then bcm auto lock
    if (RKE_AutoLockFlag == RKE_AUTO_LOCK_YES)
    {
    	if (++RKE_AutoLockCnt > RKE_AUTO_LOCK_CNT)
    	{
              RKE_AutoLockCnt = 0;
              
              RKE_COMMAND = RKECMD_LOCK;
              
              if((IGNstate == OFF)&&(wLockProtectTimeCnt ==0))TurnFlashCnt = 2;	//\__lock:turn lamps flash 2 time 
              RKELOCKstate = 0xaa;
              LockDrvCmd = LockCmd;
              if(KeyInState ==  KeyIsOutHole )Alarmstatus_RKE = 3; //自动重锁状态
              RKE_AutoLockFlag = RKE_AUTO_LOCK_NO;
    	}
    }
    else
    {
    	    RKE_AutoLockCnt = 0;
    }
}

/*********************************************************************
Name    :   void RKE_RECEIVE_RESET(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void RKE_RECEIVE_RESET(void) 
{
    uchar i;
    
	//clear rke receive buffer
	Header[0] = 0x00;
	Header[1] = 0x00;
	A_Code[0] = A_Code[1] = 0x00;
	B_Code[0] = B_Code[1] = 0x00;

	RKE_FIFO_DATA[0] = 0x00;
	RKE_FIFO_DATA[1] = 0x00;
	RKE_FIFO_DATA[2] = 0x00;
	RKE_FIFO_DATA[3] = 0x00;
	RKE_FIFO_DATA[4] = 0x00;
	RKE_FIFO_DATA[5] = 0x00;
    //reset rke receive setting
    TIM3_OVFINT_DISABLE;
    TIM3_OCINT_DISABLE;
    RISE_EDGE_INT;
	ENABLE_RX_INT;

	RKE_STEP = RKE_Idle;
}

/*********************************************************************
Name    :   void RKE_RECEIVE_STOP(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void RKE_RECEIVE_STOP(void)
{
    uchar i;
    
	//clear rke receive buffer
	Header[0] = 0x00;
	Header[1] = 0x00;
	A_Code[0] = A_Code[1] = 0x00;
	B_Code[0] = B_Code[1] = 0x00;

	RKE_FIFO_DATA[0] = 0x00;
	RKE_FIFO_DATA[1] = 0x00;
	RKE_FIFO_DATA[2] = 0x00;
	RKE_FIFO_DATA[3] = 0x00;
	RKE_FIFO_DATA[4] = 0x00;

    //reset rke receive setting
    TIM3_OCINT_DISABLE;
    TIM3_OVFINT_DISABLE;
    RISE_EDGE_INT;
    DISABLE_RX_INT;

	RKE_STEP = RKE_Idle;
}

/*********************************************************************
Name    :   void Check_RKE_Receive_Timeout(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void Check_RKE_Receive_Timeout(void)
{
    static uchar RKETimeOutCnt;
    
    //RKE receive time out--> reset
    if (RKE_STEP == RKE_Idle)
    {
    	RKETimeOutCnt = 0;
    }
    else
    {
		if ((++RKETimeOutCnt > RKE_RECEIVE_TIME_OUT) && ((RKE_STEP != RKE_RecFinished)))
		{
			RKE_RECEIVE_RESET();
		}
    }

   
    
}


/*********************************************************************/
/*            RKE学习流程控制                                        */
/*程序名称：void RkeStudy(void)                                      */
/*输    入：无                                                       */
/*输    出：无                                                       */
/*调用要求：                                                         */
/*作    者：rexlei              完成时间：2008.02.21                 */
/*功能描述: RKE学习                                                  */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void RkeStudy(void)
{
    unsigned char eepromcnt;
    
    if (EnalbeLearnRkeTime20s != 0)
	{
        if(EnalbeLearnRkeTime20s > 1240) keyindex = 0;
		//learn remote key okay:turn lamps flash 5 time 
		RKE_COMMAND = RKECMD_LEARN;
		//已经学习过的钥匙仅学习同步码
		
       	if(RKE_COMMAND_StandBy_state == 0x11)
       	{
          		
          		RX_Sync_Code = B_Code[1];	
       
          		SAVE_SYNC_CODE(keyindex);		//read sync code and save it into flash 
       
          		 //BuzzerOnCnt = 1;
				 BuzzerDrv(1,125,62,buzzlearnkey); 
         	     //TurnFlashCnt = 5;	
          		//return Fail;	// check error
       	}
		else
		{
				if( f_RKE_SerialNum[0] == 0x00000000 )
				{
				 keyindex = 0;
				}
				else if(  f_RKE_SerialNum[1] == 0x00000000 )
				{
				 keyindex = 1;
				}
				//else if(  f_RKE_SerialNum[2] == 0x00000000 )
				//{
				// keyindex = 2;
				//}
				//else if(  f_RKE_SerialNum[3] == 0x00000000 )
				//{
				// keyindex = 3;
				////}
				//else
				//{
				  //keyindex 
				 //无空地址保存序列号需要察除
				//}

				//keyindex = 0;
				
				SAVE_SERIAL_NUMBER(keyindex);
				//keyindex = 1;
				//SAVE_SERIAL_NUMBER(keyindex);
				//W32eeprom(0x4000,RX_SerialNum);

				RKEstadynumber++;
				RX_Sync_Code = B_Code[1];		
				SAVE_SYNC_CODE(keyindex);		//read sync code and save it into flash

				keyindex++;
				//BuzzerOnCnt = 1;
				BuzzerDrv(1,125,62,buzzlearnkey); 
				//TurnFlashCnt = 5;	
            
		}
	}
    else
  {
       return;
    }
}
/*********************************************************************/
/*            RKE电池电压检测                                       */
/*程序名称：void RKEBatteryVoltage(void)                             */
/*输    入：无                                                       */
/*输    出：无                                                       */
/*调用要求：                                                         */
/*作    者：rexlei              完成时间：2008.02.21                 */
/*功能描述: RKE电池电压检测                                          */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void RKEBatteryVoltage(void)
{
    uchar BatterVolcnt;

    if(KeyInState == KeyIsInHole) return;
	
    if((Header[0]& 0x0003)== 0x0003)
    {

       //B_Code_new &=  0x7000 ;
       BatterVolcnt = RKEVOlCNT[keyindex]+1;
       if(BatterVolcnt >= 3)
       {
           //置电池电压不足驱动报警状态     
		   BuzzerDrv(9,125,62,buzzvcclow); 
           RKEBatteryVoltageturnstate = 1;
           BatterVolcnt = 3;
       }
     }
     else
     {
           BatterVolcnt = 0;
           RKEBatteryVoltageturnstate  = 0;
     }
     SAVE_BatterVol_CODE(keyindex,BatterVolcnt);   // 保存电池电压信息      

    
}
/*********************************************************************/
/*            保存RKE电池电压状态信息                                */
/*程序名称：void SAVE_BatterVol_CODE(uchar keyindex,uchar data)      */
/*输    入：无                                                       */
/*输    出：无                                                       */
/*调用要求：                                                         */
/*作    者：rexlei              完成时间：2008.02.21                 */
/*功能描述: RKE电池电压状态信息保存                                  */
/*程序修改记录                                                       */
/*修改日期      作者         修改内容                   备注         */
/*********************************************************************/
void SAVE_BatterVol_CODE(uchar keyindex,uchar data)
{
	uchar res;
	u32 temp;
	
	temp = (u32)(&RKEVOlCNT) + keyindex*1;
	//FLASH_Status_Typedef FLASH_ProgramByte(u32 Address, u8 Data)
	Clear_WDT();
	res = (u8)(data);
	FLASH_ProgramByte(temp++, res);	
	Clear_WDT();
}





/*********************************************************************
 end of the warm_drv.c file
*********************************************************************/


