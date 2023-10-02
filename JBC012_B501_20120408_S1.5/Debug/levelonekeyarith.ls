   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
   5                     .const:	section	.text
   6  0000               L3_vKey2:
   7  0000 00            	dc.b	0
   8  0001 00            	dc.b	0
   9  0002 00            	dc.b	0
  10  0003 00            	dc.b	0
 131                     ; 21 unsigned char  LevelOneKeyArith(const u8 *vseed,u8 *GetLevelOnekey)
 131                     ; 22 {
 132                     	switch	.text
 133  0000               f_LevelOneKeyArith:
 135  0000 89            	pushw	x
 136  0001 5219          	subw	sp,#25
 137       00000019      OFST:	set	25
 140                     ; 23 	u8 vKey1[NUM_LEVEL_ONE_KEY],vKey2[NUM_LEVEL_ONE_KEY] = {0,0,0,0};
 142  0003 96            	ldw	x,sp
 143  0004 1c0014        	addw	x,#OFST-5
 144  0007 90ae0000      	ldw	y,#L3_vKey2
 145  000b a604          	ld	a,#4
 146  000d 8d000000      	callf	d_xymvx
 148                     ; 25 	u32 tempkey = 0; 
 150  0011 5f            	clrw	x
 151  0012 1f10          	ldw	(OFST-9,sp),x
 152  0014 1f0e          	ldw	(OFST-11,sp),x
 153                     ; 26 	unsigned char  vResult = FALSE;
 155                     ; 34 		for(i = NUM_LEVEL_ONE_SEED;i > 0;i--)
 157  0016 a604          	ld	a,#4
 158  0018 6b19          	ld	(OFST+0,sp),a
 159  001a               L36:
 160                     ; 36 			vKey1[i - 1] = (u8)(vseed[i - 1] ^ AppKeyConst[i - 1]);
 162  001a 96            	ldw	x,sp
 163  001b 1c000a        	addw	x,#OFST-15
 164  001e 1f07          	ldw	(OFST-18,sp),x
 165  0020 5f            	clrw	x
 166  0021 97            	ld	xl,a
 167  0022 5a            	decw	x
 168  0023 72fb07        	addw	x,(OFST-18,sp)
 169  0026 905f          	clrw	y
 170  0028 9097          	ld	yl,a
 171  002a 905a          	decw	y
 172  002c 72f91a        	addw	y,(OFST+1,sp)
 173  002f 9089          	pushw	y
 174  0031 7b1b          	ld	a,(OFST+2,sp)
 175  0033 905f          	clrw	y
 176  0035 9097          	ld	yl,a
 177  0037 905a          	decw	y
 178  0039 90d60000      	ld	a,(_AppKeyConst,y)
 179  003d 9085          	popw	y
 180  003f 90f8          	xor	a,(y)
 181  0041 f7            	ld	(x),a
 182                     ; 38 			vRshift = 0x80;
 184  0042 a680          	ld	a,#128
 185  0044 6b12          	ld	(OFST-7,sp),a
 186                     ; 39 			vLshift = 0x01;
 188  0046 a601          	ld	a,#1
 189  0048 6b13          	ld	(OFST-6,sp),a
 190                     ; 40 			for(j = 0;j < 8;j++)
 192  004a 0f18          	clr	(OFST-1,sp)
 193  004c               L17:
 194                     ; 42 				if(vseed[NUM_LEVEL_ONE_SEED - i] & vRshift)
 196  004c 4f            	clr	a
 197  004d 97            	ld	xl,a
 198  004e a604          	ld	a,#4
 199  0050 1019          	sub	a,(OFST+0,sp)
 200  0052 2401          	jrnc	L6
 201  0054 5a            	decw	x
 202  0055               L6:
 203  0055 02            	rlwa	x,a
 204  0056 72fb1a        	addw	x,(OFST+1,sp)
 205  0059 f6            	ld	a,(x)
 206  005a 1512          	bcp	a,(OFST-7,sp)
 207  005c 2712          	jreq	L77
 208                     ; 44 					vKey2[i - 1] |= vLshift;
 210  005e 96            	ldw	x,sp
 211  005f 1c0014        	addw	x,#OFST-5
 212  0062 1f07          	ldw	(OFST-18,sp),x
 213  0064 7b19          	ld	a,(OFST+0,sp)
 214  0066 5f            	clrw	x
 215  0067 97            	ld	xl,a
 216  0068 5a            	decw	x
 217  0069 72fb07        	addw	x,(OFST-18,sp)
 218  006c f6            	ld	a,(x)
 219  006d 1a13          	or	a,(OFST-6,sp)
 220  006f f7            	ld	(x),a
 221  0070               L77:
 222                     ; 46 				vRshift >>= 1;
 224  0070 0412          	srl	(OFST-7,sp)
 225                     ; 47 				vLshift <<= 1;
 227  0072 0813          	sll	(OFST-6,sp)
 228                     ; 40 			for(j = 0;j < 8;j++)
 230  0074 0c18          	inc	(OFST-1,sp)
 233  0076 7b18          	ld	a,(OFST-1,sp)
 234  0078 a108          	cp	a,#8
 235  007a 25d0          	jrult	L17
 236                     ; 50 			vKey2[i - 1] = (u8)(vKey2[i - 1] ^ AppKeyConst[i - 1]);
 238  007c 96            	ldw	x,sp
 239  007d 1c0014        	addw	x,#OFST-5
 240  0080 1f07          	ldw	(OFST-18,sp),x
 241  0082 7b19          	ld	a,(OFST+0,sp)
 242  0084 5f            	clrw	x
 243  0085 97            	ld	xl,a
 244  0086 5a            	decw	x
 245  0087 72fb07        	addw	x,(OFST-18,sp)
 246  008a 905f          	clrw	y
 247  008c 9097          	ld	yl,a
 248  008e 905a          	decw	y
 249  0090 f6            	ld	a,(x)
 250  0091 90d80000      	xor	a,(_AppKeyConst,y)
 251  0095 f7            	ld	(x),a
 252                     ; 52 			vshift = (u8)((NUM_LEVEL_ONE_SEED - i) << 3);
 254  0096 a604          	ld	a,#4
 255  0098 1019          	sub	a,(OFST+0,sp)
 256  009a 48            	sll	a
 257  009b 48            	sll	a
 258  009c 48            	sll	a
 259  009d 6b18          	ld	(OFST-1,sp),a
 260                     ; 53 			tempkey += (u32)((u32)((u32)vKey1[i - 1] << (u32)vshift) + (u32)((u32)vKey2[i - 1] << (u32)vshift));
 262  009f 96            	ldw	x,sp
 263  00a0 1c0014        	addw	x,#OFST-5
 264  00a3 1f07          	ldw	(OFST-18,sp),x
 265  00a5 7b19          	ld	a,(OFST+0,sp)
 266  00a7 5f            	clrw	x
 267  00a8 97            	ld	xl,a
 268  00a9 5a            	decw	x
 269  00aa 72fb07        	addw	x,(OFST-18,sp)
 270  00ad f6            	ld	a,(x)
 271  00ae b703          	ld	c_lreg+3,a
 272  00b0 3f02          	clr	c_lreg+2
 273  00b2 3f01          	clr	c_lreg+1
 274  00b4 3f00          	clr	c_lreg
 275  00b6 7b18          	ld	a,(OFST-1,sp)
 276  00b8 8d000000      	callf	d_llsh
 278  00bc 96            	ldw	x,sp
 279  00bd 1c0003        	addw	x,#OFST-22
 280  00c0 8d000000      	callf	d_rtol
 282  00c4 96            	ldw	x,sp
 283  00c5 1c000a        	addw	x,#OFST-15
 284  00c8 1f01          	ldw	(OFST-24,sp),x
 285  00ca 7b19          	ld	a,(OFST+0,sp)
 286  00cc 5f            	clrw	x
 287  00cd 97            	ld	xl,a
 288  00ce 5a            	decw	x
 289  00cf 72fb01        	addw	x,(OFST-24,sp)
 290  00d2 f6            	ld	a,(x)
 291  00d3 b703          	ld	c_lreg+3,a
 292  00d5 3f02          	clr	c_lreg+2
 293  00d7 3f01          	clr	c_lreg+1
 294  00d9 3f00          	clr	c_lreg
 295  00db 7b18          	ld	a,(OFST-1,sp)
 296  00dd 8d000000      	callf	d_llsh
 298  00e1 96            	ldw	x,sp
 299  00e2 1c0003        	addw	x,#OFST-22
 300  00e5 8d000000      	callf	d_ladd
 302  00e9 96            	ldw	x,sp
 303  00ea 1c000e        	addw	x,#OFST-11
 304  00ed 8d000000      	callf	d_lgadd
 306                     ; 55 			GetLevelOnekey[i - 1] = (u8)(tempkey >> vshift);
 308  00f1 7b19          	ld	a,(OFST+0,sp)
 309  00f3 5f            	clrw	x
 310  00f4 97            	ld	xl,a
 311  00f5 5a            	decw	x
 312  00f6 72fb1f        	addw	x,(OFST+6,sp)
 313  00f9 7b11          	ld	a,(OFST-8,sp)
 314  00fb b703          	ld	c_lreg+3,a
 315  00fd 7b10          	ld	a,(OFST-9,sp)
 316  00ff b702          	ld	c_lreg+2,a
 317  0101 7b0f          	ld	a,(OFST-10,sp)
 318  0103 b701          	ld	c_lreg+1,a
 319  0105 7b0e          	ld	a,(OFST-11,sp)
 320  0107 b700          	ld	c_lreg,a
 321  0109 7b18          	ld	a,(OFST-1,sp)
 322  010b 8d000000      	callf	d_lursh
 324  010f b603          	ld	a,c_lreg+3
 325  0111 f7            	ld	(x),a
 326                     ; 34 		for(i = NUM_LEVEL_ONE_SEED;i > 0;i--)
 328  0112 0a19          	dec	(OFST+0,sp)
 331  0114 7b19          	ld	a,(OFST+0,sp)
 332  0116 2704ac1a001a  	jrne	L36
 333                     ; 58 		vResult = TRUE; 
 335  011c 7b09          	ld	a,(OFST-16,sp)
 336  011e 97            	ld	xl,a
 337                     ; 61 	return(vResult);
 339  011f a601          	ld	a,#1
 342  0121 5b1b          	addw	sp,#27
 343  0123 87            	retf	
 355                     	xdef	f_LevelOneKeyArith
 356                     	xref	_AppKeyConst
 357                     	xref.b	c_lreg
 376                     	xref	d_lursh
 377                     	xref	d_ltor
 378                     	xref	d_lgadd
 379                     	xref	d_ladd
 380                     	xref	d_rtol
 381                     	xref	d_llsh
 382                     	xref	d_xymvx
 383                     	end
