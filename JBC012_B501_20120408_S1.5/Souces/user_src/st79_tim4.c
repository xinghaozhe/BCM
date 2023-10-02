
/* Includes ------------------------------------------------------------------*/
#include "st79_tim4.h"
#include "stm8_clk.h"

void TIM4_Init(void)	//16Mhz  2mS timebase
{
	//CLK_PCKEN1PeriphClockCmd(CLK_PCKEN1Periph_TIMER4, ENABLE);
	TIM4->PSCR = 0X07;			//128 prescale
	TIM4->ARR = 124;
	TIM4->CR1 = 0X81;			//preload mode & timer4 enable
	TIM4->IER = 0;
	TIM4->SR1 = 0;				//clear interrupt flag
	TIM4->CNTR = 0;
	TIM4->IER = 1;				//enable interrupt

}

void TIM4_Clear_Int_Flag(void)
{
	TIM4->SR1 = 0;
}
