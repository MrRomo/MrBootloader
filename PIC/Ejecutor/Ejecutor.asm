
_readData:

;Ejecutor.c,3 :: 		unsigned char readData(){
;Ejecutor.c,5 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Ejecutor.c,6 :: 		while (1){
L_readData0:
;Ejecutor.c,7 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readData2
;Ejecutor.c,8 :: 		dato = UART1_Read();
	CALL       _UART1_Read+0
;Ejecutor.c,9 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Ejecutor.c,10 :: 		return dato;
	GOTO       L_end_readData
;Ejecutor.c,11 :: 		}
L_readData2:
;Ejecutor.c,12 :: 		}
	GOTO       L_readData0
;Ejecutor.c,13 :: 		}
L_end_readData:
	RETURN
; end of _readData

_ascii2hex:

;Ejecutor.c,15 :: 		unsigned char ascii2hex(){
;Ejecutor.c,16 :: 		unsigned char dato = 0, datoh = 0;
	CLRF       ascii2hex_dato_L0+0
	CLRF       ascii2hex_datoh_L0+0
;Ejecutor.c,17 :: 		dato = readData();
	CALL       _readData+0
	MOVF       R0+0, 0
	MOVWF      ascii2hex_dato_L0+0
;Ejecutor.c,18 :: 		datoh = readData();
	CALL       _readData+0
	MOVF       R0+0, 0
	MOVWF      ascii2hex_datoh_L0+0
;Ejecutor.c,19 :: 		dato = (dato>='A') ? (dato-55)<<4 : (dato-48)<<4;
	MOVLW      65
	SUBWF      ascii2hex_dato_L0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_ascii2hex3
	MOVLW      55
	SUBWF      ascii2hex_dato_L0+0, 0
	MOVWF      ?FLOC___ascii2hexT3+0
	MOVLW      4
	MOVWF      R0+0
	MOVLW      0
	MOVWF      ?FLOC___ascii2hexT3+1
	MOVF       R0+0, 0
L__ascii2hex31:
	BTFSC      STATUS+0, 2
	GOTO       L__ascii2hex32
	RLF        ?FLOC___ascii2hexT3+0, 1
	RLF        ?FLOC___ascii2hexT3+1, 1
	BCF        ?FLOC___ascii2hexT3+0, 0
	ADDLW      255
	GOTO       L__ascii2hex31
L__ascii2hex32:
	GOTO       L_ascii2hex4
L_ascii2hex3:
	MOVLW      48
	SUBWF      ascii2hex_dato_L0+0, 0
	MOVWF      ?FLOC___ascii2hexT3+0
	MOVLW      4
	MOVWF      R0+0
	MOVLW      0
	MOVWF      ?FLOC___ascii2hexT3+1
	MOVF       R0+0, 0
L__ascii2hex33:
	BTFSC      STATUS+0, 2
	GOTO       L__ascii2hex34
	RLF        ?FLOC___ascii2hexT3+0, 1
	RLF        ?FLOC___ascii2hexT3+1, 1
	BCF        ?FLOC___ascii2hexT3+0, 0
	ADDLW      255
	GOTO       L__ascii2hex33
L__ascii2hex34:
L_ascii2hex4:
	MOVF       ?FLOC___ascii2hexT3+0, 0
	MOVWF      ascii2hex_dato_L0+0
;Ejecutor.c,20 :: 		dato += (datoh>='A') ? datoh-55 : datoh-48;
	MOVLW      65
	SUBWF      ascii2hex_datoh_L0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_ascii2hex5
	MOVLW      55
	SUBWF      ascii2hex_datoh_L0+0, 0
	MOVWF      ?FLOC___ascii2hexT8+0
	MOVLW      0
	MOVWF      ?FLOC___ascii2hexT8+1
	GOTO       L_ascii2hex6
L_ascii2hex5:
	MOVLW      48
	SUBWF      ascii2hex_datoh_L0+0, 0
	MOVWF      ?FLOC___ascii2hexT8+0
	MOVLW      0
	MOVWF      ?FLOC___ascii2hexT8+1
L_ascii2hex6:
	MOVF       ?FLOC___ascii2hexT8+0, 0
	ADDWF      ascii2hex_dato_L0+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      ascii2hex_dato_L0+0
;Ejecutor.c,21 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Ejecutor.c,22 :: 		return dato;
;Ejecutor.c,23 :: 		}
L_end_ascii2hex:
	RETURN
; end of _ascii2hex

_write_eeprom:

;Ejecutor.c,25 :: 		void write_eeprom(char * trama){
;Ejecutor.c,26 :: 		unsigned char i = 0, addrh = trama[1], addr = trama[2], size = trama[0]+5;
	CLRF       write_eeprom_i_L0+0
	INCF       FARG_write_eeprom_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R4+0
	MOVF       R4+0, 0
	MOVWF      write_eeprom_addrh_L0+0
	MOVLW      2
	ADDWF      FARG_write_eeprom_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R3+0
	MOVF       R3+0, 0
	MOVWF      write_eeprom_addr_L0+0
;Ejecutor.c,27 :: 		unsigned int dir = (addrh << 8 | addr)/2;
	MOVF       R4+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       R3+0, 0
	IORWF      R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	MOVLW      0
	IORWF      R2+1, 1
	MOVF       R2+0, 0
	MOVWF      R4+0
	MOVF       R2+1, 0
	MOVWF      R4+1
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	MOVF       R4+0, 0
	MOVWF      write_eeprom_dir_L0+0
	MOVF       R4+1, 0
	MOVWF      write_eeprom_dir_L0+1
;Ejecutor.c,28 :: 		addrh = dir>>8;
	MOVF       R4+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      write_eeprom_addrh_L0+0
;Ejecutor.c,29 :: 		addr = dir;
	MOVF       R4+0, 0
	MOVWF      write_eeprom_addr_L0+0
;Ejecutor.c,30 :: 		if(!((dir==0x0000)||(dir>0x1FFF))){
	MOVLW      0
	XORWF      R4+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__write_eeprom36
	MOVLW      0
	XORWF      R4+0, 0
L__write_eeprom36:
	BTFSC      STATUS+0, 2
	GOTO       L_write_eeprom8
	MOVF       write_eeprom_dir_L0+1, 0
	SUBLW      31
	BTFSS      STATUS+0, 2
	GOTO       L__write_eeprom37
	MOVF       write_eeprom_dir_L0+0, 0
	SUBLW      255
L__write_eeprom37:
	BTFSS      STATUS+0, 0
	GOTO       L_write_eeprom8
	CLRF       R0+0
	GOTO       L_write_eeprom7
L_write_eeprom8:
	MOVLW      1
	MOVWF      R0+0
L_write_eeprom7:
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_write_eeprom9
;Ejecutor.c,31 :: 		for(i = 0; i<trama[0]/2; i++){
	CLRF       write_eeprom_i_L0+0
L_write_eeprom10:
	MOVF       FARG_write_eeprom_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R1+0
	RRF        R1+0, 1
	BCF        R1+0, 7
	MOVF       R1+0, 0
	SUBWF      write_eeprom_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_write_eeprom11
;Ejecutor.c,32 :: 		EEADR = addr;
	MOVF       write_eeprom_addr_L0+0, 0
	MOVWF      EEADR+0
;Ejecutor.c,33 :: 		EEADRH = addrh;
	MOVF       write_eeprom_addrh_L0+0, 0
	MOVWF      EEADRH+0
;Ejecutor.c,34 :: 		EEDATA = trama[i*2+4];
	MOVF       write_eeprom_i_L0+0, 0
	MOVWF      R2+0
	CLRF       R2+1
	RLF        R2+0, 1
	RLF        R2+1, 1
	BCF        R2+0, 0
	MOVLW      4
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      FARG_write_eeprom_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      EEDATA+0
;Ejecutor.c,35 :: 		EEDATH = trama[i*2+5];
	MOVLW      5
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      FARG_write_eeprom_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      EEDATH+0
;Ejecutor.c,36 :: 		EECON1.EEPGD = 1;
	BSF        EECON1+0, 7
;Ejecutor.c,37 :: 		EECON1.WREN = 1;
	BSF        EECON1+0, 2
;Ejecutor.c,38 :: 		INTCON.GIE = 0;
	BCF        INTCON+0, 7
;Ejecutor.c,39 :: 		EECON2 = 0x55;
	MOVLW      85
	MOVWF      EECON2+0
;Ejecutor.c,40 :: 		EECON2 = 0xAA;
	MOVLW      170
	MOVWF      EECON2+0
;Ejecutor.c,41 :: 		EECON1.WR = 1;
	BSF        EECON1+0, 1
;Ejecutor.c,43 :: 		nop
	NOP
;Ejecutor.c,44 :: 		nop
	NOP
;Ejecutor.c,46 :: 		while(EECON1.WR);
L_write_eeprom13:
	BTFSS      EECON1+0, 1
	GOTO       L_write_eeprom14
	GOTO       L_write_eeprom13
L_write_eeprom14:
;Ejecutor.c,47 :: 		INTCON.GIE = 1;
	BSF        INTCON+0, 7
;Ejecutor.c,48 :: 		if(addr == 0xFF) addrh+=0x01;
	MOVF       write_eeprom_addr_L0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_write_eeprom15
	INCF       write_eeprom_addrh_L0+0, 1
L_write_eeprom15:
;Ejecutor.c,49 :: 		addr+=0x01;
	INCF       write_eeprom_addr_L0+0, 1
;Ejecutor.c,31 :: 		for(i = 0; i<trama[0]/2; i++){
	INCF       write_eeprom_i_L0+0, 1
;Ejecutor.c,50 :: 		}
	GOTO       L_write_eeprom10
L_write_eeprom11:
;Ejecutor.c,51 :: 		}
L_write_eeprom9:
;Ejecutor.c,52 :: 		UART1_Write_Text("OK\n");
	MOVLW      ?lstr1_Ejecutor+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Ejecutor.c,53 :: 		}
L_end_write_eeprom:
	RETURN
; end of _write_eeprom

_main:

;Ejecutor.c,55 :: 		void main() {
;Ejecutor.c,56 :: 		unsigned char * trama[25] = {0};
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
;Ejecutor.c,57 :: 		unsigned char size = 0, j = 0, check = 0;
	CLRF       main_size_L0+0
	CLRF       main_j_L0+0
	CLRF       main_check_L0+0
;Ejecutor.c,58 :: 		TRISB=0X00;
	CLRF       TRISB+0
;Ejecutor.c,59 :: 		UART1_Init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Ejecutor.c,60 :: 		PORTB=0X00;
	CLRF       PORTB+0
;Ejecutor.c,61 :: 		while (1) {
L_main16:
;Ejecutor.c,62 :: 		check = 0;
	CLRF       main_check_L0+0
;Ejecutor.c,63 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main18
;Ejecutor.c,64 :: 		check = readData();
	CALL       _readData+0
	MOVF       R0+0, 0
	MOVWF      main_check_L0+0
;Ejecutor.c,65 :: 		if(check == ':'){
	MOVF       R0+0, 0
	XORLW      58
	BTFSS      STATUS+0, 2
	GOTO       L_main19
;Ejecutor.c,66 :: 		trama[0] = ascii2hex();
	CALL       _ascii2hex+0
	MOVF       R0+0, 0
	MOVWF      main_trama_L0+0
;Ejecutor.c,67 :: 		check = trama[0];
	MOVF       R0+0, 0
	MOVWF      main_check_L0+0
;Ejecutor.c,68 :: 		size = trama[0] + 0x05;
	MOVLW      5
	ADDWF      R0+0, 0
	MOVWF      main_size_L0+0
;Ejecutor.c,69 :: 		for(j = 1; j<size; j++){
	MOVLW      1
	MOVWF      main_j_L0+0
L_main20:
	MOVF       main_size_L0+0, 0
	SUBWF      main_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main21
;Ejecutor.c,70 :: 		trama[j] = ascii2hex();
	MOVF       main_j_L0+0, 0
	ADDLW      main_trama_L0+0
	MOVWF      FLOC__main+0
	CALL       _ascii2hex+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Ejecutor.c,71 :: 		check += trama[j];
	MOVF       main_j_L0+0, 0
	ADDLW      main_trama_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      main_check_L0+0, 1
;Ejecutor.c,69 :: 		for(j = 1; j<size; j++){
	INCF       main_j_L0+0, 1
;Ejecutor.c,72 :: 		}
	GOTO       L_main20
L_main21:
;Ejecutor.c,73 :: 		check -= trama[size-1];
	MOVLW      1
	SUBWF      main_size_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      main_trama_L0+0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      main_check_L0+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      main_check_L0+0
;Ejecutor.c,74 :: 		check = ~check + 1;
	COMF       R0+0, 1
	INCF       R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      main_check_L0+0
;Ejecutor.c,75 :: 		check = (check == (unsigned char)trama[size-1]);
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R1+0, 0
	XORWF      INDF+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      main_check_L0+0
;Ejecutor.c,76 :: 		check ? write_eeprom(trama) : UART1_Write_Text("BAD\n");
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main23
	MOVLW      main_trama_L0+0
	MOVWF      FARG_write_eeprom_trama+0
	CALL       _write_eeprom+0
	GOTO       L_main24
L_main23:
	MOVLW      ?lstr2_Ejecutor+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
L_main24:
;Ejecutor.c,77 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Ejecutor.c,78 :: 		if(!trama[0] && check) {
	MOVF       main_trama_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main27
	MOVF       main_check_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main27
L__main28:
;Ejecutor.c,79 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Ejecutor.c,80 :: 		UART1_Write_Text("STR\n");
	MOVLW      ?lstr3_Ejecutor+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Ejecutor.c,82 :: 		goto dir_offset;
	GOTO       1280
;Ejecutor.c,84 :: 		}
L_main27:
;Ejecutor.c,85 :: 		}
L_main19:
;Ejecutor.c,86 :: 		}
L_main18:
;Ejecutor.c,87 :: 		}
	GOTO       L_main16
;Ejecutor.c,88 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
