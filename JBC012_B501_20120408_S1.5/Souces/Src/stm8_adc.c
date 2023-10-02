/**
  ******************************************************************************
  * @file stm8_adc.c
  * @brief This file contains all the functions/macros for the ADC peripheral.
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
#include "stm8_adc.h"
 #include "adc_drv.h"

/* LINKER SECTIONS DEFINITION FOR THIS FILE ONLY */
#ifdef USE_COSMIC_SECTIONS
#pragma section (ADC_CODE)
#pragma section const {ADC_CONST}
#pragma section @near [ADC_URAM]
#pragma section @near {ADC_IRAM}
#pragma section @tiny [ADC_UZRAM]
#pragma section @tiny {ADC_IZRAM}
#endif

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/* Public functions ----------------------------------------------------------*/

/**
  * @addtogroup ADC_Public_Functions
  * @{
  */

/**
  * @brief Clear the ADC End of Conversion Flag.
  * @par Parameter:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Clears the end of conversion Flag
  * @code
  * ADC_ClearFlag();
  * @endcode
  */
void ADC_ClearFlag(void)
{
  ADC->CSR &= (u8)(~ADC_CSR_EOC);
}

/**
  * @brief Enables or Disables the ADC peripheral.
  * @param[in] NewState Specify the peripheral enabled or disabled state.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable the ADC peripheral.
  * @code
  * ADC_Cmd(ENABLE);
  * @endcode
  */
void ADC_Cmd(FunctionalState NewState)
{

  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));

  if (NewState != DISABLE)
  {
    ADC->CR1 |= ADC_CR1_ADON;
  }
  else /* NewState == DISABLE */
  {
    ADC->CR1 &= (u8)(~ADC_CR1_ADON);
  }

}

/**
  * @brief Start ADC conversion
  * @par Full description:
  * This function  triggers the start of conversion, after ADC configuration.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * Enable the ADC peripheral before calling this fuction
  * @par Called functions:
  * None
  * @par Example:
  * Start conversion
  * @code
  * ADC_StartConversion();
  * @endcode
  */
void ADC_StartConversion(void)
{
  ADC->CR1 |= ADC_CR1_ADON;
}


/**
  * @brief Deinitializes the ADC peripheral registers to their default reset
  * values.
  * @par Parameters:
  * None
  * @retval None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Initializes ADC to its reset values.
  * @code
  * ADC_DeInit();
  * @endcode
  */
void ADC_DeInit(void)
{
  ADC->CSR  = ADC_CSR_RESET_VALUE;
  ADC->CR1  = ADC_CR1_RESET_VALUE;
  ADC->CR2  = ADC_CR2_RESET_VALUE;
  ADC->TDRH = ADC_TDRH_RESET_VALUE;
  ADC->TDRL = ADC_TDRL_RESET_VALUE;
}


/**
  * @brief Fills ADC_InitStruct members with default value.
  * @param[in] ADC_InitStruct Pointer to ADC_Init_TypeDef structure that will be initialized.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * ADC_Init_TypeDef ADC_InitStructure;
  * ADC_StructInit(&ADC_InitStructure);
  * @endcode
  */
void ADC_StructInit(ADC_Init_TypeDef* ADC_InitStruct)
{
  /* Reset ADC init structure parameters values */
  /* Initialize the ADC conversion mode */
  ADC_InitStruct->ADC_ConversionMode = ADC_CONVERSIONMODE_SINGLE;

  /* Initialize the ADC Channels */
  ADC_InitStruct->ADC_Channel = ADC_CHANNEL_0;

  /* Initialize the ADC Prescaler division factor */
  ADC_InitStruct->ADC_PrescalerSelection = ADC_PRESSEL_FCPU_D2;

  /* Initialize the ADC external trigger event */
  ADC_InitStruct->ADC_ExtTrigger = ADC_EXTTRIG_TIM1;

  /* Initialize the ADC external trigger status */
  ADC_InitStruct->ADC_ExtTrigState = DISABLE;

  /* Initialize the ADC data alignement */
  ADC_InitStruct->ADC_Align = ADC_ALIGN_LEFT;

  /* Initialize the ADC schmitt trigger channel */
  ADC_InitStruct->ADC_SchmittTriggerChannel = ADC_SCHMITTTRIG_CHANNEL0;

  /* Initialize the ADC schmitt trigger status */
  ADC_InitStruct->ADC_SchmittTriggerState = ENABLE;
}


/**
  * @brief Configure the ADC conversion on selected channel.
  * @param[in] ADC_ConversionMode Specifies the conversion type.
  * It can be set of the values of @ref ADC_ConvMode_TypeDef
  * @param[in] ADC_Channel specifies the ADC Channel.
  * It can be set of the values of @ref ADC_Channel_TypeDef
  * @param[in] ADC_Align specifies the conerted data alignement.
  * It can be set of the values of @ref ADC_Align_TypeDef
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Configure the ADC conversion in continuous mode on channel 2
  * @code
  * ADC_ConversionConfig(ADC_CHANNEL_2, ADC_CONVERSIONMODE_CONTINUOUS, ADC_ALIGN_RIGHT);
  * @endcode
  */
void ADC_ConversionConfig(ADC_ConvMode_TypeDef ADC_ConversionMode, ADC_Channel_TypeDef ADC_Channel, ADC_Align_TypeDef ADC_Align)
{

  /* Check the parameters */
  assert_param(IS_ADC_CONVERSIONMODE_OK(ADC_ConversionMode));
  assert_param(IS_ADC_CHANNEL_OK(ADC_Channel));
  assert_param(IS_ADC_ALIGN_OK(ADC_Align));

  if (ADC_ConversionMode == ADC_CONVERSIONMODE_CONTINUOUS)
  {
    /* Set the continuous coversion mode */
    ADC->CR1 |= ADC_CR1_CONT;
  }
  else /* ADC_ConversionMode == ADC_CONVERSIONMODE_SINGLE */
  {
    /* Set the single conversion mode */
    ADC->CR1 &= (u8)(~ADC_CR1_CONT);
  }

  /* Clear the ADC channels */
  ADC->CSR &= (u8)(~ADC_CSR_CH);
  /* Select the ADC channel */
  ADC->CSR |= (u8)(ADC_Channel);

  /* Clear the align bit */
  ADC->CR2 &= (u8)(~ADC_CR2_ALIGN);
  /* Configure the data alignment */
  ADC->CR2 |= (u8)(ADC_Align);
  
}


/**
  * @brief Initializes the ADC peripheral according to the specified parameters
  * in the ADC_InitStruct structure.
  * @param[in] ADC_InitStruct: pointer to an ADC_Init_TypeDef structure that
  * contains the configuration information of the ADC peripheral.
  * @retval void None
  * @par Required preconditions:
  *  Call the ADC_DeInit function or the ADC_StructInit function
  * @par Called functions:
  * - ADC_ConversionConfig()
  * - ADC_PrescalerConfig()
  * - ADC_ExternalTriggerConfig()
  * - ADC_SchmittTriggerConfig()
  * - ADC_Cmd()
  * @par Example:
  * Initializes ADC according to ADC_InitStruct.
  * @code
  * ADC_Init(&ADC_InitStructure);
  * @endcode
  */
void ADC_Init(ADC_Init_TypeDef* ADC_InitStruct)
{

  /* Check the parameters */
  assert_param(IS_ADC_CONVERSIONMODE_OK(ADC_InitStruct->ADC_ConversionMode));
  assert_param(IS_ADC_CHANNEL_OK(ADC_InitStruct->ADC_Channel));
  assert_param(IS_ADC_PRESSEL_OK(ADC_InitStruct->ADC_PrescalerSelection));
  assert_param(IS_ADC_EXTTRIG_OK(ADC_InitStruct->ADC_ExtTrigger));
  assert_param(IS_FUNCTIONALSTATE_OK(((ADC_InitStruct->ADC_ExtTrigState))));
  assert_param(IS_ADC_ALIGN_OK(ADC_InitStruct->ADC_Align));
  assert_param(IS_ADC_SCHMITTTRIG_OK(ADC_InitStruct->ADC_SchmittTriggerChannel));
  assert_param(IS_FUNCTIONALSTATE_OK(ADC_InitStruct->ADC_SchmittTriggerState));

  /*-----------------CR1 & CSR configuration --------------------*/
  /* Configure the conversion mode and the channel to convert
  respectively according to ADC_ConversionMode & ADC_Channel values  &  ADC_Align values */
  ADC_ConversionConfig(ADC_InitStruct->ADC_ConversionMode, ADC_InitStruct->ADC_Channel, ADC_InitStruct->ADC_Align);
  /* Select the prescaler division factor according to ADC_PrescalerSelection values */
  ADC_PrescalerConfig(ADC_InitStruct->ADC_PrescalerSelection);

  /*-----------------CR2 configuration --------------------*/
  /* Configure the external trigger state and event respectively
  according to ADC_ExtTrigStatus, ADC_ExtTrigger */
  ADC_ExternalTriggerConfig(ADC_InitStruct->ADC_ExtTrigger, ADC_InitStruct->ADC_ExtTrigState);

  /*------------------TDR configuration ---------------------------*/
  /* Configure the schmitt trigger channel and state respectively
  according to ADC_SchmittTriggerChannel & ADC_SchmittTriggerNewState  values */
  ADC_SchmittTriggerConfig(ADC_InitStruct->ADC_SchmittTriggerChannel, ADC_InitStruct->ADC_SchmittTriggerState);

  /* Enable the ADC peripheral */
  ADC_Cmd(ENABLE);

}



void ADC_init(void)
 {
	ADC->CSR &= 0xdf;		//disable ADC convertion interrupt
	ADC->CR1 &= 0x70;
	ADC->CR1 &= 0x70;		//operate twice, power off ADC module 
	
	//ADC->CFG1 |= 0x02;		// 0:Single conversion mode 
							// 1:continuous convertion
	ADC->CR1 |= 0b01010000;//set convertion clock frequence:  Fmaster/16
	ADC->CR2 = 0x00;//08;		//right alignment:  8bit LSB in DL   ;  external triggle disable
	
	// 0: Schmitt trigger enabled
	// 1: Schmitt trigger disabled
	ADC->TDRH = 0;			//0b11000001;	//channel 15~8
	ADC->TDRL = 0;			//0b00111111;	//channel 15~8
	
	ADC->CR1 |= 1;			//power on ADC
	ADC->CR1 |= 1;			//start convertion

	adChIndex = 0;
	adRstIndex = 0;
 }



/**
  * @brief Configure teh ADC prescaler division factor.
  * @param[in] ADC_Prescaler: the selected precaler.
  * can be one of the values of @ref ADC_PresSel_TypeDef.
  * @retval void None
  * @par Required preconditions:
  *  None
  * @par Called functions:
  * None
  * @par Example:
  * Configure the prescaler with the value of fadc = fcpu/4
  * @code
  * ADC_PrescalerConfig(ADC_PRESSEL_FCPU_D4 );
  * @endcode
  */
void ADC_PrescalerConfig(ADC_PresSel_TypeDef ADC_Prescaler)
{

  /* Check the parameter */
  assert_param(IS_ADC_PRESSEL_OK(ADC_Prescaler));

  /* Clear the SPSEL bits */
  ADC->CR1 &= (u8)(~ADC_CR1_SPSEL);
  /* Select the prescaler division factor according to ADC_PrescalerSelection values */
  ADC->CR1 |= (u8)(ADC_Prescaler);

}

/**
  * @brief Enables or disables the ADC interrupt.
  * @param[in] ADC_ITEnable this parameter is to set or reset the  EOC interrupt.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable the ADC End Of Convertion (EOC) Interrupt.
  * @code
  * ADC_ITCmd(ENABLE);
  * @endcode
  */
void ADC_ITCmd(FunctionalState ADC_ITEnable)
{

  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(ADC_ITEnable));

  if (ADC_ITEnable != DISABLE)
  {
    /* Enable the ADC interrupts */
    ADC->CSR |= ADC_CSR_ITEN;
  }
  else  /*ADC_ITEnable == DISABLE */
  {
    /* Disable the ADC interrupts */
    ADC->CSR &= (u8)(~ADC_CSR_ITEN);
  }

}

/**
  * @brief Get one sample of measured signal.
  * @par Parameters:
  * None
  * @retval ConversionValue:  value of the measured signal.
  * @par Required preconditions:
  * ADC conversion finished.
  * @par Called functions:
  * None
  * @par Example:
  * Get the converted value of a given signal on a given channel.
  * @code
  * u16 ADC_ConversionValue;
  * ADC_ConversionValue = ADC_GetConversionValue();
  * @endcode
  */
u16 ADC_GetConversionValue(void)
{

  u16 ConversionValue = 0;
  u16 tempH = 0;
  u16 tempL = 0;

 if (ADC->CR2 & ADC_CR2_ALIGN) /* Right alignment */
 {
    /* Read LSB first */
		tempL = ADC->DRL;
    /* Then read MSB */
		tempH = ADC->DRH;
 }
 else /* Left alignment */
 {
    /* Read MSB firts*/
		tempH = ADC->DRH;
    /* Then read LSB */
		tempL = ADC->DRL;
 }
	
	ConversionValue = (u16)(tempL | (u16)(tempH << (u8)8));
  return ((u16)ConversionValue);

}

u16 ADC_GetValue(u8 ADC_Channel)
 {
 	u16 temp;
 	
 	//ADC->CFG1 |= 1;			//power on ADC
	//ADC->CFG1 |= 1;			//start convertion
	
	ADCerrorCnt = 0;
	ADC->CSR &= 0x7f;		//clear EOC flag
	ADC->CSR = (ADC->CSR & 0x80) | ADC_Channel;  //start A/D convertion
	ADC->CR1 |= 1;			//power on ADC
	ADC->CR1 |= 1;			//start convertion
	while(!(ADC->CSR & 0x80))	
	{
		if (ADCerrorCnt) 
		{
			ADC_init();
			return;
		}
	}
	temp = ADC->DRH;
	temp <<= 2;
	temp += ADC->DRL;
	return temp;
 }


/**
  * @brief Checks whether the ADC EOC flag is set or not.
  * @par Parameters:
  * None
  * @retval FlagStatus Status of the EOC flag.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Get the EOC flag status.
  * @code
  * FlagStatus ADC_FlagStatus;
  * ADC_FlagStatus = ADC_GetFlagStatus();
  * @endcode
  */
FlagStatus ADC_GetFlagStatus(void)
{

  u8 flagstatus = 0;

  /* Get EOC flag status */
  flagstatus |= (u8)(ADC->CSR & ADC_CSR_EOC);

  return ((FlagStatus)flagstatus);

}

/**
  * @brief Checks whether the ITEN bit is set or not.
  * @par Parameters:
  * None
  * @retval FlagStatus: status of the ITEN bit.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Get the  ITEN bit status.
  * @code
  * ITStatus ADC_ITStatus;
  * ADC_ITStatus = ADC_GetITStatus();
  * @endcode
  */
ITStatus ADC_GetITStatus(void)
{

  u8 itstatus = 0;

  itstatus |= (u8)(ADC->CSR & ADC_CSR_ITEN);
  
  return ((ITStatus)itstatus);

}

/**
  * @brief Configure the ADC conversion on external trigger event.
  * @par Full description:
  * The selected external trigger evant can be enabled or disabled.
  * @param[in] ADC_ExtTrigger to select the External trigger event.
  * can have one of the values of @ref ADC_ExtTrig_TypeDef.
  * @param[in] ADC_ExtTrigState to enable/disable the selected external trigger
  * can have one of the values of @ref FunctionalState.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable the TIM1 TRGO to trigger the conversion.
  * @code
  * ADC_ExternalTriggerConfig(ADC_EXTTRIG_TIM1, ENABLE);
  * @endcode
  */
void ADC_ExternalTriggerConfig(ADC_ExtTrig_TypeDef ADC_ExtTrigger, FunctionalState ADC_ExtTrigState)
{

  /* Check the parameters */
  assert_param(IS_ADC_EXTTRIG_OK(ADC_ExtTrigger));
  assert_param(IS_FUNCTIONALSTATE_OK(ADC_ExtTrigState));

  if (ADC_ExtTrigState != DISABLE)
  {
    /* Enable the external Trigger */
    ADC->CR2 |= (u8)(ADC_CR2_EXTTRIG);
  }
  else /* ADC_ExtTrigStatus == DISABLE */
  {
    /* Disable the external trigger */
    ADC->CR2 &= (u8)(~ADC_CR2_EXTTRIG);
  }

  /* Clear the external trigger selection bits */
  ADC->CR2 &= (u8)(~ADC_CR2_EXTSEL);
  /* Set the slected external trigger */
  ADC->CR2 |= (u8)(ADC_ExtTrigger);

}


/**
  * @brief Enables or disables the ADC Schmitt Trigger on a selected channel.
  * @param[in] ADC_SchmittTriggerChannel specifies the desired Channel.
  * It can be set of the values of @ref ADC_SchmittTrigg_TypeDef.
  * @param[in] ADC_SchmittTriggerState specifies Channel new status.
  * can have one of the values of @ref FunctionalState.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enables the schmitt trigger on the channel 8.
  * @code
  * ADC_SchmittTriggerConfig(ACD_SchmittCannel8,ENABLE);
  * @endcode
  */
void ADC_SchmittTriggerConfig(ADC_SchmittTrigg_TypeDef ADC_SchmittTriggerChannel, FunctionalState ADC_SchmittTriggerState)
{

  /* Check the parameters */
  assert_param(IS_ADC_SCHMITTTRIG_OK(ADC_SchmittTriggerChannel));
  assert_param(IS_FUNCTIONALSTATE_OK(ADC_SchmittTriggerState));

  if (ADC_SchmittTriggerChannel == ADC_SCHMITTTRIG_ALL)
  {
    if (ADC_SchmittTriggerState != DISABLE)
    {
      ADC->TDRL &= (u8)0x0;
      ADC->TDRH &= (u8)0x0;
    }
    else /* ADC_SchmittState == DISABLE */
    {
      ADC->TDRL |= (u8)0xFF;
      ADC->TDRH |= (u8)0xFF;
    }
  }
  else if (ADC_SchmittTriggerChannel < ADC_SCHMITTTRIG_CHANNEL8)
  {
    if (ADC_SchmittTriggerState != DISABLE)
    {
      ADC->TDRL &= (u8)(~(u8)((u8)0x01 << (u8)ADC_SchmittTriggerChannel));
    }
    else /* ADC_SchmittState == DISABLE */
    {
      ADC->TDRL |= (u8)((u8)0x01 << (u8)ADC_SchmittTriggerChannel);
    }
  }
  else /* ADC_SchmittTriggerChannel >= ADC_SCHMITTTRIG_CHANNEL8 */
  {
    if (ADC_SchmittTriggerState != DISABLE)
    {
      ADC->TDRH &= (u8)(~(u8)((u8)0x01 << ((u8)ADC_SchmittTriggerChannel - (u8)8)));
    }
    else /* ADC_SchmittState == DISABLE */
    {
      ADC->TDRH |= (u8)((u8)0x01 << ((u8)ADC_SchmittTriggerChannel - (u8)8));
    }
  }

}

/**
  * @}
  */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
