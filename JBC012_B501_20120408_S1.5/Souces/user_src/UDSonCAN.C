//UDS on CAN NET 
#include "udsoncan.h"
#include "can.h"
//#include "lock_drv.h"
//#include "stm8_wwdg.h"
//#include "main.h"
/////
//#include "stm8_map.h"
//#include "can.h"
//#include "turnlamp_drv.h"
//#include "lock_drv.h"
//#include "rke_drv.h"
//#include "beam_drv.h"
//#include "defrost_drv.h"
//#include "warm_drv.h"
//#include "gpio_macro.h"
//#include "horn_drv.h"
//#include "wiper_drv.h"
//#include "main.h"
//#include "window_drv.h"
//#include "domelamp_drv.h"
//#include "lin.h"
//#include "stm8_flash.h"

//#include "LevelOneKeyArith.h"
//#include "share.h"
//#include "stm8_lib.h"
//#include "warm_drv.h"

extern void WWDG_Refresh( u8 CounterValue );
extern uchar   speedlockset;
//uchar speedlockstate=0;

//eeprom
uu8     DIDF18bEEPROM[4]                 @0x4100; 
uu8     DIDF19dEEPROM[4]                 @0x4104; 
uu8     DIDF1f2EEPROM[2]                 @0x4108; 
uu8     DIDF1f3EEPROM[2]                 @0x410a; 
uu8     DIDF18cEEPROM[7]                 @0x410c; 
uu8     DIDF190EEPROM[17]                @0x4113; 
uu8     DIDF1F4EEPROM[2]                   @0x4125;

uu8     DTCstate[DTCLong]                     @0x4150;

//诊断网络层协议
extern void CAN_send2(u16 ID,u8 dlc,u8 data0,u8 data1,u8 data2,u8 data3,u8 data4,u8 data5,u8 data6,u8 data7);
extern unsigned int EnalbeLearnRkeTime20s;
extern void INITrkenumber(void);
//extern ulong f_RKE_SerialNum[KEY_COUNT];
extern uchar RKEnumberRead(void);
extern unsigned char Weeprommain(unsigned long temp,unsigned char value);
//extern FLASH_Status_Typedef FLASH_ProgramByte(u32 Address, u8 Data);

//与应用层接口变量
// 1 未确认分段数据传输数据
UDSData N_UDSDdata;
// 2 未确认分段数据传输的第一帧服务
USData_FF N_UDSDdata_FF;
// 3 更改网络层参数服务
ChangeParameter N_ChangeParameter;
//PDU
PDU N_PDU[20];
PDU R_PDU[20];
DTCName DTCNameN[DTCLong];

//单帧
unsigned char SF_FS;//N_PDU.PCI的低4位
unsigned int  FF_DL;
unsigned char CF_SN;
unsigned char TYPE;//N_PDU.PCI的高4位
unsigned char N_Result;
//报文帧格式
#define SF 0x00    //单帧
#define FF 0x10    //多帧
#define CF 0x20    //连续帧
#define FC 0x30    //流控制
//TIME
unsigned char STmin; //>20MS
unsigned char BS;    //8
unsigned char N_ASAR;  //MAX 70 MS
unsigned int  N_BS;    //MAX 150 MS
unsigned char N_Br;    //<70ms
unsigned char N_CS;	   //<70MS
unsigned char N_CR;    //MAX 150 MS
//缓冲区
//Receive data
PDU RecData[Reclong];
unsigned char UDSRITcnt;
unsigned char UDSRuscnt;

//////dtc commation
unsigned char DTC_SRS_ID;
unsigned char DTC_ABS_ID;
unsigned char DTC_TCU_ID;
unsigned char DTC_EMS_ID1;
unsigned char DTC_EMS_ID2;
///////
unsigned char BCMvseed[4];
unsigned char BCMkey[4];
unsigned char  AppKeyConst[NUM_LEVEL_ONE_CONST];
//send data
unsigned int sjs;
//key
unsigned char keyerror1,keyerror2;
unsigned int  keyerrorclosetime;
// 3e
unsigned int time3e;


//com
void UDSonCAN_netmain(void)
{
   unsigned char reccnt;
   static unsigned char CFcnt=0,qonestate;
   static unsigned int	Toalcfcnt=0,Toalsendcnt=0,Toalsenddata;
   static unsigned char Timecnt;
   static unsigned int Recfftoal,RECtoalcnt,RECcntk;
   static unsigned char commcontrl = 0;
   static unsigned char buzystate = 0;
   static unsigned char state;
   static unsigned char duostate,CFRstate;
   unsigned char hz;
   static unsigned char NBSstate;
   if(N_BS)
   {  
         N_BS--;
	  if(N_BS == 0)
	  {
	  	N_UDSDdata.Request = 0;
         	qonestate == 0;
	       CFRstate =0;
	  }
   }
   //send 
   if(N_UDSDdata.Request != 0)
   {
       switch(N_UDSDdata.Request )
       {
           case RequestsendSF://单帧发送  发送条件N_UDSDdata.Request = RequestsendSF;
		    {
				NBSstate = 0;
                        CAN_send2(TesterBCM,8,N_PDU[0].PCI,N_PDU[0].Data[0],N_PDU[0].Data[1],N_PDU[0].Data[2],N_PDU[0].Data[3],N_PDU[0].Data[4],N_PDU[0].Data[5],N_PDU[0].Data[6]);
			   N_UDSDdata.Request = 0;
			   qonestate == 0;
			   N_UDSDdata.Confirmation = ConfirmationOK;
			   ClearNPDUbuff();
		    }
		   	break;
		   case RequestsendFF://多帧第一帧发送 发送条件 UDSDdata.Request = RequestsendFF;
		   	{
			   NBSstate = 0;
			   if(qonestate != 0) {N_UDSDdata.Request = 0;break;}
                        CAN_send2(TesterBCM,8,N_PDU[0].PCI,N_PDU[0].Data[0],N_PDU[0].Data[1],N_PDU[0].Data[2],N_PDU[0].Data[3],N_PDU[0].Data[4],N_PDU[0].Data[5],N_PDU[0].Data[6]);
			   //N_UDSDdata.Request = 0;
			   qonestate = 0x55;
			   CFRstate = 1;//add  send dd
			   Toalsendcnt = N_PDU[0].PCI & 0x0f;
			   Toalsendcnt =(Toalsendcnt<< 8)+N_PDU[0].Data[0];
			   Toalsenddata = 6;
			   Toalcfcnt = 1;
			   N_UDSDdata.Request = 0;
			   commcontrl = 1;
			   CFcnt = 0;
			   N_BS = 75; //150ms
			   //SF_FS = 1;
			   //N_UDSDdata.Confirmation = ConfirmationOK;
		    }
		   	break;
		   case RequestsendCF:  //多帧发送 本标志自动设置   
		   	{   
			   
               switch(SF_FS)
               {
                  case 0:
                                   NBSstate = 0;
				  	Timecnt = Timecnt + 2;
				  	if(Timecnt > (STmin+10))
				  	{
				  	       if(qonestate == 0)
					       {
					            N_UDSDdata.Request = 0; 
						    break;
						}
				  	    Timecnt = 0;
					  	CAN_send2(TesterBCM,8,(CF|(CFcnt&0x0f))+1,N_PDU[Toalcfcnt].Data[0],N_PDU[Toalcfcnt].Data[1],N_PDU[Toalcfcnt].Data[2],N_PDU[Toalcfcnt].Data[3],N_PDU[Toalcfcnt].Data[4],N_PDU[Toalcfcnt].Data[5],N_PDU[Toalcfcnt].Data[6]);
						if(Toalcfcnt < 20)Toalcfcnt++;
						else
						{
							N_UDSDdata.Confirmation = ConfirmationER;
							commcontrl = 0;
							N_UDSDdata.Request = 0;
							qonestate = 0;
							duostate = 0;
							CFRstate=0;
						}
						Toalsenddata =Toalsenddata+7;
						CFcnt++;
						if(((CFcnt % BS )== 0)&&(BS!=0))
						{
	                                      //CFcnt = 0 ;
						   SF_FS = 1;
						}
						if(Toalsenddata >= Toalsendcnt)
						{
							N_UDSDdata.Confirmation = ConfirmationOK;
							duostate = 0;
							commcontrl = 0;
							N_UDSDdata.Request = 0;
							CFRstate = 0;
							TYPE = 0;
						       Toalsendcnt = 0;
						       Toalsenddata = 0;
						       Toalcfcnt = 0;
							CFcnt = 0; 
							qonestate = 0;
							ClearNPDUbuff();
						}
				  	}
				  break;
				  case 1:
				  	//wait sf_fs==0 countion
				  	SF_FS = 1;
					if(NBSstate == 0){N_BS = 75; NBSstate = 0x55;} //150ms
				  break;
				  case 2:
				  	   NBSstate = 0;
				  	   N_Result = ConfirmationOverflow;
					   N_BS = 0;
					   N_UDSDdata.Request = 0;
					   commcontrl = 0;
					   qonestate = 0;
					   Toalsendcnt = 0;
					   Toalsenddata = 0;
					   Toalcfcnt = 0;
					   CFcnt = 0;
					   CFRstate =0;
					
				  break;
				  default:break;
				  	
			   }
		    }
		   	break;
		   case RequestsendFC:
		   	
		   	   if(Recfftoal > RecMaxlong)
		   	   {
					N_Result = ConfirmationOverflow;
			              CAN_send2(TesterBCM,8,0X32,0X10,0X15,0,0,0,0,0);
		          }   
			   else if(N_UDSDdata.Indication != 0)  //数据未处理
			   {
					CAN_send2(TesterBCM,8,0X31,0X10,0X15,0,0,0,0,0);
					N_BS = 75; //150ms
			   }
			   else
			   {
					CAN_send2(TesterBCM,8,0X30,0X10,0X15,0,0,0,0,0);
					N_BS = 75; //150ms
					duostate=1;
					
			   }
			  
			   N_UDSDdata.Request =0;
		   	break;
		   default:break;
	   }

   }
   //Receive

//if(UDSRuscnt >= Reclong) UDSRuscnt = 0;
   if(UDSRITcnt != UDSRuscnt)
   {
   	UDSRuscnt++;
       if(UDSRuscnt >= Reclong) UDSRuscnt = 0;

       if(RecData[UDSRuscnt].AI != TesterID) {RecData[UDSRuscnt].AI = 0;return;}
	   RecData[UDSRuscnt].AI = 0;

	   
	   
	   TYPE = RecData[UDSRuscnt].PCI & 0xF0;

	   if((CFRstate ==1) &&(TYPE != FC))return;   //多帧发送过程中接收到单帧命令不响应
	   
       switch(TYPE)
       {
           case SF: //单帧接收成功
                        qonestate = 0;
			   state = 0;
		   	   R_PDU[0].AI  = RecData[UDSRuscnt].AI;
			   //RecData[reccnt].AI = 0;
		   	   R_PDU[0].PCI = RecData[UDSRuscnt].PCI;
			   R_PDU[0].Data[0]= RecData[UDSRuscnt].Data[0];
			   R_PDU[0].Data[1]= RecData[UDSRuscnt].Data[1];
			   R_PDU[0].Data[2]= RecData[UDSRuscnt].Data[2];
			   R_PDU[0].Data[3]= RecData[UDSRuscnt].Data[3];
			   R_PDU[0].Data[4]= RecData[UDSRuscnt].Data[4];
			   R_PDU[0].Data[5]= RecData[UDSRuscnt].Data[5];
			   R_PDU[0].Data[6]= RecData[UDSRuscnt].Data[6];
	   			RecData[UDSRuscnt].PCI=0;
			 	RecData[UDSRuscnt].Data[0]=0;
			 	RecData[UDSRuscnt].Data[1]=0;
			 	RecData[UDSRuscnt].Data[2]=0;
			 	RecData[UDSRuscnt].Data[3]=0;
			 	RecData[UDSRuscnt].Data[4]=0;
			 	RecData[UDSRuscnt].Data[5]=0;
			 	RecData[UDSRuscnt].Data[6]=0;
			  //if(N_UDSDdata.Request ==RequestsendCF ) {N_UDSDdata.Indication = 0;return;}
			  if(( R_PDU[0].PCI == 0)||(R_PDU[0].PCI > 7))N_UDSDdata.Indication = 0;
			  //else if(CFRstate == 1)N_UDSDdata.Indication = 0;
			  else
			  {
			   
		   	         N_UDSDdata.Indication =IndicationOK1;
			  }
			  //if(duostate !=0) N_UDSDdata.Indication = 0;
		   break;
		   case FF: //第一帧数据接收
		       qonestate = 0;
                      Recfftoal = RecData[UDSRuscnt].PCI & 0x0f;
			   Recfftoal = (Recfftoal<<8) + RecData[UDSRuscnt].Data[0];
			   R_PDU[hz].AI  = RecData[UDSRuscnt].AI;
			   //RecData[reccnt].AI = 0;
		   	   R_PDU[0].PCI = RecData[UDSRuscnt].PCI;
			   R_PDU[0].Data[0]= RecData[UDSRuscnt].Data[0];
			   R_PDU[0].Data[1]= RecData[UDSRuscnt].Data[1];
			   R_PDU[0].Data[2]= RecData[UDSRuscnt].Data[2];
			   R_PDU[0].Data[3]= RecData[UDSRuscnt].Data[3];
			   R_PDU[0].Data[4]= RecData[UDSRuscnt].Data[4];
			   R_PDU[0].Data[5]= RecData[UDSRuscnt].Data[5];
			   R_PDU[0].Data[6]= RecData[UDSRuscnt].Data[6];
			       RecData[UDSRuscnt].PCI=0;
			 	RecData[UDSRuscnt].Data[0]=0;
			 	RecData[UDSRuscnt].Data[1]=0;
			 	RecData[UDSRuscnt].Data[2]=0;
			 	RecData[UDSRuscnt].Data[3]=0;
			 	RecData[UDSRuscnt].Data[4]=0;
			 	RecData[UDSRuscnt].Data[5]=0;
			 	RecData[UDSRuscnt].Data[6]=0;
			   if(((R_PDU[0].PCI&0x0f)!=0)||(((R_PDU[0].PCI&0x0f)==0)&&(R_PDU[0].Data[0] >= 8)))
			   {
			       N_UDSDdata.Request = RequestsendFC;
			       RECcntk = 1;
			       RECtoalcnt = 7 ;
			   }
			   else
			   {
			       N_UDSDdata.Request = 0;
				RECcntk = 0;
			       RECtoalcnt = 0 ;
			   }

			   state = 0;
			
		   break;
		   case CF: //多帧数据接收
                       if((RecData[UDSRuscnt].PCI & 0x80)!= 0)break;
			  if(N_BS == 0){CFRstate = 0;break;}
			   R_PDU[RECcntk].AI  = RecData[UDSRuscnt].AI;
			   //RecData[reccnt].AI = 0;
		   	   R_PDU[RECcntk].PCI = RecData[UDSRuscnt].PCI;
			   R_PDU[RECcntk].Data[0]= RecData[UDSRuscnt].Data[0];
			   R_PDU[RECcntk].Data[1]= RecData[UDSRuscnt].Data[1];
			   R_PDU[RECcntk].Data[2]= RecData[UDSRuscnt].Data[2];
			   R_PDU[RECcntk].Data[3]= RecData[UDSRuscnt].Data[3];
			   R_PDU[RECcntk].Data[4]= RecData[UDSRuscnt].Data[4];
			   R_PDU[RECcntk].Data[5]= RecData[UDSRuscnt].Data[5];
			   R_PDU[RECcntk].Data[6]= RecData[UDSRuscnt].Data[6];

			   	RecData[UDSRuscnt].PCI=0;
			 	RecData[UDSRuscnt].Data[0]=0;
			 	RecData[UDSRuscnt].Data[1]=0;
			 	RecData[UDSRuscnt].Data[2]=0;
			 	RecData[UDSRuscnt].Data[3]=0;
			 	RecData[UDSRuscnt].Data[4]=0;
			 	RecData[UDSRuscnt].Data[5]=0;
			 	RecData[UDSRuscnt].Data[6]=0;
			   if(RECcntk == 1)
			   {                                
			           if(R_PDU[RECcntk].PCI!=0x21)state=1;
			   }
			   else
			   {
				    if((R_PDU[RECcntk].PCI-R_PDU[RECcntk-1].PCI)!=1)state=1;      //帧不连续 
			   }
			   RECcntk++;
			   RECtoalcnt = RECtoalcnt + 7; 
                       if(RECtoalcnt > Recfftoal)
                       {
                               if(state !=1 ) N_UDSDdata.Indication =IndicationOKm;//ok
                               else  N_UDSDdata.Indication=0;
                               Recfftoal = 0;
				   RECtoalcnt=0;
				   RECcntk = 0;
                   
			   }
			   if(RECcntk >= 0x10)
			   {  
			       RECcntk =0;
			       N_UDSDdata.Request = RequestsendFC;
			   }
		   break;
		   case FC:  //流控制数据
		   {
		   	   if(N_BS==0)
			   {
			           CFRstate=0;
				    //N_UDSDdata.Request =0;
				    break; 
			   }//超时150ms
                        SF_FS = RecData[UDSRuscnt].PCI & 0x0f;
			   BS = RecData[UDSRuscnt].Data[0];
			   STmin = RecData[UDSRuscnt].Data[1];
                        if(commcontrl != 0)N_UDSDdata.Request = RequestsendCF;

			   	RecData[UDSRuscnt].PCI=0;
			 	RecData[UDSRuscnt].Data[0]=0;
			 	RecData[UDSRuscnt].Data[1]=0;
			 	RecData[UDSRuscnt].Data[2]=0;
			 	RecData[UDSRuscnt].Data[3]=0;
			 	RecData[UDSRuscnt].Data[4]=0;
			 	RecData[UDSRuscnt].Data[5]=0;
			 	RecData[UDSRuscnt].Data[6]=0;
			   //RecData[reccnt].AI = 0;
			   
		   }
		   break;
		   default:break;
	   }


   }


}



////////////////////////////////////////////////////
//N_UDSDdata.Request  send data           
//N_UDSDdata.Indication RX 
////////////////////////////////////////////////////
//time cnt
unsigned char P2CAN_Server;
unsigned int  P2CAN_Server1;
unsigned int  S3Server;
//SID  10 
unsigned char SystemMode;   //系统诊断模式
unsigned char SalfeMode;    //系统安全模式
unsigned char DTCRuningstate=0;   //DTC诊断运行允许标志
unsigned char CommControl=0;  //非诊断报文通讯控制
unsigned char KEYleanstate;  //钥匙学习例程启动停止标志


void UDSonCANDiag(void)
{
     unsigned char ErrorCode = 0;
	 unsigned char Readcom;
     //密钥次数超限禁止10秒安全访问
     if(keyerrorclosetime != 0 )
	 {
	 	keyerrorclosetime--;
		if(keyerrorclosetime == 0)
		{
			keyerror1 = 0;
			keyerror2 = 0;
		}
     }
	 ////
	 if( time3e != 0)
	 {
	    time3e--;
		if(time3e == 0)
		{
			SystemMode = defaSession;
			SalfeMode = 0;
		}
	 }
	 	
     if(N_UDSDdata.Indication == ConfirmationER)
     {

	 }
	 if(N_UDSDdata.Indication == ConfirmationOverflow)
	 {

	 }
     if((N_UDSDdata.Indication != IndicationOK1)&&(N_UDSDdata.Indication != IndicationOKm))return;

	 if((R_PDU[0].PCI == 0x07)&&(R_PDU[0].Data[0]== 0xff)&&(R_PDU[0].Data[1]==0x58)&&(R_PDU[0].Data[2]==0x41))
	 {
	        
    		//ReadDidvalue(0xf1f2,Didwrite);
    		//INITrkenumber();
    		//EnalbeLearnRkeTime20s = 1250 ;
			UDSsendone(0x03,0x95,DIDF1f3EEPROM[0],DIDF1f3EEPROM[1],0,0,0,0);	
			N_UDSDdata.Indication = 0;
			return;
	 }

	 if((R_PDU[0].PCI & 0xf0)==0x10)
	 {
		Readcom = R_PDU[0].Data[1];
	 }
	 else
	 {
		Readcom = R_PDU[0].Data[0];
	 }
	 
     if((Readcom > 0x10)&&(Readcom < 0x40))time3e = time3etime; //shujulianjie 
	 
     switch(Readcom)
     {
		case SID10:
		{   
			//ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
                      ErrorCode = UDSDiag10(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
                     R_PDU[0].Data[0] = 0;
			//if((R_PDU[0].Data[1] != 0x01)&&(R_PDU[0].Data[1]!= 0x03)) ErrorCode = NCR12;
			if(ErrorCode != 0)
                    {
                             UDSsendone(0x03,ErRequst,SID10,ErrorCode,0,0,0,0);
			}
			else
			{
                              UDSsendone(0x06,SID10+0x40,R_PDU[0].Data[1],0x00,0x32,0x13,0x88,0x00);  //时间参数默认
			}
			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		case SID11:
		{
			//ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
			ErrorCode = NCR11;
 			UDSsendone(0x03,ErRequst,SID11,ErrorCode,0,0,0,0);
			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		case SID14:
		{
			//ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
			//if(SystemMode != exDiagSession)return NCR7f;
			
                     if(R_PDU[0].PCI != 0x04) ErrorCode = NCR13;  //add diag error long 
                     else
                     {
			       if((R_PDU[0].Data[1]==0xff)&&(R_PDU[0].Data[2]==0xff)&&(R_PDU[0].Data[3]==0xff))
				{
					ErrorCode = UDSclearDTC();
				}
				else
				{
					ErrorCode = NCR12;
				}
                     }
			if(ErrorCode != 0)
			{
 				UDSsendone(0x03,ErRequst,SID14,ErrorCode,0,0,0,0);
			}
			else
			{
				UDSsendone(0x01,SID14+0x40,0,0,0,0,0,0);
			}
			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		case SID19:
		{
			//ClearNPDUbuff();
			ErrorCode = UDSDiag19(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
			//ErrorCode = NCR12;
			if(ErrorCode != 0)
			{
 				UDSsendone(0x03,ErRequst,SID19,ErrorCode,0,0,0,0);
			}
			N_UDSDdata.Indication = 0;
			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		case SID22:
		{			
			//ClearNPDUbuff();
			ErrorCode = UDSDiag22(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
            if(ErrorCode != 0)
            {
 				UDSsendone(0x03,ErRequst,SID22,ErrorCode,0,0,0,0);
            }
			ErrorCode = 0;
			N_UDSDdata.Indication = 0;
			ClearRPDUbuff();
		}break;
		case SID23:
		{
			ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
			ErrorCode = NCR11;
 			UDSsendone(0x03,ErRequst,SID23,ErrorCode,0,0,0,0);
			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		case SID27:
		{
			//ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
			ErrorCode = UDSDiag27(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
			
			if(ErrorCode !=0)//ErrorCode = NCR12;
			{
 				UDSsendone(0x03,ErRequst,SID27,ErrorCode,0,0,0,0);
			}
			ErrorCode = 0;
			N_UDSDdata.Indication = 0;
			ClearRPDUbuff();
		}break;
		case SID28:
		{
			//ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
			ErrorCode = UDSDiag28(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
            if(ErrorCode != 0)
            {
 				UDSsendone(0x03,ErRequst,SID28,ErrorCode,0,0,0,0);
            }
			else
			{
				UDSsendone(0x03,SID28+0x40,R_PDU[0].Data[1],0,0,0,0,0);
			}
			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		case SID2a:
		{
			ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
			ErrorCode = NCR11;
 			UDSsendone(0x03,ErRequst,SID2a,ErrorCode,0,0,0,0);
			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		case SID2e:   //每次只允许写1个DID数据
		{		
			//ClearNPDUbuff();
			ErrorCode = 0;
			ErrorCode = UDSDiag2e(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
			if(ErrorCode !=0)
			{
				UDSsendone(0x03,ErRequst,SID2e,ErrorCode,0,0,0,0);
			}
			else
			{
			    if((R_PDU[0].PCI & 0xf0)==0x10)
			    {
					UDSsendone(0x03,SID2e+0x40,R_PDU[0].Data[2],R_PDU[0].Data[3],0,0,0,0);
			    }
				else
				{
					UDSsendone(0x03,SID2e+0x40,R_PDU[0].Data[1],R_PDU[0].Data[2],0,0,0,0);
				}
			}
			N_UDSDdata.Indication = 0;
			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		case SID2f:
		{   
			//ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
			ErrorCode = NCR11;
 			UDSsendone(0x03,ErRequst,SID2f,ErrorCode,0,0,0,0);
			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		case SID31://未测试
		{
			//ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
                     if(R_PDU[0].PCI != 4)
                     {
 				UDSsendone(0x03,ErRequst,SID31,NCR13,0,0,0,0);
				ClearRPDUbuff();
				break;
			}
			
			ErrorCode = UDSDiag31(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);

			if(ErrorCode == 1)
			{
				if(EnalbeLearnRkeTime20s != 0)KEYleanstate = 1;
				else KEYleanstate = 2;
				UDSsendone(0x04,SID31+0x40,KEYleanstate,R_PDU[0].Data[2],R_PDU[0].Data[3],0,0,0);//返回例程执行结果 1。表示运行中 2。表示执行完成
			}
			else if(ErrorCode == 0)
			{
				UDSsendone(0x04,SID31+0x40,R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],0,0,0);
			}
			else
			{
 				UDSsendone(0x03,ErRequst,SID31,ErrorCode,0,0,0,0);
			}

			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		case SID34:
		{
			//ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
			ErrorCode = NCR11;
 			UDSsendone(0x03,ErRequst,SID34,ErrorCode,0,0,0,0);
			ErrorCode = 0;
		}break;
		case SID36:
		{
			//ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
			ErrorCode = NCR11;
 			UDSsendone(0x03,ErRequst,SID36,ErrorCode,0,0,0,0);
			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		case SID37:
		{
			//ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
			ErrorCode = NCR11;
 			UDSsendone(0x03,ErRequst,SID37,ErrorCode,0,0,0,0);
			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		case SID3d:
		{
			//ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
			ErrorCode = NCR11;
 			UDSsendone(0x03,ErRequst,SID3d,ErrorCode,0,0,0,0);
			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		case SID3e:
		{
			//ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
            ErrorCode = UDSDiag3e(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
			if(ErrorCode == 0xff)
			{
                             break;  //不需要响应    清除时间参数变量
			}
			else if(ErrorCode == 0)
			{
 				 UDSsendone(0x02,SID3e+0x40,0,0,0,0,0,0);
				 //正确响应    清除时间参数变量
			}
			else
			{
 				UDSsendone(0x03,ErRequst,SID3e,ErrorCode,0,0,0,0);
				//Error
			}
			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		case SID85:
		{
			//ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
			ErrorCode = UDSDiag85(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
            if(ErrorCode != NCRright)
            {
 				UDSsendone(0x03,ErRequst,SID85,ErrorCode,0,0,0,0);
			}
			else
			{

				UDSsendone(0x02,SID85+0x40,R_PDU[0].Data[1],0,0,0,0,0);
			}

			ErrorCode = 0;
			ClearRPDUbuff();
		}break;
		default:
		{
			//ClearNPDUbuff();
			N_UDSDdata.Indication = 0;
			ErrorCode = NCR11;
                     UDSsendone(0x03,ErRequst,R_PDU[0].Data[0],ErrorCode,0,0,0,0);
			
			ClearRPDUbuff();
		}break;

	 }


}


void UDSsendone(uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6,uu8 d7)
{
	 ClearRPDUbuff();
     N_PDU[0].AI = TesterBCM;
	 N_PDU[0].PCI = d0;
	 N_PDU[0].Data[0] = d1;
	 N_PDU[0].Data[1] = d2;
	 N_PDU[0].Data[2] = d3;
	 N_PDU[0].Data[3] = d4;
	 N_PDU[0].Data[4] = d5;
	 N_PDU[0].Data[5] = d6;
	 N_PDU[0].Data[6] = d7;

	 N_UDSDdata.Request = 1; //dan zheng send 

}


unsigned char  UDSDiag10(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
{
    unsigned char Errorvalue=0;

	
	if(pci  != 2){ Errorvalue=NCR13; return Errorvalue;}
	
    switch(d1)
    {
              case defaSession:
		{
			SystemMode = defaSession;
			SalfeMode = Salfe0;
			Errorvalue = NCRright;
		}break;
		/*case progSession:
		{
			SystemMode = defaSession;
			//time3e = time3etime;
			SalfeMode = Salfe0;
			Errorvalue = NCR12;
		}break;*/
		case exDiagSession:
		{   
				SystemMode = exDiagSession;
			       time3e = time3etime;
				Errorvalue = NCRright;

		}break;
		default:
		{
			SystemMode = defaSession;
			SalfeMode = Salfe0;
			Errorvalue = NCR12;
		}break;
	}
    //NCR13
   // if((d1 != 0x01)&&(d1 != 0x03)) return NCR12;
    //if(pci >= 3) Errorvalue = NCR13;
    return Errorvalue;
}




unsigned char UDSDiag3e(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
{
      unsigned char Errorvalue=0;
	if(pci != 2) return NCR13;
	//if(SystemMode != exDiagSession)return NCR7f;
	
	if(d1 == 0x80)
	{
               Errorvalue = 0xff;  //不需要相应
               time3e = time3etime;
	}
	else if(d1 == 0x00)
	{
              Errorvalue = 0;
		time3e = time3etime;
	}
	else
	{
               Errorvalue = NCR12;
	}
	//if(pci != 2) Errorvalue = NCR13;

	return Errorvalue;
}







unsigned char UDSDiag85(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
{
	static unsigned char Errorvalue;
    if(pci != 2) return NCR13;
    if(SystemMode != exDiagSession)return NCR7f;
    //if(SalfeMode < salfe01){ Errorvalue = NCR33;return Errorvalue;}
	switch(d1)
	{
       case 0:
	   {
     		Errorvalue = NCR12 ;
	   }break;
	   case 1:
	   {
	   	    DTCRuningstate = 0;//open  DTC
                  Errorvalue = NCRright;
	   }break;
	   case 2:
	   {
	   	       DTCRuningstate = 1; //Close DTC
			Errorvalue = NCRright;
	   }break;
	   default: Errorvalue = NCR12 ;break;
	}
	//d2--d6 参数未用

	if(pci >= 7)Errorvalue = NCR13;

	return Errorvalue;
}



unsigned char UDSDiag28(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
{
   unsigned char Errorvalue=0;
   
   if(pci != 0x03) return NCR13; //add diag error long
   if(SystemMode != exDiagSession)return NCR7f;
  // if(SalfeMode < salfe01 ){ Errorvalue = NCR33;return Errorvalue;}

   switch(d1)
   {
   		case 0:
		{
                     CommControl = 0x00;
			if(d2 == 0x00)
			{
			           CommControl += d2;
				    Errorvalue =NCRright;
			}
			else Errorvalue = NCR12;
		}break;
		case 1:
		{
			Errorvalue = NCR12;
		}break;
		case 2:
		{
			Errorvalue = NCR12;
		}break;
		case 3:
		{
                  CommControl = 0x30;
		    if(d2 == 0x03)
		   {
		             CommControl += d2;
			      Errorvalue =NCRright;
		    }
		    else  Errorvalue =NCR12;		    

		}break;
		default:
		{
			Errorvalue = NCR12;
		}break;

   }
   // if(d2 > 3)Errorvalue = NCR31;
 //  if(pci >= 8) Errorvalue = NCR13;

   return Errorvalue;

}


unsigned char UDSDiag31(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
{
	unsigned char Errorvalue=0;
       unsigned int Didnumber;

	if(pci != 0x04) return NCR13;
       //if(SystemMode != exDiagSession)return NCR7f;
	if(SalfeMode < salfe02) {Errorvalue = NCR33;return Errorvalue;}
    Didnumber = d2;
	Didnumber = (Didnumber<<8) +d3;
    if(Didnumber == DidFD01)
    {
         switch(d1)
         {
 			 case 1:
			 {
                             KEYleanstate = d1 ;
				 INITrkenumber();
				 EnalbeLearnRkeTime20s = 1250 ;
				 Errorvalue = NCRright;
			 }break;
			 case 2:
			 {
			 	if(KEYleanstate == Start)
			 	{
					 KEYleanstate = d1 ;
					 Errorvalue = NCRright;
			 	}
				else
				{ 
					 Errorvalue = NCR24;
				}
			 }break;
			 case 3:
			 {
				 //KEYleanstate = d1 ;
				 //if(EnalbeLearnRkeTime20s != 0)
				 Errorvalue = NCRright+1;  //需要返回例程执行结果
			 }break;
			 default:
			 {
				Errorvalue = NCR12;
			 }break;
		 }
	}
	else
	{
        Errorvalue = NCR31;
	}

    if(pci >= 8) Errorvalue = NCR13;
	return Errorvalue;
}



unsigned char UDSDiag22(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
{
	unsigned char Errorvalue=0;
	unsigned char Didlang;

    //if(SystemMode != exDiagSession) return NCR7f;  //mode error
	
    if((pci < 0x03)||(pci == 0x04)||(pci == 0x06)) {Errorvalue = NCR13; return Errorvalue;}  //add diag error long

    if(pci & 0x80)  //多帧接收
    {
         if(((pci &0x7f)%2) != 0)Errorvalue = NCR13; //add diag error long
		 else
		 {
             Didlang = (((pci&0x7f)+d0)-2)>>1;
		 }
	}
	else //单帧接收
	{
         Didlang = (pci-1)>>1;

	}

	Errorvalue = ReadDid22(Didlang);

	
	
	return Errorvalue;
}

unsigned char Didvalue[20];
unsigned char F190didsavevin[17];
unsigned char F190Savestate;
unsigned char F18Cdidsave[7];
unsigned char F18CSavestate;
unsigned char F18Bdidsave[4];
unsigned char F18Bsavestate;
unsigned char F19ddidsave[4];
unsigned char F19dsavestate;
unsigned char F1f2didsave[2];
unsigned char F1f2savestate;
unsigned char F1f3didsave[2];
unsigned char F1f3savestate;
unsigned char F1f4didsave[2];
unsigned char F1f4savestate;

void  Did2einit(void)
{
       uchar   datalong,data;
	//f190  long 17
	datalong = 17;
	for(data = 0;data < datalong;data++)
	{
            F190didsavevin[data] = DIDF190EEPROM[data];
	}
	//f18c  long 7
	datalong = 7;
	for(data = 0;data < datalong;data++)
	{
            F18Cdidsave[data] = DIDF18cEEPROM[data];
	}	
	//f18b  long 4
	datalong = 4;
	for(data = 0;data < datalong;data++)
	{
            F18Bdidsave[data] = DIDF18bEEPROM[data];
	}
	//f19d  long 4
	datalong = 4;
	for(data = 0;data < datalong;data++)
	{
            F19ddidsave[data] = DIDF19dEEPROM[data];
	}
	//f1f2  long 2
	datalong = 2;
	for(data = 0;data < datalong;data++)
	{
            F1f2didsave[data] = DIDF1f2EEPROM[data];
	}
	//f1f3  long 2
	datalong = 2;
	for(data = 0;data < datalong;data++)
	{
            F1f3didsave[data] = DIDF1f3EEPROM[data];
	}
	//f1f2  long 2
	datalong = 2;
	for(data = 0;data < datalong;data++)
	{
            F1f4didsave[data] = DIDF1F4EEPROM[data];
	}
}

void Did2esave(void)
{
     if(F190Savestate != 0)
     {
         F190Savestate--;
         Weeprommain((unsigned long)(&DIDF190EEPROM[F190Savestate]),F190didsavevin[F190Savestate]);
     }
     if(F18CSavestate !=0)
     {
         F18CSavestate--;
         Weeprommain((unsigned long)(&DIDF18cEEPROM[F18CSavestate]),F18Cdidsave[F18CSavestate]);
      }
     if(F18Bsavestate !=0)
     {
         F18Bsavestate--;
         Weeprommain((unsigned long)(&DIDF18bEEPROM[F18Bsavestate]),F18Bdidsave[F18Bsavestate]);
      }
     if(F19dsavestate !=0)
     {
         F19dsavestate--;
         Weeprommain((unsigned long)(&DIDF19dEEPROM[F19dsavestate]),F19ddidsave[F19dsavestate]);
      }
     if(F1f2savestate !=0)
     {
         F1f2savestate--;
         Weeprommain((unsigned long)(&DIDF1f2EEPROM[F1f2savestate]),F1f2didsave[F1f2savestate]);
      }
     if(F1f3savestate !=0)
     {
         F1f3savestate--;
         Weeprommain((unsigned long)(&DIDF1f3EEPROM[F1f3savestate]),F1f3didsave[F1f3savestate]);
      }	
     if(F1f4savestate !=0)
     {
         F1f4savestate--;
         Weeprommain((unsigned long)(&DIDF1F4EEPROM[F1f4savestate]),F1f4didsave[F1f4savestate]);
	  //speedlockstate =2;
	  speedlockset =0x55;
	  //BuzzerDrv(1,126,125,buzzspeedlockon);
      }
   

}

unsigned char ReadDid22(unsigned char longdid)
{
     unsigned char Errorvalue=0;
	 unsigned char didcnt,DIDreadtoal;
	 unsigned int DIDread;
     //unsigned char savedid[80];
	 unsigned char cnt,cnt1;
	 unsigned char onecnt,onecnt1,onecnt2,onecnt3;
	 //if(SystemMode != exDiagSession)return NCR7f;
	 if(longdid == 1)
	 {     
	                cnt = 1;
			  ClearNPDUbuff(); //add diag
                       DIDread = R_PDU[0].Data[cnt];
			  DIDread = (DIDread<<8) +R_PDU[0].Data[cnt+1];
			  didcnt = ReadDidvalue(DIDread,Didread);
			  if(didcnt > 20) 
			  {
                              Errorvalue = didcnt -0x10;
				  return Errorvalue;
			  }
			  if(didcnt == 0xff) {Errorvalue = NCR13 ;return;}//???
			  if(didcnt > 4) //长度大于1帧必须多帧发送
			  {
			      
                              N_PDU[0].PCI = 0x10;
				  N_PDU[0].Data[0] = didcnt+3;
				  N_PDU[0].Data[1] = SID22+0x40;
				  N_PDU[0].Data[2] = R_PDU[0].Data[1];
				  N_PDU[0].Data[3] = R_PDU[0].Data[2];
                              onecnt = 4;
				  onecnt1 = 0;
				  for(cnt = 0;cnt < didcnt;cnt++)
				  {
                                     N_PDU[onecnt1].Data[onecnt++] = Didvalue[cnt];
					 if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
				  }		
				  //
				  N_UDSDdata.Request = 2;  //设置多帧发送标志
			  }
			  else  //单帧发送
			  {
                              UDSsendone(0x03+didcnt,SID22+0x40,R_PDU[0].Data[1],R_PDU[0].Data[2],Didvalue[0],Didvalue[1],Didvalue[2],Didvalue[3]);
			  }
	 }
     else if(longdid <= 3)
     {
         DIDreadtoal = 0;
		 onecnt = 2;
		 onecnt1 = 0;
         for(cnt = 1;cnt <= longdid;cnt++) //防缓存
         {
                       if(cnt == 1) ClearNPDUbuff(); // add diag
                       DIDread = R_PDU[0].Data[(cnt<<1)-1];
			  DIDread = (DIDread<<8) +R_PDU[0].Data[cnt<<1];
			  didcnt = ReadDidvalue(DIDread,Didread);
			  if(didcnt > 20) 
			  {
                               Errorvalue = didcnt-0x10;
				  return Errorvalue;
			  }
			  DIDreadtoal = DIDreadtoal + didcnt+2;
			  if(didcnt == 0xff) {Errorvalue = NCR13 ;return;}//???
			  //savedid[DIDreadtoal++] = (unsigned char) DIDread >> 8;
			  //savedid[DIDreadtoal++] = (unsigned char)DIDread;
			  N_PDU[onecnt1].Data[onecnt++] = R_PDU[0].Data[(cnt<<1)-1];
			  if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
			  N_PDU[onecnt1].Data[onecnt++] = R_PDU[0].Data[cnt<<1];
			  if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
			  for(cnt1 = 0;cnt1 < didcnt ;cnt1++)
			  {
					//savedid[DIDreadtoal++] = Didvalue[cnt];
					N_PDU[onecnt1].Data[onecnt++] = Didvalue[cnt1];
					if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
			  }
		 }
		 // 放发送缓存
		 N_PDU[0].PCI = 0x10;
		 N_PDU[0].Data[0]= DIDreadtoal+1;
		 N_PDU[0].Data[1]=SID22 +0x40;
		 /*
		 onecnt = 2;
		 onecnt1 =0;
         for(cnt = 0 ;cnt < DIDreadtoal;cnt++)
         {
             N_PDU[onecnt1].Data[onecnt++] = savedid[cnt];
			 if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
		 }*/
        //发送
        N_UDSDdata.Request = 2;  //设置多帧发送标志
		 
	 }
	 else if(longdid < 12)
	 {
		DIDreadtoal = 0;
		// 10 xx 22 
		onecnt2=2;
		onecnt3=0;
	    onecnt = 2;
		onecnt1 = 0;
		for(cnt = 0 ;cnt <= longdid ; cnt++) //放临时缓存
		{		
       		  DIDread = R_PDU[onecnt3].Data[onecnt2++];
			  if(onecnt2 > 6) {onecnt2 = 0;onecnt3++;}
			  DIDread = (DIDread<<8) + R_PDU[onecnt3].Data[onecnt2++];
			  if(onecnt2 > 6) {onecnt2 = 0;onecnt3++;}
			  
			  didcnt = 0;
			  didcnt = ReadDidvalue(DIDread,Didread);

			  if(didcnt == 0xff) {Errorvalue = NCR13 ;return;}//???
			  if(didcnt > 20) 
			  {
                              Errorvalue = didcnt-0x10;
				  return Errorvalue;
			  }


			  
              DIDreadtoal = DIDreadtoal+ didcnt+2;
			  
			  N_PDU[onecnt1].Data[onecnt++] = (uu8)(DIDread >> 8);
			  if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
			  N_PDU[onecnt1].Data[onecnt++] = (uu8)DIDread;
			  if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
			  for(cnt1 = 0;cnt1 < didcnt ;cnt1++)
			  {
					//savedid[DIDreadtoal++] = Didvalue[cnt];
					N_PDU[onecnt1].Data[onecnt++] = Didvalue[cnt1];
					if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
			  }
		}
		//放发送缓存

		 N_PDU[0].PCI = 0x10;
		 N_PDU[0].Data[0]= DIDreadtoal+1;
		 N_PDU[0].Data[1]=SID22 +0x40;

        //发送
        N_UDSDdata.Request = 2;  //设置多帧发送标志


		
	 }
	 else
	 {
			Errorvalue = NCR31;
	 }

     //if(SystemMode == progSession) Errorvalue = NCR22;
	 
     return Errorvalue;
}

void ClearDidvalue(void)
{
    uchar didcnt;
	for(didcnt = 0;didcnt < 20;didcnt++)
	{
		Didvalue[didcnt] = 0;
	}

}

unsigned char ReadDidvalue(unsigned int DID,unsigned char DIDrwstate)
{
     unsigned char Didonelong;
	 unsigned char cnt;
	 
	 ClearDidvalue();
	 
	 switch(DID)
	 {
        case DidF120:
		{
			if(DIDrwstate == Didread)
			{
				Didonelong = 4;
				Didvalue[3] = (unsigned char)(DIDvalueF120);
                            Didvalue[2] = (unsigned char)(DIDvalueF120 >> 8);
				Didvalue[1] = (unsigned char)(DIDvalueF120 >> 16);
				Didvalue[0] = (unsigned char)(DIDvalueF120 >> 24);
			}
			else
			{
				Didonelong = NCR31+0x10;
			}
			
		}break;
		
		case DidF181:
		{
			if(DIDrwstate == Didread)
			{
				Didonelong = 4;
				Didvalue[3] = (unsigned char)(DIDvalueF181);
                Didvalue[2] = (unsigned char)(DIDvalueF181 >> 8);
				Didvalue[1] = (unsigned char)(DIDvalueF181 >> 16);
				Didvalue[0] = (unsigned char)(DIDvalueF181 >> 24);
			}
			else
			{
				Didonelong = NCR31+0x10;
			}
		}break;
		case DidF187:
		{
			if(DIDrwstate == Didread)
			{
				Didonelong = 10;
				Didvalue[3] = (unsigned char)(DIDvalueF1871);
                            Didvalue[2] = (unsigned char)(DIDvalueF1871 >> 8);
				Didvalue[1] = (unsigned char)(DIDvalueF1871 >> 16);
				Didvalue[0] = (unsigned char)(DIDvalueF1871 >> 24);
				Didvalue[7] = (unsigned char)(DIDvalueF1872 );
                            Didvalue[6] = (unsigned char)(DIDvalueF1872 >> 8);
				Didvalue[5] = (unsigned char)(DIDvalueF1872 >> 16);
				Didvalue[4] = (unsigned char)(DIDvalueF1872 >> 24);
				Didvalue[9] = (unsigned char)(DIDvalueF1873 );
                            Didvalue[8] = (unsigned char)(DIDvalueF1873 >> 8);

			}
			else
			{
				Didonelong = NCR31+0x10;
			}
		}break;
		case DidF18a:
		{
			if(DIDrwstate == Didread)
			{
				Didonelong = 7;
				Didvalue[3] = (unsigned char)(DIDvalueF18a1);
                            Didvalue[2] = (unsigned char)(DIDvalueF18a1 >> 8);
				Didvalue[1] = (unsigned char)(DIDvalueF18a1 >> 16);
				Didvalue[0] = (unsigned char)(DIDvalueF18a1 >> 24);
				Didvalue[6] = (unsigned char)(DIDvalueF18a2);
                            Didvalue[5] = (unsigned char)(DIDvalueF18a2 >> 8);
				Didvalue[4] = (unsigned char)(DIDvalueF18a2 >> 16);

			}
			else
			{
				Didonelong = NCR31+0x10;
			}
		}break;
		case DidF18b:
		{
			if(DIDrwstate == Didread)
			{
				Didonelong = 4;
				Didvalue[0] = F18Bdidsave[0];
                            Didvalue[1] = F18Bdidsave[1];
				Didvalue[2] = F18Bdidsave[2];
				Didvalue[3] = F18Bdidsave[3];
				//Didvalue[4] = DIDF18bEEPROM[4];
                //Didvalue[5] = DIDF18bEEPROM[5];
				//Didvalue[6] = DIDF18bEEPROM[6];
			}
			else
			{ 
			      if(R_PDU[0].PCI!= 7) { Didonelong = NCR13+0x10;break;}
			      F18Bdidsave[0]=R_PDU[0].Data[3];
			      F18Bdidsave[1]=R_PDU[0].Data[4];
			      F18Bdidsave[2]=R_PDU[0].Data[5];
			      F18Bdidsave[3]=R_PDU[0].Data[6];
			      F18Bsavestate = 4;
			      //Weeprommain((unsigned long)(&DIDF18bEEPROM[0]),R_PDU[0].Data[3]); 
                           //DIDF18bEEPROM[0] = R_PDU[0].Data[3];
                           //Weeprommain((unsigned long)(&DIDF18bEEPROM[1]),R_PDU[0].Data[4]);
				//DIDF18bEEPROM[1] = R_PDU[0].Data[4];
				//Weeprommain((unsigned long)(&DIDF18bEEPROM[2]),R_PDU[0].Data[5]);
				//DIDF18bEEPROM[2] = R_PDU[0].Data[5];
				//Weeprommain((unsigned long)(&DIDF18bEEPROM[3]),R_PDU[0].Data[6]);
				//DIDF18bEEPROM[3] = R_PDU[0].Data[6];
				if((F18Bdidsave[0] != R_PDU[0].Data[3])||(F18Bdidsave[3] != R_PDU[0].Data[6]))
				{
					Didonelong = NCR72+0x10;
				}
			
			}
		}break;
		case DidF190:
		{
			if(DIDrwstate == Didread)
			{
			       Didonelong = 17;
				Didvalue[0] = F190didsavevin[0];
				Didvalue[1] = F190didsavevin[1];
				Didvalue[2] = F190didsavevin[2];
				Didvalue[3] = F190didsavevin[3];
				Didvalue[4] = F190didsavevin[4];
				Didvalue[5] = F190didsavevin[5];
				Didvalue[6] = F190didsavevin[6];
				Didvalue[7] = F190didsavevin[7];
				Didvalue[8] = F190didsavevin[8];
				Didvalue[9] = F190didsavevin[9];
				Didvalue[10] = F190didsavevin[10];
				Didvalue[11] = F190didsavevin[11];
				Didvalue[12] = F190didsavevin[12];
				Didvalue[13] = F190didsavevin[13];
				Didvalue[14] = F190didsavevin[14];
				Didvalue[15] = F190didsavevin[15];
				Didvalue[16] = F190didsavevin[16];
				
				
			}
			else
			{
			     if(R_PDU[0].Data[0]!= 20) { Didonelong = NCR13+0x10;break;}
			       F190didsavevin[0] = R_PDU[0].Data[4]; 
                            F190didsavevin[1] = R_PDU[0].Data[5];				
				F190didsavevin[2] = R_PDU[0].Data[6];
				
				F190didsavevin[3] = R_PDU[1].Data[0];
				F190didsavevin[4] = R_PDU[1].Data[1]; 
                            F190didsavevin[5] = R_PDU[1].Data[2];	
	
				F190didsavevin[6] = R_PDU[1].Data[3];				
				F190didsavevin[7] = R_PDU[1].Data[4];
				F190didsavevin[8] = R_PDU[1].Data[5]; 
				
                            F190didsavevin[9] = R_PDU[1].Data[6];				
				F190didsavevin[10] = R_PDU[2].Data[0];				
				F190didsavevin[11] = R_PDU[2].Data[1];
				
				F190didsavevin[12] = R_PDU[2].Data[2]; 
                            F190didsavevin[13] = R_PDU[2].Data[3];				
				F190didsavevin[14] = R_PDU[2].Data[4];	
				
				F190didsavevin[15] = R_PDU[2].Data[5];
				F190didsavevin[16] = R_PDU[2].Data[6]; 
				
				F190Savestate = 17;
		
				
				if((F190didsavevin[0] != R_PDU[0].Data[4])||(F190didsavevin[16] != R_PDU[2].Data[6]))
				{
					Didonelong = NCR72+0x10;
				}

			}
		}break;
		case DidF18c:
		{
			if(DIDrwstate == Didread)
			{
				Didonelong = 7;
				Didvalue[0] = F18Cdidsave[0];
              	       Didvalue[1] = F18Cdidsave[1];
				Didvalue[2] = F18Cdidsave[2];
				Didvalue[3] = F18Cdidsave[3];
				Didvalue[4] = F18Cdidsave[4];
               		 Didvalue[5] = F18Cdidsave[5];
				Didvalue[6] = F18Cdidsave[6];
			}
			else
			{
			       if(R_PDU[0].Data[0] != 10) { Didonelong = NCR13+0x10;break;}
			       F18Cdidsave[0] = R_PDU[0].Data[4]; 
				F18Cdidsave[1] =R_PDU[0].Data[5]; 
				F18Cdidsave[2] =R_PDU[0].Data[6]; 
				F18Cdidsave[3] =R_PDU[1].Data[0]; 
				F18Cdidsave[4] =R_PDU[1].Data[1]; 
				F18Cdidsave[5] =R_PDU[1].Data[2]; 
				F18Cdidsave[6] =R_PDU[1].Data[3]; 
				F18CSavestate = 7;
				if((F18Cdidsave[0] != R_PDU[0].Data[4])||(F18Cdidsave[6] != R_PDU[1].Data[3]))
				{
					Didonelong = NCR72+0x10;
				}
				
			}
		}break;
		case DidF193:
		{
			if(DIDrwstate == Didread)
			{
				Didonelong = 4;
				Didvalue[3] = (unsigned char)(DIDvalueF193);
                            Didvalue[2] = (unsigned char)(DIDvalueF193 >> 8);
				Didvalue[1] = (unsigned char)(DIDvalueF193 >> 16);
				Didvalue[0] = (unsigned char)(DIDvalueF193 >> 24);
			}
			else
			{
				Didonelong = NCR31+0x10;
			}
		}break;
		case DidF195:
		{
			if(DIDrwstate == Didread)
			{
				Didonelong = 4;
				Didvalue[3] = (unsigned char)(DIDvalueF195);
                            Didvalue[2] = (unsigned char)(DIDvalueF195 >> 8);
				Didvalue[1] = (unsigned char)(DIDvalueF195 >> 16);
				Didvalue[0] = (unsigned char)(DIDvalueF195 >> 24);
			}
			else
			{
				Didonelong = NCR31+0x10;
			}
		}break;
		case DidF19d:
		{
			if(DIDrwstate == Didread)
			{
				Didonelong = 4;
				Didvalue[0] = F19ddidsave[0];
                            Didvalue[1] = F19ddidsave[1];
				Didvalue[2] = F19ddidsave[2];
				Didvalue[3] = F19ddidsave[3];
			}
			else
			{
			       if(R_PDU[0].PCI!= 7) { Didonelong = NCR13+0x10;break;}
				F19ddidsave[0]=R_PDU[0].Data[3];
				F19ddidsave[1]=R_PDU[0].Data[4];
				F19ddidsave[2]=R_PDU[0].Data[5];
				F19ddidsave[3]=R_PDU[0].Data[6];
				F19dsavestate = 4;
			       //Weeprommain((unsigned long)(&DIDF19dEEPROM[0]),R_PDU[0].Data[3]);
                            //DIDF19dEEPROM[0] = R_PDU[0].Data[3];
                            //Weeprommain((unsigned long)(&DIDF19dEEPROM[1]),R_PDU[0].Data[4]);
				//DIDF19dEEPROM[1] = R_PDU[0].Data[4];
				//Weeprommain((unsigned long)(&DIDF19dEEPROM[2]),R_PDU[0].Data[5]);
				//DIDF19dEEPROM[2] = R_PDU[0].Data[5];
				//Weeprommain((unsigned long)(&DIDF19dEEPROM[3]),R_PDU[0].Data[6]);
				//DIDF19dEEPROM[3] = R_PDU[0].Data[6];
				if((F19ddidsave[0] != R_PDU[0].Data[3])||(F19ddidsave[3] != R_PDU[0].Data[6]))
				{
					Didonelong = NCR72+0x10;
				}
			}
		}break;
		case DidF1f1:
		{
			if(DIDrwstate == Didread)
			{
				Didonelong = 1;
				//if(f_RKE_SerialNum[0] != 0)Didvalue[0]++;
				//if(f_RKE_SerialNum[1] != 0)Didvalue[0]++;
				Didvalue[0] = RKEnumberRead();
				//Didvalue[0] = (unsigned char)(DIDvalueF1f1);
			}
			else
			{
				Didonelong = NCR31+0x10;
			}
		}break;
		case DidF1f2:
		{
			if(DIDrwstate == Didread)
			{

					Didonelong = 2;
					Didvalue[0] = F1f2didsave[0];
	                            Didvalue[1] = F1f2didsave[1];

			}
			else
			{
			       if(R_PDU[0].PCI!= 5) { Didonelong = NCR13+0x10;break;}
				F1f2didsave[0] = R_PDU[0].Data[3];
				F1f2didsave[1] = R_PDU[0].Data[4];
				F1f2savestate=2;
				//Weeprommain((unsigned long)(&DIDF1f2EEPROM[0]),R_PDU[0].Data[3]);
                            //DIDF1f2EEPROM[0] = R_PDU[0].Data[3];
				//Weeprommain((unsigned long)(&DIDF1f2EEPROM[1]),R_PDU[0].Data[4]);
				//DIDF1f2EEPROM[1] = R_PDU[0].Data[4];
				if((F1f2didsave[0] != R_PDU[0].Data[3])||(F1f2didsave[1] != R_PDU[0].Data[4]))
				{
					Didonelong = NCR72+0x10;
				}

				//写入失败   判断
			}
		}break;
		case DidF1f3:
		{
			if(DIDrwstate == Didread)
			{
			      if(SalfeMode < salfe02) 
			      {
     				       Didonelong = NCR33+0x10;
				}
				else
				{
					Didonelong = 2;
					Didvalue[0] = F1f3didsave[0];
	                            Didvalue[1] = F1f3didsave[1];
				}
			}
			else
			{  
				if(R_PDU[0].PCI!= 5) { Didonelong = NCR13+0x10;break;}
				F1f3didsave[0] = R_PDU[0].Data[3];
				F1f3didsave[1] = R_PDU[0].Data[4];
				F1f3savestate=2;
			       //Weeprommain((unsigned long)(&DIDF1f3EEPROM[0]),R_PDU[0].Data[3]);

				//Weeprommain((unsigned long)(&DIDF1f3EEPROM[1]),R_PDU[0].Data[4]);

				if((F1f3didsave[0] != R_PDU[0].Data[3])||(F1f3didsave[1] != R_PDU[0].Data[4]))
				{
					Didonelong = NCR72+0x10;
				}

			}
		}break;
		case DidF1f4:
		{
			if(DIDrwstate == Didread)
			{
				Didonelong = 2;
				Didvalue[0] = F1f4didsave[0];
                            Didvalue[1] = F1f4didsave[1];
			}
			else
			{  
				if(R_PDU[0].PCI != 5) { Didonelong = NCR13+0x10;  break;}
				F1f4didsave[0] = R_PDU[0].Data[3];
				F1f4didsave[1] = R_PDU[0].Data[4];
				F1f4savestate=2;
				
			       //Weeprommain((unsigned long)(&DIDF1F4EEPROM[0]),R_PDU[0].Data[3]);

				//Weeprommain((unsigned long)(&DIDF1F4EEPROM[1]),R_PDU[0].Data[4]);

				if((F1f4didsave[0] != R_PDU[0].Data[3])||(F1f4didsave[1] != R_PDU[0].Data[4]))
				{
					Didonelong = NCR72+0x10;
				}

			}
		}break;
		case DidFD01:
		{
			if(DIDrwstate == Didread)
			{
				Didonelong = 1;
			}
			else
			{
				Didonelong = NCR31+0x10;
			}
		}break;
		default:
		{
                      Didonelong = NCR31+0x10;   //error1
		}break;

	 }

	 return Didonelong;
}
/*
void savedidtodid(unsigned char cnt)
{
    unsigned char ii;
    for(ii=0;ii <cnt;++)



}
*/

 unsigned char UDSDiag2e(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
 {
 	unsigned char Errorvalue=0;
	unsigned int DIDv;
	unsigned char datalang;
	unsigned char rexstate;

	if(pci < 0x04) return NCR13;//add diag error long
	//if(SystemMode != exDiagSession)return NCR7f;
	if(SalfeMode < salfe02) {Errorvalue = NCR33 ;return Errorvalue;}

	if((pci & 0xf0)==0x10)
	{
              datalang = d0;
		DIDv = d2;
		DIDv = (DIDv << 8)+d3;
	}
	else 
	{
              datalang = pci;
		DIDv = d1;
		DIDv = (DIDv << 8)+d2;
	}
    //if(datalang > 20) Errorvalue = NCR13;
	
    rexstate = ReadDidvalue(DIDv,Didwrite);
    if(rexstate > 20) Errorvalue = rexstate-0x10;
	
 	return Errorvalue;
 }

 unsigned char UDSDiag19(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
 {
 	unsigned char Errorvalue=0;
    unsigned char dtcnumber,cnt1,cnt2;
	
	if(pci != 0x03) {Errorvalue = NCR13; return Errorvalue;}  //add diag error long
	//if(SystemMode != exDiagSession)return NCR7f;
	switch(d1)
	{
		case 1:  //返回相匹配的DTC数量
		{
                     dtcnumber = ReadDTCquantity(d2);
			UDSsendone(0x06,SID19+0x40,0x01,d2,0,0,dtcnumber,0);
		}break;
		case 2:
		{
			dtcnumber = ReadDTCquantity(d2);
			Errorvalue = SaveDTCtoBuff(dtcnumber,d2);
		}break;
		case 3:
		{
			Errorvalue = NCR12;
		}break;
		case 4:
		{
			Errorvalue = NCR12;
		}break;
		case 6:
		{
			Errorvalue = NCR12;
		}break;
		case 0X0A:
		{
			dtcnumber =DTCLong ;// ReadDTCquantity(d2);
			Errorvalue = SaveDTCtoBuff(dtcnumber,0);
		}break;
		default:
		{
			Errorvalue = NCR12;
		}break;

	}
 
 	return Errorvalue;
 }

unsigned char UDSclearDTC(void)
{
    unsigned char ccntt;
	unsigned char ccntt2;
	for(ccntt =0;ccntt <DTCLong; ccntt++)
	{
	    for(ccntt2 = 0 ; ccntt2 < 5; ccntt2++)
	    {
			if(DTCstate[ccntt] != 0)
			{
				Weeprommain((unsigned long)(&DTCstate[ccntt]),0x00);
				WWDG_Refresh(0x7f);
				
			}
			else
			{
				break;
			}
	    }
				
	}

    return NCRright;
}
 
unsigned char SaveDTCtoBuff(uu8 dtcnumber,uu8 dtcmask)
{
     unsigned char ccnt1,ccnt2,ccnt;
	if(dtcnumber > 1) //多帧发送
	{
	     N_PDU[0].PCI = 0x10;
		 N_PDU[0].Data[0] = (dtcnumber << 2)+3 ;
		 N_PDU[0].Data[1] = SID19+0x40;
		 N_PDU[0].Data[2] = R_PDU[0].Data[1];
		 N_PDU[0].Data[3] = R_PDU[0].Data[2];
	     ccnt1 = 0;
		 ccnt2 = 4;
	     for(ccnt = 0; ccnt <DTCLong ; ccnt++)
	     {
	         if(dtcmask == 0)
	         {
	             N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCH;
				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
	             N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCL;
				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
	             N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCS;
				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
	             N_PDU[ccnt1].Data[ccnt2++] = DTCstate[ccnt];
				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
				 
			 }
			 else
			 {
				 if(dtcmask & DTCstate[ccnt])
				 {
			         N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCH;
					 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
			         N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCL;
					 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
			         N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCS;
					 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
			         N_PDU[ccnt1].Data[ccnt2++] = DTCstate[ccnt];
					 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
				 }
			 }
		 }
		 N_UDSDdata.Request = 2 ;//请求多帧发送
	}	 
	else   //单帧发送
	{
		 N_PDU[0].PCI = (dtcnumber << 2) +3;
		 N_PDU[0].Data[0] = SID19+0x40;
		 N_PDU[0].Data[1] = R_PDU[0].Data[1];
		 N_PDU[0].Data[2] = R_PDU[0].Data[2];
		 //N_PDU[0].Data[3] = ;
	     ccnt1 = 0;
		 ccnt2 = 3;
	     for(ccnt = 0; ccnt <DTCLong ; ccnt++)
	     {

			 if(dtcmask & DTCstate[ccnt])
			 {
		         N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCH;
				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
		         N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCL;
				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
		         N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCS;
				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
		         N_PDU[ccnt1].Data[ccnt2++] = DTCstate[ccnt];
				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
			 }

		 }
		 N_UDSDdata.Request = 1 ;//请求单帧发送
	 }


    return NCRright;
}


unsigned char ReadDTCquantity(unsigned char DTCMASK)
{
    unsigned char cnt1,cnt2;

    cnt1 = 0;
	cnt2 = 0;
    for(cnt1 = 0; cnt1 < DTCLong; cnt1++)
    {
        if(( DTCstate[cnt1] & DTCMASK)!=0)
        {
           cnt2++;
		}
	}


    return cnt2;
}



 unsigned char UDSDiag27(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
 {
 	unsigned char Errorvalue = 0;
	static unsigned char code = 0;
	if((pci != 2)&&(pci != 6)&&(pci != 4)) return NCR13;
	if(SystemMode != exDiagSession)return NCR7f;
	if((d1 == salfe01)||(d1 == salfe02)||(d1 == salfe11)||(d1 == salfe12))
	{
	       if(keyerror2 > 3)
	       {
	                            Errorvalue = NCR36;
					return Errorvalue;
		}
		if(keyerrorclosetime > 3) 
		{
			Errorvalue = NCR37;
			return Errorvalue;
		}
	}
	else
	{
		return NCR12;
	}
	
    switch(d1)
    {
	    case salfe01:
		{
			if(pci != 0x02) return NCR13; //add diag error long
			BCMsjs(sjs);	
			
			LevelOneKeyArith(BCMvseed,BCMkey);
			code = 1;
			UDSsendone(0x06,SID27+0x40,salfe01,BCMvseed[0],BCMvseed[1],BCMvseed[2],BCMvseed[3],0);
		}break;
		case salfe02:
		{
			if(pci != 0x06) return NCR13; //add diag error long
			if(keyerrorclosetime != 0) return NCR36;
			if(code != 1) return NCR24;
			code = 0;
			if((BCMkey[0] == d2)&&(BCMkey[1] == d3)&&(BCMkey[2] == d4)&&(BCMkey[3] == d5))
			{
				SalfeMode = Salfe1;
				keyerror1 = 0;
				Errorvalue = 0;
				UDSsendone(0x02,SID27+0x40,salfe02,0,0,0,0,0);
			}
			else
			{
				Errorvalue = NCR35;
				SalfeMode = Salfe0;
				if(keyerror1 < 5)keyerror1++;
			}
			if(keyerror1 > 3)
            {
                            Errorvalue = NCR36;
				keyerrorclosetime = DTC10000MS;
			}
		}break;
		case salfe11:
		{			
			if(pci != 0x02) return NCR13; //add diag error long
			if(SalfeMode < Salfe1) return NCR24;
			
			Errorvalue = 0;
			if((DIDF1f2EEPROM[0] ==0x00)&&(DIDF1f2EEPROM[1] ==0x00))
			{
				SalfeMode = Salfe2;
			}
			else
			{
				code = 2;
			}
			//
			//UDSsendone(0x06,SID27+0x40,salfe11,uu8(RetCode>>8),uu8(RetCode),0,0,0);
			UDSsendone(0x05,SID27+0x40,salfe11,DIDF1f2EEPROM[0],DIDF1f2EEPROM[1],0,0,0);
		}break;
		case salfe12:
		{
			if(pci != 0x04) return NCR13; //add diag error long
			
			//if(code != 2) return NCR24;
			if(keyerrorclosetime != 0 )return NCR37;
			code = 0;
			if(SalfeMode < Salfe1) return NCR24;
            if((DIDF1f3EEPROM[0]==d2)&&(DIDF1f3EEPROM[1]==d3))
            {
                Errorvalue = 0;
				SalfeMode = Salfe2;
				keyerror2 = 0;
				UDSsendone(0x02,SID27+0x40,salfe12,0,0,0,0,0);
			}
			else
			{
				Errorvalue = NCR35;
				SalfeMode = Salfe1;
				if(keyerror2 < 5) keyerror2++;
			}

            if(keyerror2 > 3)
            {
                            Errorvalue = NCR36;
				keyerrorclosetime = DTC10000MS;
			}
			
		}break;
		case salfe21:
		{
			Errorvalue = NCR12;
		}break;
		case salfe22:
		{
			Errorvalue = NCR12;
		}break;
		default:
		{
			Errorvalue = NCR12;
		}break;


	}
 
 	return Errorvalue;
 }

void BCMsjs(unsigned int sjs)
{
    static unsigned char sjscnt=0x55;
	sjscnt++;
       BCMvseed[0] = (unsigned char)sjs+sjscnt;
	BCMvseed[1] = (unsigned char)(sjs>>2)^BCMvseed[0]-sjscnt;
	BCMvseed[2] = (unsigned char)(sjs>>3)+BCMvseed[1]+sjscnt;
	BCMvseed[3] = (unsigned char)(sjs>>4)^BCMvseed[2]-sjscnt;
       //BCMvseed[0] = 0x55;//(unsigned char)sjs+sjscnt;
	//BCMvseed[1] =0x55;// (unsigned char)(sjs>>2)^BCMvseed[0]-sjscnt;
	//BCMvseed[2] =0x55;// (unsigned char)(sjs>>3)+BCMvseed[1]+sjscnt;
	//BCMvseed[3] = 0x55;//(unsigned char)(sjs>>4)^BCMvseed[2]-sjscnt;



	
}




void DTCinit(void)
{
   DTCNameN[DTC9001].DTCH =0x90;
   DTCNameN[DTC9001].DTCL =0x01;
   DTCNameN[DTC9001].DTCS =0x1e;

   DTCNameN[DTC9003].DTCH =0x90;
   DTCNameN[DTC9003].DTCL =0x03;
   DTCNameN[DTC9003].DTCS =0x1e;

   DTCNameN[DTC9015].DTCH =0x90;
   DTCNameN[DTC9015].DTCL =0x15;
   DTCNameN[DTC9015].DTCS =0x17;

   DTCNameN[DTC9111].DTCH =0x91;
   DTCNameN[DTC9111].DTCL =0x11;
   DTCNameN[DTC9111].DTCS =0x16;

   DTCNameN[DTC9091].DTCH =0x90;
   DTCNameN[DTC9091].DTCL =0x91;
   DTCNameN[DTC9091].DTCS =0x15;

   DTCNameN[DTC9083].DTCH =0x90;
   DTCNameN[DTC9083].DTCL =0x83;
   DTCNameN[DTC9083].DTCS =0x15;
   
   DTCNameN[DTC9011].DTCH =0x90;
   DTCNameN[DTC9011].DTCL =0x11;
   DTCNameN[DTC9011].DTCS =0x15;

   DTCNameN[DTC9023].DTCH =0x90;
   DTCNameN[DTC9023].DTCL =0x23;
   DTCNameN[DTC9023].DTCS =0x15;

   DTCNameN[DTC9007].DTCH =0x90;
   DTCNameN[DTC9007].DTCL =0x07;
   DTCNameN[DTC9007].DTCS =0x15;

   DTCNameN[DTC9043].DTCH =0x90;
   DTCNameN[DTC9043].DTCL =0x43;
   DTCNameN[DTC9043].DTCS =0x14;

   DTCNameN[DTC9093].DTCH =0x90;
   DTCNameN[DTC9093].DTCL =0x93;
   DTCNameN[DTC9093].DTCS =0x14;

   DTCNameN[DTC9061].DTCH =0x90;
   DTCNameN[DTC9061].DTCL =0x61;
   DTCNameN[DTC9061].DTCS =0x15;

   DTCNameN[DTC9067].DTCH =0x90;
   DTCNameN[DTC9067].DTCL =0x67;
   DTCNameN[DTC9067].DTCS =0x1e;
   
   DTCNameN[DTC9045].DTCH =0x90;
   DTCNameN[DTC9045].DTCL =0x45;
   DTCNameN[DTC9045].DTCS =0x14;

   DTCNameN[DTC9073].DTCH =0x90;
   DTCNameN[DTC9073].DTCL =0x73;
   DTCNameN[DTC9073].DTCS =0x1c;

   DTCNameN[DTC900C].DTCH =0x90;
   DTCNameN[DTC900C].DTCL =0x0c;
   DTCNameN[DTC900C].DTCS =0x1c;

   DTCNameN[DTCD001].DTCH =0xd0;
   DTCNameN[DTCD001].DTCL =0x01;
   DTCNameN[DTCD001].DTCS =0x08;

   DTCNameN[DTCD002].DTCH =0xd0;
   DTCNameN[DTCD002].DTCL =0x02;
   DTCNameN[DTCD002].DTCS =0x08;

   DTCNameN[DTCD003].DTCH =0xd0;
   DTCNameN[DTCD003].DTCL =0x03;
   DTCNameN[DTCD003].DTCS =0x08;

   DTCNameN[DTCD004].DTCH =0xd0;
   DTCNameN[DTCD004].DTCL =0x04;
   DTCNameN[DTCD004].DTCS =0x08;
   
   DTCNameN[DTCD005].DTCH =0xd0;
   DTCNameN[DTCD005].DTCL =0x05;
   DTCNameN[DTCD005].DTCS =0x08;
   
}

unsigned char Weeprom(unsigned long temp,unsigned char value)
{    
    uu8 cnt;
	@far u8 *pFlash;

	//FLASH_ProgramByte(temp, value);
	
	pFlash = (@far u8 *) temp;
	for(cnt = 0 ; cnt < 10; cnt++)
	{
		*pFlash = value;
		if(*pFlash == value) break;
	}

    if(*pFlash == value) return 0;
	else return 1;
	
}
/*
void  W32eeprom(unsigned long tempp,unsigned long valuee)
{
	@far u8 *pFlash;
	unsigned char value[4];
	value[0] = unsigned char (valuee>>24);
	value[1] = unsigned char (valuee>>16);
	value[2] = unsigned char (valuee>>8);
	value[3] = unsigned char (value);
	pFlash = (@far u8 *) tempp;
	
    Weeprom(pFlash,value[0]);

	Weeprom(pFlash+1,value[1]);
	
	Weeprom(pFlash+2,value[2]);

	Weeprom(pFlash+3,value[3]);
	

}
*/
void leveonekeytest(void)
{
	LevelOneKeyArith(BCMvseed,BCMkey);
}



unsigned char  LevelOneKeyArith(const u8 *vseed,u8 *GetLevelOnekey)
{
	u8 vKey1[NUM_LEVEL_ONE_KEY],vKey2[NUM_LEVEL_ONE_KEY] = {0,0,0,0};
	u8 i,j,vshift,vRshift,vLshift;
	u32 tempkey = 0; 
	unsigned char  vResult = FALSE3;
	
    AppKeyConst[0] = 0x7f;
	AppKeyConst[1] = 0xe4;
	AppKeyConst[2] = 0x75;
	AppKeyConst[3] = 0x16;
		



		for(i = NUM_LEVEL_ONE_SEED;i > 0;i--)
		{
			vKey1[i - 1] = (u8)(vseed[i - 1] ^ AppKeyConst[i - 1]);
							
			vRshift = 0x80;
			vLshift = 0x01;
			for(j = 0;j < 8;j++)
			{
				if(vseed[NUM_LEVEL_ONE_SEED - i] & vRshift)
				{
					vKey2[i - 1] |= vLshift;
				}
				vRshift >>= 1;
				vLshift <<= 1;
			}				    	        
					
			vKey2[i - 1] = (u8)(vKey2[i - 1] ^ AppKeyConst[i - 1]);
			
			vshift = (u8)((NUM_LEVEL_ONE_SEED - i) << 3);
			tempkey += (u32)((u32)((u32)vKey1[i - 1] << (u32)vshift) + (u32)((u32)vKey2[i - 1] << (u32)vshift));
			
			GetLevelOnekey[i - 1] = (u8)(tempkey >> vshift);
		}
			
		vResult = TRUE3; 
	//}
    
	return(vResult);
}



void ClearRPDUbuff(void)
{  
    unsigned char i,j;
    for(i=0;i<20;i++)
    {
        R_PDU[i].AI = 0;
		R_PDU[i].PCI = 0;
		for(j=0;j<7;j++)
		{
			R_PDU[i].Data[j] = 0;
		}
	}


}
void ClearNPDUbuff(void)
{
    unsigned char i,j;
    for(i=0;i<20;i++)
    {
        N_PDU[i].AI = 0;
		N_PDU[i].PCI = 0;
		for(j=0;j<7;j++)
		{
			N_PDU[i].Data[j] = 0;
		}
	}
}




