
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

;Grabador.c,7 :: 		void main() {
;Grabador.c,8 :: 		unsigned char trama[21] = {0};
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
	CLRF       main_size_L0+0
	CLRF       main_j_L0+0
;Grabador.c,13 :: 		start();
	CALL       _start+0
;Grabador.c,14 :: 		while (1) {
L_main12:
;Grabador.c,16 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
;Grabador.c,17 :: 		byteRecv = readData();
	CALL       _readData+0
;Grabador.c,18 :: 		if(byteRecv == ':'){
	MOVF       R0+0, 0
	XORLW      58
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;Grabador.c,19 :: 		trama[0] = ascii2hex();
	CALL       _ascii2hex+0
	MOVF       R0+0, 0
	MOVWF      main_trama_L0+0
;Grabador.c,20 :: 		size = trama[0] + 0x05;
	MOVLW      5
	ADDWF      R0+0, 0
	MOVWF      main_size_L0+0
;Grabador.c,21 :: 		for(j = 1; j<size; j++){
	MOVLW      1
	MOVWF      main_j_L0+0
L_main16:
	MOVF       main_size_L0+0, 0
	SUBWF      main_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main17
;Grabador.c,22 :: 		trama[j] = ascii2hex();
	MOVF       main_j_L0+0, 0
	ADDLW      main_trama_L0+0
	MOVWF      FLOC__main+0
	CALL       _ascii2hex+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Grabador.c,21 :: 		for(j = 1; j<size; j++){
	INCF       main_j_L0+0, 1
;Grabador.c,23 :: 		}
	GOTO       L_main16
L_main17:
;Grabador.c,24 :: 		check = check_sum(trama);
	MOVLW      main_trama_L0+0
	MOVWF      FARG_check_sum_trama+0
	CALL       _check_sum+0
;Grabador.c,25 :: 		check ? UART1_Write_Text("OK\n") : UART1_Write_Text("BAD\n");
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	MOVLW      ?lstr1_Grabador+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
	GOTO       L_main20
L_main19:
	MOVLW      ?lstr2_Grabador+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
L_main20:
;Grabador.c,26 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Grabador.c,27 :: 		}
L_main15:
;Grabador.c,28 :: 		}
L_main14:
;Grabador.c,29 :: 		}
	GOTO       L_main12
;Grabador.c,30 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_write_intel:

;Grabador.c,31 :: 		void write_intel(unsigned char * trama){
;Grabador.c,33 :: 		unsigned int addt  = trama[1]<<8;
	INCF       FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      write_intel_addt_L0+1
	CLRF       write_intel_addt_L0+0
;Grabador.c,34 :: 		unsigned char addr = 0x00;
;Grabador.c,35 :: 		unsigned char size = trama[0]+0x04;
	MOVF       FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVLW      4
	ADDWF      INDF+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      write_intel_size_L0+0
;Grabador.c,36 :: 		unsigned char i = 0;
	CLRF       write_intel_i_L0+0
;Grabador.c,38 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_write_intel21:
	DECFSZ     R13+0, 1
	GOTO       L_write_intel21
	DECFSZ     R12+0, 1
	GOTO       L_write_intel21
	NOP
	NOP
;Grabador.c,39 :: 		addt += trama[2];
	MOVLW      2
	ADDWF      FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      write_intel_addt_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       write_intel_addt_L0+1, 1
;Grabador.c,40 :: 		addt += 0x0300;
	MOVLW      0
	ADDWF      write_intel_addt_L0+0, 1
	MOVLW      3
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      write_intel_addt_L0+1, 1
;Grabador.c,41 :: 		for (i=4; i<size; i+2) {
	MOVLW      4
	MOVWF      write_intel_i_L0+0
L_write_intel22:
	MOVF       write_intel_size_L0+0, 0
	SUBWF      write_intel_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_write_intel23
;Grabador.c,43 :: 		write_eeprom(addt>>8, addr, trama[i], trama[i+1]);
	MOVF       write_intel_addt_L0+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_write_eeprom_addrh+0
	MOVF       write_intel_addt_L0+0, 0
	MOVWF      FARG_write_eeprom_addr+0
	MOVF       write_intel_i_L0+0, 0
	ADDWF      FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_write_eeprom_datoh+0
	MOVF       write_intel_i_L0+0, 0
	ADDLW      1
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
;Grabador.c,44 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_write_intel25:
	DECFSZ     R13+0, 1
	GOTO       L_write_intel25
	DECFSZ     R12+0, 1
	GOTO       L_write_intel25
	DECFSZ     R11+0, 1
	GOTO       L_write_intel25
	NOP
	NOP
;Grabador.c,45 :: 		addt++;
	INCF       write_intel_addt_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       write_intel_addt_L0+1, 1
;Grabador.c,46 :: 		}
	GOTO       L_write_intel22
L_write_intel23:
;Grabador.c,47 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Grabador.c,48 :: 		}
L_end_write_intel:
	RETURN
; end of _write_intel

_start:

;Grabador.c,50 :: 		void start() {
;Grabador.c,51 :: 		ANSELH=0X00;
	CLRF       ANSELH+0
;Grabador.c,52 :: 		TRISB=0X00;
	CLRF       TRISB+0
;Grabador.c,53 :: 		PORTB=0XFF;
	MOVLW      255
	MOVWF      PORTB+0
;Grabador.c,54 :: 		UART1_Init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Grabador.c,55 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_start26:
	DECFSZ     R13+0, 1
	GOTO       L_start26
	DECFSZ     R12+0, 1
	GOTO       L_start26
	DECFSZ     R11+0, 1
	GOTO       L_start26
	NOP
	NOP
;Grabador.c,56 :: 		PORTB=0X00;
	CLRF       PORTB+0
;Grabador.c,57 :: 		UART1_Write_Text("MrBurner Ready");
	MOVLW      ?lstr3_Grabador+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Grabador.c,58 :: 		}
L_end_start:
	RETURN
; end of _start
