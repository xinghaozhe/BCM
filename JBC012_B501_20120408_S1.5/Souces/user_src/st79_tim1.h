#ifndef __ST79_TIMER1_H
#define __ST79_TIMER1_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"

void TIM1_Counter_Cycle_OVIE_init(HTIM_TypeDef* TIMX, u16 ARR_Data);

#endif			//__ST79_TIMER1_H

