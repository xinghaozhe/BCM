/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              sys_init.c
  Build Author:          Kevin   
  creation date:         2007/08/28
  Version of Software:   V101_BCM_v0.1                         
  Version of Hardware:   V101_BCM_v0.1
  Description:  MCU:ST79
                Development Tools: 
  Function List:   
    1. 
    2. 
  History:        
      <author>      Kevin
      <date>        2007/08/28
      <version >    v0.0.0 
      <description> build this moudle                   
*********************************************************************/

/*********************************************************************
 INCLUDE HEADER FILES
*********************************************************************/
#include "gpio_macro.h"
#include "sys_init.h"
#include "stm8_gpio.h"
#include "rke_drv.h"
#include "st79_it.h"
#include "adc_drv.h"
#include "stm8_macro.h"
#include "can.h"
#include "TIMER2_3.h"
#include "lin.h"
#include "lock_drv.h"

extern void TIM4_Init(void);
extern void GPIO_UserInit(GPIO_TypeDef* GPIOx);
extern void DecelerationSetting(uchar SettingValue); 
extern void ONSEINITEeprom(void);
/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
//uchar   LockDrvCmd;

/*********************************************************************
Name    :   void CheckWinTimeOut(void)
Function:   V101BCM function description
Input   :
Output  :   KeyInState <KeyIsOutHole / KeyIsInHole>
History :   
   1>Author      :   Kevin
     Date        :   2007/08/28
     Description :   Build
*********************************************************************/
void System_Init(void)
{
    Clear_WDT();
    
	GPIO_SysInit();
	RAM_Init();	
	RKE_RECEIVE_RESET();//RKE_Init(); 替换
	ADC_init();
	ADC_Start();


	EXTI_SetExtIntSensitivity(EXTI_GPIOD, EXTI_RISE_ONLY);
	
	//Timer 4 used 2ms timebase
	TIM4_Init();
	
	//Timer 2 used for Domelamp driver
	//TIM2TIM3_Counter_Cycle_OVIE_init(TIM2, T3PERIOD);
	TIM2_Counter_Cycle_OVIE_init(T3PERIOD);
	
  	//TIM2TIM3_PWM_Init(TIM2, 2, 0,  PWM_1,  Output_ActiveHigh);
	TIM2_PWM_Init(3, 0,  PWM_1,  Output_ActiveHigh);
  	TIM2_OCINT_DISABLE;
  	TIM2_OVFINT_DISABLE;
  	
  	//Timer 3 used for RKE receiver
  	//TIM2TIM3_CCR_WRITE(MTIM_TypeDef * TIMX, uc8 CC_Channel, u16 CCR_Value);
  	//TIM2TIM3_Counter_Cycle_OVIE_init(TIM3, 25000);
  	TIM3_Counter_Cycle_OVIE_init(25000);
	
	//TIM2TIM3_OCMP_Init(TIM3, 1, 20000,  Frozen,  NotOutput_ActiveLow);
	TIM3_OCMP_Init(1, 20000,  Frozen,  NotOutput_ActiveLow);
	//TIM2TIM3_OCMP_Init(TIM3, 2, 20000,  Frozen,  NotOutput_ActiveLow);
	TIM3_OCINT_DISABLE;
	TIM3_OVFINT_DISABLE;
	//TIM2TIM3_PWM_Init(TIM2, 3, 2500,  PWM_1,  Output_ActiveLow);

	FLASH_DeInit( );
	FLASH_Unlock(FLASH_MEMTYPE_DATA);  //程序调试取消写保护
	FLASH_Unlock(FLASH_MEMTYPE_PROG);
	DecelerationSetting(0); //写刹车初始参数   默认
    //CAN 初始化
	CAN_WakeUp();
	CAN_Init(CMCR_AWUM);
	//CAN_Init(CMCR_ABOM | CMCR_AWUM);
	CAN_EnableDiagMode(CDGR_RX);		//  | CDGR_SILM TEST MODE
	CanCanInterruptRestore();

	
	//LIN_Init();
	
	enableInterrupts();

    //   ONSEINITEeprom(); //第一次启动初始化EEPROM 
 
    //   TRUNKWarmstate = 1 ;
       
  	rim()
}
/*********************************************************************
*********************************************************************/
void GPIO_SysInit(void)
{
    GPIO_UserInit(GPIOA);
    GPIO_UserInit(GPIOB);
    GPIO_UserInit(GPIOC);
    GPIO_UserInit(GPIOD);
    GPIO_UserInit(GPIOE);
    GPIO_UserInit(GPIOF);
    GPIO_UserInit(GPIOG);
    GPIO_UserInit(GPIOH);
    GPIO_UserInit(GPIOI);
	TURN_LEFT_LAMP_OFF;
	TURN_RIGHT_LAMP_OFF;
	CAN_TURNRightSW_OFF;
	CAN_TURNLeftSW_OFF;
}

/*********************************************************************
*********************************************************************/
void RAM_Init(void)
{

}

/*********************************************************************
*********************************************************************/
void Clear_WDT(void)
{
	//feed exteral watch dog timer
      IWDG->KR = 0xaa;
//if (EXTERAL_WDG_OUT)
//    	CLEAR_EXTERAL_WDG;
//    else
//    	SET_EXTERAL_WDG;
    
    //feed interal watch dog timer  

}


////////////////////////////////////////////////////////////////

void GPIO_UserInit(GPIO_TypeDef* GPIOx)
{
    switch ((u16)(GPIOx))
    {
        case GPIOA_BaseAddress:
            {
                GPIOx->ODR = GPIOA_ODR_RESET_VALUE; /* Reset Output Data Register */
                GPIOx->IDR = GPIOA_IDR_RESET_VALUE; /* Reset Input Data Register */
                GPIOx->DDR = GPIOA_DDR_RESET_VALUE; /* Reset Data Direction Register */
                GPIOx->CR1 = GPIOA_CR1_RESET_VALUE; /* Reset Control Register 1 */
                GPIOx->CR2 = GPIOA_CR2_RESET_VALUE; /* Reset Control Register 2 */
            }break;

        case GPIOB_BaseAddress:
            {
                GPIOx->ODR = GPIOB_ODR_RESET_VALUE; /* Reset Output Data Register */
                GPIOx->IDR = GPIOB_IDR_RESET_VALUE; /* Reset Input Data Register */
                GPIOx->DDR = GPIOB_DDR_RESET_VALUE; /* Reset Data Direction Register */
                GPIOx->CR1 = GPIOB_CR1_RESET_VALUE; /* Reset Control Register 1 */
                GPIOx->CR2 = GPIOB_CR2_RESET_VALUE; /* Reset Control Register 2 */
            }break;

        case GPIOC_BaseAddress:
            {
                GPIOx->ODR = GPIOC_ODR_RESET_VALUE; /* Reset Output Data Register */
                GPIOx->IDR = GPIOC_IDR_RESET_VALUE; /* Reset Input Data Register */
                GPIOx->DDR = GPIOC_DDR_RESET_VALUE; /* Reset Data Direction Register */
                GPIOx->CR1 = GPIOC_CR1_RESET_VALUE; /* Reset Control Register 1 */
                GPIOx->CR2 = GPIOC_CR2_RESET_VALUE; /* Reset Control Register 2 */
            }break;

        case GPIOD_BaseAddress:
            {
                GPIOx->ODR = GPIOD_ODR_RESET_VALUE; /* Reset Output Data Register */
                GPIOx->IDR = GPIOD_IDR_RESET_VALUE; /* Reset Input Data Register */
                GPIOx->DDR = GPIOD_DDR_RESET_VALUE; /* Reset Data Direction Register */
                GPIOx->CR1 = GPIOD_CR1_RESET_VALUE; /* Reset Control Register 1 */
                GPIOx->CR2 = GPIOD_CR2_RESET_VALUE; /* Reset Control Register 2 */
            }break;

        case GPIOE_BaseAddress:
            {
                GPIOx->ODR = GPIOE_ODR_RESET_VALUE; /* Reset Output Data Register */
                GPIOx->IDR = GPIOE_IDR_RESET_VALUE; /* Reset Input Data Register */
                GPIOx->DDR = GPIOE_DDR_RESET_VALUE; /* Reset Data Direction Register */
                GPIOx->CR1 = GPIOE_CR1_RESET_VALUE; /* Reset Control Register 1 */
                GPIOx->CR2 = GPIOE_CR2_RESET_VALUE; /* Reset Control Register 2 */
            }break;

        case GPIOF_BaseAddress:
            {
                GPIOx->ODR = GPIOF_ODR_RESET_VALUE; /* Reset Output Data Register */
                GPIOx->IDR = GPIOF_IDR_RESET_VALUE; /* Reset Input Data Register */
                GPIOx->DDR = GPIOF_DDR_RESET_VALUE; /* Reset Data Direction Register */
                GPIOx->CR1 = GPIOF_CR1_RESET_VALUE; /* Reset Control Register 1 */
                GPIOx->CR2 = GPIOF_CR2_RESET_VALUE; /* Reset Control Register 2 */
            }break;

        case GPIOG_BaseAddress:
            {
                GPIOx->ODR = GPIOG_ODR_RESET_VALUE; /* Reset Output Data Register */
                GPIOx->IDR = GPIOG_IDR_RESET_VALUE; /* Reset Input Data Register */
                GPIOx->DDR = GPIOG_DDR_RESET_VALUE; /* Reset Data Direction Register */
                GPIOx->CR1 = GPIOG_CR1_RESET_VALUE; /* Reset Control Register 1 */
                GPIOx->CR2 = GPIOG_CR2_RESET_VALUE; /* Reset Control Register 2 */
            }break;

        case GPIOH_BaseAddress:
            {
                GPIOx->ODR = GPIOH_ODR_RESET_VALUE; /* Reset Output Data Register */
                GPIOx->IDR = GPIOH_IDR_RESET_VALUE; /* Reset Input Data Register */
                GPIOx->DDR = GPIOH_DDR_RESET_VALUE; /* Reset Data Direction Register */
                GPIOx->CR1 = GPIOH_CR1_RESET_VALUE; /* Reset Control Register 1 */
                GPIOx->CR2 = GPIOH_CR2_RESET_VALUE; /* Reset Control Register 2 */
            }break;

        case GPIOI_BaseAddress:
            {
                GPIOx->ODR = GPIOI_ODR_RESET_VALUE; /* Reset Output Data Register */
                GPIOx->IDR = GPIOI_IDR_RESET_VALUE; /* Reset Input Data Register */
                GPIOx->DDR = GPIOI_DDR_RESET_VALUE; /* Reset Data Direction Register */
                GPIOx->CR1 = GPIOI_CR1_RESET_VALUE; /* Reset Control Register 1 */
                GPIOx->CR2 = GPIOI_CR2_RESET_VALUE; /* Reset Control Register 2 */
            }break;

        default:
             break;
    }
}

/*********************************************************************
 end of the sys_init.c file
*********************************************************************/

