
/* Includes ------------------------------------------------------------------*/
#include "st79_tim2tim3.h"
#include "stm8_clk.h"


void TIM2TIM3_Counter_Cycle_OVIE_init(MTIM_TypeDef * TIMX, u16 ARR_Data)
{	
	if(TIMX == TIM2) 
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
	//CLK_PCKEN1PeriphClockCmd(CLK_PCKEN1Periph_TIMER2, ENABLE);
	else
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER3, ENABLE);
	//CLK_PCKEN1PeriphClockCmd(CLK_PCKEN1Periph_TIMER3, ENABLE);

 	TIMX->CR1 |= 0X80; 				//set preload mode
  	TIMX->PSCL = 4; 					//set prescaler
  	TIMX->ARRH = (u8)(ARR_Data>>8);
  	TIMX->ARRL = (u8)ARR_Data;  
  	TIMX->CNTRH = 0;
 	TIMX->CNTRL = 10; 
 	//TIMX->CNTR = 10;  
  	TIMX->IER = 1; 
  	TIMX->SR1 &= ~1; 
  	TIMX->CR1 |= 1;
	
/*	TIMX->CR1 |=  0X80;				//set preload mode
	TIMX->ARR = ARR_Data;			// set autoreload register 
	TIMX->CNTR = 0;
	TIMX->IER &= 0XFE;				//diable overflow interrupt
	TIMX->EGR |= 0X01;				//update 
	TIMX->SR1 &= 0XFE;				//clear overflow flag
	TIMX->IER |= 0X01;				//enable overflow interrupt
	TIMX->CR1 |=  0X01;				//enable TIM2*/
}

void TIM2TIM3_OCMP_Init(MTIM_TypeDef * TIMX, uc8 CC_Channel, u16 CCR_Value, TIM2TIM3_OCMP_Mode OCMP_Mode, TIM2TIM3_Output_Mode Output_Mode)
{						// disable TIMxCCR register preload 
	switch(CC_Channel)
	{
		case	1:
		TIMX->CCER1 = TIMX->CCER1 & 0xfe;			//first clear CC1E bit in CCER, then you can modify the CC1S bits in CCMR.
		TIMX->CCMR1 = 0b00000011;					//setup the CC1S bits to reserved value, then you can modify OC1M & OC1PE configurations.
		TIMX->CCMR1 |= OCMP_Mode;				//set output compare mode
		//TIMX->CCMR1 |= 0b00001000;					//set preload mode
		TIMX->CCMR1 &= 0xfc;						//clear CC1S bits for enable channel output direction
		TIMX->CCER1 = (TIMX->CCER1 & 0xfc) | Output_Mode;
		TIMX->CCR1H = (u8)(CCR_Value>>8);
 		TIMX->CCR1L = (u8)(CCR_Value);
 		//TIMX->CCR1 = CCR_Value;
		TIMX->IER |= 2;								//enable CC1 channel output compare interrupt
		break;
		
		case	2:
		TIMX->CCER1 = TIMX->CCER1 & 0xef;			//first clear CC2E bit in CCER, then you can modify the CC2S bits in CCMR.
		TIMX->CCMR2 = 0b00000011;					//setup the CC2S bits to reserved value, then you can modify OC2M & OC2PE configurations.
		TIMX->CCMR2 |= OCMP_Mode;
		//TIMX->CCMR2 |= 0b00001000;					//set preload mode
		TIMX->CCMR2 &= 0xfc;						//clear CC2S bits for output compare mode
		TIMX->CCER1 = (TIMX->CCER1 & 0xcf) | (Output_Mode<<4);
		TIMX->CCR2H = (u8)(CCR_Value>>8);
 		TIMX->CCR2L = (u8)(CCR_Value);
		TIMX->IER |= 4;								//enable CC2 channel output compare interrupt
		break;
		
		case	3:
		TIMX->CCER2 = TIMX->CCER2 & 0xfe;			//first clear CC3E bit in CCER, then you can modify the CC3S bits in CCMR.
		TIMX->CCMR3 = 0b00000011;					//setup the CC3S bits to reserved value, then you can modify OC3M & OC3PE configurations.
		TIMX->CCMR3 |= OCMP_Mode;
		//TIMX->CCMR3 |= 0b00001000;					//set preload mode
		TIMX->CCMR3 &= 0xfc;						//clear CC3S bits for output compare mode
		TIMX->CCER2 = (TIMX->CCER2 & 0xfc) | Output_Mode;
		TIMX->CCR3H = (u8)(CCR_Value>>8);
 		TIMX->CCR3L = (u8)(CCR_Value);
		TIMX->IER |= 8;								//enable CC2 channel output compare interrupt
		break;
		
		default:
		break;
 	}

}

void TIM2TIM3_PWM_Init(MTIM_TypeDef * TIMX, uc8 CC_Channel, u16 CCR_Value, TIM2TIM3_PWM_Mode PWM_Mode, TIM2TIM3_Output_Mode Output_Mode)
{
	switch(CC_Channel)
	{
		case	1:
		TIMX->CCER1 = TIMX->CCER1 & 0xfe;			//first clear CC1E bit in CCER, then you can modify the CC1S bits in CCMR.
		TIMX->CCMR1 = 0b00000011;					//setup the CC1S bits to reserved value, then you can modify OC1M & OC1PE configurations.
		TIMX->CCMR1 |= PWM_Mode;				//set PWM mode
		TIMX->CCMR1 |= 0b00001000;					//set preload mode
		TIMX->CCMR1 &= 0xfc;						//clear CC1S bits for enable channel output direction
		TIMX->CCER1 = (TIMX->CCER1 & 0xfc) | Output_Mode;
		TIMX->CCR1H = (u8)(CCR_Value>>8);
 		TIMX->CCR1L = (u8)(CCR_Value);
 		//TIMX->CCR1 = CCR_Value;
		//TIMX->IER |= 2;								//enable CC1 channel PWM interrupt
		TIMX->IER &= ~2;								//disable CC1 channel PWM interrupt
		break;
		
		case	2:
		TIMX->CCER1 = TIMX->CCER1 & 0xef;			//first clear CC2E bit in CCER, then you can modify the CC2S bits in CCMR.
		TIMX->CCMR2 = 0b00000011;					//setup the CC2S bits to reserved value, then you can modify OC2M & OC2PE configurations.
		TIMX->CCMR2 |= PWM_Mode;
		TIMX->CCMR2 |= 0b00001000;					//set preload mode
		TIMX->CCMR2 &= 0xfc;						//clear CC2S bits for output compare mode
		TIMX->CCER1 = (TIMX->CCER1 & 0xcf) | (Output_Mode<<4);
		TIMX->CCR2H = (u8)(CCR_Value>>8);
 		TIMX->CCR2L = (u8)(CCR_Value);
		//TIMX->IER |= 4;								//enable CC2 channel PWM interrupt
		TIMX->IER &= ~4;								//disable CC2 channel PWM interrupt
		break;
		
		case	3:
		TIMX->CCER2 = TIMX->CCER2 & 0xfe;			//first clear CC3E bit in CCER, then you can modify the CC3S bits in CCMR.
		TIMX->CCMR3 = 0b00000011;					//setup the CC3S bits to reserved value, then you can modify OC3M & OC3PE configurations.
		TIMX->CCMR3 |= PWM_Mode;
		TIMX->CCMR3 |= 0b00001000;					//set preload mode
		TIMX->CCMR3 &= 0xfc;						//clear CC3S bits for output compare mode
		TIMX->CCER2 = (TIMX->CCER2 & 0xfc) | Output_Mode;
		TIMX->CCR3H = (u8)(CCR_Value>>8);
 		TIMX->CCR3L = (u8)(CCR_Value);
		//TIMX->IER |= 8;								//enable CC3 channel PWM interrupt
		TIMX->IER &= ~8;								//disable CC3 channel PWM interrupt
		break;
		
		default:
		break;
 	}

}

void TIM2TIM3_CCR_WRITE(MTIM_TypeDef * TIMX, uc8 CC_Channel,   u16 CCR_Value)
{
	switch(CC_Channel)
	{
		case 	1:
		TIMX->CCR1H = (u8)(CCR_Value>>8);
 		TIMX->CCR1L = (u8)(CCR_Value);
		break;
		case 	2:
		TIMX->CCR2H = (u8)(CCR_Value>>8);
 		TIMX->CCR2L = (u8)(CCR_Value);
		break;
		case 	3:
		TIMX->CCR3H = (u8)(CCR_Value>>8);
 		TIMX->CCR3L = (u8)(CCR_Value);
		break;
		
		default:
		break;
	}
}

void TIM2TIM3_Clear_IT_Flag(MTIM_TypeDef * TIMX, TIM2TIM3_IT_Flag Flag_F)
{
	TIMX->SR1 &= (~Flag_F) ;
	TIMX->SR2 = 0;				//not handle the overcapture event, clear all of the overcapture flag
}

void TIM2TIM3_Enable_IT(MTIM_TypeDef * TIMX, TIM2TIM3_Enable_IT_Bit IE_Bit)
{
	TIMX->IER |= IE_Bit;
}

void TIM2TIM3_Disable_IT(MTIM_TypeDef * TIMX, TIM2TIM3_Enable_IT_Bit IE_Bit)
{
	TIMX->IER &= (~IE_Bit);
}
