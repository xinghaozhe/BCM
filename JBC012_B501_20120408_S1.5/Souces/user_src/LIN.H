/*******************************************************************************
| File Name    : st79_LIN.h
| Description  : This file contains all the functions prototypes for the LIN.c.
| Group        : APG/Car Body Division/Microcontroller & Car Networking
|===============================================================================
|                C O P Y R I G H T
|===============================================================================
| (C) COPYRIGHT 2007 STMicroelectronics
| THE SOFTWARE INCLUDED IN THIS FILE IS FOR GUIDANCE ONLY. ST MICROELECTRONICS
| SHALL NOT BE HELD LIABLE FOR ANY DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES
| WITH RESPECT TO ANY CLAIMS ARISING FROM USE OF THIS SOFTWARE.
|===============================================================================
|                A U T H O R    I D E N T I T Y
|===============================================================================
| Initials   Name                          Company
| --------   ----------------------------  -------------------------------------
| CA         Claude ANGUILLE               STMicroelectronics
|===============================================================================
|                R E V I S I O N    H I S T O R Y
|===============================================================================
| Date         Ver   Author  Description
| -----------  ----  ------  ---------------------------------------------------
| 10-Mar-2008  0.1  ZJJ     Created.
*******************************************************************************/

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __ST79_LIN_H
#define __ST79_LIN_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_type.h"
#include "stm8_linuart.h"
#include "can.h"

/* Exported types ------------------------------------------------------------*/
/* user transmmit structure */

/*********************************************************************
BCM LIN Frame1 Definition
/********************************************************************/
//extern uchar  LINsendLen;


struct BCM_LIN_FRAME1
{
  union  {     
          uchar  allbits;
          struct {
                  unsigned BCM_WindowEnable:1;
                  unsigned BCM_VehicleModel:3;
                  unsigned BYTE_reserve:4;
                 }bit;  
        }BYTE0;                    
  
  /*  
  BCM_WindowEnable车窗使能信号
  0：允许车窗工作
  1：禁止车窗工作

  BCM_VehicleModel车型
  0：CV8
  1：V101  
  */
  
  union  {     
          uchar  allbits;  
          struct{
                  unsigned BYTE_reserve:8;
                }bit;
        }BYTE1;
  /*
  reserve
  */
  
  union  {     
          uchar  allbits;  
          struct{
                  unsigned BYTE_reserve:8;
                }bit;
        }BYTE2;  
  /*
  reserve
  */     
  
	union {     
          uchar  allbits;
          struct{
                  unsigned BCM_GlobleClose:1;
                  unsigned BCM_IGN:1;
                  unsigned BCM_GlobleOpen:1;
                  unsigned BYTE_reserve:5;
                }bit;
        }BYTE3;
	
}

;
/*********************************************************************
BCM LIN Frame2 Definition
/********************************************************************/
struct BCM_LIN_FRAME2
{
  union  {     
          uchar  allbits;
          struct {
                  unsigned BCM_WiperSwitchPosition:3;
                  unsigned BYTE_reserve:5;
                 }bit;  
        }BYTE0;                    
  
  /*雨刮开关位置
    0(000)：OFF档
    1(001)：自动档
    2(010)：低速刮水
    3(011)：高速刮水
    4(100)：喷水洗涤
    5(101)：喷水自动刮刷档           
  */
  
  union  {     
          uchar  allbits;  
          struct{
                  unsigned BCM_SensitivitySetting:4;
                  unsigned BYTE_reserve:4;
                }bit;
        }BYTE1;
  /*自动雨刮间歇灵敏度设置
    0(0000)：1级灵敏度
    1(0000)：2级灵敏度
    2(0000)：3级灵敏度
    3(0000)：4级灵敏度
    4(0000)：5级灵敏度
    5-14(0101-1110)：保留 
    15(1111):BCM故障
  */
  
  union  {     
          uchar  allbits;
          struct{
                  unsigned BCM_AmbientTemperature:8;
                }bit;
        }BYTE2;  
  /*
    缺省值0XFF:默认温度10℃
  */     
  
	union {     
          uchar  allbits;
          struct{
                 unsigned BYTE_reserve:8;
                }bit;
        }BYTE3;
  /*
    reserve
  */     	
};



/*********************************************************************
DDCM LIN Frame Definition
/********************************************************************/
struct DDCU_LIN_FRAME
{
  union  {     
          uchar  allbits;
          struct {
                  unsigned DDCU_WinStatus:3;
                  unsigned BYTE_reserve:5;
                 }bit;  
        }BYTE0;                    
  
  /*
    DDCU_WinStatus 车窗状态
    0：closed，关闭
    1：open，开启
    2：closing，关闭中
    3：openning，开启中
    4：trapped，有防夹
    5:继电器故障
    6：霍尔传感器故障
  */
  union  {     
          uchar  allbits;
          struct{
                  unsigned DDCU_VehicleModel:3;
                  unsigned DDCU_ProductID:5;
                }bit;
        }BYTE1;  
  /*DDCU_VehicleModel 车型
    0：CV8
    1：V101              
    3-7：保留

    DDCU_ProductID
    
  */     

};



/*********************************************************************
PDCM LIN Frame Definition
/********************************************************************/
struct PDCU_LIN_FRAME
{
    union  {     
          uchar  allbits;
          struct {
                  unsigned PDCU_WinStatus:3;
                  unsigned BYTE_reserve:5;
                 }bit;  
        }BYTE0;                    
  
  /*
    PDCU_WinStatus 车窗状态
    0：closed，关闭
    1：open，开启
    2：closing，关闭中
    3：openning，开启中
    4：trapped，有防夹
    5:继电器故障
    6：霍尔传感器故障
  */
  union  {     
          uchar  allbits;
          struct{
                  unsigned PDCU_VehicleModel:3;
                  unsigned PDCU_ProductID:5;
                }bit;
        }BYTE1;  
  /*PDCU_VehicleModel 车型
    0：CV8
    1：V101              
    3-7：保留

    PDCU_ProductID
  */     


};



/*********************************************************************
RLDCU LIN Frame Definition
/********************************************************************/
struct RLDCU_LIN_FRAME
{
    union  {     
          uchar  allbits;
          struct {
                  unsigned RLDCU_WinStatus:3;
                  unsigned BYTE_reserve:5;
                 }bit;  
        }BYTE0;                    
  
  /*
    RLDCU_WinStatus 车窗状态
    0：closed，关闭
    1：open，开启
    2：closing，关闭中
    3：openning，开启中
    4：trapped，有防夹
    5:继电器故障
    6：霍尔传感器故障
  */
  union  {     
          uchar  allbits;
          struct{
                  unsigned RLDCU_VehicleModel:3;
                  unsigned RLDCU_ProductID:5;
                }bit;
        }BYTE1;  
  /*RLDCU_VehicleModel 车型
    0：CV8
    1：V101              
    3-7：保留

    RLDCU_ProductID
  
  */     


};



/*********************************************************************
RRDCU LIN Frame Definition
/********************************************************************/
struct RRDCU_LIN_FRAME
{
    union  {     
          uchar  allbits;
          struct {
                  unsigned RRDCU_WinStatus:3;
                  unsigned BYTE_reserve:5;
                 }bit;  
        }BYTE0;                    
  
  /*
    RRDCU_WinStatus 车窗状态
    0：closed，关闭
    1：open，开启
    2：closing，关闭中
    3：openning，开启中
    4：trapped，有防夹
    5: 继电器故障
    6：霍尔传感器故障
  */
  union  {     
          uchar  allbits;
          struct{
                  unsigned RRDCU_VehicleModel:3;
                  unsigned RRDCU_ProductID:5;
                }bit;
        }BYTE1;  
  /*RRDCU_VehicleModel 车型
    0：CV8
    1：V101              
    3-7：保留

    RRDCU_ProductID
  
  */     


};

/*********************************************************************
RRDCU LIN Frame Definition
/********************************************************************/
struct RAINS_LIN_FRAME
{
    union  {     
          uchar  allbits;
          struct {
                  unsigned RAINS_WiperRequest:3;
                  unsigned BYTE_reserve:5;
                 }bit;  
        }BYTE0;                    
  
  /*
  RAINS_WiperRequest 雨刮刮刷信号
  0:不刮刷
  1：刮刷一次
  2：低速刮刷
  3：高速刮刷
  4-6:保留
  7：雨量传感器故障
  */
  union  {     
          uchar  allbits;
          struct{
                  unsigned BYTE_reserve:8;
                }bit;
        }BYTE1;  
  /*
  ALL reserve
  */     


};
/***********************************************************
  BCM LIN FRAME1 MACRO Definition [BYTE0]
***********************************************************/
#define LIN1_BCM_WindowEnable    LIN_BCM_FRAME1.BYTE0.bit.BCM_WindowEnable
#define LIN1_BCM_VehicleModel   LIN_BCM_FRAME1.BYTE0.bit.BCM_VehicleModel

    /*
      BCM_WindowEnable definition
    */
    #define WindowEnable                     0
    #define Windowdisable                    1

    /*
      VehicleModel definition
    */
    #define VehicleModel_CV8                 0
    #define VehicleModel_CV101               1


/***********************************************************
  BCM LIN FRAME1 MACRO Definition [BYTE3]
***********************************************************/
#define LIN1_BCM_GlobleClose    LIN_BCM_FRAME1.BYTE3.bit.BCM_GlobleClose
#define LIN1_BCM_IGN            LIN_BCM_FRAME1.BYTE3.bit.BCM_IGN
//#define LIN1_BCM_GlobleOpen     LIN_BCM_FRAME1.BYTE3.bit.BCM_GlobleOpen 

  /*
      LIN1_BCM_GlobleClose definition
 */
 //   #define RF_Window_close_on          1
 //   #define RF_Window_close_off         0

  /*
      LIN1_BCM_IGN definition
 */
    
    #define BCM_IGN_ON                  1
    #define BCM_IGN_OFF                 0

 /*
 //     LIN1_BCM_GlobleOpen definition
 */
    
 //   #define RF_Window_Open_on           1
    #define RF_Window_Open_off          0

		
/***********************************************************
  BCM_LIN1_FRAME BYTE0~8 definition
***********************************************************/
#define LIN1_BCM_BYTE0       LIN_BCM_FRAME1.BYTE0.allbits
#define LIN1_BCM_BYTE1       LIN_BCM_FRAME1.BYTE1.allbits
#define LIN1_BCM_BYTE2       LIN_BCM_FRAME1.BYTE2.allbits
#define LIN1_BCM_BYTE3       LIN_BCM_FRAME1.BYTE3.allbits


/***********************************************************
  BCM LIN FRAME2 MACRO Definition [BYTE0]
***********************************************************/
#define LIN2_BCM_WiperSwitchPosition   LIN_BCM_FRAME2.BYTE0.bit.BCM_WiperSwitchPosition

    /*
      WiperSwitchPosition definition
    */
    #define WiperSwitchPosition_OFF                     0
    #define WiperSwitchPosition_AOTO                    1
    #define WiperSwitchPosition_SLOW                    2
    #define WiperSwitchPosition_FAST                    3
    #define WiperSwitchPosition_GUSH                    4
    #define WiperSwitchPosition_AOTOGUSH                5


/***********************************************************
  BCM LIN FRAME1 MACRO Definition [BYTE1]
***********************************************************/
#define LIN2_BCM_SensitivitySetting    LIN_BCM_FRAME2.BYTE1.bit.BCM_SensitivitySetting

 /*
      LIN1_BCM_GlobleClose definition
*/
    #define BCM_SensitivitySetting_1D           0
    #define BCM_SensitivitySetting_2D           1
    #define BCM_SensitivitySetting_3D           2
    #define BCM_SensitivitySetting_4D           3
    #define BCM_SensitivitySetting_5D           4
    #define BCM_Fault                           15


    /***********************************************************
  BCM LIN FRAME1 MACRO Definition [BYTE2]
***********************************************************/
#define LIN2_BCM_AmbientTemperature   LIN_BCM_FRAME2.BYTE2.bit.BCM_AmbientTemperature

 /*
      LIN2_BCM_AmbientTemperature definition
*/
    #define BCM_AmbientTemperature_Default      0xff
		
/***********************************************************
  BCM_LIN1_FRAME BYTE0~8 definition
***********************************************************/
#define LIN2_BCM_BYTE0       LIN_BCM_FRAME2.BYTE0.allbits
#define LIN2_BCM_BYTE1       LIN_BCM_FRAME2.BYTE1.allbits
#define LIN2_BCM_BYTE2       LIN_BCM_FRAME2.BYTE2.allbits
#define LIN2_BCM_BYTE3       LIN_BCM_FRAME2.BYTE3.allbits


/***********************************************************
  DDCU LIN FRAME MACRO Definition [BYTE0]
***********************************************************/
#define LIN_DDCU_WinStatus       LIN_DDCU_FRAME.BYTE0.bit.DDCU_WinStatus

    /*
      LIN_DDCU_WinState definition
    */ 
    #define DDCU_WinStatus_close           0
    #define DDCU_WinStatus_open            1
    #define DDCU_WinStatus_closing         2
    #define DDCU_WinStatus_opening         3
    #define DDCU_WinStatus_trapped         4
    #define DDCU_WinStatus_Ralayfault      5
    #define DDCU_WinStatus_hollfault       6

/***********************************************************
  DDCU LIN FRAME MACRO Definition [BYTE1]
***********************************************************/
#define LIN_DDCU_VehicleModel       LIN_DDCU_FRAME.BYTE0.bit.DDCU_VehicleModel

    /*
      LIN_DDCU_WinState definition
    */ 
    #define DDCU_VehicleModel_CV8             0
    #define DDCU_VehicleModel_V101            1
    

/***********************************************************
***********************************************************/
#define LIN_DDCU_BYTE0       LIN_DDCU_FRAME.BYTE0.allbits
#define LIN_DDCU_BYTE1       LIN_DDCU_FRAME.BYTE1.allbits


/***********************************************************
  PDCU LIN FRAME MACRO Definition [BYTE0]
***********************************************************/
#define LIN_PDCU_WinStatus       LIN_PDCU_FRAME.BYTE0.bit.PDCU_WinStatus

    /*
      LIN_DDCU_WinState definition
    */ 
    #define PDCU_WinStatus_close           0
    #define PDCU_WinStatus_open            1
    #define PDCU_WinStatus_closing         2
    #define PDCU_WinStatus_opening         3
    #define PDCU_WinStatus_trapped         4
    #define PDCU_WinStatus_Ralayfault      5
    #define PDCU_WinStatus_hollfault       6

/***********************************************************
  DDCU LIN FRAME MACRO Definition [BYTE1]
***********************************************************/
#define LIN_PDCU_VehicleModel       LIN_PDCU_FRAME.BYTE0.bit.PDCU_VehicleModel

    /*
      LIN_DDCU_WinState definition
    */ 
    #define PDCU_VehicleModel_CV8             0
    #define PDCU_VehicleModel_V101            1
    

/***********************************************************
***********************************************************/
#define LIN_PDCU_BYTE0       LIN_PDCU_FRAME.BYTE0.allbits
#define LIN_PDCU_BYTE1       LIN_PDCU_FRAME.BYTE1.allbits



/***********************************************************
  RLDCU LIN FRAME MACRO Definition [BYTE0]
***********************************************************/
#define LIN_RLDCU_WinStatus       LIN_DDCU_FRAME.BYTE0.bit.RLDCU_WinStatus

    /*
      LIN_DDCU_WinState definition
    */ 
    #define RLDCU_WinStatus_close           0
    #define RLDCU_WinStatus_open            1
    #define RLDCU_WinStatus_closing         2
    #define RLDCU_WinStatus_opening         3
    #define RLDCU_WinStatus_trapped         4
    #define RLDCU_WinStatus_Ralayfault      5
    #define RLDCU_WinStatus_hollfault       6

/***********************************************************
  DDCU LIN FRAME MACRO Definition [BYTE1]
***********************************************************/
#define LIN_RLDCU_VehicleModel       LIN_RLDCU_FRAME.BYTE0.bit.RLDCU_VehicleModel

    /*
      LIN_DDCU_WinState definition
    */ 
    #define RLDCU_VehicleModel_CV8             0
    #define RLDCU_VehicleModel_V101            1
    

/***********************************************************
***********************************************************/
#define LIN_RLDCU_BYTE0       LIN_RLDCU_FRAME.BYTE0.allbits
#define LIN_RLDCU_BYTE1       LIN_RLDCU_FRAME.BYTE1.allbits



/***********************************************************
  RRDCU LIN FRAME MACRO Definition [BYTE0]
***********************************************************/
#define LIN_RRDCU_WinStatus       LIN_RRDCU_FRAME.BYTE0.bit.RRDCU_WinStatus

    /*
      LIN_RRDCU_WinState definition
    */ 
    #define RRDCU_WinStatus_close           0
    #define RRDCU_WinStatus_open            1
    #define RRDCU_WinStatus_closing         2
    #define RRDCU_WinStatus_opening         3
    #define RRDCU_WinStatus_trapped         4
    #define RRDCU_WinStatus_Ralayfault      5
    #define RRDCU_WinStatus_hollfault       6

/***********************************************************
  RRDCU LIN FRAME MACRO Definition [BYTE1]
***********************************************************/
#define LIN_RRDCU_VehicleModel       LIN_RRDCU_FRAME.BYTE0.bit.RRDCU_VehicleModel

    /*
      LIN_DDCU_WinState definition
    */ 
    #define RRDCU_VehicleModel_CV8             0
    #define RRDCU_VehicleModel_V101            1
    

/***********************************************************
***********************************************************/
#define LIN_RRDCU_BYTE0       LIN_RRDCU_FRAME.BYTE0.allbits
#define LIN_RRDCU_BYTE1       LIN_RRDCU_FRAME.BYTE1.allbits


/***********************************************************
  RAINS LIN FRAME MACRO Definition [BYTE0]
***********************************************************/
#define LIN_RAINS_WiperRequest       LIN_RAINS_FRAME.BYTE0.bit.RAINS_WiperRequest

    /*
      LIN_RRDCU_WinState definition
    */ 
    #define RAINS_WiperRequest_NO              0
    #define RAINS_WiperRequest_Slow1Time       1
    #define RAINS_WiperRequest_Slow            2
    #define RAINS_WiperRequest_fast            3
    #define RAINS_WiperRequest_fault           7

/***********************************************************
***********************************************************/
#define LIN_RAINS_BYTE0       LIN_RAINS_FRAME.BYTE0.allbits
#define LIN_RAINS_BYTE1       LIN_RAINS_FRAME.BYTE1.allbits

//////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////


#define ID_BCM1          0xb1 //0x31//b1
#define ID_BCM2          0x20//0x20//20
#define ID_DDCU          0x50//0x10//0x50
#define ID_PDCU           0x11//11
#define ID_RLDCU         0x92//0x12//92
#define ID_RRDCU        0xd3//0x13//d3
#define ID_RAINS        0x80//0x00//80

#define LIN_BCM1_DataLength    6
#define LIN_BCM2_DataLength    6
#define LIN_DDCU_DataLength    2
#define LIN_PDCU_DataLength    2
#define LIN_RLDCU_DataLength   2
#define LIN_RRDCU_DataLength   2
#define LIN_RAINS_DataLength   2



//#define LIN_SendBreak          0
//#define LIN_SendHeader        1
#define LIN_Idle                  0
#define LIN_SendData              1
#define LIN_ReceiveData           2
//#define LIN_SendFinished          3
#define LIN_ReceiveFinished       4
//#define LIN_Sendhead              5

//#define LIN_TransimitData  0x00
//#define LIN_RecieverData   0xff


#define SendBCM1frame 1
#define SendBCM1frame_timeout   (SendBCM1frame+9)

#define SendBCM2frame   (SendBCM1frame_timeout+1)
#define SendBCM2frame_timeout  (SendBCM2frame + 9)

#define SendDDCUframe (SendBCM2frame_timeout+1)
#define ReceiveDDCUframe_timeout (SendDDCUframe+4)

#define SendPDCUframe (ReceiveDDCUframe_timeout+1)
#define ReceivePDCUframe_timeout (SendPDCUframe+4)

#define SendRLDCUframe (ReceivePDCUframe_timeout+1)
#define ReceiveRLDCUframe_timeout (SendRLDCUframe+4)

#define SendRRDCUframe (ReceiveRLDCUframe_timeout+1)
#define ReceiveRRDCUframe_timeout (SendRRDCUframe+4)

//#define SendRAINSframe (ReceiveRRDCUframe_timeout+2)
//#define ReceiveRAINSframe_timeout (SendRAINSframe+5)

//#define LINFrame_Cycle_duty   (ReceiveRAINSframe_timeout+10)
#define LINFrame_Cycle_duty   (ReceiveRRDCUframe_timeout+10)


extern struct BCM_LIN_FRAME1  LIN_BCM_FRAME1;
extern struct BCM_LIN_FRAME2  LIN_BCM_FRAME2;
extern struct DDCU_LIN_FRAME  LIN_DDCU_FRAME;

extern struct PDCU_LIN_FRAME  LIN_PDCU_FRAME;
extern struct RLDCU_LIN_FRAME LIN_RLDCU_FRAME;
extern struct RRDCU_LIN_FRAME LIN_RRDCU_FRAME;
extern struct RAINS_LIN_FRAME LIN_RAINS_FRAME;

extern uchar  LinRcBuffer[8];
extern uchar  LinTxBuffer[8];
extern uchar  LIN_StateFlag ;
extern uchar  LIN_IDProperty;
extern uchar  LIN_RECIVE_DataLength;
extern uchar  RxBufIndex ;
extern uchar  TxBufIndex ;
extern uchar  LINsendLen;
extern uchar  LIN_OUT_TIME_FLAG;
//extern u16    LostCommunication[7]; 
extern  uint  FJwarmTime;
//extern uchar  LIN_OUT_TIME_FLAG;

    
//extern void LIN_RequestMsg(void);
extern void LIN_FrameInit(void);
extern void LIN_PutMsg(uchar msgId);
extern void LinTaskScheduler(void);
extern void LIN_Init(void);
extern void LINControlDTC(void);
extern void WAKElin(void);
#endif
