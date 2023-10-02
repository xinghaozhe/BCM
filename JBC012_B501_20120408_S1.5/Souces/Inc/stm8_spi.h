/**
  ******************************************************************************
  * @file stm8_spi.h
  * @brief This file contains all functions prototype and macros for the SPI peripheral.
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
#ifndef __STM8_SPI_H
#define __STM8_SPI_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"

/* Exported types ------------------------------------------------------------*/

/** @addtogroup SPI_Exported_Types
  * @{
  */

/** SPI data direction mode */
/* Warning: element values correspond to BDM, BDOE, RXONLY bits position */
typedef enum {
  SPI_DATADIRECTION_2LINES_FULLDUPLEX = (u8)0x00, /*!< 2-line uni-directional data mode enable */
  SPI_DATADIRECTION_2LINES_RXONLY     = (u8)0x04, /*!< Receiver only in 2 line uni-directional data mode */
  SPI_DATADIRECTION_1LINE_RX          = (u8)0x80, /*!< Receiver only in 1 line bi-directional data mode */
  SPI_DATADIRECTION_1LINE_TX          = (u8)0xC0  /*!< Transmit only in 1 line bi-directional data mode */
} SPI_DataDirection_Typedef;

/** SPI direction transmit/receive */
typedef enum {
  SPI_DIRECTION_RX = (u8)0x00, /*!< Selects Rx receive direction in bi-directional mode */
  SPI_DIRECTION_TX = (u8)0x01  /*!< Selects Tx transmission direction in bi-directional mode */
} SPI_Direction_Typedef;

/** SPI master/slave mode */
/* Warning: element values correspond to MSTR bit position */
typedef enum {
  SPI_MODE_MASTER = (u8)0x04, /*!< SPI Master configuration */
  SPI_MODE_SLAVE  = (u8)0x00  /*!< SPI Slave configuration */
} SPI_Mode_Typedef;

/** SPI BaudRate Prescaler  */
/* Warning: element values correspond to BR bits position */
typedef enum {
  SPI_BAUDRATEPRESCALER_2   = (u8)0x00, /*!< SPI frequency = frequency(CPU)/2 */
  SPI_BAUDRATEPRESCALER_4   = (u8)0x08, /*!< SPI frequency = frequency(CPU)/4 */
  SPI_BAUDRATEPRESCALER_8   = (u8)0x10, /*!< SPI frequency = frequency(CPU)/8 */
  SPI_BAUDRATEPRESCALER_16  = (u8)0x18, /*!< SPI frequency = frequency(CPU)/16 */
  SPI_BAUDRATEPRESCALER_32  = (u8)0x20, /*!< SPI frequency = frequency(CPU)/32 */
  SPI_BAUDRATEPRESCALER_64  = (u8)0x28, /*!< SPI frequency = frequency(CPU)/64 */
  SPI_BAUDRATEPRESCALER_128 = (u8)0x30, /*!< SPI frequency = frequency(CPU)/128 */
  SPI_BAUDRATEPRESCALER_256 = (u8)0x38  /*!< SPI frequency = frequency(CPU)/256 */
} SPI_BaudRatePrescaler_Typedef;

/** SPI Clock Polarity */
/* Warning: element values correspond to CPOL bit position */
typedef enum {
  SPI_CPOL_LOW  = (u8)0x00, /*!< Clock to 0 when idle */
  SPI_CPOL_HIGH = (u8)0x02  /*!< Clock to 1 when idle */
} SPI_ClockPolarity_Typedef;

/** SPI Clock Phase */
/* Warning: element values correspond to CPHA bit position */
typedef enum {
  SPI_CPHA_1EDGE = (u8)0x00, /*!< The first clock transition is the first data capture edge */
  SPI_CPHA_2EDGE = (u8)0x01  /*!< The second clock transition is the first data capture edge */
} SPI_ClockPhase_Typedef;

/** SPI Frame Format: MSB or LSB transmitted first */
/* Warning: element values correspond to LSBFIRST bit position */
typedef enum {
  SPI_FIRSTBIT_MSB = (u8)0x00, /*!< MSB bit will be transmitted first */
  SPI_FIRSTBIT_LSB = (u8)0x80  /*!< LSB bit will be transmitted first */
} SPI_FirstBit_Typedef;

/** SPI CRC Transmit/Receive */
typedef enum {
  SPI_CRC_TX = (u8)0x00, /*!< Select Tx CRC register */
  SPI_CRC_RX = (u8)0x01  /*!< Select Rx CRC register */
} SPI_CRC_Typedef;

/** SPI interrupts definition */
typedef enum {
  SPI_IT_TXIE  = (u8)0x80, /*!< Transmit buffer empty interrupt enable mask */
  SPI_IT_RXIE  = (u8)0x40, /*!< Receiver buffer not empty interrupt enable mask */
  SPI_IT_ERRIE = (u8)0x20, /*!< Error interrupt enable mask */
  SPI_IT_WKIE  = (u8)0x10  /*!< Wake-up interrupt enable mask */
} SPI_Interrupts_Typedef;

/** SPI flags definition - Warning : FLAG value = mapping position register*/
typedef enum {
  SPI_FLAG_BSY    = (u8)0x80, /*!< Busy flag */
  SPI_FLAG_OVR    = (u8)0x40, /*!< Overrun flag */
  SPI_FLAG_MODF   = (u8)0x20, /*!< Mode fault */
  SPI_FLAG_CRCERR = (u8)0x10, /*!< CRC error flag */
  SPI_FLAG_WKUP   = (u8)0x08, /*!< Wake-up flag */
  SPI_FLAG_TXE    = (u8)0x02, /*!< Transmit buffer empty */
  SPI_FLAG_RXNE   = (u8)0x01  /*!< Receive buffer empty */
} SPI_Flag_Typedef;

/** SPI Init structure definition */
typedef struct
{
  SPI_FirstBit_Typedef          FirstBit;
  SPI_BaudRatePrescaler_Typedef BaudRatePrescaler;
  SPI_Mode_Typedef              Mode;
  SPI_ClockPolarity_Typedef     ClockPolarity;
  SPI_ClockPhase_Typedef        ClockPhase;
  SPI_DataDirection_Typedef     Data_Direction;
  FunctionalState               NSS_Software;
  u8                            CRCPolynomial;
} SPI_Init_TypeDef;

/**
  * @}
  */

/* Private define ------------------------------------------------------------*/

/* Private macros ------------------------------------------------------------*/

/** @addtogroup SPI_Private_Macros
  * @brief Macros used by the assert function to check the different functions parameters.
  * @{
  */

#define IS_SPI_DATA_DIRECTION_OK(MODE) (((MODE) == SPI_DATADIRECTION_2LINES_FULLDUPLEX) || \
                                        ((MODE) == SPI_DATADIRECTION_2LINES_RXONLY) || \
                                        ((MODE) == SPI_DATADIRECTION_1LINE_RX) || \
                                        ((MODE) == SPI_DATADIRECTION_1LINE_TX))

#define IS_SPI_DIRECTION_OK(DIRECTION) (((DIRECTION) == SPI_DIRECTION_RX) || \
                                        ((DIRECTION) == SPI_DIRECTION_TX))

#define IS_SPI_MODE_OK(MODE) (((MODE) == SPI_MODE_MASTER) || ((MODE) == SPI_MODE_SLAVE))

#define IS_SPI_BAUDRATE_PRESCALER_OK(PRESCALER) (((PRESCALER) == SPI_BAUDRATEPRESCALER_2) || \
    ((PRESCALER) == SPI_BAUDRATEPRESCALER_4) || \
    ((PRESCALER) == SPI_BAUDRATEPRESCALER_8) || \
    ((PRESCALER) == SPI_BAUDRATEPRESCALER_16) || \
    ((PRESCALER) == SPI_BAUDRATEPRESCALER_32) || \
    ((PRESCALER) == SPI_BAUDRATEPRESCALER_64) || \
    ((PRESCALER) == SPI_BAUDRATEPRESCALER_128) || \
    ((PRESCALER) == SPI_BAUDRATEPRESCALER_256))

#define IS_SPI_POLARITY_OK(CLKPOL) (((CLKPOL) == SPI_CPOL_LOW) || ((CLKPOL) == SPI_CPOL_HIGH))

#define IS_SPI_PHASE_OK(CLKPHA) (((CLKPHA) == SPI_CPHA_1EDGE) || ((CLKPHA) == SPI_CPHA_2EDGE))

#define IS_SPI_FIRSTBIT_OK(BIT) (((BIT) == SPI_FIRSTBIT_MSB) || ((BIT) == SPI_FIRSTBIT_LSB))

#define IS_SPI_CRC_OK(CRC) (((CRC) == SPI_CRC_TX) ||((CRC) == SPI_CRC_RX))

#define IS_SPI_INTERRUPTS_OK(FLAG) (((FLAG) == SPI_IT_TXIE) || ((FLAG) == SPI_IT_RXIE) || \
                                    ((FLAG) == SPI_IT_ERRIE) || ((FLAG) == SPI_IT_WKIE))

#define IS_SPI_FLAGS_OK(FLAG) (((FLAG) == SPI_FLAG_OVR) || \
                               ((FLAG) == SPI_FLAG_MODF) || \
                               ((FLAG) == SPI_FLAG_CRCERR) || \
                               ((FLAG) == SPI_FLAG_WKUP) || \
                               ((FLAG) == SPI_FLAG_TXE) || \
                               ((FLAG) == SPI_FLAG_RXNE) || \
                               ((FLAG) == SPI_FLAG_BSY))

#define IS_SPI_PENDINGBIT_OK(FLAG) (((FLAG) == SPI_FLAG_OVR) || \
                                    ((FLAG) == SPI_FLAG_MODF) || \
                                    ((FLAG) == SPI_FLAG_CRCERR) || \
                                    ((FLAG) == SPI_FLAG_WKUP) || \
                                    ((FLAG) == SPI_FLAG_TXE) || \
                                    ((FLAG) == SPI_FLAG_RXNE))

#define IS_SPI_CLEAR_FLAGS_OK(FLAG) (((FLAG) == SPI_FLAG_OVR) || \
                                     ((FLAG) == SPI_FLAG_MODF) || \
                                     ((FLAG) == SPI_FLAG_CRCERR) || \
                                     ((FLAG) == SPI_FLAG_WKUP))

/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup SPI_Exported_Functions
  * @{
  */

void SPI_DeInit(void);
void SPI_StructInit(SPI_Init_TypeDef* SPI_InitStruct);
void SPI_Init(SPI_Init_TypeDef* SPI_InitStruct);
void SPI_Cmd(FunctionalState NewState);
void SPI_SendData(u8 Data);
u8 SPI_ReceiveData(void);
void SPI_NSSInternalSoftwareCmd(FunctionalState NSS_NewState);
void SPI_ResetCRC(void);
void SPI_TransmitCRC(void);
void SPI_CalculateCRCCmd(FunctionalState NewState);
u8 SPI_GetCRC(SPI_CRC_Typedef SPI_CRC);
u8 SPI_GetCRCPolynomial(void);
void SPI_BiDirectionalLineConfig(SPI_Direction_Typedef SPI_Direction);
void SPI_ITConfig(SPI_Interrupts_Typedef SPI_IT, FunctionalState NewState);
FlagStatus SPI_GetFlagStatus(SPI_Flag_Typedef SPI_FLAG);
ITStatus SPI_GetITStatus(SPI_Interrupts_Typedef Spi_IT);
void SPI_ClearFlag(SPI_Flag_Typedef SPI_FLAG);
void SPI_ClearITPendingBit(SPI_Interrupts_Typedef Spi_IT);

/**
  * @}
  */

#endif /* __STM8_SPI_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
