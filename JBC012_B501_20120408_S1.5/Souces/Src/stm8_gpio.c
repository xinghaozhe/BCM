/**
  ******************************************************************************
  * @file stm8_gpio.c
  * @brief This file contains all the functions for the GPIO peripheral.
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
#include "stm8_gpio.h"

/* LINKER SECTIONS DEFINITION FOR THIS FILE ONLY */
#ifdef USE_COSMIC_SECTIONS
#pragma section (GPIO_CODE)
#pragma section const {GPIO_CONST}
#pragma section @near [GPIO_URAM]
#pragma section @near {GPIO_IRAM}
#pragma section @tiny [GPIO_UZRAM]
#pragma section @tiny {GPIO_IZRAM}
#endif

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/* Public functions ----------------------------------------------------------*/

/**
  * @addtogroup GPIO_Public_Functions
  * @{
  */

/**
  * @brief Deinitializes the GPIOx peripheral registers to their default reset
  * values.
  * @param[in] GPIOx Select the GPIO peripheral number (x = A to I).
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Initializes GPIOA and GPIOB ports to their reset values.
  * @code
  * GPIO_DeInit(GPIOA);
  * GPIO_DeInit(GPIOB);
  * @endcode
  */
void GPIO_DeInit(GPIO_TypeDef* GPIOx)
{
  GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
  GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
  GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
  GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
}

/**
  * @brief Initializes the GPIOx peripheral according to the specified
  * parameters in the GPIO_InitStruct.
  * @param[in] GPIOx Select the GPIO peripheral number (x = A to I).
  * @param[in] GPIO_InitStruct Pointer to a GPIO_Init_TypeDef structure that
  * contains the configuration information for the specified GPIO peripheral.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Configure PC6, PC7, PD6, PD7 in output push-pull mode, low level, fast slope
  * @code
  * GPIO_Init_TypeDef GPIO_InitStructure;
  * GPIO_InitStructure.GPIO_Mode = GPIO_MODE_OUT_PP_LOW_FAST;
  * GPIO_InitStructure.GPIO_Pin = GPIO_PIN_6 | GPIO_PIN_7;
  * GPIO_Init(GPIOC, &GPIO_InitStructure);
  * GPIO_Init(GPIOD, &GPIO_InitStructure);
  * @endcode
  */
void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Init_TypeDef* GPIO_InitStruct)
{

  /*----------------------*/
  /* Check the parameters */
  /*----------------------*/

  assert_param(IS_GPIO_MODE_OK(GPIO_InitStruct->GPIO_Mode));
  assert_param(IS_GPIO_PIN_OK(GPIO_InitStruct->GPIO_Pin));

  /*-----------------------------*/
  /* Input/Output mode selection */
  /*-----------------------------*/

  if ((((u8)(GPIO_InitStruct->GPIO_Mode)) & (u8)0x80) != (u8)0x00) /* Output mode */
  {
    if ((((u8)(GPIO_InitStruct->GPIO_Mode)) & (u8)0x10) != (u8)0x00) /* High level */
    {
      GPIOx->ODR |= GPIO_InitStruct->GPIO_Pin;
    } else /* Low level */
    {
      GPIOx->ODR &= (u8)(~(GPIO_InitStruct->GPIO_Pin));
    }
    /* Set Output mode */
    GPIOx->DDR |= GPIO_InitStruct->GPIO_Pin;
  } else /* Input mode */
  {
    /* Set Input mode */
    GPIOx->DDR &= (u8)(~(GPIO_InitStruct->GPIO_Pin));
  }

  /*------------------------------------------------------------------------*/
  /* Pull-Up/Float (Input) or Push-Pull/Open-Drain (Output) modes selection */
  /*------------------------------------------------------------------------*/

  if ((((u8)(GPIO_InitStruct->GPIO_Mode)) & (u8)0x40) != (u8)0x00) /* Pull-Up or Push-Pull */
  {
    GPIOx->CR1 |= GPIO_InitStruct->GPIO_Pin;
  } else /* Float or Open-Drain */
  {
    GPIOx->CR1 &= (u8)(~(GPIO_InitStruct->GPIO_Pin));
  }

  /*-----------------------------------------------------*/
  /* Interrupt (Input) or Slope (Output) modes selection */
  /*-----------------------------------------------------*/

  if ((((u8)(GPIO_InitStruct->GPIO_Mode)) & (u8)0x20) != (u8)0x00) /* Interrupt or Slow slope */
  {
    GPIOx->CR2 |= GPIO_InitStruct->GPIO_Pin;
  } else /* No external interrupt or No slope control */
  {
    GPIOx->CR2 &= (u8)(~(GPIO_InitStruct->GPIO_Pin));
  }

}

/**
  * @brief Fills each GPIO_InitStruct member with its default value.
  * @param[in] GPIO_InitStruct Pointer to a GPIO_Init_TypeDef structure which
  * will be initialized.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * GPIO_Init_TypeDef GPIO_InitStructure;
  * GPIO_StructInit(&GPIO_InitStructure);
  * @endcode
  */
void GPIO_StructInit(GPIO_Init_TypeDef* GPIO_InitStruct)
{
  /* Reset GPIO init structure parameters values */
  GPIO_InitStruct->GPIO_Pin = GPIO_Pin_All;
  GPIO_InitStruct->GPIO_Mode = GPIO_MODE_IN_FL_NO_IT;
}

/**
  * @brief Writes data to the specified GPIO data port.
  * @param[in] GPIOx Select the GPIO peripheral number (x = A to I).
  * @param[in] PortVal Specifies the value to be written to the port output
  * data register.
  * @retval void None
  * @par Required preconditions:
  * The port must be configured in output mode.
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * GPIO_Write(GPIOA, 0x55);
  * @endcode
  */
void GPIO_Write(GPIO_TypeDef* GPIOx, u8 PortVal)
{
  GPIOx->ODR = PortVal;
}

/**
  * @brief Writes high level to the specified GPIO pins.
  * @param[in] GPIOx Select the GPIO peripheral number (x = A to I).
  * @param[in] PortPins Specifies the pins to be turned high to the port output
  * data register.
  * @retval void None
  * @par Required preconditions:
  * The port must be configured in output mode.
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * GPIO_WriteHigh(GPIOA, (GPIO_PIN_7 | GPIO_PIN_0));
  * @endcode
  */
void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, u8 PortPins)
{
  GPIOx->ODR |= PortPins;
}

/**
  * @brief Writes low level to the specified GPIO pins.
  * @param[in] GPIOx Select the GPIO peripheral number (x = A to I).
  * @param[in] PortPins Specifies the pins to be turned low to the port output
  * data register.
  * @retval void None
  * @par Required preconditions:
  * The port must be configured in output mode.
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * GPIO_WriteLow(GPIOA, (GPIO_PIN_7 | GPIO_PIN_0));
  * @endcode
  */
void GPIO_WriteLow(GPIO_TypeDef* GPIOx, u8 PortPins)
{
  GPIOx->ODR &= (u8)(~PortPins);
}

/**
  * @brief Writes reverse level to the specified GPIO pins.
  * @param[in] GPIOx Select the GPIO peripheral number (x = A to I).
  * @param[in] PortPins Specifies the pins to be reversed to the port output
  * data register.
  * @retval void None
  * @par Required preconditions:
  * The port must be configured in output mode.
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * GPIO_WriteReverse(GPIOA, (GPIO_PIN_7 | GPIO_PIN_0));
  * @endcode
  */
void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, u8 PortPins)
{
  GPIOx->ODR ^= PortPins;
}

/**
  * @brief Reads the specified GPIO output data port.
  * @param[in] GPIOx Select the GPIO peripheral number (x = A to I).
  * @retval u8 GPIO output data port value.
  * @par Required preconditions:
  * The port must be configured in input mode.
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * u8 val;
  * val = GPIO_ReadOutputData(GPIOA);
  * @endcode
  */
u8 GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
{
  return ((u8)GPIOx->ODR);
}

/**
  * @brief Reads the specified GPIO input data port.
  * @param[in] GPIOx Select the GPIO peripheral number (x = A to I).
  * @retval u8 GPIO input data port value.
  * @par Required preconditions:
  * The port must be configured in input mode.
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * u8 val;
  * val = GPIO_ReadInputData(GPIOA);
  * @endcode
  */
u8 GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
{
  return ((u8)GPIOx->IDR);
}

/**
  * @}
  */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
