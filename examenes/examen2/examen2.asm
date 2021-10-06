.include"m8535def.inc"
        .def adl = r17
	.def ctados = r23
	.def col = r18
	.def aux = r19
	.def cta = r20
	.def col2 = r21
	.def mcount = r22
;----------------------------------------------------------------------------
.macro num
          push zh
	  push zl
	  ldi ZH, high(@0<<1)              ; Initialize Z pointer
          ldi ZL, low(@0<<1)
	  lpm r0, Z+
          lpm r1, Z+
	  lpm r2, Z+
          lpm r3, Z+
	  lpm r4, Z+
          lpm r5, Z+
	  lpm r6, Z+
          lpm r7, Z
	  pop zl
	  pop zh
.endm
;--------------------------------------------------------------------------
         rjmp  Start
		 rjmp cuenta1
		 rjmp cuenta2
	.org $008
	 nop
	 rjmp muestra

;---------------------------------------------------------------------------
Start:
          LDI R16,LOW(RAMEND)
	  OUT SPL,R16
	  LDI R16,HIGH(RAMEND)
	  OUT SPH,R16
	  ldi aux, 0b11000000
		out gicr,aux
		ldi aux,15
		out mcucr,aux
			
	  SER R16
	  OUT portd,R16
	  OUT DDRB,R16
	  OUT DDRC,R16
	  OUT DDRa,R16
	  LDI R16,$ED ; 1110 1101
	  ldi aux,2
	  out tccr0,aux
	  ldi aux,1
	  out timsk,aux
	  SEI
         ldi cta,-1
		 ldi ctados,-1
		 ldi mcount,0
	 ldi col,1
	 ldi col2,1
	 clr zh
	 ldi zl,0
;----------------------------------------------------------------
Loop:
	  nop
	   rjmp  Loop

;---------------------------------------------------------------
muestra:
	cpi mcount,0
	breq barre
	rjmp barre2
barre:
	mov aux,cta
	rcall deco
	ldi aux,0
	out portb,aux
      out porta,zh
      ld aux,z+
      lsl col
   
      brcs nbarre

sss:
      com col
      out portc,col
      com col
      out porta,aux
      reti
 nbarre:
      ldi col,1
      ldi zl,0
      ld aux,z+
      
	  ldi mcount,1
	  rjmp sss 
	 ; reti

barre2:
	mov aux,ctados
	;ldi aux,3
	rcall deco
	ldi aux,0
	out porta,aux
      out portb,zh
      ld aux,z+
      lsl col2
   
      brcs nbarre2

sss2:
      com col2
      out portc,col2
      com col2
      out portb,aux
      reti
 nbarre2:
      ldi col2,1
      ldi zl,0
      ld aux,z+
      
	  ldi mcount,0
	  rjmp sss2
	  ;reti


 ;-------------------------------------------------------------
 cuenta1:
		inc cta
		cpi cta,10
		brne rcta1
		ldi cta,-1
rcta1:
		reti
cuenta2:
		inc ctados
		cpi ctados,10
		brne rcta2
		ldi ctados,-1
rcta2:
		reti

deco:
	   cpi aux,0
	   breq cta0
	   cpi aux,1
	   breq cta1
	   cpi aux,2
	   breq cta2
	   cpi aux,3
	   breq cta3
	   cpi aux,4
	   breq cta4
	   cpi aux,5
	   breq cta5
	   cpi aux,6
	   breq cta6
	   cpi aux,7
	   breq cta7
	   cpi aux,8
	   breq cta8
	   cpi aux,9
	   breq cta9
 ncta:
      ret
cta3:
	rjmp cta31
cta4:
      rjmp cta41
 cta5:
      rjmp cta51
cta6:
      rjmp cta61
 cta7:
      rjmp cta71
cta8:
      rjmp cta81
 cta9:
      rjmp cta91

 cta0:
      num cero
      rjmp ncta
 cta1:
      num uno
      rjmp ncta
 cta2:
      num dos
      rjmp ncta
 cta31:
      num tres
      rjmp ncta
 cta41:
      num cuatro
      rjmp ncta
  cta51:
      num cinco
      rjmp ncta
  cta61:
      num seis
      rjmp ncta
  cta71:
      num siete
      rjmp ncta
  cta81:
      num ocho
      rjmp ncta
  cta91:
      num nueve
      rjmp ncta
 ;----------------------------------------------------
 cero:
    .db $00,$7C,$82,$82,$82,$7C,$00,$02
 uno:
    .db $00,$22,$42,$FE,$02,$02,$00,$04
 dos:
    .db $00,$42,$86,$8A,$92,$62,$00,$08
 tres:
    .db $00,$44,$82,$92,$92,$6C,$00,$10
 cuatro:
    .db $00,$08,$18,$28,$48,$FE,$00,$20
 cinco:
    .db $00,$F4,$92,$92,$92,$8C,$00,$40
 seis:
    .db $00,$7C,$92,$92,$92,$4C,$00,$40
  siete:
    .db $00,$80,$80,$80,$80,$FE,$00,$80
  ocho:
    .db $00,$6C,$92,$92,$92,$6C,$00,$08
   nueve:
    .db $00,$64,$92,$92,$92,$7C,$00,$08
