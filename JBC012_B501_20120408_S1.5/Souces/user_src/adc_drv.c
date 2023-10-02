
/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              adc_drv.c
  Build Author:          Kevin   
  creation date:         2007/08/28
  Version of Software:   V101_BCM_v0.1                         
  Version of Hardware:   V101_BCM_v0.1
  Description:  MCU:ST79
                Development Tools: 
  Function List:   
    1. 
    2. 
  History:        
      <author>      Kevin
      <date>        2007/08/28
      <version >    v0.0.0 
      <description> build this moudle                   
*********************************************************************/

/*********************************************************************
 INCLUDE HEADER FILES
*********************************************************************/
#include "adc_drv.h"
#include "gpio_macro.h"
#include "stm8_lib.h"

/*********************************************************************
 VARIABLES DECLARATION
*********************************************************************/
uint  adResult[AD_CH_INDEX_MAX][AD_RST_INDEX_MAX];
uchar adChIndex,adRstIndex;
uchar ADCerrorCnt;

/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/
const uchar adChannelTable[AD_CH_INDEX_MAX] = 
{

       LOCK_KEY_ADIN,			//ADC channel 10
       WIN_FL_KEY_ADIN,		//ADC channel 7
	BATTERY_VOL_ADIN,		//ADC channel 11
	//TURN_R_CS_ADI,			//ADC channel 15
	TURN_L_CS_ADI,			//ADC channel 14
	SCANTURNK,
	
};

/*********************************************************************
Name    :   void ADC_Start(void)
Function:   V101BCM function description
Input   :   None
Output  :   None
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
//ADC start conversion
void ADC_Start(void)
{
	adChIndex = 0;
	adRstIndex = 0;
	ADC->CSR = adChannelTable[adChIndex];
	ADC->CR1 |= 1;			//This bit must be written twice.
	ADC->CR1 |= 1;			//Enable ADC and to start conversion

}
/*********************************************************************
Name    :   void ADC_Stop(void)
Function:   V101BCM function description
Input   :   None
Output  :   None
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
//ADC stop conversion
void ADC_Stop(void)
{
	ADC->CSR = 0;		    //disable ADC convertion interrupt
	ADC->CSR &= 0xdf;		//disable ADC convertion interrupt
	ADC->CR1 &= 0xfe;
	ADC->CR1 &= 0xfe;		//This bit must be written twice.To power off ADC module 
}

/*********************************************************************
Name    :   void ADC_Scan(void)
Function:   V101BCM function description
Input   :   None
Output  :   None
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void ADC_Scan(void)      
{
	uchar i;
	//if in 2*4ms = 8ms adc convert isn't completed,
	//and then change next AD chanale
	for (i=0;i<AD_CH_INDEX_MAX;i++)
	{
		adResult[i][adRstIndex] = ADC_GetValue(adChannelTable[i]);
	}	
	if (++adRstIndex >= AD_RST_INDEX_MAX)	
    {
        adRstIndex = 0;
    }
	

}


/*********************************************************************
Name    :   uint GetADCresultAverage(void)
Function:   V101BCM function description
Input   :   None
Output  :   None
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
uint GetADCresultAverage(uchar ADCResultIndex)
{
	ulong sum;
	uint  adcMax,adcMin,Average,i;

	sum = adcMax = adcMin = adResult[ADCResultIndex][0];

	//calculate sum + find max and min adc value
	for (i=1;i<AD_RST_INDEX_MAX;i++)
	{
		//calculate sum
		sum += adResult[ADCResultIndex][i];
		//find max and min 
		if (adcMax < adResult[ADCResultIndex][i])
		{
			adcMax = adResult[ADCResultIndex][i];
		}
		if (adcMin > adResult[ADCResultIndex][i])
		{
			adcMin = adResult[ADCResultIndex][i];
		}
	}
	//delete max and min adc value
	sum = sum - adcMin - adcMax;
	//calculate adc result's average
	Average = sum >> 2; 

	return Average;

}

/*********************************************************************
 end of the adc_drv.c file
*********************************************************************/


