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


