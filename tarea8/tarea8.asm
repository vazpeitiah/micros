	.include"m8535def.inc"
	.def aux = r16
	.def dat = r17
	.def dsp = r18
reset:
	rjmp main
	.org $009
	rjmp barre
main: 
	ldi aux,low(RAMEND)
	out spl,aux
	ldi aux,high(RAMEND)
	out sph,aux
	rcall config_io
	ldi dsp,1; 0000 0001
	ldi ZH, high(datos<<1)
	ldi ZL, low(datos<<1)
ciclo:
	nop
	nop
	nop
	rjmp ciclo
datos:
	.db $40,$77,$38,$3F, $76, $40
barre:
	out porta,zh
	com dsp
	out portc,dsp
	com dsp
	lpm dat,z+
	out porta,dat
	lsl dsp
    sbrc dsp,7
	rjmp otro
sal:
	reti
otro:
	ldi dsp,1; 0000 0001
	ldi ZH, high(datos<<1)
	ldi ZL, low(datos<<1)
	rjmp sal

config_io:
	ser aux
	out ddra,aux
	out ddrc,aux
	ldi aux,2
	out tccr0,aux
	ldi aux,1
	out timsk,aux
	clr zh
	sei
	ret
