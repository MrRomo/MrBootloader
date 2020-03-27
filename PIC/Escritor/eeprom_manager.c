void read_eeprom( unsigned char addrh, unsigned char addr) {
   unsigned char dataWrited[2] = {0};
   EEADRH = addrh;
   EEADR = addr;
   EEDATH = 0X00; //Limpieza del registro
   EEDAT = 0X00; //Limpieza del registro
   UART1_Write(EEADRH);
   UART1_Write(EEADR);
   EECON1.EEPGD = 1;
   EECON1.RD = 1; //Inicio de Lectura
   asm{
      nop
      nop
   }
   while(EECON1.RD);
   dataWrited[0]=EEDATH;
   dataWrited[1]=EEDAT;
   UART1_Write(dataWrited[0]);
   UART1_Write(dataWrited[1]);
}

void write_eeprom(unsigned char addrh,unsigned char addr, unsigned char datoh ,unsigned char dato){
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