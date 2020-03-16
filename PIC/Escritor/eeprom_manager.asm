
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
