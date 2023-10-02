/**
  ********************************************************************************
  * @file stm8_linuart.h
  * @brief This file contains all functions prototypes and macros for the LINUART peripheral.
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
#ifndef __STM8_LINUART_H
#define __STM8_LINUART_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"

/* Exported types ------------------------------------------------------------*/

/** @addtogroup LINUART_Exported_Types
  * @{
  */

/* LINUART_FLAG possible values
   Elements values convention: 0xXY
      X: FLAG position
      Y: Position of the corresponding Interrupt
*/
typedef enum { LINUART_FLAG_TXE          = (u8)0x77, /**< Transmit Data Register Empty flag  */
               LINUART_FLAG_TC           = (u8)0x66, /**< Transmission Complete flag         */
               LINUART_FLAG_RXNE         = (u8)0x55, /**< Read Data Register Not Empty flag  */
               LINUART_FLAG_IDLE         = (u8)0x44, /**< Idle line detected flag            */
               LINUART_FLAG_ORE_LHE      = (u8)0x53, /**< OverRun error flag                 */
               LINUART_FLAG_NE           = (u8)0x02, /**< Noise error flag                   */
               LINUART_FLAG_FE           = (u8)0x01, /**< Framing Error flag                 */
               LINUART_FLAG_PE           = (u8)0x00, /**< Parity Error flag                  */
               LINUART_FLAG_LBD          = (u8)0x64, /**< LIN Break Detection Flag           */
               LINUART_FLAG_LHDF         = (u8)0x21, /**< LIN Header Detection Flag*/
               LINUART_FLAG_LSF          = (u8)0x10, /**< LIN Sync Field Flag*/
               LINUART_FLAG_SBK          = (u8)0x20  /**< Send Break Complete interrupt flag */
             } LINUART_Flag_TypeDef;

/** LINUART Interruption sources  */
typedef enum { LINUART_IT_TIEN      = (u8)0x80,   /**< 0x80 Transmitter Interruption Enable*/
               LINUART_IT_TCIEN     = (u8)0x40,   /**< 0x40 Transmission Complete Interruption Enable*/
               LINUART_IT_RIEN      = (u8)0x20,   /**< 0x20 Receiver Interruption Enable*/
               LINUART_IT_ILIEN     = (u8)0x10,   /**< 0x10 IDLE Line Interruption Enable*/
               LINUART_IT_LBDIEN    = (u8)0x08,   /**< 0x04 LIN Break Detection Interruption Enable*/
               LINUART_IT_PIEN      = (u8)0x01,   /**< 0x01 Parity Interruption  Enable*/
               LINUART_IT_LHDIEN    = (u8)0x04    /**0x08 LIN Header Detection Interrupt*/
             } LINUART_IT_TypeDef;

/** LINUART WakeUP Modes  */
typedef enum { LINUART_WAKEUP_IDLELINE      = (u8)0x00,  /**< 0x01 Idle Line wake up*/
               LINUART_WAKEUP_ADDRESSMARK   = (u8)0x08   /**< 0x02 Address Mark wake up*/
             } LINUART_WakeUp_TypeDef;

typedef enum { LINUART_BREAK10BITS = (u8)0x01, /**< 0x01 10 bits Lin Break detection*/
               LINUART_BREAK11BITS = (u8)0x02  /**< 0x02 11 bits Lin Break detection*/
             } LINUART_LINBreakDetectionLength_TypeDef;

typedef enum { LINUART_STOPBITS_1  = (u8)0x00,  /**< One stop bit is  transmitted at the end of frame*/
               LINUART_STOPBITS_2  = (u8)0x20   /**< Two stop bits are  transmitted at the end of frame*/
             } LINUART_StopBits_TypeDef;

typedef enum { LINUART_PARITY_NO    = (u8)0x00,    /**< No Parity*/
               LINUART_PARITY_EVEN  = (u8)0x04,    /**< Even Parity*/
               LINUART_PARITY_ODD   = (u8)0x06     /**< Odd Parity*/
             } LINUART_Parity_TypeDef;

/** LINUART Word length possible values */
typedef enum { LINUART_WORDLENGTH_8D = (u8)0x00,    /**< 0x00 8 bits Data*/
               LINUART_WORDLENGTH_9D = (u8)0x10     /**< 0x10 9 bits Data*/
             } LINUART_WordLength_TypeDef;

/** LINUART Mode possible values */
typedef enum { LINUART_MODE_RX_ENABLE    = (u8)0x08,  /**< 0x08 Receive Enable*/
               LINUART_MODE_TX_ENABLE    = (u8)0x04,  /**< 0x04 Transmit Enable*/
               LINUART_MODE_TX_DISABLE   = (u8)0x80,  /**< 0x80 Receive Enable*/
               LINUART_MODE_RX_DISABLE   = (u8)0x40,  /**< 0x40 Single-wire Half-duplex mode*/
               LINUART_MODE_TXRX_ENABLE  = (u8)0x0C   /**< 0x0C Receive Enable and Transmit enable*/
             } LINUART_Mode_TypeDef;

typedef enum { LINUART_LIN_MASTER_MODE  = (u8)0x01, /**< 0x01 LIN Master Mode*/
               LINUART_LIN_SLAVE_MODE   = (u8)0x02  /**< 0x02 LIN Slave Mode*/
             } LINUART_Slave_TypeDef;

typedef enum { LINUART_LIN_AUTOSYNC_ENABLE    = (u8)0x01, /**< 0x01 LIN Autosynchronization Enable*/
               LINUART_LIN_AUTOSYNC_DISABLE   = (u8)0x02  /**< 0x02 LIN LIN Autosynchronization Enable*/
             } LINUART_Autosync_TypeDef;

typedef enum { LINUART_LIN_DIVUP_LBRR1    = (u8)0x01, /**< 0x01 LIN LDIV is updated as soon as LBRR1 is written*/
               LINUART_LIN_DIVUP_NEXTRXNE = (u8)0x02  /**< 0x02 LIN LDIV is updated at the next received character*/
             } LINUART_DivUp_TypeDef;

/** LINUART Init structure definition */
typedef struct
{
  LINUART_WordLength_TypeDef           WordLength;
  LINUART_StopBits_TypeDef             StopBits;
  LINUART_Parity_TypeDef               Parity;
  u32                                  BaudRate;
  LINUART_Mode_TypeDef                 Mode;
} LINUART_Init_TypeDef; 

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/
/* Exported macros ------------------------------------------------------------*/

/* Private macros ------------------------------------------------------------*/

/** @addtogroup LINUART_Private_Macros
  * @{
  */

/**
  * @brief Macro used by the assert_param function in order to check the different sensitivity values for the FLAGs
  */
#define IS_LINUART_FLAG_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == LINUART_FLAG_TXE) || \
   ((SensitivityValue) == LINUART_FLAG_TC) || \
   ((SensitivityValue) == LINUART_FLAG_RXNE) || \
   ((SensitivityValue) == LINUART_FLAG_IDLE ) || \
   ((SensitivityValue) == LINUART_FLAG_ORE_LHE) || \
   ((SensitivityValue) == LINUART_FLAG_NE) || \
   ((SensitivityValue) == LINUART_FLAG_FE) || \
   ((SensitivityValue) == LINUART_FLAG_PE) || \
   ((SensitivityValue) == LINUART_FLAG_LBD) || \
   ((SensitivityValue) == LINUART_FLAG_LHDF) || \
   ((SensitivityValue) == LINUART_FLAG_LSF) || \
   ((SensitivityValue) == LINUART_FLAG_SBK))

/**
  * @brief Macro used by the assert_param function in order to check the different sensitivity values for the pending bit
  */
#define IS_LINUART_ITPENDINGBIT_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == LINUART_FLAG_TXE) || \
   ((SensitivityValue) == LINUART_FLAG_TC) || \
   ((SensitivityValue) == LINUART_FLAG_RXNE) || \
   ((SensitivityValue) == LINUART_FLAG_IDLE ) || \
   ((SensitivityValue) == LINUART_FLAG_ORE_LHE) || \
   ((SensitivityValue) == LINUART_FLAG_PE) || \
   ((SensitivityValue) == LINUART_FLAG_LBD) || \
   ((SensitivityValue) == LINUART_FLAG_LHDF))

/**
 * @brief Macro used by the assert_param function in order to check the different sensitivity values for the MODEs
 */
#define IS_LINUART_MODE_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == (u8)LINUART_MODE_RX_ENABLE) || \
   ((SensitivityValue) == (u8)LINUART_MODE_RX_DISABLE) || \
   ((SensitivityValue) == (u8)LINUART_MODE_TX_ENABLE) || \
   ((SensitivityValue) == (u8)LINUART_MODE_TX_DISABLE) || \
   ((SensitivityValue) == (u8)LINUART_MODE_TXRX_ENABLE) || \
   ((SensitivityValue) == (u8)((u8)LINUART_MODE_TX_ENABLE|(u8)LINUART_MODE_RX_ENABLE)) || \
   ((SensitivityValue) == (u8)((u8)LINUART_MODE_TX_ENABLE|(u8)LINUART_MODE_RX_DISABLE)) || \
   ((SensitivityValue) == (u8)((u8)LINUART_MODE_TX_DISABLE|(u8)LINUART_MODE_RX_DISABLE)) || \
   ((SensitivityValue) == (u8)((u8)LINUART_MODE_TX_DISABLE|(u8)LINUART_MODE_RX_ENABLE)))

/**
 * @brief Macro used by the assert_param function in order to check the different sensitivity values for the WordLengths
 */
#define IS_LINUART_WORDLENGTH_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == LINUART_WORDLENGTH_8D) || \
   ((SensitivityValue) == LINUART_WORDLENGTH_9D))

/**
  * @brief Macro used by the assert_param function in order to check the different sensitivity values for the Interrupts
  */
#define IS_LINUART_IT_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == LINUART_IT_PIEN) || \
   ((SensitivityValue) == LINUART_IT_TIEN) || \
   ((SensitivityValue) == LINUART_IT_TCIEN) || \
   ((SensitivityValue) == LINUART_IT_RIEN ) || \
   ((SensitivityValue) == LINUART_IT_ILIEN) || \
   ((SensitivityValue) == LINUART_IT_LBDIEN)||\
   ((SensitivityValue) == LINUART_IT_LHDIEN))

/**
  * @brief Macro used by the assert_param function in order to check the different sensitivity values for the WakeUps
  */
#define IS_LINUART_WAKEUP_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == LINUART_WAKEUP_IDLELINE) || \
   ((SensitivityValue) == LINUART_WAKEUP_ADDRESSMARK))

/**
  * @brief Macro used by the assert_param function in order to check the different sensitivity values for the LINBreakDetectionLengths
  */
#define IS_LINUART_LINBREAKDETECTIONLENGTH_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == LINUART_BREAK10BITS) || \
   ((SensitivityValue) == LINUART_BREAK11BITS))

/**
  * @brief Macro used by the assert_param function in order to check the different sensitivity values for the LINUART_StopBits
  */
#define IS_LINUART_STOPBITS_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == LINUART_STOPBITS_1) || \
   ((SensitivityValue) == LINUART_STOPBITS_2))

/**
 * @brief Macro used by the assert_param function in order to check the different sensitivity values for the Paritys
 */
#define IS_LINUART_PARITY_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == LINUART_PARITY_NO) || \
   ((SensitivityValue) == LINUART_PARITY_EVEN) || \
   ((SensitivityValue) == LINUART_PARITY_ODD ))

/**
 * @brief Macro used by the assert_param function in order to check the maximum baudrate value
 */ 
#define IS_LINUART_BAUDRATE_OK(NUM) ((NUM) <= (u32)625000)

/**
 * @brief Macro used by the assert_param function in order to check the address of the LINUART node
 */
#define LINUART_ADDRESS_MAX ((u8)0x16)
#define IS_LINUART_LINUART_Address_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) < LINUART_ADDRESS_MAX))

/**
 * @brief Macro used by the assert_param function in order to check the LIN mode
 */
#define IS_LINUART_SLAVE_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == LINUART_LIN_MASTER_MODE) || \
   ((SensitivityValue) == LINUART_LIN_SLAVE_MODE))

/**
 * @brief Macro used by the assert_param function in order to check the LIN automatic resynchronization mode
 */
#define IS_LINUART_AUTOSYNC_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) ==  LINUART_LIN_AUTOSYNC_ENABLE) || \
   ((SensitivityValue) == LINUART_LIN_AUTOSYNC_DISABLE))

/**
 * @brief Macro used by the assert_param function in order to check the LIN divider update method
 */
#define IS_LINUART_DIVUP_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == LINUART_LIN_DIVUP_LBRR1) || \
   ((SensitivityValue) == LINUART_LIN_DIVUP_NEXTRXNE))

/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup LINUART_Exported_Functions
  * @{
  */

void LINUART_ClearFlag(LINUART_Flag_TypeDef LINUART_FLAGT);
void LINUART_ClearITPendingBit(LINUART_Flag_TypeDef LINUART_FLAG);
void LINUART_Cmd(FunctionalState NewState);
void LINUART_DeInit(void);
FlagStatus LINUART_GetFlagStatus(LINUART_Flag_TypeDef LINUART_FLAG);
ITStatus LINUART_GetITStatus(LINUART_Flag_TypeDef LINUART_FLAG);
void LINUART_StructInit(LINUART_Init_TypeDef* LINUART_InitStruct);
void LINUART_Init(LINUART_Init_TypeDef* LINUART_InitStruct);
void LINUART_ITConfig(LINUART_IT_TypeDef LINUART_IT, FunctionalState NewState);
void LINUART_LINBreakDetectionConfig(LINUART_LINBreakDetectionLength_TypeDef LINUART_LINBreakDetectionLength);
void LINUART_LINConfig(LINUART_Slave_TypeDef LINUART_Slave, LINUART_Autosync_TypeDef LINUART_Autosync, LINUART_DivUp_TypeDef LINUART_DivUp);
void LINUART_LINCmd(FunctionalState NewState);
u8 LINUART_ReceiveData8(void);
u16 LINUART_ReceiveData9(void);
void LINUART_ReceiverWakeUpCmd(FunctionalState NewState);
void LINUART_SendBreak(void);
void LINUART_SendData8(u8 Data);
void LINUART_SendData9(u16 Data);
void LINUART_SetAddress(u8 LINUART_Address);
void LINUART_WakeUpConfig( LINUART_WakeUp_TypeDef LINUART_WakeUp);

/**
  * @}
  */

#endif /* __STM8_LINUART_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
