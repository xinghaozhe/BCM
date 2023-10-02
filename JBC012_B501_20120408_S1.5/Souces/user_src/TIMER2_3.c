
/* Includes ------------------------------------------------------------------*/
#include "TIMER2_3.h"
#include "stm8_clk.h"


void TIM2_Counter_Cycle_OVIE_init(u16 ARR_Data)
{	
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);

 	TIM2->CR1 |= 0X80; 				//set preload mode
  	TIM2->PSCR = 4; 					//set prescaler
  	TIM2->ARRH = (u8)(ARR_Data>>8);
  	TIM2->ARRL = (u8)ARR_Data;  
  	TIM2->CNTRH = 0;
 	TIM2->CNTRL = 10; 
 	//TIM2->CNTR = 10;  
  	TIM2->IER = 1; 
  	TIM2->SR1 &= ~1; 
  	TIM2->CR1 |= 1;
			//enable TIM2*/
}


void TIM3_Counter_Cycle_OVIE_init(u16 ARR_Data)
{	
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER3, ENABLE);

 	TIM3->CR1 |= 0X80; 				//set preload mode
  	TIM3->PSCR = 4; 					//set prescaler
  	TIM3->ARRH = (u8)(ARR_Data>>8);
  	TIM3->ARRL = (u8)ARR_Data;  
  	TIM3->CNTRH = 0;
 	TIM3->CNTRL = 10; 
 	//TIM3->CNTR = 10;  
  	TIM3->IER = 1; 
  	TIM3->SR1 &= ~1; 
  	TIM3->CR1 |= 1;
			//enable TIM3*/
}

/////////////////////////////////////////////////////////////////////////////////////////////////
void TIM2_OCMP_Init(uc8 CC_Channel, u16 CCR_Value, TIM2TIM3_OCMP_Mode OCMP_Mode, TIM2TIM3_Output_Mode Output_Mode)
{						// disable TIM2CCR register preload 
	switch(CC_Channel)
	{
		case	1:
		TIM2->CCER1 = TIM2->CCER1 & 0xfe;			//first clear CC1E bit in CCER, then you can modify the CC1S bits in CCMR.
		TIM2->CCMR1 = 0b00000011;					//setup the CC1S bits to reserved value, then you can modify OC1M & OC1PE configurations.
		TIM2->CCMR1 |= OCMP_Mode;				//set output compare mode
		//TIM2->CCMR1 |= 0b00001000;					//set preload mode
		TIM2->CCMR1 &= 0xfc;						//clear CC1S bits for enable channel output direction
		TIM2->CCER1 = (TIM2->CCER1 & 0xfc) | Output_Mode;
		TIM2->CCR1H = (u8)(CCR_Value>>8);
 		TIM2->CCR1L = (u8)(CCR_Value);
 		//TIM2->CCR1 = CCR_Value;
		TIM2->IER |= 2;								//enable CC1 channel output compare interrupt
		break;
		
		case	2:
		TIM2->CCER1 = TIM2->CCER1 & 0xef;			//first clear CC2E bit in CCER, then you can modify the CC2S bits in CCMR.
		TIM2->CCMR2 = 0b00000011;					//setup the CC2S bits to reserved value, then you can modify OC2M & OC2PE configurations.
		TIM2->CCMR2 |= OCMP_Mode;
		//TIM2->CCMR2 |= 0b00001000;					//set preload mode
		TIM2->CCMR2 &= 0xfc;						//clear CC2S bits for output compare mode
		TIM2->CCER1 = (TIM2->CCER1 & 0xcf) | (Output_Mode<<4);
		TIM2->CCR2H = (u8)(CCR_Value>>8);
 		TIM2->CCR2L = (u8)(CCR_Value);
		TIM2->IER |= 4;								//enable CC2 channel output compare interrupt
		break;
		
		case	3:
		TIM2->CCER2 = TIM2->CCER2 & 0xfe;			//first clear CC3E bit in CCER, then you can modify the CC3S bits in CCMR.
		TIM2->CCMR3 = 0b00000011;					//setup the CC3S bits to reserved value, then you can modify OC3M & OC3PE configurations.
		TIM2->CCMR3 |= OCMP_Mode;
		//TIM2->CCMR3 |= 0b00001000;					//set preload mode
		TIM2->CCMR3 &= 0xfc;						//clear CC3S bits for output compare mode
		TIM2->CCER2 = (TIM2->CCER2 & 0xfc) | Output_Mode;
		TIM2->CCR3H = (u8)(CCR_Value>>8);
 		TIM2->CCR3L = (u8)(CCR_Value);
		TIM2->IER |= 8;								//enable CC2 channel output compare interrupt
		break;
		
		default:
		break;
 	}

}

void TIM3_OCMP_Init(uc8 CC_Channel, u16 CCR_Value, TIM2TIM3_OCMP_Mode OCMP_Mode, TIM2TIM3_Output_Mode Output_Mode)
{						// disable TIM3CCR register preload 
	switch(CC_Channel)
	{
		case	1:
		TIM3->CCER1 = TIM3->CCER1 & 0xfe;			//first clear CC1E bit in CCER, then you can modify the CC1S bits in CCMR.
		TIM3->CCMR1 = 0b00000011;					//setup the CC1S bits to reserved value, then you can modify OC1M & OC1PE configurations.
		TIM3->CCMR1 |= OCMP_Mode;				//set output compare mode
		//TIM3->CCMR1 |= 0b00001000;					//set preload mode
		TIM3->CCMR1 &= 0xfc;						//clear CC1S bits for enable channel output direction
		TIM3->CCER1 = (TIM3->CCER1 & 0xfc) | Output_Mode;
		TIM3->CCR1H = (u8)(CCR_Value>>8);
 		TIM3->CCR1L = (u8)(CCR_Value);
 		//TIM3->CCR1 = CCR_Value;
		TIM3->IER |= 2;								//enable CC1 channel output compare interrupt
		break;
		
		case	2:
		TIM3->CCER1 = TIM3->CCER1 & 0xef;			//first clear CC2E bit in CCER, then you can modify the CC2S bits in CCMR.
		TIM3->CCMR2 = 0b00000011;					//setup the CC2S bits to reserved value, then you can modify OC2M & OC2PE configurations.
		TIM3->CCMR2 |= OCMP_Mode;
		//TIM3->CCMR2 |= 0b00001000;					//set preload mode
		TIM3->CCMR2 &= 0xfc;						//clear CC2S bits for output compare mode
		TIM3->CCER1 = (TIM3->CCER1 & 0xcf) | (Output_Mode<<4);
		TIM3->CCR2H = (u8)(CCR_Value>>8);
 		TIM3->CCR2L = (u8)(CCR_Value);
		TIM3->IER |= 4;								//enable CC2 channel output compare interrupt
		break;
		
		
		default:
		break;
 	}

}

//////////////////////////////////////////////////////////////////////////////////////////

void TIM2_PWM_Init(uc8 CC_Channel, u16 CCR_Value, TIM2TIM3_PWM_Mode PWM_Mode, TIM2TIM3_Output_Mode Output_Mode)
{
	switch(CC_Channel)
	{
		case	1:
		TIM2->CCER1 = TIM2->CCER1 & 0xfe;			//first clear CC1E bit in CCER, then you can modify the CC1S bits in CCMR.
		TIM2->CCMR1 = 0b00000011;					//setup the CC1S bits to reserved value, then you can modify OC1M & OC1PE configurations.
		TIM2->CCMR1 |= PWM_Mode;				//set PWM mode
		TIM2->CCMR1 |= 0b00001000;					//set preload mode
		TIM2->CCMR1 &= 0xfc;						//clear CC1S bits for enable channel output direction
		TIM2->CCER1 = (TIM2->CCER1 & 0xfc) | Output_Mode;
		TIM2->CCR1H = (u8)(CCR_Value>>8);
 		TIM2->CCR1L = (u8)(CCR_Value);
 		//TIM2->CCR1 = CCR_Value;
		//TIM2->IER |= 2;								//enable CC1 channel PWM interrupt
		TIM2->IER &= ~2;								//disable CC1 channel PWM interrupt
		break;
		
		case	2:
		TIM2->CCER1 = TIM2->CCER1 & 0xef;			//first clear CC2E bit in CCER, then you can modify the CC2S bits in CCMR.
		TIM2->CCMR2 = 0b00000011;					//setup the CC2S bits to reserved value, then you can modify OC2M & OC2PE configurations.
		TIM2->CCMR2 |= PWM_Mode;
		TIM2->CCMR2 |= 0b00001000;					//set preload mode
		TIM2->CCMR2 &= 0xfc;						//clear CC2S bits for output compare mode
		TIM2->CCER1 = (TIM2->CCER1 & 0xcf) | (Output_Mode<<4);
		TIM2->CCR2H = (u8)(CCR_Value>>8);
 		TIM2->CCR2L = (u8)(CCR_Value);
		//TIM2->IER |= 4;								//enable CC2 channel PWM interrupt
		TIM2->IER &= ~4;								//disable CC2 channel PWM interrupt
		break;
		
		case	3:
		TIM2->CCER2 = TIM2->CCER2 & 0xfe;			//first clear CC3E bit in CCER, then you can modify the CC3S bits in CCMR.
		TIM2->CCMR3 = 0b00000011;					//setup the CC3S bits to reserved value, then you can modify OC3M & OC3PE configurations.
		TIM2->CCMR3 |= PWM_Mode;
		TIM2->CCMR3 |= 0b00001000;					//set preload mode
		TIM2->CCMR3 &= 0xfc;						//clear CC3S bits for output compare mode
		TIM2->CCER2 = (TIM2->CCER2 & 0xfc) | Output_Mode;
		TIM2->CCR3H = (u8)(CCR_Value>>8);
 		TIM2->CCR3L = (u8)(CCR_Value);
		//TIM2->IER |= 8;								//enable CC3 channel PWM interrupt
		TIM2->IER &= ~8;								//disable CC3 channel PWM interrupt
		break;
		
		default:
		break;
 	}

}

void TIM3_PWM_Init(uc8 CC_Channel, u16 CCR_Value, TIM2TIM3_PWM_Mode PWM_Mode, TIM2TIM3_Output_Mode Output_Mode)
{
	switch(CC_Channel)
	{
		case	1:
		TIM3->CCER1 = TIM3->CCER1 & 0xfe;			//first clear CC1E bit in CCER, then you can modify the CC1S bits in CCMR.
		TIM3->CCMR1 = 0b00000011;					//setup the CC1S bits to reserved value, then you can modify OC1M & OC1PE configurations.
		TIM3->CCMR1 |= PWM_Mode;				//set PWM mode
		TIM3->CCMR1 |= 0b00001000;					//set preload mode
		TIM3->CCMR1 &= 0xfc;						//clear CC1S bits for enable channel output direction
		TIM3->CCER1 = (TIM3->CCER1 & 0xfc) | Output_Mode;
		TIM3->CCR1H = (u8)(CCR_Value>>8);
 		TIM3->CCR1L = (u8)(CCR_Value);
 		//TIM3->CCR1 = CCR_Value;
		//TIM3->IER |= 2;								//enable CC1 channel PWM interrupt
		TIM3->IER &= ~2;								//disable CC1 channel PWM interrupt
		break;
		
		case	2:
		TIM3->CCER1 = TIM3->CCER1 & 0xef;			//first clear CC2E bit in CCER, then you can modify the CC2S bits in CCMR.
		TIM3->CCMR2 = 0b00000011;					//setup the CC2S bits to reserved value, then you can modify OC2M & OC2PE configurations.
		TIM3->CCMR2 |= PWM_Mode;
		TIM3->CCMR2 |= 0b00001000;					//set preload mode
		TIM3->CCMR2 &= 0xfc;						//clear CC2S bits for output compare mode
		TIM3->CCER1 = (TIM3->CCER1 & 0xcf) | (Output_Mode<<4);
		TIM3->CCR2H = (u8)(CCR_Value>>8);
 		TIM3->CCR2L = (u8)(CCR_Value);
		//TIM3->IER |= 4;								//enable CC2 channel PWM interrupt
		TIM3->IER &= ~4;								//disable CC2 channel PWM interrupt
		break;
		
		
		default:
		break;
 	}

}

//////////////////////////////////////////////////////////////////////////////////////////

void TIM2_CCR_WRITE( uc8 CC_Channel,   u16 CCR_Value)
{
	switch(CC_Channel)
	{
		case 	1:
		TIM2->CCR1H = (u8)(CCR_Value>>8);
 		TIM2->CCR1L = (u8)(CCR_Value);
		break;
		case 	2:
		TIM2->CCR2H = (u8)(CCR_Value>>8);
 		TIM2->CCR2L = (u8)(CCR_Value);
		break;
		case 	3:
		TIM2->CCR3H = (u8)(CCR_Value>>8);
 		TIM2->CCR3L = (u8)(CCR_Value);
		break;
		
		default:break;
		break;
	}
}

void TIM3_CCR_WRITE(uc8 CC_Channel,   u16 CCR_Value)
{
	switch(CC_Channel)
	{
		case 	1:
		TIM3->CCR1H = (u8)(CCR_Value>>8);
 		TIM3->CCR1L = (u8)(CCR_Value);
		break;
		case 	2:
		TIM3->CCR2H = (u8)(CCR_Value>>8);
 		TIM3->CCR2L = (u8)(CCR_Value);
		break;
		
		default:
		break;
	}
}

//////////////////////////////////////////////////////////////////////////////////////////

void TIM2_Clear_IT_Flag(TIM2TIM3_IT_Flag Flag_F)
{
	TIM2->SR1 &= (~Flag_F) ;
	TIM2->SR2 = 0;				//not handle the overcapture event, clear all of the overcapture flag
}

void TIM3_Clear_IT_Flag(TIM2TIM3_IT_Flag Flag_F)
{
	TIM3->SR1 &= (~Flag_F) ;
	TIM3->SR2 = 0;				//not handle the overcapture event, clear all of the overcapture flag
}

//////////////////////////////////////////////////////////////////////////////////////////

void TIM2_Enable_IT(TIM2TIM3_Enable_IT_Bit IE_Bit)
{
	TIM2->IER |= IE_Bit;
}

void TIM3_Enable_IT(TIM2TIM3_Enable_IT_Bit IE_Bit)
{
	TIM3->IER |= IE_Bit;
}

//////////////////////////////////////////////////////////////////////////////////////////

void TIM2_Disable_IT( TIM2TIM3_Enable_IT_Bit IE_Bit)
{
	TIM2->IER &= (~IE_Bit);
}
void TIM3_Disable_IT(TIM2TIM3_Enable_IT_Bit IE_Bit)
{
	TIM3->IER &= (~IE_Bit);
}

