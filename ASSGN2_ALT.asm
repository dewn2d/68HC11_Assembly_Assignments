**************************************
*
* Name:	Dwayne Williams
* ID:	16141671
* Date:	9/24/17
* Lab2
*
* Program description:
*
* Pseudocode:
* #define N 255
*
* unsinged int result
* int count
*
* result = 0;
* count = 0;
*
* do{
*   result += N;
* } until (count == N)
*
*
*
*
**************************************

* start of data section

	ORG 	$B000
N      	FCB	55

	ORG 	$B010
RESULT	RMB     	2
COUNT	RMB	1

* define any other variables that you might need here


	ORG	$C000
	CLR	COUNT			
	CLR	RESULT
	CLR	RESULT+1
INCH	LDAA	COUNT		*increment high bits of result
	CMPA	#0		*check if program has started
	BEQ	DO		*if not skip this part
	INC	RESULT		
	CLC			
	BRA	CONT	
DO	
	LDAB	RESULT+1		*load lower bits of result		
	ADDB	N		*increment by N
	BCS	INCH		*branch to INCH if ther is a carry
CONT	STAB	RESULT+1			
	INC	COUNT			
UNTIL	LDAB	COUNT			
	CMPB	N			
	BNE	DO			
DONE 	BRA	DONE
		
* start of your program
