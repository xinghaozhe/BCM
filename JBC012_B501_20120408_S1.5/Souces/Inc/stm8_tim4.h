/**
  ******************************************************************************
  * @file stm8_tim4.h
  * @brief This file contains all functions prototype and macros for the TIM4 peripheral.
  * @author STMicroelectronics
  * @version V0.04
  * @date 21-DEC-2007
  ******************************************************************************
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2007 STMicroelectronics</center></h2>
  * @image html logo.bmp
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM8_TIM4_H
#define __STM8_TIM4_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"

/* Exported types ------------------------------------------------------------*/

/** @addtogroup TIM4_Exported_Types
  * @{
  */

/** TIM4 Time Base Init structure definition */
typedef struct
{
    u8 TIM4_Prescaler;
    u8 TIM4_Period;
    
} TIM4_TimeBaseInit_TypeDef;

/** TIM4 Output Compare Init structure definition */
typedef struct
{
    u8 TIM4_OCMode;
    u8 TIM4_OutputState;
    u16 TIM4_Pulse;
    u8 TIM4_OCPolarity;
} TIM4_OCInit_TypeDef;

/** TIM4 Input Capture Init structure definition */
typedef struct
{
    u8 TIM4_Channel;
    u8 TIM4_ICPolarity;
    u8 TIM4_ICSelection;
    u8 TIM4_ICPrescaler;
    u8 TIM4_ICFilter;
} TIM4_ICInit_TypeDef;

/** TIM4 Forced Action */
typedef enum
{
 TIM4_FORCEDACTION_ACTIVE           =((u8)0x50),
 TIM4_FORCEDACTION_INACTIVE         =((u8)0x40)
} TIM4_ForcedAction_TypeDef;

#define IS_TIM4_FORCED_ACTION_OK(ACTION) (((ACTION) == TIM4_FORCEDACTION_ACTIVE) || \
                                          ((ACTION) == TIM4_FORCEDACTION_INACTIVE))

/** TIM4 Prescaler */
typedef enum
{
  TIM4_PRESCALER_1		=((u8)0x00),
  TIM4_PRESCALER_2   	=((u8)0x01),
  TIM4_PRESCALER_4   	=((u8)0x02),
  TIM4_PRESCALER_8	   	=((u8)0x03),
  TIM4_PRESCALER_16  	=((u8)0x04),
  TIM4_PRESCALER_32    	=((u8)0x05),
  TIM4_PRESCALER_64   	=((u8)0x06),
  TIM4_PRESCALER_128  	=((u8)0x07)
} TIM4_Prescaler_TypeDef;

#define IS_TIM4_PRESCALER_OK(PRESCALER) (((PRESCALER) == TIM4_PRESCALER_1		) || \
							   ((PRESCALER) == TIM4_PRESCALER_2   	) || \
							   ((PRESCALER) == TIM4_PRESCALER_4   	) || \
							   ((PRESCALER) == TIM4_PRESCALER_8		) || \
							   ((PRESCALER) == TIM4_PRESCALER_16  	) || \
							   ((PRESCALER) == TIM4_PRESCALER_32    	) || \
							   ((PRESCALER) == TIM4_PRESCALER_64   	) || \
							   ((PRESCALER) == TIM4_PRESCALER_128  	) )

/** TIM4 One Pulse Mode */
typedef enum
{
 TIM4_OPMODE_SINGLE                 =((u8)0x01),
 TIM4_OPMODE_REPETITIVE             =((u8)0x00)
} TIM4_OPMode_TypeDef;

#define IS_TIM4_OPM_MODE_OK(MODE) (((MODE) == TIM4_OPMODE_SINGLE) || \
                                   ((MODE) == TIM4_OPMODE_REPETITIVE))

/** TIM4 Prescaler Reload Mode */
typedef enum
{
 TIM4_PSCRELOADMODE_UPDATE          =((u8)0x00),
 TIM4_PSCRELOADMODE_IMMEDIATE       =((u8)0x01)
} TIM4_PSCReloadMode_TypeDef;

#define IS_TIM4_PRESCALER_RELOAD_OK(RELOAD) (((RELOAD) == TIM4_PSCRELOADMODE_UPDATE) || \
                                             ((RELOAD) == TIM4_PSCRELOADMODE_IMMEDIATE))

/** TIM4 Update Source */
typedef enum
{
 TIM4_UPDATESOURCE_GLOBAL           =((u8)0x00),
 TIM4_UPDATESOURCE_REGULAR          =((u8)0x01)
} TIM4_UpdateSource_TypeDef;

#define IS_TIM4_UPDATE_SOURCE_OK(SOURCE) (((SOURCE) == TIM4_UPDATESOURCE_GLOBAL) || \
                                          ((SOURCE) == TIM4_UPDATESOURCE_REGULAR))

/** TIM4 Event Source */
#define  TIM4_EVENTSOURCE_UPDATE            ((u8)0x01)

/** TIM4 Flags */
#define TIM4_FLAG_UPDATE              ((u8)0x01)

/** TIM4 interrupt sources */
#define TIM4_IT_UPDATE            ((u8)0x01)

/**
  * @}
  */

/* Exported macro ------------------------------------------------------------*/

/* Exported functions --------------------------------------------------------*/

/** @addtogroup TIM4_Exported_Functions
  * @{
  */

void TIM4_DeInit(void);
void TIM4_TimeBaseInit(TIM4_TimeBaseInit_TypeDef* TIM4_TimeBaseInitStruct);
void TIM4_TimeBaseStructInit(TIM4_TimeBaseInit_TypeDef* TIM4_TimeBaseInitStruct);
void TIM4_Cmd(FunctionalState NewState);
void TIM4_UpdateITConfig(FunctionalState NewState);
void TIM4_UpdateDisableConfig(FunctionalState Newstate);
void TIM4_UpdateRequestConfig(u8 TIM4_UpdateSource);
void TIM4_SelectOnePulseMode(u8 TIM4_OPMode);
void TIM4_PrescalerConfig(u8 Prescaler, u8 TIM4_PSCReloadMode);
void TIM4_ARRPreloadConfig(FunctionalState Newstate);
void TIM4_GenerateUpdateEvent(void);
void TIM4_SetCounter(u8 Counter);
void TIM4_SetAutoreload(u8 Autoreload);
u8 TIM4_GetCounter(void);
u8 TIM4_GetPrescaler(void);
FlagStatus TIM4_GetUpdateFlagStatus(void);
void TIM4_ClearUpdateFlag(void);
ITStatus TIM4_GetUpdateITStatus(void);
void TIM4_ClearUpdateITPendingBit(void);

/**
  * @}
  */

#endif /* __STM8_TIM4_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
