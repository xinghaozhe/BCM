/**
  ******************************************************************************
  * @file stm8_tim2.c
  * @brief This file contains all the functions for the TIM2 peripheral.
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
#include "stm8_tim2.h"

/* LINKER SECTIONS DEFINITION FOR THIS FILE ONLY */
#ifdef USE_COSMIC_SECTIONS
#pragma section (TIM2_CODE)
#pragma section const {TIM2_CONST}
#pragma section @near [TIM2_URAM]
#pragma section @near {TIM2_IRAM}
#pragma section @tiny [TIM2_UZRAM]
#pragma section @tiny {TIM2_IZRAM}
#endif

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/

/* TIM2 private Masks */
#define TIM2_PERIOD_RESET_MASK             ((u16)0xFFFF)
#define TIM2_PRESCALER_RESET_MASK          ((u8)0x00)
#define TIM2_PULSE_RESET_MASK              ((u16)0x0000)
#define TIM2_ICFILTER_MASK                 ((u8)0x00)


/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
static void TI1_Config(u8 TIM2_ICPolarity, u8 TIM2_ICSelection,
                       u8 TIM2_ICFilter);
static void TI2_Config(u8 TIM2_ICPolarity, u8 TIM2_ICSelection,
                       u8 TIM2_ICFilter);
static void TI3_Config(u8 TIM2_ICPolarity, u8 TIM2_ICSelection,
                       u8 TIM2_ICFilter);
/**
  * @addtogroup TIM2_Public_Functions
  * @{
  */

/**
  * @brief Deinitializes the TIM2 peripheral registers to their default reset values.
  * @param[in] :
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Initialize TIM2 registers to their reset values.
  * @code
  * TIM2_DeInit();
  * @endcode
  */
void TIM2_DeInit(void)
{

    TIM2->CR1 = (u8)TIM2_CR1_RESET_VALUE;
    TIM2->IER = (u8)TIM2_IER_RESET_VALUE;
    TIM2->SR2 = (u8)TIM2_SR2_RESET_VALUE;

    /* Disable channels */
    TIM2->CCER1 = (u8)TIM2_CCER1_RESET_VALUE;
    TIM2->CCER2 = (u8)TIM2_CCER2_RESET_VALUE;


    /* Then reset channel registers: it also works if lock level is equal to 2 or 3 */
    TIM2->CCER1 = (u8)TIM2_CCER1_RESET_VALUE;
    TIM2->CCER2 = (u8)TIM2_CCER2_RESET_VALUE;
    TIM2->CCMR1 = (u8)TIM2_CCMR1_RESET_VALUE;
    TIM2->CCMR2 = (u8)TIM2_CCMR2_RESET_VALUE;
    TIM2->CCMR3 = (u8)TIM2_CCMR3_RESET_VALUE;
    TIM2->CNTRH = (u8)TIM2_CNTRH_RESET_VALUE;
    TIM2->CNTRL = (u8)TIM2_CNTRL_RESET_VALUE;
    TIM2->PSCR	= (u8)TIM2_PSCR_RESET_VALUE;
    TIM2->ARRH 	= (u8)TIM2_ARRH_RESET_VALUE;
    TIM2->ARRL 	= (u8)TIM2_ARRL_RESET_VALUE;
    TIM2->CCR1H = (u8)TIM2_CCR1H_RESET_VALUE;
    TIM2->CCR1L = (u8)TIM2_CCR1L_RESET_VALUE;
    TIM2->CCR2H = (u8)TIM2_CCR2H_RESET_VALUE;
    TIM2->CCR2L = (u8)TIM2_CCR2L_RESET_VALUE;
    TIM2->CCR3H = (u8)TIM2_CCR3H_RESET_VALUE;
    TIM2->CCR3L = (u8)TIM2_CCR3L_RESET_VALUE;
    TIM2->SR1 = (u8)TIM2_SR1_RESET_VALUE;
}


/**
  * @brief Initializes the TIM2 Time Base Unit according to the specified
  * parameters in the TIM2_TimeBaseInitStruct.
  * @param[in] TIM2_TimeBaseInitStruct pointer to a TIM2_TimeBaseInit_TypeDef
  * structure that contains the configuration information for the specified
  * TIM2 peripheral.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Initialize TIM2 registers to the values on TIM2_TimeBaseInitStruct.
  * @code
  * TIM2_TimeBaseInit(&TIM2_TimeBaseInitStruct);
  * @endcode
  */
void TIM2_TimeBaseInit(TIM2_TimeBaseInit_TypeDef* TIM2_TimeBaseInitStruct)
{
    /* Set the Autoreload value */
    TIM2->ARRH = (u8)(TIM2_TimeBaseInitStruct->TIM2_Period >> 8) ;
	TIM2->ARRL = (u8)(TIM2_TimeBaseInitStruct->TIM2_Period);
    
    /* Set the Prescaler value */
    TIM2->PSCR = (u8)(TIM2_TimeBaseInitStruct->TIM2_Prescaler);
}


/**
  * @brief Initializes the TIM2 Channel1 according to the specified parameters
  * in the TIM2_OCInitStruct.
  * @param[in] TIM2_OCInitStruct pointer to a TIM2_OCInit_TypeDef structure that
  * contains the configuration information for the TIM2 peripheral.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Initialize the TIM2 Channel1 according to the specified parameters in the
  * TIM2_OCInitStruct.
  * @code
  * TIM2_OC1Init(&TIM2_OCInitStruct);
  * @endcode
  */
void TIM2_OC1Init(TIM2_OCInit_TypeDef* TIM2_OCInitStruct)
{
    u8 tmpccmr1 = 0;


    /* Check the parameters */
    assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCInitStruct->TIM2_OCMode));
    assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OCInitStruct->TIM2_OutputState));
    assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCInitStruct->TIM2_OCPolarity));


    tmpccmr1 = TIM2->CCMR1;


    /* Disable the Channel 1: Reset the CCE Bit */
    TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1E);
    /* Reset the Output Compare Bits */
    tmpccmr1 &= (u8)(~TIM2_CCMR_OCM);

    /* Set the Ouput Compare Mode */
    tmpccmr1 |= (u8)TIM2_OCInitStruct->TIM2_OCMode;

    TIM2->CCMR1 = tmpccmr1;

    /* Set the Output State */
    if (TIM2_OCInitStruct->TIM2_OutputState == TIM2_OUTPUTSTATE_ENABLE)
    {
        TIM2->CCER1 |= TIM2_CCER1_CC1E;
    }
    else
    {
        TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1E);
    }


    /* Set the Output Polarity */
    if (TIM2_OCInitStruct->TIM2_OCPolarity == TIM2_OCPOLARITY_LOW)
    {
        TIM2->CCER1 |= TIM2_CCER1_CC1P;
    }
    else
    {
        TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1P);
    }

    /* Set the Pulse value */
    TIM2->CCR1H = (u8)(TIM2_OCInitStruct->TIM2_Pulse >> 8);
	TIM2->CCR1L = (u8)(TIM2_OCInitStruct->TIM2_Pulse);
    
}


/**
  * @brief Initializes the TIM2 Channel2 according to the specified
  * parameters in the TIM2_OCInitStruct.
  * @param[in] TIM2_OCInitStruct pointer to a TIM2_OCInit_TypeDef structure that
  * contains the configuration information for the TIM2 peripheral.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Initialize the TIM2 Channel2 according to the specified parameters in the
  * TIM2_OCInitStruct.
  * @code
  * TIM2_OC2Init(&TIM2_OCInitStruct);
  * @endcode
  */
void TIM2_OC2Init(TIM2_OCInit_TypeDef* TIM2_OCInitStruct)
{
    u8 tmpccmr2 = 0;

    /* Check the parameters */
    assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCInitStruct->TIM2_OCMode));
    assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OCInitStruct->TIM2_OutputState));
    assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCInitStruct->TIM2_OCPolarity));

    tmpccmr2 = TIM2->CCMR2;

    /* Disable the Channel 2: Reset the CCE Bit */
    TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC2E);

    /* Reset the Output Compare Bits */
    tmpccmr2 &= (u8)(~TIM2_CCMR_OCM);

    /* Set the Ouput Compare Mode */
    tmpccmr2 |= TIM2_OCInitStruct->TIM2_OCMode;

    TIM2->CCMR2 = tmpccmr2;

    /* Set the Output State */
    if (TIM2_OCInitStruct->TIM2_OutputState == TIM2_OUTPUTSTATE_ENABLE)
    {
        TIM2->CCER1 |= TIM2_CCER1_CC2E;
    }
    else
    {
        TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC2E);
    }



    /* Set the Output Polarity */
    if (TIM2_OCInitStruct->TIM2_OCPolarity == TIM2_OCPOLARITY_LOW)
    {
        TIM2->CCER1 |= TIM2_CCER1_CC2P;
    }
    else
    {
        TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC2P);
    }


    /* Set the Pulse value */
    TIM2->CCR2H = (u8)(TIM2_OCInitStruct->TIM2_Pulse >> 8);
	TIM2->CCR2L = (u8)(TIM2_OCInitStruct->TIM2_Pulse);
    
}


/**
  * @brief Initializes the TIM2 Channel3 according to the specified
  * parameters in the TIM2_OCInitStruct.
  * @param[in] TIM2_OCInitStruct pointer to a TIM2_OCInit_TypeDef structure that
  * contains the configuration information for the TIM2 peripheral.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Initialize the TIM2 Channel3 according to the specified parameters in the
  * TIM2_OCInitStruct.
  * @code
  * TIM2_OC3Init(&TIM2_OCInitStruct);
  * @endcode
  */
void TIM2_OC3Init(TIM2_OCInit_TypeDef* TIM2_OCInitStruct)
{
    u8 tmpccmr3 = 0;

    /* Check the parameters */
    assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCInitStruct->TIM2_OCMode));
    assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OCInitStruct->TIM2_OutputState));
    assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCInitStruct->TIM2_OCPolarity));

    tmpccmr3 = TIM2->CCMR3;

    /* Disable the Channel 3: Reset the CCE Bit */
    TIM2->CCER2 &= (u8)(~TIM2_CCER2_CC3E);

    /* Reset the Output Compare Bits */
    tmpccmr3 &= (u8)(~TIM2_CCMR_OCM);

    /* Set the Ouput Compare Mode */
    tmpccmr3 |= TIM2_OCInitStruct->TIM2_OCMode;

    TIM2->CCMR3 = tmpccmr3;

    /* Set the Output State */
    if (TIM2_OCInitStruct->TIM2_OutputState == TIM2_OUTPUTSTATE_ENABLE)
    {
        TIM2->CCER2 |= TIM2_CCER2_CC3E;
    }
    else
    {
        TIM2->CCER2 &= (u8)(~TIM2_CCER2_CC3E);
    }


    /* Set the Output Polarity */
    if (TIM2_OCInitStruct->TIM2_OCPolarity == TIM2_OCPOLARITY_LOW)
    {
        TIM2->CCER2 |= TIM2_CCER2_CC3P;
    }
    else
    {
        TIM2->CCER2 &= (u8)(~TIM2_CCER2_CC3P);
    }


    /* Set the Pulse value */
    TIM2->CCR3H = (u8)(TIM2_OCInitStruct->TIM2_Pulse >> 8);
	TIM2->CCR3L = (u8)(TIM2_OCInitStruct->TIM2_Pulse);
    
}


/**
  * @brief Initializes the TIM2 peripheral according to the specified parameters
  * in the TIM2_ICInitStruct.
  * @param[in] TIM2_ICInitStruct pointer to a TIM2_ICInit_TypeDef structure that
  * contains the configuration information for the TIM2 peripheral.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * TI1_Config
  * TI2_Config
  * TI3_Config
  * TIM2_SetIC1Prescaler
  * TIM2_SetIC2Prescaler
  * TIM2_SetIC3Prescaler
  * @par Example:
  * Initialize the TIM2 Channel1 according to the specified parameters in the
  * TIM2_ICInitStruct.
  * @code
  * TIM2_ICInit(&TIM2_ICInitStruct);
  * @endcode
  */
void TIM2_ICInit(TIM2_ICInit_TypeDef* TIM2_ICInitStruct)
{
    /* Check the parameters */
    assert_param(IS_TIM2_CHANNEL_OK(TIM2_ICInitStruct->TIM2_Channel));
    assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICInitStruct->TIM2_ICPolarity));
    assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICInitStruct->TIM2_ICSelection));
    assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICInitStruct->TIM2_ICPrescaler));
    assert_param(IS_TIM2_IC_FILTER_OK(TIM2_ICInitStruct->TIM2_ICFilter));

    if (TIM2_ICInitStruct->TIM2_Channel == TIM2_CHANNEL_1)
    {
        /* TI1 Configuration */
        TI1_Config(TIM2_ICInitStruct->TIM2_ICPolarity,
                   TIM2_ICInitStruct->TIM2_ICSelection,
                   TIM2_ICInitStruct->TIM2_ICFilter);

        /* Set the Input Capture Prescaler value */
        TIM2_SetIC1Prescaler(TIM2_ICInitStruct->TIM2_ICPrescaler);
    }
    else if (TIM2_ICInitStruct->TIM2_Channel == TIM2_CHANNEL_2)
    {
        /* TI2 Configuration */
        TI2_Config(TIM2_ICInitStruct->TIM2_ICPolarity,
                   TIM2_ICInitStruct->TIM2_ICSelection,
                   TIM2_ICInitStruct->TIM2_ICFilter);

        /* Set the Input Capture Prescaler value */
        TIM2_SetIC2Prescaler(TIM2_ICInitStruct->TIM2_ICPrescaler);
    }
    else
    {
        /* TI3 Configuration */
        TI3_Config(TIM2_ICInitStruct->TIM2_ICPolarity,
                   TIM2_ICInitStruct->TIM2_ICSelection,
                   TIM2_ICInitStruct->TIM2_ICFilter);

        /* Set the Input Capture Prescaler value */
        TIM2_SetIC3Prescaler(TIM2_ICInitStruct->TIM2_ICPrescaler);
    }
}


/**
  * @brief Configures the TIM2 peripheral in PWM Input Mode according to the
  * specified parameters in the TIM2_ICInitStruct.
  * @param[in] TIM2_ICInitStruct pointer to a TIM2_ICInit_TypeDef structure that
  * contains the configuration information for the TIM2 peripheral.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * TI1_Config
  * TI2_Config
  * TIM2_SetIC1Prescaler
  * TIM2_SetIC2Prescaler
  * @par Example:
  * Configure the TIM2 peripheral in PWM Input Mode according to the specified
  * parameters in the TIM2_ICInitStruct.
  * @code
  * TIM2_PWMIConfig(&TIM2_ICInitStruct);
  * @endcode
  */
void TIM2_PWMIConfig(TIM2_ICInit_TypeDef* TIM2_ICInitStruct)
{
    u8 icpolarity = (u8)TIM2_ICPOLARITY_RISING;
    u8 icselection = (u8)TIM2_ICSELECTION_DIRECTTI;

    /* Check the parameters */
    assert_param(IS_TIM2_PWMI_CHANNEL_OK(TIM2_ICInitStruct->TIM2_Channel));
    assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICInitStruct->TIM2_ICPolarity));
    assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICInitStruct->TIM2_ICSelection));
    assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICInitStruct->TIM2_ICPrescaler));

    /* Select the Opposite Input Polarity */
    if (TIM2_ICInitStruct->TIM2_ICPolarity == TIM2_ICPOLARITY_RISING)
    {
        icpolarity = (u8)TIM2_ICPOLARITY_FALLING;
    }
    else
    {
        icpolarity = (u8)TIM2_ICPOLARITY_RISING;
    }

    /* Select the Opposite Input */
    if (TIM2_ICInitStruct->TIM2_ICSelection == TIM2_ICSELECTION_DIRECTTI)
    {
        icselection = (u8)TIM2_ICSELECTION_INDIRECTTI;
    }
    else
    {
        icselection = (u8)TIM2_ICSELECTION_DIRECTTI;
    }

    if (TIM2_ICInitStruct->TIM2_Channel == TIM2_CHANNEL_1)
    {
        /* TI1 Configuration */
        TI1_Config(TIM2_ICInitStruct->TIM2_ICPolarity, TIM2_ICInitStruct->TIM2_ICSelection,
                   TIM2_ICInitStruct->TIM2_ICFilter);

        /* Set the Input Capture Prescaler value */
        TIM2_SetIC1Prescaler(TIM2_ICInitStruct->TIM2_ICPrescaler);

        /* TI2 Configuration */
        TI2_Config(icpolarity, icselection, TIM2_ICInitStruct->TIM2_ICFilter);

        /* Set the Input Capture Prescaler value */
        TIM2_SetIC2Prescaler(TIM2_ICInitStruct->TIM2_ICPrescaler);
    }
    else
    {
        /* TI2 Configuration */
        TI2_Config(TIM2_ICInitStruct->TIM2_ICPolarity, TIM2_ICInitStruct->TIM2_ICSelection,
                   TIM2_ICInitStruct->TIM2_ICFilter);

        /* Set the Input Capture Prescaler value */
        TIM2_SetIC2Prescaler(TIM2_ICInitStruct->TIM2_ICPrescaler);

        /* TI1 Configuration */
        TI1_Config(icpolarity, icselection, TIM2_ICInitStruct->TIM2_ICFilter);

        /* Set the Input Capture Prescaler value */
        TIM2_SetIC1Prescaler(TIM2_ICInitStruct->TIM2_ICPrescaler);
    }
}

/**
  * @brief Fills each TIM2_OCInitStruct member with its default value.
  * @param[in] TIM2_OCInitStruct pointer to a TIM2_OCInit_TypeDef structure which
  * will be initialized.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Fill each TIM2_OCInitStruct member with its default value.
  * @code
  * TIM2_OCStructInit(&TIM2_OCInitStruct);
  * @endcode
  */
void TIM2_OCStructInit(TIM2_OCInit_TypeDef* TIM2_OCInitStruct)
{
    /* Set the default configuration */
    TIM2_OCInitStruct->TIM2_OCMode = (u8)TIM2_OCMODE_TIMING;
    TIM2_OCInitStruct->TIM2_OutputState = (u8)TIM2_OUTPUTSTATE_DISABLE;
    TIM2_OCInitStruct->TIM2_Pulse = (u16)TIM2_PULSE_RESET_MASK;
    TIM2_OCInitStruct->TIM2_OCPolarity = (u8)TIM2_OCPOLARITY_HIGH;
}


/**
  * @brief Fills each TIM2_ICInitStruct member with its default value.
  * @param[in] TIM2_ICInitStruct pointer to a TIM2_ICInit_TypeDef structure which
  * will be initialized.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Fill each TIM2_ICInitStruct member with its default value.
  * @code
  * TIM2_ICStructInit(&TIM2_ICInitStruct);
  * @endcode
  */
void TIM2_ICStructInit(TIM2_ICInit_TypeDef* TIM2_ICInitStruct)
{
    /* Set the default configuration */
    TIM2_ICInitStruct->TIM2_Channel = (u8)TIM2_CHANNEL_1;
    TIM2_ICInitStruct->TIM2_ICSelection = (u8)TIM2_ICSELECTION_DIRECTTI;
    TIM2_ICInitStruct->TIM2_ICPolarity = (u8)TIM2_ICPOLARITY_RISING;
    TIM2_ICInitStruct->TIM2_ICPrescaler = (u8)TIM2_ICPSC_DIV1;
    TIM2_ICInitStruct->TIM2_ICFilter = (u8)TIM2_ICFILTER_MASK;
}


/**
  * @brief Fills each TIM2_TimeBaseInitStruct member with its default value.
  * @param[in] TIM2_TimeBaseInitStruct pointer to a TIM2_TimeBaseInit_TypeDef
  * structure which will be initialized.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Fill each TIM2_TimeBaseInitStruct member with its default value.
  * @code
  * TIM2_TimeBaseStructInit(&TIM2_TimeBaseInitStruct);
  * @endcode
  */
void TIM2_TimeBaseStructInit(TIM2_TimeBaseInit_TypeDef* TIM2_TimeBaseInitStruct)
{
    /* Set the default configuration */
    TIM2_TimeBaseInitStruct->TIM2_Period = (u16)TIM2_PERIOD_RESET_MASK;
    TIM2_TimeBaseInitStruct->TIM2_Prescaler = (u16) TIM2_PRESCALER_RESET_MASK;
}

/**
  * @brief Enables or disables the TIM2 peripheral.
  * @param[in] NewState new state of the TIM2 peripheral.This parameter can
  * be ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable the TIM2 peripheral.
  * @code
  * TIM2_Cmd(ENABLE);
  * @endcode
  */
void TIM2_Cmd(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* set or Reset the CEN Bit */
    if (NewState == ENABLE)
    {
        TIM2->CR1 |= TIM2_CR1_CEN ;
    }
    else
    {
        TIM2->CR1 &= (u8)(~TIM2_CR1_CEN) ;
    }
}


/**
  * @brief Enables or disables the specified TIM2 interrupts.
  * @param[in] NewState new state of the TIM2 peripheral.
  * This parameter can be: ENABLE or DISABLE.
  * @param[in] TIM2_IT specifies the TIM2 interrupts sources to be enabled or disabled.
  * This parameter can be any combination of the following values:
  *                       - TIM2_IT_UPDATE: TIM2 update Interrupt source
  *                       - TIM2_IT_CC1: TIM2 Capture Compare 1 Interrupt source
  *                       - TIM2_IT_CC2: TIM2 Capture Compare 2 Interrupt source
  *                       - TIM2_IT_CC3: TIM2 Capture Compare 3 Interrupt source
  * @param[in] NewState new state of the TIM2 peripheral.

  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable the the TIM2_IT_UPDATE interrupt.
  * @code
  * TIM2_ITConfig(TIM2_IT_Update, ENABLE);
  * @endcode
  */
void TIM2_ITConfig(u8 TIM2_IT, FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_TIM2_IT_OK(TIM2_IT));
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    if (NewState == ENABLE)
    {
        /* Enable the Interrupt sources */
        TIM2->IER |= TIM2_IT;
    }
    else
    {
        /* Disable the Interrupt sources */
        TIM2->IER &= (u8)(~TIM2_IT);
    }
}


/**
  * @brief Enables or Disables the TIM2 Update event.
  * @param[in] NewState new state of the TIM2 peripheral Preload register.This parameter can
  * be ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable the TIM2 Update event.
  * @code
  * TIM2_UpdateDisableConfig(ENABLE);
  * @endcode
  */

void TIM2_UpdateDisableConfig(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* Set or Reset the UDIS Bit */
    if (NewState == ENABLE)
    {
        TIM2->CR1 |= TIM2_CR1_UDIS ;
    }
    else
    {
        TIM2->CR1 &= (u8)(~TIM2_CR1_UDIS) ;
    }
}

/**
  * @brief Selects the TIM2 Update Request Interrupt source.
  * @param[in] TIM2_UpdateSource specifies the Update source.
  * This parameter can be one of the following values
  *                       - TIM2_UPDATESOURCE_REGULAR
  *                       - TIM2_UPDATESOURCE_GLOBAL
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Select the TIM2 Update Request Interrupt source
  * @code
  * TIM2_UpdateRequestConfig(TIM2_UPDATESOURCE_GLOBAL);
  * @endcode
  */
void TIM2_UpdateRequestConfig(u8 TIM2_UpdateSource)
{
    /* Check the parameters */
    assert_param(IS_TIM2_UPDATE_SOURCE_OK(TIM2_UpdateSource));

    /* Set or Reset the URS Bit */
    if (TIM2_UpdateSource == TIM2_UPDATESOURCE_REGULAR)
    {
        TIM2->CR1 |= TIM2_CR1_URS ;
    }
    else
    {
        TIM2->CR1 &= (u8)(~TIM2_CR1_URS) ;
    }
}


/**
  * @brief Selects the TIM2’s One Pulse Mode.
  * @param[in] TIM2_OPMode specifies the OPM Mode to be used.
  * This parameter can be one of the following values
  *                    - TIM2_OPMODE_SINGLE
  *                    - TIM2_OPMODE_REPETITIVE
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Select the TIM2 single One Pulse Mode
  * @code
  * TIM2_SelectOnePulseMode(TIM2_OPMODE_SINGLE);
  * @endcode
  */
void TIM2_SelectOnePulseMode(u8 TIM2_OPMode)
{
    /* Check the parameters */
    assert_param(IS_TIM2_OPM_MODE_OK(TIM2_OPMode));

    /* Set or Reset the OPM Bit */
    if (TIM2_OPMode == TIM2_OPMODE_SINGLE)
    {
        TIM2->CR1 |= TIM2_CR1_OPM ;
    }
    else
    {
        TIM2->CR1 &= (u8)(~TIM2_CR1_OPM) ;
    }

}


/**
  * @brief Configures the TIM2 Prescaler.
  * @param[in] Prescaler specifies the Prescaler Register value
  * This parameter can be one of the following values
  *                       -  TIM2_PRESCALER_1
  *                       -  TIM2_PRESCALER_2
  *                       -  TIM2_PRESCALER_4
  *                       -  TIM2_PRESCALER_8
  *                       -  TIM2_PRESCALER_16
  *                       -  TIM2_PRESCALER_32
  *                       -  TIM2_PRESCALER_64
  *                       -  TIM2_PRESCALER_128
  *                       -  TIM2_PRESCALER_256
  *                       -  TIM2_PRESCALER_512
  *                       -  TIM2_PRESCALER_1024
  *                       -  TIM2_PRESCALER_2048
  *                       -  TIM2_PRESCALER_4096
  *                       -  TIM2_PRESCALER_8192
  *                       -  TIM2_PRESCALER_16384
  *                       -  TIM2_PRESCALER_32768
  * @param[in] TIM2_PSCReloadMode specifies the TIM2 Prescaler Reload mode.
  * This parameter can be one of the following values
  *                       - TIM2_PSCRELOADMODE_IMMEDIATE: The Prescaler is loaded
  *                         immediatly.
  *                       - TIM2_PSCRELOADMODE_UPDATE: The Prescaler is loaded at
  *                         the update event.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Configures the TIM2 Prescaler.
  * @code
  * TIM2_PrescalerConfig(TIM2_PRESCALER_1, TIM2_PSCRELOADMODE_UPDATE);
  * @endcode
  */

void TIM2_PrescalerConfig(u8 Prescaler, u8 TIM2_PSCReloadMode)
{
    /* Check the parameters */
    assert_param(IS_TIM2_PRESCALER_RELOAD_OK(TIM2_PSCReloadMode));
    assert_param(IS_TIM2_PRESCALER_OK(Prescaler));

    /* Set the Prescaler value */
    TIM2->PSCR = Prescaler;

    /* Set or reset the UG Bit */
    if (TIM2_PSCReloadMode == TIM2_PSCRELOADMODE_IMMEDIATE)
    {
        TIM2->EGR |= TIM2_EGR_UG ;
    }
    else
    {
        TIM2->EGR &= (u8)(~TIM2_EGR_UG) ;
    }
}


/**
  * @brief Forces the TIM2 Channel1 output waveform to active or inactive level.
  * @param[in] TIM2_ForcedAction specifies the forced Action to be set to the output waveform.
  * This parameter can be one of the following values:
  *                       - TIM2_FORCEDACTION_ACTIVE: Force active level on OC1REF
  *                       - TIM2_FORCEDACTION_INACTIVE: Force inactive level on
  *                         OC1REF.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Force the TIM2 Channel1 output waveform to active or inactive level.
  * @code
  * TIM2_ForcedOC1Config(TIM2_FORCEDACTION_ACTIVE);
  * @endcode
  */
void TIM2_ForcedOC1Config(u8 TIM2_ForcedAction)
{
    u8 tmpccmr1 = 0;

    /* Check the parameters */
    assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));

    tmpccmr1 = TIM2->CCMR1;

    /* Reset the OCM Bits */
    tmpccmr1 &= (u8)(~TIM2_CCMR_OCM);

    /* Configure The Forced output Mode */
    tmpccmr1 |= TIM2_ForcedAction;

    TIM2->CCMR1 = tmpccmr1;
}


/**
  * @brief Forces the TIM2 Channel2 output waveform to active or inactive level.
  * @param[in] TIM2_ForcedAction specifies the forced Action to be set to the output waveform.
  * This parameter can be one of the following values:
  *                       - TIM2_FORCEDACTION_ACTIVE: Force active level on OC2REF
  *                       - TIM2_FORCEDACTION_INACTIVE: Force inactive level on
  *                         OC2REF.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Force the TIM2 Channel2 output waveform to active or inactive level.
  * @code
  * TIM2_ForcedOC2Config(TIM2_FORCEDACTION_ACTIVE);
  * @endcode
  */
void TIM2_ForcedOC2Config(u8 TIM2_ForcedAction)
{
    u8 tmpccmr2 = 0;

    /* Check the parameters */
    assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));

    tmpccmr2 = TIM2->CCMR2;

    /* Reset the OCM Bits */
    tmpccmr2 &= (u8)(~TIM2_CCMR_OCM);

    /* Configure The Forced output Mode */
    tmpccmr2 |= TIM2_ForcedAction;

    TIM2->CCMR2 = tmpccmr2;
}


/**
  * @brief Forces the TIM2 Channel3 output waveform to active or inactive level.
  * @param[in] TIM2_ForcedAction specifies the forced Action to be set to the output waveform.
  * This parameter can be one of the following values:
  *                       - TIM2_FORCEDACTION_ACTIVE: Force active level on OC3REF
  *                       - TIM2_FORCEDACTION_INACTIVE: Force inactive level on
  *                         OC3REF.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Force the TIM2 Channel3 output waveform to active or inactive level.
  * @code
  * TIM2_ForcedOC3Config(TIM2_FORCEDACTION_ACTIVE);
  * @endcode
  */
void TIM2_ForcedOC3Config(u8 TIM2_ForcedAction)
{
    u8 tmpccmr3 = 0;

    /* Check the parameters */
    assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));

    tmpccmr3 = TIM2->CCMR3;

    /* Reset the OCM Bits */
    tmpccmr3 &= (u8)(~TIM2_CCMR_OCM);

    /* Configure The Forced output Mode */
    tmpccmr3 |= TIM2_ForcedAction;

    TIM2->CCMR3 = tmpccmr3;
}


/**
  * @brief Enables or disables TIM2 peripheral Preload register on ARR.
  * @param[in] NewState new state of the TIM2 peripheral Preload register.
  * This parameter can be ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable TIM2 peripheral Preload register on ARR.
  * @code
  * TIM2_ARRPreloadConfig(ENABLE);
  * @endcode
  */
void TIM2_ARRPreloadConfig(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* Set or Reset the ARPE Bit */
    if (NewState == ENABLE)
    {
        TIM2->CR1 |= TIM2_CR1_ARPE ;
    }
    else
    {
        TIM2->CR1 &= (u8)(~TIM2_CR1_ARPE) ;
    }
}


/**
  * @brief Enables or disables the TIM2 peripheral Preload Register on CCR1.
  * @param[in] NewState new state of the Capture Compare Preload register.
  * This parameter can be ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable the TIM2 peripheral Preload Register on CCR1.
  * @code
  * TIM2_OC1PreloadConfig(ENABLE);
  * @endcode
  */
void TIM2_OC1PreloadConfig(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* Set or Reset the OC1PE Bit */
    if (NewState == ENABLE)
    {
        TIM2->CCMR1 |= TIM2_CCMR_OCxPE ;
    }
    else
    {
        TIM2->CCMR1 &= (u8)(~TIM2_CCMR_OCxPE) ;
    }
}


/**
  * @brief Enables or disables the TIM2 peripheral Preload Register on CCR2.
  * @param[in] NewState new state of the Capture Compare Preload register.
  * This parameter can be ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable the TIM2 peripheral Preload Register on CCR2.
  * @code
  * TIM2_OC2PreloadConfig(ENABLE);
  * @endcode
  */
void TIM2_OC2PreloadConfig(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* Set or Reset the OC2PE Bit */
    if (NewState == ENABLE)
    {
        TIM2->CCMR2 |= TIM2_CCMR_OCxPE ;
    }
    else
    {
        TIM2->CCMR2 &= (u8)(~TIM2_CCMR_OCxPE) ;
    }
}


/**
  * @brief Enables or disables the TIM2 peripheral Preload Register on CCR3.
  * @param[in] NewState new state of the Capture Compare Preload register.
  * This parameter can be ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable the TIM2 peripheral Preload Register on CCR3.
  * @code
  * TIM2_OC3PreloadConfig(ENABLE);
  * @endcode
  */
void TIM2_OC3PreloadConfig(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* Set or Reset the OC3PE Bit */
    if (NewState == ENABLE)
    {
        TIM2->CCMR3 |= TIM2_CCMR_OCxPE ;
    }
    else
    {
        TIM2->CCMR3 &= (u8)(~TIM2_CCMR_OCxPE) ;
    }
}


/**
  * @brief Configures the TIM2 event to be generated by software.
  * @param[in] TIM2_EventSource specifies the event source.
  * This parameter can be one of the following values:
  *                       - TIM2_EVENTSOURCE_UPDATE: TIM2 update Event source
  *                       - TIM2_EVENTSOURCE_CC1: TIM2 Capture Compare 1 Event source
  *                       - TIM2_EVENTSOURCE_CC2: TIM2 Capture Compare 2 Event source
  *                       - TIM2_EVENTSOURCE_CC3: TIM2 Capture Compare 3 Event source
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Configure the TIM2 event to be generated by software.
  * @code
  * TIM2_GenerateEvent(TIM2_EVENTSOURCE_UPDATE);
  * @endcode
  */
void TIM2_GenerateEvent(u8 TIM2_EventSource)
{
    /* Check the parameters */
    assert_param(IS_TIM2_EVENT_SOURCE_OK(TIM2_EventSource));

    /* Set the event sources */
    TIM2->EGR |= TIM2_EventSource;
}


/**
  * @brief Configures the TIM2 Channel 1 polarity.
  * @param[in] TIM2_OCPolarity specifies the OC1 Polarity.
  * This parameter can be one of the following values:
  *                       - TIM2_OCPOLARITY_LOW: Output Compare active low
  *                       - TIM2_OCPOLARITY_HIGH: Output Compare active high
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Configure the TIM2 Channel 1 polarity to High.
  * @code
  * TIM2_OC1PolarityConfig(TIM2_OCPOLARITY_HIGH);
  * @endcode
  */
void TIM2_OC1PolarityConfig(u8 TIM2_OCPolarity)
{
    /* Check the parameters */
    assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));

    /* Set or Reset the CC1P Bit */
    if (TIM2_OCPolarity == TIM2_OCPOLARITY_LOW)
    {
        TIM2->CCER1 |= TIM2_CCER1_CC1P ;
    }
    else
    {
        TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1P) ;
    }
}


/**
  * @brief Configures the TIM2 Channel 2 polarity.
  * @param[in] TIM2_OCPolarity specifies the OC2 Polarity.
  * This parameter can be one of the following values:
  *                       - TIM2_OCPOLARITY_LOW: Output Compare active low
  *                       - TIM2_OCPOLARITY_HIGH: Output Compare active high
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Configure the TIM2 Channel 2 polarity to High.
  * @code
  * TIM2_OC2PolarityConfig(TIM2_OCPOLARITY_HIGH);
  * @endcode
  */
void TIM2_OC2PolarityConfig(u8 TIM2_OCPolarity)
{
    /* Check the parameters */
    assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));

    /* Set or Reset the CC2P Bit */
    if (TIM2_OCPolarity == TIM2_OCPOLARITY_LOW)
    {
        TIM2->CCER1 |= TIM2_CCER1_CC2P ;
    }
    else
    {
        TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC2P) ;
    }
}


/**
  * @brief Configures the TIM2 Channel 3 polarity.
  * @param[in] TIM2_OCPolarity specifies the OC3 Polarity.
  * This parameter can be one of the following values:
  *                       - TIM2_OCPOLARITY_LOW: Output Compare active low
  *                       - TIM2_OCPOLARITY_HIGH: Output Compare active high
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Configure the TIM2 Channel 3 polarity to High.
  * @code
  * TIM2_OC3PolarityConfig(TIM2_OCPOLARITY_HIGH);
  * @endcode
  */
void TIM2_OC3PolarityConfig(u8 TIM2_OCPolarity)
{
    /* Check the parameters */
    assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));

    /* Set or Reset the CC3P Bit */
    if (TIM2_OCPolarity == TIM2_OCPOLARITY_LOW)
    {
        TIM2->CCER2 |= TIM2_CCER2_CC3P ;
    }
    else
    {
        TIM2->CCER2 &= (u8)(~TIM2_CCER2_CC3P) ;
    }
}


/**
  * @brief Enables or disables the TIM2 Capture Compare Channel x.
  * @param[in] TIM2_Channel specifies the TIM2 Channel.
  * This parameter can be one of the following values:
  *                       - TIM2_Channel1: TIM2 Channel1
  *                       - TIM2_Channel2: TIM2 Channel2
  *                       - TIM2_Channel3: TIM2 Channel3
  * @param[in] NewState specifies the TIM2 Channel CCxE bit new state.
  * This parameter can be: ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable the TIM2 Capture Compare Channel 1.
  * @code
  * TIM2_CCxCmd(TIM2_Channel1, ENABLE);
  * @endcode
  */
void TIM2_CCxCmd(u8 TIM2_Channel, FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    if (TIM2_Channel == TIM2_CHANNEL_1)
    {
        /* Set or Reset the CC1E Bit */
        if (NewState == ENABLE)
        {
            TIM2->CCER1 |= TIM2_CCER1_CC1E ;
        }
        else
        {
            TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1E) ;
        }

    }
    else if (TIM2_Channel == TIM2_CHANNEL_2)
    {
        /* Set or Reset the CC2E Bit */
        if (NewState == ENABLE)
        {
            TIM2->CCER1 |= TIM2_CCER1_CC2E;
        }
        else
        {
            TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC2E) ;
        }
    }
    else
    {
        /* Set or Reset the CC3E Bit */
        if (NewState == ENABLE)
        {
            TIM2->CCER2 |= TIM2_CCER2_CC3E;
        }
        else
        {
            TIM2->CCER2 &= (u8)(~TIM2_CCER2_CC3E) ;
        }
    }
}

/**
  * @brief Selects the TIM2 Ouput Compare Mode. This function disables the
  * selected channel before changing the Ouput Compare Mode. User has to
  * enable this channel using TIM2_CCxCmd and TIM2_CCxNCmd functions.
  * @param[in] TIM2_Channel specifies the TIM2 Channel.
  * This parameter can be one of the following values:
  *                       - TIM2_Channel1: TIM2 Channel1
  *                       - TIM2_Channel2: TIM2 Channel2
  *                       - TIM2_Channel3: TIM2 Channel3
  * @param[in] TIM2_OCMode specifies the TIM2 Output Compare Mode.
  * This paramter can be one of the following values:
  *                       - TIM2_OCMODE_TIMING
  *                       - TIM2_OCMODE_ACTIVE
  *                       - TIM2_OCMODE_TOGGLE
  *                       - TIM2_OCMODE_PWM1
  *                       - TIM2_OCMODE_PWM2
  *                       - TIM2_FORCEDACTION_ACTIVE
  *                       - TIM2_FORCEDACTION_INACTIVE
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Selects the TIM2 Ouput Compare Mode TIM2_OCMODE_TIMING for channel1.
  * @code
  * TIM2_SelectOCxM(TIM2_Channel1, TIM2_OCMODE_TIMING);
  * @endcode
  */
void TIM2_SelectOCxM(u8 TIM2_Channel, u8 TIM2_OCMode)
{
    /* Check the parameters */
    assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
    assert_param(IS_TIM2_OCM_OK(TIM2_OCMode));

    if (TIM2_Channel == TIM2_CHANNEL_1)
    {
        /* Disable the Channel 1: Reset the CCE Bit */
        TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1E);

        /* Reset the Output Compare Bits */
        TIM2->CCMR1 &= (u8)(~TIM2_CCMR_OCM);

        /* Set the Ouput Compare Mode */
        TIM2->CCMR1 |= TIM2_OCMode;
    }
    else if (TIM2_Channel == TIM2_CHANNEL_2)
    {
        /* Disable the Channel 2: Reset the CCE Bit */
        TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC2E);

        /* Reset the Output Compare Bits */
        TIM2->CCMR2 &= (u8)(~TIM2_CCMR_OCM);

        /* Set the Ouput Compare Mode */
        TIM2->CCMR2 |= TIM2_OCMode;
    }
    else
    {
        /* Disable the Channel 3: Reset the CCE Bit */
        TIM2->CCER2 &= (u8)(~TIM2_CCER2_CC3E);

        /* Reset the Output Compare Bits */
        TIM2->CCMR3 &= (u8)(~TIM2_CCMR_OCM);

        /* Set the Ouput Compare Mode */
        TIM2->CCMR3 |= TIM2_OCMode;
    }
}


/**
  * @brief Sets the TIM2 Counter Register value.
  * @param[in] Counter specifies the Counter register new value.
  * This parameter is between 0x0000 and 0xFFFF.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Set the TIM2 Counter Register value to 0xFFEE.
  * @code
  * TIM2_SetCounter(0xFFEE);
  * @endcode
  */
void TIM2_SetCounter(u16 Counter)
{
    /* Set the Counter Register value */
    TIM2->CNTRH = (u8)(Counter >> 8);
	TIM2->CNTRL = (u8)(Counter);
    
}


/**
  * @brief Sets the TIM2 Autoreload Register value.
  * @param[in] Autoreload specifies the Autoreload register new value.
  * This parameter is between 0x0000 and 0xFFFF.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Set the TIM2 Autoreload Register value to 0xFFEE.
  * @code
  * TIM2_SetAutoreload(0xFFEE);
  * @endcode
  */
void TIM2_SetAutoreload(u16 Autoreload)
{

    /* Set the Autoreload Register value */
    TIM2->ARRH = (u8)(Autoreload >> 8);
	TIM2->ARRL = (u8)(Autoreload);
    
}


/**
  * @brief Sets the TIM2 Capture Compare1 Register value.
  * @param[in] Compare1 specifies the Capture Compare1 register new value.
  * This parameter is between 0x0000 and 0xFFFF.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Set the TIM2 Capture Compare1 Register value to 0xFFEE.
  * @code
  * TIM2_SetCompare1(0xFFEE);
  * @endcode
  */
void TIM2_SetCompare1(u16 Compare1)
{
    /* Set the Capture Compare1 Register value */
    TIM2->CCR1H = (u8)(Compare1 >> 8);
	TIM2->CCR1L = (u8)(Compare1);
    
}


/**
  * @brief Sets the TIM2 Capture Compare2 Register value.
  * @param[in] Compare2 specifies the Capture Compare2 register new value.
  * This parameter is between 0x0000 and 0xFFFF.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Set the TIM2 Capture Compare2 Register value to 0xFFEE.
  * @code
  * TIM2_SetCompare2(0xFFEE);
  * @endcode
  */
void TIM2_SetCompare2(u16 Compare2)
{
    /* Set the Capture Compare2 Register value */
    TIM2->CCR2H = (u8)(Compare2 >> 8);
	TIM2->CCR2L = (u8)(Compare2);
    
}


/**
  * @brief Sets the TIM2 Capture Compare3 Register value.
  * @param[in] Compare3 specifies the Capture Compare3 register new value.
  * This parameter is between 0x0000 and 0xFFFF.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Set the TIM2 Capture Compare3 Register value to 0xFFEE.
  * @code
  * TIM2_SetCompare3(0xFFEE);
  * @endcode
  */
void TIM2_SetCompare3(u16 Compare3)
{
    /* Set the Capture Compare3 Register value */
    TIM2->CCR3H = (u8)(Compare3 >> 8);
	TIM2->CCR3L = (u8)(Compare3);
    
}


/**
  * @brief Sets the TIM2 Input Capture 1 prescaler.
  * @param[in] TIM2_IC1Prescaler specifies the Input Capture prescaler new value
  * This parameter can be one of the following values:
  *                       - TIM2_ICPSC_DIV1: no prescaler
  *                       - TIM2_ICPSC_DIV2: capture is done once every 2 events
  *                       - TIM2_ICPSC_DIV4: capture is done once every 4 events
  *                       - TIM2_ICPSC_DIV8: capture is done once every 8 events
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Set the TIM2 Input Capture 1 prescaler to do a capture every 8 events.
  * @code
  * TIM2_SetIC1Prescaler(TIM2_ICPSC_DIV8);
  * @endcode
  */
void TIM2_SetIC1Prescaler(u8 TIM2_IC1Prescaler)
{
    u8 tmpccmr1 = 0;

    /* Check the parameters */
    assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC1Prescaler));

    tmpccmr1 = TIM2->CCMR1;

    /* Reset the IC1PSC Bits */
    tmpccmr1 &= (u8)(~TIM2_CCMR_ICxPSC);

    /* Set the IC1PSC value */
    tmpccmr1 |= TIM2_IC1Prescaler;

    TIM2->CCMR1 = tmpccmr1;
}

/**
  * @brief Sets the TIM2 Input Capture 2 prescaler.
  * @param[in] TIM2_IC2Prescaler specifies the Input Capture prescaler new value
  * This parameter can be one of the following values:
  *                       - TIM2_ICPSC_DIV1: no prescaler
  *                       - TIM2_ICPSC_DIV2: capture is done once every 2 events
  *                       - TIM2_ICPSC_DIV4: capture is done once every 4 events
  *                       - TIM2_ICPSC_DIV8: capture is done once every 8 events
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Set the TIM2 Input Capture 2 prescaler to do a capture every 8 events.
  * @code
  * TIM2_SetIC2Prescaler(TIM2_ICPSC_DIV8);
  * @endcode
  */
void TIM2_SetIC2Prescaler(u8 TIM2_IC2Prescaler)
{
    u8 tmpccmr2 = 0;

    /* Check the parameters */
    assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC2Prescaler));

    tmpccmr2 = TIM2->CCMR2;

    /* Reset the IC2PSC Bits */
    tmpccmr2 &= (u8)(~TIM2_CCMR_ICxPSC);

    /* Set the IC2PSC value */
    tmpccmr2 |= TIM2_IC2Prescaler;

    TIM2->CCMR2 = tmpccmr2;
}

/**
  * @brief Sets the TIM2 Input Capture 3 prescaler.
  * @param[in] TIM2_IC3Prescaler specifies the Input Capture prescaler new value
  * This parameter can be one of the following values:
  *                       - TIM2_ICPSC_DIV1: no prescaler
  *                       - TIM2_ICPSC_DIV2: capture is done once every 2 events
  *                       - TIM2_ICPSC_DIV4: capture is done once every 4 events
  *                       - TIM2_ICPSC_DIV8: capture is done once every 8 events
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Set the TIM2 Input Capture 3 prescaler to do a capture every 8 events.
  * @code
  * TIM2_SetIC3Prescaler(TIM2_ICPSC_DIV8);
  * @endcode
  */
void TIM2_SetIC3Prescaler(u8 TIM2_IC3Prescaler)
{
    u8 tmpccmr3 = 0;

    /* Check the parameters */
    assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC3Prescaler));

    tmpccmr3 = TIM2->CCMR3;

    /* Reset the IC3PSC Bits */
    tmpccmr3 &= (u8)(~TIM2_CCMR_ICxPSC);

    /* Set the IC3PSC value */
    tmpccmr3  |= TIM2_IC3Prescaler;

    TIM2->CCMR3 = tmpccmr3;
}

/**
  * @brief Gets the TIM2 Input Capture 1 value.
  * @param[in] :
  * None
  * @retval Capture Compare 1 Register value.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Get the TIM2 Input Capture 1 value.
  * @code
  * u16 Value;
  * Value = TIM2_GetCapture1();
  * @endcode
  */
u16 TIM2_GetCapture1(void)
{
    u16 tmpccr1=0;
    u8 tmpccr1l, tmpccr1h;

    tmpccr1h = TIM2->CCR1H;
	tmpccr1l = TIM2->CCR1L;
    

    tmpccr1 = (u16)(tmpccr1l);
    tmpccr1 |= (u16)((u16)(tmpccr1h) << 8);
    /* Get the Capture 1 Register value */
    return tmpccr1;
}

/**
  * @brief Gets the TIM2 Input Capture 2 value.
  * @param[in] :
  * None
  * @retval Capture Compare 2 Register value.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Get the TIM2 Input Capture 2 value.
  * @code
  * u16 Value;
  * Value = TIM2_GetCapture2();
  * @endcode
  */
u16 TIM2_GetCapture2(void)
{
    u16 tmpccr2=0;
    u8 tmpccr2l, tmpccr2h;

    
    tmpccr2h = TIM2->CCR2H;
	tmpccr2l = TIM2->CCR2L;

    tmpccr2 = (u16)(tmpccr2l);
    tmpccr2 |= (u16)((u16)(tmpccr2h) << 8);
    /* Get the Capture 2 Register value */
    return tmpccr2;
}

/**
  * @brief Gets the TIM2 Input Capture 3 value.
  * @param[in] :
  * None
  * @retval Capture Compare 3 Register value.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Get the TIM2 Input Capture 3 value.
  * @code
  * u16 Value;
  * Value = TIM2_GetCapture3();
  * @endcode
  */
u16 TIM2_GetCapture3(void)
{
    u16 tmpccr3=0;
    u8 tmpccr3l, tmpccr3h;

    
    tmpccr3h = TIM2->CCR3H;
	tmpccr3l = TIM2->CCR3L;

    tmpccr3 = (u16)(tmpccr3l);
    tmpccr3 |= (u16)((u16)(tmpccr3h) << 8);
    /* Get the Capture 3 Register value */
    return tmpccr3;
}

/**
  * @brief Gets the TIM2 Counter value.
  * @param[in] :
  * None
  * @retval Counter Register value.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Get the TIM2 Counter value.
  * @code
  * u16 Value;
  * Value = TIM2_GetCounter();
  * @endcode
  */
u16 TIM2_GetCounter(void)
{
    u16 tmpcnt=0;
    u8 tmpcntrl, tmpcntrh;

    tmpcntrh = TIM2->CNTRH;
	tmpcntrl = TIM2->CNTRL;

    tmpcnt = (u16)(tmpcntrl);
    tmpcnt |= (u16)((u16)(tmpcntrh) << 8);
    /* Get the Counter Register value */
    return tmpcnt;
}


/**
  * @brief Gets the TIM2 Prescaler value.
  * @param[in] :
  * None
  * @retval Prescaler Register configuration value.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Get the TIM2 Prescaler configurartion value.
  * @code
  * u8  Prescaler;
  * Prescaler = TIM2_GetPrescaler();
  * @endcode
  */
u8 TIM2_GetPrescaler(void)
{
    u8 tmppscr;

    tmppscr = TIM2->PSCR;

    /* Get the Prescaler Register value */
    return tmppscr;
}


/**
  * @brief Checks whether the specified TIM2 flag is set or not.
  * @param[in] TIM2_FLAG specifies the flag to check.
  * This parameter can be one of the following values:
  *                       - TIM2_FLAG_UPDATE: TIM2 update Flag
  *                       - TIM2_FLAG_CC1: TIM2 Capture Compare 1 Flag
  *                       - TIM2_FLAG_CC2: TIM2 Capture Compare 2 Flag
  *                       - TIM2_FLAG_CC3: TIM2 Capture Compare 3 Flag
  *                       - TIM2_FLAG_CC1OF: TIM2 Capture Compare 1 overcapture Flag
  *                       - TIM2_FLAG_CC2OF: TIM2 Capture Compare 2 overcapture Flag
  *                       - TIM2_FLAG_CC3OF: TIM2 Capture Compare 3 overcapture Flag
  * @retval FlagStatus The new state of TIM2_FLAG (SET or RESET).
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Check whether the TIM2_FLAG_UPDATE flag is set or not.
  * @code
  * FlagStatus FlagValue;
  * FlagValue = TIM2_GetFlagStatus(TIM2_FLAG_Update);
  * @endcode
  */
FlagStatus TIM2_GetFlagStatus(u16 TIM2_FLAG)
{
    FlagStatus bitstatus = RESET;
    u8 tim2_flag_l, tim2_flag_h;

    /* Check the parameters */
    assert_param(IS_TIM2_GET_FLAG_OK(TIM2_FLAG));

    tim2_flag_l= (u8)(TIM2_FLAG);
    tim2_flag_h= (u8)(TIM2_FLAG >> 8);

    if (((TIM2->SR1 & tim2_flag_l)|(TIM2->SR2 & tim2_flag_h)) != (u8)RESET )
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
  * @brief Clears the TIM2’s pending flags.
  * @param[in] TIM2_FLAG specifies the flag to clear.
  * This parameter can be one of the following values:
  *                       - TIM2_FLAG_UPDATE: TIM2 update Flag
  *                       - TIM2_FLAG_CC1: TIM2 Capture Compare 1 Flag
  *                       - TIM2_FLAG_CC2: TIM2 Capture Compare 2 Flag
  *                       - TIM2_FLAG_CC3: TIM2 Capture Compare 3 Flag
  *                       - TIM2_FLAG_CC1OF: TIM2 Capture Compare 1 overcapture Flag
  *                       - TIM2_FLAG_CC2OF: TIM2 Capture Compare 2 overcapture Flag
  *                       - TIM2_FLAG_CC3OF: TIM2 Capture Compare 3 overcapture Flag
  * @retval void None.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Clear the TIM2_FLAG_UPDATE flag.
  * @code
  * TIM2_ClearFlag(TIM2_FLAG_Update);
  * @endcode
  */
void TIM2_ClearFlag(u16 TIM2_FLAG)
{
    u8 tim2_flag_l, tim2_flag_h;
    /* Check the parameters */
    assert_param(IS_TIM2_CLEAR_FLAG_OK(TIM2_FLAG));

    tim2_flag_l= (u8)(TIM2_FLAG);
    tim2_flag_h= (u8)(TIM2_FLAG >> 8);
    /* Clear the flags (rc_w0) clear this bit by writing 0. Writing ‘1’ has no effect*/
    TIM2->SR1 &= (u8)(~tim2_flag_l);
    TIM2->SR2 &= (u8)(~tim2_flag_h);
}


/**
  * @brief Checks whether the TIM2 interrupt has occurred or not.
  * @param[in] TIM2_IT specifies the TIM2 interrupt source to check.
  * This parameter can be one of the following values:
  *                       - TIM2_IT_UPDATE: TIM2 update Interrupt source
  *                       - TIM2_IT_CC1: TIM2 Capture Compare 1 Interrupt source
  *                       - TIM2_IT_CC2: TIM2 Capture Compare 2 Interrupt source
  *                       - TIM2_IT_CC3: TIM2 Capture Compare 3 Interrupt source
  * @retval ITStatus The new state of the TIM2_IT(SET or RESET).
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Check whether the TIM2_IT_UPDATE interrupt has occurred or not.
  * @code
  * ITStatus ITValue;
  * ITValue = TIM2_GetITStatus(TIM2_FLAG_Update);
  * @endcode
  */

ITStatus TIM2_GetITStatus(u8 TIM2_IT)
{
    ITStatus bitstatus = RESET;

    u8 TIM2_itStatus = 0x0, TIM2_itEnable = 0x0;

    /* Check the parameters */
    assert_param(IS_TIM2_GET_IT_OK(TIM2_IT));

    TIM2_itStatus = (u8)(TIM2->SR1 & TIM2_IT);

    TIM2_itEnable = (u8)(TIM2->IER & TIM2_IT);

    if ((TIM2_itStatus != (u8)RESET ) && (TIM2_itEnable != (u8)RESET ))
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
  * @brief Clears the TIM2's interrupt pending bits.
  * @param[in] TIM2_IT specifies the pending bit to clear.
  * This parameter can be one of the following values:
  *                       - TIM2_IT_UPDATE: TIM2 update Interrupt source
  *                       - TIM2_IT_CC1: TIM2 Capture Compare 1 Interrupt source
  *                       - TIM2_IT_CC2: TIM2 Capture Compare 2 Interrupt source
  *                       - TIM2_IT_CC3: TIM2 Capture Compare 3 Interrupt source
  * @retval void None.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Clear the TIM2_IT_UPDATE interrupt pending bit.
  * @code
  * TIM2_ClearITPendingBit(TIM2_IT_Update);
  * @endcode
  */
void TIM2_ClearITPendingBit(u8 TIM2_IT)
{
    /* Check the parameters */
    assert_param(IS_TIM2_IT_OK(TIM2_IT));

    /* Clear the IT pending Bit */
    TIM2->SR1 &= (u8)(~TIM2_IT);
}


/**
  * @brief Configure the TI1 as Input.
  * @param[in] TIM2_ICPolarity  The Input Polarity.
  * This parameter can be one of the following values:
  *                       - TIM2_ICPOLARITY_FALLING
  *                       - TIM2_ICPOLARITY_RISING
  * @param[in] TIM2_ICSelection specifies the input to be used.
  * This parameter can be one of the following values:
  *                       - TIM2_ICSELECTION_DIRECTTI: TIM2 Input 1 is selected to
  *                         be connected to IC1.
  *                       - TIM2_ICSELECTION_INDIRECTTI: TIM2 Input 1 is selected to
  *                         be connected to IC2.
  * @param[in] TIM2_ICFilter Specifies the Input Capture Filter.
  * This parameter must be a value between 0x00 and 0x0F.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Configure the TI1 as Input selected to be connected to IC1 with Rising Polarity and 0x0E as Filter value.
  * @code
  * TI1_Config(TIM2_ICPOLARITY_RISING, TIM2_ICSELECTION_DIRECTTI,0x0E);
  * @endcode
  */
static void TI1_Config(u8 TIM2_ICPolarity, u8 TIM2_ICSelection,
                       u8 TIM2_ICFilter)
{
    u8 tmpccmr1 = 0;
    u8 tmpicpolarity = TIM2_ICPolarity;
    tmpccmr1 = TIM2->CCMR1;

    /* Disable the Channel 1: Reset the CCE Bit */
    TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1E);

    /* Select the Input and set the filter */
    tmpccmr1 &= (u8)(~TIM2_CCMR_CCxS) & (u8)(~TIM2_CCMR_ICxF);
    tmpccmr1 |= (u8)(((u8)(TIM2_ICSelection)) | ((u8)(TIM2_ICFilter << 4)));

    TIM2->CCMR1 = tmpccmr1;


    /* Select the Polarity */
    if (tmpicpolarity == TIM2_ICPOLARITY_FALLING)
    {
        TIM2->CCER1 |= TIM2_CCER1_CC1P ;
    }
    else
    {
        TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1P) ;
    }

    /* Set the CCE Bit */
    TIM2->CCER1 |=  TIM2_CCER1_CC1E;
}


/**
  * @brief Configure the TI2 as Input.
  * @param[in] TIM2_ICPolarity  The Input Polarity.
  * This parameter can be one of the following values:
  *                       - TIM2_ICPOLARITY_FALLING
  *                       - TIM2_ICPOLARITY_RISING
  * @param[in] TIM2_ICSelection specifies the input to be used.
  * This parameter can be one of the following values:
  *                       - TIM2_ICSELECTION_DIRECTTI: TIM2 Input 2 is selected to
  *                         be connected to IC2.
  *                       - TIM2_ICSELECTION_INDIRECTTI: TIM2 Input 2 is selected to
  *                         be connected to IC1.
  * @param[in] TIM2_ICFilter Specifies the Input Capture Filter.
  * This parameter must be a value between 0x00 and 0x0F.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * * Configure the TI2 as Input selected to be connected to IC2 with Rising Polarity and 0x0E as Filter value.
  * @code
  * TI2_Config(TIM2_ICPOLARITY_RISING, TIM2_ICSELECTION_DIRECTTI,0x0E);
  * @endcode
  */
static void TI2_Config(u8 TIM2_ICPolarity, u8 TIM2_ICSelection,
                       u8 TIM2_ICFilter)
{
    u8 tmpccmr2 = 0;
    u8 tmpicpolarity = TIM2_ICPolarity;

    tmpccmr2 = TIM2->CCMR2;

    /* Disable the Channel 2: Reset the CCE Bit */
    TIM2->CCER1 &=  (u8)(~TIM2_CCER1_CC2E);

    /* Select the Input and set the filter */
    tmpccmr2 &= (u8)(~TIM2_CCMR_CCxS) & (u8)(~TIM2_CCMR_ICxF);
    tmpccmr2 |= (u8)(((u8)(TIM2_ICSelection)) | ((u8)(TIM2_ICFilter << 4)));

    TIM2->CCMR2 = tmpccmr2;

    /* Select the Polarity */
    if (tmpicpolarity == TIM2_ICPOLARITY_FALLING)
    {
        TIM2->CCER1 |= TIM2_CCER1_CC2P ;
    }
    else
    {
        TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC2P) ;
    }

    /* Set the CCE Bit */
    TIM2->CCER1 |=  TIM2_CCER1_CC2E;

}

/**
  * @brief Configure the TI3 as Input.
  * @param[in] TIM2_ICPolarity  The Input Polarity.
  * This parameter can be one of the following values:
  *                       - TIM2_ICPOLARITY_FALLING
  *                       - TIM2_ICPOLARITY_RISING
  * @param[in] TIM2_ICSelection specifies the input to be used.
  * This parameter can be one of the following values:
  *                       - TIM2_ICSELECTION_DIRECTTI: TIM2 Input 3 is selected to
  *                         be connected to IC3.
  * @param[in] TIM2_ICFilter Specifies the Input Capture Filter.
  * This parameter must be a value between 0x00 and 0x0F.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * * Configure the TI3 as Input selected to be connected to IC3 with Rising Polarity and 0x0E as Filter value.
  * @code
  * TI3_Config(TIM2_ICPOLARITY_RISING, TIM2_ICSELECTION_DIRECTTI,0x0E);
  * @endcode
  */
static void TI3_Config(u8 TIM2_ICPolarity, u8 TIM2_ICSelection,
                       u8 TIM2_ICFilter)
{

    u8 tmpccmr3 = 0;
    u8 tmpicpolarity = TIM2_ICPolarity;

    assert_param(IS_TIM2_IC_SELECTION1_OK(TIM2_ICSelection));


    tmpccmr3 = TIM2->CCMR3;

    /* Disable the Channel 3: Reset the CCE Bit */
    TIM2->CCER2 &=  (u8)(~TIM2_CCER2_CC3E);

    /* Select the Input and set the filter */
    tmpccmr3 &= (u8)(~TIM2_CCMR_CCxS) & (u8)(~TIM2_CCMR_ICxF);
    tmpccmr3 |= (u8)(((u8)(TIM2_ICSelection)) | ((u8)(TIM2_ICFilter << 4)));

    TIM2->CCMR3 = tmpccmr3;

    /* Select the Polarity */
    if (tmpicpolarity == TIM2_ICPOLARITY_FALLING)
    {
        TIM2->CCER2 |= TIM2_CCER2_CC3P ;
    }
    else
    {
        TIM2->CCER2 &= (u8)(~TIM2_CCER2_CC3P) ;
    }
    /* Set the CCE Bit */
    TIM2->CCER2 |=  TIM2_CCER2_CC3E;
}
/**
  * @}
  */
/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
