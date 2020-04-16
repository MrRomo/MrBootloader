#define dir_offset 0x0250

unsigned char readData() {
   unsigned char dato;
   PORTB = 0x00;
   while (1){
     if(UART1_Data_Ready()){
        dato = UART1_Read();
        PORTB = 0xFF;
        return dato;
     }
   }
}

unsigned char ascii2hex(){
    unsigned char dato = 0, datoh = 0;
    dato = readData();
    datoh = readData();
    dato = (dato>='A') ? (dato-55)<<4 : (dato-48)<<4;
    dato += (datoh>='A') ? datoh-55 : datoh-48;
    PORTB = 0xFF;
    return dato;
}

void write_eeprom(char * trama) {
  unsigned char i = 0, addrh = trama[1], addr = trama[2], size = trama[0]+5,  datal = 0, datah = 0;
  unsigned int dir = (addrh << 8 | addr)/2;
  unsigned int dataf =0;
  if(!((dir>0x1FFF))){
    dir+=dir_offset;
    addrh = dir>>8;
    addr = dir;
    for(i = 0; i<(trama[0]/2); i++){
      datal = trama[i*2+4];
      datah = trama[i*2+5];
      dataf = (datah << 8 | datal);
      if(datah==0x28) dataf+=dir_offset;
      EEADR = addr;
      EEADRH = addrh;
      EEDATA = dataf;
      EEDATH = dataf>>8;
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
      if(addr == 0xFF) addrh+=0x01;
      addr+=0x01;
    }
  }
  UART1_Write_Text("OK\n");
}

void main() {
   unsigned char * trama[25] = {0};
   unsigned char size = 0, j = 0, check = 0;
   TRISB=0X00;
   UART1_Init(9600);
   PORTB=0X00;
   while (1) {
    check = 0;
    if(UART1_Data_Ready()){
     check = readData();
     if(check == ':'){
      trama[0] = ascii2hex();
      check = trama[0];
      size = trama[0] + 0x05;
      for(j = 1; j<size; j++){
        trama[j] = ascii2hex();
        check += trama[j];
      }
      check -= trama[size-1];
      check = ~check + 1;
      (check == (unsigned char)trama[size-1]) ? write_eeprom(trama) : UART1_Write_Text("BAD\n");
      PORTB = 0x00;
      if(!trama[0] && check) {
       PORTB = 0xFF;
       UART1_Write_Text("STR\n");
       asm {
        goto dir_offset;
       }
      }
     }
    }
   }
}