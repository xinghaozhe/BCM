
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H
#define ENTRY_STANDBY_DELAY     227000//150000 //250////1//����͹���ʱ��
#define IMMO_LED_DUTY         1       //���ָʾ�Ƶ���ʱ��
#define IMMO_LED_PERIOD      50      //���ָʾ������
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
extern uchar   WakeState;            //˯�߻��ѱ�־����
extern uint    WakeInTime;           //��ʱ����˯�� ʱ��  �����ñ���
extern uint    WakeUpTime;           //����ʱ��           �����ñ���
extern uchar   StandByState;         ////�����źš���������ײ���ƹ�  �˳��͹���ģʽ
extern uchar   StandTIM3state;
extern ulong  StandbyTime;  //����͹���ʱ�����
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
