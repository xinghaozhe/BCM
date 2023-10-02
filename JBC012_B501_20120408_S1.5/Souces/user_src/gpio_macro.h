
/*
**********************************************************************
*file name  : GPIO_MACRO.h                                           *
*description: This is the header file of configue file for PIO module*
*author     : cqhubin@126.com                                        *
*date       : 2007/08/20                                             *
**********************************************************************
*/


/*********************************************************************
 INCLUDE HEADER FILES
*********************************************************************/
//no I/O definition
#include "stm8_gpio.h"
//#include "st79_map.h"


/*********************************************************************
 MACRO DEFINITION 
*********************************************************************/


/*********************************************************************
 GPIO/PINS MACRO DEFINITION
*********************************************************************/
/* GPIOA Output Data Register bits MACRO definition (7 pins)*/ 
#define     MCU_OSC2			       	(GPIOA->IDR &   GPIO_Pin_1)	//no used
#define     MCU_OSC1			       	(GPIOA->IDR &   GPIO_Pin_2)	//no used

#define		DOME_LAMP_OUT				(GPIOA->ODR &   GPIO_Pin_3) //501
#define     DOME_LAMP_ON      			(GPIOA->ODR |=  GPIO_Pin_3)
#define     DOME_LAMP_OFF      			(GPIOA->ODR &= ~GPIO_Pin_3)

#define     WIN_FL_UP_OUT				(GPIOA->ODR &   GPIO_Pin_4)
#define     WIN_FL_UP_ON				(GPIOA->ODR |=  GPIO_Pin_4)
#define     WIN_FL_UP_OFF               (GPIOA->ODR &= ~GPIO_Pin_4)

#define     WIN_FL_DOWN_OUT             (GPIOA->ODR &   GPIO_Pin_5)
#define     WIN_FL_DOWN_ON              (GPIOA->ODR |=  GPIO_Pin_5)
#define     WIN_FL_DOWN_OFF             (GPIOA->ODR &= ~GPIO_Pin_5)
//#define	    DomeLampChannel				3


//#define		TRUNK_RELEASE_SW			(GPIOA->IDR &   GPIO_Pin_4) //501
//#define		FORTIFY_SW  				(GPIOA->ODR |=  GPIO_Pin_5) //501
#define		R_Door_state_IN				(GPIOA->IDR & GPIO_Pin_6) //501


/* GPIOA ODR/IDR/DDR/CR1/CR2 Register MACRO definition */
/* Configuration Register 1 bits description
   In input mode (DDR=0)= 0: Floating input    
                          1: Input with pull-up
   In output mode(DDR=1)= 0: Pseudo Open Drain 
                          1: Push-pull
*/    
/* Configuration Register 2 bits description
   In input mode (DDR=0)= 0: External interrupt disabled 
                          1: External interrupt enabled
   In output mode(DDR=1)= 0: Slope limited to 2 MHz
                          1: Slope limited to 10 MHz
*/    
#define     GPIOA_ODR_RESET_VALUE   	((u8)0b00000000)    //0:clear;  1:set
#define     GPIOA_IDR_RESET_VALUE   	((u8)0b00000000)    //0:low;    1:high
#define     GPIOA_DDR_RESET_VALUE   	((u8)0b00111000)    //0:input;  1:output
#define     GPIOA_CR1_RESET_VALUE   	((u8)0b00111000)    //
#define     GPIOA_CR2_RESET_VALUE   	((u8)0b00001000)    //

/*********************************************************************/
/* GPIOB Output Data Register bits MACRO definition (8 pins)*/ 
#define     TRUNK_AJAR           		  	(GPIOB->IDR &   GPIO_Pin_0)
#define     TURN_RIGHT_SW           		(GPIOB->IDR &   GPIO_Pin_1)
#define     TURN_LEFT_SW           		  	(GPIOB->IDR &   GPIO_Pin_2)

#define     LOCK_STA             	        (GPIOB->IDR &   GPIO_Pin_3)
#define     IGN_ON_STATE_IN             	(GPIOB->IDR &   GPIO_Pin_4)
#define     R_DEFROSTER_SW              	(GPIOB->IDR &   GPIO_Pin_5)
#define     D_SEATBELT_SW	              	(GPIOB->IDR &   GPIO_Pin_6)

#define     WIN_FL_KEY_ADIN          		7//GPIOB7

/* GPIOB ODR/IDR/DDR/CR1/CR2 Register MACRO definition */
/* Configuration Register 1 bits description
   In input mode (DDR=0)= 0: Floating input    
                          1: Input with pull-up
   In output mode(DDR=1)= 0: Pseudo Open Drain 
                          1: Push-pull
*/    
/* Configuration Register 2 bits description
   In input mode (DDR=0)= 0: External interrupt disabled 
                          1: External interrupt enabled
   In output mode(DDR=1)= 0: Slope limited to 2 MHz
                          1: Slope limited to 10 MHz
*/    
#define     GPIOB_ODR_RESET_VALUE   	((u8)0b00000000)    //0:clear;  1:set
#define     GPIOB_IDR_RESET_VALUE   	((u8)0b00000000)    //0:low;    1:high
#define     GPIOB_DDR_RESET_VALUE   	((u8)0b00000000)    //0:input;  1:output
#define     GPIOB_CR1_RESET_VALUE   	((u8)0b00000000)    //
#define     GPIOB_CR2_RESET_VALUE   	((u8)0b00000000)    //

/*********************************************************************/
/* GPIOC Output Data Register bits MACRO definition (8 pins)*/ 
//#define     RKE_SHUT_DOWN	           	(GPIOC->ODR &= ~GPIO_Pin_0)//NO used
//#define     RKE_POWER_ON	           	(GPIOC->ODR |=  GPIO_Pin_0)
#define     KEY_IN_STATE_IN             (GPIOC->IDR &   GPIO_Pin_1)
#define     CRASH_IN	                (GPIOC->IDR &   GPIO_Pin_2)
#define     HOOD_IN	                    (GPIOC->IDR &   GPIO_Pin_3)
#define     HORN_SW	                    (GPIOC->IDR &   GPIO_Pin_4)
#define     D_DOOR_AJAR		            (GPIOC->IDR &   GPIO_Pin_5)
//pin6 no used
#define     CAN_EN_OUT            		(GPIOC->ODR &   GPIO_Pin_7)
#define     CAN_EN_OFF                  (GPIOC->ODR |=  GPIO_Pin_7)
#define     CAN_EN_ON                   (GPIOC->ODR &= ~GPIO_Pin_7)

/* GPIOC ODR/IDR/DDR/CR1/CR2 Register MACRO definition */
/* Configuration Register 1 bits description
   In input mode (DDR=0)= 0: Floating input    
                          1: Input with pull-up
   In output mode(DDR=1)= 0: Pseudo Open Drain 
                          1: Push-pull
*/    
/* Configuration Register 2 bits description
   In input mode (DDR=0)= 0: External interrupt disabled 
                          1: External interrupt enabled
   In output mode(DDR=1)= 0: Slope limited to 2 MHz
                          1: Slope limited to 10 MHz
*/    
#define     GPIOC_ODR_RESET_VALUE   	((u8)0b10000000)    //0:clear;  1:set
#define     GPIOC_IDR_RESET_VALUE   	((u8)0b00000000)    //0:low;    1:high
#define     GPIOC_DDR_RESET_VALUE   	((u8)0b10000000)    //0:input;  1:output
#define     GPIOC_CR1_RESET_VALUE   	((u8)0b10000000)    //
#define     GPIOC_CR2_RESET_VALUE   	((u8)0b10000000)    //

/*********************************************************************/
/* GPIOD Output Data Register bits MACRO definition (8 pins)*/ 
#define     HORN_OUT   			(GPIOD->ODR &   GPIO_Pin_0)
#define     HORN_ON				(GPIOD->ODR |=  GPIO_Pin_0)
#define     HORN_OFF			(GPIOD->ODR &= ~GPIO_Pin_0)


#define		SWIM						(GPIOD->IDR &   GPIO_Pin_1)	//no used

#define     RKE_DATA_IN	                (GPIOD->IDR &   GPIO_Pin_2)

#define     BUZZER_OUT					(GPIOD->ODR &   GPIO_Pin_3)
#define     BUZZER_ON					(GPIOD->ODR |=  GPIO_Pin_3)
#define     BUZZER_OFF					(GPIOD->ODR &= ~GPIO_Pin_3)

#define     LIN_ENABLE_OUT				(GPIOD->ODR &   GPIO_Pin_4)
#define     LIN_ENABLE					(GPIOD->ODR |=  GPIO_Pin_4)
#define     LIN_DISENABLE				(GPIOD->ODR &= ~GPIO_Pin_4)

#define     LIN_TX_OUT					(GPIOD->ODR &   GPIO_Pin_5)      
#define     LIN_TX_HIGH        			(GPIOD->ODR |=  GPIO_Pin_5)
#define     LIN_TX_LOW		       		(GPIOD->ODR &= ~GPIO_Pin_5)

#define     LIN_RX		                (GPIOD->IDR &   GPIO_Pin_6)

#define     LIN_WAKE_UP	                (GPIOD->IDR &   GPIO_Pin_7)


/* GPIOD ODR/IDR/DDR/CR1/CR2 Register MACRO definition */
/* Configuration Register 1 bits description
   In input mode (DDR=0)= 0: Floating input    
                          1: Input with pull-up
   In output mode(DDR=1)= 0: Pseudo Open Drain 
                          1: Push-pull
*/    
/* Configuration Register 2 bits description
   In input mode (DDR=0)= 0: External interrupt disabled 
                          1: External interrupt enabled
   In output mode(DDR=1)= 0: Slope limited to 2 MHz
                          1: Slope limited to 10 MHz
*/    
#define     GPIOD_ODR_RESET_VALUE   	((u8)0b00000000)    //0:clear;  1:set
#define     GPIOD_IDR_RESET_VALUE   	((u8)0b00000000)    //0:low;    1:high
#define     GPIOD_DDR_RESET_VALUE   	((u8)0b00111001)    //0:input;  1:output
#define     GPIOD_CR1_RESET_VALUE   	((u8)0b00111001)    //
#define     GPIOD_CR2_RESET_VALUE   	((u8)0b00111101)    //

/*********************************************************************/
/* GPIOE Output Data Register bits MACRO definition (only 8 pins)*/ 
#define     TRUNK_UNLOCK_OUT   			(GPIOE->ODR &   GPIO_Pin_0)
#define     TRUNK_UNLOCK_ON				(GPIOE->ODR |=  GPIO_Pin_0)
#define     TRUNK_UNLOCK_OFF			(GPIOE->ODR &= ~GPIO_Pin_0)

//#define     WIN_FL_UP_OUT				(GPIOE->ODR &   GPIO_Pin_1)
//#define     WIN_FL_UP_ON				(GPIOE->ODR |=  GPIO_Pin_1)
//#define     WIN_FL_UP_OFF               (GPIOE->ODR &= ~GPIO_Pin_1)

//#define     WIN_FL_DOWN_OUT             (GPIOE->ODR &   GPIO_Pin_2)
//#define     WIN_FL_DOWN_ON              (GPIOE->ODR |=  GPIO_Pin_2)
//#define     WIN_FL_DOWN_OFF             (GPIOE->ODR &= ~GPIO_Pin_2)

#define     LOCK_OUT         		    (GPIOE->ODR &   GPIO_Pin_4)
#define     LOCK_ON                 	(GPIOE->ODR |=  GPIO_Pin_4)
#define     LOCK_OFF         		    (GPIOE->ODR &= ~GPIO_Pin_4)

#define     REAR_DEFROSTER_OUT         	(GPIOE->ODR &   GPIO_Pin_3)
#define     REAR_DEFROSTER_ON           (GPIOE->ODR |=  GPIO_Pin_3)
#define     REAR_DEFROSTER_OFF         	(GPIOE->ODR &= ~GPIO_Pin_3)



#define     UNLOCK_STA      	       	(GPIOE->IDR &   GPIO_Pin_5)

#define     HAZARD_SW					(GPIOE->IDR &   GPIO_Pin_6)

#define     OTHER_DOOR_AJAR				(GPIOE->IDR &   GPIO_Pin_7)
/* GPIOE ODR/IDR/DDR/CR1/CR2 Register MACRO definition */
/* Configuration Register 1 bits description
   In input mode (DDR=0)= 0: Floating input    
                          1: Input with pull-up
   In output mode(DDR=1)= 0: Pseudo Open Drain 
                          1: Push-pull
*/    
/* Configuration Register 2 bits description
   In input mode (DDR=0)= 0: External interrupt disabled 
                          1: External interrupt enabled
   In output mode(DDR=1)= 0: Slope limited to 2 MHz
                          1: Slope limited to 10 MHz
*/    
#define     GPIOE_ODR_RESET_VALUE   	((u8)0b00000000)    //0:clear;  1:set
#define     GPIOE_IDR_RESET_VALUE   	((u8)0b00000000)    //0:low;    1:high
#define     GPIOE_DDR_RESET_VALUE   	((u8)0b00011111)    //0:input;  1:output
#define     GPIOE_CR1_RESET_VALUE   	((u8)0b00011111)    //0b00011111
#define     GPIOE_CR2_RESET_VALUE   	((u8)0b00011111)    //

/*********************************************************************/
/* GPIOF Output Data Register bits MACRO definition (8 pins)*/ 
#define     LOCK_KEY_ADIN          			    10//GPIOF0
#define     BATTERY_VOL_ADIN          		    11//GPIOF3

#define     TURN_LEFT_LAMP_OUT           	(GPIOF->ODR &   GPIO_Pin_4)
#define     TURN_LEFT_LAMP_ON            	(GPIOF->ODR |=  GPIO_Pin_4)
#define     TURN_LEFT_LAMP_OFF           	(GPIOF->ODR &= ~GPIO_Pin_4)

#define     TURN_RIGHT_LAMP_OUT           	(GPIOF->ODR &   GPIO_Pin_5)
#define     TURN_RIGHT_LAMP_ON            	(GPIOF->ODR |=  GPIO_Pin_5)
#define     TURN_RIGHT_LAMP_OFF           	(GPIOF->ODR &= ~GPIO_Pin_5)

#define     TURN_L_CS_ADI           	14  //GPIOF PIN6
#define 	   SCANTURNK			0
//#define     TURN_R_CS_ADI           	15  //GPIOF PIN7
//#define                            (GPIOF->ODR &   GPIO_Pin_7)
#define     TURN_AD_RIGHT_EN                	(GPIOF->ODR |=  GPIO_Pin_7)
#define     TURN_AD_LEFT_EN                	(GPIOF->ODR &= ~GPIO_Pin_7)

/* GPIOF ODR/IDR/DDR/CR1/CR2 Register MACRO definition */
/* Configuration Register 1 bits description
   In input mode (DDR=0)= 0: Floating input    
                          1: Input with pull-up
   In output mode(DDR=1)= 0: Pseudo Open Drain 
                          1: Push-pull
*/    
/* Configuration Register 2 bits description
   In input mode (DDR=0)= 0: External interrupt disabled 
                          1: External interrupt enabled
   In output mode(DDR=1)= 0: Slope limited to 2 MHz
                          1: Slope limited to 10 MHz
*/    
#define     GPIOF_ODR_RESET_VALUE   	((u8)0b00000000)    //0:clear;  1:set
#define     GPIOF_IDR_RESET_VALUE   	((u8)0b00000000)    //0:low;    1:high
#define     GPIOF_DDR_RESET_VALUE   	((u8)0b10110000)    //0:input;  1:output
#define     GPIOF_CR1_RESET_VALUE   	((u8)0b10110000)    //
#define     GPIOF_CR2_RESET_VALUE   	((u8)0b10110000)    //

/*********************************************************************/
/* GPIOG Output Data Register bits MACRO definition (7 pins)*/ 
#define     CAN_TX_HIGH             	(GPIOG->ODR |=  GPIO_Pin_0)
#define     CAN_TX_LOW              	(GPIOG->ODR &= ~GPIO_Pin_0)
#define     CAN_RX_IN               	(GPIOG->IDR &   GPIO_Pin_1)

#define     H4021_CLK_HIGH            	(GPIOG->ODR |=  GPIO_Pin_2)
#define     H4021_CLK_LOW           	(GPIOG->ODR &= ~GPIO_Pin_2)

#define     H4021_SERIAL_IN_MODE       	(GPIOG->ODR |=  GPIO_Pin_3)
#define     H4021_PARALLEL_IN_MODE      (GPIOG->ODR &= ~GPIO_Pin_3)

#define     H4021_DATA_IN1              (GPIOG->IDR &   GPIO_Pin_4)
//#define     SMALL_LAMP_SW              (GPIOG->IDR &   GPIO_Pin_4)

#define     P_Seatbelt_OUT           	(GPIOG->ODR &   GPIO_Pin_5)
#define     P_Seatbelt_ON            	(GPIOG->ODR |=  GPIO_Pin_5)
#define     P_Seatbelt_OFF           	(GPIOG->ODR &= ~GPIO_Pin_5)

#define     IMMO_LED_OUT           		(GPIOG->ODR &   GPIO_Pin_6)
#define     IMMO_LED_ON	            	(GPIOG->ODR |=  GPIO_Pin_6)
#define     IMMO_LED_OFF          	 	(GPIOG->ODR &= ~GPIO_Pin_6)

#define     UNLOCK_OUT         		    (GPIOG->ODR &   GPIO_Pin_7)
#define     UNLOCK_ON                 	(GPIOG->ODR |=  GPIO_Pin_7)
#define     UNLOCK_OFF         		    (GPIOG->ODR &= ~GPIO_Pin_7)


/* GPIOG ODR/IDR/DDR/CR1/CR2 Register MACRO definition */
/* Configuration Register 1 bits description
   In input mode (DDR=0)= 0: Floating input    
                          1: Input with pull-up
   In output mode(DDR=1)= 0: Pseudo Open Drain 
                          1: Push-pull
*/    
/* Configuration Register 2 bits description
   In input mode (DDR=0)= 0: External interrupt disabled 
                          1: External interrupt enabled
   In output mode(DDR=1)= 0: Slope limited to 2 MHz
                          1: Slope limited to 10 MHz
*/    
#define     GPIOG_ODR_RESET_VALUE   	((u8)0b00000001)    //0:clear;  1:set
#define     GPIOG_IDR_RESET_VALUE   	((u8)0b00000000)    //0:low;    1:high
#define     GPIOG_DDR_RESET_VALUE   	((u8)0b11101101)    //0:input;  1:output
#define     GPIOG_CR1_RESET_VALUE  	 	((u8)0b11101101)    //
#define     GPIOG_CR2_RESET_VALUE   	((u8)0b11101101)    //

/*********************************************************************/
/* GPIOH Output Data Register bits MACRO definition (8 pins)*/ 
//#define     TRUNK_UNLOCK_OUT         	(GPIOH->ODR &   GPIO_Pin_1)
//#define     TRUNK_UNLOCK_ON         	(GPIOH->ODR |=  GPIO_Pin_1)
//#define     TRUNK_UNLOCK_OFF        	(GPIOH->ODR &= ~GPIO_Pin_1)
//#define     DRIVER_UNLOCK_OUT        	(GPIOH->ODR &   GPIO_Pin_0)
//#define     DRIVER_UNLOCK_ON        	(GPIOH->ODR |=  GPIO_Pin_0)
//#define     DRIVER_UNLOCK_OFF       	(GPIOH->ODR &= ~GPIO_Pin_0)
//#define     LOCK_OUT                	(GPIOH->ODR &   GPIO_Pin_2)
//#define     LOCK_ON                 	(GPIOH->ODR |=  GPIO_Pin_2)
//#define     LOCK_OFF                	(GPIOH->ODR &= ~GPIO_Pin_2)
//#define     WIN_FL_DOWN_OUT         	(GPIOH->ODR &   GPIO_Pin_3)
//#define     WIN_FL_DOWN_ON          	(GPIOH->ODR |=  GPIO_Pin_3)
//#define     WIN_FL_DOWN_OFF         	(GPIOH->ODR &= ~GPIO_Pin_3)
//#define     WIN_RL_UP_OUT       	  	(GPIOH->ODR &   GPIO_Pin_4)
//#define     WIN_RL_UP_ON	          	(GPIOH->ODR |=  GPIO_Pin_4)/
//#define     WIN_RL_UP_OFF   	      	(GPIOH->ODR &= ~GPIO_Pin_4)
//#define     HIGH_BEAM_ON	          	(GPIOH->ODR |=  GPIO_Pin_5)
//#define     HIGH_BEAM_OFF 		      	(GPIOH->ODR &= ~GPIO_Pin_5)
//#define     WIN_RR_UP_OUT       	  	(GPIOH->ODR &   GPIO_Pin_6)
//#define     WIN_RR_UP_ON	          	(GPIOH->ODR |=  GPIO_Pin_6)
//#define     WIN_RR_UP_OFF   	      	(GPIOH->ODR &= ~GPIO_Pin_6)
//#define     TURN_SOUND_ON	          	(GPIOH->ODR |=  GPIO_Pin_7)
//#define     TURN_SOUND_OFF   	      	(GPIOH->ODR &= ~GPIO_Pin_7)

/* GPIOH ODR/IDR/DDR/CR1/CR2 Register MACRO definition */

/* Configuration Register 1 bits description
   In input mode (DDR=0)= 0: Floating input    
                          1: Input with pull-up
   In output mode(DDR=1)= 0: Pseudo Open Drain 
                          1: Push-pull
*/    
/* Configuration Register 2 bits description
   In input mode (DDR=0)= 0: External interrupt disabled 
                          1: External interrupt enabled
   In output mode(DDR=1)= 0: Slope limited to 2 MHz
                          1: Slope limited to 10 MHz
*/    
#define     GPIOH_ODR_RESET_VALUE   	((u8)0b00000000)    //0:clear;  1:set
#define     GPIOH_IDR_RESET_VALUE   	((u8)0b00000000)    //0:low;    1:high
#define     GPIOH_DDR_RESET_VALUE   	((u8)0b00000000)    //0:input;  1:output
#define     GPIOH_CR1_RESET_VALUE   	((u8)0b00000000)    //
#define     GPIOH_CR2_RESET_VALUE   	((u8)0b00000000)    //

/*********************************************************************/
/* GPIOI Output Data Register bits MACRO definition (8 pins)*/ 
#define     RKE_POWER_ON	           	(GPIOI->ODR &= ~GPIO_Pin_0)
#define     RKE_SHUT_DOWN           	(GPIOI->ODR |=  GPIO_Pin_0)
/*
#define     HIGH_BEAM_SW                (GPIOI->IDR &   GPIO_Pin_0)
#define     SMALL_LAMP_SW           	(GPIOI->IDR &   GPIO_Pin_1)
#define     LOW_BEAM_SW             	(GPIOI->IDR &   GPIO_Pin_2)
#define     TURN_LEFT_SW            	(GPIOI->IDR &   GPIO_Pin_3)
#define     TURN_RIGHT_SW           	(GPIOI->IDR &   GPIO_Pin_4)
//#define     H4021_DATA_IN2 				(GPIOI->IDR &   GPIO_Pin_5)
#define     HORN_OUT                 	(GPIOI->ODR &   GPIO_Pin_6)
#define     HORN_ON                 	(GPIOI->ODR |=  GPIO_Pin_6)
#define     HORN_OFF                	(GPIOI->ODR &= ~GPIO_Pin_6)
#define     BATTERY_SAVE_OUT            (GPIOI->ODR &   GPIO_Pin_7)
#define     BATTERY_SAVE_ON             (GPIOI->ODR |=  GPIO_Pin_7)
#define     BATTERY_SAVE_OFF            (GPIOI->ODR &= ~GPIO_Pin_7)
*/
/* GPIOI ODR/IDR/DDR/CR1/CR2 Register MACRO definition */
/* Configuration Register 1 bits description
   In input mode (DDR=0)= 0: Floating input    
                          1: Input with pull-up
   In output mode(DDR=1)= 0: Pseudo Open Drain 
                          1: Push-pull
*/    
/* Configuration Register 2 bits description
   In input mode (DDR=0)= 0: External interrupt disabled 
                          1: External interrupt enabled
   In output mode(DDR=1)= 0: Slope limited to 2 MHz
                          1: Slope limited to 10 MHz
*/    
#define     GPIOI_ODR_RESET_VALUE   	((u8)0b00000000)    //0:clear;  1:set
#define     GPIOI_IDR_RESET_VALUE   	((u8)0b00000000)    //0:low;    1:high
#define     GPIOI_DDR_RESET_VALUE   	((u8)0b00000001)    //0:input;  1:output
#define     GPIOI_CR1_RESET_VALUE   	((u8)0b00000001)    //
#define     GPIOI_CR2_RESET_VALUE   	((u8)0b00000000)    //

/*********************************************************************
 end of the gpoi_macro.h file
*********************************************************************/

