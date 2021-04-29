	.include"m8535def.inc"
	.def aux = r16
	.def dat = r17

load:
	LDI aux, low(RAMEND)
	OUT spl, aux
	LDI aux, high(RAMEND)
	OUT sph, aux
	SER aux
	OUT ddra, aux
	out portb, aux
	OUT ddrc, aux
	CLR zh

	LDI	r20, $3f
	LDI r21, 6	
	LDI r22, $5b
	LDI r23, $4f
	LDI r24, $66
	LDI r25, $6d
	LDI r26, $7d
	LDI r27, $27
	LDI r28, $7f
	LDI r29, $6f

loop:
	IN dat, pinb
	ANDI dat, $0F
	RCALL deco
	CBI portc, 0		# Pone cero en el bit que se le pone en este caso el cero
	SBI portc, 1		# Pone uno en el bit que se le pone en este caso el uno
	OUT porta, dat
	RCALL delay
	OUT porta, zh
	IN dat, pinb
	ANDI dat, $F0
	SWAP dat	
	RCALL deco
	CBI portc, 1
	SBI portc, 0
	OUT porta, dat
	RCALL delay
	OUT porta, zh
	rjmp loop

deco:
	LDI zl, 20
	ADD zl, dat
	LD dat, z
	RET

delay:				#Retardo
	push r18
	push r19
    ldi  r18, 26
    ldi  r19, 246
L1: dec  r19
    brne L1
    dec  r18
    brne L1
    nop
	pop r19
	pop r18
	ret
