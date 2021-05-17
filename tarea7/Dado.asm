	.include "m8535def.inc"
	.def aux = r16
	.def count = r17
	.def most = r18
reset:
	rjmp main
	rjmp cuenta
	

main:
	ldi aux,low(RAMEND)
	out spl,aux
	ldi aux,high(RAMEND)
	out sph,aux
	ser aux
	out ddra,aux
	out portd,aux
	ldi aux,0b00001110
	out mcucr,aux
	ldi aux, 0b11100000
	out GICR,aux
	
	ldi r20,$06
	ldi r21,$5b
	ldi r22,$4f
	ldi r23,$66
	ldi r24,$6d
	ldi r25,$7d
	ldi aux,$06
	clr zh
	clr count
	sei
loop:
	rcall mostrar
	rjmp loop


cuenta:
	sbic pind,2
	reti
	cpi count,$06
	brne suma
	clr count
suma:
	inc count
	rcall deco
	rcall mostrar
	rcall delay
	rjmp cuenta

mostrar:
	out porta,most
	ret
deco:
	ldi zl,19
	add zl,count
	ld most,z
	ret
delay:
	ldi  r26, 5
    ldi  r27, 15
    ldi  r28, 242
L1: dec  r28
    brne L1
    dec  r27
    brne L1
    dec  r26
    brne L1
	ret

	
