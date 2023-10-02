/**
  ******************************************************************************
  * @file stm8_i2c.c
  * @brief This file contains all the functions for the I2C peripheral.
  * @author STMicroelectronics
  * @version V0.04
  * @date 21-DEC-2007
  ******************************************************************************
  *
  * THE PRESENT SOFTWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
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
#include "stm8_i2c.h"

/* LINKER SECTIONS DEFINITION FOR THIS FILE ONLY */
#ifdef USE_COSMIC_SECTIONS
#pragma section (I2C_CODE)
#pragma section const {I2C_CONST}
#pragma section @near [I2C_URAM]
#pragma section @near {I2C_IRAM}
#pragma section @tiny [I2C_UZRAM]
#pragma section @tiny {I2C_IZRAM}
#endif

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/* Public functions ----------------------------------------------------------*/

/**
  * @addtogroup I2C_Public_Functions
  * @{
  */

/**
  * @brief Deinitializes the I2C peripheral registers to their default reset values.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * I2C_DeInit();
  * @endcode
  */
void I2C_DeInit(void)
{
  I2C->CR1 = I2C_CR1_RESET_VALUE;
  I2C->CR2 = I2C_CR2_RESET_VALUE;
  I2C->FREQR = I2C_FREQR_RESET_VALUE;
  I2C->OARL = I2C_OARL_RESET_VALUE;
  I2C->OARH = I2C_OARH_RESET_VALUE;
  I2C->ITR = I2C_ITR_RESET_VALUE;
  I2C->CCRL = I2C_CCRL_RESET_VALUE;
  I2C->CCRH = I2C_CCRH_RESET_VALUE;
  I2C->TRISER = I2C_TRISER_RESET_VALUE;
}

/**
  * @brief Fills I2C_InitStruct members with default value.
  * @param[in] I2C_InitStruct Pointer to I2C_Init_TypeDef structure that will be initialized.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * I2C_Init_TypeDef I2C_InitStructure;
  * I2C_StructInit(&I2C_InitStructure);
  * @endcode
  */
void I2C_StructInit(I2C_Init_TypeDef* I2C_InitStruct)
{
  I2C_InitStruct->DutyCycle              = I2C_DUTYCYCLE_2;
  I2C_InitStruct->Ack                    = I2C_ACK_NONE;
  I2C_InitStruct->AddMode                = I2C_ADDMODE_10BIT;
  I2C_InitStruct->OwnAddress             = (u16)0x0000;
  I2C_InitStruct->InputClockFrequencyMHz = (u8)2;
  I2C_InitStruct->OutputClockFrequencyHz = (u32)20000;
}

/**
  * @brief Enables or disables the I2C peripheral.
  * @param[in] NewState Indicate the new I2C peripheral state.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * I2C_Cmd(ENABLE);
  * @endcode
  */
void I2C_Cmd(FunctionalState NewState)
{

  /* Check function parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));

  if (NewState != DISABLE)
  {
    I2C->CR1 |= I2C_CR1_PE; /* Enable I2C peripheral */
  }
  else
  {
    I2C->CR1 &= (u8)(~I2C_CR1_PE); /* Disable I2C peripheral */
  }

}

/**
  * @brief Enable or Disable the I2C acknowledge and position acknowledge feature.
  * @param[in] Ack Specifies the acknowledge mode to apply.
  * @retval void None
  * @par Required preconditions:
  * This function must be called before data reception starts.
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * I2C_AcknowledgeConfig(I2C_ACK_NONE);
  * @endcode
  */
void I2C_AcknowledgeConfig(I2C_Ack_Typedef Ack)
{

  /* Check function parameters */
  assert_param(IS_I2C_ACK_OK(Ack));

  if (Ack == I2C_ACK_NONE)
  {
    I2C->CR2 &= (u8)(~I2C_CR2_ACK); /* Disable the acknowledgement */
  }
  else
  {
    I2C->CR2 |= I2C_CR2_ACK; /* Enable the acknowledgement */
    if (Ack == I2C_ACK_CURR)
    {
      I2C->CR2 &= (u8)(~I2C_CR2_POS); /* Configure (N)ACK on current byte */
    }
    else
    {
      I2C->CR2 |= I2C_CR2_POS; /* Configure (N)ACK on next byte */
    }
  }

}

/**
  * @brief Selects the specified I2C fast mode duty cycle.
  * @param[in] DutyCycle Specifies the duty cycle to apply.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * I2C_FastModeDutyCycleConfig(I2C_DUTYCYCLE_16_9);
  * @endcode
  */
void I2C_FastModeDutyCycleConfig(I2C_DutyCycle_Typedef DutyCycle)
{

  /* Check function parameters */
  assert_param(IS_I2C_DUTYCYCLE_OK(DutyCycle));

  if (DutyCycle == I2C_DUTYCYCLE_16_9)
  {
    I2C->CCRH |= I2C_CCRH_DUTY; /* I2C fast mode Tlow/Thigh = 16/9 */
  }
  else /* I2C_DUTYCYCLE_2 */
  {
    I2C->CCRH &= (u8)(~I2C_CCRH_DUTY); /* I2C fast mode Tlow/Thigh = 2 */
  }

}

/**
  * @brief Enables or disables the I2C General Call feature.
  * @param[in] NewState State of the General Call feature to apply.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * I2C_GeneralCallCmd(ENABLE);
  * @endcode
  */
void I2C_GeneralCallCmd(FunctionalState NewState)
{

  /* Check function parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));

  if (NewState == ENABLE)
  {
    I2C->CR1 |= I2C_CR1_ENGC; /* Enable General Call */
  }
  else
  {
    I2C->CR1 &= (u8)(~I2C_CR1_ENGC); /* Disable General Call */
  }

}

/**
  * @brief Generates I2C communication START condition.
  * @param[in] NewState Enable or disable the start condition.
  * @retval void None
  * @par Required preconditions:
  * CCR must be programmed i.e. I2C_Init function must have been called with a valid I2C_ClockSpeed
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * I2C_GenerateSTART(ENABLE);
  * @endcode
  */
void I2C_GenerateSTART(FunctionalState NewState)
{

  /* Check function parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));

  if (NewState == ENABLE)
  {
    I2C->CR2 |= I2C_CR2_START; /* Generate a START condition */
  }
  else
  {
    I2C->CR2 &= (u8)(~I2C_CR2_START); /* Disable the START condition generation */
  }

}

/**
  * @brief Generates I2C communication STOP condition.
  * @param[in] NewState Enable or disable the stop condition.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * I2C_GenerateSTOP(ENABLE);
  * @endcode
  */
void I2C_GenerateSTOP(FunctionalState NewState)
{

  /* Check function parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));

  if (NewState == ENABLE)
  {
    I2C->CR2 |= I2C_CR2_STOP; /* Generate a STOP condition */
  }
  else
  {
    I2C->CR2 &= (u8)(~I2C_CR2_STOP); /* Disable the STOP condition generation */
  }

}

/**
  * @brief Returns the specified I2C flag state
  * @param[in] Flag Specifies the flag to read
  * @retval FlagStatus State of the flag
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * FlagStatus status;
  * status = I2C_GetFlagStatus(I2C_FLAG_ADDRESSSENTMATCHED);
  * @endcode
  */
FlagStatus I2C_GetFlagStatus(I2C_Flag_TypeDef Flag)
{

  FlagStatus bitstatus = RESET;

  /* Check the parameters */
  assert_param(IS_I2C_FLAG_OK(Flag));

  /* Check SRx index */
  switch ((u16)Flag & (u16)0xF000)
  {

    /* Returns whether the status register to check is SR1 */
    case 0x1000:
      /* Check the status of the specified I2C flag */
      if ((I2C->SR1 & (u8)Flag) != 0)
      {
        /* Flag is set */
        bitstatus = SET;
      }
      else
      {
        /* Flag is reset */
        bitstatus = RESET;
      }
      break;

    /* Returns whether the status register to check is SR2 */
    case 0x2000:
      /* Check the status of the specified I2C flag */
      if ((I2C->SR2 & (u8)Flag) != 0)
      {
        /* Flag is set */
        bitstatus = SET;
      }
      else
      {
        /* Flag is reset */
        bitstatus = RESET;
      }
      break;

    /* Returns whether the status register to check is SR3 */
    case 0x3000:
      /* Check the status of the specified I2C flag */
      if ((I2C->SR3 & (u8)Flag) != 0)
      {
        /* Flag is set */
        bitstatus = SET;
      }
      else
      {
        /* Flag is reset */
        bitstatus = RESET;
      }
      break;

    default:
      break;

  }

  /* Return the flag status */
  return bitstatus;

}

/**
  * @brief Enables or disables the specified I2C interrupt.
  * @param[in] ITName Name of the interrupt to enable or disable.
  * @param[in] NewState State of the interrupt to apply.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * I2C_ITConfig(I2C_IT_BUF_ERR, ENABLE);
  * @endcode
  */
void I2C_ITConfig(I2C_IT_Typedef ITName, FunctionalState NewState)
{

  /* Check functions parameters */
  assert_param(IS_I2C_INTERRUPT_OK(ITName));
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));

  if (NewState == ENABLE)
  {
    I2C->ITR |= (u8)ITName; /* Enable the selected I2C interrupts */
  }
  else
  {
    I2C->ITR &= (u8)(~(u8)ITName); /* Disable the selected I2C interrupts */
  }

}

/**
  * @brief Returns the most recent received data.
  * @par Parameters:
  * None
  * @retval u8 The value of the received byte data.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * u8 data;
  * data = I2C_ReceiveData();
  * @endcode
  */
u8 I2C_ReceiveData(void)
{
  return ((u8)I2C->DR); /* Return the data present in the DR register */
}

/**
  * @brief Transmits the 7-bit address (to select the) slave device.
  * @param[in] Address Specifies the slave address which will be transmitted.
  * @param[in] Direction Specifies whether the I2C device will be a Transmitter or a Receiver.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * I2C_Send7bitAddress((u8)0xA8, I2C_DIRECTION_TX);
  * @endcode
  */
void I2C_Send7bitAddress(u8 Address, I2C_Direction_Typedef Direction)
{
  /* Check function parameters */
  assert_param(IS_I2C_ADDRESS_OK(Address));
  assert_param(IS_I2C_DIRECTION_OK(Direction));

  /* Clear bit0 (direction) just in case */
  Address &= (u8)0xFE;
  
  /* Send the Address + Direction */
  I2C->DR = (u8)(Address | (u8)Direction);
}

/**
  * @brief Send a byte by writing in the DR register.
  * @param[in] Data Byte to be sent.
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * I2C_SendData((u8)0x5A);
  * @endcode
  */
void I2C_SendData(u8 Data)
{
  I2C->DR = Data; /* Write in the DR register the data to be sent */
}

/**
  * @brief Enables or disables I2C software reset.
  * @param[in] NewState Specifies the new state of the I2C software reset
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * I2C_SoftwareResetCmd(ENABLE);
  * @endcode
  */
void I2C_SoftwareResetCmd(FunctionalState NewState)
{
  /* Check function parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));

  if (NewState == ENABLE)
  {
    I2C->CR2 |= I2C_CR2_SWRST; /* Peripheral under reset */
  }
  else
  {
    I2C->CR2 &= (u8)(~I2C_CR2_SWRST); /* Peripheral not under reset */
  }
}

/**
  * @brief Enables or disables the I2C clock stretching.
  * @param[in] NewState Specifies the new state of the I2C Clock stretching
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * I2C_StretchClockCmd(ENABLE);
  * @endcode
  */
void I2C_StretchClockCmd(FunctionalState NewState)
{
  /* Check function parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));

  if (NewState == DISABLE)
  {
    I2C->CR1 |= I2C_CR1_NOSTRETCH; /* Clock Stretching Disable (Slave mode) */
  }
  else
  {
    I2C->CR1 &= (u8)(~I2C_CR1_NOSTRETCH); /* Clock Stretching Enable */
  }
}

/**
  * @brief Clear pending flags
  * @param[in] Flag Specifies the flag to clear
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * I2C_ClearFlag(I2C_FLAG_STOPDETECTION);
  * @endcode
  */
void I2C_ClearFlag(I2C_Flag_TypeDef Flag)
{
  u8 tmp1 = 0;
  u8 tmp2 = 0;

  /* Check the parameters */
  assert_param(IS_I2C_FLAG_OK(Flag));

  /* Check the clear flag methodology index */
  switch ((u16)Flag & (u16)0x0F00)
  {

    /* Clear the flag directly in the SR2 register */
    case 0x0100:
      /* Clear the selected I2C flag */
      I2C->SR2 &= (u8)(~(u8)Flag);
      break;

    /* Flags that need a read of SR1 register and a dummy write in CR2 register to be cleared */
    case 0x0200:
      /* Read the SR1 register */
      tmp1 = (u8)I2C->SR1;
      /* Dummy write in the CR2 register */
      /*I2C->CR2 |= (u8)0x00; */ /*Due to compilo optimisation a 0x00 dummy write does not work */
			tmp2 = (u8)I2C->CR2;
			I2C->CR2 = tmp2;
      break;
      
    /* Flags that need a read of SR1 register followed by a read of SR3 register to be cleared */
    case 0x0300:
      /* 2 variables are used to avoid any compiler optimization */
      /* Read the SR1 register */
      tmp1 = I2C->SR1;
      /* Read the SR3 register */
      tmp2 = I2C->SR3;
      break;

    /* Flags that need a read of SR1 register followed by a read of DR register to be cleared */
    case 0x0400:
      /* 2 variables are used to avoid any compiler optimization */
      /* Read the SR1 register */
      tmp1 = I2C->SR1;
      /* Read the DR register */
      tmp2 = I2C->DR;
      break;
      
    default:
      break;
      
  }
}

/**
  * @brief Initializes the I2C according to the specified parameters in standard or fast mode.
  * @retval void None
  * @par Required preconditions:
  * You can call I2C_InitStruct before in order to initialize the structure members.
  * @par Called functions:
  * - I2C_Cmd()
  * - I2C_AcknowledgeConfig()
  * @par Example:
  * @code
  * I2C_Init_TypeDef I2C_InitStructure;
  * I2C_Init(&I2C_InitStructure);  
  * @endcode
  */
void I2C_Init(I2C_Init_TypeDef* I2C_InitStruct)
{
  u16 result = 0x0004;
  u16 tmpval;
  
  /* Check the parameters */
  assert_param(IS_I2C_DUTYCYCLE_OK(I2C_InitStruct->DutyCycle));
  assert_param(IS_I2C_ACK_OK(I2C_InitStruct->Ack));
  assert_param(IS_I2C_ADDMODE_OK(I2C_InitStruct->AddMode));
  assert_param(IS_I2C_OWN_ADDRESS_OK(I2C_InitStruct->OwnAddress));
  assert_param(IS_I2C_INPUT_CLOCK_FREQ_OK(I2C_InitStruct->InputClockFrequencyMHz));
  assert_param(IS_I2C_OUTPUT_CLOCK_FREQ_OK(I2C_InitStruct->OutputClockFrequencyHz));

  /*------------------------- I2C FREQR Configuration ------------------------*/
  /* Clear frequency bits */
  I2C->FREQR &= (u8)(~I2C_FREQR_FREQ);
  /* Write new value */
  I2C->FREQR |= I2C_InitStruct->InputClockFrequencyMHz;

  /*--------------------------- I2C CCR Configuration ------------------------*/
  /* Disable I2C to configure TRISER */
  I2C_Cmd(DISABLE);

  /* Clear CCRH & CCRL */
  I2C->CCRH &= (u8)(~(I2C_CCRH_FS | I2C_CCRH_DUTY | I2C_CCRH_CCR));
  I2C->CCRL &= (u8)(~I2C_CCRL_CCR);

  /* Detect Fast or Standard mode depending on the Output clock frequency selected */
  if (I2C_InitStruct->OutputClockFrequencyHz > I2C_MAX_STANDARD_FREQ) /* FAST MODE */
  {
   
    /* Set F/S bit for fast mode */
    I2C->CCRH |= I2C_CCRH_FS;
   
    if (I2C_InitStruct->DutyCycle == I2C_DUTYCYCLE_2)
    {
      /* Fast mode speed calculate: Tlow/Thigh = 2 */
      result = (u16) ((I2C_InitStruct->InputClockFrequencyMHz * 1000000) / (I2C_InitStruct->OutputClockFrequencyHz * 3));
    }
    else /* I2C_DUTYCYCLE_16_9 */
    {
      /* Fast mode speed calculate: Tlow/Thigh = 16/9 */
      result = (u16) ((I2C_InitStruct->InputClockFrequencyMHz * 1000000) / (I2C_InitStruct->OutputClockFrequencyHz * 25));
      /* Set DUTY bit */
      I2C->CCRH |= I2C_CCRH_DUTY;
    }
    
    /* Verify and correct CCR value if below minimum value */
    if (result < (u16)0x01)
    {
      /* Set the minimum allowed value */
      result = (u16)0x0001;
    }
    
    /* Set Maximum Rise Time: 300ns max in Fast Mode
    = [300ns/(1/InputClockFrequencyMHz.10e6)]+1
    = [(InputClockFrequencyMHz * 3)/10]+1 */
    tmpval = ((I2C_InitStruct->InputClockFrequencyMHz * 3) / 10) + 1;
    I2C->TRISER = (u8)tmpval;
    
  }
  else /* STANDARD MODE */
  {
   
    /* Calculate standard mode speed */
    result = (u16)((I2C_InitStruct->InputClockFrequencyMHz * 1000000) / (I2C_InitStruct->OutputClockFrequencyHz << (u8)1));
   
    /* Verify and correct CCR value if below minimum value */
    if (result < (u16)0x0004)
    {
      /* Set the minimum allowed value */
      result = (u16)0x0004;
    }
   
    /* Set Maximum Rise Time: 1000ns max in Standard Mode
    = [1000ns/(1/InputClockFrequencyMHz.10e6)]+1
    = InputClockFrequencyMHz+1 */
    I2C->TRISER = (u8)(I2C_InitStruct->InputClockFrequencyMHz + 1);
   
  }
  
  /* Write CCR with new calculated value */
  I2C->CCRL = (u8)result;
  I2C->CCRH |= (u8)((u8)(result >> 8) & I2C_CCRH_CCR);

  /* Enable I2C */
  I2C_Cmd(ENABLE);

  /* Configure I2C acknowledgement */
  I2C_AcknowledgeConfig(I2C_InitStruct->Ack);

  /*--------------------------- I2C OAR Configuration ------------------------*/
  I2C->OARL = (u8)(I2C_InitStruct->OwnAddress);
  I2C->OARH = (u8)((u8)I2C_InitStruct->AddMode |
               I2C_OARH_ADDCONF |
              (u8)((I2C_InitStruct->OwnAddress & (u16)0x0300) >> (u8)7));

}

/**
  * @brief Checks whether the last I2C event is equal to the one passed as parameter.
  * This function must be called only once as the flags can be reset by reading the registers.
  * @param[in] I2C_Event Specifies the event to be checked.
  * @retval ErrorStatus Status of the event
  * SUCCESS : last event is equal to the I2C_Event
  * ERROR : last event is different from the I2C_Event
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * ErrorStatus Status;
  * Status = I2C_CheckEvent(I2C_EVENT_SLAVE_BYTE_TRANSMITTED);
  * @endcode
  */
ErrorStatus I2C_CheckEvent(I2C_Event_Typedef I2C_Event)
{

  u8 Flag1 = 0;
  u8 Flag2 = 0;
  ErrorStatus status = ERROR;

  /* Check the parameters */
  assert_param(IS_I2C_EVENT_OK(I2C_Event));

  Flag1 = I2C->SR1;
  Flag2 = I2C->SR2;

  /* Check which SRx register must be read */
  switch ((u16)I2C_Event & (u16)0x0F00)
  {
  
    /* Returns whether the status register to check is SR1 */
    case 0x0700:
      Flag1 &= (u8)I2C_Event;
      /* Check whether the last event is equal to I2C_EVENT */
      if (Flag1 == (u8)I2C_Event)
      {
        /* SUCCESS: last event is equal to I2C_EVENT */
        status = SUCCESS;
      }
      else
      {
        /* ERROR: last event is different from I2C_EVENT */
        status = ERROR;
      }
      break;

    /* Returns whether the status register to check is SR2 */
    case 0x0800:
      Flag2 &= (u8)I2C_Event;
      /* Check whether the last event is equal to I2C_EVENT */
      if (Flag2 == (u8)I2C_Event)
      {
        /* SUCCESS: last event is equal to I2C_EVENT */
        status = SUCCESS;
      }
      else
      {
        /* ERROR: last event is different from I2C_EVENT */
        status = ERROR;
      }
      break;

    default:
      break;
  }

  /* Return status */
  return status;

}

/**
  * @}
  */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
