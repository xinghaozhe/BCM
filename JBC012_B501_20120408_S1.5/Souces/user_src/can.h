/*******************************************************************************
| File Name    : st79_can.h
| Description  : This file contains all the functions prototypes for the can.c.
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
| 10-Mar-2006  1.0   CA      Created.
*******************************************************************************/

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __ST79_CAN_H
#define __ST79_CAN_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_type.h"

/* Exported types ------------------------------------------------------------*/
/* user transmmit structure */
typedef volatile struct
{
	u16 stdid;
	u16 extid;
	u8 dlc;
	u8 data[8];
} tCanMsgOject;

typedef volatile struct
{
	u16 stdid;
	u16 extid;
	u8 dlc;
	u8 data[8];
	u8 State;
} RCanMsgOject;


///////
//extern unsigned char gNMMsgTransitFlag  ;//@0X4500;
//extern unsigned char gLocalWakeupFlag;
//extern unsigned char gRemoteWakeupFlag;

//extern unsigned short gTimeOskeBase;
//extern unsigned char gNMCANBatFlag;
//extern unsigned char gNMCanBusOff;
//extern unsigned char gDectID_EMS_255_Flag;
//extern unsigned char gDectID_IP_270_Flag;
//NM output
//extern unsigned char gNMHasSleeped;
//extern unsigned char gCanNormalMsgActive;
//extern unsigned char gNodeMiss_EMS_255;
//extern unsigned char gNodeMiss_IP_270;

//extern NM_NetWorkStatus_TypeDef gNetWorkStatus;
//extern CAN_Msg_TypeDef NM_CAN_DATA[3];



extern vu8 Can_Page;
extern vu16 Rx_Stdid[1];
extern vu16 Rx_Extid[1];
extern vu8  Rx_Dlc[1];
extern vu8  Rx_Data[1][8];
extern vu8  Rx_Flag[1];

extern vu8  CanSendData[8];   //CAN发数据暂村变量

extern tCanMsgOject Tx_Msg;
extern RCanMsgOject Rx_Msg[10];    //接收缓存
extern u8 Can_Tx_State;

extern u8     MasterVehSpeedFault;    //车速度标志//是否有效
extern u8     BatteryVoltage;         //电池电压  //CAN  可能不要
extern u8     MasterVehicleSpeed;     //车速2,419 不知道怎么用
extern uchar  BreakPedalSignal; //刹车踏板信号  通过CAN总线获得
extern uchar  CAN_FORTIFY_state;  //CAN解除设防标志
extern uchar  DTCsendstate;     //DTC send state
extern uchar  PIDsendstate;     //PID send state
extern u16  battervalue;  //电池电压缓存
extern uchar PIDbattervalue;
extern u16 adResultTemp1,adResultTemp2 ;
//Diag PID
extern uchar CommonPID4932[4]; //PID 4932
extern uchar CommonPID7100[2]; //PID 7100
extern uchar CommonPID7110[2]; //PID 7110
extern uchar CommonPID7115[2]; //PID 7115
extern uchar CommonPID7130[2]; //PID 7130
extern uchar CommonPIDA141[2]; //PID A141
extern uchar CommonPIDA145[2]; //PID A145
extern uchar CommonPIDA442[2]; //PID A442
extern uchar CommonPIDA445[2]; //PID A445
extern uchar CommonPIDA452[2]; //PID A452
extern uchar CommonPIDA455[2]; //PID A455
extern uchar CommonPIDA457[2]; //PID A457
extern uchar CommonPIDC111[2]; //PID C111
extern uchar CommonPIDC136[2]; //PID A136
extern uchar CommonPIDC900[2]; //PID A900
//input/output PID
extern uchar InOutPutPID0200[1];   //pid0200
extern uchar InOutPutPID0202[1];   //pid0202
extern uchar InOutPutPIDd102[1];   //pid0102
extern uchar InOutPutPIDe114[1];   //pide114
//PACK PID
extern uchar PACKPIDa442[2];       //pida442
extern uchar PACKPIDe200[4];       //pide200
extern uchar PACKPIDe217[4];       //pide217
extern uchar PACKPIDe219[2];       //pida442
extern uchar PACKPIDe21a[4];       //pida442

#define  DTCLongAdress     50
//extern uchar reknumbercnt;
extern uchar  VehicleType;     //车型配置
//u8     VehicleType                   @0x4080;   //车型   通过CAN总线 学习钥匙时配置
extern u8     VehicleTypeEnable  ;//           @0x4081;
extern u16    RetCode            ;//           @0x4082;   //初始密码状态
extern u8     SecurityAccess     ;//            @0x4084;   //状态
extern u8     HornAlarmState     ;//            @0x4085;   //喇叭报警
extern u16    PassWord1          ;//            @0x4086;   //BCM密码 
extern u16    PassWord2          ;//            @0x4088;   //BCM密码 
extern u8     Configuration[5]   ;//            @0x4090;
extern u8     CANsetvalue[4]; 
extern u16    ONESstate ;              //                     @0x409b;
extern u32    BCMnumber  ; // xx year  x moth  xx day  xxx number      16hex
extern u8     Hazardecestate    ;//            @0x40a1;   //减速报警是否启用标志
extern u8     Rearfogbutton     ;//            @0x40a2;   //后雾灯开关状态
//extern u16    DTCnumber[DTCLongAdress]      ;//            @0x409a;   //故障代码保存空间
/////////////////////////
extern uint  DeceSettingValueH;//         @0x4070;  //减速161-224KMS
extern uint  DeceSettingValueL;//         @0X4074;  //减速96-161KMS
//DTC value
extern uchar Speedlock_ls;
extern  uchar  WiperINTDiag;
extern uchar salfmode;   //安全模式状态 为1为可以允许TEST操作   2允许改密码
extern uchar CAN_Auto_state;
//////////////////////////////
extern uchar CAN_Crash;

//#define AT  1    //自动档
//#define MT  2    //手动档
#define CJAE 0x03   //集诚公司标识
//车型配置
#define RESERVED 0x10
#define CV8      0x20
#define CV101    0x30
/* Exported constants --------------------------------------------------------*/
#define CanSavePg()     (Can_Page = CAN_FPSR)
#define CanRestorePg()  (CAN_FPSR = Can_Page)

/*-- Bit defines -----------------------------------------------------------*/
#define CAN_TXMB0_PG       ((u8) 0) /* CAN TX mailbox 0 reg page */
#define CAN_TXMB1_PG       ((u8) 1) /* CAN TX mailbox 1 reg page */
#define CAN_FILTER01_PG    ((u8) 2) /* CAN Filters 0 & 1 reg page*/
#define CAN_FILTER23_PG    ((u8) 3) /* CAN Filters 2 & 3 reg page*/
#define CAN_FILTER45_PG    ((u8) 4) /* CAN Filters 4 & 5 reg page*/
#define CAN_TXMB2_PG       ((u8) 5) /* CAN TX mailbox 2 reg page */
#define CAN_CTRL_PG        ((u8) 6) /* CAN control/status reg page*/
#define CAN_FIFO_PG        ((u8) 7) /* CAN FIFO registers page */

#define MCSR_ABRQ          ((u8)0x40)
#define MCSR_TXRQ          ((u8)0x01)
#define MCSR_RQCP          ((u8)0x04)

#define CMCR_TTCN          ((u8)0x80)
#define CMCR_ABOM          ((u8)0x40)
#define CMCR_AWUM          ((u8)0x20)
#define CMCR_NART          ((u8)0x10)
#define CMCR_RFLM          ((u8)0x08)
#define CMCR_TXFP          ((u8)0x04)
#define CMCR_SLEEP         ((u8)0x02)
#define CMCR_INRQ          ((u8)0x01)

#define CMSR_SLAK          ((u8)0x02)
#define CMSR_INAK          ((u8)0x01)
#define CMSR_ERRI          ((u8)0x04)
#define CMSR_WKUI          ((u8)0x08)
#define CMSR_REC           ((u8)0x20)

#define CTSR_RQCP0         ((u8)0x01)
#define CTSR_RQCP1         ((u8)0x02)
#define CTSR_RQCP2         ((u8)0x04)
#define CTSR_TXOK0         ((u8)0x10)
#define CTSR_TXOK1         ((u8)0x20)

#define CTPR_TME0          ((u8)0x04)
#define CTPR_TME1          ((u8)0x08)
#define CTPR_TME2          ((u8)0x10)

#define CRFR_RFOM          ((u8)0x20)
#define CRFR_FOVR          ((u8)0x10)
#define CRFR_FULL          ((u8)0x08)
#define CRFR_FMP01         ((u8)0x03)

#define CESR_BOFF          ((u8)0x04)
#define CESR_EPVF          ((u8)0x02)
#define CESR_EWGF          ((u8)0x01)

#define CDGR_RX            ((u8)0x08)
#define CDGR_3TX           ((u8)0x10)
#define CDGR_LBKM          ((u8)0x01)
#define CDGR_SILM          ((u8)0x02)


#define CIER_WKUIE         0x80U
#define CIER_FOVIE         0x08U
#define CIER_FFIE          0x04U
#define CIER_FMPIE         0x02U
#define CIER_TMEIE         0x01U

#define CEIER_ERRIE        0x80U
#define CEIER_LECIE        0x10U
#define CEIER_BOFIE        0x04U
#define CEIER_EPVIE        0x02U
#define CEIER_EWGIE        0x01U

/* Return Status by the driver function */ 
#define KCANTXFAILED	((u8) 0x00)
#define KCANTXOK		((u8) 0x01)

#define MSG1_STDID		(u16)0x0508
#define MSG1_EXTID		(u16)0x0206
#define MSG1_DLC			(u8)3
#define MSG1_DATA1		(u8)0x01
#define MSG1_DATA2		(u8)0x01
#define MSG2_STDID		(u16)0x0308
#define MSG2_EXTID		(u16)0x0
#define MSG2_DLC			(u8)2
#define MSG2_DATA1		(u8)0x0A
//#define MSG2_DATA2		(u8)0xC0
#define MSG3_STDID		(u16)0x0418
#define MSG3_EXTID		(u16)0x0
#define MSG3_DLC			(u8)2
#define MSG3_DATA1		(u8)0x08
//#define MSG3_DATA2		(u8)0xC0




//extern uchar LOWBeamDriverState;   //近光灯驱动状态
/*-- CAN bit timing parameters ------------------------------------------------*/
/* Note: 8 <= total number of TIME QUANTUM (Tq) <= 25 */
/*******************************************************************************
 Constant Name: SJW
 Description  : Resynchronization Jump Width
 Value range  : from 1 to 4
 Comments     : The decrease by 1 for register write is made automatically.
*******************************************************************************/
#define CAN_SJW ((u8) 3)

/*******************************************************************************
Constant name: BRP
Description  : Baud Rate Prescaler - define length of Tq
Value range  : from 1 to 64
Comments     : The decrease by 1 for register write is made automatically.
*******************************************************************************/
/* Baud rate = 125 Kbps @ (16 Tq & Fcpu = 8 MHz) */
#define CAN_BRP ((u8) 4)

/* Baud rate = 100 Kbps @ (16 Tq & Fcpu = 8 MHz) */
//#define CAN_BRP ((u8) 10)

/*******************************************************************************
Constant name: TSEG1
Description  : Time Segment 1 (+ prop. seg.)
Value range  : from 1 to 16              
Comments     : The decrease by 1 for register write is made automatically.
*******************************************************************************/
#define CAN_TSEG1 ((u8) 4)

/*******************************************************************************
Constant name: TSEG2
Description  : Time Segment 2
Value range  : from 1 to 8        
Comments     : The decrease by 1 for register write is made automatically.
*******************************************************************************/
#define CAN_TSEG2 ((u8) 3)


/* CAN BIT TIMING REGISTERS */
#define CAN_CBTR0_REGISTER (u8)  ( ((CAN_SJW-1 & 0x03)<<6) | ((CAN_BRP-1) & 0x3f) )
#define CAN_CBTR1_REGISTER (u8)  ( ((CAN_TSEG2-1 & 0x07)<<4) | ((CAN_TSEG1-1) & 0x0f) )


/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
extern void CAN_Init (u8);
extern void CAN_WakeUp (void);
extern void CAN_EnableDiagMode (u8);
extern void CAN_DisableDiagMode (void);
extern u8   CanMsgTransmit (tCanMsgOject*);
extern void CAN_Sleep (void);
extern void CanCanInterruptDisable (void);
extern void CanCanInterruptRestore (void);
extern void CANSend(void);
extern void CANRX(void);
extern void CAN_Send1(u16 ID,u8 DLC ,u8 *data);
extern void CAN_send2(u16 ID,u8 dlc,u8 data0,u8 data1,u8 data2,u8 data3,u8 data4,u8 data5,u8 data6,u8 data7);
extern void DiagnosticateTactic(void);
extern void CANenble(void);
extern void ClearDTC(void);
extern void WriteDTC(u16 DTCvalue);
extern void SendDTC(void);

extern void BatteryDTC(void);
extern void MMXG3b01(u8 mode ,u8 Rxcnt);
extern void CommonPIDdiag(void);
extern void DiagPIDsendChange(u8 commoned1,u8 commoned2,u8 *PIDdata,u8 Datalong);
extern void DiagPIDsend(uchar Rxcnt);
//extern void WiperDTC(void);
//extern void WiperParkDTC(void);
extern void CentralLockDTC(void);
//extern void FWiperINTOutDTC(void);
extern void TurnCircuitDTC(void);
extern void TrunkDiagDTC(void);
//extern void SaverBatteryDTC(void);
//extern void RearWindowDTC(void);

extern void DoorDTC(void);
extern void TurnSwitchDTC(void);
extern void KeySwitchDTC(void);
extern void LockUnlockOutDTC(void);
extern void HazardSwitchDTC(void);
extern void TCUandEMS_DTC(void);
extern void writeHazardecestate(u8 number);
extern void writeRearfogbutton(u8 number);
extern void Crash_CAN(void);
//can ID

#define  EMS_ID1                             0x255
#define  EMS_ID2                             0x265
#define  TCU_ID                              0x339
#define  ABS_ID                              0x218
#define  SRS_ID                              0x050
#define  BCM_PM_ID                           0x288

#define  TesterID                            0x700
#define  TesterBCM                           0x708

//诊断宏定义  diag
#define  DIAGMODE87                                       0x87
#define  DIAGMODE81                                       0x81
#define  DIAGMODE82                                       0x82

#define  STARTDIAG                                0X10
#define  STOPDIAG                                 0x20
//#define  ECUREST                                  0x11
//#define  ReadFreezeFrameData                      0x12
#define  ClearDiagInformation                     0x14
#define  ReadDTCbyStatus                          0x18
#define  ReadDataByLocalld                        0x21
#define  ReadDataByCommonld                       0x22
//#define  ReadMemoryByAddress                      0x23
//#define  ReqCommonldScalingMask                 0x24
#define  SECURITYACCESS                           0x27
//#define  WriteDatabyCommonld                       0x2e
//#define  INOUTputCtrlCommonld                      0x2f
#define  StartRoutineLocall                       0x31
#define  StopRountinelocall                       0x32
//#define  ReqRoutineResultsLocalld                   0X33
//#define  RequestDownload                                0x34
//#define  RequestUpload                                    0x35
//#define  TransferData                                       0x36
//#define  RequestTransferExit                           0x37
#define  WriteDatabyLocalld                       0x3b
//#define  WriteMemoryAddress                        0x3d
#define  TesterPresent                            0x3e
//#define  ReqDiagDataPacket                            0xa0
//#define  DynamicallyDefineDiagPACK             0xa1
#define  SAEJ1979DiagTestMode                     0xb1
#define  Error                                                  0x7f
//Diag DTC
#define  BatteryValueLOW                              0x205
#define  BatteryValueHIG                               0x3f0

#define  houmen0                                   0x08
#define  houmen1                                   0xfe
#define  houmen2                                   0xc7
#define  houmen3                                   0xae
#define  houmen4                                   0x75
#define  houmen5                                   0x3f
#define  houmen6                                   0x5a
#define  houmen7                                   0x88
////////////////////////////////////////////////
#define  SoftwareEdition    0x000a911f 
////////////////////////////////////////////////
//#define  SoftwareEdition    0x000a831f    //长安协议更改 SKB SKC更改长安发放密钥
////////////////////////////////////////////////
//#define  SoftwareEdition    0x000a311c
///////////////////////////////////////////////////
//#define  SoftwareEdition    0x000a311c  RKE协议更改
//////////////////////////////////////////////////////
//#define  SoftwareEdition    0x0008920e LIN总线有IGN到ON时一直发LIN命令
//////////////////////////////////////////////////
//#define  SoftwareEdition    0x0008910d  根据长安最新更改#define  SoftwareEdition    0x0008910d
//////////////////////////////////////////////////
//#define  SoftwareEdition    0x0008840c  实用于CV8和CV101
///////////////////////////////////////////////////
//#define  SoftwareEdition    0x0008830b   RKE唤醒  方式更改
///////////////////////////////////////////////////
//#define  SoftwareEdition    0x00088109
//实车测试版本   20080723 周晶杰功能核实版本
///////////////////////////////////////////////////
//#define  SoftwareEdition    0x00087308         //
//实车测试版本   20080718  陈华核实功能版本      //
///////////////////////////////////////////////////
//#define  SoftwareEdition    0x00086405                //
//经过周晶杰功能验证过的版本 //
/////////////////////////////////////////////
/*
#define  SoftwareEdition    0x00085101  
软件版本号定义:
                        byte1 :  00     预留
                        byte2 :  08     2008年
                        byte3 :  51     5: 为五月份  1: 为五月份第一版本
                        byte4    01     总版本序列号
*/
//module configuration

#define  Speedlockset                    Configuration[0]&0x80
#define  HornWarm                        Configuration[0]&0x40
#define  AT                              Configuration[0]&0x20
//#define  MT              Configuration[0]&0xcf
#define  HazardDECEN                     Configuration[0]&0x10
#define  IgnitionTICEN                   Configuration[0]&0x08
#define  RadioInAlarmEN                  Configuration[0]&0x02
#define  RCdoorUnlockEN                  Configuration[0]&0x01
#define  RRWindowControlEN               Configuration[1]&0x80
#define  RLWindowControlEN               Configuration[1]&0x40
#define  PassengerWindowEN               Configuration[1]&0x20
#define  DriverWindowEN                  Configuration[1]&0x10
#define  RRDCU                           Configuration[1]&0x08
#define  RLDCU                           Configuration[1]&0x04
#define  PDCU                            Configuration[1]&0x02
#define  DDCU                            Configuration[1]&0x01
#define  RWiperControlEN                 Configuration[2]&0x10
#define  RheostatFitted                  Configuration[2]&0x08
#define  FWiperHControlEN                Configuration[2]&0x04
#define  FWiperLControlEN                Configuration[2]&0x02
#define  FWiperControlEN                 Configuration[2]&0x01
#define  RFogLightPushEN                 Configuration[3]&0x10
#define  HomeSafeLightEN                 Configuration[3]&0x08
#define  PassengerWarmEN                 Configuration[3]&0x04
#define  LightSensorEN                   Configuration[3]&0x02
#define  RainSensorEN                    Configuration[3]&0x01


#define EECNT   10

//////////////////////////////////////////////////////////////////////
#define CAN_TURNLeftSW_ON     				CanSendData[1]|=0x40
#define CAN_TURNLeftSW_OFF    			    CanSendData[1]&=0x3f
#define CAN_TURNLeftSW_Error    			CanSendData[1]|=0xc0
#define CAN_TURNRightSW_ON     				CanSendData[1]|=0x10
#define CAN_TURNRightSW_OFF    			    CanSendData[1]&=0xcf
#define CAN_TURNRightSW_Error    			CanSendData[1]|=0x30
//////////////////
#define CAN_TrunkSW_ON   	  				CanSendData[2]|=0x08
#define CAN_TrunkSW_OFF						CanSendData[2]&=0xf7
#define CAN_RRdoorSW_ON   	  				CanSendData[2]|=0x10
#define CAN_RRdoorSW_OFF					CanSendData[2]&=0xef
#define CAN_LRdoorSW_ON   	  				CanSendData[2]|=0x20
#define CAN_LRdoorSW_OFF					CanSendData[2]&=0xDF
#define CAN_RFdoorSW_ON   	  				CanSendData[2]|=0x40
#define CAN_RFdoorSW_OFF					CanSendData[2]&=0xBF
#define CAN_LFdoorSW_ON   	  				CanSendData[2]|=0x80
#define CAN_LFdoorSW_OFF					CanSendData[2]&=0x7F
//////////////////
#define CAN_FLwindowDrv_ON   	  			CanSendData[3]|=0x40
#define CAN_FLwindowDrv_OFF					CanSendData[3]&=0x3f
#define CAN_FLwindowDrv_Error				CanSendData[3]|=0xc0
//////////////////
#define CAN_RDefrostSW_ON   	  			CanSendData[4]|=0x01
#define CAN_RDefrostSW_OFF					CanSendData[4]&=0xfc
#define CAN_RDefrostSW_Error				CanSendData[4]|=0x03
//////////////////
#define CAN_LOCKstate_unlock 	  			CanSendData[5]|=0x01
#define CAN_LOCKstate_lock					CanSendData[5]&=0xfc
#define CAN_LOCKstate_Error					CanSendData[5]|=0x03
//////////////////
#define CAN_ARMED_Disarmed   	  			CanSendData[6]&=0xcf
#define CAN_ARMED_prearmed					CanSendData[6]|=0x10
#define CAN_ARMED_Armed						CanSendData[6]|=0x20
#define CAN_ARMED_Error						CanSendData[6]|=0x30
//////////////////
#define CAN_System_Error 	  				CanSendData[7]|=0x20
#define CAN_System_noError					CanSendData[7]&=0xdf
//////////////////
#define CAN_Buzz_close                      CanSendData[7]&=0xf0
#define CAN_Buzz_gohome                     CanSendData[7]=(CanSendData[7]&0XF0)|0X01
#define CAN_Buzz_SpeedlockOFF               CanSendData[7]=(CanSendData[7]&0XF0)|0X02
#define CAN_Buzz_SpeedlockOON               CanSendData[7]=(CanSendData[7]&0XF0)|0X03
#define CAN_Buzz_LeankeyOK                  CanSendData[7]=(CanSendData[7]&0XF0)|0X04
#define CAN_Buzz_DRVunlockOFF               CanSendData[7]=(CanSendData[7]&0XF0)|0X05
#define CAN_Buzz_DRVunlockON                CanSendData[7]=(CanSendData[7]&0XF0)|0X06

#define CAN_Buzz_LightON	                CanSendData[7]=(CanSendData[7]&0XF0)|0X10
#define CAN_Buzz_Sunroof               	    CanSendData[7]=(CanSendData[7]&0XF0)|0X11
#define CAN_Buzz_KeyinON               	    CanSendData[7]=(CanSendData[7]&0XF0)|0X12
#define CAN_Buzz_NOkey              	    CanSendData[7]=(CanSendData[7]&0XF0)|0X13
#define CAN_Buzz_armedOUT              	    CanSendData[7]=(CanSendData[7]&0XF0)|0X14
#define CAN_Buzz_DopenLock             	    CanSendData[7]=(CanSendData[7]&0XF0)|0X15
#define CAN_Buzz_RKElow               	    CanSendData[7]=(CanSendData[7]&0XF0)|0X16
#define CAN_Buzz_PSeat               	    CanSendData[7]=(CanSendData[7]&0XF0)|0X17
#define CAN_Buzz_Dseat               	    CanSendData[7]=(CanSendData[7]&0XF0)|0X19
#define CAN_Buzz_DoorNoClose           	    CanSendData[7]=(CanSendData[7]&0XF0)|0X1b


#define BrakeNO     0
#define BrakeOK     1
#define BrakeError  3

extern unsigned char cansendstate;
extern unsigned char cansendbusoff;
////////////////////////////////////////////////////////////////////////////////////////
extern uint DeceSettingValue(uchar seting);
extern uint DeceCount(uint speed);  
extern void DecelerationThresholds(uint VehicleSpeed);
extern void DecelerationSetting(uchar SettingValue);
extern void BUSoff(void);

extern unsigned char RXITcnt;
extern unsigned char RXREcnt;

extern unsigned char Busoffstate;
extern unsigned int busoffcnt;
extern unsigned int busofftimecnt;
	
#define NMbuslang      5


#define     Speed45      	80
#define     Speed96         207
#define     Speed160        284

#endif /* __ST79_CAN_H */
/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
