/**
  ********************************************************************************
  * @file stm8_linuart.c
  * @brief This file contains all the functions for the LINUART peripheral.
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
#include "stm8_linuart.h"
#include "stm8_clk.h"

/* LINKER SECTIONS DEFINITION FOR THIS FILE ONLY */
#ifdef USE_COSMIC_SECTIONS
#pragma section (LINUART_CODE)
#pragma section const {LINUART_CONST}
#pragma section @near [LINUART_URAM]
#pragma section @near {LINUART_IRAM}
#pragma section @tiny [LINUART_UZRAM]
#pragma section @tiny {LINUART_IZRAM}
#endif

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/

/* Private functions ---------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/

/** @}
  * @addtogroup LINUART_Public_Functions
  * @{
  */

/**
 * @brief Clears the LINUART flags.
 * @par Full description:
 * Clears the LINUART flags.
 * @param[in] LINUART_FLAG specifies the flag to clear
 *  This parameter can be one of the following values:
 *                       - LINUART_FLAG_LBD
 *                       - LINUART_FLAG_TXE
 *                       - LINUART_FLAG_TC
 *                       - LINUART_FLAG_RXNE
 *                       - LINUART_FLAG_IDLE
 *                       - LINUART_FLAG_SBK
 *                       - LINUART_FLAG_ORE_LHE
 *                       - LINUART_FLAG_NE
 *                       - LINUART_FLAG_FE
 *                       - LINUART_FLAG_PE
 *                       - LINUART_FLAG_LHDF     
 *                       - LINUART_FLAG_LSF    
 * @retval void None
 * @par Required preconditions:
 * None
 * @par Called functions:
 * None
 * @par Example:
 * Clear the LINUART TC flag
 * @code
 * LINUART_ClearFlag(LINUART_FLAG_TC);
 * @endcode
 */

void LINUART_ClearFlag(LINUART_Flag_TypeDef LINUART_FLAG)
{
  u8 dummy =0x00;
  assert_param(IS_LINUART_FLAG_VALUE_OK(LINUART_FLAG));

  switch (LINUART_FLAG)
  {
      /*< Clear the Transmit Register Empty flag    */
    case LINUART_FLAG_TXE:
      LINUART->DR = (u8)0x00;
		  break;
      /*< Clear the Transmission Complete flag      */
    case LINUART_FLAG_TC:
     dummy = LINUART->SR;
     LINUART->DR = (u8)0x00;
      break;
      /*< Clear the Receive Register Not Empty flag */
    case LINUART_FLAG_RXNE:
      dummy = LINUART->DR; /*< Read Data Register   */
      break;
      /*< Clear the Idle Detection flag             */
    case LINUART_FLAG_IDLE:
      /*< Clear the Overrun Error flag or Clear the LIN Header Error flag       */
    case LINUART_FLAG_ORE_LHE:
      /*< Clear the Noise Error flag                */
    case LINUART_FLAG_NE:
      /*< Clear the Framing Error flag              */
    case LINUART_FLAG_FE:
      /*< Clear the Parity Error flag               */
    case LINUART_FLAG_PE:
      dummy = LINUART->SR; /*< Read Status Register */
      dummy = LINUART->SR; /*< Read Status Register */  /*TBD*/
      dummy = LINUART->DR; /*< Read Data Register   */
      break;

      /*< Clear the LIN Break Detection flag */
    case LINUART_FLAG_LBD:
      LINUART->CR4 &= (u8)(~LINUART_CR4_LBDF);
      break;
    case LINUART_FLAG_LHDF:
      /* LINUART->CR5; */ /*TBD*/
      break;
    case LINUART_FLAG_LSF:
      LINUART->CR5 &= (u8)(~LINUART_CR5_LSF); /*TBD*/
      break;
    case LINUART_FLAG_SBK:
      LINUART->CR2 &= (u8)(~LINUART_CR2_SBK);
      break;
    default:
      break;
  }
}
/**
 * @brief Clears the LINUART pending Bit.
 * @par Full description:
 * Clears the LINUART pending bit.
 * @param[in] LINUART_FLAG specifies the flag to clear
 *  This parameter can be one of the following values:
 *                       - LINUART_FLAG_LBD
 *                       - LINUART_FLAG_TXE
 *                       - LINUART_FLAG_TC
 *                       - LINUART_FLAG_RXNE
 *                       - LINUART_FLAG_IDLE
 *                       - LINUART_FLAG_ORE_LHE
 *                       - LINUART_FLAG_PE
 *                       - LINUART_FLAG_LHDF     
 * @retval void None
 * @par Required preconditions:
 * None
 * @par Called functions:
 * None
 * @par Example:
 * Clear the LINUART TC flag
 * @code
 * LINUART_ClearFlag(LINUART_FLAG_TC);
 * @endcode
 */

void LINUART_ClearITPendingBit(LINUART_Flag_TypeDef LINUART_FLAG)
{
  u8 dummy =0x00;
  assert_param(IS_LINUART_ITPENDINGBIT_VALUE_OK(LINUART_FLAG));

  switch (LINUART_FLAG)
  {
      /*< Clear the Transmit Register Empty pending bit    */
    case LINUART_FLAG_TXE:
      LINUART->DR = (u8)0x00;
	    break;
      /*< Clear the Transmission Complete pending bit      */
    case LINUART_FLAG_TC:
      dummy = LINUART->SR;
      LINUART->DR = (u8)0x00;
      break;
      /*< Clear the Receive Register Not Empty pending bit */
    case LINUART_FLAG_RXNE:
      dummy = LINUART->DR; /*< Read Data Register   */
			dummy = LINUART->DR; /*< Read Data Register   */
      break;
      /*< Clear the Idle Detection pending bit             */
    case LINUART_FLAG_IDLE:
      /*< Clear the Overrun Error flag or Clear the LIN Header Error pending bit       */
    case LINUART_FLAG_ORE_LHE:
      /*< Clear the Parity Error pending bit               */
    case LINUART_FLAG_PE:
      dummy = LINUART->SR; /*< Read Status Register */
      dummy = LINUART->SR; /*< Read Status Register */  /*TBD*/
      dummy = LINUART->DR; /*< Read Data Register   */
      break;

      /*< Clear the LIN Break Detection pending bit */
    case LINUART_FLAG_LBD:
      LINUART->CR4 &= (u8)(~LINUART_CR4_LBDF);
      break;
    case LINUART_FLAG_LHDF:
      /* LINUART->CR5; */ /*TBD*/
      break;
    case LINUART_FLAG_NE:
    case LINUART_FLAG_FE:
    case LINUART_FLAG_LSF:
    case LINUART_FLAG_SBK:
    default:
      break;
  }
}

/**
  * @brief Enable the LINUART peripheral.
  * @par Full description:
  * Enable the LINUART peripheral.
  * @param[in] NewState new state of the LINUART Communication.
  *                    This parameter can be: ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Enable LINUART peripheral.
  * @code
  * LINUART_Cmd(ENABLE);
  * @endcode
  */
void LINUART_Cmd(FunctionalState NewState)
{

  if (NewState)
  {
    LINUART->CR1 &= (u8)(~LINUART_CR1_UARTD); /**< LINUART Enable */
  }
  else
  {
    LINUART->CR1 |= LINUART_CR1_UARTD;  /**< LINUART Disable (for low power consumption) */
  }
}

/**
  * @brief Deinitializes the LINUART peripheral.
  * @par Full description:
  * Set the LINUART peripheral registers to their default reset values.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Deinitialize LINUART peripheral.
  * @code
  * LINUART_DeInit();
  * @endcode
  */

void LINUART_DeInit(void)
{
  u8 dummy;
  /*< Clear the Idle Line Detected bit in the status rerister by a read
     to the LINUART_SR register followed by a Read to the LINUART_DR register */
  dummy = LINUART->SR;
  dummy = LINUART->DR;

  LINUART->BRR2 = LINUART_BRR2_RESET_VALUE;  /*< Set LINUART_BRR2 to reset value 0x00 */
  LINUART->BRR1 = LINUART_BRR1_RESET_VALUE;  /*< Set LINUART_BRR1 to reset value 0x00 */

  LINUART->CR1 = LINUART_CR1_RESET_VALUE; /*< Set LINUART_CR1 to reset value 0x00  */
  LINUART->CR2 = LINUART_CR2_RESET_VALUE; /*< Set LINUART_CR2 to reset value 0x00  */
  LINUART->CR3 = LINUART_CR3_RESET_VALUE;  /*< Set LINUART_CR3 to reset value 0x00  */
  LINUART->CR4 = LINUART_CR4_RESET_VALUE;  /*< Set LINUART_CR4 to reset value 0x00  */
  LINUART->CR5 = LINUART_CR5_RESET_VALUE; /*< Set LINUART_CR5 to reset value 0x00  */

}


/**
  * @brief Checks whether the specified LINUART flag is set or not.
  * @par Full description:
  * Checks whether the specified LINUART flag is set or not.
  * @param[in] LINUART_FLAG specifies the flag to check.
  *                    This parameter can be one of the following values:
  *                       - LINUART_FLAG_LBD
  *                       - LINUART_FLAG_TXE
  *                       - LINUART_FLAG_TC
  *                       - LINUART_FLAG_RXNE
  *                       - LINUART_FLAG_IDLE
  *                       - LINUART_FLAG_ORE_LHE
  *                       - LINUART_FLAG_NE
  *                       - LINUART_FLAG_FE
  *                       - LINUART_FLAG_PE
  *                       - LINUART_FLAG_SBK
  *                       - LINUART_FLAG_LHDF
  *                       - LINUART_FLAG_LSF 
  * @retval FlagStatus (SET or RESET)
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Check the status of TC flag.
  * @code
  * FlagStatus TC_flag;
  * TC_Flag = LINUART_GetFlagStatus(LINUART_FLAG_TC);
  * @endcode
  */
FlagStatus LINUART_GetFlagStatus(LINUART_Flag_TypeDef LINUART_FLAG)
{
  FlagStatus status = RESET;
  u8 itpos = 0;

  /* Check parameters */
  assert_param(IS_LINUART_FLAG_VALUE_OK(LINUART_FLAG));

  /* Get the LINUART_FLAG index*/
  itpos = (u8)((u8)1 << (u8)((u8)LINUART_FLAG & (u8)0x0F));

  /* Check the status of the specified LINUART flag*/
  switch (LINUART_FLAG)
  {
    case LINUART_FLAG_LBD:
      if ((LINUART->CR4 & itpos) != (u8)0x00)
      {
        /* LINUART_FLAG is set*/
        status = SET;
      }
      else
      {
        /* LINUART_FLAG is reset*/
        status = RESET;
      }
      break;
      /*< Returns the Transmit Data Register Empty flag     */
    case LINUART_FLAG_TXE:
      /*< Returns the Transmission Complete flag state   */
    case LINUART_FLAG_TC:
      /*< Returns the Read Data Not Empty flag state     */
    case LINUART_FLAG_RXNE:
      /*< Returns the IDLE Detection flag state          */
    case LINUART_FLAG_IDLE:
      /*< Returns the Overrun Error flag state           */
    case LINUART_FLAG_ORE_LHE:
      /*< Returns the Noise Error flag state             */
    case LINUART_FLAG_NE:
      /*< Returns the Framing Error flag state           */
    case LINUART_FLAG_FE:
      /*< Returns the Parity Error flag state            */
    case LINUART_FLAG_PE:

      if ((LINUART->SR & itpos) != (u8)0x00)
      {
        /* LINUART_FLAG is set*/
        status = SET;
      }
      else
      {
        /* LINUART_FLAG is reset*/
        status = RESET;
      }

      break;
      /*< Returns the Send Break flag state */
    case LINUART_FLAG_SBK:
      if ((LINUART->CR2 & itpos) != (u8)0x00)
      {
        /* LINUART_FLAG is set*/
        status = SET;
      }
      else
      {
        /* LINUART_FLAG is reset*/
        status = RESET;
      }
      break;
    case LINUART_FLAG_LHDF:
    case LINUART_FLAG_LSF:
      if ((LINUART->CR5 & itpos) != (u8)0x00)
      {
        status = SET;
      }
      else
      {
        status = RESET;
      }
      break;
    default:
      status = SET;
      break;
  }
  /* Return the LINUART_FLAG status*/
  return  status;
}
/**
  * @brief Checks whether the specified LINUART interrupt has occurred or not.
  * @par Full description:
  * Checks whether the specified LINUART interrupt has occurred or not.
  * @param[in] LINUART_FLAG Specifies the LINUART interrupt source to check.
	*  This parameter can be one of the following values:
  *                       - LINUART_FLAG_LBD
  *                       - LINUART_FLAG_TXE
  *                       - LINUART_FLAG_TC
  *                       - LINUART_FLAG_RXNE
  *                       - LINUART_FLAG_IDLE
  *                       - LINUART_FLAG_ORE_LHE
  *                       - LINUART_FLAG_PE
  *                       - LINUART_FLAG_LHDF  
  * @retval ITStatus The new state of LINUART_IT (SET or RESET).
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * IT_Status PIEN_ITStatus;
  * PIEN_ITStatus = LINUART_GetITStatus(LINUART_FLAG_TC);
  * @endcode
  */
ITStatus LINUART_GetITStatus(LINUART_Flag_TypeDef LINUART_FLAG)
{

  ITStatus pendingbitstatus = RESET;
  u8 itpos = 0;
  u8 itmask1 = 0;
  u8 itmask2 = 0;
  u8 enablestatus = 0;

  /* Check parameters */
  assert_param(IS_LINUART_ITPENDINGBIT_VALUE_OK(LINUART_FLAG));

  /* Get the LINUART IT index*/
  itpos = (u8)((u8)1 << (u8)((u8)LINUART_FLAG & (u8)0x0F));
  /* Get the LINUART IT index*/
  itmask1 = (u8)((u8)LINUART_FLAG >> (u8)4);
  /* Set the IT mask*/
  itmask2 = (u8)((u8)1 << itmask1);

  switch (LINUART_FLAG)
  {
    case LINUART_FLAG_LBD:
      /* Get the LINUART_FLAG enable bit status*/
      enablestatus = (u8)((u8)LINUART->CR4 & itmask2);
      /* Check the status of the specified LINUART interrupt*/
      if (((LINUART->CR4 & itpos) != (u8)0x00) && enablestatus)
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

    case LINUART_FLAG_PE:

      /* Get the LINUART_FLAG enable bit status*/
      enablestatus = (u8)((u8)LINUART->CR1 & itmask2);
      /* Check the status of the specified LINUART interrupt*/

      if (((LINUART->SR & itpos) != (u8)0x00) && enablestatus)
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

    case LINUART_FLAG_TXE:
    case LINUART_FLAG_TC:
    case LINUART_FLAG_RXNE:
    case LINUART_FLAG_IDLE:
    case LINUART_FLAG_ORE_LHE:
      /* Get the LINUART_FLAG enable bit status*/
      enablestatus = (u8)((u8)LINUART->CR2 & itmask2);
      /* Check the status of the specified LINUART interrupt*/
      if (((LINUART->SR & itpos) != (u8)0x00) && enablestatus)
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
    case LINUART_FLAG_LHDF:
      /* Get the LINUART_FLAG enable bit status*/
      enablestatus = (u8)((u8)LINUART->CR5 & itmask2);
      /* Check the status of the specified LINUART interrupt*/
      if (((LINUART->CR5 & itpos) != (u8)0x00) && enablestatus)
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
    case LINUART_FLAG_NE:
    case LINUART_FLAG_FE:
    case LINUART_FLAG_LSF:
    case LINUART_FLAG_SBK:
    default:
      pendingbitstatus = SET;
      break;
  }

  /* Return the LINUART_FLAG status*/
  return  pendingbitstatus;

}

/**
  * @brief Fills LINUART_InitStruct members with default value.
  * @param[in] LINUART_InitStruct Pointer to LINUART_Init_TypeDef structure that will be initialized.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * LINUART_Init_TypeDef LINUART_InitStructure;
  * LINUART_StructInit(&LINUART_InitStructure);
  * @endcode
  */
void LINUART_StructInit(LINUART_Init_TypeDef* LINUART_InitStruct)
{
  LINUART_InitStruct->WordLength          = LINUART_WORDLENGTH_8D;
  LINUART_InitStruct->StopBits            = LINUART_STOPBITS_1;
  LINUART_InitStruct->Parity              = LINUART_PARITY_NO;
  LINUART_InitStruct->BaudRate            = (u32)9600;
  LINUART_InitStruct->Mode                = LINUART_MODE_TXRX_ENABLE;
}
	
/**
  * @brief Initializes the LINUART according to the specified parameters.
  * @retval void None
  * @par Required preconditions:
  * You can call LINUART_InitStruct before in order to initialize the structure members.
  * @par Called functions:
  * CLK_GetClockFreq().
  * @par Example:
  * @code
  * LINUART_Init_TypeDef LINUART_InitStructure;
  * LINUART_Init(&LINUART_InitStructure);
  * @endcode
  */
void LINUART_Init(LINUART_Init_TypeDef* LINUART_InitStruct)
{
  u8 BRR2_1, BRR2_2;
  u32 BaudRate_Mantissa, BaudRate_Mantissa100;

  assert_param(IS_LINUART_WORDLENGTH_VALUE_OK(LINUART_InitStruct->WordLength));

  assert_param(IS_LINUART_STOPBITS_VALUE_OK(LINUART_InitStruct->StopBits));

  assert_param(IS_LINUART_PARITY_VALUE_OK(LINUART_InitStruct->Parity));

  /* assert_param: BaudRate value should be <= 625000 bps */
  assert_param(IS_LINUART_BAUDRATE_OK(LINUART_InitStruct->BaudRate));

  /* assert_param: LINUART_Mode value should exclude values such as  LINUART_ModeTx_Enable|LINUART_ModeTx_Disable */
  assert_param(IS_LINUART_MODE_VALUE_OK((u8)LINUART_InitStruct->Mode));

  /* Wait for no Transmition before modifying the M bit */
  /* while(!(LINUART->SR&LINUART_SR_TC));      */

  LINUART->CR1 &= (u8)(~LINUART_CR1_M);     /**< Clear the word length bit */
  LINUART->CR1 |= (u8)LINUART_InitStruct->WordLength; /**< Set the word length bit according to LINUART_WordLength value */

  LINUART->CR3 &= (u8)(~LINUART_CR3_STOP);  /**< Clear the STOP bits */
  LINUART->CR3 |= (u8)LINUART_InitStruct->StopBits;  /**< Set the STOP bits number according to LINUART_StopBits value  */

  LINUART->CR1 &= (u8)(~(LINUART_CR1_PCEN | LINUART_CR1_PS));  /**< Clear the Parity Control bit */
  LINUART->CR1 |= (u8)LINUART_InitStruct->Parity;     /**< Set the Parity Control bit to LINUART_Parity value */

  LINUART->BRR1 &= (u8)(~LINUART_BRR1_DIVM);  /**< Clear the LSB mantissa of LINUARTDIV  */
  LINUART->BRR2 &= (u8)(~LINUART_BRR2_DIVM);  /**< Clear the MSB mantissa of LINUARTDIV  */
  LINUART->BRR2 &= (u8)(~LINUART_BRR2_DIVF);  /**< Clear the Fraction bits of LINUARTDIV */

  /**< Set the LINUART BaudRates in BRR1 and BRR2 registers according to LINUART_BaudRate value */
  BaudRate_Mantissa    = ((u32)CLK_GetClockFreq() / (LINUART_InitStruct->BaudRate << 4));
  BaudRate_Mantissa100 = (((u32)CLK_GetClockFreq() * 100) / (LINUART_InitStruct->BaudRate << 4));
  BRR2_1 = (u8)((u8)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
                      << 4) / 100) & (u8)0x0F); /**< Set the fraction of USARTDIV  */
  BRR2_2 = (u8)((BaudRate_Mantissa >> 4) & (u8)0xF0);

  LINUART->BRR2 = (u8)(BRR2_1 | BRR2_2);
  LINUART->BRR1 = (u8)BaudRate_Mantissa;           /**< Set the LSB mantissa of LINUARTDIV  */

  if ((u8)LINUART_InitStruct->Mode&(u8)LINUART_MODE_TX_ENABLE)
  {
    LINUART->CR2 |= LINUART_CR2_TEN;  /**< Set the Transmitter Enable bit */
  }
  else
  {
    LINUART->CR2 &= (u8)(~LINUART_CR2_TEN);  /**< Clear the Transmitter Disable bit */
  }
  if ((u8)LINUART_InitStruct->Mode & (u8)LINUART_MODE_RX_ENABLE)
  {
    LINUART->CR2 |= LINUART_CR2_REN;  /**< Set the Receiver Enable bit */
  }
  else
  {
    LINUART->CR2 &= (u8)(~LINUART_CR2_REN);  /**< Clear the Receiver Disable bit */
  }
}

/**
  * @brief Enables or disables the specified LINUART interrupts.
  * @par Full description:
  * Enables or disables the specified LINUART interrupts.
  * @param[in] LINUART_IT Specifies the LINUART interrupt sources to be
  * enabled or disabled.
  * @param[in] NewState New state of the specified LINUART interrupts.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * LINUART_ITConfig(LINUART_IT_PIEN, ENABLE)
  * @endcode
  */
void LINUART_ITConfig(LINUART_IT_TypeDef LINUART_IT, FunctionalState NewState)
{
  assert_param(IS_LINUART_IT_VALUE_OK(LINUART_IT));
  assert_param(IS_STATE_VALUE_OK(NewState));

  if (NewState)
  {
    /**< Enable the Interrupt bits according to LINUART_IT mask */
    LINUART->CR2 |= (u8)(((u8)LINUART_IT) & (u8)(LINUART_CR2_TIEN | LINUART_CR2_TCIEN | LINUART_CR2_RIEN | LINUART_CR2_ILIEN));
    LINUART->CR1 |= (u8)((u8)LINUART_IT & LINUART_CR1_PIEN);
    LINUART->CR4 |= (u8)((u8)((u8)LINUART_IT << 3) & LINUART_CR4_LBDIEN);
    LINUART->CR5 |= (u8)((u8)LINUART_IT  & LINUART_CR5_LHDIEN);
  }
  else
  {
    /**< Disable the interrupt bits according to LINUART_IT mask */

    LINUART->CR2 &= (u8)(~(((u8)LINUART_IT) & (u8)(LINUART_CR2_TIEN | LINUART_CR2_TCIEN | LINUART_CR2_RIEN | LINUART_CR2_ILIEN)));
    LINUART->CR1 &= (u8)(~((u8)LINUART_IT & LINUART_CR1_PIEN));

LINUART->CR4 &= (u8)(~((u8)((u8)LINUART_IT << 3) & LINUART_CR4_LBDIEN));
    LINUART->CR5 &= (u8)(~((u8)LINUART_IT  & LINUART_CR5_LHDIEN));
  }

}

/**
  * @brief Sets the LINUART LIN Break detection length.
  * @par Full description:
  * Sets the LINUART LIN Break detection length.
  * @param[in] LINUART_LINBreakDetectionLength specifies the LIN break
  *                    detection length.
  *                    This parameter can be one of the following values:
  *                       - LINUART_BREAK10BITS
  *                       - LINUART_BREAK11BITS
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * LINUART_LINBreakDetectionConfig(LINUART_BREAK11BITS)
  * @endcode
  */
void LINUART_LINBreakDetectionConfig(LINUART_LINBreakDetectionLength_TypeDef LINUART_LINBreakDetectionLength)
{
  assert_param(IS_LINUART_LINBREAKDETECTIONLENGTH_VALUE_OK(LINUART_LINBreakDetectionLength));

  if (LINUART_LINBreakDetectionLength == LINUART_BREAK10BITS)
  {
    LINUART->CR4 &= ((u8)~LINUART_CR4_LBDL);
  }
  else
  {
    LINUART->CR4 |= LINUART_CR4_LBDL;
  }
}

/**
  * @brief Configue the LINUART peripheral.
  * @par Full description:
  * Configue the LINUART peripheral.
  * @param[in] LINUART_Slave specifies the LIN mode.
  *                    This parameter can be one of the following values:
  *                       - LINUART_LIN_MASTER_MODE
  *                       - LINUART_LIN_SLAVE_MODE
	* @param[in] LINUART_Autosync specifies the LIN automatic resynchronization mode.
  *                    This parameter can be one of the following values:
  *                       - LINUART_LIN_AUTOSYNC_ENABLE
  *                       - LINUART_LIN_AUTOSYNC_DISABLE
	* @param[in] LINUART_DivUp specifies the LIN divider update method.
  *                    This parameter can be one of the following values:
  *                       - LINUART_LIN_DIVUP_LBRR1
  *                       - LINUART_LIN_DIVUP_NEXTRXNE
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * LINUART_LINConfig(LINUART_LIN_MASTER_MODE,LINUART_LIN_AUTOSYNC_DISABLE,LINUART_LIN_DIVUP_LBRR1);
  * @endcode
  */
void LINUART_LINConfig(LINUART_Slave_TypeDef LINUART_Slave, LINUART_Autosync_TypeDef LINUART_Autosync, LINUART_DivUp_TypeDef LINUART_DivUp)
{
  assert_param(IS_LINUART_SLAVE_VALUE_OK(LINUART_Slave));

  assert_param(IS_LINUART_AUTOSYNC_VALUE_OK(LINUART_Autosync));

  assert_param(IS_LINUART_DIVUP_VALUE_OK(LINUART_DivUp));

  if (LINUART_Slave == LINUART_LIN_MASTER_MODE)
  {
    LINUART->CR5 &= ((u8)~LINUART_CR5_LSLV);
  }
  else
  {
    LINUART->CR5 |=  LINUART_CR5_LSLV;
  }

  if (LINUART_Autosync == LINUART_LIN_AUTOSYNC_DISABLE)
  {
    LINUART->CR5 &= ((u8)~ LINUART_CR5_LASE );
  }
  else
  {
    LINUART->CR5 |=  LINUART_CR5_LASE ;
  }

  if (LINUART_DivUp == LINUART_LIN_DIVUP_LBRR1)
  {
    LINUART->CR5 &= ((u8)~ LINUART_CR5_LDUM);
  }
  else
  {
    LINUART->CR5 |=  LINUART_CR5_LDUM;
  }

}

/**
  * @brief Enables or disables the LINUART LIN mode.
  * @par Full description:
  * Enables or disables the LINUART’s LIN mode.
  * @param[in] NewState is new state of the LINUART LIN mode.
  *                    This parameter can be: ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * LINUART_LINCmd(ENABLE)
  * @endcode
  */
void LINUART_LINCmd(FunctionalState NewState)
{
  assert_param(IS_STATE_VALUE_OK(NewState));

  if (NewState)
  {
    /* Enable the LIN mode by setting the LINE bit in the CR2 register */
    LINUART->CR3 |= LINUART_CR3_LINEN;
  }
  else
  {
    /* Disable the LIN mode by clearing the LINE bit in the CR2 register */
    LINUART->CR3 &= ((u8)~LINUART_CR3_LINEN);
  }
}
/**
  * @brief Returns the most recent received data by the LINUART peripheral.
  * @par Full description:
  * Returns the most recent received data by the LINUART peripheral.
  * @retval u16 Received Data
  * @par Required preconditions:
  * LINUART_Cmd(ENABLE);
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * u8 my_data;
  * my_data = LINUART_ReceiveData8();
  * @endcode
  */
u8 LINUART_ReceiveData8(void)
{
  return LINUART->DR;
}


/**
  * @brief Returns the most recent received data by the LINUART peripheral.
  * @par Full description:
  * Returns the most recent received data by the LINUART peripheral.
  * @retval u16 Received Data
  * @par Required preconditions:
  * LINUART_Cmd(ENABLE);
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * u16 my_data;
  * my_data = LINUART_ReceiveData9();
  * @endcode
  */
u16 LINUART_ReceiveData9(void)
{
  return (u16)((((u16)LINUART->DR) | ((u16)(((u16)((u16)LINUART->CR1 & (u16)LINUART_CR1_R8)) << 1))) & ((u16)0x01FF));
}

/**
  * @brief Determines if the LINUART is in mute mode or not.
  * @par Full description:
  * Determines if the LINUART is in mute mode or not.
  * @param[in] NewState: new state of the LINUART mode.
  *                    This parameter can be: ENABLE or DISABLE.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * LINUART_ReceiverWakeUpCmd(DISABLE);
  * @endcode
  */
void LINUART_ReceiverWakeUpCmd(FunctionalState NewState)
{
  assert_param(IS_STATE_VALUE_OK(NewState));

  if (NewState)
  {
    /* Enable the mute mode LINUART by setting the RWU bit in the CR2 register */
    LINUART->CR2 |= LINUART_CR2_RWU;
  }
  else
  {
    /* Disable the mute mode LINUART by clearing the RWU bit in the CR1 register */
    LINUART->CR2 &= ((u8)~LINUART_CR2_RWU);
  }
}

/**
  * @brief Transmits break characters.
  * @par Full description:
  * Transmits break characters on the LINUART peripheral.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * LINUART_SendBreak();
  * @endcode
  */
void LINUART_SendBreak(void)
{
  LINUART->CR2 |= LINUART_CR2_SBK;
}

/**
  * @brief Transmits 8 bit data through the LINUART peripheral.
  * @par Full description:
  * Transmits 8 bit data through the LINUART peripheral.
  * @param[in] Data: the data to transmit.
  * @retval void None
  * @par Required preconditions:
  * LINUART_Cmd(ENABLE);
  * @par Called functions:
  * None
  * @par Example:
  * Send 0x55 using LINUART
  * @code
  * u8 my_data = 0x55;
  * LINUART_SendData8(my_data);
  * @endcode
  */
void LINUART_SendData8(u8 Data)
{
  /* Transmit Data */
  LINUART->DR = Data;
}

/**
  * @brief Transmits 9 bit data through the LINUART peripheral.
  * @par Full description:
  * Transmits 9 bit data through the LINUART peripheral.
  * @param[in] Data: the data to transmit.
  * @retval void None
  * @par Required preconditions:
  * LINUART_Cmd(ENABLE);
  * @par Called functions:
  * None
  * @par Example:
  * Send 0x103 using LINUART
   * @code
  * u16 my_data = 0x103;
  * LINUART_SendData9(my_data);
  * @endcode
  */
void LINUART_SendData9(u16 Data)
{
  LINUART->CR1 &= ((u8)~LINUART_CR1_T8);                  /**< Clear the transmit data bit 8     */
  LINUART->CR1 |= (u8)(((u8)(Data >> 2)) & LINUART_CR1_T8); /**< Write the transmit data bit [8]   */
  LINUART->DR   = (u8)(Data);                    /**< Write the transmit data bit [0:7] */

}

/**
  * @brief Sets the address of the LINUART node.
  * @par Full description:
  * Sets the address of the LINUART node.
  * @param[in] LINUART_Address: Indicates the address of the LINUART node.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * Set the address of the LINUART node at 0x04
  * @code
  * u8 my_LINUART_Address = 0x04;
  * LINUART_SetAddress(my_LINUART_Address);
  * @endcode
  */
void LINUART_SetAddress(u8 LINUART_Address)
{
  /*assert_param for x LINUART_Address*/
  assert_param(IS_LINUART_LINUART_Address_VALUE_OK(LINUART_Address));

  /* Clear the LINUART address */
  LINUART->CR4 &= ((u8)~LINUART_CR4_ADD);
  /* Set the LINUART address node */
  LINUART->CR4 |= LINUART_Address;
}


/**
  * @brief Selects the LINUART WakeUp method.
  * @par Full description:
  * Selects the LINUART WakeUp method.
  * @param[in] LINUART_WakeUp: specifies the LINUART wakeup method.
  *                    This parameter can be one of the following values:
  *                        - LINUART_WAKEUP_IDLELINE
  *                        - LINUART_WAKEUP_ADDRESSMARK
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * LINUART WakeUp Idle line .
  * @code
    * LINUART_WakeUpConfig(LINUART_WAKEUP_IDLELINE);
  * @endcode
  */
void LINUART_WakeUpConfig(LINUART_WakeUp_TypeDef LINUART_WakeUp)
{
  assert_param(IS_LINUART_WAKEUP_VALUE_OK(LINUART_WakeUp));

  LINUART->CR1 &= ((u8)~LINUART_CR1_WAKE);
  LINUART->CR1 |= (u8)LINUART_WakeUp;
}

/**
  * @}
  */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
