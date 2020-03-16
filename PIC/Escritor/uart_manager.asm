
_readData:

;uart_manager.c,2 :: 		unsigned char readData(){
;uart_manager.c,4 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;uart_manager.c,5 :: 		while (1){
L_readData0:
;uart_manager.c,6 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readData2
;uart_manager.c,7 :: 		dato = UART1_Read();
	CALL       _UART1_Read+0
;uart_manager.c,8 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;uart_manager.c,9 :: 		return dato;
	GOTO       L_end_readData
;uart_manager.c,10 :: 		}
L_readData2:
;uart_manager.c,11 :: 		}
	GOTO       L_readData0
;uart_manager.c,12 :: 		}
L_end_readData:
	RETURN
; end of _readData

_mult:

;uart_manager.c,13 :: 		unsigned char mult(unsigned char dato){
;uart_manager.c,14 :: 		if (dato>='A'){
	MOVLW      65
	SUBWF      FARG_mult_dato+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_mult3
;uart_manager.c,15 :: 		return dato-55;
	MOVLW      55
	SUBWF      FARG_mult_dato+0, 0
	MOVWF      R0+0
	GOTO       L_end_mult
;uart_manager.c,16 :: 		}else{
L_mult3:
;uart_manager.c,17 :: 		return dato-48;
	MOVLW      48
	SUBWF      FARG_mult_dato+0, 0
	MOVWF      R0+0
;uart_manager.c,19 :: 		}
L_end_mult:
	RETURN
; end of _mult

_ascii2hex:

;uart_manager.c,20 :: 		unsigned char ascii2hex(){
;uart_manager.c,21 :: 		unsigned char dato = 0x00;
	CLRF       ascii2hex_dato_L0+0
;uart_manager.c,22 :: 		dato = mult(readData())<<4;
	CALL       _readData+0
	MOVF       R0+0, 0
	MOVWF      FARG_mult_dato+0
	CALL       _mult+0
	MOVF       R0+0, 0
	MOVWF      ascii2hex_dato_L0+0
	RLF        ascii2hex_dato_L0+0, 1
	BCF        ascii2hex_dato_L0+0, 0
	RLF        ascii2hex_dato_L0+0, 1
	BCF        ascii2hex_dato_L0+0, 0
	RLF        ascii2hex_dato_L0+0, 1
	BCF        ascii2hex_dato_L0+0, 0
	RLF        ascii2hex_dato_L0+0, 1
	BCF        ascii2hex_dato_L0+0, 0
;uart_manager.c,23 :: 		dato += mult(readData());
	CALL       _readData+0
	MOVF       R0+0, 0
	MOVWF      FARG_mult_dato+0
	CALL       _mult+0
	MOVF       ascii2hex_dato_L0+0, 0
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      ascii2hex_dato_L0+0
;uart_manager.c,25 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;uart_manager.c,26 :: 		return dato;
;uart_manager.c,27 :: 		}
L_end_ascii2hex:
	RETURN
; end of _ascii2hex

_check_sum:

;uart_manager.c,28 :: 		unsigned char check_sum(unsigned char * trama) {
;uart_manager.c,29 :: 		unsigned char checksum, j = 0x00;
	CLRF       check_sum_j_L0+0
;uart_manager.c,30 :: 		unsigned char size = trama[0]+0x04;
	MOVF       FARG_check_sum_trama+0, 0
	MOVWF      FSR
	MOVLW      4
	ADDWF      INDF+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      R3+0
;uart_manager.c,31 :: 		for(j = 0; j<size; j++)
	CLRF       check_sum_j_L0+0
L_check_sum5:
	MOVF       R3+0, 0
	SUBWF      check_sum_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_sum6
;uart_manager.c,33 :: 		checksum += trama[j];
	MOVF       check_sum_j_L0+0, 0
	ADDWF      FARG_check_sum_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R2+0, 1
;uart_manager.c,31 :: 		for(j = 0; j<size; j++)
	INCF       check_sum_j_L0+0, 1
;uart_manager.c,35 :: 		}
	GOTO       L_check_sum5
L_check_sum6:
;uart_manager.c,36 :: 		checksum = ~checksum + 1;
	COMF       R2+0, 0
	MOVWF      R0+0
	INCF       R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      R2+0
;uart_manager.c,40 :: 		j = (checksum == trama[size]);
	MOVF       R3+0, 0
	ADDWF      FARG_check_sum_trama+0, 0
	MOVWF      FSR
	MOVF       R1+0, 0
	XORWF      INDF+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      check_sum_j_L0+0
;uart_manager.c,41 :: 		checksum = 0;
	CLRF       R2+0
;uart_manager.c,42 :: 		return j;
;uart_manager.c,43 :: 		}
L_end_check_sum:
	RETURN
; end of _check_sum
