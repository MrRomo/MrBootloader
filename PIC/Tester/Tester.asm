
_main:

;Tester.c,1 :: 		void main() org 0x500{
;Tester.c,2 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;Tester.c,3 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Tester.c,4 :: 		while (1){
L_main0:
;Tester.c,5 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
	NOP
;Tester.c,6 :: 		PORTB = ~PORTB;
	COMF       PORTB+0, 1
;Tester.c,7 :: 		}
	GOTO       L_main0
;Tester.c,8 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
