
_main:

;Tester.c,2 :: 		void main() org 0x500{
;Tester.c,3 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;Tester.c,4 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Tester.c,5 :: 		while (1){
L_main0:
;Tester.c,6 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
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
;Tester.c,7 :: 		PORTB = ~PORTB;
	COMF       PORTB+0, 1
;Tester.c,8 :: 		}
	GOTO       L_main0
;Tester.c,9 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
