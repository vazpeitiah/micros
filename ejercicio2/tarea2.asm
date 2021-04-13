/*  -Fecha: viernes 09 abr 2021
	-Descripcion: Ejercicio 2. Realizar un programa que lea el dato del 
	puerto B, este dato sera un número que llamaremos "ascii" (0-9, A-F). 
	El programa deberá mostrar en el puerto A el codigo hexadecimal 
	correspondiente al codigo ascii del dato presente en el puerto B 
	-Autor: Vladimir Azpeitia Hernández 3CM17 */	

	.include "m8535def.inc"	; Para usar nombres de registros IO
	SER r16					; Carga FF en r16
	OUT DDRA, r16			; Configurar el puerto A como salida
	OUT PORTB, r16			; Activa los pullouts del puerto B, poniendo 1's
loop:
	IN r17, pinb			; Lee el dato del puerto B en r17
	LDI r16, $30			; Cargamos $30 en r16
	LDI r18, $3A			; Cargamos $3A en r18
	LDI r19, $07			; Cargamos $07 en r19
	ADD r17, r16			; r17 = r17 + r16 (hex = ascii + $30)
	CP	r17, r18			; r17 - r18
	BRLO end				; r17 < r18 (hex < $3A) -> salta a end
	ADD r17, r19			; r17 = r17 + r19 (hex = ascii + $30 + $3A)
end:
	OUT porta, r17			; Manda el dato de r17 al puerto A
	RJMP loop				; Salta a loop