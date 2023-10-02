/**
  ******************************************************************************
  * @file   st79_it.h
  * @brief  This file contains the external declarations of the interrupt routines.
  * @author STMicroelectronics - MCD/APG Application Teams
  ******************************************************************************
  * <h3>History:</h3>
  * <table border=2>
  * <tr><td>Date</td>        <td>Changes</td></tr>
  * <tr><td>23-APR-2007</td> <td>First version</td></tr>
  * </table>
  ******************************************************************************
  *
  * THE PRESENT SOFTWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT(void); STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT(void); INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2007 STMicroelectronics</center></h2>
  * <center><a href="http://mcu.st.com/mcu/">Microcontrollers Division</a></center>
  * @image html logo.bmp
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __ST79_IT_H
#define __ST79_IT_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_lib.h"
#include "TIMER2_3.h"
/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/*********************************************************************
 MACRO DEFINITION
*********************************************************************/
#define 	ENABLE_RX_INT			GPIOD->CR2  |= 0b00000100;
#define 	DISABLE_RX_INT			GPIOD->CR2  &= 0b11111011;

#define 	RISE_EDGE_INT			EXTI_SetExtIntSensitivity(EXTI_GPIOD, EXTI_RISE_ONLY)
#define		FALL_EDGE_INT			EXTI_SetExtIntSensitivity(EXTI_GPIOD, EXTI_FALL_ONLY)
#define 	RISE_FALL_EDGE_INT		EXTI_SetExtIntSensitivity(EXTI_GPIOD, EXTI_RISE_FALL)

#define 	TIM3_OCINT_DISABLE		TIM3_Disable_IT(CC1IE |CC2IE)
#define 	TIM3_OCINT_ENABLE		TIM3_Enable_IT(CC1IE |CC2IE)
#define 	TIM3_OVFINT_DISABLE		TIM3_Disable_IT(UIE)
#define 	TIM3_OVFINT_ENABLE		TIM3_Enable_IT(UIE)

#define 	TIM2_OCINT_DISABLE		TIM2_Disable_IT(CC1IE |CC2IE)
#define 	TIM2_OVFINT_DISABLE		TIM2_Disable_IT(UIE)
/* Exported functions ------------------------------------------------------- */

void NonHandledInterrupt(void);
void EEPROM_EEC_IRQHandler(void); /* EEPROM ECC CORRECTION */
void TIM4_UPD_OVF_IRQHandler(void); /* TIM4 UPD/OVF */
void ADC_IRQHandler(void); /* ADC */
void LINUART_RX_IRQHandler(void); /* LINUART RX */
void LINUART_TX_IRQHandler(void); /* LINUART TX */
void I2C_IRQHandler(void); /* I2C */
void USART_RX_IRQHandler(void); /* USART RX */
void USART_TX_IRQHandler(void); /* USART TX */
void TIM3_CAP_COM_IRQHandler(void); /* TIM3 CAP/COM */
void TIM3_UPD_OVF_BRK_IRQHandler(void); /* TIM3 UPD/OVF/BRK */
void TIM2_CAP_COM_IRQHandler(void); /* TIM2 CAP/COM */
void TIM2_UPD_OVF_BRK_IRQHandler(void); /* TIM2 UPD/OVF/BRK */
void TIM1_CAP_COM_IRQHandler(void); /* TIM1 CAP/COM */
void TIM1_UPD_OVF_TRG_BRK_IRQHandler(void); /* TIM1 UPD/OVF/TRG/BRK */
void SPI_IRQHandler(void); /* SPI */
void CAN_TX_IRQHandler(void); /* CAN TX/SCE */
void CAN_RX_IRQHandler(void); /* CAN RX */
void EXTI_PORTE_IRQHandler(void); /* EXTI PORTE */
void EXTI_PORTD_IRQHandler(void); /* EXTI PORTD */
void EXTI_PORTC_IRQHandler(void); /* EXTI PORTC */
void EXTI_PORTB_IRQHandler(void); /* EXTI PORTB */
void EXTI_PORTA_IRQHandler(void); /* EXTI PORTA */
void CLK_IRQHandler(void); /* CLOCK */
void AWU_IRQHandler(void); /* AWU */
void TLI_IRQHandler(void); /* TLI */
void TRAP_IRQHandler(void); /* TRAP */
void _stext(void); /* RESET startup routine */

 extern uchar canrextime;

#endif /* __ST79_IT_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
