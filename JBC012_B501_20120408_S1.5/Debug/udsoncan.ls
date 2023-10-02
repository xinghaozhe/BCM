   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   3                     ; Optimizer V4.2.4 - 18 Dec 2007
  23                     	switch	.data
  24  0000               L3_CFcnt:
  25  0000 00            	dc.b	0
  26  0001               L7_Toalcfcnt:
  27  0001 0000          	dc.w	0
  28  0003               L11_Toalsendcnt:
  29  0003 0000          	dc.w	0
  30  0005               L52_commcontrl:
  31  0005 00            	dc.b	0
  32  0006               L72_buzystate:
  33  0006 00            	dc.b	0
  34                     	switch	.bss
  35  0000               L32_RECcntk:
  36  0000 0000          	ds.b	2
  37  0002               L5_qonestate:
  38  0002 00            	ds.b	1
  39  0003               L53_CFRstate:
  40  0003 00            	ds.b	1
  41  0004               L73_NBSstate:
  42  0004 00            	ds.b	1
  43  0005               L12_RECtoalcnt:
  44  0005 0000          	ds.b	2
  45  0007               L71_Recfftoal:
  46  0007 0000          	ds.b	2
  47  0009               L31_Toalsenddata:
  48  0009 0000          	ds.b	2
  49  000b               L13_state:
  50  000b 00            	ds.b	1
  51  000c               L51_Timecnt:
  52  000c 00            	ds.b	1
  53  000d               L33_duostate:
  54  000d 00            	ds.b	1
 211                     ; 111 void UDSonCAN_netmain(void)
 211                     ; 112 {
 212                     	switch	.text
 213  0000               f_UDSonCAN_netmain:
 215  0000 5203          	subw	sp,#3
 216       00000003      OFST:	set	3
 219                     ; 124    if(N_BS)
 221  0002 ce0061        	ldw	x,_N_BS
 222  0005 2712          	jreq	L551
 223                     ; 126          N_BS--;
 225  0007 5a            	decw	x
 226  0008 cf0061        	ldw	_N_BS,x
 227                     ; 127 	  if(N_BS == 0)
 229  000b 260c          	jrne	L551
 230                     ; 129 	  	N_UDSDdata.Request = 0;
 232  000d 725f0283      	clr	_N_UDSDdata
 233                     ; 130          	qonestate == 0;
 235  0011 725d0002      	tnz	L5_qonestate
 236                     ; 131 	       CFRstate =0;
 238  0015 725f0003      	clr	L53_CFRstate
 239  0019               L551:
 240                     ; 135    if(N_UDSDdata.Request != 0)
 242  0019 725d0283      	tnz	_N_UDSDdata
 243  001d 2604acf602f6  	jreq	L161
 244                     ; 137        switch(N_UDSDdata.Request )
 246  0023 c60283        	ld	a,_N_UDSDdata
 248                     ; 266 		   default:break;
 249  0026 4a            	dec	a
 250  0027 2715          	jreq	L14
 251  0029 4a            	dec	a
 252  002a 274c          	jreq	L34
 253  002c 4a            	dec	a
 254  002d 2604aced00ed  	jreq	L54
 255  0033 4a            	dec	a
 256  0034 2604ac7b027b  	jreq	L75
 257  003a acf602f6      	jra	L161
 258  003e               L14:
 259                     ; 141 				NBSstate = 0;
 261  003e c70004        	ld	L73_NBSstate,a
 262                     ; 142                         CAN_send2(TesterBCM,8,N_PDU[0].PCI,N_PDU[0].Data[0],N_PDU[0].Data[1],N_PDU[0].Data[2],N_PDU[0].Data[3],N_PDU[0].Data[4],N_PDU[0].Data[5],N_PDU[0].Data[6]);
 264  0041 3b0176        	push	_N_PDU+9
 265  0044 3b0175        	push	_N_PDU+8
 266  0047 3b0174        	push	_N_PDU+7
 267  004a 3b0173        	push	_N_PDU+6
 268  004d 3b0172        	push	_N_PDU+5
 269  0050 3b0171        	push	_N_PDU+4
 270  0053 3b0170        	push	_N_PDU+3
 271  0056 3b016f        	push	_N_PDU+2
 272  0059 4b08          	push	#8
 273  005b ae0708        	ldw	x,#1800
 274  005e 8d000000      	callf	f_CAN_send2
 276  0062 5b09          	addw	sp,#9
 277                     ; 143 			   N_UDSDdata.Request = 0;
 279  0064 725f0283      	clr	_N_UDSDdata
 280                     ; 144 			   qonestate == 0;
 282  0068 725d0002      	tnz	L5_qonestate
 283                     ; 145 			   N_UDSDdata.Confirmation = ConfirmationOK;
 285  006c 35010285      	mov	_N_UDSDdata+2,#1
 286                     ; 146 			   ClearNPDUbuff();
 288  0070 8da320a3      	callf	f_ClearNPDUbuff
 290                     ; 148 		   	break;
 292  0074 acf602f6      	jra	L161
 293  0078               L34:
 294                     ; 151 			   NBSstate = 0;
 296  0078 c70004        	ld	L73_NBSstate,a
 297                     ; 152 			   if(qonestate != 0) {N_UDSDdata.Request = 0;break;}
 299  007b 725d0002      	tnz	L5_qonestate
 300  007f 2707          	jreq	L761
 303  0081 c70283        	ld	_N_UDSDdata,a
 306  0084 acf602f6      	jra	L161
 307  0088               L761:
 308                     ; 153                         CAN_send2(TesterBCM,8,N_PDU[0].PCI,N_PDU[0].Data[0],N_PDU[0].Data[1],N_PDU[0].Data[2],N_PDU[0].Data[3],N_PDU[0].Data[4],N_PDU[0].Data[5],N_PDU[0].Data[6]);
 310  0088 3b0176        	push	_N_PDU+9
 311  008b 3b0175        	push	_N_PDU+8
 312  008e 3b0174        	push	_N_PDU+7
 313  0091 3b0173        	push	_N_PDU+6
 314  0094 3b0172        	push	_N_PDU+5
 315  0097 3b0171        	push	_N_PDU+4
 316  009a 3b0170        	push	_N_PDU+3
 317  009d 3b016f        	push	_N_PDU+2
 318  00a0 4b08          	push	#8
 319  00a2 ae0708        	ldw	x,#1800
 320  00a5 8d000000      	callf	f_CAN_send2
 322  00a9 5b09          	addw	sp,#9
 323                     ; 155 			   qonestate = 0x55;
 325  00ab 35550002      	mov	L5_qonestate,#85
 326                     ; 156 			   CFRstate = 1;//add  send dd
 328  00af 35010003      	mov	L53_CFRstate,#1
 329                     ; 157 			   Toalsendcnt = N_PDU[0].PCI & 0x0f;
 331  00b3 c6016f        	ld	a,_N_PDU+2
 332  00b6 a40f          	and	a,#15
 333  00b8 5f            	clrw	x
 334  00b9 97            	ld	xl,a
 335  00ba cf0003        	ldw	L11_Toalsendcnt,x
 336                     ; 158 			   Toalsendcnt =(Toalsendcnt<< 8)+N_PDU[0].Data[0];
 338  00bd 4f            	clr	a
 339  00be cb0170        	add	a,_N_PDU+3
 340  00c1 2401          	jrnc	L42
 341  00c3 5c            	incw	x
 342  00c4               L42:
 343  00c4 c70004        	ld	L11_Toalsendcnt+1,a
 344  00c7 9f            	ld	a,xl
 345  00c8 c70003        	ld	L11_Toalsendcnt,a
 346                     ; 159 			   Toalsenddata = 6;
 348  00cb ae0006        	ldw	x,#6
 349  00ce cf0009        	ldw	L31_Toalsenddata,x
 350                     ; 160 			   Toalcfcnt = 1;
 352  00d1 ae0001        	ldw	x,#1
 353  00d4 cf0001        	ldw	L7_Toalcfcnt,x
 354                     ; 161 			   N_UDSDdata.Request = 0;
 356  00d7 725f0283      	clr	_N_UDSDdata
 357                     ; 162 			   commcontrl = 1;
 359  00db 35010005      	mov	L52_commcontrl,#1
 360                     ; 163 			   CFcnt = 0;
 362  00df 725f0000      	clr	L3_CFcnt
 363                     ; 164 			   N_BS = 75; //150ms
 365  00e3 ae004b        	ldw	x,#75
 366  00e6 cf0061        	ldw	_N_BS,x
 367                     ; 168 		   	break;
 369  00e9 acf602f6      	jra	L161
 370  00ed               L54:
 371                     ; 172                switch(SF_FS)
 373  00ed c6024e        	ld	a,_SF_FS
 375                     ; 239 				  default:break;
 376  00f0 2712          	jreq	L74
 377  00f2 4a            	dec	a
 378  00f3 2604ac3f023f  	jreq	L15
 379  00f9 4a            	dec	a
 380  00fa 2604ac560256  	jreq	L35
 381  0100 acf602f6      	jra	L161
 382  0104               L74:
 383                     ; 174                   case 0:
 383                     ; 175                                    NBSstate = 0;
 385  0104 c70004        	ld	L73_NBSstate,a
 386                     ; 176 				  	Timecnt = Timecnt + 2;
 388  0107 725c000c      	inc	L51_Timecnt
 389  010b 725c000c      	inc	L51_Timecnt
 390                     ; 177 				  	if(Timecnt > (STmin+10))
 392  010f c6000c        	ld	a,L51_Timecnt
 393  0112 5f            	clrw	x
 394  0113 97            	ld	xl,a
 395  0114 bf01          	ldw	c_x+1,x
 396  0116 c60065        	ld	a,_STmin
 397  0119 905f          	clrw	y
 398  011b 9097          	ld	yl,a
 399  011d 72a9000a      	addw	y,#10
 400  0121 90b301        	cpw	y,c_x+1
 401  0124 2eda          	jrsge	L161
 402                     ; 179 				  	       if(qonestate == 0)
 404  0126 725d0002      	tnz	L5_qonestate
 405                     ; 181 					            N_UDSDdata.Request = 0; 
 406                     ; 182 						    break;
 408  012a 2604acf202f2  	jreq	L512
 409                     ; 184 				  	    Timecnt = 0;
 411  0130 725f000c      	clr	L51_Timecnt
 412                     ; 185 					  	CAN_send2(TesterBCM,8,(CF|(CFcnt&0x0f))+1,N_PDU[Toalcfcnt].Data[0],N_PDU[Toalcfcnt].Data[1],N_PDU[Toalcfcnt].Data[2],N_PDU[Toalcfcnt].Data[3],N_PDU[Toalcfcnt].Data[4],N_PDU[Toalcfcnt].Data[5],N_PDU[Toalcfcnt].Data[6]);
 414  0134 ce0001        	ldw	x,L7_Toalcfcnt
 415  0137 90ae000a      	ldw	y,#10
 416  013b 8d000000      	callf	d_imul
 418  013f d60176        	ld	a,(_N_PDU+9,x)
 419  0142 88            	push	a
 420  0143 ce0001        	ldw	x,L7_Toalcfcnt
 421  0146 90ae000a      	ldw	y,#10
 422  014a 8d000000      	callf	d_imul
 424  014e d60175        	ld	a,(_N_PDU+8,x)
 425  0151 88            	push	a
 426  0152 ce0001        	ldw	x,L7_Toalcfcnt
 427  0155 90ae000a      	ldw	y,#10
 428  0159 8d000000      	callf	d_imul
 430  015d d60174        	ld	a,(_N_PDU+7,x)
 431  0160 88            	push	a
 432  0161 ce0001        	ldw	x,L7_Toalcfcnt
 433  0164 90ae000a      	ldw	y,#10
 434  0168 8d000000      	callf	d_imul
 436  016c d60173        	ld	a,(_N_PDU+6,x)
 437  016f 88            	push	a
 438  0170 ce0001        	ldw	x,L7_Toalcfcnt
 439  0173 90ae000a      	ldw	y,#10
 440  0177 8d000000      	callf	d_imul
 442  017b d60172        	ld	a,(_N_PDU+5,x)
 443  017e 88            	push	a
 444  017f ce0001        	ldw	x,L7_Toalcfcnt
 445  0182 90ae000a      	ldw	y,#10
 446  0186 8d000000      	callf	d_imul
 448  018a d60171        	ld	a,(_N_PDU+4,x)
 449  018d 88            	push	a
 450  018e ce0001        	ldw	x,L7_Toalcfcnt
 451  0191 90ae000a      	ldw	y,#10
 452  0195 8d000000      	callf	d_imul
 454  0199 d60170        	ld	a,(_N_PDU+3,x)
 455  019c 88            	push	a
 456  019d c60000        	ld	a,L3_CFcnt
 457  01a0 a40f          	and	a,#15
 458  01a2 aa20          	or	a,#32
 459  01a4 4c            	inc	a
 460  01a5 88            	push	a
 461  01a6 4b08          	push	#8
 462  01a8 ae0708        	ldw	x,#1800
 463  01ab 8d000000      	callf	f_CAN_send2
 465  01af 5b09          	addw	sp,#9
 466                     ; 186 						if(Toalcfcnt < 20)Toalcfcnt++;
 468  01b1 ce0001        	ldw	x,L7_Toalcfcnt
 469  01b4 a30014        	cpw	x,#20
 470  01b7 2406          	jruge	L102
 473  01b9 5c            	incw	x
 474  01ba cf0001        	ldw	L7_Toalcfcnt,x
 476  01bd 2018          	jra	L302
 477  01bf               L102:
 478                     ; 189 							N_UDSDdata.Confirmation = ConfirmationER;
 480  01bf 35020285      	mov	_N_UDSDdata+2,#2
 481                     ; 190 							commcontrl = 0;
 483  01c3 725f0005      	clr	L52_commcontrl
 484                     ; 191 							N_UDSDdata.Request = 0;
 486  01c7 725f0283      	clr	_N_UDSDdata
 487                     ; 192 							qonestate = 0;
 489  01cb 725f0002      	clr	L5_qonestate
 490                     ; 193 							duostate = 0;
 492  01cf 725f000d      	clr	L33_duostate
 493                     ; 194 							CFRstate=0;
 495  01d3 725f0003      	clr	L53_CFRstate
 496  01d7               L302:
 497                     ; 196 						Toalsenddata =Toalsenddata+7;
 499  01d7 ce0009        	ldw	x,L31_Toalsenddata
 500  01da 1c0007        	addw	x,#7
 501  01dd cf0009        	ldw	L31_Toalsenddata,x
 502                     ; 197 						CFcnt++;
 504  01e0 725c0000      	inc	L3_CFcnt
 505                     ; 198 						if(((CFcnt % BS )== 0)&&(BS!=0))
 507  01e4 c60000        	ld	a,L3_CFcnt
 508  01e7 5f            	clrw	x
 509  01e8 97            	ld	xl,a
 510  01e9 c60064        	ld	a,_BS
 511  01ec 905f          	clrw	y
 512  01ee 9097          	ld	yl,a
 513  01f0 8d000000      	callf	d_idiv
 515  01f4 905d          	tnzw	y
 516  01f6 2609          	jrne	L502
 518  01f8 c60064        	ld	a,_BS
 519  01fb 2704          	jreq	L502
 520                     ; 201 						   SF_FS = 1;
 522  01fd 3501024e      	mov	_SF_FS,#1
 523  0201               L502:
 524                     ; 203 						if(Toalsenddata >= Toalsendcnt)
 526  0201 ce0009        	ldw	x,L31_Toalsenddata
 527  0204 c30003        	cpw	x,L11_Toalsendcnt
 528  0207 2404acf602f6  	jrult	L161
 529                     ; 205 							N_UDSDdata.Confirmation = ConfirmationOK;
 531  020d 35010285      	mov	_N_UDSDdata+2,#1
 532                     ; 206 							duostate = 0;
 534  0211 725f000d      	clr	L33_duostate
 535                     ; 207 							commcontrl = 0;
 537  0215 725f0005      	clr	L52_commcontrl
 538                     ; 208 							N_UDSDdata.Request = 0;
 540  0219 725f0283      	clr	_N_UDSDdata
 541                     ; 209 							CFRstate = 0;
 543  021d 725f0003      	clr	L53_CFRstate
 544                     ; 210 							TYPE = 0;
 546  0221 725f024a      	clr	_TYPE
 547                     ; 211 						       Toalsendcnt = 0;
 549  0225 5f            	clrw	x
 550  0226 cf0003        	ldw	L11_Toalsendcnt,x
 551                     ; 212 						       Toalsenddata = 0;
 553  0229 cf0009        	ldw	L31_Toalsenddata,x
 554                     ; 213 						       Toalcfcnt = 0;
 556  022c cf0001        	ldw	L7_Toalcfcnt,x
 557                     ; 214 							CFcnt = 0; 
 559  022f 725f0000      	clr	L3_CFcnt
 560                     ; 215 							qonestate = 0;
 562  0233 725f0002      	clr	L5_qonestate
 563                     ; 216 							ClearNPDUbuff();
 565  0237 8da320a3      	callf	f_ClearNPDUbuff
 567  023b acf602f6      	jra	L161
 568  023f               L15:
 569                     ; 220 				  case 1:
 569                     ; 221 				  	//wait sf_fs==0 countion
 569                     ; 222 				  	SF_FS = 1;
 571  023f 3501024e      	mov	_SF_FS,#1
 572                     ; 223 					if(NBSstate == 0){N_BS = 75; NBSstate = 0x55;} //150ms
 574  0243 c60004        	ld	a,L73_NBSstate
 575  0246 26f3          	jrne	L161
 578  0248 ae004b        	ldw	x,#75
 579  024b cf0061        	ldw	_N_BS,x
 582  024e 35550004      	mov	L73_NBSstate,#85
 583  0252 acf602f6      	jra	L161
 584  0256               L35:
 585                     ; 225 				  case 2:
 585                     ; 226 				  	   NBSstate = 0;
 587  0256 c70004        	ld	L73_NBSstate,a
 588                     ; 227 				  	   N_Result = ConfirmationOverflow;
 590  0259 35030249      	mov	_N_Result,#3
 591                     ; 228 					   N_BS = 0;
 593  025d 5f            	clrw	x
 594  025e cf0061        	ldw	_N_BS,x
 595                     ; 229 					   N_UDSDdata.Request = 0;
 597  0261 c70283        	ld	_N_UDSDdata,a
 598                     ; 230 					   commcontrl = 0;
 600  0264 c70005        	ld	L52_commcontrl,a
 601                     ; 231 					   qonestate = 0;
 603  0267 c70002        	ld	L5_qonestate,a
 604                     ; 232 					   Toalsendcnt = 0;
 606  026a cf0003        	ldw	L11_Toalsendcnt,x
 607                     ; 233 					   Toalsenddata = 0;
 609  026d cf0009        	ldw	L31_Toalsenddata,x
 610                     ; 234 					   Toalcfcnt = 0;
 612  0270 cf0001        	ldw	L7_Toalcfcnt,x
 613                     ; 235 					   CFcnt = 0;
 615  0273 c70000        	ld	L3_CFcnt,a
 616                     ; 236 					   CFRstate =0;
 618  0276 c70003        	ld	L53_CFRstate,a
 619                     ; 238 				  break;
 621  0279 207b          	jra	L161
 622                     ; 239 				  default:break;
 624                     ; 243 		   	break;
 626  027b               L75:
 627                     ; 244 		   case RequestsendFC:
 627                     ; 245 		   	
 627                     ; 246 		   	   if(Recfftoal > RecMaxlong)
 629  027b ce0007        	ldw	x,L71_Recfftoal
 630  027e a30079        	cpw	x,#121
 631  0281 2521          	jrult	L312
 632                     ; 248 					N_Result = ConfirmationOverflow;
 634  0283 35030249      	mov	_N_Result,#3
 635                     ; 249 			              CAN_send2(TesterBCM,8,0X32,0X10,0X15,0,0,0,0,0);
 637  0287 4b00          	push	#0
 638  0289 4b00          	push	#0
 639  028b 4b00          	push	#0
 640  028d 4b00          	push	#0
 641  028f 4b00          	push	#0
 642  0291 4b15          	push	#21
 643  0293 4b10          	push	#16
 644  0295 4b32          	push	#50
 645  0297 4b08          	push	#8
 646  0299 ae0708        	ldw	x,#1800
 647  029c 8d000000      	callf	f_CAN_send2
 649  02a0 5b09          	addw	sp,#9
 651  02a2 204e          	jra	L512
 652  02a4               L312:
 653                     ; 251 			   else if(N_UDSDdata.Indication != 0)  //数据未处理
 655  02a4 725d0284      	tnz	_N_UDSDdata+1
 656  02a8 2723          	jreq	L712
 657                     ; 253 					CAN_send2(TesterBCM,8,0X31,0X10,0X15,0,0,0,0,0);
 659  02aa 4b00          	push	#0
 660  02ac 4b00          	push	#0
 661  02ae 4b00          	push	#0
 662  02b0 4b00          	push	#0
 663  02b2 4b00          	push	#0
 664  02b4 4b15          	push	#21
 665  02b6 4b10          	push	#16
 666  02b8 4b31          	push	#49
 667  02ba 4b08          	push	#8
 668  02bc ae0708        	ldw	x,#1800
 669  02bf 8d000000      	callf	f_CAN_send2
 671  02c3 5b09          	addw	sp,#9
 672                     ; 254 					N_BS = 75; //150ms
 674  02c5 ae004b        	ldw	x,#75
 675  02c8 cf0061        	ldw	_N_BS,x
 677  02cb 2025          	jra	L512
 678  02cd               L712:
 679                     ; 258 					CAN_send2(TesterBCM,8,0X30,0X10,0X15,0,0,0,0,0);
 681  02cd 4b00          	push	#0
 682  02cf 4b00          	push	#0
 683  02d1 4b00          	push	#0
 684  02d3 4b00          	push	#0
 685  02d5 4b00          	push	#0
 686  02d7 4b15          	push	#21
 687  02d9 4b10          	push	#16
 688  02db 4b30          	push	#48
 689  02dd 4b08          	push	#8
 690  02df ae0708        	ldw	x,#1800
 691  02e2 8d000000      	callf	f_CAN_send2
 693  02e6 5b09          	addw	sp,#9
 694                     ; 259 					N_BS = 75; //150ms
 696  02e8 ae004b        	ldw	x,#75
 697  02eb cf0061        	ldw	_N_BS,x
 698                     ; 260 					duostate=1;
 700  02ee 3501000d      	mov	L33_duostate,#1
 701  02f2               L512:
 702                     ; 264 			   N_UDSDdata.Request =0;
 705  02f2 725f0283      	clr	_N_UDSDdata
 706                     ; 265 		   	break;
 708                     ; 266 		   default:break;
 710  02f6               L161:
 711                     ; 273    if(UDSRITcnt != UDSRuscnt)
 713  02f6 c60250        	ld	a,_UDSRITcnt
 714  02f9 c1024f        	cp	a,_UDSRuscnt
 715  02fc 2740          	jreq	L44
 716                     ; 275    	UDSRuscnt++;
 718  02fe 725c024f      	inc	_UDSRuscnt
 719                     ; 276        if(UDSRuscnt >= Reclong) UDSRuscnt = 0;
 721  0302 c6024f        	ld	a,_UDSRuscnt
 722  0305 a105          	cp	a,#5
 723  0307 2504          	jrult	L522
 726  0309 4f            	clr	a
 727  030a c7024f        	ld	_UDSRuscnt,a
 728  030d               L522:
 729                     ; 278        if(RecData[UDSRuscnt].AI != TesterID) {RecData[UDSRuscnt].AI = 0;return;}
 731  030d 97            	ld	xl,a
 732  030e a60a          	ld	a,#10
 733  0310 42            	mul	x,a
 734  0311 9093          	ldw	y,x
 735  0313 90de0251      	ldw	y,(_RecData,y)
 736  0317 90a30700      	cpw	y,#1792
 737  031b 2707          	jreq	L722
 740  031d 905f          	clrw	y
 741  031f df0251        	ldw	(_RecData,x),y
 744  0322 201a          	jra	L44
 745  0324               L722:
 746                     ; 279 	   RecData[UDSRuscnt].AI = 0;
 748  0324 905f          	clrw	y
 749  0326 df0251        	ldw	(_RecData,x),y
 750                     ; 283 	   TYPE = RecData[UDSRuscnt].PCI & 0xF0;
 752  0329 d60253        	ld	a,(_RecData+2,x)
 753  032c a4f0          	and	a,#240
 754  032e c7024a        	ld	_TYPE,a
 755                     ; 285 	   if((CFRstate ==1) &&(TYPE != FC))return;   //多帧发送过程中接收到单帧命令不响应
 757  0331 c60003        	ld	a,L53_CFRstate
 758  0334 4a            	dec	a
 759  0335 260a          	jrne	L132
 761  0337 c6024a        	ld	a,_TYPE
 762  033a a130          	cp	a,#48
 763  033c 2703          	jreq	L132
 765  033e               L44:
 768  033e 5b03          	addw	sp,#3
 769  0340 87            	retf	
 770  0341               L132:
 771                     ; 287        switch(TYPE)
 773  0341 c6024a        	ld	a,_TYPE
 775                     ; 430 		   default:break;
 776  0344 271a          	jreq	L36
 777  0346 a010          	sub	a,#16
 778  0348 2604ace003e0  	jreq	L56
 779  034e a010          	sub	a,#16
 780  0350 2604acae04ae  	jreq	L76
 781  0356 a010          	sub	a,#16
 782  0358 2604ac520652  	jreq	L17
 783  035e 20de          	jra	L44
 784  0360               L36:
 785                     ; 289            case SF: //单帧接收成功
 785                     ; 290                         qonestate = 0;
 787  0360 c70002        	ld	L5_qonestate,a
 788                     ; 291 			   state = 0;
 790  0363 c7000b        	ld	L13_state,a
 791                     ; 292 		   	   R_PDU[0].AI  = RecData[UDSRuscnt].AI;
 793  0366 de0251        	ldw	x,(_RecData,x)
 794  0369 cf00a5        	ldw	_R_PDU,x
 795                     ; 294 		   	   R_PDU[0].PCI = RecData[UDSRuscnt].PCI;
 797  036c c6024f        	ld	a,_UDSRuscnt
 798  036f 97            	ld	xl,a
 799  0370 a60a          	ld	a,#10
 800  0372 42            	mul	x,a
 801  0373 d60253        	ld	a,(_RecData+2,x)
 802  0376 c700a7        	ld	_R_PDU+2,a
 803                     ; 295 			   R_PDU[0].Data[0]= RecData[UDSRuscnt].Data[0];
 805  0379 d60254        	ld	a,(_RecData+3,x)
 806  037c c700a8        	ld	_R_PDU+3,a
 807                     ; 296 			   R_PDU[0].Data[1]= RecData[UDSRuscnt].Data[1];
 809  037f d60255        	ld	a,(_RecData+4,x)
 810  0382 c700a9        	ld	_R_PDU+4,a
 811                     ; 297 			   R_PDU[0].Data[2]= RecData[UDSRuscnt].Data[2];
 813  0385 d60256        	ld	a,(_RecData+5,x)
 814  0388 c700aa        	ld	_R_PDU+5,a
 815                     ; 298 			   R_PDU[0].Data[3]= RecData[UDSRuscnt].Data[3];
 817  038b d60257        	ld	a,(_RecData+6,x)
 818  038e c700ab        	ld	_R_PDU+6,a
 819                     ; 299 			   R_PDU[0].Data[4]= RecData[UDSRuscnt].Data[4];
 821  0391 d60258        	ld	a,(_RecData+7,x)
 822  0394 c700ac        	ld	_R_PDU+7,a
 823                     ; 300 			   R_PDU[0].Data[5]= RecData[UDSRuscnt].Data[5];
 825  0397 d60259        	ld	a,(_RecData+8,x)
 826  039a c700ad        	ld	_R_PDU+8,a
 827                     ; 301 			   R_PDU[0].Data[6]= RecData[UDSRuscnt].Data[6];
 829  039d d6025a        	ld	a,(_RecData+9,x)
 830  03a0 c700ae        	ld	_R_PDU+9,a
 831                     ; 302 	   			RecData[UDSRuscnt].PCI=0;
 833  03a3 724f0253      	clr	(_RecData+2,x)
 834                     ; 303 			 	RecData[UDSRuscnt].Data[0]=0;
 836  03a7 724f0254      	clr	(_RecData+3,x)
 837                     ; 304 			 	RecData[UDSRuscnt].Data[1]=0;
 839  03ab 724f0255      	clr	(_RecData+4,x)
 840                     ; 305 			 	RecData[UDSRuscnt].Data[2]=0;
 842  03af 724f0256      	clr	(_RecData+5,x)
 843                     ; 306 			 	RecData[UDSRuscnt].Data[3]=0;
 845  03b3 724f0257      	clr	(_RecData+6,x)
 846                     ; 307 			 	RecData[UDSRuscnt].Data[4]=0;
 848  03b7 724f0258      	clr	(_RecData+7,x)
 849                     ; 308 			 	RecData[UDSRuscnt].Data[5]=0;
 851  03bb 724f0259      	clr	(_RecData+8,x)
 852                     ; 309 			 	RecData[UDSRuscnt].Data[6]=0;
 854  03bf 724f025a      	clr	(_RecData+9,x)
 855                     ; 311 			  if(( R_PDU[0].PCI == 0)||(R_PDU[0].PCI > 7))N_UDSDdata.Indication = 0;
 857  03c3 725d00a7      	tnz	_R_PDU+2
 858  03c7 2707          	jreq	L142
 860  03c9 c600a7        	ld	a,_R_PDU+2
 861  03cc a108          	cp	a,#8
 862  03ce 2508          	jrult	L732
 863  03d0               L142:
 866  03d0 725f0284      	clr	_N_UDSDdata+1
 868  03d4 ac3e033e      	jra	L44
 869  03d8               L732:
 870                     ; 316 		   	         N_UDSDdata.Indication =IndicationOK1;
 872  03d8 35010284      	mov	_N_UDSDdata+1,#1
 873  03dc ac3e033e      	jra	L44
 874  03e0               L56:
 875                     ; 320 		   case FF: //第一帧数据接收
 875                     ; 321 		       qonestate = 0;
 877  03e0 c70002        	ld	L5_qonestate,a
 878                     ; 322                       Recfftoal = RecData[UDSRuscnt].PCI & 0x0f;
 880  03e3 d60253        	ld	a,(_RecData+2,x)
 881  03e6 a40f          	and	a,#15
 882  03e8 5f            	clrw	x
 883  03e9 97            	ld	xl,a
 884  03ea cf0007        	ldw	L71_Recfftoal,x
 885                     ; 323 			   Recfftoal = (Recfftoal<<8) + RecData[UDSRuscnt].Data[0];
 887  03ed c6024f        	ld	a,_UDSRuscnt
 888  03f0 97            	ld	xl,a
 889  03f1 a60a          	ld	a,#10
 890  03f3 42            	mul	x,a
 891  03f4 d60254        	ld	a,(_RecData+3,x)
 892  03f7 6b02          	ld	(OFST-1,sp),a
 893  03f9 ce0007        	ldw	x,L71_Recfftoal
 894  03fc 4f            	clr	a
 895  03fd 1b02          	add	a,(OFST-1,sp)
 896  03ff 2401          	jrnc	L04
 897  0401 5c            	incw	x
 898  0402               L04:
 899  0402 c70008        	ld	L71_Recfftoal+1,a
 900  0405 9f            	ld	a,xl
 901  0406 c70007        	ld	L71_Recfftoal,a
 902                     ; 324 			   R_PDU[hz].AI  = RecData[UDSRuscnt].AI;
 904  0409 c6024f        	ld	a,_UDSRuscnt
 905  040c 97            	ld	xl,a
 906  040d a60a          	ld	a,#10
 907  040f 42            	mul	x,a
 908  0410 de0251        	ldw	x,(_RecData,x)
 909  0413 1f01          	ldw	(OFST-2,sp),x
 910  0415 7b03          	ld	a,(OFST+0,sp)
 911  0417 97            	ld	xl,a
 912  0418 a60a          	ld	a,#10
 913  041a 42            	mul	x,a
 914  041b 1601          	ldw	y,(OFST-2,sp)
 915  041d df00a5        	ldw	(_R_PDU,x),y
 916                     ; 326 		   	   R_PDU[0].PCI = RecData[UDSRuscnt].PCI;
 918  0420 c6024f        	ld	a,_UDSRuscnt
 919  0423 97            	ld	xl,a
 920  0424 a60a          	ld	a,#10
 921  0426 42            	mul	x,a
 922  0427 d60253        	ld	a,(_RecData+2,x)
 923  042a c700a7        	ld	_R_PDU+2,a
 924                     ; 327 			   R_PDU[0].Data[0]= RecData[UDSRuscnt].Data[0];
 926  042d d60254        	ld	a,(_RecData+3,x)
 927  0430 c700a8        	ld	_R_PDU+3,a
 928                     ; 328 			   R_PDU[0].Data[1]= RecData[UDSRuscnt].Data[1];
 930  0433 d60255        	ld	a,(_RecData+4,x)
 931  0436 c700a9        	ld	_R_PDU+4,a
 932                     ; 329 			   R_PDU[0].Data[2]= RecData[UDSRuscnt].Data[2];
 934  0439 d60256        	ld	a,(_RecData+5,x)
 935  043c c700aa        	ld	_R_PDU+5,a
 936                     ; 330 			   R_PDU[0].Data[3]= RecData[UDSRuscnt].Data[3];
 938  043f d60257        	ld	a,(_RecData+6,x)
 939  0442 c700ab        	ld	_R_PDU+6,a
 940                     ; 331 			   R_PDU[0].Data[4]= RecData[UDSRuscnt].Data[4];
 942  0445 d60258        	ld	a,(_RecData+7,x)
 943  0448 c700ac        	ld	_R_PDU+7,a
 944                     ; 332 			   R_PDU[0].Data[5]= RecData[UDSRuscnt].Data[5];
 946  044b d60259        	ld	a,(_RecData+8,x)
 947  044e c700ad        	ld	_R_PDU+8,a
 948                     ; 333 			   R_PDU[0].Data[6]= RecData[UDSRuscnt].Data[6];
 950  0451 d6025a        	ld	a,(_RecData+9,x)
 951  0454 c700ae        	ld	_R_PDU+9,a
 952                     ; 334 			       RecData[UDSRuscnt].PCI=0;
 954  0457 724f0253      	clr	(_RecData+2,x)
 955                     ; 335 			 	RecData[UDSRuscnt].Data[0]=0;
 957  045b 724f0254      	clr	(_RecData+3,x)
 958                     ; 336 			 	RecData[UDSRuscnt].Data[1]=0;
 960  045f 724f0255      	clr	(_RecData+4,x)
 961                     ; 337 			 	RecData[UDSRuscnt].Data[2]=0;
 963  0463 724f0256      	clr	(_RecData+5,x)
 964                     ; 338 			 	RecData[UDSRuscnt].Data[3]=0;
 966  0467 724f0257      	clr	(_RecData+6,x)
 967                     ; 339 			 	RecData[UDSRuscnt].Data[4]=0;
 969  046b 724f0258      	clr	(_RecData+7,x)
 970                     ; 340 			 	RecData[UDSRuscnt].Data[5]=0;
 972  046f 724f0259      	clr	(_RecData+8,x)
 973                     ; 341 			 	RecData[UDSRuscnt].Data[6]=0;
 975  0473 724f025a      	clr	(_RecData+9,x)
 976                     ; 342 			   if(((R_PDU[0].PCI&0x0f)!=0)||(((R_PDU[0].PCI&0x0f)==0)&&(R_PDU[0].Data[0] >= 8)))
 978  0477 c600a7        	ld	a,_R_PDU+2
 979  047a a50f          	bcp	a,#15
 980  047c 260e          	jrne	L742
 982  047e c600a7        	ld	a,_R_PDU+2
 983  0481 a50f          	bcp	a,#15
 984  0483 261f          	jrne	L542
 986  0485 c600a8        	ld	a,_R_PDU+3
 987  0488 a108          	cp	a,#8
 988  048a 2518          	jrult	L542
 989  048c               L742:
 990                     ; 344 			       N_UDSDdata.Request = RequestsendFC;
 992  048c 35040283      	mov	_N_UDSDdata,#4
 993                     ; 345 			       RECcntk = 1;
 995  0490 ae0001        	ldw	x,#1
 996  0493 cf0000        	ldw	L32_RECcntk,x
 997                     ; 346 			       RECtoalcnt = 7 ;
 999  0496 ae0007        	ldw	x,#7
1001  0499               L152:
1003  0499 cf0005        	ldw	L12_RECtoalcnt,x
1004                     ; 355 			   state = 0;
1006  049c 725f000b      	clr	L13_state
1007                     ; 357 		   break;
1009  04a0 ac3e033e      	jra	L44
1010  04a4               L542:
1011                     ; 350 			       N_UDSDdata.Request = 0;
1013  04a4 725f0283      	clr	_N_UDSDdata
1014                     ; 351 				RECcntk = 0;
1016  04a8 5f            	clrw	x
1017  04a9 cf0000        	ldw	L32_RECcntk,x
1018                     ; 352 			       RECtoalcnt = 0 ;
1019  04ac 20eb          	jra	L152
1020  04ae               L76:
1021                     ; 358 		   case CF: //多帧数据接收
1021                     ; 359                        if((RecData[UDSRuscnt].PCI & 0x80)!= 0)break;
1023  04ae d60253        	ld	a,(_RecData+2,x)
1024  04b1 2bed          	jrmi	L44
1027                     ; 360 			  if(N_BS == 0){CFRstate = 0;break;}
1029  04b3 ce0061        	ldw	x,_N_BS
1030  04b6 2608          	jrne	L552
1033  04b8 725f0003      	clr	L53_CFRstate
1036  04bc ac3e033e      	jra	L44
1037  04c0               L552:
1038                     ; 361 			   R_PDU[RECcntk].AI  = RecData[UDSRuscnt].AI;
1040  04c0 c6024f        	ld	a,_UDSRuscnt
1041  04c3 97            	ld	xl,a
1042  04c4 a60a          	ld	a,#10
1043  04c6 42            	mul	x,a
1044  04c7 de0251        	ldw	x,(_RecData,x)
1045  04ca 1f01          	ldw	(OFST-2,sp),x
1046  04cc ce0000        	ldw	x,L32_RECcntk
1047  04cf 90ae000a      	ldw	y,#10
1048  04d3 8d000000      	callf	d_imul
1050  04d7 1601          	ldw	y,(OFST-2,sp)
1051  04d9 df00a5        	ldw	(_R_PDU,x),y
1052                     ; 363 		   	   R_PDU[RECcntk].PCI = RecData[UDSRuscnt].PCI;
1054  04dc c6024f        	ld	a,_UDSRuscnt
1055  04df 97            	ld	xl,a
1056  04e0 a60a          	ld	a,#10
1057  04e2 42            	mul	x,a
1058  04e3 d60253        	ld	a,(_RecData+2,x)
1059  04e6 ce0000        	ldw	x,L32_RECcntk
1060  04e9 90ae000a      	ldw	y,#10
1061  04ed 8d000000      	callf	d_imul
1063  04f1 d700a7        	ld	(_R_PDU+2,x),a
1064                     ; 364 			   R_PDU[RECcntk].Data[0]= RecData[UDSRuscnt].Data[0];
1066  04f4 c6024f        	ld	a,_UDSRuscnt
1067  04f7 97            	ld	xl,a
1068  04f8 a60a          	ld	a,#10
1069  04fa 42            	mul	x,a
1070  04fb d60254        	ld	a,(_RecData+3,x)
1071  04fe ce0000        	ldw	x,L32_RECcntk
1072  0501 90ae000a      	ldw	y,#10
1073  0505 8d000000      	callf	d_imul
1075  0509 d700a8        	ld	(_R_PDU+3,x),a
1076                     ; 365 			   R_PDU[RECcntk].Data[1]= RecData[UDSRuscnt].Data[1];
1078  050c c6024f        	ld	a,_UDSRuscnt
1079  050f 97            	ld	xl,a
1080  0510 a60a          	ld	a,#10
1081  0512 42            	mul	x,a
1082  0513 d60255        	ld	a,(_RecData+4,x)
1083  0516 ce0000        	ldw	x,L32_RECcntk
1084  0519 90ae000a      	ldw	y,#10
1085  051d 8d000000      	callf	d_imul
1087  0521 d700a9        	ld	(_R_PDU+4,x),a
1088                     ; 366 			   R_PDU[RECcntk].Data[2]= RecData[UDSRuscnt].Data[2];
1090  0524 c6024f        	ld	a,_UDSRuscnt
1091  0527 97            	ld	xl,a
1092  0528 a60a          	ld	a,#10
1093  052a 42            	mul	x,a
1094  052b d60256        	ld	a,(_RecData+5,x)
1095  052e ce0000        	ldw	x,L32_RECcntk
1096  0531 90ae000a      	ldw	y,#10
1097  0535 8d000000      	callf	d_imul
1099  0539 d700aa        	ld	(_R_PDU+5,x),a
1100                     ; 367 			   R_PDU[RECcntk].Data[3]= RecData[UDSRuscnt].Data[3];
1102  053c c6024f        	ld	a,_UDSRuscnt
1103  053f 97            	ld	xl,a
1104  0540 a60a          	ld	a,#10
1105  0542 42            	mul	x,a
1106  0543 d60257        	ld	a,(_RecData+6,x)
1107  0546 ce0000        	ldw	x,L32_RECcntk
1108  0549 90ae000a      	ldw	y,#10
1109  054d 8d000000      	callf	d_imul
1111  0551 d700ab        	ld	(_R_PDU+6,x),a
1112                     ; 368 			   R_PDU[RECcntk].Data[4]= RecData[UDSRuscnt].Data[4];
1114  0554 c6024f        	ld	a,_UDSRuscnt
1115  0557 97            	ld	xl,a
1116  0558 a60a          	ld	a,#10
1117  055a 42            	mul	x,a
1118  055b d60258        	ld	a,(_RecData+7,x)
1119  055e ce0000        	ldw	x,L32_RECcntk
1120  0561 90ae000a      	ldw	y,#10
1121  0565 8d000000      	callf	d_imul
1123  0569 d700ac        	ld	(_R_PDU+7,x),a
1124                     ; 369 			   R_PDU[RECcntk].Data[5]= RecData[UDSRuscnt].Data[5];
1126  056c c6024f        	ld	a,_UDSRuscnt
1127  056f 97            	ld	xl,a
1128  0570 a60a          	ld	a,#10
1129  0572 42            	mul	x,a
1130  0573 d60259        	ld	a,(_RecData+8,x)
1131  0576 ce0000        	ldw	x,L32_RECcntk
1132  0579 90ae000a      	ldw	y,#10
1133  057d 8d000000      	callf	d_imul
1135  0581 d700ad        	ld	(_R_PDU+8,x),a
1136                     ; 370 			   R_PDU[RECcntk].Data[6]= RecData[UDSRuscnt].Data[6];
1138  0584 c6024f        	ld	a,_UDSRuscnt
1139  0587 97            	ld	xl,a
1140  0588 a60a          	ld	a,#10
1141  058a 42            	mul	x,a
1142  058b d6025a        	ld	a,(_RecData+9,x)
1143  058e ce0000        	ldw	x,L32_RECcntk
1144  0591 90ae000a      	ldw	y,#10
1145  0595 8d000000      	callf	d_imul
1147  0599 d700ae        	ld	(_R_PDU+9,x),a
1148                     ; 372 			   	RecData[UDSRuscnt].PCI=0;
1150  059c c6024f        	ld	a,_UDSRuscnt
1151  059f 97            	ld	xl,a
1152  05a0 a60a          	ld	a,#10
1153  05a2 42            	mul	x,a
1154  05a3 724f0253      	clr	(_RecData+2,x)
1155                     ; 373 			 	RecData[UDSRuscnt].Data[0]=0;
1157  05a7 724f0254      	clr	(_RecData+3,x)
1158                     ; 374 			 	RecData[UDSRuscnt].Data[1]=0;
1160  05ab 724f0255      	clr	(_RecData+4,x)
1161                     ; 375 			 	RecData[UDSRuscnt].Data[2]=0;
1163  05af 724f0256      	clr	(_RecData+5,x)
1164                     ; 376 			 	RecData[UDSRuscnt].Data[3]=0;
1166  05b3 724f0257      	clr	(_RecData+6,x)
1167                     ; 377 			 	RecData[UDSRuscnt].Data[4]=0;
1169  05b7 724f0258      	clr	(_RecData+7,x)
1170                     ; 378 			 	RecData[UDSRuscnt].Data[5]=0;
1172  05bb 724f0259      	clr	(_RecData+8,x)
1173                     ; 379 			 	RecData[UDSRuscnt].Data[6]=0;
1175  05bf 724f025a      	clr	(_RecData+9,x)
1176                     ; 380 			   if(RECcntk == 1)
1178  05c3 ce0000        	ldw	x,L32_RECcntk
1179  05c6 a30001        	cpw	x,#1
1180  05c9 2615          	jrne	L752
1181                     ; 382 			           if(R_PDU[RECcntk].PCI!=0x21)state=1;
1183  05cb 90ae000a      	ldw	y,#10
1184  05cf 8d000000      	callf	d_imul
1186  05d3 d600a7        	ld	a,(_R_PDU+2,x)
1187  05d6 a121          	cp	a,#33
1188  05d8 2732          	jreq	L362
1191  05da 3501000b      	mov	L13_state,#1
1192  05de 202c          	jra	L362
1193  05e0               L752:
1194                     ; 386 				    if((R_PDU[RECcntk].PCI-R_PDU[RECcntk-1].PCI)!=1)state=1;      //帧不连续 
1196  05e0 90ae000a      	ldw	y,#10
1197  05e4 8d000000      	callf	d_imul
1199  05e8 1d000a        	subw	x,#10
1200  05eb d600a7        	ld	a,(_R_PDU+2,x)
1201  05ee 6b02          	ld	(OFST-1,sp),a
1202  05f0 ce0000        	ldw	x,L32_RECcntk
1203  05f3 90ae000a      	ldw	y,#10
1204  05f7 8d000000      	callf	d_imul
1206  05fb d600a7        	ld	a,(_R_PDU+2,x)
1207  05fe 5f            	clrw	x
1208  05ff 1002          	sub	a,(OFST-1,sp)
1209  0601 2401          	jrnc	L24
1210  0603 5a            	decw	x
1211  0604               L24:
1212  0604 02            	rlwa	x,a
1213  0605 5a            	decw	x
1214  0606 2704          	jreq	L362
1217  0608 3501000b      	mov	L13_state,#1
1218  060c               L362:
1219                     ; 388 			   RECcntk++;
1221  060c ce0000        	ldw	x,L32_RECcntk
1222  060f 5c            	incw	x
1223  0610 cf0000        	ldw	L32_RECcntk,x
1224                     ; 389 			   RECtoalcnt = RECtoalcnt + 7; 
1226  0613 ce0005        	ldw	x,L12_RECtoalcnt
1227  0616 1c0007        	addw	x,#7
1228  0619 cf0005        	ldw	L12_RECtoalcnt,x
1229                     ; 390                        if(RECtoalcnt > Recfftoal)
1231  061c c30007        	cpw	x,L71_Recfftoal
1232  061f 2319          	jrule	L762
1233                     ; 392                                if(state !=1 ) N_UDSDdata.Indication =IndicationOKm;//ok
1235  0621 c6000b        	ld	a,L13_state
1236  0624 4a            	dec	a
1237  0625 2706          	jreq	L172
1240  0627 35020284      	mov	_N_UDSDdata+1,#2
1242  062b 2003          	jra	L372
1243  062d               L172:
1244                     ; 393                                else  N_UDSDdata.Indication=0;
1246  062d c70284        	ld	_N_UDSDdata+1,a
1247  0630               L372:
1248                     ; 394                                Recfftoal = 0;
1250  0630 5f            	clrw	x
1251  0631 cf0007        	ldw	L71_Recfftoal,x
1252                     ; 395 				   RECtoalcnt=0;
1254  0634 cf0005        	ldw	L12_RECtoalcnt,x
1255                     ; 396 				   RECcntk = 0;
1257  0637 cf0000        	ldw	L32_RECcntk,x
1258  063a               L762:
1259                     ; 399 			   if(RECcntk >= 0x10)
1261  063a ce0000        	ldw	x,L32_RECcntk
1262  063d a30010        	cpw	x,#16
1263  0640 2404ac3e033e  	jrult	L44
1264                     ; 401 			       RECcntk =0;
1266  0646 5f            	clrw	x
1267  0647 cf0000        	ldw	L32_RECcntk,x
1268                     ; 402 			       N_UDSDdata.Request = RequestsendFC;
1270  064a 35040283      	mov	_N_UDSDdata,#4
1271  064e ac3e033e      	jra	L44
1272  0652               L17:
1273                     ; 407 		   	   if(N_BS==0)
1275  0652 ce0061        	ldw	x,_N_BS
1276  0655 2607          	jrne	L772
1277                     ; 409 			           CFRstate=0;
1279  0657 c70003        	ld	L53_CFRstate,a
1280                     ; 411 				    break; 
1282  065a ac3e033e      	jra	L44
1283  065e               L772:
1284                     ; 413                         SF_FS = RecData[UDSRuscnt].PCI & 0x0f;
1286  065e c6024f        	ld	a,_UDSRuscnt
1287  0661 97            	ld	xl,a
1288  0662 a60a          	ld	a,#10
1289  0664 42            	mul	x,a
1290  0665 d60253        	ld	a,(_RecData+2,x)
1291  0668 a40f          	and	a,#15
1292  066a c7024e        	ld	_SF_FS,a
1293                     ; 414 			   BS = RecData[UDSRuscnt].Data[0];
1295  066d d60254        	ld	a,(_RecData+3,x)
1296  0670 c70064        	ld	_BS,a
1297                     ; 415 			   STmin = RecData[UDSRuscnt].Data[1];
1299  0673 d60255        	ld	a,(_RecData+4,x)
1300  0676 c70065        	ld	_STmin,a
1301                     ; 416                         if(commcontrl != 0)N_UDSDdata.Request = RequestsendCF;
1303  0679 c60005        	ld	a,L52_commcontrl
1304  067c 2704          	jreq	L103
1307  067e 35030283      	mov	_N_UDSDdata,#3
1308  0682               L103:
1309                     ; 418 			   	RecData[UDSRuscnt].PCI=0;
1311  0682 724f0253      	clr	(_RecData+2,x)
1312                     ; 419 			 	RecData[UDSRuscnt].Data[0]=0;
1314  0686 724f0254      	clr	(_RecData+3,x)
1315                     ; 420 			 	RecData[UDSRuscnt].Data[1]=0;
1317  068a 724f0255      	clr	(_RecData+4,x)
1318                     ; 421 			 	RecData[UDSRuscnt].Data[2]=0;
1320  068e 724f0256      	clr	(_RecData+5,x)
1321                     ; 422 			 	RecData[UDSRuscnt].Data[3]=0;
1323  0692 724f0257      	clr	(_RecData+6,x)
1324                     ; 423 			 	RecData[UDSRuscnt].Data[4]=0;
1326  0696 724f0258      	clr	(_RecData+7,x)
1327                     ; 424 			 	RecData[UDSRuscnt].Data[5]=0;
1329  069a 724f0259      	clr	(_RecData+8,x)
1330                     ; 425 			 	RecData[UDSRuscnt].Data[6]=0;
1332  069e 724f025a      	clr	(_RecData+9,x)
1333                     ; 429 		   break;
1335                     ; 430 		   default:break;
1337                     ; 437 }
1339  06a2 ac3e033e      	jra	L44
1341                     	switch	.data
1342  0007               _DTCRuningstate:
1343  0007 00            	dc.b	0
1344  0008               _CommControl:
1345  0008 00            	dc.b	0
1406                     ; 457 void UDSonCANDiag(void)
1406                     ; 458 {
1407                     	switch	.text
1408  06a6               f_UDSonCANDiag:
1410  06a6 88            	push	a
1411       00000001      OFST:	set	1
1414                     ; 459      unsigned char ErrorCode = 0;
1416                     ; 462      if(keyerrorclosetime != 0 )
1418  06a7 ce005a        	ldw	x,_keyerrorclosetime
1419  06aa 270e          	jreq	L763
1420                     ; 464 	 	keyerrorclosetime--;
1422  06ac 5a            	decw	x
1423  06ad cf005a        	ldw	_keyerrorclosetime,x
1424                     ; 465 		if(keyerrorclosetime == 0)
1426  06b0 2608          	jrne	L763
1427                     ; 467 			keyerror1 = 0;
1429  06b2 725f005d      	clr	_keyerror1
1430                     ; 468 			keyerror2 = 0;
1432  06b6 725f005c      	clr	_keyerror2
1433  06ba               L763:
1434                     ; 472 	 if( time3e != 0)
1436  06ba ce0058        	ldw	x,_time3e
1437  06bd 270e          	jreq	L373
1438                     ; 474 	    time3e--;
1440  06bf 5a            	decw	x
1441  06c0 cf0058        	ldw	_time3e,x
1442                     ; 475 		if(time3e == 0)
1444  06c3 2608          	jrne	L373
1445                     ; 477 			SystemMode = defaSession;
1447  06c5 35010052      	mov	_SystemMode,#1
1448                     ; 478 			SalfeMode = 0;
1450  06c9 725f0051      	clr	_SalfeMode
1451  06cd               L373:
1452                     ; 482      if(N_UDSDdata.Indication == ConfirmationER)
1454  06cd c60284        	ld	a,_N_UDSDdata+1
1455  06d0 a102          	cp	a,#2
1456                     ; 486 	 if(N_UDSDdata.Indication == ConfirmationOverflow)
1458  06d2 c60284        	ld	a,_N_UDSDdata+1
1459  06d5 a103          	cp	a,#3
1460                     ; 490      if((N_UDSDdata.Indication != IndicationOK1)&&(N_UDSDdata.Indication != IndicationOKm))return;
1462  06d7 c60284        	ld	a,_N_UDSDdata+1
1463  06da 4a            	dec	a
1464  06db 2709          	jreq	L304
1466  06dd c60284        	ld	a,_N_UDSDdata+1
1467  06e0 a102          	cp	a,#2
1468  06e2 2702          	jreq	L304
1472  06e4 84            	pop	a
1473  06e5 87            	retf	
1474  06e6               L304:
1475                     ; 492 	 if((R_PDU[0].PCI == 0x07)&&(R_PDU[0].Data[0]== 0xff)&&(R_PDU[0].Data[1]==0x58)&&(R_PDU[0].Data[2]==0x41))
1477  06e6 c600a7        	ld	a,_R_PDU+2
1478  06e9 a107          	cp	a,#7
1479  06eb 2634          	jrne	L504
1481  06ed c600a8        	ld	a,_R_PDU+3
1482  06f0 4c            	inc	a
1483  06f1 262e          	jrne	L504
1485  06f3 c600a9        	ld	a,_R_PDU+4
1486  06f6 a158          	cp	a,#88
1487  06f8 2627          	jrne	L504
1489  06fa c600aa        	ld	a,_R_PDU+5
1490  06fd a141          	cp	a,#65
1491  06ff 2620          	jrne	L504
1492                     ; 498 			UDSsendone(0x03,0x95,DIDF1f3EEPROM[0],DIDF1f3EEPROM[1],0,0,0,0);	
1494  0701 4b00          	push	#0
1495  0703 4b00          	push	#0
1496  0705 4b00          	push	#0
1497  0707 4b00          	push	#0
1498  0709 3b410b        	push	_DIDF1f3EEPROM+1
1499  070c 3b410a        	push	_DIDF1f3EEPROM
1500  070f ae0095        	ldw	x,#149
1501  0712 a603          	ld	a,#3
1502  0714 95            	ld	xh,a
1503  0715 8d110c11      	callf	f_UDSsendone
1505  0719 5b06          	addw	sp,#6
1506                     ; 499 			N_UDSDdata.Indication = 0;
1508  071b 725f0284      	clr	_N_UDSDdata+1
1509                     ; 500 			return;
1512  071f 84            	pop	a
1513  0720 87            	retf	
1514  0721               L504:
1515                     ; 503 	 if((R_PDU[0].PCI & 0xf0)==0x10)
1517  0721 c600a7        	ld	a,_R_PDU+2
1518  0724 a4f0          	and	a,#240
1519  0726 a110          	cp	a,#16
1520  0728 2605          	jrne	L704
1521                     ; 505 		Readcom = R_PDU[0].Data[1];
1523  072a c600a9        	ld	a,_R_PDU+4
1525  072d 2003          	jra	L114
1526  072f               L704:
1527                     ; 509 		Readcom = R_PDU[0].Data[0];
1529  072f c600a8        	ld	a,_R_PDU+3
1530  0732               L114:
1531  0732 6b01          	ld	(OFST+0,sp),a
1532                     ; 512      if((Readcom > 0x10)&&(Readcom < 0x40))time3e = time3etime; //shujulianjie 
1534  0734 a111          	cp	a,#17
1535  0736 250a          	jrult	L314
1537  0738 a140          	cp	a,#64
1538  073a 2406          	jruge	L314
1541  073c ae0271        	ldw	x,#625
1542  073f cf0058        	ldw	_time3e,x
1543  0742               L314:
1544                     ; 514      switch(Readcom)
1547                     ; 791 		}break;
1548  0742 a010          	sub	a,#16
1549  0744 2604ace607e6  	jreq	L303
1550  074a 4a            	dec	a
1551  074b 2604ac3f083f  	jreq	L503
1552  0751 a003          	sub	a,#3
1553  0753 2604ac570857  	jreq	L703
1554  0759 a005          	sub	a,#5
1555  075b 2604acad08ad  	jreq	L113
1556  0761 a009          	sub	a,#9
1557  0763 2604ace608e6  	jreq	L313
1558  0769 4a            	dec	a
1559  076a 2604ac190919  	jreq	L513
1560  0770 a004          	sub	a,#4
1561  0772 2604ac360936  	jreq	L713
1562  0778 4a            	dec	a
1563  0779 2604ac750975  	jreq	L123
1564  077f a002          	sub	a,#2
1565  0781 2604acc409c4  	jreq	L323
1566  0787 a004          	sub	a,#4
1567  0789 2604ace109e1  	jreq	L523
1568  078f 4a            	dec	a
1569  0790 2604ac510a51  	jreq	L723
1570  0796 a002          	sub	a,#2
1571  0798 2604ac690a69  	jreq	L133
1572  079e a003          	sub	a,#3
1573  07a0 2604acff0aff  	jreq	L333
1574  07a6 a002          	sub	a,#2
1575  07a8 2604ac1e0b1e  	jreq	L533
1576  07ae 4a            	dec	a
1577  07af 2604ac360b36  	jreq	L733
1578  07b5 a006          	sub	a,#6
1579  07b7 2604ac4e0b4e  	jreq	L143
1580  07bd 4a            	dec	a
1581  07be 2604ac660b66  	jreq	L343
1582  07c4 a047          	sub	a,#71
1583  07c6 2604acb70bb7  	jreq	L543
1584                     ; 786 			N_UDSDdata.Indication = 0;
1586  07cc 725f0284      	clr	_N_UDSDdata+1
1587                     ; 787 			ErrorCode = NCR11;
1589                     ; 788                      UDSsendone(0x03,ErRequst,R_PDU[0].Data[0],ErrorCode,0,0,0,0);
1591  07d0 4b00          	push	#0
1592  07d2 4b00          	push	#0
1593  07d4 4b00          	push	#0
1594  07d6 4b00          	push	#0
1595  07d8 4b11          	push	#17
1596  07da 3b00a8        	push	_R_PDU+3
1597  07dd ae007f        	ldw	x,#127
1598  07e0 a603          	ld	a,#3
1600                     ; 790 			ClearRPDUbuff();
1602                     ; 791 		}break;
1604  07e2 ac040c04      	jpf	L315
1605  07e6               L303:
1606                     ; 519 			N_UDSDdata.Indication = 0;
1608  07e6 c70284        	ld	_N_UDSDdata+1,a
1609                     ; 520                       ErrorCode = UDSDiag10(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
1611  07e9 3b00ae        	push	_R_PDU+9
1612  07ec 3b00ad        	push	_R_PDU+8
1613  07ef 3b00ac        	push	_R_PDU+7
1614  07f2 3b00ab        	push	_R_PDU+6
1615  07f5 3b00aa        	push	_R_PDU+5
1616  07f8 3b00a9        	push	_R_PDU+4
1617  07fb c600a8        	ld	a,_R_PDU+3
1618  07fe 97            	ld	xl,a
1619  07ff c600a7        	ld	a,_R_PDU+2
1620  0802 95            	ld	xh,a
1621  0803 8d4a0c4a      	callf	f_UDSDiag10
1623  0807 5b06          	addw	sp,#6
1624  0809 6b01          	ld	(OFST+0,sp),a
1625                     ; 521                      R_PDU[0].Data[0] = 0;
1627  080b 725f00a8      	clr	_R_PDU+3
1628                     ; 523 			if(ErrorCode != 0)
1630  080f 7b01          	ld	a,(OFST+0,sp)
1631  0811 2716          	jreq	L124
1632                     ; 525                              UDSsendone(0x03,ErRequst,SID10,ErrorCode,0,0,0,0);
1634  0813 4b00          	push	#0
1635  0815 4b00          	push	#0
1636  0817 4b00          	push	#0
1637  0819 4b00          	push	#0
1638  081b 7b05          	ld	a,(OFST+4,sp)
1639  081d 88            	push	a
1640  081e 4b10          	push	#16
1641  0820 ae007f        	ldw	x,#127
1642  0823 a603          	ld	a,#3
1645  0825 ac040c04      	jra	L315
1646  0829               L124:
1647                     ; 529                               UDSsendone(0x06,SID10+0x40,R_PDU[0].Data[1],0x00,0x32,0x13,0x88,0x00);  //时间参数默认
1649  0829 4b00          	push	#0
1650  082b 4b88          	push	#136
1651  082d 4b13          	push	#19
1652  082f 4b32          	push	#50
1653  0831 4b00          	push	#0
1654  0833 3b00a9        	push	_R_PDU+4
1655  0836 ae0050        	ldw	x,#80
1656  0839 a606          	ld	a,#6
1658                     ; 531 			ErrorCode = 0;
1660                     ; 532 			ClearRPDUbuff();
1662                     ; 533 		}break;
1664  083b ac040c04      	jpf	L315
1665  083f               L503:
1666                     ; 537 			N_UDSDdata.Indication = 0;
1668  083f c70284        	ld	_N_UDSDdata+1,a
1669                     ; 538 			ErrorCode = NCR11;
1671                     ; 539  			UDSsendone(0x03,ErRequst,SID11,ErrorCode,0,0,0,0);
1673  0842 4b00          	push	#0
1674  0844 4b00          	push	#0
1675  0846 4b00          	push	#0
1676  0848 4b00          	push	#0
1677  084a 4b11          	push	#17
1678  084c 4b11          	push	#17
1679  084e ae007f        	ldw	x,#127
1680  0851 a603          	ld	a,#3
1682                     ; 540 			ErrorCode = 0;
1684                     ; 541 			ClearRPDUbuff();
1686                     ; 542 		}break;
1688  0853 ac040c04      	jpf	L315
1689  0857               L703:
1690                     ; 546 			N_UDSDdata.Indication = 0;
1692  0857 c70284        	ld	_N_UDSDdata+1,a
1693                     ; 549                      if(R_PDU[0].PCI != 0x04) ErrorCode = NCR13;  //add diag error long 
1695  085a c600a7        	ld	a,_R_PDU+2
1696  085d a104          	cp	a,#4
1697  085f 2704          	jreq	L524
1700  0861 a613          	ld	a,#19
1702  0863 201a          	jra	L724
1703  0865               L524:
1704                     ; 552 			       if((R_PDU[0].Data[1]==0xff)&&(R_PDU[0].Data[2]==0xff)&&(R_PDU[0].Data[3]==0xff))
1706  0865 c600a9        	ld	a,_R_PDU+4
1707  0868 4c            	inc	a
1708  0869 2612          	jrne	L134
1710  086b c600aa        	ld	a,_R_PDU+5
1711  086e 4c            	inc	a
1712  086f 260c          	jrne	L134
1714  0871 c600ab        	ld	a,_R_PDU+6
1715  0874 4c            	inc	a
1716  0875 2606          	jrne	L134
1717                     ; 554 					ErrorCode = UDSclearDTC();
1719  0877 8d981898      	callf	f_UDSclearDTC
1722  087b 2002          	jra	L724
1723  087d               L134:
1724                     ; 558 					ErrorCode = NCR12;
1726  087d a612          	ld	a,#18
1727  087f               L724:
1728  087f 6b01          	ld	(OFST+0,sp),a
1729                     ; 561 			if(ErrorCode != 0)
1731  0881 2716          	jreq	L534
1732                     ; 563  				UDSsendone(0x03,ErRequst,SID14,ErrorCode,0,0,0,0);
1734  0883 4b00          	push	#0
1735  0885 4b00          	push	#0
1736  0887 4b00          	push	#0
1737  0889 4b00          	push	#0
1738  088b 7b05          	ld	a,(OFST+4,sp)
1739  088d 88            	push	a
1740  088e 4b14          	push	#20
1741  0890 ae007f        	ldw	x,#127
1742  0893 a603          	ld	a,#3
1745  0895 ac040c04      	jra	L315
1746  0899               L534:
1747                     ; 567 				UDSsendone(0x01,SID14+0x40,0,0,0,0,0,0);
1749  0899 4b00          	push	#0
1750  089b 4b00          	push	#0
1751  089d 4b00          	push	#0
1752  089f 4b00          	push	#0
1753  08a1 4b00          	push	#0
1754  08a3 4b00          	push	#0
1755  08a5 ae0054        	ldw	x,#84
1756  08a8 4c            	inc	a
1758                     ; 569 			ErrorCode = 0;
1760                     ; 570 			ClearRPDUbuff();
1762                     ; 571 		}break;
1764  08a9 ac040c04      	jpf	L315
1765  08ad               L113:
1766                     ; 575 			ErrorCode = UDSDiag19(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
1768  08ad 3b00ae        	push	_R_PDU+9
1769  08b0 3b00ad        	push	_R_PDU+8
1770  08b3 3b00ac        	push	_R_PDU+7
1771  08b6 3b00ab        	push	_R_PDU+6
1772  08b9 3b00aa        	push	_R_PDU+5
1773  08bc 3b00a9        	push	_R_PDU+4
1774  08bf c600a8        	ld	a,_R_PDU+3
1775  08c2 97            	ld	xl,a
1776  08c3 c600a7        	ld	a,_R_PDU+2
1777  08c6 95            	ld	xh,a
1778  08c7 8d2a182a      	callf	f_UDSDiag19
1780  08cb 5b06          	addw	sp,#6
1781  08cd 6b01          	ld	(OFST+0,sp),a
1782                     ; 577 			if(ErrorCode != 0)
1784  08cf 2604ac490a49  	jreq	LC006
1785                     ; 579  				UDSsendone(0x03,ErRequst,SID19,ErrorCode,0,0,0,0);
1787  08d5 4b00          	push	#0
1788  08d7 4b00          	push	#0
1789  08d9 4b00          	push	#0
1790  08db 4b00          	push	#0
1791  08dd 7b05          	ld	a,(OFST+4,sp)
1792  08df 88            	push	a
1793  08e0 4b19          	push	#25
1795                     ; 581 			N_UDSDdata.Indication = 0;
1796                     ; 582 			ErrorCode = 0;
1798                     ; 583 			ClearRPDUbuff();
1800                     ; 584 		}break;
1802  08e2 ac6e096e      	jpf	LC008
1803  08e6               L313:
1804                     ; 588 			ErrorCode = UDSDiag22(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
1806  08e6 3b00ae        	push	_R_PDU+9
1807  08e9 3b00ad        	push	_R_PDU+8
1808  08ec 3b00ac        	push	_R_PDU+7
1809  08ef 3b00ab        	push	_R_PDU+6
1810  08f2 3b00aa        	push	_R_PDU+5
1811  08f5 3b00a9        	push	_R_PDU+4
1812  08f8 c600a8        	ld	a,_R_PDU+3
1813  08fb 97            	ld	xl,a
1814  08fc c600a7        	ld	a,_R_PDU+2
1815  08ff 95            	ld	xh,a
1816  0900 8dab0dab      	callf	f_UDSDiag22
1818  0904 5b06          	addw	sp,#6
1819  0906 6b01          	ld	(OFST+0,sp),a
1820                     ; 589             if(ErrorCode != 0)
1822  0908 27c7          	jreq	LC006
1823                     ; 591  				UDSsendone(0x03,ErRequst,SID22,ErrorCode,0,0,0,0);
1825  090a 4b00          	push	#0
1826  090c 4b00          	push	#0
1827  090e 4b00          	push	#0
1828  0910 4b00          	push	#0
1829  0912 7b05          	ld	a,(OFST+4,sp)
1830  0914 88            	push	a
1831  0915 4b22          	push	#34
1833                     ; 593 			ErrorCode = 0;
1835                     ; 594 			N_UDSDdata.Indication = 0;
1836                     ; 595 			ClearRPDUbuff();
1838                     ; 596 		}break;
1840  0917 2055          	jpf	LC008
1841  0919               L513:
1842                     ; 599 			ClearNPDUbuff();
1844  0919 8da320a3      	callf	f_ClearNPDUbuff
1846                     ; 600 			N_UDSDdata.Indication = 0;
1848  091d 725f0284      	clr	_N_UDSDdata+1
1849                     ; 601 			ErrorCode = NCR11;
1851                     ; 602  			UDSsendone(0x03,ErRequst,SID23,ErrorCode,0,0,0,0);
1853  0921 4b00          	push	#0
1854  0923 4b00          	push	#0
1855  0925 4b00          	push	#0
1856  0927 4b00          	push	#0
1857  0929 4b11          	push	#17
1858  092b 4b23          	push	#35
1859  092d ae007f        	ldw	x,#127
1860  0930 a603          	ld	a,#3
1862                     ; 603 			ErrorCode = 0;
1864                     ; 604 			ClearRPDUbuff();
1866                     ; 605 		}break;
1868  0932 ac040c04      	jpf	L315
1869  0936               L713:
1870                     ; 609 			N_UDSDdata.Indication = 0;
1872  0936 c70284        	ld	_N_UDSDdata+1,a
1873                     ; 610 			ErrorCode = UDSDiag27(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
1875  0939 3b00ae        	push	_R_PDU+9
1876  093c 3b00ad        	push	_R_PDU+8
1877  093f 3b00ac        	push	_R_PDU+7
1878  0942 3b00ab        	push	_R_PDU+6
1879  0945 3b00aa        	push	_R_PDU+5
1880  0948 3b00a9        	push	_R_PDU+4
1881  094b c600a8        	ld	a,_R_PDU+3
1882  094e 97            	ld	xl,a
1883  094f c600a7        	ld	a,_R_PDU+2
1884  0952 95            	ld	xh,a
1885  0953 8d991b99      	callf	f_UDSDiag27
1887  0957 5b06          	addw	sp,#6
1888  0959 6b01          	ld	(OFST+0,sp),a
1889                     ; 612 			if(ErrorCode !=0)//ErrorCode = NCR12;
1891  095b 2604ac490a49  	jreq	LC006
1892                     ; 614  				UDSsendone(0x03,ErRequst,SID27,ErrorCode,0,0,0,0);
1894  0961 4b00          	push	#0
1895  0963 4b00          	push	#0
1896  0965 4b00          	push	#0
1897  0967 4b00          	push	#0
1898  0969 7b05          	ld	a,(OFST+4,sp)
1899  096b 88            	push	a
1900  096c 4b27          	push	#39
1901  096e               LC008:
1902  096e ae007f        	ldw	x,#127
1904                     ; 616 			ErrorCode = 0;
1906                     ; 617 			N_UDSDdata.Indication = 0;
1907                     ; 618 			ClearRPDUbuff();
1909                     ; 619 		}break;
1911  0971 ac400a40      	jpf	L554
1912  0975               L123:
1913                     ; 623 			N_UDSDdata.Indication = 0;
1915  0975 c70284        	ld	_N_UDSDdata+1,a
1916                     ; 624 			ErrorCode = UDSDiag28(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
1918  0978 3b00ae        	push	_R_PDU+9
1919  097b 3b00ad        	push	_R_PDU+8
1920  097e 3b00ac        	push	_R_PDU+7
1921  0981 3b00ab        	push	_R_PDU+6
1922  0984 3b00aa        	push	_R_PDU+5
1923  0987 3b00a9        	push	_R_PDU+4
1924  098a c600a8        	ld	a,_R_PDU+3
1925  098d 97            	ld	xl,a
1926  098e c600a7        	ld	a,_R_PDU+2
1927  0991 95            	ld	xh,a
1928  0992 8dea0cea      	callf	f_UDSDiag28
1930  0996 5b06          	addw	sp,#6
1931  0998 6b01          	ld	(OFST+0,sp),a
1932                     ; 625             if(ErrorCode != 0)
1934  099a 2712          	jreq	L744
1935                     ; 627  				UDSsendone(0x03,ErRequst,SID28,ErrorCode,0,0,0,0);
1937  099c 4b00          	push	#0
1938  099e 4b00          	push	#0
1939  09a0 4b00          	push	#0
1940  09a2 4b00          	push	#0
1941  09a4 7b05          	ld	a,(OFST+4,sp)
1942  09a6 88            	push	a
1943  09a7 4b28          	push	#40
1944  09a9 ae007f        	ldw	x,#127
1947  09ac 2010          	jra	L154
1948  09ae               L744:
1949                     ; 631 				UDSsendone(0x03,SID28+0x40,R_PDU[0].Data[1],0,0,0,0,0);
1951  09ae 4b00          	push	#0
1952  09b0 4b00          	push	#0
1953  09b2 4b00          	push	#0
1954  09b4 4b00          	push	#0
1955  09b6 4b00          	push	#0
1956  09b8 3b00a9        	push	_R_PDU+4
1957  09bb ae0068        	ldw	x,#104
1959  09be               L154:
1960  09be a603          	ld	a,#3
1961                     ; 633 			ErrorCode = 0;
1963                     ; 634 			ClearRPDUbuff();
1965                     ; 635 		}break;
1967  09c0 ac040c04      	jpf	L315
1968  09c4               L323:
1969                     ; 638 			ClearNPDUbuff();
1971  09c4 8da320a3      	callf	f_ClearNPDUbuff
1973                     ; 639 			N_UDSDdata.Indication = 0;
1975  09c8 725f0284      	clr	_N_UDSDdata+1
1976                     ; 640 			ErrorCode = NCR11;
1978                     ; 641  			UDSsendone(0x03,ErRequst,SID2a,ErrorCode,0,0,0,0);
1980  09cc 4b00          	push	#0
1981  09ce 4b00          	push	#0
1982  09d0 4b00          	push	#0
1983  09d2 4b00          	push	#0
1984  09d4 4b11          	push	#17
1985  09d6 4b2a          	push	#42
1986  09d8 ae007f        	ldw	x,#127
1987  09db a603          	ld	a,#3
1989                     ; 642 			ErrorCode = 0;
1991                     ; 643 			ClearRPDUbuff();
1993                     ; 644 		}break;
1995  09dd ac040c04      	jpf	L315
1996  09e1               L523:
1997                     ; 648 			ErrorCode = 0;
1999                     ; 649 			ErrorCode = UDSDiag2e(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
2001  09e1 3b00ae        	push	_R_PDU+9
2002  09e4 3b00ad        	push	_R_PDU+8
2003  09e7 3b00ac        	push	_R_PDU+7
2004  09ea 3b00ab        	push	_R_PDU+6
2005  09ed 3b00aa        	push	_R_PDU+5
2006  09f0 3b00a9        	push	_R_PDU+4
2007  09f3 c600a8        	ld	a,_R_PDU+3
2008  09f6 97            	ld	xl,a
2009  09f7 c600a7        	ld	a,_R_PDU+2
2010  09fa 95            	ld	xh,a
2011  09fb 8dd517d5      	callf	f_UDSDiag2e
2013  09ff 5b06          	addw	sp,#6
2014  0a01 6b01          	ld	(OFST+0,sp),a
2015                     ; 650 			if(ErrorCode !=0)
2017  0a03 2711          	jreq	L354
2018                     ; 652 				UDSsendone(0x03,ErRequst,SID2e,ErrorCode,0,0,0,0);
2020  0a05 4b00          	push	#0
2021  0a07 4b00          	push	#0
2022  0a09 4b00          	push	#0
2023  0a0b 4b00          	push	#0
2024  0a0d 7b05          	ld	a,(OFST+4,sp)
2025  0a0f 88            	push	a
2026  0a10 4b2e          	push	#46
2029  0a12 ac6e096e      	jpf	LC008
2030  0a16               L354:
2031                     ; 656 			    if((R_PDU[0].PCI & 0xf0)==0x10)
2033  0a16 c600a7        	ld	a,_R_PDU+2
2034  0a19 a4f0          	and	a,#240
2035  0a1b a110          	cp	a,#16
2036  0a1d 2610          	jrne	L754
2037                     ; 658 					UDSsendone(0x03,SID2e+0x40,R_PDU[0].Data[2],R_PDU[0].Data[3],0,0,0,0);
2039  0a1f 4b00          	push	#0
2040  0a21 4b00          	push	#0
2041  0a23 4b00          	push	#0
2042  0a25 4b00          	push	#0
2043  0a27 3b00ab        	push	_R_PDU+6
2044  0a2a 3b00aa        	push	_R_PDU+5
2047  0a2d 200e          	jpf	LC002
2048  0a2f               L754:
2049                     ; 662 					UDSsendone(0x03,SID2e+0x40,R_PDU[0].Data[1],R_PDU[0].Data[2],0,0,0,0);
2051  0a2f 4b00          	push	#0
2052  0a31 4b00          	push	#0
2053  0a33 4b00          	push	#0
2054  0a35 4b00          	push	#0
2055  0a37 3b00aa        	push	_R_PDU+5
2056  0a3a 3b00a9        	push	_R_PDU+4
2057  0a3d               LC002:
2058  0a3d ae006e        	ldw	x,#110
2060  0a40               L554:
2061  0a40 a603          	ld	a,#3
2062  0a42 95            	ld	xh,a
2063  0a43 8d110c11      	callf	f_UDSsendone
2064  0a47 5b06          	addw	sp,#6
2065                     ; 665 			N_UDSDdata.Indication = 0;
2067  0a49               LC006:
2071  0a49 725f0284      	clr	_N_UDSDdata+1
2072                     ; 666 			ErrorCode = 0;
2074                     ; 667 			ClearRPDUbuff();
2076                     ; 668 		}break;
2078  0a4d ac0b0c0b      	jpf	LC004
2079  0a51               L723:
2080                     ; 672 			N_UDSDdata.Indication = 0;
2082  0a51 c70284        	ld	_N_UDSDdata+1,a
2083                     ; 673 			ErrorCode = NCR11;
2085                     ; 674  			UDSsendone(0x03,ErRequst,SID2f,ErrorCode,0,0,0,0);
2087  0a54 4b00          	push	#0
2088  0a56 4b00          	push	#0
2089  0a58 4b00          	push	#0
2090  0a5a 4b00          	push	#0
2091  0a5c 4b11          	push	#17
2092  0a5e 4b2f          	push	#47
2093  0a60 ae007f        	ldw	x,#127
2094  0a63 a603          	ld	a,#3
2096                     ; 675 			ErrorCode = 0;
2098                     ; 676 			ClearRPDUbuff();
2100                     ; 677 		}break;
2102  0a65 ac040c04      	jpf	L315
2103  0a69               L133:
2104                     ; 681 			N_UDSDdata.Indication = 0;
2106  0a69 c70284        	ld	_N_UDSDdata+1,a
2107                     ; 682                      if(R_PDU[0].PCI != 4)
2109  0a6c c600a7        	ld	a,_R_PDU+2
2110  0a6f a104          	cp	a,#4
2111  0a71 2715          	jreq	L364
2112                     ; 684  				UDSsendone(0x03,ErRequst,SID31,NCR13,0,0,0,0);
2114  0a73 4b00          	push	#0
2115  0a75 4b00          	push	#0
2116  0a77 4b00          	push	#0
2117  0a79 4b00          	push	#0
2118  0a7b 4b13          	push	#19
2119  0a7d 4b31          	push	#49
2120  0a7f ae007f        	ldw	x,#127
2121  0a82 a603          	ld	a,#3
2123                     ; 685 				ClearRPDUbuff();
2125                     ; 686 				break;
2127  0a84 ac040c04      	jpf	L315
2128  0a88               L364:
2129                     ; 689 			ErrorCode = UDSDiag31(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
2131  0a88 3b00ae        	push	_R_PDU+9
2132  0a8b 3b00ad        	push	_R_PDU+8
2133  0a8e 3b00ac        	push	_R_PDU+7
2134  0a91 3b00ab        	push	_R_PDU+6
2135  0a94 3b00aa        	push	_R_PDU+5
2136  0a97 3b00a9        	push	_R_PDU+4
2137  0a9a c600a8        	ld	a,_R_PDU+3
2138  0a9d 97            	ld	xl,a
2139  0a9e c600a7        	ld	a,_R_PDU+2
2140  0aa1 95            	ld	xh,a
2141  0aa2 8d340d34      	callf	f_UDSDiag31
2143  0aa6 5b06          	addw	sp,#6
2144  0aa8 6b01          	ld	(OFST+0,sp),a
2145                     ; 691 			if(ErrorCode == 1)
2147  0aaa 4a            	dec	a
2148  0aab 2620          	jrne	L564
2149                     ; 693 				if(EnalbeLearnRkeTime20s != 0)KEYleanstate = 1;
2151  0aad ce0000        	ldw	x,_EnalbeLearnRkeTime20s
2152  0ab0 2706          	jreq	L764
2155  0ab2 35010050      	mov	_KEYleanstate,#1
2157  0ab6 2004          	jra	L174
2158  0ab8               L764:
2159                     ; 694 				else KEYleanstate = 2;
2161  0ab8 35020050      	mov	_KEYleanstate,#2
2162  0abc               L174:
2163                     ; 695 				UDSsendone(0x04,SID31+0x40,KEYleanstate,R_PDU[0].Data[2],R_PDU[0].Data[3],0,0,0);//返回例程执行结果 1。表示运行中 2。表示执行完成
2165  0abc 4b00          	push	#0
2166  0abe 4b00          	push	#0
2167  0ac0 4b00          	push	#0
2168  0ac2 3b00ab        	push	_R_PDU+6
2169  0ac5 3b00aa        	push	_R_PDU+5
2170  0ac8 3b0050        	push	_KEYleanstate
2173  0acb 2013          	jpf	LC003
2174  0acd               L564:
2175                     ; 697 			else if(ErrorCode == 0)
2177  0acd 7b01          	ld	a,(OFST+0,sp)
2178  0acf 2618          	jrne	L574
2179                     ; 699 				UDSsendone(0x04,SID31+0x40,R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],0,0,0);
2181  0ad1 4b00          	push	#0
2182  0ad3 4b00          	push	#0
2183  0ad5 4b00          	push	#0
2184  0ad7 3b00ab        	push	_R_PDU+6
2185  0ada 3b00aa        	push	_R_PDU+5
2186  0add 3b00a9        	push	_R_PDU+4
2187  0ae0               LC003:
2188  0ae0 ae0071        	ldw	x,#113
2189  0ae3 a604          	ld	a,#4
2192  0ae5 ac040c04      	jra	L315
2193  0ae9               L574:
2194                     ; 703  				UDSsendone(0x03,ErRequst,SID31,ErrorCode,0,0,0,0);
2196  0ae9 4b00          	push	#0
2197  0aeb 4b00          	push	#0
2198  0aed 4b00          	push	#0
2199  0aef 4b00          	push	#0
2200  0af1 7b05          	ld	a,(OFST+4,sp)
2201  0af3 88            	push	a
2202  0af4 4b31          	push	#49
2203  0af6 ae007f        	ldw	x,#127
2204  0af9 a603          	ld	a,#3
2206                     ; 706 			ErrorCode = 0;
2208                     ; 707 			ClearRPDUbuff();
2210                     ; 708 		}break;
2212  0afb ac040c04      	jpf	L315
2213  0aff               L333:
2214                     ; 712 			N_UDSDdata.Indication = 0;
2216  0aff c70284        	ld	_N_UDSDdata+1,a
2217                     ; 713 			ErrorCode = NCR11;
2219                     ; 714  			UDSsendone(0x03,ErRequst,SID34,ErrorCode,0,0,0,0);
2221  0b02 4b00          	push	#0
2222  0b04 4b00          	push	#0
2223  0b06 4b00          	push	#0
2224  0b08 4b00          	push	#0
2225  0b0a 4b11          	push	#17
2226  0b0c 4b34          	push	#52
2227  0b0e ae007f        	ldw	x,#127
2228  0b11 a603          	ld	a,#3
2229  0b13 95            	ld	xh,a
2230  0b14 8d110c11      	callf	f_UDSsendone
2232  0b18 5b06          	addw	sp,#6
2233                     ; 715 			ErrorCode = 0;
2235                     ; 716 		}break;
2237  0b1a ac0f0c0f      	jra	L714
2238  0b1e               L533:
2239                     ; 720 			N_UDSDdata.Indication = 0;
2241  0b1e c70284        	ld	_N_UDSDdata+1,a
2242                     ; 721 			ErrorCode = NCR11;
2244                     ; 722  			UDSsendone(0x03,ErRequst,SID36,ErrorCode,0,0,0,0);
2246  0b21 4b00          	push	#0
2247  0b23 4b00          	push	#0
2248  0b25 4b00          	push	#0
2249  0b27 4b00          	push	#0
2250  0b29 4b11          	push	#17
2251  0b2b 4b36          	push	#54
2252  0b2d ae007f        	ldw	x,#127
2253  0b30 a603          	ld	a,#3
2255                     ; 723 			ErrorCode = 0;
2257                     ; 724 			ClearRPDUbuff();
2259                     ; 725 		}break;
2261  0b32 ac040c04      	jpf	L315
2262  0b36               L733:
2263                     ; 729 			N_UDSDdata.Indication = 0;
2265  0b36 c70284        	ld	_N_UDSDdata+1,a
2266                     ; 730 			ErrorCode = NCR11;
2268                     ; 731  			UDSsendone(0x03,ErRequst,SID37,ErrorCode,0,0,0,0);
2270  0b39 4b00          	push	#0
2271  0b3b 4b00          	push	#0
2272  0b3d 4b00          	push	#0
2273  0b3f 4b00          	push	#0
2274  0b41 4b11          	push	#17
2275  0b43 4b37          	push	#55
2276  0b45 ae007f        	ldw	x,#127
2277  0b48 a603          	ld	a,#3
2279                     ; 732 			ErrorCode = 0;
2281                     ; 733 			ClearRPDUbuff();
2283                     ; 734 		}break;
2285  0b4a ac040c04      	jpf	L315
2286  0b4e               L143:
2287                     ; 738 			N_UDSDdata.Indication = 0;
2289  0b4e c70284        	ld	_N_UDSDdata+1,a
2290                     ; 739 			ErrorCode = NCR11;
2292                     ; 740  			UDSsendone(0x03,ErRequst,SID3d,ErrorCode,0,0,0,0);
2294  0b51 4b00          	push	#0
2295  0b53 4b00          	push	#0
2296  0b55 4b00          	push	#0
2297  0b57 4b00          	push	#0
2298  0b59 4b11          	push	#17
2299  0b5b 4b3d          	push	#61
2300  0b5d ae007f        	ldw	x,#127
2301  0b60 a603          	ld	a,#3
2303                     ; 741 			ErrorCode = 0;
2305                     ; 742 			ClearRPDUbuff();
2307                     ; 743 		}break;
2309  0b62 ac040c04      	jpf	L315
2310  0b66               L343:
2311                     ; 747 			N_UDSDdata.Indication = 0;
2313  0b66 c70284        	ld	_N_UDSDdata+1,a
2314                     ; 748             ErrorCode = UDSDiag3e(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
2316  0b69 3b00ae        	push	_R_PDU+9
2317  0b6c 3b00ad        	push	_R_PDU+8
2318  0b6f 3b00ac        	push	_R_PDU+7
2319  0b72 3b00ab        	push	_R_PDU+6
2320  0b75 3b00aa        	push	_R_PDU+5
2321  0b78 3b00a9        	push	_R_PDU+4
2322  0b7b c600a8        	ld	a,_R_PDU+3
2323  0b7e 97            	ld	xl,a
2324  0b7f c600a7        	ld	a,_R_PDU+2
2325  0b82 95            	ld	xh,a
2326  0b83 8d820c82      	callf	f_UDSDiag3e
2328  0b87 5b06          	addw	sp,#6
2329  0b89 6b01          	ld	(OFST+0,sp),a
2330                     ; 749 			if(ErrorCode == 0xff)
2332  0b8b 4c            	inc	a
2333  0b8c 278c          	jreq	L714
2334                     ; 751                              break;  //不需要响应    清除时间参数变量
2336                     ; 753 			else if(ErrorCode == 0)
2338  0b8e 7b01          	ld	a,(OFST+0,sp)
2339  0b90 2611          	jrne	L505
2340                     ; 755  				 UDSsendone(0x02,SID3e+0x40,0,0,0,0,0,0);
2342  0b92 4b00          	push	#0
2343  0b94 4b00          	push	#0
2344  0b96 4b00          	push	#0
2345  0b98 4b00          	push	#0
2346  0b9a 4b00          	push	#0
2347  0b9c 4b00          	push	#0
2348  0b9e ae007e        	ldw	x,#126
2351  0ba1 205f          	jpf	LC009
2352  0ba3               L505:
2353                     ; 760  				UDSsendone(0x03,ErRequst,SID3e,ErrorCode,0,0,0,0);
2355  0ba3 4b00          	push	#0
2356  0ba5 4b00          	push	#0
2357  0ba7 4b00          	push	#0
2358  0ba9 4b00          	push	#0
2359  0bab 7b05          	ld	a,(OFST+4,sp)
2360  0bad 88            	push	a
2361  0bae 4b3e          	push	#62
2362  0bb0 ae007f        	ldw	x,#127
2363  0bb3 a603          	ld	a,#3
2365                     ; 763 			ErrorCode = 0;
2367                     ; 764 			ClearRPDUbuff();
2369                     ; 765 		}break;
2371  0bb5 204d          	jpf	L315
2372  0bb7               L543:
2373                     ; 769 			N_UDSDdata.Indication = 0;
2375  0bb7 c70284        	ld	_N_UDSDdata+1,a
2376                     ; 770 			ErrorCode = UDSDiag85(R_PDU[0].PCI,R_PDU[0].Data[0],R_PDU[0].Data[1],R_PDU[0].Data[2],R_PDU[0].Data[3],R_PDU[0].Data[4],R_PDU[0].Data[5],R_PDU[0].Data[6]);
2378  0bba 3b00ae        	push	_R_PDU+9
2379  0bbd 3b00ad        	push	_R_PDU+8
2380  0bc0 3b00ac        	push	_R_PDU+7
2381  0bc3 3b00ab        	push	_R_PDU+6
2382  0bc6 3b00aa        	push	_R_PDU+5
2383  0bc9 3b00a9        	push	_R_PDU+4
2384  0bcc c600a8        	ld	a,_R_PDU+3
2385  0bcf 97            	ld	xl,a
2386  0bd0 c600a7        	ld	a,_R_PDU+2
2387  0bd3 95            	ld	xh,a
2388  0bd4 8daa0caa      	callf	f_UDSDiag85
2390  0bd8 5b06          	addw	sp,#6
2391  0bda 6b01          	ld	(OFST+0,sp),a
2392                     ; 771             if(ErrorCode != NCRright)
2394  0bdc 2714          	jreq	L115
2395                     ; 773  				UDSsendone(0x03,ErRequst,SID85,ErrorCode,0,0,0,0);
2397  0bde 4b00          	push	#0
2398  0be0 4b00          	push	#0
2399  0be2 4b00          	push	#0
2400  0be4 4b00          	push	#0
2401  0be6 7b05          	ld	a,(OFST+4,sp)
2402  0be8 88            	push	a
2403  0be9 4b85          	push	#133
2404  0beb ae007f        	ldw	x,#127
2405  0bee a603          	ld	a,#3
2408  0bf0 2012          	jra	L315
2409  0bf2               L115:
2410                     ; 777 				UDSsendone(0x02,SID85+0x40,R_PDU[0].Data[1],0,0,0,0,0);
2412  0bf2 4b00          	push	#0
2413  0bf4 4b00          	push	#0
2414  0bf6 4b00          	push	#0
2415  0bf8 4b00          	push	#0
2416  0bfa 4b00          	push	#0
2417  0bfc 3b00a9        	push	_R_PDU+4
2418  0bff ae00c5        	ldw	x,#197
2419  0c02               LC009:
2420  0c02 a602          	ld	a,#2
2422  0c04               L315:
2423  0c04 95            	ld	xh,a
2424  0c05 8d110c11      	callf	f_UDSsendone
2425  0c09 5b06          	addw	sp,#6
2426                     ; 780 			ErrorCode = 0;
2428                     ; 781 			ClearRPDUbuff();
2430  0c0b               LC004:
2449  0c0b 8d6d206d      	callf	f_ClearRPDUbuff
2451                     ; 782 		}break;
2453  0c0f               L714:
2454                     ; 796 }
2457  0c0f 84            	pop	a
2458  0c10 87            	retf	
2541                     ; 799 void UDSsendone(uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6,uu8 d7)
2541                     ; 800 {
2542                     	switch	.text
2543  0c11               f_UDSsendone:
2545  0c11 89            	pushw	x
2546       00000000      OFST:	set	0
2549                     ; 801 	 ClearRPDUbuff();
2551  0c12 8d6d206d      	callf	f_ClearRPDUbuff
2553                     ; 802      N_PDU[0].AI = TesterBCM;
2555  0c16 ae0708        	ldw	x,#1800
2556  0c19 cf016d        	ldw	_N_PDU,x
2557                     ; 803 	 N_PDU[0].PCI = d0;
2559  0c1c 7b01          	ld	a,(OFST+1,sp)
2560  0c1e c7016f        	ld	_N_PDU+2,a
2561                     ; 804 	 N_PDU[0].Data[0] = d1;
2563  0c21 7b02          	ld	a,(OFST+2,sp)
2564  0c23 c70170        	ld	_N_PDU+3,a
2565                     ; 805 	 N_PDU[0].Data[1] = d2;
2567  0c26 7b06          	ld	a,(OFST+6,sp)
2568  0c28 c70171        	ld	_N_PDU+4,a
2569                     ; 806 	 N_PDU[0].Data[2] = d3;
2571  0c2b 7b07          	ld	a,(OFST+7,sp)
2572  0c2d c70172        	ld	_N_PDU+5,a
2573                     ; 807 	 N_PDU[0].Data[3] = d4;
2575  0c30 7b08          	ld	a,(OFST+8,sp)
2576  0c32 c70173        	ld	_N_PDU+6,a
2577                     ; 808 	 N_PDU[0].Data[4] = d5;
2579  0c35 7b09          	ld	a,(OFST+9,sp)
2580  0c37 c70174        	ld	_N_PDU+7,a
2581                     ; 809 	 N_PDU[0].Data[5] = d6;
2583  0c3a 7b0a          	ld	a,(OFST+10,sp)
2584  0c3c c70175        	ld	_N_PDU+8,a
2585                     ; 810 	 N_PDU[0].Data[6] = d7;
2587  0c3f 7b0b          	ld	a,(OFST+11,sp)
2588  0c41 c70176        	ld	_N_PDU+9,a
2589                     ; 812 	 N_UDSDdata.Request = 1; //dan zheng send 
2591  0c44 35010283      	mov	_N_UDSDdata,#1
2592                     ; 814 }
2595  0c48 85            	popw	x
2596  0c49 87            	retf	
2644                     ; 817 unsigned char  UDSDiag10(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
2644                     ; 818 {
2645                     	switch	.text
2646  0c4a               f_UDSDiag10:
2648  0c4a 89            	pushw	x
2649  0c4b 88            	push	a
2650       00000001      OFST:	set	1
2653                     ; 819     unsigned char Errorvalue=0;
2655  0c4c 0f01          	clr	(OFST+0,sp)
2656                     ; 822 	if(pci  != 2){ Errorvalue=NCR13; return Errorvalue;}
2658  0c4e 9e            	ld	a,xh
2659  0c4f a102          	cp	a,#2
2660  0c51 2704          	jreq	L575
2665  0c53 a613          	ld	a,#19
2667  0c55 2028          	jra	L106
2668  0c57               L575:
2669                     ; 824     switch(d1)
2671  0c57 7b07          	ld	a,(OFST+6,sp)
2673                     ; 851 		}break;
2674  0c59 4a            	dec	a
2675  0c5a 2710          	jreq	L745
2676  0c5c a002          	sub	a,#2
2677  0c5e 2715          	jreq	L155
2678                     ; 848 			SystemMode = defaSession;
2680  0c60 35010052      	mov	_SystemMode,#1
2681                     ; 849 			SalfeMode = Salfe0;
2683  0c64 725f0051      	clr	_SalfeMode
2684                     ; 850 			Errorvalue = NCR12;
2686  0c68 a612          	ld	a,#18
2687                     ; 851 		}break;
2689  0c6a 2013          	jra	L106
2690  0c6c               L745:
2691                     ; 828 			SystemMode = defaSession;
2693  0c6c 35010052      	mov	_SystemMode,#1
2694                     ; 829 			SalfeMode = Salfe0;
2696  0c70 c70051        	ld	_SalfeMode,a
2697                     ; 830 			Errorvalue = NCRright;
2699                     ; 831 		}break;
2701  0c73 200a          	jra	L106
2702  0c75               L155:
2703                     ; 841 				SystemMode = exDiagSession;
2705  0c75 35030052      	mov	_SystemMode,#3
2706                     ; 842 			       time3e = time3etime;
2708  0c79 ae0271        	ldw	x,#625
2709  0c7c cf0058        	ldw	_time3e,x
2710                     ; 843 				Errorvalue = NCRright;
2712                     ; 845 		}break;
2714  0c7f               L106:
2715                     ; 856     return Errorvalue;
2719  0c7f 5b03          	addw	sp,#3
2720  0c81 87            	retf	
2766                     ; 862 unsigned char UDSDiag3e(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
2766                     ; 863 {
2767                     	switch	.text
2768  0c82               f_UDSDiag3e:
2770  0c82 89            	pushw	x
2771  0c83 88            	push	a
2772       00000001      OFST:	set	1
2775                     ; 864       unsigned char Errorvalue=0;
2777  0c84 0f01          	clr	(OFST+0,sp)
2778                     ; 865 	if(pci != 2) return NCR13;
2780  0c86 9e            	ld	a,xh
2781  0c87 a102          	cp	a,#2
2782  0c89 2704          	jreq	L326
2785  0c8b a613          	ld	a,#19
2787  0c8d 2018          	jra	L726
2788  0c8f               L326:
2789                     ; 868 	if(d1 == 0x80)
2791  0c8f 7b07          	ld	a,(OFST+6,sp)
2792  0c91 a180          	cp	a,#128
2793  0c93 2604          	jrne	L526
2794                     ; 870                Errorvalue = 0xff;  //不需要相应
2796  0c95 a6ff          	ld	a,#255
2797                     ; 871                time3e = time3etime;
2799  0c97 2004          	jpf	LC010
2800  0c99               L526:
2801                     ; 873 	else if(d1 == 0x00)
2803  0c99 7b07          	ld	a,(OFST+6,sp)
2804  0c9b 2608          	jrne	L136
2805                     ; 875               Errorvalue = 0;
2807                     ; 876 		time3e = time3etime;
2809  0c9d               LC010:
2811  0c9d ae0271        	ldw	x,#625
2812  0ca0 cf0058        	ldw	_time3e,x
2814  0ca3 2002          	jra	L726
2815  0ca5               L136:
2816                     ; 880                Errorvalue = NCR12;
2818  0ca5 a612          	ld	a,#18
2819  0ca7               L726:
2820                     ; 884 	return Errorvalue;
2824  0ca7 5b03          	addw	sp,#3
2825  0ca9 87            	retf	
2827                     	switch	.bss
2828  000e               L536_Errorvalue:
2829  000e 00            	ds.b	1
2875                     ; 893 unsigned char UDSDiag85(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
2875                     ; 894 {
2876                     	switch	.text
2877  0caa               f_UDSDiag85:
2879  0caa 89            	pushw	x
2880       00000000      OFST:	set	0
2883                     ; 896     if(pci != 2) return NCR13;
2885  0cab 9e            	ld	a,xh
2886  0cac a102          	cp	a,#2
2887  0cae 2704          	jreq	L766
2890  0cb0 a613          	ld	a,#19
2892  0cb2 2009          	jra	L062
2893  0cb4               L766:
2894                     ; 897     if(SystemMode != exDiagSession)return NCR7f;
2896  0cb4 c60052        	ld	a,_SystemMode
2897  0cb7 a103          	cp	a,#3
2898  0cb9 2704          	jreq	L176
2901  0cbb a67f          	ld	a,#127
2903  0cbd               L062:
2905  0cbd 85            	popw	x
2906  0cbe 87            	retf	
2907  0cbf               L176:
2908                     ; 899 	switch(d1)
2910  0cbf 7b06          	ld	a,(OFST+6,sp)
2912                     ; 915 	   default: Errorvalue = NCR12 ;break;
2913  0cc1 2706          	jreq	L736
2914  0cc3 4a            	dec	a
2915  0cc4 2709          	jreq	L146
2916  0cc6 4a            	dec	a
2917  0cc7 270b          	jreq	L346
2921  0cc9               L736:
2922                     ; 903      		Errorvalue = NCR12 ;
2925  0cc9 3512000e      	mov	L536_Errorvalue,#18
2926                     ; 904 	   }break;
2928  0ccd 200c          	jra	L576
2929  0ccf               L146:
2930                     ; 907 	   	    DTCRuningstate = 0;//open  DTC
2932  0ccf c70007        	ld	_DTCRuningstate,a
2933                     ; 908                   Errorvalue = NCRright;
2934                     ; 909 	   }break;
2936  0cd2 2004          	jpf	LC011
2937  0cd4               L346:
2938                     ; 912 	   	       DTCRuningstate = 1; //Close DTC
2940  0cd4 35010007      	mov	_DTCRuningstate,#1
2941                     ; 913 			Errorvalue = NCRright;
2943  0cd8               LC011:
2945  0cd8 c7000e        	ld	L536_Errorvalue,a
2946                     ; 914 	   }break;
2948  0cdb               L576:
2949                     ; 919 	if(pci >= 7)Errorvalue = NCR13;
2951  0cdb 7b01          	ld	a,(OFST+1,sp)
2952  0cdd a107          	cp	a,#7
2953  0cdf 2504          	jrult	L776
2956  0ce1 3513000e      	mov	L536_Errorvalue,#19
2957  0ce5               L776:
2958                     ; 921 	return Errorvalue;
2960  0ce5 c6000e        	ld	a,L536_Errorvalue
2962  0ce8 20d3          	jra	L062
3016                     ; 926 unsigned char UDSDiag28(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
3016                     ; 927 {
3017                     	switch	.text
3018  0cea               f_UDSDiag28:
3020  0cea 89            	pushw	x
3021  0ceb 88            	push	a
3022       00000001      OFST:	set	1
3025                     ; 928    unsigned char Errorvalue=0;
3027  0cec 0f01          	clr	(OFST+0,sp)
3028                     ; 930    if(pci != 0x03) return NCR13; //add diag error long
3030  0cee 9e            	ld	a,xh
3031  0cef a103          	cp	a,#3
3032  0cf1 2704          	jreq	L537
3035  0cf3 a613          	ld	a,#19
3037  0cf5 2009          	jra	L462
3038  0cf7               L537:
3039                     ; 931    if(SystemMode != exDiagSession)return NCR7f;
3041  0cf7 c60052        	ld	a,_SystemMode
3042  0cfa a103          	cp	a,#3
3043  0cfc 2705          	jreq	L737
3046  0cfe a67f          	ld	a,#127
3048  0d00               L462:
3050  0d00 5b03          	addw	sp,#3
3051  0d02 87            	retf	
3052  0d03               L737:
3053                     ; 934    switch(d1)
3055  0d03 7b07          	ld	a,(OFST+6,sp)
3057                     ; 968 		}break;
3058  0d05 270b          	jreq	L107
3059  0d07 4a            	dec	a
3060  0d08 2726          	jreq	L157
3061  0d0a 4a            	dec	a
3062  0d0b 2723          	jreq	L157
3063  0d0d 4a            	dec	a
3064  0d0e 2711          	jreq	L707
3065                     ; 967 			Errorvalue = NCR12;
3066                     ; 968 		}break;
3068  0d10 201e          	jpf	L157
3069  0d12               L107:
3070                     ; 938                      CommControl = 0x00;
3072  0d12 c70008        	ld	_CommControl,a
3073                     ; 939 			if(d2 == 0x00)
3075  0d15 0d08          	tnz	(OFST+7,sp)
3076  0d17 2617          	jrne	L157
3077                     ; 941 			           CommControl += d2;
3079                     ; 942 				    Errorvalue =NCRright;
3081  0d19               LC014:
3082  0d19 1b08          	add	a,(OFST+7,sp)
3083  0d1b c70008        	ld	_CommControl,a
3085  0d1e 4f            	clr	a
3087  0d1f 20df          	jra	L462
3088                     ; 944 			else Errorvalue = NCR12;
3089                     ; 948 			Errorvalue = NCR12;
3090                     ; 949 		}break;
3092                     ; 952 			Errorvalue = NCR12;
3093                     ; 953 		}break;
3095  0d21               L707:
3096                     ; 956                   CommControl = 0x30;
3098  0d21 35300008      	mov	_CommControl,#48
3099                     ; 957 		    if(d2 == 0x03)
3101  0d25 7b08          	ld	a,(OFST+7,sp)
3102  0d27 a103          	cp	a,#3
3103  0d29 2605          	jrne	L157
3104                     ; 959 		             CommControl += d2;
3106  0d2b c60008        	ld	a,_CommControl
3107                     ; 960 			      Errorvalue =NCRright;
3109  0d2e 20e9          	jpf	LC014
3110  0d30               L157:
3111                     ; 962 		    else  Errorvalue =NCR12;		    
3117  0d30 a612          	ld	a,#18
3118                     ; 974    return Errorvalue;
3121  0d32 20cc          	jra	L462
3191                     ; 979 unsigned char UDSDiag31(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
3191                     ; 980 {
3192                     	switch	.text
3193  0d34               f_UDSDiag31:
3195  0d34 89            	pushw	x
3196  0d35 5203          	subw	sp,#3
3197       00000003      OFST:	set	3
3200                     ; 981 	unsigned char Errorvalue=0;
3202  0d37 0f03          	clr	(OFST+0,sp)
3203                     ; 984 	if(pci != 0x04) return NCR13;
3205  0d39 9e            	ld	a,xh
3206  0d3a a104          	cp	a,#4
3207  0d3c 2704          	jreq	L3101
3210  0d3e a613          	ld	a,#19
3212  0d40 200c          	jra	L472
3213  0d42               L3101:
3214                     ; 986 	if(SalfeMode < salfe02) {Errorvalue = NCR33;return Errorvalue;}
3216  0d42 c60051        	ld	a,_SalfeMode
3217  0d45 a102          	cp	a,#2
3218  0d47 2408          	jruge	L5101
3221  0d49 7b03          	ld	a,(OFST+0,sp)
3222  0d4b 97            	ld	xl,a
3225  0d4c a633          	ld	a,#51
3227  0d4e               L472:
3229  0d4e 5b05          	addw	sp,#5
3230  0d50 87            	retf	
3231  0d51               L5101:
3232                     ; 987     Didnumber = d2;
3234  0d51 7b0a          	ld	a,(OFST+7,sp)
3235  0d53 5f            	clrw	x
3236  0d54 97            	ld	xl,a
3237                     ; 988 	Didnumber = (Didnumber<<8) +d3;
3239  0d55 4f            	clr	a
3240  0d56 1b0b          	add	a,(OFST+8,sp)
3241  0d58 2401          	jrnc	L072
3242  0d5a 5c            	incw	x
3243  0d5b               L072:
3244  0d5b 02            	rlwa	x,a
3245  0d5c 1f01          	ldw	(OFST-2,sp),x
3246                     ; 989     if(Didnumber == DidFD01)
3248  0d5e a3fd01        	cpw	x,#64769
3249  0d61 2636          	jrne	L7101
3250                     ; 991          switch(d1)
3252  0d63 7b09          	ld	a,(OFST+6,sp)
3254                     ; 1021 			 }break;
3255  0d65 4a            	dec	a
3256  0d66 270a          	jreq	L557
3257  0d68 4a            	dec	a
3258  0d69 271a          	jreq	L757
3259  0d6b 4a            	dec	a
3260  0d6c 2728          	jreq	L167
3261                     ; 1020 				Errorvalue = NCR12;
3263  0d6e a612          	ld	a,#18
3264                     ; 1021 			 }break;
3266  0d70 2029          	jpf	LC015
3267  0d72               L557:
3268                     ; 995                              KEYleanstate = d1 ;
3270  0d72 7b09          	ld	a,(OFST+6,sp)
3271  0d74 c70050        	ld	_KEYleanstate,a
3272                     ; 996 				 INITrkenumber();
3274  0d77 8d000000      	callf	f_INITrkenumber
3276                     ; 997 				 EnalbeLearnRkeTime20s = 1250 ;
3278  0d7b ae04e2        	ldw	x,#1250
3279  0d7e cf0000        	ldw	_EnalbeLearnRkeTime20s,x
3280                     ; 998 				 Errorvalue = NCRright;
3282  0d81               LC016:
3284  0d81 0f03          	clr	(OFST+0,sp)
3285                     ; 999 			 }break;
3287  0d83 2018          	jra	L1301
3288  0d85               L757:
3289                     ; 1002 			 	if(KEYleanstate == Start)
3291  0d85 c60050        	ld	a,_KEYleanstate
3292  0d88 4a            	dec	a
3293  0d89 2607          	jrne	L5201
3294                     ; 1004 					 KEYleanstate = d1 ;
3296  0d8b 7b09          	ld	a,(OFST+6,sp)
3297  0d8d c70050        	ld	_KEYleanstate,a
3298                     ; 1005 					 Errorvalue = NCRright;
3300  0d90 20ef          	jpf	LC016
3301  0d92               L5201:
3302                     ; 1009 					 Errorvalue = NCR24;
3304  0d92 a624          	ld	a,#36
3305  0d94 2005          	jpf	LC015
3306  0d96               L167:
3307                     ; 1016 				 Errorvalue = NCRright+1;  //需要返回例程执行结果
3309  0d96 4c            	inc	a
3310                     ; 1017 			 }break;
3312  0d97 2002          	jpf	LC015
3313                     ; 1021 			 }break;
3314  0d99               L7101:
3315                     ; 1026         Errorvalue = NCR31;
3317  0d99 a631          	ld	a,#49
3318  0d9b               LC015:
3319  0d9b 6b03          	ld	(OFST+0,sp),a
3320  0d9d               L1301:
3321                     ; 1029     if(pci >= 8) Errorvalue = NCR13;
3323  0d9d 7b04          	ld	a,(OFST+1,sp)
3324  0d9f a108          	cp	a,#8
3325  0da1 2504          	jrult	L3301
3328  0da3 a613          	ld	a,#19
3329  0da5 6b03          	ld	(OFST+0,sp),a
3330  0da7               L3301:
3331                     ; 1030 	return Errorvalue;
3333  0da7 7b03          	ld	a,(OFST+0,sp)
3335  0da9 20a3          	jra	L472
3388                     ; 1035 unsigned char UDSDiag22(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
3388                     ; 1036 {
3389                     	switch	.text
3390  0dab               f_UDSDiag22:
3392  0dab 89            	pushw	x
3393  0dac 88            	push	a
3394       00000001      OFST:	set	1
3397                     ; 1037 	unsigned char Errorvalue=0;
3399                     ; 1042     if((pci < 0x03)||(pci == 0x04)||(pci == 0x06)) {Errorvalue = NCR13; return Errorvalue;}  //add diag error long
3401  0dad 7b02          	ld	a,(OFST+1,sp)
3402  0daf a103          	cp	a,#3
3403  0db1 2508          	jrult	L1601
3405  0db3 a104          	cp	a,#4
3406  0db5 2704          	jreq	L1601
3408  0db7 a106          	cp	a,#6
3409  0db9 2607          	jrne	L7501
3410  0dbb               L1601:
3413  0dbb 7b01          	ld	a,(OFST+0,sp)
3414  0dbd 97            	ld	xl,a
3417  0dbe a613          	ld	a,#19
3419  0dc0 2029          	jra	L403
3420  0dc2               L7501:
3421                     ; 1044     if(pci & 0x80)  //多帧接收
3423  0dc2 a580          	bcp	a,#128
3424  0dc4 2717          	jreq	L5601
3425                     ; 1046          if(((pci &0x7f)%2) != 0)Errorvalue = NCR13; //add diag error long
3427  0dc6 a401          	and	a,#1
3428  0dc8 2705          	jreq	L7601
3431  0dca 7b01          	ld	a,(OFST+0,sp)
3432  0dcc 97            	ld	xl,a
3434  0dcd 2018          	jra	L3701
3435  0dcf               L7601:
3436                     ; 1049              Didlang = (((pci&0x7f)+d0)-2)>>1;
3438  0dcf 7b02          	ld	a,(OFST+1,sp)
3439  0dd1 a47f          	and	a,#127
3440  0dd3 5f            	clrw	x
3441  0dd4 1b03          	add	a,(OFST+2,sp)
3442  0dd6 59            	rlcw	x
3443  0dd7 02            	rlwa	x,a
3444  0dd8 1d0002        	subw	x,#2
3445  0ddb 2003          	jpf	LC017
3446  0ddd               L5601:
3447                     ; 1054          Didlang = (pci-1)>>1;
3449  0ddd 5f            	clrw	x
3450  0dde 97            	ld	xl,a
3451  0ddf 5a            	decw	x
3452  0de0               LC017:
3453  0de0 57            	sraw	x
3454  0de1 01            	rrwa	x,a
3455  0de2 6b01          	ld	(OFST+0,sp),a
3456  0de4 02            	rlwa	x,a
3457  0de5 7b01          	ld	a,(OFST+0,sp)
3458  0de7               L3701:
3459                     ; 1058 	Errorvalue = ReadDid22(Didlang);
3461  0de7 8d621062      	callf	f_ReadDid22
3463                     ; 1062 	return Errorvalue;
3466  0deb               L403:
3468  0deb 5b03          	addw	sp,#3
3469  0ded 87            	retf	
3521                     ; 1081 void  Did2einit(void)
3521                     ; 1082 {
3522                     	switch	.text
3523  0dee               f_Did2einit:
3525  0dee 89            	pushw	x
3526       00000002      OFST:	set	2
3529                     ; 1085 	datalong = 17;
3531  0def a611          	ld	a,#17
3532  0df1 6b01          	ld	(OFST-1,sp),a
3533                     ; 1086 	for(data = 0;data < datalong;data++)
3535  0df3 0f02          	clr	(OFST+0,sp)
3537  0df5 200a          	jra	L7111
3538  0df7               L3111:
3539                     ; 1088             F190didsavevin[data] = DIDF190EEPROM[data];
3541  0df7 5f            	clrw	x
3542  0df8 97            	ld	xl,a
3543  0df9 d64113        	ld	a,(_DIDF190EEPROM,x)
3544  0dfc d7002b        	ld	(_F190didsavevin,x),a
3545                     ; 1086 	for(data = 0;data < datalong;data++)
3547  0dff 0c02          	inc	(OFST+0,sp)
3548  0e01               L7111:
3551  0e01 7b02          	ld	a,(OFST+0,sp)
3552  0e03 1101          	cp	a,(OFST-1,sp)
3553  0e05 25f0          	jrult	L3111
3554                     ; 1091 	datalong = 7;
3556  0e07 a607          	ld	a,#7
3557  0e09 6b01          	ld	(OFST-1,sp),a
3558                     ; 1092 	for(data = 0;data < datalong;data++)
3560  0e0b 0f02          	clr	(OFST+0,sp)
3562  0e0d 200a          	jra	L7211
3563  0e0f               L3211:
3564                     ; 1094             F18Cdidsave[data] = DIDF18cEEPROM[data];
3566  0e0f 5f            	clrw	x
3567  0e10 97            	ld	xl,a
3568  0e11 d6410c        	ld	a,(_DIDF18cEEPROM,x)
3569  0e14 d70023        	ld	(_F18Cdidsave,x),a
3570                     ; 1092 	for(data = 0;data < datalong;data++)
3572  0e17 0c02          	inc	(OFST+0,sp)
3573  0e19               L7211:
3576  0e19 7b02          	ld	a,(OFST+0,sp)
3577  0e1b 1101          	cp	a,(OFST-1,sp)
3578  0e1d 25f0          	jrult	L3211
3579                     ; 1097 	datalong = 4;
3581  0e1f a604          	ld	a,#4
3582  0e21 6b01          	ld	(OFST-1,sp),a
3583                     ; 1098 	for(data = 0;data < datalong;data++)
3585  0e23 0f02          	clr	(OFST+0,sp)
3587  0e25 200a          	jra	L7311
3588  0e27               L3311:
3589                     ; 1100             F18Bdidsave[data] = DIDF18bEEPROM[data];
3591  0e27 5f            	clrw	x
3592  0e28 97            	ld	xl,a
3593  0e29 d64100        	ld	a,(_DIDF18bEEPROM,x)
3594  0e2c d7001e        	ld	(_F18Bdidsave,x),a
3595                     ; 1098 	for(data = 0;data < datalong;data++)
3597  0e2f 0c02          	inc	(OFST+0,sp)
3598  0e31               L7311:
3601  0e31 7b02          	ld	a,(OFST+0,sp)
3602  0e33 1101          	cp	a,(OFST-1,sp)
3603  0e35 25f0          	jrult	L3311
3604                     ; 1103 	datalong = 4;
3606  0e37 a604          	ld	a,#4
3607  0e39 6b01          	ld	(OFST-1,sp),a
3608                     ; 1104 	for(data = 0;data < datalong;data++)
3610  0e3b 0f02          	clr	(OFST+0,sp)
3612  0e3d 200a          	jra	L7411
3613  0e3f               L3411:
3614                     ; 1106             F19ddidsave[data] = DIDF19dEEPROM[data];
3616  0e3f 5f            	clrw	x
3617  0e40 97            	ld	xl,a
3618  0e41 d64104        	ld	a,(_DIDF19dEEPROM,x)
3619  0e44 d70019        	ld	(_F19ddidsave,x),a
3620                     ; 1104 	for(data = 0;data < datalong;data++)
3622  0e47 0c02          	inc	(OFST+0,sp)
3623  0e49               L7411:
3626  0e49 7b02          	ld	a,(OFST+0,sp)
3627  0e4b 1101          	cp	a,(OFST-1,sp)
3628  0e4d 25f0          	jrult	L3411
3629                     ; 1109 	datalong = 2;
3631  0e4f a602          	ld	a,#2
3632  0e51 6b01          	ld	(OFST-1,sp),a
3633                     ; 1110 	for(data = 0;data < datalong;data++)
3635  0e53 0f02          	clr	(OFST+0,sp)
3637  0e55 200a          	jra	L7511
3638  0e57               L3511:
3639                     ; 1112             F1f2didsave[data] = DIDF1f2EEPROM[data];
3641  0e57 5f            	clrw	x
3642  0e58 97            	ld	xl,a
3643  0e59 d64108        	ld	a,(_DIDF1f2EEPROM,x)
3644  0e5c d70016        	ld	(_F1f2didsave,x),a
3645                     ; 1110 	for(data = 0;data < datalong;data++)
3647  0e5f 0c02          	inc	(OFST+0,sp)
3648  0e61               L7511:
3651  0e61 7b02          	ld	a,(OFST+0,sp)
3652  0e63 1101          	cp	a,(OFST-1,sp)
3653  0e65 25f0          	jrult	L3511
3654                     ; 1115 	datalong = 2;
3656  0e67 a602          	ld	a,#2
3657  0e69 6b01          	ld	(OFST-1,sp),a
3658                     ; 1116 	for(data = 0;data < datalong;data++)
3660  0e6b 0f02          	clr	(OFST+0,sp)
3662  0e6d 200a          	jra	L7611
3663  0e6f               L3611:
3664                     ; 1118             F1f3didsave[data] = DIDF1f3EEPROM[data];
3666  0e6f 5f            	clrw	x
3667  0e70 97            	ld	xl,a
3668  0e71 d6410a        	ld	a,(_DIDF1f3EEPROM,x)
3669  0e74 d70013        	ld	(_F1f3didsave,x),a
3670                     ; 1116 	for(data = 0;data < datalong;data++)
3672  0e77 0c02          	inc	(OFST+0,sp)
3673  0e79               L7611:
3676  0e79 7b02          	ld	a,(OFST+0,sp)
3677  0e7b 1101          	cp	a,(OFST-1,sp)
3678  0e7d 25f0          	jrult	L3611
3679                     ; 1121 	datalong = 2;
3681  0e7f a602          	ld	a,#2
3682  0e81 6b01          	ld	(OFST-1,sp),a
3683                     ; 1122 	for(data = 0;data < datalong;data++)
3685  0e83 0f02          	clr	(OFST+0,sp)
3687  0e85 200a          	jra	L7711
3688  0e87               L3711:
3689                     ; 1124             F1f4didsave[data] = DIDF1F4EEPROM[data];
3691  0e87 5f            	clrw	x
3692  0e88 97            	ld	xl,a
3693  0e89 d64125        	ld	a,(_DIDF1F4EEPROM,x)
3694  0e8c d70010        	ld	(_F1f4didsave,x),a
3695                     ; 1122 	for(data = 0;data < datalong;data++)
3697  0e8f 0c02          	inc	(OFST+0,sp)
3698  0e91               L7711:
3701  0e91 7b02          	ld	a,(OFST+0,sp)
3702  0e93 1101          	cp	a,(OFST-1,sp)
3703  0e95 25f0          	jrult	L3711
3704                     ; 1126 }
3707  0e97 85            	popw	x
3708  0e98 87            	retf	
3753                     ; 1128 void Did2esave(void)
3753                     ; 1129 {
3754                     	switch	.text
3755  0e99               f_Did2esave:
3757  0e99 5204          	subw	sp,#4
3758       00000004      OFST:	set	4
3761                     ; 1130      if(F190Savestate != 0)
3763  0e9b c6002a        	ld	a,_F190Savestate
3764  0e9e 273b          	jreq	L3121
3765                     ; 1132          F190Savestate--;
3767  0ea0 725a002a      	dec	_F190Savestate
3768                     ; 1133          Weeprommain((unsigned long)(&DIDF190EEPROM[F190Savestate]),F190didsavevin[F190Savestate]);
3770  0ea4 c6002a        	ld	a,_F190Savestate
3771  0ea7 5f            	clrw	x
3772  0ea8 97            	ld	xl,a
3773  0ea9 d6002b        	ld	a,(_F190didsavevin,x)
3774  0eac 88            	push	a
3775  0ead ae4113        	ldw	x,#_DIDF190EEPROM
3776  0eb0 8d000000      	callf	d_uitolx
3778  0eb4 96            	ldw	x,sp
3779  0eb5 1c0002        	addw	x,#OFST-2
3780  0eb8 8d000000      	callf	d_rtol
3782  0ebc 55002a0003    	mov	c_lreg+3,_F190Savestate
3783  0ec1 3f02          	clr	c_lreg+2
3784  0ec3 3f01          	clr	c_lreg+1
3785  0ec5 3f00          	clr	c_lreg
3786  0ec7 96            	ldw	x,sp
3787  0ec8 1c0002        	addw	x,#OFST-2
3788  0ecb 8d000000      	callf	d_ladd
3790  0ecf be02          	ldw	x,c_lreg+2
3791  0ed1 89            	pushw	x
3792  0ed2 be00          	ldw	x,c_lreg
3793  0ed4 89            	pushw	x
3794  0ed5 8d000000      	callf	f_Weeprommain
3796  0ed9 5b05          	addw	sp,#5
3797  0edb               L3121:
3798                     ; 1135      if(F18CSavestate !=0)
3800  0edb c60022        	ld	a,_F18CSavestate
3801  0ede 273b          	jreq	L5121
3802                     ; 1137          F18CSavestate--;
3804  0ee0 725a0022      	dec	_F18CSavestate
3805                     ; 1138          Weeprommain((unsigned long)(&DIDF18cEEPROM[F18CSavestate]),F18Cdidsave[F18CSavestate]);
3807  0ee4 c60022        	ld	a,_F18CSavestate
3808  0ee7 5f            	clrw	x
3809  0ee8 97            	ld	xl,a
3810  0ee9 d60023        	ld	a,(_F18Cdidsave,x)
3811  0eec 88            	push	a
3812  0eed ae410c        	ldw	x,#_DIDF18cEEPROM
3813  0ef0 8d000000      	callf	d_uitolx
3815  0ef4 96            	ldw	x,sp
3816  0ef5 1c0002        	addw	x,#OFST-2
3817  0ef8 8d000000      	callf	d_rtol
3819  0efc 5500220003    	mov	c_lreg+3,_F18CSavestate
3820  0f01 3f02          	clr	c_lreg+2
3821  0f03 3f01          	clr	c_lreg+1
3822  0f05 3f00          	clr	c_lreg
3823  0f07 96            	ldw	x,sp
3824  0f08 1c0002        	addw	x,#OFST-2
3825  0f0b 8d000000      	callf	d_ladd
3827  0f0f be02          	ldw	x,c_lreg+2
3828  0f11 89            	pushw	x
3829  0f12 be00          	ldw	x,c_lreg
3830  0f14 89            	pushw	x
3831  0f15 8d000000      	callf	f_Weeprommain
3833  0f19 5b05          	addw	sp,#5
3834  0f1b               L5121:
3835                     ; 1140      if(F18Bsavestate !=0)
3837  0f1b c6001d        	ld	a,_F18Bsavestate
3838  0f1e 273b          	jreq	L7121
3839                     ; 1142          F18Bsavestate--;
3841  0f20 725a001d      	dec	_F18Bsavestate
3842                     ; 1143          Weeprommain((unsigned long)(&DIDF18bEEPROM[F18Bsavestate]),F18Bdidsave[F18Bsavestate]);
3844  0f24 c6001d        	ld	a,_F18Bsavestate
3845  0f27 5f            	clrw	x
3846  0f28 97            	ld	xl,a
3847  0f29 d6001e        	ld	a,(_F18Bdidsave,x)
3848  0f2c 88            	push	a
3849  0f2d ae4100        	ldw	x,#_DIDF18bEEPROM
3850  0f30 8d000000      	callf	d_uitolx
3852  0f34 96            	ldw	x,sp
3853  0f35 1c0002        	addw	x,#OFST-2
3854  0f38 8d000000      	callf	d_rtol
3856  0f3c 55001d0003    	mov	c_lreg+3,_F18Bsavestate
3857  0f41 3f02          	clr	c_lreg+2
3858  0f43 3f01          	clr	c_lreg+1
3859  0f45 3f00          	clr	c_lreg
3860  0f47 96            	ldw	x,sp
3861  0f48 1c0002        	addw	x,#OFST-2
3862  0f4b 8d000000      	callf	d_ladd
3864  0f4f be02          	ldw	x,c_lreg+2
3865  0f51 89            	pushw	x
3866  0f52 be00          	ldw	x,c_lreg
3867  0f54 89            	pushw	x
3868  0f55 8d000000      	callf	f_Weeprommain
3870  0f59 5b05          	addw	sp,#5
3871  0f5b               L7121:
3872                     ; 1145      if(F19dsavestate !=0)
3874  0f5b c60018        	ld	a,_F19dsavestate
3875  0f5e 273b          	jreq	L1221
3876                     ; 1147          F19dsavestate--;
3878  0f60 725a0018      	dec	_F19dsavestate
3879                     ; 1148          Weeprommain((unsigned long)(&DIDF19dEEPROM[F19dsavestate]),F19ddidsave[F19dsavestate]);
3881  0f64 c60018        	ld	a,_F19dsavestate
3882  0f67 5f            	clrw	x
3883  0f68 97            	ld	xl,a
3884  0f69 d60019        	ld	a,(_F19ddidsave,x)
3885  0f6c 88            	push	a
3886  0f6d ae4104        	ldw	x,#_DIDF19dEEPROM
3887  0f70 8d000000      	callf	d_uitolx
3889  0f74 96            	ldw	x,sp
3890  0f75 1c0002        	addw	x,#OFST-2
3891  0f78 8d000000      	callf	d_rtol
3893  0f7c 5500180003    	mov	c_lreg+3,_F19dsavestate
3894  0f81 3f02          	clr	c_lreg+2
3895  0f83 3f01          	clr	c_lreg+1
3896  0f85 3f00          	clr	c_lreg
3897  0f87 96            	ldw	x,sp
3898  0f88 1c0002        	addw	x,#OFST-2
3899  0f8b 8d000000      	callf	d_ladd
3901  0f8f be02          	ldw	x,c_lreg+2
3902  0f91 89            	pushw	x
3903  0f92 be00          	ldw	x,c_lreg
3904  0f94 89            	pushw	x
3905  0f95 8d000000      	callf	f_Weeprommain
3907  0f99 5b05          	addw	sp,#5
3908  0f9b               L1221:
3909                     ; 1150      if(F1f2savestate !=0)
3911  0f9b c60015        	ld	a,_F1f2savestate
3912  0f9e 273b          	jreq	L3221
3913                     ; 1152          F1f2savestate--;
3915  0fa0 725a0015      	dec	_F1f2savestate
3916                     ; 1153          Weeprommain((unsigned long)(&DIDF1f2EEPROM[F1f2savestate]),F1f2didsave[F1f2savestate]);
3918  0fa4 c60015        	ld	a,_F1f2savestate
3919  0fa7 5f            	clrw	x
3920  0fa8 97            	ld	xl,a
3921  0fa9 d60016        	ld	a,(_F1f2didsave,x)
3922  0fac 88            	push	a
3923  0fad ae4108        	ldw	x,#_DIDF1f2EEPROM
3924  0fb0 8d000000      	callf	d_uitolx
3926  0fb4 96            	ldw	x,sp
3927  0fb5 1c0002        	addw	x,#OFST-2
3928  0fb8 8d000000      	callf	d_rtol
3930  0fbc 5500150003    	mov	c_lreg+3,_F1f2savestate
3931  0fc1 3f02          	clr	c_lreg+2
3932  0fc3 3f01          	clr	c_lreg+1
3933  0fc5 3f00          	clr	c_lreg
3934  0fc7 96            	ldw	x,sp
3935  0fc8 1c0002        	addw	x,#OFST-2
3936  0fcb 8d000000      	callf	d_ladd
3938  0fcf be02          	ldw	x,c_lreg+2
3939  0fd1 89            	pushw	x
3940  0fd2 be00          	ldw	x,c_lreg
3941  0fd4 89            	pushw	x
3942  0fd5 8d000000      	callf	f_Weeprommain
3944  0fd9 5b05          	addw	sp,#5
3945  0fdb               L3221:
3946                     ; 1155      if(F1f3savestate !=0)
3948  0fdb c60012        	ld	a,_F1f3savestate
3949  0fde 273b          	jreq	L5221
3950                     ; 1157          F1f3savestate--;
3952  0fe0 725a0012      	dec	_F1f3savestate
3953                     ; 1158          Weeprommain((unsigned long)(&DIDF1f3EEPROM[F1f3savestate]),F1f3didsave[F1f3savestate]);
3955  0fe4 c60012        	ld	a,_F1f3savestate
3956  0fe7 5f            	clrw	x
3957  0fe8 97            	ld	xl,a
3958  0fe9 d60013        	ld	a,(_F1f3didsave,x)
3959  0fec 88            	push	a
3960  0fed ae410a        	ldw	x,#_DIDF1f3EEPROM
3961  0ff0 8d000000      	callf	d_uitolx
3963  0ff4 96            	ldw	x,sp
3964  0ff5 1c0002        	addw	x,#OFST-2
3965  0ff8 8d000000      	callf	d_rtol
3967  0ffc 5500120003    	mov	c_lreg+3,_F1f3savestate
3968  1001 3f02          	clr	c_lreg+2
3969  1003 3f01          	clr	c_lreg+1
3970  1005 3f00          	clr	c_lreg
3971  1007 96            	ldw	x,sp
3972  1008 1c0002        	addw	x,#OFST-2
3973  100b 8d000000      	callf	d_ladd
3975  100f be02          	ldw	x,c_lreg+2
3976  1011 89            	pushw	x
3977  1012 be00          	ldw	x,c_lreg
3978  1014 89            	pushw	x
3979  1015 8d000000      	callf	f_Weeprommain
3981  1019 5b05          	addw	sp,#5
3982  101b               L5221:
3983                     ; 1160      if(F1f4savestate !=0)
3985  101b c6000f        	ld	a,_F1f4savestate
3986  101e 273f          	jreq	L7221
3987                     ; 1162          F1f4savestate--;
3989  1020 725a000f      	dec	_F1f4savestate
3990                     ; 1163          Weeprommain((unsigned long)(&DIDF1F4EEPROM[F1f4savestate]),F1f4didsave[F1f4savestate]);
3992  1024 c6000f        	ld	a,_F1f4savestate
3993  1027 5f            	clrw	x
3994  1028 97            	ld	xl,a
3995  1029 d60010        	ld	a,(_F1f4didsave,x)
3996  102c 88            	push	a
3997  102d ae4125        	ldw	x,#_DIDF1F4EEPROM
3998  1030 8d000000      	callf	d_uitolx
4000  1034 96            	ldw	x,sp
4001  1035 1c0002        	addw	x,#OFST-2
4002  1038 8d000000      	callf	d_rtol
4004  103c 55000f0003    	mov	c_lreg+3,_F1f4savestate
4005  1041 3f02          	clr	c_lreg+2
4006  1043 3f01          	clr	c_lreg+1
4007  1045 3f00          	clr	c_lreg
4008  1047 96            	ldw	x,sp
4009  1048 1c0002        	addw	x,#OFST-2
4010  104b 8d000000      	callf	d_ladd
4012  104f be02          	ldw	x,c_lreg+2
4013  1051 89            	pushw	x
4014  1052 be00          	ldw	x,c_lreg
4015  1054 89            	pushw	x
4016  1055 8d000000      	callf	f_Weeprommain
4018  1059 5b05          	addw	sp,#5
4019                     ; 1165 	  speedlockset =0x55;
4021  105b 35550000      	mov	_speedlockset,#85
4022  105f               L7221:
4023                     ; 1170 }
4026  105f 5b04          	addw	sp,#4
4027  1061 87            	retf	
4135                     ; 1172 unsigned char ReadDid22(unsigned char longdid)
4135                     ; 1173 {
4136                     	switch	.text
4137  1062               f_ReadDid22:
4139  1062 88            	push	a
4140  1063 520d          	subw	sp,#13
4141       0000000d      OFST:	set	13
4144                     ; 1174      unsigned char Errorvalue=0;
4146  1065 0f06          	clr	(OFST-7,sp)
4147                     ; 1181 	 if(longdid == 1)
4149  1067 4a            	dec	a
4150  1068 2704ac311131  	jrne	L1721
4151                     ; 1183 	                cnt = 1;
4153  106e 4c            	inc	a
4154  106f 6b0a          	ld	(OFST-3,sp),a
4155                     ; 1184 			  ClearNPDUbuff(); //add diag
4157  1071 8da320a3      	callf	f_ClearNPDUbuff
4159                     ; 1185                        DIDread = R_PDU[0].Data[cnt];
4161  1075 7b0a          	ld	a,(OFST-3,sp)
4162  1077 5f            	clrw	x
4163  1078 97            	ld	xl,a
4164  1079 d600a8        	ld	a,(_R_PDU+3,x)
4165  107c 5f            	clrw	x
4166  107d 97            	ld	xl,a
4167  107e 1f07          	ldw	(OFST-6,sp),x
4168                     ; 1186 			  DIDread = (DIDread<<8) +R_PDU[0].Data[cnt+1];
4170  1080 7b0a          	ld	a,(OFST-3,sp)
4171  1082 5f            	clrw	x
4172  1083 97            	ld	xl,a
4173  1084 d600a9        	ld	a,(_R_PDU+4,x)
4174  1087 6b02          	ld	(OFST-11,sp),a
4175  1089 1e07          	ldw	x,(OFST-6,sp)
4176  108b 4f            	clr	a
4177  108c 1b02          	add	a,(OFST-11,sp)
4178  108e 2401          	jrnc	L433
4179  1090 5c            	incw	x
4180  1091               L433:
4181  1091 02            	rlwa	x,a
4182  1092 1f07          	ldw	(OFST-6,sp),x
4183                     ; 1187 			  didcnt = ReadDidvalue(DIDread,Didread);
4185  1094 4b01          	push	#1
4186  1096 1e08          	ldw	x,(OFST-5,sp)
4187  1098 8d831383      	callf	f_ReadDidvalue
4189  109c 5b01          	addw	sp,#1
4190  109e 6b0b          	ld	(OFST-2,sp),a
4191                     ; 1188 			  if(didcnt > 20) 
4193  10a0 a115          	cp	a,#21
4194                     ; 1190                               Errorvalue = didcnt -0x10;
4195                     ; 1191 				  return Errorvalue;
4198  10a2 2504acbd12bd  	jruge	LC019
4199                     ; 1193 			  if(didcnt == 0xff) {Errorvalue = NCR13 ;return;}//???
4201  10a8 a1ff          	cp	a,#255
4202  10aa 2606          	jrne	L5721
4205  10ac               LC018:
4208  10ac 7b06          	ld	a,(OFST-7,sp)
4209  10ae 97            	ld	xl,a
4211  10af               L673:
4214  10af 5b0e          	addw	sp,#14
4215  10b1 87            	retf	
4216  10b2               L5721:
4217                     ; 1194 			  if(didcnt > 4) //长度大于1帧必须多帧发送
4219  10b2 a105          	cp	a,#5
4220  10b4 2557          	jrult	L7721
4221                     ; 1197                               N_PDU[0].PCI = 0x10;
4223  10b6 3510016f      	mov	_N_PDU+2,#16
4224                     ; 1198 				  N_PDU[0].Data[0] = didcnt+3;
4226  10ba ab03          	add	a,#3
4227  10bc c70170        	ld	_N_PDU+3,a
4228                     ; 1199 				  N_PDU[0].Data[1] = SID22+0x40;
4230  10bf 35620171      	mov	_N_PDU+4,#98
4231                     ; 1200 				  N_PDU[0].Data[2] = R_PDU[0].Data[1];
4233  10c3 5500a90172    	mov	_N_PDU+5,_R_PDU+4
4234                     ; 1201 				  N_PDU[0].Data[3] = R_PDU[0].Data[2];
4236  10c8 5500aa0173    	mov	_N_PDU+6,_R_PDU+5
4237                     ; 1202                               onecnt = 4;
4239  10cd a604          	ld	a,#4
4240  10cf 6b0d          	ld	(OFST+0,sp),a
4241                     ; 1203 				  onecnt1 = 0;
4243  10d1 0f0c          	clr	(OFST-1,sp)
4244                     ; 1204 				  for(cnt = 0;cnt < didcnt;cnt++)
4246  10d3 0f0a          	clr	(OFST-3,sp)
4248  10d5 202c          	jra	L5031
4249  10d7               L1031:
4250                     ; 1206                                      N_PDU[onecnt1].Data[onecnt++] = Didvalue[cnt];
4252  10d7 7b0d          	ld	a,(OFST+0,sp)
4253  10d9 0c0d          	inc	(OFST+0,sp)
4254  10db 6b02          	ld	(OFST-11,sp),a
4255  10dd 7b0c          	ld	a,(OFST-1,sp)
4256  10df 97            	ld	xl,a
4257  10e0 a60a          	ld	a,#10
4258  10e2 42            	mul	x,a
4259  10e3 01            	rrwa	x,a
4260  10e4 1b02          	add	a,(OFST-11,sp)
4261  10e6 2401          	jrnc	L043
4262  10e8 5c            	incw	x
4263  10e9               L043:
4264  10e9 02            	rlwa	x,a
4265  10ea 7b0a          	ld	a,(OFST-3,sp)
4266  10ec 905f          	clrw	y
4267  10ee 9097          	ld	yl,a
4268  10f0 90d6003c      	ld	a,(_Didvalue,y)
4269  10f4 d70170        	ld	(_N_PDU+3,x),a
4270                     ; 1207 					 if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
4272  10f7 7b0d          	ld	a,(OFST+0,sp)
4273  10f9 a107          	cp	a,#7
4274  10fb 2504          	jrult	L1131
4277  10fd 0f0d          	clr	(OFST+0,sp)
4280  10ff 0c0c          	inc	(OFST-1,sp)
4281  1101               L1131:
4282                     ; 1204 				  for(cnt = 0;cnt < didcnt;cnt++)
4284  1101 0c0a          	inc	(OFST-3,sp)
4285  1103               L5031:
4288  1103 7b0a          	ld	a,(OFST-3,sp)
4289  1105 110b          	cp	a,(OFST-2,sp)
4290  1107 25ce          	jrult	L1031
4291                     ; 1210 				  N_UDSDdata.Request = 2;  //设置多帧发送标志
4293  1109 ac5f135f      	jpf	LC020
4294  110d               L7721:
4295                     ; 1214                               UDSsendone(0x03+didcnt,SID22+0x40,R_PDU[0].Data[1],R_PDU[0].Data[2],Didvalue[0],Didvalue[1],Didvalue[2],Didvalue[3]);
4297  110d 3b003f        	push	_Didvalue+3
4298  1110 3b003e        	push	_Didvalue+2
4299  1113 3b003d        	push	_Didvalue+1
4300  1116 3b003c        	push	_Didvalue
4301  1119 3b00aa        	push	_R_PDU+5
4302  111c 3b00a9        	push	_R_PDU+4
4303  111f ae0062        	ldw	x,#98
4304  1122 7b11          	ld	a,(OFST+4,sp)
4305  1124 ab03          	add	a,#3
4306  1126 95            	ld	xh,a
4307  1127 8d110c11      	callf	f_UDSsendone
4309  112b 5b06          	addw	sp,#6
4310  112d ac691369      	jra	L5131
4311  1131               L1721:
4312                     ; 1217      else if(longdid <= 3)
4314  1131 7b0e          	ld	a,(OFST+1,sp)
4315  1133 a104          	cp	a,#4
4316  1135 2504ac3a123a  	jruge	L7131
4317                     ; 1219          DIDreadtoal = 0;
4319  113b 0f04          	clr	(OFST-9,sp)
4320                     ; 1220 		 onecnt = 2;
4322  113d a602          	ld	a,#2
4323  113f 6b0d          	ld	(OFST+0,sp),a
4324                     ; 1221 		 onecnt1 = 0;
4326  1141 0f0c          	clr	(OFST-1,sp)
4327                     ; 1222          for(cnt = 1;cnt <= longdid;cnt++) //防缓存
4329  1143 a601          	ld	a,#1
4330  1145 6b0a          	ld	(OFST-3,sp),a
4332  1147 ac2e122e      	jra	L5231
4333  114b               L1231:
4334                     ; 1224                        if(cnt == 1) ClearNPDUbuff(); // add diag
4336  114b a101          	cp	a,#1
4337  114d 2606          	jrne	L1331
4340  114f 8da320a3      	callf	f_ClearNPDUbuff
4342  1153 7b0a          	ld	a,(OFST-3,sp)
4343  1155               L1331:
4344                     ; 1225                        DIDread = R_PDU[0].Data[(cnt<<1)-1];
4346  1155 5f            	clrw	x
4347  1156 97            	ld	xl,a
4348  1157 58            	sllw	x
4349  1158 5a            	decw	x
4350  1159 d600a8        	ld	a,(_R_PDU+3,x)
4351  115c 5f            	clrw	x
4352  115d 97            	ld	xl,a
4353  115e 1f07          	ldw	(OFST-6,sp),x
4354                     ; 1226 			  DIDread = (DIDread<<8) +R_PDU[0].Data[cnt<<1];
4356  1160 7b0a          	ld	a,(OFST-3,sp)
4357  1162 5f            	clrw	x
4358  1163 97            	ld	xl,a
4359  1164 58            	sllw	x
4360  1165 d600a8        	ld	a,(_R_PDU+3,x)
4361  1168 6b02          	ld	(OFST-11,sp),a
4362  116a 1e07          	ldw	x,(OFST-6,sp)
4363  116c 4f            	clr	a
4364  116d 1b02          	add	a,(OFST-11,sp)
4365  116f 2401          	jrnc	L643
4366  1171 5c            	incw	x
4367  1172               L643:
4368  1172 02            	rlwa	x,a
4369  1173 1f07          	ldw	(OFST-6,sp),x
4370                     ; 1227 			  didcnt = ReadDidvalue(DIDread,Didread);
4372  1175 4b01          	push	#1
4373  1177 1e08          	ldw	x,(OFST-5,sp)
4374  1179 8d831383      	callf	f_ReadDidvalue
4376  117d 5b01          	addw	sp,#1
4377  117f 6b0b          	ld	(OFST-2,sp),a
4378                     ; 1228 			  if(didcnt > 20) 
4380  1181 a115          	cp	a,#21
4381                     ; 1230                                Errorvalue = didcnt-0x10;
4382                     ; 1231 				  return Errorvalue;
4385  1183 2504acbd12bd  	jruge	LC019
4386                     ; 1233 			  DIDreadtoal = DIDreadtoal + didcnt+2;
4388  1189 7b04          	ld	a,(OFST-9,sp)
4389  118b 1b0b          	add	a,(OFST-2,sp)
4390  118d ab02          	add	a,#2
4391  118f 6b04          	ld	(OFST-9,sp),a
4392                     ; 1234 			  if(didcnt == 0xff) {Errorvalue = NCR13 ;return;}//???
4394  1191 7b0b          	ld	a,(OFST-2,sp)
4395  1193 4c            	inc	a
4399  1194 2604acac10ac  	jreq	LC018
4400                     ; 1237 			  N_PDU[onecnt1].Data[onecnt++] = R_PDU[0].Data[(cnt<<1)-1];
4402  119a 7b0d          	ld	a,(OFST+0,sp)
4403  119c 0c0d          	inc	(OFST+0,sp)
4404  119e 6b02          	ld	(OFST-11,sp),a
4405  11a0 7b0c          	ld	a,(OFST-1,sp)
4406  11a2 97            	ld	xl,a
4407  11a3 a60a          	ld	a,#10
4408  11a5 42            	mul	x,a
4409  11a6 01            	rrwa	x,a
4410  11a7 1b02          	add	a,(OFST-11,sp)
4411  11a9 2401          	jrnc	L253
4412  11ab 5c            	incw	x
4413  11ac               L253:
4414  11ac 02            	rlwa	x,a
4415  11ad 7b0a          	ld	a,(OFST-3,sp)
4416  11af 905f          	clrw	y
4417  11b1 9097          	ld	yl,a
4418  11b3 9058          	sllw	y
4419  11b5 905a          	decw	y
4420  11b7 90d600a8      	ld	a,(_R_PDU+3,y)
4421  11bb d70170        	ld	(_N_PDU+3,x),a
4422                     ; 1238 			  if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
4424  11be 7b0d          	ld	a,(OFST+0,sp)
4425  11c0 a107          	cp	a,#7
4426  11c2 2506          	jrult	L7331
4429  11c4 0f0d          	clr	(OFST+0,sp)
4432  11c6 0c0c          	inc	(OFST-1,sp)
4433  11c8 7b0d          	ld	a,(OFST+0,sp)
4434  11ca               L7331:
4435                     ; 1239 			  N_PDU[onecnt1].Data[onecnt++] = R_PDU[0].Data[cnt<<1];
4437  11ca 0c0d          	inc	(OFST+0,sp)
4438  11cc 6b02          	ld	(OFST-11,sp),a
4439  11ce 7b0c          	ld	a,(OFST-1,sp)
4440  11d0 97            	ld	xl,a
4441  11d1 a60a          	ld	a,#10
4442  11d3 42            	mul	x,a
4443  11d4 01            	rrwa	x,a
4444  11d5 1b02          	add	a,(OFST-11,sp)
4445  11d7 2401          	jrnc	L453
4446  11d9 5c            	incw	x
4447  11da               L453:
4448  11da 02            	rlwa	x,a
4449  11db 7b0a          	ld	a,(OFST-3,sp)
4450  11dd 905f          	clrw	y
4451  11df 9097          	ld	yl,a
4452  11e1 9058          	sllw	y
4453  11e3 90d600a8      	ld	a,(_R_PDU+3,y)
4454  11e7 d70170        	ld	(_N_PDU+3,x),a
4455                     ; 1240 			  if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
4457  11ea 7b0d          	ld	a,(OFST+0,sp)
4458  11ec a107          	cp	a,#7
4459  11ee 2504          	jrult	L1431
4462  11f0 0f0d          	clr	(OFST+0,sp)
4465  11f2 0c0c          	inc	(OFST-1,sp)
4466  11f4               L1431:
4467                     ; 1241 			  for(cnt1 = 0;cnt1 < didcnt ;cnt1++)
4469  11f4 0f09          	clr	(OFST-4,sp)
4471  11f6 202c          	jra	L7431
4472  11f8               L3431:
4473                     ; 1244 					N_PDU[onecnt1].Data[onecnt++] = Didvalue[cnt1];
4475  11f8 7b0d          	ld	a,(OFST+0,sp)
4476  11fa 0c0d          	inc	(OFST+0,sp)
4477  11fc 6b02          	ld	(OFST-11,sp),a
4478  11fe 7b0c          	ld	a,(OFST-1,sp)
4479  1200 97            	ld	xl,a
4480  1201 a60a          	ld	a,#10
4481  1203 42            	mul	x,a
4482  1204 01            	rrwa	x,a
4483  1205 1b02          	add	a,(OFST-11,sp)
4484  1207 2401          	jrnc	L653
4485  1209 5c            	incw	x
4486  120a               L653:
4487  120a 02            	rlwa	x,a
4488  120b 7b09          	ld	a,(OFST-4,sp)
4489  120d 905f          	clrw	y
4490  120f 9097          	ld	yl,a
4491  1211 90d6003c      	ld	a,(_Didvalue,y)
4492  1215 d70170        	ld	(_N_PDU+3,x),a
4493                     ; 1245 					if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
4495  1218 7b0d          	ld	a,(OFST+0,sp)
4496  121a a107          	cp	a,#7
4497  121c 2504          	jrult	L3531
4500  121e 0f0d          	clr	(OFST+0,sp)
4503  1220 0c0c          	inc	(OFST-1,sp)
4504  1222               L3531:
4505                     ; 1241 			  for(cnt1 = 0;cnt1 < didcnt ;cnt1++)
4507  1222 0c09          	inc	(OFST-4,sp)
4508  1224               L7431:
4511  1224 7b09          	ld	a,(OFST-4,sp)
4512  1226 110b          	cp	a,(OFST-2,sp)
4513  1228 25ce          	jrult	L3431
4514                     ; 1222          for(cnt = 1;cnt <= longdid;cnt++) //防缓存
4516  122a 0c0a          	inc	(OFST-3,sp)
4517  122c 7b0a          	ld	a,(OFST-3,sp)
4518  122e               L5231:
4521  122e 110e          	cp	a,(OFST+1,sp)
4522  1230 2204ac4b114b  	jrule	L1231
4523                     ; 1249 		 N_PDU[0].PCI = 0x10;
4524                     ; 1250 		 N_PDU[0].Data[0]= DIDreadtoal+1;
4525                     ; 1251 		 N_PDU[0].Data[1]=SID22 +0x40;
4526                     ; 1261         N_UDSDdata.Request = 2;  //设置多帧发送标志
4528  1236 ac511351      	jpf	LC021
4529  123a               L7131:
4530                     ; 1264 	 else if(longdid < 12)
4532  123a a10c          	cp	a,#12
4533  123c 2504ac651365  	jruge	L7531
4534                     ; 1266 		DIDreadtoal = 0;
4536  1242 0f04          	clr	(OFST-9,sp)
4537                     ; 1268 		onecnt2=2;
4539  1244 a602          	ld	a,#2
4540  1246 6b05          	ld	(OFST-8,sp),a
4541                     ; 1269 		onecnt3=0;
4543  1248 0f03          	clr	(OFST-10,sp)
4544                     ; 1270 	    onecnt = 2;
4546  124a 6b0d          	ld	(OFST+0,sp),a
4547                     ; 1271 		onecnt1 = 0;
4549  124c 0f0c          	clr	(OFST-1,sp)
4550                     ; 1272 		for(cnt = 0 ;cnt <= longdid ; cnt++) //放临时缓存
4552  124e 0f0a          	clr	(OFST-3,sp)
4554  1250 ac471347      	jra	L5631
4555  1254               L1631:
4556                     ; 1274        		  DIDread = R_PDU[onecnt3].Data[onecnt2++];
4558  1254 7b05          	ld	a,(OFST-8,sp)
4559  1256 0c05          	inc	(OFST-8,sp)
4560  1258 6b02          	ld	(OFST-11,sp),a
4561  125a 7b03          	ld	a,(OFST-10,sp)
4562  125c 97            	ld	xl,a
4563  125d a60a          	ld	a,#10
4564  125f 42            	mul	x,a
4565  1260 01            	rrwa	x,a
4566  1261 1b02          	add	a,(OFST-11,sp)
4567  1263 2401          	jrnc	L063
4568  1265 5c            	incw	x
4569  1266               L063:
4570  1266 02            	rlwa	x,a
4571  1267 d600a8        	ld	a,(_R_PDU+3,x)
4572  126a 5f            	clrw	x
4573  126b 97            	ld	xl,a
4574  126c 1f07          	ldw	(OFST-6,sp),x
4575                     ; 1275 			  if(onecnt2 > 6) {onecnt2 = 0;onecnt3++;}
4577  126e 7b05          	ld	a,(OFST-8,sp)
4578  1270 a107          	cp	a,#7
4579  1272 2506          	jrult	L1731
4582  1274 0f05          	clr	(OFST-8,sp)
4585  1276 0c03          	inc	(OFST-10,sp)
4586  1278 7b05          	ld	a,(OFST-8,sp)
4587  127a               L1731:
4588                     ; 1276 			  DIDread = (DIDread<<8) + R_PDU[onecnt3].Data[onecnt2++];
4590  127a 0c05          	inc	(OFST-8,sp)
4591  127c 6b02          	ld	(OFST-11,sp),a
4592  127e 7b03          	ld	a,(OFST-10,sp)
4593  1280 97            	ld	xl,a
4594  1281 a60a          	ld	a,#10
4595  1283 42            	mul	x,a
4596  1284 01            	rrwa	x,a
4597  1285 1b02          	add	a,(OFST-11,sp)
4598  1287 2401          	jrnc	L263
4599  1289 5c            	incw	x
4600  128a               L263:
4601  128a 02            	rlwa	x,a
4602  128b d600a8        	ld	a,(_R_PDU+3,x)
4603  128e 6b01          	ld	(OFST-12,sp),a
4604  1290 1e07          	ldw	x,(OFST-6,sp)
4605  1292 4f            	clr	a
4606  1293 1b01          	add	a,(OFST-12,sp)
4607  1295 2401          	jrnc	L463
4608  1297 5c            	incw	x
4609  1298               L463:
4610  1298 02            	rlwa	x,a
4611  1299 1f07          	ldw	(OFST-6,sp),x
4612                     ; 1277 			  if(onecnt2 > 6) {onecnt2 = 0;onecnt3++;}
4614  129b 7b05          	ld	a,(OFST-8,sp)
4615  129d a107          	cp	a,#7
4616  129f 2504          	jrult	L3731
4619  12a1 0f05          	clr	(OFST-8,sp)
4622  12a3 0c03          	inc	(OFST-10,sp)
4623  12a5               L3731:
4624                     ; 1279 			  didcnt = 0;
4626                     ; 1280 			  didcnt = ReadDidvalue(DIDread,Didread);
4628  12a5 4b01          	push	#1
4629  12a7 1e08          	ldw	x,(OFST-5,sp)
4630  12a9 8d831383      	callf	f_ReadDidvalue
4632  12ad 5b01          	addw	sp,#1
4633  12af 6b0b          	ld	(OFST-2,sp),a
4634                     ; 1282 			  if(didcnt == 0xff) {Errorvalue = NCR13 ;return;}//???
4636  12b1 a1ff          	cp	a,#255
4640  12b3 2604acac10ac  	jreq	LC018
4641                     ; 1283 			  if(didcnt > 20) 
4643  12b9 a115          	cp	a,#21
4644  12bb 2506          	jrult	L7731
4645                     ; 1285                               Errorvalue = didcnt-0x10;
4647  12bd               LC019:
4650  12bd a010          	sub	a,#16
4651                     ; 1286 				  return Errorvalue;
4654  12bf acaf10af      	jra	L673
4655  12c3               L7731:
4656                     ; 1291               DIDreadtoal = DIDreadtoal+ didcnt+2;
4658  12c3 7b04          	ld	a,(OFST-9,sp)
4659  12c5 1b0b          	add	a,(OFST-2,sp)
4660  12c7 ab02          	add	a,#2
4661  12c9 6b04          	ld	(OFST-9,sp),a
4662                     ; 1293 			  N_PDU[onecnt1].Data[onecnt++] = (uu8)(DIDread >> 8);
4664  12cb 7b0d          	ld	a,(OFST+0,sp)
4665  12cd 0c0d          	inc	(OFST+0,sp)
4666  12cf 6b02          	ld	(OFST-11,sp),a
4667  12d1 7b0c          	ld	a,(OFST-1,sp)
4668  12d3 97            	ld	xl,a
4669  12d4 a60a          	ld	a,#10
4670  12d6 42            	mul	x,a
4671  12d7 01            	rrwa	x,a
4672  12d8 1b02          	add	a,(OFST-11,sp)
4673  12da 2401          	jrnc	L073
4674  12dc 5c            	incw	x
4675  12dd               L073:
4676  12dd 02            	rlwa	x,a
4677  12de 7b07          	ld	a,(OFST-6,sp)
4678  12e0 d70170        	ld	(_N_PDU+3,x),a
4679                     ; 1294 			  if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
4681  12e3 7b0d          	ld	a,(OFST+0,sp)
4682  12e5 a107          	cp	a,#7
4683  12e7 2506          	jrult	L1041
4686  12e9 0f0d          	clr	(OFST+0,sp)
4689  12eb 0c0c          	inc	(OFST-1,sp)
4690  12ed 7b0d          	ld	a,(OFST+0,sp)
4691  12ef               L1041:
4692                     ; 1295 			  N_PDU[onecnt1].Data[onecnt++] = (uu8)DIDread;
4694  12ef 0c0d          	inc	(OFST+0,sp)
4695  12f1 6b02          	ld	(OFST-11,sp),a
4696  12f3 7b0c          	ld	a,(OFST-1,sp)
4697  12f5 97            	ld	xl,a
4698  12f6 a60a          	ld	a,#10
4699  12f8 42            	mul	x,a
4700  12f9 01            	rrwa	x,a
4701  12fa 1b02          	add	a,(OFST-11,sp)
4702  12fc 2401          	jrnc	L273
4703  12fe 5c            	incw	x
4704  12ff               L273:
4705  12ff 02            	rlwa	x,a
4706  1300 7b08          	ld	a,(OFST-5,sp)
4707  1302 d70170        	ld	(_N_PDU+3,x),a
4708                     ; 1296 			  if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
4710  1305 7b0d          	ld	a,(OFST+0,sp)
4711  1307 a107          	cp	a,#7
4712  1309 2504          	jrult	L3041
4715  130b 0f0d          	clr	(OFST+0,sp)
4718  130d 0c0c          	inc	(OFST-1,sp)
4719  130f               L3041:
4720                     ; 1297 			  for(cnt1 = 0;cnt1 < didcnt ;cnt1++)
4722  130f 0f09          	clr	(OFST-4,sp)
4724  1311 202c          	jra	L1141
4725  1313               L5041:
4726                     ; 1300 					N_PDU[onecnt1].Data[onecnt++] = Didvalue[cnt1];
4728  1313 7b0d          	ld	a,(OFST+0,sp)
4729  1315 0c0d          	inc	(OFST+0,sp)
4730  1317 6b02          	ld	(OFST-11,sp),a
4731  1319 7b0c          	ld	a,(OFST-1,sp)
4732  131b 97            	ld	xl,a
4733  131c a60a          	ld	a,#10
4734  131e 42            	mul	x,a
4735  131f 01            	rrwa	x,a
4736  1320 1b02          	add	a,(OFST-11,sp)
4737  1322 2401          	jrnc	L473
4738  1324 5c            	incw	x
4739  1325               L473:
4740  1325 02            	rlwa	x,a
4741  1326 7b09          	ld	a,(OFST-4,sp)
4742  1328 905f          	clrw	y
4743  132a 9097          	ld	yl,a
4744  132c 90d6003c      	ld	a,(_Didvalue,y)
4745  1330 d70170        	ld	(_N_PDU+3,x),a
4746                     ; 1301 					if(onecnt > 6){onecnt = 0;onecnt1++;} //第二帧
4748  1333 7b0d          	ld	a,(OFST+0,sp)
4749  1335 a107          	cp	a,#7
4750  1337 2504          	jrult	L5141
4753  1339 0f0d          	clr	(OFST+0,sp)
4756  133b 0c0c          	inc	(OFST-1,sp)
4757  133d               L5141:
4758                     ; 1297 			  for(cnt1 = 0;cnt1 < didcnt ;cnt1++)
4760  133d 0c09          	inc	(OFST-4,sp)
4761  133f               L1141:
4764  133f 7b09          	ld	a,(OFST-4,sp)
4765  1341 110b          	cp	a,(OFST-2,sp)
4766  1343 25ce          	jrult	L5041
4767                     ; 1272 		for(cnt = 0 ;cnt <= longdid ; cnt++) //放临时缓存
4769  1345 0c0a          	inc	(OFST-3,sp)
4770  1347               L5631:
4773  1347 7b0a          	ld	a,(OFST-3,sp)
4774  1349 110e          	cp	a,(OFST+1,sp)
4775  134b 2204ac541254  	jrule	L1631
4776                     ; 1306 		 N_PDU[0].PCI = 0x10;
4778                     ; 1307 		 N_PDU[0].Data[0]= DIDreadtoal+1;
4780                     ; 1308 		 N_PDU[0].Data[1]=SID22 +0x40;
4782  1351               LC021:
4784  1351 3510016f      	mov	_N_PDU+2,#16
4786  1355 7b04          	ld	a,(OFST-9,sp)
4787  1357 4c            	inc	a
4788  1358 c70170        	ld	_N_PDU+3,a
4790  135b 35620171      	mov	_N_PDU+4,#98
4791                     ; 1311         N_UDSDdata.Request = 2;  //设置多帧发送标志
4793  135f               LC020:
4796  135f 35020283      	mov	_N_UDSDdata,#2
4798  1363 2004          	jra	L5131
4799  1365               L7531:
4800                     ; 1318 			Errorvalue = NCR31;
4802  1365 a631          	ld	a,#49
4803  1367 6b06          	ld	(OFST-7,sp),a
4804  1369               L5131:
4805                     ; 1323      return Errorvalue;
4807  1369 7b06          	ld	a,(OFST-7,sp)
4809  136b acaf10af      	jra	L673
4841                     ; 1326 void ClearDidvalue(void)
4841                     ; 1327 {
4842                     	switch	.text
4843  136f               f_ClearDidvalue:
4845  136f 88            	push	a
4846       00000001      OFST:	set	1
4849                     ; 1329 	for(didcnt = 0;didcnt < 20;didcnt++)
4851  1370 4f            	clr	a
4852  1371 6b01          	ld	(OFST+0,sp),a
4853  1373               L5341:
4854                     ; 1331 		Didvalue[didcnt] = 0;
4856  1373 5f            	clrw	x
4857  1374 97            	ld	xl,a
4858  1375 724f003c      	clr	(_Didvalue,x)
4859                     ; 1329 	for(didcnt = 0;didcnt < 20;didcnt++)
4861  1379 0c01          	inc	(OFST+0,sp)
4864  137b 7b01          	ld	a,(OFST+0,sp)
4865  137d a114          	cp	a,#20
4866  137f 25f2          	jrult	L5341
4867                     ; 1334 }
4870  1381 84            	pop	a
4871  1382 87            	retf	
4935                     ; 1336 unsigned char ReadDidvalue(unsigned int DID,unsigned char DIDrwstate)
4935                     ; 1337 {
4936                     	switch	.text
4937  1383               f_ReadDidvalue:
4939  1383 89            	pushw	x
4940  1384 88            	push	a
4941       00000001      OFST:	set	1
4944                     ; 1341 	 ClearDidvalue();
4946  1385 8d6f136f      	callf	f_ClearDidvalue
4948                     ; 1343 	 switch(DID)
4950  1389 1e02          	ldw	x,(OFST+1,sp)
4952                     ; 1723 		}break;
4953  138b 1df120        	subw	x,#-3808
4954  138e 2778          	jreq	L3441
4955  1390 1d0061        	subw	x,#97
4956  1393 2604ac251425  	jreq	L5441
4957  1399 1d0006        	subw	x,#6
4958  139c 2604ac421442  	jreq	L7441
4959  13a2 1d0003        	subw	x,#3
4960  13a5 2604ac771477  	jreq	L1541
4961  13ab 5a            	decw	x
4962  13ac 2604aca014a0  	jreq	L3541
4963  13b2 5a            	decw	x
4964  13b3 2604acd815d8  	jreq	L7541
4965  13b9 1d0004        	subw	x,#4
4966  13bc 2604acfa14fa  	jreq	L5541
4967  13c2 1d0003        	subw	x,#3
4968  13c5 2604ac4c164c  	jreq	L1641
4969  13cb 1d0002        	subw	x,#2
4970  13ce 2604ac6d166d  	jreq	L3641
4971  13d4 1d0008        	subw	x,#8
4972  13d7 2604ac8a168a  	jreq	L5641
4973  13dd 1d0054        	subw	x,#84
4974  13e0 2604ace416e4  	jreq	L7641
4975  13e6 5a            	decw	x
4976  13e7 2604acfb16fb  	jreq	L1741
4977  13ed 5a            	decw	x
4978  13ee 2604ac371737  	jreq	L3741
4979  13f4 5a            	decw	x
4980  13f5 2604ac881788  	jreq	L5741
4981  13fb 1d0b0d        	subw	x,#2829
4982  13fe 2604acc417c4  	jreq	L7741
4983                     ; 1722                       Didonelong = NCR31+0x10;   //error1
4984                     ; 1723 		}break;
4986  1404 accc17cc      	jpf	L5761
4987  1408               L3441:
4988                     ; 1347 			if(DIDrwstate == Didread)
4990  1408 7b07          	ld	a,(OFST+6,sp)
4991  140a 4a            	dec	a
4992  140b 26f7          	jrne	L5761
4993                     ; 1349 				Didonelong = 4;
4995  140d a604          	ld	a,#4
4996  140f 6b01          	ld	(OFST+0,sp),a
4997                     ; 1350 				Didvalue[3] = (unsigned char)(DIDvalueF120);
4999  1411 3530003f      	mov	_Didvalue+3,#48
5000                     ; 1351                             Didvalue[2] = (unsigned char)(DIDvalueF120 >> 8);
5002  1415 352e003e      	mov	_Didvalue+2,#46
5003                     ; 1352 				Didvalue[1] = (unsigned char)(DIDvalueF120 >> 16);
5005  1419 3531003d      	mov	_Didvalue+1,#49
5006                     ; 1353 				Didvalue[0] = (unsigned char)(DIDvalueF120 >> 24);
5008  141d 3556003c      	mov	_Didvalue,#86
5010  1421 acd017d0      	jra	L5251
5011                     ; 1357 				Didonelong = NCR31+0x10;
5012  1425               L5441:
5013                     ; 1364 			if(DIDrwstate == Didread)
5015  1425 7b07          	ld	a,(OFST+6,sp)
5016  1427 4a            	dec	a
5017  1428 26da          	jrne	L5761
5018                     ; 1366 				Didonelong = 4;
5020  142a a604          	ld	a,#4
5021  142c 6b01          	ld	(OFST+0,sp),a
5022                     ; 1367 				Didvalue[3] = (unsigned char)(DIDvalueF181);
5024  142e 350e003f      	mov	_Didvalue+3,#14
5025                     ; 1368                 Didvalue[2] = (unsigned char)(DIDvalueF181 >> 8);
5027  1432 350c003e      	mov	_Didvalue+2,#12
5028                     ; 1369 				Didvalue[1] = (unsigned char)(DIDvalueF181 >> 16);
5030  1436 35db003d      	mov	_Didvalue+1,#219
5031                     ; 1370 				Didvalue[0] = (unsigned char)(DIDvalueF181 >> 24);
5033  143a 3507003c      	mov	_Didvalue,#7
5035  143e acd017d0      	jra	L5251
5036                     ; 1374 				Didonelong = NCR31+0x10;
5037  1442               L7441:
5038                     ; 1379 			if(DIDrwstate == Didread)
5040  1442 7b07          	ld	a,(OFST+6,sp)
5041  1444 4a            	dec	a
5042  1445 26bd          	jrne	L5761
5043                     ; 1381 				Didonelong = 10;
5045  1447 a60a          	ld	a,#10
5046  1449 6b01          	ld	(OFST+0,sp),a
5047                     ; 1382 				Didvalue[3] = (unsigned char)(DIDvalueF1871);
5049  144b 3530003f      	mov	_Didvalue+3,#48
5050                     ; 1383                             Didvalue[2] = (unsigned char)(DIDvalueF1871 >> 8);
5052  144f 3530003e      	mov	_Didvalue+2,#48
5053                     ; 1384 				Didvalue[1] = (unsigned char)(DIDvalueF1871 >> 16);
5055  1453 3536003d      	mov	_Didvalue+1,#54
5056                     ; 1385 				Didvalue[0] = (unsigned char)(DIDvalueF1871 >> 24);
5058  1457 3533003c      	mov	_Didvalue,#51
5059                     ; 1386 				Didvalue[7] = (unsigned char)(DIDvalueF1872 );
5061  145b 35560043      	mov	_Didvalue+7,#86
5062                     ; 1387                             Didvalue[6] = (unsigned char)(DIDvalueF1872 >> 8);
5064  145f 35300042      	mov	_Didvalue+6,#48
5065                     ; 1388 				Didvalue[5] = (unsigned char)(DIDvalueF1872 >> 16);
5067  1463 35340041      	mov	_Didvalue+5,#52
5068                     ; 1389 				Didvalue[4] = (unsigned char)(DIDvalueF1872 >> 24);
5070  1467 35300040      	mov	_Didvalue+4,#48
5071                     ; 1390 				Didvalue[9] = (unsigned char)(DIDvalueF1873 );
5073  146b 35310045      	mov	_Didvalue+9,#49
5074                     ; 1391                             Didvalue[8] = (unsigned char)(DIDvalueF1873 >> 8);
5076  146f 35300044      	mov	_Didvalue+8,#48
5078  1473 acd017d0      	jra	L5251
5079                     ; 1396 				Didonelong = NCR31+0x10;
5080  1477               L1541:
5081                     ; 1401 			if(DIDrwstate == Didread)
5083  1477 7b07          	ld	a,(OFST+6,sp)
5084  1479 4a            	dec	a
5085  147a 2688          	jrne	L5761
5086                     ; 1403 				Didonelong = 7;
5088  147c a607          	ld	a,#7
5089  147e 6b01          	ld	(OFST+0,sp),a
5090                     ; 1404 				Didvalue[3] = (unsigned char)(DIDvalueF18a1);
5092  1480 3545003f      	mov	_Didvalue+3,#69
5093                     ; 1405                             Didvalue[2] = (unsigned char)(DIDvalueF18a1 >> 8);
5095  1484 3541003e      	mov	_Didvalue+2,#65
5096                     ; 1406 				Didvalue[1] = (unsigned char)(DIDvalueF18a1 >> 16);
5098  1488 354a003d      	mov	_Didvalue+1,#74
5099                     ; 1407 				Didvalue[0] = (unsigned char)(DIDvalueF18a1 >> 24);
5101  148c 3543003c      	mov	_Didvalue,#67
5102                     ; 1408 				Didvalue[6] = (unsigned char)(DIDvalueF18a2);
5104  1490 35300042      	mov	_Didvalue+6,#48
5105                     ; 1409                             Didvalue[5] = (unsigned char)(DIDvalueF18a2 >> 8);
5107  1494 35320041      	mov	_Didvalue+5,#50
5108                     ; 1410 				Didvalue[4] = (unsigned char)(DIDvalueF18a2 >> 16);
5110  1498 35350040      	mov	_Didvalue+4,#53
5112  149c acd017d0      	jra	L5251
5113                     ; 1415 				Didonelong = NCR31+0x10;
5114  14a0               L3541:
5115                     ; 1420 			if(DIDrwstate == Didread)
5117  14a0 7b07          	ld	a,(OFST+6,sp)
5118  14a2 4a            	dec	a
5119  14a3 261c          	jrne	L7451
5120                     ; 1422 				Didonelong = 4;
5122  14a5 a604          	ld	a,#4
5123  14a7 6b01          	ld	(OFST+0,sp),a
5124                     ; 1423 				Didvalue[0] = F18Bdidsave[0];
5126  14a9 55001e003c    	mov	_Didvalue,_F18Bdidsave
5127                     ; 1424                             Didvalue[1] = F18Bdidsave[1];
5129  14ae 55001f003d    	mov	_Didvalue+1,_F18Bdidsave+1
5130                     ; 1425 				Didvalue[2] = F18Bdidsave[2];
5132  14b3 550020003e    	mov	_Didvalue+2,_F18Bdidsave+2
5133                     ; 1426 				Didvalue[3] = F18Bdidsave[3];
5135  14b8 550021003f    	mov	_Didvalue+3,_F18Bdidsave+3
5137  14bd acd017d0      	jra	L5251
5138  14c1               L7451:
5139                     ; 1433 			      if(R_PDU[0].PCI!= 7) { Didonelong = NCR13+0x10;break;}
5141  14c1 c600a7        	ld	a,_R_PDU+2
5142  14c4 a107          	cp	a,#7
5146  14c6 2704ac631563  	jrne	LC024
5147                     ; 1434 			      F18Bdidsave[0]=R_PDU[0].Data[3];
5149  14cc 5500ab001e    	mov	_F18Bdidsave,_R_PDU+6
5150                     ; 1435 			      F18Bdidsave[1]=R_PDU[0].Data[4];
5152  14d1 5500ac001f    	mov	_F18Bdidsave+1,_R_PDU+7
5153                     ; 1436 			      F18Bdidsave[2]=R_PDU[0].Data[5];
5155  14d6 5500ad0020    	mov	_F18Bdidsave+2,_R_PDU+8
5156                     ; 1437 			      F18Bdidsave[3]=R_PDU[0].Data[6];
5158  14db 5500ae0021    	mov	_F18Bdidsave+3,_R_PDU+9
5159                     ; 1438 			      F18Bsavestate = 4;
5161  14e0 3504001d      	mov	_F18Bsavestate,#4
5162                     ; 1447 				if((F18Bdidsave[0] != R_PDU[0].Data[3])||(F18Bdidsave[3] != R_PDU[0].Data[6]))
5164  14e4 c600ab        	ld	a,_R_PDU+6
5165  14e7 c1001e        	cp	a,_F18Bdidsave
5166  14ea 2704acde16de  	jrne	L5261
5168  14f0 c600ae        	ld	a,_R_PDU+9
5169  14f3 c10021        	cp	a,_F18Bdidsave+3
5170                     ; 1449 					Didonelong = NCR72+0x10;
5171  14f6 acdc16dc      	jpf	LC026
5172  14fa               L5541:
5173                     ; 1456 			if(DIDrwstate == Didread)
5175  14fa 7b07          	ld	a,(OFST+6,sp)
5176  14fc 4a            	dec	a
5177  14fd 265d          	jrne	L1651
5178                     ; 1458 			       Didonelong = 17;
5180  14ff a611          	ld	a,#17
5181  1501 6b01          	ld	(OFST+0,sp),a
5182                     ; 1459 				Didvalue[0] = F190didsavevin[0];
5184  1503 55002b003c    	mov	_Didvalue,_F190didsavevin
5185                     ; 1460 				Didvalue[1] = F190didsavevin[1];
5187  1508 55002c003d    	mov	_Didvalue+1,_F190didsavevin+1
5188                     ; 1461 				Didvalue[2] = F190didsavevin[2];
5190  150d 55002d003e    	mov	_Didvalue+2,_F190didsavevin+2
5191                     ; 1462 				Didvalue[3] = F190didsavevin[3];
5193  1512 55002e003f    	mov	_Didvalue+3,_F190didsavevin+3
5194                     ; 1463 				Didvalue[4] = F190didsavevin[4];
5196  1517 55002f0040    	mov	_Didvalue+4,_F190didsavevin+4
5197                     ; 1464 				Didvalue[5] = F190didsavevin[5];
5199  151c 5500300041    	mov	_Didvalue+5,_F190didsavevin+5
5200                     ; 1465 				Didvalue[6] = F190didsavevin[6];
5202  1521 5500310042    	mov	_Didvalue+6,_F190didsavevin+6
5203                     ; 1466 				Didvalue[7] = F190didsavevin[7];
5205  1526 5500320043    	mov	_Didvalue+7,_F190didsavevin+7
5206                     ; 1467 				Didvalue[8] = F190didsavevin[8];
5208  152b 5500330044    	mov	_Didvalue+8,_F190didsavevin+8
5209                     ; 1468 				Didvalue[9] = F190didsavevin[9];
5211  1530 5500340045    	mov	_Didvalue+9,_F190didsavevin+9
5212                     ; 1469 				Didvalue[10] = F190didsavevin[10];
5214  1535 5500350046    	mov	_Didvalue+10,_F190didsavevin+10
5215                     ; 1470 				Didvalue[11] = F190didsavevin[11];
5217  153a 5500360047    	mov	_Didvalue+11,_F190didsavevin+11
5218                     ; 1471 				Didvalue[12] = F190didsavevin[12];
5220  153f 5500370048    	mov	_Didvalue+12,_F190didsavevin+12
5221                     ; 1472 				Didvalue[13] = F190didsavevin[13];
5223  1544 5500380049    	mov	_Didvalue+13,_F190didsavevin+13
5224                     ; 1473 				Didvalue[14] = F190didsavevin[14];
5226  1549 550039004a    	mov	_Didvalue+14,_F190didsavevin+14
5227                     ; 1474 				Didvalue[15] = F190didsavevin[15];
5229  154e 55003a004b    	mov	_Didvalue+15,_F190didsavevin+15
5230                     ; 1475 				Didvalue[16] = F190didsavevin[16];
5232  1553 55003b004c    	mov	_Didvalue+16,_F190didsavevin+16
5234  1558 acd017d0      	jra	L5251
5235  155c               L1651:
5236                     ; 1481 			     if(R_PDU[0].Data[0]!= 20) { Didonelong = NCR13+0x10;break;}
5238  155c c600a8        	ld	a,_R_PDU+3
5239  155f a114          	cp	a,#20
5240  1561 2706          	jreq	L5651
5243  1563               LC024:
5250  1563 a623          	ld	a,#35
5253  1565 acce17ce      	jpf	LC022
5254  1569               L5651:
5255                     ; 1482 			       F190didsavevin[0] = R_PDU[0].Data[4]; 
5257  1569 5500ac002b    	mov	_F190didsavevin,_R_PDU+7
5258                     ; 1483                             F190didsavevin[1] = R_PDU[0].Data[5];				
5260  156e 5500ad002c    	mov	_F190didsavevin+1,_R_PDU+8
5261                     ; 1484 				F190didsavevin[2] = R_PDU[0].Data[6];
5263  1573 5500ae002d    	mov	_F190didsavevin+2,_R_PDU+9
5264                     ; 1486 				F190didsavevin[3] = R_PDU[1].Data[0];
5266  1578 5500b2002e    	mov	_F190didsavevin+3,_R_PDU+13
5267                     ; 1487 				F190didsavevin[4] = R_PDU[1].Data[1]; 
5269  157d 5500b3002f    	mov	_F190didsavevin+4,_R_PDU+14
5270                     ; 1488                             F190didsavevin[5] = R_PDU[1].Data[2];	
5272  1582 5500b40030    	mov	_F190didsavevin+5,_R_PDU+15
5273                     ; 1490 				F190didsavevin[6] = R_PDU[1].Data[3];				
5275  1587 5500b50031    	mov	_F190didsavevin+6,_R_PDU+16
5276                     ; 1491 				F190didsavevin[7] = R_PDU[1].Data[4];
5278  158c 5500b60032    	mov	_F190didsavevin+7,_R_PDU+17
5279                     ; 1492 				F190didsavevin[8] = R_PDU[1].Data[5]; 
5281  1591 5500b70033    	mov	_F190didsavevin+8,_R_PDU+18
5282                     ; 1494                             F190didsavevin[9] = R_PDU[1].Data[6];				
5284  1596 5500b80034    	mov	_F190didsavevin+9,_R_PDU+19
5285                     ; 1495 				F190didsavevin[10] = R_PDU[2].Data[0];				
5287  159b 5500bc0035    	mov	_F190didsavevin+10,_R_PDU+23
5288                     ; 1496 				F190didsavevin[11] = R_PDU[2].Data[1];
5290  15a0 5500bd0036    	mov	_F190didsavevin+11,_R_PDU+24
5291                     ; 1498 				F190didsavevin[12] = R_PDU[2].Data[2]; 
5293  15a5 5500be0037    	mov	_F190didsavevin+12,_R_PDU+25
5294                     ; 1499                             F190didsavevin[13] = R_PDU[2].Data[3];				
5296  15aa 5500bf0038    	mov	_F190didsavevin+13,_R_PDU+26
5297                     ; 1500 				F190didsavevin[14] = R_PDU[2].Data[4];	
5299  15af 5500c00039    	mov	_F190didsavevin+14,_R_PDU+27
5300                     ; 1502 				F190didsavevin[15] = R_PDU[2].Data[5];
5302  15b4 5500c1003a    	mov	_F190didsavevin+15,_R_PDU+28
5303                     ; 1503 				F190didsavevin[16] = R_PDU[2].Data[6]; 
5305  15b9 5500c2003b    	mov	_F190didsavevin+16,_R_PDU+29
5306                     ; 1505 				F190Savestate = 17;
5308  15be 3511002a      	mov	_F190Savestate,#17
5309                     ; 1508 				if((F190didsavevin[0] != R_PDU[0].Data[4])||(F190didsavevin[16] != R_PDU[2].Data[6]))
5311  15c2 c600ac        	ld	a,_R_PDU+7
5312  15c5 c1002b        	cp	a,_F190didsavevin
5313  15c8 2704acde16de  	jrne	L5261
5315  15ce c600c2        	ld	a,_R_PDU+29
5316  15d1 c1003b        	cp	a,_F190didsavevin+16
5317                     ; 1510 					Didonelong = NCR72+0x10;
5318  15d4 acdc16dc      	jpf	LC026
5319  15d8               L7541:
5320                     ; 1517 			if(DIDrwstate == Didread)
5322  15d8 7b07          	ld	a,(OFST+6,sp)
5323  15da 4a            	dec	a
5324  15db 262b          	jrne	L3751
5325                     ; 1519 				Didonelong = 7;
5327  15dd a607          	ld	a,#7
5328  15df 6b01          	ld	(OFST+0,sp),a
5329                     ; 1520 				Didvalue[0] = F18Cdidsave[0];
5331  15e1 550023003c    	mov	_Didvalue,_F18Cdidsave
5332                     ; 1521               	       Didvalue[1] = F18Cdidsave[1];
5334  15e6 550024003d    	mov	_Didvalue+1,_F18Cdidsave+1
5335                     ; 1522 				Didvalue[2] = F18Cdidsave[2];
5337  15eb 550025003e    	mov	_Didvalue+2,_F18Cdidsave+2
5338                     ; 1523 				Didvalue[3] = F18Cdidsave[3];
5340  15f0 550026003f    	mov	_Didvalue+3,_F18Cdidsave+3
5341                     ; 1524 				Didvalue[4] = F18Cdidsave[4];
5343  15f5 5500270040    	mov	_Didvalue+4,_F18Cdidsave+4
5344                     ; 1525                		 Didvalue[5] = F18Cdidsave[5];
5346  15fa 5500280041    	mov	_Didvalue+5,_F18Cdidsave+5
5347                     ; 1526 				Didvalue[6] = F18Cdidsave[6];
5349  15ff 5500290042    	mov	_Didvalue+6,_F18Cdidsave+6
5351  1604 acd017d0      	jra	L5251
5352  1608               L3751:
5353                     ; 1530 			       if(R_PDU[0].Data[0] != 10) { Didonelong = NCR13+0x10;break;}
5355  1608 c600a8        	ld	a,_R_PDU+3
5356  160b a10a          	cp	a,#10
5360  160d 2704ac631563  	jrne	LC024
5361                     ; 1531 			       F18Cdidsave[0] = R_PDU[0].Data[4]; 
5363  1613 5500ac0023    	mov	_F18Cdidsave,_R_PDU+7
5364                     ; 1532 				F18Cdidsave[1] =R_PDU[0].Data[5]; 
5366  1618 5500ad0024    	mov	_F18Cdidsave+1,_R_PDU+8
5367                     ; 1533 				F18Cdidsave[2] =R_PDU[0].Data[6]; 
5369  161d 5500ae0025    	mov	_F18Cdidsave+2,_R_PDU+9
5370                     ; 1534 				F18Cdidsave[3] =R_PDU[1].Data[0]; 
5372  1622 5500b20026    	mov	_F18Cdidsave+3,_R_PDU+13
5373                     ; 1535 				F18Cdidsave[4] =R_PDU[1].Data[1]; 
5375  1627 5500b30027    	mov	_F18Cdidsave+4,_R_PDU+14
5376                     ; 1536 				F18Cdidsave[5] =R_PDU[1].Data[2]; 
5378  162c 5500b40028    	mov	_F18Cdidsave+5,_R_PDU+15
5379                     ; 1537 				F18Cdidsave[6] =R_PDU[1].Data[3]; 
5381  1631 5500b50029    	mov	_F18Cdidsave+6,_R_PDU+16
5382                     ; 1538 				F18CSavestate = 7;
5384  1636 35070022      	mov	_F18CSavestate,#7
5385                     ; 1539 				if((F18Cdidsave[0] != R_PDU[0].Data[4])||(F18Cdidsave[6] != R_PDU[1].Data[3]))
5387  163a c600ac        	ld	a,_R_PDU+7
5388  163d c10023        	cp	a,_F18Cdidsave
5389  1640 2688          	jrne	L5261
5391  1642 c600b5        	ld	a,_R_PDU+16
5392  1645 c10029        	cp	a,_F18Cdidsave+6
5393                     ; 1541 					Didonelong = NCR72+0x10;
5394  1648 acdc16dc      	jpf	LC026
5395  164c               L1641:
5396                     ; 1548 			if(DIDrwstate == Didread)
5398  164c 7b07          	ld	a,(OFST+6,sp)
5399  164e 4a            	dec	a
5400  164f 2704accc17cc  	jrne	L5761
5401                     ; 1550 				Didonelong = 4;
5403  1655 a604          	ld	a,#4
5404  1657 6b01          	ld	(OFST+0,sp),a
5405                     ; 1551 				Didvalue[3] = (unsigned char)(DIDvalueF193);
5407  1659 3533003f      	mov	_Didvalue+3,#51
5408                     ; 1552                             Didvalue[2] = (unsigned char)(DIDvalueF193 >> 8);
5410  165d 352e003e      	mov	_Didvalue+2,#46
5411                     ; 1553 				Didvalue[1] = (unsigned char)(DIDvalueF193 >> 16);
5413  1661 3530003d      	mov	_Didvalue+1,#48
5414                     ; 1554 				Didvalue[0] = (unsigned char)(DIDvalueF193 >> 24);
5416  1665 3548003c      	mov	_Didvalue,#72
5418  1669 acd017d0      	jra	L5251
5419                     ; 1558 				Didonelong = NCR31+0x10;
5420  166d               L3641:
5421                     ; 1563 			if(DIDrwstate == Didread)
5423  166d 7b07          	ld	a,(OFST+6,sp)
5424  166f 4a            	dec	a
5425  1670 26df          	jrne	L5761
5426                     ; 1565 				Didonelong = 4;
5428  1672 a604          	ld	a,#4
5429  1674 6b01          	ld	(OFST+0,sp),a
5430                     ; 1566 				Didvalue[3] = (unsigned char)(DIDvalueF195);
5432  1676 3535003f      	mov	_Didvalue+3,#53
5433                     ; 1567                             Didvalue[2] = (unsigned char)(DIDvalueF195 >> 8);
5435  167a 352e003e      	mov	_Didvalue+2,#46
5436                     ; 1568 				Didvalue[1] = (unsigned char)(DIDvalueF195 >> 16);
5438  167e 3531003d      	mov	_Didvalue+1,#49
5439                     ; 1569 				Didvalue[0] = (unsigned char)(DIDvalueF195 >> 24);
5441  1682 3553003c      	mov	_Didvalue,#83
5443  1686 acd017d0      	jra	L5251
5444                     ; 1573 				Didonelong = NCR31+0x10;
5445  168a               L5641:
5446                     ; 1578 			if(DIDrwstate == Didread)
5448  168a 7b07          	ld	a,(OFST+6,sp)
5449  168c 4a            	dec	a
5450  168d 261c          	jrne	L5161
5451                     ; 1580 				Didonelong = 4;
5453  168f a604          	ld	a,#4
5454  1691 6b01          	ld	(OFST+0,sp),a
5455                     ; 1581 				Didvalue[0] = F19ddidsave[0];
5457  1693 550019003c    	mov	_Didvalue,_F19ddidsave
5458                     ; 1582                             Didvalue[1] = F19ddidsave[1];
5460  1698 55001a003d    	mov	_Didvalue+1,_F19ddidsave+1
5461                     ; 1583 				Didvalue[2] = F19ddidsave[2];
5463  169d 55001b003e    	mov	_Didvalue+2,_F19ddidsave+2
5464                     ; 1584 				Didvalue[3] = F19ddidsave[3];
5466  16a2 55001c003f    	mov	_Didvalue+3,_F19ddidsave+3
5468  16a7 acd017d0      	jra	L5251
5469  16ab               L5161:
5470                     ; 1588 			       if(R_PDU[0].PCI!= 7) { Didonelong = NCR13+0x10;break;}
5472  16ab c600a7        	ld	a,_R_PDU+2
5473  16ae a107          	cp	a,#7
5477  16b0 2704ac631563  	jrne	LC024
5478                     ; 1589 				F19ddidsave[0]=R_PDU[0].Data[3];
5480  16b6 5500ab0019    	mov	_F19ddidsave,_R_PDU+6
5481                     ; 1590 				F19ddidsave[1]=R_PDU[0].Data[4];
5483  16bb 5500ac001a    	mov	_F19ddidsave+1,_R_PDU+7
5484                     ; 1591 				F19ddidsave[2]=R_PDU[0].Data[5];
5486  16c0 5500ad001b    	mov	_F19ddidsave+2,_R_PDU+8
5487                     ; 1592 				F19ddidsave[3]=R_PDU[0].Data[6];
5489  16c5 5500ae001c    	mov	_F19ddidsave+3,_R_PDU+9
5490                     ; 1593 				F19dsavestate = 4;
5492  16ca 35040018      	mov	_F19dsavestate,#4
5493                     ; 1602 				if((F19ddidsave[0] != R_PDU[0].Data[3])||(F19ddidsave[3] != R_PDU[0].Data[6]))
5495  16ce c600ab        	ld	a,_R_PDU+6
5496  16d1 c10019        	cp	a,_F19ddidsave
5497  16d4 2608          	jrne	L5261
5499  16d6 c600ae        	ld	a,_R_PDU+9
5500  16d9 c1001c        	cp	a,_F19ddidsave+3
5501  16dc               LC026:
5502  16dc 27c9          	jreq	L5251
5503  16de               L5261:
5504                     ; 1604 					Didonelong = NCR72+0x10;
5512  16de a682          	ld	a,#130
5513  16e0 acce17ce      	jpf	LC022
5514  16e4               L7641:
5515                     ; 1610 			if(DIDrwstate == Didread)
5517  16e4 7b07          	ld	a,(OFST+6,sp)
5518  16e6 4a            	dec	a
5519  16e7 2704accc17cc  	jrne	L5761
5520                     ; 1612 				Didonelong = 1;
5522  16ed 4c            	inc	a
5523  16ee 6b01          	ld	(OFST+0,sp),a
5524                     ; 1615 				Didvalue[0] = RKEnumberRead();
5526  16f0 8d000000      	callf	f_RKEnumberRead
5528  16f4 c7003c        	ld	_Didvalue,a
5530  16f7 acd017d0      	jra	L5251
5531                     ; 1620 				Didonelong = NCR31+0x10;
5532  16fb               L1741:
5533                     ; 1625 			if(DIDrwstate == Didread)
5535  16fb 7b07          	ld	a,(OFST+6,sp)
5536  16fd 4a            	dec	a
5537  16fe 2612          	jrne	L3361
5538                     ; 1628 					Didonelong = 2;
5540  1700 a602          	ld	a,#2
5541  1702 6b01          	ld	(OFST+0,sp),a
5542                     ; 1629 					Didvalue[0] = F1f2didsave[0];
5544  1704 550016003c    	mov	_Didvalue,_F1f2didsave
5545                     ; 1630 	                            Didvalue[1] = F1f2didsave[1];
5547  1709 550017003d    	mov	_Didvalue+1,_F1f2didsave+1
5549  170e acd017d0      	jra	L5251
5550  1712               L3361:
5551                     ; 1635 			       if(R_PDU[0].PCI!= 5) { Didonelong = NCR13+0x10;break;}
5553  1712 c600a7        	ld	a,_R_PDU+2
5554  1715 a105          	cp	a,#5
5558  1717 2699          	jrne	LC024
5559                     ; 1636 				F1f2didsave[0] = R_PDU[0].Data[3];
5561  1719 5500ab0016    	mov	_F1f2didsave,_R_PDU+6
5562                     ; 1637 				F1f2didsave[1] = R_PDU[0].Data[4];
5564  171e 5500ac0017    	mov	_F1f2didsave+1,_R_PDU+7
5565                     ; 1638 				F1f2savestate=2;
5567  1723 35020015      	mov	_F1f2savestate,#2
5568                     ; 1643 				if((F1f2didsave[0] != R_PDU[0].Data[3])||(F1f2didsave[1] != R_PDU[0].Data[4]))
5570  1727 c600ab        	ld	a,_R_PDU+6
5571  172a c10016        	cp	a,_F1f2didsave
5572  172d 26af          	jrne	L5261
5574  172f c600ac        	ld	a,_R_PDU+7
5575  1732 c10017        	cp	a,_F1f2didsave+1
5576                     ; 1645 					Didonelong = NCR72+0x10;
5577  1735 20a5          	jpf	LC026
5578  1737               L3741:
5579                     ; 1653 			if(DIDrwstate == Didread)
5581  1737 7b07          	ld	a,(OFST+6,sp)
5582  1739 4a            	dec	a
5583  173a 261d          	jrne	L5461
5584                     ; 1655 			      if(SalfeMode < salfe02) 
5586  173c c60051        	ld	a,_SalfeMode
5587  173f a102          	cp	a,#2
5588  1741 2406          	jruge	L7461
5589                     ; 1657      				       Didonelong = NCR33+0x10;
5591  1743 a643          	ld	a,#67
5593  1745 acce17ce      	jpf	LC022
5594  1749               L7461:
5595                     ; 1661 					Didonelong = 2;
5597  1749 a602          	ld	a,#2
5598  174b 6b01          	ld	(OFST+0,sp),a
5599                     ; 1662 					Didvalue[0] = F1f3didsave[0];
5601  174d 550013003c    	mov	_Didvalue,_F1f3didsave
5602                     ; 1663 	                            Didvalue[1] = F1f3didsave[1];
5604  1752 550014003d    	mov	_Didvalue+1,_F1f3didsave+1
5605  1757 2077          	jra	L5251
5606  1759               L5461:
5607                     ; 1668 				if(R_PDU[0].PCI!= 5) { Didonelong = NCR13+0x10;break;}
5609  1759 c600a7        	ld	a,_R_PDU+2
5610  175c a105          	cp	a,#5
5614  175e 2704ac631563  	jrne	LC024
5615                     ; 1669 				F1f3didsave[0] = R_PDU[0].Data[3];
5617  1764 5500ab0013    	mov	_F1f3didsave,_R_PDU+6
5618                     ; 1670 				F1f3didsave[1] = R_PDU[0].Data[4];
5620  1769 5500ac0014    	mov	_F1f3didsave+1,_R_PDU+7
5621                     ; 1671 				F1f3savestate=2;
5623  176e 35020012      	mov	_F1f3savestate,#2
5624                     ; 1676 				if((F1f3didsave[0] != R_PDU[0].Data[3])||(F1f3didsave[1] != R_PDU[0].Data[4]))
5626  1772 c600ab        	ld	a,_R_PDU+6
5627  1775 c10013        	cp	a,_F1f3didsave
5628  1778 2704acde16de  	jrne	L5261
5630  177e c600ac        	ld	a,_R_PDU+7
5631  1781 c10014        	cp	a,_F1f3didsave+1
5632                     ; 1678 					Didonelong = NCR72+0x10;
5633  1784 acdc16dc      	jpf	LC026
5634  1788               L5741:
5635                     ; 1685 			if(DIDrwstate == Didread)
5637  1788 7b07          	ld	a,(OFST+6,sp)
5638  178a 4a            	dec	a
5639  178b 2610          	jrne	L3661
5640                     ; 1687 				Didonelong = 2;
5642  178d a602          	ld	a,#2
5643  178f 6b01          	ld	(OFST+0,sp),a
5644                     ; 1688 				Didvalue[0] = F1f4didsave[0];
5646  1791 550010003c    	mov	_Didvalue,_F1f4didsave
5647                     ; 1689                             Didvalue[1] = F1f4didsave[1];
5649  1796 550011003d    	mov	_Didvalue+1,_F1f4didsave+1
5651  179b 2033          	jra	L5251
5652  179d               L3661:
5653                     ; 1693 				if(R_PDU[0].PCI != 5) { Didonelong = NCR13+0x10;  break;}
5655  179d c600a7        	ld	a,_R_PDU+2
5656  17a0 a105          	cp	a,#5
5660  17a2 26bc          	jrne	LC024
5661                     ; 1694 				F1f4didsave[0] = R_PDU[0].Data[3];
5663  17a4 5500ab0010    	mov	_F1f4didsave,_R_PDU+6
5664                     ; 1695 				F1f4didsave[1] = R_PDU[0].Data[4];
5666  17a9 5500ac0011    	mov	_F1f4didsave+1,_R_PDU+7
5667                     ; 1696 				F1f4savestate=2;
5669  17ae 3502000f      	mov	_F1f4savestate,#2
5670                     ; 1702 				if((F1f4didsave[0] != R_PDU[0].Data[3])||(F1f4didsave[1] != R_PDU[0].Data[4]))
5672  17b2 c600ab        	ld	a,_R_PDU+6
5673  17b5 c10010        	cp	a,_F1f4didsave
5674  17b8 26c0          	jrne	L5261
5676  17ba c600ac        	ld	a,_R_PDU+7
5677  17bd c10011        	cp	a,_F1f4didsave+1
5678                     ; 1704 					Didonelong = NCR72+0x10;
5679  17c0 acdc16dc      	jpf	LC026
5680  17c4               L7741:
5681                     ; 1711 			if(DIDrwstate == Didread)
5683  17c4 7b07          	ld	a,(OFST+6,sp)
5684  17c6 4a            	dec	a
5685  17c7 2603          	jrne	L5761
5686                     ; 1713 				Didonelong = 1;
5688  17c9 4c            	inc	a
5690  17ca 2002          	jpf	LC022
5691  17cc               L5761:
5692                     ; 1717 				Didonelong = NCR31+0x10;
5702  17cc a641          	ld	a,#65
5703  17ce               LC022:
5704  17ce 6b01          	ld	(OFST+0,sp),a
5705  17d0               L5251:
5706                     ; 1727 	 return Didonelong;
5708  17d0 7b01          	ld	a,(OFST+0,sp)
5711  17d2 5b03          	addw	sp,#3
5712  17d4 87            	retf	
5801                     ; 1740  unsigned char UDSDiag2e(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
5801                     ; 1741  {
5802                     	switch	.text
5803  17d5               f_UDSDiag2e:
5805  17d5 89            	pushw	x
5806  17d6 5205          	subw	sp,#5
5807       00000005      OFST:	set	5
5810                     ; 1742  	unsigned char Errorvalue=0;
5812  17d8 0f03          	clr	(OFST-2,sp)
5813                     ; 1747 	if(pci < 0x04) return NCR13;//add diag error long
5815  17da 9e            	ld	a,xh
5816  17db a104          	cp	a,#4
5817  17dd 2404          	jruge	L5371
5820  17df a613          	ld	a,#19
5822  17e1 200c          	jra	L024
5823  17e3               L5371:
5824                     ; 1749 	if(SalfeMode < salfe02) {Errorvalue = NCR33 ;return Errorvalue;}
5826  17e3 c60051        	ld	a,_SalfeMode
5827  17e6 a102          	cp	a,#2
5828  17e8 2408          	jruge	L7371
5831  17ea 7b03          	ld	a,(OFST-2,sp)
5832  17ec 97            	ld	xl,a
5835  17ed a633          	ld	a,#51
5837  17ef               L024:
5839  17ef 5b07          	addw	sp,#7
5840  17f1 87            	retf	
5841  17f2               L7371:
5842                     ; 1751 	if((pci & 0xf0)==0x10)
5844  17f2 7b06          	ld	a,(OFST+1,sp)
5845  17f4 a4f0          	and	a,#240
5846  17f6 a110          	cp	a,#16
5847  17f8 260b          	jrne	L1471
5848                     ; 1753               datalang = d0;
5850                     ; 1754 		DIDv = d2;
5852  17fa 7b0c          	ld	a,(OFST+7,sp)
5853  17fc 5f            	clrw	x
5854  17fd 97            	ld	xl,a
5855                     ; 1755 		DIDv = (DIDv << 8)+d3;
5857  17fe 4f            	clr	a
5858  17ff 1b0d          	add	a,(OFST+8,sp)
5859  1801 240c          	jrnc	L414
5861  1803 2009          	jpf	LC027
5862  1805               L1471:
5863                     ; 1759               datalang = pci;
5865                     ; 1760 		DIDv = d1;
5867  1805 7b0b          	ld	a,(OFST+6,sp)
5868  1807 5f            	clrw	x
5869  1808 97            	ld	xl,a
5870                     ; 1761 		DIDv = (DIDv << 8)+d2;
5872  1809 4f            	clr	a
5873  180a 1b0c          	add	a,(OFST+7,sp)
5874  180c 2401          	jrnc	L414
5875  180e               LC027:
5876  180e 5c            	incw	x
5877  180f               L414:
5878  180f 02            	rlwa	x,a
5879  1810 1f04          	ldw	(OFST-1,sp),x
5880                     ; 1765     rexstate = ReadDidvalue(DIDv,Didwrite);
5882  1812 4b02          	push	#2
5883  1814 1e05          	ldw	x,(OFST+0,sp)
5884  1816 8d831383      	callf	f_ReadDidvalue
5886  181a 5b01          	addw	sp,#1
5887  181c 6b02          	ld	(OFST-3,sp),a
5888                     ; 1766     if(rexstate > 20) Errorvalue = rexstate-0x10;
5890  181e a115          	cp	a,#21
5891  1820 2504          	jrult	L5471
5894  1822 a010          	sub	a,#16
5895  1824 6b03          	ld	(OFST-2,sp),a
5896  1826               L5471:
5897                     ; 1768  	return Errorvalue;
5899  1826 7b03          	ld	a,(OFST-2,sp)
5901  1828 20c5          	jra	L024
5963                     ; 1771  unsigned char UDSDiag19(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
5963                     ; 1772  {
5964                     	switch	.text
5965  182a               f_UDSDiag19:
5967  182a 89            	pushw	x
5968  182b 89            	pushw	x
5969       00000002      OFST:	set	2
5972                     ; 1773  	unsigned char Errorvalue=0;
5974  182c 0f02          	clr	(OFST+0,sp)
5975                     ; 1776 	if(pci != 0x03) {Errorvalue = NCR13; return Errorvalue;}  //add diag error long
5977  182e 9e            	ld	a,xh
5978  182f a103          	cp	a,#3
5979  1831 2707          	jreq	L1102
5982  1833 7b02          	ld	a,(OFST+0,sp)
5983  1835 97            	ld	xl,a
5986  1836 a613          	ld	a,#19
5988  1838 205b          	jra	L634
5989  183a               L1102:
5990                     ; 1778 	switch(d1)
5992  183a 7b08          	ld	a,(OFST+6,sp)
5994                     ; 1810 		}break;
5995  183c 4a            	dec	a
5996  183d 2713          	jreq	L7471
5997  183f 4a            	dec	a
5998  1840 2734          	jreq	L1571
5999  1842 4a            	dec	a
6000  1843 2740          	jreq	L3571
6001  1845 4a            	dec	a
6002  1846 273d          	jreq	L3571
6003  1848 a002          	sub	a,#2
6004  184a 2739          	jreq	L3571
6005  184c a004          	sub	a,#4
6006  184e 2739          	jreq	L1671
6007                     ; 1809 			Errorvalue = NCR12;
6008                     ; 1810 		}break;
6010  1850 2033          	jpf	L3571
6011  1852               L7471:
6012                     ; 1782                      dtcnumber = ReadDTCquantity(d2);
6014  1852 7b09          	ld	a,(OFST+7,sp)
6015  1854 8d7a1b7a      	callf	f_ReadDTCquantity
6017  1858 6b01          	ld	(OFST-1,sp),a
6018                     ; 1783 			UDSsendone(0x06,SID19+0x40,0x01,d2,0,0,dtcnumber,0);
6020  185a 4b00          	push	#0
6021  185c 7b02          	ld	a,(OFST+0,sp)
6022  185e 88            	push	a
6023  185f 4b00          	push	#0
6024  1861 4b00          	push	#0
6025  1863 7b0d          	ld	a,(OFST+11,sp)
6026  1865 88            	push	a
6027  1866 4b01          	push	#1
6028  1868 ae0059        	ldw	x,#89
6029  186b a606          	ld	a,#6
6030  186d 95            	ld	xh,a
6031  186e 8d110c11      	callf	f_UDSsendone
6033  1872 5b06          	addw	sp,#6
6034                     ; 1784 		}break;
6036  1874 201d          	jra	L5102
6037  1876               L1571:
6038                     ; 1787 			dtcnumber = ReadDTCquantity(d2);
6040  1876 7b09          	ld	a,(OFST+7,sp)
6041  1878 8d7a1b7a      	callf	f_ReadDTCquantity
6043  187c 6b01          	ld	(OFST-1,sp),a
6044                     ; 1788 			Errorvalue = SaveDTCtoBuff(dtcnumber,d2);
6046  187e 7b09          	ld	a,(OFST+7,sp)
6047  1880 97            	ld	xl,a
6048  1881 7b01          	ld	a,(OFST-1,sp)
6050                     ; 1789 		}break;
6052  1883 2007          	jpf	LC029
6053  1885               L3571:
6054                     ; 1792 			Errorvalue = NCR12;
6059  1885 a612          	ld	a,#18
6060                     ; 1793 		}break;
6062  1887 2008          	jpf	LC028
6063                     ; 1796 			Errorvalue = NCR12;
6064                     ; 1797 		}break;
6066                     ; 1800 			Errorvalue = NCR12;
6067                     ; 1801 		}break;
6069  1889               L1671:
6070                     ; 1804 			dtcnumber =DTCLong ;// ReadDTCquantity(d2);
6072                     ; 1805 			Errorvalue = SaveDTCtoBuff(dtcnumber,0);
6074  1889 5f            	clrw	x
6075  188a a615          	ld	a,#21
6076  188c               LC029:
6077  188c 95            	ld	xh,a
6078  188d 8df018f0      	callf	f_SaveDTCtoBuff
6080  1891               LC028:
6081  1891 6b02          	ld	(OFST+0,sp),a
6082                     ; 1806 		}break;
6084  1893               L5102:
6085                     ; 1814  	return Errorvalue;
6087  1893 7b02          	ld	a,(OFST+0,sp)
6089  1895               L634:
6091  1895 5b04          	addw	sp,#4
6092  1897 87            	retf	
6133                     ; 1817 unsigned char UDSclearDTC(void)
6133                     ; 1818 {
6134                     	switch	.text
6135  1898               f_UDSclearDTC:
6137  1898 5206          	subw	sp,#6
6138       00000006      OFST:	set	6
6141                     ; 1821 	for(ccntt =0;ccntt <DTCLong; ccntt++)
6143  189a 0f06          	clr	(OFST+0,sp)
6144  189c               L5302:
6145                     ; 1823 	    for(ccntt2 = 0 ; ccntt2 < 5; ccntt2++)
6147  189c 0f05          	clr	(OFST-1,sp)
6148  189e               L3402:
6149                     ; 1825 			if(DTCstate[ccntt] != 0)
6151  189e 7b06          	ld	a,(OFST+0,sp)
6152  18a0 5f            	clrw	x
6153  18a1 97            	ld	xl,a
6154  18a2 d64150        	ld	a,(_DTCstate,x)
6155  18a5 273d          	jreq	L7402
6156                     ; 1827 				Weeprommain((unsigned long)(&DTCstate[ccntt]),0x00);
6158  18a7 4b00          	push	#0
6159  18a9 ae4150        	ldw	x,#_DTCstate
6160  18ac 8d000000      	callf	d_uitolx
6162  18b0 96            	ldw	x,sp
6163  18b1 1c0002        	addw	x,#OFST-4
6164  18b4 8d000000      	callf	d_rtol
6166  18b8 7b07          	ld	a,(OFST+1,sp)
6167  18ba b703          	ld	c_lreg+3,a
6168  18bc 3f02          	clr	c_lreg+2
6169  18be 3f01          	clr	c_lreg+1
6170  18c0 3f00          	clr	c_lreg
6171  18c2 96            	ldw	x,sp
6172  18c3 1c0002        	addw	x,#OFST-4
6173  18c6 8d000000      	callf	d_ladd
6175  18ca be02          	ldw	x,c_lreg+2
6176  18cc 89            	pushw	x
6177  18cd be00          	ldw	x,c_lreg
6178  18cf 89            	pushw	x
6179  18d0 8d000000      	callf	f_Weeprommain
6181  18d4 5b05          	addw	sp,#5
6182                     ; 1828 				WWDG_Refresh(0x7f);
6184  18d6 a67f          	ld	a,#127
6185  18d8 8d000000      	callf	f_WWDG_Refresh
6188                     ; 1823 	    for(ccntt2 = 0 ; ccntt2 < 5; ccntt2++)
6190  18dc 0c05          	inc	(OFST-1,sp)
6193  18de 7b05          	ld	a,(OFST-1,sp)
6194  18e0 a105          	cp	a,#5
6195  18e2 25ba          	jrult	L3402
6196  18e4               L7402:
6197                     ; 1821 	for(ccntt =0;ccntt <DTCLong; ccntt++)
6199  18e4 0c06          	inc	(OFST+0,sp)
6202  18e6 7b06          	ld	a,(OFST+0,sp)
6203  18e8 a115          	cp	a,#21
6204  18ea 25b0          	jrult	L5302
6205                     ; 1839     return NCRright;
6207  18ec 4f            	clr	a
6210  18ed 5b06          	addw	sp,#6
6211  18ef 87            	retf	
6275                     ; 1842 unsigned char SaveDTCtoBuff(uu8 dtcnumber,uu8 dtcmask)
6275                     ; 1843 {
6276                     	switch	.text
6277  18f0               f_SaveDTCtoBuff:
6279  18f0 89            	pushw	x
6280  18f1 5204          	subw	sp,#4
6281       00000004      OFST:	set	4
6284                     ; 1845 	if(dtcnumber > 1) //多帧发送
6286  18f3 9e            	ld	a,xh
6287  18f4 a102          	cp	a,#2
6288  18f6 2404ac8e1a8e  	jrult	L1012
6289                     ; 1847 	     N_PDU[0].PCI = 0x10;
6291  18fc 3510016f      	mov	_N_PDU+2,#16
6292                     ; 1848 		 N_PDU[0].Data[0] = (dtcnumber << 2)+3 ;
6294  1900 9e            	ld	a,xh
6295  1901 48            	sll	a
6296  1902 48            	sll	a
6297  1903 ab03          	add	a,#3
6298  1905 c70170        	ld	_N_PDU+3,a
6299                     ; 1849 		 N_PDU[0].Data[1] = SID19+0x40;
6301  1908 35590171      	mov	_N_PDU+4,#89
6302                     ; 1850 		 N_PDU[0].Data[2] = R_PDU[0].Data[1];
6304  190c 5500a90172    	mov	_N_PDU+5,_R_PDU+4
6305                     ; 1851 		 N_PDU[0].Data[3] = R_PDU[0].Data[2];
6307  1911 5500aa0173    	mov	_N_PDU+6,_R_PDU+5
6308                     ; 1852 	     ccnt1 = 0;
6310  1916 0f03          	clr	(OFST-1,sp)
6311                     ; 1853 		 ccnt2 = 4;
6313  1918 a604          	ld	a,#4
6314  191a 6b04          	ld	(OFST+0,sp),a
6315                     ; 1854 	     for(ccnt = 0; ccnt <DTCLong ; ccnt++)
6317  191c 0f02          	clr	(OFST-2,sp)
6318  191e               L3012:
6319                     ; 1856 	         if(dtcmask == 0)
6321  191e 7b06          	ld	a,(OFST+2,sp)
6322  1920 2704acc019c0  	jrne	L1112
6323                     ; 1858 	             N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCH;
6325  1926 7b04          	ld	a,(OFST+0,sp)
6326  1928 0c04          	inc	(OFST+0,sp)
6327  192a 6b01          	ld	(OFST-3,sp),a
6328  192c 7b03          	ld	a,(OFST-1,sp)
6329  192e 97            	ld	xl,a
6330  192f a60a          	ld	a,#10
6331  1931 42            	mul	x,a
6332  1932 01            	rrwa	x,a
6333  1933 1b01          	add	a,(OFST-3,sp)
6334  1935 2401          	jrnc	L054
6335  1937 5c            	incw	x
6336  1938               L054:
6337  1938 02            	rlwa	x,a
6338  1939 89            	pushw	x
6339  193a 7b04          	ld	a,(OFST+0,sp)
6340  193c 97            	ld	xl,a
6341  193d a603          	ld	a,#3
6342  193f 42            	mul	x,a
6343  1940 d60066        	ld	a,(_DTCNameN,x)
6344  1943 85            	popw	x
6345  1944 d70170        	ld	(_N_PDU+3,x),a
6346                     ; 1859 				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
6348  1947 7b04          	ld	a,(OFST+0,sp)
6349  1949 a107          	cp	a,#7
6350  194b 2506          	jrult	L3112
6353  194d 0f04          	clr	(OFST+0,sp)
6356  194f 0c03          	inc	(OFST-1,sp)
6357  1951 7b04          	ld	a,(OFST+0,sp)
6358  1953               L3112:
6359                     ; 1860 	             N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCL;
6361  1953 0c04          	inc	(OFST+0,sp)
6362  1955 6b01          	ld	(OFST-3,sp),a
6363  1957 7b03          	ld	a,(OFST-1,sp)
6364  1959 97            	ld	xl,a
6365  195a a60a          	ld	a,#10
6366  195c 42            	mul	x,a
6367  195d 01            	rrwa	x,a
6368  195e 1b01          	add	a,(OFST-3,sp)
6369  1960 2401          	jrnc	L254
6370  1962 5c            	incw	x
6371  1963               L254:
6372  1963 02            	rlwa	x,a
6373  1964 89            	pushw	x
6374  1965 7b04          	ld	a,(OFST+0,sp)
6375  1967 97            	ld	xl,a
6376  1968 a603          	ld	a,#3
6377  196a 42            	mul	x,a
6378  196b d60067        	ld	a,(_DTCNameN+1,x)
6379  196e 85            	popw	x
6380  196f d70170        	ld	(_N_PDU+3,x),a
6381                     ; 1861 				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
6383  1972 7b04          	ld	a,(OFST+0,sp)
6384  1974 a107          	cp	a,#7
6385  1976 2506          	jrult	L5112
6388  1978 0f04          	clr	(OFST+0,sp)
6391  197a 0c03          	inc	(OFST-1,sp)
6392  197c 7b04          	ld	a,(OFST+0,sp)
6393  197e               L5112:
6394                     ; 1862 	             N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCS;
6396  197e 0c04          	inc	(OFST+0,sp)
6397  1980 6b01          	ld	(OFST-3,sp),a
6398  1982 7b03          	ld	a,(OFST-1,sp)
6399  1984 97            	ld	xl,a
6400  1985 a60a          	ld	a,#10
6401  1987 42            	mul	x,a
6402  1988 01            	rrwa	x,a
6403  1989 1b01          	add	a,(OFST-3,sp)
6404  198b 2401          	jrnc	L454
6405  198d 5c            	incw	x
6406  198e               L454:
6407  198e 02            	rlwa	x,a
6408  198f 89            	pushw	x
6409  1990 7b04          	ld	a,(OFST+0,sp)
6410  1992 97            	ld	xl,a
6411  1993 a603          	ld	a,#3
6412  1995 42            	mul	x,a
6413  1996 d60068        	ld	a,(_DTCNameN+2,x)
6414  1999 85            	popw	x
6415  199a d70170        	ld	(_N_PDU+3,x),a
6416                     ; 1863 				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
6418  199d 7b04          	ld	a,(OFST+0,sp)
6419  199f a107          	cp	a,#7
6420  19a1 2506          	jrult	L7112
6423  19a3 0f04          	clr	(OFST+0,sp)
6426  19a5 0c03          	inc	(OFST-1,sp)
6427  19a7 7b04          	ld	a,(OFST+0,sp)
6428  19a9               L7112:
6429                     ; 1864 	             N_PDU[ccnt1].Data[ccnt2++] = DTCstate[ccnt];
6431  19a9 0c04          	inc	(OFST+0,sp)
6432  19ab 6b01          	ld	(OFST-3,sp),a
6433  19ad 7b03          	ld	a,(OFST-1,sp)
6434  19af 97            	ld	xl,a
6435  19b0 a60a          	ld	a,#10
6436  19b2 42            	mul	x,a
6437  19b3 01            	rrwa	x,a
6438  19b4 1b01          	add	a,(OFST-3,sp)
6439  19b6 2504ac621a62  	jrnc	L664
6440                     ; 1865 				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
6443  19bc ac611a61      	jpf	LC032
6444  19c0               L1112:
6445                     ; 1870 				 if(dtcmask & DTCstate[ccnt])
6447  19c0 7b02          	ld	a,(OFST-2,sp)
6448  19c2 5f            	clrw	x
6449  19c3 97            	ld	xl,a
6450  19c4 d64150        	ld	a,(_DTCstate,x)
6451  19c7 1506          	bcp	a,(OFST+2,sp)
6452  19c9 2604ac7a1a7a  	jreq	L3212
6453                     ; 1872 			         N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCH;
6455  19cf 7b04          	ld	a,(OFST+0,sp)
6456  19d1 0c04          	inc	(OFST+0,sp)
6457  19d3 6b01          	ld	(OFST-3,sp),a
6458  19d5 7b03          	ld	a,(OFST-1,sp)
6459  19d7 97            	ld	xl,a
6460  19d8 a60a          	ld	a,#10
6461  19da 42            	mul	x,a
6462  19db 01            	rrwa	x,a
6463  19dc 1b01          	add	a,(OFST-3,sp)
6464  19de 2401          	jrnc	L064
6465  19e0 5c            	incw	x
6466  19e1               L064:
6467  19e1 02            	rlwa	x,a
6468  19e2 89            	pushw	x
6469  19e3 7b04          	ld	a,(OFST+0,sp)
6470  19e5 97            	ld	xl,a
6471  19e6 a603          	ld	a,#3
6472  19e8 42            	mul	x,a
6473  19e9 d60066        	ld	a,(_DTCNameN,x)
6474  19ec 85            	popw	x
6475  19ed d70170        	ld	(_N_PDU+3,x),a
6476                     ; 1873 					 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
6478  19f0 7b04          	ld	a,(OFST+0,sp)
6479  19f2 a107          	cp	a,#7
6480  19f4 2506          	jrult	L7212
6483  19f6 0f04          	clr	(OFST+0,sp)
6486  19f8 0c03          	inc	(OFST-1,sp)
6487  19fa 7b04          	ld	a,(OFST+0,sp)
6488  19fc               L7212:
6489                     ; 1874 			         N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCL;
6491  19fc 0c04          	inc	(OFST+0,sp)
6492  19fe 6b01          	ld	(OFST-3,sp),a
6493  1a00 7b03          	ld	a,(OFST-1,sp)
6494  1a02 97            	ld	xl,a
6495  1a03 a60a          	ld	a,#10
6496  1a05 42            	mul	x,a
6497  1a06 01            	rrwa	x,a
6498  1a07 1b01          	add	a,(OFST-3,sp)
6499  1a09 2401          	jrnc	L264
6500  1a0b 5c            	incw	x
6501  1a0c               L264:
6502  1a0c 02            	rlwa	x,a
6503  1a0d 89            	pushw	x
6504  1a0e 7b04          	ld	a,(OFST+0,sp)
6505  1a10 97            	ld	xl,a
6506  1a11 a603          	ld	a,#3
6507  1a13 42            	mul	x,a
6508  1a14 d60067        	ld	a,(_DTCNameN+1,x)
6509  1a17 85            	popw	x
6510  1a18 d70170        	ld	(_N_PDU+3,x),a
6511                     ; 1875 					 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
6513  1a1b 7b04          	ld	a,(OFST+0,sp)
6514  1a1d a107          	cp	a,#7
6515  1a1f 2506          	jrult	L1312
6518  1a21 0f04          	clr	(OFST+0,sp)
6521  1a23 0c03          	inc	(OFST-1,sp)
6522  1a25 7b04          	ld	a,(OFST+0,sp)
6523  1a27               L1312:
6524                     ; 1876 			         N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCS;
6526  1a27 0c04          	inc	(OFST+0,sp)
6527  1a29 6b01          	ld	(OFST-3,sp),a
6528  1a2b 7b03          	ld	a,(OFST-1,sp)
6529  1a2d 97            	ld	xl,a
6530  1a2e a60a          	ld	a,#10
6531  1a30 42            	mul	x,a
6532  1a31 01            	rrwa	x,a
6533  1a32 1b01          	add	a,(OFST-3,sp)
6534  1a34 2401          	jrnc	L464
6535  1a36 5c            	incw	x
6536  1a37               L464:
6537  1a37 02            	rlwa	x,a
6538  1a38 89            	pushw	x
6539  1a39 7b04          	ld	a,(OFST+0,sp)
6540  1a3b 97            	ld	xl,a
6541  1a3c a603          	ld	a,#3
6542  1a3e 42            	mul	x,a
6543  1a3f d60068        	ld	a,(_DTCNameN+2,x)
6544  1a42 85            	popw	x
6545  1a43 d70170        	ld	(_N_PDU+3,x),a
6546                     ; 1877 					 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
6548  1a46 7b04          	ld	a,(OFST+0,sp)
6549  1a48 a107          	cp	a,#7
6550  1a4a 2506          	jrult	L3312
6553  1a4c 0f04          	clr	(OFST+0,sp)
6556  1a4e 0c03          	inc	(OFST-1,sp)
6557  1a50 7b04          	ld	a,(OFST+0,sp)
6558  1a52               L3312:
6559                     ; 1878 			         N_PDU[ccnt1].Data[ccnt2++] = DTCstate[ccnt];
6561  1a52 0c04          	inc	(OFST+0,sp)
6562  1a54 6b01          	ld	(OFST-3,sp),a
6563  1a56 7b03          	ld	a,(OFST-1,sp)
6564  1a58 97            	ld	xl,a
6565  1a59 a60a          	ld	a,#10
6566  1a5b 42            	mul	x,a
6567  1a5c 01            	rrwa	x,a
6568  1a5d 1b01          	add	a,(OFST-3,sp)
6569  1a5f 2401          	jrnc	L664
6570  1a61               LC032:
6571  1a61 5c            	incw	x
6572  1a62               L664:
6573                     ; 1879 					 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
6579  1a62 02            	rlwa	x,a
6580  1a63 7b02          	ld	a,(OFST-2,sp)
6581  1a65 905f          	clrw	y
6582  1a67 9097          	ld	yl,a
6583  1a69 90d64150      	ld	a,(_DTCstate,y)
6584  1a6d d70170        	ld	(_N_PDU+3,x),a
6586  1a70 7b04          	ld	a,(OFST+0,sp)
6587  1a72 a107          	cp	a,#7
6588  1a74 2504          	jrult	L3212
6590  1a76 0f04          	clr	(OFST+0,sp)
6592  1a78 0c03          	inc	(OFST-1,sp)
6593  1a7a               L3212:
6594                     ; 1854 	     for(ccnt = 0; ccnt <DTCLong ; ccnt++)
6596  1a7a 0c02          	inc	(OFST-2,sp)
6599  1a7c 7b02          	ld	a,(OFST-2,sp)
6600  1a7e a115          	cp	a,#21
6601  1a80 2404ac1e191e  	jrult	L3012
6602                     ; 1883 		 N_UDSDdata.Request = 2 ;//请求多帧发送
6604  1a86 35020283      	mov	_N_UDSDdata,#2
6606  1a8a ac761b76      	jra	L7312
6607  1a8e               L1012:
6608                     ; 1887 		 N_PDU[0].PCI = (dtcnumber << 2) +3;
6610  1a8e 7b05          	ld	a,(OFST+1,sp)
6611  1a90 48            	sll	a
6612  1a91 48            	sll	a
6613  1a92 ab03          	add	a,#3
6614  1a94 c7016f        	ld	_N_PDU+2,a
6615                     ; 1888 		 N_PDU[0].Data[0] = SID19+0x40;
6617  1a97 35590170      	mov	_N_PDU+3,#89
6618                     ; 1889 		 N_PDU[0].Data[1] = R_PDU[0].Data[1];
6620  1a9b 5500a90171    	mov	_N_PDU+4,_R_PDU+4
6621                     ; 1890 		 N_PDU[0].Data[2] = R_PDU[0].Data[2];
6623  1aa0 5500aa0172    	mov	_N_PDU+5,_R_PDU+5
6624                     ; 1892 	     ccnt1 = 0;
6626  1aa5 0f03          	clr	(OFST-1,sp)
6627                     ; 1893 		 ccnt2 = 3;
6629  1aa7 a603          	ld	a,#3
6630  1aa9 6b04          	ld	(OFST+0,sp),a
6631                     ; 1894 	     for(ccnt = 0; ccnt <DTCLong ; ccnt++)
6633  1aab 4f            	clr	a
6634  1aac 6b02          	ld	(OFST-2,sp),a
6635  1aae               L1412:
6636                     ; 1897 			 if(dtcmask & DTCstate[ccnt])
6638  1aae 5f            	clrw	x
6639  1aaf 97            	ld	xl,a
6640  1ab0 d64150        	ld	a,(_DTCstate,x)
6641  1ab3 1506          	bcp	a,(OFST+2,sp)
6642  1ab5 2604ac661b66  	jreq	L7412
6643                     ; 1899 		         N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCH;
6645  1abb 7b04          	ld	a,(OFST+0,sp)
6646  1abd 0c04          	inc	(OFST+0,sp)
6647  1abf 6b01          	ld	(OFST-3,sp),a
6648  1ac1 7b03          	ld	a,(OFST-1,sp)
6649  1ac3 97            	ld	xl,a
6650  1ac4 a60a          	ld	a,#10
6651  1ac6 42            	mul	x,a
6652  1ac7 01            	rrwa	x,a
6653  1ac8 1b01          	add	a,(OFST-3,sp)
6654  1aca 2401          	jrnc	L074
6655  1acc 5c            	incw	x
6656  1acd               L074:
6657  1acd 02            	rlwa	x,a
6658  1ace 89            	pushw	x
6659  1acf 7b04          	ld	a,(OFST+0,sp)
6660  1ad1 97            	ld	xl,a
6661  1ad2 a603          	ld	a,#3
6662  1ad4 42            	mul	x,a
6663  1ad5 d60066        	ld	a,(_DTCNameN,x)
6664  1ad8 85            	popw	x
6665  1ad9 d70170        	ld	(_N_PDU+3,x),a
6666                     ; 1900 				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
6668  1adc 7b04          	ld	a,(OFST+0,sp)
6669  1ade a107          	cp	a,#7
6670  1ae0 2506          	jrult	L1512
6673  1ae2 0f04          	clr	(OFST+0,sp)
6676  1ae4 0c03          	inc	(OFST-1,sp)
6677  1ae6 7b04          	ld	a,(OFST+0,sp)
6678  1ae8               L1512:
6679                     ; 1901 		         N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCL;
6681  1ae8 0c04          	inc	(OFST+0,sp)
6682  1aea 6b01          	ld	(OFST-3,sp),a
6683  1aec 7b03          	ld	a,(OFST-1,sp)
6684  1aee 97            	ld	xl,a
6685  1aef a60a          	ld	a,#10
6686  1af1 42            	mul	x,a
6687  1af2 01            	rrwa	x,a
6688  1af3 1b01          	add	a,(OFST-3,sp)
6689  1af5 2401          	jrnc	L274
6690  1af7 5c            	incw	x
6691  1af8               L274:
6692  1af8 02            	rlwa	x,a
6693  1af9 89            	pushw	x
6694  1afa 7b04          	ld	a,(OFST+0,sp)
6695  1afc 97            	ld	xl,a
6696  1afd a603          	ld	a,#3
6697  1aff 42            	mul	x,a
6698  1b00 d60067        	ld	a,(_DTCNameN+1,x)
6699  1b03 85            	popw	x
6700  1b04 d70170        	ld	(_N_PDU+3,x),a
6701                     ; 1902 				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
6703  1b07 7b04          	ld	a,(OFST+0,sp)
6704  1b09 a107          	cp	a,#7
6705  1b0b 2506          	jrult	L3512
6708  1b0d 0f04          	clr	(OFST+0,sp)
6711  1b0f 0c03          	inc	(OFST-1,sp)
6712  1b11 7b04          	ld	a,(OFST+0,sp)
6713  1b13               L3512:
6714                     ; 1903 		         N_PDU[ccnt1].Data[ccnt2++] = DTCNameN[ccnt].DTCS;
6716  1b13 0c04          	inc	(OFST+0,sp)
6717  1b15 6b01          	ld	(OFST-3,sp),a
6718  1b17 7b03          	ld	a,(OFST-1,sp)
6719  1b19 97            	ld	xl,a
6720  1b1a a60a          	ld	a,#10
6721  1b1c 42            	mul	x,a
6722  1b1d 01            	rrwa	x,a
6723  1b1e 1b01          	add	a,(OFST-3,sp)
6724  1b20 2401          	jrnc	L474
6725  1b22 5c            	incw	x
6726  1b23               L474:
6727  1b23 02            	rlwa	x,a
6728  1b24 89            	pushw	x
6729  1b25 7b04          	ld	a,(OFST+0,sp)
6730  1b27 97            	ld	xl,a
6731  1b28 a603          	ld	a,#3
6732  1b2a 42            	mul	x,a
6733  1b2b d60068        	ld	a,(_DTCNameN+2,x)
6734  1b2e 85            	popw	x
6735  1b2f d70170        	ld	(_N_PDU+3,x),a
6736                     ; 1904 				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
6738  1b32 7b04          	ld	a,(OFST+0,sp)
6739  1b34 a107          	cp	a,#7
6740  1b36 2506          	jrult	L5512
6743  1b38 0f04          	clr	(OFST+0,sp)
6746  1b3a 0c03          	inc	(OFST-1,sp)
6747  1b3c 7b04          	ld	a,(OFST+0,sp)
6748  1b3e               L5512:
6749                     ; 1905 		         N_PDU[ccnt1].Data[ccnt2++] = DTCstate[ccnt];
6751  1b3e 0c04          	inc	(OFST+0,sp)
6752  1b40 6b01          	ld	(OFST-3,sp),a
6753  1b42 7b03          	ld	a,(OFST-1,sp)
6754  1b44 97            	ld	xl,a
6755  1b45 a60a          	ld	a,#10
6756  1b47 42            	mul	x,a
6757  1b48 01            	rrwa	x,a
6758  1b49 1b01          	add	a,(OFST-3,sp)
6759  1b4b 2401          	jrnc	L674
6760  1b4d 5c            	incw	x
6761  1b4e               L674:
6762  1b4e 02            	rlwa	x,a
6763  1b4f 7b02          	ld	a,(OFST-2,sp)
6764  1b51 905f          	clrw	y
6765  1b53 9097          	ld	yl,a
6766  1b55 90d64150      	ld	a,(_DTCstate,y)
6767  1b59 d70170        	ld	(_N_PDU+3,x),a
6768                     ; 1906 				 if(ccnt2 > 6){ccnt2 = 0;ccnt1++;}
6770  1b5c 7b04          	ld	a,(OFST+0,sp)
6771  1b5e a107          	cp	a,#7
6772  1b60 2504          	jrult	L7412
6775  1b62 0f04          	clr	(OFST+0,sp)
6778  1b64 0c03          	inc	(OFST-1,sp)
6779  1b66               L7412:
6780                     ; 1894 	     for(ccnt = 0; ccnt <DTCLong ; ccnt++)
6782  1b66 0c02          	inc	(OFST-2,sp)
6785  1b68 7b02          	ld	a,(OFST-2,sp)
6786  1b6a a115          	cp	a,#21
6787  1b6c 2404acae1aae  	jrult	L1412
6788                     ; 1910 		 N_UDSDdata.Request = 1 ;//请求单帧发送
6790  1b72 35010283      	mov	_N_UDSDdata,#1
6791  1b76               L7312:
6792                     ; 1914     return NCRright;
6794  1b76 4f            	clr	a
6797  1b77 5b06          	addw	sp,#6
6798  1b79 87            	retf	
6844                     ; 1918 unsigned char ReadDTCquantity(unsigned char DTCMASK)
6844                     ; 1919 {
6845                     	switch	.text
6846  1b7a               f_ReadDTCquantity:
6848  1b7a 88            	push	a
6849  1b7b 89            	pushw	x
6850       00000002      OFST:	set	2
6853                     ; 1922     cnt1 = 0;
6855                     ; 1923 	cnt2 = 0;
6857  1b7c 0f01          	clr	(OFST-1,sp)
6858                     ; 1924     for(cnt1 = 0; cnt1 < DTCLong; cnt1++)
6860  1b7e 4f            	clr	a
6861  1b7f 6b02          	ld	(OFST+0,sp),a
6862  1b81               L1022:
6863                     ; 1926         if(( DTCstate[cnt1] & DTCMASK)!=0)
6865  1b81 5f            	clrw	x
6866  1b82 97            	ld	xl,a
6867  1b83 d64150        	ld	a,(_DTCstate,x)
6868  1b86 1503          	bcp	a,(OFST+1,sp)
6869  1b88 2702          	jreq	L7022
6870                     ; 1928            cnt2++;
6872  1b8a 0c01          	inc	(OFST-1,sp)
6873  1b8c               L7022:
6874                     ; 1924     for(cnt1 = 0; cnt1 < DTCLong; cnt1++)
6876  1b8c 0c02          	inc	(OFST+0,sp)
6879  1b8e 7b02          	ld	a,(OFST+0,sp)
6880  1b90 a115          	cp	a,#21
6881  1b92 25ed          	jrult	L1022
6882                     ; 1933     return cnt2;
6884  1b94 7b01          	ld	a,(OFST-1,sp)
6887  1b96 5b03          	addw	sp,#3
6888  1b98 87            	retf	
6890                     	switch	.data
6891  0009               L1122_code:
6892  0009 00            	dc.b	0
6984                     ; 1938  unsigned char UDSDiag27(uu8 pci,uu8 d0,uu8 d1,uu8 d2,uu8 d3,uu8 d4,uu8 d5,uu8 d6)
6984                     ; 1939  {
6985                     	switch	.text
6986  1b99               f_UDSDiag27:
6988  1b99 89            	pushw	x
6989  1b9a 88            	push	a
6990       00000001      OFST:	set	1
6993                     ; 1940  	unsigned char Errorvalue = 0;
6995  1b9b 0f01          	clr	(OFST+0,sp)
6996                     ; 1942 	if((pci != 2)&&(pci != 6)&&(pci != 4)) return NCR13;
6998  1b9d 9e            	ld	a,xh
6999  1b9e a102          	cp	a,#2
7000  1ba0 270e          	jreq	L3622
7002  1ba2 9e            	ld	a,xh
7003  1ba3 a106          	cp	a,#6
7004  1ba5 2709          	jreq	L3622
7006  1ba7 9e            	ld	a,xh
7007  1ba8 a104          	cp	a,#4
7008  1baa 2704          	jreq	L3622
7011  1bac a613          	ld	a,#19
7013  1bae 2009          	jra	L025
7014  1bb0               L3622:
7015                     ; 1943 	if(SystemMode != exDiagSession)return NCR7f;
7017  1bb0 c60052        	ld	a,_SystemMode
7018  1bb3 a103          	cp	a,#3
7019  1bb5 2705          	jreq	L5622
7022  1bb7 a67f          	ld	a,#127
7024  1bb9               L025:
7026  1bb9 5b03          	addw	sp,#3
7027  1bbb 87            	retf	
7028  1bbc               L5622:
7029                     ; 1944 	if((d1 == salfe01)||(d1 == salfe02)||(d1 == salfe11)||(d1 == salfe12))
7031  1bbc 7b07          	ld	a,(OFST+6,sp)
7032  1bbe a101          	cp	a,#1
7033  1bc0 270c          	jreq	L1722
7035  1bc2 a102          	cp	a,#2
7036  1bc4 2708          	jreq	L1722
7038  1bc6 a111          	cp	a,#17
7039  1bc8 2704          	jreq	L1722
7041  1bca a112          	cp	a,#18
7042  1bcc 2617          	jrne	L7622
7043  1bce               L1722:
7044                     ; 1946 	       if(keyerror2 > 3)
7046  1bce c6005c        	ld	a,_keyerror2
7047  1bd1 a104          	cp	a,#4
7048  1bd3 2504          	jrult	L7722
7049                     ; 1948 	                            Errorvalue = NCR36;
7051                     ; 1949 					return Errorvalue;
7053  1bd5 a636          	ld	a,#54
7055  1bd7 20e0          	jra	L025
7056  1bd9               L7722:
7057                     ; 1951 		if(keyerrorclosetime > 3) 
7059  1bd9 ce005a        	ldw	x,_keyerrorclosetime
7060  1bdc a30004        	cpw	x,#4
7061  1bdf 2508          	jrult	L3032
7062                     ; 1953 			Errorvalue = NCR37;
7064                     ; 1954 			return Errorvalue;
7066  1be1 a637          	ld	a,#55
7068  1be3 20d4          	jra	L025
7069  1be5               L7622:
7070                     ; 1959 		return NCR12;
7072  1be5 a612          	ld	a,#18
7074  1be7 20d0          	jra	L025
7075  1be9               L3032:
7076                     ; 1962     switch(d1)
7078  1be9 7b07          	ld	a,(OFST+6,sp)
7080                     ; 2056 		}break;
7081  1beb 4a            	dec	a
7082  1bec 2716          	jreq	L3122
7083  1bee 4a            	dec	a
7084  1bef 274d          	jreq	L5122
7085  1bf1 a00f          	sub	a,#15
7086  1bf3 2604acd01cd0  	jreq	L7122
7087  1bf9 4a            	dec	a
7088  1bfa 2604ac1b1d1b  	jreq	L1222
7089                     ; 2055 			Errorvalue = NCR12;
7090                     ; 2056 		}break;
7092  1c00 ac981d98      	jpf	L3222
7093  1c04               L3122:
7094                     ; 1966 			if(pci != 0x02) return NCR13; //add diag error long
7096  1c04 7b02          	ld	a,(OFST+1,sp)
7097  1c06 a102          	cp	a,#2
7098  1c08 2704          	jreq	L1132
7101  1c0a a613          	ld	a,#19
7103  1c0c 20ab          	jra	L025
7104  1c0e               L1132:
7105                     ; 1967 			BCMsjs(sjs);	
7107  1c0e ce0286        	ldw	x,_sjs
7108  1c11 8da21da2      	callf	f_BCMsjs
7110                     ; 1969 			LevelOneKeyArith(BCMvseed,BCMkey);
7112  1c15 ae023c        	ldw	x,#_BCMkey
7113  1c18 89            	pushw	x
7114  1c19 ae0240        	ldw	x,#_BCMvseed
7115  1c1c 8d391f39      	callf	f_LevelOneKeyArith
7117  1c20 35010009      	mov	L1122_code,#1
7118  1c24 85            	popw	x
7119                     ; 1970 			code = 1;
7121                     ; 1971 			UDSsendone(0x06,SID27+0x40,salfe01,BCMvseed[0],BCMvseed[1],BCMvseed[2],BCMvseed[3],0);
7123  1c25 4b00          	push	#0
7124  1c27 3b0243        	push	_BCMvseed+3
7125  1c2a 3b0242        	push	_BCMvseed+2
7126  1c2d 3b0241        	push	_BCMvseed+1
7127  1c30 3b0240        	push	_BCMvseed
7128  1c33 4b01          	push	#1
7129  1c35 ae0067        	ldw	x,#103
7130  1c38 a606          	ld	a,#6
7132                     ; 1972 		}break;
7134  1c3a ac101d10      	jpf	LC034
7135  1c3e               L5122:
7136                     ; 1975 			if(pci != 0x06) return NCR13; //add diag error long
7138  1c3e 7b02          	ld	a,(OFST+1,sp)
7139  1c40 a106          	cp	a,#6
7140  1c42 2706          	jreq	L3132
7143  1c44 a613          	ld	a,#19
7145  1c46 acb91bb9      	jra	L025
7146  1c4a               L3132:
7147                     ; 1976 			if(keyerrorclosetime != 0) return NCR36;
7149  1c4a ce005a        	ldw	x,_keyerrorclosetime
7150  1c4d 2706          	jreq	L5132
7153  1c4f a636          	ld	a,#54
7155  1c51 acb91bb9      	jra	L025
7156  1c55               L5132:
7157                     ; 1977 			if(code != 1) return NCR24;
7159  1c55 c60009        	ld	a,L1122_code
7160  1c58 4a            	dec	a
7161  1c59 2706          	jreq	L7132
7164  1c5b a624          	ld	a,#36
7166  1c5d acb91bb9      	jra	L025
7167  1c61               L7132:
7168                     ; 1978 			code = 0;
7170  1c61 c70009        	ld	L1122_code,a
7171                     ; 1979 			if((BCMkey[0] == d2)&&(BCMkey[1] == d3)&&(BCMkey[2] == d4)&&(BCMkey[3] == d5))
7173  1c64 c6023c        	ld	a,_BCMkey
7174  1c67 1108          	cp	a,(OFST+7,sp)
7175  1c69 2639          	jrne	L1232
7177  1c6b c6023d        	ld	a,_BCMkey+1
7178  1c6e 1109          	cp	a,(OFST+8,sp)
7179  1c70 2632          	jrne	L1232
7181  1c72 c6023e        	ld	a,_BCMkey+2
7182  1c75 110a          	cp	a,(OFST+9,sp)
7183  1c77 262b          	jrne	L1232
7185  1c79 c6023f        	ld	a,_BCMkey+3
7186  1c7c 110b          	cp	a,(OFST+10,sp)
7187  1c7e 2624          	jrne	L1232
7188                     ; 1981 				SalfeMode = Salfe1;
7190  1c80 35010051      	mov	_SalfeMode,#1
7191                     ; 1982 				keyerror1 = 0;
7193  1c84 725f005d      	clr	_keyerror1
7194                     ; 1983 				Errorvalue = 0;
7196  1c88 0f01          	clr	(OFST+0,sp)
7197                     ; 1984 				UDSsendone(0x02,SID27+0x40,salfe02,0,0,0,0,0);
7199  1c8a 4b00          	push	#0
7200  1c8c 4b00          	push	#0
7201  1c8e 4b00          	push	#0
7202  1c90 4b00          	push	#0
7203  1c92 4b00          	push	#0
7204  1c94 4b02          	push	#2
7205  1c96 ae0067        	ldw	x,#103
7206  1c99 a602          	ld	a,#2
7207  1c9b 95            	ld	xh,a
7208  1c9c 8d110c11      	callf	f_UDSsendone
7210  1ca0 5b06          	addw	sp,#6
7212  1ca2 2013          	jra	L3232
7213  1ca4               L1232:
7214                     ; 1988 				Errorvalue = NCR35;
7216  1ca4 a635          	ld	a,#53
7217  1ca6 6b01          	ld	(OFST+0,sp),a
7218                     ; 1989 				SalfeMode = Salfe0;
7220  1ca8 725f0051      	clr	_SalfeMode
7221                     ; 1990 				if(keyerror1 < 5)keyerror1++;
7223  1cac c6005d        	ld	a,_keyerror1
7224  1caf a105          	cp	a,#5
7225  1cb1 2404          	jruge	L3232
7228  1cb3 725c005d      	inc	_keyerror1
7229  1cb7               L3232:
7230                     ; 1992 			if(keyerror1 > 3)
7232  1cb7 c6005d        	ld	a,_keyerror1
7233  1cba a104          	cp	a,#4
7234  1cbc 2404ac9c1d9c  	jrult	L7032
7235                     ; 1994                             Errorvalue = NCR36;
7237  1cc2 a636          	ld	a,#54
7238  1cc4 6b01          	ld	(OFST+0,sp),a
7239                     ; 1995 				keyerrorclosetime = DTC10000MS;
7241  1cc6 ae04e2        	ldw	x,#1250
7242  1cc9 cf005a        	ldw	_keyerrorclosetime,x
7243  1ccc ac9c1d9c      	jra	L7032
7244  1cd0               L7122:
7245                     ; 2000 			if(pci != 0x02) return NCR13; //add diag error long
7247  1cd0 7b02          	ld	a,(OFST+1,sp)
7248  1cd2 a102          	cp	a,#2
7249  1cd4 2706          	jreq	L1332
7252  1cd6 a613          	ld	a,#19
7254  1cd8 acb91bb9      	jra	L025
7255  1cdc               L1332:
7256                     ; 2001 			if(SalfeMode < Salfe1) return NCR24;
7258  1cdc c60051        	ld	a,_SalfeMode
7259  1cdf 2606          	jrne	L3332
7262  1ce1 a624          	ld	a,#36
7264  1ce3 acb91bb9      	jra	L025
7265  1ce7               L3332:
7266                     ; 2003 			Errorvalue = 0;
7268  1ce7 0f01          	clr	(OFST+0,sp)
7269                     ; 2004 			if((DIDF1f2EEPROM[0] ==0x00)&&(DIDF1f2EEPROM[1] ==0x00))
7271  1ce9 c64108        	ld	a,_DIDF1f2EEPROM
7272  1cec 260b          	jrne	L5332
7274  1cee c64109        	ld	a,_DIDF1f2EEPROM+1
7275  1cf1 2606          	jrne	L5332
7276                     ; 2006 				SalfeMode = Salfe2;
7278  1cf3 35020051      	mov	_SalfeMode,#2
7280  1cf7 2004          	jra	L7332
7281  1cf9               L5332:
7282                     ; 2010 				code = 2;
7284  1cf9 35020009      	mov	L1122_code,#2
7285  1cfd               L7332:
7286                     ; 2014 			UDSsendone(0x05,SID27+0x40,salfe11,DIDF1f2EEPROM[0],DIDF1f2EEPROM[1],0,0,0);
7288  1cfd 4b00          	push	#0
7289  1cff 4b00          	push	#0
7290  1d01 4b00          	push	#0
7291  1d03 3b4109        	push	_DIDF1f2EEPROM+1
7292  1d06 3b4108        	push	_DIDF1f2EEPROM
7293  1d09 4b11          	push	#17
7294  1d0b ae0067        	ldw	x,#103
7295  1d0e a605          	ld	a,#5
7297  1d10               LC034:
7298  1d10 95            	ld	xh,a
7299  1d11 8d110c11      	callf	f_UDSsendone
7300  1d15 5b06          	addw	sp,#6
7301                     ; 2015 		}break;
7303  1d17 ac9c1d9c      	jra	L7032
7304  1d1b               L1222:
7305                     ; 2018 			if(pci != 0x04) return NCR13; //add diag error long
7307  1d1b 7b02          	ld	a,(OFST+1,sp)
7308  1d1d a104          	cp	a,#4
7309  1d1f 2706          	jreq	L1432
7312  1d21 a613          	ld	a,#19
7314  1d23 acb91bb9      	jra	L025
7315  1d27               L1432:
7316                     ; 2021 			if(keyerrorclosetime != 0 )return NCR37;
7318  1d27 ce005a        	ldw	x,_keyerrorclosetime
7319  1d2a 2706          	jreq	L3432
7322  1d2c a637          	ld	a,#55
7324  1d2e acb91bb9      	jra	L025
7325  1d32               L3432:
7326                     ; 2022 			code = 0;
7328  1d32 725f0009      	clr	L1122_code
7329                     ; 2023 			if(SalfeMode < Salfe1) return NCR24;
7331  1d36 c60051        	ld	a,_SalfeMode
7332  1d39 2606          	jrne	L5432
7335  1d3b a624          	ld	a,#36
7337  1d3d acb91bb9      	jra	L025
7338  1d41               L5432:
7339                     ; 2024             if((DIDF1f3EEPROM[0]==d2)&&(DIDF1f3EEPROM[1]==d3))
7341  1d41 c6410a        	ld	a,_DIDF1f3EEPROM
7342  1d44 1108          	cp	a,(OFST+7,sp)
7343  1d46 262a          	jrne	L7432
7345  1d48 c6410b        	ld	a,_DIDF1f3EEPROM+1
7346  1d4b 1109          	cp	a,(OFST+8,sp)
7347  1d4d 2623          	jrne	L7432
7348                     ; 2026                 Errorvalue = 0;
7350  1d4f 0f01          	clr	(OFST+0,sp)
7351                     ; 2027 				SalfeMode = Salfe2;
7353  1d51 a602          	ld	a,#2
7354  1d53 c70051        	ld	_SalfeMode,a
7355                     ; 2028 				keyerror2 = 0;
7357  1d56 725f005c      	clr	_keyerror2
7358                     ; 2029 				UDSsendone(0x02,SID27+0x40,salfe12,0,0,0,0,0);
7360  1d5a 4b00          	push	#0
7361  1d5c 4b00          	push	#0
7362  1d5e 4b00          	push	#0
7363  1d60 4b00          	push	#0
7364  1d62 4b00          	push	#0
7365  1d64 4b12          	push	#18
7366  1d66 ae0067        	ldw	x,#103
7367  1d69 95            	ld	xh,a
7368  1d6a 8d110c11      	callf	f_UDSsendone
7370  1d6e 5b06          	addw	sp,#6
7372  1d70 2013          	jra	L1532
7373  1d72               L7432:
7374                     ; 2033 				Errorvalue = NCR35;
7376  1d72 a635          	ld	a,#53
7377  1d74 6b01          	ld	(OFST+0,sp),a
7378                     ; 2034 				SalfeMode = Salfe1;
7380  1d76 35010051      	mov	_SalfeMode,#1
7381                     ; 2035 				if(keyerror2 < 5) keyerror2++;
7383  1d7a c6005c        	ld	a,_keyerror2
7384  1d7d a105          	cp	a,#5
7385  1d7f 2404          	jruge	L1532
7388  1d81 725c005c      	inc	_keyerror2
7389  1d85               L1532:
7390                     ; 2038             if(keyerror2 > 3)
7392  1d85 c6005c        	ld	a,_keyerror2
7393  1d88 a104          	cp	a,#4
7394  1d8a 2510          	jrult	L7032
7395                     ; 2040                             Errorvalue = NCR36;
7397  1d8c a636          	ld	a,#54
7398  1d8e 6b01          	ld	(OFST+0,sp),a
7399                     ; 2041 				keyerrorclosetime = DTC10000MS;
7401  1d90 ae04e2        	ldw	x,#1250
7402  1d93 cf005a        	ldw	_keyerrorclosetime,x
7403  1d96 2004          	jra	L7032
7404  1d98               L3222:
7405                     ; 2047 			Errorvalue = NCR12;
7406                     ; 2048 		}break;
7408                     ; 2051 			Errorvalue = NCR12;
7412  1d98 a612          	ld	a,#18
7413  1d9a 6b01          	ld	(OFST+0,sp),a
7414                     ; 2052 		}break;
7416  1d9c               L7032:
7417                     ; 2061  	return Errorvalue;
7419  1d9c 7b01          	ld	a,(OFST+0,sp)
7421  1d9e acb91bb9      	jra	L025
7423                     	switch	.data
7424  000a               L7532_sjscnt:
7425  000a 55            	dc.b	85
7463                     ; 2064 void BCMsjs(unsigned int sjs)
7463                     ; 2065 {
7464                     	switch	.text
7465  1da2               f_BCMsjs:
7467  1da2 89            	pushw	x
7468  1da3 88            	push	a
7469       00000001      OFST:	set	1
7472                     ; 2067 	sjscnt++;
7474  1da4 725c000a      	inc	L7532_sjscnt
7475                     ; 2068        BCMvseed[0] = (unsigned char)sjs+sjscnt;
7477  1da8 9f            	ld	a,xl
7478  1da9 cb000a        	add	a,L7532_sjscnt
7479  1dac c70240        	ld	_BCMvseed,a
7480                     ; 2069 	BCMvseed[1] = (unsigned char)(sjs>>2)^BCMvseed[0]-sjscnt;
7482  1daf c0000a        	sub	a,L7532_sjscnt
7483  1db2 6b01          	ld	(OFST+0,sp),a
7484  1db4 1e02          	ldw	x,(OFST+1,sp)
7485  1db6 54            	srlw	x
7486  1db7 54            	srlw	x
7487  1db8 9f            	ld	a,xl
7488  1db9 1801          	xor	a,(OFST+0,sp)
7489  1dbb c70241        	ld	_BCMvseed+1,a
7490                     ; 2070 	BCMvseed[2] = (unsigned char)(sjs>>3)+BCMvseed[1]+sjscnt;
7492  1dbe 1e02          	ldw	x,(OFST+1,sp)
7493  1dc0 54            	srlw	x
7494  1dc1 54            	srlw	x
7495  1dc2 54            	srlw	x
7496  1dc3 9f            	ld	a,xl
7497  1dc4 cb0241        	add	a,_BCMvseed+1
7498  1dc7 cb000a        	add	a,L7532_sjscnt
7499  1dca c70242        	ld	_BCMvseed+2,a
7500                     ; 2071 	BCMvseed[3] = (unsigned char)(sjs>>4)^BCMvseed[2]-sjscnt;
7502  1dcd c0000a        	sub	a,L7532_sjscnt
7503  1dd0 6b01          	ld	(OFST+0,sp),a
7504  1dd2 1e02          	ldw	x,(OFST+1,sp)
7505  1dd4 54            	srlw	x
7506  1dd5 54            	srlw	x
7507  1dd6 54            	srlw	x
7508  1dd7 54            	srlw	x
7509  1dd8 9f            	ld	a,xl
7510  1dd9 1801          	xor	a,(OFST+0,sp)
7511  1ddb c70243        	ld	_BCMvseed+3,a
7512                     ; 2080 }
7515  1dde 5b03          	addw	sp,#3
7516  1de0 87            	retf	
7539                     ; 2085 void DTCinit(void)
7539                     ; 2086 {
7540                     	switch	.text
7541  1de1               f_DTCinit:
7545                     ; 2087    DTCNameN[DTC9001].DTCH =0x90;
7547  1de1 35900066      	mov	_DTCNameN,#144
7548                     ; 2088    DTCNameN[DTC9001].DTCL =0x01;
7550  1de5 35010067      	mov	_DTCNameN+1,#1
7551                     ; 2089    DTCNameN[DTC9001].DTCS =0x1e;
7553  1de9 351e0068      	mov	_DTCNameN+2,#30
7554                     ; 2091    DTCNameN[DTC9003].DTCH =0x90;
7556  1ded 35900069      	mov	_DTCNameN+3,#144
7557                     ; 2092    DTCNameN[DTC9003].DTCL =0x03;
7559  1df1 3503006a      	mov	_DTCNameN+4,#3
7560                     ; 2093    DTCNameN[DTC9003].DTCS =0x1e;
7562  1df5 351e006b      	mov	_DTCNameN+5,#30
7563                     ; 2095    DTCNameN[DTC9015].DTCH =0x90;
7565  1df9 3590006c      	mov	_DTCNameN+6,#144
7566                     ; 2096    DTCNameN[DTC9015].DTCL =0x15;
7568  1dfd 3515006d      	mov	_DTCNameN+7,#21
7569                     ; 2097    DTCNameN[DTC9015].DTCS =0x17;
7571  1e01 3517006e      	mov	_DTCNameN+8,#23
7572                     ; 2099    DTCNameN[DTC9111].DTCH =0x91;
7574  1e05 3591006f      	mov	_DTCNameN+9,#145
7575                     ; 2100    DTCNameN[DTC9111].DTCL =0x11;
7577  1e09 35110070      	mov	_DTCNameN+10,#17
7578                     ; 2101    DTCNameN[DTC9111].DTCS =0x16;
7580  1e0d 35160071      	mov	_DTCNameN+11,#22
7581                     ; 2103    DTCNameN[DTC9091].DTCH =0x90;
7583  1e11 35900072      	mov	_DTCNameN+12,#144
7584                     ; 2104    DTCNameN[DTC9091].DTCL =0x91;
7586  1e15 35910073      	mov	_DTCNameN+13,#145
7587                     ; 2105    DTCNameN[DTC9091].DTCS =0x15;
7589  1e19 35150074      	mov	_DTCNameN+14,#21
7590                     ; 2107    DTCNameN[DTC9083].DTCH =0x90;
7592  1e1d 35900075      	mov	_DTCNameN+15,#144
7593                     ; 2108    DTCNameN[DTC9083].DTCL =0x83;
7595  1e21 35830076      	mov	_DTCNameN+16,#131
7596                     ; 2109    DTCNameN[DTC9083].DTCS =0x15;
7598  1e25 35150077      	mov	_DTCNameN+17,#21
7599                     ; 2111    DTCNameN[DTC9011].DTCH =0x90;
7601  1e29 35900078      	mov	_DTCNameN+18,#144
7602                     ; 2112    DTCNameN[DTC9011].DTCL =0x11;
7604  1e2d 35110079      	mov	_DTCNameN+19,#17
7605                     ; 2113    DTCNameN[DTC9011].DTCS =0x15;
7607  1e31 3515007a      	mov	_DTCNameN+20,#21
7608                     ; 2115    DTCNameN[DTC9023].DTCH =0x90;
7610  1e35 3590007b      	mov	_DTCNameN+21,#144
7611                     ; 2116    DTCNameN[DTC9023].DTCL =0x23;
7613  1e39 3523007c      	mov	_DTCNameN+22,#35
7614                     ; 2117    DTCNameN[DTC9023].DTCS =0x15;
7616  1e3d 3515007d      	mov	_DTCNameN+23,#21
7617                     ; 2119    DTCNameN[DTC9007].DTCH =0x90;
7619  1e41 3590007e      	mov	_DTCNameN+24,#144
7620                     ; 2120    DTCNameN[DTC9007].DTCL =0x07;
7622  1e45 3507007f      	mov	_DTCNameN+25,#7
7623                     ; 2121    DTCNameN[DTC9007].DTCS =0x15;
7625  1e49 35150080      	mov	_DTCNameN+26,#21
7626                     ; 2123    DTCNameN[DTC9043].DTCH =0x90;
7628  1e4d 35900081      	mov	_DTCNameN+27,#144
7629                     ; 2124    DTCNameN[DTC9043].DTCL =0x43;
7631  1e51 35430082      	mov	_DTCNameN+28,#67
7632                     ; 2125    DTCNameN[DTC9043].DTCS =0x14;
7634  1e55 35140083      	mov	_DTCNameN+29,#20
7635                     ; 2127    DTCNameN[DTC9093].DTCH =0x90;
7637  1e59 35900084      	mov	_DTCNameN+30,#144
7638                     ; 2128    DTCNameN[DTC9093].DTCL =0x93;
7640  1e5d 35930085      	mov	_DTCNameN+31,#147
7641                     ; 2129    DTCNameN[DTC9093].DTCS =0x14;
7643  1e61 35140086      	mov	_DTCNameN+32,#20
7644                     ; 2131    DTCNameN[DTC9061].DTCH =0x90;
7646  1e65 35900087      	mov	_DTCNameN+33,#144
7647                     ; 2132    DTCNameN[DTC9061].DTCL =0x61;
7649  1e69 35610088      	mov	_DTCNameN+34,#97
7650                     ; 2133    DTCNameN[DTC9061].DTCS =0x15;
7652  1e6d 35150089      	mov	_DTCNameN+35,#21
7653                     ; 2135    DTCNameN[DTC9067].DTCH =0x90;
7655  1e71 3590008a      	mov	_DTCNameN+36,#144
7656                     ; 2136    DTCNameN[DTC9067].DTCL =0x67;
7658  1e75 3567008b      	mov	_DTCNameN+37,#103
7659                     ; 2137    DTCNameN[DTC9067].DTCS =0x1e;
7661  1e79 351e008c      	mov	_DTCNameN+38,#30
7662                     ; 2139    DTCNameN[DTC9045].DTCH =0x90;
7664  1e7d 3590008d      	mov	_DTCNameN+39,#144
7665                     ; 2140    DTCNameN[DTC9045].DTCL =0x45;
7667  1e81 3545008e      	mov	_DTCNameN+40,#69
7668                     ; 2141    DTCNameN[DTC9045].DTCS =0x14;
7670  1e85 3514008f      	mov	_DTCNameN+41,#20
7671                     ; 2143    DTCNameN[DTC9073].DTCH =0x90;
7673  1e89 35900090      	mov	_DTCNameN+42,#144
7674                     ; 2144    DTCNameN[DTC9073].DTCL =0x73;
7676  1e8d 35730091      	mov	_DTCNameN+43,#115
7677                     ; 2145    DTCNameN[DTC9073].DTCS =0x1c;
7679  1e91 351c0092      	mov	_DTCNameN+44,#28
7680                     ; 2147    DTCNameN[DTC900C].DTCH =0x90;
7682  1e95 35900093      	mov	_DTCNameN+45,#144
7683                     ; 2148    DTCNameN[DTC900C].DTCL =0x0c;
7685  1e99 350c0094      	mov	_DTCNameN+46,#12
7686                     ; 2149    DTCNameN[DTC900C].DTCS =0x1c;
7688  1e9d 351c0095      	mov	_DTCNameN+47,#28
7689                     ; 2151    DTCNameN[DTCD001].DTCH =0xd0;
7691  1ea1 35d00096      	mov	_DTCNameN+48,#208
7692                     ; 2152    DTCNameN[DTCD001].DTCL =0x01;
7694  1ea5 35010097      	mov	_DTCNameN+49,#1
7695                     ; 2153    DTCNameN[DTCD001].DTCS =0x08;
7697  1ea9 35080098      	mov	_DTCNameN+50,#8
7698                     ; 2155    DTCNameN[DTCD002].DTCH =0xd0;
7700  1ead 35d00099      	mov	_DTCNameN+51,#208
7701                     ; 2156    DTCNameN[DTCD002].DTCL =0x02;
7703  1eb1 3502009a      	mov	_DTCNameN+52,#2
7704                     ; 2157    DTCNameN[DTCD002].DTCS =0x08;
7706  1eb5 3508009b      	mov	_DTCNameN+53,#8
7707                     ; 2159    DTCNameN[DTCD003].DTCH =0xd0;
7709  1eb9 35d0009c      	mov	_DTCNameN+54,#208
7710                     ; 2160    DTCNameN[DTCD003].DTCL =0x03;
7712  1ebd 3503009d      	mov	_DTCNameN+55,#3
7713                     ; 2161    DTCNameN[DTCD003].DTCS =0x08;
7715  1ec1 3508009e      	mov	_DTCNameN+56,#8
7716                     ; 2163    DTCNameN[DTCD004].DTCH =0xd0;
7718  1ec5 35d0009f      	mov	_DTCNameN+57,#208
7719                     ; 2164    DTCNameN[DTCD004].DTCL =0x04;
7721  1ec9 350400a0      	mov	_DTCNameN+58,#4
7722                     ; 2165    DTCNameN[DTCD004].DTCS =0x08;
7724  1ecd 350800a1      	mov	_DTCNameN+59,#8
7725                     ; 2167    DTCNameN[DTCD005].DTCH =0xd0;
7727  1ed1 35d000a2      	mov	_DTCNameN+60,#208
7728                     ; 2168    DTCNameN[DTCD005].DTCL =0x05;
7730  1ed5 350500a3      	mov	_DTCNameN+61,#5
7731                     ; 2169    DTCNameN[DTCD005].DTCS =0x08;
7733  1ed9 350800a4      	mov	_DTCNameN+62,#8
7734                     ; 2171 }
7737  1edd 87            	retf	
7792                     ; 2173 unsigned char Weeprom(unsigned long temp,unsigned char value)
7792                     ; 2174 {    
7793                     	switch	.text
7794  1ede               f_Weeprom:
7796  1ede 5204          	subw	sp,#4
7797       00000004      OFST:	set	4
7800                     ; 2180 	pFlash = (@far u8 *) temp;
7802  1ee0 7b09          	ld	a,(OFST+5,sp)
7803  1ee2 6b02          	ld	(OFST-2,sp),a
7804  1ee4 7b0a          	ld	a,(OFST+6,sp)
7805  1ee6 6b03          	ld	(OFST-1,sp),a
7806  1ee8 7b0b          	ld	a,(OFST+7,sp)
7807  1eea 6b04          	ld	(OFST+0,sp),a
7808                     ; 2181 	for(cnt = 0 ; cnt < 10; cnt++)
7810  1eec 0f01          	clr	(OFST-3,sp)
7811  1eee               L3342:
7812                     ; 2183 		*pFlash = value;
7814  1eee 7b0c          	ld	a,(OFST+8,sp)
7815  1ef0 88            	push	a
7816  1ef1 7b03          	ld	a,(OFST-1,sp)
7817  1ef3 b700          	ld	c_x,a
7818  1ef5 1e04          	ldw	x,(OFST+0,sp)
7819  1ef7 bf01          	ldw	c_x+1,x
7820  1ef9 84            	pop	a
7821  1efa 92bd0000      	ldf	[c_x.e],a
7822                     ; 2184 		if(*pFlash == value) break;
7824  1efe 7b02          	ld	a,(OFST-2,sp)
7825  1f00 b700          	ld	c_x,a
7826  1f02 1e03          	ldw	x,(OFST-1,sp)
7827  1f04 bf01          	ldw	c_x+1,x
7828  1f06 92bc0000      	ldf	a,[c_x.e]
7829  1f0a 110c          	cp	a,(OFST+8,sp)
7830  1f0c 2708          	jreq	L7342
7833                     ; 2181 	for(cnt = 0 ; cnt < 10; cnt++)
7835  1f0e 0c01          	inc	(OFST-3,sp)
7838  1f10 7b01          	ld	a,(OFST-3,sp)
7839  1f12 a10a          	cp	a,#10
7840  1f14 25d8          	jrult	L3342
7841  1f16               L7342:
7842                     ; 2187     if(*pFlash == value) return 0;
7844  1f16 7b02          	ld	a,(OFST-2,sp)
7845  1f18 b700          	ld	c_x,a
7846  1f1a bf01          	ldw	c_x+1,x
7847  1f1c 92bc0000      	ldf	a,[c_x.e]
7848  1f20 110c          	cp	a,(OFST+8,sp)
7849  1f22 2603          	jrne	L3442
7852  1f24 4f            	clr	a
7854  1f25 2002          	jra	L035
7855  1f27               L3442:
7856                     ; 2188 	else return 1;
7858  1f27 a601          	ld	a,#1
7860  1f29               L035:
7862  1f29 5b04          	addw	sp,#4
7863  1f2b 87            	retf	
7888                     ; 2213 void leveonekeytest(void)
7888                     ; 2214 {
7889                     	switch	.text
7890  1f2c               f_leveonekeytest:
7894                     ; 2215 	LevelOneKeyArith(BCMvseed,BCMkey);
7896  1f2c ae023c        	ldw	x,#_BCMkey
7897  1f2f 89            	pushw	x
7898  1f30 ae0240        	ldw	x,#_BCMvseed
7899  1f33 8d391f39      	callf	f_LevelOneKeyArith
7901  1f37 85            	popw	x
7902                     ; 2216 }
7905  1f38 87            	retf	
7907                     .const:	section	.text
7908  0000               L7542_vKey2:
7909  0000 00            	dc.b	0
7910  0001 00            	dc.b	0
7911  0002 00            	dc.b	0
7912  0003 00            	dc.b	0
8025                     ; 2220 unsigned char  LevelOneKeyArith(const u8 *vseed,u8 *GetLevelOnekey)
8025                     ; 2221 {
8026                     	switch	.text
8027  1f39               f_LevelOneKeyArith:
8029  1f39 89            	pushw	x
8030  1f3a 5219          	subw	sp,#25
8031       00000019      OFST:	set	25
8034                     ; 2222 	u8 vKey1[NUM_LEVEL_ONE_KEY],vKey2[NUM_LEVEL_ONE_KEY] = {0,0,0,0};
8036  1f3c 96            	ldw	x,sp
8037  1f3d 1c0014        	addw	x,#OFST-5
8038  1f40 90ae0000      	ldw	y,#L7542_vKey2
8039  1f44 a604          	ld	a,#4
8040  1f46 8d000000      	callf	d_xymvx
8042                     ; 2224 	u32 tempkey = 0; 
8044  1f4a 5f            	clrw	x
8045  1f4b 1f10          	ldw	(OFST-9,sp),x
8046  1f4d 1f0e          	ldw	(OFST-11,sp),x
8047                     ; 2225 	unsigned char  vResult = FALSE3;
8049                     ; 2227     AppKeyConst[0] = 0x7f;
8051  1f4f 357f0238      	mov	_AppKeyConst,#127
8052                     ; 2228 	AppKeyConst[1] = 0xe4;
8054  1f53 35e40239      	mov	_AppKeyConst+1,#228
8055                     ; 2229 	AppKeyConst[2] = 0x75;
8057  1f57 3575023a      	mov	_AppKeyConst+2,#117
8058                     ; 2230 	AppKeyConst[3] = 0x16;
8060  1f5b 3516023b      	mov	_AppKeyConst+3,#22
8061                     ; 2235 		for(i = NUM_LEVEL_ONE_SEED;i > 0;i--)
8063  1f5f a604          	ld	a,#4
8064  1f61 6b19          	ld	(OFST+0,sp),a
8065  1f63               L1352:
8066                     ; 2237 			vKey1[i - 1] = (u8)(vseed[i - 1] ^ AppKeyConst[i - 1]);
8068  1f63 96            	ldw	x,sp
8069  1f64 1c000a        	addw	x,#OFST-15
8070  1f67 1f07          	ldw	(OFST-18,sp),x
8071  1f69 5f            	clrw	x
8072  1f6a 97            	ld	xl,a
8073  1f6b 5a            	decw	x
8074  1f6c 72fb07        	addw	x,(OFST-18,sp)
8075  1f6f 905f          	clrw	y
8076  1f71 9097          	ld	yl,a
8077  1f73 905a          	decw	y
8078  1f75 72f91a        	addw	y,(OFST+1,sp)
8079  1f78 9089          	pushw	y
8080  1f7a 7b1b          	ld	a,(OFST+2,sp)
8081  1f7c 905f          	clrw	y
8082  1f7e 9097          	ld	yl,a
8083  1f80 905a          	decw	y
8084  1f82 90d60238      	ld	a,(_AppKeyConst,y)
8085  1f86 9085          	popw	y
8086  1f88 90f8          	xor	a,(y)
8087  1f8a f7            	ld	(x),a
8088                     ; 2239 			vRshift = 0x80;
8090  1f8b a680          	ld	a,#128
8091  1f8d 6b12          	ld	(OFST-7,sp),a
8092                     ; 2240 			vLshift = 0x01;
8094  1f8f a601          	ld	a,#1
8095  1f91 6b13          	ld	(OFST-6,sp),a
8096                     ; 2241 			for(j = 0;j < 8;j++)
8098  1f93 0f18          	clr	(OFST-1,sp)
8099  1f95               L7352:
8100                     ; 2243 				if(vseed[NUM_LEVEL_ONE_SEED - i] & vRshift)
8102  1f95 4f            	clr	a
8103  1f96 97            	ld	xl,a
8104  1f97 a604          	ld	a,#4
8105  1f99 1019          	sub	a,(OFST+0,sp)
8106  1f9b 2401          	jrnc	L045
8107  1f9d 5a            	decw	x
8108  1f9e               L045:
8109  1f9e 02            	rlwa	x,a
8110  1f9f 72fb1a        	addw	x,(OFST+1,sp)
8111  1fa2 f6            	ld	a,(x)
8112  1fa3 1512          	bcp	a,(OFST-7,sp)
8113  1fa5 2712          	jreq	L5452
8114                     ; 2245 					vKey2[i - 1] |= vLshift;
8116  1fa7 96            	ldw	x,sp
8117  1fa8 1c0014        	addw	x,#OFST-5
8118  1fab 1f07          	ldw	(OFST-18,sp),x
8119  1fad 7b19          	ld	a,(OFST+0,sp)
8120  1faf 5f            	clrw	x
8121  1fb0 97            	ld	xl,a
8122  1fb1 5a            	decw	x
8123  1fb2 72fb07        	addw	x,(OFST-18,sp)
8124  1fb5 f6            	ld	a,(x)
8125  1fb6 1a13          	or	a,(OFST-6,sp)
8126  1fb8 f7            	ld	(x),a
8127  1fb9               L5452:
8128                     ; 2247 				vRshift >>= 1;
8130  1fb9 0412          	srl	(OFST-7,sp)
8131                     ; 2248 				vLshift <<= 1;
8133  1fbb 0813          	sll	(OFST-6,sp)
8134                     ; 2241 			for(j = 0;j < 8;j++)
8136  1fbd 0c18          	inc	(OFST-1,sp)
8139  1fbf 7b18          	ld	a,(OFST-1,sp)
8140  1fc1 a108          	cp	a,#8
8141  1fc3 25d0          	jrult	L7352
8142                     ; 2251 			vKey2[i - 1] = (u8)(vKey2[i - 1] ^ AppKeyConst[i - 1]);
8144  1fc5 96            	ldw	x,sp
8145  1fc6 1c0014        	addw	x,#OFST-5
8146  1fc9 1f07          	ldw	(OFST-18,sp),x
8147  1fcb 7b19          	ld	a,(OFST+0,sp)
8148  1fcd 5f            	clrw	x
8149  1fce 97            	ld	xl,a
8150  1fcf 5a            	decw	x
8151  1fd0 72fb07        	addw	x,(OFST-18,sp)
8152  1fd3 905f          	clrw	y
8153  1fd5 9097          	ld	yl,a
8154  1fd7 905a          	decw	y
8155  1fd9 f6            	ld	a,(x)
8156  1fda 90d80238      	xor	a,(_AppKeyConst,y)
8157  1fde f7            	ld	(x),a
8158                     ; 2253 			vshift = (u8)((NUM_LEVEL_ONE_SEED - i) << 3);
8160  1fdf a604          	ld	a,#4
8161  1fe1 1019          	sub	a,(OFST+0,sp)
8162  1fe3 48            	sll	a
8163  1fe4 48            	sll	a
8164  1fe5 48            	sll	a
8165  1fe6 6b18          	ld	(OFST-1,sp),a
8166                     ; 2254 			tempkey += (u32)((u32)((u32)vKey1[i - 1] << (u32)vshift) + (u32)((u32)vKey2[i - 1] << (u32)vshift));
8168  1fe8 96            	ldw	x,sp
8169  1fe9 1c0014        	addw	x,#OFST-5
8170  1fec 1f07          	ldw	(OFST-18,sp),x
8171  1fee 7b19          	ld	a,(OFST+0,sp)
8172  1ff0 5f            	clrw	x
8173  1ff1 97            	ld	xl,a
8174  1ff2 5a            	decw	x
8175  1ff3 72fb07        	addw	x,(OFST-18,sp)
8176  1ff6 f6            	ld	a,(x)
8177  1ff7 b703          	ld	c_lreg+3,a
8178  1ff9 3f02          	clr	c_lreg+2
8179  1ffb 3f01          	clr	c_lreg+1
8180  1ffd 3f00          	clr	c_lreg
8181  1fff 7b18          	ld	a,(OFST-1,sp)
8182  2001 8d000000      	callf	d_llsh
8184  2005 96            	ldw	x,sp
8185  2006 1c0003        	addw	x,#OFST-22
8186  2009 8d000000      	callf	d_rtol
8188  200d 96            	ldw	x,sp
8189  200e 1c000a        	addw	x,#OFST-15
8190  2011 1f01          	ldw	(OFST-24,sp),x
8191  2013 7b19          	ld	a,(OFST+0,sp)
8192  2015 5f            	clrw	x
8193  2016 97            	ld	xl,a
8194  2017 5a            	decw	x
8195  2018 72fb01        	addw	x,(OFST-24,sp)
8196  201b f6            	ld	a,(x)
8197  201c b703          	ld	c_lreg+3,a
8198  201e 3f02          	clr	c_lreg+2
8199  2020 3f01          	clr	c_lreg+1
8200  2022 3f00          	clr	c_lreg
8201  2024 7b18          	ld	a,(OFST-1,sp)
8202  2026 8d000000      	callf	d_llsh
8204  202a 96            	ldw	x,sp
8205  202b 1c0003        	addw	x,#OFST-22
8206  202e 8d000000      	callf	d_ladd
8208  2032 96            	ldw	x,sp
8209  2033 1c000e        	addw	x,#OFST-11
8210  2036 8d000000      	callf	d_lgadd
8212                     ; 2256 			GetLevelOnekey[i - 1] = (u8)(tempkey >> vshift);
8214  203a 7b19          	ld	a,(OFST+0,sp)
8215  203c 5f            	clrw	x
8216  203d 97            	ld	xl,a
8217  203e 5a            	decw	x
8218  203f 72fb1f        	addw	x,(OFST+6,sp)
8219  2042 7b11          	ld	a,(OFST-8,sp)
8220  2044 b703          	ld	c_lreg+3,a
8221  2046 7b10          	ld	a,(OFST-9,sp)
8222  2048 b702          	ld	c_lreg+2,a
8223  204a 7b0f          	ld	a,(OFST-10,sp)
8224  204c b701          	ld	c_lreg+1,a
8225  204e 7b0e          	ld	a,(OFST-11,sp)
8226  2050 b700          	ld	c_lreg,a
8227  2052 7b18          	ld	a,(OFST-1,sp)
8228  2054 8d000000      	callf	d_lursh
8230  2058 b603          	ld	a,c_lreg+3
8231  205a f7            	ld	(x),a
8232                     ; 2235 		for(i = NUM_LEVEL_ONE_SEED;i > 0;i--)
8234  205b 0a19          	dec	(OFST+0,sp)
8237  205d 7b19          	ld	a,(OFST+0,sp)
8238  205f 2704ac631f63  	jrne	L1352
8239                     ; 2259 		vResult = TRUE3; 
8241  2065 7b09          	ld	a,(OFST-16,sp)
8242  2067 97            	ld	xl,a
8243                     ; 2262 	return(vResult);
8245  2068 a601          	ld	a,#1
8248  206a 5b1b          	addw	sp,#27
8249  206c 87            	retf	
8288                     ; 2267 void ClearRPDUbuff(void)
8288                     ; 2268 {  
8289                     	switch	.text
8290  206d               f_ClearRPDUbuff:
8292  206d 89            	pushw	x
8293       00000002      OFST:	set	2
8296                     ; 2270     for(i=0;i<20;i++)
8298  206e 4f            	clr	a
8299  206f 6b01          	ld	(OFST-1,sp),a
8300  2071               L5652:
8301                     ; 2272         R_PDU[i].AI = 0;
8303  2071 97            	ld	xl,a
8304  2072 a60a          	ld	a,#10
8305  2074 42            	mul	x,a
8306  2075 905f          	clrw	y
8307  2077 df00a5        	ldw	(_R_PDU,x),y
8308                     ; 2273 		R_PDU[i].PCI = 0;
8310  207a 724f00a7      	clr	(_R_PDU+2,x)
8311                     ; 2274 		for(j=0;j<7;j++)
8313  207e 0f02          	clr	(OFST+0,sp)
8314  2080               L3752:
8315                     ; 2276 			R_PDU[i].Data[j] = 0;
8317  2080 7b01          	ld	a,(OFST-1,sp)
8318  2082 97            	ld	xl,a
8319  2083 a60a          	ld	a,#10
8320  2085 42            	mul	x,a
8321  2086 01            	rrwa	x,a
8322  2087 1b02          	add	a,(OFST+0,sp)
8323  2089 2401          	jrnc	L445
8324  208b 5c            	incw	x
8325  208c               L445:
8326  208c 02            	rlwa	x,a
8327  208d 724f00a8      	clr	(_R_PDU+3,x)
8328                     ; 2274 		for(j=0;j<7;j++)
8330  2091 0c02          	inc	(OFST+0,sp)
8333  2093 7b02          	ld	a,(OFST+0,sp)
8334  2095 a107          	cp	a,#7
8335  2097 25e7          	jrult	L3752
8336                     ; 2270     for(i=0;i<20;i++)
8338  2099 0c01          	inc	(OFST-1,sp)
8341  209b 7b01          	ld	a,(OFST-1,sp)
8342  209d a114          	cp	a,#20
8343  209f 25d0          	jrult	L5652
8344                     ; 2281 }
8347  20a1 85            	popw	x
8348  20a2 87            	retf	
8387                     ; 2282 void ClearNPDUbuff(void)
8387                     ; 2283 {
8388                     	switch	.text
8389  20a3               f_ClearNPDUbuff:
8391  20a3 89            	pushw	x
8392       00000002      OFST:	set	2
8395                     ; 2285     for(i=0;i<20;i++)
8397  20a4 4f            	clr	a
8398  20a5 6b01          	ld	(OFST-1,sp),a
8399  20a7               L7162:
8400                     ; 2287         N_PDU[i].AI = 0;
8402  20a7 97            	ld	xl,a
8403  20a8 a60a          	ld	a,#10
8404  20aa 42            	mul	x,a
8405  20ab 905f          	clrw	y
8406  20ad df016d        	ldw	(_N_PDU,x),y
8407                     ; 2288 		N_PDU[i].PCI = 0;
8409  20b0 724f016f      	clr	(_N_PDU+2,x)
8410                     ; 2289 		for(j=0;j<7;j++)
8412  20b4 0f02          	clr	(OFST+0,sp)
8413  20b6               L5262:
8414                     ; 2291 			N_PDU[i].Data[j] = 0;
8416  20b6 7b01          	ld	a,(OFST-1,sp)
8417  20b8 97            	ld	xl,a
8418  20b9 a60a          	ld	a,#10
8419  20bb 42            	mul	x,a
8420  20bc 01            	rrwa	x,a
8421  20bd 1b02          	add	a,(OFST+0,sp)
8422  20bf 2401          	jrnc	L055
8423  20c1 5c            	incw	x
8424  20c2               L055:
8425  20c2 02            	rlwa	x,a
8426  20c3 724f0170      	clr	(_N_PDU+3,x)
8427                     ; 2289 		for(j=0;j<7;j++)
8429  20c7 0c02          	inc	(OFST+0,sp)
8432  20c9 7b02          	ld	a,(OFST+0,sp)
8433  20cb a107          	cp	a,#7
8434  20cd 25e7          	jrult	L5262
8435                     ; 2285     for(i=0;i<20;i++)
8437  20cf 0c01          	inc	(OFST-1,sp)
8440  20d1 7b01          	ld	a,(OFST-1,sp)
8441  20d3 a114          	cp	a,#20
8442  20d5 25d0          	jrult	L7162
8443                     ; 2294 }
8446  20d7 85            	popw	x
8447  20d8 87            	retf	
9124                     	xdef	f_leveonekeytest
9125                     	xdef	f_ClearDidvalue
9126                     	switch	.bss
9127  000f               _F1f4savestate:
9128  000f 00            	ds.b	1
9129                     	xdef	_F1f4savestate
9130  0010               _F1f4didsave:
9131  0010 0000          	ds.b	2
9132                     	xdef	_F1f4didsave
9133  0012               _F1f3savestate:
9134  0012 00            	ds.b	1
9135                     	xdef	_F1f3savestate
9136  0013               _F1f3didsave:
9137  0013 0000          	ds.b	2
9138                     	xdef	_F1f3didsave
9139  0015               _F1f2savestate:
9140  0015 00            	ds.b	1
9141                     	xdef	_F1f2savestate
9142  0016               _F1f2didsave:
9143  0016 0000          	ds.b	2
9144                     	xdef	_F1f2didsave
9145  0018               _F19dsavestate:
9146  0018 00            	ds.b	1
9147                     	xdef	_F19dsavestate
9148  0019               _F19ddidsave:
9149  0019 00000000      	ds.b	4
9150                     	xdef	_F19ddidsave
9151  001d               _F18Bsavestate:
9152  001d 00            	ds.b	1
9153                     	xdef	_F18Bsavestate
9154  001e               _F18Bdidsave:
9155  001e 00000000      	ds.b	4
9156                     	xdef	_F18Bdidsave
9157  0022               _F18CSavestate:
9158  0022 00            	ds.b	1
9159                     	xdef	_F18CSavestate
9160  0023               _F18Cdidsave:
9161  0023 000000000000  	ds.b	7
9162                     	xdef	_F18Cdidsave
9163  002a               _F190Savestate:
9164  002a 00            	ds.b	1
9165                     	xdef	_F190Savestate
9166  002b               _F190didsavevin:
9167  002b 000000000000  	ds.b	17
9168                     	xdef	_F190didsavevin
9169  003c               _Didvalue:
9170  003c 000000000000  	ds.b	20
9171                     	xdef	_Didvalue
9172  0050               _KEYleanstate:
9173  0050 00            	ds.b	1
9174                     	xdef	_KEYleanstate
9175  0051               _SalfeMode:
9176  0051 00            	ds.b	1
9177                     	xdef	_SalfeMode
9178  0052               _SystemMode:
9179  0052 00            	ds.b	1
9180                     	xdef	_SystemMode
9181  0053               _S3Server:
9182  0053 0000          	ds.b	2
9183                     	xdef	_S3Server
9184  0055               _P2CAN_Server1:
9185  0055 0000          	ds.b	2
9186                     	xdef	_P2CAN_Server1
9187  0057               _P2CAN_Server:
9188  0057 00            	ds.b	1
9189                     	xdef	_P2CAN_Server
9190  0058               _time3e:
9191  0058 0000          	ds.b	2
9192                     	xdef	_time3e
9193  005a               _keyerrorclosetime:
9194  005a 0000          	ds.b	2
9195                     	xdef	_keyerrorclosetime
9196  005c               _keyerror2:
9197  005c 00            	ds.b	1
9198                     	xdef	_keyerror2
9199  005d               _keyerror1:
9200  005d 00            	ds.b	1
9201                     	xdef	_keyerror1
9202  005e               _N_CR:
9203  005e 00            	ds.b	1
9204                     	xdef	_N_CR
9205  005f               _N_CS:
9206  005f 00            	ds.b	1
9207                     	xdef	_N_CS
9208  0060               _N_Br:
9209  0060 00            	ds.b	1
9210                     	xdef	_N_Br
9211  0061               _N_BS:
9212  0061 0000          	ds.b	2
9213                     	xdef	_N_BS
9214  0063               _N_ASAR:
9215  0063 00            	ds.b	1
9216                     	xdef	_N_ASAR
9217  0064               _BS:
9218  0064 00            	ds.b	1
9219                     	xdef	_BS
9220  0065               _STmin:
9221  0065 00            	ds.b	1
9222                     	xdef	_STmin
9223  0066               _DTCNameN:
9224  0066 000000000000  	ds.b	63
9225                     	xdef	_DTCNameN
9226  00a5               _R_PDU:
9227  00a5 000000000000  	ds.b	200
9228                     	xdef	_R_PDU
9229  016d               _N_PDU:
9230  016d 000000000000  	ds.b	200
9231                     	xdef	_N_PDU
9232  0235               _N_ChangeParameter:
9233  0235 0000          	ds.b	2
9234                     	xdef	_N_ChangeParameter
9235  0237               _N_UDSDdata_FF:
9236  0237 00            	ds.b	1
9237                     	xdef	_N_UDSDdata_FF
9238                     	xref	f_Weeprommain
9239                     	xref	f_RKEnumberRead
9240                     	xref	f_INITrkenumber
9241                     	xref	_EnalbeLearnRkeTime20s
9242                     	xref	_speedlockset
9243                     	xref	f_WWDG_Refresh
9244                     	xref	f_CAN_send2
9245                     	xdef	f_LevelOneKeyArith
9246  0238               _AppKeyConst:
9247  0238 00000000      	ds.b	4
9248                     	xdef	_AppKeyConst
9249                     	xdef	_CommControl
9250                     	xdef	_DTCRuningstate
9251  023c               _BCMkey:
9252  023c 00000000      	ds.b	4
9253                     	xdef	_BCMkey
9254  0240               _BCMvseed:
9255  0240 00000000      	ds.b	4
9256                     	xdef	_BCMvseed
9257  0244               _DTC_EMS_ID2:
9258  0244 00            	ds.b	1
9259                     	xdef	_DTC_EMS_ID2
9260  0245               _DTC_EMS_ID1:
9261  0245 00            	ds.b	1
9262                     	xdef	_DTC_EMS_ID1
9263  0246               _DTC_TCU_ID:
9264  0246 00            	ds.b	1
9265                     	xdef	_DTC_TCU_ID
9266  0247               _DTC_ABS_ID:
9267  0247 00            	ds.b	1
9268                     	xdef	_DTC_ABS_ID
9269  0248               _DTC_SRS_ID:
9270  0248 00            	ds.b	1
9271                     	xdef	_DTC_SRS_ID
9272  0249               _N_Result:
9273  0249 00            	ds.b	1
9274                     	xdef	_N_Result
9275  024a               _TYPE:
9276  024a 00            	ds.b	1
9277                     	xdef	_TYPE
9278  024b               _CF_SN:
9279  024b 00            	ds.b	1
9280                     	xdef	_CF_SN
9281  024c               _FF_DL:
9282  024c 0000          	ds.b	2
9283                     	xdef	_FF_DL
9284  024e               _SF_FS:
9285  024e 00            	ds.b	1
9286                     	xdef	_SF_FS
9287                     	xdef	f_Did2einit
9288                     	xdef	f_Did2esave
9289                     	xdef	f_ClearNPDUbuff
9290                     	xdef	f_ClearRPDUbuff
9291                     	xdef	f_UDSDiag27
9292                     	xdef	f_BCMsjs
9293                     	xdef	f_Weeprom
9294                     	xdef	f_UDSDiag19
9295                     	xdef	f_UDSclearDTC
9296                     	xdef	f_SaveDTCtoBuff
9297                     	xdef	f_ReadDTCquantity
9298                     	xdef	f_UDSDiag2e
9299                     	xdef	f_UDSDiag22
9300                     	xdef	f_ReadDid22
9301                     	xdef	f_ReadDidvalue
9302                     	xdef	f_UDSDiag31
9303                     	xdef	f_UDSDiag28
9304                     	xdef	f_UDSDiag85
9305                     	xdef	f_UDSDiag3e
9306                     	xdef	f_UDSsendone
9307                     	xdef	f_UDSDiag10
9308                     	xdef	f_UDSonCANDiag
9309                     	xdef	f_UDSonCAN_netmain
9310                     	xdef	f_DTCinit
9311  024f               _UDSRuscnt:
9312  024f 00            	ds.b	1
9313                     	xdef	_UDSRuscnt
9314  0250               _UDSRITcnt:
9315  0250 00            	ds.b	1
9316                     	xdef	_UDSRITcnt
9317  0251               _RecData:
9318  0251 000000000000  	ds.b	50
9319                     	xdef	_RecData
9320  0283               _N_UDSDdata:
9321  0283 000000        	ds.b	3
9322                     	xdef	_N_UDSDdata
9323  0286               _sjs:
9324  0286 0000          	ds.b	2
9325                     	xdef	_sjs
9326                     	xref.b	c_lreg
9327                     	xref.b	c_x
9347                     	xref	d_lursh
9348                     	xref	d_ltor
9349                     	xref	d_lgadd
9350                     	xref	d_llsh
9351                     	xref	d_xymvx
9352                     	xref	d_ladd
9353                     	xref	d_rtol
9354                     	xref	d_uitolx
9355                     	xref	d_idiv
9356                     	xref	d_imul
9357                     	end
