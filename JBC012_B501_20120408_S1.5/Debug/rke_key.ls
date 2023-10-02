   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
  59                     ; 5 void DECRYPT(unsigned int* In, unsigned int* Out, unsigned int* S)
  59                     ; 6 {
  60                     	switch	.text
  61  0000               f_DECRYPT:
  63  0000 89            	pushw	x
  64  0001 5b02          	addw	sp,#2
  65       00000004      OFST:	set	4
  68                     ; 10 	X = In[0];
  70                     ; 11 	Y = In[1];
  72                     ; 21 }
  75  0003 87            	retf	
  77                     .const:	section	.text
  78  0000               L33_f_SKey_C:
  79  0000 6666          	dc.w	26214
  80  0002 7777          	dc.w	30583
  81  0004 8888          	dc.w	-30584
  82  0006 1111          	dc.w	4369
  83  0008 2222          	dc.w	8738
  84  000a 3333          	dc.w	13107
  85  000c 4444          	dc.w	17476
  86  000e 5555          	dc.w	21845
  87  0010 6666          	dc.w	26214
  88  0012 7777          	dc.w	30583
  89  0014 8888          	dc.w	-30584
  90  0016 1111          	dc.w	4369
  91  0018 2222          	dc.w	8738
 134                     ; 23 void Rke_key_new(unsigned int *Header,unsigned int *A_Code,unsigned int *B_Code)
 134                     ; 24 {
 135                     	switch	.text
 136  0004               f_Rke_key_new:
 138  0004 521a          	subw	sp,#26
 139       0000001a      OFST:	set	26
 142                     ; 27        const unsigned int  f_SKey_C[13]  =  {0x6666,0x7777,0x8888, 0x1111,0x2222,0x3333,0x4444,0x5555,0x6666,0x7777,0x8888,
 142                     ; 28                                                         0x1111,0x2222
 142                     ; 29                                                       };  //production keys for key 1,52 byte
 144  0006 96            	ldw	x,sp
 145  0007 5c            	incw	x
 146  0008 90ae0000      	ldw	y,#L33_f_SKey_C
 147  000c a61a          	ld	a,#26
 148  000e 8d000000      	callf	d_xymvx
 150                     ; 47 }
 153  0012 5b1a          	addw	sp,#26
 154  0014 87            	retf	
 166                     	xdef	f_Rke_key_new
 167                     	xdef	f_DECRYPT
 186                     	xref	d_xymvx
 187                     	end
