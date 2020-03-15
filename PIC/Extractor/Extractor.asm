
_main:

;Extractor.c,7 :: 		void main() {
;Extractor.c,8 :: 		unsigned char trama[25] = {0};
	CLRF       main_trama_L0+0
	CLRF       main_trama_L0+1
	CLRF       main_trama_L0+2
	CLRF       main_trama_L0+3
	CLRF       main_trama_L0+4
	CLRF       main_trama_L0+5
	CLRF       main_trama_L0+6
	CLRF       main_trama_L0+7
	CLRF       main_trama_L0+8
	CLRF       main_trama_L0+9
	CLRF       main_trama_L0+10
	CLRF       main_trama_L0+11
	CLRF       main_trama_L0+12
	CLRF       main_trama_L0+13
	CLRF       main_trama_L0+14
	CLRF       main_trama_L0+15
	CLRF       main_trama_L0+16
	CLRF       main_trama_L0+17
	CLRF       main_trama_L0+18
	CLRF       main_trama_L0+19
	CLRF       main_trama_L0+20
	CLRF       main_trama_L0+21
	CLRF       main_trama_L0+22
	CLRF       main_trama_L0+23
	CLRF       main_trama_L0+24
	CLRF       main_size_L0+0
;Extractor.c,12 :: 		start();
	CALL       _start+0
;Extractor.c,13 :: 		for (j = 0; j < 3; j++)
	CLRF       main_j_L0+0
L_main0:
	MOVLW      3
	SUBWF      main_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main1
;Extractor.c,15 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
	NOP
;Extractor.c,16 :: 		UART1_Write_Text("Inicio");
	MOVLW      ?lstr1_Extractor+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Extractor.c,13 :: 		for (j = 0; j < 3; j++)
	INCF       main_j_L0+0, 1
;Extractor.c,17 :: 		}
	GOTO       L_main0
L_main1:
;Extractor.c,18 :: 		while (1) {
L_main4:
;Extractor.c,19 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main6
;Extractor.c,20 :: 		byteRecv = readData();
	CALL       _readData+0
;Extractor.c,21 :: 		if(byteRecv == ':'){
	MOVF       R0+0, 0
	XORLW      58
	BTFSS      STATUS+0, 2
	GOTO       L_main7
;Extractor.c,22 :: 		trama[0] = ascii2hex();
	CALL       _ascii2hex+0
	MOVF       R0+0, 0
	MOVWF      main_trama_L0+0
;Extractor.c,23 :: 		size = trama[0] + 0x05;
	MOVLW      5
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      main_size_L0+0
;Extractor.c,24 :: 		UART1_Write(size);
	MOVF       R0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Extractor.c,25 :: 		for(j = 1; j<size; j++){
	MOVLW      1
	MOVWF      main_j_L0+0
L_main8:
	MOVF       main_size_L0+0, 0
	SUBWF      main_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main9
;Extractor.c,26 :: 		trama[j] = ascii2hex();
	MOVF       main_j_L0+0, 0
	ADDLW      main_trama_L0+0
	MOVWF      FLOC__main+0
	CALL       _ascii2hex+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Extractor.c,25 :: 		for(j = 1; j<size; j++){
	INCF       main_j_L0+0, 1
;Extractor.c,28 :: 		}
	GOTO       L_main8
L_main9:
;Extractor.c,29 :: 		for(j = 0; j<trama[0]+4; j++)
	CLRF       main_j_L0+0
L_main11:
	MOVLW      4
	ADDWF      main_trama_L0+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main21
	MOVF       R1+0, 0
	SUBWF      main_j_L0+0, 0
L__main21:
	BTFSC      STATUS+0, 0
	GOTO       L_main12
	INCF       main_j_L0+0, 1
;Extractor.c,33 :: 		}
	GOTO       L_main11
L_main12:
;Extractor.c,38 :: 		}
L_main7:
;Extractor.c,39 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Extractor.c,40 :: 		}
L_main6:
;Extractor.c,41 :: 		}
	GOTO       L_main4
;Extractor.c,42 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_start:

;Extractor.c,43 :: 		void start() {
;Extractor.c,44 :: 		PORTB=0X00;
	CLRF       PORTB+0
;Extractor.c,45 :: 		ANSELH=0X00;
	CLRF       ANSELH+0
;Extractor.c,46 :: 		TRISB=0X00;
	CLRF       TRISB+0
;Extractor.c,47 :: 		UART1_Init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Extractor.c,48 :: 		Delay_ms(1);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      75
	MOVWF      R13+0
L_start14:
	DECFSZ     R13+0, 1
	GOTO       L_start14
	DECFSZ     R12+0, 1
	GOTO       L_start14
;Extractor.c,49 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Extractor.c,50 :: 		PORTB=0X00;
	CLRF       PORTB+0
;Extractor.c,51 :: 		}
L_end_start:
	RETURN
; end of _start

_ascii2hex:

;Extractor.c,52 :: 		unsigned char ascii2hex(){
;Extractor.c,53 :: 		unsigned char dato = 0x00;
	CLRF       ascii2hex_dato_L0+0
;Extractor.c,54 :: 		dato = mult(readData())<<4;
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
;Extractor.c,55 :: 		dato += mult(readData());
	CALL       _readData+0
	MOVF       R0+0, 0
	MOVWF      FARG_mult_dato+0
	CALL       _mult+0
	MOVF       ascii2hex_dato_L0+0, 0
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      ascii2hex_dato_L0+0
;Extractor.c,57 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Extractor.c,58 :: 		return dato;
;Extractor.c,59 :: 		}
L_end_ascii2hex:
	RETURN
; end of _ascii2hex

_mult:

;Extractor.c,60 :: 		unsigned char mult(unsigned char dato){
;Extractor.c,61 :: 		if (dato>='A'){
	MOVLW      65
	SUBWF      FARG_mult_dato+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_mult15
;Extractor.c,62 :: 		dato = (dato-55);
	MOVLW      55
	SUBWF      FARG_mult_dato+0, 1
;Extractor.c,63 :: 		}else{
	GOTO       L_mult16
L_mult15:
;Extractor.c,64 :: 		dato = (dato-48);
	MOVLW      48
	SUBWF      FARG_mult_dato+0, 1
;Extractor.c,65 :: 		}
L_mult16:
;Extractor.c,66 :: 		return dato;
	MOVF       FARG_mult_dato+0, 0
	MOVWF      R0+0
;Extractor.c,67 :: 		}
L_end_mult:
	RETURN
; end of _mult

_readData:

;Extractor.c,68 :: 		unsigned char readData(){
;Extractor.c,70 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Extractor.c,71 :: 		while (1){
L_readData17:
;Extractor.c,72 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readData19
;Extractor.c,73 :: 		dato = UART1_Read();
	CALL       _UART1_Read+0
;Extractor.c,74 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Extractor.c,75 :: 		return dato;
	GOTO       L_end_readData
;Extractor.c,76 :: 		}
L_readData19:
;Extractor.c,77 :: 		}
	GOTO       L_readData17
;Extractor.c,78 :: 		}
L_end_readData:
	RETURN
; end of _readData
