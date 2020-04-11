
_readData:

;Generalizador.c,3 :: 		unsigned char readData() {
;Generalizador.c,5 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Generalizador.c,6 :: 		while (1){
L_readData0:
;Generalizador.c,7 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readData2
;Generalizador.c,8 :: 		dato = UART1_Read();
	CALL       _UART1_Read+0
;Generalizador.c,9 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Generalizador.c,10 :: 		return dato;
	GOTO       L_end_readData
;Generalizador.c,11 :: 		}
L_readData2:
;Generalizador.c,12 :: 		}
	GOTO       L_readData0
;Generalizador.c,13 :: 		}
L_end_readData:
	RETURN
; end of _readData

_ascii2hex:

;Generalizador.c,15 :: 		unsigned char ascii2hex(){
;Generalizador.c,16 :: 		unsigned char dato = 0, datoh = 0;
	CLRF       ascii2hex_dato_L0+0
	CLRF       ascii2hex_datoh_L0+0
;Generalizador.c,17 :: 		dato = readData();
	CALL       _readData+0
	MOVF       R0+0, 0
	MOVWF      ascii2hex_dato_L0+0
;Generalizador.c,18 :: 		datoh = readData();
	CALL       _readData+0
	MOVF       R0+0, 0
	MOVWF      ascii2hex_datoh_L0+0
;Generalizador.c,19 :: 		dato = (dato>='A') ? (dato-55)<<4 : (dato-48)<<4;
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
;Generalizador.c,20 :: 		dato += (datoh>='A') ? datoh-55 : datoh-48;
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
;Generalizador.c,21 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Generalizador.c,22 :: 		return dato;
;Generalizador.c,23 :: 		}
L_end_ascii2hex:
	RETURN
; end of _ascii2hex

_write_eeprom:

;Generalizador.c,25 :: 		void write_eeprom(char * trama) {
;Generalizador.c,26 :: 		unsigned char i = 0, addrh = trama[1], addr = trama[2], size = trama[0]+5,  datal = 0, datah = 0;
	CLRF       write_eeprom_i_L0+0
	INCF       FARG_write_eeprom_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      write_eeprom_addrh_L0+0
	MOVLW      2
	ADDWF      FARG_write_eeprom_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      write_eeprom_addr_L0+0
;Generalizador.c,27 :: 		unsigned int dir = (addrh << 8 | addr)/2;
	MOVF       write_eeprom_addrh_L0+0, 0
	MOVWF      write_eeprom_dir_L0+1
	CLRF       write_eeprom_dir_L0+0
	MOVF       write_eeprom_addr_L0+0, 0
	IORWF      write_eeprom_dir_L0+0, 1
	MOVLW      0
	IORWF      write_eeprom_dir_L0+1, 1
	RRF        write_eeprom_dir_L0+1, 1
	RRF        write_eeprom_dir_L0+0, 1
	BCF        write_eeprom_dir_L0+1, 7
;Generalizador.c,28 :: 		unsigned int dataf =0;
	CLRF       write_eeprom_dataf_L0+0
	CLRF       write_eeprom_dataf_L0+1
;Generalizador.c,29 :: 		if(!((dir>0x1FFF))){
	MOVF       write_eeprom_dir_L0+1, 0
	SUBLW      31
	BTFSS      STATUS+0, 2
	GOTO       L__write_eeprom36
	MOVF       write_eeprom_dir_L0+0, 0
	SUBLW      255
L__write_eeprom36:
	BTFSS      STATUS+0, 0
	GOTO       L_write_eeprom7
;Generalizador.c,30 :: 		dir+=dir_offset;
	MOVLW      0
	ADDWF      write_eeprom_dir_L0+0, 0
	MOVWF      R3+0
	MOVF       write_eeprom_dir_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      2
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      write_eeprom_dir_L0+0
	MOVF       R3+1, 0
	MOVWF      write_eeprom_dir_L0+1
;Generalizador.c,31 :: 		addrh = dir>>8;
	MOVF       R3+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      write_eeprom_addrh_L0+0
;Generalizador.c,32 :: 		addr = dir;
	MOVF       R3+0, 0
	MOVWF      write_eeprom_addr_L0+0
;Generalizador.c,33 :: 		for(i = 0; i<trama[0]/2; i++){
	CLRF       write_eeprom_i_L0+0
L_write_eeprom8:
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
	GOTO       L_write_eeprom9
;Generalizador.c,34 :: 		datal = trama[i*2+4];
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
	MOVWF      R4+0
;Generalizador.c,35 :: 		datah = trama[i*2+5];
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
	MOVWF      R1+0
;Generalizador.c,36 :: 		dataf = (datah << 8 | datal);
	MOVF       R1+0, 0
	MOVWF      write_eeprom_dataf_L0+1
	CLRF       write_eeprom_dataf_L0+0
	MOVF       R4+0, 0
	IORWF      write_eeprom_dataf_L0+0, 1
	MOVLW      0
	IORWF      write_eeprom_dataf_L0+1, 1
;Generalizador.c,37 :: 		if(datah==0x28) dataf+=dir_offset;
	MOVF       R1+0, 0
	XORLW      40
	BTFSS      STATUS+0, 2
	GOTO       L_write_eeprom11
	MOVLW      0
	ADDWF      write_eeprom_dataf_L0+0, 1
	MOVLW      2
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      write_eeprom_dataf_L0+1, 1
L_write_eeprom11:
;Generalizador.c,38 :: 		EEADR = addr;
	MOVF       write_eeprom_addr_L0+0, 0
	MOVWF      EEADR+0
;Generalizador.c,39 :: 		EEADRH = addrh;
	MOVF       write_eeprom_addrh_L0+0, 0
	MOVWF      EEADRH+0
;Generalizador.c,40 :: 		EEDATA = dataf;
	MOVF       write_eeprom_dataf_L0+0, 0
	MOVWF      EEDATA+0
;Generalizador.c,41 :: 		EEDATH = dataf>>8;
	MOVF       write_eeprom_dataf_L0+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      EEDATH+0
;Generalizador.c,42 :: 		EECON1.EEPGD = 1;
	BSF        EECON1+0, 7
;Generalizador.c,43 :: 		EECON1.WREN = 1;
	BSF        EECON1+0, 2
;Generalizador.c,44 :: 		INTCON.GIE = 0;
	BCF        INTCON+0, 7
;Generalizador.c,45 :: 		EECON2 = 0x55;
	MOVLW      85
	MOVWF      EECON2+0
;Generalizador.c,46 :: 		EECON2 = 0xAA;
	MOVLW      170
	MOVWF      EECON2+0
;Generalizador.c,47 :: 		EECON1.WR = 1;
	BSF        EECON1+0, 1
;Generalizador.c,49 :: 		nop
	NOP
;Generalizador.c,50 :: 		nop
	NOP
;Generalizador.c,52 :: 		while(EECON1.WR);
L_write_eeprom12:
	BTFSS      EECON1+0, 1
	GOTO       L_write_eeprom13
	GOTO       L_write_eeprom12
L_write_eeprom13:
;Generalizador.c,53 :: 		INTCON.GIE = 1;
	BSF        INTCON+0, 7
;Generalizador.c,54 :: 		if(addr == 0xFF) addrh+=0x01;
	MOVF       write_eeprom_addr_L0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_write_eeprom14
	INCF       write_eeprom_addrh_L0+0, 1
L_write_eeprom14:
;Generalizador.c,55 :: 		addr+=0x01;
	INCF       write_eeprom_addr_L0+0, 1
;Generalizador.c,33 :: 		for(i = 0; i<trama[0]/2; i++){
	INCF       write_eeprom_i_L0+0, 1
;Generalizador.c,56 :: 		}
	GOTO       L_write_eeprom8
L_write_eeprom9:
;Generalizador.c,57 :: 		}
L_write_eeprom7:
;Generalizador.c,58 :: 		UART1_Write_Text("OK\n");
	MOVLW      ?lstr1_Generalizador+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Generalizador.c,59 :: 		}
L_end_write_eeprom:
	RETURN
; end of _write_eeprom

_main:

;Generalizador.c,61 :: 		void main() {
;Generalizador.c,62 :: 		unsigned char * trama[25] = {0};
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
;Generalizador.c,63 :: 		unsigned char size = 0, j = 0, check = 0;
	CLRF       main_size_L0+0
	CLRF       main_j_L0+0
	CLRF       main_check_L0+0
;Generalizador.c,64 :: 		TRISB=0X00;
	CLRF       TRISB+0
;Generalizador.c,65 :: 		UART1_Init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Generalizador.c,66 :: 		PORTB=0XFF;
	MOVLW      255
	MOVWF      PORTB+0
;Generalizador.c,67 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	DECFSZ     R11+0, 1
	GOTO       L_main15
	NOP
	NOP
;Generalizador.c,68 :: 		PORTB=0X00;
	CLRF       PORTB+0
;Generalizador.c,69 :: 		while (1) {
L_main16:
;Generalizador.c,70 :: 		check = 0;
	CLRF       main_check_L0+0
;Generalizador.c,71 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main18
;Generalizador.c,72 :: 		check = readData();
	CALL       _readData+0
	MOVF       R0+0, 0
	MOVWF      main_check_L0+0
;Generalizador.c,73 :: 		if(check == ':'){
	MOVF       R0+0, 0
	XORLW      58
	BTFSS      STATUS+0, 2
	GOTO       L_main19
;Generalizador.c,74 :: 		trama[0] = ascii2hex();
	CALL       _ascii2hex+0
	MOVF       R0+0, 0
	MOVWF      main_trama_L0+0
;Generalizador.c,75 :: 		check = trama[0];
	MOVF       R0+0, 0
	MOVWF      main_check_L0+0
;Generalizador.c,76 :: 		size = trama[0] + 0x05;
	MOVLW      5
	ADDWF      R0+0, 0
	MOVWF      main_size_L0+0
;Generalizador.c,77 :: 		for(j = 1; j<size; j++){
	MOVLW      1
	MOVWF      main_j_L0+0
L_main20:
	MOVF       main_size_L0+0, 0
	SUBWF      main_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main21
;Generalizador.c,78 :: 		trama[j] = ascii2hex();
	MOVF       main_j_L0+0, 0
	ADDLW      main_trama_L0+0
	MOVWF      FLOC__main+0
	CALL       _ascii2hex+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Generalizador.c,79 :: 		check += trama[j];
	MOVF       main_j_L0+0, 0
	ADDLW      main_trama_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      main_check_L0+0, 1
;Generalizador.c,77 :: 		for(j = 1; j<size; j++){
	INCF       main_j_L0+0, 1
;Generalizador.c,80 :: 		}
	GOTO       L_main20
L_main21:
;Generalizador.c,81 :: 		check -= trama[size-1];
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
;Generalizador.c,82 :: 		check = ~check + 1;
	COMF       R0+0, 1
	INCF       R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      main_check_L0+0
;Generalizador.c,83 :: 		check = (check == (unsigned char)trama[size-1]);
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
;Generalizador.c,84 :: 		check ? write_eeprom(trama) : UART1_Write_Text("BAD\n");
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main23
	MOVLW      main_trama_L0+0
	MOVWF      FARG_write_eeprom_trama+0
	CALL       _write_eeprom+0
	GOTO       L_main24
L_main23:
	MOVLW      ?lstr2_Generalizador+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
L_main24:
;Generalizador.c,85 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Generalizador.c,86 :: 		if(!trama[0] && check) {
	MOVF       main_trama_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main27
	MOVF       main_check_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main27
L__main28:
;Generalizador.c,87 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Generalizador.c,88 :: 		UART1_Write_Text("STR\n");
	MOVLW      ?lstr3_Generalizador+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Generalizador.c,90 :: 		goto dir_offset;
	GOTO       512
;Generalizador.c,92 :: 		}
L_main27:
;Generalizador.c,93 :: 		}
L_main19:
;Generalizador.c,94 :: 		}
L_main18:
;Generalizador.c,95 :: 		}
	GOTO       L_main16
;Generalizador.c,96 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
