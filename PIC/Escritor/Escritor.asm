
_read_eeprom:

;eeprom_manager.c,1 :: 		unsigned int read_eeprom( char addrh, char addr) {
;eeprom_manager.c,3 :: 		EEADR = addr;
	MOVF       FARG_read_eeprom_addr+0, 0
	MOVWF      EEADR+0
;eeprom_manager.c,4 :: 		EEADRH = addrh;
	MOVF       FARG_read_eeprom_addrh+0, 0
	MOVWF      EEADRH+0
;eeprom_manager.c,5 :: 		EEDAT = 0X00; //Limpieza del registro
	CLRF       EEDAT+0
;eeprom_manager.c,6 :: 		EEDATH = 0X00; //Limpieza del registro
	CLRF       EEDATH+0
;eeprom_manager.c,7 :: 		EECON1.EEPGD = 1;
	BSF        EECON1+0, 7
;eeprom_manager.c,8 :: 		EECON1.RD = 1; //Inicio de Lectura
	BSF        EECON1+0, 0
;eeprom_manager.c,10 :: 		nop
	NOP
;eeprom_manager.c,11 :: 		nop
	NOP
;eeprom_manager.c,13 :: 		while(EECON1.RD);
L_read_eeprom0:
	BTFSS      EECON1+0, 0
	GOTO       L_read_eeprom1
	GOTO       L_read_eeprom0
L_read_eeprom1:
;eeprom_manager.c,14 :: 		UART1_Write(EEDAT);
	MOVF       EEDAT+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;eeprom_manager.c,15 :: 		UART1_Write(EEDATH);
	MOVF       EEDATH+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;eeprom_manager.c,16 :: 		response = EEDATH;
	MOVF       EEDATH+0, 0
	MOVWF      read_eeprom_response_L0+0
	CLRF       read_eeprom_response_L0+1
;eeprom_manager.c,17 :: 		response = response<<8;
	MOVF       read_eeprom_response_L0+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       R0+0, 0
	MOVWF      read_eeprom_response_L0+0
	MOVF       R0+1, 0
	MOVWF      read_eeprom_response_L0+1
;eeprom_manager.c,18 :: 		response |= EEDAT;
	MOVF       EEDAT+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      read_eeprom_response_L0+0
	MOVF       R0+1, 0
	MOVWF      read_eeprom_response_L0+1
;eeprom_manager.c,19 :: 		return(response);
;eeprom_manager.c,20 :: 		}
L_end_read_eeprom:
	RETURN
; end of _read_eeprom

_write_eeprom:

;eeprom_manager.c,22 :: 		void write_eeprom(char addrh,char addr, char datoh ,char dato){
;eeprom_manager.c,23 :: 		EEADR = addr;
	MOVF       FARG_write_eeprom_addr+0, 0
	MOVWF      EEADR+0
;eeprom_manager.c,24 :: 		EEADRH = addrh;
	MOVF       FARG_write_eeprom_addrh+0, 0
	MOVWF      EEADRH+0
;eeprom_manager.c,25 :: 		EEDATA = dato;
	MOVF       FARG_write_eeprom_dato+0, 0
	MOVWF      EEDATA+0
;eeprom_manager.c,26 :: 		EEDATH = datoh;
	MOVF       FARG_write_eeprom_datoh+0, 0
	MOVWF      EEDATH+0
;eeprom_manager.c,27 :: 		EECON1.EEPGD = 1;
	BSF        EECON1+0, 7
;eeprom_manager.c,28 :: 		EECON1.WREN = 1;
	BSF        EECON1+0, 2
;eeprom_manager.c,29 :: 		INTCON.GIE = 0;
	BCF        INTCON+0, 7
;eeprom_manager.c,30 :: 		EECON2 = 0x55;
	MOVLW      85
	MOVWF      EECON2+0
;eeprom_manager.c,31 :: 		EECON2 = 0xAA;
	MOVLW      170
	MOVWF      EECON2+0
;eeprom_manager.c,32 :: 		EECON1.WR = 1;
	BSF        EECON1+0, 1
;eeprom_manager.c,34 :: 		nop
	NOP
;eeprom_manager.c,35 :: 		nop
	NOP
;eeprom_manager.c,37 :: 		while(EECON1.WR);
L_write_eeprom2:
	BTFSS      EECON1+0, 1
	GOTO       L_write_eeprom3
	GOTO       L_write_eeprom2
L_write_eeprom3:
;eeprom_manager.c,38 :: 		INTCON.GIE = 1;
	BSF        INTCON+0, 7
;eeprom_manager.c,39 :: 		}
L_end_write_eeprom:
	RETURN
; end of _write_eeprom

_readData:

;uart_manager.c,2 :: 		unsigned char readData(){
;uart_manager.c,4 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;uart_manager.c,5 :: 		while (1){
L_readData4:
;uart_manager.c,6 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readData6
;uart_manager.c,7 :: 		dato = UART1_Read();
	CALL       _UART1_Read+0
;uart_manager.c,8 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;uart_manager.c,9 :: 		return dato;
	GOTO       L_end_readData
;uart_manager.c,10 :: 		}
L_readData6:
;uart_manager.c,11 :: 		}
	GOTO       L_readData4
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
	GOTO       L_mult7
;uart_manager.c,15 :: 		return dato-55;
	MOVLW      55
	SUBWF      FARG_mult_dato+0, 0
	MOVWF      R0+0
	GOTO       L_end_mult
;uart_manager.c,16 :: 		}else{
L_mult7:
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
L_check_sum9:
	MOVF       R3+0, 0
	SUBWF      check_sum_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_sum10
;uart_manager.c,33 :: 		checksum += trama[j];
	MOVF       check_sum_j_L0+0, 0
	ADDWF      FARG_check_sum_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R2+0, 1
;uart_manager.c,31 :: 		for(j = 0; j<size; j++)
	INCF       check_sum_j_L0+0, 1
;uart_manager.c,35 :: 		}
	GOTO       L_check_sum9
L_check_sum10:
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

_main:

;Escritor.c,9 :: 		void main() {
;Escritor.c,10 :: 		unsigned char * trama[21] = {0};
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
;Escritor.c,11 :: 		unsigned char size = 0x00;
	CLRF       main_size_L0+0
	CLRF       main_j_L0+0
;Escritor.c,16 :: 		start();
	CALL       _start+0
;Escritor.c,17 :: 		while (1) {
L_main12:
;Escritor.c,18 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
;Escritor.c,19 :: 		byteRecv = readData();
	CALL       _readData+0
;Escritor.c,20 :: 		if(byteRecv == ':'){
	MOVF       R0+0, 0
	XORLW      58
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;Escritor.c,21 :: 		trama[0] = ascii2hex();
	CALL       _ascii2hex+0
	MOVF       R0+0, 0
	MOVWF      main_trama_L0+0
;Escritor.c,22 :: 		size = trama[0] + 0x05;
	MOVLW      5
	ADDWF      R0+0, 0
	MOVWF      main_size_L0+0
;Escritor.c,23 :: 		for(j = 1; j<size; j++){
	MOVLW      1
	MOVWF      main_j_L0+0
L_main16:
	MOVF       main_size_L0+0, 0
	SUBWF      main_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main17
;Escritor.c,24 :: 		trama[j] = ascii2hex();
	MOVF       main_j_L0+0, 0
	ADDLW      main_trama_L0+0
	MOVWF      FLOC__main+0
	CALL       _ascii2hex+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Escritor.c,23 :: 		for(j = 1; j<size; j++){
	INCF       main_j_L0+0, 1
;Escritor.c,25 :: 		}
	GOTO       L_main16
L_main17:
;Escritor.c,26 :: 		check = check_sum(trama);
	MOVLW      main_trama_L0+0
	MOVWF      FARG_check_sum_trama+0
	CALL       _check_sum+0
;Escritor.c,27 :: 		check ? write_intel(trama) : UART1_Write_Text("BAD\n");
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	MOVLW      main_trama_L0+0
	MOVWF      FARG_write_intel_trama+0
	CALL       _write_intel+0
	GOTO       L_main20
L_main19:
	MOVLW      ?lstr1_Escritor+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
L_main20:
;Escritor.c,28 :: 		j = 0;
	CLRF       main_j_L0+0
;Escritor.c,29 :: 		for(j = 0; j<size; j++){
	CLRF       main_j_L0+0
L_main21:
	MOVF       main_size_L0+0, 0
	SUBWF      main_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main22
;Escritor.c,30 :: 		UART1_Write(trama[j]);
	MOVF       main_j_L0+0, 0
	ADDLW      main_trama_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Escritor.c,31 :: 		trama[j] = 0x00;
	MOVF       main_j_L0+0, 0
	ADDLW      main_trama_L0+0
	MOVWF      FSR
	CLRF       INDF+0
;Escritor.c,29 :: 		for(j = 0; j<size; j++){
	INCF       main_j_L0+0, 1
;Escritor.c,32 :: 		}
	GOTO       L_main21
L_main22:
;Escritor.c,33 :: 		j = 0;
	CLRF       main_j_L0+0
;Escritor.c,34 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Escritor.c,35 :: 		}
L_main15:
;Escritor.c,36 :: 		}
L_main14:
;Escritor.c,37 :: 		}
	GOTO       L_main12
;Escritor.c,38 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_write_intel:

;Escritor.c,39 :: 		void write_intel(unsigned char * trama){
;Escritor.c,40 :: 		unsigned char i = 0, addrh = trama[1], addr = trama[2], size = trama[0]+5;
	CLRF       write_intel_i_L0+0
	INCF       FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R3+0
	MOVLW      2
	ADDWF      FARG_write_intel_trama+0, 0
	MOVWF      FSR
;Escritor.c,41 :: 		unsigned int dir = (addrh << 8 | addr)/2;
	MOVF       R3+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       INDF+0, 0
	IORWF      R0+0, 0
	MOVWF      R3+0
	MOVF       R0+1, 0
	MOVWF      R3+1
	MOVLW      0
	IORWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R1+0
	MOVF       R3+1, 0
	MOVWF      R1+1
	RRF        R1+1, 1
	RRF        R1+0, 1
	BCF        R1+1, 7
	MOVF       R1+0, 0
	MOVWF      write_intel_dir_L0+0
	MOVF       R1+1, 0
	MOVWF      write_intel_dir_L0+1
;Escritor.c,42 :: 		if(dir == 0x0000){
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__write_intel42
	MOVLW      0
	XORWF      R1+0, 0
L__write_intel42:
	BTFSS      STATUS+0, 2
	GOTO       L_write_intel24
;Escritor.c,43 :: 		UART1_Write_Text("STR\n");
	MOVLW      ?lstr2_Escritor+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Escritor.c,44 :: 		}
L_write_intel24:
;Escritor.c,45 :: 		if(dir>0x1FFF) {
	MOVF       write_intel_dir_L0+1, 0
	SUBLW      31
	BTFSS      STATUS+0, 2
	GOTO       L__write_intel43
	MOVF       write_intel_dir_L0+0, 0
	SUBLW      255
L__write_intel43:
	BTFSC      STATUS+0, 0
	GOTO       L_write_intel25
;Escritor.c,46 :: 		UART1_Write_Text("END\n");
	MOVLW      ?lstr3_Escritor+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Escritor.c,47 :: 		}else{
	GOTO       L_write_intel26
L_write_intel25:
;Escritor.c,48 :: 		trama[2] = dir;
	MOVLW      2
	ADDWF      FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       write_intel_dir_L0+0, 0
	MOVWF      INDF+0
;Escritor.c,49 :: 		trama[1] = dir>>8;
	INCF       FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       write_intel_dir_L0+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Escritor.c,50 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Escritor.c,51 :: 		for(i = 0; i<trama[0]; i+=2){
	CLRF       write_intel_i_L0+0
L_write_intel27:
	MOVF       FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      write_intel_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_write_intel28
;Escritor.c,52 :: 		delay_ms(1);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      75
	MOVWF      R13+0
L_write_intel30:
	DECFSZ     R13+0, 1
	GOTO       L_write_intel30
	DECFSZ     R12+0, 1
	GOTO       L_write_intel30
;Escritor.c,53 :: 		write_eeprom(trama[1], trama[2], trama[i+0x05], trama[i+0x04]);
	INCF       FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_write_eeprom_addrh+0
	MOVLW      2
	ADDWF      FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_write_eeprom_addr+0
	MOVLW      5
	ADDWF      write_intel_i_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDWF      FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_write_eeprom_datoh+0
	MOVLW      4
	ADDWF      write_intel_i_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDWF      FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_write_eeprom_dato+0
	CALL       _write_eeprom+0
;Escritor.c,54 :: 		if(trama[2] == 0xFF) trama[1]+=0x01;
	MOVLW      2
	ADDWF      FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_write_intel31
	INCF       FARG_write_intel_trama+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	INCF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
L_write_intel31:
;Escritor.c,55 :: 		trama[2]+=0x01;
	MOVLW      2
	ADDWF      FARG_write_intel_trama+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	INCF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Escritor.c,56 :: 		delay_ms(1);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      75
	MOVWF      R13+0
L_write_intel32:
	DECFSZ     R13+0, 1
	GOTO       L_write_intel32
	DECFSZ     R12+0, 1
	GOTO       L_write_intel32
;Escritor.c,57 :: 		i = 0;
	CLRF       write_intel_i_L0+0
;Escritor.c,58 :: 		UART1_Write_Text("OK\n");
	MOVLW      ?lstr4_Escritor+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Escritor.c,51 :: 		for(i = 0; i<trama[0]; i+=2){
	MOVLW      2
	ADDWF      write_intel_i_L0+0, 1
;Escritor.c,59 :: 		}
	GOTO       L_write_intel27
L_write_intel28:
;Escritor.c,60 :: 		}
L_write_intel26:
;Escritor.c,61 :: 		}
L_end_write_intel:
	RETURN
; end of _write_intel

_start:

;Escritor.c,63 :: 		void start() {
;Escritor.c,64 :: 		ANSELH=0X00;
	CLRF       ANSELH+0
;Escritor.c,65 :: 		TRISB=0X00;
	CLRF       TRISB+0
;Escritor.c,66 :: 		PORTB=0XFF;
	MOVLW      255
	MOVWF      PORTB+0
;Escritor.c,67 :: 		UART1_Init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Escritor.c,68 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_start33:
	DECFSZ     R13+0, 1
	GOTO       L_start33
	DECFSZ     R12+0, 1
	GOTO       L_start33
	DECFSZ     R11+0, 1
	GOTO       L_start33
	NOP
	NOP
;Escritor.c,69 :: 		PORTB=0X00;
	CLRF       PORTB+0
;Escritor.c,70 :: 		UART1_Write_Text("MrBurner Ready");
	MOVLW      ?lstr5_Escritor+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Escritor.c,71 :: 		}
L_end_start:
	RETURN
; end of _start
