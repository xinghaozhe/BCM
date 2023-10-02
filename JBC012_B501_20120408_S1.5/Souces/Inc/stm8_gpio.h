/**
  ******************************************************************************
  * @file stm8_gpio.h
  * @brief This file contains all functions prototype and macros for the GPIO peripheral.
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
#ifndef __STM8_GPIO_H
#define __STM8_GPIO_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"

/* Exported constants --------------------------------------------------------*/

/** @addtogroup GPIO_Exported_Constants
  * @{
  */

//#define GPIO_PIN_0    ((u8)0x01) /*!< Pin 0 selected */
//#define GPIO_PIN_1    ((u8)0x02) /*!< Pin 1 selected */
//#define GPIO_PIN_2    ((u8)0x04) /*!< Pin 2 selected */
//#define GPIO_PIN_3    ((u8)0x08) /*!< Pin 3 selected */
//#define GPIO_PIN_4    ((u8)0x10) /*!< Pin 4 selected */
//#define GPIO_PIN_5    ((u8)0x20) /*!< Pin 5 selected */
//#define GPIO_PIN_6    ((u8)0x40) /*!< Pin 6 selected */
//#define GPIO_PIN_7    ((u8)0x80) /*!< Pin 7 selected */
//#define GPIO_PIN_LNIB ((u8)0x0F) /*!< Low nibble pins selected */
//#define GPIO_PIN_HNIB ((u8)0xF0) /*!< High nibble pins selected */
//#define GPIO_PIN_ALL  ((u8)0xFF) /*!< All pins selected */
 
#define GPIO_Pin_0    ((u8)0x01) /*!< Pin 0 selected */
#define GPIO_Pin_1    ((u8)0x02) /*!< Pin 1 selected */
#define GPIO_Pin_2    ((u8)0x04) /*!< Pin 2 selected */
#define GPIO_Pin_3    ((u8)0x08) /*!< Pin 3 selected */
#define GPIO_Pin_4    ((u8)0x10) /*!< Pin 4 selected */
#define GPIO_Pin_5    ((u8)0x20) /*!< Pin 5 selected */
#define GPIO_Pin_6    ((u8)0x40) /*!< Pin 6 selected */
#define GPIO_Pin_7    ((u8)0x80) /*!< Pin 7 selected */
#define GPIO_Pin_Lnib ((u8)0x0F) /*!< Low nibble pins selected */
#define GPIO_Pin_Hnib ((u8)0xF0) /*!< High nibble pins selected */
#define GPIO_Pin_All  ((u8)0xFF) /*!< All pins selected */

/**
  * @}
  */

/* Exported types ------------------------------------------------------------*/

/** @addtogroup GPIO_Exported_Types
  * @{
  */

/** GPIO modes */
typedef enum
{
  /*
  Bits definitions:
  - Bit 7: 0 = INPUT mode
           1 = OUTPUT mode
  - Bit 6: 0 = FLOAT (input) or OPEN-DRAIN (output)
           1 = PULL-UP (input) or PUSH-PULL (output)
  - Bit 5: 0 = No external interrupt (input) or No slope control (output)
           1 = External interrupt (input) or Slow control enabled (output)
  - Bit 4: 0 = Low level (output)
           1 = High level (output push-pull) or HI-Z (output open-drain)
  */
  GPIO_MODE_IN_FL_NO_IT      = (u8)0b00000000, /*!< Input floating, no external interrupt */
  GPIO_MODE_IN_PU_NO_IT      = (u8)0b01000000, /*!< Input pull-up, no external interrupt */
  GPIO_MODE_IN_FL_IT         = (u8)0b00100000, /*!< Input floating, external interrupt */
  GPIO_MODE_IN_PU_IT         = (u8)0b01100000, /*!< Input pull-up, external interrupt */
  GPIO_MODE_OUT_OD_LOW_FAST  = (u8)0b10000000, /*!< Output open-drain, low level, no slope control */
  GPIO_MODE_OUT_PP_LOW_FAST  = (u8)0b11000000, /*!< Output push-pull, low level, no slope control */
  GPIO_MODE_OUT_OD_LOW_SLOW  = (u8)0b10100000, /*!< Output open-drain, low level, slow slope */
  GPIO_MODE_OUT_PP_LOW_SLOW  = (u8)0b11100000, /*!< Output push-pull, low level, slow slope */
  GPIO_MODE_OUT_OD_HIZ_FAST  = (u8)0b10010000, /*!< Output open-drain, high-impedance level, no slope control */
  GPIO_MODE_OUT_PP_HIGH_FAST = (u8)0b11010000, /*!< Output push-pull, high level, no slope control */
  GPIO_MODE_OUT_OD_HIZ_SLOW  = (u8)0b10110000, /*!< Output open-drain, high-impedance level, slow slope */
  GPIO_MODE_OUT_PP_HIGH_SLOW = (u8)0b11110000  /*!< Output push-pull, high level, slow slope */
}
GPIO_Mode_TypeDef;

/** GPIO Init structure definition */
typedef struct
{
  u8 GPIO_Pin;
  GPIO_Mode_TypeDef GPIO_Mode;
}
GPIO_Init_TypeDef;

/**
  * @}
  */

/* Exported macros -----------------------------------------------------------*/

/* Private macros ------------------------------------------------------------*/

/** @addtogroup GPIO_Private_Macros
  * @{
  */

/** Macro used by the assert function in order to check the different
    values of GPIOMode_TypeDef */
#define IS_GPIO_MODE_OK(MODE) (((MODE) == GPIO_MODE_IN_FL_NO_IT) || \
                               ((MODE) == GPIO_MODE_IN_PU_NO_IT) || \
                               ((MODE) == GPIO_MODE_IN_FL_IT) || \
                               ((MODE) == GPIO_MODE_IN_PU_IT) || \
                               ((MODE) == GPIO_MODE_OUT_OD_LOW_FAST) || \
                               ((MODE) == GPIO_MODE_OUT_PP_LOW_FAST) || \
                               ((MODE) == GPIO_MODE_OUT_OD_LOW_SLOW) || \
                               ((MODE) == GPIO_MODE_OUT_PP_LOW_SLOW) || \
                               ((MODE) == GPIO_MODE_OUT_OD_HIZ_FAST) || \
                               ((MODE) == GPIO_MODE_OUT_PP_HIGH_FAST) || \
                               ((MODE) == GPIO_MODE_OUT_OD_HIZ_SLOW) || \
                               ((MODE) == GPIO_MODE_OUT_PP_HIGH_SLOW))

/** Macro used by the assert function in order to check the different
    values of GPIO_Pins */
#define IS_GPIO_PIN_OK(PIN) ((((PIN) & (u8)0x00) == (u8)0x00) && ((PIN) != (u8)0x00))

/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup GPIO_Exported_Functions
  * @{
  */

void GPIO_DeInit(GPIO_TypeDef* GPIOx);
void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Init_TypeDef* GPIO_InitStruct);
void GPIO_StructInit(GPIO_Init_TypeDef* GPIO_InitStruct);
void GPIO_Write(GPIO_TypeDef* GPIOx, u8 PortVal);
void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, u8 PortPins);
void GPIO_WriteLow(GPIO_TypeDef* GPIOx, u8 PortPins);
void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, u8 PortPins);
u8 GPIO_ReadInputData(GPIO_TypeDef* GPIOx);
u8 GPIO_ReadOutputData(GPIO_TypeDef* GPIOx);

/**
  * @}
  */

#endif /* __STM8_GPIO_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
