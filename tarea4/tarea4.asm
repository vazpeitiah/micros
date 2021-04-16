	.include "m8535def.inc"
	.def aux = r19
	.def hex = r20
	SER aux
	OUT ddra, aux
	OUT portb, aux

	LDI aux, $3f
	MOV r3, aux		;0
	LDI aux, $06
	MOV r4, aux		;1
	LDI aux, $5b
	MOV r5, aux		;2
	LDI aux, $4f
	MOV r6, aux		;3
	LDI aux, $66
	MOV r7, aux		;4
	LDI aux, $6d
	MOV r8, aux		;5
	LDI aux, $7d
	MOV r9, aux		;6
	LDI aux, $27 
	MOV r10, aux		;7
	LDI aux, $7f 
	MOV r11, aux		;8
	LDI aux, $6f 
	MOV r12, aux	;9
	LDI aux, $77 
	MOV r13, aux	;A
	LDI aux, $7c 
	MOV r14, aux	;B
	LDI aux, $39 
	MOV r15, aux	;C
	LDI r16, $5E 	;D
	LDI r17, $79 	;E
	LDI r18, $71	;F
	CLR zh
lee:
	IN hex, pinb	; Lee el valor hexadecimal del puerto B
	ANDI hex, $0F 	; Ponemos 0-s en el nible bajo de hex
	LDI zl, 3		; Cargamos $01 en r30

	ADD zl, hex		; $01 = 14 + aux	
	LD hex, z		; carga z en aux
	OUT porta, hex
	RJMP lee
