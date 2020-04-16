
_main:

;Tester.c,2 :: 		void main() {
;Tester.c,3 :: 		TRISA = 0x00;
	CLRF       TRISA+0
;Tester.c,4 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;Tester.c,6 :: 		ANSEL = 0X00;
	CLRF       ANSEL+0
;Tester.c,7 :: 		ANSELH = 0X00;
	CLRF       ANSELH+0
;Tester.c,8 :: 		PORTA = 0x02;
	MOVLW      2
	MOVWF      PORTA+0
;Tester.c,9 :: 		PORTB = 0x08;
	MOVLW      8
	MOVWF      PORTB+0
;Tester.c,11 :: 		while (1){
L_main0:
;Tester.c,12 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
	NOP
;Tester.c,13 :: 		PORTA = PORTA<<1;
	MOVF       PORTA+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	MOVWF      PORTA+0
;Tester.c,14 :: 		PORTB = PORTB<<1;
	MOVF       PORTB+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;Tester.c,16 :: 		if(PORTA.F5 == 1) PORTA++;
	BTFSS      PORTA+0, 5
	GOTO       L_main3
	INCF       PORTA+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      PORTA+0
L_main3:
;Tester.c,17 :: 		if(PORTB.F7 == 1) PORTB++;
	BTFSS      PORTB+0, 7
	GOTO       L_main4
	INCF       PORTB+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
L_main4:
;Tester.c,19 :: 		}
	GOTO       L_main0
;Tester.c,20 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
