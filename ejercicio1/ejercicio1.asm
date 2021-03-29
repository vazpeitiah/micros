; Ejercicio 1
	LDI R16, 90		; Carga 80 en R16
	LDI R17, 5		; Carga 5 en R17
	LDI R18, $01	; Carga 1 en R18
	MOV R19, R16	; Copia R16 en R19
	CLR R20			; Inicializa R20 con 0xFF
	CLR R21			; Inicializa R21 con 0xFF
loop:
	CP R17, R18		; Compara R17 con R18
	BREQ result		; Si R17=R18 -> salta a fin
	ADD R19, R16	; R19 = R19 + R16
	ADC R20, R21	; Suma el acarreo en R20
	INC	R18			; R18++
	RJMP loop		; Salta a loop
result:
	MOV R17, R20	; Copia R20 en R17
	MOV R18, R19	; Copia R19 en R18
end:
	RJMP end		; Fin del programa
