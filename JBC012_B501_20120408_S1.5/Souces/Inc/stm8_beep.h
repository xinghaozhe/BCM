/**
  ******************************************************************************
  * @file stm8_beep.h
  * @brief This file contains all functions prototype and macros for the BEEP peripheral.
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
#ifndef __STM8_BEEP_H
#define __STM8_BEEP_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"
#include "stm8_tim3.h"
#include "stm8_clk.h"

/* Exported types ------------------------------------------------------------*/

/** @addtogroup BEEP_Exported_Types
  * @{
  */

/** BEEP Frequency selection */
typedef enum {
  BEEP_FREQ_1KHZ = (u8)0x00, /*!< Beep signal output frequency equals to 1 KHz */
  BEEP_FREQ_2KHZ = (u8)0x40, /*!< Beep signal output frequency equals to 2 KHz */
  BEEP_FREQ_4KHZ = (u8)0x80  /*!< Beep signal output frequency equals to 4 KHz */
} BEEP_Frequency_TypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/

/** @addtogroup BEEP_Exported_Constants
  * @{
  */

#define BEEP_CALIBRATION_DEFAULT ((u8)0x0B) /*!< Default value when calibration is not done */

#define LSI_FREQ_MIN ((u32)100000) /*!< LSI minimum value in Hertz */
#define LSI_FREQ_MAX ((u32)200000) /*!< LSI maximum value in Hertz */

/**
  * @}
  */

/* Exported macros ------------------------------------------------------------*/

/* Private macros ------------------------------------------------------------*/

/** @addtogroup BEEP_Private_Macros
  * @{
  */

/** Macro used by the assert function to check the BEEP frequencies */
#define IS_BEEP_FREQ_OK(FREQ) \
  (((FREQ) == BEEP_FREQ_1KHZ) || \
   ((FREQ) == BEEP_FREQ_2KHZ) || \
   ((FREQ) == BEEP_FREQ_4KHZ))

/** Macro used by the assert function to check the LSI frequency (in Hz) */
#define IS_LSI_FREQ_OK(FREQ) (((FREQ) >= LSI_FREQ_MIN) && ((FREQ) <= LSI_FREQ_MAX))

/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup BEEP_Exported_Functions
  * @{
  */

void BEEP_DeInit(void);
void BEEP_LSICalibrationConfig(u32 LSIFreqHz);
ErrorStatus BEEP_AutoLSICalibration(void);
void BEEP_Init(BEEP_Frequency_TypeDef BEEP_Frequency);
void BEEP_Cmd(FunctionalState NewState);

/**
  * @}
  */

/* Exported variables ------------------------------------------------------- */
extern const u8 APR_Array[];
extern const u8 TBR_Array[];

#endif /* __STM8_BEEP_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
