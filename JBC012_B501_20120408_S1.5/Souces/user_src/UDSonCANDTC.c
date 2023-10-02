

#include "UDSonCANDTC.h"

#include "UDSonCAN.h"
//////////////////////////需要的头文件
#include "main.h"
#include "gpio_macro.h"
#include "adc_drv.h"
#include "st79_it.h"
#include "domelamp_drv.h"
#include "turnlamp_drv.h"
#include "lock_drv.h"
#include "warm_drv.h"
#include "horn_drv.h"
#include "rke_drv.h"
#include "window_drv.h"
#include "stm8_macro.h"
#include "defrost_drv.h"
//#include "foglamp_drv.h"
//#include "beam_drv.h"
//#include "wiper_drv.h"
#include "sys_Init.h"
#include "can.h"
//#include "Lin.h"
#include "stm8_awu.h"
#include "share.h"
#include "can_nm_osek.h"
//#include "udsoncan.h"
//////////////////////////

extern FLASH_Status_Typedef FLASH_ProgramByte(u32 Address, u8 Data);

void UDSDTC_main(void)
{
     if(DTCRuningstate != 0) return;
	 
     UDSDTC9001();

	 UDSDTC9003();

	 UDSDTC9015();

	 UDSDTC9111();

	 UDSDTC9091();

	 UDSDTC9083();

	 UDSDTC9011();

	 UDSDTC9023();

	 UDSDTC9007();

	 UDSDTC9043();

	 UDSDTC9093();

	 UDSDTC9061();

	 UDSDTC9067();

	 UDSDTC9045();

	 UDSDTC9073();

	 UDSDTC900c();

	 UDSDTCd001();

	 UDSDTCd002();

	 UDSDTCd003();

	 UDSDTCd004();

	 UDSDTCd005();

}


void UDSDTC9001(void)
{
     static unsigned int dtctime=0;
	 static unsigned int dtctime2=0;
     //周期性故障
     if(TurnLampState & TLL_IS_OPEN)
     {
        if((DTCstate[DTC9001] & DTCcycleFail)==0)
        {
         	//DTCstate[DTC9001] | DTCcycleFail
			Weeprommain((unsigned long)(&DTCstate[DTC9001]),DTCstate[DTC9001] | DTCcycleFail);
        }
	 }
	 else 
	 {
	    if((DTCstate[DTC9001] & DTCcycleFail)!=0)
        {
         	//DTCstate[DTC9001] &=~DTCcycleFail;
			Weeprommain((unsigned long)(&DTCstate[DTC9001]),DTCstate[DTC9001] & (~DTCcycleFail));
        }
	 }
     //永久性故障
     if((TurnLampDrv &  TurnLampLeftOn )&&(TurnLampState & TLL_IS_OPEN))
     {
          dtctime2 = 0;
          if(dtctime < DTC10000MS) dtctime++;
		  else 
		  {
		        if((DTCstate[DTC9001] & DTCconfirmed)==0)
		        {
		         	//DTCstate[DTC9001] |= DTCconfirmed;
					Weeprommain((unsigned long)(&DTCstate[DTC9001]),DTCstate[DTC9001] | DTCconfirmed);
		        }
		  }

	 }
	 else if((TurnLampDrv &  TurnLampLeftOn )&&((TurnLampState & TLL_IS_OPEN)==0))
	 {
	      dtctime = 0;
          if(dtctime2 < DTC10000MS) dtctime2++;
		  else 
		  {
		        if((DTCstate[DTC9001] & DTCconfirmed)!=0)
		        {
		         	//DTCstate[DTC9001] &= ~DTCconfirmed;
					Weeprommain((unsigned long)(&DTCstate[DTC9001]),DTCstate[DTC9001] & (~DTCconfirmed));
		        }
		  }

	 }
	 else
	 {
		dtctime = 0 ;
		dtctime2 = 0;
	 }
	 
}

void UDSDTC9003(void)
{
     static unsigned int dtctime=0;
	 static unsigned int dtctime2=0;
	 unsigned char cnt;
     //周期性故障
     if(TurnLampState & TLR_IS_OPEN)
     {
        if((DTCstate[DTC9003] & DTCcycleFail)==0)
        {
         	DTCstate[DTC9003] |= DTCcycleFail;
			Weeprommain((unsigned long)(&DTCstate[DTC9003]),DTCstate[DTC9003] | DTCcycleFail);
        }
	 }
	 else 
	 {
	    if((DTCstate[DTC9003] & DTCcycleFail)!=0)
        {
         	//DTCstate[DTC9003] &=~DTCcycleFail;
			Weeprommain((unsigned long)(&DTCstate[DTC9003]),DTCstate[DTC9003] & (~DTCcycleFail));
        }
	 }
     //永久性故障
     if((TurnLampDrv &  TurnLampRightOn )&&(TurnLampState & TLR_IS_OPEN))
     {
          dtctime2 = 0;
          if(dtctime < DTC10000MS) dtctime++;
		  else 
		  {
		        if((DTCstate[DTC9003] & DTCconfirmed)==0)
		        {

					Weeprommain((unsigned long)(&DTCstate[DTC9003]),DTCstate[DTC9003] | DTCconfirmed);


		        }
		  }

	 }
	 else if((TurnLampDrv &  TurnLampRightOn)&&((TurnLampState & TLR_IS_OPEN)==0))
	 {
	      dtctime = 0;
          if(dtctime2 < DTC10000MS) dtctime2++;
		  else 
		  {
		        if((DTCstate[DTC9003] & DTCconfirmed)!=0)
		        {
		         	//DTCstate[DTC9003] &= ~DTCconfirmed;
					Weeprommain((unsigned long)(&DTCstate[DTC9003]),DTCstate[DTC9003] & (~DTCconfirmed));
		        }
		  }

	 }
	 else
	 {
		dtctime = 0 ;
		dtctime2 = 0;
	 }
}

void UDSDTC9015(void)
{
     static unsigned int dtctime=0;
	 static unsigned int dtctime2=0;

     if(battervalue > Batter16V)
     {
        dtctime2 = 0;
        //周期性故障
        if((DTCstate[DTC9015] & DTCcycleFail)==0)
        {
         	//DTCstate[DTC9015] |= DTCcycleFail;
			Weeprommain((unsigned long)(&DTCstate[DTC9015]),DTCstate[DTC9015] | DTCcycleFail);
        }
		//dtc
		if(dtctime < DTC10000MS)dtctime++;
	    else
		{
			if((DTCstate[DTC9015] & DTCconfirmed)==0)
			{
				//DTCstate[DTC9015] |= DTCconfirmed;
				Weeprommain((unsigned long)(&DTCstate[DTC9015]),DTCstate[DTC9015] | DTCconfirmed);
			
			}	
		}
	 }
	 else
	 {
	    dtctime = 0;
	    //周期性故障
	    if((DTCstate[DTC9015] & DTCcycleFail)!=0)
        {
         	//DTCstate[DTC9015] &=~DTCcycleFail;
			Weeprommain((unsigned long)(&DTCstate[DTC9015]),DTCstate[DTC9015] & (~DTCcycleFail));
        }
		//dtc
		if(dtctime2 < DTC1Min)dtctime2++;
	    else
		{
			if((DTCstate[DTC9015] & DTCconfirmed)!=0)
			{
				//DTCstate[DTC9015] &= ~DTCconfirmed;
				Weeprommain((unsigned long)(&DTCstate[DTC9015]),DTCstate[DTC9015] & (~DTCconfirmed));
			}	
		}
	 }

}
void UDSDTC9111(void)
{
     static unsigned int dtctime=0;
	 static unsigned int dtctime2=0;

     if(battervalue < Batter9V)
     {
        dtctime2 = 0;
        //周期性故障
        if((DTCstate[DTC9111] & DTCcycleFail)==0)
        {
         	//DTCstate[DTC9111] |= DTCcycleFail;
			Weeprommain((unsigned long)(&DTCstate[DTC9111]),DTCstate[DTC9111] | DTCcycleFail);
        }
		//dtc
		if(dtctime < DTC10000MS)dtctime++;
	    else
		{
			if((DTCstate[DTC9111] & DTCconfirmed)==0)
			{
				//DTCstate[DTC9111] |= DTCconfirmed;
				Weeprommain((unsigned long)(&DTCstate[DTC9111]),DTCstate[DTC9111] | DTCconfirmed);
			}	
		}
	 }
	 else
	 {
	    dtctime = 0;
	    //周期性故障
	    if((DTCstate[DTC9111] & DTCcycleFail)!=0)
        {
         	//DTCstate[DTC9111] &=~DTCcycleFail;
			Weeprommain((unsigned long)(&DTCstate[DTC9111]),DTCstate[DTC9111] & (~DTCcycleFail));
        }
		//dtc
		if(dtctime2 < DTC1Min)dtctime2++;
	    else
		{
			if((DTCstate[DTC9111] & DTCconfirmed)!=0)
			{
				//DTCstate[DTC9111] &= ~DTCconfirmed;
				Weeprommain((unsigned long)(&DTCstate[DTC9111]),DTCstate[DTC9111] & (~DTCconfirmed));
			}	
		}
	 }
}

void UDSDTC9091(void)
{
     static unsigned char lockstatetime = 0;
	 static unsigned char lockcnt = 0;
     if(LockDrvCmd & UnlockDriverDoorCmd)
     {
		lockstatetime = 10;
	 }
	 if(lockstatetime)
	 {
        lockstatetime--;
		if(lockstatetime == 0)
		{
            if(LockState == Locked)
            {
                lockcnt = 0;
				if((DTCstate[DTC9091] & DTCconfirmed)==0)
				{
					//DTCstate[DTC9091] |= DTCconfirmed;
					Weeprommain((unsigned long)(&DTCstate[DTC9091]),DTCstate[DTC9091] | DTCconfirmed);
				}	
			}
			else
			{
                if(lockcnt < 12)lockcnt++;
				if(lockcnt > 10)
				{
					if((DTCstate[DTC9091] & DTCconfirmed)!=0)
					{
						//DTCstate[DTC9091] &= ~DTCconfirmed;
						Weeprommain((unsigned long)(&DTCstate[DTC9091]),DTCstate[DTC9091] & (~DTCconfirmed));
					}
				}
			}
		}
	 }
}


void UDSDTC9083(void)
{
     static unsigned char lockstatetime = 0;
	 static unsigned char lockcnt = 0;
     if(LockDrvCmd & LockCmd)
     {
		lockstatetime = 10;
	 }
	 if(lockstatetime)
	 {
        lockstatetime--;
		if(lockstatetime == 0)
		{
            if(LockState == Unlocked)
            {
                lockcnt = 0;
				if((DTCstate[DTC9083] & DTCconfirmed)==0)
				{
					//DTCstate[DTC9083] |= DTCconfirmed;
					Weeprommain((unsigned long)(&DTCstate[DTC9083]),DTCstate[DTC9083] | DTCconfirmed);
				}	
			}
			else
			{
                if(lockcnt < 12)lockcnt++;
				if(lockcnt > 10)
				{
					if((DTCstate[DTC9083] & DTCconfirmed)!=0)
					{
						//DTCstate[DTC9083] &= ~DTCconfirmed;
						Weeprommain((unsigned long)(&DTCstate[DTC9083]),DTCstate[DTC9083] & (~DTCconfirmed));
					}
				}
			}
		}
	 }
}

void UDSDTC9011(void)
{
     static unsigned char lockcnt;
	 static unsigned char dtccnt1,dtccnt2;
     if(LockState == Locked)
     {
         if(lockcnt < DTC48MS) lockcnt++;
		 else if(lockcnt == DTC48MS)
		 {
		 	 lockcnt++;
			 if(DoorState & DriverDoorIsOpen)
	         {  
	             dtccnt2 = 0;
	            //cycle
		        if((DTCstate[DTC9011] & DTCcycleFail)==0)
		        {
		         	//DTCstate[DTC9011] |=DTCcycleFail;
					Weeprommain((unsigned long)(&DTCstate[DTC9011]),DTCstate[DTC9011] | DTCcycleFail);
		        }
				//dtc
				
				if(dtccnt1 < 10) dtccnt1++;
				else
				{
			        if((DTCstate[DTC9011] & DTCconfirmed)==0)
			        {
			         	//DTCstate[DTC9011] |=DTCconfirmed;
						Weeprommain((unsigned long)(&DTCstate[DTC9011]),DTCstate[DTC9011] | DTCconfirmed);
			        }
				}
			 }
			 else
			 {
			    dtccnt1 = 0;
				//cycle
		        if((DTCstate[DTC9011] & DTCcycleFail)!=0)
		        {
		         	//DTCstate[DTC9011] &= ~DTCcycleFail;
					Weeprommain((unsigned long)(&DTCstate[DTC9011]),DTCstate[DTC9011] & (~DTCcycleFail));
		        }
				//dtc
				if(dtccnt2 < 10) dtccnt2++;
				else
				{
			        if((DTCstate[DTC9011] & DTCconfirmed)!=0)
			        {
			         	//DTCstate[DTC9011] &=~DTCconfirmed;
						Weeprommain((unsigned long)(&DTCstate[DTC9011]),DTCstate[DTC9011] & (~DTCconfirmed));
			        }
				}
			 }

		 }

	 }
}
void UDSDTC9023(void)
{
     static unsigned char lockcnt;
	 static unsigned char dtccnt1,dtccnt2;
     if(LockState == Locked)
     {
         if(lockcnt < DTC48MS) lockcnt++;
		 else if(lockcnt == DTC48MS)
		 {
		 	 lockcnt++;
			 if(DoorState & OtherDoorIsOpen)
	         {  
	             dtccnt2 = 0;
	            //cycle
		        if((DTCstate[DTC9023] & DTCcycleFail)==0)
		        {
		         	//DTCstate[DTC9023] |=DTCcycleFail;
					Weeprommain((unsigned long)(&DTCstate[DTC9023]),DTCstate[DTC9023] | DTCcycleFail);
		        }
				//dtc
				
				if(dtccnt1 < 10) dtccnt1++;
				else
				{
			        if((DTCstate[DTC9023] & DTCconfirmed)==0)
			        {
			         	//DTCstate[DTC9023] |=DTCconfirmed;
						Weeprommain((unsigned long)(&DTCstate[DTC9023]),DTCstate[DTC9023] | DTCconfirmed);
			        }
				}
			 }
			 else
			 {
			    dtccnt1 = 0;
				//cycle
		        if((DTCstate[DTC9023] & DTCcycleFail)!=0)
		        {
		         	//DTCstate[DTC9023] &= ~DTCcycleFail;
					Weeprommain((unsigned long)(&DTCstate[DTC9023]),DTCstate[DTC9023] & (~DTCcycleFail));
		        }
				//dtc
				if(dtccnt2 < 10) dtccnt2++;
				else
				{
			        if((DTCstate[DTC9023] & DTCconfirmed)!=0)
			        {
			         	//DTCstate[DTC9023] &=~DTCconfirmed;
						Weeprommain((unsigned long)(&DTCstate[DTC9023]),DTCstate[DTC9023] & (~DTCconfirmed));
			        }
				}
			 }

		 }

	 }
}


void UDSDTC9007(void)
{
     static unsigned char lockcnt;
	 static unsigned char dtccnt1,dtccnt2;
     if(LockState == Locked)
     {
         if(lockcnt < DTC48MS) lockcnt++;
		 else if(lockcnt == DTC48MS)
		 {
		 	 lockcnt++;
			 if(DoorState & FDdoorisopen)
	         {  
	             dtccnt2 = 0;
	            //cycle
		        if((DTCstate[DTC9007] & DTCcycleFail)==0)
		        {
		         	//DTCstate[DTC9007] |=DTCcycleFail;
					Weeprommain((unsigned long)(&DTCstate[DTC9007]),DTCstate[DTC9007] | DTCcycleFail);
		        }
				//dtc
				
				if(dtccnt1 < 10) dtccnt1++;
				else
				{
			        if((DTCstate[DTC9007] & DTCconfirmed)==0)
			        {
			         	//DTCstate[DTC9007] |=DTCconfirmed;
						Weeprommain((unsigned long)(&DTCstate[DTC9007]),DTCstate[DTC9007] | DTCconfirmed);
			        }
				}
			 }
			 else
			 {
			    dtccnt1 = 0;
				//cycle
		        if((DTCstate[DTC9007] & DTCcycleFail)!=0)
		        {
		         	//DTCstate[DTC9007] &= ~DTCcycleFail;
					Weeprommain((unsigned long)(&DTCstate[DTC9007]),DTCstate[DTC9007] & (~DTCcycleFail));
		        }
				//dtc
				if(dtccnt2 < 10) dtccnt2++;
				else
				{
			        if((DTCstate[DTC9007] & DTCconfirmed)!=0)
			        {
			         	//DTCstate[DTC9007] &=~DTCconfirmed;
						Weeprommain((unsigned long)(&DTCstate[DTC9007]),DTCstate[DTC9007] & (~DTCconfirmed));
			        }
				}
			 }

		 }

	 }
}

void UDSDTC9043(void)
{
    static unsigned char turncnt1;
	static unsigned int  turncnt2;
	static unsigned char cnt;
    if((!TURN_LEFT_SW)&&(!TURN_RIGHT_SW))
    {
        turncnt2 = 0;
		if(cnt <DTC48MS) {cnt++;return ;}
        //cycle
        if((DTCstate[DTC9043] & DTCcycleFail)==0)
        {
         	//DTCstate[DTC9043] |=DTCcycleFail;
			Weeprommain((unsigned long)(&DTCstate[DTC9043]),DTCstate[DTC9043] | DTCcycleFail);
        }
		//dtc
		if(turncnt1 < DTC1000MS)turncnt1++;
		else
		{
	        if((DTCstate[DTC9043] & DTCconfirmed)==0)
	        {
	         	//DTCstate[DTC9043] |=DTCconfirmed;
				Weeprommain((unsigned long)(&DTCstate[DTC9043]),DTCstate[DTC9043] | DTCconfirmed);
	        }
		}

	}
	else
	{
	    cnt = 0;
	    turncnt1 = 0;
	    //cycle
        if((DTCstate[DTC9043] & DTCcycleFail)!=0)
        {
         	//DTCstate[DTC9043] |=DTCcycleFail;
			Weeprommain((unsigned long)(&DTCstate[DTC9043]),DTCstate[DTC9043] & (~DTCcycleFail));
        }
		//dtc
		if(turncnt2 < DTC1000MS)turncnt2++;
		else
		{
	        if((DTCstate[DTC9043] & DTCconfirmed)!=0)
	        {
	         	//DTCstate[DTC9043] &=~DTCconfirmed;
				Weeprommain((unsigned long)(&DTCstate[DTC9043]),DTCstate[DTC9043] & (~DTCconfirmed));
	        }
		}		
	}
}
void UDSDTC9093(void)
{
     static unsigned char keyincnt1,keyincnt2,keyincnt3;
     if((KeyInState == KeyIsOutHole)&&(IGNstate == ON))
     {
         if(keyincnt1 < DTC48MS) keyincnt1++;
		 else if(keyincnt1 == DTC48MS )
		 {
            keyincnt1++;
	        if((DTCstate[DTC9093] & DTCconfirmed)==0)
	        {
	         	//DTCstate[DTC9093] |=DTCconfirmed;
				Weeprommain((unsigned long)(&DTCstate[DTC9093]),DTCstate[DTC9093] | DTCconfirmed);
	        }			 //keyincnt2++;
			 
		 }

	 }
	 else if((KeyInState == KeyIsInHole)&&(IGNstate == ON))
	 {
         if(keyincnt2 < DTC48MS) keyincnt2++;
		 else if(keyincnt2 == DTC48MS )
		 {
            keyincnt2++;
			if(keyincnt3 < 10 )keyincnt3++;
			else
			{
		        if((DTCstate[DTC9093] & DTCconfirmed)!=0)
		        {
		         	//DTCstate[DTC9093] &=~DTCconfirmed;
					Weeprommain((unsigned long)(&DTCstate[DTC9093]),DTCstate[DTC9093] & (~DTCconfirmed));
		        }			 //keyincnt2++;
			}
		 }

	 }
	 else
	 {
         keyincnt1 = 0;
		 keyincnt2 = 0;
		 keyincnt3 = 0;
	 }

}

void UDSDTC9061(void)
{
     //预留功能暂时不诊断
}

void UDSDTC9067(void)
{
	//预留功能暂时不诊断
}

void UDSDTC9045(void)
{
    static unsigned int hazardcnt1,hazardcnt2,hazardcnt3;
	
    if(!HAZARD_SW)
    {
		if(hazardcnt1 < DTC1Min)hazardcnt1++;
		if(hazardcnt1 == DTC10000MS)
		{
            hazardcnt2++;
			hazardcnt3 = 0;
	  	    //cycle
	        if((DTCstate[DTC9045] & DTCcycleFail)==0)
	        {
	         	//DTCstate[DTC9045] |=DTCcycleFail;
				Weeprommain((unsigned long)(&DTCstate[DTC9045]),DTCstate[DTC9045] | DTCcycleFail);
	        }
			if(hazardcnt2 > 5)
			{
			    hazardcnt3 = 0;
		  	    //dtc
		        if((DTCstate[DTC9045] & DTCconfirmed)==0)
		        {
		         	//DTCstate[DTC9045] |=DTCconfirmed;
					Weeprommain((unsigned long)(&DTCstate[DTC9045]),DTCstate[DTC9045] | DTCconfirmed);
		        }
			}
		}
		if(hazardcnt1 > (DTC1Min>>1))
		{
		        hazardcnt3 = 0;
		  	    //dtc
		        if((DTCstate[DTC9045] & DTCconfirmed)==0)
		        {
		         	//DTCstate[DTC9045] |=DTCconfirmed;
					Weeprommain((unsigned long)(&DTCstate[DTC9045]),DTCstate[DTC9045] | DTCconfirmed);
		        }
		}
	}
	else
	{
		if((hazardcnt1 > 5)&&(hazardcnt1 < DTC10000MS))
		{
            hazardcnt1 = 0;
			hazardcnt2 = 0;
			if((DTCstate[DTC9045] & DTCcycleFail)!=0)
		    {
		        //DTCstate[DTC9045] &=~DTCcycleFail;
				Weeprommain((unsigned long)(&DTCstate[DTC9045]),DTCstate[DTC9045] & (~DTCcycleFail));
		    }
			//clear dtc
			if(hazardcnt3 > 10)hazardcnt3++;
			else
			{
				if((DTCstate[DTC9045] & DTCconfirmed)!=0)
		        {
		         	//DTCstate[DTC9045] &=~DTCconfirmed;
					Weeprommain((unsigned long)(&DTCstate[DTC9045]),DTCstate[DTC9045] & (~DTCconfirmed));
		        }
			}
		}
	}
}

void UDSDTC9073(void)
{
   unsigned int lockadva;
   static unsigned int lockadcnt1,lockadcnt2;
   
   lockadva = GetADCresultAverage(0);
   if(lockadva < 100)
   {
		if(lockadcnt1 < DTC10000MS) lockadcnt1++;
		else
		{
	  	    //dtc
	        if((DTCstate[DTC9073] & DTCconfirmed)==0)
	        {
	         	//DTCstate[DTC9073] |=DTCconfirmed;
				Weeprommain((unsigned long)(&DTCstate[DTC9073]),DTCstate[DTC9073] | DTCconfirmed);
	        }

		}
   }
   else
   {
        if(lockadcnt2 < DTC48MS)lockadcnt2++;
		else
		{
	        //dtc
	        if((DTCstate[DTC9073] & DTCconfirmed)!=0)
	        {
	         	//DTCstate[DTC9073] &=~DTCconfirmed;
				Weeprommain((unsigned long)(&DTCstate[DTC9073]),DTCstate[DTC9073] & (~DTCconfirmed));
	        }

		}

   }

   
}


void UDSDTC900c(void)
{
    //功能预留暂时未诊断
}


void UDSDTCd001(void)
{
    static unsigned int BCMcantime=DTC10000MS,BCMcantime1=DTC1000MS;
    if(IGNstate != ON) return;
    if((DTC_ABS_ID)||(DTC_EMS_ID1)||(DTC_EMS_ID2)||(DTC_SRS_ID)||(DTC_TCU_ID))
    {
		if(DTC_ABS_ID)DTC_ABS_ID--;
		if(DTC_EMS_ID1)DTC_EMS_ID1--;
		if(DTC_EMS_ID2)DTC_EMS_ID2--;
		if(DTC_SRS_ID)DTC_SRS_ID --;
		if(DTC_TCU_ID)DTC_TCU_ID --;
		BCMcantime = DTC10000MS;		
    }
	//else
	//{
		//BCMcantime1 = DTC1000MS;
	//}
	
    if(BCMcantime != 0)
	{
		BCMcantime--;
		if(BCMcantime < 5)
		{
			//FLASH_ProgramByte((unsigned long)(&DTCstate[DTCD001]), DTCconfirmed);
			Weeprommain((unsigned long)(&DTCstate[DTCD001]),DTCconfirmed);
			
		}
    }
	if(BCMcantime1 != 0)
	{
		BCMcantime1--;
		if(BCMcantime1 < 5)
		{
			 Weeprommain((unsigned long)(&DTCstate[DTCD001]),0x00);
		}
	}
   
	

}

void UDSDTCd002(void)
{
    static unsigned char dtcTIME;
	static unsigned char dtcON;

	if(dtcTIME < DTC1000MS)dtcTIME++;
    if((DTC_EMS_ID1)||(DTC_EMS_ID2))
    {
		//if(DTC_EMS_ID1)DTC_EMS_ID1--;
		//if(DTC_TCU_ID)DTC_TCU_ID--;
		dtcTIME = 0;
		//cycle
        if((DTCstate[DTCD002] & DTCcycleFail)!=0)
        {
         	//DTCstate[DTCD002] &= ~DTCcycleFail;
			Weeprommain((unsigned long)(&DTCstate[DTCD002]),DTCstate[DTCD002] & (~DTCcycleFail));
        }
		if(dtcON < 10)dtcON++;
		else
		{
	  	    //cycle
	        if((DTCstate[DTCD002] & DTCconfirmed)!=0)
	        {
	         	//DTCstate[DTCD002] &= ~DTCconfirmed;
				Weeprommain((unsigned long)(&DTCstate[DTCD002]),DTCstate[DTCD002] & (~DTCconfirmed));
	        }
		}
	}

    if(dtcTIME > DTC96MS)
    {
        dtcON = 0;
  	    //cycle
        if((DTCstate[DTCD002] & DTCcycleFail)==0)
        {
         	//DTCstate[DTCD002] |=DTCcycleFail;
			Weeprommain((unsigned long)(&DTCstate[DTCD002]),DTCstate[DTCD002] | DTCcycleFail);
        }
	}
	if(dtcTIME >= DTC1000MS)
	{ 
	    dtcON = 0;
  	    //cycle
        if((DTCstate[DTCD002] & DTCconfirmed)==0)
        {
         	//DTCstate[DTCD002] |=DTCconfirmed;
			Weeprommain((unsigned long)(&DTCstate[DTCD002]),DTCstate[DTCD002] | DTCconfirmed);
        }
	}

}

void UDSDTCd003(void)
{
    static unsigned char dtcTIME;
	static unsigned char dtcON;

	if(dtcTIME < DTC1000MS)dtcTIME++;
    if(DTC_TCU_ID)
    {
		//DTC_EMS_ID1 = 0;
		//DTC_TCU_ID = 0;
		dtcTIME = 0;
		//cycle
        if((DTCstate[DTCD003] & DTCcycleFail)!=0)
        {
         	//DTCstate[DTCD003] &= ~DTCcycleFail;
			//Weeprommain((unsigned long)(&DTCstate[DTCD003]),DTCstate[DTCD003] & (~DTCcycleFail));
        }
		if(dtcON < 10)dtcON++;
		else
		{
	  	    //cycle
	        if((DTCstate[DTCD003] & DTCconfirmed)!=0)
	        {
	         	//DTCstate[DTCD003] &= ~DTCconfirmed;
			//Weeprommain((unsigned long)(&DTCstate[DTCD003]),DTCstate[DTCD003] & (~DTCconfirmed));
	        }
		}
	}

    if(dtcTIME > DTC96MS)
    {
        dtcON = 0;
  	    //cycle
        if((DTCstate[DTCD003] & DTCcycleFail)==0)
        {
         	       //DTCstate[DTCD003] |=DTCcycleFail;
			//Weeprommain((unsigned long)(&DTCstate[DTCD003]),DTCstate[DTCD003] | DTCcycleFail);
        }
	}
	if(dtcTIME >= DTC1000MS)
	{ 
	    dtcON = 0;
  	    //cycle
        if((DTCstate[DTCD003] & DTCconfirmed)==0)
        {
         	       //DTCstate[DTCD003] |=DTCconfirmed;
			//Weeprommain((unsigned long)(&DTCstate[DTCD003]),DTCstate[DTCD003] | DTCconfirmed);
        }
	}

}

void UDSDTCd004(void)
{
    static unsigned char dtcTIME;
	static unsigned char dtcON;

	if(dtcTIME < DTC1000MS)dtcTIME++;
    if(DTC_ABS_ID)
    {
		//DTC_EMS_ID1 = 0;
		//DTC_TCU_ID = 0;
		dtcTIME = 0;
		//cycle
        if((DTCstate[DTCD004] & DTCcycleFail)!=0)
        {
         	//DTCstate[DTCD004] &= ~DTCcycleFail;
			//Weeprommain((unsigned long)(&DTCstate[DTCD004]),DTCstate[DTCD004] & (~DTCcycleFail));
        }
		if(dtcON < 10)dtcON++;
		else
		{
	  	    //cycle
	        if((DTCstate[DTCD004] & DTCconfirmed)!=0)
	        {
	         	//DTCstate[DTCD004] &= ~DTCconfirmed;
				//Weeprommain((unsigned long)(&DTCstate[DTCD004]),DTCstate[DTCD004] & (~DTCconfirmed));
	        }
		}
	}

    if(dtcTIME > DTC96MS)
    {
        dtcON = 0;
  	    //cycle
        if((DTCstate[DTCD004] & DTCcycleFail)==0)
        {
         	//DTCstate[DTCD004] |=DTCcycleFail;
			//Weeprommain((unsigned long)(&DTCstate[DTCD004]),DTCstate[DTCD004] | DTCcycleFail);
        }
	}
	if(dtcTIME >=DTC1000MS)
	{ 
	    dtcON = 0;
  	    //cycle
        if((DTCstate[DTCD004] & DTCconfirmed)==0)
        {
         	//DTCstate[DTCD004] |=DTCconfirmed;
			//Weeprommain((unsigned long)(&DTCstate[DTCD004]),DTCstate[DTCD004] | DTCconfirmed);
        }
	}

}

void UDSDTCd005(void)
{
    static unsigned char dtcTIME;
	static unsigned char dtcON;

	if(dtcTIME < DTC1000MS)dtcTIME++;
    if(DTC_SRS_ID)
    {
		//DTC_EMS_ID1 = 0;
		//DTC_TCU_ID = 0;
		dtcTIME = 0;
		//cycle
        if((DTCstate[DTCD005] & DTCcycleFail)!=0)
        {
         	//DTCstate[DTCD005] &= ~DTCcycleFail;
		//	Weeprommain((unsigned long)(&DTCstate[DTCD005]),DTCstate[DTCD005] & (~DTCcycleFail));
        }
		if(dtcON < 10)dtcON++;
		else
		{
	  	    //cycle
	        if((DTCstate[DTCD005] & DTCconfirmed)!=0)
	        {
	         	//DTCstate[DTCD005] &= ~DTCconfirmed;
			//	Weeprommain((unsigned long)(&DTCstate[DTCD005]),DTCstate[DTCD005] & (~DTCconfirmed));
	        }
		}
	}

    if(dtcTIME > DTC96MS)
    {
        dtcON = 0;
  	    //cycle
        if((DTCstate[DTCD005] & DTCcycleFail)==0)
        {
         	//DTCstate[DTCD005] |=DTCcycleFail;
		//	Weeprommain((unsigned long)(&DTCstate[DTCD005]),DTCstate[DTCD005] | DTCcycleFail);
        }
	}
	if(dtcTIME >= DTC1000MS)
	{ 
	    dtcON = 0;
  	    //cycle
        if((DTCstate[DTCD005] & DTCconfirmed)==0)
        {
         	//DTCstate[DTCD005] |=DTCconfirmed;
		//	Weeprommain((unsigned long)(&DTCstate[DTCD005]),DTCstate[DTCD005] | DTCconfirmed);
        }
	}

}




