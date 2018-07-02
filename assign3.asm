**************************************
*
* Name: Dwayne Williams
* ID:   16141671
* Date: 10/10/2017
* Lab3
*
* Program description:
* assembly language program which generates
* the sum of integer squared from 1 to N,  1 => N <= 254.
*
* Pseudocode:
*
* #define N 254
* unsigned int result;
* unsinged int sresult;
* unsigned int inby;
* unsigned int fval;
* unsigned int c1;
* unsigned int c2;
* 
* result = 0;
* c1 = N;
* c2 = 1;
*
* do{
*
* sresult = 0;
* temp = 0;
* inby = 1;
*
* while( c2 != temp  ){
* 	sresult += inby;
* 	inby +=2;
*	temp++;
* }
*
* result += sresult;
* c2++;
*
* } until (c2 > c1)
*
*
*
*
**************************************

* start of data section

	ORG $B000
N       	FCB    254

	ORG $B010
RESULT  	RMB 	4
SRESULT	RMB	2
INBY	RMB	2
TEMP	RMB	2
C1	RMB	2
C2	RMB	2
* define any other variables that you might need here


	ORG $C000
* start of your program
	CLR	RESULT
	CLR 	RESULT+1
	CLR 	RESULT+2
	CLR 	RESULT+3
	CLR	TEMP
	CLR	TEMP+1		
	CLR	C1
	CLR	C1+1
	CLR	C2
	CLR	C2+1
	
	LDAB	C2+1		*initialize c2 to 1
	INCB			
	STAB	C2+1
	
	LDAB	C1+1
	ADDB	N		*copy the value in N and store it in C1
	STAB	C1+1

				*start of do loop
				*clear variables for squaring in while loop	
DO	CLR	SRESULT
	CLR	SRESULT+1
	
	CLR	TEMP
	CLR 	TEMP+1
	
				*reinitialize counter to  one
	CLR	INBY
	CLR	INBY+1
	
	INC	INBY+1
		
WHLE	LDD	C2		*start of while loop
	CMPD	TEMP		*compare temp counter to current limit
	BEQ	ENDWHLE
	LDD	SRESULT				
	ADDD	INBY		*increment result by inby
	STD	SRESULT
	LDD	INBY		*load counter for result incrementing
	ADDD	#0002		*add 2 to inby
	STD	INBY
	INC	TEMP+1		
	BRA	WHLE		*branch to start of while loop
			
ENDWHLE	LDD	RESULT+2		*load result for squard value summation
	ADDD	SRESULT		*add current squared value
	STD	RESULT+2
	LDAA	RESULT+1		
	ADCA	#0000		*add carry bit to high 2 bytes
	STAA	RESULT+1 	
	
	LDAB	C2+1		*update limit of while loop
	INCB			*increment counter of added squared values
	STAB	C2+1
	
UNTIL	LDD	C2		
	CMPD	C1			
	BLS	DO		*end if current limit passes N
		
DONE	BRA		DONE