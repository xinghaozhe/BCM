/**
  ******************************************************************************
  * @file stm8_flash.h
  * @brief This file contains all functions prototype and macros for the FLASH peripheral.
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
#ifndef __STM8_FLASH_H__
#define __STM8_FLASH_H__

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"

/* Exported constants --------------------------------------------------------*/

/** @addtogroup FLASH_Exported_Constants
  * @{
  */

#define FLASH_PROG_START_PHYSICAL_ADDRESS ((u32)0x008000) /*!< Program memory: start address */
#define FLASH_PROG_END_PHYSICAL_ADDRESS   ((u32)0x027FFF) /*!< Program memory: end address */
#define FLASH_PROG_BLOCKS_NUMBER          ((u16)1024)     /*!< Program memory: total number of blocks */

#define FLASH_DATA_START_PHYSICAL_ADDRESS ((u32)0x004000) /*!< Data EEPROM memory: start address */
#define FLASH_DATA_END_PHYSICAL_ADDRESS   ((u32)0x0047FF) /*!< Data EEPROM memory: end address */
#define FLASH_DATA_BLOCKS_NUMBER          ((u16)16)       /*!< Data EEPROM memory: total number of blocks */

#define FLASH_BLOCK_SIZE                  ((u8)128)       /*!< Number of bytes in a block (common for Program and Data memories) */

#define FLASH_RASS_KEY1 ((u8)0x56) /*!< First RASS key */
#define FLASH_RASS_KEY2 ((u8)0xAE) /*!< Second RASS key */

#define OPTION_BYTE_START_PHYSICAL_ADDRESS  ((u32)0x004801)
#define OPTION_BYTE_END_PHYSICAL_ADDRESS ((u32)0x004811)
#define FLASH_OPTIONBYTE_ERROR ((u16)0x5555) /*!< Error code option byte (if value read is not equal to complement value read) */
/**
  * @}
  */

/* Exported types ------------------------------------------------------------*/

/** @addtogroup FLASH_Exported_Types
  * @{
  */

/**
  * @brief FLASH Memory types
  */
typedef enum {
  FLASH_MEMTYPE_PROG      = (u8)0x00, /*!< Program memory */
  FLASH_MEMTYPE_DATA      = (u8)0x01, /*!< Data EEPROM memory */
  FLASH_MEMTYPE_PROG_DATA = (u8)0x02  /*!< Program and Data EEPROM memories */
} FLASH_MemType_TypeDef;

/**
  * @brief FLASH programming modes
  */
typedef enum {
  FLASH_PROGRAMMODE_STANDARD = (u8)0x00, /*!< Standard programming mode */
  FLASH_PROGRAMMODE_FAST     = (u8)0x10  /*!< Fast programming mode */
} FLASH_ProgramMode_Typedef;

/**
  * @brief FLASH fixed programming time
  */
typedef enum {
  FLASH_PROGRAMTIME_STANDARD = (u8)0x00, /*!< Standard programming time fixed at 1/2 tprog */
  FLASH_PROGRAMTIME_TPROG    = (u8)0x01  /*!< Programming time fixed at tprog */
} FLASH_ProgramTime_Typedef;

/**
  * @brief FLASH Low Power mode select
  */
typedef enum {
  FLASH_LPMODE_POWERDOWN         = (u8)0x04, /*!< HALT: Power-Down / ACTIVE-HALT: Power-Down */
  FLASH_LPMODE_STANDBY           = (u8)0x08, /*!< HALT: Standby    / ACTIVE-HALT: Standby */
  FLASH_LPMODE_POWERDOWN_STANDBY = (u8)0x00, /*!< HALT: Power-Down / ACTIVE-HALT: Standby */
  FLASH_LPMODE_STANDBY_POWERDOWN = (u8)0x0C  /*!< HALT: Standby    / ACTIVE-HALT: Power-Down */
}
FLASH_LPMode_Typedef;

/**
  * @brief FLASH Option bytes
  */
typedef enum {
  FLASH_OPTIONBYTE_0 = (u8)0x00,
  FLASH_OPTIONBYTE_1 = (u8)0x01,
  FLASH_OPTIONBYTE_2 = (u8)0x02,
  FLASH_OPTIONBYTE_3 = (u8)0x03
} FLASH_OptionByte_TypeDef;

/**
  * @brief FLASH status of the last operation
  */
typedef enum {
  FLASH_STATUS_WRITE_PROTECTION_ERROR = (u8)0x01, /*!< Write attempted to protected page */
  FLASH_STATUS_PRG_UNLOCKED           = (u8)0x02, /*!< Write attempted to protected page */
  FLASH_STATUS_SUCCESSFUL_OPERATION   = (u8)0x04  /*!< End of operation flag */
} FLASH_Status_Typedef;

/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/

/**
  * @brief Macros used by the assert function in order to check the different functions parameters.
  * @addtogroup FLASH_Private_Macros
  * @{
  */

#define IS_FLASH_PROG_ADDRESS_OK(ADDRESS) \
  (((ADDRESS) >= FLASH_PROG_START_PHYSICAL_ADDRESS) && \
   ((ADDRESS) <= FLASH_PROG_END_PHYSICAL_ADDRESS))

#define IS_FLASH_DATA_ADDRESS_OK(ADDRESS) \
  (((ADDRESS) >= FLASH_DATA_START_PHYSICAL_ADDRESS) && \
   ((ADDRESS) <= FLASH_DATA_END_PHYSICAL_ADDRESS))

#define IS_FLASH_ADDRESS_OK(ADDRESS) \
  ((((ADDRESS) >= FLASH_PROG_START_PHYSICAL_ADDRESS) && ((ADDRESS) <= FLASH_PROG_END_PHYSICAL_ADDRESS)) || \
   (((ADDRESS) >= FLASH_DATA_START_PHYSICAL_ADDRESS) && ((ADDRESS) <= FLASH_DATA_END_PHYSICAL_ADDRESS)))

#define IS_FLASH_PROG_BLOCK_NUMBER_OK(BLOCKNUM) ((BLOCKNUM) < FLASH_PROG_BLOCKS_NUMBER)


#define IS_FLASH_DATA_BLOCK_NUMBER_OK(BLOCKNUM) ((BLOCKNUM) < FLASH_DATA_BLOCKS_NUMBER)
  
#define IS_MEMORY_TYPE_OK(MEMTYPE) \
  (((MEMTYPE) == FLASH_MEMTYPE_PROG) || \
   ((MEMTYPE) == FLASH_MEMTYPE_DATA) || \
   ((MEMTYPE) == FLASH_MEMTYPE_PROG_DATA))

#define IS_FLASH_PROGRAM_MODE_OK(MODE) \
  (((MODE) == FLASH_PROGRAMMODE_STANDARD) || \
   ((MODE) == FLASH_PROGRAMMODE_FAST))

#define IS_FLASH_PROGRAM_TIME_OK(TIME) \
  (((TIME) == FLASH_PROGRAMTIME_STANDARD) || \
   ((TIME) == FLASH_PROGRAMTIME_TPROG))

#define IS_FLASH_LOW_POWER_MODE_OK(LPMODE) \
  (((LPMODE) == FLASH_LPMODE_POWERDOWN) || \
   ((LPMODE) == FLASH_LPMODE_STANDBY) || \
   ((LPMODE) == FLASH_LPMODE_POWERDOWN_STANDBY) || \
   ((LPMODE) == FLASH_LPMODE_STANDBY_POWERDOWN))

#define IS_OPTION_BYTE_OK(OPT) \
  (((OPT) == FLASH_OPTIONBYTE_0) || \
   ((OPT) == FLASH_OPTIONBYTE_1) || \
   ((OPT) == FLASH_OPTIONBYTE_2) || \
   ((OPT) == FLASH_OPTIONBYTE_3))

#define IS_OPTION_BYTE_ADDRESS_OK(ADDRESS) \
  (((ADDRESS) >= OPTION_BYTE_START_PHYSICAL_ADDRESS) && \
   ((ADDRESS) <= OPTION_BYTE_END_PHYSICAL_ADDRESS))

/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup FLASH_Exported_Functions
  * @{
  */

void FLASH_ClearFlags(void);
void FLASH_DeInit(void);
FLASH_Status_Typedef FLASH_EraseBlock(FLASH_MemType_TypeDef MemType, u16 BlockNum);
FLASH_Status_Typedef FLASH_EraseByte(u32 Address);
FLASH_Status_Typedef FLASH_EraseOptionByte(u32 Address);
u32 FLASH_GetBootMemSize(void);
ITStatus FLASH_GetITStatus(void);
FLASH_LPMode_Typedef FLASH_GetLowPowerMode(void);
FLASH_ProgramTime_Typedef FLASH_GetProgrammingTime(void);
void FLASH_ITConfig(FunctionalState NewState);
FLASH_Status_Typedef FLASH_ProgramBlock(FLASH_MemType_TypeDef MemType, u16 BlockNum, FLASH_ProgramMode_Typedef ProgMode, u8 *Buffer);
FLASH_Status_Typedef FLASH_ProgramByte(u32 Address, u8 Data);
FLASH_Status_Typedef FLASH_ProgramOptionByte(u32 Address, u8 Data); 
FLASH_Status_Typedef FLASH_ProgramWord(u8 *Address, u8 *data);
u8 FLASH_ReadByte(u32 Address);
u16 FLASH_ReadOptionByte(u32 Address);
void FLASH_SetLowPowerMode(FLASH_LPMode_Typedef LPMode);
void FLASH_SetProgrammingTime(FLASH_ProgramTime_Typedef ProgTime);
FLASH_Status_Typedef FLASH_WaitForLastOperation(void);
void FLASH_Unlock(FLASH_MemType_TypeDef MemType);
void FLASH_Lock(FLASH_MemType_TypeDef MemType);

/**
  * @}
  */

#endif /*__STM8_FLASH_H__*/

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
