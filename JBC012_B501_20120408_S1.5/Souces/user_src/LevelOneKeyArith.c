/********************************************************************
*   Corypright (c) 2011.04, ����������װ���Ŀ��Ƽ�����
*   All rights reserved.
*
*�� �ļ���:		LevelOneKeyArith.c
*
*�� �ļ�����:	�����˰�ȫ����İ�ȫ�㷨����
*							       
*
********************************************************************/

#include "LevelOneKeyArith.h"

/**********************************************
* �������ܣ��������Ӽ��㰲ȫ����һ���ܳ�
* ���������vseed���ӣ�����						
* ���������Getkey�ܳ�
* ����ֵ��	�ܳ׼�����
**********************************************/

unsigned char  LevelOneKeyArith(const u8 *vseed,u8 *GetLevelOnekey)
{
	u8 vKey1[NUM_LEVEL_ONE_KEY],vKey2[NUM_LEVEL_ONE_KEY] = {0,0,0,0};
	u8 i,j,vshift,vRshift,vLshift;
	u32 tempkey = 0; 
	unsigned char  vResult = FALSE;

	/*if((vseed == NULL) || (GetLevelOnekey == NULL))
	{
    	vResult = FALSE;15002317613 
	}
	else
	{*/
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
			
		vResult = TRUE; 
	//}
    
	return(vResult);
}