/*
*****************************************************************************************
*                     Copyright (C) 2006 Freescale, Inc.                                *
*                           All Rights Reserved									       	*
*file name       : event.c                                                              *
*file description: This file contains all the event                                     * 
*author          : r66192@freescale.com                                                 *
*creation date   : 2006/4/13                                                            *
*revision date1  :                                                                      *
*****************************************************************************************
*/

/*********************************************************************
 INCLUDE HEADER FILES
*********************************************************************/
#include <hidef.h> /* for Enable Interrupts macro */
#include <stddef.h>
#include "event.h"   
#include "sci_drv.h"
#include "tpm_config.h"
#include "pio_drv.h"
#include "rke_drv.h"
#include "sys_init.h"
#include "pio_def.h"
#include "adc_drv.h"
#include "adc_cfg.h"
#include "win_drv.h"
#include "door_drv.h"
#include "lock_drv.h"
#include "defrost_drv.h"

/*********************************************************************
 VARIABLES DEFINITION
*********************************************************************/
uint    SpeedConter;
uchar   bitCnt;

/*********************************************************************
*********************************************************************/
/* IRQ interrupt routine*/
interrupt void IRQ_ISR( void )
{
	TPM1CHNL0_ID;		//disable TPM1Ch0 interrupt
    TPM1C0SC_CH0F = 0;	//clear TPM1Chn10 interrupt flag 

	IRQSC_IRQACK = 1; 	/* Clear IRQ interrupt flag */
    
    switch (RKE_STEP)
    {
    	case RKE_Idle:
    	{
    		if (IRQSC_IRQEDG)
    		{
    		    RKE_STEP = RKE_RecPreCodeHigh;
        		nPrecodeCnt = 0;
        		TPM1C0V = ((TPM1CNT + TE_ONE) % T1PERIOD);
        		TPM1CHNL0_IE;			//enable TPM1Ch0 interrupt
      		    IRQSC_IRQEDG = 0;
    		}
    		else
    		{
    		    IRQSC_IRQEDG = 1;
    			IRQSC_IRQIE = 1;        //Enable IRQ interrupt 
    		}
	    }break;
    	
    	case RKE_RecPreCodeHigh:
    	{
    	    if(isStandbying)
    	    {
    		    if(nPrecodeCnt > 2)
    		    {
    		        //ExitStandbyMode();
    	            nPrecodeCnt = 0;
    	            RKE_STEP = RKE_RecPreCodeLow;
        		    IRQSC_IRQEDG = 1;
            		TPM1C0V = ((TPM1CNT + TE_HALF) % T1PERIOD);
            		TPM1CHNL0_IE;		//enable TPM1Ch0 interrupt
    		    }
    	    }
	        else if((nPrecodeCnt < 9) || (nPrecodeCnt > 11))
	        {
    		    RKE_STEP = RKE_Idle;
    		    IRQSC_IRQEDG = 1;
	        }
	        else
	        {
	            nPrecodeCnt = 0;
	            RKE_STEP = RKE_RecPreCodeLow;
    		    IRQSC_IRQEDG = 1;
        		TPM1C0V = ((TPM1CNT + TE_HALF) % T1PERIOD);
        		TPM1CHNL0_IE;			//enable TPM1Ch0 interrupt
	        }
    	}break;

    	case RKE_RecPreCodeLow:
    	{
    		if (IRQSC_IRQEDG && (nPrecodeCnt >= 5) && (nPrecodeCnt <= 6))
    		{
                //start receive rke data
        		TPM1C0V = ((TPM1CNT + (TE_HALF + TE_QUARTER)) % T1PERIOD);
    			bitCnt = 0;
    			RKE_STEP = RKE_RecData;
        		TPM1CHNL0_IE;			//enable TPM1Ch0 interrupt
    		}
    		else
	        {
    		    RKE_STEP = RKE_Idle;
    		    IRQSC_IRQEDG = 1;
	        }
    	}break;
    	
    	case RKE_RecData:
    	{
    		TPM1C0V = ((TPM1CNT + TE_HALF + TE_QUARTER) % T1PERIOD);
    		TPM1CHNL0_IE;			//enable TPM1Ch0 interrupt
    	}break;
    	
    	case RKE_RecFinished:
    	{
    		TPM1C0SC_CH0F = 0;		//clear TPM1Chn10 interrupt flag 
   			IRQSC_IRQIE = 0;        //disable IRQ interrupt 
    	}break;

    	default :
    	{
    		RKE_RECEIVE_RESET(); 
    	}break;
    }
}
 
/*********************************************************************
*********************************************************************/
/* TPM1 channe0 interrupt routine*/
void T1C0(void)
{
    uchar i, tempMode, CheckSum;

	TPM1C0SC_CH0F = 0;				//clear TPM1Chn10 interrupt flag 
	
    switch (RKE_STEP)
    {
    	case RKE_Idle:
    	{
            RKE_STEP = RKE_Idle;
		    IRQSC_IRQEDG = 1;
			IRQSC_IRQIE = 1;        //enable IRQ interrupt 
    		TPM1CHNL0_ID;			//disable TPM1Ch0 interrupt
    	}break;
    	
    	case RKE_RecPreCodeHigh:
    	{
            nPrecodeCnt++;
    		TPM1C0V = ((TPM1CNT + TE_ONE) % T1PERIOD);
    	}break;

    	case RKE_RecPreCodeLow:
    	{
            nPrecodeCnt++;
    		TPM1C0V = ((TPM1CNT + TE_HALF + 50) % T1PERIOD);
    	}break;
    	
    	case RKE_RecData:
    	{
    		i = bitCnt / 16;
            LED_HO ^= 1;
    		if (RKE_DATA_IN)	
    		{
	    		RKE_FIFO_DATA[i] |= (1 << (bitCnt % 16));
	    		IRQSC_IRQEDG = 0;	//falling edge 
    		}
 			else 	 
 			{
 				RKE_FIFO_DATA[i] &= ~(1 << (bitCnt % 16));
 				IRQSC_IRQEDG = 1;	//rising edge
 			}
 			if (bitCnt == 7)
 			{   
 			    tempMode = (RKE_FIFO_DATA[0] & MODE_MASK);
 			    if ((tempMode != LEARN_MODE) && (tempMode != NORMAL_MODE) && (tempMode != CLOSE_WIN_MODE))
 			    {
 			        //rke received "Mode" is error
 			        RKE_STEP = RKE_Idle;
        		    IRQSC_IRQEDG = 1;
            		TPM1CHNL0_ID;			//disable TPM1Ch0 interrupt
 			    }
 			}
 			
			if (++bitCnt >= 80)
			{
				IRQSC_IRQIE = 0;        //disable IRQ interrupt 
				TPM1CHNL0_ID;	        //disable TPM1Ch0 interrupt
				CheckSum = 0;
                for (i=0;i<10;i++)
				    CheckSum ^= *((byte*)RKE_FIFO_DATA + i);
                if (CheckSum)
                {
                    RKE_STEP = RKE_Idle;
        		    IRQSC_IRQEDG = 1;
    				IRQSC_IRQIE = 1;        //Enable IRQ interrupt 
            		TPM1CHNL0_ID;			//disable TPM1Ch0 interrupt
                }
				else
				    RKE_STEP = RKE_RecFinished;
			}
    	}break;
    	
    	case RKE_RecFinished:
    	{
			TPM1CHNL0_ID;			//disable TPM1Ch0 interrupt
        }break;
    	
    	default:
    	{
			RKE_RECEIVE_RESET();
    	}break;
    }
}

/*********************************************************************
*********************************************************************/
// RTI interrupt routine
// 8ms interrupt
interrupt void RTI_ISR( void ) 	
{
    
    RTI_ACK;

    //check ADC convert isn't completed or convert is time out
    ADCerrorCnt++;
    
    //set main loop flag
    mainDutyFlag = 1;  

}

/*********************************************************************
*********************************************************************/
//event->TPM1 ch11 overflow, every 5ms
void T1C1(void)
{
	static uchar buzzerCnt;
	static uint  speedTime;
	
    //adjust buzzer driver 4Hz
    TPM1C1SC_CH1F = 0;	// clear TPM1Chn10 interrupt flag 

    //calculate engine rotate speed
    if (++speedTime >= TIME_3S)
    {
        //TPM1CHNL3_IE;
        if (SpeedConter >= SPEED_700RPM)
        {
            EngineSpeedState = SPEED_FAST;
        }
        else
        {
            EngineSpeedState = SPEED_SLOW;
        }
        SpeedConter = 0;
        speedTime = 0;
    }
    
    //Buzzer driver
    if (BuzzerDrvCnt)
    {
    	if (++buzzerCnt < BUZZER_DUTY)
	    {
	    	BUZZER_HO = HIGH;
	    }
	    else if (buzzerCnt < BUZZER_PERIOD)
	    {
	    	BUZZER_HO = LOW;
	    }
	    else
	    {
	    	BuzzerDrvCnt--;
	    	buzzerCnt = 0;
	    }
    }
    else
    {
	    	BUZZER_HO = LOW;
    }
}

/*********************************************************************
*********************************************************************/
//event->TPM1 ch13 input capture on rising edge 
void T1C3(void)
{
    SpeedConter++;
}

