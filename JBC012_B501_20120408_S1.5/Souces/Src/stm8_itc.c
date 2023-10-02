/**
  ******************************************************************************
  * @file stm8_itc.c
  * @brief This file contains all the functions for the ITC peripheral.
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

/* Includes ------------------------------------------------------------------*/
#include "stm8_itc.h"

/* LINKER SECTIONS DEFINITION FOR THIS FILE ONLY */
#ifdef USE_COSMIC_SECTIONS
#pragma section (ITC_CODE)
#pragma section const {ITC_CONST}
#pragma section @near [ITC_URAM]
#pragma section @near {ITC_IRAM}
#pragma section @tiny [ITC_UZRAM]
#pragma section @tiny {ITC_IZRAM}
#endif

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/

/* Private functions ---------------------------------------------------------*/

/** @addtogroup ITC_Private_Functions
  * @{
  */

/**
  * @brief Utility function used to read CC register.
  * @par Parameters:
  * None
  * @retval u8 Content of CC register (in A register).
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * u8 val;
  * val = ITC_GetCPUCC();
  * @endcode
*/
u8 ITC_GetCPUCC(void)
{
  _asm("push cc");
  _asm("pop a");
  return; /* Ignore compiler warning, the returned value is in A register */
}

/**
  * @}
  */

/* Public functions ----------------------------------------------------------*/

/** @addtogroup ITC_Public_Functions
  * @{
  */

/**
  * @brief Deinitializes the ITC registers to their default reset value.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * ITC_DeInit();
  * @endcode
*/
void ITC_DeInit(void)
{
  ITC->ISPR1 = ITC_SPRX_RESET_VALUE;
  ITC->ISPR2 = ITC_SPRX_RESET_VALUE;
  ITC->ISPR3 = ITC_SPRX_RESET_VALUE;
  ITC->ISPR4 = ITC_SPRX_RESET_VALUE;
  ITC->ISPR5 = ITC_SPRX_RESET_VALUE;
  ITC->ISPR6 = ITC_SPRX_RESET_VALUE;
  ITC->ISPR7 = ITC_SPRX_RESET_VALUE;
  ITC->ISPR8 = ITC_SPRX_RESET_VALUE;
}

/**
  * @brief Get the software interrupt priority bits (I1, I0) value from CPU CC register.
  * @par Parameters:
  * None
  * @retval u8 The software interrupt priority bits value.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * @ref ITC_GetCPUCC
  * @par Example:
  * @code
  * u8 val;
  * val = ITC_GetSoftIntStatus();
  * @endcode
*/
u8 ITC_GetSoftIntStatus(void)
{
  return (u8)(ITC_GetCPUCC() & CPU_CC_I1I0);
}

/**
  * @brief Get the software priority of the specified interrupt source.
  * @param[in] IrqNum The IRQ number to access.
  * @retval ITC_PriorityLevel_TypeDef The software priority of the interrupt source.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * ITC_PriorityLevel_TypeDef val;
  * val = ITC_GetSoftwarePriority(I2C_IRQ_N);
  * if (val == ITC_PriorityLevel1) { ... }
  * @endcode
*/
ITC_PriorityLevel_TypeDef ITC_GetSoftwarePriority(ITC_IrqNum_TypeDef IrqNum)
{

  u8 Value = 0;
  u8 Mask;

  /* Check function parameters */
  assert_param(IS_ITC_IRQ_NUM_OK((u8)IrqNum));

  /* Define the mask corresponding to the bits position in the SPR register */
  Mask = (u8)(0x03U << (((u8)IrqNum % 4U) * 2U));

  switch (IrqNum)
  {
    case TLI_IRQ_N: /* TLI software priority can be read but has no meaning */
    case AWU_IRQ_N:
    case CLK_IRQ_N:
    case PORTA_IRQ_N:
      Value = (u8)(ITC->ISPR1 & Mask); /* Read software priority */
      break;
    case PORTB_IRQ_N:
    case PORTC_IRQ_N:
    case PORTD_IRQ_N:
    case PORTE_IRQ_N:
      Value = (u8)(ITC->ISPR2 & Mask); /* Read software priority */
      break;
    case CAN_RX_IRQ_N:
    case CAN_TX_IRQ_N:
    case SPI_IRQ_N:
    case TIM1_OVF_IRQ_N:
      Value = (u8)(ITC->ISPR3 & Mask); /* Read software priority */
      break;
    case TIM1_CAPCOM_IRQ_N:
    case TIM2_OVF_IRQ_N:
    case TIM2_CAPCOM_IRQ_N:
    case TIM3_OVF_IRQ_N:
      Value = (u8)(ITC->ISPR4 & Mask); /* Read software priority */
      break;
    case TIM3_CAPCOM_IRQ_N:
    case USART_TX_IRQ_N:
    case USART_RX_IRQ_N:
    case I2C_IRQ_N:
      Value = (u8)(ITC->ISPR5 & Mask); /* Read software priority */
      break;
    case LINUART_TX_IRQ_N:
    case LINUART_RX_IRQ_N:
    case ADC_IRQ_N:
    case TIM4_OVF_IRQ_N:
      Value = (u8)(ITC->ISPR6 & Mask); /* Read software priority */
      break;
    case EEPROM_EEC_IRQ_N:
      Value = (u8)(ITC->ISPR7 & Mask); /* Read software priority */
      break;
    default:
      break;
  }

  Value >>= (u8)(((u8)IrqNum % 4u) * 2u);

  return((ITC_PriorityLevel_TypeDef)Value);

}

/**
  * @brief Set the software priority of the specified interrupt source.
  * @param[in] IrqNum The interrupt source to access.
  * @param[in] PriorityValue The software priority value to set.
  * @retval ITC_PriorityLevel_TypeDef The software priority of the interrupt source.
  * @par Required preconditions:
  * - The modification of the software priority is only possible when the interrupts are disabled.
  * - The normal behavior is to disable the interrupts before calling this function, and re-enable it after.
  * - The priority level 0 cannot be set (see product specification for more details).
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * ITC_SetSoftwarePriority(SPI_IRQ_N, ITC_PriorityLevel1);
  * @endcode
*/
void ITC_SetSoftwarePriority(ITC_IrqNum_TypeDef IrqNum, ITC_PriorityLevel_TypeDef PriorityValue)
{

  u8 Mask;
  u8 NewPriority;

  /* Check function parameters */
  assert_param(IS_ITC_IRQ_NUM_OK((u8)IrqNum));
  assert_param(IS_ITC_PRIORITY_VALUE_OK(PriorityValue));

  /* Check if interrupts are disabled */
  assert_param(IS_ITC_INTERRUPTS_DISABLED);

  /* Define the mask corresponding to the bits position in the SPR register */
  /* The mask is reversed in order to clear the 2 bits after more easily */
  Mask = (u8)(~(u8)(0x03U << (((u8)IrqNum % 4U) * 2U)));

  /* Define the new priority to write */
  NewPriority = (u8)((u8)(PriorityValue) << (((u8)IrqNum % 4U) * 2U));

  switch (IrqNum)
  {
   
    case TLI_IRQ_N: /* TLI software priority can be written but has no meaning */
    case AWU_IRQ_N:
    case CLK_IRQ_N:
    case PORTA_IRQ_N:
      ITC->ISPR1 &= Mask;
      ITC->ISPR1 |= NewPriority;
    break;
   
    case PORTB_IRQ_N:
    case PORTC_IRQ_N:
    case PORTD_IRQ_N:
    case PORTE_IRQ_N:
      ITC->ISPR2 &= Mask;
      ITC->ISPR2 |= NewPriority;
    break;
   
    case CAN_RX_IRQ_N:
    case CAN_TX_IRQ_N:
    case SPI_IRQ_N:
    case TIM1_OVF_IRQ_N:
      ITC->ISPR3 &= Mask;
      ITC->ISPR3 |= NewPriority;
    break;
   
    case TIM1_CAPCOM_IRQ_N:
    case TIM2_OVF_IRQ_N:
    case TIM2_CAPCOM_IRQ_N:
    case TIM3_OVF_IRQ_N:
      ITC->ISPR4 &= Mask;
      ITC->ISPR4 |= NewPriority;
    break;
   
    case TIM3_CAPCOM_IRQ_N:
    case USART_TX_IRQ_N:
    case USART_RX_IRQ_N:
    case I2C_IRQ_N:
      ITC->ISPR5 &= Mask;
      ITC->ISPR5 |= NewPriority;
    break;
   
    case LINUART_TX_IRQ_N:
    case LINUART_RX_IRQ_N:
    case ADC_IRQ_N:
    case TIM4_OVF_IRQ_N:
      ITC->ISPR6 &= Mask;
      ITC->ISPR6 |= NewPriority;
    break;
   
    case EEPROM_EEC_IRQ_N:
      ITC->ISPR7 &= Mask;
      ITC->ISPR7 |= NewPriority;
    break;
   
    default:
    break;
   
  }

}

/**
  * @}
  */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
