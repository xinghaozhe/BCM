/********************************************************************
*   Corypright (c) 2011.04, ����������װ���Ŀ��Ƽ�����
*   All rights reserved.
*
*�� �ļ���:		LevelOneKeyArith.h
*
*�� �ļ�����:	����������
*							���������ӡ��ܳס������ĳ��ȣ�
*							����������������       
*
********************************************************************/
//#ifndef _LEVELONE_KEY_ARITH_H_
//#define _LEVELONE_KEY_ARITH_H_

//typedef unsigned long  u32;
//typedef unsigned char  u8;
#define u32 unsigned long
#define u8  unsigned char 
/*
typedef enum
{
  FALSE = 0,
  TRUE = !FALSE
}
boolean;
*/
#define FALSE   0
#define TRUE    1


#define NUM_LEVEL_ONE_KEY       4
#define NUM_LEVEL_ONE_SEED      4
#define NUM_LEVEL_ONE_CONST     4

extern const u8 AppKeyConst[NUM_LEVEL_ONE_CONST];

extern unsigned char LevelOneKeyArith(const u8 *vseed,u8 *GetLevelOnekey);

//#endif