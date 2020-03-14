
_read_eeprom:

;eeprom_manager.c,11 :: 		unsigned int read_eeprom( char addrh, char addr) {
;eeprom_manager.c,13 :: 		EEADR = addr;
	MOVF       FARG_read_eeprom_addr+0, 0
	MOVWF      EEADR+0
;eeprom_manager.c,14 :: 		EEADRH = addrh;
	MOVF       FARG_read_eeprom_addrh+0, 0
	MOVWF      EEADRH+0
;eeprom_manager.c,15 :: 		EEDAT = 0X00; //Limpieza del registro
	CLRF       EEDAT+0
;eeprom_manager.c,16 :: 		EEDATH = 0X00; //Limpieza del registro
	CLRF       EEDATH+0
;eeprom_manager.c,17 :: 		EECON1.EEPGD = 1;
	BSF        EECON1+0, 7
;eeprom_manager.c,18 :: 		EECON1.RD = 1; //Inicio de Lectura
	BSF        EECON1+0, 0
;eeprom_manager.c,20 :: 		nop
	NOP
;eeprom_manager.c,21 :: 		nop
	NOP
;eeprom_manager.c,23 :: 		while(EECON1.RD);
L_read_eeprom0:
	BTFSS      EECON1+0, 0
	GOTO       L_read_eeprom1
	GOTO       L_read_eeprom0
L_read_eeprom1:
;eeprom_manager.c,24 :: 		UART1_Write(EEDAT);
	MOVF       EEDAT+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;eeprom_manager.c,25 :: 		UART1_Write(EEDATH);
	MOVF       EEDATH+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;eeprom_manager.c,26 :: 		response = EEDATH;
	MOVF       EEDATH+0, 0
	MOVWF      read_eeprom_response_L0+0
	CLRF       read_eeprom_response_L0+1
;eeprom_manager.c,27 :: 		response = response<<8;
	MOVF       read_eeprom_response_L0+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       R0+0, 0
	MOVWF      read_eeprom_response_L0+0
	MOVF       R0+1, 0
	MOVWF      read_eeprom_response_L0+1
;eeprom_manager.c,28 :: 		response |= EEDAT;
	MOVF       EEDAT+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      read_eeprom_response_L0+0
	MOVF       R0+1, 0
	MOVWF      read_eeprom_response_L0+1
;eeprom_manager.c,29 :: 		return(response);
;eeprom_manager.c,30 :: 		}
L_end_read_eeprom:
	RETURN
; end of _read_eeprom

_write_eeprom:

;eeprom_manager.c,32 :: 		void write_eeprom(char addrh, char addr, char datoh,char dato){
;eeprom_manager.c,33 :: 		unsigned char i = 0;
;eeprom_manager.c,34 :: 		EEADR = addr;//+i;
	MOVF       FARG_write_eeprom_addr+0, 0
	MOVWF      EEADR+0
;eeprom_manager.c,35 :: 		EEADRH = addrh;
	MOVF       FARG_write_eeprom_addrh+0, 0
	MOVWF      EEADRH+0
;eeprom_manager.c,36 :: 		EEDATA = dato;
	MOVF       FARG_write_eeprom_dato+0, 0
	MOVWF      EEDATA+0
;eeprom_manager.c,37 :: 		EEDATH = datoh;
	MOVF       FARG_write_eeprom_datoh+0, 0
	MOVWF      EEDATH+0
;eeprom_manager.c,38 :: 		EECON1.EEPGD = 1;
	BSF        EECON1+0, 7
;eeprom_manager.c,39 :: 		EECON1.WREN = 1;
	BSF        EECON1+0, 2
;eeprom_manager.c,40 :: 		INTCON.GIE = 0;
	BCF        INTCON+0, 7
;eeprom_manager.c,41 :: 		EECON2 = 0x55;
	MOVLW      85
	MOVWF      EECON2+0
;eeprom_manager.c,42 :: 		EECON2 = 0xAA;
	MOVLW      170
	MOVWF      EECON2+0
;eeprom_manager.c,43 :: 		EECON1.WR = 1;
	BSF        EECON1+0, 1
;eeprom_manager.c,45 :: 		nop
	NOP
;eeprom_manager.c,46 :: 		nop
	NOP
;eeprom_manager.c,48 :: 		while(EECON1.WR);
L_write_eeprom2:
	BTFSS      EECON1+0, 1
	GOTO       L_write_eeprom3
	GOTO       L_write_eeprom2
L_write_eeprom3:
;eeprom_manager.c,49 :: 		INTCON.GIE = 1;
	BSF        INTCON+0, 7
;eeprom_manager.c,50 :: 		}
L_end_write_eeprom:
	RETURN
; end of _write_eeprom

_main:

;Trama.c,7 :: 		void main() {
;Trama.c,9 :: 		unsigned char byteRecv = 0x00;
;Trama.c,11 :: 		start();
	CALL       _start+0
;Trama.c,12 :: 		for (j = 0; j < 3; j++)
	CLRF       main_j_L0+0
L_main4:
	MOVLW      3
	SUBWF      main_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main5
;Trama.c,14 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
	NOP
;Trama.c,15 :: 		UART1_Write_Text("Inicio");
	MOVLW      ?lstr1_Trama+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Trama.c,12 :: 		for (j = 0; j < 3; j++)
	INCF       main_j_L0+0, 1
;Trama.c,16 :: 		}
	GOTO       L_main4
L_main5:
;Trama.c,17 :: 		while (1) {
L_main8:
;Trama.c,18 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
;Trama.c,19 :: 		byteRecv = readData();
	CALL       _readData+0
;Trama.c,20 :: 		if(byteRecv == ':'){
	MOVF       R0+0, 0
	XORLW      58
	BTFSS      STATUS+0, 2
	GOTO       L_main11
;Trama.c,21 :: 		Trama->size = ascii2hex();
	MOVF       main_Trama_L0+0, 0
	MOVWF      FLOC__main+0
	CALL       _ascii2hex+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Trama.c,22 :: 		Trama->addr = ascii2hex();
	INCF       main_Trama_L0+0, 0
	MOVWF      FLOC__main+0
	CALL       _ascii2hex+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Trama.c,23 :: 		Trama->addrh = ascii2hex();
	MOVLW      2
	ADDWF      main_Trama_L0+0, 0
	MOVWF      FLOC__main+0
	CALL       _ascii2hex+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Trama.c,24 :: 		Trama->type = ascii2hex();
	MOVLW      3
	ADDWF      main_Trama_L0+0, 0
	MOVWF      FLOC__main+0
	CALL       _ascii2hex+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Trama.c,25 :: 		for (j = 0; j < Trama->size; j++)
	CLRF       main_j_L0+0
L_main12:
	MOVF       main_Trama_L0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBWF      main_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main13
;Trama.c,27 :: 		Trama->info[j] = ascii2hex();
	MOVLW      4
	ADDWF      main_Trama_L0+0, 0
	MOVWF      R0+0
	MOVF       main_j_L0+0, 0
	ADDWF      R0+0, 0
	MOVWF      FLOC__main+0
	CALL       _ascii2hex+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Trama.c,25 :: 		for (j = 0; j < Trama->size; j++)
	INCF       main_j_L0+0, 1
;Trama.c,28 :: 		}
	GOTO       L_main12
L_main13:
;Trama.c,29 :: 		Trama->checksum = ascii2hex();
	MOVLW      68
	ADDWF      main_Trama_L0+0, 0
	MOVWF      FLOC__main+0
	CALL       _ascii2hex+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Trama.c,30 :: 		check_sum(Trama);
	MOVF       main_Trama_L0+0, 0
	MOVWF      FARG_check_sum_Trama+0
	CALL       _check_sum+0
;Trama.c,38 :: 		}
L_main11:
;Trama.c,40 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Trama.c,41 :: 		}
L_main10:
;Trama.c,42 :: 		}
	GOTO       L_main8
;Trama.c,43 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_start:

;Trama.c,44 :: 		void start() {
;Trama.c,45 :: 		PORTB=0X00;
	CLRF       PORTB+0
;Trama.c,46 :: 		ANSELH=0X00;
	CLRF       ANSELH+0
;Trama.c,47 :: 		TRISB=0X00;
	CLRF       TRISB+0
;Trama.c,48 :: 		UART1_Init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Trama.c,49 :: 		Delay_ms(1);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      75
	MOVWF      R13+0
L_start15:
	DECFSZ     R13+0, 1
	GOTO       L_start15
	DECFSZ     R12+0, 1
	GOTO       L_start15
;Trama.c,50 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Trama.c,51 :: 		PORTB=0X00;
	CLRF       PORTB+0
;Trama.c,52 :: 		}
L_end_start:
	RETURN
; end of _start

_ascii2hex:

;Trama.c,54 :: 		unsigned char ascii2hex(){
;Trama.c,55 :: 		unsigned char dato = 0x00;
	CLRF       ascii2hex_dato_L0+0
;Trama.c,56 :: 		dato = mult(readData())*16;
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
;Trama.c,57 :: 		dato += mult(readData());
	CALL       _readData+0
	MOVF       R0+0, 0
	MOVWF      FARG_mult_dato+0
	CALL       _mult+0
	MOVF       ascii2hex_dato_L0+0, 0
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      ascii2hex_dato_L0+0
;Trama.c,58 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Trama.c,59 :: 		return dato;
;Trama.c,60 :: 		}
L_end_ascii2hex:
	RETURN
; end of _ascii2hex

_mult:

;Trama.c,62 :: 		unsigned char mult(unsigned char dato){
;Trama.c,63 :: 		if (dato>='A'){
	MOVLW      65
	SUBWF      FARG_mult_dato+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_mult16
;Trama.c,64 :: 		dato = (dato-55);
	MOVLW      55
	SUBWF      FARG_mult_dato+0, 1
;Trama.c,65 :: 		}else{
	GOTO       L_mult17
L_mult16:
;Trama.c,66 :: 		dato = (dato-48);
	MOVLW      48
	SUBWF      FARG_mult_dato+0, 1
;Trama.c,67 :: 		}
L_mult17:
;Trama.c,68 :: 		return dato;
	MOVF       FARG_mult_dato+0, 0
	MOVWF      R0+0
;Trama.c,69 :: 		}
L_end_mult:
	RETURN
; end of _mult

_readData:

;Trama.c,70 :: 		unsigned char readData(){
;Trama.c,72 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Trama.c,73 :: 		while (1){
L_readData18:
;Trama.c,74 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readData20
;Trama.c,75 :: 		dato = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      readData_dato_L0+0
;Trama.c,76 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Trama.c,77 :: 		UART1_Write(dato);
	MOVF       R0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Trama.c,78 :: 		return dato;
	MOVF       readData_dato_L0+0, 0
	MOVWF      R0+0
	GOTO       L_end_readData
;Trama.c,79 :: 		}
L_readData20:
;Trama.c,80 :: 		}
	GOTO       L_readData18
;Trama.c,81 :: 		}
L_end_readData:
	RETURN
; end of _readData

_check_sum:

;Trama.c,83 :: 		unsigned char check_sum(trama_t * Trama){
;Trama.c,84 :: 		unsigned char checksum = 0x00;
	CLRF       check_sum_checksum_L0+0
	CLRF       check_sum_i_L0+0
;Trama.c,86 :: 		checksum = Trama->size + Trama->addr+Trama->addrh+Trama->type;
	MOVF       FARG_check_sum_Trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FARG_check_sum_Trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R0+0, 0
	MOVWF      check_sum_checksum_L0+0
	MOVLW      2
	ADDWF      FARG_check_sum_Trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      check_sum_checksum_L0+0, 1
	MOVLW      3
	ADDWF      FARG_check_sum_Trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      check_sum_checksum_L0+0, 1
;Trama.c,87 :: 		for (i=0; i<Trama->size; i++){
	CLRF       check_sum_i_L0+0
L_check_sum21:
	MOVF       FARG_check_sum_Trama+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBWF      check_sum_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_sum22
;Trama.c,88 :: 		checksum += Trama->info[i];
	MOVLW      4
	ADDWF      FARG_check_sum_Trama+0, 0
	MOVWF      R0+0
	MOVF       check_sum_i_L0+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      check_sum_checksum_L0+0, 1
;Trama.c,87 :: 		for (i=0; i<Trama->size; i++){
	INCF       check_sum_i_L0+0, 1
;Trama.c,89 :: 		}
	GOTO       L_check_sum21
L_check_sum22:
;Trama.c,90 :: 		checksum = ~checksum + 1;
	COMF       check_sum_checksum_L0+0, 0
	MOVWF      R0+0
	INCF       R0+0, 1
	MOVF       R0+0, 0
	MOVWF      check_sum_checksum_L0+0
;Trama.c,91 :: 		UART1_Write(checksum);
	MOVF       R0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Trama.c,92 :: 		}
L_end_check_sum:
	RETURN
; end of _check_sum
