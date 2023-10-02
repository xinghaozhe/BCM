/**
  ******************************************************************************
  * @file stm8_tim4.c
  * @brief This file contains all the functions for the TIM4 peripheral.
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
#include "stm8_tim4.h"

/* LINKER SECTIONS DEFINITION FOR THIS FILE ONLY */
#ifdef USE_COSMIC_SECTIONS
#pragma section (TIM4_CODE)
#pragma section const {TIM4_CONST}
#pragma section @near [TIM4_URAM]
#pragma section @near {TIM4_IRAM}
#pragma section @tiny [TIM4_UZRAM]
#pragma section @tiny {TIM4_IZRAM}
#endif

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/

/* TIM4 private Masks */
#define TIM4_PERIOD_RESET_MASK             ((u8)0xFF)
#define TIM4_PRESCALER_RESET_MASK          ((u8)0x00)
#define TIM4_PULSE_RESET_MASK              ((u16)0x0000)
#define TIM4_ICFILTER_MASK                 ((u8)0x00)


/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/**
  * @addtogroup TIM4_Public_Functions
  * @{
  */

/**
  * @brief Deinitializes the TIM4 peripheral registers to their default reset values.
  * @param[in] :
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Initialize TIM4 registers to their reset values.
  * @code
  * TIM4_DeInit();
  * @endcode
  */
void TIM4_DeInit(void)
{

    TIM4->CR1 		= TIM4_CR1_RESET_VALUE;
    TIM4->IER 		= TIM4_IER_RESET_VALUE;
    TIM4->CNTR 		= TIM4_CNTR_RESET_VALUE;
    TIM4->PSCR	 	= TIM4_PSCR_RESET_VALUE;
    TIM4->ARR 		= TIM4_ARR_RESET_VALUE;
    TIM4->SR1 		= TIM4_SR1_RESET_VALUE;
}

/**
  * @brief Initializes the TIM4 Time Base Unit according to the specified
  * parameters in the TIM4_TimeBaseInitStruct.
  * @param[in] TIM4_TimeBaseInitStruct pointer to a TIM4_TimeBaseInit_TypeDef
  * structure that contains the configuration information for the specified
  * TIM4 peripheral.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Initialize TIM4 registers to the values on TIM4_TimeBaseInitStruct.
  * @code
  * TIM4_TimeBaseInit(&TIM4_TimeBaseInitStruct);
  * @endcode
  */
void TIM4_TimeBaseInit(TIM4_TimeBaseInit_TypeDef* TIM4_TimeBaseInitStruct)
{
	/* Check TIM4 prescaler value */
	assert_param(IS_TIM4_PRESCALER_OK(TIM4_TimeBaseInitStruct->TIM4_Prescaler));
    /* Set the Autoreload value */
    TIM4->ARR = (u8)(TIM4_TimeBaseInitStruct->TIM4_Period);
    /* Set the Prescaler value */
    TIM4->PSCR = (u8)(TIM4_TimeBaseInitStruct->TIM4_Prescaler);
}

/**
  * @brief Fills each TIM4_TimeBaseInitStruct member with its default value.
  * @param[in] TIM4_TimeBaseInitStruct pointer to a TIM4_TimeBaseInit_TypeDef
  * structure which will be initialized.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Fill each TIM4_TimeBaseInitStruct member with its default value.
  * @code
  * TIM4_TimeBaseStructInit(&TIM4_TimeBaseInitStruct);
  * @endcode
  */
void TIM4_TimeBaseStructInit(TIM4_TimeBaseInit_TypeDef* TIM4_TimeBaseInitStruct)
{
		
    /* Set the default configuration */
    TIM4_TimeBaseInitStruct->TIM4_Period = TIM4_PERIOD_RESET_MASK;
    TIM4_TimeBaseInitStruct->TIM4_Prescaler = TIM4_PRESCALER_RESET_MASK;
}
/*******************************************************************************/
/**
  * @brief Enables or disables the TIM4 peripheral.
  * @param[in] NewState new state of the TIM4 peripheral.This parameter can
  * be ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable the TIM4 peripheral.
  * @code
  * TIM4_Cmd(ENABLE);
  * @endcode
  */
void TIM4_Cmd(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* set or Reset the CEN Bit */
    if (NewState == ENABLE)
    {
        TIM4->CR1 |= TIM4_CR1_CEN ;
    }
    else
    {
        TIM4->CR1 &= (u8)(~TIM4_CR1_CEN) ;
    }
}

/**
  * @brief Enables or disables the TIM4 update interrupt.
  * @param[in] NewState new state of the TIM4 update interrupt.
  * This parameter can be: ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable the the TIM4_IT_UPDATE interrupt.
  * @code
  * TIM4_UpdateITConfig(ENABLE);
  * @endcode
  */
void TIM4_UpdateITConfig(FunctionalState NewState)
{
    /* Check the parameter */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    if (NewState == ENABLE)
    {
        /* Enable the Interrupt sources */
        TIM4->IER |= TIM4_IT_UPDATE;
    }
    else
    {
        /* Disable the Interrupt sources */
        TIM4->IER &= (u8)(~TIM4_IT_UPDATE);
    }
}

/**
  * @brief Enables or Disables the TIM4 Update event.
  * @param[in] NewState new state of the TIM4 peripheral Preload register.This parameter can
  * be ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable the TIM4 Update event.
  * @code
  * TIM4_UpdateDisableConfig(ENABLE);
  * @endcode
  */
void TIM4_UpdateDisableConfig(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* Set or Reset the UDIS Bit */
    if (NewState == ENABLE)
    {
        TIM4->CR1 |= TIM4_CR1_UDIS ;
    }
    else
    {
        TIM4->CR1 &= (u8)(~TIM4_CR1_UDIS) ;
    }
}

/**
  * @brief Selects the TIM4 Update Request Interrupt source.
  * @param[in] TIM4_UpdateSource specifies the Update source.
  * This parameter can be one of the following values
  *                       - TIM4_UPDATESOURCE_REGULAR
  *                       - TIM4_UPDATESOURCE_GLOBAL
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Select the TIM4 Update Request Interrupt source
  * @code
  * TIM4_UpdateRequestConfig(TIM4_UPDATESOURCE_GLOBAL);
  * @endcode
  */
void TIM4_UpdateRequestConfig(u8 TIM4_UpdateSource)
{
    /* Check the parameters */
    assert_param(IS_TIM4_UPDATE_SOURCE_OK(TIM4_UpdateSource));

    /* Set or Reset the URS Bit */
    if (TIM4_UpdateSource == TIM4_UPDATESOURCE_REGULAR)
    {
        TIM4->CR1 |= TIM4_CR1_URS ;
    }
    else
    {
        TIM4->CR1 &= (u8)(~TIM4_CR1_URS) ;
    }
}

/**
  * @brief Selects the TIM4’s One Pulse Mode.
  * @param[in] TIM4_OPMode specifies the OPM Mode to be used.
  * This parameter can be one of the following values
  *                    - TIM4_OPMODE_SINGLE
  *                    - TIM4_OPMODE_REPETITIVE
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Select the TIM4 single One Pulse Mode
  * @code
  * TIM4_SelectOnePulseMode(TIM4_OPMODE_SINGLE);
  * @endcode
  */
void TIM4_SelectOnePulseMode(u8 TIM4_OPMode)
{
    /* Check the parameters */
    assert_param(IS_TIM4_OPM_MODE_OK(TIM4_OPMode));

    /* Set or Reset the OPM Bit */
    if (TIM4_OPMode == TIM4_OPMODE_SINGLE)
    {
        TIM4->CR1 |= TIM4_CR1_OPM ;
    }
    else
    {
        TIM4->CR1 &= (u8)(~TIM4_CR1_OPM) ;
    }

}

/**
  * @brief Configures the TIM4 Prescaler.
  * @param[in] Prescaler specifies the Prescaler Register value
  * This parameter can be one of the following values
  *                       -  TIM4_PRESCALER_1		
  *                       -  TIM4_PRESCALER_2   		
  *                       -  TIM4_PRESCALER_4   		
  *                       -  TIM4_PRESCALER_8		
  *                       -  TIM4_PRESCALER_16  		
  *                       -  TIM4_PRESCALER_32    		
  *                       -  TIM4_PRESCALER_64   
  *                       -  TIM4_PRESCALER_128  
  * @param[in] TIM4_PSCReloadMode specifies the TIM4 Prescaler Reload mode.
  * This parameter can be one of the following values
  *                       - TIM4_PSCRELOADMODE_IMMEDIATE: The Prescaler is loaded
  *                         immediatly.
  *                       - TIM4_PSCRELOADMODE_UPDATE: The Prescaler is loaded at
  *                         the update event.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Configures the TIM4 Prescaler.
  * @code
  * TIM4_PrescalerConfig(TIM4_PRESCALER_1, TIM4_PSCRELOADMODE_UPDATE);
  * @endcode
  */
void TIM4_PrescalerConfig(u8 Prescaler, u8 TIM4_PSCReloadMode)
{
    /* Check the parameters */
    assert_param(IS_TIM4_PRESCALER_RELOAD_OK(TIM4_PSCReloadMode));
		assert_param(IS_TIM4_PRESCALER_OK(Prescaler));

    /* Set the Prescaler value */
    TIM4->PSCR = Prescaler;

    /* Set or reset the UG Bit */
    if (TIM4_PSCReloadMode == TIM4_PSCRELOADMODE_IMMEDIATE)
    {
        TIM4->EGR |= TIM4_EGR_UG ;
    }
    else
    {
        TIM4->EGR &= (u8)(~TIM4_EGR_UG) ;
    }
}

/**
  * @brief Enables or disables TIM4 peripheral Preload register on ARR.
  * @param[in] NewState new state of the TIM4 peripheral Preload register.
  * This parameter can be ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable TIM4 peripheral Preload register on ARR.
  * @code
  * TIM4_ARRPreloadConfig(ENABLE);
  * @endcode
  */
void TIM4_ARRPreloadConfig(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* Set or Reset the ARPE Bit */
    if (NewState == ENABLE)
    {
        TIM4->CR1 |= TIM4_CR1_ARPE ;
    }
    else
    {
        TIM4->CR1 &= (u8)(~TIM4_CR1_ARPE) ;
    }
}

/**
  * @brief Configures the Update TIM4 event to be generated by software.
  * @param[in] :
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Configure the Update TIM4 event to be generated by software.
  * @code
  * TIM4_GenerateUpdateEvent();
  * @endcode
  */
void TIM4_GenerateUpdateEvent(void)
{

    /* Set the Update event source */
    TIM4->EGR |= TIM4_EVENTSOURCE_UPDATE;
}


/**
  * @brief Sets the TIM4 Counter Register value.
  * @param[in] Counter specifies the Counter register new value.
  * This parameter is between 0x00 and 0xFF.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Set the TIM4 Counter Register value to 0xFE.
  * @code
  * TIM4_SetCounter(0xFE);
  * @endcode
  */
void TIM4_SetCounter(u8 Counter)
{
    /* Set the Counter Register value */
    TIM4->CNTR = (u8)(Counter);
}


/**
  * @brief Sets the TIM4 Autoreload Register value.
  * @param[in] Autoreload specifies the Autoreload register new value.
  * This parameter is between 0x00 and 0xFF.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Set the TIM4 Autoreload Register value to 0xFE.
  * @code
  * TIM4_SetAutoreload(0xFE);
  * @endcode
  */
void TIM4_SetAutoreload(u8 Autoreload)
{
    /* Set the Autoreload Register value */
    TIM4->ARR = (u8)(Autoreload);
}

/**
  * @brief Gets the TIM4 Counter value.
  * @param[in] :
  * None
  * @retval Counter Register value.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Get the TIM4 Counter value.
  * @code
  * u8 Value;
  * Value = TIM4_GetCounter();
  * @endcode
  */
u8 TIM4_GetCounter(void)
{
    u8 tmpcntr=0;
    tmpcntr = TIM4->CNTR;
    /* Get the Counter Register value */
    return tmpcntr;
}

/**
  * @brief Gets the TIM4 Prescaler value.
  * @param[in] :
  * None
  * @retval Prescaler Register configuration value.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Get the TIM4 Prescaler configurartion value.
  * @code
  * u8  Prescaler;
  * Prescaler = TIM4_GetPrescaler();
  * @endcode
  */
u8 TIM4_GetPrescaler(void)
{
    u8 tmppscr;

    tmppscr = TIM4->PSCR;
    
    /* Get the Prescaler Register value */
    return tmppscr;
}

/**
  * @brief Checks whether the Update TIM4 flag is set or not.
  * @param[in] :
  * None
  * @retval FlagStatus The new state of TIM4_FLAG (SET or RESET).
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Check whether the TIM4_FLAG_UPDATE flag is set or not.
  * @code
  * FlagStatus FlagValue;
  * FlagValue = TIM4_GetUpdateFlagStatus();
  * @endcode
  */
FlagStatus TIM4_GetUpdateFlagStatus()
{
	FlagStatus bitstatus = RESET;

  if (TIM4->SR1 != RESET)
  {
    bitstatus = SET;
  }
  else
  {
    bitstatus = RESET;
  }
  return bitstatus;
}

/**
  * @brief Clears the TIM4’s Update pending flag.
  * @param[in] :
  * None
  * @retval void None.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Clear the TIM4_FLAG_UPDATE flag.
  * @code
  * TIM4_ClearUpdateFlag();
  * @endcode
  */
void TIM4_ClearUpdateFlag(void)
{
    /* Clear the flags (rc_w0) clear this bit by writing 0. Writing ‘1’ has no effect*/
    TIM4->SR1 &= (u8)(~TIM4_FLAG_UPDATE);
}

/**
  * @brief Checks whether the TIM4 Update interrupt has occurred or not.
  * @param[in] :
  * None
  * @retval ITStatus The new state of the TIM4_IT(SET or RESET).
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Check whether the TIM4_IT_UPDATE interrupt has occurred or not.
  * @code
  * ITStatus ITValue;
  * ITValue = TIM4_GetUpdateITStatus();
  * @endcode
  */
ITStatus TIM4_GetUpdateITStatus(void)
{
    ITStatus bitstatus = RESET;

    u8 TIM4_itStatus = 0x0, TIM4_itEnable = 0x0;

    TIM4_itStatus = (u8)(TIM4->SR1 & TIM4_IT_UPDATE);

    TIM4_itEnable = (u8)(TIM4->IER & TIM4_IT_UPDATE);

    if ((TIM4_itStatus != (u8)RESET ) && (TIM4_itEnable != (u8)RESET ))
    {
        bitstatus = SET;
    }
    else
    {
        bitstatus = RESET;
    }
    return bitstatus;
}



/**
  * @brief Clears the TIM4's update Interrupt pending bit .
  * @param[in] :
  * None
  * @retval void None.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Clear the TIM4_IT_UPDATE interrupt pending bit.
  * @code
  * TIM4_ClearUpdateITPendingBit();
  * @endcode
  */
void TIM4_ClearUpdateITPendingBit(void)
{

    /* Clear the update IT pending Bit */
    TIM4->SR1 &= (u8)(~TIM4_IT_UPDATE);
}
/**
  * @}
  */
/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
