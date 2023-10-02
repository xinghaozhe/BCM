
//与应用层接口变量
// 1 未确认分段数据传输数据
typedef volatile struct
{
     unsigned char Request;
	 unsigned char Indication;
	 unsigned char Confirmation;
}UDSData;
// 2 未确认分段数据传输的第一帧服务
typedef volatile struct
{
	 unsigned char Indication;
}USData_FF;
// 3 更改网络层参数服务
typedef volatile struct
{
     unsigned char Request;
	 unsigned char Confirmation;
}ChangeParameter;
//pdu
typedef volatile struct
{
     unsigned int AI;
	 unsigned char PCI;
	 unsigned char Data[7];
}PDU;

typedef volatile struct
{
    unsigned char DTCH;
	unsigned char DTCL;
	unsigned char DTCS;
}DTCName;
//////////////
extern unsigned int sjs;
//////////////////////
#define uu8  unsigned char 
//extern FLASH_Status_Typedef FLASH_ProgramByte(u32 Address, u8 Data);
//////////////////////
#define RequestsendSF  0x01
#define RequestsendFF  0x02
#define RequestsendCF  0x03
#define RequestsendFC  0x04

#define ConfirmationOK  		0x01
#define ConfirmationER  		0X02
#define ConfirmationOverflow  	0X03

#define IndicationOK1     0X01
#define IndicationOKm     0X02

#define RecMaxlong     120

#define Reclong    5

#define DTCLong     21
////////////////////
extern UDSData N_UDSDdata;
extern PDU RecData[Reclong];

extern unsigned char UDSRITcnt;
extern unsigned char UDSRuscnt;

extern void DTCinit(void);

extern void UDSonCAN_netmain(void);

extern void UDSonCANDiag(void);

extern unsigned char  UDSDiag10(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6);

extern void UDSsendone(uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6,uu8 d7);

extern unsigned char UDSDiag3e(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6);

extern unsigned char UDSDiag85(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6);

extern unsigned char UDSDiag28(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6);

extern unsigned char UDSDiag31(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6);

extern unsigned char ReadDidvalue(unsigned int DID,unsigned char DIDrwstate);

extern unsigned char ReadDid22(unsigned char longdid);

extern unsigned char UDSDiag22(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6);

extern  unsigned char UDSDiag2e(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6);

extern unsigned char ReadDTCquantity(unsigned char DTCMASK);

extern unsigned char SaveDTCtoBuff(uu8 dtcnumber,uu8 dtcmask);

extern unsigned char UDSclearDTC(void);

extern  unsigned char UDSDiag19(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6);

extern unsigned char Weeprom(unsigned long temp,unsigned char value);

//extern void  W32eeprom(unsigned long tempp,unsigned long valuee);

extern void BCMsjs(unsigned int sjs);

extern  unsigned char UDSDiag27(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6);

extern void ClearRPDUbuff(void);

extern void ClearNPDUbuff(void);

extern void Did2esave(void);

extern void  Did2einit(void);

//单帧
extern unsigned char SF_FS;//N_PDU.PCI的低4位
extern unsigned int  FF_DL;
extern unsigned char CF_SN;
extern unsigned char TYPE;//N_PDU.PCI的高4位
extern unsigned char N_Result;

extern uu8     DIDF18bEEPROM[4]; 
extern uu8     DIDF19dEEPROM[4]; 
extern uu8     DIDF1f2EEPROM[2]; 
extern uu8     DIDF1f3EEPROM[2]; 
extern uu8     DIDF18cEEPROM[7]; 
extern uu8     DIDF190EEPROM[17]; 
extern uu8     DIDF1F4EEPROM[2];


extern uu8     DTCstate[DTCLong];

//////dtc commation
extern unsigned char DTC_SRS_ID;
extern unsigned char DTC_ABS_ID;
extern unsigned char DTC_TCU_ID;
extern unsigned char DTC_EMS_ID1;
extern unsigned char DTC_EMS_ID2;
///
#define time3etime     625

////SID
#define SID10       0x10
#define SID11		0x11
#define SID27		0x27
#define SID28		0x28
#define SID3e		0x3e
#define SID85		0x85

#define SID22		0x22
#define SID23		0x23
#define SID2a		0x2a
#define SID2e		0x2e
#define SID3d		0x3d

#define SID14		0x14
#define SID19		0x19
#define SID2f		0x2f
#define SID34		0x34
#define SID36		0x36	
#define SID37		0x37
#define SID31		0x31

//NCR
#define NCRright    0x00   //正确
#define NCR10       0x10   //使用此否定码拒绝向客户端提供服务
#define NCR11		0x11   //服务器不支持客户端请求的诊断服务
#define NCR12       0x12   //服务器不支持客户端请求服务的子功能
#define NCR13		0x13   //服务器认为客户端的请求报文的数据长度(或者格式)不符合本标准
#define NCR21		0x21   //服务器正忙，无法处理客户端发出的请求。此否定响应表明诊断服务结束
#define NCR22		0x22   //服务器执行诊断服务的条件不满足
#define NCR23		0x23   //
#define NCR24		0x24   //服务器认为诊断服务的请求(或者执行)顺序错误
#define NCR31		0x31   //服务器没有客户端请求的数据，此否定响应适用于支持数据读、写，或者根据数据调整功能的服务器
#define NCR32		0x32   //
#define NCR33		0x33   //服务器阻止客户端的受限诊断服务请求，原因包括：.. 服务器的测试条件不满足.. 服务器的安全状态处于锁定状态
#define NCR34		0x34   //	
#define NCR35		0x35   //服务器认为客户端返回的密钥错误
#define NCR36		0x36   //服务器认为客户端尝试安全访问(解锁)的失败次数超标
#define NCR37		0x37   //服务器拒绝客户端的安全访问请求，因为服务器允许接收请求的计时器未到时
#define NCR70       0x70   //服务器由于某种故障而拒绝客户端对服务器内存的上传/下载操作
#define NCR71		0x71   //服务器由于某种故障而终止了正在运行的数据传输
#define NCR72		0x72   //再擦除或者烧写非易失性内存的过程中，服务器由于发现错误而终止诊断服务
#define NCR73		0x73   //服务器发现客户端的发送数据(SID = 0x36)请求报文的blockSequenceCounter 计数错误
#define NCR78		0x78   //服务器正确接收到客户端发送的请求，正在处理中，但尚未处理完，此否定响应的发送时间应满足本标准第9.3.1节P2CAN_Server 的要求，并且服务器应重复发送此否定响应，直到完成操作。
#define NCR7e		0x7e   //在当前诊断模式下，服务器不支持客户端请求服务的子功能
#define NCR7f		0x7f   //在当前诊断模式下，服务器不支持客户端请求的SID
#define NCR92		0x92   //服务器认为蓄电池电压过高
#define NCR93		0x93   //服务器认为蓄电池电压过低

//system mode 
#define defaSession			0x01
#define progSession			0x02
#define exDiagSession		0x03
//#define defaSession		    0x04
//salfe mode
#define Salfe0          0
#define Salfe1			1
#define Salfe2          2
//////
#define  ErRequst     0x7f
#define Start        0x01
//#define Stop         0x02

////////////////////////DID
#define  DidFD01		0xfd01
#define  DidF181		0xf181
#define  DidF18b		0xf18b
#define  DidF18c        0xf18c
#define  DidF19d		0xf19d
#define  DidF1f1		0xf1f1
#define  DidF1f2		0xf1f2
#define  DidF1f3         0xf1f3
#define  DidF1f4         0xf1f4
#define  DidF120		0xf120
#define  DidF187		0xf187
#define  DidF18a		0xf18a
#define  DidF193		0xf193
#define  DidF195		0xf195
#define  DidF190		0XF190

#define  Didread        0x01
#define  Didwrite		0x02

//did  value
#define  DIDvalueF181    0x07db0c0e          //应用软件标识20111214
#define  DIDvalueF1f1     0x02                     //临时钥匙数量
#define  DIDvalueF120     0x56312E30          //网络协议版本信息
#define  DIDvalueF1871   0x33363030
#define  DIDvalueF1872   0x30343056
#define  DIDvalueF1873   0x3031                //整车厂定义的零件编号
#define  DIDvalueF18a1   0x434A4145
#define  DIDvalueF18a2   0x353230            //供应商标识符
#define  DIDvalueF193     0x48302E33          //ECU 硬件版本编号
#define  DIDvalueF195        0x53312E35          //ECU 软件版本编号
//extern uchar speedlockstate;

//A 0X41 56
// 1 0X31
//DTC NUMBER
#define   DTC9001      0
#define   DTC9003      1
#define   DTC9015      2
#define   DTC9111      3
#define   DTC9091      4
#define   DTC9083      5
#define   DTC9011      6
#define   DTC9023      7
#define   DTC9007      8
#define   DTC9043      9
#define   DTC9093      10
#define   DTC9061      11
#define   DTC9067      12
#define   DTC9045      13
#define   DTC9073      14
#define   DTC900C      15
#define   DTCD001      16
#define   DTCD002      17
#define   DTCD003      18
#define   DTCD004      19
#define   DTCD005      20

//DTC STATU
#define  DTCcycleFail     0x02
#define  DTCconfirmed     0x08
//time
#define  DTC48MS         	 6
#define  DTC96MS          	12
#define  DTC500MS         	63
#define  DTC1000MS          125
#define  DTC5000MS          625
#define  DTC10000MS         1250
#define  DTC1Min            7500
//battervalue 
#define  Batter9V          0x214
#define  Batter16V         0x3e6

#define salfe01     0x01
#define salfe02     0x02
#define salfe11     0x11
#define salfe12     0x12
#define salfe21     0x21
#define salfe22     0x22

extern unsigned char BCMvseed[4];
extern unsigned char BCMkey[4];


extern unsigned char DTCRuningstate;   //DTC诊断运行允许标志
extern unsigned char CommControl;  //非诊断报文通讯控制
//////////////////////////////
//typedef unsigned char  u8;
//#define u32 unsigned long
//#define u8  unsigned char 
/*
typedef enum
{
  FALSE = 0,
  TRUE = !FALSE
}
boolean;
*/
#define FALSE3   0
#define TRUE3    1


#define NUM_LEVEL_ONE_KEY       4
#define NUM_LEVEL_ONE_SEED      4
#define NUM_LEVEL_ONE_CONST     4

extern unsigned char  AppKeyConst[NUM_LEVEL_ONE_CONST];

extern unsigned char LevelOneKeyArith(unsigned char *vseed,unsigned char *GetLevelOnekey);

