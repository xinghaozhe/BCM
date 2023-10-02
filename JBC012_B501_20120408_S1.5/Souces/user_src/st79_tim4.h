#ifndef __ST79_TIMER4_H
#define __ST79_TIMER4_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"

void TIM4_Init(void);	//16Mhz  2mS timebase
void TIM4_Clear_Int_Flag(void);

#endif			//__ST79_TIMER4_H

