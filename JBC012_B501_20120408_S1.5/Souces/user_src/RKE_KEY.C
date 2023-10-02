//#include "rke_key.h" 

extern const unsigned int  f_SKey_B[13]  ;  //production keys for key 1,52 byte

void DECRYPT(unsigned int* In, unsigned int* Out, unsigned int* S)
{
	unsigned int  X,Y;
	unsigned char i;

	X = In[0];
	Y = In[1];
	/*
	for (i=r;i>0;i--)
	{
	    Y = ROTR(Y-S[2*i+1],X)^X; 
	    X = ROTR(X-S[2*i],Y)^Y; 
	}

	Out[0] = X - S[0];
	Out[1] = Y - S[1];*/
}

void Rke_key_new(unsigned int *Header,unsigned int *A_Code,unsigned int *B_Code)
{
       unsigned char  i;

       const unsigned int  f_SKey_C[13]  =  {0x6666,0x7777,0x8888, 0x1111,0x2222,0x3333,0x4444,0x5555,0x6666,0x7777,0x8888,
                                                        0x1111,0x2222
                                                      };  //production keys for key 1,52 byte

       unsigned int  f_SKey_A[26] ;
	   
     /*  for(i=0;i<13;i++)
       {
           f_SKey_A[i]=(f_SKey_B[i]^Header[1]);
       }
       for(i=13;i<26;i++)
       {
           f_SKey_A[i]=(f_SKey_C[i-13]^Header[1]);
       }

	DECRYPT(A_Code,A_Code,f_SKey_A);
	
	DECRYPT(B_Code,B_Code,f_SKey_A);

   */
}
	








