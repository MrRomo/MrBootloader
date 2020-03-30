
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

;eeprom_manager.c,22 :: 		void write_eeprom(char * trama){
;eeprom_manager.c,24 :: 		unsigned char i = 0, addrh = trama[1], addr = trama[2], size = trama[0]+5;
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
;eeprom_manager.c,25 :: 		unsigned int dir = (addrh << 8 | addr)/2;
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
;eeprom_manager.c,26 :: 		addrh = dir>>8;
	MOVF       R4+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      write_eeprom_addrh_L0+0
;eeprom_manager.c,27 :: 		addr = dir;
	MOVF       R4+0, 0
	MOVWF      write_eeprom_addr_L0+0
;eeprom_manager.c,28 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;eeprom_manager.c,30 :: 		for(i = 0; i<trama[0]/2; i++){
	CLRF       write_eeprom_i_L0+0
L_write_eeprom2:
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
	GOTO       L_write_eeprom3
;eeprom_manager.c,31 :: 		EEADR = addr;
	MOVF       write_eeprom_addr_L0+0, 0
	MOVWF      EEADR+0
;eeprom_manager.c,32 :: 		EEADRH = addrh;
	MOVF       write_eeprom_addrh_L0+0, 0
	MOVWF      EEADRH+0
;eeprom_manager.c,33 :: 		EEDATA = trama[i*2+4];
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
;eeprom_manager.c,34 :: 		EEDATH = trama[i*2+5];
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
;eeprom_manager.c,35 :: 		EECON1.EEPGD = 1;
	BSF        EECON1+0, 7
;eeprom_manager.c,36 :: 		EECON1.WREN = 1;
	BSF        EECON1+0, 2
;eeprom_manager.c,37 :: 		INTCON.GIE = 0;
	BCF        INTCON+0, 7
;eeprom_manager.c,38 :: 		EECON2 = 0x55;
	MOVLW      85
	MOVWF      EECON2+0
;eeprom_manager.c,39 :: 		EECON2 = 0xAA;
	MOVLW      170
	MOVWF      EECON2+0
;eeprom_manager.c,40 :: 		EECON1.WR = 1;
	BSF        EECON1+0, 1
;eeprom_manager.c,42 :: 		nop
	NOP
;eeprom_manager.c,43 :: 		nop
	NOP
;eeprom_manager.c,45 :: 		while(EECON1.WR);
L_write_eeprom5:
	BTFSS      EECON1+0, 1
	GOTO       L_write_eeprom6
	GOTO       L_write_eeprom5
L_write_eeprom6:
;eeprom_manager.c,46 :: 		INTCON.GIE = 1;
	BSF        INTCON+0, 7
;eeprom_manager.c,47 :: 		if(addr == 0xFF) addrh+=0x01;
	MOVF       write_eeprom_addr_L0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_write_eeprom7
	INCF       write_eeprom_addrh_L0+0, 1
L_write_eeprom7:
;eeprom_manager.c,48 :: 		addr+=0x01;
	INCF       write_eeprom_addr_L0+0, 1
;eeprom_manager.c,30 :: 		for(i = 0; i<trama[0]/2; i++){
	INCF       write_eeprom_i_L0+0, 1
;eeprom_manager.c,49 :: 		}
	GOTO       L_write_eeprom2
L_write_eeprom3:
;eeprom_manager.c,50 :: 		UART1_Write_Text("OK\n");
	MOVLW      ?lstr1_Ejecutor+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;eeprom_manager.c,51 :: 		}
L_end_write_eeprom:
	RETURN
; end of _write_eeprom

_readData:

;uart_manager.c,2 :: 		unsigned char readData(){
;uart_manager.c,4 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;uart_manager.c,5 :: 		while (1){
L_readData8:
;uart_manager.c,6 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readData10
;uart_manager.c,7 :: 		dato = UART1_Read();
	CALL       _UART1_Read+0
;uart_manager.c,8 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;uart_manager.c,9 :: 		return dato;
	GOTO       L_end_readData
;uart_manager.c,10 :: 		}
L_readData10:
;uart_manager.c,11 :: 		}
	GOTO       L_readData8
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
	GOTO       L_mult11
;uart_manager.c,15 :: 		return dato-55;
	MOVLW      55
	SUBWF      FARG_mult_dato+0, 0
	MOVWF      R0+0
	GOTO       L_end_mult
;uart_manager.c,16 :: 		}else{
L_mult11:
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
L_check_sum13:
	MOVF       R3+0, 0
	SUBWF      check_sum_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_sum14
;uart_manager.c,33 :: 		checksum += trama[j];
	MOVF       check_sum_j_L0+0, 0
	ADDWF      FARG_check_sum_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R2+0, 1
;uart_manager.c,31 :: 		for(j = 0; j<size; j++)
	INCF       check_sum_j_L0+0, 1
;uart_manager.c,34 :: 		}
	GOTO       L_check_sum13
L_check_sum14:
;uart_manager.c,35 :: 		checksum = ~checksum + 1;
	COMF       R2+0, 0
	MOVWF      R0+0
	INCF       R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      R2+0
;uart_manager.c,36 :: 		j = (checksum == trama[size]);
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
;uart_manager.c,37 :: 		checksum = 0;
	CLRF       R2+0
;uart_manager.c,38 :: 		return j;
;uart_manager.c,39 :: 		}
L_end_check_sum:
	RETURN
; end of _check_sum

_main:

;Ejecutor.c,4 :: 		void main() {
;Ejecutor.c,5 :: 		unsigned char * trama[21] = {0};
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
;Ejecutor.c,6 :: 		unsigned char size = 0x00;
	CLRF       main_size_L0+0
	CLRF       main_j_L0+0
;Ejecutor.c,11 :: 		start();
	CALL       _start+0
;Ejecutor.c,12 :: 		while (1) {
L_main16:
;Ejecutor.c,13 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main18
;Ejecutor.c,14 :: 		byteRecv = readData();
	CALL       _readData+0
;Ejecutor.c,15 :: 		if(byteRecv == ':'){
	MOVF       R0+0, 0
	XORLW      58
	BTFSS      STATUS+0, 2
	GOTO       L_main19
;Ejecutor.c,16 :: 		trama[0] = ascii2hex();
	CALL       _ascii2hex+0
	MOVF       R0+0, 0
	MOVWF      main_trama_L0+0
;Ejecutor.c,17 :: 		size = trama[0] + 0x05;
	MOVLW      5
	ADDWF      R0+0, 0
	MOVWF      main_size_L0+0
;Ejecutor.c,18 :: 		for(j = 1; j<size; j++){
	MOVLW      1
	MOVWF      main_j_L0+0
L_main20:
	MOVF       main_size_L0+0, 0
	SUBWF      main_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main21
;Ejecutor.c,19 :: 		trama[j] = ascii2hex();
	MOVF       main_j_L0+0, 0
	ADDLW      main_trama_L0+0
	MOVWF      FLOC__main+0
	CALL       _ascii2hex+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Ejecutor.c,18 :: 		for(j = 1; j<size; j++){
	INCF       main_j_L0+0, 1
;Ejecutor.c,20 :: 		}
	GOTO       L_main20
L_main21:
;Ejecutor.c,21 :: 		check = check_sum(trama);
	MOVLW      main_trama_L0+0
	MOVWF      FARG_check_sum_trama+0
	CALL       _check_sum+0
;Ejecutor.c,22 :: 		check ? write_eeprom(trama) : UART1_Write_Text("BAD\n");
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
;Ejecutor.c,23 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Ejecutor.c,24 :: 		}
L_main19:
;Ejecutor.c,25 :: 		}
L_main18:
;Ejecutor.c,26 :: 		}
	GOTO       L_main16
;Ejecutor.c,27 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_start:

;Ejecutor.c,28 :: 		void start() {
;Ejecutor.c,29 :: 		ANSELH=0X00;
	CLRF       ANSELH+0
;Ejecutor.c,30 :: 		TRISB=0X00;
	CLRF       TRISB+0
;Ejecutor.c,31 :: 		PORTB=0XFF;
	MOVLW      255
	MOVWF      PORTB+0
;Ejecutor.c,32 :: 		UART1_Init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Ejecutor.c,33 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_start25:
	DECFSZ     R13+0, 1
	GOTO       L_start25
	DECFSZ     R12+0, 1
	GOTO       L_start25
	DECFSZ     R11+0, 1
	GOTO       L_start25
	NOP
	NOP
;Ejecutor.c,34 :: 		PORTB=0X00;
	CLRF       PORTB+0
;Ejecutor.c,35 :: 		UART1_Write_Text("MrBurner Ready");
	MOVLW      ?lstr3_Ejecutor+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Ejecutor.c,36 :: 		}
L_end_start:
	RETURN
; end of _start
