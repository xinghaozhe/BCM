
/* CR5-w/r/b {CR5-16/12/8} */
#define 	w		    16      // Word bit length
#define 	r		    12      // Cycle times
#define 	b		    8       // Bytes of key
#define 	t		    26		// 2*r+2=12*2+2
#define 	c		    4 		// b*8/w = 16*8/32 

extern void Rke_key_new(unsigned int *Header,unsigned int *A_Code,unsigned int *B_Code);
extern void DECRYPT(unsigned int* In, unsigned int* Out, unsigned int* S);


#define ROTR(x,y) (((x)>>(y&(w-1))) | ((x)<<(w-(y&(w-1)))))





//extern unsigned int  f_SKey_A[t] ;
//extern const unsigned int  f_SKey_B[13] ;
//extern const unsigned int  f_SKey_C[13] ;