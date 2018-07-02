***************************************
*
* Name: Dwayne Williams
* ID:   16141671
* Date: 11/3/17
* Lab 4
*
* Program description:
* use a subroutine to calculate the sum of squares
*
* Pseudocode of Main Program:
*
*---------------------------------------
* int narr[8] = 1, 2, 5, 100, 150, 200, 250, 254;
*
* int* ptr1;
* int* ptr2;
*
* while ( *ptr1 != $FF)
* {
*	*ptr2 = SUB( *ptr1 );
*	ptr2++;
*	ptr2++;
* 	ptr1++;
* }
*
* Pseudocode of Subroutine:
* int SUB( int* array )
* {
*
* int result;
* int c1;
* int c2;
* int sresult;
* int temp;
* int inby;
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
* return result;
*}
*	
***************************************
* start of data section
	ORG $B000
NARR	FCB	1, 2, 5, 100, 150, 200, 250, 254, $FF
SENTIN	EQU	$FF

	ORG $B010
RESARR	RMB	32
REST	RMB	2


* define any variables that your MAIN program might need here
* REMEMBER: Your subroutine must not access any of the main
* program variables including NARR and RESARR.

	ORG $C000
	CLR	REST

	LDS	#$01FF				*initialize stack pointer

	LDY	#RESARR	*intialize pointer to resarr

	LDX	#NARR	*intialize pointer to narr

WHILE	LDAB	0, X
	CMPB	#SENTIN	*end if equal to $FF
	BEQ	ENDWHILE

	JSR	SUB	*jump to sub routine

	PULA		*pull first 2 bytes off stack
	PULB
			
	STD	REST	*store in temp

	PULA		*repeat steps for next 2 bytes
	PULB
			
	STD	0, Y	*store in resaddr
	
	INY
	INY
		
	LDD	REST
	STD	0, Y	*store first 2 bits
	
	INY		*inc pointer by 2
	INY

	INX		*inc narr pointer

	BRA	WHILE

ENDWHILE	
DONE	BRA		DONE
	
* define any other variables that you might need here using RMB (not FCB or FDB)
* remember that your main program must not access any of these variables, including


	ORG $D000
* start of your subroutine 
SUB	
	DES	*RESULT	16
	DES	*RESULT+1	17
	DES	*RESULT+2	18
	DES	*RESULT+3  	19

	PSHA	*15
	PSHB	*14
	PSHX	*13 - 12	
	PSHY	*11 - 10

	DES	*C2+1	0
	DES	*C2	1
	DES	*C1+1	2
	DES	*C1	3
	DES	*TEMP+1	4
	DES	*TEMP	5
	DES	*INBY+1	6
	DES	*INBY	7
	DES	*SRESULT+1	8
	DES	*SRESULT	9

	TSX
		
	CLR	16, X
	CLR	17, X
	
	CLR	18, X
	CLR	19, X
	CLR	3, X
	CLR	2, X
	CLR	0, X
		
	INCA			*initialize c2 to 1
	STAA	1, X
	DECA

	ABA			*copy the value in REG A and store it in C1
	STAA	3, X

				*start of do loop
				*clear variables for squaring in while loop	
DO	CLR	9, X
	CLR	8, X

	CLR	5, X
	CLR 	4, X
				*reinitialize counter to  one
	CLR	7, X
	CLR	6, X
	
	INC	7, X
		
WHLE	LDD	0, X		*start of while loop
	CMPD	4, X		*compare temp counter to current limit
	BEQ	ENDWHLE
	LDD	8, X				
	ADDD	6, X		*increment result by inby
	STD	8, X
	LDD	6, X		*load counter for result incrementing
	ADDD	#0002		*add 2 to inby
	STD	6, X
	INC	5, X		
	BRA	WHLE		*branch to start of while loop
			
ENDWHLE	LDD	18, X		*load result for squard value summation
	ADDD	8, X		*add current squared value
	STD	18, X
	LDAA	17, X		
	ADCA	#0000		*add carry bit to high 2 bytes
	STAA	17, X 	
	
	LDAB	1, X		*update limit of while loop
	INCB			*increment counter of added squared values
	STAB	1, X
	
UNTIL	LDD	0, X		
	CMPD	2, X			
	BLS	DO		*end if current limit passes N
	
	LDY	16,X

	LDD	20,X
	STD	16,X

	STY	20,X

	INS
	INS
	INS
	INS
	INS
	INS
	INS
	INS
	INS
	INS
	
	PULY
	PULX
	PULB
	PULA

	RTS


