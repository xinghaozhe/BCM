/**
  ********************************************************************************
  * @file stm8_usart.h
  * @brief This file contains all functions prototypes and macros for the USART peripheral.
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
#ifndef __STM8_USART_H
#define __STM8_USART_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"
/* Exported types ------------------------------------------------------------*/

/** @addtogroup USART_Exported_Types
  * @{
  */

/* USART_FLAG possible values
   Elements values convention: 0xXY
 		   X: FLAG position
       Y: Position of the corresponding Interrupt
*/
typedef enum { USART_FLAG_TXE           = (u8)0x77, /**< Transmit Data Register Empty flag  */
               USART_FLAG_TC            = (u8)0x66, /**< Transmission Complete flag         */
               USART_FLAG_RXNE          = (u8)0x55, /**< Read Data Register Not Empty flag  */
               USART_FLAG_IDLE          = (u8)0x44, /**< Idle line detected flag            */
               USART_FLAG_ORE           = (u8)0x53, /**< OverRun error flag                 */
               USART_FLAG_NE            = (u8)0x02, /**< Noise error flag                   */
               USART_FLAG_FE            = (u8)0x01, /**< Framing Error flag                 */
               USART_FLAG_PE            = (u8)0x00, /**< Parity Error flag                  */
               USART_FLAG_LBD           = (u8)0x64, /**< Break Detection Flag               */
               USART_FLAG_SBK           = (u8)0x20  /**< Send Break Complete interrupt flag */
             } USART_Flag_TypeDef;

/** USART Interruption sources  */
typedef enum { USART_IT_TIEN         = (u8)0x80, /**< 0x80 Transmitter Interruption   Enable         */
               USART_IT_TCIEN			   = (u8)0x40, /**< 0x40 Transmission Complete Interruption Enable */
               USART_IT_RIEN         = (u8)0x20, /**< 0x20 Receiver Interruption  Enable             */
               USART_IT_ILIEN	       = (u8)0x10, /**< 0x10 IDLE Line Interruption   Enable           */
               USART_IT_LBDIEN		   = (u8)0x04, /**< 0x04 LIN Break Detection Interruption Enable   */
               USART_IT_PIEN         = (u8)0x01  /**< 0x01 Parity Interruption  Enable               */
             } USART_IT_TypeDef;

/** USART Irda Modes  */
typedef enum { USART_IRDAMODE_LOWPOWER       = (u8)0x01, /**< 0x01 Irda Low Power Mode                */
               USART_IRDAMODE_NORMAL         = (u8)0x02 /**< 0x02 Irda Normal Mode                     */
             } USART_IrDAMode_TypeDef;

/** USART WakeUP Modes  */
typedef enum { USART_WAKEUP_IDLELINE       = (u8)0x00, /**< 0x01 Idle Line wake up                */
               USART_WAKEUP_ADDRESSMARK    = (u8)0x08  /**< 0x02 Address Mark wake up          */
             } USART_WakeUp_TypeDef;

typedef enum { USART_BREAK10BITS	= (u8)0x01, /**< 0x01 10 bits Lin Break detection            */
               USART_BREAK11BITS	= (u8)0x02  /**< 0x02 11 bits Lin Break detection          */
             } USART_LINBreakDetectionLength_TypeDef;

typedef enum { USART_STOPBITS_1	  = (u8)0x00,    /**< One stop bit is  transmitted at the end of frame*/
               USART_STOPBITS_0_5	= (u8)0x10,    /**< Half stop bits is transmitted at the end of frame*/
               USART_STOPBITS_2		= (u8)0x20,    /**< Two stop bits are  transmitted at the end of frame*/
               USART_STOPBITS_1_5	= (u8)0x30     /**< One and half stop bits*/
             } USART_StopBits_TypeDef;

typedef enum { USART_PARITY_NO	    = (u8)0x00,      /**< No Parity*/
               USART_PARITY_EVEN	  = (u8)0x04,      /**< Even Parity*/
               USART_PARITY_ODD		  = (u8)0x06       /**< Odd Parity*/
             } USART_Parity_TypeDef;

/** USART Synchrone modes */
typedef enum { USART_CLOCK_DISABLE    = (u8)0x80, /**< 0x80 Sync mode Disable, SLK pin Disable */
               USART_CLOCK_ENABLE     = (u8)0x08, /**< 0x08 Sync mode Enable, SLK pin Enable     */
               USART_CPOL_LOW         = (u8)0x40, /**< 0x40 Steady low value on SCLK pin outside transmission window */
               USART_CPOL_HIGH        = (u8)0x04, /**< 0x04 Steady high value on SCLK pin outside transmission window */
               USART_CPHA_MIDDLE      = (u8)0x20, /**< 0x20 SCLK clock line activated in middle of data bit     */
               USART_CPHA_BEGINING    = (u8)0x02, /**< 0x02 SCLK clock line activated at beginning of data bit  */
               USART_LASTBIT_DISABLE  = (u8)0x10, /**< 0x10 The clock pulse of the last data bit is not output to the SCLK pin */
               USART_LASTBIT_ENABLE   = (u8)0x01  /**< 0x01 The clock pulse of the last data bit is output to the SCLK pin */
             } USART_SyncMode_TypeDef;

/** USART Word length possible values */
typedef enum { USART_WORDLENGTH_8D = (u8)0x00,/**< 0x00 8 bits Data  */
               USART_WORDLENGTH_9D = (u8)0x10 /**< 0x10 9 bits Data  */
             } USART_WordLength_TypeDef;

/** USART Mode possible values */
typedef enum { USART_MODE_RX_ENABLE     = (u8)0x08,  /**< 0x08 Receive Enable                     */
               USART_MODE_TX_ENABLE     = (u8)0x04,  /**< 0x04 Transmit Enable                    */
               USART_MODE_TX_DISABLE    = (u8)0x80,  /**< 0x80 Transmit Disable                   */
               USART_MODE_RX_DISABLE    = (u8)0x40,  /**< 0x40 Single-wire Half-duplex mode       */
							 USART_MODE_TXRX_ENABLE   = (u8)0x0C  /**< 0x0C Transmit Enable and Receive Enable */
             } USART_Mode_TypeDef;


/** USART Init structure definition */
typedef struct
{
  USART_WordLength_TypeDef           WordLength;
  USART_StopBits_TypeDef             StopBits;
  USART_Parity_TypeDef               Parity;
  USART_SyncMode_TypeDef             SyncMode;
  u32                                BaudRate;
  USART_Mode_TypeDef                 Mode;
} USART_Init_TypeDef; 

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/
/* Exported macros ------------------------------------------------------------*/

/* Private macros ------------------------------------------------------------*/

/** @addtogroup USART_Private_Macros
  * @{
  */


/**
  * @brief Macro used by the assert_param function in order to check the different sensitivity values for the pending bit
  */
#define IS_USART_ITPENDINGBIT_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == USART_FLAG_TXE) || \
   ((SensitivityValue) == USART_FLAG_TC) || \
   ((SensitivityValue) == USART_FLAG_RXNE) || \
   ((SensitivityValue) == USART_FLAG_IDLE ) || \
   ((SensitivityValue) == USART_FLAG_ORE) || \
   ((SensitivityValue) == USART_FLAG_PE) || \
   ((SensitivityValue) == USART_FLAG_LBD))


/**
  * @brief Macro used by the assert_param function in order to check the different sensitivity values for the FLAGs
  */
#define IS_USART_FLAG_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == USART_FLAG_TXE) || \
   ((SensitivityValue) == USART_FLAG_TC)  || \
	 ((SensitivityValue) == USART_FLAG_SBK) || \
   ((SensitivityValue) == USART_FLAG_RXNE) || \
   ((SensitivityValue) == USART_FLAG_IDLE) || \
   ((SensitivityValue) == USART_FLAG_ORE) || \
   ((SensitivityValue) == USART_FLAG_NE) || \
   ((SensitivityValue) == USART_FLAG_FE) || \
	 ((SensitivityValue) == USART_FLAG_PE) || \
   ((SensitivityValue) == USART_FLAG_LBD))

/**
 * @brief Macro used by the assert_param function in order to check the different sensitivity values for the MODEs
 * possible combination should be one of the following
 */
#define IS_USART_MODE_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == (u8)USART_MODE_RX_ENABLE) || \
   ((SensitivityValue) == (u8)USART_MODE_RX_DISABLE) || \
   ((SensitivityValue) == (u8)USART_MODE_TX_ENABLE) || \
   ((SensitivityValue) == (u8)USART_MODE_TX_DISABLE) || \
	 ((SensitivityValue) == (u8)USART_MODE_TXRX_ENABLE) || \
   ((SensitivityValue) == (u8)((u8)USART_MODE_TX_ENABLE|(u8)USART_MODE_RX_ENABLE)) || \
   ((SensitivityValue) == (u8)((u8)USART_MODE_TX_ENABLE|(u8)USART_MODE_RX_DISABLE)) || \
   ((SensitivityValue) == (u8)((u8)USART_MODE_TX_DISABLE|(u8)USART_MODE_RX_DISABLE)) || \
   ((SensitivityValue) == (u8)((u8)USART_MODE_TX_DISABLE|(u8)USART_MODE_RX_ENABLE)))

/**
 * @brief Macro used by the assert_param function in order to check the different sensitivity values for the WordLengths
 */
#define IS_USART_WORDLENGTH_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == USART_WORDLENGTH_8D) || \
   ((SensitivityValue) == USART_WORDLENGTH_9D))

/**
  * @brief Macro used by the assert_param function in order to check the different sensitivity values for the SyncModes; it should exclude values such as  USART_CLOCK_ENABLE|USART_CLOCK_DISABLE
  * USART_SyncMode value should exclude values such as  USART_CLOCK_ENABLE|USART_CLOCK_DISABLE
  */
#define IS_USART_SYNCMODE_VALUE_OK(SensitivityValue) \
  (!((((SensitivityValue)&(((u8)USART_CLOCK_ENABLE)|((u8)USART_CLOCK_DISABLE))) == (((u8)USART_CLOCK_ENABLE)|((u8)USART_CLOCK_DISABLE))) || \
     (((SensitivityValue)&(((u8)USART_CPOL_LOW )|((u8)USART_CPOL_HIGH))) == (((u8)USART_CPOL_LOW )|((u8)USART_CPOL_HIGH))) || \
     (((SensitivityValue)&(((u8)USART_CPHA_MIDDLE)|((u8)USART_CPHA_BEGINING))) == (((u8)USART_CPHA_MIDDLE)|((u8)USART_CPHA_BEGINING))) || \
     (((SensitivityValue)&(((u8)USART_LASTBIT_DISABLE)|((u8)USART_LASTBIT_ENABLE))) == (((u8)USART_LASTBIT_DISABLE)|((u8)USART_LASTBIT_ENABLE)))))


/**
  * @brief Macro used by the assert_param function in order to check the different sensitivity values for the Interrupts
  */
#define IS_USART_IT_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == USART_IT_PIEN) || \
   ((SensitivityValue) == USART_IT_TIEN) || \
   ((SensitivityValue) == USART_IT_TCIEN) || \
   ((SensitivityValue) == USART_IT_RIEN ) || \
   ((SensitivityValue) == USART_IT_ILIEN) || \
   ((SensitivityValue) == USART_IT_LBDIEN))

/**
 * @brief Macro used by the assert_param function in order to check the different sensitivity values for the IrDAModes
 */
#define IS_USART_IRDAMODE_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == USART_IRDAMODE_LOWPOWER) || \
   ((SensitivityValue) == USART_IRDAMODE_NORMAL))

/**
  * @brief Macro used by the assert_param function in order to check the different sensitivity values for the WakeUps
  */
#define IS_USART_WAKEUP_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == USART_WAKEUP_IDLELINE) || \
   ((SensitivityValue) == USART_WAKEUP_ADDRESSMARK))

/**
  * @brief Macro used by the assert_param function in order to check the different sensitivity values for the LINBreakDetectionLengths
  */
#define IS_USART_LINBREAKDETECTIONLENGTH_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == USART_BREAK10BITS) || \
   ((SensitivityValue) == USART_BREAK11BITS))

/**
  * @brief Macro used by the assert_param function in order to check the different sensitivity values for the USART_StopBits
  */
#define IS_USART_STOPBITS_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == USART_STOPBITS_1) || \
   ((SensitivityValue) == USART_STOPBITS_0_5) || \
   ((SensitivityValue) == USART_STOPBITS_2) || \
   ((SensitivityValue) == USART_STOPBITS_1_5 ))

/**
 * @brief Macro used by the assert_param function in order to check the different sensitivity values for the Paritys
 */
#define IS_USART_PARITY_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) == USART_PARITY_NO) || \
   ((SensitivityValue) == USART_PARITY_EVEN) || \
    ((SensitivityValue) == USART_PARITY_ODD ))

/**
 * @brief Macro used by the assert_param function in order to check the maximum baudrate value
 */
#define IS_USART_BAUDRATE_OK(NUM) ((NUM) <= (u32)625000)


/**
 * @brief Macro used by the assert_param function in order to check the address of the LINUART node
 */
#define USART_ADDRESS_MAX ((u8)0x16)
#define IS_USART_ADDRESS_VALUE_OK(SensitivityValue) \
  (((SensitivityValue) < USART_ADDRESS_MAX ))

/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup USART_Exported_Functions
  * @{
  */

void USART_ClearFlag(USART_Flag_TypeDef USART_FLAG);
void USART_ClearITPendingBit(USART_Flag_TypeDef USART_FLAG);
void USART_Cmd(FunctionalState NewState);
void USART_DeInit(void);
FlagStatus USART_GetFlagStatus(USART_Flag_TypeDef USART_FLAG);
ITStatus USART_GetITStatus(USART_Flag_TypeDef USART_FLAG);
void USART_HalfDuplexCmd(FunctionalState NewState);
void USART_StructInit(USART_Init_TypeDef* USART_InitStruct);
void USART_Init(USART_Init_TypeDef* USART_InitStruct);
void USART_IrDAConfig(USART_IrDAMode_TypeDef USART_IrDAMode);
void USART_IrDACmd(FunctionalState NewState);
void USART_ITConfig(USART_IT_TypeDef USART_IT, FunctionalState NewState);
void USART_LINBreakDetectionConfig(USART_LINBreakDetectionLength_TypeDef USART_LINBreakDetectionLength);
void USART_LINCmd(FunctionalState NewState);
u8 USART_ReceiveData8(void);
u16 USART_ReceiveData9(void);
void USART_ReceiverWakeUpCmd(FunctionalState NewState);
void USART_SendBreak(void);
void USART_SendData8(u8 Data);
void USART_SendData9(u16 Data);
void USART_SetAddress(u8 USART_Address);
void USART_SetGuardTime(u8 USART_GuardTime);
void USART_SetPrescaler(u8 USART_Prescaler);
void USART_SmartCardCmd(FunctionalState NewState);
void USART_SmartCardNACKCmd(FunctionalState NewState);
void USART_WakeUpConfig(USART_WakeUp_TypeDef USART_WakeUp);

/**
  * @}
  */

#endif /* __STM8_USART_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
