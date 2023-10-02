
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              adc_drv.h
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
//"IGNstate" bits definition */



/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/
//ADC Convert result buffer index definition
#define		WinFRKADchl		0x00
#define		WinFLKADchl		0x01
#define		WinRLKADchl		0x02
#define		WinRRKADchl		0x03
#define		LockKeyADchl	0x04
#define		FWiperRADchl	0x05
#define		BatVolADchl		0x06
#define		TurnLADchl		0x07
#define		TurnRADchl		0x08

#define     AD_CH_INDEX_MAX	    5
#define     AD_RST_INDEX_MAX    6

/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/
extern uchar ADCerrorCnt;
extern uchar adChIndex,adRstIndex;
extern uint  adResult[AD_CH_INDEX_MAX][AD_RST_INDEX_MAX];

/*********************************************************************
 API DECLARATION
*********************************************************************/
//extern void ADC_Init(void);
extern void ADC_Start(void);
extern void ADC_Stop(void);
extern void ADC_Scan(void);
extern uint GetADCresultAverage(uchar ADCResultIndex);

/*********************************************************************
 end of the adc_drv.h file
*********************************************************************/

