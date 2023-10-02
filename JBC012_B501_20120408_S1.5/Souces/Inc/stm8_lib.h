/**
  ******************************************************************************
  * @file stm8_lib.h
  * @brief This file includes the peripherals header files in the user application.
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
#ifndef __STM8_LIB_H
#define __STM8_LIB_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"

#ifdef _ADC
#include "stm8_adc.h"
#endif /* _ADC */

#ifdef _AWU
#include "stm8_awu.h"
#endif /* _AWU */

#ifdef _BEEP
#include "stm8_beep.h"
#endif /* _BEEP */

#ifdef _CLK
#include "stm8_clk.h"
#endif /* _CLK */

#if defined(_FLASH) || defined(_OPT)
#include "stm8_flash.h"
#endif /* _FLASH/OPT */

#ifdef _EXTI
#include "stm8_exti.h"
#endif /* _EXTI */

#if defined(_GPIOA) || defined(_GPIOB) || defined(_GPIOC) ||\
    defined(_GPIOD) || defined(_GPIOE) || defined(_GPIOF) ||\
    defined(_GPIOG) || defined(_GPIOH) || defined(_GPIOI)
#include "stm8_gpio.h"
#endif /* _GPIOx */

#ifdef _I2C
#include "stm8_i2c.h"
#endif /* _I2C */

#ifdef _ITC
#include "stm8_itc.h"
#endif /* _ITC */

#ifdef _IWDG
#include "stm8_iwdg.h"
#endif /* _IWDG */

#ifdef _RST
#include "stm8_rst.h"
#endif /* _RST */

#ifdef _SPI
#include "stm8_spi.h"
#endif /* _SPI */

#ifdef _TIM1
#include "stm8_tim1.h"
#endif /* _TIM1 */
/*
#ifdef _TIM2
#include "stm8_tim2.h"
#endif /* _TIM2 */
/*
#ifdef _TIM3
#include "stm8_tim3.h"
#endif /* _TIM3 */

#ifdef _TIM4
#include "stm8_tim4.h"
#endif /* _TIM4 */

#ifdef _USART 
#include "stm8_usart.h"
#endif /* _USART */

#ifdef _LINUART 
#include "stm8_linuart.h"
#endif /* _LINUART */

#ifdef _WWDG
#include "stm8_wwdg.h"
#endif /* _WWDG */

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */

#endif /* __STM8_LIB_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
