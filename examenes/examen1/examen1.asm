.include "m8535def.inc"
    	SER r16
    	OUT ddra, r16   ; Salida puerto A
    	OUT ddrc, r16   ; Salida puerto C
    	
    	OUT portb, r16  ; Entrada puerto B
    	OUT portd, r16  ; Entrada puerto D
    
    principal:
    	IN r17, pinb    ; Pone el puerto B como entrada
    	IN r18, pind    ; Pone el puerto D como entrada
    	
    	CP r17, r18
    	BREQ fin        ; if B == D
    	BRLO esmayor    ; if B < D
                      	; if D < B
    	OUT porta, r18  ; Mostar B menor en el puerto A
    	OUT portc, r17  ; Mostar D mayor en el puerto C
    
    	RJMP principal
    esmayor:          	; D es menor que B
    	OUT porta, r17  ; Mostar D menor en el puerto A
    	OUT portc, r18  ; Mostar B mayor en el puerto C
    	RJMP principal
    
    fin:              	; Son iguales
    	OUT porta, r17  ; Mostar D en C
    	OUT portc, r18  ; Mostar B en A
    	RJMP principal
