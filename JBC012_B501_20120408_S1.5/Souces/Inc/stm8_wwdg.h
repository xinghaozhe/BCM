/**
  ********************************************************************************
  * @file stm8_wwdg.h
  * @brief This file contains all functions prototype and macros for the WWDG peripheral.
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
#ifndef __STM8_WWDG_H
#define __STM8_WWDG_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"

/* Private macros ------------------------------------------------------------*/

/** @addtogroup WWDG_Private_Macros
  * @{
  */

/**
  * @brief Macro used by the assert function in order to check the
  * values of the window register.
  */
#define IS_WWDG_WINDOWLIMITVALUE_OK(WindowLimitValue) (WindowLimitValue <= 0x7F)

/**
  * @brief Macro used by the assert function in order to check the different
  * values of the counter register.
  */
#define IS_WWDG_COUNTERVALUE_OK(CounterValue) (CounterValue <= 0x7F)

/**
  * @}
  */

/* Exported types ------------------------------------------------------------*/

/* Exported functions ------------------------------------------------------- */

/** @addtogroup WWDG_Exported_Functions
  * @{
  */

void WWDG_Init( u8 ControlValue, u8 WindowLimitValue );
void WWDG_Refresh( u8 CounterValue );
u8 WWDG_GetControlValue(void);
void WWDG_SWReset(void);

/**
  * @}
  */

#endif /* __STM8_WWDG_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
