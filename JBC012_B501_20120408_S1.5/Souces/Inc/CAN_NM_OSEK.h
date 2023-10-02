/***************************************************************
****************************************************************/
/*Can NM_OSEK Macro  Definitions*/
/***************************************************************/
#ifndef _NM_CAN_OSEK_MACRO_H_
#define _NM_CAN_OSEK_MACRO_H_



/**********************NM_OSEK_Macro.h************************/

//typedef unsigned char  u8;
//typedef unsigned short u16;
//#define u8 


/*���Զ���*/
#define XIELC_NM_STATE_FEEDBAKE                  ((u8)1)
	/***********NM���в����궨��***********/
#define NM_LOCAL_ID						0x400
#define NM_TTX_TIMEOUT					20
#define NM_TTYP_TIMEOUT					100
#define NM_TMAX_TIMEOUT					260
#define NM_TERROR_TIMEOUT				1000
#define NM_TWBS_TIMEOUT					1500
#define NM_TX_LIMIT						8
#define NM_RX_LIMIT						4
#define NM_NODE_NUM_MAX					32
	/***********�ڵ������ں궨��***********/
#define NM_DETECT_NM							2      //���ڵ���Ŀ
#define NM_NODE_DET_EMS_255						10
#define NM_NODE_DET_IP_270						40

#define NM_OFF                  ((u8)0x00)
#define NM_ON                   ((u8)0x01)
#define NM_SHUTDOWN             ((u8)0x02)
#define NM_INIT                 ((u8)0x00)
#define NM_AWAKE                ((u8)0x01)

/*OpCode����*/
#define NM_ALIVE_MSG	   				((u8)0x01)
#define NM_RING_MSG	   					((u8)0x02)
#define NM_LIMPHOME_MSG	   				((u8)0x04)
#define NM_IND_LIMPHOME_MSG	   			((u8)0x14)
#define NM_IND_RING_MSG	  				((u8)0x12)
#define NM_ACK_RING_MSG	   				((u8)0x32)
#define NM_IND_ALIVE_MSG	   			((u8)0x11)
#define NM_BIT_IND_MSG	   				((u8)0x10)
#define NM_BIT_RING_MSG	   				((u8)0x02)

/*�����궨��*/
#define NM_SOURCE_ID	   				((u8)NM_LOCAL_ID)
#define NM_SEND_MSG_DLC					((u8)0x08)

/*����״̬�궨��(gNMNodeState)*/
#define NM_NORMAL_RUN					((u8)0x01)
#define NM_NORMAL_PRESLEEP				((u8)0x02)
#define NM_NORMAL_WAITSLEEP				((u8)0x04)
#define NM_LIMPHOME_RUN					((u8)0x10)
#define NM_LIMPHOME_PRESLEEP			((u8)0x20)
#define NM_LIMPHOME_WAITSLEEP			((u8)0x40)

/*Ӳ��״̬�궨��*/
#define NM_HARDWARE_INIT				((u8)0x01)
#define NM_HARDWARE_SLEEP				((u8)0x02)
#define NM_HARDWARE_WAKEUP				((u8)0x04)
#define NM_HARDWARE_NORMAL				((u8)0x08)

/*��ʱ�����ú궨��*/
#define NM_BIT_TIMER_CANCEL				((u8)0x00)
#define NM_BIT_TTYP_SET					((u8)0x01)
#define NM_BIT_TMAX_SET					((u8)0x02)
#define NM_BIT_TERROR_SET				((u8)0x04)
#define NM_BIT_TWBS_SET					((u8)0x08)

/*����״̬������NM_FUNCTION�ǵı�־*/
#define NM_TTYP_TIMEOUT_FLAG									((u8)0x01)
#define NM_TMAX_TIMEOUT_FLAG									((u8)0x02)
#define NM_TERROR_TIMEOUT_FLAG								((u8)0x04)
#define NM_TWBS_TIMEOUT_FLAG									((u8)0x08)
#define NM_TRANSMIT_FLAG											((u8)0x11)
#define NM_GOTOSLEEP_FLAG											((u8)0x12)
#define NM_EXITSLEEP_FLAG											((u8)0x21)

/*����ģ��ID*/
#define NM_ID_BCM									((u8)0x00)
#define NM_ID_IBC									((u8)0x01)
#define NM_ID_ESCL									((u8)0x02)
#define NM_ID_PEPS									((u8)0x03)

/*CAN����״̬*/
#define NM_BCM_BUS_OK										 			(0U)
#define NM_BCM_NON_BUS_OFF								 				(1U)
#define NM_BCM_BUS_OFF										 			(2U)
#define NM_BCM_BUS_ERROR									 			(3U)
#define NM_CAN_MODE_INIT										 		(0U)
#define NM_CAN_MODE_NORMAL								 				(1U)
#define NM_CAN_MODE_NORMALED										 	(2U)
#define NM_CAN_MODE_SUCCESS												(3U)
 
#define NM_NODE_DETECT_CYCLE_NUM_MAX							(5U)      //���ڵ����ʧ����

/*��Դ���*/
#define BAT_CAN_FAULT_FLAG                         (0U)
#define BAT_CAN_NORMAL_FLAG                        (1U)

#define NM_INIT_DELAY_TIMEOUT                      (120U)

typedef volatile struct NM_Merker_struct
{
	u8	stable;
	u8	limphome;																							//����״̬�ɹ�����NM���ı�־��
}
NM_Merker_TypeDef;

typedef volatile struct NM_Config_struct
{
	u8	limphome;																							//�����Ƿ���Limphome״̬��־��
}
NM_Config_TypeDef;

typedef volatile struct NM_NetWorkStatus_struct
{
	u8	configurationstable;
	u8	NMactive;
	u8	bussleep;
	u8  gNMStart;                  //�������ʼ���б�־
}
NM_NetWorkStatus_TypeDef;

typedef volatile struct CAN_Msg_struct
{
	u16	id;
	u8	dlc;
	u8	Byte[8];
}
CAN_Msg_TypeDef;

/**********************NM_OSEK_Varible.h************************/

/*************�ⲿ�������***************/
extern u16		gTimeOskeBase;
extern u8		gNMMsgTransitFlag;				//�ɹ����ͱ��ı�־��
extern u8		gLocalWakeupFlag;         //���ػ��ѱ�־��
extern u8 		gRemoteWakeupFlag;
extern u8		gCanNormalMsgActive;
extern u8		gNMHasSleeped;	//�ڵ�Ӳ��״̬��1��Ӳ����ʼ����2��˯�ߣ�3������

/*BUS-OFF*/
extern u8 	gNMCanHardwareStatus;
extern u8 	gNMCanBusOff;
extern NM_NetWorkStatus_TypeDef gNetWorkStatus;

	/***********�ڵ���ȫ�ֱ�������***********/
extern u8		gNodeMiss_EMS_255;
extern u8		gDectID_EMS_255_Flag;
extern u8		gNodeMiss_IP_270;
extern u8		gDectID_IP_270_Flag;

/*��ѹ���*/
extern u8		gNMCANBatFlag;

/**********************NM_OSEK_Function.h************************/

void NM_OSEK_Init(void);                                    //�ϵ��ʼ��ʱ����
void NM_Function_Main(void);								//NM������������ֱ�ӷ�����������

extern  CAN_Msg_TypeDef NM_RecMsgSave(void);
extern  u8 CANHardwave_Init(u8 gCANHardwareState);
extern  u8 CanSendMsg(CAN_Msg_TypeDef NM_Msg);


#endif
