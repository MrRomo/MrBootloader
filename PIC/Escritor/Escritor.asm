
_read_eeprom:

;eeprom_manager.c,1 :: 		void read_eeprom( char addrh, char addr) {
;eeprom_manager.c,3 :: 		EEADRH = addrh;
	MOVF       FARG_read_eeprom_addrh+0, 0
	MOVWF      EEADRH+0
;eeprom_manager.c,4 :: 		EEADR = addr;
	MOVF       FARG_read_eeprom_addr+0, 0
	MOVWF      EEADR+0
;eeprom_manager.c,5 :: 		EEDATH = 0X00; //Limpieza del registro
	CLRF       EEDATH+0
;eeprom_manager.c,6 :: 		EEDAT = 0X00; //Limpieza del registro
	CLRF       EEDAT+0
;eeprom_manager.c,7 :: 		EECON1.EEPGD = 1;
	BSF        EECON1+0, 7
;eeprom_manager.c,10 :: 		EECON1.RD = 1; //Inicio de Lectura
	BSF        EECON1+0, 0
;eeprom_manager.c,12 :: 		nop
	NOP
;eeprom_manager.c,13 :: 		nop
	NOP
;eeprom_manager.c,15 :: 		while(EECON1.RD);
L_read_eeprom0:
	BTFSS      EECON1+0, 0
	GOTO       L_read_eeprom1
	GOTO       L_read_eeprom0
L_read_eeprom1:
;eeprom_manager.c,14 :: 		UART1_Write(EEADRH);
	MOVF       EEADRH+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;eeprom_manager.c,15 :: 		UART1_Write(EEADR);
	MOVF       EEADR+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;eeprom_manager.c,16 :: 		UART1_Write(EEDATH);
	MOVF       EEDATH+0, 0
	MOVWF      read_eeprom_dataWrited_L0+0
;eeprom_manager.c,17 :: 		dataWrited[1]=EEDAT;
	MOVF       EEDAT+0, 0
	MOVWF      read_eeprom_dataWrited_L0+1
;eeprom_manager.c,18 :: 		UART1_Write_Text(dataWrited);
	MOVLW      read_eeprom_dataWrited_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;eeprom_manager.c,19 :: 		}
L_end_read_eeprom:
	RETURN
; end of _read_eeprom

_write_eeprom:

;eeprom_manager.c,20 :: 		void write_eeprom(char addrh,char addr, char datoh ,char dato){
;eeprom_manager.c,21 :: 		EEADRH = addrh;
	MOVF       FARG_write_eeprom_addrh+0, 0
	MOVWF      EEADRH+0
;eeprom_manager.c,22 :: 		EEADR = addr;
	MOVF       FARG_write_eeprom_addr+0, 0
	MOVWF      EEADR+0
;eeprom_manager.c,23 :: 		EEDATH = datoh;
	MOVF       FARG_write_eeprom_datoh+0, 0
	MOVWF      EEDATH+0
;eeprom_manager.c,24 :: 		EEDATA = dato;
	MOVF       FARG_write_eeprom_dato+0, 0
	MOVWF      EEDATA+0
;eeprom_manager.c,25 :: 		UART1_Write(EEADRH);
	MOVF       EEADRH+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;eeprom_manager.c,26 :: 		UART1_Write(EEADR);
	MOVF       EEADR+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;eeprom_manager.c,27 :: 		UART1_Write(EEDATH);
	MOVF       EEDATH+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;eeprom_manager.c,28 :: 		UART1_Write(EEDATA);
	MOVF       EEDATA+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;eeprom_manager.c,29 :: 		EECON1.EEPGD = 1;
	BSF        EECON1+0, 7
;eeprom_manager.c,30 :: 		EECON1.WREN = 1;
	BSF        EECON1+0, 2
;eeprom_manager.c,31 :: 		INTCON.GIE = 0;
	BCF        INTCON+0, 7
;eeprom_manager.c,32 :: 		EECON2 = 0x55;
	MOVLW      85
	MOVWF      EECON2+0
;eeprom_manager.c,33 :: 		EECON2 = 0xAA;
	MOVLW      170
	MOVWF      EECON2+0
;eeprom_manager.c,34 :: 		EECON1.WR = 1;
	BSF        EECON1+0, 1
;eeprom_manager.c,36 :: 		nop
	NOP
;eeprom_manager.c,37 :: 		nop
	NOP
;eeprom_manager.c,39 :: 		while(EECON1.WR);
L_write_eeprom2:
	BTFSS      EECON1+0, 1
	GOTO       L_write_eeprom3
	GOTO       L_write_eeprom2
L_write_eeprom3:
;eeprom_manager.c,40 :: 		INTCON.GIE = 1;
	BSF        INTCON+0, 7
;eeprom_manager.c,41 :: 		}
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
;uart_manager.c,24 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;uart_manager.c,25 :: 		return dato;
;uart_manager.c,26 :: 		}
L_end_ascii2hex:
	RETURN
; end of _ascii2hex

_check_sum:

;uart_manager.c,27 :: 		unsigned char check_sum(unsigned char * trama) {
;uart_manager.c,28 :: 		unsigned char checksum, j = 0x00;
	CLRF       check_sum_j_L0+0
;uart_manager.c,29 :: 		unsigned char size = trama[0]+0x04;
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
;uart_manager.c,30 :: 		for(j = 0; j<size; j++)
	CLRF       check_sum_j_L0+0
L_check_sum9:
	MOVF       R3+0, 0
	SUBWF      check_sum_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_sum10
;uart_manager.c,32 :: 		checksum += trama[j];
	MOVF       check_sum_j_L0+0, 0
	ADDWF      FARG_check_sum_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R2+0, 1
;uart_manager.c,30 :: 		for(j = 0; j<size; j++)
	INCF       check_sum_j_L0+0, 1
;uart_manager.c,33 :: 		}
	GOTO       L_check_sum9
L_check_sum10:
;uart_manager.c,34 :: 		checksum = ~checksum + 1;
	COMF       R2+0, 0
	MOVWF      R0+0
	INCF       R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      R2+0
;uart_manager.c,35 :: 		j = (checksum == trama[size]);
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
;uart_manager.c,36 :: 		checksum = 0;
	CLRF       R2+0
;uart_manager.c,37 :: 		return j;
;uart_manager.c,38 :: 		}
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
;Escritor.c,15 :: 		start();
	CALL       _start+0
;Escritor.c,16 :: 		while (1) {
L_main12:
;Escritor.c,17 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
;Escritor.c,18 :: 		byteRecv = readData();
	CALL       _readData+0
;Escritor.c,19 :: 		if(byteRecv == ':'){
	MOVF       R0+0, 0
	XORLW      58
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;Escritor.c,20 :: 		trama[0] = ascii2hex();
	CALL       _ascii2hex+0
	MOVF       R0+0, 0
	MOVWF      main_trama_L0+0
;Escritor.c,21 :: 		size = trama[0] + 0x05;
	MOVLW      5
	ADDWF      R0+0, 0
	MOVWF      main_size_L0+0
;Escritor.c,22 :: 		for(j = 1; j<size; j++){
	MOVLW      1
	MOVWF      main_j_L0+0
L_main16:
	MOVF       main_size_L0+0, 0
	SUBWF      main_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main17
;Escritor.c,23 :: 		trama[j] = ascii2hex();
	MOVF       main_j_L0+0, 0
	ADDLW      main_trama_L0+0
	MOVWF      FLOC__main+0
	CALL       _ascii2hex+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Escritor.c,22 :: 		for(j = 1; j<size; j++){
	INCF       main_j_L0+0, 1
;Escritor.c,24 :: 		}
	GOTO       L_main16
L_main17:
;Escritor.c,25 :: 		check = check_sum(trama); //comprobar checksum
	MOVLW      main_trama_L0+0
	MOVWF      FARG_check_sum_trama+0
	CALL       _check_sum+0
;Escritor.c,26 :: 		check ? write_intel(trama) : UART1_Write_Text("BAD\n"); //Escritura
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
;Escritor.c,27 :: 		j = 0;
	CLRF       main_j_L0+0
;Escritor.c,28 :: 		for(j = 0; j<21; j++){
	CLRF       main_j_L0+0
L_main21:
	MOVLW      21
	SUBWF      main_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main22
;Escritor.c,29 :: 		trama[j] = 0x00;
	MOVF       main_j_L0+0, 0
	ADDLW      main_trama_L0+0
	MOVWF      FSR
	CLRF       INDF+0
;Escritor.c,28 :: 		for(j = 0; j<21; j++){
	INCF       main_j_L0+0, 1
;Escritor.c,30 :: 		}
	GOTO       L_main21
L_main22:
;Escritor.c,31 :: 		j = 0;
	CLRF       main_j_L0+0
;Escritor.c,32 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Escritor.c,33 :: 		}
L_main15:
;Escritor.c,34 :: 		}
L_main14:
;Escritor.c,35 :: 		}
	GOTO       L_main12
;Escritor.c,36 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_write_intel:

;Escritor.c,37 :: 		void write_intel(unsigned char * trama){
;Escritor.c,38 :: 		unsigned char i = 0x00;
	CLRF       write_intel_i_L0+0
;Escritor.c,39 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Escritor.c,40 :: 		UART1_Write_Text("OK\n");
	MOVLW      ?lstr2_Escritor+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Escritor.c,41 :: 		for(i = 0; i<trama[0]; i+=2){
	CLRF       write_intel_i_L0+0
L_write_intel24:
	MOVF       FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      write_intel_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_write_intel25
;Escritor.c,42 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_intel27:
	DECFSZ     R13+0, 1
	GOTO       L_write_intel27
;Escritor.c,43 :: 		write_eeprom(trama[1], trama[2], trama[i+0x05], trama[i+0x04]);
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
;Escritor.c,44 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_intel28:
	DECFSZ     R13+0, 1
	GOTO       L_write_intel28
;Escritor.c,45 :: 		read_eeprom(trama[1], trama[2]);
	INCF       FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_read_eeprom_addrh+0
	MOVLW      2
	ADDWF      FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_read_eeprom_addr+0
	CALL       _read_eeprom+0
;Escritor.c,46 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_intel29:
	DECFSZ     R13+0, 1
	GOTO       L_write_intel29
;Escritor.c,47 :: 		if(trama[2] == 0xFF) trama[1]+=0x01;
	MOVLW      2
	ADDWF      FARG_write_intel_trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_write_intel30
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
L_write_intel30:
;Escritor.c,48 :: 		trama[2]+=0x01;
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
;Escritor.c,41 :: 		for(i = 0; i<trama[0]; i+=2){
	MOVLW      2
	ADDWF      write_intel_i_L0+0, 1
;Escritor.c,49 :: 		}
	GOTO       L_write_intel24
L_write_intel25:
;Escritor.c,50 :: 		i = 0;
	CLRF       write_intel_i_L0+0
;Escritor.c,51 :: 		}
L_end_write_intel:
	RETURN
; end of _write_intel

_start:

;Escritor.c,53 :: 		void start() {
;Escritor.c,54 :: 		ANSELH=0X00;
	CLRF       ANSELH+0
;Escritor.c,55 :: 		TRISB=0X00;
	CLRF       TRISB+0
;Escritor.c,56 :: 		PORTB=0XFF;
	MOVLW      255
	MOVWF      PORTB+0
;Escritor.c,57 :: 		UART1_Init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Escritor.c,58 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_start31:
	DECFSZ     R13+0, 1
	GOTO       L_start31
	DECFSZ     R12+0, 1
	GOTO       L_start31
	DECFSZ     R11+0, 1
	GOTO       L_start31
	NOP
	NOP
;Escritor.c,59 :: 		PORTB=0X00;
	CLRF       PORTB+0
;Escritor.c,60 :: 		UART1_Write_Text("MrBurner Ready");
	MOVLW      ?lstr3_Escritor+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Escritor.c,61 :: 		}
L_end_start:
	RETURN
; end of _start
