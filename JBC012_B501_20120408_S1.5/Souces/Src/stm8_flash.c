/**
  ******************************************************************************
  * @file stm8_flash.c
  * @brief This file contains all the functions for the FLASH peripheral.
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
#include "stm8_flash.h"

/* LINKER SECTIONS DEFINITION FOR THIS FILE ONLY */
#ifdef USE_COSMIC_SECTIONS
#pragma section (FLASH_CODE)
#pragma section const {FLASH_CONST}
#pragma section @near [FLASH_URAM]
#pragma section @near {FLASH_IRAM}
#pragma section @tiny [FLASH_UZRAM]
#pragma section @tiny {FLASH_IZRAM}
#endif

/* Public functions ----------------------------------------------------------*/

/** @addtogroup FLASH_Public_functions
  * @{
  */

/**
  * @brief Clears status register flags
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * FLASH_ClearFlags();
  * @endcode
*/
void FLASH_ClearFlags(void)
{
  u8 temp;
  temp = FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
}

/**
  * @brief Deinitializes the FLASH peripheral registers to their default reset values.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * FLASH_DeInit();
  * @endcode
*/
void FLASH_DeInit(void)
{
  u8 temp;
  FLASH->CR1 = FLASH_CR1_RESET_VALUE;
  FLASH->CR2 = FLASH_CR2_RESET_VALUE;
  FLASH->NCR2 = FLASH_NCR2_RESET_VALUE;
  FLASH->IAPSR &= (u8)(~FLASH_IAPSR_DUL);
  FLASH->IAPSR &= (u8)(~FLASH_IAPSR_PUL);         ///????????
  temp = FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
}

/**
  * @brief Erases a block in the program or data memory.
  * @param[in] MemType Memory type
  * @param[in] BlockNum Indicates the block number to erase
  * @retval FLASH_Status_Typedef Indicates the state of the last operation.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * FLASH_WaitForLastOperation()
  * @par Example:
  * Erase the block number 512 in Program memory
  * @code
  * FLASH_Status_Typedef status;
  * status = FLASH_EraseBlock(FLASH_MEMTYPE_PROG, 512);
  * @endcode
 */
FLASH_Status_Typedef FLASH_EraseBlock(FLASH_MemType_TypeDef MemType, u16 BlockNum)
{
  @far u8 *pFlash;
  u32 StartAddress;

  /* Check parameters */
  assert_param(IS_MEMORY_TYPE_OK(MemType));
  if (MemType == FLASH_MEMTYPE_PROG)
  {
    assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
    StartAddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
  }
  else
  {
    assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
    StartAddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
  }

  /* Point to the first block address */
  StartAddress = StartAddress + ((u32)BlockNum * (u32)FLASH_BLOCK_SIZE);
  pFlash = (@far u8 *) StartAddress;

  /* Enable erase block mode */
  FLASH->CR2 |= FLASH_CR2_ERASE;
  FLASH->NCR2 &= (u8)(~FLASH_NCR2_NERASE);

  *(pFlash + 0) = (u8)0x00;
  *(pFlash + 1) = (u8)0x00;
  *(pFlash + 2) = (u8)0x00;
  *(pFlash + 3) = (u8)0x00;

  /* Wait that ERASE flag goes low */
  while ((FLASH->CR2 & FLASH_CR2_ERASE) != (u8)0x00)
  {}

  return(FLASH_WaitForLastOperation());

}

/**
  * @brief Erases one byte in the program or data EEPROM memory
  * @param[in] Address Address of the byte to erase
  * @retval FLASH_Status_Typedef State of the last operation
  * @par Required preconditions:
  * None
  * @par Called functions:
  * FLASH_WaitForLastOperation()
  * @par Example:
  * @code
  * FLASH_Status_Typedef status;
  * status = FLASH_EraseByte(0xEFFF);
  * if (status == FLASH_SUCCESSFUL_OPERATION) { ... }
  * @endcode
*/
FLASH_Status_Typedef FLASH_EraseByte(u32 Address)
{
  @far u8 *pFlash;
  /* Check parameter */
  assert_param(IS_FLASH_ADDRESS_OK(Address));

  pFlash = (@far u8 *) Address;
  *(pFlash) = (u8)0x00; /* Erase byte */

  return(FLASH_WaitForLastOperation());

}

/**
  * @brief Erases an option byte
  * @param[in] Address Option byte address to erase
  * @retval FLASH_Status_Typedef State of the last operation
  * @par Required preconditions:
  * None
  * @par Called functions:
  * FLASH_WaitForLastOperation()
  * @par Example:
  * @code
  * FLASH_Status_Typedef status;
  * status = FLASH_EraseOptionByte(0x4801);
  * if (status == FLASH_SUCCESSFUL_OPERATION) { ... }
  * @endcode
*/
FLASH_Status_Typedef FLASH_EraseOptionByte(u32 Address)
{
  u8 *pFlash;
  FLASH_Status_Typedef status;

  /* Check parameter */
  assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));

  /* Enable write access to option bytes */
  FLASH->CR2 |= FLASH_CR2_OPT;
  FLASH->NCR2 &= (u8)(~FLASH_NCR2_NOPT);

  /* Erase option byte and his complement */
  pFlash = (u8 *)Address;
  *pFlash = (u8)0x00;
  pFlash = (u8 *)(Address + 1 );
  *pFlash = (u8)0xFF;

  status = FLASH_WaitForLastOperation();

  /* Disable write access to option bytes */
  FLASH->CR2 &= (u8)(~FLASH_CR2_OPT);
  FLASH->NCR2 |= FLASH_NCR2_NOPT;

  return(status);

}

/**
  * @brief Returns the Boot memory size in bytes
  * @par Parameters:
  * None
  * @retval u32 Boot memory size in bytes
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * u32 bootmemsize;
  * bootmemsize = FLASH_GetBootMemSize();
  * @endcode
*/
u32 FLASH_GetBootMemSize(void)
{

  u32 temp;

  /* Calculates the number of bytes */
  temp = (u32)((u32)FLASH->FPR * (u32)512);

  /* Correction because size of 127.5 kb doesn't exist */
  if (FLASH->FPR == 0xFF)
  {
	  temp += 512;
	}

  /* Return value */
  return(temp);

}

/**
  * @brief Returns the state of the Flash interrupt mode
  * @par Parameters:
  * None
  * @retval ITStatus Interrupt mode state
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * ITStatus Status;
  * Status = FLASH_GetITStatus();
  * @endcode
*/
ITStatus FLASH_GetITStatus(void)
{
  return((ITStatus)(((u8)(FLASH->CR1 & FLASH_CR1_IE) == (u8)0x00) ? RESET : SET));
}

/**
  * @brief Returns the Flash behaviour type in low power mode
  * @par Parameters:
  * None
  * @retval FLASH_LPMode_Typedef Flash behaviour type in low power mode
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * FLASH_LowPowerModeSelect_Typedef status;
  * status = FLASH_GetLowPowerMode();
  * @endcode
*/
FLASH_LPMode_Typedef FLASH_GetLowPowerMode(void)
{
  return((FLASH_LPMode_Typedef)(FLASH->CR1 & (FLASH_CR1_HALT | FLASH_CR1_AHALT)));
}

/**
  * @brief Returns the fixed programming time
  * @par Parameters:
  * None
  * @retval FLASH_ProgramTime_Typedef Fixed programming time value
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * FLASH_ProgramTime_Typedef status;
  * status = FLASH_GetProgrammingTime();
  * @endcode
*/
FLASH_ProgramTime_Typedef FLASH_GetProgrammingTime(void)
{
  return((FLASH_ProgramTime_Typedef)(FLASH->CR1 & FLASH_CR1_FIX));
}

/**
  * @brief Enables or Disables the Flash interrupt mode
  * @param[in] NewState The new state of the flash interrupt mode
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * FLASH_ITConfig(ENABLE);
  * @endcode
*/
void FLASH_ITConfig(FunctionalState NewState)
{
  if (NewState == ENABLE)
  {
    FLASH->CR1 |= FLASH_CR1_IE; /* Enables the interrupt sources */
  }
  else
  {
    FLASH->CR1 &= (u8)(~FLASH_CR1_IE); /* Disables the interrupt sources */
  }
}

/**
  * @brief Locks the program or data EEPROM memory
  * @param[in] MemType Memory type
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * FLASH_Lock(FLASH_MEMTYPE_PROG_DATA);
  * @endcode
*/
void FLASH_Lock(FLASH_MemType_TypeDef MemType)
{

  /* Check parameter */
  assert_param(IS_MEMORY_TYPE_OK(MemType));

  /* Lock program memory */
  if ((MemType == FLASH_MEMTYPE_PROG) || (MemType == FLASH_MEMTYPE_PROG_DATA))
  {
    FLASH->IAPSR &= (u8)(~FLASH_IAPSR_PUL);
  }

  /* Lock data memory */
  if ((MemType == FLASH_MEMTYPE_DATA) || (MemType == FLASH_MEMTYPE_PROG_DATA))
  {
    FLASH->IAPSR &= (u8)(~FLASH_IAPSR_DUL);
  }

}

/**
  *@brief Programs a memory block
  * @param[in] MemType The type of memory to program
  * @param[in] BlockNum The block number
  * @param[in] ProgMode The programming mode.
  * @param[in] Buffer The buffer address of source data.
  * @retval FLASH_Status_Typedef Indicates the state of the last operation.
  * @par Required preconditions:
  * None
  * @par Called functions:
  * FLASH_WaitForLastOperation()
  * @par Example:
  * Writes the block 1000 of program memory
  * @code
  * u8 Buffer[FLASH_BLOCK_SIZE] =
  * {
  *   0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
  *   ...
  *   0x78, 0x79, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F
  * };
  * FLASH_Status_Typedef status;
  * status = FLASH_ProgramBlock(FLASH_MEMTYPE_PROG, 1000, FLASH_PROGRAMMODE_STANDARD, Buffer);
  * @endcode
  */
FLASH_Status_Typedef FLASH_ProgramBlock(FLASH_MemType_TypeDef MemType, u16 BlockNum, FLASH_ProgramMode_Typedef ProgMode, u8 *Buffer)
{
  @far u8 *pFlash;
  u16 Count = 0;
  u32 StartAddress;

  /* Check parameters */
  assert_param(IS_MEMORY_TYPE_OK(MemType));
  assert_param(IS_FLASH_PROGRAM_MODE_OK(ProgMode));
  if (MemType == FLASH_MEMTYPE_PROG)
  {
    assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
    StartAddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
  }
  else
  {
    assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
    StartAddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
  }

  /* Point to the first block address */
  StartAddress = StartAddress + (BlockNum * FLASH_BLOCK_SIZE);
  pFlash = (@far u8 *) StartAddress;
  
  /* Selection of Standard or Fast programming mode */
  if (ProgMode == FLASH_PROGRAMMODE_STANDARD)
  {
    /* Standard programming mode */ /*No need in standard mode*/
	FLASH->CR2 |= FLASH_CR2_PRG;
	FLASH->NCR2 &= (u8)(~FLASH_NCR2_NPRG);
  }
  else
  {
    /* Fast programming mode */
    FLASH->CR2 |= FLASH_CR2_FPRG;
    FLASH->NCR2 &= (u8)(~FLASH_NCR2_NFPRG);
  }

  /* Copy data bytes from RAM to FLASH memory */
  for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
  {
    *(pFlash + Count) = ((u8)(Buffer[Count]));
  }

  return(FLASH_WaitForLastOperation());
}


/**
  * @brief Programs one byte in program or data EEPROM memory
  * @param[in] Address Adress where the byte is written
  * @param[in] Data Value to be written
  * @retval FLASH_Status_Typedef State of the last operation
  * @par Required preconditions:
  * None
  * @par Called functions:
  * FLASH_WaitForLastOperation()
  * @par Example:
  * @code
  * FLASH_Status_Typedef status;
  * u32 add = 0x4500;
  * u8 val = 0x55;
  * status = FLASH_ProgramByte(add, val);
  * if (status == FLASH_SUCCESSFUL_OPERATION) { ... }
  * @endcode
*/
FLASH_Status_Typedef FLASH_ProgramByte(u32 Address, u8 Data)
{
  @far u8 *pFlash;
	
  /* Check parameters */
  assert_param(IS_FLASH_ADDRESS_OK(Address));

  pFlash = (@far u8 *) Address;
  *pFlash = Data;
  return(FLASH_WaitForLastOperation());

}

/**
  * @brief Programs an option byte
  * @param[in] Address  option byte address  to program
  * @param[in] Data Value to write
  * @retval FLASH_Status_Typedef State of the last operation
  * @par Required preconditions:
  * None
  * @par Called functions:
  * FLASH_WaitForLastOperation()
  * @par Example:
  * @code
  * FLASH_Status_Typedef status;
  * status = FLASH_ProgramOptionByte(0x4801, 0x55);
  * if (status == FLASH_SUCCESSFUL_OPERATION) { ... }
  * @endcode
*/
FLASH_Status_Typedef FLASH_ProgramOptionByte(u32 Address, u8 Data)
{
  u8 *pFlash;
  FLASH_Status_Typedef status;

  /* Check parameter */
  assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));

  /* Enable write access to option bytes */
  FLASH->CR2 |= FLASH_CR2_OPT;
  FLASH->NCR2 &= (u8)(~FLASH_NCR2_NOPT);

  /* Program option byte and his complement */
  pFlash = (u8 *)Address;
  *pFlash = Data;
  pFlash = (u8 *)(Address + 1);
  *pFlash = (u8)(~Data);

  status = FLASH_WaitForLastOperation();

  /* Disable write access to option bytes */
  FLASH->CR2 &= (u8)(~FLASH_CR2_OPT);
  FLASH->NCR2 |= FLASH_NCR2_NOPT;

  return(status);

}


/**
  * @brief Programs one word (4 bytes) in program or data EEPROM memory
  * @param[in] Address Adress where the byte is written
  * @param[in] Data Value to be written
  * @retval FLASH_Status_Typedef State of the last operation
  * @par Required preconditions:
  * None
  * @par Called functions:
  * FLASH_WaitForLastOperation()
  * @par Example:
  * @code
  * FLASH_Status_Typedef status;
  * u32 address = 0x011FFF;
  * u32 data = 0x01234567;
  * status = FLASH_ProgramWord(address, data);
  * if (status == FLASH_SUCCESSFUL_OPERATION) { ... }
  * @endcode
*/
FLASH_Status_Typedef FLASH_ProgramWord(u8 *Address, u8 *data)
{

  //@far u8 *pFlash;

  /* Check parameters */
//  assert_param(IS_FLASH_ADDRESS_OK(Address));

  /* Enable Word Write Once */
  FLASH->CR2 |= FLASH_CR2_WPRG;
  FLASH->NCR2 &= (u8)(~FLASH_NCR2_NWPRG);

  //pFlash = (@far u8 *)Address;

  Address[0] = data[0]; /* Write one byte */
  Address[1]  = data[1]; /* Write one byte */
  Address[2]  = data[2]; /* Write one byte */
  Address[3]  = data[3]; /* Write one byte */

  return(FLASH_WaitForLastOperation());

}

/**
  * @brief Reads any byte from flash memory
  * @param[in] Address Address to read
  * @retval u8 Value read
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * u8 val;
  * val = FLASH_ReadByte(0x011FFF);
  * @endcode
*/
u8 FLASH_ReadByte(u32 Address)
{
  @far u8 *pFlash;

  /* Check parameter */
  assert_param(IS_FLASH_ADDRESS_OK(Address));

  pFlash = (@far u8 *) Address;
  return(*pFlash); /* Read byte */

}

/**
  * @brief Reads one option byte
  * @param[in] Address  option byte address to read.
  * @retval u16 res_value (Value read + complement value read.)
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * u16 val;
  * val = FLASH_ReadOptionByte(0x4801);
  * @endcode
*/
u16 FLASH_ReadOptionByte(u32 Address)
{

  @far u8 *pFlash;
  u8 value_optbyte, value_optbyte_complement;
  u16 res_value;

  /* Check parameter */
  assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));

  pFlash = (@far u8 *)Address;

  value_optbyte = *pFlash; /* Read option byte */
  value_optbyte_complement = *(pFlash + 1); /* Read option byte complement*/

  if (value_optbyte == (u8)(~value_optbyte_complement))
  {
    res_value = (u16)((u16)value_optbyte << 8);
    res_value = res_value | (u16)value_optbyte_complement;
  }
  else
  {
    res_value = FLASH_OPTIONBYTE_ERROR;
  }

  return(res_value);

}

/**
  * @brief Select the Flash behaviour in low power mode
  * @param[in] LPMode Low power mode selection
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * FLASH_SetLowPowerMode(FLASH_LPMODE_POWERDOWN_STANDBY);
  * @endcode
*/
void FLASH_SetLowPowerMode(FLASH_LPMode_Typedef LPMode)
{

  /* Check parameter */
  assert_param(IS_FLASH_LOW_POWER_MODE_OK(LPMode));

  FLASH->CR1 &= (u8)(~(FLASH_CR1_HALT | FLASH_CR1_AHALT)); /* Clears the two bits */
  FLASH->CR1 |= (u8)LPMode; /* Sets the new mode */

}

/**
  * @brief Sets the fixed programming time
  * @param[in] ProgTime Indicates the programming time to be fixed
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
  * @endcode
*/
void FLASH_SetProgrammingTime(FLASH_ProgramTime_Typedef ProgTime)
{

  /* Check parameter */
  assert_param(IS_FLASH_PROGRAM_TIME_OK(ProgTime));

  FLASH->CR1 &= (u8)(~FLASH_CR1_FIX);
  FLASH->CR1 |= (u8)ProgTime;

}

/**
  * @brief Wait for a Flash operation to complete.
  * @par Parameters:
  * None
  * @retval FLASH_Status_Typedef State of the last operation
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * FLASH_Status_Typedef val;
  * val = FLASH_WaitForLastOperation();
  * @endcode
*/
FLASH_Status_Typedef FLASH_WaitForLastOperation(void)
{
  u8 timeout = 0x19;
  u8 My_FlagStatus = 0x01;

  /* Wait until operation completion or write protected page occured */
  while ((My_FlagStatus != 0x00) && (timeout != 0x00)) /* TBD Doesn't work on TC */
  {
    /*FlagStatus = (u8)(FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS));*/
    My_FlagStatus = (u8)(FLASH->IAPSR & FLASH_IAPSR_EOP);
    timeout--;
  }

  return((FLASH_Status_Typedef)My_FlagStatus);

}

/**
  * @brief Unlocks the program or data EEPROM memory
  * @param[in] MemType Memory type to unlock
  * @retval void None
  * @par Required preconditions:
  * None
  * @par Called functions:
  * None
  * @par Example:
  * @code
  * FLASH_UnLock(FLASH_MEMTYPE_DATA);
  * @endcode
*/
void FLASH_Unlock(FLASH_MemType_TypeDef MemType)
{

  /* Check parameter */
  assert_param(IS_MEMORY_TYPE_OK(MemType));

  /* Unlock program memory */
  if ((MemType == FLASH_MEMTYPE_PROG) || (MemType == FLASH_MEMTYPE_PROG_DATA))
  {
    FLASH->PUKR = FLASH_RASS_KEY1;
    FLASH->PUKR = FLASH_RASS_KEY2;
  }

  /* Unlock data memory */
  if ((MemType == FLASH_MEMTYPE_DATA) || (MemType == FLASH_MEMTYPE_PROG_DATA))
  {
    FLASH->DUKR = FLASH_RASS_KEY2; /* Warning: keys are reversed on data memory !!! */
    FLASH->DUKR = FLASH_RASS_KEY1;
  }

}

/**
  * @}
  */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
