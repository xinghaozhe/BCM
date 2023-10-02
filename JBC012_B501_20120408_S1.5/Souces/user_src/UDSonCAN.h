
//��Ӧ�ò�ӿڱ���
// 1 δȷ�Ϸֶ����ݴ�������
typedef volatile struct
{
     unsigned char Request;
	 unsigned char Indication;
	 unsigned char Confirmation;
}UDSData;
// 2 δȷ�Ϸֶ����ݴ���ĵ�һ֡����
typedef volatile struct
{
	 unsigned char Indication;
}USData_FF;
// 3 ����������������
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

//��֡
extern unsigned char SF_FS;//N_PDU.PCI�ĵ�4λ
extern unsigned int  FF_DL;
extern unsigned char CF_SN;
extern unsigned char TYPE;//N_PDU.PCI�ĸ�4λ
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
#define NCRright    0x00   //��ȷ
#define NCR10       0x10   //ʹ�ô˷���ܾ���ͻ����ṩ����
#define NCR11		0x11   //��������֧�ֿͻ����������Ϸ���
#define NCR12       0x12   //��������֧�ֿͻ������������ӹ���
#define NCR13		0x13   //��������Ϊ�ͻ��˵������ĵ����ݳ���(���߸�ʽ)�����ϱ���׼
#define NCR21		0x21   //��������æ���޷�����ͻ��˷��������󡣴˷���Ӧ������Ϸ������
#define NCR22		0x22   //������ִ����Ϸ��������������
#define NCR23		0x23   //
#define NCR24		0x24   //��������Ϊ��Ϸ��������(����ִ��)˳�����
#define NCR31		0x31   //������û�пͻ�����������ݣ��˷���Ӧ������֧�����ݶ���д�����߸������ݵ������ܵķ�����
#define NCR32		0x32   //
#define NCR33		0x33   //��������ֹ�ͻ��˵�������Ϸ�������ԭ�������.. �������Ĳ�������������.. �������İ�ȫ״̬��������״̬
#define NCR34		0x34   //	
#define NCR35		0x35   //��������Ϊ�ͻ��˷��ص���Կ����
#define NCR36		0x36   //��������Ϊ�ͻ��˳��԰�ȫ����(����)��ʧ�ܴ�������
#define NCR37		0x37   //�������ܾ��ͻ��˵İ�ȫ����������Ϊ�����������������ļ�ʱ��δ��ʱ
#define NCR70       0x70   //����������ĳ�ֹ��϶��ܾ��ͻ��˶Է������ڴ���ϴ�/���ز���
#define NCR71		0x71   //����������ĳ�ֹ��϶���ֹ���������е����ݴ���
#define NCR72		0x72   //�ٲ���������д����ʧ���ڴ�Ĺ����У����������ڷ��ִ������ֹ��Ϸ���
#define NCR73		0x73   //���������ֿͻ��˵ķ�������(SID = 0x36)�����ĵ�blockSequenceCounter ��������
#define NCR78		0x78   //��������ȷ���յ��ͻ��˷��͵��������ڴ����У�����δ�����꣬�˷���Ӧ�ķ���ʱ��Ӧ���㱾��׼��9.3.1��P2CAN_Server ��Ҫ�󣬲��ҷ�����Ӧ�ظ����ʹ˷���Ӧ��ֱ����ɲ�����
#define NCR7e		0x7e   //�ڵ�ǰ���ģʽ�£���������֧�ֿͻ������������ӹ���
#define NCR7f		0x7f   //�ڵ�ǰ���ģʽ�£���������֧�ֿͻ��������SID
#define NCR92		0x92   //��������Ϊ���ص�ѹ����
#define NCR93		0x93   //��������Ϊ���ص�ѹ����

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
#define  DIDvalueF181    0x07db0c0e          //Ӧ�������ʶ20111214
#define  DIDvalueF1f1     0x02                     //��ʱԿ������
#define  DIDvalueF120     0x56312E30          //����Э��汾��Ϣ
#define  DIDvalueF1871   0x33363030
#define  DIDvalueF1872   0x30343056
#define  DIDvalueF1873   0x3031                //�����������������
#define  DIDvalueF18a1   0x434A4145
#define  DIDvalueF18a2   0x353230            //��Ӧ�̱�ʶ��
#define  DIDvalueF193     0x48302E33          //ECU Ӳ���汾���
#define  DIDvalueF195        0x53312E35          //ECU ����汾���
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


extern unsigned char DTCRuningstate;   //DTC������������־
extern unsigned char CommControl;  //����ϱ���ͨѶ����
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

