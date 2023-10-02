/**
  ******************************************************************************
  * @file stm8_adc.h
  * @brief This file contains all the prototypes/macros for the ADC peripheral.
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
#ifndef __STM8_ADC_H
#define __STM8_ADC_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_map.h"

/* Exported types ------------------------------------------------------------*/

/** @addtogroup ADC_Exported_Types
  * @{
  */

/** ADC clock prescaler selection */
typedef enum {
  ADC_PRESSEL_FCPU_D2  = (u8)0x00, /**< Prescaler selection fadc = fcpu */
  ADC_PRESSEL_FCPU_D3  = (u8)0x10, /**< Prescaler selection fadc = fcpu/2 */
  ADC_PRESSEL_FCPU_D4  = (u8)0x20, /**< Prescaler selection fadc = fcpu/4 */
  ADC_PRESSEL_FCPU_D6  = (u8)0x30, /**< Prescaler selection fadc = fcpu/8 */
  ADC_PRESSEL_FCPU_D8  = (u8)0x40, /**< Prescaler selection fadc = fcpu/10 */
  ADC_PRESSEL_FCPU_D10 = (u8)0x50, /**< Prescaler selection fadc = fcpu/16 */
  ADC_PRESSEL_FCPU_D12 = (u8)0x60, /**< Prescaler selection fadc = fcpu/20 */
  ADC_PRESSEL_FCPU_D18 = (u8)0x70  /**< Prescaler selection fadc = fcpu/40 */
} ADC_PresSel_TypeDef;

/** ADC External conversion trigger event selection */
typedef enum {
  ADC_EXTTRIG_TIM1 = (u8)0x00, /**< Conversion from Internal TIM1 TRGO event */
  ADC_EXTTRIG_PC0  = (u8)0x10  /**< Conversion from External interrupt on GPIO Port C0 */
} ADC_ExtTrig_TypeDef;

/** ADC data alignment */
typedef enum {
  ADC_ALIGN_LEFT  = (u8)0x00, /**< Data alignment left */
  ADC_ALIGN_RIGHT = (u8)0x08  /**< Data alignment right */
} ADC_Align_TypeDef;

/** ADC schmitt Trigger */
typedef enum {
  ADC_SCHMITTTRIG_CHANNEL0  = (u8)0x00, /**< Schmitt trigger disable on AIN0 */
  ADC_SCHMITTTRIG_CHANNEL1  = (u8)0x01, /**< Schmitt trigger disable on AIN1 */
  ADC_SCHMITTTRIG_CHANNEL2  = (u8)0x02, /**< Schmitt trigger disable on AIN2 */
  ADC_SCHMITTTRIG_CHANNEL3  = (u8)0x03, /**< Schmitt trigger disable on AIN3 */
  ADC_SCHMITTTRIG_CHANNEL4  = (u8)0x04, /**< Schmitt trigger disable on AIN4 */
  ADC_SCHMITTTRIG_CHANNEL5  = (u8)0x05, /**< Schmitt trigger disable on AIN5 */
  ADC_SCHMITTTRIG_CHANNEL6  = (u8)0x06, /**< Schmitt trigger disable on AIN6 */
  ADC_SCHMITTTRIG_CHANNEL7  = (u8)0x07, /**< Schmitt trigger disable on AIN7 */
  ADC_SCHMITTTRIG_CHANNEL8  = (u8)0x08, /**< Schmitt trigger disable on AIN8 */
  ADC_SCHMITTTRIG_CHANNEL9  = (u8)0x09, /**< Schmitt trigger disable on AIN9 */
  ADC_SCHMITTTRIG_CHANNEL10 = (u8)0x0A, /**< Schmitt trigger disable on AIN10 */
  ADC_SCHMITTTRIG_CHANNEL11 = (u8)0x0B, /**< Schmitt trigger disable on AIN11 */
  ADC_SCHMITTTRIG_CHANNEL12 = (u8)0x0C, /**< Schmitt trigger disable on AIN12 */
  ADC_SCHMITTTRIG_CHANNEL13 = (u8)0x0D, /**< Schmitt trigger disable on AIN13 */
  ADC_SCHMITTTRIG_CHANNEL14 = (u8)0x0E, /**< Schmitt trigger disable on AIN14 */
  ADC_SCHMITTTRIG_CHANNEL15 = (u8)0x0F, /**< Schmitt trigger disable on AIN15 */
  ADC_SCHMITTTRIG_ALL       = (u8)0x1F /**< Schmitt trigger disable on all channels */
} ADC_SchmittTrigg_TypeDef;

/** ADC conversion mode selection */
typedef enum {
  ADC_CONVERSIONMODE_SINGLE     = (u8)0x00, /**< Single conversion mode */
  ADC_CONVERSIONMODE_CONTINUOUS = (u8)0x01  /**< Continuous conversion mode */
} ADC_ConvMode_TypeDef;

/**  ADC analog channel selection */
typedef enum {
  ADC_CHANNEL_0  = (u8)0x00, /**< Analog channel 0 */
  ADC_CHANNEL_1  = (u8)0x01, /**< Analog channel 1 */
  ADC_CHANNEL_2  = (u8)0x02, /**< Analog channel 2 */
  ADC_CHANNEL_3  = (u8)0x03, /**< Analog channel 3 */
  ADC_CHANNEL_4  = (u8)0x04, /**< Analog channel 4 */
  ADC_CHANNEL_5  = (u8)0x05, /**< Analog channel 5 */
  ADC_CHANNEL_6  = (u8)0x06, /**< Analog channel 6 */
  ADC_CHANNEL_7  = (u8)0x07, /**< Analog channel 7 */
  ADC_CHANNEL_8  = (u8)0x08, /**< Analog channel 8 */
  ADC_CHANNEL_9  = (u8)0x09, /**< Analog channel 9 */
  ADC_CHANNEL_10 = (u8)0x0A, /**< Analog channel 10 */
  ADC_CHANNEL_11 = (u8)0x0B, /**< Analog channel 11 */
  ADC_CHANNEL_12 = (u8)0x0C, /**< Analog channel 12 */
  ADC_CHANNEL_13 = (u8)0x0D, /**< Analog channel 13 */
  ADC_CHANNEL_14 = (u8)0x0E, /**< Analog channel 14 */
  ADC_CHANNEL_15 = (u8)0x0F  /**< Analog channel 15 */
} ADC_Channel_TypeDef;

/** ADC Init structure definition */
typedef struct
{
  ADC_ConvMode_TypeDef     ADC_ConversionMode;
  ADC_Channel_TypeDef      ADC_Channel;
  ADC_PresSel_TypeDef      ADC_PrescalerSelection;
  ADC_ExtTrig_TypeDef      ADC_ExtTrigger;
  FunctionalState          ADC_ExtTrigState;
  ADC_Align_TypeDef        ADC_Align;
  ADC_SchmittTrigg_TypeDef ADC_SchmittTriggerChannel;
  FunctionalState          ADC_SchmittTriggerState;
} ADC_Init_TypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/

/* Exported macros ------------------------------------------------------------*/

/* Private macros ------------------------------------------------------------*/

/** @addtogroup ADC_Private_Macros
  * @brief Macros used by the assert function to check the different functions parameters.
  * @{
  */

#define IS_ADC_PRESSEL_OK(PRESCALER) (((PRESCALER) == ADC_PRESSEL_FCPU_D2) || \
                                      ((PRESCALER) == ADC_PRESSEL_FCPU_D3) || \
                                      ((PRESCALER) == ADC_PRESSEL_FCPU_D4) || \
                                      ((PRESCALER) == ADC_PRESSEL_FCPU_D6) || \
                                      ((PRESCALER) == ADC_PRESSEL_FCPU_D8) || \
                                      ((PRESCALER) == ADC_PRESSEL_FCPU_D10) || \
                                      ((PRESCALER) == ADC_PRESSEL_FCPU_D12) || \
                                      ((PRESCALER) == ADC_PRESSEL_FCPU_D18))

#define IS_ADC_EXTTRIG_OK(EXTRIG) (((EXTRIG) == ADC_EXTTRIG_TIM1) || \
                                   ((EXTRIG) == ADC_EXTTRIG_PC0))

#define IS_ADC_ALIGN_OK(ALIGN) (((ALIGN) == ADC_ALIGN_LEFT) || \
                                ((ALIGN) == ADC_ALIGN_RIGHT))

#define IS_ADC_SCHMITTTRIG_OK(SCHMITTTRIG) (((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL0) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL1) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL2) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL3) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL4) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL5) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL6) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL7) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL8) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL9) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL10) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL11) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL12) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL13) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL14) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_CHANNEL15) || \
    ((SCHMITTTRIG) == ADC_SCHMITTTRIG_ALL))

#define IS_ADC_CONVERSIONMODE_OK(MODE) (((MODE) == ADC_CONVERSIONMODE_SINGLE) || \
                                        ((MODE) == ADC_CONVERSIONMODE_CONTINUOUS))

#define IS_ADC_CHANNEL_OK(CHANNEL) (((CHANNEL) == ADC_CHANNEL_0) || \
                                    ((CHANNEL) == ADC_CHANNEL_1) || \
                                    ((CHANNEL) == ADC_CHANNEL_2) || \
                                    ((CHANNEL) == ADC_CHANNEL_3) || \
                                    ((CHANNEL) == ADC_CHANNEL_4) || \
                                    ((CHANNEL) == ADC_CHANNEL_5) || \
                                    ((CHANNEL) == ADC_CHANNEL_6) || \
                                    ((CHANNEL) == ADC_CHANNEL_7) || \
                                    ((CHANNEL) == ADC_CHANNEL_8) || \
                                    ((CHANNEL) == ADC_CHANNEL_9) || \
                                    ((CHANNEL) == ADC_CHANNEL_10) || \
                                    ((CHANNEL) == ADC_CHANNEL_11) || \
                                    ((CHANNEL) == ADC_CHANNEL_12) || \
                                    ((CHANNEL) == ADC_CHANNEL_13) || \
                                    ((CHANNEL) == ADC_CHANNEL_14) || \
                                    ((CHANNEL) == ADC_CHANNEL_15))

/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup ADC_Exported_Functions
  * @{
  */

void ADC_ClearFlag(void);
void ADC_Cmd(FunctionalState NewState);
void ADC_ConversionConfig(ADC_ConvMode_TypeDef ADC_ConversionMode, ADC_Channel_TypeDef ADC_Channel, ADC_Align_TypeDef ADC_Align);
void ADC_DeInit(void);
void ADC_ExternalTriggerConfig(ADC_ExtTrig_TypeDef ADC_ExtTrigger, FunctionalState ADC_ExtTrigState);
u16 ADC_GetConversionValue(void);
FlagStatus ADC_GetFlagStatus(void);
ITStatus ADC_GetITStatus(void);
void ADC_Init(ADC_Init_TypeDef* ADC_InitStruct);
void ADC_ITCmd(FunctionalState ADC_ITEnable);
void ADC_PrescalerConfig(ADC_PresSel_TypeDef ADC_Prescaler);
void ADC_SchmittTriggerConfig(ADC_SchmittTrigg_TypeDef ADC_SchmittTriggerChannel, FunctionalState ADC_SchmittTriggerState);
void ADC_StartConversion(void);
void ADC_StructInit(ADC_Init_TypeDef* ADC_InitStruct);
extern u16 ADC_GetValue(u8 ADC_Channel);
extern void ADC_init(void);

/**
  * @}
  */

#endif /* __STM8_ADC_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
