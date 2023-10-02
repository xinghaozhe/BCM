/**
  ******************************************************************************
  * @file stm8_itc.h
  * @brief This file contains all functions prototype and macros for the ITC peripheral.
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
#ifndef __STM8_ITC_H__
#define __STM8_ITC_H__

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"

/* Exported types ------------------------------------------------------------*/

/** @addtogroup ITC_Exported_Types
  * @{
  */

/**
  * @brief ITC Interrupt Lines selection
  */
typedef enum {
  TLI_IRQ_N         = (u8)0,
  AWU_IRQ_N         = (u8)1,
  CLK_IRQ_N         = (u8)2,
  PORTA_IRQ_N       = (u8)3,
  PORTB_IRQ_N       = (u8)4,
  PORTC_IRQ_N       = (u8)5,
  PORTD_IRQ_N       = (u8)6,
  PORTE_IRQ_N       = (u8)7,
  CAN_RX_IRQ_N      = (u8)8,
  CAN_TX_IRQ_N      = (u8)9,
  SPI_IRQ_N         = (u8)10,
  TIM1_OVF_IRQ_N    = (u8)11,
  TIM1_CAPCOM_IRQ_N = (u8)12,
  TIM2_OVF_IRQ_N    = (u8)13,
  TIM2_CAPCOM_IRQ_N = (u8)14,
  TIM3_OVF_IRQ_N    = (u8)15,
  TIM3_CAPCOM_IRQ_N = (u8)16,
  USART_TX_IRQ_N    = (u8)17,
  USART_RX_IRQ_N    = (u8)18,
  I2C_IRQ_N         = (u8)19,
  LINUART_TX_IRQ_N  = (u8)20,
  LINUART_RX_IRQ_N  = (u8)21,
  ADC_IRQ_N         = (u8)22,
  TIM4_OVF_IRQ_N    = (u8)23,
  EEPROM_EEC_IRQ_N  = (u8)24
} ITC_IrqNum_TypeDef;

/**
  * @brief ITC Priority Levels selection
  */
typedef enum {
  ITC_PriorityLevel0 = (u8)0x02, /*!< Software priority level 0 (cannot be written) */
  ITC_PriorityLevel1 = (u8)0x01, /*!< Software priority level 1 */
  ITC_PriorityLevel2 = (u8)0x00, /*!< Software priority level 2 */
  ITC_PriorityLevel3 = (u8)0x03  /*!< Software priority level 3 */
} ITC_PriorityLevel_TypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/

/** @addtogroup ITC_Exported_Constants
  * @{
  */

#define CPU_SOFT_INT_DISABLED ((u8)0x28) /*!< Mask for I1 and I0 bits in CPU_CC register */

/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/

/**
  * @brief Macros used by the assert function in order to check the different functions parameters.
  * @addtogroup ITC_Private_Macros
  * @{
  */

/* Used by assert function */
#define IS_ITC_IRQ_NUM_OK(IrqNum) ((IrqNum) <= (u8)24)

/* Used by assert function */
#define IS_ITC_PRIORITY_VALUE_OK(PriorityValue) \
  (((PriorityValue) == ITC_PriorityLevel0) || \
   ((PriorityValue) == ITC_PriorityLevel1) || \
   ((PriorityValue) == ITC_PriorityLevel2) || \
   ((PriorityValue) == ITC_PriorityLevel3))

/* Used by assert function */
#define IS_ITC_INTERRUPTS_DISABLED (ITC_GetSoftIntStatus() == CPU_SOFT_INT_DISABLED)

/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup ITC_Exported_Functions
  * @{
  */

u8 ITC_GetCPUCC(void);
void ITC_DeInit(void);
u8 ITC_GetSoftIntStatus(void);
void ITC_SetSoftwarePriority(ITC_IrqNum_TypeDef IrqNum, ITC_PriorityLevel_TypeDef PriorityValue);
ITC_PriorityLevel_TypeDef ITC_GetSoftwarePriority(ITC_IrqNum_TypeDef IrqNum);

/**
  * @}
  */

#endif /* __STM8_ITC_H__ */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
