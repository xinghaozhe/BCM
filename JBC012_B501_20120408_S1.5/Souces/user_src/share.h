/*********************************************************************
  COPYRIGHT 2007 CJAE(Chongqing Jicheng Automobile Electronic Co., Ltd )
  All Rights Reserved
  FileName:              share.h
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
#include "stm8_type.h"
#include "stm8_lib.h"

#include "CAN_NM_OSEK.h"

/*********************************************************************
 TYPE DEFINITION
*********************************************************************/
/* compiler independent data type */
//#define uchar   u8
//#define uint    u16
//#define ulong   u32
//typedef unsigned int  uint;
//typedef unsigned long ulong;

/*********************************************************************
 MACRO DEFINITION
*********************************************************************/
#define Nop               {asm nop;}
/* B bit definition [0,1,2,3,4,5,6,7] */
#define _bset(A,B)        (A |=  (0x01<<(B)))
#define _bres(A,B)        (A &= ~(0x01<<(B)))
#define _btog(A,B)        (A ^=  (0x01<<(B)))
#define _btst(A,B)        ((A) & (0x01<<(B)))

/* B bit definition [01,02,04,08,10,20,40,80] */
#define _BSET(A,B)        (A |=  B)
#define _BRES(A,B)        (A &= ~B)
#define _BTOG(A,B)        (A ^=  B)
#define _BTST(A,B)        ((A) & B)

/*
typedef unsigned long  ulong;
typedef unsigned int   uint;
typedef unsigned char  uchar;
*/
/*********************************************************************
 BIT DEFINITION
*********************************************************************/
#define BIT0    0x0001    
#define BIT1    0x0002    
#define BIT2    0x0004    
#define BIT3    0x0008    
#define BIT4    0x0010    
#define BIT5    0x0020    
#define BIT6    0x0040    
#define BIT7    0x0080    
#define BIT8    0x0100    
#define BIT9    0x0200    
#define BIT10   0x0400    
#define BIT11   0x0800
#define BIT12   0x1000    
#define BIT13   0x1000
#define BIT14   0x4000    
#define BIT15   0x8000    

#ifndef TRUE
#define TRUE  1
#endif

#ifndef FALSE 
#define FALSE 0
#endif

#ifndef HIGH  
#define HIGH  1
#endif

#ifndef LOW  
#define LOW   0
#endif


#ifndef NULL
#define NULL  ((void *) 0)
#endif

//switch state definition
#define     Unpressed       0x00
#define     Pressed         0x55
//door state definition
//#define     Open            0x00
//#define     Closed          0x55
//driver state definition
#define     OFF             0x00
#define     ON              0x55


/*********************************************************************
 CONSTANT DEFINITION
*********************************************************************/
#define	    KEY_FILTER_CNT		    5   // 5*8ms = 40ms
#define     AD_KEY_FILTER_CNT       15//30

/*********************************************************************
 end of the share.h file
*********************************************************************/



