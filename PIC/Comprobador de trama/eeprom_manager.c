
typedef struct trama{
  unsigned char size;
  unsigned char addr;
  unsigned char addrh;
  unsigned char type;
  unsigned char * info;
  unsigned char checksum;
}trama_t;

unsigned int read_eeprom( char addrh, char addr) {
   unsigned int response;
   EEADR = addr;
   EEADRH = addrh;
   EEDAT = 0X00; //Limpieza del registro
   EEDATH = 0X00; //Limpieza del registro
   EECON1.EEPGD = 1;
   EECON1.RD = 1; //Inicio de Lectura
   asm{
      nop
      nop
   }
   while(EECON1.RD);
   UART1_Write(EEDAT);
   UART1_Write(EEDATH);
   response = EEDATH;
   response = response<<8;
   response |= EEDAT;
   return(response);
}

void write_eeprom(char addrh, char addr, char datoh,char dato){
   unsigned char i = 0;
   EEADR = addr;//+i;
   EEADRH = addrh;
   EEDATA = dato;
   EEDATH = datoh;
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