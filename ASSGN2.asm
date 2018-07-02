**************************************
*
* Name:	Dwayne Williams
* ID:	16141671
* Date:	9/25/17
* Lab2
*
* Program description:
*
* Pseudocode:
*
* #define N 1
* unsigned int result;
* unsigned int inby;
* unsigned int fval;
* unsigned int c1;
* 
* result = 0;
* inby = 1;
* c1 = N;
* fval = 2*c1-1;
*
* do{
* result += inby;
* inby+=2;
* } until (inby >= fval)
*
**************************************

* start of data section

	ORG 	$B000
N      	FCB	255

	ORG 	$B010
RESULT	RMB     	2
INBY	RMB	2
FVAL	RMB	2
C1	RMB	2
* define any other variables that you might need here

	ORG	$C000
	CLR	FVAL
	CLR	FVAL+1
	CLR	C1
	CLR	C1+1
	CLR	INBY
	CLR	INBY+1			
	CLR	RESULT
	CLR	RESULT+1

	INC	INBY+1		*initialize counter to  one

	LDAB	C1+1
	ADDB	N		*copy the value in N and store it in C1
	STAB	C1+1
	LDD	FVAL
	ADDD	C1
	ADDD	C1
	SUBD	#0001		*add c1 twice and subtract 1
	STD	FVAL
	
	BRA	DO		*skip incbyh for first time
	
INCBYH	LDD	INBY		*load counter for result incrementing
	ADDD	#0002		*add 2 to inby
	STD	INBY
	BRA	UNTIL	
	
DO	LDD	RESULT				
	ADDD	INBY		*increment result by inby
	STD	RESULT		
	BRA	INCBYH		*always branch to inrement inby
			
UNTIL	LDD	INBY		
	CMPD	FVAL			
	BLS	DO		*stop if inby reaches fval
			
DONE 	BRA	DONE
		
* start of your program

