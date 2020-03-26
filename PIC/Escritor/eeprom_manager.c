void read_eeprom( char addrh, char addr) {
   unsigned int response;
   EEADRH = addrh;
   EEADR = addr;
   EEDATH = 0X00; //Limpieza del registro
   EEDAT = 0X00; //Limpieza del registro
   EECON1.EEPGD = 1;
   EECON1.RD = 1; //Inicio de Lectura
   asm{
      nop
      nop
   }
   while(EECON1.RD);
   UART1_Write(EEADRH);
   UART1_Write(EEADR);
   UART1_Write(EEDATH);
   UART1_Write(EEDAT);
}

void write_eeprom(char addrh,char addr, char datoh ,char dato){
   EEADRH = addrh;
   EEADR = addr;
   EEDATH = datoh;
   EEDATA = dato;
   UART1_Write(EEADRH);
   UART1_Write(EEADR);
   UART1_Write(EEDATH);
   UART1_Write(EEDATA);
   EECON1.EEPGD = 1;
   EECON1.WREN = 1;
   INTCON.GIE = 0;
   EECON2 = 0x55;
   EECON2 = 0xAA;
   EECON1.WR = 1;
   asm{
     nop
     nop
   }
   while(EECON1.WR);
   INTCON.GIE = 1;
}