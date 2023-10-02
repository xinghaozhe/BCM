/*	BASIC INTERRUPT VECTOR TABLE FOR STM8 devices
 *	Copyright (c) 2007 STMicroelectronics
 */
#include "st79_it.h"

typedef void  (*interrupt_handler_t)(void);

struct interrupt_vector {
	unsigned char interrupt_instruction;
	interrupt_handler_t interrupt_handler;
};

//@far @interrupt void NonHandledInterrupt (void)
//{
	/* in order to detect unexpected events during development, 
	   it is recommended to set a breakpoint on the following instruction
	*/
//	return;
//}

extern void NonHandledInterrupt (void);
extern void AWU_IRQHandler (void);
extern void EXTI_PORTE_IRQHandler (void);
extern void CAN_RX_IRQHandler (void);
extern void CAN_TX_IRQHandler (void);
extern void TIM2_UPD_OVF_BRK_IRQHandler (void);
extern void TIM2_CAP_COM_IRQHandler (void);
extern void TIM3_UPD_OVF_BRK_IRQHandler (void);
extern void TIM3_CAP_COM_IRQHandler (void);
extern void TIM4_UPD_OVF_IRQHandler (void);
extern void LINUART_RX_IRQHandler(void); 
extern void LINUART_TX_IRQHandler(void); 

extern void _stext();     /* startup routine */

struct interrupt_vector const _vectab[] = {
	{0x82, (interrupt_handler_t)_stext}, /* reset */
	{0x82, NonHandledInterrupt}, /* trap  */
	{0x82, NonHandledInterrupt}, /* irq0  */
	{0x82, AWU_IRQHandler}, /* irq1  */
	{0x82, NonHandledInterrupt}, /* irq2  */
	{0x82, NonHandledInterrupt}, /* irq3  */
	{0x82, NonHandledInterrupt}, /* irq4  */
	{0x82, NonHandledInterrupt}, /* irq5  */
	{0x82, EXTI_PORTD_IRQHandler}, /* irq6  */
	{0x82, NonHandledInterrupt}, /* irq7  */
	{0x82, CAN_RX_IRQHandler}, /* irq8  */
	{0x82, CAN_TX_IRQHandler}, /* irq9  */
	{0x82, NonHandledInterrupt}, /* irq10 */
	{0x82, NonHandledInterrupt}, /* irq11 */
	{0x82, NonHandledInterrupt}, /* irq12 */
	{0x82, TIM2_UPD_OVF_BRK_IRQHandler}, /* irq13 */
	{0x82, TIM2_CAP_COM_IRQHandler}, /* irq14 */
    {0x82, TIM3_UPD_OVF_BRK_IRQHandler}, /* irq15 */
	{0x82, TIM3_CAP_COM_IRQHandler}, /* irq16 */
	{0x82, LINUART_TX_IRQHandler}, /* irq17 */
    {0x82, LINUART_RX_IRQHandler}, /* irq18 */
	{0x82, NonHandledInterrupt}, /* irq19 */
	{0x82, NonHandledInterrupt}, /* irq20 */
	{0x82, NonHandledInterrupt}, /* irq21 */
	{0x82, NonHandledInterrupt}, /* irq22 */
	{0x82, TIM4_UPD_OVF_IRQHandler}, /* irq23 */
	{0x82, NonHandledInterrupt}, /* irq24 */
	{0x82, NonHandledInterrupt}, /* irq25 */
	{0x82, NonHandledInterrupt}, /* irq26 */
	{0x82, NonHandledInterrupt}, /* irq27 */
	{0x82, NonHandledInterrupt}, /* irq28 */
	{0x82, NonHandledInterrupt}, /* irq29 */
};


