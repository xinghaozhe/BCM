#ifndef __ST79_TIMER23_H
#define __ST79_TIMER23_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"

typedef enum
{
 TIF		= 0b01000000,
 CC3IF	= 0b00001000,
 CC2IF	= 0b00000100,
 CC1IF 	= 0b00000010,
 UIF		= 0b00000001
}TIM2TIM3_IT_Flag;

typedef enum
{
 AllOff	= 0xff,
 TIE		= 0b01000000,
 CC3IE	= 0b00001000,
 CC2IE	= 0b00000100,
 CC1IE 	= 0b00000010,
 UIE		= 0b00000001
}TIM2TIM3_Enable_IT_Bit;

typedef enum
{
 Frozen		= 0b00000000,
 Active_High	= 0b00010000,
 Active_Low	= 0b00100000,
 Active_Toggle= 0b00110000,
 Force_Low	= 0b01000000,
 Force_High	= 0b01010000 
}TIM2TIM3_OCMP_Mode;

typedef enum
{
 PWM_1		= 0b01100000,
 PWM_2		= 0b01110000
}TIM2TIM3_PWM_Mode;

typedef enum
{
 Output_ActiveHigh		= 0b00000001,
 Output_ActiveLow		= 0b00000011,
 NotOutput_ActiveHigh	= 0b00000000,
 NotOutput_ActiveLow	= 0b00000010
}TIM2TIM3_Output_Mode;

/*//////////////// function protype ////////////////////*/
void TIM2TIM3_Counter_Cycle_OVIE_init(MTIM_TypeDef * TIMX, u16 ARR_Data);
void TIM2TIM3_OCMP_Init(MTIM_TypeDef * TIMX, uc8 CC_Chanel, u16 CCR_Value, TIM2TIM3_OCMP_Mode OCMP_Mode, TIM2TIM3_Output_Mode Output_Mode);
void TIM2TIM3_PWM_Init(MTIM_TypeDef * TIMX, uc8 CC_Chanel, u16 CCR_Value, TIM2TIM3_PWM_Mode PWM_Mode, TIM2TIM3_Output_Mode Output_Mode);
void TIM2TIM3_CCR_WRITE(MTIM_TypeDef * TIMX, uc8 CC_Channel,   u16 CCR_Value);
void TIM2TIM3_Clear_IT_Flag(MTIM_TypeDef * TIMX, TIM2TIM3_IT_Flag Flag_F);
void TIM2TIM3_Enable_IT(MTIM_TypeDef * TIMX, TIM2TIM3_Enable_IT_Bit IE_Bit);
void TIM2TIM3_Disable_IT(MTIM_TypeDef * TIMX, TIM2TIM3_Enable_IT_Bit IE_Bit);

#endif			//__ST79_TIMER23_H

