
/* Includes ------------------------------------------------------------------*/
#include "st79_tim1.h"
#include "stm8_clk.h"

void TIM1_Counter_Cycle_OVIE_init(HTIM_TypeDef * TIMX, u16 ARR_Data)
{
	TIMX->CR1 = 0B10000000;		
	TIMX->PSCRH =0;
	TIMX->PSCRL =159;
	TIMX->ARR = ARR_Data;			// set autoreload register 
	//CONTROL REGISTER 1
//	ARPE	CMS	1	CMS0	DIR		OPM		URS		UDIS	CEN
//	1		0		0		0		0		0		0		1
	TIMX->CR2 = 0X00;		//capture/compare register control bits preload selection
	TIMX->SMCR = 0X00;
  	TIMX->ETR = 0X00;
	
	
	
	
}


