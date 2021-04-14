/*	Fecha: 14 abr 2021
	Descripcion: Escribir un programa que obtenga la raíz cuadrada (la parte entera) 
	del número presente en el puerto B, el resultado se debera mostrar 
	en el puerto A.  El rango de los datos de entrada sera de $00 al 
	$FF (0 al 255)	
	Autor: Vladimir Azpeitia Hernandez*/
	.include "m8535def.inc"	; Para usar nombres de registros IO
	SER r16					; Carga $FF en r16
	OUT DDRA, r16			; Configurar el puerto A como salida
	OUT PORTB, r16			; Configurar el puerto B como entrada
loop:
	IN r17, pinb			; Leer el dato del puerto B en num
	LDI r16, $01
	CPI r17, $00			; num - $0
	BREQ end				; if(C = 0) salta a end
	LDI r19, $01
	LDI r18, $01
	CLR R20
	CLR R21
sum:
	INC r19
	INC r19
	ADD r18, r19
	INC r16
	ADC r20, r21			; suma acarreo en r20
	CPI r20, $00			; r20 - $00
	BRNE end				; if(z = 0) salta a end
	CP	r17, r18			; r17 - r16
	BRSH sum				; if(c = 1) salta a sum
end:
	DEC r16
	OUT porta, r16			; Manda el dato de r17 al puerto A
	RJMP loop				; Salta a loop
