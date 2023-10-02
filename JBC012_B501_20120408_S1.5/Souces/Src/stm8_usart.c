/**
  ********************************************************************************
  * @file stm8_usart.c
  * @brief This file contains all the functions for the USART peripheral.
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
#include "stm8_usart.h"
#include "stm8_clk.h"

/* LINKER SECTIONS DEFINITION FOR THIS FILE ONLY */
#ifdef USE_COSMIC_SECTIONS
#pragma section (USART_CODE)
#pragma section const {USART_CONST}
#pragma section @near [USART_URAM]
#pragma section @near {USART_IRAM}
#pragma section @tiny [USART_UZRAM]
#pragma section @tiny {USART_IZRAM}
#endif

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/

/** @}
  * @addtogroup USART_Public_Functions
  * @{
  */

/**
 * @brief Clears the USART flags.
 * @par Full description:
 * Clears the USART flags.
 * @param[in] USART_FLAG specifies the flag to clear
 *  This parameter can be one of the following values:
 *                       - USART_FLAG_TXE
 *                       - USART_FLAG_TC
 *                       - USART_FLAG_RXNE
 *                       - USART_FLAG_IDLE
 *                       - USART_FLAG_ORE
 *                       - USART_FLAG_NE
 *                       - USART_FLAG_FE
 *                       - USART_FLAG_PE
 *                       - USART_FLAG_LBD
 *                       - USART_FLAG_SBK
 * @retval void None
 * @par Required preconditions:
 * None
 * @par Called functions:
 * None
 * @par Example:
 * Clear the USART TC flag
 * @code
 * USART_ClearFlag(USART_FLAG_TC);
 * @endcode
 */

void USART_ClearFlag(USART_Flag_TypeDef USART_FLAG)
{
  u8 dummy = 0x00;
  assert_param(IS_USART_FLAG_VALUE_OK(USART_FLAG));
  switch (USART_FLAG)
  {
      /*< Clear the Transmit Register Empty flag    */
    case USART_FLAG_TXE:
      USART->DR = (u8)(0x00);
		  break;
      /*< Clear the Transmission Complete flag      */
    case USART_FLAG_TC:
      dummy = USART->SR;
      USART->DR = (u8)(0x00);
      break;
      /*< Clear the Receive Register Not Empty flag */
    case USART_FLAG_RXNE:
      /*< Clear the Idle Detection flag             */
    case USART_FLAG_IDLE:
      /*< Clear the Overrun Error flag              */
    case USART_FLAG_ORE:
      /*< Clear the Noise Error flag                */
    case USART_FLAG_NE:
      /*< Clear the Framing Error flag              */
    case USART_FLAG_FE:
      /*< Clear the Parity Error flag               */
    case USART_FLAG_PE:
      dummy = USART->SR; /*< Read Status Register */ /*TBD*/
      dummy = USART->SR; /*< Read Status Register */

      dummy = USART->DR; /*< Read Data Register   */
      break;
    case USART_FLAG_SBK:
      USART->CR2 &= (u8)~(USART_CR2_SBK);
      break;
      /*< Clear the LIN Break Detection flag */
    case USART_FLAG_LBD:
      USART->CR4 &= (u8)~(USART_CR4_LBDF);
      break;
    default:
      break;
  }
}
/**
 * @brief Clears the USART pending flags.
 * @par Full description:
 * Clears the USART pending bit.
 * @param[in] USART_FLAG specifies the pending bit to clear
 *  This parameter can be one of the following values:
 *                       - USART_FLAG_LBD
 *                       - USART_FLAG_TXE
 *                       - USART_FLAG_TC
 *                       - USART_FLAG_RXNE
 *                       - USART_FLAG_IDLE
 *                       - USART_FLAG_ORE
 *                       - USART_FLAG_PE
 * @retval void None
 * @par Required preconditions:
 * None
 * @par Called functions:
 * None
 * @par Example:
 * Clear the USART TC pending bit
 * @code
 * USART_ClearITPendingBit(USART_FLAG_TC);
 * @endcode
 */

void USART_ClearITPendingBit(USART_Flag_TypeDef USART_FLAG)
{
  u8 dummy;
  assert_param(IS_USART_ITPENDINGBIT_VALUE_OK(USART_FLAG));
  switch (USART_FLAG)
  {
      /*< Clear the Transmit Register Empty flag    */
    case USART_FLAG_TXE:
      USART->DR = (u8)(0x00);
		   break;
      /*< Clear the Transmission Complete flag      */
    case USART_FLAG_TC:
     dummy = USART->SR;
     USART->DR = (u8)(0x00);
      break;
      /*< Clear the Receive Register Not Empty flag */
    case USART_FLAG_RXNE:
      dummy = USART->DR; /*< Read Data Register   */
      break;
      /*< Clear the Idle Detection flag             */
    case USART_FLAG_IDLE:
      /*< Clear the Overrun Error flag              */
    case USART_FLAG_ORE:
      /*< Clear the Parity Error flag               */
    case USART_FLAG_PE:
      dummy = USART->SR; /*< Read Status Register */ /*TBD*/
      dummy = USART->SR; /*< Read Status Register */
      dummy = USART->DR; /*< Read Data Register   */
      break;

      /*< Clear the LIN Break Detection flag */
    case USART_FLAG_LBD:
      USART->CR4 &= (u8)~(USART_CR4_LBDF);
      break;
    case USART_FLAG_NE:
    case USART_FLAG_FE:
    case USART_FLAG_SBK:
    default:
      break;
  }
}

/**
  * @brief Enable the USART peripheral.
  * @par Full description:
  * Enable the USART peripheral.
  * @param[in] NewState new state of the USART Communication.
  *                    This parameter can be: ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable USART peripheral.
  * @code
  * USART_Cmd(ENABLE);
  * @endcode
  */
void USART_Cmd(FunctionalState NewState)
{
  if (NewState)
  {
    USART->CR1 &= (u8)(~USART_CR1_USARTD); /**< USART Enable */
  }
  else
  {
    USART->CR1 |= USART_CR1_USARTD;  /**< USART Disable (for low power consumption) */
  }
}
/**
  * @brief Deinitializes the USART peripheral.
  * @par Full description:
  * Set the USART peripheral registers to their default reset values.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Deinitialize USART peripheral.
  * @code
  * USART_DeInit();
  * @endcode
  */

void USART_DeInit(void)
{
  u8 dummy;

  /*< Clear the Idle Line Detected bit in the status rerister by a read
     to the USART_SR register followed by a Read to the USART_DR register */
  dummy = USART->SR;
  dummy = USART->DR;

  USART->BRR2 = USART_BRR2_RESET_VALUE;  /*< Set USART_BRR2 to reset value 0x00 */
  USART->BRR1 = USART_BRR1_RESET_VALUE;  /*< Set USART_BRR1 to reset value 0x00 */

  USART->CR1 = USART_CR1_RESET_VALUE; /*< Set USART_CR1 to reset value 0x00  */
  USART->CR2 = USART_CR2_RESET_VALUE; /*< Set USART_CR2 to reset value 0x00  */
  USART->CR3 = USART_CR3_RESET_VALUE;  /*< Set USART_CR3 to reset value 0x00  */
  USART->CR4 = USART_CR4_RESET_VALUE;  /*< Set USART_CR4 to reset value 0x00  */
  USART->CR5 = USART_CR5_RESET_VALUE; /*< Set USART_CR5 to reset value 0x00  */

  USART->GTR = USART_GTR_RESET_VALUE;
  USART->PSCR = USART_PSCR_RESET_VALUE;
}


/**
  * @brief Checks whether the specified USART flag is set or not.
  * @par Full description:
  * Checks whether the specified USART flag is set or not.
  * @param[in] USART_FLAG specifies the flag to check.
  *                    This parameter can be one of the following values:
  *                       - USART_FLAG_LBD
  *                       - USART_FLAG_TXE
  *                       - USART_FLAG_TC
  *                       - USART_FLAG_RXNE
  *                       - USART_FLAG_IDLE
  *                       - USART_FLAG_ORE
 *                       - USART_FLAG_NE
  *                       - USART_FLAG_FE
  *                       - USART_FLAG_PE
 *                       - USART_FLAG_SBK
  * @retval FlagStatus (SET or RESET)
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Check the status of TC flag.
  * @code
  * FlagStatus TC_flag;
  * TC_Flag = USART_GetFlagStatus(USART_FLAG_TC);
  * @endcode
  */
FlagStatus USART_GetFlagStatus(USART_Flag_TypeDef USART_FLAG)
{

  FlagStatus status = RESET;
  u8 itpos = 0;

  /* Check parameters */
  assert_param(IS_USART_FLAG_VALUE_OK(USART_FLAG));

  /* Get the USART_FLAG index*/
  itpos = (u8)((u8)1 << (u8)((u8)USART_FLAG & (u8)0x0F));

  /* Check the status of the specified USART flag*/
  switch (USART_FLAG)
  {
    case USART_FLAG_TXE:
    case USART_FLAG_TC:
    case USART_FLAG_RXNE:
    case USART_FLAG_IDLE:
    case USART_FLAG_ORE:
    case USART_FLAG_NE:
    case USART_FLAG_FE:
    case USART_FLAG_PE:
      if ((USART->SR & itpos) != (u8)0x00)
      {
        /* Interrupt occurred*/
        status = SET;
      }
      else
      {
        /* Interrupt not occurred*/
        status = RESET;
      }
      break;

    case USART_FLAG_LBD:
      if ((USART->CR4 & itpos) != (u8)0x00)
      {
        /* USART_FLAG is set*/
        status = SET;
      }
      else
      {
        /* USART_FLAG is reset*/
        status = RESET;
      }
      break;

    case USART_FLAG_SBK:
      if ((USART->CR2 & itpos) != (u8)0x00)
      {
        /* USART_FLAG is set*/
        status = SET;
      }
      else
      {
        /* USART_FLAG is reset*/
        status = RESET;
      }
      break;

    default:
      status = SET;
      break;

  }

  /* Return the USART_FLAG status*/
  return status;
}


/**
  * @brief Checks whether the specified USART interrupt has occurred or not.
  * @par Full description:
  * Checks whether the specified USART interrupt has occurred or not.
  * @param[in] USART_FLAG specifies the USART interrupt source to check.
  *                    This parameter can be one of the following values:
 *                       - USART_FLAG_LBD
 *                       - USART_FLAG_TXE
 *                       - USART_FLAG_TC
 *                       - USART_FLAG_RXNE
 *                       - USART_FLAG_IDLE
 *                       - USART_FLAG_ORE
 *                       - USART_FLAG_PE
  * @retval ITStatus - The new state of USART_IT (SET or RESET).
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * IT_Status PIEN_ITStatus;
  * PIEN_ITStatus = USART_GetITStatus(USART_FLAG_TC);
  * @endcode
  */
ITStatus USART_GetITStatus(USART_Flag_TypeDef USART_FLAG)
{

  ITStatus pendingbitstatus = RESET;
  u8 itpos = 0;
  u8 itmask1 = 0;
  u8 itmask2 = 0;
  u8 enablestatus = 0;

  /* Check parameters */
  assert_param(IS_USART_ITPENDINGBIT_VALUE_OK(USART_FLAG));

  /* Get the USART IT index */
  itpos = (u8)((u8)1 << (u8)((u8)USART_FLAG & (u8)0x0F));
  /* Get the USART IT index */
  itmask1 = (u8)((u8)USART_FLAG >> (u8)4);
  /* Set the IT mask*/
  itmask2 = (u8)((u8)1 << itmask1);

  switch (USART_FLAG)
  {
    case USART_FLAG_LBD:
      /* Get the USART_FLAG enable bit status*/
      enablestatus = (u8)((u8)USART->CR4 & itmask2);
      /* Check the status of the specified USART interrupt*/
      if (((USART->CR4 & itpos) != (u8)0x00) && enablestatus)
      {
        /* Interrupt occurred*/
        pendingbitstatus = SET;
      }
      else
      {
        /* Interrupt not occurred*/
        pendingbitstatus = RESET;
      }
      break;

    case USART_FLAG_PE:

      /* Get the USART_FLAG enable bit status*/
      enablestatus = (u8)((u8)USART->CR1 & itmask2);
      /* Check the status of the specified USART interrupt*/

      if (((USART->SR & itpos) != (u8)0x00) && enablestatus)
      {
        /* Interrupt occurred*/
        pendingbitstatus = SET;
      }
      else
      {
        /* Interrupt not occurred*/
        pendingbitstatus = RESET;
      }
      break;
    case USART_FLAG_TXE:
    case USART_FLAG_TC:
    case USART_FLAG_RXNE:
    case USART_FLAG_IDLE:
    case USART_FLAG_ORE:
      /* Get the USART_FLAG enable bit status*/
      enablestatus = (u8)((u8)USART->CR2 & itmask2);
      /* Check the status of the specified USART interrupt*/
      if (((USART->SR & itpos) != (u8)0x00) && enablestatus)
      {
        /* Interrupt occurred*/
        pendingbitstatus = SET;
      }
      else
      {
        /* Interrupt not occurred*/
        pendingbitstatus = RESET;
      }
      break;
    case USART_FLAG_NE:
    case USART_FLAG_FE:
    case USART_FLAG_SBK:
    default:
      pendingbitstatus = SET;
      break;

  }

  /* Return the USART_FLAG status*/
  return  pendingbitstatus;
}


/**
  * @brief Enables or disables the USART’s Half Duplex communication.
  * @par Full description:
  * Enables or disables the USART’s Half Duplex communication.
  * @param[in] NewState new state of the USART Communication.
  *                    This parameter can be: ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * USART_HalfDuplexCmd(ENABLE);
  * @endcode
  */
void USART_HalfDuplexCmd(FunctionalState NewState)
{
  assert_param(IS_STATE_VALUE_OK(NewState));

  if (NewState)
  {
    USART->CR5 |= USART_CR5_HDSEL;  /**< USART Half Duplex Enable  */
  }
  else
  {
    USART->CR5 &= (u8)~USART_CR5_HDSEL; /**< USART Half Duplex Disable */
  }
}

/**
  * @brief Fills USART_InitStruct members with default value.
  * @param[in] USART_InitStruct Pointer to USART_Init_TypeDef structure that will be initialized.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * USART_Init_TypeDef USART_InitStructure;
  * USART_StructInit(&USART_InitStructure);
  * @endcode
  */
void USART_StructInit(USART_Init_TypeDef* USART_InitStruct)
{
  USART_InitStruct->WordLength          = USART_WORDLENGTH_8D;
  USART_InitStruct->StopBits            = USART_STOPBITS_1;
  USART_InitStruct->Parity              = USART_PARITY_NO;
  USART_InitStruct->SyncMode            = USART_CLOCK_DISABLE;
  USART_InitStruct->BaudRate            = (u32)9600;
  USART_InitStruct->Mode                = USART_MODE_TXRX_ENABLE;
}
	
/**
  * @brief Initializes the USART according to the specified parameters.
  * @retval void None
  * @par Required preconditions:
  * You can call USART_InitStruct before in order to initialize the structure members.
  * @par Called functions:
  * CLK_GetClockFreq().
  * @par Example:
  * @code
  * USART_Init_TypeDef USART_InitStructure;
  * USART_Init(&USART_InitStructure);
  * @endcode
  */	
void USART_Init(USART_Init_TypeDef* USART_InitStruct)
{

  u32 BaudRate_Mantissa, BaudRate_Mantissa100;

  assert_param(IS_USART_WORDLENGTH_VALUE_OK(USART_InitStruct->WordLength));

  assert_param(IS_USART_STOPBITS_VALUE_OK(USART_InitStruct->StopBits));

  assert_param(IS_USART_PARITY_VALUE_OK(USART_InitStruct->Parity));

  /* assert_param: BaudRate value should be <= 625000 bps */
  assert_param(IS_USART_BAUDRATE_OK(USART_InitStruct->BaudRate));

  /* assert_param: USART_Mode value should exclude values such as  USART_ModeTx_Enable|USART_ModeTx_Disable */
  assert_param(IS_USART_MODE_VALUE_OK((u8)USART_InitStruct->Mode));

  /* assert_param: USART_SyncMode value should exclude values such as
     USART_CLOCK_ENABLE|USART_CLOCK_DISABLE */
  assert_param(IS_USART_SYNCMODE_VALUE_OK((u8)USART_InitStruct->SyncMode));

  /* Wait for no Transmition before modifying the M bit */
  /* while(!(USART->SR&USART_SR_TC));      */

  USART->CR1 &= (u8)(~USART_CR1_M);     /**< Clear the word length bit */
  USART->CR1 |= (u8)USART_InitStruct->WordLength; /**< Set the word length bit according to USART_WordLength value */

  USART->CR3 &= (u8)(~USART_CR3_STOP);  /**< Clear the STOP bits */
  USART->CR3 |= (u8)USART_InitStruct->StopBits;  /**< Set the STOP bits number according to USART_StopBits value  */

  USART->CR1 &= (u8)(~(USART_CR1_PCEN | USART_CR1_PS  ));  /**< Clear the Parity Control bit */
  USART->CR1 |= (u8)USART_InitStruct->Parity;     /**< Set the Parity Control bit to USART_Parity value */

  USART->BRR1 &= (u8)(~USART_BRR1_DIVM);  /**< Clear the LSB mantissa of USARTDIV  */
  USART->BRR2 &= (u8)(~USART_BRR2_DIVM);  /**< Clear the MSB mantissa of USARTDIV  */
  USART->BRR2 &= (u8)(~USART_BRR2_DIVF);  /**< Clear the Fraction bits of USARTDIV */

  /**< Set the USART BaudRates in BRR1 and BRR2 registers according to USART_BaudRate value */
  BaudRate_Mantissa    = ((u32)CLK_GetClockFreq()/ (USART_InitStruct->BaudRate << 4));
  BaudRate_Mantissa100 = (((u32)CLK_GetClockFreq() * 100) / (USART_InitStruct->BaudRate << 4));
  USART->BRR2 |= (u8)((u8)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100)) << 4) / 100) & (u8)0x0F); /**< Set the fraction of USARTDIV  */
  USART->BRR2 |= (u8)((BaudRate_Mantissa >> 4) & (u8)0xF0); /**< Set the MSB mantissa of USARTDIV  */
  USART->BRR1 |= (u8)BaudRate_Mantissa;           /**< Set the LSB mantissa of USARTDIV  */

  USART->CR2 &= (u8)~(USART_CR2_TEN | USART_CR2_REN); /**< Disable the Transmitter and Receiver before seting the LBCL, CPOL and CPHA bits */
  USART->CR3 &= (u8)~(USART_CR3_CPOL | USART_CR3_CPHA | USART_CR3_LBCL); /**< Clear the Clock Polarity, lock Phase, Last Bit Clock pulse */
  USART->CR3 |= (u8)((u8)USART_InitStruct->SyncMode & (u8)(USART_CR3_CPOL | USART_CR3_CPHA | USART_CR3_LBCL));  /**< Set the Clock Polarity, lock Phase, Last Bit Clock pulse */

  if ((u8)USART_InitStruct->Mode & (u8)USART_MODE_TX_ENABLE)
  {
    USART->CR2 |= (u8)USART_CR2_TEN;  /**< Set the Transmitter Enable bit */
  }
  else
  {
    USART->CR2 &= (u8)(~USART_CR2_TEN);  /**< Clear the Transmitter Disable bit */
  }
  if ((u8)USART_InitStruct->Mode & (u8)USART_MODE_RX_ENABLE)
  {
    USART->CR2 |= (u8)USART_CR2_REN;  /**< Set the Receiver Enable bit */
  }
  else
  {
    USART->CR2 &= (u8)(~USART_CR2_REN);  /**< Clear the Receiver Disable bit */
  }
  /**< Set the Clock Enable bit, lock Polarity, lock Phase and Last Bit Clock pulse bits according to USART_Mode value */
  if ((u8)USART_InitStruct->SyncMode&(u8)USART_CLOCK_DISABLE)
  {
    USART->CR3 &= (u8)(~USART_CR3_CLKEN); /**< Clear the Clock Enable bit */
    /**< configure in Push Pull or Open Drain mode the Tx I/O line by setting the correct I/O Port register according the product package and line configuration*/
  }
  else
  {
    USART->CR3 |= (u8)((u8)USART_InitStruct->SyncMode & USART_CR3_CLKEN);
    /* USART->CR2 &= (u8)(~USART_CR2_REN);*/ /*TBD */
  }
}
/**
  * @brief Configures the USART’s IrDA interface.
  * @par Full description:
  * Configures the USART’s IrDA interface.
  * @par This function is valid only for USART.
  * @param[in] USART_IrDAMode specifies the IrDA mode.
  *                    This parameter can be one of the following values:
  *                       - USART_IrDAMode_LowPower
  *                       - USART_IrDAMode_Normal
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * USART_IrDAConfig(USART_IrDAMode_LowPower)
  * @endcode
  */
void USART_IrDAConfig(USART_IrDAMode_TypeDef USART_IrDAMode)
{
  assert_param(IS_USART_IRDAMODE_VALUE_OK(USART_IrDAMode));

  if (USART_IrDAMode == USART_IRDAMODE_NORMAL)
  {
    USART->CR5 &= ((u8)~USART_CR5_IRLP);
  }
  else
  {
    USART->CR5 |= USART_CR5_IRLP;
  }
}

/**
  * @brief Enables or disables the USART’s IrDA interface.
  * @par Full description:
  * Enables or disables the USART’s IrDA interface.
  * @par This function is related to IrDA mode.
  * @param[in] NewState new state of the IrDA mode.
  *                    This parameter can be: ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * USART_IrDACmd(ENABLE)
  * @endcode
  */
void USART_IrDACmd(FunctionalState NewState)
{

  /* Check parameters */
  assert_param(IS_STATE_VALUE_OK(NewState));

  if (NewState)
  {
    /* Enable the IrDA mode by setting the IREN bit in the CR3 register */
    USART->CR5 |= USART_CR5_IREN;
  }
  else
  {
    /* Disable the IrDA mode by clearing the IREN bit in the CR3 register */
    USART->CR5 &= ((u8)~USART_CR5_IREN);
  }
}

/**
  * @brief Enables or disables the specified USART interrupts.
  * @par Full description:
  * Enables or disables the specified USART interrupts.
  * @param[in] USART_IT specifies the USART interrupt sources to be
  *                    enabled or disabled.
  *                    This parameter can be one of the following values:
  *                       - USART_IT_PIEN
  *                       - USART_IT_TCIEN
  *                       - USART_IT_RIEN
  *                       - USART_IT_ILIEN
  *                       - USART_IT_RIEN
  *                       - USART_IT_LBDIE
  * @param[in] NewState new state of the specified USART interrupts.
  *                    This parameter can be: ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * USART_ITConfig(USART_IT_PIEN, ENABLE)
  * @endcode
  */
void USART_ITConfig(USART_IT_TypeDef USART_IT, FunctionalState NewState)
{
  assert_param(IS_USART_IT_VALUE_OK(USART_IT));
  assert_param(IS_STATE_VALUE_OK(NewState));

  if (NewState)
  {
    /**< Enable the Interrupt bits according to USART_IT mask */
    USART->CR2 |= (u8)((u8)(USART_IT) & (u8)(USART_CR2_TIEN | USART_CR2_TCIEN | USART_CR2_RIEN | USART_CR2_ILIEN));
    USART->CR1 |= (u8)((u8)USART_IT & USART_CR1_PIEN);
    USART->CR4 |= (u8)((u8)((u8)USART_IT << 4) & USART_CR4_LBDIEN);
  }
  else
  {
    /**< Disable the interrupt bits according to USART_IT mask */
    USART->CR2 &= (u8)(~((u8)(USART_IT) & (u8)(USART_CR2_TIEN | USART_CR2_TCIEN | USART_CR2_RIEN | USART_CR2_ILIEN)));
    USART->CR1 &= (u8)(~((u8)USART_IT & USART_CR1_PIEN));
    USART->CR4 &= (u8)(~((u8)((u8)USART_IT << 4) & USART_CR4_LBDIEN));
  }

}


/**
  * @brief Sets the USART LIN Break detection length.
  * @par Full description:
  * Sets the USART LIN Break detection length.
  * @param[in] USART_LINBreakDetectionLength specifies the LIN break
  *                    detection length.
  *                    This parameter can be one of the following values:
  *                       - USART_LINBreakDetectionLength10
  *                       - USART_LINBreakDetectionLength11
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * USART_LINBreakDetectionConfig(USART_LINBreakDetectionLength11)
  * @endcode
  */
void USART_LINBreakDetectionConfig(USART_LINBreakDetectionLength_TypeDef USART_LINBreakDetectionLength)
{
  assert_param(IS_USART_LINBREAKDETECTIONLENGTH_VALUE_OK(USART_LINBreakDetectionLength));

  if (USART_LINBreakDetectionLength == USART_BREAK10BITS)
  {
    USART->CR4 &= ((u8)~USART_CR4_LBDL);
  }
  else
  {
    USART->CR4 |= USART_CR4_LBDL;
  }
}


/**
  * @brief Enables or disables the USART’s LIN mode.
  * @par Full description:
  * Enables or disables the USART’s LIN mode.
  * @param[in] NewState is new state of the USART LIN mode.
  *                    This parameter can be: ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * USART_LINCmd(ENABLE)
  * @endcode
  */
void USART_LINCmd(FunctionalState NewState)
{
  assert_param(IS_STATE_VALUE_OK(NewState));

  if (NewState)
  {
    /* Enable the LIN mode by setting the LINE bit in the CR2 register */
    USART->CR3 |= USART_CR3_LINEN;
  }
  else
  {
    /* Disable the LIN mode by clearing the LINE bit in the CR2 register */
    USART->CR3 &= ((u8)~USART_CR3_LINEN);
  }
}


/**
  * @brief Returns the most recent received data by the USART peripheral.
  * @par Full description:
  * Returns the most recent received data by the USART peripheral.
  * @retval u16 Received Data
  * @par Required preconditions:
  * USART_Cmd(ENABLE);
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * u8 my_data;
  * my_data = USART_ReceiveData8();
  * @endcode
  */
u8 USART_ReceiveData8(void)
{
  return USART->DR;
}


/**
  * @brief Returns the most recent received data by the USART peripheral.
  * @par Full description:
  * Returns the most recent received data by the USART peripheral.
  * @retval u16 Received Data
  * @par Required preconditions:
  * USART_Cmd(ENABLE);
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * u16 my_data;
  * my_data = USART_ReceiveData9();
  * @endcode
  */
u16 USART_ReceiveData9(void)
{
  return (u16)( (((u16) USART->DR) | ((u16)(((u16)( (u16)USART->CR1 & (u16)USART_CR1_R8)) << 1))) & ((u16)0x01FF));
}

/**
  * @brief Determines if the USART is in mute mode or not.
  * @par Full description:
  * Determines if the USART is in mute mode or not.
  * @param[in] NewState: new state of the USART mode.
  *                    This parameter can be: ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * USART_ReceiverWakeUpCmd(DISABLE);
  * @endcode
  */
void USART_ReceiverWakeUpCmd(FunctionalState NewState)
{
  assert_param(IS_STATE_VALUE_OK(NewState));

  if (NewState)
  {
    /* Enable the mute mode USART by setting the RWU bit in the CR2 register */
    USART->CR2 |= USART_CR2_RWU;
  }
  else
  {
    /* Disable the mute mode USART by clearing the RWU bit in the CR1 register */
    USART->CR2 &= ((u8)~USART_CR2_RWU);
  }
}

/**
  * @brief Transmits break characters.
  * @par Full description:
  * Transmits break characters on the USART peripheral.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * USART_SendBreak();
  * @endcode
  */
void USART_SendBreak(void)
{
  USART->CR2 |= USART_CR2_SBK;
}

/**
  * @brief Transmits 8 bit data through the USART peripheral.
  * @par Full description:
  * Transmits 8 bit data through the USART peripheral.
  * @param[in] Data: the data to transmit.
  * @retval void None
  * @par Required preconditions:
  * USART_Cmd(ENABLE);
  * @par Called functions:
  * None
  * @par Example:
  * Send 0x55 using USART
  * @code
  * u8 my_data = 0x55;
  * USART_SendData8(my_data);
  * @endcode
  */
void USART_SendData8(u8 Data)
{
  /* Transmit Data */
  USART->DR = Data;
}

/**
  * @brief Transmits 9 bit data through the USART peripheral.
  * @par Full description:
  * Transmits 9 bit data through the USART peripheral.
  * @param[in] Data: the data to transmit.
  * @retval void None
  * @par Required preconditions:
  * USART_Cmd(ENABLE);
  * @par Called functions:
  * None
  * @par Example:
  * Send 0x103 using USART
   * @code
  * u16 my_data = 0x103;
  * USART_SendData9(my_data);
  * @endcode
  */
void USART_SendData9(u16 Data)
{

  USART->CR1 &= ((u8)~USART_CR1_T8);                  /**< Clear the transmit data bit 8     */
  USART->CR1 |= (u8)(((u8)(Data >> 2)) & USART_CR1_T8); /**< Write the transmit data bit [8]   */
  USART->DR   = (u8)(Data);                    /**< Write the transmit data bit [0:7] */

}



/**
  * @brief Sets the address of the USART node.
  * @par Full description:
  * Sets the address of the USART node.
  * @param[in] USART_Address: Indicates the address of the USART node.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Set the address of the USART node at 0x04
  * @code
  * u8 my_USART_Address = 0x04;
  * USART_SetAddress(my_USART_Address);
  * @endcode
  */
void USART_SetAddress(u8 USART_Address)
{
  /*assert_param for USART_Address*/
  assert_param(IS_USART_ADDRESS_VALUE_OK(USART_Address));

  /* Clear the USART address */
  USART->CR4 &= ((u8)~USART_CR4_ADD);
  /* Set the USART address node */
  USART->CR4 |= USART_Address;
}

/**
  * @brief Sets the specified USART guard time.
  * @par Full description:
  * Sets the address of the USART node.
  * @par This function is related to SmartCard mode.
  * @param[in] USART_GuardTime: specifies the guard time.
  * @retval void None
  * @par Required preconditions:
  * SmartCard Mode Enabled
  * @par Called functions:
  * None
  * @par Example:
  * The USART guard time counter count up to 0x44 until TC is assert_paramed high.
  * @code
    * USART_SetGuardTime(0x44);
  * @endcode
  */
void USART_SetGuardTime(u8 USART_GuardTime)
{
  /* Set the USART guard time */
  USART->GTR = USART_GuardTime;
}

/**
  * @brief Sets the system clock prescaler.
  * @par Full description:
  * Sets the system clock prescaler.
  * @par This function is related to SmartCard and IrDa mode.
  * @param[in] USART_Prescaler: specifies the prescaler clock.
  *                    This parameter can be one of the following values:
  *                       @par IrDA Low Power Mode
  *   The clock source is diveded by the value given in the register (8 bits)
  *                       - 0000 0000 Reserved
  *                       - 0000 0001 divides the clock source by 1
  *                       - 0000 0010 divides the clock source by 2
  *                       - ...........................................................
  *                       @par Smart Card Mode
  *   The clock source is diveded by the value given in the register (5 significant bits) multipied by 2
  *                       - 0 0000 Reserved
  *                       - 0 0001 divides the clock source by 2
  *                       - 0 0010 divides the clock source by 4
  *                       - 0 0011 divides the clock source by 6
  *                       - ...........................................................
  * @retval void None
  * @par Required preconditions:
  * IrDA Low Power mode or smartcard mode enabled
  * @par Called functions:
  * None
  * @par Example:
  * Sets USART prescalerfor SmartCard divided by 2.
  * @code
  * USART_SmartCardCmd(Enable);
  * USART_SetPrescaler(0x01);
  * @endcode
  */
void USART_SetPrescaler(u8 USART_Prescaler)
{
  /* Load the USART prescaler value*/
  USART->PSCR = USART_Prescaler;
}

/**
  * @brief Enables or disables the USART Smart Card mode.
  * @par Full description:
  * Enables or disables the USART Smart Card mode.
  * @par This function is related to SmartCard mode.
  * @param[in] NewState: new state of the Smart Card mode.
  *                    This parameter can be: ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Disable USART Smart Card mode.
  * @code
    * USART_SmartCardCmd(DISABLE);
  * @endcode
  */
void USART_SmartCardCmd(FunctionalState NewState)
{
  assert_param(IS_STATE_VALUE_OK(NewState));

  if (NewState)
  {
    /* Enable the SC mode by setting the SCEN bit in the CR5 register */
    USART->CR5 |= USART_CR5_SCEN;
  }
  else
  {
    /* Disable the SC mode by clearing the SCEN bit in the CR5 register */
    USART->CR5 &= ((u8)(~USART_CR5_SCEN));
  }
}

/**
  * @brief Enables or disables NACK transmission.
  * @par Full description:
  * Enables or disables NACK transmission.
  * @par This function is valid only for USART because is related to SmartCard mode.
  * @param[in] NewState: new state of the Smart Card mode.
  *                    This parameter can be: ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Disable USART NACK transmission.
  * @code
    * USART_SmartCardNACKCmd(DISABLE);
  * @endcode
  */
void USART_SmartCardNACKCmd(FunctionalState NewState)
{
  assert_param(IS_STATE_VALUE_OK(NewState));

  if (NewState)
  {
    /* Enable the NACK transmission by setting the NACK bit in the CR5 register */
    USART->CR5 |= USART_CR5_NACK;
  }
  else
  {
    /* Disable the NACK transmission by clearing the NACK bit in the CR5 register */
    USART->CR5 &= ((u8)~(USART_CR5_NACK));
  }
}

/**
  * @brief Selects the USART WakeUp method.
  * @par Full description:
  * Selects the USART WakeUp method.
  * @param[in] USART_WakeUp: specifies the USART wakeup method.
  *                    This parameter can be one of the following values:
  *                        - USART_WakeUp_IdleLine
  *                        - USART_WakeUp_AddressMark
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * USART WakeUp Idle line .
  * @code
    * USART_WakeUpConfig(USART_WakeUp_IdleLine);
  * @endcode
  */
void USART_WakeUpConfig(USART_WakeUp_TypeDef USART_WakeUp)
{
  assert_param(IS_USART_WAKEUP_VALUE_OK(USART_WakeUp));

  USART->CR1 &= ((u8)~USART_CR1_WAKE);
  USART->CR1 |= (u8)USART_WakeUp;
}

/**
  * @}
  */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
