/**
  ******************************************************************************
  * @file stm8_spi.c
  * @brief This file contains all the functions for the SPI peripheral.
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
#include "stm8_spi.h"

/* LINKER SECTIONS DEFINITION FOR THIS FILE ONLY */
#ifdef USE_COSMIC_SECTIONS
#pragma section (SPI_CODE)
#pragma section const {SPI_CONST}
#pragma section @near [SPI_URAM]
#pragma section @near {SPI_IRAM}
#pragma section @tiny [SPI_UZRAM]
#pragma section @tiny {SPI_IZRAM}
#endif

/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/

/** @addtogroup SPI_Public_Functions
  * @{
  */

/**
* @brief Deinitializes the SPI peripheral registers to their default reset values.
* @par Parameters:
* None
* @retval void None
* @par Required preconditions:
* None
* @par Called functions:
* SPI_Cmd
* @par Example:
* This example shows how to call the function:
* @code
* SPI_DeInit();
* @endcode
*/
void SPI_DeInit(void)
{
  SPI->CR1    = SPI_CR1_RESET_VALUE;
  SPI->CR2    = SPI_CR2_RESET_VALUE;
  SPI->ICR    = SPI_ICR_RESET_VALUE;
  SPI->SR     = SPI_SR_RESET_VALUE;
  SPI->CRCPR  = SPI_CRCPR_RESET_VALUE;
}

/**
  * @brief Fills SPI_InitStruct members with default value.
  * @param[in] SPI_InitStruct Pointer to SPI_Init_TypeDef structure that will be initialized.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * SPI_Init_TypeDef SPI_InitStructure;
  * SPI_StructInit(&SPI_InitStructure);
  * @endcode
  */
void SPI_StructInit(SPI_Init_TypeDef* SPI_InitStruct)
{
  SPI_InitStruct->FirstBit          = SPI_FIRSTBIT_MSB;
  SPI_InitStruct->BaudRatePrescaler = SPI_BAUDRATEPRESCALER_2;
  SPI_InitStruct->Mode              = SPI_MODE_MASTER;
  SPI_InitStruct->ClockPolarity     = SPI_CPOL_LOW;
  SPI_InitStruct->ClockPhase        = SPI_CPHA_1EDGE;
  SPI_InitStruct->Data_Direction    = SPI_DATADIRECTION_2LINES_FULLDUPLEX;
  SPI_InitStruct->NSS_Software      = ENABLE;
  SPI_InitStruct->CRCPolynomial     = (u8)0x07;
}

/**
  * @brief Initializes the SPI according to the specified parameters.
  * @retval void None
  * @par Required preconditions:
  * You can call SPI_InitStruct before in order to initialize the structure members.
  * @par Called functions:
* None.
  * @par Example:
  * @code
  * SPI_Init_TypeDef SPI_InitStructure;
  * SPI_Init(&SPI_InitStructure);
  * @endcode
  */
void SPI_Init(SPI_Init_TypeDef* SPI_InitStruct)
{

  /* Check structure elements */
  assert_param(IS_SPI_FIRSTBIT_OK(SPI_InitStruct->FirstBit));
  assert_param(IS_SPI_BAUDRATE_PRESCALER_OK(SPI_InitStruct->BaudRatePrescaler));
  assert_param(IS_SPI_MODE_OK(SPI_InitStruct->Mode));
  assert_param(IS_SPI_POLARITY_OK(SPI_InitStruct->ClockPolarity));
  assert_param(IS_SPI_PHASE_OK(SPI_InitStruct->ClockPhase));
  assert_param(IS_SPI_DATA_DIRECTION_OK(SPI_InitStruct->Data_Direction));
  assert_param(IS_FUNCTIONALSTATE_OK(SPI_InitStruct->NSS_Software));

  /* Reset value */
  SPI->CR1 = SPI_CR1_RESET_VALUE;
  SPI->CR2 = SPI_CR2_RESET_VALUE;

  /* Frame Format, BaudRate, Clock Polarity and Phase configuration */  
  SPI->CR1 |= (u8)((u8)(SPI_InitStruct->FirstBit) |
                   (u8)(SPI_InitStruct->BaudRatePrescaler) |
                   (u8)(SPI_InitStruct->ClockPolarity) |
                   (u8)(SPI_InitStruct->ClockPhase));

  /* Data direction configuration: BDM, BDOE and RXONLY bits */
  SPI->CR2 |= (u8)(SPI_InitStruct->Data_Direction);

  /* NSS configuration */
  if (SPI_InitStruct->NSS_Software == ENABLE)
  {
    SPI->CR2 |= SPI_CR2_SSM;
    if (SPI_InitStruct->Mode == SPI_MODE_MASTER)
    {
      SPI->CR2 |= SPI_CR2_SSI;
    }
  }

  /* Master/Slave mode configuration */
  SPI->CR1 |= (u8)(SPI_InitStruct->Mode);

  /* CRC configuration */
  SPI->CRCPR = SPI_InitStruct->CRCPolynomial;

}

/**
* @brief Enables or disables the specified SPI peripheral.
* @param[in] NewState New state of the SPI peripheral.
* This parameter can be:
* - ENABLE
* - DISABLE
* @retval void None
* @par Required preconditions:
* None
* @par Called functions:
* None
* @par Example:
* @code
* SPI_Cmd(ENABLE);
* @endcode
*/
void SPI_Cmd(FunctionalState NewState)
{

  /* Check function parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));

  if (NewState == ENABLE)
  {
    SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
  }
  else
  {
    SPI->CR1 &= (u8)(~SPI_CR1_SPE); /* Disable the SPI peripheral*/
  }

}

/**
* @brief Transmits a Data through the SPI peripheral.
* @param[in] Data Byte to be transmitted.
* @retval void None
* @par Required preconditions:
* None
* @par Called functions:
* None
* @par Example:
* @code
* SPI_SendData(0xFF);
* @endcode
*/
void SPI_SendData(u8 Data)
{
  SPI->DR = Data; /* Write in the DR register the data to be sent*/
}

/**
* @brief Returns the most recent received data by the SPI peripheral.
* @par Parameters:
* None
* @retval u8 The value of the received data.
* @par Required preconditions:
* None
* @par Called functions:
* None
* @par Example:
* @code
* Return_Value = SPI_ReceiveData();
* @endcode
*/
u8 SPI_ReceiveData(void)
{
  return ((u8)SPI->DR); /* Return the data in the DR register*/
}

/**
* @brief Configures internally by software the NSS pin.
* @param[in] NewState Indicates the new state of the SPI Software slave management.
* This parameter can be:
* - ENABLE
* - DISABLE
* @retval void None
* @par Required preconditions:
* None
* @par Called functions:
* None
* @par Example:
* @code
* SPI_NSSInternalSoftwareCmd(ENABLE);
* @endcode
*/
void SPI_NSSInternalSoftwareCmd(FunctionalState NewState)
{

  /* Check function parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));

  if (NewState != DISABLE)
  {
    SPI->CR2 |= SPI_CR2_SSI; /* Set NSS pin internally by software*/
  }
  else
  {
    SPI->CR2 &= (u8)(~SPI_CR2_SSI); /* Reset NSS pin internally by software*/
  }

}

/**
* @brief Enables the transmit of the CRC value.
* @par Parameters:
* None
* @retval void None
* @par Required preconditions:
* None
* @par Called functions:
* None
* @par Example:
* @code
* SPI_TransmitCRC();
* @endcode
*/
void SPI_TransmitCRC(void)
{
  SPI->CR2 |= SPI_CR2_CRCNEXT; /* Enable the CRC transmission*/
}

/**
* @brief Enables or disables the CRC value calculation of the transfered bytes.
* @param[in] NewState Indicates the new state of the SPI CRC value calculation.
* This parameter can be:
* - ENABLE
* - DISABLE
* @retval void None
* @par Required preconditions:
* None
* @par Called functions: SPI_Cmd(DISABLE);
* @par Example:
* @code
* SPI_CalculateCRCCmd(ENABLE);
* @endcode
*/
void SPI_CalculateCRCCmd(FunctionalState NewState)
{

  /* Check function parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));

  /* SPI must be disable forcorrect operation od Hardware CRC calculation */
  SPI_Cmd(DISABLE);

  if (NewState == ENABLE)
  {
    SPI->CR2 |= SPI_CR2_CRCEN; /* Enable the CRC calculation*/
  }
  else
  {
    SPI->CR2 &= (u8)(~SPI_CR2_CRCEN); /* Disable the CRC calculation*/
  }

}

/**
* @brief Returns the transmit or the receive CRC register value.
* @param[in] SPI_CRC Specifies the CRC register to be read.
* @retval u8 The selected CRC register value.
* @par Required preconditions:
* None
* @par Called functions:
* None
* @par Example:
* @code
* SPI_GetCRC(SPI_CRC_TX);
* @endcode
*/
u8 SPI_GetCRC(SPI_CRC_Typedef SPI_CRC)
{

  u8 crcreg = 0;

  /* Check function parameters */
  assert_param(IS_SPI_CRC_OK(SPI_CRC));

  if (SPI_CRC == SPI_CRC_TX)
  {
    crcreg = SPI->TXCRCR;  /* Get the Tx CRC register*/
  }
  else
  {
    crcreg = SPI->RXCRCR; /* Get the Rx CRC register*/
  }

  /* Return the selected CRC register status*/
  return crcreg;

}

/**
* @brief Reset the Rx CRCR and Tx CRCR registers.
* @par Parameters:
* None
* @retval void None
* @par Required preconditions:
* None
* @par Called functions: SPI_CalculateCRCCmd and SPI_Cmd.
* @par Example:
* @code
* SPI_ResetCRC();
* @endcode
*/
void SPI_ResetCRC(void)
{

  /* Rx CRCR & Tx CRCR registers are reset when CRCEN (hardware calculation)
     bit in SPI_CR2 is written to 1 (enable) */
  SPI_CalculateCRCCmd(ENABLE) ;

  /* Previous function disable the SPI */
  SPI_Cmd(ENABLE);

}

/**
* @brief Returns the CRC Polynomial register value.
* @par Parameters:
* None
* @retval u8 The CRC Polynomial register value.
* @par Required preconditions:
* None
* @par Called functions:
* None
* @par Example:
* @code
* u8 polynomial;
* polynomial = SPI_GetCRCPolynomial();
* @endcode
*/
u8 SPI_GetCRCPolynomial(void)
{
  return SPI->CRCPR; /* Return the CRC polynomial register */
}

/**
* @brief Selects the data transfer direction in bi-directional mode.
* @param[in] SPI_Direction Specifies the data transfer direction in bi-directional mode.
* @retval void None
* @par Required preconditions:
* None
* @par Called functions:
* None
* @par Example:
* @code
* SPI_BiDirectionalLineConfig(SPI_DIRECTION_TX);
* @endcode
*/
void SPI_BiDirectionalLineConfig(SPI_Direction_Typedef SPI_Direction)
{

  /* Check function parameters */
  assert_param(IS_SPI_DIRECTION_OK(SPI_Direction));

  if (SPI_Direction == SPI_DIRECTION_TX)
  {
    SPI->CR2 |= SPI_CR2_BDOE; /* Set the Tx only mode*/
  }
  else
  {
    SPI->CR2 &= (u8)(~SPI_CR2_BDOE); /* Set the Rx only mode*/
  }

}

/**
* @brief Enables or disables the specified interrupts.
* @param[in] Spi_IT Specifies the SPI interrupts sources to be enabled or disabled.
* @param[in] NewState: The new state of the specified SPI interrupts.
* This parameter can be:
* - ENABLE
* - DISABLE.
* @retval void None
* @par Required preconditions:
* None
* @par Called functions:
* None
* @par Example:
* @code
* SPI_ITConfig(SPI_IT_TXIE, ENABLE);
* @endcode
*/
void SPI_ITConfig(SPI_Interrupts_Typedef Spi_IT, FunctionalState NewState)
{

  /* Check function parameters */
  assert_param(IS_SPI_INTERRUPTS_OK(Spi_IT));
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));

  if (NewState == ENABLE)
  {
    SPI->ICR |= (u8)Spi_IT; /* Enable interrupt*/
  }
  else
  {
    SPI->ICR &= (u8)(~(u8)Spi_IT); /* Disable interrupt*/
  }

}


/**
* @brief Checks whether the specified SPI flag is set or not.
* @param[in]  SPI_FLAG specifies the flag to check.
* This parameter can be one of the following values:
* @retval FlagStatus Indicates the state of SPI_FLAG.
* This parameter can be one of the following values:
* - SET
* - RESET
* @par Required preconditions:
* None
* @par Called functions:
* None
* @par Example:
* @code
* FlagStatus status;
* status = SPI_GetFlagStatus(SPI_FLAG_OVR);
* @endcode
*/
FlagStatus SPI_GetFlagStatus(SPI_Flag_Typedef SPI_FLAG)
{

  FlagStatus status = RESET;

  /* Check function parameters */
  assert_param(IS_SPI_FLAGS_OK(SPI_FLAG));

  /* Check the status of the specified SPI flag*/
  if ((SPI->SR & (u8)SPI_FLAG) != (u8)RESET)
  {
    status = SET; /* SPI_FLAG is set*/
  }
  else
  {
    status = RESET; /* SPI_FLAG is reset*/
  }

  /* Return the SPI_FLAG status*/
  return status;

}

/**
* @brief Checks whether the specified interrupt has occurred or not.
* @param[in] Spi_IT specifies the SPI interrupt source to check.
* @retval ITStatus The new state of Spi_IT.
* @par Required preconditions:
* None
* @par Called functions:
* None
* @par Example:
* @code
* ITStatus interrupt;
* interrupt = SPI_GetITStatus(SPI_IT_OVR);
* @endcode
*/
ITStatus SPI_GetITStatus(SPI_Interrupts_Typedef Spi_IT)
{

  ITStatus pendingbitstatus = RESET;

  /* Check function parameters */
  assert_param(IS_SPI_PENDINGBIT_OK(Spi_IT));

  /* Check the status of the specified SPI interrupt*/
  if ((SPI->ICR & (u8)Spi_IT) != (u8)0x00)
  {
    pendingbitstatus = SET;  /* Spi_IT is set*/
  }
  else
  {
    pendingbitstatus = RESET; /* Spi_IT is reset*/
  }

  /* Return the Spi_IT status*/
  return pendingbitstatus;

}

/**
* @brief Clears the SPI flags.
* @param[in] SPI_FLAG specifies the flag to clear.
* @retval void None
* @par Required preconditions:
* None
* @par Called functions:
* None
* @par Example:
* @code
* SPI_ClearFlag(SPI_FLAG_OVR);
* @endcode
*/
void SPI_ClearFlag(SPI_Flag_Typedef SPI_FLAG)
{

  u8 tempreg = 0;

  /* Check function parameters */
  assert_param(IS_SPI_CLEAR_FLAGS_OK(SPI_FLAG));

  /* Clear SPI_FLAG_CRCERR or SPI_FLAG_WKUP flag*/
  if ((SPI_FLAG == SPI_FLAG_CRCERR) || (SPI_FLAG == SPI_FLAG_WKUP))
  {
    SPI->SR &= (u8)(~(u8)SPI_FLAG); /* Clear the flag*/
  }
  else /* SPI_IT_OVR flag clear*/
  {
    tempreg = SPI->SR; /* Read SR register*/
    if (SPI_FLAG == SPI_FLAG_MODF) /* SPI_FLAG_MODF flag clear*/
    {
      /* Write on CR1 register*/
      SPI->CR1 |= SPI_CR1_SPE;
    }
  }

}

/**
* @brief Clears the interrupt pending bits.
* @param[in] Spi_IT Specifies the interrupt pending bit to clear.
* @retval void None
* @par Required preconditions:
* None
* @par Called functions:
* None
* @par Example:
* @code
* SPI_ClearITPendingBit(SPI_IT_OVR_Mask);
* @endcode
*/
void SPI_ClearITPendingBit(SPI_Interrupts_Typedef Spi_IT)
{

  u8 tempreg = 0;

  /* Check function parameters */
  assert_param(IS_SPI_CLEAR_FLAGS_OK(Spi_IT));

  /* Clear SPI_FLAG_CRCERR or SPI_FLAG_WKUP interrupt pending bits*/
  if ((Spi_IT == SPI_FLAG_CRCERR) || (Spi_IT == SPI_FLAG_WKUP))
  {
    SPI->SR &= (u8)(~(u8)Spi_IT);    /* Clear the pending bit*/
  }

  else /* SPI_IT_OVR pending bit clear*/
  {
    tempreg = SPI->SR;  /* Read SR register*/
    if (Spi_IT == SPI_FLAG_MODF) /* SPI_FLAG_MODF pending bit clear*/
    {
      SPI->CR1 |= SPI_CR1_SPE;   /* Write on CR1 register*/
    }
  }

}

/**
  * @}
  */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
