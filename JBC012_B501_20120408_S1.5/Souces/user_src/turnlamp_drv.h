
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              turnlamp_drv.h
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


/*********************************************************************
 VARIABLES BITS DEFINITION
*********************************************************************/
//"TurnLampDrv" bits definition
#define  TurnLampLeftOn    	0x01             //����ƴ�
#define  TurnLampLeftOff   	0xfe             //����ƹر�
#define  TurnLampRightOn   	0x02             //��ת��ƴ�
#define  TurnLampRightOff  	0xfd             //��ת��ƹر�
#define  TurnLampHazzardOn  0x04             //�����źŴ�
#define  TurnLampHazzardOff	0xfb             //�����źŹر�
#define  TurnLampCrashOn    0x08             //��ײ�źŴ�
#define  TurnLampCrashOff   0xf7             //��ײ�źŹر�
#define  TurnLampBrakeOn    0x10             //����ɲ���źŴ�
#define  TurnLampBrakeOff	0xef             //����ɲ���źŹر�

//"TurnLampCScmd" bits definition 
#define  TLCSCMD_L_OPEN		0x01
#define  TLCSCMD_L_SHORT	0x02
#define  TLCSCMD_R_OPEN		0x04
#define  TLCSCMD_R_SHORT	0x08
#define  TLCSCMD_NO       	0x00

//"TurnLampState" bits definition
#define  TLL_IS_SHORT		0x01
#define  TLL_IS_OPEN		0x02
#define  TLR_IS_SHORT		0x04
#define  TLR_IS_OPEN		0x08
#define  TL_STA_MASK		0x0f
#define  TL_IS_OK			0x00

//static unsigned char  tempFlag bits definition
#define  findCarTurnOn		0x01
#define  findCarTurnOff		0xfe
#define  findCarHornOn		0x02
#define  findCarHornOff		0xfd


/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/
//turn lamps period definition
#define  TL_NORMAL_DUTY      45		 //360ms
#define  TL_NORMAL_PERIOD    90		 //720ms
#define  TL_FAST_DUTY     	 20		 //190ms
#define  TL_FAST_PERIOD   	 40		 //380ms
#define  TL_WAIT_TIME        10      //80ms
#define  BRAKEKEEPTIME       125     //125*8ms=1s
#define  CRASHKEEPTIME       500     //500*8ms=4s  
#define  TURNLAMPRIROTYTIME  1000//3750    //3750*8ms=30s
#define  DISABLEROADWAYTIME  125     //125*8ms=1s

//turn lamps key = off->on->off = t 
//when 0<t<500ms,switch roadway,flashs left/right turn lamps 3 times
#define  TL_SWITCH_ROADWAY_MAXCNT	87	//87*8ms=700ms
#define  TL_SWITCH_ROADWAY_MINCNT   13  //13*8ms=100ms

//turn lamps short/open adc value definition
//20091024 �差����
#define  TL_SHORT_VALUE		300//700//220		// 4V/5V*255=204
#define  TL_OPEN_VALUE		1000//160		// 3V/5V*255=153
//20091024�差����
#define  turnTL                    60 //50
#define   turntlcnt                   15

//turn flash period for RKE
#define  RKE_FLASH_TL_DUTY       30
#define  RKE_FLASH_TL_PERIOD     50

extern unsigned char turnfindcarstate;

/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/
extern uint   TurnFlashCnt;
extern uint     ledcnt;
extern uchar  TurnLampDrv;
extern uint  TurnLamp_CrashKeepTime;
//Ѱ��������
extern uchar   LockDrvCmd;
extern uchar  	LockState;
extern uchar    DoorState;
extern uchar  Turn_R_State;         //��ת����״̬
extern uchar  Turn_L_State;         //��ת����״̬
extern uchar  Warningstate;
extern uchar  HazzardState;         //��������״̬
extern uchar  Crash_state_Y;            //��ײ�źű��
extern uint   WarningTimeCnt;  	//������� 5���Ӽ���
extern uchar  RKEBatteryVoltage_turn;
extern uchar  BrakeSpeedHazards_state;  //����ɲ������״̬


extern uchar  TurnLampState;
/*********************************************************************
 API DECLARATION
*********************************************************************/
extern void FindCar(void);
extern void ScanTurnLampKeys(void);
extern void JudgeTurnLampDrv(void);
extern void ScanStandByHazzardKeys(void);
extern void ScanTurnLampState(void);
extern void SFLED(void);
extern void Turnvcclow(void);
extern void turnbd(unsigned int turnad);
/*********************************************************************
 end of the turnlamp_drv.h file
*********************************************************************/


