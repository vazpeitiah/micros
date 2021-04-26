	.include "m8535def.inc"

	.def input = r16
	.def aux = r17
	.def nbajo = r18
	.def nalto = r19
	.def convertir = r20
	.def convertir2 = r21
	.def segundos = r25
	.def cuenta = r26

	ser aux
	out ddra,aux
	out portb, aux
	out ddrc,aux
	ldi aux,low(RAMEND)
	out spl,aux
	ldi aux,high(RAMEND)
	out sph,aux
leer:
	in input,pinb
	ldi nbajo,$0f
	ldi nalto,$f0
	clr convertir2
	and nbajo,input
	and nalto,input
	swap nalto
	clr cuenta
	cpi nalto,0
	brne contar
	mov convertir,nbajo
	rcall conversion
	nop
	nop
	rcall mostrar
	nop
	rjmp leer
contar:
	mov convertir,cuenta
	rcall conversion
	rcall mostrar
	mov segundos,nalto
	rcall retardo
	inc cuenta
	cp nbajo,cuenta
	brge contar
	clr cuenta
	rjmp contar


mostrar:
	
	out portc,convertir
	out porta,convertir2
	ret


;----------------------------------------------------------
;---------Subrutina para conversion binario a 7seg---------
;-----------------------------------------------------------
conversion:
	cpi convertir,0
	breq es0
	cpi convertir,1
	breq es1
	cpi convertir,2
	breq es2
	cpi convertir,3
	breq es3
	cpi convertir,4
	breq es4
	cpi convertir,5
	breq es5
	cpi convertir,6
	breq es6
	cpi convertir,7
	breq es7
	cpi convertir,8
	breq es8
	cpi convertir,9
	breq es9
	cpi convertir,10
	breq es10
	cpi convertir,11
	breq es11
	cpi convertir,12
	breq es12
	cpi convertir,13
	breq es13
	cpi convertir,13
	breq es13
	cpi convertir,14
	breq es14
	cpi convertir,15
	breq es15
es0:
	ldi convertir,$3f
	ret
es1:
	ldi convertir,$06
	ret
es2:
	ldi convertir,$5b
	ret
es3:
	ldi convertir,$4f
	ret
es4:
	ldi convertir,$66
	ret
es5:
	ldi convertir,$6d
	ret
es6:
	ldi convertir,$7d
	ret
es7:
	ldi convertir,$07
	ret
es8:
	ldi convertir,$7f
	ret
es9:
	ldi convertir,$67
	ret
es10:
	ldi convertir,$3f
	ldi convertir2,$06
	ret
es11:
	ldi convertir,$06
	ldi convertir2,$06
	ret
es12:
	ldi convertir,$5b
	ldi convertir2,$06
	ret
es13:
	ldi convertir,$4f
	ldi convertir2,$06
	ret
es14:
	ldi convertir,$66
	ldi convertir2,$06
	ret
es15:
	ldi convertir,$6d
	ldi convertir2,$06
	ret

;----------------------------------------------------------
;---------------Subrutina retardo n seg -------------------
;-----------------------------------------------------------	

retardo:
	ldi  r22, 6
    ldi  r23, 19
    ldi  r24, 174

	
L1: dec  r24
    brne L1
    dec  r23
    brne L1
    dec  r22
    brne L1
    dec segundos
	brne retardo
	ret
