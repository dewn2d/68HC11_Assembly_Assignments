***************************************
*
* Name: 
* ID:   
* Date: 
* Lab 4
*
* Program description:
*
*
* Pseudocode of Main Program:
*
*---------------------------------------
*
* Pseudocode of Subroutine:
*	
*	
***************************************
* start of data section
	ORG $B000
NARR	FCB	1, 2, 5, 100, 150, 200, 250, 254, $FF
SENTIN	EQU	$FF

	ORG $B010
RESARR	RMB	32
RESADDR	RMB	2
NARRADDR	RMB	2	
INDEX	RMB	1
INDEX1	RMB	1
INDEX2	RMB	1
REST	RMB 	2


* define any variables that your MAIN program might need here
* REMEMBER: Your subroutine must not access any of the main
* program variables including NARR and RESARR.

	ORG $C000

	LDS	#$01FF				*initialize stack pointer
	CLR	INDEX
	CLR	INDEX1
	CLR	INDEX2
	CLR	REST
	
	LDAB 	INDEX1
	ADDB	#01
	STAB	INDEX1

	LDAB 	INDEX
	ADDB	#02
	STAB	INDEX

	LDAB 	INDEX2
	ADDB	#06
	STAB	INDEX2

	LDD	#RESARR
	STD	RESADDR

	LDD	#NARR
	STD	NARRADDR	

WHILE	CLRA	
	LDX	NARRADDR
	LDAB	0, X
	CMPB	#SENTIN	
	BEQ	ENDWHILE

	JSR	SUB

	PULA
	PULB
			
	STD	REST

	LDY	RESADDR
	LDD	REST
	STD	0,Y

	PULA	
	PULB
			
	STD	REST

	LDD	RESADDR
	ADDB	INDEX
	STD	RESADDR

	LDY	RESADDR
	LDD	REST
	STD	0,Y

	LDD	RESADDR
	ADDB	INDEX
	STD	RESADDR

	LDD	NARRADDR
	ADDB	INDEX1
	STD	NARRADDR

	BRA	WHILE

ENDWHILE	
DONE	BRA		DONE
	
* define any other variables that you might need here using RMB (not FCB or FDB)
* remember that your main program must not access any of these variables, including


	ORG $D000
* start of your subroutine 
SUB	
	
	PULY

	DES	*C2	0
	DES	*C2+1	1
	DES	*C1	2
	DES	*C1+1	3
	DES	*TEMP	4
	DES	*TEMP+1	5
	DES	*INBY	6
	DES	*INBY+1	7
	DES	*SRESULT	8
	DES	*SRESULT+1	9
	DES	*RESULT	10
	DES	*RESULT+1	11
	DES	*RESULT+2	12
	DES	*RESULT+3  	13


	TSX
		
	CLR	10, X
	CLR	11, X
	
	CLR	12, X
	CLR	13, X
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
			
ENDWHLE	LDD	12, X		*load result for squard value summation
	ADDD	8, X		*add current squared value
	STD	12, X
	LDAA	11, X		
	ADCA	#0000		*add carry bit to high 2 bytes
	STAA	11, X 	
	
	LDAB	1, X		*update limit of while loop
	INCB			*increment counter of added squared values
	STAB	1, X
	
UNTIL	LDD	0, X		
	CMPD	2, X			
	BLS	DO		*end if current limit passes N
		
	LDD 	12, X


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
	INS
	INS
	INS
	INS

	PSHB
	PSHA
	
	DES
	DES
	DES
	DES
	DES
	DES
	DES
	DES
	DES
	DES
	DES
	DES
	DES
	DES

	LDD 	10, X

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
	INS
	INS
	INS
	INS

	PSHB
	PSHA	

	PSHY

	RTS


