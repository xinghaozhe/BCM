/**
  ******************************************************************************
  * @file stm8_clk.c
  * @brief This file contains all the functions for the CLK peripheral.
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

#include "stm8_clk.h"

/* LINKER SECTIONS DEFINITION FOR THIS FILE ONLY */
#ifdef USE_COSMIC_SECTIONS
#pragma section (CLK_CODE)
#pragma section const {CLK_CONST}
#pragma section @near [CLK_URAM]
#pragma section @near {CLK_IRAM}
#pragma section @tiny [CLK_UZRAM]
#pragma section @tiny {CLK_IZRAM}
#endif

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/

/* Private Constants ---------------------------------------------------------*/

/**
  * @addtogroup CLK_Private_Constants
  * @{
  */

uc8 HSIDivFactor[4] = {1, 2, 4, 8}; /*!< Holds the different HSI Dividor factors */
uc8 CLKPrescTable[8] = {1, 2, 4, 8, 10, 16, 20, 40}; /*!< Holds the different CLK prescaler values */

/**
  * @}
  */

/* Public functions ----------------------------------------------------------*/
/**
  * @addtogroup CLK_Public_Functions
  * @{
  */

/**
  * @brief Deinitializes the CLK peripheral registers to their default reset
  * values.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
   * @par Warning:
  *  Resetting the CCOR register: \n
  * When the CCOEN bit is set, the reset of the CCOR register require
  * two consecutive write instructions in order to reset first the CCOEN bit
  * and the second one is to reset the CCOSEL bits.
  * @par Called functions:
  * None
  * @par Example:
  * This example shows how to call the function:
  * @code
  * CLK_DeInit();
  * @endcode
  */
void CLK_DeInit(void)
{

  CLK->ICKR = CLK_ICKR_RESET_VALUE;
  CLK->ECKR = CLK_ECKR_RESET_VALUE;
  CLK->SWR  = CLK_SWR_RESET_VALUE;
  CLK->SWCR = CLK_SWCR_RESET_VALUE;
  CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  CLK->CSSR = CLK_CSSR_RESET_VALUE;
  CLK->CCOR = CLK_CCOR_RESET_VALUE;
  while(CLK->CCOR & CLK_CCOR_CCOEN);
  CLK->CCOR = CLK_CCOR_RESET_VALUE;
  CLK->CANCCR = CLK_CANCCR_RESET_VALUE;
  CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
  CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;

}

/**
  * @brief Fills CLK_InitStruct members with default value.
  * @param[in] CLK_InitStruct Pointer to CLK_Init_TypeDef structure that will be initialized.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * CLK_Init_TypeDef CLK_InitStructure;
  * CLK_StructInit(&CLK_InitStructure);
  * @endcode
  */
void CLK_StructInit(CLK_Init_TypeDef* CLK_InitStruct)
{
  /* Reset CLK init structure parameters values */
  /* Initialize the CLK fast wake up from halt */
  CLK_InitStruct->CLK_FastHaltWakeup              = DISABLE;

  /* Initialize the CLK Prescaler division factor */
  CLK_InitStruct->CLK_HSIPrescaler                = CLK_PRESCALER_HSIDIV8;

  /* Initialize the CLK switch mode */
  CLK_InitStruct->CLK_SwitchMode       = CLK_SWITCHMODE_AUTO;

  /* Initialize the new clock selection */
  CLK_InitStruct->CLK_NewClock         = CLK_SOURCE_HSI;

  /* Initialize the CLK switch interrupt status */
  CLK_InitStruct->CLK_SwitchIT         = DISABLE;

  /* Initialize the current CLK state */
  CLK_InitStruct->CLK_CurrentClockState           = CLK_CURRENTCLOCKSTATE_ENABLE;

}

/**
  * @brief Initializes the CLK peripheral according to the specified parameters
  * in the CLK_InitStruct structure.
  * @param[in] CLK_InitStruct: pointer to an CLK_Init_TypeDef structure that
  * contains the configuration information of the CLK peripheral.
  * @retval void None
  * @par Required preconditions:
  *  Call the CLK_DeInit function or the CLK_StructInit function
  * @par Called functions:
  * - CLK_ClockSwitchConfig();
  * - CLK_HSIConfig();
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * ErrorStatus val;
  * val = CLK_Init(&CLK_InitStructure);
  * if (val == ERROR) { ... }
  * @endcode
  */
ErrorStatus CLK_Init(CLK_Init_TypeDef* CLK_InitStruct)
{
  ErrorStatus Status = ERROR;

  /* Check the parameters */
  assert_param(IS_CLK_SOURCE_OK(CLK_InitStruct->CLK_NewClock));
  assert_param(IS_CLK_SWITCHMODE_OK(CLK_InitStruct->CLK_SwitchMode));
  assert_param(IS_FUNCTIONALSTATE_OK(CLK_InitStruct->CLK_SwitchIT));
  assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_InitStruct->CLK_CurrentClockState));
  assert_param(IS_FUNCTIONALSTATE_OK(CLK_InitStruct->CLK_FastHaltWakeup));
  assert_param(IS_CLK_HSIPRESCALER_OK(CLK_InitStruct->CLK_HSIPrescaler));


  /* Select and configure Clock */
  if (CLK_InitStruct->CLK_NewClock != CLK_SOURCE_HSI)
  {
    Status = CLK_ClockSwitchConfig(CLK_InitStruct->CLK_SwitchMode, CLK_InitStruct->CLK_NewClock, CLK_InitStruct->CLK_SwitchIT, CLK_InitStruct->CLK_CurrentClockState);
  }
  else /* CLK_InitStruct->CLK_NewClock == CLK_SOURCE_HSI*/
  {
    CLK_HSIConfig(CLK_InitStruct->CLK_FastHaltWakeup, CLK_InitStruct->CLK_HSIPrescaler);
    Status = SUCCESS;
  }
  return Status;
}

/**
  * @brief Enable or Disable the External High Speed oscillator (HSE).
  * @param[in] CLK_NewState new state of HSEEN, value accepted ENABLE, DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_HSECmd(ENABLE);
  * @endcode
  */
void CLK_HSECmd(FunctionalState CLK_NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));

  if (CLK_NewState != DISABLE)
  {
    /* Set HSEEN bit */
    CLK->ECKR |= CLK_ECKR_HSEEN;
  }
  else
  {
    /* Reset HSEEN bit */
    CLK->ECKR &= (u8)(~CLK_ECKR_HSEEN);
  }
}

/**
  * @brief Enables or disables the Internal High Speed oscillator (HSI).
   * @param[in] CLK_NewState new state of HSIEN, value accepted ENABLE, DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_HSICmd(ENABLE);
  * @endcode
  */
void CLK_HSICmd(FunctionalState CLK_NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));

  if (CLK_NewState != DISABLE)
  {
    /* Set HSIEN bit */
    CLK->ICKR |= CLK_ICKR_HSIEN;
  }
  else
  {
    /* Reset HSIEN bit */
    CLK->ICKR &= (u8)(~CLK_ICKR_HSIEN);
  }
}

/**
  * @brief Enables or disables the Internal Low Speed oscillator (LSI).
   * @param[in]  CLK_NewState new state of LSIEN, value accepted ENABLE, DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_LSICmd(ENABLE);
  * @endcode
  */
void CLK_LSICmd(FunctionalState CLK_NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));

  if (CLK_NewState != DISABLE)
  {
    /* Set LSIEN bit */
    CLK->ICKR |= CLK_ICKR_LSIEN;
  }
  else
  {
    /* Reset LSIEN bit */
    CLK->ICKR &= (u8)(~CLK_ICKR_LSIEN);
  }
}

/**
  * @brief Enables or disablle the Configurable Clock Output (CCO).
  * @param[in] CLK_NewState new state of CCEN bit (CCO register), value accepted ENABLE, DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_CCOCmd(ENABLE)
  * @endcode
  */
void CLK_CCOCmd(FunctionalState CLK_NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));

  if (CLK_NewState != DISABLE)
  {
    /* Set CCOEN bit */
    CLK->CCOR |= CLK_CCOR_CCOEN;
  }
  else
  {
    /* Reset CCOEN bit */
    CLK->CCOR &= (u8)(~CLK_CCOR_CCOEN);
  }

}


/**
  * @brief Starts or Stops manually the clock switch execution.
  * @par Full description:
  * CLK_NewState parameter set the SWEN.
  * @param[in] CLK_NewState new state of SWEN, value accepted ENABLE, DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_ClockSwitchCmd(ENABLE);
  * @endcode
  */

void CLK_ClockSwitchCmd(FunctionalState CLK_NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));

  if (CLK_NewState != DISABLE )
  {
    /* Enable the Clock Switch */
    CLK->SWCR |= CLK_SWCR_SWEN;
  }
  else
  {
    /* Disable the Clock Switch */
    CLK->SWCR &= (u8)(~CLK_SWCR_SWEN);
  }
}

/**
  * @brief  Enables or disables the specified peripheral CLK.
  * @param[in] CLK_Peripheral this parameter specifies the peripheral clock to gate.
  * It can be set of the values of @ref CLK_Peripheral_TypeDef.
  * @param[in] CLK_NewState new state of specified peripheral clock, value accepted ENABLE, DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
  * @endcode
  */
void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState CLK_NewState)
{
  
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));
  assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));

  if ((CLK_Peripheral & 0x10) == 0x0)
  {
	  if (CLK_NewState != DISABLE)
	  {
		  /* Enable the peripheral Clock */
		  CLK->PCKENR1 |= (u8)((u8)1 << (u8)(CLK_Peripheral & (u8)0x0F));
	  }
	  else
	  {
		  /* Disable the peripheral Clock */
		  CLK->PCKENR1 &= (u8)(~(u8)(((u8)1 << (u8)(CLK_Peripheral & (u8)0x0F))));
	  }
  }
  else
  {
	  if (CLK_NewState != DISABLE)
	  {
		  /* Enable the peripheral Clock */
		  CLK->PCKENR2 |= (u8)((u8)1 << (u8)(CLK_Peripheral & (u8)0x0F));
	  }
	  else
	  {
		  /* Disable the peripheral Clock */
		  CLK->PCKENR2 &= (u8)(~(u8)(((u8)1 << (u8)(CLK_Peripheral & (u8)0x0F))));
	  }
  }
}

/**
  * @brief Switch from one clock to another with or without interrupt,
  * and switch off or not the previous clock.
  * @param[in] CLK_SwitchMode select the clock switch mode.
  * It can be set of the values of @ref CLK_SwitchMode_TypeDef
  * @param[in] CLK_NewClock choice of the future clock.
  * It can be set of the values of @ref CLK_Source_TypeDef
  * @param[in] CLK_SwitchIT Enable or Disable the Clock Switch interrupt.
  * @param[in] CLK_CurrentClockState current clock to switch OFF or to keep ON.
  * It can be set of the values of @ref CLK_CurrentClockState_TypeDef
  * @retval ErrorStatus this shows the clock switch status (ERROR/SUCCESS).
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * ErrorStatus val;
  * val = CLK_CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
  * if (val == ERROR) { ... }
  * @endcode
  */
ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState CLK_SwitchIT, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
{
  CLK_Source_TypeDef clock_master;
  u16 DownCounter = CLK_TIMEOUT;
  ErrorStatus Swif = ERROR;

  /* Check the parameters */
  assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
  assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
  assert_param(IS_FUNCTIONALSTATE_OK(CLK_SwitchIT));
  assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));

  /*option byte config */
  if (CLK_NewClock == CLK_SOURCE_LSI)
  {
    *(unsigned char*)0x5069 = 0x08;
    *(unsigned char*)0x506A = (u8)(~0x08);
  }

  /* Current clock master saving */
  clock_master = CLK->CMSR;

  /* Automatic switch mode management */
  if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
  {
    /* Enables Clock switch */
    CLK->SWCR |= CLK_SWCR_SWEN;
    /* Enables or Disables Switch interrupt */
    if (CLK_SwitchIT != DISABLE)
    {
      CLK->SWCR |= CLK_SWCR_SWIEN;
    }
    else
    {
      CLK->SWCR &= (u8)(~CLK_SWCR_SWIEN);
    }
    /* Selection of the target clock source */
    CLK->SWR = (u8)CLK_NewClock;
   
      while (((CLK->SWCR & CLK_SWCR_SWBSY) && (DownCounter != 0)))
      {
        DownCounter--;
      }
      if (DownCounter != 0)
      {
        Swif = SUCCESS;
      }
    
  }
  else /* CLK_SwitchMode == CLK_SWITCHMODE_MANUAL */
  {
    /* Enables or Disables Switch interrupt  if required  */
    if (CLK_SwitchIT != DISABLE)
    {
      CLK->SWCR |= CLK_SWCR_SWIEN;
    }
    else
    {
      CLK->SWCR &= (u8)(~CLK_SWCR_SWIEN);
    }
    /* Selection of the target clock source */
    CLK->SWR = (u8)CLK_NewClock;
    /* In manual mode, there is no risk to be stucked in a loop, value returned
      is then always SUCCESS */
    Swif = SUCCESS;
  }
  /* Switch OFF current clock if required */
  if (CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE)
  {
    switch (clock_master)
    {
      case CLK_SOURCE_HSI:
        CLK->ICKR &= (u8)(~CLK_ICKR_HSIEN);
        break;
      case CLK_SOURCE_LSI:
        CLK->ICKR &= (u8)(~CLK_ICKR_LSIEN);
        break;
      case CLK_SOURCE_HSE:
        CLK->ECKR &= (u8)(~CLK_ECKR_HSEEN);
        break;
      default:
        break;
    }
  }
  return Swif;
}

/**
  * @brief  Configures the High Speed Internal oscillator (HSI).
  * @par Full description:
  * If CLK_FastHaltWakeup is enabled, HSI oscillator is automatically
  * switched-on (HSIEN=1) and selected as next clock master
  * (CKM=SWI=HSI) when resuming from HALT/ActiveHalt modes.\n
  * @param[in] CLK_FastHaltWakeup this parameter is the Wake-up Mode.
  * @param[in] HSIPrescaler this second parameter is the Clock Prescaler.
  * It can be set of the values of @ref CLK_Prescaler_TypeDef
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_HSIConfig(ENABLE, CLK_PRESCALER_HSIDIV2);
  * @endcode
  */
void CLK_HSIConfig(FunctionalState CLK_FastHaltWakeup, CLK_Prescaler_TypeDef HSIPrescaler)
{

  /* check teh parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(CLK_FastHaltWakeup));
  assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));

  /* Clear High speed internal clock prescaler */
  CLK->CKDIVR &= (u8)(~CLK_CKDIVR_HSIDIV);

  /* Set High speed internal clock prescaler */
  CLK->CKDIVR |= (u8)HSIPrescaler;

  if (CLK_FastHaltWakeup != DISABLE)
  {
    /* Set FHWU bit (HSI oscillator is automatically switched-on) */
    CLK->ICKR |= CLK_ICKR_FHWU;
  }
  else  /* FastHaltWakeup = DISABLE */
  {
    /* Reset FHWU bit */
    CLK->ICKR &= (u8)(~CLK_ICKR_FHWU);
  }
}

/**
  * @brief Configures the Low Speed Internal oscillator (LSI).
  * @param[in] CLK_SlowActiveHalt specifies the Fast or Slow Active Halt mode.
   * can be set of the following values:
  * - DISABLE: Slow Active Halt mode disabled;
  * - ENABLE:  Slow Active Halt mode enabled.
  * @retval  void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_LSIConfig(ENABLE);
  * @endcode
  */
void CLK_LSIConfig(FunctionalState CLK_SlowActiveHalt)
{
  /* check teh parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(CLK_SlowActiveHalt));

  if (CLK_SlowActiveHalt != DISABLE)
  {
    /* Set S_ACTHALT bit */
    CLK->ICKR |= CLK_ICKR_SWUAH;
  }
  else
  {
    /* Reset S_ACTHALT bit */
    CLK->ICKR &= (u8)(~CLK_ICKR_SWUAH);
  }

}

/**
  * @brief Output the selected clock on a dedicated I/O pin.
  * @param[in] CLK_CCO specifies the clock source.
  * @retval void None
  * @par Required preconditions:
  * The dedicated I/O pin must be set at 1 in the corresponding Px_CR1 register \n
  * to be set as input with pull-up or push-pull output.
  * @par Called functions:
  * -  CLK_CCOCmd();
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_CCOConfig(CLK_OUTPUT_HSE );
  * @endcode
  */
void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
{
  /* check teh parameters */
  assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));

  /* Clears of the CCO type bits part */
  CLK->CCOR &= (u8)(~CLK_CCOR_CCOSEL);

  /* Selects the source provided on cco_ck output */
  CLK->CCOR |= CLK_CCO;

  /* Enable the clock output */
  CLK_CCOCmd(ENABLE);
}

/**
  * @brief  Enables or disables the specified CLK interrupts.
   * @param[in] CLK_IT This parameter specifies the interrupt sources.
   * It can be one of the values of @ref CLK_IT_TypeDef.
  * @param[in] IT_NewState New state of the Interrupt.
  * Value accepted ENABLE, DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_ITConfig(CLK_IT_SWIE, ENABLE);
  * @endcode
  */
void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState IT_NewState)
{
  /* check teh parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(IT_NewState));
  assert_param(IS_CLK_IT_OK(CLK_IT));

  if (IT_NewState != DISABLE)
  {
    switch (CLK_IT)
    {
      case CLK_IT_SWIE: /* Enable the clock switch interrupt */
        CLK->SWCR |= CLK_SWCR_SWIEN;
        break;
      case CLK_IT_CSSDIE: /* Enable the clock security system detection interrupt */
        CLK->CSSR |= CLK_CSSR_CSSDIE;
        break;
      default:
        break;
    }
  }
  else  /*(IT_NewState == DISABLE)*/
  {
    switch (CLK_IT)
    {
      case CLK_IT_SWIE: /* Disable the clock switch interrupt */
        CLK->SWCR  &= (u8)(~CLK_SWCR_SWIEN);
        break;
      case CLK_IT_CSSDIE: /* Disable the clock security system detection interrupt */
        CLK->CSSR &= (u8)(~CLK_CSSR_CSSDIE);
        break;
      default:
        break;
    }
  }
}

/**
  * @brief Configures the HSI and CPU clock dividers.
  * @param[in] ClockPrescaler Specifies the HSI or CPU clock divider to apply.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * These examples shows how to call the function:
  * @code
  * CLK_SYSCLKConfig(CLK_HSI_DIV2);
  * or
  * CLK_SYSCLKConfig(CLK_CPU_DIV8);
  * @endcode
  */
void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef ClockPrescaler)
{

  /* check teh parameters */
  assert_param(IS_CLK_PRESCALER_OK(ClockPrescaler));


  if ((ClockPrescaler & (u8)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
  {
    CLK->CKDIVR &= (u8)(~CLK_CKDIVR_HSIDIV);
    CLK->CKDIVR |= (u8)(ClockPrescaler & CLK_CKDIVR_HSIDIV);
  }
  else /* Bit7 = 1 means CPU divider */
  {
    CLK->CKDIVR &= (u8)(~CLK_CKDIVR_CPUDIV);
    CLK->CKDIVR |= (u8)(ClockPrescaler & CLK_CKDIVR_CPUDIV);
  }

}
/**
  * @brief Configures the SWIM clock frequency on the fly.
  * @param[in] CLK_SWIMDivider Specifies the SWIM clock divider to apply.
  * can be one of the value of @ref CLK_SWIMDivider_TypeDef
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * These examples shows how to call the function:
  * @code
  * CLK_SWIMConfig(CLK_SWIMDIVIDER_2);
  * @endcode
  */
void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
{
  /* check teh parameters */
  assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));

  if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
  {
    /* SWIM clock is not divided by 2 */
    CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
  }
  else /* CLK_SWIMDivider == CLK_SWIMDIVIDER_2 */
  {
    /* SWIM clock is divided by 2 */
    CLK->SWIMCCR &= (u8)(~CLK_SWIMCCR_SWIMDIV);
  }
}

/**
  * @brief Configure the divider for the external CAN clock.
  * @param[in] CLK_CANDivider Specifies the CAN clock divider to apply.
  * can be one of the value of @ref CLK_CANDivider_TypeDef
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * These examples shows how to call the function:
  * @code
  * CLK_CANConfig(CLK_CANDIVIDER_1);
  * @endcode
  */
void CLK_CANConfig(CLK_CANDivider_TypeDef CLK_CANDivider)
{
  /* check teh parameters */
  assert_param(IS_CLK_CANDIVIDER_OK(CLK_CANDivider));

  /*Clear the CANDIV bits */
  CLK->CANCCR &= (u8)(~CLK_CANCCR_CANDIV);

  /* Select divider*/
  CLK->CANCCR |= CLK_CANDivider;
}

/**
  * @brief Enables the Clock Security System.
  * @par Full description:
  * once CSS is enabled it cannot be disabled until the next reset.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_ClockSecuritySystemEnable();
  * @endcode
  */
void CLK_ClockSecuritySystemEnable(void)
{
  /* Set CSSEN bit  */
  CLK->CSSR |= CLK_CSSR_CSSEN;
}

/**
  * @brief Returns the clock source used as system clock.
  * @par Parameters:
  * None
  * @retval  Clock source used.
  * can be one of the values of @ref CLK_Source_TypeDef
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  *CLK_Source_TypeDef val;
  * val = CLK_GetSYSCLKSource();
  * @endcode
  */
CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
{
  return((CLK_Source_TypeDef)CLK->CMSR);
}


/**
  * @brief Checks whether the specified CLK interrupt has is enabled or not.
  * @param[in] CLK_IT specifies the CLK interrupt.
  * can be one of the values of @ref CLK_IT_TypeDef
  * @retval ITStatus, new state of CLK_IT (SET or RESET).
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * ITStatus val;
  * val = CLK_GetITStatus(CLK_IT_SWIE);
  * if (val == RESET) { ... }
  * @endcode
  */
ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
{
  ITStatus bitstatus = RESET;

  /* check teh parameters */
  assert_param(IS_CLK_IT_OK(CLK_IT));

  if (CLK_IT == CLK_IT_SWIE)
  {
    /* Check the status of the clock switch interrupt */
    if ((CLK->SWCR & (u8)CLK_SWCR_SWIEN) != (u8)RESET)
    {
      bitstatus = SET;
    }
    else
    {
      bitstatus = RESET;
    }
  }
  else /* CLK_IT == CLK_IT_CSSDIE */
  {
    /* Check the status of the security system detection interrupt */
    if ((CLK->CSSR & (u8)CLK_CSSR_CSSDIE) != (u8)RESET)
    {
      bitstatus = SET;
    }
    else
    {
      bitstatus = RESET;
    }
  }

  /* Return the CLK_IT status */
  return  bitstatus;
}

/**
  * @brief Checks whether the specified CLK flag is set or not.
  * @par Full description:
  * @param[in] CLK_FLAG Flag to check.
  * can be one of the values of @ref CLK_Flag_TypeDef
  * @retval FlagStatus, status of the checked flag
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_GetFlagStatus(CLK_FLAG_LSIRDY);
  * @endcode
  */
FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
{
  u16 statusreg = 0;
  u8 tmpreg = 0;
  FlagStatus bitstatus = RESET;

  /* check teh parameters */
  assert_param(IS_CLK_FLAG_OK(CLK_FLAG));

  /* Get the CLK register index */
  //statusreg = (u8)(CLK_FLAG >> (u8)8);
  statusreg = (CLK_FLAG &= 0xFF00);
  switch (statusreg)
  {
    case 0x100: /* The flag to check is in ICKRregister */
      tmpreg = CLK->ICKR;
      break;
    case 0x200: /* The flag to check is in ECKRregister */
      tmpreg = CLK->ECKR;
      break;
    case 0x300: /* The flag to check is in SWIC register */
      tmpreg = CLK->SWCR;
      break;
    case 0x400: /* The flag to check is in CSS register */
      tmpreg = CLK->CSSR;
      break;
    case 0x500: /* The flag to check is in CCO register */
      tmpreg = CLK->CCOR;
      break;
    default:
      break;
  }

  if ((tmpreg & (u8)CLK_FLAG) != (u8)RESET)
  {
    bitstatus = SET;
  }
  else
  {
    bitstatus = RESET;
  }

  /* Return the flag status */
  return (u8)bitstatus;
}

/**
  * @brief This function returns the frequencies of different on chip clocks.
   * @par Parameters:
  * None
  * @retval the master clock frequency
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * u32 masterfrequency = 0;
  * masterfrequency = CLK_GetClockFreq();
  * @endcode
  */
u32 CLK_GetClockFreq(void)
{

  u32 clockfrequency = 0;
  CLK_Source_TypeDef clocksource = 0xE1;
  u8 tmp = 0, presc = 0;

  /* Get CLK source. */
  clocksource = CLK->CMSR;

  switch (clocksource)
  {
    case CLK_SOURCE_HSI:
      tmp = (u8)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
      tmp = (u8)(tmp >> 3);
      presc = HSIDivFactor[tmp];
      clockfrequency = HSI_VALUE / presc;
      break;
    case CLK_SOURCE_LSI:
      clockfrequency = LSI_VALUE;
      break;
    case CLK_SOURCE_HSE:
      clockfrequency = HSE_VALUE;
      break;
    default:
      break;
  }
  return((u32)clockfrequency);
}

/**
  * @brief Adjusts the Internal High Speed oscillator (HSI) calibration value.
  * @par Full description:
  * @param[in] CLK_HSICalibrationValue calibration trimming value.
  * can be one of the values of @ref CLK_HSITrimValue_TypeDef
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_AdjustHSICalibrationValue(CLK_HSITRIMVALUE_5)
  * @endcode
  */
void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
{

  /* check the parameters */
  assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));

  /* Clear HSITRIM[2:0] bits */
  CLK->HSITRIMR &= (u8)(~CLK_HSITRIMR_HSITRIM);

  /* Store the new value */
  CLK->HSITRIMR |= (u8)CLK_HSICalibrationValue;

}

/**
  * @brief Clears the CLK’s interrupt pending bits.
  * @param[in] CLK_PendingBit specifies the interrupt pending bits.
  * can be one of the values of @ref CLK_PendingBit_TypeDef
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_ClearITPendingBit(CLK_PENDINGBIT_CSSD);
  * @endcode
  */
void CLK_ClearITPendingBit(CLK_PendingBit_TypeDef CLK_PendingBit)
{
  /* check the parameters */
  assert_param(IS_CLK_PENDINGBIT_OK(CLK_PendingBit));

  if (CLK_PendingBit == (u8)CLK_PENDINGBIT_CSSD)
  {
    /* Clear the status of the security system detection interrupt */
    CLK->CSSR  &= (u8)(~CLK_CSSR_CSSD);
  }
  else /* CLK_PendingBit == (u8)CLK_PENDINGBIT_SWIF */
  {
    /* Clear the status of the clock switch interrupt */
    CLK->SWCR &= (u8)(~CLK_SWCR_SWIF);
  }

}

/**
  * @brief Reset the SWBSY flag (SWICR Reister)
  * @par Full description:
  * This function reset SWBSY flag in order to reset clock switch operations (target
  * oscillator is broken, stabilization is longing too much, etc.).  If at the same time \n
  * software attempts to set SWEN and clear SWBSY, SWBSY action takes precedence.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Examples:
  * This example shows how to call the function:
  * @code
  * CLK_SYSCLKEmergencyClear();
  * @endcode
  */
void CLK_SYSCLKEmergencyClear(void)
{
  CLK->SWCR &= (u8)(~CLK_SWCR_SWBSY);
}



/**
  * @}
  */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
